#!/usr/bin/env node
/** Merge ruler-bios-group*.mjs into ruler-bios.mjs */
import { writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";
import { WIKI_TITLE_BY_PERSON_ID } from "./ruler-bios.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function loadGroup(file) {
  const mod = await import(pathToFileURL(path.join(__dirname, file)).href);
  return mod.RULER_BIO_OVERRIDES ?? {};
}

async function main() {
  const groups = [
    "ruler-bios-group1.mjs",
    "ruler-bios-group2.mjs",
    "ruler-bios-group3.mjs",
    "ruler-bios-group4.mjs",
  ];

  const merged = {};
  for (const file of groups) {
    try {
      Object.assign(merged, await loadGroup(file));
    } catch {
      console.warn(`skip missing ${file}`);
    }
  }

  const lines = [
    "/**",
    " * Ruler bio overrides (summarized from zh.wikipedia.org).",
    " * Regenerate groups, then: node data/imports/chunqiu-zhanguo/merge-ruler-bios.mjs",
    " */",
    "",
    "export const WIKI_TITLE_BY_PERSON_ID = " + JSON.stringify(WIKI_TITLE_BY_PERSON_ID, null, 2) + ";",
    "",
    "export const RULER_BIO_OVERRIDES = {",
  ];

  for (const [id, entry] of Object.entries(merged).sort(([a], [b]) => a.localeCompare(b))) {
    lines.push(`  ${JSON.stringify(id)}: { bio: ${JSON.stringify(entry.bio)} },`);
  }

  lines.push("};", "");
  const outPath = path.join(__dirname, "ruler-bios.mjs");
  writeFileSync(outPath, lines.join("\n"), "utf8");
  console.log(`Merged ${Object.keys(merged).length} bios -> ${outPath}`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
