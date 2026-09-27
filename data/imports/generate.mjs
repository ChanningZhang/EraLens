#!/usr/bin/env node
import { readdirSync, statSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { generateCachedPackageFromDirectory } from "./lib/generateCachedPackage.mjs";
import { auditPackageOwnership } from "./lib/auditPackageOwnership.mjs";

const importsRoot = path.dirname(fileURLToPath(import.meta.url));
const target = process.argv[2];
if (!target) {
  console.error("Usage: node data/imports/generate.mjs <package-slug|--all>");
  process.exit(1);
}

const slugs = target === "--all"
  ? readdirSync(importsRoot).filter((slug) => {
    const dir = path.join(importsRoot, slug);
    return statSync(dir).isDirectory() && statSync(path.join(dir, "cache.json"), { throwIfNoEntry: false });
  }).sort()
  : [target];

auditPackageOwnership(importsRoot);

for (const slug of slugs) {
  if (slug !== path.basename(slug) || slug.startsWith(".")) {
    throw new Error(`Invalid import package slug: ${slug}`);
  }
  const dir = path.join(importsRoot, slug);
  if (!statSync(dir, { throwIfNoEntry: false })?.isDirectory() || !statSync(path.join(dir, "cache.json"), { throwIfNoEntry: false })) {
    throw new Error(`Import package has no cache.json: ${slug}`);
  }
  generateCachedPackageFromDirectory(dir);
}
