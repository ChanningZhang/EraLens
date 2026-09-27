import { Capacitor } from "@capacitor/core";
import { CapacitorSQLite, SQLiteConnection } from "@capacitor-community/sqlite";
import { HttpTimelineRepository } from "./httpRepository";
import { SqliteTimelineRepository } from "./sqliteRepository";
import type { TimelineRepository } from "./repository";

const CONTENT_DATABASE = "eralens-content";
const sqlite = new SQLiteConnection(CapacitorSQLite);
let nativeRepository: SqliteTimelineRepository | null = null;

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
          await sqlite.copyFromAssets();
          const database = await sqlite.createConnection(CONTENT_DATABASE, false, "no-encryption", 1, false);
          await database.open();
          return {
            query: async (sql, values = []) => {
              const result = await database.query(sql, values as (string | number | null)[]);
              return { values: result.values as Record<string, unknown>[] | undefined };
            },
            close: async () => {
              await database.close();
              await sqlite.closeConnection(CONTENT_DATABASE, false);
            },
          };
        },
      });
    }
    return nativeRepository;
  }
  return new HttpTimelineRepository(options.apiBase);
}
