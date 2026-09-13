#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Song–Liao–Jin rivalry (916–1234).
 * Southern Song (1127–1279) context; reuses song-north/song-south from sui-tang-wudai-song.
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { defaultPreferredAppellation } from "../lib/defaultPreferredAppellation.mjs";
import { finalizeImportReigns, sqlDeleteSystemMissingReigns } from "../lib/missingReigns.mjs";
import { drDay, dynastyReignDay, dynastyReignMonth } from "../lib/reignDateHelpers.mjs";

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
function ym(year, month = 1, day = null) {
  const point = { year, month, abs: absMonth(year, month) };
  return day == null ? point : { ...point, day };
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

const colorTokens = [
  "ochre", "azure", "cinnabar", "jade", "indigo", "coral",
  "moss", "plum", "mineral", "amber", "grape", "sage",
  "stone", "clay", "wisteria", "slate",
];
let colorIdx = 0;
function nextColor() {
  return colorTokens[colorIdx++ % colorTokens.length];
}

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  // 辽
  person("yelu-abaoji", "耶律阿保机", ["皇帝"], "辽太祖，统一契丹，916年称帝建大契丹。", "耶律阿保机"),
  person("yelu-deguang", "耶律德光", ["皇帝"], "辽太宗，灭后晋，947年改国号大辽。", "耶律德光"),
  person("yelu-ruan", "耶律阮", ["皇帝"], "辽世宗，太宗之子，在位五年遇弑。", "耶律阮"),
  person("yelu-jing", "耶律璟", ["皇帝"], "辽穆宗，酗酒嗜杀，近侍弑之。", "耶律璟"),
  person("yelu-xian", "耶律贤", ["皇帝"], "辽景宗，整顿吏治，为圣宗盛世奠基。", "耶律贤"),
  person("yelu-longxu", "耶律隆绪", ["皇帝"], "辽圣宗，萧太后摄政，与宋订澶渊之盟。", "耶律隆绪"),
  person("yelu-zongzhen", "耶律宗真", ["皇帝"], "辽兴宗，在位期间辽势仍强。", "耶律宗真"),
  person("yelu-hongji", "耶律洪基", ["皇帝"], "辽道宗，在位长久，后期辽政日衰。", "耶律洪基"),
  person("yelu-yanxi", "耶律延禧", ["皇帝"], "辽天祚帝，1125年被金俘，辽亡。", "耶律延禧"),
  // 金
  person("wanyan-aguda", "完颜阿骨打", ["皇帝"], "金太祖，统一女真，1115年建国反辽。", "完颜阿骨打"),
  person("wanyan-sheng", "完颜晟", ["皇帝"], "金太宗，继续攻辽灭宋，占中原。", "完颜晟"),
  person("wanyan-dan", "完颜亶", ["皇帝"], "金熙宗，推行汉化，后被弑。", "完颜亶"),
  person("wanyan-liang", "完颜亮", ["皇帝"], "海陵王，迁都中都，1161年采石之战败亡。", "完颜亮"),
  person("wanyan-yong", "完颜雍", ["皇帝"], "金世宗，大定之治，金朝中兴。", "完颜雍"),
  person("wanyan-jing", "完颜璟", ["皇帝"], "金章宗，在位期间金势尚盛。", "完颜璟"),
  person("wanyan-yongji", "完颜永济", ["皇帝"], "卫绍王，蒙古入侵时被弑。", "完颜永济"),
  person("wanyan-xun", "完颜珣", ["皇帝"], "金宣宗，迁都南京，蒙金战争加剧。", "完颜珣"),
  person("wanyan-shouxu", "完颜守绪", ["皇帝"], "金哀宗，1234年蔡州陷落，金亡。", "完颜守绪"),
  person("wanyan-chenglin", "完颜承麟", ["皇帝"], "金末帝，即位不足一日即战死。", "完颜承麟"),
  // 宋辽金时期重要人物
  person("yue-fei", "岳飞", ["军事家"], "南宋抗金名将，郾城大捷，后被秦桧害死。", "岳飞", ym(1103), ym(1142)),
  person("yu-yunwen", "虞允文", ["军事家", "政治家"], "采石之战大败金军，阻止金军渡江。", "虞允文", ym(1110), ym(1174)),
  person("qin-hui", "秦桧", ["政治家"], "南宋权臣，主和议，害岳飞。", "秦桧", ym(1090), ym(1155)),
  person("kou-zhun", "寇准", ["政治家"], "北宋名相，真宗朝力主御驾亲征，促成澶渊之盟。", "寇准", ym(961), ym(1023)),
  person("xiao-chuo", "萧绰", ["政治家"], "辽景宗皇后，圣宗朝萧太后，摄政多年，与宋订澶渊之盟。", "萧绰", ym(953), ym(1009)),
];

// ── dynasties ────────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "liao",
    name: "辽",
    altNames: ["契丹", "大辽"],
    scope: "cn",
    region: "east_asia",
    start: ym(916),
    end: ym(1125),
    precision: "year",
    colorToken: nextColor(),
    note: "契丹耶律氏，916年太祖称帝；1125年金灭辽。",
  },
  {
    id: "jin-nvzhen",
    name: "金",
    altNames: ["大金", "女真金"],
    scope: "cn",
    region: "east_asia",
    start: ym(1115),
    end: ym(1234),
    precision: "year",
    colorToken: nextColor(),
    note: "女真完颜氏，1115年太祖建国；1234年蒙古灭金。id 为 jin-nvzhen，避免与两晋/后晋 jin-* 冲突。",
  },
];

// ── reigns ───────────────────────────────────────────────────────────────────

// 辽金皇帝在位日取中国君主列表/维基百科通行换算，precision=day。
const liaoReigns = [
  drDay("liao", "yelu-abaoji", "辽太祖", null, "太祖", 916, 3, 17, 926, 9, 6, [{ name: "神册", sy: 916, ey: 922 }, { name: "天赞", sy: 922, ey: 926 }]),
  drDay("liao", "yelu-deguang", "辽太宗", null, "太宗", 927, 12, 11, 947, 5, 15),
  drDay("liao", "yelu-ruan", "辽世宗", null, "世宗", 947, 5, 16, 951, 10, 7),
  drDay("liao", "yelu-jing", "辽穆宗", null, "穆宗", 951, 10, 7, 969, 3, 12),
  drDay("liao", "yelu-xian", "辽景宗", null, "景宗", 969, 3, 12, 982, 10, 13),
  drDay("liao", "yelu-longxu", "辽圣宗", null, "圣宗", 982, 10, 13, 1031, 6, 25, [{ name: "统和", sy: 983, ey: 1012 }, { name: "开泰", sy: 1012, ey: 1021 }, { name: "太平", sy: 1021, ey: 1031 }]),
  drDay("liao", "yelu-zongzhen", "辽兴宗", null, "兴宗", 1031, 6, 25, 1055, 8, 25),
  drDay("liao", "yelu-hongji", "辽道宗", null, "道宗", 1055, 8, 25, 1101, 2, 12),
  drDay("liao", "yelu-yanxi", "辽天祚帝", null, null, 1101, 2, 12, 1125, 3, 26),
];

const jinReigns = [
  drDay("jin-nvzhen", "wanyan-aguda", "金太祖", null, "太祖", 1115, 1, 28, 1123, 9, 19, [{ name: "收国", sy: 1115, ey: 1116 }, { name: "天辅", sy: 1117, ey: 1123 }]),
  drDay("jin-nvzhen", "wanyan-sheng", "金太宗", null, "太宗", 1123, 9, 19, 1135, 12, 25),
  drDay("jin-nvzhen", "wanyan-dan", "金熙宗", null, "熙宗", 1135, 12, 25, 1149, 12, 24),
  drDay("jin-nvzhen", "wanyan-liang", "海陵王", null, null, 1150, 1, 9, 1161, 1, 6),
  drDay("jin-nvzhen", "wanyan-yong", "金世宗", null, "世宗", 1161, 1, 6, 1189, 1, 20, [{ name: "大定", sy: 1161, ey: 1189 }]),
  drDay("jin-nvzhen", "wanyan-jing", "金章宗", null, "章宗", 1189, 1, 20, 1208, 12, 29),
  drDay("jin-nvzhen", "wanyan-yongji", "卫绍王", null, null, 1208, 12, 29, 1213, 9, 11),
  drDay("jin-nvzhen", "wanyan-xun", "金宣宗", null, "宣宗", 1213, 9, 11, 1223, 1, 14),
  // 1234年2月9日蔡州陷落：哀宗殉国，承麟即位不足一日即战死。
  dynastyReignMonth("jin-nvzhen", "wanyan-shouxu", "金哀宗", null, "哀宗", 1223, 1, 1234, 2),
  dynastyReignDay("jin-nvzhen", "wanyan-chenglin", "金末帝", null, null, 1234, 2, 9, 1234, 2, 9),
];

const reignGroups = [liaoReigns, jinReigns];
const reigns = reignGroups.flat();

// ── events ───────────────────────────────────────────────────────────────────

function eventPoint(partial) {
  const at = partial.at;
  return { kind: "other", timeMode: "point", precision: "year", dynastyIds: [], participantIds: [], ...partial, at, atAbs: at.abs };
}
function eventRange(partial) {
  const start = partial.start;
  const end = partial.end;
  const at = partial.at;
  return {
    kind: "other", precision: "year", dynastyIds: [], participantIds: [], ...partial,
    start, end, startAbs: start.abs, endAbs: end.abs, ...(at ? { at, atAbs: at.abs } : {}),
  };
}

const events = [
  eventPoint({
    id: "chanyuan-treaty",
    name: "澶渊之盟",
    kind: "politics",
    at: ym(1004),
    dynastyIds: ["liao", "song-north"],
    participantIds: ["yelu-longxu", "zhao-heng"],
    summary: "宋真宗与辽圣宗订立和约，宋岁赐辽银绢，双方罢兵。",
  }),
  eventPoint({
    id: "jin-founded",
    name: "金朝建立",
    kind: "politics",
    at: ym(1115),
    dynastyIds: ["jin-nvzhen"],
    participantIds: ["wanyan-aguda"],
    summary: "完颜阿骨打称帝，国号大金，起兵反辽。",
  }),
  eventPoint({
    id: "jin-destroy-liao",
    name: "金灭辽",
    kind: "battle",
    dateNote: "1125年俘天祚帝",
    at: ym(1125),
    dynastyIds: ["jin-nvzhen", "liao"],
    participantIds: ["wanyan-sheng", "yelu-yanxi"],
    summary: "金军俘辽天祚帝耶律延禧，辽朝灭亡。",
  }),
  eventPoint({
    id: "yancheng-battle",
    name: "郾城之战",
    kind: "battle",
    at: ym(1140),
    dynastyIds: ["song-south", "jin-nvzhen"],
    participantIds: ["yue-fei"],
    summary: "岳飞率岳家军大败金军，收复中原要地。",
  }),
  eventPoint({
    id: "shaoxing-treaty",
    name: "绍兴和议",
    kind: "politics",
    at: ym(1141),
    dynastyIds: ["song-south", "jin-nvzhen"],
    participantIds: ["zhao-gou", "qin-hui"],
    summary: "宋金议和，割地纳贡，岳飞被害，南北对峙格局确立。",
  }),
  eventPoint({
    id: "caishi-battle",
    name: "采石之战",
    kind: "battle",
    at: ym(1161),
    dynastyIds: ["song-south", "jin-nvzhen"],
    participantIds: ["yu-yunwen", "wanyan-liang"],
    summary: "虞允文督师采石，大败金军，完颜亮兵败被杀。",
  }),
  eventRange({
    id: "kaixi-expedition",
    name: "开禧北伐",
    kind: "battle",
    timeMode: "span",
    start: ym(1206),
    end: ym(1208),
    dynastyIds: ["song-south", "jin-nvzhen"],
    participantIds: ["zhao-kuo"],
    summary: "宋宁宗朝北伐金朝，初战告捷后失利，嘉定和议复归对峙。",
  }),
  eventPoint({
    id: "song-jin-alliance-mongol",
    name: "联蒙灭金",
    kind: "politics",
    dateNote: "1234年蔡州陷落",
    at: ym(1234),
    dynastyIds: ["song-south", "jin-nvzhen"],
    participantIds: ["zhao-yun", "wanyan-shouxu"],
    summary: "宋蒙结盟攻金，金哀宗殉国，金朝灭亡；宋随即遭蒙古南侵。",
  }),
  eventPoint({
    id: "yongle-campaign",
    name: "雍熙北伐",
    kind: "battle",
    dateNote: "986年，宋太宗二次北伐辽国失利",
    at: ym(986),
    dynastyIds: ["song-north", "liao"],
    participantIds: ["zhao-kuangyi"],
    summary: "宋太宗遣潘美、杨业等北伐，岐沟关、陈家谷惨败，杨业殉国，宋辽转为守势。",
  }),
  eventPoint({
    id: "haoshuichuan-battle",
    name: "好水川之战",
    kind: "battle",
    dateNote: "1044年，西夏大败宋军",
    at: ym(1044),
    dynastyIds: ["song-north"],
    participantIds: ["zhao-zhen"],
    summary: "西夏李元昊于好水川伏击宋军，韩琦、范仲淹主持的西线战事受挫。",
  }),
];

// Supplemental links for events already in sui-tang-wudai-song
const supplementalEventDynasties = [
  { eventId: "jingkang-incident", dynastyId: "jin-nvzhen" },
  { eventId: "song-south-founded", dynastyId: "jin-nvzhen" },
  { eventId: "jingkang-incident", dynastyId: "liao" },
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
  { id: "rel-chanyuan-liao-song", fromRef: "event:chanyuan-treaty", toRef: "dynasty:liao", kind: "alliance" },
  { id: "rel-yancheng-yue-fei", fromRef: "event:yancheng-battle", toRef: "person:yue-fei", kind: "battle" },
  { id: "rel-caishi-yu-yunwen", fromRef: "event:caishi-battle", toRef: "person:yu-yunwen", kind: "battle" },
  { id: "rel-jin-destroy-liao", fromRef: "event:jin-destroy-liao", toRef: "dynasty:liao", kind: "battle" },
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
  return `INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision)
VALUES (${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(r.title)}, ${sqlStr(r.posthumousName ?? null)}, ${sqlStr(r.templeName ?? null)}, ${sqlJson(r.preferredAppellation)}, ${r.start.year}, ${r.start.month}, ${r.start.day ?? "NULL"}, ${r.end.year}, ${r.end.month}, ${r.end.day ?? "NULL"}, ${r.startAbs}, ${r.endAbs}, ${sqlStr(r.precision)})
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;`;
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

const { persons: importPersons, reigns: importReigns } = finalizeImportReigns("song-liao-jin", persons, reigns);

const reignsWithEras = importReigns.filter((r) => r.eraNames.length > 0);
const eraDeleteSql = reignsWithEras.map((r) => `DELETE FROM era_names WHERE reign_id = ${sqlStr(r.id)};`);
const eraInsertSql = reignsWithEras.flatMap((r) => r.eraNames.map(eraNameSql));
const eventDynastySql = events.flatMap((e) => e.dynastyIds.map((d) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(e.id)}, ${sqlStr(d)}) ON CONFLICT DO NOTHING;`));
const supplementalEventDynastySql = supplementalEventDynasties.map(
  ({ eventId, dynastyId }) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(eventId)}, ${sqlStr(dynastyId)}) ON CONFLICT DO NOTHING;`,
);
const eventParticipantSql = events.flatMap((e) => e.participantIds.map((p) => `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(e.id)}, ${sqlStr(p)}) ON CONFLICT DO NOTHING;`));

const sql = [
  "-- EraLens period import: song-liao-jin",
  "-- Window: 916-01 .. 1234-12",
  "BEGIN;",
  "",
  "-- remove stale auto-generated 史料缺 (太祖卒后述律太后摄政期应留白)",
  sqlDeleteSystemMissingReigns(["liao"], sqlStr),
  "",
  "", "-- persons", ...importPersons.map(personSql),
  "", "-- dynasties", ...dynasties.map(dynastySql),
  "", "-- reigns", ...importReigns.map(reignSql),
  "", "-- era_names", ...eraDeleteSql, ...eraInsertSql,
  "", "-- events", ...events.map(eventSql),
  "", "-- event_dynasties", ...eventDynastySql, ...supplementalEventDynastySql,
  "", "-- event_participants", ...eventParticipantSql,
  "", "-- relations", ...relations.map(relationSql),
  "", "COMMIT;", "",
].join("\n");

mkdirSync(__dirname, { recursive: true });
writeFileSync(path.join(__dirname, "import.sql"), sql);

const manifest = {
  slug: "song-liao-jin",
  title: "宋辽金对峙（含南宋时期）",
  window: { startYear: 916, startMonth: 1, endYear: 1234, endMonth: 12 },
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
    { label: "辽朝", url: "https://zh.wikipedia.org/wiki/辽朝" },
    { label: "辽朝君主列表", url: "https://zh.wikipedia.org/wiki/辽朝君主列表" },
    { label: "金朝", url: "https://zh.wikipedia.org/wiki/金朝" },
    { label: "金朝君主列表", url: "https://zh.wikipedia.org/wiki/金朝君主列表" },
    { label: "澶渊之盟", url: "https://zh.wikipedia.org/wiki/澶渊之盟" },
    { label: "靖康之变", url: "https://zh.wikipedia.org/wiki/靖康之变" },
    { label: "郾城之战", url: "https://zh.wikipedia.org/wiki/郾城之战" },
    { label: "采石之战", url: "https://zh.wikipedia.org/wiki/采石之战" },
  ],
  notes: [
    "覆盖辽（916–1125）、女真金（1115–1234）及宋辽金对峙重大事件。",
    "金朝 id 为 jin-nvzhen，避免与两晋 jin-west/jin-east、后晋 jin-hou 冲突。",
    "南宋/北宋王朝与皇帝见 sui-tang-wudai-song；本包补充 event_dynasties 关联靖康之变、南宋建立。",
    "未收录西辽、北辽、东辽等辽亡后残余政权。",
    "辽金皇帝在位日取中国君主列表/维基百科通行换算，precision=day；1234年蔡州陷落同年更替用 month；承麟在位不足一日用 day。",
    "辽太祖卒至太宗即位间述律太后摄政、未立新帝，时间轴留白，不标史料缺。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);

console.log(`Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`);
