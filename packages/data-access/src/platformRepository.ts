import { Capacitor } from "@capacitor/core";
import { CapacitorSQLite, SQLiteConnection, type SQLiteDBConnection } from "@capacitor-community/sqlite";
import { HttpTimelineRepository } from "./httpRepository";
import { SqliteTimelineRepository } from "./sqliteRepository";
import { EraLensNative } from "./nativeContentPlugin";
import type { TimelineRepository } from "./repository";

const CONTENT_DATABASE = "eralens-content";
const sqlite = new SQLiteConnection(CapacitorSQLite);
let nativeRepository: SqliteTimelineRepository | null = null;
let nativeConnectionPromise: Promise<SQLiteDBConnection> | null = null;
let nativeQueryTail: Promise<void> = Promise.resolve();

function serializeNativeQuery<T>(operation: () => Promise<T>): Promise<T> {
  const result = nativeQueryTail.then(operation, operation);
  nativeQueryTail = result.then(() => undefined, () => undefined);
  return result;
}

async function nativeConnection(): Promise<SQLiteDBConnection> {
  if (!nativeConnectionPromise) {
    const opening = (async () => {
      // A WebView reload can leave a native connection that no longer has a
      // matching JS wrapper. Reconcile it before validating/replacing files.
      await sqlite.checkConnectionsConsistency().catch(() => ({ result: false }));
      await sqlite.copyFromAssets();
      await EraLensNative.prepareContentDatabase();
      const exists = await sqlite.isConnection(CONTENT_DATABASE, false);
      const database = exists.result
        ? await sqlite.retrieveConnection(CONTENT_DATABASE, false)
        : await sqlite.createConnection(CONTENT_DATABASE, false, "no-encryption", 1, false);
      if (!(await database.isDBOpen()).result) await database.open();
      return database;
    })();
    const recoverable = opening.catch((error) => {
      if (nativeConnectionPromise === recoverable) nativeConnectionPromise = null;
      throw error;
    });
    nativeConnectionPromise = recoverable;
  }
  return nativeConnectionPromise;
}

async function closeNativeConnection(): Promise<void> {
  const connection = nativeConnectionPromise;
  nativeConnectionPromise = null;
  if (!connection) return;
  try {
    const database = await connection;
    if ((await database.isDBOpen()).result) await database.close();
  } finally {
    const exists = await sqlite.isConnection(CONTENT_DATABASE, false).catch(() => ({ result: false }));
    if (exists.result) await sqlite.closeConnection(CONTENT_DATABASE, false);
  }
}

async function queryNativeDatabase(sql: string, values: unknown[]) {
  return serializeNativeQuery(async () => {
    try {
      const result = await (await nativeConnection()).query(sql, values as (string | number | null)[]);
      return { values: result.values as Record<string, unknown>[] | undefined };
    } catch (firstError) {
      await closeNativeConnection().catch(() => undefined);
      try {
        const result = await (await nativeConnection()).query(sql, values as (string | number | null)[]);
        return { values: result.values as Record<string, unknown>[] | undefined };
      } catch {
        throw firstError;
      }
    }
  });
}

export async function closePlatformRepository(): Promise<void> {
  const repository = nativeRepository;
  nativeRepository = null;
  if (repository) {
    await repository.close();
    return;
  }
  await serializeNativeQuery(closeNativeConnection);
}

export function createPlatformRepository(options: {
  apiBase?: string;
  source?: string;
  mockRepository?: TimelineRepository;
} = {}): TimelineRepository {
  if (options.source === "mock" && options.mockRepository) return options.mockRepository;
  if (options.source === "sqlite" || (options.source !== "http" && Capacitor.isNativePlatform())) {
    if (!nativeRepository) {
      nativeRepository = new SqliteTimelineRepository({
        async open() {
          await nativeConnection();
          return {
            query: (sql, values = []) => queryNativeDatabase(sql, values),
            close: () => serializeNativeQuery(closeNativeConnection),
          };
        },
      });
    }
    return nativeRepository;
  }
  return new HttpTimelineRepository(options.apiBase);
}
