import { DatabaseSync } from "node:sqlite";
import { mkdir, readFile } from "node:fs/promises";
import path from "node:path";
import { statePath } from "../src/db.js";

type Setting = { key: string; value: string; updated_at?: string };
const input = process.argv.find(argument => argument.startsWith("--input="))?.slice("--input=".length);
if (!input) throw new Error("Usage: pnpm settings:import -- --input=/path/to/sys-config.json");
const parsed: unknown = JSON.parse(await readFile(input, "utf8"));
const rows: Setting[] = Array.isArray(parsed)
  ? parsed as Setting[]
  : parsed && typeof parsed === "object"
    ? Object.entries(parsed).map(([key, value]) => ({ key, value: String(value) }))
    : (() => { throw new Error("Settings snapshot must be an object or an array of {key,value} rows"); })();
for (const row of rows) {
  if (!row || typeof row.key !== "string" || typeof row.value !== "string") throw new Error("Every setting must have string key and value fields");
}
await mkdir(path.dirname(statePath), { recursive: true });
const db = new DatabaseSync(statePath);
try {
  db.exec("PRAGMA journal_mode=WAL; PRAGMA synchronous=NORMAL; PRAGMA busy_timeout=5000;");
  db.exec("CREATE TABLE IF NOT EXISTS sys_config(key TEXT PRIMARY KEY,value TEXT NOT NULL,updated_at TEXT NOT NULL);");
  const insert = db.prepare("INSERT INTO sys_config(key,value,updated_at) VALUES(?,?,?) ON CONFLICT(key) DO UPDATE SET value=excluded.value,updated_at=excluded.updated_at");
  db.exec("BEGIN IMMEDIATE;");
  try {
    for (const row of rows) insert.run(row.key, row.value, row.updated_at ?? new Date().toISOString());
    db.exec("PRAGMA user_version=1; COMMIT;");
  } catch (error) {
    db.exec("ROLLBACK;");
    throw error;
  }
  console.log(`Imported ${rows.length} settings into ${statePath}`);
} finally {
  db.close();
}
