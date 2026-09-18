#!/usr/bin/env node
import { readFileSync } from "node:fs";

const file = process.argv[2];
if (!file) {
  console.error("Usage: node validate-import.mjs <path/to/import.sql>");
  process.exit(1);
}

const sql = readFileSync(file, "utf8");
const errors = [];
const warnings = [];

if (!/\bBEGIN\s*;/i.test(sql)) errors.push("Missing BEGIN;");
if (!/\bCOMMIT\s*;/i.test(sql)) errors.push("Missing COMMIT;");

// Only inspect the column list, not VALUES — time_mode 'span' is valid.
const forbidden = [
  /\bINSERT\s+INTO\s+dynasty_groups\s*\([^)]*\bspan\b/is,
  /\bINSERT\s+INTO\s+dynasties\s*\([^)]*\bspan\b/is,
  /\bINSERT\s+INTO\s+reigns\s*\([^)]*\bspan\b/is,
  /\bINSERT\s+INTO\s+events\s*\([^)]*\bspan_start_abs\b/is,
  /\bINSERT\s+INTO\s+events\s*\([^)]*\bspan_end_abs\b/is,
  /\bINSERT\s+INTO\s+events\s*\([^)]*\bspan\b/is,
];
for (const re of forbidden) {
  if (re.test(sql)) errors.push(`Forbidden generated column in INSERT: ${re}`);
}

const tableOrder = [
  "persons",
  "dynasty_groups",
  "dynasties",
  "reigns",
  "era_names",
  "events",
  "event_dynasties",
  "event_participants",
  "relations",
];

const positions = tableOrder.map((table) => {
  const re = new RegExp(`\\bINSERT\\s+INTO\\s+${table}\\b`, "i");
  const match = re.exec(sql);
  return { table, index: match ? match.index : -1 };
});

const seen = positions.filter((p) => p.index >= 0);
for (let i = 1; i < seen.length; i++) {
  if (seen[i].index < seen[i - 1].index) {
    errors.push(
      `Insert order violation: ${seen[i].table} appears before ${seen[i - 1].table}`,
    );
  }
}

for (const table of ["persons", "dynasties", "reigns", "events"]) {
  const re = new RegExp(`\\bINSERT\\s+INTO\\s+${table}\\b`, "i");
  if (!re.test(sql)) warnings.push(`No INSERT into ${table}`);
}

if (/\bINSERT\s+INTO\s+events\b/i.test(sql) && !/\btime_mode\b/i.test(sql)) {
  warnings.push("events INSERT has no time_mode; DB default is point");
}

const absFields = sql.match(/\b(start_abs|end_abs|at_abs)\s*,\s*(-?\d+)/gi) ?? [];
// Heuristic: flag obviously unquoted negative in wrong context — light check only

if (errors.length) {
  console.error("VALIDATION FAILED");
  for (const e of errors) console.error("  ✗", e);
  if (warnings.length) {
    console.warn("Warnings:");
    for (const w of warnings) console.warn("  !", w);
  }
  process.exit(1);
}

console.log("OK:", file);
if (warnings.length) {
  for (const w of warnings) console.warn("  !", w);
}
