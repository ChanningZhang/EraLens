import { readFileSync, writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { discoverPackages } from "./lib/discoverPackages.mjs";
import { auditPackageOwnership } from "./lib/auditPackageOwnership.mjs";
import { rowsForPackage } from "./lib/sqlitePackageRows.mjs";
import { mapReign } from "../../packages/data-access/src/sqliteRepository.ts";
import { parseDynastyName, reignDynastyNameDurations, resolveReignDynastyNameByDuration } from "../../packages/shared/src/dynastyNames.ts";
import { isParallelClaim } from "../../packages/shared/src/claimTracks.ts";

// Run with pnpm --filter @eralens/api exec node --import tsx ../../data/imports/assign-reign-dynasty-names.mjs [--apply].
const root = path.dirname(fileURLToPath(import.meta.url));
const apply = process.argv.includes("--apply");
auditPackageOwnership(root);
const packages = discoverPackages(root).map(slug => ({
  slug, file: path.join(root, slug, "cache.json"),
  cache: JSON.parse(readFileSync(path.join(root, slug, "cache.json"), "utf8")),
}));
const dynasties = new Map(packages.flatMap(({ cache }) => (cache.dynasties ?? [])
  .filter(dynasty => typeof parseDynastyName(dynasty.name) !== "string")
  .map(dynasty => [dynasty.id, dynasty])));
const reigns = packages.flatMap(({ slug, cache }) => rowsForPackage(slug, cache).reigns.map(mapReign));
const reignById = new Map(reigns.map(reign => [reign.id, reign]));
const assignments = [];
const changedPackages = [];
const note = "2026-10：分时名称王朝所属主线 reign 的 dynastyName 按已有 name.periods 和共享 reign/phase 归属区间计算，取累计使用日数最多的名称；同名阶段累计，阶段外回退 default，时长相同取较早阶段。并立政权保留其已有 dynastyName，不参与主线名称回填；日期与并立轨道不作调整。";
for (const { slug, file, cache } of packages) {
  let changed = false;
  for (const row of cache.reigns ?? []) {
    const dynasty = dynasties.get(row.dynastyId);
    if (!dynasty) continue;
    const reign = reignById.get(row.id);
    if (isParallelClaim(reign)) continue;
    const name = resolveReignDynastyNameByDuration(dynasty, reign, reigns);
    assignments.push({ slug, id: row.id, dynastyId: row.dynastyId, previous: row.dynastyName ?? null, name,
      durations: reignDynastyNameDurations(dynasty, reign, reigns) });
    if (row.dynastyName !== name) { row.dynastyName = name; changed = true; }
  }
  if (!changed) continue;
  changedPackages.push(slug);
  if (apply) {
    cache.manifest.notes ??= [];
    if (!cache.manifest.notes.includes(note)) cache.manifest.notes.push(note);
    writeFileSync(file, `${JSON.stringify(cache, null, 2)}\n`);
  }
}
console.log(JSON.stringify({ apply, dynastyIds: [...dynasties.keys()], changedPackages, count: assignments.length,
  counts: Object.fromEntries([...dynasties.keys()].map(id => [id, assignments.filter(row => row.dynastyId === id).length])),
  crossings: assignments.filter(row => row.durations.length > 1),
  overrides: assignments.filter(row => row.previous && row.previous !== row.name),
}, null, 2));
