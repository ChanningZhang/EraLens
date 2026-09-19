#!/usr/bin/env node
/**
 * Audit 618+ persons missing posthumous_name / temple_name in import SQL.
 * Run: node data/imports/lib/auditImperialAppellationFields.mjs
 */
import { readdirSync, readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const TEMPLE_ERA_START_YEAR = 618;
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const importsRoot = path.resolve(__dirname, "..");

function parsePersons(content) {
  const persons = [];
  const re =
    /INSERT INTO persons \(id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name\)\s*VALUES \('([^']+)'[\s\S]*?'::jsonb,\s*([^,]+),\s*([^)]+)\)/g;
  for (const m of content.matchAll(re)) {
    persons.push({
      id: m[1],
      posthumous: m[2].trim(),
      temple: m[3].trim(),
    });
  }
  return persons;
}

function parseReignStartYears(content) {
  const byPerson = new Map();
  const re =
    /INSERT INTO reigns \([^)]+\)\s*VALUES \('[^']+', '[^']+', '([^']+)'[\s\S]*?,\s*(-?\d+),/g;
  for (const m of content.matchAll(re)) {
    const personId = m[1];
    const startYear = Number(m[2]);
    const prev = byPerson.get(personId);
    if (prev == null || startYear < prev) byPerson.set(personId, startYear);
  }
  return byPerson;
}

function main() {
  const gaps = [];
  for (const slug of readdirSync(importsRoot)) {
    const sqlPath = path.join(importsRoot, slug, "import.sql");
    try {
      const content = readFileSync(sqlPath, "utf8");
      const reignStarts = parseReignStartYears(content);
      for (const person of parsePersons(content)) {
        const startYear = reignStarts.get(person.id);
        if (startYear == null || startYear < TEMPLE_ERA_START_YEAR) continue;
        if (person.posthumous !== "NULL" || person.temple !== "NULL") continue;
        gaps.push({ slug, personId: person.id, startYear });
      }
    } catch {
      // skip
    }
  }
  console.log("=== 618+ persons with both posthumous_name and temple_name NULL ===");
  for (const row of gaps.slice(0, 40)) {
    console.log(`${row.slug}\t${row.startYear}\t${row.personId}`);
  }
  if (gaps.length > 40) console.log(`... and ${gaps.length - 40} more`);
  console.log(`Total: ${gaps.length}`);
}

main();
