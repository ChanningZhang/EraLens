import contentVersions from "../../../../data/mobile/versions.json";
import { describe, expect, it } from "vitest";
import { SqliteTimelineRepository, type SqliteDatabase, type SqliteDatabaseProvider } from "@eralens/data-access";

function emptyDatabase(): SqliteDatabase {
  return {
    async query(sql) {
      if (sql.includes("content_metadata")) {
        return {
          values: [
            { key: "schema_version", value: String(contentVersions.schemaVersion) },
            { key: "contract_version", value: String(contentVersions.contractVersion) },
          ],
        };
      }
      return { values: [] };
    },
    async close() {},
  };
}

describe("SqliteTimelineRepository recovery", () => {
  it.each([[contentVersions.schemaVersion - 1, contentVersions.contractVersion], [contentVersions.schemaVersion, contentVersions.contractVersion - 1]])("rejects schema %i / contract %i", async (schema, contract) => {
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

describe("SQLite person detail dynasty context", () => {
  it("keeps a non-ruler's dynasty in the detail subtitle", async () => {
    const repository = new SqliteTimelineRepository({
      async open() {
        return {
          async query(sql) {
            if (sql.includes("content_metadata")) {
              return { values: [
                { key: "schema_version", value: String(contentVersions.schemaVersion) },
                { key: "contract_version", value: String(contentVersions.contractVersion) },
              ] };
            }
            if (sql.includes("WITH request(person_id")) {
              expect(sql).toContain("'dynasty_id', p.dynasty_id");
              return { values: [{
                person_json: JSON.stringify({
                  id: "du-fu", name: "杜甫", dynasty_id: "tang", roles: "[\"诗人\"]",
                  alt_names: "[]", links: "[]", search_terms: "[\"杜甫\"]",
                }),
                reign_json: null,
                reign_count: 0,
              }] };
            }
            if (sql === "SELECT * FROM persons") {
              return { values: [{
                id: "du-fu", name: "杜甫", dynasty_id: "tang", roles: "[\"诗人\"]",
                alt_names: "[]", links: "[]", search_terms: "[\"杜甫\"]",
              }] };
            }
            if (sql.includes("FROM dynasties")) {
              return { values: [{
                id: "tang", name: "唐", alt_names: "[\"唐\"]", scope: "cn", region: "east_asia",
                start_year: 618, start_month: 1, start_day: null, start_confidence: "year", start_abs: 7421,
                end_year: 907, end_month: 12, end_day: null, end_confidence: "year", end_abs: 10895,
                color_token: "ochre", parent_id: null, group_id: null, note: null,
              }] };
            }
            return { values: [] };
          },
          async close() {},
        };
      },
    });

    await expect(repository.getEntity({ type: "person", id: "du-fu" })).resolves.toMatchObject({
      title: "杜甫",
      subtitle: expect.stringContaining("唐"),
      dynastyId: "tang",
    });
  });
});
