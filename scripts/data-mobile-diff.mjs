import { DatabaseSync } from "node:sqlite";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const args = new Map(process.argv.slice(2).map((arg) => {
  const i = arg.indexOf("=");
  return i < 0 ? [arg, ""] : [arg.slice(0, i), arg.slice(i + 1)];
}));
const basePath = args.get("--base");
const candidatePath = args.get("--candidate") ?? path.join(root, "data/mobile/eralens-content.sqlite");
if (!basePath) throw new Error("Usage: pnpm data:mobile:diff -- --base=<previous.sqlite> [--candidate=<candidate.sqlite>]");
const base = new DatabaseSync(path.resolve(basePath), { readOnly: true });
const candidate = new DatabaseSync(path.resolve(candidatePath), { readOnly: true });
const tables = ["persons", "dynasty_groups", "dynasties", "reigns", "events", "event_locations", "event_dynasties", "event_participants", "relations", "dynasty_lane_groups", "dynasty_capitals", "reign_capitals", "search_entries"];
const primaryKeys = {
  persons: ["id"], dynasty_groups: ["id"], dynasties: ["id"], reigns: ["id"], events: ["id"],
  event_locations: ["id"], event_dynasties: ["event_id", "dynasty_id"],
  event_participants: ["event_id", "person_id"], relations: ["id"], dynasty_lane_groups: ["id"],
  dynasty_capitals: ["id"], reign_capitals: ["reign_id", "capital_id"],
  search_entries: ["entity_type", "entity_id", "normalized_term", "term_kind"],
};
const keyOf = (row, keys) => JSON.stringify(keys.map((key) => row[key]));
const stable = (v) => Array.isArray(v) ? `[${v.map(stable).join(",")}]` : v && typeof v === "object" ? `{${Object.keys(v).sort().map((k) => `${JSON.stringify(k)}:${stable(v[k])}`).join(",")}}` : JSON.stringify(v);
const count = (db, table) => Number(db.prepare(`SELECT COUNT(*) AS count FROM "${table}"`).get().count);
try {
  const report = { base: path.resolve(basePath), candidate: path.resolve(candidatePath), tables: {}, metadata: {} };
  for (const db of [base, candidate]) {
    const m = Object.fromEntries(db.prepare("SELECT key, value FROM content_metadata").all().map((row) => [row.key, JSON.parse(row.value)]));
    report.metadata[db === base ? "base" : "candidate"] = {
      datasetVersion: m.dataset_version, schemaVersion: m.schema_version,
      contractVersion: m.contract_version, sourceChecksum: m.source_checksum,
    };
  }
  for (const table of tables) {
    const read = (db) => new Map(db.prepare(`SELECT * FROM "${table}" ORDER BY 1`).all().map((row) => [keyOf(row, primaryKeys[table]), stable(row)]));
    const oldRows = read(base), newRows = read(candidate);
    let added = 0, removed = 0, changed = 0;
    for (const [key, value] of newRows) {
      if (!oldRows.has(key)) added++;
      else if (oldRows.get(key) !== value) changed++;
    }
    for (const key of oldRows.keys()) if (!newRows.has(key)) removed++;
    report.tables[table] = { baseCount: count(base, table), candidateCount: count(candidate, table), added, updated: changed, removed };
  }
  console.log(JSON.stringify(report, null, 2));
} finally {
  base.close(); candidate.close();
}
