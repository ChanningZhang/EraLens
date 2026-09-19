#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Republic of China heads of state.
 * Warlords are persons only, not separate dynasties.
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { dynastySql, normalizeYearPrecisionAt, personSql } from "../lib/sqlHelpers.mjs";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import { ymDay } from "../lib/reignDateHelpers.mjs";
import { finalizeImportReigns, sqlDeleteSystemMissingReigns } from "../lib/missingReigns.mjs";
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

function person(id, name, roles, bio, wikiTitle, birth = null, death = null, altNames = []) {
  return { id, name, roles, bio, links: wiki(wikiTitle), birth, death, altNames };
}

function reign({ id, dynastyId, personId, title, posthumousName, templeName, preferred, start, end, precision = "year", eraNames = [] }) {
  return { id, dynastyId, personId, title, posthumousName, templeName, preferredAppellation: preferred, eraNames, start, end, startAbs: start.abs, endAbs: end.abs, precision };
}

function rocOffice({ id, personId, title, start, end }) {
  const [sy, sm, sd] = start;
  const [ey, em, ed] = end;
  return reign({
    id: id ?? `reign-${personId}-roc`,
    dynastyId: "roc",
    personId,
    title,
    posthumousName: null,
    templeName: null,
    preferred: { kind: "regnal", name: title },
    start: sd != null ? { ...ym(sy, sm), day: sd } : ym(sy, sm),
    end: ed != null ? { ...ym(ey, em), day: ed } : ym(ey, em),
    precision: sd != null && ed != null ? "day" : "month",
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
  person("jiang-jieshi", "蒋介石", ["军事家", "政治家"], "黄埔军校校长，北伐统一，曾任国民政府主席；1949年迁台后继续主政，1975年卒于台北。", "蒋介石", ym(1887, 10), ym(1975, 4), ["蒋中正"]),
  person("li-zongren", "李宗仁", ["军事家", "政治家"], "桂系首领，蒋中正引退后代理元首，1950年蒋复行视事后解除代理。", "李宗仁"),
  person("tan-yankai", "谭延闿", ["政治家"], "国民党元老，宁汉合流后任南京国民政府主席，后任行政院院长。", "谭延闿", ym(1880, 1), ym(1930, 9), ["谭延闓"]),
  person("yan-jiagan", "严家淦", ["政治家"], "蒋中正逝世后继任台湾地区领导人。", "严家淦", ym(1905, 10), ym(1993, 12)),
  person("jiang-jingguo", "蒋经国", ["政治家"], "蒋中正长子，继任领导人，任内推动十大建设。", "蒋经国", ym(1910, 4), ym(1988, 1)),
  person("li-denghui", "李登辉", ["政治家"], "蒋经国逝世后继任，后为首次全民直选当选的领导人。", "李登辉", ym(1923, 1), ym(2020, 7)),
  person("chen-shuibian", "陈水扁", ["政治家"], "2000年当选，行宪后首次政党轮替。", "陈水扁", ym(1950, 10)),
  person("ma-yingjiu", "马英九", ["政治家"], "2008年当选领导人，行宪后第二次政党轮替。", "马英九", ym(1950, 7)),
  person("cai-yingwen", "蔡英文", ["政治家"], "2016年当选，首位女性领导人。", "蔡英文", ym(1956, 8)),
  person("lai-qingde", "赖清德", ["政治家"], "2024年就任台湾地区领导人。", "赖清德", ym(1959, 10)),
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
    end: ym(2026, 9),
    precision: "month",
    note: "1912年孙中山任临时大总统肇建；1949年中央迁台后续统。正统金色截于1949年9月。元首收录截至2026年9月。",
  },
];

// ── reigns（国家元首）──────────────────────────────────────────────────────

const rocReigns = [
  rocOffice({ personId: "sun-yat-sen", title: "临时大总统", start: [1912, 1, 1], end: [1912, 3, 10] }),
  rocOffice({ personId: "yuan-shikai", title: "大总统", start: [1912, 3, 10], end: [1916, 6, 6] }),
  rocOffice({ personId: "li-yuanhong", title: "大总统", start: [1916, 6, 7], end: [1917, 7, 6] }),
  rocOffice({ personId: "feng-guozhang", title: "代理大总统", start: [1917, 7, 6], end: [1918, 10, 10] }),
  rocOffice({ personId: "xu-shichang", title: "大总统", start: [1918, 10, 10], end: [1922, 6, 2] }),
  rocOffice({ id: "reign-li-yuanhong-roc-2", personId: "li-yuanhong", title: "大总统", start: [1922, 6, 11], end: [1923, 6, 13] }),
  rocOffice({ personId: "cao-kun", title: "大总统", start: [1923, 10, 10], end: [1924, 11, 2] }),
  rocOffice({ personId: "duan-qirui", title: "临时执政", start: [1924, 11, 24], end: [1926, 4, 20] }),
  rocOffice({ personId: "zhang-zuolin", title: "陆海军大元帅", start: [1927, 6, 18], end: [1928, 6, 3] }),
  rocOffice({ personId: "tan-yankai", title: "国民政府主席", start: [1928, 6, 4], end: [1928, 10, 10] }),
  rocOffice({ id: "reign-jiang-jieshi-chairman-1-roc", personId: "jiang-jieshi", title: "国民政府主席", start: [1928, 10, 10], end: [1931, 12, 15] }),
  rocOffice({ personId: "lin-sen", title: "国民政府主席", start: [1931, 12, 15], end: [1943, 8, 1] }),
  rocOffice({ id: "reign-jiang-jieshi-chairman-roc", personId: "jiang-jieshi", title: "国民政府主席", start: [1943, 8, 1], end: [1948, 5, 20] }),
  rocOffice({ personId: "jiang-jieshi", title: "总统", start: [1948, 5, 20], end: [1949, 1, 21] }),
  rocOffice({ personId: "li-zongren", title: "代总统", start: [1949, 1, 21], end: [1950, 3, 1] }),
  rocOffice({ id: "reign-jiang-jieshi-roc-2", personId: "jiang-jieshi", title: "总统", start: [1950, 3, 1], end: [1975, 4, 5] }),
  rocOffice({ personId: "yan-jiagan", title: "总统", start: [1975, 4, 6], end: [1978, 5, 20] }),
  rocOffice({ personId: "jiang-jingguo", title: "总统", start: [1978, 5, 20], end: [1988, 1, 13] }),
  rocOffice({ personId: "li-denghui", title: "总统", start: [1988, 1, 13], end: [2000, 5, 20] }),
  rocOffice({ personId: "chen-shuibian", title: "总统", start: [2000, 5, 20], end: [2008, 5, 20] }),
  rocOffice({ personId: "ma-yingjiu", title: "总统", start: [2008, 5, 20], end: [2016, 5, 20] }),
  rocOffice({ personId: "cai-yingwen", title: "总统", start: [2016, 5, 20], end: [2024, 5, 20] }),
  rocOffice({ personId: "lai-qingde", title: "总统", start: [2024, 5, 20], end: [2026, 9] }),
];

// 孙中山护法军政府、广州/武汉国民政府（1925–1928 汪兆铭等）及汪精卫伪政权不建 reign
// 国务院摄行（周自齐、高凌霨、黄郛、胡惟德、颜惠庆、杜锡珪、顾维钧）不建 reign，空档留白

const reignGroups = [rocReigns];
const reigns = applyDocumentedDatesToReigns(rocReigns);

// ── events ───────────────────────────────────────────────────────────────────

function eventPoint(partial) {
  const precision = partial.precision ?? "year";
  const at = normalizeYearPrecisionAt(partial.at, precision);
  return { kind: "other", timeMode: "point", precision, dynastyIds: [], participantIds: [], ...partial, precision, at, atAbs: at.abs };
}
function eventRange(partial) {
  const start = partial.start;
  const end = partial.end;
  const precision = partial.precision ?? "year";
  const at = partial.at ? normalizeYearPrecisionAt(partial.at, precision) : undefined;
  return {
    kind: "other",
    precision,
    dynastyIds: [],
    participantIds: [],
    timeMode: partial.timeMode ?? "span",
    ...partial,
    precision,
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
  eventPoint({
    id: "puyi-leaves-forbidden-city",
    name: "溥仪出宫",
    kind: "politics",
    precision: "day",
    dateNote: "1924年11月5日，国民军将溥仪逐出紫禁城",
    at: ymDay(1924, 11, 5),
    dynastyIds: ["roc", "qing"],
    participantIds: ["puyi", "feng-yuxiang"],
    summary: "冯玉祥北京政变后执行修正清室优待条件，溥仪被逐出紫禁城，逊清小朝廷终结。",
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
  for (let i = 0; i < list.length - 1; i++) {
    const fromId = list[i].personId;
    const toId = list[i + 1].personId;
    if (fromId === toId) continue;
    pairs.push([fromId, toId]);
  }
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

function reignSql(r) {
  return formatReignSql(r, sqlStr, sqlJson);
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
  "-- Window: 1912-01 .. 2026-09",
  "-- Warlords as persons only; single roc dynasty row",
  "BEGIN;",
  "",
  "-- remove stale auto-generated 史料缺 (元首空缺期应留白)",
  sqlDeleteSystemMissingReigns(["roc"], sqlStr),
  "DELETE FROM relations WHERE id = 'rel-jiang-jieshi-jiang-jieshi-succession';",
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
  title: "中华民国",
  window: { startYear: 1912, startMonth: 1, endYear: 2026, endMonth: 9 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-19",
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
    "覆盖中华民国（1912–2026-09），单行 roc 王朝；各路军阀仅作 persons，不建独立王朝。中华人民共和国不在本包内。",
    "国家元首按维基百科「中华民国国家元首列表」收录（临时大总统、大总统、国民政府主席、总统）。连任不拆卡。",
    "孙中山（sun-yat-sen）复用已有 id。蒋介石分四段：国民政府主席 1928–1931、1943–1948，总统 1948–1949、1950–1975。",
    "不收录：护法军政府、1925–1928 广州/武汉国民政府（汪兆铭等，维基详表仅列 1928 年后主席）、汪精卫伪政权。",
    "国务院摄行（周自齐、高凌霨、黄郛、胡惟德、颜惠庆、杜锡珪、顾维钧）不建 reign，空档留白，不标史料缺。",
    "谭延闿维基自 1928-02-07 任南京国民政府主席，与张作霖安国军政府并立至 6 月；主线自张作霖 1928-06-03 离京后接谭，避免叠卡。",
    "正统金色截于 1949 年 9 月（十月一日中华人民共和国成立后迁台续统不上金）。1950 年起界面称「台湾地区 · 领导人」，人物概述不用「总统」。赖清德任期收录截至 2026-09。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);
console.log(`Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`);
