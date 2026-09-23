#!/usr/bin/env node
/**
 * Generate EraLens import SQL for the Mongol Empire before the Yuan Dynasty (1206–1271).
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import { finalizeImportReigns, sqlDeleteSystemMissingReigns } from "../lib/missingReigns.mjs";
import { reignSql as formatReignSql } from "../lib/reignSql.mjs";
import { ymDay } from "../lib/reignDateHelpers.mjs";
import { dynastySql, formatAppellationCsv, mergeAppellationsIntoPersons, normalizeYearPrecisionAt, personSql } from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

function toAstroYear(year) {
  return year > 0 ? year : year + 1;
}
function absMonth(year, month = 1) {
  return toAstroYear(year) * 12 + (month - 1);
}
function sqlStr(value) {
  if (value == null) return "NULL";
  return `'${String(value).replace(/'/g, "''")}'`;
}
function sqlArray(values) {
  if (!values?.length) return "ARRAY[]::text[]";
  return `ARRAY[${values.map(sqlStr).join(",")}]`;
}
function sqlJson(value) {
  if (value == null) return "NULL";
  return `${sqlStr(JSON.stringify(value))}::jsonb`;
}
function ym(year, month = 1) {
  return { year, month, abs: absMonth(year, month) };
}
function wiki(title) {
  return [{ label: "维基百科", url: `https://zh.wikipedia.org/wiki/${title}` }];
}

function person(id, name, roles, bio, wikiTitle, birth = null, death = null) {
  return { id, name, roles, bio, links: wiki(wikiTitle), birth, death };
}

function reign({ id, dynastyId, personId, title, posthumousName, templeName, start, end, precision = "year", eraNames = [] }) {
  return { id, dynastyId, personId, title, posthumousName, templeName, eraNames, start, end, startAbs: start.abs, endAbs: end.abs, precision };
}

function dynastyReign(dynastyId, personId, title, posthumous, temple, startYear, endYear) {
  const reignId = `reign-${personId}-${dynastyId}`;
  return reign({ id: reignId, dynastyId, personId, title, posthumousName: posthumous, templeName: temple, start: ym(startYear), end: ym(endYear, 12) });
}

function dr(dynastyId, personId, title, posthumous, temple, sy, ey) {
  return dynastyReign(dynastyId, personId, title, posthumous, temple, sy, ey);
}


// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  person("temujin", "铁木真", ["大汗"], "成吉思汗，统一蒙古诸部，1206年建国，开创大蒙古国。", "成吉思汗", { year: 1162 }, { year: 1227 }),
  person("ogedei", "窝阔台", ["大汗"], "蒙古帝国第二任大汗，成吉思汗第三子，灭金、西征欧洲。", "窝阔台"),
  person("guyuk", "贵由", ["大汗"], "蒙古帝国第三任大汗，窝阔台之子，在位不足两年。", "贵由"),
  person("mongke", "蒙哥", ["大汗"], "蒙古帝国第四任大汗，拖雷长子，攻宋、灭大理，帝国分裂前最后一位普遍承认的大汗。", "蒙哥"),
  person("hu-bilie", "忽必烈", ["大汗", "皇帝"], "成吉思汗之孙，1260年即位大汗，1271年定国号大元；元朝皇帝见 yuan-ming-qing。", "忽必烈"),
  person("ariq-boke", "阿里不哥", ["大汗"], "拖雷幼子，1260年与忽必烈争位，1264年败亡。", "阿里不哥"),
  person("tolui", "拖雷", ["宗王"], "成吉思汗幼子，1227–1229年监国，蒙哥、忽必烈、阿里不哥之父。", "拖雷"),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "mongol-empire",
    name: "蒙古帝国",
    altNames: ["大蒙古国", "蒙古汗国"],
    scope: "cn",
    region: "east_asia",
    start: ym(1206),
    end: ym(1271, 12),
    precision: "year",
    note: "1206年铁木真称成吉思汗建国；1271年忽必烈定国号大元，中原史语境转入元朝。帝国诸汗国此后分治。",
  },
];

// ── reigns ─────────────────────────────────────────────────────────────────

const mongolReigns = [
  dr("mongol-empire", "temujin", "成吉思汗", "法天启运圣武皇帝", "太祖", 1206, 1227, { kind: "regnal", name: "成吉思汗" }),
  dr("mongol-empire", "ogedei", "窝阔台汗", "英文皇帝", "太宗", 1229, 1241, { kind: "regnal", name: "窝阔台汗" }),
  dr("mongol-empire", "guyuk", "贵由汗", "钦定皇帝", "定宗", 1246, 1248, { kind: "regnal", name: "贵由汗" }),
  dr("mongol-empire", "mongke", "蒙哥汗", "桓肃皇帝", "宪宗", 1251, 1259, { kind: "regnal", name: "蒙哥汗" }),
  dr("mongol-empire", "hu-bilie", "薛禅汗", null, null, 1260, 1271, { kind: "regnal", name: "薛禅汗" }),
];

const reignGroups = [mongolReigns];
const reigns = applyDocumentedDatesToReigns(reignGroups.flat());

// ── events ───────────────────────────────────────────────────────────────────

function eventPoint(partial) {
  const precision = partial.precision ?? "year";
  const at = normalizeYearPrecisionAt(partial.at, precision);
  return { kind: "other", timeMode: "point", precision: "year", dynastyIds: [], participantIds: [], ...partial, precision, at, atAbs: at.abs };
}
function eventRange(partial) {
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
    timeMode: partial.timeMode ?? "span",
  };
}

const events = [
  eventRange({
    id: "mongol-campaign-jin",
    name: "蒙古攻金",
    kind: "battle",
    timeMode: "span",
    start: ym(1211),
    end: ym(1234),
    dynastyIds: ["mongol-empire", "jin-nvzhen"],
    participantIds: ["temujin", "ogedei"],
    summary: "成吉思汗至窝阔台时期对金朝发动长期战争，1234年蔡州陷落，金亡。",
  }),
  eventRange({
    id: "mongol-west-campaign",
    name: "西征花剌子模",
    kind: "battle",
    timeMode: "circa",
    dateNote: "1219–1225年，史料月日不一",
    start: ym(1219),
    end: ym(1225),
    at: ym(1221),
    dynastyIds: ["mongol-empire"],
    participantIds: ["temujin"],
    summary: "成吉思汗率军西征花剌子模，兵锋远达中亚，奠定蒙古西征格局。",
  }),
  eventRange({
    id: "tolui-regency",
    name: "拖雷监国",
    kind: "politics",
    timeMode: "circa",
    dateNote: "1227–1229年，库里尔台推举窝阔台前",
    start: ym(1227),
    end: ym(1229),
    dynastyIds: ["mongol-empire"],
    participantIds: ["tolui"],
    summary: "成吉思汗去世后幼子拖雷监国，两年后库里尔台推举窝阔台继位。",
  }),
  eventPoint({
    id: "mongke-death",
    name: "蒙哥汗驾崩",
    kind: "politics",
    dateNote: "1259年攻宋四川军中",
    at: ym(1259),
    dynastyIds: ["mongol-empire"],
    participantIds: ["mongke"],
    summary: "蒙哥汗攻宋途中于四川去世，忽必烈与阿里不哥随即展开汗位之争。",
  }),
  eventRange({
    id: "great-khan-contention",
    name: "忽必烈与阿里不哥争位",
    kind: "politics",
    timeMode: "span",
    start: ym(1260),
    end: ym(1264),
    dynastyIds: ["mongol-empire"],
    participantIds: ["hu-bilie", "ariq-boke"],
    summary: "蒙哥死后忽必烈与阿里不哥各举忽里台互不承认，1264年忽必烈获胜，帝国走向分裂。",
  }),
  eventRange({
    id: "mongol-campaign-song",
    name: "蒙古攻宋",
    kind: "battle",
    timeMode: "span",
    start: ym(1235),
    end: ym(1279),
    dynastyIds: ["mongol-empire", "song-south"],
    participantIds: ["hu-bilie", "mongke"],
    summary: "蒙古自窝阔台至忽必烈长期南征，经襄樊之战、崖山海战，最终灭南宋。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "song-jin-alliance-mongol", dynastyId: "mongol-empire" },
  { eventId: "mongol-campaign-song", dynastyId: "song-south" },
  { eventId: "xiangyang-siege", dynastyId: "mongol-empire" },
];
const supplementalEventParticipants = [
  { eventId: "song-jin-alliance-mongol", personId: "ogedei" },
];

// ── relations ────────────────────────────────────────────────────────────────

function successionPairs(list) {
  const pairs = [];
  for (let i = 0; i < list.length - 1; i++) pairs.push([list[i].personId, list[i + 1].personId]);
  return pairs;
}

const relations = [];
for (const group of reignGroups) {
  for (const [fromId, toId] of successionPairs(group)) {
    relations.push({ id: `rel-${fromId}-${toId}-succession`, fromRef: `person:${fromId}`, toRef: `person:${toId}`, kind: "succession" });
  }
}
relations.push(
  { id: "rel-great-khan-hu-bilie", fromRef: "event:great-khan-contention", toRef: "person:hu-bilie", kind: "battle" },
  { id: "rel-great-khan-ariq-boke", fromRef: "event:great-khan-contention", toRef: "person:ariq-boke", kind: "battle" },
  { id: "rel-mongol-song-hu-bilie", fromRef: "event:mongol-campaign-song", toRef: "person:hu-bilie", kind: "battle" },
  { id: "rel-temujin-tolui-succession", fromRef: "person:temujin", toRef: "person:tolui", kind: "other" },
);

// ── SQL ──────────────────────────────────────────────────────────────────────

function reignSql(r) {
  return formatReignSql(r, sqlStr, sqlJson, formatAppellationCsv);
}
function eventSql(e) {
  const cols = ["id", "name", "kind", "time_mode", "precision", "date_note", "at_year", "at_month", "at_abs", "start_year", "start_month", "start_abs", "end_year", "end_month", "end_abs", "summary"];
  const vals = [sqlStr(e.id), sqlStr(e.name), sqlStr(e.kind), sqlStr(e.timeMode), sqlStr(e.precision), sqlStr(e.dateNote ?? null), e.at?.year ?? "NULL", e.at?.month ?? "NULL", e.atAbs ?? "NULL", e.start?.year ?? "NULL", e.start?.month ?? "NULL", e.startAbs ?? "NULL", e.end?.year ?? "NULL", e.end?.month ?? "NULL", e.endAbs ?? "NULL", sqlStr(e.summary ?? null)];
  return `INSERT INTO events (${cols.join(", ")}) VALUES (${vals.join(", ")}) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;`;
}
function parseRef(raw) {
  const [type, ...rest] = raw.split(":");
  return { type, id: rest.join(":") };
}
function relationSql(r) {
  const from = parseRef(r.fromRef);
  const to = parseRef(r.toRef);
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)}) ON CONFLICT (id) DO NOTHING;`;
}

const eventDynastySql = events.flatMap((e) => e.dynastyIds.map((d) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(e.id)}, ${sqlStr(d)}) ON CONFLICT DO NOTHING;`));
const supplementalEventDynastySql = supplementalEventDynasties.map(
  ({ eventId, dynastyId }) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(eventId)}, ${sqlStr(dynastyId)}) ON CONFLICT DO NOTHING;`,
);
const eventParticipantSql = events.flatMap((e) => e.participantIds.map((p) => `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(e.id)}, ${sqlStr(p)}) ON CONFLICT DO NOTHING;`));
const supplementalEventParticipantSql = supplementalEventParticipants.map(
  ({ eventId, personId }) => `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(eventId)}, ${sqlStr(personId)}) ON CONFLICT DO NOTHING;`,
);

const finalized = finalizeImportReigns(
  "mongol-pre-yuan",
  persons,
  reigns,
);
const { persons: importPersons, reigns: importReigns } = mergeAppellationsIntoPersons(
  finalized.persons,
  finalized.reigns,
);

const sql = [
  "-- EraLens period import: mongol-pre-yuan",
  "-- Window: 1206-01 .. 1271-12",
  "BEGIN;",
  "",
  "-- remove stale auto-generated 史料缺 (regency gaps are intentional blanks)",
  sqlDeleteSystemMissingReigns(["mongol-empire"], sqlStr),
  "",
  "-- persons",
  ...importPersons.map(personSql),
  "",
  "-- dynasties",
  ...dynasties.map(dynastySql),
  "",
  "-- reigns",
  ...importReigns.map(reignSql),
  "",
  "-- events",
  ...events.map(eventSql),
  "",
  "-- event_dynasties",
  ...eventDynastySql,
  ...supplementalEventDynastySql,
  "",
  "-- event_participants",
  ...eventParticipantSql,
  ...supplementalEventParticipantSql,
  "",
  "-- relations",
  ...relations.map(relationSql),
  "",
  "COMMIT;",
  "",
].join("\n");

mkdirSync(__dirname, { recursive: true });
writeFileSync(path.join(__dirname, "import.sql"), sql);

const manifest = {
  slug: "mongol-pre-yuan",
  title: "元朝建立前的蒙古帝国",
  window: { startYear: 1206, startMonth: 1, endYear: 1271, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-12",
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "蒙古帝国", url: "https://zh.wikipedia.org/wiki/蒙古帝国" },
    { label: "成吉思汗", url: "https://zh.wikipedia.org/wiki/成吉思汗" },
    { label: "窝阔台", url: "https://zh.wikipedia.org/wiki/窝阔台" },
    { label: "蒙哥", url: "https://zh.wikipedia.org/wiki/蒙哥" },
    { label: "忽必烈", url: "https://zh.wikipedia.org/wiki/忽必烈" },
    { label: "蒙古帝国大汗列表", url: "https://zh.wikipedia.org/wiki/蒙古帝国大汗列表" },
  ],
  notes: [
    "覆盖大蒙古国（1206–1271），五位普遍承认的大汗：成吉思汗、窝阔台、贵由、蒙哥、忽必烈（薛禅汗）。",
    "1227–1229拖雷监国、1241–1246乃马真称制、1248–1251海迷失称制以事件收录，不建 reign；大汗间隔留白（同唐武周留白）。",
    "忽必烈 1271 年定国号大元后见 yuan-ming-qing；本包 reign-hu-bilie-mongol-empire 止于 1271。",
    "联蒙灭金事件见 song-liao-jin，本包补充 mongol-empire 关联。",
    "未收录钦察、伊利、察合台等汗国分治时期。",
    "在位年取维基百科君主列表，precision=year。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);
console.log(`Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`);
