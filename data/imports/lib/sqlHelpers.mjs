import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";

export function toAstroYear(year) {
  return year > 0 ? year : year + 1;
}
export function absMonth(year, month = 1) {
  return toAstroYear(year) * 12 + (month - 1);
}
export function fromAbsMonth(abs) {
  const wholeAbs = Math.round(abs);
  const astroYear = Math.floor(wholeAbs / 12);
  const month = wholeAbs - astroYear * 12 + 1;
  return { year: astroYear > 0 ? astroYear : astroYear - 1, month };
}
export function sqlStr(value) {
  if (value == null) return "NULL";
  return `'${String(value).replace(/'/g, "''")}'`;
}
export function sqlArray(values) {
  if (!values?.length) return "ARRAY[]::text[]";
  return `ARRAY[${values.map(sqlStr).join(",")}]`;
}
export function sqlJson(value) {
  if (value == null) return "NULL";
  return `${sqlStr(JSON.stringify(value))}::jsonb`;
}

export function ym(year, month = 1) {
  return { year, month, abs: absMonth(year, month) };
}

/** Year-precision point: December, matching lane year-end and fate `atAbs`. */
export function eventYear(year) {
  return ym(year, 12);
}

/**
 * Year-confidence `at` uses month 12 (lane year-end). January is the old
 * placeholder and is rewritten; explicit month confidence preserves January.
 */
export function normalizeYearPrecisionAt(at, confidence = "year") {
  if (!at || confidence !== "year" || at.day != null) return at;
  if (at.month !== 1) return at;
  return ym(at.year, 12);
}
export function wiki(title) {
  return [{ label: "维基百科", url: `https://zh.wikipedia.org/wiki/${title}` }];
}

export function formatAppellationCsv(values) {
  if (!values?.length) return null;
  const cleaned = values.map((v) => String(v).trim()).filter(Boolean);
  return cleaned.length ? cleaned.join(",") : null;
}

export function endpointDateConfidence(explicit, date = null) {
  if (explicit) return explicit;
  if (date?.day != null) return "day";
  if (date?.month != null && date.month !== 1) return "month";
  return "year";
}

export function parseAppellationCsv(raw) {
  if (!raw) return [];
  return raw
    .split(",")
    .map((part) => part.trim())
    .filter(Boolean);
}

export function person(
  id,
  name,
  roles,
  bio,
  wikiTitle,
  birth = null,
  death = null,
  altNames = [],
  posthumousNames = [],
  templeNames = [],
) {
  return {
    id,
    name,
    roles,
    bio,
    links: wiki(wikiTitle),
    birth,
    death,
    altNames,
    posthumousNames,
    templeNames,
  };
}

export function normalizeEraNameList(eraNames = []) {
  if (!eraNames.length) return [];
  if (typeof eraNames[0] === "string") return eraNames.filter(Boolean);
  return eraNames.map((e) => e.name).filter(Boolean);
}

export function reign({
  id,
  dynastyId,
  personId,
  title,
  posthumousName,
  templeName,
  start,
  end,
  endAbs: explicitEndAbs = null,
  eraNames = [],
  claimTrack = null,
  claimLabel = null,
  claimRole = null,
}) {
  return {
    id,
    dynastyId,
    personId,
    title,
    posthumousName,
    templeName,
    eraNames: normalizeEraNameList(eraNames),
    start,
    end,
    startAbs: start.abs,
    endAbs: explicitEndAbs ?? end?.abs ?? null,
    claimTrack,
    claimLabel,
    claimRole,
  };
}

export function dynastyReign(dynastyId, personId, title, posthumous, temple, startYear, endYear, eraNames = []) {
  return reign({
    id: `reign-${personId}-${dynastyId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    start: ym(startYear),
    end: ym(endYear, 12),
    eraNames,
  });
}

export function eras(_reignId, list) {
  return list.map((e) => e.name).filter(Boolean);
}

export function dr(dynastyId, personId, title, posthumous, temple, sy, ey, eraList = []) {
  const reignId = `reign-${personId}-${dynastyId}`;
  return dynastyReign(
    dynastyId,
    personId,
    title,
    posthumous,
    temple,
    sy,
    ey,
    eraList.length ? eras(reignId, eraList) : [],
  );
}


export function eventPoint(partial) {
  const atConfidence = endpointDateConfidence(partial.at?.confidence ?? partial.atConfidence, partial.at);
  const at = normalizeYearPrecisionAt(partial.at, atConfidence);
  return {
    kind: "other",
    timeMode: "point",
    dynastyIds: [],
    participantIds: [],
    ...partial,
    at,
    atAbs: at.abs,
  };
}

export function idiomPoint(partial) {
  if (!partial.meaning?.trim()) {
    throw new Error(`idiomPoint requires meaning: ${partial.id ?? partial.name ?? "unknown"}`);
  }
  const point = eventPoint({ ...partial, kind: "idiom" });
  return {
    ...point,
    kind: "idiom",
    meaning: partial.meaning.trim(),
  };
}

export function eventRange(partial) {
  const start = partial.start;
  const end = partial.end;
  const atConfidence = endpointDateConfidence(partial.at?.confidence ?? partial.atConfidence, partial.at);
  const at = partial.at ? normalizeYearPrecisionAt(partial.at, atConfidence) : undefined;
  return {
    kind: "other",
    timeMode: "span",
    dynastyIds: [],
    participantIds: [],
    ...partial,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    ...(at ? { at, atAbs: at.abs } : {}),
  };
}

export function successionPairs(list) {
  const pairs = [];
  for (let i = 0; i < list.length - 1; i++) pairs.push([list[i].personId, list[i + 1].personId]);
  return pairs;
}

export function personSql(p) {
  return `INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, birth_day, birth_confidence, death_year, death_month, death_day, death_confidence, roles, bio, links, posthumous_name, temple_name, title)
VALUES (${sqlStr(p.id)}, ${sqlStr(p.name)}, ${sqlArray(p.altNames ?? [])}, ${sqlStr(p.ancestralXing ?? null)}, ${sqlStr(p.clanShi ?? null)}, ${p.birth?.year ?? "NULL"}, ${p.birth?.month ?? "NULL"}, ${p.birth?.day ?? "NULL"}, ${sqlStr(p.birth ? p.birth.confidence ?? (p.birth.month !== 1 ? "month" : "year") : null)}, ${p.death?.year ?? "NULL"}, ${p.death?.month ?? "NULL"}, ${p.death?.day ?? "NULL"}, ${sqlStr(p.death ? p.death.confidence ?? (p.death.month !== 1 ? "month" : "year") : null)}, ${sqlArray(p.roles)}, ${sqlStr(p.bio)}, ${sqlJson(p.links)}, ${sqlStr(formatAppellationCsv(p.posthumousNames))}, ${sqlStr(formatAppellationCsv(p.templeNames))}, ${sqlStr(p.title ?? null)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, birth_day = EXCLUDED.birth_day, birth_confidence = EXCLUDED.birth_confidence, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, death_day = EXCLUDED.death_day, death_confidence = EXCLUDED.death_confidence, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;`;
}

export function dynastyLaneGroupSql(group) {
  return `INSERT INTO dynasty_lane_groups (id, primary_dynasty_id, phase_dynasty_ids, lane_order_start_abs, lane_order_end_abs)
VALUES (${sqlStr(group.id)}, ${sqlStr(group.primaryDynastyId)}, ${sqlArray(group.phaseDynastyIds)}, ${group.laneOrderStartAbs}, ${group.laneOrderEndAbs})
ON CONFLICT (id) DO UPDATE SET primary_dynasty_id = EXCLUDED.primary_dynasty_id, phase_dynasty_ids = EXCLUDED.phase_dynasty_ids, lane_order_start_abs = EXCLUDED.lane_order_start_abs, lane_order_end_abs = EXCLUDED.lane_order_end_abs;`;
}

export function dynastyGroupSql(g) {
  return `INSERT INTO dynasty_groups (id, name, alt_names, scope, start_year, start_month, start_day, start_confidence, end_year, end_month, end_day, end_confidence, start_abs, end_abs, note)
VALUES (${sqlStr(g.id)}, ${sqlStr(g.name)}, ${sqlArray(g.altNames ?? [])}, ${sqlStr(g.scope ?? "cn")}, ${g.start.year}, ${g.start.month}, ${g.start.day ?? "NULL"}, ${sqlStr(endpointDateConfidence(g.start.confidence, g.start))}, ${g.end.year}, ${g.end.month}, ${g.end.day ?? "NULL"}, ${sqlStr(endpointDateConfidence(g.end.confidence, g.end))}, ${g.start.abs}, ${g.end.abs}, ${sqlStr(g.note ?? null)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, scope = EXCLUDED.scope, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, start_confidence = EXCLUDED.start_confidence, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, end_confidence = EXCLUDED.end_confidence, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, note = EXCLUDED.note;`;
}

/** DB NOT NULL placeholder; runtime lane colors are assigned in the frontend. */
export const LEGACY_COLOR_TOKEN = "ochre";

export function dynastySql(d) {
  const groupId = d.groupId ? sqlStr(d.groupId) : "NULL";
  return `INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, start_day, start_confidence, end_year, end_month, end_day, end_confidence, start_abs, end_abs, color_token, parent_id, group_id, note)
VALUES (${sqlStr(d.id)}, ${sqlStr(d.name)}, ${sqlArray(d.altNames)}, ${sqlStr(d.scope)}, ${sqlStr(d.region)}, ${d.start.year}, ${d.start.month}, ${d.start.day ?? "NULL"}, ${sqlStr(endpointDateConfidence(d.start.confidence, d.start))}, ${d.end.year}, ${d.end.month}, ${d.end.day ?? "NULL"}, ${sqlStr(endpointDateConfidence(d.end.confidence, d.end))}, ${d.start.abs}, ${d.end.abs}, ${sqlStr(LEGACY_COLOR_TOKEN)}, NULL, ${groupId}, ${sqlStr(d.note)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, start_confidence = EXCLUDED.start_confidence, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, end_confidence = EXCLUDED.end_confidence, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;`;
}

export function reignSql(r) {
  const isMain = r.isMain;
  const hasClaimFields =
    Object.hasOwn(r, "claimTrack") || Object.hasOwn(r, "claimLabel") || Object.hasOwn(r, "claimRole");
  const claimCols =
    hasClaimFields ? ", claim_track, claim_label, claim_role" : "";
  const claimVals =
    hasClaimFields
      ? `, ${sqlStr(r.claimTrack ?? null)}, ${sqlStr(r.claimLabel ?? null)}, ${sqlStr(r.claimRole ?? null)}`
      : "";
  const claimUpdates =
    hasClaimFields ? ", claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role" : "";
  const informalCol = r.isInformalMonarch != null ? ", is_informal_monarch" : "";
  const informalVal = r.isInformalMonarch != null ? `, ${r.isInformalMonarch}` : "";
  const informalUpdate = r.isInformalMonarch != null ? ", is_informal_monarch = EXCLUDED.is_informal_monarch" : "";
  const mainCol = isMain != null ? ", is_main" : "";
  const mainVal = isMain != null ? `, ${isMain}` : "";
  const mainUpdate = isMain != null ? ", is_main = EXCLUDED.is_main" : "";
  const startConfidence = endpointDateConfidence(r.start.confidence ?? r.startConfidence, r.start);
  const endConfidence = endpointDateConfidence(r.end?.confidence ?? r.endConfidence, r.end);
  return `INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence${claimCols}${informalCol}${mainCol})
VALUES (${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(r.title ?? null)}, ${sqlStr(formatAppellationCsv(r.eraNames))}, ${r.start.year}, ${r.start.month}, ${r.start.day ?? "NULL"}, ${r.end?.year ?? "NULL"}, ${r.end?.month ?? "NULL"}, ${r.end?.day ?? "NULL"}, ${r.startAbs}, ${r.endAbs ?? "NULL"}, ${sqlStr(startConfidence)}, ${sqlStr(endConfidence)}${claimVals}${informalVal}${mainVal})
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, start_confidence = EXCLUDED.start_confidence, end_confidence = EXCLUDED.end_confidence${claimUpdates}${informalUpdate}${mainUpdate};`;
}

export function eventSql(e) {
  const at = e.at;
  const atConfidence = endpointDateConfidence(at?.confidence ?? e.atConfidence, at);
  const startConfidence = endpointDateConfidence(e.start?.confidence ?? e.startConfidence, e.start);
  const endConfidence = endpointDateConfidence(e.end?.confidence ?? e.endConfidence, e.end);
  const cols = ["id", "name", "kind", "time_mode", "at_confidence", "start_confidence", "end_confidence", "date_note", "at_year", "at_month", "at_day", "at_abs", "start_year", "start_month", "start_day", "start_abs", "end_year", "end_month", "end_day", "end_abs", "summary", "meaning", "content"];
  const vals = [sqlStr(e.id), sqlStr(e.name), sqlStr(e.kind), sqlStr(e.timeMode), sqlStr(at ? atConfidence : null), sqlStr(e.start ? startConfidence : null), sqlStr(e.end ? endConfidence : null), sqlStr(e.dateNote ?? null), at?.year ?? "NULL", at?.month ?? "NULL", at?.day ?? "NULL", at?.abs ?? e.atAbs ?? "NULL", e.start?.year ?? "NULL", e.start?.month ?? "NULL", e.start?.day ?? "NULL", e.startAbs ?? "NULL", e.end?.year ?? "NULL", e.end?.month ?? "NULL", e.end?.day ?? "NULL", e.endAbs ?? "NULL", sqlStr(e.summary ?? null), sqlStr(e.meaning ?? null), sqlStr(e.content ?? null)];
  return `INSERT INTO events (${cols.join(", ")}) VALUES (${vals.join(", ")})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, at_confidence = EXCLUDED.at_confidence, start_confidence = EXCLUDED.start_confidence, end_confidence = EXCLUDED.end_confidence, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_day = EXCLUDED.at_day, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;`;
}

export function locationSql(l) {
  return `INSERT INTO locations (id, modern_name, longitude, latitude, coordinate_system) VALUES (${sqlStr(l.id)}, ${sqlStr(l.modernName)}, ${l.longitude}, ${l.latitude}, ${sqlStr(l.coordinateSystem)}) ON CONFLICT(id) DO UPDATE SET modern_name=EXCLUDED.modern_name, longitude=EXCLUDED.longitude, latitude=EXCLUDED.latitude, coordinate_system=EXCLUDED.coordinate_system;`;
}

export function locationMappingSql(m) {
  if (Object.hasOwn(m, "claimTrack")) throw new Error(`Mapping ${m.id} must not store claimTrack`);
  if (/[（）()；;]/u.test(m.historicalName) || /代表点|会战|大战/u.test(m.historicalName)) throw new Error(`Mapping ${m.id} has an annotated historicalName`);
  const columns = ["id", "location_id", "kind", "external_id", "historical_name", "spatial_precision", "start_year", "start_month", "start_day", "end_year", "end_month", "end_day", "start_abs", "end_abs", "start_confidence", "end_confidence", "role", "note", "links"];
  const values = [sqlStr(m.id), sqlStr(m.locationId), sqlStr(m.kind), sqlStr(m.externalId), sqlStr(m.historicalName), sqlStr(m.spatialPrecision ?? null), m.start?.year ?? "NULL", m.start?.month ?? "NULL", m.start?.day ?? "NULL", m.end?.year ?? "NULL", m.end?.month ?? "NULL", m.end?.day ?? "NULL", m.startAbs ?? "NULL", m.endAbs ?? "NULL", sqlStr(m.start ? endpointDateConfidence(m.start.confidence ?? m.startConfidence, m.start) : null), sqlStr(m.end ? endpointDateConfidence(m.end.confidence ?? m.endConfidence, m.end) : null), sqlStr(m.kind === "event" ? null : m.role ?? "primary"), sqlStr(m.note ?? null), sqlJson(m.links ?? [])];
  return `INSERT INTO location_mapping (${columns.join(", ")}) VALUES (${values.join(", ")}) ON CONFLICT(id) DO UPDATE SET ${columns.slice(1).map(c => `${c}=EXCLUDED.${c}`).join(", ")};`;
}

function parseRef(raw) {
  const [type, ...rest] = raw.split(":");
  return { type, id: rest.join(":") };
}

export function relationSql(r) {
  const from = parseRef(r.fromRef);
  const to = parseRef(r.toRef);
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_day, at_abs, at_confidence, event_id) VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)}, ${r.at?.year ?? "NULL"}, ${r.at?.month ?? "NULL"}, ${r.at?.day ?? "NULL"}, ${r.atAbs ?? "NULL"}, ${sqlStr(endpointDateConfidence(r.at?.confidence ?? r.atConfidence, r.at))}, ${sqlStr(r.eventId ?? null)}) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_day = EXCLUDED.at_day, at_abs = EXCLUDED.at_abs, at_confidence = EXCLUDED.at_confidence, event_id = EXCLUDED.event_id;`;
}

/** Write a cache of already-resolved records without applying data-specific transformations. */
export function writePreparedImportPackage(dir, {
  slug,
  window = { startYear: 9999, startMonth: 1, endYear: 9999, endMonth: 12 },
  persons = [],
  dynastyGroups = [],
  dynastyLaneGroups = [],
  dynasties = [],
  locations = [],
  locationMappings = [],
  reigns = [],
  events = [],
  updates = [],
  relations = [],
  supplementalEventDynasties = [],
  supplementalEventParticipants = [],
  preSql = "",
  postSql = "",
  manifest,
}) {

  const eventDynastySql = events.flatMap((e) => e.dynastyIds.map((d) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(e.id)}, ${sqlStr(d)}) ON CONFLICT DO NOTHING;`));
  const supplementalEventDynastySql = supplementalEventDynasties.map(
    ({ eventId, dynastyId }) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(eventId)}, ${sqlStr(dynastyId)}) ON CONFLICT DO NOTHING;`,
  );
  const eventParticipantSql = events.flatMap((e) => e.participantIds.map((p) => `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(e.id)}, ${sqlStr(p)}) ON CONFLICT DO NOTHING;`));
  const supplementalEventParticipantSql = supplementalEventParticipants.map(
    ({ eventId, personId }) => `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(eventId)}, ${sqlStr(personId)}) ON CONFLICT DO NOTHING;`,
  );

  const sql = [
    `-- EraLens period import: ${slug}`,
    `-- Window: ${window.startYear}-${String(window.startMonth).padStart(2, "0")} .. ${window.endYear}-${String(window.endMonth).padStart(2, "0")}`,
    "BEGIN;",
    ...(preSql ? ["", "-- cleanup", preSql] : []),
    ...(persons.length ? ["", "-- persons", ...persons.map(personSql)] : []),
    ...(dynastyGroups.length ? ["", "-- dynasty_groups", ...dynastyGroups.map(dynastyGroupSql)] : []),
    ...(dynasties.length ? ["", "-- dynasties", ...dynasties.map(dynastySql)] : []),
    ...(locations.length ? ["", "-- locations", ...locations.map(locationSql)] : []),
    ...(dynastyLaneGroups.length ? ["", "-- dynasty_lane_groups", ...dynastyLaneGroups.map(dynastyLaneGroupSql)] : []),
    ...(reigns.length ? ["", "-- reigns", ...reigns.map(reignSql)] : []),
    ...(events.length ? ["", "-- events", ...events.map(eventSql)] : []),
    ...(eventDynastySql.length || supplementalEventDynastySql.length ? ["", "-- event_dynasties", ...eventDynastySql, ...supplementalEventDynastySql] : []),
    ...(eventParticipantSql.length || supplementalEventParticipantSql.length ? ["", "-- event_participants", ...eventParticipantSql, ...supplementalEventParticipantSql] : []),
    ...(relations.length ? ["", "-- relations", ...relations.map(relationSql)] : []),
    ...(locationMappings.length ? ["", "-- location_mapping", ...locationMappings.map(locationMappingSql)] : []),
    ...(updates.length ? ["", "-- updates", ...updates.map((update) => {
      const allowed = { persons: new Set(["bio"]), dynasties: new Set(["note"]) };
      if (!allowed[update.table]?.has(update.column)) throw new Error(`Unsupported cached update: ${update.table}.${update.column}`);
      return `UPDATE ${update.table} SET ${update.column} = ${sqlStr(update.value)} WHERE id = ${sqlStr(update.id)};`;
    })] : []),
    ...(postSql ? ["", postSql] : []),
    "", "COMMIT;", "",
  ].join("\n");

  mkdirSync(dir, { recursive: true });
  writeFileSync(path.join(dir, "import.sql"), sql);
  writeFileSync(path.join(dir, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);
  console.log(
    `[${slug}] ${persons.length} persons, ${dynasties.length} dynasties, ${locations.length} locations, ${locationMappings.length} mappings, ${reigns.length} reigns, ${events.length} events`,
  );
}
