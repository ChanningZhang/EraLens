#!/usr/bin/env node
/**
 * Load period packages from data/imports/{slug}/import.sql into PostgreSQL.
 * Used by pnpm db:import / pnpm db:setup. Does not use data/seed JSON.
 */
import { existsSync, readdirSync, readFileSync } from "node:fs";
import { spawnSync } from "node:child_process";
import path from "node:path";
import { fileURLToPath } from "node:url";

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
  reigns,
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
  const packages = listPackages();
  if (packages.length === 0) fail("No data/imports/{slug}/import.sql found");

  waitForPostgres();
  console.log(`Clearing tables, then importing ${packages.length} packages from data/imports ...`);

  const truncated = dockerPsql(TRUNCATE_SQL);
  if (truncated.status !== 0) fail("Failed to truncate tables", truncated.stderr || truncated.stdout);

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

  console.log("Done.");
}

try {
  main();
} catch (error) {
  fail(error instanceof Error ? error.message : String(error));
}
