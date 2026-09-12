#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Two Jin + Sixteen Kingdoms (266–439).
 * AbsMonth must match packages/shared/src/time.ts
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { defaultPreferredAppellation } from "../lib/defaultPreferredAppellation.mjs";

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
    id: `reign-${personId}`,
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

function dynastyReignMonth(
  dynastyId,
  personId,
  title,
  posthumous,
  temple,
  startYear,
  startMonth,
  endYear,
  endMonth,
  eraNames = [],
  preferred = null,
) {
  const pref =
    preferred ??
    defaultPreferredAppellation({ title, posthumous, temple, startYear: startYear, eraNames });
  return reign({
    id: `reign-${personId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    preferred: pref,
    start: ym(startYear, startMonth),
    end: ym(endYear, endMonth),
    eraNames,
    precision: "month",
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
  // 西晋
  person("sima-yan", "司马炎", ["皇帝"], "晋武帝，代魏建晋，灭吴统一天下。", "司马炎", ym(236), ym(290)),
  person("sima-zhong", "司马衷", ["皇帝"], "晋惠帝，智力低下，八王之乱在其朝爆发。", "司马衷"),
  person("sima-chi", "司马炽", ["皇帝"], "晋怀帝，永嘉之乱中被刘曜俘虏。", "司马炽"),
  person("sima-ye", "司马邺", ["皇帝"], "晋愍帝，西晋末代皇帝，长安陷落后被杀。", "司马邺"),
  // 东晋
  person("sima-rui", "司马睿", ["皇帝"], "晋元帝，南渡建康，开创东晋。", "司马睿", ym(276), ym(323)),
  person("sima-shao", "司马绍", ["皇帝"], "晋明帝，东晋第二位皇帝，澄清吏治。", "司马绍"),
  person("sima-yan-cheng", "司马衍", ["皇帝"], "晋成帝，幼年即位，苏峻之乱在其朝。", "司马衍"),
  person("sima-yue", "司马岳", ["皇帝"], "晋康帝，成帝之弟，在位仅两年。", "司马岳"),
  person("sima-dan", "司马聃", ["皇帝"], "晋穆帝，桓温北伐在其朝。", "司马聃"),
  person("sima-pi", "司马丕", ["皇帝"], "晋哀帝，服食丹药，在位五年。", "司马丕"),
  person("sima-yi-jin", "司马奕", ["皇帝"], "晋海西公，为桓温废黜。", "司马奕"),
  person("sima-yu-jin", "司马昱", ["皇帝"], "晋简文帝，桓温拥立，在位仅一年。", "司马昱"),
  person("sima-yao", "司马曜", ["皇帝"], "晋孝武帝，淝水之战在其朝，后被宫人缢杀。", "司马曜"),
  person("sima-dezong", "司马德宗", ["皇帝"], "晋安帝，痴呆，为刘裕所弑。", "司马德宗"),
  person("sima-dewen", "司马德文", ["皇帝"], "晋恭帝，东晋末代皇帝，刘裕禅让后被害。", "司马德文"),
  // 成汉
  person("li-xiong", "李雄", ["皇帝"], "成汉开国皇帝，据益州称帝。", "李雄_(十六国)"),
  person("li-ban", "李班", ["皇帝"], "成汉哀帝，李雄养子，在位仅数月。", "李班_(成汉)"),
  person("li-qi", "李期", ["皇帝"], "成汉末代君主之一，后被李寿废杀。", "李期"),
  person("li-shou", "李寿", ["皇帝"], "成汉昭文皇帝，改国号汉。", "李寿"),
  person("li-shi", "李势", ["皇帝"], "成汉末帝，桓温伐蜀后降晋。", "李势"),
  // 汉赵
  person("liu-yuan", "刘渊", ["皇帝"], "汉赵（前赵）开国皇帝，匈奴贵族，举兵反晋。", "刘渊"),
  person("liu-he", "刘和", ["皇帝"], "汉赵皇帝，刘渊嫡子，在位仅七日被刘聪所杀。", "刘和"),
  person("liu-cong", "刘聪", ["皇帝"], "汉赵昭武皇帝，灭西晋、俘怀愍二帝。", "刘聪"),
  person("liu-can", "刘粲", ["皇帝"], "汉赵末帝，在位仅一月被杀。", "刘粲"),
  person("liu-yao-jin", "刘曜", ["皇帝"], "汉赵末代君主，改国号赵，后为石勒所俘杀。", "刘曜"),
  // 后赵
  person("shi-le", "石勒", ["皇帝"], "后赵开国皇帝，羯族，统一北方大部。", "石勒"),
  person("shi-hong", "石弘", ["皇帝"], "后赵皇帝，石勒之子，为石虎所废。", "石弘"),
  person("shi-hu", "石虎", ["皇帝"], "后赵武皇帝，穷兵黩武，后赵由盛转衰。", "石虎"),
  // 前凉
  person("zhang-gui", "张轨", ["君主"], "前凉奠基者，任凉州刺史，保境安民。", "张轨"),
  person("zhang-shi", "张寔", ["君主"], "前凉昭王，张轨之子，继守河西。", "张寔"),
  person("zhang-mao", "张茂", ["君主"], "前凉成王，称臣于晋而实据凉州。", "张茂_(前凉)"),
  person("zhang-jun", "张骏", ["君主"], "前凉文王，前凉极盛时期。", "张骏_(十六国)"),
  person("zhang-chonghua", "张重华", ["君主"], "前凉桓王，张骏之子。", "张重华"),
  person("zhang-zuo", "张祚", ["君主"], "前凉威王，废杀侄儿，后为宋修所杀。", "张祚_(前凉)"),
  person("zhang-xuanjing", "张玄靓", ["君主"], "前凉冲王，幼年即位，后为张天锡所废。", "张玄靓"),
  person("zhang-tianxi", "张天锡", ["君主"], "前凉末代君主，前秦苻坚攻凉后降。", "张天锡_(前凉)"),
  // 前燕
  person("murong-huang", "慕容皝", ["皇帝"], "前燕文明皇帝，据辽东称燕王，后称帝。", "慕容皝"),
  person("murong-jun", "慕容儁", ["皇帝"], "前燕景昭皇帝，迁都邺城，前燕极盛。", "慕容儁"),
  person("murong-wei", "慕容暐", ["皇帝"], "前燕末帝，为前秦苻坚所灭。", "慕容暐"),
  // 前秦
  person("fu-jian", "苻健", ["皇帝"], "前秦开国皇帝，氐族，据关中。", "苻健"),
  person("fu-sheng", "苻生", ["皇帝"], "前秦废帝，苻健之子，暴虐，为苻坚所废。", "苻生"),
  person("fu-jian-ming", "苻坚", ["皇帝"], "前秦宣昭皇帝，统一北方，淝水之战后前秦崩溃。", "苻坚"),
  person("fu-chong", "苻崇", ["皇帝"], "前秦末帝，苻坚之子，为西秦乞伏乾归所杀。", "苻崇"),
  // 后燕
  person("murong-chui", "慕容垂", ["皇帝"], "后燕成武皇帝，前燕旧臣，淝水后复国。", "慕容垂"),
  person("murong-de-yan", "慕容德", ["皇帝"], "南燕开国皇帝，后燕分裂后据广固。", "慕容德"),
  person("murong-chao", "慕容超", ["皇帝"], "南燕末帝，为东晋刘裕所灭。", "慕容超"),
  person("murong-yi", "慕容义", ["皇帝"], "北燕末帝，为冯跋所废。", "慕容义"),
  person("murong-xi", "慕容熙", ["皇帝"], "后燕末帝，为冯跋兄弟所杀。", "慕容熙"),
  person("feng-ba", "冯跋", ["皇帝"], "北燕开国皇帝，据和龙。", "冯跋"),
  // 后秦
  person("yao-chang", "姚苌", ["皇帝"], "后秦武昭皇帝，苻坚旧臣，淝水后杀苻坚建后秦。", "姚苌"),
  person("yao-xing", "姚兴", ["皇帝"], "后秦文桓皇帝，崇佛，与东晋刘裕、北魏拓跋珪同时。", "姚兴"),
  person("yao-hong", "姚泓", ["皇帝"], "后秦末帝，为刘裕北伐所灭。", "姚泓"),
  // 西秦
  person("qifu-guoren", "乞伏国仁", ["皇帝"], "西秦开国，鲜卑乞伏部。", "乞伏国仁"),
  person("qifu-gan", "乞伏乾归", ["皇帝"], "西秦文威皇帝，复国后再亡。", "乞伏乾归"),
  // 后凉
  person("lu-guang", "吕光", ["皇帝"], "后凉武皇帝，前秦旧将，据凉州。", "吕光"),
  // 南凉
  person("tufa-wugu", "秃发乌孤", ["皇帝"], "南凉开国，鲜卑秃发部。", "秃发乌孤"),
  person("tufa-lilugu", "秃发利鹿孤", ["皇帝"], "南凉皇帝，秃发乌孤之弟。", "秃发利鹿孤"),
  person("tufa-rutan", "秃发傉檀", ["皇帝"], "南凉末帝，后为西秦所灭。", "秃发傉檀"),
  // 西凉
  person("li-gao", "李暠", ["皇帝"], "西凉武昭王，陇西李氏，据敦煌。", "李暠"),
  person("li-xin", "李歆", ["皇帝"], "西凉末帝，为北凉沮渠蒙逊所杀。", "李歆"),
  // 北凉
  person("juqu-mengxun", "沮渠蒙逊", ["皇帝"], "北凉开国，卢水胡，据河西。", "沮渠蒙逊"),
  person("juqu-mujian", "沮渠牧犍", ["皇帝"], "北凉末帝，北魏太武帝灭北凉。", "沮渠牧犍"),
  // 胡夏
  person("helian-bobo", "赫连勃勃", ["皇帝"], "胡夏开国，匈奴铁弗部，据朔方。", "赫连勃勃"),
  person("helian-chang", "赫连昌", ["皇帝"], "胡夏皇帝，赫连勃勃之子。", "赫连昌"),
  person("helian-ding", "赫连定", ["皇帝"], "胡夏末帝，为北魏所俘杀。", "赫连定"),
  // 军事人物
  person("wang-dao", "王导", ["政治家"], "东晋开国重臣，与司马睿共定江南，王与马共天下。", "王导"),
  person("huan-wen", "桓温", ["军事家", "政治家"], "东晋权臣，三次北伐，废海西公立简文帝。", "桓温"),
  person("xie-an", "谢安", ["政治家"], "东晋名相，淝水之战时主持朝政。", "谢安"),
  person("liu-yu-jin", "刘裕", ["军事家", "政治家"], "东晋末年权臣，北伐灭南燕、后秦，后代晋建宋。", "刘裕"),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const colorTokens = ["ochre", "indigo", "moss", "mineral", "cinnabar", "stone", "grape", "wisteria"];
let colorIdx = 0;
function nextColor() {
  return colorTokens[colorIdx++ % colorTokens.length];
}

const dynasties = [
  {
    id: "jin-west",
    name: "西晋",
    altNames: ["晋", "司马晋"],
    scope: "cn",
    region: "east_asia",
    start: ym(266, 2),
    end: ym(316, 4),
    precision: "year",
    colorToken: "stone",
    note: "司马炎代魏建晋，都洛阳；316年愍帝出降，西晋灭亡。",
  },
  {
    id: "jin-east",
    name: "东晋",
    altNames: ["晋"],
    scope: "cn",
    region: "east_asia",
    start: ym(317),
    end: ym(420, 7),
    precision: "year",
    colorToken: nextColor(),
    note: "司马睿南渡建康，与北方十六国对峙；420年刘裕代晋。",
  },
  {
    id: "cheng-han",
    name: "成汉",
    altNames: ["成", "汉", "大成"],
    scope: "cn",
    region: "east_asia",
    start: ym(304),
    end: ym(347),
    precision: "year",
    colorToken: nextColor(),
    note: "李雄据益州，304年建号，347年桓温伐蜀后灭亡。",
  },
  {
    id: "han-zhao",
    name: "汉赵",
    altNames: ["前赵", "汉", "赵"],
    scope: "cn",
    region: "east_asia",
    start: ym(304),
    end: ym(329),
    precision: "year",
    colorToken: nextColor(),
    note: "刘渊举兵反晋，304年建汉；329年石勒灭之，改国号赵。",
  },
  {
    id: "zhao-back",
    name: "后赵",
    altNames: ["赵", "魏"],
    scope: "cn",
    region: "east_asia",
    start: ym(319),
    end: ym(351),
    precision: "year",
    colorToken: nextColor(),
    note: "石勒据襄国，319年建后赵；351年内乱，冉闵篡位。",
  },
  {
    id: "liang-front",
    name: "前凉",
    altNames: ["凉"],
    scope: "cn",
    region: "east_asia",
    start: ym(301),
    end: ym(376),
    precision: "year",
    colorToken: nextColor(),
    note: "张轨301年任凉州刺史，张氏据河西百余年；376年前秦灭之。",
  },
  {
    id: "yan-front",
    name: "前燕",
    altNames: ["燕"],
    scope: "cn",
    region: "east_asia",
    start: ym(337),
    end: ym(370),
    precision: "year",
    colorToken: nextColor(),
    note: "慕容氏据辽东，337年慕容皝称燕王；370年前秦灭之。",
  },
  {
    id: "qin-front",
    name: "前秦",
    altNames: ["秦"],
    scope: "cn",
    region: "east_asia",
    start: ym(351),
    end: ym(394),
    precision: "year",
    colorToken: nextColor(),
    note: "苻氏据关中，苻坚一度统一北方；淝水之战后崩溃。",
  },
  {
    id: "yan-back",
    name: "后燕",
    altNames: ["燕"],
    scope: "cn",
    region: "east_asia",
    start: ym(384),
    end: ym(409),
    precision: "year",
    colorToken: nextColor(),
    note: "慕容垂淝水后复国，都中山；409年慕容熙被杀，后燕衰亡。",
  },
  {
    id: "qin-back",
    name: "后秦",
    altNames: ["秦"],
    scope: "cn",
    region: "east_asia",
    start: ym(384),
    end: ym(417),
    precision: "year",
    colorToken: nextColor(),
    note: "姚苌杀苻坚建后秦，都长安；417年刘裕北伐灭之。",
  },
  {
    id: "qin-xi",
    name: "西秦",
    altNames: ["秦"],
    scope: "cn",
    region: "east_asia",
    start: ym(385),
    end: ym(431),
    precision: "year",
    colorToken: nextColor(),
    note: "乞伏氏据陇右，386年乞伏国仁建西秦；431年赫连定俘杀乞伏暮末。",
  },
  {
    id: "liang-back",
    name: "后凉",
    altNames: ["凉"],
    scope: "cn",
    region: "east_asia",
    start: ym(386),
    end: ym(403),
    precision: "year",
    colorToken: nextColor(),
    note: "吕光据凉州，386年建后凉；403年南凉、北凉攻灭。",
  },
  {
    id: "liang-south",
    name: "南凉",
    altNames: ["凉"],
    scope: "cn",
    region: "east_asia",
    start: ym(397),
    end: ym(414),
    precision: "year",
    colorToken: nextColor(),
    note: "秃发氏据青海，397年建南凉；414年降西秦。",
  },
  {
    id: "liang-xi",
    name: "西凉",
    altNames: ["凉"],
    scope: "cn",
    region: "east_asia",
    start: ym(400),
    end: ym(421),
    precision: "year",
    colorToken: nextColor(),
    note: "李暠据敦煌，400年建西凉；421年北凉沮渠蒙逊灭之。",
  },
  {
    id: "liang-north",
    name: "北凉",
    altNames: ["凉"],
    scope: "cn",
    region: "east_asia",
    start: ym(397),
    end: ym(439),
    precision: "year",
    colorToken: nextColor(),
    note: "沮渠氏据河西，397年建北凉；439年北魏太武帝灭之，十六国时期终结。",
  },
  {
    id: "yan-south",
    name: "南燕",
    altNames: ["燕"],
    scope: "cn",
    region: "east_asia",
    start: ym(398),
    end: ym(410),
    precision: "year",
    colorToken: nextColor(),
    note: "慕容德据广固，398年建南燕；410年刘裕北伐灭之。",
  },
  {
    id: "yan-north",
    name: "北燕",
    altNames: ["燕"],
    scope: "cn",
    region: "east_asia",
    start: ym(407),
    end: ym(436),
    precision: "year",
    colorToken: nextColor(),
    note: "冯跋据和龙，407年建北燕；436年北魏灭之。",
  },
  {
    id: "xia-hu",
    name: "胡夏",
    altNames: ["夏", "大夏"],
    scope: "cn",
    region: "east_asia",
    start: ym(407),
    end: ym(431),
    precision: "year",
    colorToken: nextColor(),
    note: "赫连勃勃据朔方，407年建夏；431年赫连定为北魏所俘。",
  },
];

// ── reigns ─────────────────────────────────────────────────────────────────

const jinWestReigns = [
  dynastyReign(
    "jin-west",
    "sima-yan",
    "晋武帝",
    "武皇帝",
    "世祖",
    266,
    290,
    eras("reign-sima-yan", [
      { name: "泰始", sy: 265, ey: 274 },
      { name: "咸宁", sy: 275, ey: 280 },
      { name: "太康", sy: 280, ey: 289 },
      { name: "太熙", sy: 290, ey: 290 },
    ]),
  ),
  dynastyReign(
    "jin-west",
    "sima-zhong",
    "晋惠帝",
    "孝惠皇帝",
    null,
    290,
    306,
    eras("reign-sima-zhong", [
      { name: "永熙", sy: 290, ey: 290 },
      { name: "永平", sy: 291, ey: 291 },
      { name: "元康", sy: 291, ey: 299 },
      { name: "永康", sy: 300, ey: 301 },
      { name: "永宁", sy: 301, ey: 302 },
      { name: "太安", sy: 302, ey: 304 },
      { name: "永安", sy: 304, ey: 304 },
      { name: "建武", sy: 304, ey: 304 },
      { name: "永兴", sy: 304, ey: 306 },
      { name: "光熙", sy: 306, ey: 306 },
    ]),
  ),
  dynastyReign("jin-west", "sima-chi", "晋怀帝", "孝怀皇帝", null, 306, 312),
  dynastyReign("jin-west", "sima-ye", "晋愍帝", "孝愍皇帝", null, 313, 316),
];

const jinEastReigns = [
  dynastyReign(
    "jin-east",
    "sima-rui",
    "晋元帝",
    "元皇帝",
    "中宗",
    317,
    323,
    eras("reign-sima-rui", [
      { name: "建武", sy: 317, ey: 317 },
      { name: "大兴", sy: 318, ey: 321 },
      { name: "永昌", sy: 322, ey: 323 },
    ]),
  ),
  dynastyReign("jin-east", "sima-shao", "晋明帝", "孝明皇帝", "肃宗", 323, 325, eras("reign-sima-shao", [{ name: "太宁", sy: 323, ey: 326 }])),
  dynastyReign(
    "jin-east",
    "sima-yan-cheng",
    "晋成帝",
    "孝成皇帝",
    "显宗",
    325,
    342,
    eras("reign-sima-yan-cheng", [
      { name: "咸和", sy: 326, ey: 334 },
      { name: "咸康", sy: 335, ey: 342 },
    ]),
  ),
  dynastyReign("jin-east", "sima-yue", "晋康帝", "孝康皇帝", null, 342, 344, eras("reign-sima-yue", [{ name: "建元", sy: 343, ey: 344 }])),
  dynastyReign(
    "jin-east",
    "sima-dan",
    "晋穆帝",
    "孝穆皇帝",
    null,
    344,
    361,
    eras("reign-sima-dan", [
      { name: "永和", sy: 345, ey: 356 },
      { name: "升平", sy: 357, ey: 361 },
    ]),
  ),
  dynastyReign(
    "jin-east",
    "sima-pi",
    "晋哀帝",
    "孝哀皇帝",
    null,
    361,
    365,
    eras("reign-sima-pi", [
      { name: "隆和", sy: 362, ey: 363 },
      { name: "兴宁", sy: 363, ey: 365 },
    ]),
  ),
  dynastyReign("jin-east", "sima-yi-jin", "晋海西公", null, null, 365, 371, eras("reign-sima-yi-jin", [{ name: "太和", sy: 366, ey: 371 }])),
  dynastyReign("jin-east", "sima-yu-jin", "晋简文帝", null, null, 371, 372, eras("reign-sima-yu-jin", [{ name: "咸安", sy: 371, ey: 372 }])),
  dynastyReign(
    "jin-east",
    "sima-yao",
    "晋孝武帝",
    "孝武皇帝",
    null,
    372,
    396,
    eras("reign-sima-yao", [
      { name: "宁康", sy: 373, ey: 375 },
      { name: "太元", sy: 376, ey: 396 },
    ]),
  ),
  dynastyReign(
    "jin-east",
    "sima-dezong",
    "晋安帝",
    "孝安皇帝",
    null,
    396,
    419,
    eras("reign-sima-dezong", [
      { name: "隆安", sy: 397, ey: 401 },
      { name: "元兴", sy: 402, ey: 404 },
      { name: "义熙", sy: 405, ey: 419 },
    ]),
  ),
  dynastyReign("jin-east", "sima-dewen", "晋恭帝", "孝恭皇帝", null, 419, 420, eras("reign-sima-dewen", [{ name: "元熙", sy: 419, ey: 420 }])),
];

const chengHanReigns = [
  dynastyReign("cheng-han", "li-xiong", "成汉武皇帝", "武皇帝", "太宗", 304, 334),
  dynastyReign("cheng-han", "li-ban", "成汉哀皇帝", "哀皇帝", null, 334, 334),
  dynastyReign("cheng-han", "li-qi", "成汉幽公", null, null, 335, 338),
  dynastyReign("cheng-han", "li-shou", "成汉昭文皇帝", "昭文皇帝", "中宗", 338, 343),
  dynastyReign("cheng-han", "li-shi", "成汉末帝", null, null, 343, 347),
];

// 汉赵同年更替：刘渊七月卒→刘和（七日）→刘聪八月即位；刘聪八月卒→刘粲→刘曜十月即位。
const hanZhaoReigns = [
  dynastyReignMonth("han-zhao", "liu-yuan", "汉赵光文皇帝", "光文皇帝", "高祖", 304, 1, 310, 7),
  dynastyReignMonth("han-zhao", "liu-he", "汉赵皇帝", null, null, 310, 7, 310, 7),
  dynastyReignMonth("han-zhao", "liu-cong", "汉赵昭武皇帝", "昭武皇帝", null, 310, 8, 318, 8),
  dynastyReignMonth("han-zhao", "liu-can", "汉赵末帝", null, null, 318, 8, 318, 9),
  dynastyReignMonth("han-zhao", "liu-yao-jin", "汉赵末帝", null, null, 318, 10, 329, 12),
];

const zhaoBackReigns = [
  dynastyReign("zhao-back", "shi-le", "后赵明皇帝", "明皇帝", "高祖", 319, 333),
  dynastyReign("zhao-back", "shi-hong", "后赵皇帝", null, null, 333, 334),
  dynastyReign("zhao-back", "shi-hu", "后赵武皇帝", "武皇帝", "太祖", 334, 349),
];

const liangFrontReigns = [
  dynastyReign("liang-front", "zhang-gui", "前凉奠基者", null, null, 301, 314),
  dynastyReign("liang-front", "zhang-shi", "前凉昭王", "昭王", null, 314, 320),
  dynastyReign("liang-front", "zhang-mao", "前凉成王", "成王", null, 320, 324),
  dynastyReign("liang-front", "zhang-jun", "前凉文王", "文王", null, 324, 346),
  dynastyReign("liang-front", "zhang-chonghua", "前凉桓王", "桓王", null, 346, 353),
  dynastyReign("liang-front", "zhang-zuo", "前凉威王", "威王", null, 353, 355),
  dynastyReign("liang-front", "zhang-xuanjing", "前凉冲王", "冲王", null, 355, 363),
  dynastyReign("liang-front", "zhang-tianxi", "前凉末王", null, null, 363, 376),
];

const yanFrontReigns = [
  dynastyReign("yan-front", "murong-huang", "前燕文明皇帝", "文明皇帝", null, 337, 348),
  dynastyReign("yan-front", "murong-jun", "前燕景昭皇帝", "景昭皇帝", null, 348, 360),
  dynastyReign("yan-front", "murong-wei", "前燕末帝", null, null, 360, 370),
];

const qinFrontReigns = [
  dynastyReign("qin-front", "fu-jian", "前秦景明皇帝", "景明皇帝", null, 351, 355),
  dynastyReign("qin-front", "fu-sheng", "前秦废帝", null, null, 355, 357),
  dynastyReign("qin-front", "fu-jian-ming", "前秦宣昭皇帝", "宣昭皇帝", null, 357, 385),
  dynastyReign("qin-front", "fu-chong", "前秦末帝", null, null, 385, 394),
];

const yanBackReigns = [
  dynastyReign("yan-back", "murong-chui", "后燕成武皇帝", "成武皇帝", "世祖", 384, 396),
  dynastyReign("yan-back", "murong-xi", "后燕末帝", null, null, 401, 409),
];

const qinBackReigns = [
  dynastyReign("qin-back", "yao-chang", "后秦武昭皇帝", "武昭皇帝", "太祖", 384, 394),
  dynastyReign("qin-back", "yao-xing", "后秦文桓皇帝", "文桓皇帝", null, 394, 416),
  dynastyReign("qin-back", "yao-hong", "后秦末帝", null, null, 416, 417),
];

const qinXiReigns = [
  dynastyReign("qin-xi", "qifu-guoren", "西秦武元王", "武元王", null, 385, 388),
  dynastyReign("qin-xi", "qifu-gan", "西秦文威皇帝", "文威皇帝", null, 388, 412),
];

const liangBackReigns = [dynastyReign("liang-back", "lu-guang", "后凉武皇帝", "武皇帝", null, 386, 399)];

const liangSouthReigns = [
  dynastyReign("liang-south", "tufa-wugu", "南凉武成王", "武成王", null, 397, 399),
  dynastyReign("liang-south", "tufa-lilugu", "南凉皇帝", null, null, 399, 402),
  dynastyReign("liang-south", "tufa-rutan", "南凉末帝", null, null, 402, 414),
];

const liangXiReigns = [
  dynastyReign("liang-xi", "li-gao", "西凉武昭王", "武昭王", null, 400, 417),
  dynastyReign("liang-xi", "li-xin", "西凉末帝", null, null, 417, 421),
];

const liangNorthReigns = [
  dynastyReign("liang-north", "juqu-mengxun", "北凉武宣王", "武宣王", null, 397, 433),
  dynastyReign("liang-north", "juqu-mujian", "北凉末帝", null, null, 433, 439),
];

const yanSouthReigns = [
  dynastyReign("yan-south", "murong-de-yan", "南燕献武皇帝", "献武皇帝", null, 398, 405),
  dynastyReign("yan-south", "murong-chao", "南燕末帝", null, null, 405, 410),
];

const yanNorthReigns = [dynastyReign("yan-north", "feng-ba", "北燕文成皇帝", "文成皇帝", null, 407, 430)];

const xiaHuReigns = [
  dynastyReign("xia-hu", "helian-bobo", "胡夏武皇帝", "武皇帝", null, 407, 425),
  dynastyReign("xia-hu", "helian-chang", "胡夏皇帝", null, null, 425, 428),
  dynastyReign("xia-hu", "helian-ding", "胡夏末帝", null, null, 428, 431),
];

const reignGroups = [
  jinWestReigns,
  jinEastReigns,
  chengHanReigns,
  hanZhaoReigns,
  zhaoBackReigns,
  liangFrontReigns,
  yanFrontReigns,
  qinFrontReigns,
  yanBackReigns,
  qinBackReigns,
  qinXiReigns,
  liangBackReigns,
  liangSouthReigns,
  liangXiReigns,
  liangNorthReigns,
  yanSouthReigns,
  yanNorthReigns,
  xiaHuReigns,
];
const reigns = reignGroups.flat();

// ── events ───────────────────────────────────────────────────────────────────

function eventPoint(partial) {
  const at = partial.at;
  return {
    kind: "other",
    timeMode: "point",
    precision: "year",
    dynastyIds: [],
    participantIds: [],
    ...partial,
    at,
    atAbs: at.abs,
  };
}
function eventRange(partial) {
  const start = partial.start;
  const end = partial.end;
  const at = partial.at;
  return {
    kind: "other",
    precision: "year",
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

const events = [
  eventPoint({
    id: "jin-founded",
    name: "西晋建立",
    kind: "politics",
    at: ym(266, 2),
    dynastyIds: ["jin-west"],
    participantIds: ["sima-yan"],
    summary: "司马炎代魏受禅，改国号晋，定都洛阳。",
  }),
  eventPoint({
    id: "jin-unify-wu",
    name: "晋灭吴统一天下",
    kind: "politics",
    precision: "month",
    dateNote: "太康元年四月，280年",
    at: ym(280, 4),
    dynastyIds: ["jin-west"],
    participantIds: ["sima-yan"],
    summary: "晋军灭东吴，三国分裂终结，西晋完成统一。",
  }),
  eventRange({
    id: "eight-princes",
    name: "八王之乱",
    kind: "politics",
    timeMode: "span",
    dateNote: "291–306年，诸王争权，国力大损",
    start: ym(291),
    end: ym(306, 12),
    dynastyIds: ["jin-west"],
    participantIds: ["sima-zhong"],
    summary: "西晋宗室诸王相互攻伐，中央权威崩溃，为五胡乱华埋下祸根。",
  }),
  eventPoint({
    id: "yongjia-disaster",
    name: "永嘉之乱",
    kind: "battle",
    dateNote: "永嘉五年，311年，刘曜陷洛阳",
    at: ym(311),
    dynastyIds: ["jin-west", "han-zhao"],
    participantIds: ["sima-chi", "liu-cong"],
    summary: "汉赵刘曜攻陷洛阳，俘晋怀帝，中原士族南渡，西晋名存实亡。",
  }),
  eventPoint({
    id: "jin-west-fall",
    name: "西晋灭亡",
    kind: "politics",
    dateNote: "316年，刘曜陷长安，愍帝出降",
    at: ym(316, 4),
    dynastyIds: ["jin-west", "han-zhao"],
    participantIds: ["sima-ye", "liu-yao-jin"],
    summary: "晋愍帝出降刘曜，西晋正式灭亡。",
  }),
  eventPoint({
    id: "jin-east-founded",
    name: "东晋建立",
    kind: "politics",
    dateNote: "317年，司马睿即皇帝位于建康",
    at: ym(317),
    dynastyIds: ["jin-east"],
    participantIds: ["sima-rui", "wang-dao"],
    summary: "司马睿南渡即帝位，建都建康，东晋开始，王导等士族共定江南。",
  }),
  eventPoint({
    id: "cheng-han-founded",
    name: "成汉建立",
    kind: "politics",
    at: ym(304),
    dynastyIds: ["cheng-han"],
    participantIds: ["li-xiong"],
    summary: "李雄据益州称成都王，后称帝，成汉立国。",
  }),
  eventPoint({
    id: "han-zhao-founded",
    name: "汉赵建立",
    kind: "politics",
    at: ym(304),
    dynastyIds: ["han-zhao"],
    participantIds: ["liu-yuan"],
    summary: "刘渊于离石举兵，称汉王，后称帝，五胡乱华开端。",
  }),
  eventRange({
    id: "wuhu-chaos",
    name: "五胡乱华",
    kind: "politics",
    timeMode: "span",
    dateNote: "304年起诸胡纷纷立国，中原长期战乱",
    start: ym(304),
    end: ym(439),
    dynastyIds: ["jin-west", "jin-east", "han-zhao", "cheng-han"],
    participantIds: ["liu-yuan", "li-xiong"],
    summary: "匈奴、羯、氐、羌、鲜卑等族内迁并建立政权，北方长期分裂混战。",
  }),
  eventPoint({
    id: "zhao-back-founded",
    name: "后赵建立",
    kind: "politics",
    at: ym(319),
    dynastyIds: ["zhao-back"],
    participantIds: ["shi-le"],
    summary: "石勒据襄国，称赵王，后称帝，建立后赵。",
  }),
  eventPoint({
    id: "qin-front-founded",
    name: "前秦建立",
    kind: "politics",
    at: ym(351),
    dynastyIds: ["qin-front"],
    participantIds: ["fu-jian"],
    summary: "苻健据长安称帝，前秦开始。",
  }),
  eventRange({
    id: "fu-jian-unify-north",
    name: "苻坚统一北方",
    kind: "politics",
    timeMode: "span",
    dateNote: "370–376年，前秦先后灭前燕、前凉等",
    start: ym(370),
    end: ym(376),
    dynastyIds: ["qin-front", "yan-front", "liang-front"],
    participantIds: ["fu-jian-ming"],
    summary: "苻坚任用王猛，先后灭前燕、前凉等，统一北方，为十六国最大疆域。",
  }),
  eventPoint({
    id: "feishui-battle",
    name: "淝水之战",
    kind: "battle",
    dateNote: "太元八年，383年，前秦败于东晋",
    at: ym(383),
    dynastyIds: ["jin-east", "qin-front"],
    participantIds: ["fu-jian-ming", "sima-yao", "xie-an"],
    summary: "苻坚率百万大军南征东晋，于淝水惨败，前秦迅速崩溃，北方再分裂。",
  }),
  eventRange({
    id: "huan-wen-expeditions",
    name: "桓温北伐",
    kind: "battle",
    timeMode: "span",
    dateNote: "354、356、369年三次北伐",
    start: ym(354),
    end: ym(369),
    dynastyIds: ["jin-east"],
    participantIds: ["huan-wen"],
    summary: "桓温三次北伐，一度逼近长安，但最终未能恢复中原。",
  }),
  eventPoint({
    id: "cheng-han-fall",
    name: "桓温伐蜀",
    kind: "battle",
    dateNote: "346年，桓温攻成都，李势降",
    at: ym(346),
    dynastyIds: ["jin-east", "cheng-han"],
    participantIds: ["huan-wen", "li-shi"],
    summary: "桓温率军伐蜀，李势投降，成汉灭亡。",
  }),
  eventPoint({
    id: "liu-yu-north",
    name: "刘裕北伐",
    kind: "battle",
    dateNote: "416–417年，刘裕灭后秦",
    at: ym(417),
    dynastyIds: ["jin-east", "qin-back"],
    participantIds: ["liu-yu-jin", "yao-hong"],
    summary: "刘裕率军北伐，攻占长安，灭后秦，东晋势力达于极北。",
  }),
  eventPoint({
    id: "jin-east-end",
    name: "东晋灭亡",
    kind: "politics",
    dateNote: "420年，刘裕代晋",
    at: ym(420, 7),
    dynastyIds: ["jin-east"],
    participantIds: ["liu-yu-jin", "sima-dewen"],
    summary: "刘裕受禅代晋，建宋，东晋终结。",
  }),
  eventPoint({
    id: "sixteen-kingdoms-end",
    name: "北魏灭北凉",
    kind: "politics",
    dateNote: "439年，拓跋焘灭北凉，统一华北",
    at: ym(439),
    dynastyIds: ["liang-north"],
    participantIds: ["juqu-mujian"],
    summary: "北魏太武帝灭北凉，统一华北，五胡十六国时期结束。",
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
  { id: "rel-feishui-fu-jian", fromRef: "event:feishui-battle", toRef: "person:fu-jian-ming", kind: "battle" },
  { id: "rel-feishui-xie-an", fromRef: "event:feishui-battle", toRef: "person:xie-an", kind: "battle" },
  { id: "rel-yongjia-liu-cong", fromRef: "event:yongjia-disaster", toRef: "person:liu-cong", kind: "battle" },
  { id: "rel-jin-east-wang-dao", fromRef: "event:jin-east-founded", toRef: "person:wang-dao", kind: "alliance" },
);

// ── SQL generation ───────────────────────────────────────────────────────────

function personSql(p) {
  return `INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  ${sqlStr(p.id)}, ${sqlStr(p.name)},
  ${p.birth?.year ?? "NULL"}, ${p.birth?.month ?? "NULL"},
  ${p.death?.year ?? "NULL"}, ${p.death?.month ?? "NULL"},
  ${sqlArray(p.roles)}, ${sqlStr(p.bio)}, ${sqlJson(p.links)}
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;`;
}

function dynastySql(d) {
  return `INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  ${sqlStr(d.id)}, ${sqlStr(d.name)}, ${sqlArray(d.altNames)}, ${sqlStr(d.scope)}, ${sqlStr(d.region)},
  ${d.start.year}, ${d.start.month}, ${d.end.year}, ${d.end.month},
  ${d.start.abs}, ${d.end.abs}, ${sqlStr(d.precision)}, ${sqlStr(d.colorToken)}, NULL,
  ${sqlStr(d.note)}
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  color_token = EXCLUDED.color_token,
  note = EXCLUDED.note;`;
}

function reignSql(r) {
  return `INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  ${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(r.title)},
  ${sqlStr(r.posthumousName ?? null)}, ${sqlStr(r.templeName ?? null)}, ${sqlJson(r.preferredAppellation)},
  ${r.start.year}, ${r.start.month}, ${r.end.year}, ${r.end.month},
  ${r.startAbs}, ${r.endAbs}, ${sqlStr(r.precision)}
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;`;
}

function eraNameSql(e) {
  return `INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES (${sqlStr(e.reignId)}, ${sqlStr(e.name)}, ${e.start.year}, ${e.start.month}, ${e.end.year}, ${e.end.month}, ${e.start.abs}, ${e.end.abs}, ${e.sortOrder});`;
}

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

const reignsWithEras = reigns.filter((r) => r.eraNames.length > 0);
const eraDeleteSql = reignsWithEras.map((r) => `DELETE FROM era_names WHERE reign_id = ${sqlStr(r.id)};`);
const eraInsertSql = reignsWithEras.flatMap((r) => r.eraNames.map(eraNameSql));

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
  "-- EraLens period import: jin-sixteen",
  "-- Window: 266-02 .. 439-12 (Two Jin + Sixteen Kingdoms)",
  "-- Chronology: Wikipedia Jin + Sixteen Kingdoms emperor lists",
  "BEGIN;",
  "",
  "-- persons",
  ...persons.map(personSql),
  "",
  "-- dynasties",
  ...dynasties.map(dynastySql),
  "",
  "-- reigns",
  ...reigns.map(reignSql),
  "",
  "-- era_names",
  ...eraDeleteSql,
  ...eraInsertSql,
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
  slug: "jin-sixteen",
  title: "两晋五胡十六国",
  window: { startYear: 266, startMonth: 2, endYear: 439, endMonth: 12 },
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
    { label: "晋朝", url: "https://zh.wikipedia.org/wiki/晋朝" },
    { label: "晋朝君主列表", url: "https://zh.wikipedia.org/wiki/晋朝君主列表" },
    { label: "五胡十六国", url: "https://zh.wikipedia.org/wiki/五胡十六国" },
    { label: "五胡十六国君主列表", url: "https://zh.wikipedia.org/wiki/五胡十六国君主列表" },
    { label: "淝水之战", url: "https://zh.wikipedia.org/wiki/淝水之战" },
    { label: "永嘉之乱", url: "https://zh.wikipedia.org/wiki/永嘉之乱" },
  ],
  notes: [
    "覆盖西晋（266–316）、东晋（317–420）及崔鸿《十六国春秋》所列十六国（304–439）。",
    "王朝与皇帝在位年取维基百科君主列表常见年表，precision=year；汉赵同年更替者用 month。",
    "西晋 upsert 已有 jin-west 行；胡夏 id 为 xia-hu，避免与夏朝 xia 冲突。",
    "前秦/后秦/西秦 id 分别为 qin-front/qin-back/qin-xi，避免与秦朝 qin 冲突。",
    "439 年北魏灭北凉为十六国终结事件；北魏本身归入南北朝，不在此包内。",
    "未收录冉魏、西燕、仇池等《十六国春秋》以外的小国。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);

console.log(
  `Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`,
);
console.log("Sample abs:", {
  jinWestStart: absMonth(266, 2),
  feishui: absMonth(383),
  sixteenEnd: absMonth(439),
});
