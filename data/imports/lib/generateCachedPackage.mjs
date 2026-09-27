import { readFileSync } from "node:fs";
import path from "node:path";
import { writePreparedImportPackage } from "./sqlHelpers.mjs";

export function generateCachedPackageFromDirectory(dir) {
  const cache = JSON.parse(readFileSync(path.join(dir, "cache.json"), "utf8"));
  writePreparedImportPackage(dir, cache);
}
