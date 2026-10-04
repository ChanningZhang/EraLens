#!/usr/bin/env node
import { validateDynastyName } from "../../../../packages/shared/src/dynastyNameFormat.mjs";
import { readFileSync } from "node:fs";
import path from "node:path";
import { validateReignDateConfidenceSeams } from "../../../../data/imports/lib/validateReignSeams.mjs";

const file = process.argv[2];
if (!file) {
  console.error("Usage: node validate-import.mjs <path/to/import.sql>");
  process.exit(1);
}

const sql = readFileSync(file, "utf8");
const errors = [];
if (!/^\s*-- SQLite import package:/u.test(sql)) errors.push("Expected generated SQLite package SQL");
if (!/\bBEGIN\s*;/iu.test(sql)) errors.push("Missing BEGIN;");
if (!/\bCOMMIT\s*;/iu.test(sql)) errors.push("Missing COMMIT;");
if (/\b(?:SERIAL|JSONB|ARRAY\s*\[|::text\[\]|EXCLUDED\.)/iu.test(sql)) errors.push("PostgreSQL-only syntax found in SQLite import SQL");
if (/\b(?:event_dynasties|event_participants)\b/iu.test(sql)) errors.push("Deprecated event association table found");
if (/\bINSERT\s+INTO\s+\w+\s*\([^)]*\b(?:span|span_start_abs|span_end_abs)\b/iu.test(sql)) errors.push("Generated span column must not be inserted");

const cachePath = path.join(path.dirname(path.resolve(file)), "cache.json");
try {
  const cache = JSON.parse(readFileSync(cachePath, "utf8"));
  for (const dynasty of cache.dynasties ?? []) validateDynastyName(dynasty);
  for (const seamError of validateReignDateConfidenceSeams(cache.reigns ?? [])) errors.push(`Reign seam mismatch: ${seamError}`);
} catch (error) {
  errors.push(`Could not read adjacent cache.json for reign seam validation: ${error.message}`);
}

if (errors.length) {
  console.error("VALIDATION FAILED");
  for (const error of errors) console.error("  ✗", error);
  process.exit(1);
}
console.log("OK:", file);
