#!/usr/bin/env node
/**
 * Load period packages from data/imports/{slug}/import.sql into PostgreSQL.
 * Used by pnpm db:import / pnpm db:setup. Does not use data/seed JSON.
 */
import { existsSync, readdirSync, readFileSync } from "node:fs";
import { spawnSync } from "node:child_process";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { PERSON_TITLE_SELECTIONS } from "../data/imports/lib/personTitleSelections.mjs";

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
  event_locations,
  reigns,
  dynasty_capitals,
  dynasties,
  dynasty_lane_groups,
  persons
RESTART IDENTITY CASCADE;
`;

function listPackages() {
  return readdirSync(importDir, { withFileTypes: true })
    .filter((entry) => entry.isDirectory())
    .map((entry) => {
      const sql = path.join(importDir, entry.name, "import.sql");
      const manifestPath = path.join(importDir, entry.name, "manifest.json");
      if (!existsSync(sql)) return null;
      const manifest = existsSync(manifestPath) ? JSON.parse(readFileSync(manifestPath, "utf8")) : {};
      return {
        slug: entry.name,
        sql,
        startYear: manifest.window?.startYear ?? Number.MAX_SAFE_INTEGER,
        importPhase: manifest.importPhase ?? "normal",
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
  for (let i = 0; i < sql.length; i += 1) {
    if (sql[i] === "'") {
      if (inString && sql[i + 1] === "'") {
        i += 1;
      } else {
        inString = !inString;
      }
    } else if (sql[i] === ";" && !inString) {
      statements.push(sql.slice(start, i + 1));
      start = i + 1;
    }
  }
  if (sql.slice(start).trim()) statements.push(sql.slice(start));
  return statements;
}

function preseedDynasties(packages) {
  const inserts = packages.flatMap(({ sql }) =>
    sqlStatements(readFileSync(sql, "utf8")).filter((statement) =>
      /^\s*INSERT\s+INTO\s+dynasties\b/i.test(statement),
    ),
  );
  if (inserts.length === 0) return;

  const result = dockerPsql(`BEGIN;\n${inserts.join("\n")}\nCOMMIT;\n`);
  if (result.status !== 0) {
    fail("Failed to preseed dynasty rows", result.stderr || result.stdout);
  }
  console.log(`Preseeded ${inserts.length} dynasty rows for cross-package references.`);
}

function sqlString(value) {
  return `'${String(value).replaceAll("'", "''")}'`;
}

function updatePersonTitles() {
  const selectedTitles = Object.entries(PERSON_TITLE_SELECTIONS)
    .map(([personId, title]) => `WHEN p.id = ${sqlString(personId)} THEN ${sqlString(title)}`)
    .join("\n    ");
  const selectedIds = Object.keys(PERSON_TITLE_SELECTIONS).map(sqlString).join(", ");
  const sql = `
UPDATE persons AS p
SET title = CASE
  WHEN p.id = 'system-missing-ruler' THEN '史料缺'
  ${selectedTitles}
  ELSE (
    SELECT r.title
    FROM reigns AS r
    WHERE r.person_id = p.id
    ORDER BY r.start_abs DESC, r.end_abs DESC, r.id DESC
    LIMIT 1
  )
END
WHERE p.id = 'system-missing-ruler'
   OR p.id IN (${selectedIds})
   OR EXISTS (SELECT 1 FROM reigns AS r WHERE r.person_id = p.id);
`;
  const result = dockerPsql(sql);
  if (result.status !== 0) fail("Failed to populate persons.title", result.stderr || result.stdout);
  console.log("Updated persons.title from the latest reign title and selected multi-reign titles.");
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
  const postPackages = allPackages.filter((pkg) => pkg.importPhase === "post");
  if (packages.length === 0) fail("No data/imports/{slug}/import.sql found");

  waitForPostgres();
  console.log(`Clearing tables, then importing ${packages.length} packages from data/imports ...`);

  const truncated = dockerPsql(TRUNCATE_SQL);
  if (truncated.status !== 0) fail("Failed to truncate tables", truncated.stderr || truncated.stdout);

  // Some event and capital packages refer to dynasties owned by later period
  // packages. Seed the shared lookup table first so deferred package imports
  // can resolve those foreign keys without changing package ownership/order.
  preseedDynasties(allPackages);

  let remaining = packages;
  const maxPasses = packages.length;
  for (let pass = 1; remaining.length > 0; pass += 1) {
    if (pass > maxPasses) {
      fail(`Could not apply remaining packages: ${remaining.map((pkg) => pkg.slug).join(", ")}`);
    }

    const failed = [];
    for (const pkg of remaining) {
      process.stdout.write(`  [${pkg.slug}] `);
      const result = dockerPsql(readFileSync(pkg.sql));
      if (result.status === 0) {
        console.log("ok");
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
    const result = dockerPsql(readFileSync(pkg.sql));
    if (result.status !== 0) fail(`Failed to apply post-import package ${pkg.slug}`, result.stderr || result.stdout);
    console.log("ok (post-import)");
  }

  updatePersonTitles();

  console.log("Done.");
}

try {
  main();
} catch (error) {
  fail(error instanceof Error ? error.message : String(error));
}
