#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Republic of China (1912–1949).
 * Warlords are persons only, not separate dynasties.
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { dynastySql } from "../lib/sqlHelpers.mjs";
import { finalizeImportReigns } from "../lib/missingReigns.mjs";

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

function reign({ id, dynastyId, personId, title, posthumousName, templeName, preferred, start, end, precision = "year", eraNames = [] }) {
  return { id, dynastyId, personId, title, posthumousName, templeName, preferredAppellation: preferred, eraNames, start, end, startAbs: start.abs, endAbs: end.abs, precision };
}

function dr(dynastyId, personId, title, sy, ey, sm = 1, em = 12, precision = "year") {
  return reign({
    id: `reign-${personId}-${dynastyId}`,
    dynastyId,
    personId,
    title,
    posthumousName: null,
    templeName: null,
    preferred: { kind: "regnal", name: title },
    start: ym(sy, sm),
    end: ym(ey, em),
    precision,
  });
}

// ── persons ────────────────────────────────────────────────────────────────
// sun-yat-sen 已在 yuan-ming-qing 导入

const warlords = [
  person("yuan-shikai", "袁世凯", ["政治家", "军事家"], "北洋首领，曾任大总统，称帝失败。", "袁世凯"),
  person("li-yuanhong", "黎元洪", ["政治家"], "武昌起义后任湖北都督，后两度任大总统。", "黎元洪"),
  person("feng-guozhang", "冯国璋", ["军事家", "政治家"], "直系军阀首领，曾任副总统、大总统。", "冯国璋"),
  person("xu-shichang", "徐世昌", ["政治家"], "北洋元老，曾任大总统。", "徐世昌"),
  person("cao-kun", "曹锟", ["军事家", "政治家"], "直系军阀，贿选大总统。", "曹锟"),
  person("zhang-zuolin", "张作霖", ["军事家", "政治家"], "奉系军阀首领，据东北，皇姑屯事件中遇刺。", "张作霖"),
  person("lin-sen", "林森", ["政治家"], "国民政府主席，长期虚位元首。", "林森"),
  person("jiang-jieshi", "蒋介石", ["军事家", "政治家"], "黄埔军校校长，北伐统一，后任总统，1949年退台。", "蒋介石"),
  person("li-zongren", "李宗仁", ["军事家", "政治家"], "桂系首领，曾任代总统。", "李宗仁"),
  // 军阀（仅人物）
  person("duan-qirui", "段祺瑞", ["军事家", "政治家"], "皖系军阀首领，曾任国务总理、临时执政。", "段祺瑞"),
  person("wu-peifu", "吴佩孚", ["军事家"], "直系军阀，「玉帅」，北洋名将。", "吴佩孚"),
  person("sun-chuanfang", "孙传芳", ["军事家"], "直系军阀，据东南五省。", "孙传芳"),
  person("feng-yuxiang", "冯玉祥", ["军事家"], "西北军首领，北京政变发动者。", "冯玉祥"),
  person("yan-xishan", "阎锡山", ["军事家", "政治家"], "晋系军阀，据山西三十八年。", "阎锡山"),
  person("lu-rongting", "陆荣廷", ["军事家"], "旧桂系军阀，据广西。", "陆荣廷"),
  person("tang-jiyao", "唐继尧", ["军事家", "政治家"], "滇系军阀，据云南。", "唐继尧"),
  person("long-yun", "龙云", ["军事家", "政治家"], "滇系军阀，云南王。", "龙云"),
  person("liu-xiang", "刘湘", ["军事家"], "川系军阀，四川王。", "刘湘"),
  person("liu-wenhui", "刘文辉", ["军事家"], "川系军阀，刘湘之叔。", "刘文辉"),
  person("chen-jiongming", "陈炯明", ["军事家", "政治家"], "粤系军阀，曾叛孙中山。", "陈炯明"),
  person("ma-bufang", "马步芳", ["军事家"], "马家军，据青海。", "马步芳"),
  person("cai-e", "蔡锷", ["军事家"], "护国战争领袖，滇军名将。", "蔡锷"),
  person("zhang-xueliang", "张学良", ["军事家"], "奉系继承人，西安事变发动者，东北易帜。", "张学良"),
  person("zhou-enlai", "周恩来", ["政治家"], "中共领导人，国共合作与抗战时期重要人物。", "周恩来"),
  person("mao-zedong", "毛泽东", ["政治家", "军事家"], "中国共产党主要缔造者，1949年建立中华人民共和国。", "毛泽东"),
];

const persons = warlords;

// ── dynasty ────────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "roc",
    name: "中华民国",
    altNames: ["民国"],
    scope: "cn",
    region: "east_asia",
    start: ym(1912, 1),
    end: ym(1949, 12),
    precision: "month",
    colorToken: "indigo",
    note: "1912年孙中山任临时大总统，定都南京；1949年国民政府迁台，大陆时期结束。",
  },
];

// ── reigns（国家元首）──────────────────────────────────────────────────────

const rocReigns = [
  dr("roc", "sun-yat-sen", "临时大总统", 1912, 1912, 1, 4, "month"),
  dr("roc", "yuan-shikai", "大总统", 1912, 1916, 3, 6),
  dr("roc", "li-yuanhong", "大总统", 1916, 1917),
  dr("roc", "feng-guozhang", "大总统", 1917, 1918),
  dr("roc", "xu-shichang", "大总统", 1918, 1922),
  dr("roc", "cao-kun", "大总统", 1923, 1924),
  dr("roc", "zhang-zuolin", "陆海军大元帅", 1927, 1928, 6, 6),
  dr("roc", "lin-sen", "国民政府主席", 1932, 1943),
  reign({
    id: "reign-jiang-jieshi-chairman-roc",
    dynastyId: "roc",
    personId: "jiang-jieshi",
    title: "国民政府主席",
    posthumousName: null,
    templeName: null,
    preferred: { kind: "regnal", name: "国民政府主席" },
    start: ym(1943),
    end: ym(1948, 5),
    precision: "year",
  }),
  dr("roc", "jiang-jieshi", "总统", 1948, 1949, 5, 12, "month"),
  dr("roc", "li-zongren", "代总统", 1949, 1949, 1, 12, "month"),
];

// 孙中山护法时期不另建 reign，以事件「护法运动」表示
// 蒋介石 1928–1948 主导国民政府，1932–1943 林森为名义主席

const reignGroups = [rocReigns];
const reigns = rocReigns;

// ── events ───────────────────────────────────────────────────────────────────

function eventPoint(partial) {
  const at = partial.at;
  return { kind: "other", timeMode: "point", precision: partial.precision ?? "year", dynastyIds: [], participantIds: [], ...partial, at, atAbs: at.abs };
}
function eventRange(partial) {
  const start = partial.start;
  const end = partial.end;
  const at = partial.at;
  return {
    kind: "other",
    precision: partial.precision ?? "year",
    dynastyIds: [],
    participantIds: [],
    timeMode: partial.timeMode ?? "span",
    ...partial,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    ...(at ? { at, atAbs: at.abs } : {}),
  };
}

const events = [
  eventPoint({
    id: "roc-founded",
    name: "中华民国成立",
    kind: "politics",
    precision: "month",
    dateNote: "1912年1月1日，孙中山就任临时大总统",
    at: ym(1912, 1),
    dynastyIds: ["roc", "qing"],
    participantIds: ["sun-yat-sen"],
    summary: "南京临时政府成立，孙中山就任临时大总统，民国肇建。",
  }),
  eventPoint({
    id: "yuan-shikai-emperor",
    name: "袁世凯称帝",
    kind: "politics",
    at: ym(1915, 12),
    dynastyIds: ["roc"],
    participantIds: ["yuan-shikai"],
    summary: "袁世凯改国号中华帝国，遭全国反对，83天后取消。",
  }),
  eventRange({
    id: "national-protection-war",
    name: "护国战争",
    kind: "battle",
    dateNote: "1915–1916年，蔡锷等讨袁",
    start: ym(1915, 12),
    end: ym(1916, 6),
    dynastyIds: ["roc"],
    participantIds: ["cai-e", "yuan-shikai", "tang-jiyao"],
    summary: "蔡锷、唐继尧等起兵讨袁，袁世凯称帝失败。",
  }),
  eventPoint({
    id: "may-fourth",
    name: "五四运动",
    kind: "politics",
    precision: "month",
    dateNote: "1919年5月4日",
    at: ym(1919, 5),
    dynastyIds: ["roc"],
    participantIds: [],
    summary: "北京学生抗议巴黎和会山东问题，新文化运动与爱国运动高潮。",
  }),
  eventRange({
    id: "warlord-era",
    name: "军阀割据",
    kind: "politics",
    dateNote: "1916年袁死至1928年东北易帜，北洋诸系及地方军阀混战",
    start: ym(1916),
    end: ym(1928),
    dynastyIds: ["roc"],
    participantIds: ["duan-qirui", "wu-peifu", "zhang-zuolin", "yan-xishan", "feng-yuxiang", "lu-rongting", "tang-jiyao", "liu-xiang"],
    summary: "北洋分裂，直皖直奉混战，地方割据，中央名义大于实权。",
  }),
  eventRange({
    id: "northern-expedition",
    name: "北伐战争",
    kind: "battle",
    start: ym(1926, 7),
    end: ym(1928, 12),
    dynastyIds: ["roc"],
    participantIds: ["jiang-jieshi"],
    summary: "国民革命军自广州北伐，推翻北洋军阀，统一全国。",
  }),
  eventPoint({
    id: "northeast-flag-change",
    name: "东北易帜",
    kind: "politics",
    at: ym(1928, 12),
    dynastyIds: ["roc"],
    participantIds: ["zhang-xueliang"],
    summary: "张学良宣布服从国民政府，改挂青天白日旗，名义上全国统一。",
  }),
  eventPoint({
    id: "mukden-incident",
    name: "九一八事变",
    kind: "battle",
    precision: "month",
    dateNote: "1931年9月18日",
    at: ym(1931, 9),
    dynastyIds: ["roc"],
    participantIds: ["zhang-xueliang"],
    summary: "日本关东军发动事变，侵占东北，十四年抗战开始。",
  }),
  eventPoint({
    id: "xi-an-incident",
    name: "西安事变",
    kind: "politics",
    precision: "month",
    dateNote: "1936年12月12日",
    at: ym(1936, 12),
    dynastyIds: ["roc"],
    participantIds: ["zhang-xueliang", "jiang-jieshi", "zhou-enlai"],
    summary: "张学良、杨虎城逼蒋抗日，和平解决，国共二次合作。",
  }),
  eventRange({
    id: "resistance-war",
    name: "抗日战争",
    kind: "battle",
    dateNote: "1937–1945年，全面抗战",
    start: ym(1937, 7),
    end: ym(1945, 9),
    dynastyIds: ["roc"],
    participantIds: ["jiang-jieshi", "mao-zedong", "zhou-enlai", "yan-xishan"],
    summary: "全民族抗战，1945年日本投降，台湾光复。",
  }),
  eventRange({
    id: "civil-war",
    name: "解放战争",
    kind: "battle",
    start: ym(1946),
    end: ym(1949, 12),
    dynastyIds: ["roc"],
    participantIds: ["jiang-jieshi", "mao-zedong", "li-zongren"],
    summary: "国共内战，三大战役后国民党退守台湾，大陆政权更迭。",
  }),
  eventPoint({
    id: "roc-mainland-end",
    name: "国民政府迁台",
    kind: "politics",
    precision: "month",
    dateNote: "1949年12月，中央迁台北，大陆时期结束",
    at: ym(1949, 12),
    dynastyIds: ["roc"],
    participantIds: ["jiang-jieshi", "li-zongren"],
    summary: "解放军渡江后国民党退守台湾，中华民国大陆时期终结。",
  }),
];

// Link existing xinhai event to roc if we upsert event_dynasties
const extraEventDynasties = [
  { eventId: "xinhai-revolution", dynastyId: "roc" },
  { eventId: "qing-fall", dynastyId: "roc" },
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
  { id: "rel-northern-jiang", fromRef: "event:northern-expedition", toRef: "person:jiang-jieshi", kind: "battle" },
  { id: "rel-xian-zhang", fromRef: "event:xi-an-incident", toRef: "person:zhang-xueliang", kind: "battle" },
  { id: "rel-protection-cai-e", fromRef: "event:national-protection-war", toRef: "person:cai-e", kind: "battle" },
);

// ── SQL ──────────────────────────────────────────────────────────────────────

function personSql(p) {
  return `INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links) VALUES (${sqlStr(p.id)}, ${sqlStr(p.name)}, ${p.birth?.year ?? "NULL"}, ${p.birth?.month ?? "NULL"}, ${p.death?.year ?? "NULL"}, ${p.death?.month ?? "NULL"}, ${sqlArray(p.roles)}, ${sqlStr(p.bio)}, ${sqlJson(p.links)}) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;`;
}
function reignSql(r) {
  return `INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision) VALUES (${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(r.title)}, ${sqlStr(r.posthumousName ?? null)}, ${sqlStr(r.templeName ?? null)}, ${sqlJson(r.preferredAppellation)}, ${r.start.year}, ${r.start.month}, ${r.end.year}, ${r.end.month}, ${r.startAbs}, ${r.endAbs}, ${sqlStr(r.precision)}) ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;`;
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
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)}) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;`;
}

const eventDynastySql = [
  ...events.flatMap((e) => e.dynastyIds.map((d) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(e.id)}, ${sqlStr(d)}) ON CONFLICT DO NOTHING;`)),
  ...extraEventDynasties.map(({ eventId, dynastyId }) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(eventId)}, ${sqlStr(dynastyId)}) ON CONFLICT DO NOTHING;`),
];
const eventParticipantSql = events.flatMap((e) => e.participantIds.map((p) => `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(e.id)}, ${sqlStr(p)}) ON CONFLICT DO NOTHING;`));

const { persons: importPersons, reigns: importReigns } = finalizeImportReigns("minguo", persons, reigns);

const sql = [
  "-- EraLens period import: minguo",
  "-- Window: 1912-01 .. 1949-12",
  "-- Warlords as persons only; single roc dynasty row",
  "BEGIN;",
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
  "",
  "-- event_participants",
  ...eventParticipantSql,
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
  slug: "minguo",
  title: "中华民国（大陆时期）",
  window: { startYear: 1912, startMonth: 1, endYear: 1949, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-12",
  counts: { persons: persons.length, dynasties: dynasties.length, reigns: reigns.length, events: events.length, relations: relations.length },
  sources: [
    { label: "中华民国", url: "https://zh.wikipedia.org/wiki/中华民国" },
    { label: "中华民国国家元首列表", url: "https://zh.wikipedia.org/wiki/中华民国国家元首列表" },
    { label: "北洋政府", url: "https://zh.wikipedia.org/wiki/北洋政府" },
    { label: "军阀", url: "https://zh.wikipedia.org/wiki/军阀" },
    { label: "五四运动", url: "https://zh.wikipedia.org/wiki/五四运动" },
    { label: "抗日战争", url: "https://zh.wikipedia.org/wiki/抗日战争" },
  ],
  notes: [
    "覆盖中华民国大陆时期（1912–1949），单行 roc 王朝；各路军阀仅作 persons，不建独立王朝。",
    "国家元首以 reign 卡片收录（临时大总统、大总统、国民政府主席、总统等）。",
    "孙中山（sun-yat-sen）复用已有 id；蒋介石 1928–1948 实际主政以事件关联，1948 年起 reign。",
    "段祺瑞临时执政、汪精卫伪政权等未建 reign；军阀割据以 span 事件「军阀割据」概括。",
    "1949 迁台后之台湾时期不在本包内；中华人民共和国不在本包内。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);
console.log(`Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`);
