import { describe, expect, it } from "vitest";
import { SqliteTimelineRepository, type SqliteDatabase, type SqliteDatabaseProvider } from "@eralens/data-access";

function emptyDatabase(): SqliteDatabase {
  return {
    async query(sql) {
      if (sql.includes("content_metadata")) {
        return {
          values: [
            { key: "schema_version", value: "6" },
            { key: "contract_version", value: "7" },
          ],
        };
      }
      return { values: [] };
    },
    async close() {},
  };
}

describe("SqliteTimelineRepository recovery", () => {
  it.each([[5, 7], [6, 6]])("rejects schema %i / contract %i", async (schema, contract) => {
    const repository = new SqliteTimelineRepository({
      async open() {
        return {
          async query() {
            return { values: [
              { key: "schema_version", value: String(schema) },
              { key: "contract_version", value: String(contract) },
            ] };
          },
          async close() {},
        };
      },
    });
    await expect(repository.getBounds()).rejects.toThrow("version is not supported");
  });

  it("opens the database again after a transient initialization failure", async () => {
    let opens = 0;
    const provider: SqliteDatabaseProvider = {
      async open() {
        opens += 1;
        if (opens === 1) throw new Error("transient native open failure");
        return emptyDatabase();
      },
    };
    const repository = new SqliteTimelineRepository(provider);

    await expect(repository.getTimeline({ fromAbs: 0, toAbs: 12, lod: "month" })).rejects.toThrow(
      "transient native open failure",
    );
    await expect(repository.getTimeline({ fromAbs: 0, toAbs: 12, lod: "month" })).resolves.toMatchObject({
      dynasties: [],
      reigns: [],
      events: [],
      persons: [],
    });
    expect(opens).toBe(2);
  });

  it("does not open SQLite for a timeline query that was already cancelled", async () => {
    let opens = 0;
    const provider: SqliteDatabaseProvider = {
      async open() {
        opens += 1;
        return emptyDatabase();
      },
    };
    const repository = new SqliteTimelineRepository(provider);
    const controller = new AbortController();
    controller.abort();

    await expect(repository.getTimeline({
      fromAbs: 0,
      toAbs: 12,
      lod: "month",
      signal: controller.signal,
    })).rejects.toBeDefined();
    expect(opens).toBe(0);
  });
});
