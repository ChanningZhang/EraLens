import { readFileSync } from "node:fs";
import path from "node:path";
import { discoverPackages } from "./discoverPackages.mjs";
import { writePreparedImportPackage } from "./sqlHelpers.mjs";

export function generateCachedPackageFromDirectory(dir) {
  const cache = JSON.parse(readFileSync(path.join(dir, "cache.json"), "utf8"));
  for (const key of ["capitals", "reignCapitals", "eventLocations"]) if (cache[key]?.length) throw new Error(`Legacy geography cache: ${key}`);
  const root = path.resolve(dir.split(`${path.sep}data${path.sep}imports${path.sep}`)[0], "data/imports");
  const all = discoverPackages(root).map(slug => JSON.parse(readFileSync(path.join(root, slug, "cache.json"), "utf8")));
  const locations = new Set(all.flatMap(c => c.locations ?? []).map(l => l.id));
  const owners = Object.fromEntries(["dynasty", "reign", "event"].map(kind => [kind, new Set(all.flatMap(c => c[kind === "dynasty" ? "dynasties" : kind === "reign" ? "reigns" : "events"] ?? []).map(r => r.id))]));
  for (const m of cache.locationMappings ?? []) {
    if (!locations.has(m.locationId) || !owners[m.kind]?.has(m.externalId)) throw new Error(`Dangling mapping ${m.id}: ${m.kind}:${m.externalId} @ ${m.locationId}`);
  }
  writePreparedImportPackage(dir, cache);
}
