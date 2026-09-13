#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Western Xia (西夏, 982–1227).
 * Tangut Li clan; empire declared 1038; overlaps Song–Liao–Jin era.
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { defaultPreferredAppellation } from "../lib/defaultPreferredAppellation.mjs";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import { finalizeImportReigns } from "../lib/missingReigns.mjs";
import { reignSql as formatReignSql } from "../lib/reignSql.mjs";

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

function reign({
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
  };
}

function dynastyReign(dynastyId, personId, title, posthumous, temple, startYear, endYear, eraNames = [], preferred = null) {
  const pref =
    preferred ??
    defaultPreferredAppellation({ title, posthumous, temple, startYear, eraNames });
  return reign({
    id: `reign-${personId}-${dynastyId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    preferred: pref,
    start: ym(startYear),
    end: ym(endYear, 12),
    eraNames,
  });
}

function eras(reignId, list) {
  return list.map((e, i) => ({
    reignId,
    name: e.name,
    start: ym(e.sy, e.sm ?? 1),
    end: ym(e.ey, e.em ?? 12),
    sortOrder: i,
  }));
}

function dr(dynastyId, personId, title, posthumous, temple, sy, ey, eraList = []) {
  const reignId = `reign-${personId}-${dynastyId}`;
  return dynastyReign(dynastyId, personId, title, posthumous, temple, sy, ey, eraList.length ? eras(reignId, eraList) : [], null);
}

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  person("li-jiqian", "李继迁", ["君主"], "党项首领，982年叛宋自立，奠定西夏基业；追谥夏太祖。", "李继迁"),
  person("li-deming", "李德明", ["君主"], "李继迁之子，1004年嗣位，与宋辽修好，为李元昊称帝奠基。", "李德明"),
  person("li-yuanhao", "李元昊", ["皇帝"], "夏景宗，1038年称帝，国号大夏，创西夏文字，屡败宋军。", "李元昊", ym(1003), ym(1048)),
  person("li-liangzuo", "李谅祚", ["皇帝"], "夏毅宗，幼年即位，母没藏太后摄政，1064年亲政。", "李谅祚"),
  person("li-bingchang", "李秉常", ["皇帝"], "夏惠宗，幼年即位，母梁太后摄政，与宋长期交战。", "李秉常"),
  person("li-qianshun", "李乾顺", ["皇帝"], "夏崇宗，在位五十余年，西夏国力鼎盛期之一。", "李乾顺"),
  person("li-renxiao", "李仁孝", ["皇帝"], "夏仁宗，推行儒学，设科举，西夏文化繁荣。", "李仁孝"),
  person("li-chunyou", "李纯佑", ["皇帝"], "夏桓宗，在位十三年，蒙古势力崛起之际。", "李纯佑"),
  person("li-anquan", "李安全", ["皇帝"], "夏襄宗，篡位夺嫡，1211年蒙古首次大举攻夏。", "李安全"),
  person("li-zunxu", "李遵顼", ["皇帝"], "夏神宗，蒙古反复侵夏，国力日衰。", "李遵顼"),
  person("li-dewang", "李德旺", ["皇帝"], "夏献宗，1223年嗣位，蒙古持续围攻。", "李德旺"),
  person("li-xian-xixia", "李睍", ["皇帝"], "夏末帝，1226年即位，1227年西夏亡于蒙古。", "李睍"),
  person("mo-nang-e-pang", "没藏讹庞", ["政治家", "军事家"], "西夏权臣，毅宗朝没藏太后之父，长期摄政干政。", "没藏讹庞"),
  person("liang-taihou", "梁太后", ["后妃", "政治家"], "惠宗李秉常之母，两度摄政，主张对宋用兵。", "梁太后"),
];

// ── dynasties ────────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "xixia",
    name: "西夏",
    altNames: ["大夏", "党项西夏"],
    scope: "cn",
    region: "east_asia",
    start: ym(982),
    end: ym(1227),
    precision: "year",
    colorToken: "grape",
    note: "党项李氏，982年李继迁叛宋自立；1038年李元昊称帝，国号大夏；1227年蒙古攻灭。",
  },
];

// ── reigns ───────────────────────────────────────────────────────────────────

const xixiaReigns = [
  dr("xixia", "li-jiqian", "夏太祖", "光天皇帝", "太祖", 982, 1004),
  dr("xixia", "li-deming", "西夏王", null, null, 1004, 1031),
  dr("xixia", "li-yuanhao", "夏景宗", "武烈皇帝", "景宗", 1031, 1048, [
    { name: "显道", sy: 1032, ey: 1034 },
    { name: "开运", sy: 1034, ey: 1036 },
    { name: "广运", sy: 1036, ey: 1038 },
    { name: "大庆", sy: 1038, ey: 1044 },
    { name: "天授礼法延祚", sy: 1044, ey: 1048 },
  ]),
  dr("xixia", "li-liangzuo", "夏毅宗", "昭英皇帝", "毅宗", 1048, 1067),
  dr("xixia", "li-bingchang", "夏惠宗", "昭简皇帝", "惠宗", 1067, 1086),
  dr("xixia", "li-qianshun", "夏崇宗", "康靖皇帝", "崇宗", 1086, 1139, [
    { name: "天安礼定", sy: 1086, ey: 1089 },
    { name: "贞观", sy: 1089, ey: 1139 },
  ]),
  dr("xixia", "li-renxiao", "夏仁宗", "圣德皇帝", "仁宗", 1139, 1193, [{ name: "乾佑", sy: 1139, ey: 1193 }]),
  dr("xixia", "li-chunyou", "夏桓宗", "昭简皇帝", "桓宗", 1193, 1206),
  dr("xixia", "li-anquan", "夏襄宗", "敬穆皇帝", "襄宗", 1206, 1211),
  dr("xixia", "li-zunxu", "夏神宗", "英武皇帝", "神宗", 1211, 1223),
  dr("xixia", "li-dewang", "夏献宗", "南平王", "献宗", 1223, 1226),
  // Stable id reign-li-xian-xixia (person was li-xian before rename to li-xian-xixia).
  reign({
    id: "reign-li-xian-xixia",
    dynastyId: "xixia",
    personId: "li-xian-xixia",
    title: "夏末帝",
    posthumousName: null,
    templeName: null,
    preferred: defaultPreferredAppellation({
      title: "夏末帝",
      posthumous: null,
      temple: null,
      startYear: 1226,
      eraNames: [],
    }),
    start: ym(1226),
    end: ym(1227, 12),
    precision: "year",
    eraNames: [],
  }),
];

const reignGroups = [xixiaReigns];
const reigns = applyDocumentedDatesToReigns(reignGroups.flat());

// ── events ───────────────────────────────────────────────────────────────────

function eventPoint(partial) {
  const at = partial.at;
  return { kind: "other", timeMode: "point", precision: "year", dynastyIds: [], participantIds: [], ...partial, at, atAbs: at.abs };
}

const events = [
  eventPoint({
    id: "xixia-li-jiqian-rebel",
    name: "李继迁叛宋",
    kind: "politics",
    at: ym(982),
    dynastyIds: ["xixia"],
    participantIds: ["li-jiqian"],
    summary: "党项首领李继迁叛宋，据有夏州，西夏政权肇始。",
  }),
  eventPoint({
    id: "xixia-yuanhao-empire",
    name: "李元昊称帝",
    kind: "politics",
    at: ym(1038),
    dynastyIds: ["xixia"],
    participantIds: ["li-yuanhao"],
    summary: "李元昊称帝，国号大夏，定都兴庆府，与宋辽金并立。",
  }),
  eventPoint({
    id: "xixia-haoshuichuan-battle",
    name: "好水川之战",
    kind: "battle",
    at: ym(1040),
    dynastyIds: ["xixia", "song-north"],
    participantIds: ["li-yuanhao"],
    summary: "李元昊设伏于好水川，大败宋军，宋名将任福等阵亡。",
  }),
  eventPoint({
    id: "xixia-qingli-treaty",
    name: "宋夏庆历和议",
    kind: "politics",
    at: ym(1044),
    dynastyIds: ["xixia", "song-north"],
    participantIds: ["li-yuanhao"],
    summary: "宋夏议和，宋承认西夏帝号，岁赐银绢，双方罢兵。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "mongol-fall-xixia", dynastyId: "xixia" },
];

const supplementalEventParticipants = [
  { eventId: "mongol-fall-xixia", personId: "li-xian-xixia" },
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
  { id: "rel-xixia-yuanhao-empire", fromRef: "event:xixia-yuanhao-empire", toRef: "dynasty:xixia", kind: "other" },
  { id: "rel-xixia-haoshuichuan-yuanhao", fromRef: "event:xixia-haoshuichuan-battle", toRef: "person:li-yuanhao", kind: "battle" },
  { id: "rel-mongol-fall-xixia", fromRef: "event:mongol-fall-xixia", toRef: "dynasty:xixia", kind: "battle" },
);

// ── SQL helpers ─────────────────────────────────────────────────────────────

function personSql(p) {
  return `INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (${sqlStr(p.id)}, ${sqlStr(p.name)}, ${p.birth?.year ?? "NULL"}, ${p.birth?.month ?? "NULL"}, ${p.death?.year ?? "NULL"}, ${p.death?.month ?? "NULL"}, ${sqlArray(p.roles)}, ${sqlStr(p.bio)}, ${sqlJson(p.links)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;`;
}

function dynastySql(d) {
  return `INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, parent_id, note)
VALUES (${sqlStr(d.id)}, ${sqlStr(d.name)}, ${sqlArray(d.altNames)}, ${sqlStr(d.scope)}, ${sqlStr(d.region)}, ${d.start.year}, ${d.start.month}, ${d.end.year}, ${d.end.month}, ${d.start.abs}, ${d.end.abs}, ${sqlStr(d.precision)}, ${sqlStr(d.colorToken)}, NULL, ${sqlStr(d.note)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, note = EXCLUDED.note;`;
}

function reignSql(r) {
  return formatReignSql(r, sqlStr, sqlJson);
}

function eraNameSql(e) {
  return `INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES (${sqlStr(e.reignId)}, ${sqlStr(e.name)}, ${e.start.year}, ${e.start.month}, ${e.end.year}, ${e.end.month}, ${e.start.abs}, ${e.end.abs}, ${e.sortOrder});`;
}

function eventSql(e) {
  const cols = ["id", "name", "kind", "time_mode", "precision", "date_note", "at_year", "at_month", "at_abs", "start_year", "start_month", "start_abs", "end_year", "end_month", "end_abs", "summary"];
  const vals = [sqlStr(e.id), sqlStr(e.name), sqlStr(e.kind), sqlStr(e.timeMode), sqlStr(e.precision), sqlStr(e.dateNote ?? null), e.at?.year ?? "NULL", e.at?.month ?? "NULL", e.atAbs ?? "NULL", e.start?.year ?? "NULL", e.start?.month ?? "NULL", e.startAbs ?? "NULL", e.end?.year ?? "NULL", e.end?.month ?? "NULL", e.endAbs ?? "NULL", sqlStr(e.summary ?? null)];
  return `INSERT INTO events (${cols.join(", ")}) VALUES (${vals.join(", ")})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;`;
}

function parseRef(raw) {
  const [type, ...rest] = raw.split(":");
  return { type, id: rest.join(":") };
}

function relationSql(r) {
  const from = parseRef(r.fromRef);
  const to = parseRef(r.toRef);
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)}) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;`;
}

const { persons: importPersons, reigns: importReigns } = finalizeImportReigns("xixia", persons, reigns);

const reignsWithEras = importReigns.filter((r) => r.eraNames.length > 0);
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
  "-- EraLens period import: xixia",
  "-- Window: 982-01 .. 1227-12",
  "BEGIN;",
  "", "-- persons", ...importPersons.map(personSql),
  "", "-- dynasties", ...dynasties.map(dynastySql),
  "",
  "-- cleanup renamed / orphaned reigns (li-xian person id collision with 唐中宗)",
  "DELETE FROM era_names WHERE reign_id = 'reign-li-xian-xixia-xixia';",
  "DELETE FROM reigns WHERE id = 'reign-li-xian-xixia-xixia';",
  "",
  "-- reigns",
  ...importReigns.map(reignSql),
  "", "-- era_names", ...eraDeleteSql, ...eraInsertSql,
  "", "-- events", ...events.map(eventSql),
  "", "-- event_dynasties", ...eventDynastySql, ...supplementalEventDynastySql,
  "", "-- event_participants", ...eventParticipantSql, ...supplementalEventParticipantSql,
  "", "-- relations", ...relations.map(relationSql),
  "", "COMMIT;", "",
].join("\n");

mkdirSync(__dirname, { recursive: true });
writeFileSync(path.join(__dirname, "import.sql"), sql);

const manifest = {
  slug: "xixia",
  title: "西夏（党项大夏）",
  window: { startYear: 982, startMonth: 1, endYear: 1227, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-13",
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "西夏", url: "https://zh.wikipedia.org/wiki/西夏" },
    { label: "西夏君主列表", url: "https://zh.wikipedia.org/wiki/西夏君主列表" },
    { label: "李元昊", url: "https://zh.wikipedia.org/wiki/李元昊" },
    { label: "好水川之战", url: "https://zh.wikipedia.org/wiki/好水川之战" },
    { label: "庆历和议", url: "https://zh.wikipedia.org/wiki/庆历和议" },
    { label: "蒙古灭西夏", url: "https://zh.wikipedia.org/wiki/蒙古攻灭西夏" },
  ],
  notes: [
    "覆盖西夏李氏十二世君主（982–1227），与宋辽金并立。",
    "王朝始年取李继迁叛宋自立（982），1038年李元昊称帝国号大夏。",
    "「蒙古灭西夏」事件见 mongol-pre-yuan 包，本包补充 event_dynasties / event_participants 关联。",
    "在位年取维基百科君主列表常见年表，precision=year。",
    "《射雕英雄传》西夏公主等为小说虚构人物，未收录。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);

console.log(`Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`);
