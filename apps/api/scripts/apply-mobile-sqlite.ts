import { DatabaseSync } from "node:sqlite";
import { readFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..");
const contentPath = path.resolve(process.env.CONTENT_DB_PATH ?? path.join(root, "data/mobile/eralens-content.sqlite"));
const sqlPath = `${contentPath}.refresh.sql`;
const versions = JSON.parse(await readFile(path.join(root, "data/mobile/versions.json"), "utf8")) as {
  schemaVersion: number;
  contractVersion: number;
};
const sql = await readFile(sqlPath, "utf8");
const db = new DatabaseSync(contentPath);

try {
  db.exec("PRAGMA foreign_keys = ON; PRAGMA busy_timeout = 15000;");
  const metadata = new Map((db.prepare("SELECT key, value FROM content_metadata").all() as { key: string; value: string }[])
    .map(row => [row.key, JSON.parse(row.value) as unknown]));
  const schemaVersion = Number(metadata.get("schema_version") ?? 0);
  const contractVersion = Number(metadata.get("contract_version") ?? 0);
  if (schemaVersion !== versions.schemaVersion || contractVersion !== versions.contractVersion) {
    throw new Error(
      `Existing content database is schema ${schemaVersion}/contract ${contractVersion}; ` +
      `SQL refresh requires ${versions.schemaVersion}/${versions.contractVersion}. Use pnpm data:build for a schema change.`,
    );
  }

  db.exec("BEGIN IMMEDIATE;");
  try {
    db.exec(sql);
    const foreignErrors = db.prepare("PRAGMA foreign_key_check").all();
    if (foreignErrors.length) throw new Error(`foreign_key_check failed (${foreignErrors.length})`);
    const integrity = (db.prepare("PRAGMA integrity_check").get() as { integrity_check: string }).integrity_check;
    if (integrity !== "ok") throw new Error(`integrity_check failed: ${integrity}`);
    db.exec("COMMIT;");
  } catch (error) {
    db.exec("ROLLBACK;");
    throw error;
  }

  const applied = new Map((db.prepare("SELECT key, value FROM content_metadata").all() as { key: string; value: string }[])
    .map(row => [row.key, JSON.parse(row.value) as unknown]));
  console.log(JSON.stringify({
    status: "ok",
    contentPath,
    datasetVersion: applied.get("dataset_version"),
    schemaVersion: applied.get("schema_version"),
    contractVersion: applied.get("contract_version"),
  }, null, 2));
} finally {
  db.close();
}
