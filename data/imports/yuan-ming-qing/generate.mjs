#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Yuan, Ming, Qing (1271–1912).
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

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

function dynastyReign(dynastyId, personId, title, posthumous, temple, startYear, endYear, eraNames = [], preferred = null) {
  const pref = preferred ?? (temple ? { kind: "temple", name: title } : posthumous ? { kind: "posthumous", name: title } : { kind: "regnal", name: title });
  const reignId = `reign-${personId}-${dynastyId}`;
  return reign({ id: reignId, dynastyId, personId, title, posthumousName: posthumous, templeName: temple, preferred: pref, start: ym(startYear), end: ym(endYear, 12), eraNames });
}

function eras(reignId, list) {
  return list.map((e, i) => ({ reignId, name: e.name, start: ym(e.sy, e.sm ?? 1), end: ym(e.ey, e.em ?? 12), sortOrder: i }));
}

function dr(dynastyId, personId, title, posthumous, temple, sy, ey, eraList = []) {
  const r = dynastyReign(dynastyId, personId, title, posthumous, temple, sy, ey);
  if (eraList.length) r.eraNames = eras(r.id, eraList);
  return r;
}

const colorTokens = ["ochre", "indigo", "moss", "mineral", "cinnabar", "stone", "grape", "wisteria"];
let colorIdx = 0;
function nextColor() {
  return colorTokens[colorIdx++ % colorTokens.length];
}

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  // 元
  person("hu-bilie", "忽必烈", ["皇帝"], "元世祖，成吉思汗之孙，1271年定国号大元，灭南宋统一。", "忽必烈"),
  person("temur", "铁穆耳", ["皇帝"], "元成宗，忽必烈之孙，守成之君。", "元成宗"),
  person("khayishan", "海山", ["皇帝"], "元武宗，海山即位，后兄死弟立。", "元武宗"),
  person("ayurbarwada", "爱育黎拔力八达", ["皇帝"], "元仁宗，恢复科举，与武宗约兄终弟及。", "元仁宗"),
  person("shidebala", "硕德八剌", ["皇帝"], "元英宗，被南坡之变弑杀。", "元英宗"),
  person("yeshuntuemur", "也孙铁木儿", ["皇帝"], "元泰定帝，在位五年。", "元泰定帝"),
  person("ragibagh", "阿速吉八", ["皇帝"], "元天顺帝，两都之战，在位仅一月。", "阿速吉八"),
  person("tugh-temur", "图帖睦尔", ["皇帝"], "元文宗，两都之战后即位，传位弟又夺位。", "元文宗"),
  person("khoshila", "和世㻋", ["皇帝"], "元明宗，文宗之兄，即位仅一月被害。", "和世㻋"),
  person("irinchibal", "懿璘质班", ["皇帝"], "元宁宗，幼年即位，在位仅两月。", "元宁宗"),
  person("togon-temur", "妥懽帖睦尔", ["皇帝"], "元顺帝，元朝末代，红巾起义，退居漠北。", "元顺帝"),
  // 明
  person("zhu-yuanzhang", "朱元璋", ["皇帝"], "明太祖，驱逐蒙元，建立明朝，定都南京后迁北京。", "朱元璋"),
  person("zhu-yunwen", "朱允炆", ["皇帝"], "建文帝，削藩引发靖难之役，下落成谜。", "建文帝"),
  person("zhu-di", "朱棣", ["皇帝"], "明成祖，靖难之役即位，迁都北京，派郑和下西洋。", "朱棣"),
  person("zhu-gaochi", "朱高炽", ["皇帝"], "明仁宗，永乐之后与民休息。", "朱高炽"),
  person("zhu-zhanji", "朱瞻基", ["皇帝"], "明宣宗，仁宣之治。", "朱瞻基"),
  person("zhu-qizhen", "朱祁镇", ["皇帝"], "明英宗，土木堡被俘，复辟后杀于谦。", "朱祁镇"),
  person("zhu-qiyu", "朱祁钰", ["皇帝"], "明代宗，土木堡之变后即位，后被英宗复辟。", "朱祁钰"),
  person("zhu-jianshen", "朱见深", ["皇帝"], "明宪宗，宠信万贵妃，设西厂。", "朱见深"),
  person("zhu-youcheng", "朱祐樘", ["皇帝"], "明孝宗，弘治中兴，一夫一后。", "朱祐樘"),
  person("zhu-houzhao", "朱厚照", ["皇帝"], "明武宗，好微行，豹房。", "朱厚照"),
  person("zhu-houcong", "朱厚熜", ["皇帝"], "明世宗，大礼议，崇道，庚戌之变。", "朱厚熜"),
  person("zhu-zaihou", "朱载坖", ["皇帝"], "明穆宗，隆庆开关，与蒙古互市。", "朱载坖"),
  person("zhu-yiming", "朱翊钧", ["皇帝"], "明神宗，万历三大征，后期怠政。", "朱翊钧"),
  person("zhu-changluo", "朱常洛", ["皇帝"], "明光宗，红丸案，在位仅一月。", "明光宗"),
  person("zhu-youjiao", "朱由校", ["皇帝"], "明熹宗，木匠皇帝，魏忠贤专权。", "朱由校"),
  person("zhu-youjian", "朱由检", ["皇帝"], "明思宗，崇祯，煤山自缢，明亡。", "崇祯帝"),
  person("zhu-yousong", "朱由崧", ["皇帝"], "弘光帝，南明首任，被俘处死。", "弘光帝"),
  person("zhu-yujian", "朱聿键", ["皇帝"], "隆武帝，南明，清军攻福州时被俘。", "隆武帝"),
  person("zhu-youlang", "朱由榔", ["皇帝"], "永历帝，南明末帝，为吴三桂所害。", "永历帝"),
  person("zheng-chenggong", "郑成功", ["军事家"], "抗清名将，收复台湾。", "郑成功"),
  person("yu-qian", "于谦", ["政治家", "军事家"], "土木堡之变后保卫北京，后被英宗冤杀。", "于谦"),
  // 清
  person("nurhaci", "努尔哈赤", ["皇帝"], "清太祖，统一女真，建立后金。", "努尔哈赤"),
  person("huang-taiji", "皇太极", ["皇帝"], "清太宗，改国号大清，完善八旗。", "皇太极"),
  person("fulin", "福临", ["皇帝"], "清世祖，六岁即位，多尔衮摄政，清军入关。", "顺治帝"),
  person("xuanye", "玄烨", ["皇帝"], "清圣祖康熙，平三藩、收台湾、亲征准噶尔。", "康熙帝"),
  person("yinzhen", "胤禛", ["皇帝"], "清世宗雍正，勤政改革，设军机处。", "雍正帝"),
  person("hongli", "弘历", ["皇帝"], "清高宗乾隆，康乾盛世顶峰，后闭关。", "乾隆帝"),
  person("yongyan", "颙琰", ["皇帝"], "清仁宗嘉庆，白莲教起义在其朝。", "嘉庆帝"),
  person("minning", "旻宁", ["皇帝"], "清宣宗道光，鸦片战争在其朝。", "道光帝"),
  person("yizhu", "奕詝", ["皇帝"], "清文宗咸丰，太平天国与第二次鸦片战争。", "咸丰帝"),
  person("zaichun", "载淳", ["皇帝"], "清穆宗同治，慈禧垂帘听政。", "同治帝"),
  person("zaitian", "载湉", ["皇帝"], "清德宗光绪，戊戌变法、庚子事变。", "光绪帝"),
  person("puyi", "溥仪", ["皇帝"], "清末帝，宣统退位，中国帝制终结。", "溥仪"),
  person("lin-zexu", "林则徐", ["政治家"], "禁烟英雄，虎门销烟主持者。", "林则徐"),
  person("sun-yat-sen", "孙中山", ["政治家"], "辛亥革命领袖，中华民国临时大总统。", "孙中山"),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const dynasties = [
  { id: "yuan", name: "元", altNames: ["大元", "蒙元"], scope: "cn", region: "east_asia", start: ym(1271, 12), end: ym(1368), precision: "year", colorToken: nextColor(), note: "忽必烈1271年定国号大元；1368年顺帝北逃，元亡。" },
  { id: "ming", name: "明", altNames: ["大明"], scope: "cn", region: "east_asia", start: ym(1368), end: ym(1644, 4), precision: "year", colorToken: nextColor(), note: "朱元璋驱逐蒙元，定都南京后迁北京；1644年崇祯自缢，明亡。" },
  { id: "ming-south", name: "南明", altNames: ["明"], scope: "cn", region: "east_asia", start: ym(1644), end: ym(1662), precision: "year", colorToken: nextColor(), note: "明亡后朱氏宗室相继监国称帝；1662年永历帝殉，南明终结。" },
  { id: "qing", name: "清", altNames: ["大清", "后金"], scope: "cn", region: "east_asia", start: ym(1616, 2), end: ym(1912, 2), precision: "year", colorToken: nextColor(), note: "1616年努尔哈赤建后金，1636年改国号大清；1912年宣统退位。" },
];

// ── reigns ─────────────────────────────────────────────────────────────────

const yuanReigns = [
  dr("yuan", "hu-bilie", "元世祖", "圣德神功文武皇帝", "世祖", 1271, 1294, [{ name: "至元", sy: 1264, ey: 1294 }]),
  dr("yuan", "temur", "元成宗", "钦明广孝皇帝", null, 1294, 1307),
  dr("yuan", "khayishan", "元武宗", "仁圣钦安皇帝", null, 1307, 1311),
  dr("yuan", "ayurbarwada", "元仁宗", "圣德慈仁皇帝", null, 1311, 1320),
  dr("yuan", "shidebala", "元英宗", "睿圣文孝皇帝", null, 1320, 1323),
  dr("yuan", "yeshuntuemur", "元泰定帝", null, null, 1323, 1328),
  dr("yuan", "ragibagh", "元天顺帝", null, null, 1328, 1328),
  dr("yuan", "tugh-temur", "元文宗", "圣明元孝皇帝", null, 1328, 1332),
  dr("yuan", "khoshila", "元明宗", "翼献景孝皇帝", null, 1329, 1329),
  dr("yuan", "irinchibal", "元宁宗", "冲圣嗣孝皇帝", null, 1332, 1332),
  dr("yuan", "togon-temur", "元顺帝", "宣仁普孝皇帝", null, 1333, 1368),
];

const mingReigns = [
  dr("ming", "zhu-yuanzhang", "明太祖", "高皇帝", "太祖", 1368, 1398, [{ name: "洪武", sy: 1368, ey: 1398 }]),
  dr("ming", "zhu-yunwen", "建文帝", null, null, 1398, 1402, [{ name: "建文", sy: 1399, ey: 1402 }]),
  dr("ming", "zhu-di", "明成祖", "文皇帝", "成祖", 1402, 1424, [{ name: "永乐", sy: 1403, ey: 1424 }]),
  dr("ming", "zhu-gaochi", "明仁宗", "昭皇帝", "仁宗", 1424, 1425),
  dr("ming", "zhu-zhanji", "明宣宗", "章皇帝", "宣宗", 1425, 1435),
  dr("ming", "zhu-qizhen", "明英宗", "睿皇帝", "英宗", 1435, 1464),
  dr("ming", "zhu-qiyu", "明代宗", "景皇帝", "代宗", 1449, 1457),
  dr("ming", "zhu-jianshen", "明宪宗", "纯皇帝", "宪宗", 1464, 1487),
  dr("ming", "zhu-youcheng", "明孝宗", "达皇帝", "孝宗", 1487, 1505),
  dr("ming", "zhu-houzhao", "明武宗", "毅皇帝", "武宗", 1505, 1521),
  dr("ming", "zhu-houcong", "明世宗", "肃皇帝", "世宗", 1521, 1566),
  dr("ming", "zhu-zaihou", "明穆宗", "庄皇帝", "穆宗", 1566, 1572),
  dr("ming", "zhu-yiming", "明神宗", "显皇帝", "神宗", 1572, 1620),
  dr("ming", "zhu-changluo", "明光宗", "贞皇帝", "光宗", 1620, 1620),
  dr("ming", "zhu-youjiao", "明熹宗", "哲皇帝", "熹宗", 1620, 1627),
  dr("ming", "zhu-youjian", "明思宗", "毅皇帝", "思宗", 1627, 1644),
];

const mingSouthReigns = [
  dr("ming-south", "zhu-yousong", "弘光帝", null, null, 1644, 1645),
  dr("ming-south", "zhu-yujian", "隆武帝", null, null, 1645, 1646),
  dr("ming-south", "zhu-youlang", "永历帝", null, null, 1646, 1662),
];

const qingReigns = [
  dr("qing", "nurhaci", "清太祖", "武皇帝", "太祖", 1616, 1626),
  dr("qing", "huang-taiji", "清太宗", "文皇帝", "太宗", 1626, 1643),
  dr("qing", "fulin", "清世祖", "章皇帝", "世祖", 1643, 1661),
  dr("qing", "xuanye", "清圣祖", "仁皇帝", "圣祖", 1661, 1722, [{ name: "康熙", sy: 1662, ey: 1722 }]),
  dr("qing", "yinzhen", "清世宗", "宪皇帝", "世宗", 1722, 1735, [{ name: "雍正", sy: 1723, ey: 1735 }]),
  dr("qing", "hongli", "清高宗", "纯皇帝", "高宗", 1735, 1796, [{ name: "乾隆", sy: 1736, ey: 1795 }]),
  dr("qing", "yongyan", "清仁宗", "睿皇帝", "仁宗", 1796, 1820),
  dr("qing", "minning", "清宣宗", "成皇帝", "宣宗", 1820, 1850),
  dr("qing", "yizhu", "清文宗", "显皇帝", "文宗", 1850, 1861),
  dr("qing", "zaichun", "清穆宗", "毅皇帝", "穆宗", 1861, 1875),
  dr("qing", "zaitian", "清德宗", "景皇帝", "德宗", 1875, 1908),
  dr("qing", "puyi", "清逊帝", null, null, 1908, 1912),
];

const reignGroups = [yuanReigns, mingReigns, mingSouthReigns, qingReigns];
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
  return { kind: "other", precision: "year", dynastyIds: [], participantIds: [], ...partial, start, end, startAbs: start.abs, endAbs: end.abs, ...(at ? { at, atAbs: at.abs } : {}), timeMode: partial.timeMode ?? "span" };
}

const events = [
  eventPoint({ id: "yuan-founded", name: "元朝建立", kind: "politics", at: ym(1271, 12), dynastyIds: ["yuan"], participantIds: ["hu-bilie"], summary: "忽必烈定国号大元，都大都，元朝开始。" }),
  eventPoint({ id: "yuan-unify-song", name: "元灭南宋", kind: "politics", at: ym(1279), dynastyIds: ["yuan", "song-south"], participantIds: ["hu-bilie"], summary: "崖山之战后南宋灭亡，元统一全国。" }),
  eventPoint({ id: "ming-founded", name: "明朝建立", kind: "politics", at: ym(1368), dynastyIds: ["ming", "yuan"], participantIds: ["zhu-yuanzhang"], summary: "朱元璋称帝，定都南京，国号大明，元顺帝北逃。" }),
  eventRange({ id: "yongle-rule", name: "永乐盛世", kind: "politics", timeMode: "span", start: ym(1403), end: ym(1424), dynastyIds: ["ming"], participantIds: ["zhu-di"], summary: "明成祖迁都北京，派郑和下西洋，国力强盛。" }),
  eventPoint({ id: "tumu-crisis", name: "土木堡之变", kind: "battle", at: ym(1449), dynastyIds: ["ming"], participantIds: ["zhu-qizhen"], summary: "明英宗率军北征瓦剌，土木堡被俘，明军主力覆没。" }),
  eventPoint({ id: "ming-fall", name: "明朝灭亡", kind: "politics", at: ym(1644, 4), dynastyIds: ["ming"], participantIds: ["zhu-youjian"], summary: "李自成攻入北京，崇祯自缢，明朝灭亡。" }),
  eventPoint({ id: "qing-founded", name: "大清建国", kind: "politics", at: ym(1636, 5), dynastyIds: ["qing"], participantIds: ["huang-taiji"], summary: "皇太极改国号大清，完善国家制度。" }),
  eventPoint({ id: "qing-enter-pass", name: "清军入关", kind: "politics", at: ym(1644), dynastyIds: ["qing", "ming"], participantIds: ["fulin"], summary: "吴三桂引清军入关，定都北京，逐鹿中原。" }),
  eventRange({ id: "kangqian-prosperity", name: "康乾盛世", kind: "politics", timeMode: "span", start: ym(1661), end: ym(1796), dynastyIds: ["qing"], participantIds: ["xuanye", "hongli"], summary: "康熙、雍正、乾隆三朝国力强盛，疆域辽阔。" }),
  eventPoint({ id: "opium-war", name: "鸦片战争", kind: "battle", at: ym(1840), dynastyIds: ["qing"], participantIds: ["minning", "lin-zexu"], summary: "英国发动鸦片战争，清政府战败，签订南京条约。" }),
  eventRange({ id: "taiping-rebellion", name: "太平天国", kind: "politics", timeMode: "span", start: ym(1851), end: ym(1864), dynastyIds: ["qing"], participantIds: ["yizhu"], summary: "洪秀全领导太平天国运动，动摇清统治根基。" }),
  eventPoint({ id: "xinhai-revolution", name: "辛亥革命", kind: "politics", at: ym(1911), dynastyIds: ["qing"], participantIds: ["sun-yat-sen"], summary: "武昌起义爆发，各省独立，帝制走向终结。" }),
  eventPoint({ id: "qing-fall", name: "清帝退位", kind: "politics", precision: "month", dateNote: "1912年2月12日，宣统退位", at: ym(1912, 2), dynastyIds: ["qing"], participantIds: ["puyi"], summary: "溥仪颁布退位诏书，清朝终结，中华民国成立。" }),
  eventPoint({ id: "ming-south-end", name: "南明终结", kind: "politics", at: ym(1662), dynastyIds: ["ming-south"], participantIds: ["zhu-youlang"], summary: "永历帝为吴三桂所害，南明彻底灭亡。" }),
  eventPoint({ id: "zheng-recover-taiwan", name: "郑成功收复台湾", kind: "battle", at: ym(1662), dynastyIds: ["ming-south"], participantIds: ["zheng-chenggong"], summary: "郑成功驱逐荷兰殖民者，收复台湾。" }),
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
  { id: "rel-tumu-zhu-qizhen", fromRef: "event:tumu-crisis", toRef: "person:zhu-qizhen", kind: "battle" },
  { id: "rel-opium-lin-zexu", fromRef: "event:opium-war", toRef: "person:lin-zexu", kind: "other" },
);

// ── SQL ──────────────────────────────────────────────────────────────────────

function personSql(p) {
  return `INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links) VALUES (${sqlStr(p.id)}, ${sqlStr(p.name)}, ${p.birth?.year ?? "NULL"}, ${p.birth?.month ?? "NULL"}, ${p.death?.year ?? "NULL"}, ${p.death?.month ?? "NULL"}, ${sqlArray(p.roles)}, ${sqlStr(p.bio)}, ${sqlJson(p.links)}) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;`;
}
function dynastySql(d) {
  return `INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, parent_id, note) VALUES (${sqlStr(d.id)}, ${sqlStr(d.name)}, ${sqlArray(d.altNames)}, ${sqlStr(d.scope)}, ${sqlStr(d.region)}, ${d.start.year}, ${d.start.month}, ${d.end.year}, ${d.end.month}, ${d.start.abs}, ${d.end.abs}, ${sqlStr(d.precision)}, ${sqlStr(d.colorToken)}, NULL, ${sqlStr(d.note)}) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, note = EXCLUDED.note;`;
}
function reignSql(r) {
  return `INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision) VALUES (${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(r.title)}, ${sqlStr(r.posthumousName ?? null)}, ${sqlStr(r.templeName ?? null)}, ${sqlJson(r.preferredAppellation)}, ${r.start.year}, ${r.start.month}, ${r.end.year}, ${r.end.month}, ${r.startAbs}, ${r.endAbs}, ${sqlStr(r.precision)}) ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;`;
}
function eraNameSql(e) {
  return `INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order) VALUES (${sqlStr(e.reignId)}, ${sqlStr(e.name)}, ${e.start.year}, ${e.start.month}, ${e.end.year}, ${e.end.month}, ${e.start.abs}, ${e.end.abs}, ${e.sortOrder});`;
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

const reignsWithEras = reigns.filter((r) => r.eraNames.length > 0);
const eraDeleteSql = reignsWithEras.map((r) => `DELETE FROM era_names WHERE reign_id = ${sqlStr(r.id)};`);
const eraInsertSql = reignsWithEras.flatMap((r) => r.eraNames.map(eraNameSql));
const eventDynastySql = events.flatMap((e) => e.dynastyIds.map((d) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(e.id)}, ${sqlStr(d)}) ON CONFLICT DO NOTHING;`));
const eventParticipantSql = events.flatMap((e) => e.participantIds.map((p) => `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(e.id)}, ${sqlStr(p)}) ON CONFLICT DO NOTHING;`));

const sql = ["-- EraLens period import: yuan-ming-qing", "-- Window: 1271-12 .. 1912-02", "BEGIN;", "", "-- persons", ...persons.map(personSql), "", "-- dynasties", ...dynasties.map(dynastySql), "", "-- reigns", ...reigns.map(reignSql), "", "-- era_names", ...eraDeleteSql, ...eraInsertSql, "", "-- events", ...events.map(eventSql), "", "-- event_dynasties", ...eventDynastySql, "", "-- event_participants", ...eventParticipantSql, "", "-- relations", ...relations.map(relationSql), "", "COMMIT;", ""].join("\n");

mkdirSync(__dirname, { recursive: true });
writeFileSync(path.join(__dirname, "import.sql"), sql);

const manifest = {
  slug: "yuan-ming-qing",
  title: "元明清（含南明）",
  window: { startYear: 1271, startMonth: 12, endYear: 1912, endMonth: 2 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-12",
  counts: { persons: persons.length, dynasties: dynasties.length, reigns: reigns.length, events: events.length, relations: relations.length },
  sources: [
    { label: "元朝", url: "https://zh.wikipedia.org/wiki/元朝" },
    { label: "明朝", url: "https://zh.wikipedia.org/wiki/明朝" },
    { label: "清朝", url: "https://zh.wikipedia.org/wiki/清朝" },
    { label: "南明", url: "https://zh.wikipedia.org/wiki/南明" },
    { label: "土木堡之变", url: "https://zh.wikipedia.org/wiki/土木堡之变" },
    { label: "辛亥革命", url: "https://zh.wikipedia.org/wiki/辛亥革命" },
  ],
  notes: [
    "覆盖元（1271–1368）、明（1368–1644）、南明（1644–1662）、清（1636–1912）。",
    "清王朝行自1616年努尔哈赤建后金起算，1636年改国号大清；努尔哈赤、皇太极在位计入清 reign。",
    "元世祖至元年间部分早于1271年，年号取1271年后窗口。",
    "1912年清帝退位为帝制终结；中华民国不在本包内。",
    "未收录北元（1368–1388）、明郑（1662–1683）等延续政权。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);
console.log(`Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`);
