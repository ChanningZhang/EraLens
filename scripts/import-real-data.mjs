#!/usr/bin/env node
/**
 * Load period packages from data/imports/{slug}/import.sql into PostgreSQL.
 * Used by pnpm db:import / pnpm db:setup. Does not use data/seed JSON.
 */
import { existsSync, readFileSync } from "node:fs";
import { spawnSync } from "node:child_process";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { discoverPackages } from "../data/imports/lib/discoverPackages.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(__dirname, "..");
const importDir = path.join(repoRoot, "data/imports");

const CONTAINER = process.env.ERALENS_PG_CONTAINER || "eralens-postgres";
const PGUSER = process.env.ERALENS_PG_USER || "eralens";
const PGDB = process.env.ERALENS_PG_DB || "eralens";

const TRUNCATE_SQL = `
TRUNCATE TABLE
  event_participants,
  event_dynasties,
  relations,
  events,
  location_mapping,
  locations,
  reigns,
  dynasties,
  dynasty_lane_groups,
  persons
RESTART IDENTITY CASCADE;
`;

function listPackages() {
  return discoverPackages(importDir, "import.sql")
    .map((slug) => {
      const sql = path.join(importDir, slug, "import.sql");
      const manifestPath = path.join(importDir, slug, "manifest.json");
      if (!existsSync(sql)) return null;
      const manifest = existsSync(manifestPath) ? JSON.parse(readFileSync(manifestPath, "utf8")) : {};
      return {
        slug,
        sql,
        startYear: manifest.window?.startYear ?? Number.MAX_SAFE_INTEGER,
        importPhase: manifest.importPhase ?? "normal",
        postImportOrder: manifest.postImportOrder ?? 0,
      };
    })
    .filter(Boolean)
    .sort((a, b) => a.startYear - b.startYear || a.slug.localeCompare(b.slug));
}

function dockerPsql(input) {
  return spawnSync(
    "docker",
    ["exec", "-i", CONTAINER, "psql", "-v", "ON_ERROR_STOP=1", "-U", PGUSER, "-d", PGDB, "-q"],
    { input, encoding: "utf8" },
  );
}

/** Split SQL on statement terminators outside quoted string literals. */
function sqlStatements(sql) {
  const statements = [];
  let start = 0;
  let inString = false;
  let inLineComment = false;
  let inBlockComment = false;
  for (let i = 0; i < sql.length; i += 1) {
    if (inLineComment) {
      if (sql[i] === "\n") inLineComment = false;
      continue;
    }
    if (inBlockComment) {
      if (sql[i] === "*" && sql[i + 1] === "/") {
        inBlockComment = false;
        i += 1;
      }
      continue;
    }
    if (sql[i] === "'") {
      if (inString && sql[i + 1] === "'") {
        i += 1;
      } else {
        inString = !inString;
      }
    } else if (!inString && sql[i] === "-" && sql[i + 1] === "-") {
      inLineComment = true;
      i += 1;
    } else if (!inString && sql[i] === "/" && sql[i + 1] === "*") {
      inBlockComment = true;
      i += 1;
    } else if (sql[i] === ";" && !inString) {
      statements.push(sql.slice(start, i + 1));
      start = i + 1;
    }
  }
  if (sql.slice(start).trim()) statements.push(sql.slice(start));
  return statements;
}

// These tables are cross-package associations or supplemental records. Their
// referenced entities may be owned by packages later in the import order, so
// applying them with the owning package can roll back that package's core rows
// and create a retry cycle (for example, capitals <-> reign capitals).
const DEFERRED_INSERT_TABLES = new Set([
  "location_mapping",
  "event_dynasties",
  "event_participants",
]);

function splitDeferredInserts(sql) {
  const deferred = [];
  const regular = sqlStatements(sql).filter((statement) => {
    const match = statement.match(/^(?:\s|--[^\n]*(?:\n|$))*INSERT\s+INTO\s+([a-z_]+)/i);
    if (!match || !DEFERRED_INSERT_TABLES.has(match[1].toLowerCase())) return true;
    deferred.push(statement);
    return false;
  });
  return { regular: regular.join("\n"), deferred };
}

function insertsInto(statement, table) {
  return new RegExp(`^(?:\\s|--[^\\n]*(?:\\n|$))*INSERT\\s+INTO\\s+${table}\\b`, "i").test(statement);
}

function preseedDynasties(packages) {
  const inserts = packages.flatMap(({ sql }) =>
    sqlStatements(readFileSync(sql, "utf8")).filter((statement) => insertsInto(statement, "dynasties")),
  );
  if (inserts.length === 0) return;

  const result = dockerPsql(`BEGIN;\n${inserts.join("\n")}\nCOMMIT;\n`);
  if (result.status !== 0) {
    fail("Failed to preseed dynasty rows", result.stderr || result.stdout);
  }
  console.log(`Preseeded ${inserts.length} dynasty rows for cross-package references.`);
}

function preseedDynastyGroups(packages) {
  const inserts = packages.flatMap(({ sql }) =>
    sqlStatements(readFileSync(sql, "utf8")).filter((statement) => insertsInto(statement, "dynasty_groups")),
  );
  if (inserts.length === 0) return;

  const result = dockerPsql(`BEGIN;\n${inserts.join("\n")}\nCOMMIT;\n`);
  if (result.status !== 0) {
    fail("Failed to preseed dynasty group rows", result.stderr || result.stdout);
  }
  console.log(`Preseeded ${inserts.length} dynasty group rows for cross-package references.`);
}

function preseedRows(packages, table, label) {
  const inserts = packages.flatMap(({ sql }) =>
    sqlStatements(readFileSync(sql, "utf8")).filter((statement) => insertsInto(statement, table)),
  );
  if (inserts.length === 0) return;

  const result = dockerPsql(`BEGIN;\n${inserts.join("\n")}\nCOMMIT;\n`);
  if (result.status !== 0) {
    fail(`Failed to preseed ${label} rows`, result.stderr || result.stdout);
  }
  console.log(`Preseeded ${inserts.length} ${label} rows for cross-package references.`);
}

function waitForPostgres() {
  const deadline = Date.now() + 60_000;
  while (Date.now() < deadline) {
    const ready = spawnSync("docker", ["exec", CONTAINER, "pg_isready", "-U", PGUSER, "-d", PGDB], {
      encoding: "utf8",
    });
    if (ready.status === 0) return;
    spawnSync("sleep", ["1"]);
  }
  throw new Error(`PostgreSQL in ${CONTAINER} is not ready. Run: pnpm db:up`);
}

function fail(message, detail) {
  console.error(message);
  if (detail) console.error(detail);
  process.exit(1);
}

function main() {
  const allPackages = listPackages();
  const packages = allPackages.filter((pkg) => pkg.importPhase !== "post");
  const postPackages = allPackages
    .filter((pkg) => pkg.importPhase === "post")
    .sort((a, b) => a.postImportOrder - b.postImportOrder || a.startYear - b.startYear || a.slug.localeCompare(b.slug));
  if (packages.length === 0) fail("No data/imports/{slug}/import.sql found");

  waitForPostgres();
  console.log(`Clearing tables, then importing ${packages.length} packages from data/imports ...`);

  const truncated = dockerPsql(TRUNCATE_SQL);
  if (truncated.status !== 0) fail("Failed to truncate tables", truncated.stderr || truncated.stdout);

  // Cross-package references must exist before package order starts. Dynasty
  // groups are the parent lookup for dynasty rows, which in turn are referenced
  // by events, capitals, and later periods. Persons and event locations are
  // also shared references used by period packages imported earlier than their
  // owner package (notably late-period relations and cross-period event data).
  preseedDynastyGroups(allPackages);
  preseedDynasties(allPackages);
  preseedRows(allPackages, "persons", "person");
  preseedRows(allPackages, "locations", "location");

  let remaining = packages;
  const deferredInserts = [];
  const maxPasses = packages.length;
  for (let pass = 1; remaining.length > 0; pass += 1) {
    if (pass > maxPasses) {
      fail(`Could not apply remaining packages: ${remaining.map((pkg) => pkg.slug).join(", ")}`);
    }

    const failed = [];
    for (const pkg of remaining) {
      process.stdout.write(`  [${pkg.slug}] `);
      const { regular, deferred } = splitDeferredInserts(readFileSync(pkg.sql, "utf8"));
      const result = dockerPsql(regular);
      if (result.status === 0) {
        console.log("ok");
        deferredInserts.push(...deferred);
      } else {
        console.log(pass === 1 ? "deferred" : "failed");
        failed.push({ ...pkg, error: result.stderr || result.stdout });
      }
    }

    if (failed.length === remaining.length) {
      for (const pkg of failed) {
        console.error(`\n=== ${pkg.slug} ===\n${pkg.error}`);
      }
      fail("No progress applying imports.");
    }
    remaining = failed;
  }

  for (const pkg of postPackages) {
    process.stdout.write(`  [${pkg.slug}] `);
    const { regular, deferred } = splitDeferredInserts(readFileSync(pkg.sql, "utf8"));
    const result = dockerPsql(regular);
    if (result.status !== 0) fail(`Failed to apply post-import package ${pkg.slug}`, result.stderr || result.stdout);
    deferredInserts.push(...deferred);
    console.log("ok (post-import)");
  }

  if (deferredInserts.length > 0) {
    const result = dockerPsql(`BEGIN;\n${deferredInserts.join("\n")}\nCOMMIT;\n`);
    if (result.status !== 0) {
      fail("Failed to apply deferred cross-package links", result.stderr || result.stdout);
    }
    console.log(`Applied ${deferredInserts.length} deferred cross-package link rows.`);
  }

  console.log("Done.");
}

try {
  main();
} catch (error) {
  fail(error instanceof Error ? error.message : String(error));
}
