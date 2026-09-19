#!/usr/bin/env node
/**
 * Rewrite import.sql: move 庙谥 to persons, collapse era_names into reigns.era_names CSV.
 */
import { readdirSync, readFileSync, statSync, writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { formatAppellationCsv } from "./sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const importsRoot = path.resolve(__dirname, "..");

const NULL_OR_QUOTED = `(NULL|'(?:[^'\\\\]|\\\\.|'')*')`;

function sqlStr(value) {
  if (value == null) return "NULL";
  return `'${String(value).replace(/'/g, "''")}'`;
}

function unquoteSql(value) {
  const trimmed = value.trim();
  if (trimmed === "NULL") return null;
  if (!trimmed.startsWith("'")) return trimmed;
  return trimmed.slice(1, -1).replace(/''/g, "'");
}

function joinMultilineInserts(content) {
  let next = content.replace(
    /(INSERT INTO (?:persons|reigns) \([^)]+\))\s*\nVALUES \(([\s\S]*?)\)\s*\n(ON CONFLICT[\s\S]*?;)/g,
    "$1 VALUES ($2) $3",
  );
  next = next.replace(
    /(INSERT INTO era_names \([^)]+\))\s*\nVALUES \(([^;]+)\);/g,
    "$1 VALUES ($2);",
  );
  return next;
}

function collectReignAppellations(content) {
  const byPerson = new Map();
  const re = new RegExp(
    `INSERT INTO reigns \\([^)]+\\)\\s*VALUES \\('([^']+)', '([^']+)', '([^']+)', '(?:[^'\\\\]|\\\\.|'')*', ${NULL_OR_QUOTED}, ${NULL_OR_QUOTED},`,
    "g",
  );
  for (const m of content.matchAll(re)) {
    const personId = m[3];
    const posthumous = unquoteSql(m[4]);
    const temple = unquoteSql(m[5]);
    const entry = byPerson.get(personId) ?? { posthumous: [], temple: [] };
    if (posthumous && !entry.posthumous.includes(posthumous)) entry.posthumous.push(posthumous);
    if (temple && !entry.temple.includes(temple)) entry.temple.push(temple);
    byPerson.set(personId, entry);
  }
  return byPerson;
}

function collectEraNames(content) {
  const rows = [
    ...content.matchAll(
      /INSERT INTO era_names \(reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order\) VALUES \('([^']*)', '([^']*)',[^,]+,[^,]+,[^,]+,[^,]+,[^,]+,[^,]+, (-?\d+)\);/g,
    ),
  ];
  rows.sort((a, b) => Number(a[3]) - Number(b[3]));
  const byReign = new Map();
  for (const m of rows) {
    const reignId = m[1].replace(/''/g, "'");
    const name = m[2].replace(/''/g, "'");
    const list = byReign.get(reignId) ?? [];
    if (!list.includes(name)) list.push(name);
    byReign.set(reignId, list);
  }
  return byReign;
}

function rewritePersons(content, byPerson) {
  if (
    content.includes(
      "INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)",
    )
  ) {
    return content;
  }
  return content.replace(
    /INSERT INTO persons \(id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links\)\s*VALUES \('([^']+)'([\s\S]*?)'::jsonb\)\s*(ON CONFLICT \(id\) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;)/g,
    (_match, personId, middle, conflictPart) => {
      const entry = byPerson.get(personId) ?? { posthumous: [], temple: [] };
      const posthumous = formatAppellationCsv(entry.posthumous);
      const temple = formatAppellationCsv(entry.temple);
      return `INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name) VALUES ('${personId}'${middle}'::jsonb, ${sqlStr(posthumous)}, ${sqlStr(temple)}) ${conflictPart.replace(
        "links = EXCLUDED.links;",
        "links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;",
      )}`;
    },
  );
}

function rewriteReigns(content, erasByReign) {
  if (content.includes("title, era_names, preferred_appellation")) return content;
  let next = content.replace(
    /INSERT INTO reigns \(id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation,/g,
    "INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, preferred_appellation,",
  );
  next = next.replace(
    /posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation/g,
    "era_names = EXCLUDED.era_names, preferred_appellation",
  );
  const re = new RegExp(
    `(INSERT INTO reigns \\([^)]+\\)\\s*VALUES \\('([^']+)', '([^']+)', '([^']+)', '(?:[^'\\\\]|\\\\.|'')*', )${NULL_OR_QUOTED}, ${NULL_OR_QUOTED},`,
    "g",
  );
  next = next.replace(re, (_match, prefix, reignId) => {
    const eraCsv = formatAppellationCsv(erasByReign.get(reignId) ?? []);
    return `${prefix}${sqlStr(eraCsv)}, `;
  });
  return next;
}

function stripEraSection(content) {
  return content
    .replace(/\n-- era_names[\s\S]*?(?=\n-- events|\n-- event_dynasties|\n-- relations|\nCOMMIT;)/, "\n")
    .replace(/\nDELETE FROM era_names[^\n]*\n/g, "\n")
    .replace(/\nINSERT INTO era_names[^\n]*\n/g, "\n");
}

function rewriteFile(sqlPath) {
  let content = readFileSync(sqlPath, "utf8");
  if (
    content.includes(
      "INSERT INTO reigns (id, dynasty_id, person_id, title, era_names,",
    ) &&
    content.includes(
      "INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)",
    )
  ) {
    return { skipped: true };
  }
  content = joinMultilineInserts(content);
  const byPerson = collectReignAppellations(content);
  const localPersonIds = new Set();
  for (const m of content.matchAll(
    /INSERT INTO persons \(id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links(?:, posthumous_name, temple_name)?\)\s*VALUES \('([^']+)'/g,
  )) {
    localPersonIds.add(m[1]);
  }
  const erasByReign = collectEraNames(content);
  content = rewritePersons(content, byPerson);
  content = rewriteReigns(content, erasByReign);
  content = stripEraSection(content);
  const orphanUpdates = [];
  for (const [personId, entry] of byPerson) {
    if (localPersonIds.has(personId)) continue;
    const posthumous = formatAppellationCsv(entry.posthumous);
    const temple = formatAppellationCsv(entry.temple);
    if (!posthumous && !temple) continue;
    orphanUpdates.push(
      `UPDATE persons SET posthumous_name = COALESCE(NULLIF(posthumous_name, ''), ${sqlStr(posthumous)}), temple_name = COALESCE(NULLIF(temple_name, ''), ${sqlStr(temple)}) WHERE id = ${sqlStr(personId)};`,
    );
  }
  if (orphanUpdates.length) {
    content = content.replace(
      /\nCOMMIT;/,
      `\n\n-- person_appellation_updates\n${orphanUpdates.join("\n")}\n\nCOMMIT;`,
    );
  }
  writeFileSync(sqlPath, content.endsWith("\n") ? content : `${content}\n`);
  return {
    persons: byPerson.size,
    eras: erasByReign.size,
    orphanUpdates: orphanUpdates.length,
  };
}

function main() {
  let rewritten = 0;
  let skipped = 0;
  for (const slug of readdirSync(importsRoot)) {
    const dirPath = path.join(importsRoot, slug);
    try {
      if (!statSync(dirPath).isDirectory()) continue;
      const result = rewriteFile(path.join(dirPath, "import.sql"));
      if (result.skipped) {
        skipped++;
        continue;
      }
      rewritten++;
      console.log(`${slug}: ${result.persons} persons w/ 庙谥, ${result.eras} reigns w/ eras`);
    } catch (error) {
      if (error.code !== "ENOENT") console.error(`${slug}: ${error.message}`);
    }
  }
  console.log(`Rewrote ${rewritten} files (${skipped} skipped).`);
}

main();
