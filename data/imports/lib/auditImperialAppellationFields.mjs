#!/usr/bin/env node
/**
 * Audit 618+ reigns missing posthumous_name / temple_name in import SQL.
 * Run: node data/imports/lib/auditImperialAppellationFields.mjs
 */
import { readdirSync, readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const TEMPLE_ERA_START_YEAR = 618;
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const importsRoot = path.resolve(__dirname, "..");

function parseReigns(content) {
  const reigns = [];
  const re =
    /INSERT INTO reigns \(id, dynasty_id, person_id, title, posthumous_name, temple_name[^)]*\)\s*\nVALUES \('([^']+)', '([^']+)', '([^']+)', '([^']+)', ([^,]+), ([^,]+),[^,]*,\s*(-?\d+),/g;
  for (const m of content.matchAll(re)) {
    reigns.push({
      id: m[1],
      dynastyId: m[2],
      title: m[4],
      posthumous: m[5].trim(),
      temple: m[6].trim(),
      startYear: Number(m[7]),
    });
  }
  return reigns;
}

function main() {
  const gaps = [];
  for (const slug of readdirSync(importsRoot)) {
    const sqlPath = path.join(importsRoot, slug, "import.sql");
    try {
      const content = readFileSync(sqlPath, "utf8");
      for (const reign of parseReigns(content)) {
        if (reign.startYear < TEMPLE_ERA_START_YEAR) continue;
        if (reign.posthumous !== "NULL" || reign.temple !== "NULL") continue;
        gaps.push({ slug, ...reign });
      }
    } catch {
      // skip
    }
  }
  console.log("=== 618+ reigns with both posthumous_name and temple_name NULL ===");
  for (const row of gaps.slice(0, 40)) {
    console.log(`${row.slug}\t${row.startYear}\t${row.title}\t${row.id}`);
  }
  if (gaps.length > 40) console.log(`... and ${gaps.length - 40} more`);
  console.log(`Total: ${gaps.length}`);
}

main();
