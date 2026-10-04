import { mapEntityAssociation, EntityAssociationSchema } from "@eralens/shared";
import { DatabaseSync } from "node:sqlite";
import { createHash } from "node:crypto";
import { readFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  LocationSchema, LocationMappingSchema, mapLocation, mapLocationMapping, DynastyGroupSchema, DynastySchema,
  EventSchema, PersonSchema, RelationSchema, ReignSchema,
} from "@eralens/shared";
import { mapDynasty, mapGroup as mapDynastyGroup, mapEvent, mapPerson, mapRelation, mapReign } from "@eralens/data-access/sqlite";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..");
const input = path.resolve(process.argv.find((arg) => arg.startsWith("--db="))?.slice(5) ?? path.join(root, "data/mobile/eralens-content.sqlite"));
const versions = JSON.parse(await readFile(path.join(root, "data/mobile/versions.json"), "utf8")) as { schemaVersion: number; contractVersion: number };
const db = new DatabaseSync(input, { readOnly: true });
const fail = (message: string): never => { throw new Error(message); };
const hydrate = (row: Record<string, unknown>) => Object.fromEntries(Object.entries(row).map(([key, raw]) => {
  let value = raw;
  if (["alt_names", "roles", "links", "search_terms", "phase_dynasty_ids", "altNames", "phaseDynastyIds", "searchTerms"].includes(key) && typeof raw === "string") value = JSON.parse(raw);
  if (["is_informal_monarch", "is_main", "isInformalMonarch", "isMain"].includes(key) && raw != null) value = Boolean(raw);
  if (["longitude", "latitude"].includes(key) && raw != null) value = Number(raw);
  return [key.replace(/_([a-z])/g, (_, c: string) => c.toUpperCase()), value];
}));
const rawHydrate = (row: Record<string, unknown>) => Object.fromEntries(Object.entries(row).map(([key, raw]) => {
  let value = raw;
  if (["alt_names", "roles", "links", "search_terms", "phase_dynasty_ids"].includes(key) && typeof raw === "string") value = JSON.parse(raw);
  if (["is_informal_monarch", "is_main"].includes(key) && raw != null) value = Boolean(raw);
  if (["longitude", "latitude"].includes(key) && raw != null) value = Number(raw);
  return [key, value];
}));
const stableJson = (value: unknown): string => Array.isArray(value)
  ? `[${value.map(stableJson).join(",")}]`
  : value && typeof value === "object"
    ? `{${Object.entries(value as Record<string, unknown>).sort(([a], [b]) => a.localeCompare(b)).map(([key, item]) => `${JSON.stringify(key)}:${stableJson(item)}`).join(",")}}`
    : JSON.stringify(value);
try {
  const integrity = db.prepare("PRAGMA integrity_check").get() as { integrity_check: string };
  if (integrity.integrity_check !== "ok") fail(`integrity_check: ${integrity.integrity_check}`);
  const foreignKeys = db.prepare("PRAGMA foreign_key_check").all();
  if (foreignKeys.length) fail(`foreign_key_check: ${foreignKeys.length} violation(s)`);
  const metadata = new Map((db.prepare("SELECT key, value FROM content_metadata").all() as { key: string; value: string }[]).map((item) => [item.key, JSON.parse(item.value)]));
  if (metadata.get("schema_version") !== versions.schemaVersion) fail(`schema version mismatch: ${metadata.get("schema_version")}`);
  if (metadata.get("contract_version") !== versions.contractVersion) fail(`contract version mismatch: ${metadata.get("contract_version")}`);
  const declaredCounts = metadata.get("counts") as Record<string, number>;
  for (const [table, expected] of Object.entries(declaredCounts)) {
    const actual = Number((db.prepare(`SELECT COUNT(*) AS count FROM "${table}"`).get() as { count: number }).count);
    if (actual !== expected) fail(`${table} count mismatch: metadata=${expected}, actual=${actual}`);
  }
  const checksum = createHash("sha256");
  const contentTables: [string, string][] = [
    ["persons", "id"], ["dynasty_groups", "id"], ["dynasties", "id"], ["reigns", "id"],
    ["events", "id"], ["entity_associations", "a_type, a_id, b_type, b_id"], ["relations", "id"],
    ["locations", "id"], ["location_mapping", "id"],
  ];
  for (const [table, keys] of contentTables) {
    for (const row of db.prepare(`SELECT * FROM "${table}" ORDER BY ${keys.split(", ").map((key) => `"${key}"`).join(", ")}`).all()) checksum.update(`${table}\n${stableJson(row)}\n`);
  }
  for (const row of db.prepare("SELECT * FROM search_entries ORDER BY entity_type, entity_id, normalized_term, term_kind").all()) checksum.update(`search_entries\n${stableJson(row)}\n`);
  const actualChecksum = checksum.digest("hex");
  if (actualChecksum !== metadata.get("source_checksum")) fail(`content checksum mismatch: metadata=${metadata.get("source_checksum")}, actual=${actualChecksum}`);
  const all = (table: string) => db.prepare(`SELECT * FROM "${table}" ORDER BY 1`).all() as Record<string, unknown>[];
  const persons = all("persons");
  const dynasties = all("dynasties");
  const groups = all("dynasty_groups");
  const reigns = all("reigns");
  const events = all("events");
  const relations = all("relations");
  const mappingRows = all("location_mapping");
  for (const row of persons) PersonSchema.parse(mapPerson(hydrate(row) as never));
  for (const row of dynasties) DynastySchema.parse(mapDynasty(rawHydrate(row) as never));
  for (const row of groups) DynastyGroupSchema.parse(mapDynastyGroup(rawHydrate(row) as never));
  for (const row of reigns) ReignSchema.parse(mapReign(rawHydrate(row) as never));
  for (const row of relations) RelationSchema.parse(mapRelation(rawHydrate(row) as never));
  const relationTargets = new Map([
    ["person", new Set(persons.map((row) => String(row.id)))],
    ["dynasty", new Set(dynasties.map((row) => String(row.id)))],
    ["reign", new Set(reigns.map((row) => String(row.id)))],
    ["event", new Set(events.map((row) => String(row.id)))],
    ["location_mapping", new Set(all("location_mapping").map((row) => String(row.id)))],
  ]);
  for (const row of relations) {
    for (const end of ["from", "to"]) {
      const type = String(row[`${end}_type`]);
      const id = String(row[`${end}_id`]);
      if (!relationTargets.get(type)?.has(id)) fail(`dangling relation endpoint: ${String(row.id)} ${end}=${type}:${id}`);
    }
    if (row.event_id != null && !relationTargets.get("event")?.has(String(row.event_id))) fail(`dangling relation event reference: ${String(row.id)} event_id=${String(row.event_id)}`);
  }
  const associations=all("entity_associations").map(mapEntityAssociation);
  for (const row of associations) {
    EntityAssociationSchema.parse(row);
    for(const ref of [row.aRef,row.bRef]) {
      const colon=ref.indexOf(":"),type=ref.slice(0,colon),id=ref.slice(colon+1);
      if(!relationTargets.get(type)?.has(id)) fail(`Dangling association: ${ref}`);
    }
  }
  const locationRows=all("locations");
  const locations=new Map(locationRows.map(row=>[String(row.id),mapLocation(row)]));
  const mappings=all("location_mapping").map(row=>mapLocationMapping({...row,location:locations.get(String(row.location_id))}));
  for(const m of mappings) {
    const table=m.kind === "dynasty" ? dynasties : m.kind === "reign" ? reigns : events;
    if(!table.some(r=>r.id===m.externalId)) fail(`Dangling mapping owner: ${m.id}`);
  }
  for (const row of events) EventSchema.parse(mapEvent({
    ...rawHydrate(row),
    locationMappings:mappings.filter(m=>m.kind === "event" && m.externalId===row.id),
  } as never, associations));
  const rowCounts = { persons: persons.length, dynasties: dynasties.length, dynastyGroups: groups.length, reigns: reigns.length, events: events.length, relations: relations.length, locations: locationRows.length, locationMappings: mappingRows.length };
  console.log(JSON.stringify({ input, status: "ok", schemaVersion: versions.schemaVersion, contractVersion: versions.contractVersion, counts: declaredCounts, zodRows: rowCounts }, null, 2));
} finally {
  db.close();
}
