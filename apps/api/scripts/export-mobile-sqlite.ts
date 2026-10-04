import { mapEntityAssociation, buildPersonSearchTerms, normalizeSearchTerm, resolveDynastyName, resolveDynastyDefaultName, dynastyNameSearchEntries } from "@eralens/shared";
import {
  EventSchema, PersonSchema, ReignSchema, DynastySchema, DynastyGroupSchema, RelationSchema,
  LocationSchema, LocationMappingSchema, EntityAssociationSchema,
  mapLocation, mapLocationMapping,
} from "@eralens/shared";
import { DatabaseSync } from "node:sqlite";
import { createHash } from "node:crypto";
import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { mkdir, readFile, rename, rm, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { discoverPackages } from "../../../data/imports/lib/discoverPackages.mjs";
import { auditPackageOwnership } from "../../../data/imports/lib/auditPackageOwnership.mjs";
import { serializeSqlitePackages } from "../../../data/imports/lib/sqlitePackageRows.mjs";
import {
  mapDynasty, mapGroup as mapDynastyGroup, mapEvent, mapPerson, mapRelation, mapReign,
} from "@eralens/data-access/sqlite";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..");
const importsRoot = path.join(root, "data/imports");
const schemaPath = path.join(root, "data/mobile/schema.sql");
const versionsPath = path.join(root, "data/mobile/versions.json");
const versions = JSON.parse(await readFile(versionsPath, "utf8")) as { schemaVersion: number; contractVersion: number };
const outputArg = process.argv.find(arg => arg.startsWith("--out="))?.slice(6);
const sqlOnly = process.argv.includes("--sql-only");
const outputPath = path.resolve(outputArg ?? path.join(root, "data/mobile/eralens-content.sqlite"));
const tempPath = `${outputPath}.tmp`;
const sqlPath = `${outputPath}.sql`;
const refreshSqlPath = `${outputPath}.refresh.sql`;
const tempSqlPath = `${sqlPath}.tmp`;
const tempRefreshSqlPath = `${refreshSqlPath}.tmp`;
const tables: [string, string][] = [
  ["persons", "id"], ["dynasty_groups", "id"], ["dynasties", "id"], ["reigns", "id"], ["events", "id"],
  ["entity_associations", "a_type, a_id, b_type, b_id"], ["relations", "id"], ["locations", "id"], ["location_mapping", "id"],
];
type Row = Record<string, any>;
const sqlText = (value: unknown) => `'${String(value).replaceAll("'", "''")}'`;
const stableJson = (value: unknown): string => Array.isArray(value)
  ? `[${value.map(stableJson).join(",")}]`
  : value && typeof value === "object"
    ? `{${Object.entries(value as Row).sort(([a], [b]) => a.localeCompare(b)).map(([key, item]) => `${JSON.stringify(key)}:${stableJson(item)}`).join(",")}}`
    : JSON.stringify(value);

function canonicalRows(db: DatabaseSync, table: string, orderBy: string): Row[] {
  return db.prepare(`SELECT * FROM "${table}" ORDER BY ${orderBy}`).all() as Row[];
}

function insertSearchEntry(db: DatabaseSync, type: string, id: string, term: string, kind: string, label: string, subtitle: string | null, anchor: number | null) {
  const normalized = normalizeSearchTerm(term);
  if (!normalized) return;
  db.prepare("INSERT OR IGNORE INTO search_entries(entity_type,entity_id,normalized_term,term_kind,label,subtitle,anchor_abs) VALUES(?,?,?,?,?,?,?)")
    .run(type, id, normalized, kind, label, subtitle, anchor);
}

function createSearchIndex(db: DatabaseSync): string {
  const sql: string[] = [];
  const insert = db.prepare("INSERT OR IGNORE INTO search_entries(entity_type,entity_id,normalized_term,term_kind,label,subtitle,anchor_abs) VALUES(?,?,?,?,?,?,?)");
  const personRows = canonicalRows(db, "persons", "id");
  const dynastyRows = canonicalRows(db, "dynasties", "id");
  const reignRows = canonicalRows(db, "reigns", "id");
  const eventRows = canonicalRows(db, "events", "id");
  const locationRows = canonicalRows(db, "locations", "id");
  const mappingRows = canonicalRows(db, "location_mapping", "id");
  const associations = canonicalRows(db, "entity_associations", "a_type,a_id,b_type,b_id").map(mapEntityAssociation);
  const persons = personRows.map(mapPerson);
  const dynasties = dynastyRows.map(mapDynasty);
  const reigns = reignRows.map(mapReign);
  const dynastyById = new Map(dynasties.map(dynasty => [dynasty.id, dynasty]));
  const personById = new Map(persons.map(person => [person.id, person]));
  const mappingByEvent = new Map<string, Row[]>();
  const locationById = new Map(locationRows.map(row => [String(row.id), mapLocation(row)]));
  const mappings = mappingRows.map(row => mapLocationMapping({
    ...row,
    links: row.links,
    location: locationById.get(String(row.location_id)),
  }));
  const eventLocationById = new Map<string, typeof mappings>();
  for (const mapping of mappings) if (mapping.kind === "event") eventLocationById.set(mapping.externalId, [...(eventLocationById.get(mapping.externalId) ?? []), mapping]);
  const events = eventRows.map(row => mapEvent({
    ...row,
    locationMappings: eventLocationById.get(String(row.id)) ?? [],
  }, associations));

  const updatePerson = db.prepare("UPDATE persons SET search_terms=? WHERE id=?");
  for (const person of persons) {
    const terms = buildPersonSearchTerms(person, reigns, dynasties);
    updatePerson.run(JSON.stringify(terms), person.id);
    const roles = person.roles.join(" · ");
    const anchorRows = reignRows.filter(row => row.person_id === person.id);
    const anchor = anchorRows.length ? Math.min(...anchorRows.map(row => Number(row.start_abs))) : null;
    for (const term of terms) {
      const normalized = normalizeSearchTerm(term);
      if (!normalized) continue;
      const values = ["person", person.id, normalized, "person", person.name, roles || null, anchor];
      insert.run(...values);
      sql.push(`INSERT OR IGNORE INTO search_entries(entity_type,entity_id,normalized_term,term_kind,label,subtitle,anchor_abs) VALUES(${values.map(value => value == null ? "NULL" : typeof value === "number" ? value : sqlText(value)).join(",")});`);
    }
    sql.push(`UPDATE persons SET search_terms=${sqlText(JSON.stringify(terms))} WHERE id=${sqlText(person.id)};`);
  }
  for (const dynasty of dynasties) {
    for (const entry of dynastyNameSearchEntries(dynasty, dynasty.startAbs)) {
      const values = ["dynasty", dynasty.id, entry.name, "name", entry.name, null, entry.abs];
      insertSearchEntry(db, ...values as [string,string,string,string,string,string|null,number|null]);
      sql.push(`INSERT OR IGNORE INTO search_entries(entity_type,entity_id,normalized_term,term_kind,label,subtitle,anchor_abs) VALUES(${values.map(value => value == null ? "NULL" : typeof value === "number" ? value : sqlText(value)).join(",")});`);
    }
    for (const alias of dynasty.altNames ?? []) {
      const label = resolveDynastyDefaultName(dynasty);
      const values = ["dynasty", dynasty.id, alias, "alias", label, null, dynasty.startAbs];
      insertSearchEntry(db, ...values as [string,string,string,string,string,string|null,number|null]);
      sql.push(`INSERT OR IGNORE INTO search_entries(entity_type,entity_id,normalized_term,term_kind,label,subtitle,anchor_abs) VALUES(${values.map(value => value == null ? "NULL" : typeof value === "number" ? value : sqlText(value)).join(",")});`);
    }
  }
  for (const row of reignRows) {
    const person = personById.get(String(row.person_id));
    const dynasty = dynastyById.get(String(row.dynasty_id));
    const dynastyName = dynasty ? resolveDynastyDefaultName(dynasty) : "";
    for (const term of String(row.era_names ?? "").split(",").map(value => value.trim()).filter(Boolean)) {
      const values = ["reign", String(row.id), term, "era", term, `${person?.name ?? ""} · ${dynastyName}`, Number(row.start_abs)];
      insertSearchEntry(db, ...values as [string,string,string,string,string,string|null,number|null]);
      sql.push(`INSERT OR IGNORE INTO search_entries(entity_type,entity_id,normalized_term,term_kind,label,subtitle,anchor_abs) VALUES(${values.map(value => value == null ? "NULL" : typeof value === "number" ? value : sqlText(value)).join(",")});`);
    }
  }
  const eventLabels: Record<string, string> = { idiom: "成语", poetry: "诗词", battle: "战争", politics: "政治", culture: "文化", disaster: "灾害", commerce: "商业", agriculture: "农业", finance: "金融", other: "其他" };
  for (const row of eventRows) {
    const anchor = row.at_abs ?? row.start_abs ?? row.end_abs;
    const subtitle = row.kind === "idiom" ? "成语" : eventLabels[String(row.kind)] ?? "其他";
    const terms: [string, string][] = [[String(row.name), "name"], ...(row.meaning ? [[String(row.meaning), "meaning"] as [string,string]] : [])];
    for (const [term, kind] of terms) {
      const values = ["event", String(row.id), term, kind, String(row.name), subtitle, anchor == null ? null : Number(anchor)];
      insertSearchEntry(db, ...values as [string,string,string,string,string,string|null,number|null]);
      sql.push(`INSERT OR IGNORE INTO search_entries(entity_type,entity_id,normalized_term,term_kind,label,subtitle,anchor_abs) VALUES(${values.map(value => value == null ? "NULL" : typeof value === "number" ? value : sqlText(value)).join(",")});`);
    }
  }
  for (const mapping of mappings) {
    const reign = mapping.kind === "reign" ? reigns.find(item => item.id === mapping.externalId) : undefined;
    const event = mapping.kind === "event" ? events.find(item => item.id === mapping.externalId) : undefined;
    const dynasty = dynastyById.get(reign?.dynastyId ?? mapping.externalId);
    const subtitle = [mapping.location.modernName, event?.name ?? (dynasty ? resolveDynastyName(dynasty, mapping.startAbs) : undefined), mapping.kind === "event" ? "事件地点" : "都城"].filter(Boolean).join(" · ");
    const anchor = mapping.startAbs ?? event?.atAbs ?? event?.startAbs;
    for (const [term, kind] of [[mapping.historicalName, "historical_name"], [mapping.location.modernName, "modern_name"]] as const) {
      const values = ["location_mapping", mapping.id, term, kind, mapping.historicalName, subtitle, anchor ?? null];
      insertSearchEntry(db, ...values as [string,string,string,string,string,string|null,number|null]);
      sql.push(`INSERT OR IGNORE INTO search_entries(entity_type,entity_id,normalized_term,term_kind,label,subtitle,anchor_abs) VALUES(${values.map(value => value == null ? "NULL" : typeof value === "number" ? value : sqlText(value)).join(",")});`);
    }
  }
  return sql.join("\n");
}

auditPackageOwnership(importsRoot);
const packages = discoverPackages(importsRoot).map(slug => ({
  slug,
  cache: JSON.parse(readFileSync(path.join(importsRoot, slug, "cache.json"), "utf8")) as Row,
}));
const serialized = serializeSqlitePackages(packages);
await mkdir(path.dirname(outputPath), { recursive: true });
await rm(tempPath, { force: true });
await rm(tempSqlPath, { force: true });
await rm(tempRefreshSqlPath, { force: true });
const db = new DatabaseSync(tempPath);
let open = true;
try {
  const schemaSql = await readFile(schemaPath, "utf8");
  db.exec("PRAGMA foreign_keys=ON;");
  db.exec(schemaSql);
  const indexSql = createSearchIndexAfterLoad(db, serialized.sql);
  validateContent(db);
  const counts = { ...serialized.counts, search_entries: Number((db.prepare("SELECT COUNT(*) AS count FROM search_entries").get() as { count: number }).count) };
  const foreignErrors = db.prepare("PRAGMA foreign_key_check").all();
  if (foreignErrors.length) throw new Error(`foreign_key_check failed (${foreignErrors.length})`);
  const integrity = (db.prepare("PRAGMA integrity_check").get() as { integrity_check: string }).integrity_check;
  if (integrity !== "ok") throw new Error(`integrity_check failed: ${integrity}`);

  const hash = createHash("sha256");
  for (const [table, orderBy] of tables) {
    for (const row of canonicalRows(db, table, orderBy)) hash.update(`${table}\n${stableJson(row)}\n`);
  }
  for (const row of canonicalRows(db, "search_entries", "entity_type,entity_id,normalized_term,term_kind")) hash.update(`search_entries\n${stableJson(row)}\n`);
  const sourceChecksum = hash.digest("hex");
  let sourceGitSha = "unknown";
  try { sourceGitSha = execFileSync("git", ["rev-parse", "HEAD"], { cwd: root, encoding: "utf8" }).trim(); } catch { /* source archive */ }
  const metadata = {
    schema_version: versions.schemaVersion,
    contract_version: versions.contractVersion,
    dataset_version: process.env.DATASET_VERSION ?? `local-${sourceChecksum.slice(0, 12)}`,
    source_git_sha: sourceGitSha,
    source_checksum: sourceChecksum,
    counts,
    built_at: new Date().toISOString(),
  };
  const insertMetadata = db.prepare("INSERT INTO content_metadata(key,value) VALUES(?,?)");
  for (const [key, value] of Object.entries(metadata)) insertMetadata.run(key, JSON.stringify(value));
  db.exec("PRAGMA optimize;");
  db.close();
  open = false;

  const metadataSql = Object.entries(metadata).map(([key, value]) => `INSERT INTO content_metadata(key,value) VALUES(${sqlText(key)},${sqlText(JSON.stringify(value))});`).join("\n");
  const fullSql = `${schemaSql}\nBEGIN IMMEDIATE;\n${serialized.sql}\n${indexSql}\n${metadataSql}\nCOMMIT;\n`;
  const clearSql = [
    "DELETE FROM search_entries;",
    "DELETE FROM content_metadata;",
    "DELETE FROM entity_associations;",
    "DELETE FROM relations;",
    "DELETE FROM location_mapping;",
    "DELETE FROM events;",
    "DELETE FROM reigns;",
    "DELETE FROM dynasties;",
    "DELETE FROM dynasty_groups;",
    "DELETE FROM persons;",
    "DELETE FROM locations;",
  ].join("\n");
  const refreshSql = `${clearSql}\n${serialized.sql}\n${indexSql}\n${metadataSql}\n`;
  await writeFile(tempSqlPath, fullSql);
  await writeFile(tempRefreshSqlPath, refreshSql);
  if (sqlOnly) {
    await rm(tempPath, { force: true });
  } else {
    await rename(tempPath, outputPath);
  }
  await rename(tempSqlPath, sqlPath);
  await rename(tempRefreshSqlPath, refreshSqlPath);
  console.log(JSON.stringify({ outputPath, sqlPath, refreshSqlPath, mode: sqlOnly ? "sql-only" : "snapshot", ...metadata }, null, 2));
} catch (error) {
  if (open) {
    try { db.close(); } catch { /* already closed */ }
  }
  await rm(tempPath, { force: true });
  await rm(tempSqlPath, { force: true });
  await rm(tempRefreshSqlPath, { force: true });
  throw error;
}

function createSearchIndexAfterLoad(database: DatabaseSync, baseSql: string): string {
  database.exec("BEGIN IMMEDIATE;");
  try {
    database.exec(baseSql);
    const indexSql = createSearchIndex(database);
    database.exec("COMMIT;");
    return indexSql;
  } catch (error) {
    database.exec("ROLLBACK;");
    throw error;
  }
}

function validateContent(database: DatabaseSync) {
  const rows = (table: string) => database.prepare(`SELECT * FROM "${table}" ORDER BY 1`).all() as Row[];
  const persons = rows("persons").map(row => PersonSchema.parse(mapPerson(row)));
  const dynasties = rows("dynasties").map(row => DynastySchema.parse(mapDynasty(row)));
  const groups = rows("dynasty_groups").map(row => DynastyGroupSchema.parse(mapDynastyGroup(row)));
  const reigns = rows("reigns").map(row => ReignSchema.parse(mapReign(row)));
  const relations = rows("relations").map(row => RelationSchema.parse(mapRelation(row)));
  const associations = rows("entity_associations").map(row => EntityAssociationSchema.parse(mapEntityAssociation(row)));
  const locationsById = new Map(rows("locations").map(row => [String(row.id), LocationSchema.parse(mapLocation(row))]));
  const mappings = rows("location_mapping").map(row => LocationMappingSchema.parse(mapLocationMapping({ ...row, location: locationsById.get(String(row.location_id)) })));
  const eventMappings = new Map<string, typeof mappings>();
  for (const mapping of mappings) if (mapping.kind === "event") eventMappings.set(mapping.externalId, [...(eventMappings.get(mapping.externalId) ?? []), mapping]);
  for (const row of rows("events")) EventSchema.parse(mapEvent({ ...row, locationMappings: eventMappings.get(String(row.id)) ?? [] }, associations));
  const names = [persons.length, dynasties.length, groups.length, reigns.length, relations.length, associations.length, locationsById.size, mappings.length];
  if (names.some(count => !Number.isInteger(count))) throw new Error("SQLite content schema validation failed");
}
