import { createHash } from "node:crypto";
import { DatabaseSync } from "node:sqlite";
import { execFileSync } from "node:child_process";
import { mkdir, readFile, rename, rm } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  DynastyCapitalSchema,
  DynastyGroupSchema,
  DynastyLaneGroupSchema,
  DynastySchema,
  EventSchema,
  EventLocationSchema,
  PersonSchema,
  RelationSchema,
  ReignSchema,
  normalizeSearchTerm,
} from "@eralens/shared";
import {
  mapDynasty,
  mapDynastyCapital,
  mapDynastyGroup,
  mapDynastyLaneGroup,
  mapEvent,
  mapPerson,
  mapRelation,
  mapReign,
} from "../src/mappers.js";
import { prisma } from "../src/db.js";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..");
const schemaPath = path.join(root, "data/mobile/schema.sql");
const versions = JSON.parse(await readFile(path.join(root, "data/mobile/versions.json"), "utf8")) as {
  schemaVersion: number;
  contractVersion: number;
};
const outputArg = process.argv.find((arg) => arg.startsWith("--out="))?.slice(6);
const outputPath = path.resolve(outputArg ?? path.join(root, "data/mobile/eralens-content.sqlite"));
const tempPath = `${outputPath}.tmp`;

const TABLES = [
  ["persons", "id"], ["dynasty_groups", "id"], ["dynasties", "id"], ["reigns", "id"],
  ["event_locations", "id"], ["events", "id"], ["event_dynasties", "event_id, dynasty_id"],
  ["event_participants", "event_id, person_id"], ["relations", "id"],
  ["dynasty_lane_groups", "id"], ["dynasty_capitals", "id"], ["reign_capitals", "reign_id, capital_id"],
] as const;

type Row = Record<string, unknown>;
const quoteId = (id: string) => `"${id.replaceAll('"', '""')}"`;

function camelizeRow(row: Row): Row {
  return Object.fromEntries(Object.entries(row).map(([key, value]) => [
    key.replace(/_([a-z])/g, (_, c: string) => c.toUpperCase()), value,
  ]));
}

function dtoValidate(name: string, schema: { parse(value: unknown): unknown }, value: unknown) {
  try { schema.parse(value); }
  catch (error) { throw new Error(`${name} failed Zod validation: ${String(error)}`); }
}

function serializable(value: unknown): null | string | number | Uint8Array {
  if (value == null) return null;
  if (typeof value === "string" || typeof value === "number") return value;
  if (typeof value === "boolean") return value ? 1 : 0;
  if (Array.isArray(value)) return JSON.stringify(value);
  if (typeof value === "object" && "toString" in value) {
    const text = String(value);
    const numeric = Number(text);
    return Number.isFinite(numeric) && /^-?\d+(\.\d+)?$/.test(text) ? numeric : text;
  }
  return JSON.stringify(value) ?? String(value);
}

function stableJson(value: unknown): string {
  if (Array.isArray(value)) return `[${value.map(stableJson).join(",")}]`;
  if (value && typeof value === "object") {
    return `{${Object.entries(value as Row).sort(([a], [b]) => a.localeCompare(b)).map(([k, v]) => `${JSON.stringify(k)}:${stableJson(v)}`).join(",")}}`;
  }
  return JSON.stringify(value);
}

function searchEntry(db: DatabaseSync, type: string, id: string, term: string, kind: string, label: string, subtitle: string | null, anchor: number | null) {
  const normalized = normalizeSearchTerm(term);
  if (!normalized) return;
  db.prepare(`INSERT OR IGNORE INTO search_entries(entity_type, entity_id, normalized_term, term_kind, label, subtitle, anchor_abs) VALUES (?, ?, ?, ?, ?, ?, ?)`)
    .run(type, id, normalized, kind, label, subtitle, anchor);
}

await mkdir(path.dirname(outputPath), { recursive: true });
await rm(tempPath, { force: true });
const db = new DatabaseSync(tempPath);
let pgConnected = false;
try {
  await prisma.$connect();
  pgConnected = true;
  const schemaSql = await readFile(schemaPath, "utf8");
  db.exec(schemaSql);
  db.exec("BEGIN IMMEDIATE");

  const raw = new Map<string, Row[]>();
  const counts: Record<string, number> = {};
  for (const [table, orderBy] of TABLES) {
    const info = db.prepare(`PRAGMA table_info(${quoteId(table)})`).all() as { name: string }[];
    const columns = info.map((column) => column.name);
    const rows = await prisma.$queryRawUnsafe<Row[]>(`SELECT ${columns.map(quoteId).join(", ")} FROM "${table}" ORDER BY ${orderBy.split(", ").map(quoteId).join(", ")}`);
    raw.set(table, rows);
    counts[table] = rows.length;
    const insert = db.prepare(`INSERT INTO ${quoteId(table)} (${columns.map(quoteId).join(",")}) VALUES (${columns.map(() => "?").join(",")})`);
    for (const row of rows) {
      try { insert.run(...columns.map((column) => serializable(row[column]))); }
      catch (error) { throw new Error(`SQLite insert failed for ${table} row ${String(row.id ?? row.event_id ?? row.reign_id)} (event_id=${String(row.event_id ?? "null")}, dynasty_id=${String(row.dynasty_id ?? "null")}, person_id=${String(row.person_id ?? "null")}): ${String(error)}`); }
    }
  }

  const persons = raw.get("persons")!;
  const dynasties = raw.get("dynasties")!;
  const groups = raw.get("dynasty_groups")!;
  const laneGroups = raw.get("dynasty_lane_groups")!;
  const reigns = raw.get("reigns")!;
  const events = raw.get("events")!;
  const relations = raw.get("relations")!;
  const capitalRows = raw.get("dynasty_capitals")!;
  for (const row of persons) dtoValidate("Person", PersonSchema, mapPerson(camelizeRow(row) as never));
  for (const row of dynasties) dtoValidate("Dynasty", DynastySchema, mapDynasty(row as never));
  for (const row of groups) dtoValidate("DynastyGroup", DynastyGroupSchema, mapDynastyGroup(row as never));
  for (const row of laneGroups) dtoValidate("DynastyLaneGroup", DynastyLaneGroupSchema, mapDynastyLaneGroup(camelizeRow(row) as never));
  for (const row of reigns) dtoValidate("Reign", ReignSchema, mapReign(row as never));
  const dynastyLinks = raw.get("event_dynasties")!;
  const participantLinks = raw.get("event_participants")!;
  const locations = new Map(raw.get("event_locations")!.map((row) => [row.id, camelizeRow(row)]));
  for (const row of raw.get("event_locations")!) {
    dtoValidate("EventLocation", EventLocationSchema, {
      ...camelizeRow(row), longitude: Number(row.longitude), latitude: Number(row.latitude), note: row.note ?? undefined,
    });
  }
  for (const row of events) {
    const camel = camelizeRow(row);
    const mapped = mapEvent({
      ...row,
      dynasties: dynastyLinks.filter((link) => link.event_id === row.id).map((link) => ({ dynastyId: link.dynasty_id })),
      participants: participantLinks.filter((link) => link.event_id === row.id).map((link) => ({ personId: link.person_id })),
      location: locations.get(row.location_id as string) as never,
    } as never);
    dtoValidate("Event", EventSchema, mapped);
  }
  for (const row of relations) dtoValidate("Relation", RelationSchema, mapRelation(camelizeRow(row) as never));
  const relationTargets = new Map([
    ["person", new Set(persons.map((row) => String(row.id)))],
    ["dynasty", new Set(dynasties.map((row) => String(row.id)))],
    ["reign", new Set(reigns.map((row) => String(row.id)))],
    ["event", new Set(events.map((row) => String(row.id)))],
    ["capital", new Set(capitalRows.map((row) => String(row.id)))],
  ]);
  const danglingRelations: string[] = [];
  for (const row of relations) {
    for (const end of ["from", "to"] as const) {
      const type = String(row[`${end}_type`]);
      const id = String(row[`${end}_id`]);
      if (!relationTargets.get(type)?.has(id)) danglingRelations.push(`${String(row.id)} ${end}=${type}:${id}`);
    }
    if (row.event_id != null && !relationTargets.get("event")?.has(String(row.event_id))) {
      danglingRelations.push(`${String(row.id)} event_id=event:${String(row.event_id)}`);
    }
  }
  if (danglingRelations.length) throw new Error(`Found ${danglingRelations.length} dangling relation endpoint(s):\n${danglingRelations.map((item) => `- ${item}`).join("\n")}`);
  const capitalLinks = raw.get("reign_capitals")!;
  for (const row of capitalRows) {
    const mapped = mapDynastyCapital({ ...row, reign_ids: capitalLinks.filter((link) => link.capital_id === row.id).map((link) => link.reign_id) } as never);
    dtoValidate("DynastyCapital", DynastyCapitalSchema, mapped);
  }

  const personReigns = new Map<string, Row[]>();
  for (const row of reigns) personReigns.set(String(row.person_id), [...(personReigns.get(String(row.person_id)) ?? []), row]);
  const dynastyNames = new Map(dynasties.map((row) => [String(row.id), String(row.name)]));
  const eventKindLabel: Record<string, string> = { idiom: "成语", poetry: "诗词", battle: "战争", politics: "政治", culture: "文化", disaster: "灾害", commerce: "商业", agriculture: "农业", finance: "金融", other: "其他" };
  for (const row of persons) {
    const roles = Array.isArray(row.roles) ? row.roles.join(" · ") : "";
    const anchorReigns = personReigns.get(String(row.id)) ?? [];
    const anchor = anchorReigns.length ? Math.min(...anchorReigns.map((reign) => Number(reign.start_abs))) : null;
    for (const term of (Array.isArray(row.search_terms) && row.search_terms.length ? row.search_terms : [row.name, ...(Array.isArray(row.alt_names) ? row.alt_names : [])])) {
      searchEntry(db, "person", String(row.id), String(term), "person", String(row.name), roles || null, anchor);
    }
  }
  for (const row of dynasties) searchEntry(db, "dynasty", String(row.id), String(row.name), "name", String(row.name), null, Number(row.start_abs));
  for (const row of reigns) {
    const person = persons.find((item) => item.id === row.person_id);
    const dynasty = dynastyNames.get(String(row.dynasty_id)) ?? "";
    for (const term of String(row.era_names ?? "").split(",").map((item) => item.trim()).filter(Boolean)) {
      searchEntry(db, "reign", String(row.id), term, "era", term, `${String(person?.name ?? "")} · ${dynasty}`, Number(row.start_abs));
    }
  }
  for (const row of events) {
    const anchor = row.at_abs ?? row.start_abs ?? row.end_abs;
    const subtitle = row.kind === "idiom" ? "成语" : eventKindLabel[String(row.kind)] ?? "其他";
    searchEntry(db, "event", String(row.id), String(row.name), "name", String(row.name), subtitle, anchor == null ? null : Number(anchor));
    if (row.meaning) searchEntry(db, "event", String(row.id), String(row.meaning), "meaning", String(row.name), subtitle, anchor == null ? null : Number(anchor));
  }
  for (const row of capitalRows) {
    const subtitle = `${String(row.modern_name)} · ${dynastyNames.get(String(row.dynasty_id)) ?? ""} · 都城`;
    searchEntry(db, "capital", String(row.id), String(row.historical_name), "historical_name", String(row.historical_name), subtitle, Number(row.start_abs));
    searchEntry(db, "capital", String(row.id), String(row.modern_name), "modern_name", String(row.historical_name), subtitle, Number(row.start_abs));
  }
  counts.search_entries = Number((db.prepare("SELECT COUNT(*) AS count FROM search_entries").get() as { count: number }).count);

  const fkErrors = db.prepare("PRAGMA foreign_key_check").all();
  if (fkErrors.length) throw new Error(`SQLite foreign_key_check failed with ${fkErrors.length} row(s)`);
  const integrity = db.prepare("PRAGMA integrity_check").get() as { integrity_check: string };
  if (integrity.integrity_check !== "ok") throw new Error(`SQLite integrity_check failed: ${integrity.integrity_check}`);

  const checksumHash = createHash("sha256");
  for (const [table, orderBy] of TABLES) {
    const columns = (db.prepare(`PRAGMA table_info(${quoteId(table)})`).all() as { name: string }[]).map((column) => column.name);
    const rows = db.prepare(`SELECT * FROM ${quoteId(table)} ORDER BY ${orderBy.split(", ").map(quoteId).join(", ")}`).all();
    for (const row of rows) checksumHash.update(`${table}\n${stableJson(row)}\n`);
  }
  for (const row of db.prepare("SELECT * FROM search_entries ORDER BY entity_type, entity_id, normalized_term, term_kind").all()) {
    checksumHash.update(`search_entries\n${stableJson(row)}\n`);
  }
  const sourceChecksum = checksumHash.digest("hex");
  let sourceGitSha = "unknown";
  try { sourceGitSha = execFileSync("git", ["rev-parse", "HEAD"], { cwd: root, encoding: "utf8" }).trim(); } catch { /* export may run from a source archive */ }
  const metadata = {
    schema_version: versions.schemaVersion,
    contract_version: versions.contractVersion,
    dataset_version: process.env.DATASET_VERSION ?? `local-${sourceChecksum.slice(0, 12)}`,
    source_git_sha: sourceGitSha,
    source_checksum: sourceChecksum,
    counts,
    built_at: new Date().toISOString(),
  };
  const putMetadata = db.prepare("INSERT INTO content_metadata(key, value) VALUES (?, ?)");
  for (const [key, value] of Object.entries(metadata)) putMetadata.run(key, JSON.stringify(value));
  db.exec("COMMIT");
  db.exec("PRAGMA optimize");
  db.close();
  await rename(tempPath, outputPath);
  console.log(JSON.stringify({ outputPath, ...metadata }, null, 2));
} catch (error) {
  try { db.exec("ROLLBACK"); } catch { /* transaction may have closed */ }
  db.close();
  await rm(tempPath, { force: true });
  throw error;
} finally {
  if (pgConnected) await prisma.$disconnect();
}
