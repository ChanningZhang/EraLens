#!/usr/bin/env node
/**
 * Audit pre-imperial reigns for missing 姓/氏 in detail panels.
 * Reads persons.ancestral_xing / clan_shi from import SQL (DB fields), not runtime name parsing.
 * Run: node data/imports/lib/auditPreQinXingShi.mjs
 */
import { readdirSync, readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { buildPreQinClanContext, resolvePreQinXingShi } from "./preQinClanContext.mjs";
import { rulersByDynasty } from "../chunqiu-zhanguo/rulers.mjs";

const PRE_IMPERIAL_START_YEAR = -221;

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const importsRoot = path.resolve(__dirname, "..");

function parsePersonsFromSql(content) {
  const persons = new Map();
  const blocks = content.split(/(?=INSERT INTO persons)/i);
  for (const block of blocks) {
    if (!/^INSERT INTO persons/i.test(block)) continue;
    if (!block.includes("ancestral_xing")) continue;
    const m = block.match(
      /VALUES\s*\(\s*'([^']+)',\s*'([^']*)',\s*(?:ARRAY\[[^\]]*\]|[^,]+),\s*(?:'([^']*)'|NULL),\s*(?:'([^']*)'|NULL)/s,
    );
    if (m) {
      persons.set(m[1], {
        name: m[2],
        ancestralXing: m[3] || null,
        clanShi: m[4] || null,
      });
      continue;
    }
    const legacy = block.match(
      /VALUES\s*\(\s*'([^']+)',\s*'([^']*)',\s*(?:'([^']*)'|NULL),\s*(?:'([^']*)'|NULL)/s,
    );
    if (legacy) {
      persons.set(legacy[1], {
        name: legacy[2],
        ancestralXing: legacy[3] || null,
        clanShi: legacy[4] || null,
      });
    }
  }
  return persons;
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
  const reigns = [];
  for (const slug of readdirSync(importsRoot)) {
    const sqlPath = path.join(importsRoot, slug, "import.sql");
    try {
      const content = readFileSync(sqlPath, "utf8");
      for (const [id, row] of parsePersonsFromSql(content)) {
        if (!persons.has(id)) persons.set(id, row);
      }
      reigns.push(...parseReignsFromSql(content));
    } catch {
      // skip
    }
  }
  return { persons, reigns };
}

function auditRow(clan) {
  const { xing, shi } = resolvePreQinXingShi(null, clan);
  const missing = [];
  if (!xing && !shi) missing.push("姓/氏");
  return missing;
}

function main() {
  const { persons, reigns } = loadSqlCorpus();
  const missing = [];
  const seenReign = new Set();

  for (const [dynastyId, rulers] of Object.entries(rulersByDynasty)) {
    for (const ruler of rulers) {
      if (ruler.startYear >= PRE_IMPERIAL_START_YEAR) continue;
      const key = `${ruler.personId}:${dynastyId}`;
      if (seenReign.has(key)) continue;
      seenReign.add(key);
      const person = persons.get(ruler.personId);
      const clan = buildPreQinClanContext(person);
      const gaps = auditRow(clan);
      if (gaps.length) {
        missing.push({
          dynastyId,
          title: ruler.title,
          personId: ruler.personId,
          personName: ruler.personName ?? person?.name,
          gaps,
        });
      }
    }
  }

  for (const reign of reigns) {
    if (reign.startYear >= PRE_IMPERIAL_START_YEAR) continue;
    const key = `${reign.personId}:${reign.dynastyId}`;
    if (seenReign.has(key)) continue;
    seenReign.add(key);
    const person = persons.get(reign.personId);
    const clan = buildPreQinClanContext(person);
    const gaps = auditRow(clan);
    if (gaps.length) {
      missing.push({
        dynastyId: reign.dynastyId,
        title: reign.title,
        personId: reign.personId,
        personName: person?.name,
        gaps,
      });
    }
  }

  console.log("=== Missing 姓 and/or 氏 on pre-Qin reigns ===");
  for (const row of missing) {
    console.log(
      `${row.dynastyId}\t${row.title}\t${row.personId}\t${row.personName ?? "(no name)"}\tmissing: ${row.gaps.join(", ")}`,
    );
  }
  console.log(`Total: ${missing.length}`);
}

main();
