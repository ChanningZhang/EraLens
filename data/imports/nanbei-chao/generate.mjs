#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Northern and Southern Dynasties (386–589).
 * AbsMonth must match packages/shared/src/time.ts
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import { finalizeImportReigns } from "../lib/missingReigns.mjs";
import { reignSql } from "../lib/reignSql.mjs";
import { dynastyGroupSql, dynastySql, formatAppellationCsv, mergeAppellationsIntoPersons, normalizeYearPrecisionAt, personSql } from "../lib/sqlHelpers.mjs";

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

function reign({
  id,
  dynastyId,
  personId,
  title,
  posthumousName,
  templeName,
  start,
  end,
  precision = "year",
  eraNames = [],
  claimTrack,
  claimLabel,
  claimRole,
}) {
  return {
    id,
    dynastyId,
    personId,
    title,
    posthumousName,
    templeName,
    eraNames,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    precision,
    claimTrack,
    claimLabel,
    claimRole,
  };
}

function dynastyReign(
  dynastyId,
  personId,
  title,
  posthumous,
  temple,
  startYear,
  endYear,
  eraNames = [],
  claim = null,
) {
  return reign({
    id: `reign-${personId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    start: ym(startYear),
    end: ym(endYear, 12),
    eraNames,
    claimTrack: claim?.track,
    claimLabel: claim?.label,
    claimRole: claim?.track ? "rival" : undefined,
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

function person(id, name, roles, bio, wikiTitle, birth = null, death = null) {
  return { id, name, roles, bio, links: wiki(wikiTitle), birth, death };
}

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  // 刘宋（刘裕已在 jin-sixteen 导入）
  person("liu-yifu", "刘义符", ["皇帝"], "宋少帝，刘裕长子，被徐羡之等废杀。", "刘义符"),
  person("liu-yilong", "刘义隆", ["皇帝"], "宋文帝，元嘉之治，后被太子刘劭所弑。", "刘义隆"),
  person("liu-shao", "刘劭", ["皇帝"], "宋元凶，弑父自立，旋为刘骏所灭。", "刘劭"),
  person("liu-jun", "刘骏", ["皇帝"], "宋孝武帝，平讨元凶，后期穷兵黩武。", "刘骏"),
  person("liu-ziye", "刘子业", ["皇帝"], "宋前废帝，荒淫暴虐，为湘东王刘彧所杀。", "刘子业"),
  person("liu-yu-song", "刘彧", ["皇帝"], "宋明帝，屠戮宗室，宋室由盛转衰。", "刘彧"),
  person("liu-yu-fei", "刘昱", ["皇帝"], "宋后废帝，为萧道成所杀。", "刘昱"),
  person("liu-zhun", "刘准", ["皇帝"], "宋顺帝，刘宋末代，萧道成代宋。", "刘准"),
  // 南齐
  person("xiao-daocheng", "萧道成", ["皇帝"], "齐高帝，代宋建齐，定都建康。", "萧道成"),
  person("xiao-ze", "萧赜", ["皇帝"], "齐武帝，永明之治，南齐极盛。", "萧赜"),
  person("xiao-zhaoye", "萧昭业", ["皇帝"], "南齐郁林王，荒乱，为萧鸾所废杀。", "萧昭业"),
  person("xiao-zhaowen", "萧昭文", ["皇帝"], "南齐海陵王，在位仅二十三日。", "萧昭文"),
  person("xiao-luan", "萧鸾", ["皇帝"], "齐明帝，杀侄自立，大杀齐室。", "萧鸾"),
  person("xiao-baojuan", "萧宝卷", ["皇帝"], "东昏侯，荒淫，为萧衍所废。", "萧宝卷"),
  person("xiao-baorong", "萧宝融", ["皇帝"], "齐和帝，南齐末代，萧衍代齐。", "萧宝融"),
  // 南梁
  person("xiao-yan", "萧衍", ["皇帝"], "梁武帝，崇佛，侯景之乱在其朝，饿死台城。", "萧衍"),
  person("xiao-gang", "萧纲", ["皇帝"], "梁简文帝，侯景拥立，后被杀。", "萧纲"),
  person("xiao-yi", "萧绎", ["皇帝"], "梁元帝，江陵称帝，后为西魏所杀。", "萧绎"),
  person("xiao-fangzhi", "萧方智", ["皇帝"], "梁敬帝，南梁末代，陈霸先代梁。", "萧方智"),
  // 南陈
  person("chen-baxian", "陈霸先", ["皇帝"], "陈武帝，代梁建陈，定都建康。", "陈霸先"),
  person("chen-qian", "陈蒨", ["皇帝"], "陈文帝，陈霸先侄，励精图治。", "陈蒨"),
  person("chen-bozong", "陈伯宗", ["皇帝"], "陈废帝，为叔父陈顼所废。", "陈伯宗"),
  person("chen-xu", "陈顼", ["皇帝"], "陈宣帝，陈朝中兴，北伐齐。", "陈顼"),
  person("chen-shubao", "陈叔宝", ["皇帝"], "陈后主，玉树后庭花，隋灭陈。", "陈叔宝"),
  // 北魏
  person("tuoba-gui", "拓跋珪", ["皇帝"], "北魏道武帝，386年建国，统一北方。", "魏道武帝"),
  person("tuoba-si", "拓跋嗣", ["皇帝"], "北魏明元帝，道武帝子，巩固北魏统治。", "魏明元帝"),
  person("tuoba-tao", "拓跋焘", ["皇帝"], "北魏太武帝，灭北凉，统一北方。", "魏太武帝"),
  person("tuoba-yu", "拓跋余", ["皇帝"], "北魏南安王，太武帝被杀后继位，旋被诛。", "元余"),
  person("tuoba-jun", "拓跋浚", ["皇帝"], "北魏文成帝，恢复佛教，与南朝和亲。", "魏文成帝"),
  person("tuoba-hong", "拓跋弘", ["皇帝"], "北魏献文帝，后禅位予子，为冯太后所杀。", "魏献文帝"),
  person("yuan-hong", "元宏", ["皇帝"], "北魏孝文帝，迁都洛阳，汉化改革。", "魏孝文帝"),
  person("yuan-ke", "元恪", ["皇帝"], "北魏宣武帝，孝文帝子。", "魏宣武帝"),
  person("yuan-xu", "元诩", ["皇帝"], "北魏孝明帝，被胡太后所毒杀。", "魏孝明帝"),
  person("yuan-zi-you", "元子攸", ["皇帝"], "北魏孝庄帝，诛尔朱荣，后为尔朱世隆所杀。", "魏孝庄帝"),
  person("yuan-ye", "元晔", ["皇帝"], "北魏长广王，尔朱氏所立，后被废杀。", "元晔"),
  person("yuan-lang", "元朗", ["皇帝"], "北魏节闵帝，尔朱氏所立，后被废。", "元朗"),
  person(
    "yuan-xiu",
    "元修",
    ["皇帝"],
    "北魏末帝；534年西迁长安，与东魏孝静帝并立，535年为宇文泰所杀。",
    "魏孝武帝",
  ),
  person("yuan-shan-jian", "元善见", ["皇帝"], "东魏孝静帝，高欢拥立于邺，东魏唯一皇帝，为北齐所废。", "魏孝静帝"),
  person(
    "yuan-bao-ju",
    "元宝炬",
    ["皇帝"],
    "西魏文帝，宇文泰杀孝武帝后拥立，都长安。",
    "元宝炬",
  ),
  person("yuan-qin", "元钦", ["皇帝"], "西魏废帝，为宇文泰所废杀。", "元钦"),
  person("tuoba-kuo", "拓跋廓", ["皇帝"], "西魏恭帝，西魏末代，禅让于北周宇文觉。", "魏恭帝"),
  // 北齐
  person("gao-yang", "高洋", ["皇帝"], "北齐文宣帝，建国于邺，前期励精，后期暴虐。", "齐文宣帝"),
  person("gao-yin", "高殷", ["皇帝"], "北齐废帝，文宣帝子，为叔父高演所废杀。", "齐废帝"),
  person("gao-yan", "高演", ["皇帝"], "北齐孝昭帝，夺侄位，在位仅两年。", "齐孝昭帝"),
  person("gao-zhan", "高湛", ["皇帝"], "北齐武成帝，荒淫，传位予子。", "齐武成帝"),
  person("gao-wei", "高纬", ["皇帝"], "北齐后主，宠信小人，为北周所灭。", "高纬"),
  person("gao-heng", "高恒", ["皇帝"], "北齐幼主，北齐末代，为北周所俘。", "高恒"),
  // 北周
  person("yuwen-jue", "宇文觉", ["皇帝"], "北周孝闵帝，代西魏建周，为宇文护所杀。", "周孝闵帝"),
  person("yuwen-yu", "宇文毓", ["皇帝"], "北周明帝，宇文觉之兄，为宇文护所毒杀。", "周明帝"),
  person("yuwen-yong", "宇文邕", ["皇帝"], "北周武帝，灭佛，灭北齐，统一北方。", "周武帝"),
  person("yuwen-yun", "宇文赟", ["皇帝"], "北周宣帝，荒淫，传位予子后崩。", "周宣帝"),
  person("yuwen-yan", "宇文衍", ["皇帝"], "北周静帝，北周末代，杨坚代周。", "周静帝"),
  // 重要人物
  person("hou-jing", "侯景", ["将领"], "北魏降将，梁武帝时降梁，后发动侯景之乱。", "侯景"),
  person("chen-qingzhi", "陈庆之", ["军事家"], "梁将，七千白袍军入洛阳，威震北魏。", "陈庆之"),
  person("erzhu-rong", "尔朱荣", ["军事家", "政治家"], "北魏权臣，河阴之变，后为孝庄帝所诛。", "尔朱荣"),
  // 非帝王人物
  person("feng-taihou", "冯太后", ["太后", "政治家"], "北魏文明太后，献文帝、孝文帝朝两度临朝，推动改革。", "冯太后", ym(442), ym(490)),
  person("hu-taihou", "胡太后", ["太后", "政治家"], "北魏灵太后，孝明帝生母，毒杀明帝，河阴之变后被沉河。", "胡太后", null, ym(528, 4)),
  person("zu-chongzhi", "祖冲之", ["科学家"], "南朝数学家，精确圆周率，大明历作者。", "祖冲之", ym(429), ym(500)),
  person("zhang-lihua", "张丽华", ["后妃", "政治家"], "陈后主宠妃，与孔、龚二妃干预朝政，隋灭陈时殉。", "张丽华", ym(559), ym(604)),
  person("yang-jian", "杨坚", ["皇帝", "政治家"], "隋文帝，代北周建隋，后灭陈统一天下。", "杨坚"),
];

const allPersons = persons;

// ── dynasties ──────────────────────────────────────────────────────────────


const dynastyGroups = [
  {
    id: "nan-chao",
    name: "南朝",
    altNames: [],
    scope: "cn",
    start: ym(420),
    end: ym(589, 12),
    precision: "year",
    note: "420–589年南朝（刘宋、南齐、南梁、南陈及江陵西梁）。",
  },
  {
    id: "bei-chao",
    name: "北朝",
    altNames: [],
    scope: "cn",
    start: ym(420),
    end: ym(581, 12),
    precision: "year",
    note: "420–581年北朝（北魏、东魏、西魏、北齐、北周）。",
  },
];

const dynasties = [
  {
    id: "wei-north",
    name: "北魏",
    altNames: ["魏", "拓跋魏"],
    scope: "cn",
    region: "east_asia",
    start: ym(386),
    end: ym(535, 2),
    precision: "year",
    groupId: "bei-chao",
    note: "拓跋珪386年建国，439年灭北凉统一北方；534年分裂，535年孝武帝被杀，北魏亡。",
  },
  {
    id: "song-liu",
    name: "刘宋",
    altNames: ["宋", "南朝宋"],
    scope: "cn",
    region: "east_asia",
    start: ym(420, 7),
    end: ym(479),
    precision: "year",
    groupId: "nan-chao",
    note: "刘裕代晋建宋，都建康；479年萧道成代宋。",
  },
  {
    id: "qi-nan",
    name: "南齐",
    altNames: ["齐", "萧齐"],
    scope: "cn",
    region: "east_asia",
    start: ym(479),
    end: ym(502),
    precision: "year",
    groupId: "nan-chao",
    note: "萧道成代宋建齐；502年萧衍代齐。",
  },
  {
    id: "liang-nan",
    name: "南梁",
    altNames: ["梁", "萧梁"],
    scope: "cn",
    region: "east_asia",
    start: ym(502),
    end: ym(557),
    precision: "year",
    groupId: "nan-chao",
    note: "萧衍代齐建梁；557年陈霸先代梁。",
  },
  {
    id: "chen-nan",
    name: "南陈",
    altNames: ["陈"],
    scope: "cn",
    region: "east_asia",
    start: ym(557),
    end: ym(589),
    precision: "year",
    groupId: "nan-chao",
    note: "陈霸先代梁建陈；589年隋灭陈，南北朝终结。",
  },
  {
    id: "qi-bei",
    name: "北齐",
    altNames: ["齐", "高齐"],
    scope: "cn",
    region: "east_asia",
    start: ym(550),
    end: ym(577),
    precision: "year",
    groupId: "bei-chao",
    note: "高洋代东魏建齐，都邺；577年北周灭齐。",
  },
  {
    id: "zhou-bei",
    name: "北周",
    altNames: ["周", "宇文周"],
    scope: "cn",
    region: "east_asia",
    start: ym(557, 2),
    end: ym(581, 3),
    precision: "month",
    groupId: "bei-chao",
    note: "557年2月宇文觉代西魏建周，都长安；581年3月杨坚代周。",
  },
  {
    id: "wei-east",
    name: "东魏",
    altNames: ["魏"],
    scope: "cn",
    region: "east_asia",
    start: ym(534, 11),
    end: ym(550, 2),
    precision: "year",
    groupId: "bei-chao",
    note: "高欢拥立孝静帝于邺；550年高洋代魏建齐。",
  },
  {
    id: "wei-west",
    name: "西魏",
    altNames: ["魏"],
    scope: "cn",
    region: "east_asia",
    start: ym(535, 2),
    end: ym(557, 2),
    precision: "year",
    groupId: "bei-chao",
    note: "宇文泰拥立文帝于长安；557年宇文觉代魏建周。",
  },
];

// ── reigns ─────────────────────────────────────────────────────────────────

const songLiuReigns = [
  dynastyReign("song-liu", "liu-yu-jin", "宋武帝", "武皇帝", "高祖", 420, 422, eras("reign-liu-yu-jin", [{ name: "永初", sy: 420, ey: 422 }])),
  dynastyReign("song-liu", "liu-yifu", "宋少帝", null, null, 422, 424),
  dynastyReign(
    "song-liu",
    "liu-yilong",
    "宋文帝",
    "文皇帝",
    "太祖",
    424,
    453,
    eras("reign-liu-yilong", [
      { name: "元嘉", sy: 424, ey: 453 },
    ]),
  ),
  dynastyReign("song-liu", "liu-shao", "宋元凶", null, null, 453, 453),
  dynastyReign(
    "song-liu",
    "liu-jun",
    "宋孝武帝",
    "孝武皇帝",
    "世祖",
    453,
    464,
    eras("reign-liu-jun", [
      { name: "孝建", sy: 454, ey: 456 },
      { name: "大明", sy: 457, ey: 464 },
    ]),
  ),
  dynastyReign("song-liu", "liu-ziye", "宋前废帝", null, null, 464, 465),
  dynastyReign("song-liu", "liu-yu-song", "宋明帝", "明皇帝", "太宗", 465, 472),
  dynastyReign("song-liu", "liu-yu-fei", "宋后废帝", null, null, 473, 477),
  dynastyReign("song-liu", "liu-zhun", "宋顺帝", "顺皇帝", null, 477, 479),
];

const qiNanReigns = [
  dynastyReign("qi-nan", "xiao-daocheng", "齐高帝", "高皇帝", "太祖", 479, 482),
  dynastyReign(
    "qi-nan",
    "xiao-ze",
    "齐武帝",
    "武皇帝",
    "世祖",
    482,
    493,
    eras("reign-xiao-ze", [{ name: "永明", sy: 483, ey: 493 }]),
  ),
  dynastyReign("qi-nan", "xiao-zhaoye", "齐郁林王", null, null, 494, 494),
  dynastyReign("qi-nan", "xiao-zhaowen", "齐海陵王", null, null, 494, 494),
  dynastyReign("qi-nan", "xiao-luan", "齐明帝", "明皇帝", "高宗", 494, 498),
  dynastyReign("qi-nan", "xiao-baojuan", "东昏侯", null, null, 499, 501),
  dynastyReign("qi-nan", "xiao-baorong", "齐和帝", "和帝", null, 501, 502),
];

const liangNanReigns = [
  dynastyReign(
    "liang-nan",
    "xiao-yan",
    "梁武帝",
    "武皇帝",
    "高祖",
    502,
    549,
    eras("reign-xiao-yan", [
      { name: "天监", sy: 502, ey: 519 },
      { name: "普通", sy: 520, ey: 527 },
      { name: "大通", sy: 527, ey: 529 },
      { name: "中大通", sy: 529, ey: 534 },
      { name: "大同", sy: 535, ey: 546 },
      { name: "中大同", sy: 546, ey: 547 },
      { name: "太清", sy: 547, ey: 549 },
    ]),
  ),
  dynastyReign("liang-nan", "xiao-gang", "梁简文帝", "简文帝", null, 549, 551),
  dynastyReign("liang-nan", "xiao-yi", "梁元帝", "孝元皇帝", null, 552, 555),
  dynastyReign("liang-nan", "xiao-fangzhi", "梁敬帝", "敬帝", null, 555, 557),
];

const chenNanReigns = [
  dynastyReign("chen-nan", "chen-baxian", "陈武帝", "武皇帝", "高祖", 557, 559),
  dynastyReign("chen-nan", "chen-qian", "陈文帝", "文皇帝", null, 559, 566),
  dynastyReign("chen-nan", "chen-bozong", "陈废帝", null, null, 566, 568),
  dynastyReign("chen-nan", "chen-xu", "陈宣帝", "宣皇帝", null, 568, 582),
  dynastyReign("chen-nan", "chen-shubao", "陈后主", null, null, 582, 589),
];

const weiNorthReigns = [
  dynastyReign("wei-north", "tuoba-gui", "魏道武帝", "道武皇帝", "太祖", 386, 409),
  dynastyReign("wei-north", "tuoba-si", "魏明元帝", "明元皇帝", "太宗", 409, 423),
  dynastyReign("wei-north", "tuoba-tao", "魏太武帝", "太武皇帝", "世祖", 423, 452),
  dynastyReign("wei-north", "tuoba-yu", "魏南安王", null, null, 452, 452),
  dynastyReign("wei-north", "tuoba-jun", "魏文成帝", "文成皇帝", "高宗", 452, 465),
  dynastyReign("wei-north", "tuoba-hong", "魏献文帝", "献文皇帝", null, 465, 471),
  dynastyReign(
    "wei-north",
    "yuan-hong",
    "魏孝文帝",
    "孝文皇帝",
    "高祖",
    471,
    499,
    eras("reign-yuan-hong", [
      { name: "太和", sy: 477, ey: 499 },
    ]),
  ),
  dynastyReign("wei-north", "yuan-ke", "魏宣武帝", "宣武皇帝", null, 499, 515),
  dynastyReign("wei-north", "yuan-xu", "魏孝明帝", "孝明皇帝", null, 515, 528),
  dynastyReign("wei-north", "yuan-zi-you", "魏孝庄帝", "孝庄皇帝", null, 528, 530),
  dynastyReign("wei-north", "yuan-ye", "魏长广王", null, null, 530, 531),
  dynastyReign("wei-north", "yuan-lang", "魏节闵帝", "节闵帝", null, 531, 532),
  dynastyReign("wei-north", "yuan-xiu", "魏孝武帝", "孝武皇帝", null, 532, 535),
];

const weiEastReigns = [
  dynastyReign("wei-east", "yuan-shan-jian", "魏孝静帝", "孝静皇帝", null, 534, 550),
];

const weiWestReigns = [
  dynastyReign("wei-west", "yuan-bao-ju", "魏文帝", "文皇帝", null, 535, 551),
  dynastyReign("wei-west", "yuan-qin", "魏废帝", null, null, 551, 554),
  dynastyReign("wei-west", "tuoba-kuo", "魏恭帝", "恭帝", null, 554, 557),
];

const qiBeiReigns = [
  dynastyReign("qi-bei", "gao-yang", "齐文宣帝", "文宣皇帝", null, 550, 559),
  dynastyReign("qi-bei", "gao-yin", "齐废帝", null, null, 560, 561),
  dynastyReign("qi-bei", "gao-yan", "齐孝昭帝", "孝昭皇帝", null, 561, 565),
  dynastyReign("qi-bei", "gao-zhan", "齐武成帝", "武成皇帝", null, 565, 569),
  dynastyReign("qi-bei", "gao-wei", "齐后主", null, null, 569, 577),
  dynastyReign("qi-bei", "gao-heng", "齐幼主", null, null, 577, 577),
];

const zhouBeiReigns = [
  dynastyReign("zhou-bei", "yuwen-jue", "周孝闵帝", "孝闵帝", null, 557, 557),
  dynastyReign("zhou-bei", "yuwen-yu", "周明帝", "明皇帝", null, 557, 560),
  dynastyReign("zhou-bei", "yuwen-yong", "周武帝", "武皇帝", null, 560, 578),
  dynastyReign("zhou-bei", "yuwen-yun", "周宣帝", "宣皇帝", null, 578, 579),
  dynastyReign("zhou-bei", "yuwen-yan", "周静帝", "静帝", null, 579, 581),
];

const reignGroups = [
  weiNorthReigns,
  weiEastReigns,
  weiWestReigns,
  songLiuReigns,
  qiNanReigns,
  liangNanReigns,
  chenNanReigns,
  qiBeiReigns,
  zhouBeiReigns,
];
const reigns = applyDocumentedDatesToReigns(reignGroups.flat());

// ── events ───────────────────────────────────────────────────────────────────

function eventPoint(partial) {
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
  };
}

const events = [
  eventPoint({
    id: "song-liu-founded",
    name: "刘宋代晋",
    kind: "politics",
    dateNote: "420年七月，刘裕受禅代晋",
    at: ym(420, 7),
    dynastyIds: ["song-liu", "jin-east"],
    participantIds: ["liu-yu-jin"],
    summary: "刘裕废晋恭帝自立，改国号宋，南朝开始。",
  }),
  eventRange({
    id: "yuanjia-rule",
    name: "元嘉之治",
    kind: "politics",
    timeMode: "span",
    start: ym(424),
    end: ym(453),
    dynastyIds: ["song-liu"],
    participantIds: ["liu-yilong"],
    summary: "宋文帝刘义隆励精图治，南朝国力达于鼎盛。",
  }),
  eventPoint({
    id: "qi-nan-founded",
    name: "南齐代宋",
    kind: "politics",
    at: ym(479),
    dynastyIds: ["song-liu", "qi-nan"],
    participantIds: ["xiao-daocheng", "liu-zhun"],
    summary: "萧道成废宋顺帝自立，改国号齐。",
  }),
  eventPoint({
    id: "liang-nan-founded",
    name: "南梁代齐",
    kind: "politics",
    at: ym(502),
    dynastyIds: ["qi-nan", "liang-nan"],
    participantIds: ["xiao-yan", "xiao-baorong"],
    summary: "萧衍废齐和帝自立，改国号梁。",
  }),
  eventRange({
    id: "xiaoyan-reform",
    name: "梁武帝崇佛",
    kind: "culture",
    timeMode: "span",
    dateNote: "萧衍多次舍身同泰寺，大力崇佛",
    start: ym(502),
    end: ym(549),
    dynastyIds: ["liang-nan"],
    participantIds: ["xiao-yan"],
    summary: "梁武帝萧衍崇信佛教，多次舍身，耗费国库。",
  }),
  eventRange({
    id: "houjing-rebellion",
    name: "侯景之乱",
    kind: "politics",
    timeMode: "span",
    dateNote: "548–552年，侯景叛梁，陷建康",
    start: ym(548),
    end: ym(552),
    dynastyIds: ["liang-nan"],
    participantIds: ["hou-jing", "xiao-yan"],
    summary: "侯景叛梁，攻陷建康，梁武帝饿死台城，江南凋敝。",
  }),
  eventPoint({
    id: "chen-nan-founded",
    name: "南陈代梁",
    kind: "politics",
    at: ym(557),
    dynastyIds: ["liang-nan", "chen-nan"],
    participantIds: ["chen-baxian", "xiao-fangzhi"],
    summary: "陈霸先废梁敬帝自立，改国号陈。",
  }),
  eventRange({
    id: "tuoba-reform",
    name: "孝文帝改革",
    kind: "politics",
    timeMode: "span",
    dateNote: "494年迁都洛阳，推行汉化",
    start: ym(471),
    end: ym(499),
    dynastyIds: ["wei-north"],
    participantIds: ["yuan-hong"],
    summary: "孝文帝迁都洛阳，改姓元，推行均田制与汉化政策。",
  }),
  eventPoint({
    id: "wei-split",
    name: "北魏分裂",
    kind: "politics",
    dateNote: "534年，孝武帝西迁，东魏、西魏分立",
    at: ym(534),
    dynastyIds: ["wei-north", "wei-east", "wei-west"],
    participantIds: ["yuan-xiu", "yuan-shan-jian"],
    summary: "孝武帝西迁，高欢立孝静帝于邺；次年宇文泰杀孝武帝立文帝于长安，北魏分裂。",
  }),
  eventPoint({
    id: "qi-bei-founded",
    name: "北齐代东魏",
    kind: "politics",
    at: ym(550),
    dynastyIds: ["wei-east", "qi-bei"],
    participantIds: ["gao-yang", "yuan-shan-jian"],
    summary: "高洋废东魏孝静帝自立，改国号齐，史称北齐。",
  }),
  eventPoint({
    id: "zhou-bei-founded",
    name: "北周代西魏",
    kind: "politics",
    at: ym(557),
    dynastyIds: ["wei-west", "zhou-bei"],
    participantIds: ["yuwen-jue", "tuoba-kuo"],
    summary: "宇文觉废西魏恭帝自立，改国号周，史称北周。",
  }),
  eventPoint({
    id: "zhou-qi-unify",
    name: "北周灭北齐",
    kind: "battle",
    dateNote: "577年，周武帝宇文邕灭齐",
    at: ym(577),
    dynastyIds: ["zhou-bei", "qi-bei"],
    participantIds: ["yuwen-yong", "gao-wei"],
    summary: "北周武帝攻灭北齐，北方重归统一。",
  }),
  eventPoint({
    id: "yang-jian-usurp",
    name: "杨坚代周",
    kind: "politics",
    dateNote: "581年，杨坚废周静帝，建隋",
    at: ym(581),
    dynastyIds: ["zhou-bei"],
    participantIds: ["yang-jian", "yuwen-yan"],
    summary: "杨坚废北周静帝自立，改国号隋，北朝终结。",
  }),
  eventPoint({
    id: "sui-chen-unify",
    name: "隋灭陈",
    kind: "politics",
    dateNote: "589年，隋军渡江灭陈",
    at: ym(589),
    dynastyIds: ["chen-nan"],
    participantIds: ["chen-shubao", "yang-jian"],
    summary: "隋军灭南陈，陈后主降，南北分裂终结，中国重归统一。",
  }),
  eventPoint({
    id: "chen-qingzhi-luoyang",
    name: "白袍军入洛",
    kind: "battle",
    dateNote: "528年，陈庆之率七千白袍军入洛阳",
    at: ym(528),
    dynastyIds: ["liang-nan", "wei-north"],
    participantIds: ["chen-qingzhi"],
    summary: "陈庆之率七千白袍军护送元颢入洛，威震北魏。",
  }),
  eventPoint({
    id: "he-yin-massacre",
    name: "河阴之变",
    kind: "politics",
    dateNote: "528年，尔朱荣于河阴屠杀百官",
    at: ym(528),
    dynastyIds: ["wei-north"],
    participantIds: ["erzhu-rong"],
    summary: "尔朱荣于河阴屠杀北魏公卿两千余人，后诛杀孝明帝。",
  }),
];

// ── relations ────────────────────────────────────────────────────────────────

function successionPairs(list) {
  const pairs = [];
  for (let i = 0; i < list.length - 1; i++) {
    pairs.push([list[i].personId, list[i + 1].personId]);
  }
  return pairs;
}

const relations = [];
for (const group of reignGroups) {
  for (const [fromId, toId] of successionPairs(group)) {
    relations.push({
      id: `rel-${fromId}-${toId}-succession`,
      fromRef: `person:${fromId}`,
      toRef: `person:${toId}`,
      kind: "succession",
    });
  }
}
relations.push(
  { id: "rel-houjing-xiao-yan", fromRef: "event:houjing-rebellion", toRef: "person:hou-jing", kind: "battle" },
  { id: "rel-zhouqi-yuwen-yong", fromRef: "event:zhou-qi-unify", toRef: "person:yuwen-yong", kind: "battle" },
  { id: "rel-songliu-liu-yu-jin", fromRef: "event:song-liu-founded", toRef: "person:liu-yu-jin", kind: "succession" },
);

// ── SQL generation (same helpers as jin-sixteen) ─────────────────────────────



function eventSql(e) {
  const cols = [
    "id", "name", "kind", "time_mode", "precision", "date_note",
    "at_year", "at_month", "at_abs",
    "start_year", "start_month", "start_abs",
    "end_year", "end_month", "end_abs",
    "summary",
  ];
  const vals = [
    sqlStr(e.id), sqlStr(e.name), sqlStr(e.kind), sqlStr(e.timeMode), sqlStr(e.precision), sqlStr(e.dateNote ?? null),
    e.at?.year ?? "NULL", e.at?.month ?? "NULL", e.atAbs ?? "NULL",
    e.start?.year ?? "NULL", e.start?.month ?? "NULL", e.startAbs ?? "NULL",
    e.end?.year ?? "NULL", e.end?.month ?? "NULL", e.endAbs ?? "NULL",
    sqlStr(e.summary ?? null),
  ];
  return `INSERT INTO events (${cols.join(", ")})
VALUES (${vals.join(", ")})
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;`;
}

function parseRef(raw) {
  const [type, ...rest] = raw.split(":");
  return { type, id: rest.join(":") };
}

function relationSql(r) {
  const from = parseRef(r.fromRef);
  const to = parseRef(r.toRef);
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)})
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;`;
}

const finalized = finalizeImportReigns("nanbei-chao", allPersons, reigns);
const merged = mergeAppellationsIntoPersons(finalized.persons, finalized.reigns);
const importPersons = merged.persons;
const importReigns = merged.reigns;


const staleRelationSql = [
  "DELETE FROM relations WHERE id IN ('rel-yuan-xiu-yuan-bao-ju-succession', 'rel-tuoba-kuo-yuan-shan-jian-succession');",
];
const eventDynastyCleanupSql = events.map((e) => {
  const keep = e.dynastyIds.map(sqlStr).join(", ");
  return keep
    ? `DELETE FROM event_dynasties WHERE event_id = ${sqlStr(e.id)} AND dynasty_id NOT IN (${keep});`
    : `DELETE FROM event_dynasties WHERE event_id = ${sqlStr(e.id)};`;
});
const eventDynastySql = events.flatMap((e) =>
  e.dynastyIds.map(
    (dynastyId) =>
      `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(e.id)}, ${sqlStr(dynastyId)}) ON CONFLICT DO NOTHING;`,
  ),
);
const eventParticipantSql = events.flatMap((e) =>
  e.participantIds.map(
    (personId) =>
      `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(e.id)}, ${sqlStr(personId)}) ON CONFLICT DO NOTHING;`,
  ),
);

const sql = [
  "-- EraLens period import: nanbei-chao",
  "-- Window: 386-01 .. 589-12 (Northern and Southern Dynasties)",
  "-- Chronology: Wikipedia Nanbei-chao emperor lists",
  "BEGIN;",
  "",
  "-- persons",
  ...importPersons.map(personSql),
  "",
  "-- dynasty_groups",
  ...dynastyGroups.map(dynastyGroupSql),
  "",
  "-- dynasties",
  ...dynasties.map(dynastySql),
  "",
  "-- reigns",
  ...importReigns.map((r) => reignSql(r, sqlStr, sqlJson, formatAppellationCsv)),
  "",
  "-- events",
  ...events.map(eventSql),
  "",
  "-- event_dynasties",
  ...eventDynastyCleanupSql,
  ...eventDynastySql,
  "",
  "-- event_participants",
  ...eventParticipantSql,
  "",
  "-- relations",
  ...staleRelationSql,
  ...relations.map(relationSql),
  "",
  "COMMIT;",
  "",
].join("\n");

mkdirSync(__dirname, { recursive: true });
writeFileSync(path.join(__dirname, "import.sql"), sql);

const manifest = {
  slug: "nanbei-chao",
  title: "南北朝",
  window: { startYear: 386, startMonth: 1, endYear: 589, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-18",
  counts: {
    persons: allPersons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "南北朝", url: "https://zh.wikipedia.org/wiki/南北朝" },
    { label: "南北朝君主列表", url: "https://zh.wikipedia.org/wiki/南北朝君主列表" },
    { label: "刘宋", url: "https://zh.wikipedia.org/wiki/刘宋" },
    { label: "北魏", url: "https://zh.wikipedia.org/wiki/北魏" },
    { label: "东魏", url: "https://zh.wikipedia.org/wiki/东魏" },
    { label: "西魏", url: "https://zh.wikipedia.org/wiki/西魏" },
    { label: "侯景之乱", url: "https://zh.wikipedia.org/wiki/侯景之乱" },
    { label: "孝文帝改革", url: "https://zh.wikipedia.org/wiki/北魏孝文帝改革" },
  ],
  notes: [
    "覆盖南北朝（420–589），含386年立国的北魏；北朝含北魏、东魏、西魏、北齐、北周，南朝含刘宋、南齐、南梁、南陈；江陵西梁（555–587）在 nanbei-sixteen-extra，同属 nan-chao。",
    "全部53位君主在位日取维基百科君主条目公历换算（documentedReignDates，precision=day）。",
    "刘裕（liu-yu-jin）复用 jin-sixteen 已有 id；北魏 id 为 wei-north，避免与曹魏 wei 冲突；东魏 wei-east、西魏 wei-west。",
    "东魏、西魏按通行史书习惯分期各占一行（与北齐、北周并列），不用北魏 claim_track。孝武帝仍属北魏（至535年2月3日）；孝静帝属东魏；文帝→废帝→恭帝属西魏。",
    "南梁 id 为 liang-nan，与十六国南凉 liang-south 区分。",
    "589 年隋灭陈为南北朝终结事件；隋（581–）不在本包内。",
    "西梁行在 nanbei-sixteen-extra，group_id 为 nan-chao，不另立组。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);

console.log(
  `Wrote import.sql + manifest.json: ${allPersons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`,
);
console.log("Sample abs:", {
  weiNorthStart: absMonth(386),
  songLiuStart: absMonth(420, 7),
  suiChenEnd: absMonth(589),
});
