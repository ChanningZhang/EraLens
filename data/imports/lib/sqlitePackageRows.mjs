import { assertEntityAssociation } from "../../../packages/shared/src/entityAssociations.mjs";

const text = value => value == null ? null : String(value);
const csv = values => values?.length ? values.map(value => String(value).trim()).filter(Boolean).join(",") || null : null;
const confidence = (date, explicit) => explicit ?? date?.confidence ?? (date?.day != null ? "day" : date?.month != null && date.month !== 1 ? "month" : "year");
const point = (date, key) => ({
  [`${key}_year`]: date?.year ?? null,
  [`${key}_month`]: date?.month ?? null,
  [`${key}_day`]: date?.day ?? null,
});

function serializeValue(value) {
  if (value == null) return "NULL";
  if (typeof value === "boolean") return value ? "1" : "0";
  if (typeof value === "number") {
    if (!Number.isFinite(value)) throw new Error(`Invalid SQLite number: ${value}`);
    return String(value);
  }
  if (typeof value === "object") return `'${JSON.stringify(value).replaceAll("'", "''")}'`;
  return `'${String(value).replaceAll("'", "''")}'`;
}

function insert(table, row) {
  const columns = Object.keys(row);
  return `INSERT INTO "${table}" (${columns.map(column => `"${column}"`).join(",")}) VALUES (${columns.map(column => serializeValue(row[column])).join(",")});`;
}

export function rowsForPackage(slug, cache) {
  const groups = (cache.dynastyGroups ?? []).map(row => ({
    id: row.id, name: row.name, alt_names: row.altNames ?? [], scope: row.scope ?? "cn",
    ...point(row.start, "start"), start_confidence: confidence(row.start),
    ...point(row.end, "end"), end_confidence: confidence(row.end),
    start_abs: row.start.abs, end_abs: row.end.abs, note: row.note ?? null,
  }));
  const dynasties = (cache.dynasties ?? []).map(row => ({
    id: row.id, name: row.name, alt_names: row.altNames ?? [], ethnicity: row.ethnicity ?? null,
    scope: row.scope ?? "cn", region: row.region ?? "east_asia",
    ...point(row.start, "start"), start_confidence: confidence(row.start),
    ...point(row.end, "end"), end_confidence: confidence(row.end),
    start_abs: row.start.abs, end_abs: row.end.abs, color_token: "ochre",
    parent_id: row.parentId ?? null, group_id: row.groupId ?? null, note: row.note ?? null,
  }));
  const persons = (cache.persons ?? []).map(row => ({
    id: row.id, name: row.name, dynasty_id: row.dynastyId ?? null,
    alt_names: row.altNames ?? [], ancestral_xing: row.ancestralXing ?? null, clan_shi: row.clanShi ?? null,
    ...point(row.birth, "birth"), birth_confidence: row.birth ? confidence(row.birth) : null,
    ...point(row.death, "death"), death_confidence: row.death ? confidence(row.death) : null,
    roles: row.roles ?? [], bio: row.bio ?? null, links: row.links ?? [],
    posthumous_name: csv(row.posthumousNames), temple_name: csv(row.templeNames),
    title: row.title ?? null, search_terms: [],
  }));
  const locations = (cache.locations ?? []).map(row => ({
    id: row.id, modern_name: row.modernName, longitude: row.longitude, latitude: row.latitude,
    coordinate_system: row.coordinateSystem,
  }));
  const reigns = (cache.reigns ?? []).map(row => ({
    id: row.id, dynasty_id: row.dynastyId, person_id: row.personId, title: row.title ?? "",
    era_names: csv(row.eraNames), ...point(row.start, "start"), start_confidence: confidence(row.start, row.startConfidence),
    ...point(row.end, "end"), end_confidence: confidence(row.end, row.endConfidence),
    start_abs: row.startAbs ?? row.start.abs, end_abs: row.endAbs ?? row.end?.abs ?? null,
    claim_track: row.claimTrack ?? null, claim_label: row.claimLabel ?? null,
    is_informal_monarch: row.isInformalMonarch ?? false, is_main: row.isMain ?? null,
  }));
  const events = (cache.events ?? []).map(row => ({
    id: row.id, name: row.name, kind: row.kind ?? "other", time_mode: row.timeMode ?? "point",
    at_confidence: row.at ? confidence(row.at, row.atConfidence) : null,
    start_confidence: row.start ? confidence(row.start, row.startConfidence) : null,
    end_confidence: row.end ? confidence(row.end, row.endConfidence) : null,
    date_note: row.dateNote ?? null,
    ...point(row.at, "at"), at_abs: row.atAbs ?? row.at?.abs ?? null,
    ...point(row.start, "start"), start_abs: row.startAbs ?? row.start?.abs ?? null,
    ...point(row.end, "end"), end_abs: row.endAbs ?? row.end?.abs ?? null,
    summary: row.summary ?? null, meaning: row.meaning ?? null, content: row.content ?? null,
  }));
  const associations = (cache.associations ?? []).map(row => {
    assertEntityAssociation(row);
    const [aType, ...aParts] = row.aRef.split(":");
    const [bType, ...bParts] = row.bRef.split(":");
    return { a_type: aType, a_id: aParts.join(":"), b_type: bType, b_id: bParts.join(":") };
  });
  const relations = (cache.relations ?? []).map(row => {
    const [fromType, ...fromParts] = row.fromRef.split(":");
    const [toType, ...toParts] = row.toRef.split(":");
    return {
      id: row.id, from_type: fromType, from_id: fromParts.join(":"),
      to_type: toType, to_id: toParts.join(":"), kind: row.kind,
      ...point(row.at, "at"), at_abs: row.atAbs ?? row.at?.abs ?? null,
      at_confidence: row.at ? confidence(row.at, row.atConfidence) : null,
      event_id: row.eventId ?? null,
    };
  });
  const locationMappings = (cache.locationMappings ?? []).map(row => ({
    id: row.id, location_id: row.locationId, kind: row.kind, external_id: row.externalId,
    historical_name: row.historicalName, spatial_precision: row.spatialPrecision ?? null,
    ...point(row.start, "start"), ...point(row.end, "end"),
    start_abs: row.startAbs ?? row.start?.abs ?? null, end_abs: row.endAbs ?? row.end?.abs ?? null,
    start_confidence: row.start ? confidence(row.start, row.startConfidence) : null,
    end_confidence: row.end ? confidence(row.end, row.endConfidence) : null,
    role: row.kind === "event" ? null : row.role ?? "primary", note: row.note ?? null, links: row.links ?? [],
  }));
  return { slug, dynasty_groups: groups, dynasties, persons, locations, reigns, events, entity_associations: associations, relations, location_mapping: locationMappings };
}

export function serializeSqlitePackages(packages, { allowLegacyCleanup = false } = {}) {
  const tableOrder = ["dynasty_groups", "dynasties", "persons", "locations", "reigns", "events", "relations", "entity_associations", "location_mapping"];
  const flattened = Object.fromEntries(tableOrder.map(table => [table, []]));
  for (const { slug, cache } of packages) {
    if (["capitals", "reignCapitals", "eventLocations"].some(key => cache[key]?.length)) throw new Error(`${slug}: legacy geography cache cannot be imported into SQLite`);
    if (cache.dynastyMerges?.length) throw new Error(`${slug}: remove retired dynastyMerges; maintain final dynasty rows and references in source packages`);
    if (cache.updates?.length) throw new Error(`${slug}: remove cached updates; edit the owning row in its source package`);
    for (const field of ["preSql", "postSql"]) {
      if (cache[field]?.trim() && !allowLegacyCleanup) throw new Error(`${slug}: ${field} is retired; remove retired database cleanup from this source package`);
    }
    const converted = rowsForPackage(slug, cache);
    for (const table of tableOrder) flattened[table].push(...converted[table]);
  }
  const statements = [];
  for (const table of tableOrder) {
    flattened[table].sort((a, b) => String(a.id ?? `${a.a_type}:${a.a_id}:${a.b_type}:${a.b_id}`).localeCompare(String(b.id ?? `${b.a_type}:${b.a_id}:${b.b_type}:${b.b_id}`)));
    for (const row of flattened[table]) statements.push(insert(table, row));
  }
  return { sql: statements.join("\n"), rows: flattened, counts: Object.fromEntries(tableOrder.map(table => [table, flattened[table].length])) };
}
