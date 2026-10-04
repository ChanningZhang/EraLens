import { readFileSync, writeFileSync } from "node:fs";
import path from "node:path";
import { serializeSqlitePackages } from "./sqlitePackageRows.mjs";

export function generateCachedPackageFromDirectory(dir) {
  const cachePath = path.join(dir, "cache.json");
  const cache = JSON.parse(readFileSync(cachePath, "utf8"));
  const { sql, counts } = serializeSqlitePackages([{ slug: cache.slug, cache }]);
  const manifest = {
    ...cache.manifest,
    slug: cache.slug,
    counts: {
      ...(cache.manifest?.counts ?? {}),
      persons: cache.persons?.length ?? 0,
      dynastyGroups: cache.dynastyGroups?.length ?? 0,
      dynasties: cache.dynasties?.length ?? 0,
      reigns: cache.reigns?.length ?? 0,
      events: cache.events?.length ?? 0,
      relations: cache.relations?.length ?? 0,
      associations: cache.associations?.length ?? 0,
      locations: cache.locations?.length ?? 0,
      locationMappings: cache.locationMappings?.length ?? 0,
    },
  };
  writeFileSync(path.join(dir, "import.sql"), `-- SQLite import package: ${cache.slug}\nBEGIN;\n${sql}\nCOMMIT;\n`);
  writeFileSync(path.join(dir, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);
  console.log(`[${cache.slug}] ${JSON.stringify(counts)}`);
}
