#!/usr/bin/env node
import { readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { spawnSync } from "node:child_process";
import { discoverPackages, resolvePackageDirectory } from "../data/imports/lib/discoverPackages.mjs";
import { auditPackageOwnership } from "../data/imports/lib/auditPackageOwnership.mjs";
import { dynastySql, sqlStr } from "../data/imports/lib/sqlHelpers.mjs";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const imports = path.join(root, "data/imports");
const slug = process.argv[2];
if (!slug) throw new Error("Usage: node scripts/apply-dynasty-merges.mjs <owner-package> [--dry-run]");
auditPackageOwnership(imports);
const owner = JSON.parse(readFileSync(path.join(resolvePackageDirectory(imports, slug), "cache.json"), "utf8"));
const merges = owner.dynastyMerges;
if (!merges?.length || merges.some(m => !m.fromId || !m.toId || m.fromId === m.toId)) throw new Error("Missing or invalid dynastyMerges source configuration");
const targets = new Set(merges.map(m => m.toId));
if ([...targets].some(id => !owner.dynasties.some(d => d.id === id))) throw new Error("Merge targets must belong to the owner package");
const packages = discoverPackages(imports).map(name => {
  const directory = resolvePackageDirectory(imports, name);
  return { name, directory, cache: JSON.parse(readFileSync(path.join(directory, "cache.json"), "utf8")) };
}).filter(({ name, cache: c }) =>
  name === slug || (c.dynasties ?? []).some(d => targets.has(d.id) || targets.has(d.parentId)) ||
  (c.reigns ?? []).some(r => targets.has(r.dynastyId)) ||
  (c.locationMappings ?? []).some(m => m.kind === "dynasty" && targets.has(m.externalId)) ||
  (c.associations ?? []).some(a => [a.aRef, a.bRef].some(ref => ref.startsWith("dynasty:") && targets.has(ref.slice(8)))),
).sort((a, b) => a.name === slug ? -1 : b.name === slug ? 1 : a.name.localeCompare(b.name));

const packageSql = packages.map(p => {
  const file = path.join(p.directory, "import.sql");
  const validation = spawnSync(process.execPath, [path.join(root, ".cursor/skills/eralens-period-import/scripts/validate-import.mjs"), file], { encoding: "utf8" });
  if (validation.status !== 0) throw new Error(validation.stderr || validation.stdout);
  return readFileSync(file, "utf8").replace(/^\s*(BEGIN|COMMIT);\s*$/gmi, "");
});
const sql = `BEGIN;
LOCK TABLE dynasties, reigns, entity_associations, location_mapping IN SHARE ROW EXCLUSIVE MODE;
CREATE TEMP TABLE dynasty_merge_ids (old_id TEXT PRIMARY KEY, new_id TEXT NOT NULL) ON COMMIT DROP;
INSERT INTO dynasty_merge_ids VALUES ${merges.map(m => `(${sqlStr(m.fromId)}, ${sqlStr(m.toId)})`).join(",")};
CREATE TEMP TABLE merge_reigns_before ON COMMIT DROP AS SELECT id FROM reigns;
CREATE TEMP TABLE merge_persons_before ON COMMIT DROP AS SELECT id FROM persons;
${owner.dynasties.filter(d => targets.has(d.id)).map(dynastySql).join("\n")}
UPDATE reigns r SET dynasty_id=m.new_id FROM dynasty_merge_ids m WHERE r.dynasty_id=m.old_id;
UPDATE dynasties d SET parent_id=m.new_id FROM dynasty_merge_ids m WHERE d.parent_id=m.old_id;
UPDATE location_mapping l SET external_id=m.new_id FROM dynasty_merge_ids m WHERE l.kind='dynasty' AND l.external_id=m.old_id;
WITH mapped AS (
 SELECT a_type, CASE WHEN a_type='dynasty' THEN COALESCE(ma.new_id,a_id) ELSE a_id END AS a_id,
        b_type, CASE WHEN b_type='dynasty' THEN COALESCE(mb.new_id,b_id) ELSE b_id END AS b_id
 FROM entity_associations a
 LEFT JOIN dynasty_merge_ids ma ON a.a_type='dynasty' AND a.a_id=ma.old_id
 LEFT JOIN dynasty_merge_ids mb ON a.b_type='dynasty' AND a.b_id=mb.old_id
 WHERE ma.old_id IS NOT NULL OR mb.old_id IS NOT NULL
), normalized AS (
 SELECT CASE WHEN (a_type||':'||a_id) COLLATE "C" < (b_type||':'||b_id) COLLATE "C" THEN a_type ELSE b_type END AS a_type,
        CASE WHEN (a_type||':'||a_id) COLLATE "C" < (b_type||':'||b_id) COLLATE "C" THEN a_id ELSE b_id END AS a_id,
        CASE WHEN (a_type||':'||a_id) COLLATE "C" < (b_type||':'||b_id) COLLATE "C" THEN b_type ELSE a_type END AS b_type,
        CASE WHEN (a_type||':'||a_id) COLLATE "C" < (b_type||':'||b_id) COLLATE "C" THEN b_id ELSE a_id END AS b_id
 FROM mapped WHERE a_type||':'||a_id <> b_type||':'||b_id
)
INSERT INTO entity_associations SELECT DISTINCT * FROM normalized ON CONFLICT DO NOTHING;
DELETE FROM entity_associations a USING dynasty_merge_ids m WHERE (a.a_type='dynasty' AND a.a_id=m.old_id) OR (a.b_type='dynasty' AND a.b_id=m.old_id);
${packageSql.join("\n")}
DO $$ BEGIN
 IF EXISTS (SELECT 1 FROM merge_reigns_before b LEFT JOIN reigns r ON r.id=b.id WHERE r.id IS NULL)
    OR EXISTS (SELECT 1 FROM merge_persons_before b LEFT JOIN persons p ON p.id=b.id WHERE p.id IS NULL) THEN
   RAISE EXCEPTION 'Dynasty merge unexpectedly removed existing person or reign IDs';
 END IF;
 IF EXISTS (SELECT 1 FROM reigns r JOIN dynasty_merge_ids m ON r.dynasty_id=m.old_id)
    OR EXISTS (SELECT 1 FROM location_mapping l JOIN dynasty_merge_ids m ON l.kind='dynasty' AND l.external_id=m.old_id)
    OR EXISTS (SELECT 1 FROM dynasties d JOIN dynasty_merge_ids m ON d.parent_id=m.old_id) THEN
   RAISE EXCEPTION 'Old dynasty references remain';
 END IF;
END $$;
DELETE FROM dynasties d USING dynasty_merge_ids m WHERE d.id=m.old_id;
SELECT rebuild_person_search_terms();
COMMIT;
`;
if (process.argv.includes("--dry-run")) {
  console.log(JSON.stringify({ packages: packages.map(p => p.name), merges, sqlBytes: sql.length }));
} else {
  const result = spawnSync("docker", ["exec", "-i", process.env.ERALENS_PG_CONTAINER ?? "eralens-postgres", "psql", "-v", "ON_ERROR_STOP=1", "-U", process.env.ERALENS_PG_USER ?? "eralens", "-d", process.env.ERALENS_PG_DB ?? "eralens"], { input: sql, encoding: "utf8", maxBuffer: 10 * 1024 * 1024 });
  if (result.status !== 0) throw new Error(result.stderr || result.stdout);
  console.log(`Dynasty merge committed: ${packages.map(p => p.name).join(", ")}`);
}
