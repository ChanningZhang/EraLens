import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { resolveOrthodoxEndAbs, resolveOrthodoxFromAbs } from "./orthodoxDynasties.mjs";
import { finalizeImportReigns } from "./missingReigns.mjs";
import { PERSON_TITLE_SELECTIONS } from "./personTitleSelections.mjs";
import { resolveReignTitle } from "./reignTitleSelections.mjs";

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

export function formatAppellationCsv(values) {
  if (!values?.length) return null;
  const cleaned = values.map((v) => String(v).trim()).filter(Boolean);
  return cleaned.length ? cleaned.join(",") : null;
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
  precision = "year",
  startDateConfidence = null,
  endDateConfidence = null,
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
    endAbs: end.abs,
    precision,
    startDateConfidence,
    endDateConfidence,
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

/** Move reign-level 庙谥 onto person rows before SQL export. */
export function mergeAppellationsIntoPersons(persons, reigns) {
  const personMap = new Map(persons.map((p) => [p.id, { ...p, posthumousNames: [...(p.posthumousNames ?? [])], templeNames: [...(p.templeNames ?? [])] }]));
  for (const reign of reigns) {
    const person = personMap.get(reign.personId);
    if (!person) continue;
    if (reign.posthumousName && !person.posthumousNames.includes(reign.posthumousName)) {
      person.posthumousNames.push(reign.posthumousName);
    }
    if (reign.templeName && !person.templeNames.includes(reign.templeName)) {
      person.templeNames.push(reign.templeName);
    }
  }
  const lastReignByPerson = new Map();
  for (const reign of reigns) {
    const current = lastReignByPerson.get(reign.personId);
    if (!current || reign.startAbs > current.startAbs || (reign.startAbs === current.startAbs && (reign.endAbs > current.endAbs || (reign.endAbs === current.endAbs && reign.id.localeCompare(current.id) > 0)))) {
      lastReignByPerson.set(reign.personId, reign);
    }
  }
  for (const person of personMap.values()) {
    person.title = PERSON_TITLE_SELECTIONS[person.id] ?? lastReignByPerson.get(person.id)?.title ?? person.title ?? null;
  }
  return {
    persons: [...personMap.values()],
    reigns: reigns.map((r) => ({
      ...r,
      eraNames: normalizeEraNameList(r.eraNames),
    })),
  };
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
  const precision = partial.precision ?? "year";
  const at = partial.at ? normalizeYearPrecisionAt(partial.at, precision) : undefined;
  return {
    kind: "other",
    timeMode: "span",
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
  return `INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES (${sqlStr(p.id)}, ${sqlStr(p.name)}, ${sqlArray(p.altNames ?? [])}, ${sqlStr(p.ancestralXing ?? null)}, ${sqlStr(p.clanShi ?? null)}, ${p.birth?.year ?? "NULL"}, ${p.birth?.month ?? "NULL"}, ${p.death?.year ?? "NULL"}, ${p.death?.month ?? "NULL"}, ${sqlArray(p.roles)}, ${sqlStr(p.bio)}, ${sqlJson(p.links)}, ${sqlStr(formatAppellationCsv(p.posthumousNames))}, ${sqlStr(formatAppellationCsv(p.templeNames))}, ${sqlStr(p.title ?? null)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;`;
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

/** DB NOT NULL placeholder; runtime lane colors are assigned in the frontend. */
export const LEGACY_COLOR_TOKEN = "ochre";

export function dynastySql(d) {
  const orthodoxFromAbs = resolveOrthodoxFromAbs(d);
  const orthodoxEndAbs = resolveOrthodoxEndAbs(d);
  const groupId = d.groupId ? sqlStr(d.groupId) : "NULL";
  return `INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES (${sqlStr(d.id)}, ${sqlStr(d.name)}, ${sqlArray(d.altNames)}, ${sqlStr(d.scope)}, ${sqlStr(d.region)}, ${d.start.year}, ${d.start.month}, ${d.end.year}, ${d.end.month}, ${d.start.abs}, ${d.end.abs}, ${sqlStr(d.precision)}, ${sqlStr(LEGACY_COLOR_TOKEN)}, ${orthodoxFromAbs ?? "NULL"}, ${orthodoxEndAbs ?? "NULL"}, NULL, ${groupId}, ${sqlStr(d.note)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;`;
}

export function reignSql(r) {
  const claimCols =
    r.claimTrack != null || r.claimLabel != null || r.claimRole != null
      ? ", claim_track, claim_label, claim_role"
      : "";
  const claimVals =
    r.claimTrack != null || r.claimLabel != null || r.claimRole != null
      ? `, ${sqlStr(r.claimTrack ?? null)}, ${sqlStr(r.claimLabel ?? null)}, ${sqlStr(r.claimRole ?? null)}`
      : "";
  const claimUpdates =
    r.claimTrack != null || r.claimLabel != null || r.claimRole != null
      ? ", claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role"
      : "";
  const informalCol = r.isInformalMonarch != null ? ", is_informal_monarch" : "";
  const informalVal = r.isInformalMonarch != null ? `, ${r.isInformalMonarch}` : "";
  const informalUpdate = r.isInformalMonarch != null ? ", is_informal_monarch = EXCLUDED.is_informal_monarch" : "";
  return `INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence${claimCols}${informalCol})
VALUES (${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(resolveReignTitle(r))}, ${sqlStr(formatAppellationCsv(r.eraNames))}, ${r.start.year}, ${r.start.month}, ${r.start.day ?? "NULL"}, ${r.end.year}, ${r.end.month}, ${r.end.day ?? "NULL"}, ${r.startAbs}, ${r.endAbs}, ${sqlStr(r.precision)}, ${sqlStr(r.startDateConfidence ?? null)}, ${sqlStr(r.endDateConfidence ?? null)}${claimVals}${informalVal})
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence${claimUpdates}${informalUpdate};`;
}

export function eventSql(e) {
  const at = normalizeYearPrecisionAt(e.at, e.precision ?? "year");
  const cols = ["id", "name", "kind", "time_mode", "precision", "date_note", "at_year", "at_month", "at_abs", "start_year", "start_month", "start_abs", "end_year", "end_month", "end_abs", "summary", "meaning", "content"];
  const vals = [sqlStr(e.id), sqlStr(e.name), sqlStr(e.kind), sqlStr(e.timeMode), sqlStr(e.precision), sqlStr(e.dateNote ?? null), at?.year ?? "NULL", at?.month ?? "NULL", at?.abs ?? "NULL", e.start?.year ?? "NULL", e.start?.month ?? "NULL", e.startAbs ?? "NULL", e.end?.year ?? "NULL", e.end?.month ?? "NULL", e.endAbs ?? "NULL", sqlStr(e.summary ?? null), sqlStr(e.meaning ?? null), sqlStr(e.content ?? null)];
  return `INSERT INTO events (${cols.join(", ")}) VALUES (${vals.join(", ")})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;`;
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

export function dynastyCapitalSql(c) {
  return `INSERT INTO dynasty_capitals (id, dynasty_id, historical_name, modern_name, longitude, latitude, coordinate_system, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, role, claim_track, note, links)
VALUES (${sqlStr(c.id)}, ${sqlStr(c.dynastyId)}, ${sqlStr(c.historicalName)}, ${sqlStr(c.modernName)}, ${c.longitude}, ${c.latitude}, ${sqlStr(c.coordinateSystem ?? "GCJ02")}, ${c.start.year}, ${c.start.month}, ${c.start.day ?? "NULL"}, ${c.end.year}, ${c.end.month}, ${c.end.day ?? "NULL"}, ${c.startAbs}, ${c.endAbs}, ${sqlStr(c.precision ?? "year")}, ${sqlStr(c.startDateConfidence ?? null)}, ${sqlStr(c.endDateConfidence ?? null)}, ${sqlStr(c.role ?? "primary")}, ${sqlStr(c.claimTrack ?? null)}, ${sqlStr(c.note ?? null)}, ${sqlJson(c.links ?? [])})
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, role = EXCLUDED.role, claim_track = EXCLUDED.claim_track, note = EXCLUDED.note, links = EXCLUDED.links;`;
}

export function writeImportPackage(dir, { slug, window, persons, dynastyGroups = [], dynasties, capitals = [], reignGroups, reigns, events, relations, supplementalEventDynasties = [], supplementalEventParticipants = [], preSql = "", missingReigns = [], manifest }) {
  const finalized = finalizeImportReigns(slug, persons, reigns, missingReigns);
  persons = finalized.persons;
  reigns = finalized.reigns;
  missingReigns = finalized.missingReigns;

  ({ persons, reigns } = mergeAppellationsIntoPersons(persons, reigns));

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
    ...(capitals.length ? ["", "-- dynasty_capitals", ...capitals.map(dynastyCapitalSql)] : []),
    "", "-- reigns", ...reigns.map(reignSql),
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
