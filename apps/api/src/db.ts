import { DatabaseSync } from "node:sqlite";
import { mkdir } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { SqliteTimelineRepository } from "@eralens/data-access/sqlite";
import type { SettingsStore, SqliteDatabase, SqliteDatabaseProvider } from "@eralens/data-access/repository";

const projectRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..");
export const contentPath = path.resolve(process.env.CONTENT_DB_PATH ?? path.join(projectRoot, "data/mobile/eralens-content.sqlite"));
export const statePath = path.resolve(process.env.STATE_DB_PATH ?? path.join(projectRoot, "data/mobile/eralens-state.sqlite"));

export class NodeSqliteProvider implements SqliteDatabaseProvider {
  private db: DatabaseSync | null = null;
  constructor(private readonly filename: string, private readonly readOnly = false) {}

  async open(): Promise<SqliteDatabase> {
    if (!this.db) {
      this.db = new DatabaseSync(this.filename, { readOnly: this.readOnly });
      this.db.exec("PRAGMA foreign_keys = ON; PRAGMA busy_timeout = 5000;");
      if (this.readOnly) this.db.exec("PRAGMA query_only = ON;");
    }
    const db = this.db;
    return {
      async query(sql, values = []) {
        return { values: db.prepare(sql).all(...values as (null | number | bigint | string | Uint8Array)[]) as Record<string, unknown>[] };
      },
      async close() { /* The provider owns its connection and closes it at shutdown. */ },
    };
  }

  close(): void {
    this.db?.close();
    this.db = null;
  }
}

export class SqliteSettingsStore implements SettingsStore {
  private readonly db: DatabaseSync;

  private constructor(filename: string) {
    this.db = new DatabaseSync(filename);
    this.db.exec("PRAGMA journal_mode = WAL; PRAGMA synchronous = NORMAL; PRAGMA busy_timeout = 5000;");
    const version = Number((this.db.prepare("PRAGMA user_version").get() as { user_version: number }).user_version);
    if (version > 1) throw new Error(`Unsupported settings database version ${version}`);
    if (version === 0) {
      this.db.exec(`BEGIN IMMEDIATE;
        CREATE TABLE IF NOT EXISTS sys_config (
          key TEXT PRIMARY KEY,
          value TEXT NOT NULL,
          updated_at TEXT NOT NULL
        );
        PRAGMA user_version = 1;
        COMMIT;`);
    }
  }

  static async open(filename: string): Promise<SqliteSettingsStore> {
    await mkdir(path.dirname(filename), { recursive: true });
    return new SqliteSettingsStore(filename);
  }

  async get(key: string): Promise<string | null> {
    const row = this.db.prepare("SELECT value FROM sys_config WHERE key = ?").get(key) as { value: string } | undefined;
    return row?.value ?? null;
  }

  async set(key: string, value: string): Promise<void> {
    this.db.prepare("INSERT INTO sys_config(key,value,updated_at) VALUES(?,?,?) ON CONFLICT(key) DO UPDATE SET value=excluded.value,updated_at=excluded.updated_at")
      .run(key, value, new Date().toISOString());
  }

  close(): void { this.db.close(); }
}

export async function openApiDatabase() {
  const contentProvider = new NodeSqliteProvider(contentPath, true);
  const settings = await SqliteSettingsStore.open(statePath);
  const repository = new SqliteTimelineRepository(contentProvider, settings);
  const getContentInfo = async () => {
    const metadataRows = await (await contentProvider.open()).query("SELECT key,value FROM content_metadata");
    const metadata = new Map((metadataRows.values ?? []).map(row => [String(row.key), JSON.parse(String(row.value)) as unknown]));
    return {
    datasetVersion: String(metadata.get("dataset_version") ?? "unknown"),
    schemaVersion: Number(metadata.get("schema_version") ?? 0),
    contractVersion: Number(metadata.get("contract_version") ?? 0),
    };
  };
  const [bounds, contentInfo] = await Promise.all([repository.getBounds(), getContentInfo()]);
  if (!contentInfo.schemaVersion || !contentInfo.contractVersion) throw new Error(`Invalid SQLite content metadata at ${contentPath}`);
  return { repository, contentProvider, settings, getContentInfo, bounds };
}
