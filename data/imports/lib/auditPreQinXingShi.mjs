#!/usr/bin/env node
/**
 * Audit pre-imperial reigns for missing 姓/氏 in detail panels.
 * Reads ancestral_xing / clan_shi from import SQL (DB fields), not runtime name parsing.
 * Run: node data/imports/lib/auditPreQinXingShi.mjs
 */
import { readdirSync, readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { rulersByDynasty } from "../chunqiu-zhanguo/rulers.mjs";
import { FEUDAL_DYNASTY_CLAN } from "./feudalClanMetadata.mjs";

const PRE_IMPERIAL_START_YEAR = -221;

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const importsRoot = path.resolve(__dirname, "..");

function resolvePreQinXingShi(clan) {
  const xing = clan?.personAncestralXing ?? clan?.dynastyAncestralXing ?? undefined;
  const shi = clan?.personClanShi ?? clan?.dynastyClanShi ?? undefined;
  if (!xing && !shi) return {};
  return { ...(xing ? { xing } : {}), ...(shi ? { shi } : {}) };
}

function parsePersonsFromSql(content) {
  const persons = new Map();
  const blocks = content.split(/(?=INSERT INTO persons)/i);
  for (const block of blocks) {
    if (!/^INSERT INTO persons/i.test(block)) continue;
    if (!block.includes("ancestral_xing")) continue;
    const m = block.match(
      /VALUES\s*\(\s*'([^']+)',\s*'([^']*)',\s*(?:'([^']*)'|NULL),\s*(?:'([^']*)'|NULL)/s,
    );
    if (m) {
      persons.set(m[1], {
        name: m[2],
        ancestralXing: m[3] || null,
        clanShi: m[4] || null,
      });
    }
  }
  const legacyRe =
    /INSERT INTO persons \(id, name[^)]*\)\s*\nVALUES \('([^']+)', '([^']+)'(?:, (-?\d+), (-?\d+))?(?:, (-?\d+), (-?\d+))?/g;
  for (const m of content.matchAll(legacyRe)) {
    if (!persons.has(m[1])) {
      persons.set(m[1], { name: m[2], ancestralXing: null, clanShi: null });
    }
  }
  return persons;
}

function parseDynastiesFromSql(content) {
  const dynasties = new Map();
  const blocks = content.split(/(?=INSERT INTO dynasties)/i);
  for (const block of blocks) {
    if (!/^INSERT INTO dynasties/i.test(block)) continue;
    if (!block.includes("ancestral_xing")) continue;
    const m = block.match(
      /VALUES\s*\(\s*'([^']+)',\s*'([^']*)',\s*(?:'([^']*)'|NULL),\s*(?:'([^']*)'|NULL)/s,
    );
    if (m) {
      dynasties.set(m[1], {
        ancestralXing: m[3] || null,
        clanShi: m[4] || null,
      });
    }
  }
  return dynasties;
}

function parseReignsFromSql(content) {
  const reigns = [];
  const re =
    /INSERT INTO reigns \(id, dynasty_id, person_id, title[^)]*\)\s*\nVALUES \('([^']+)', '([^']+)', '([^']+)', '([^']+)'[^,]*,\s*(-?\d+),/g;
  for (const m of content.matchAll(re)) {
    reigns.push({
      id: m[1],
      dynastyId: m[2],
      personId: m[3],
      title: m[4],
      startYear: Number(m[5]),
    });
  }
  return reigns;
}

function loadSqlCorpus() {
  const persons = new Map();
  const dynasties = new Map();
  const reigns = [];
  for (const slug of readdirSync(importsRoot)) {
    const sqlPath = path.join(importsRoot, slug, "import.sql");
    try {
      const content = readFileSync(sqlPath, "utf8");
      for (const [id, row] of parsePersonsFromSql(content)) {
        if (!persons.has(id)) persons.set(id, row);
      }
      for (const [id, row] of parseDynastiesFromSql(content)) {
        dynasties.set(id, row);
      }
      reigns.push(...parseReignsFromSql(content));
    } catch {
      // skip
    }
  }
  return { persons, dynasties, reigns };
}

function buildClanContext(personId, dynastyId, persons, dynasties) {
  const person = persons.get(personId);
  const dynasty = dynasties.get(dynastyId);
  return {
    personAncestralXing: person?.ancestralXing,
    personClanShi: person?.clanShi,
    dynastyAncestralXing: dynasty?.ancestralXing,
    dynastyClanShi: dynasty?.clanShi,
  };
}

function auditRow(clan) {
  const { xing, shi } = resolvePreQinXingShi(clan);
  const missing = [];
  if (!xing && !shi) missing.push("姓/氏");
  else {
    if (!xing && clan.dynastyAncestralXing) missing.push("姓");
    if (!shi && clan.dynastyClanShi) missing.push("氏");
  }
  return missing;
}

function main() {
  const { persons, dynasties, reigns } = loadSqlCorpus();
  const missing = [];
  const dynastyGaps = [];
  const seenReign = new Set();

  for (const [dynastyId, meta] of Object.entries(FEUDAL_DYNASTY_CLAN)) {
    const row = dynasties.get(dynastyId);
    if (!row) continue;
    if (meta.ancestralXing && !row.ancestralXing) {
      dynastyGaps.push(`${dynastyId}: missing dynasty ancestral_xing (expected ${meta.ancestralXing})`);
    }
    if (meta.clanShi && !row.clanShi) {
      dynastyGaps.push(`${dynastyId}: missing dynasty clan_shi (expected ${meta.clanShi})`);
    }
  }

  for (const [dynastyId, rulers] of Object.entries(rulersByDynasty)) {
    for (const ruler of rulers) {
      if (ruler.startYear >= PRE_IMPERIAL_START_YEAR) continue;
      const key = `${ruler.personId}:${dynastyId}`;
      if (seenReign.has(key)) continue;
      seenReign.add(key);
      const name = ruler.personName ?? persons.get(ruler.personId)?.name;
      const clan = buildClanContext(ruler.personId, dynastyId, persons, dynasties);
      const gaps = auditRow(clan);
      if (gaps.length) {
        missing.push({ dynastyId, title: ruler.title, personId: ruler.personId, personName: name, gaps });
      }
    }
  }

  for (const reign of reigns) {
    if (reign.startYear >= PRE_IMPERIAL_START_YEAR) continue;
    const key = `${reign.personId}:${reign.dynastyId}`;
    if (seenReign.has(key)) continue;
    seenReign.add(key);
    const person = persons.get(reign.personId);
      const name = person?.name;
      const clan = buildClanContext(reign.personId, reign.dynastyId, persons, dynasties);
      const gaps = auditRow(clan);
      if (gaps.length) {
        missing.push({
          dynastyId: reign.dynastyId,
          title: reign.title,
          personId: reign.personId,
          personName: name,
          gaps,
        });
      }
  }

  console.log("=== Dynasty 姓/氏 column gaps ===");
  for (const row of dynastyGaps) console.log(row);
  console.log(`Dynasty gaps: ${dynastyGaps.length}`);
  console.log("");
  console.log("=== Missing 姓 and/or 氏 on pre-Qin reigns ===");
  for (const row of missing) {
    console.log(
      `${row.dynastyId}\t${row.title}\t${row.personId}\t${row.personName ?? "(no name)"}\tmissing: ${row.gaps.join(", ")}`,
    );
  }
  console.log(`Total: ${missing.length}`);
}

main();
