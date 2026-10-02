#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { discoverPackages, resolvePackageDirectory } from "../../../../data/imports/lib/discoverPackages.mjs";
import { fileURLToPath } from "node:url";

const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../../../");
const importsRoot = path.join(repoRoot, "data/imports");
const fontCssPath = path.join(repoRoot, "apps/web/src/design/timelineSerifFont.css");
const fontAssetsRoot = path.join(repoRoot, "apps/web/public");
const requestedSlug = process.argv[2];

if (requestedSlug === "--help" || requestedSlug === "-h") {
  console.log("Usage: node .cursor/skills/eralens-period-import/scripts/check-timeline-font-coverage.mjs [import-slug]");
  console.log("Omit import-slug to check every cache.json recursively under data/imports.");
  process.exit(0);
}

function fail(message) {
  console.error(`Font coverage check failed: ${message}`);
  process.exit(1);
}

function readFontCoverage() {
  if (!fs.existsSync(fontCssPath)) fail(`missing ${path.relative(repoRoot, fontCssPath)}`);
  const css = fs.readFileSync(fontCssPath, "utf8");
  const ranges = [];
  const missingAssets = [];
  let faceCount = 0;

  for (const [, body] of css.matchAll(/@font-face\s*\{([^}]+)\}/g)) {
    if (!/font-family\s*:\s*["']EraLens Lane Serif["']/i.test(body)) continue;
    faceCount += 1;

    const assetUrl = body.match(/url\(["']?([^)'"\s]+)["']?\)/i)?.[1];
    if (assetUrl?.startsWith("/")) {
      const assetPath = path.join(fontAssetsRoot, assetUrl.slice(1));
      if (!fs.existsSync(assetPath)) missingAssets.push(assetUrl);
    } else {
      missingAssets.push(assetUrl ?? "(missing src URL)");
    }

    const unicodeRange = body.match(/unicode-range\s*:\s*([^;]+);/i)?.[1];
    if (!unicodeRange) continue;
    for (const [, firstHex, lastHex] of unicodeRange.matchAll(/U\+([\da-f]+)(?:-([\da-f]+))?/gi)) {
      ranges.push([Number.parseInt(firstHex, 16), Number.parseInt(lastHex ?? firstHex, 16)]);
    }
  }

  if (faceCount === 0) fail(`no "EraLens Lane Serif" faces in ${path.relative(repoRoot, fontCssPath)}`);
  if (missingAssets.length) fail(`missing font assets: ${[...new Set(missingAssets)].join(", ")}`);
  return { ranges, faceCount };
}

function cacheFiles() {
  if (requestedSlug) {
    const cachePath = path.join(resolvePackageDirectory(importsRoot, requestedSlug), "cache.json");
    if (!fs.existsSync(cachePath)) fail(`no cache.json for import package "${requestedSlug}"`);
    return [[requestedSlug, cachePath]];
  }

  return discoverPackages(importsRoot)
    .map((slug) => [slug, path.join(importsRoot, slug, "cache.json")]);
}

function* displayedStrings(cache) {
  for (const dynasty of cache.dynasties ?? []) {
    yield [dynasty.name, `dynasties[${dynasty.id}].name`];
  }

  for (const person of cache.persons ?? []) {
    yield [person.name, `persons[${person.id}].name`];
    yield [person.title, `persons[${person.id}].title`];
    for (const [field, values] of [
      ["posthumousNames", person.posthumousNames],
      ["templeNames", person.templeNames],
    ]) {
      for (const value of values ?? []) yield [value, `persons[${person.id}].${field}`];
    }
  }

  for (const reign of cache.reigns ?? []) {
    yield [reign.title, `reigns[${reign.id}].title`];
  }
}

const { ranges, faceCount } = readFontCoverage();
const packages = cacheFiles();
const missing = new Map();
let checkedStrings = 0;
const supports = (codePoint) => ranges.some(([start, end]) => codePoint >= start && codePoint <= end);

for (const [slug, cachePath] of packages) {
  let cache;
  try {
    cache = JSON.parse(fs.readFileSync(cachePath, "utf8"));
  } catch (error) {
    fail(`cannot parse ${path.relative(repoRoot, cachePath)}: ${error.message}`);
  }

  for (const [value, label] of displayedStrings(cache)) {
    if (typeof value !== "string" || value.length === 0) continue;
    checkedStrings += 1;
    for (const character of value) {
      const codePoint = character.codePointAt(0);
      // ASCII letters, digits, punctuation, and whitespace use the normal fallback stack.
      if (codePoint <= 0x7f || supports(codePoint)) continue;
      const entry = missing.get(codePoint) ?? { character, examples: [] };
      if (entry.examples.length < 4) entry.examples.push(`${slug}:${label}`);
      missing.set(codePoint, entry);
    }
  }
}

if (missing.size) {
  console.error(`Missing ${missing.size} distinct glyph(s) from EraLens Lane Serif (${checkedStrings} display strings checked):`);
  for (const [codePoint, { character, examples }] of [...missing].sort(([a], [b]) => a - b)) {
    console.error(`  ${character} U+${codePoint.toString(16).toUpperCase().padStart(4, "0")}  ${examples.join("; ")}`);
  }
  console.error("Extend timelineSerifFont.css and its WOFF2 subsets, then rerun this check.");
  process.exit(1);
}

console.log(`Timeline font coverage OK: ${checkedStrings} display strings, all non-ASCII glyphs covered by ${faceCount} font subset(s) across ${packages.length} import package(s).`);
