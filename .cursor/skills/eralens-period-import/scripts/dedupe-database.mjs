#!/usr/bin/env node
/**
 * Remove stale duplicate reigns from the database.
 *
 * Upsert imports (ON CONFLICT DO UPDATE) never delete rows that were removed
 * from import.sql. This script finds:
 *   1. Orphan reigns — in DB but not in any import.sql under data/imports
 *   2. Span duplicates — same dynasty + start_abs + end_abs (causes UI stacking)
 *
 * Keeps the reign that exists in import.sql; drops the orphan.
 * Co-regents with different person_ids (e.g. 萧昭业/萧昭文) are preserved.
 *
 * Usage:
 *   node .cursor/skills/eralens-period-import/scripts/dedupe-database.mjs [--dry-run]
 */
import { readFileSync, readdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { execSync } from "node:child_process";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(__dirname, "../../../..");
const importDir = path.join(repoRoot, "data/imports");
const dryRun = process.argv.includes("--dry-run");

const CONTAINER = process.env.ERALENS_PG_CONTAINER || "eralens-postgres";
const PGUSER = process.env.ERALENS_PG_USER || "eralens";
const PGDB = process.env.ERALENS_PG_DB || "eralens";

function psql(query) {
  const cmd = `docker exec ${CONTAINER} psql -U ${PGUSER} -d ${PGDB} -t -A -F'|' -c "${query.replace(/"/g, '\\"')}"`;
  return execSync(cmd, { encoding: "utf8" }).trim();
}

function psqlExec(query) {
  const cmd = `docker exec ${CONTAINER} psql -v ON_ERROR_STOP=1 -U ${PGUSER} -d ${PGDB} -c "${query.replace(/"/g, '\\"')}"`;
  execSync(cmd, { stdio: "inherit" });
}

function collectImportReignIds() {
  const ids = new Set();
  for (const slug of readdirSync(importDir)) {
    const sqlFile = path.join(importDir, slug, "import.sql");
    try {
      const sql = readFileSync(sqlFile, "utf8");
      for (const m of sql.matchAll(/'reign-[^']+'/g)) {
        ids.add(m[0].slice(1, -1));
      }
    } catch {
      // no import.sql in this folder
    }
  }
  return ids;
}

function loadDbReigns() {
  const raw = psql(
    "SELECT r.id, r.dynasty_id, r.person_id, r.title, r.start_abs, r.end_abs, p.name FROM reigns r JOIN persons p ON p.id = r.person_id ORDER BY r.id",
  );
  if (!raw) return [];
  return raw.split("\n").map((line) => {
    const [id, dynastyId, personId, title, startAbs, endAbs, personName] = line.split("|");
    return { id, dynastyId, personId, title, startAbs: +startAbs, endAbs: +endAbs, personName };
  });
}

function pickKeeper(group, importIds) {
  const inImport = group.filter((r) => importIds.has(r.id));
  if (inImport.length === 1) return inImport[0];
  if (inImport.length > 1) return inImport[0]; // multiple in import — keep first
  // none in import (seed data): keep first by id
  return group[0];
}

function main() {
  const importIds = collectImportReignIds();
  const reigns = loadDbReigns();
  console.log(`Import SQL reign ids: ${importIds.size}`);
  console.log(`Database reigns: ${reigns.length}`);

  const toDelete = new Set();

  // Orphan reigns not in any import.sql (but only delete if they cause span dupes or are clearly stale)
  const orphans = reigns.filter((r) => !importIds.has(r.id));
  console.log(`\nOrphan reigns (not in import.sql): ${orphans.length}`);

  // Span duplicates
  const bySpan = new Map();
  for (const r of reigns) {
    const key = `${r.dynastyId}|${r.startAbs}|${r.endAbs}`;
    if (!bySpan.has(key)) bySpan.set(key, []);
    bySpan.get(key).push(r);
  }

  for (const [key, group] of bySpan) {
    if (group.length <= 1) continue;

    // Different persons with same span = co-regency (e.g. 萧昭业/萧昭文), keep all
    const personIds = new Set(group.map((r) => r.personId));
    if (personIds.size > 1) {
      const names = new Set(group.map((r) => r.personName));
      if (names.size > 1) {
        console.log(`  Co-regency kept: ${key} → ${group.map((r) => r.title).join(" / ")}`);
        continue;
      }
    }

    const keeper = pickKeeper(group, importIds);
    for (const r of group) {
      if (r.id !== keeper.id) {
        toDelete.add(r.id);
        console.log(`  Duplicate span: drop ${r.id} (${r.title}), keep ${keeper.id} (${keeper.title})`);
      }
    }
  }

  // Orphans that don't cause span dupes but are stale import leftovers
  for (const r of orphans) {
    if (!toDelete.has(r.id)) {
      // Only auto-delete orphans that have a same-span sibling already kept
      const key = `${r.dynastyId}|${r.startAbs}|${r.endAbs}`;
      const group = bySpan.get(key) ?? [];
      const keeper = pickKeeper(group, importIds);
      if (group.length > 1 && keeper.id !== r.id) {
        toDelete.add(r.id);
        console.log(`  Orphan duplicate: drop ${r.id} (${r.title})`);
      }
    }
  }

  if (toDelete.size === 0) {
    console.log("\nNo duplicate reigns to remove.");
    return;
  }

  const deleteIds = [...toDelete].map((id) => `'${id}'`).join(", ");
  console.log(`\n${dryRun ? "[DRY RUN] Would delete" : "Deleting"} ${toDelete.size} reigns.`);

  if (dryRun) return;

  const personIds = reigns.filter((r) => toDelete.has(r.id)).map((r) => r.personId);
  const uniquePersonIds = [...new Set(personIds)].map((id) => `'${id}'`).join(", ");
  const personCleanup = uniquePersonIds
    ? `DELETE FROM persons
       WHERE id IN (${uniquePersonIds})
         AND NOT EXISTS (SELECT 1 FROM reigns r WHERE r.person_id = persons.id)
         AND NOT EXISTS (SELECT 1 FROM event_participants ep WHERE ep.person_id = persons.id)
         AND NOT EXISTS (SELECT 1 FROM relations rel WHERE rel.from_id = persons.id OR rel.to_id = persons.id);`
    : "";

  const sql = [
    "BEGIN;",
    `DELETE FROM era_names WHERE reign_id IN (${deleteIds});`,
    `DELETE FROM reigns WHERE id IN (${deleteIds});`,
    personCleanup,
    "COMMIT;",
  ]
    .filter(Boolean)
    .join("\n");

  execSync(`docker exec -i ${CONTAINER} psql -v ON_ERROR_STOP=1 -U ${PGUSER} -d ${PGDB}`, {
    input: sql,
    stdio: ["pipe", "inherit", "inherit"],
  });

  // Verify
  const remaining = psql(
    "SELECT dynasty_id, start_abs, end_abs, COUNT(*) FROM reigns GROUP BY dynasty_id, start_abs, end_abs HAVING COUNT(*) > 1",
  );
  if (remaining) {
    console.log("\nWarning: remaining span duplicates:");
    console.log(remaining);
  } else {
    console.log("\nDone. No span duplicates remain (co-regencies excluded).");
  }
}

main();
