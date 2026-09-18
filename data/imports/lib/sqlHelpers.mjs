import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { resolveOrthodoxEndAbs, resolveOrthodoxFromAbs } from "./orthodoxDynasties.mjs";
import { finalizeImportReigns } from "./missingReigns.mjs";

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
 * Year-precision `at` uses month 12 (lane year-end). January is the old
 * placeholder and is rewritten; a real January must be `precision: month`.
 */
export function normalizeYearPrecisionAt(at, precision = "year") {
  if (!at || precision !== "year" || at.day != null) return at;
  if (at.month !== 1) return at;
  return ym(at.year, 12);
}
export function wiki(title) {
  return [{ label: "维基百科", url: `https://zh.wikipedia.org/wiki/${title}` }];
}

export function person(id, name, roles, bio, wikiTitle, birth = null, death = null, altNames = []) {
  return { id, name, roles, bio, links: wiki(wikiTitle), birth, death, altNames };
}

export function reign({
  id,
  dynastyId,
  personId,
  title,
  posthumousName,
  templeName,
  preferred,
  start,
  end,
  precision = "year",
  startDateConfidence = null,
  endDateConfidence = null,
  eraNames = [],
}) {
  return {
    id,
    dynastyId,
    personId,
    title,
    posthumousName,
    templeName,
    preferredAppellation: preferred,
    eraNames,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    precision,
    startDateConfidence,
    endDateConfidence,
  };
}

export function dynastyReign(dynastyId, personId, title, posthumous, temple, startYear, endYear, eraNames = [], preferred = null) {
  return reign({
    id: `reign-${personId}-${dynastyId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    preferred,
    start: ym(startYear),
    end: ym(endYear, 12),
    eraNames,
  });
}

export function eras(reignId, list) {
  return list.map((e, i) => ({
    reignId,
    name: e.name,
    start: ym(e.sy, e.sm ?? 1),
    end: ym(e.ey, e.em ?? 12),
    sortOrder: i,
  }));
}

export function dr(dynastyId, personId, title, posthumous, temple, sy, ey, eraList = []) {
  const reignId = `reign-${personId}-${dynastyId}`;
  return dynastyReign(dynastyId, personId, title, posthumous, temple, sy, ey, eraList.length ? eras(reignId, eraList) : [], null);
}

export function eventPoint(partial) {
  const precision = partial.precision ?? "year";
  const at = normalizeYearPrecisionAt(partial.at, precision);
  return {
    kind: "other",
    timeMode: "point",
    precision: "year",
    dynastyIds: [],
    participantIds: [],
    ...partial,
    precision,
    at,
    atAbs: at.abs,
  };
}

export function eventRange(partial) {
  const start = partial.start;
  const end = partial.end;
  const precision = partial.precision ?? "year";
  const at = partial.at ? normalizeYearPrecisionAt(partial.at, precision) : undefined;
  return {
    kind: "other",
    precision: "year",
    dynastyIds: [],
    participantIds: [],
    ...partial,
    precision,
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
  return `INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (${sqlStr(p.id)}, ${sqlStr(p.name)}, ${sqlArray(p.altNames ?? [])}, ${sqlStr(p.ancestralXing ?? null)}, ${sqlStr(p.clanShi ?? null)}, ${p.birth?.year ?? "NULL"}, ${p.birth?.month ?? "NULL"}, ${p.death?.year ?? "NULL"}, ${p.death?.month ?? "NULL"}, ${sqlArray(p.roles)}, ${sqlStr(p.bio)}, ${sqlJson(p.links)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;`;
}

export function dynastyLaneGroupSql(group) {
  return `INSERT INTO dynasty_lane_groups (id, primary_dynasty_id, phase_dynasty_ids, lane_order_start_abs, lane_order_end_abs)
VALUES (${sqlStr(group.id)}, ${sqlStr(group.primaryDynastyId)}, ${sqlArray(group.phaseDynastyIds)}, ${group.laneOrderStartAbs}, ${group.laneOrderEndAbs})
ON CONFLICT (id) DO UPDATE SET primary_dynasty_id = EXCLUDED.primary_dynasty_id, phase_dynasty_ids = EXCLUDED.phase_dynasty_ids, lane_order_start_abs = EXCLUDED.lane_order_start_abs, lane_order_end_abs = EXCLUDED.lane_order_end_abs;`;
}

export function dynastyGroupSql(g) {
  return `INSERT INTO dynasty_groups (id, name, alt_names, scope, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, note)
VALUES (${sqlStr(g.id)}, ${sqlStr(g.name)}, ${sqlArray(g.altNames ?? [])}, ${sqlStr(g.scope ?? "cn")}, ${g.start.year}, ${g.start.month}, ${g.end.year}, ${g.end.month}, ${g.start.abs}, ${g.end.abs}, ${sqlStr(g.precision ?? "year")}, ${sqlStr(g.note ?? null)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, scope = EXCLUDED.scope, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, note = EXCLUDED.note;`;
}

export function dynastySql(d) {
  const orthodoxFromAbs = resolveOrthodoxFromAbs(d);
  const orthodoxEndAbs = resolveOrthodoxEndAbs(d);
  const groupId = d.groupId ? sqlStr(d.groupId) : "NULL";
  return `INSERT INTO dynasties (id, name, ancestral_xing, clan_shi, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES (${sqlStr(d.id)}, ${sqlStr(d.name)}, ${sqlStr(d.ancestralXing ?? null)}, ${sqlStr(d.clanShi ?? null)}, ${sqlArray(d.altNames)}, ${sqlStr(d.scope)}, ${sqlStr(d.region)}, ${d.start.year}, ${d.start.month}, ${d.end.year}, ${d.end.month}, ${d.start.abs}, ${d.end.abs}, ${sqlStr(d.precision)}, ${sqlStr(d.colorToken)}, ${orthodoxFromAbs ?? "NULL"}, ${orthodoxEndAbs ?? "NULL"}, NULL, ${groupId}, ${sqlStr(d.note)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;`;
}

export function reignSql(r) {
  return `INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES (${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(r.title)}, ${sqlStr(r.posthumousName ?? null)}, ${sqlStr(r.templeName ?? null)}, ${sqlJson(r.preferredAppellation)}, ${r.start.year}, ${r.start.month}, ${r.start.day ?? "NULL"}, ${r.end.year}, ${r.end.month}, ${r.end.day ?? "NULL"}, ${r.startAbs}, ${r.endAbs}, ${sqlStr(r.precision)}, ${sqlStr(r.startDateConfidence ?? null)}, ${sqlStr(r.endDateConfidence ?? null)})
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;`;
}

export function eraNameSql(e) {
  return `INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES (${sqlStr(e.reignId)}, ${sqlStr(e.name)}, ${e.start.year}, ${e.start.month}, ${e.end.year}, ${e.end.month}, ${e.start.abs}, ${e.end.abs}, ${e.sortOrder});`;
}

export function eventSql(e) {
  const at = normalizeYearPrecisionAt(e.at, e.precision ?? "year");
  const cols = ["id", "name", "kind", "time_mode", "precision", "date_note", "at_year", "at_month", "at_abs", "start_year", "start_month", "start_abs", "end_year", "end_month", "end_abs", "summary"];
  const vals = [sqlStr(e.id), sqlStr(e.name), sqlStr(e.kind), sqlStr(e.timeMode), sqlStr(e.precision), sqlStr(e.dateNote ?? null), at?.year ?? "NULL", at?.month ?? "NULL", at?.abs ?? "NULL", e.start?.year ?? "NULL", e.start?.month ?? "NULL", e.startAbs ?? "NULL", e.end?.year ?? "NULL", e.end?.month ?? "NULL", e.endAbs ?? "NULL", sqlStr(e.summary ?? null)];
  return `INSERT INTO events (${cols.join(", ")}) VALUES (${vals.join(", ")})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;`;
}

function parseRef(raw) {
  const [type, ...rest] = raw.split(":");
  return { type, id: rest.join(":") };
}

export function relationSql(r) {
  const from = parseRef(r.fromRef);
  const to = parseRef(r.toRef);
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id) VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)}, ${r.at?.year ?? "NULL"}, ${r.at?.month ?? "NULL"}, ${r.atAbs ?? "NULL"}, ${sqlStr(r.precision ?? null)}, ${sqlStr(r.eventId ?? null)}) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;`;
}

export function writeImportPackage(dir, { slug, window, persons, dynastyGroups = [], dynasties, reignGroups, reigns, events, relations, supplementalEventDynasties = [], supplementalEventParticipants = [], preSql = "", missingReigns = [], manifest }) {
  const finalized = finalizeImportReigns(slug, persons, reigns, missingReigns);
  persons = finalized.persons;
  reigns = finalized.reigns;
  missingReigns = finalized.missingReigns;

  const reignsWithEras = reigns.filter((r) => r.eraNames.length > 0);
  const eraDeleteSql = reignsWithEras.map((r) => `DELETE FROM era_names WHERE reign_id = ${sqlStr(r.id)};`);
  const eraInsertSql = reignsWithEras.flatMap((r) => r.eraNames.map(eraNameSql));
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
    "", "-- persons", ...persons.map(personSql),
    ...(dynastyGroups.length ? ["", "-- dynasty_groups", ...dynastyGroups.map(dynastyGroupSql)] : []),
    "", "-- dynasties", ...dynasties.map(dynastySql),
    "", "-- reigns", ...reigns.map(reignSql),
    "", "-- era_names", ...eraDeleteSql, ...eraInsertSql,
    "", "-- events", ...events.map(eventSql),
    "", "-- event_dynasties", ...eventDynastySql, ...supplementalEventDynastySql,
    "", "-- event_participants", ...eventParticipantSql, ...supplementalEventParticipantSql,
    "", "-- relations", ...relations.map(relationSql),
    "", "COMMIT;", "",
  ].join("\n");

  mkdirSync(dir, { recursive: true });
  writeFileSync(path.join(dir, "import.sql"), sql);
  writeFileSync(path.join(dir, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);
  console.log(
    `[${slug}] ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns (${missingReigns.length} missing), ${events.length} events`,
  );
}

export const colorTokens = ["ochre", "indigo", "cinnabar", "moss", "wisteria", "grape", "stone", "mineral"];
let colorIdx = 0;
export function nextColor() {
  return colorTokens[colorIdx++ % colorTokens.length];
}
