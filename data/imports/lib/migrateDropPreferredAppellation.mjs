#!/usr/bin/env node
/**
 * One-shot migration: merge preferred_appellation into title and strip the column
 * from baked import.sql files and chunqiu-zhanguo/rulers.mjs.
 */
import { readFileSync, writeFileSync, readdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

function parseSqlValue(raw) {
  const trimmed = raw.trim();
  if (trimmed === "NULL") return null;
  if (trimmed.startsWith("'")) {
    let out = "";
    for (let i = 1; i < trimmed.length; i++) {
      if (trimmed[i] === "'" && trimmed[i + 1] === "'") {
        out += "'";
        i++;
        continue;
      }
      if (trimmed[i] === "'") break;
      out += trimmed[i];
    }
    return out;
  }
  if (trimmed.endsWith("::jsonb")) {
    try {
      return JSON.parse(trimmed.slice(0, -7).replace(/^'|'$|''/g, (m, i, s) => (m === "''" ? "'" : i === 0 || i === s.length - 1 ? "" : m)));
    } catch {
      const inner = trimmed.match(/^'(.+)'::jsonb$/);
      if (inner) {
        try {
          return JSON.parse(inner[1].replace(/''/g, "'"));
        } catch {
          return null;
        }
      }
    }
  }
  return trimmed;
}

function splitSqlValues(valuesPart) {
  const values = [];
  let current = "";
  let inQuote = false;
  for (let i = 0; i < valuesPart.length; i++) {
    const ch = valuesPart[i];
    if (ch === "'" && valuesPart[i + 1] === "'") {
      current += "''";
      i++;
      continue;
    }
    if (ch === "'") {
      inQuote = !inQuote;
      current += ch;
      continue;
    }
    if (ch === "," && !inQuote) {
      values.push(current.trim());
      current = "";
      continue;
    }
    current += ch;
  }
  if (current.trim()) values.push(current.trim());
  return values;
}

function sqlQuote(value) {
  return `'${String(value).replace(/'/g, "''")}'`;
}

function migrateReignInsert(sql) {
  const headerRe =
    /INSERT INTO reigns\s*\(([^)]+)\)\s*VALUES\s*\(([\s\S]*?)\)\s*(ON CONFLICT[\s\S]*?;|;)/gi;
  return sql.replace(headerRe, (block, colsRaw, valuesRaw, tail) => {
    const cols = colsRaw.split(",").map((c) => c.trim());
    const prefIdx = cols.indexOf("preferred_appellation");
    if (prefIdx < 0) return block;

    const values = splitSqlValues(valuesRaw);
    if (values.length !== cols.length) return block;

    const titleIdx = cols.indexOf("title");
    const preferred = parseSqlValue(values[prefIdx]);
    const preferredName =
      preferred && typeof preferred === "object" && preferred.name
        ? preferred.name
        : null;
    if (preferredName && preferredName !== parseSqlValue(values[titleIdx])) {
      values[titleIdx] = sqlQuote(preferredName);
    }

    const nextCols = cols.filter((_, i) => i !== prefIdx);
    const nextValues = values.filter((_, i) => i !== prefIdx);
    const nextTail = tail.replace(
      /,?\s*preferred_appellation\s*=\s*EXCLUDED\.preferred_appellation/g,
      "",
    );
    return `INSERT INTO reigns (${nextCols.join(", ")}) VALUES (${nextValues.join(", ")})${nextTail}`;
  });
}

function migrateRulersMjs(content) {
  return content.replace(
    /"title": "((?:\\.|[^"\\])*)"(?:,\s*"personName": "((?:\\.|[^"\\])*)")?,\s*"posthumousName": ([^,]+),\s*"preferredAppellation": \{\s*"kind": "regnal",\s*"name": "((?:\\.|[^"\\])*)"\s*\}/g,
    (_m, _title, personNamePart, posthumousName, prefName) => {
      const personSegment = personNamePart ? `, "personName": "${personNamePart}"` : "";
      return `"title": "${prefName}"${personSegment}, "posthumousName": ${posthumousName}`;
    },
  );
}

function walkImportSql(dir, out = []) {
  for (const ent of readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, ent.name);
    if (ent.isDirectory()) walkImportSql(p, out);
    else if (ent.name === "import.sql") out.push(p);
  }
  return out;
}

let changed = 0;
for (const file of walkImportSql(root)) {
  const before = readFileSync(file, "utf8");
  const after = migrateReignInsert(before);
  if (after !== before) {
    writeFileSync(file, after);
    changed++;
    console.log("updated", path.relative(root, file));
  }
}

const rulersPath = path.join(root, "chunqiu-zhanguo", "rulers.mjs");
const rulersBefore = readFileSync(rulersPath, "utf8");
const rulersAfter = migrateRulersMjs(rulersBefore);
if (rulersAfter !== rulersBefore) {
  writeFileSync(rulersPath, rulersAfter);
  console.log("updated chunqiu-zhanguo/rulers.mjs");
}

console.log(`Done. ${changed} import.sql file(s) updated.`);
