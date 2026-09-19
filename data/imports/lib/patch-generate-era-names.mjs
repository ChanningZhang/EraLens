#!/usr/bin/env node
/**
 * Remove legacy era_names SQL from period generate.mjs files.
 */
import { readFileSync, writeFileSync } from "node:fs";

const files = [
  "data/imports/nanbei-chao/generate.mjs",
  "data/imports/sui-tang-wudai-song/generate.mjs",
  "data/imports/yuan-ming-qing/generate.mjs",
  "data/imports/qin-han/generate.mjs",
  "data/imports/jin-sixteen/generate.mjs",
  "data/imports/song-liao-jin/generate.mjs",
  "data/imports/xixia/generate.mjs",
];

for (const file of files) {
  let s = readFileSync(file, "utf8");
  const orig = s;

  if (!s.includes("mergeAppellationsIntoPersons")) {
    s = s.replace(
      /from "\.\.\/lib\/sqlHelpers\.mjs";/,
      (m) =>
        m.replace(
          '"../lib/sqlHelpers.mjs";',
          '"../lib/sqlHelpers.mjs";',
        ),
    );
    if (s.includes('formatAppellationCsv, normalizeYearPrecisionAt, personSql')) {
      s = s.replace(
        "formatAppellationCsv, normalizeYearPrecisionAt, personSql",
        "formatAppellationCsv, mergeAppellationsIntoPersons, normalizeYearPrecisionAt, personSql",
      );
    } else if (s.includes("formatAppellationCsv, personSql")) {
      s = s.replace(
        "formatAppellationCsv, personSql",
        "formatAppellationCsv, mergeAppellationsIntoPersons, personSql",
      );
    } else if (s.includes("{ dynastySql, normalizeYearPrecisionAt, personSql }")) {
      s = s.replace(
        "{ dynastySql, normalizeYearPrecisionAt, personSql }",
        "{ dynastySql, formatAppellationCsv, mergeAppellationsIntoPersons, normalizeYearPrecisionAt, personSql }",
      );
    } else if (s.includes("dynastySql, normalizeYearPrecisionAt, personSql")) {
      s = s.replace(
        "dynastySql, normalizeYearPrecisionAt, personSql",
        "dynastySql, formatAppellationCsv, mergeAppellationsIntoPersons, normalizeYearPrecisionAt, personSql",
      );
    }
  }

  s = s.replace(/\nfunction eraNameSql\([\s\S]*?\n\}\n/g, "\n");

  s = s.replace(
    /\nconst reignsWithEras = importReigns\.filter\(\(r\) => r\.eraNames\.length > 0\);\nconst eraDeleteSql = [\s\S]*?;\nconst eraInsertSql = [\s\S]*?;\n/g,
    "\n",
  );

  s = s.replace(
    /,\s*""\s*,\s*"-- era_names"\s*,\s*\.\.\.eraDeleteSql\s*,\s*\.\.\.eraInsertSql/g,
    "",
  );
  s = s.replace(/\n\s*"-- era_names",\s*\.\.\.eraDeleteSql,\s*\.\.\.eraInsertSql,?\n/g, "\n");
  s = s.replace(/\n\s*"", "-- era_names", \.\.\.eraDeleteSql, \.\.\.eraInsertSql,\n/g, "\n");

  s = s.replace(
    /DELETE FROM era_names WHERE reign_id[^;]+;\n/g,
    "",
  );

  const mergeBlock = `
({ persons: importPersons, reigns: importReigns } = mergeAppellationsIntoPersons(importPersons, importReigns));`;

  if (!s.includes("mergeAppellationsIntoPersons(importPersons")) {
    s = s.replace(
      /(const \{ persons: importPersons, reigns: importReigns \} = finalizeImportReigns\([\s\S]*?\);)\n/,
      `$1${mergeBlock}\n`,
    );
  }

  if (s !== orig) {
    writeFileSync(file, s);
    console.log("patched", file);
  }
}
