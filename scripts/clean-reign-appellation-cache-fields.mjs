import { readFileSync, writeFileSync } from "node:fs";
import path from "node:path";
import { discoverPackages } from "../data/imports/lib/discoverPackages.mjs";
import { fileURLToPath } from "node:url";

const projectRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const importsRoot = path.join(projectRoot, "data", "imports");
let changedPackages = 0;
let removedFields = 0;

for (const slug of discoverPackages(importsRoot)) {

  const cachePath = path.join(importsRoot, slug, "cache.json");
  let cache;
  try {
    cache = JSON.parse(readFileSync(cachePath, "utf8"));
  } catch (error) {
    if (error.code === "ENOENT") continue;
    throw new Error(`Failed to read ${cachePath}: ${error.message}`, { cause: error });
  }

  if (cache.reigns == null) cache.reigns = [];
  if (!Array.isArray(cache.reigns)) {
    throw new Error(`${cachePath} must contain a reigns array`);
  }

  let packageRemovedFields = 0;
  for (const reign of cache.reigns) {
    for (const field of ["posthumousName", "templeName"]) {
      if (Object.hasOwn(reign, field)) {
        delete reign[field];
        packageRemovedFields += 1;
      }
    }
  }

  if (packageRemovedFields === 0) continue;
  writeFileSync(cachePath, `${JSON.stringify(cache, null, 2)}\n`);
  changedPackages += 1;
  removedFields += packageRemovedFields;
  console.log(`${slug}: removed ${packageRemovedFields} fields`);
}

console.log(`Done: ${removedFields} fields removed from ${changedPackages} packages.`);
