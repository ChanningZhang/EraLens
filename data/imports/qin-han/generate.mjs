#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Qin through Eastern Han (incl. Xin, Gengshi).
 * AbsMonth must match packages/shared/src/time.ts
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import { finalizeImportReigns } from "../lib/missingReigns.mjs";
import { reignSql } from "../lib/sqlHelpers.mjs";

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

const wiki = (title) => [{ label: "维基百科", url: `https://zh.wikipedia.org/wiki/${title}` }];

const persons = [
  { id: "ying-zheng", name: "嬴政", birth: ym(-259), death: ym(-210), roles: ["皇帝"], bio: "秦始皇帝，灭六国统一天下，建立中国首个大一统中央集权帝国。", links: wiki("秦始皇") },
  { id: "ying-huhai", name: "胡亥", roles: ["皇帝"], bio: "秦二世皇帝，赵高矫诏即位，秦政益暴，终致天下反叛。", links: wiki("秦二世") },
  { id: "ying-ziying", name: "子婴", roles: ["君主"], bio: "秦末秦王，赵高废二世后立之，刘邦入关后投降，秦朝终结。", links: wiki("秦王子婴") },
  { id: "li-si", name: "李斯", roles: ["政治家"], bio: "秦相，助嬴政统一，推行郡县、书同文，后因赵高陷害被诛。", links: wiki("李斯") },
  { id: "chen-sheng", name: "陈胜", roles: ["起义领袖"], bio: "大泽乡起义领袖，首开秦末农民战争。", links: wiki("陈胜") },
  { id: "wu-guang", name: "吴广", roles: ["起义领袖"], bio: "与陈胜共举大泽乡义旗，后称王于张楚。", links: wiki("吴广") },
  { id: "xiang-yu", name: "项羽", birth: ym(-232), death: ym(-202), roles: ["霸王", "军事家"], bio: "西楚霸王，巨鹿破秦军，垓下败于刘邦后自刎。", links: wiki("项羽") },
  { id: "liu-bang", name: "刘邦", birth: ym(-256), death: ym(-195), roles: ["皇帝"], bio: "汉高祖，楚汉之争胜项羽，建立西汉。", links: wiki("刘邦") },
  { id: "lv-zhi", name: "吕雉", roles: ["皇后", "政治家"], bio: "汉高祖皇后，惠帝后临朝称制，史称吕后。", links: wiki("吕雉") },
  { id: "xiao-he", name: "萧何", birth: ym(-257), death: ym(-193), roles: ["政治家"], bio: "汉初相国，定都长安、制律令，与韩信、张良并称三杰。", links: wiki("萧何") },
  { id: "han-xin", name: "韩信", birth: ym(-231), death: ym(-196), roles: ["军事家"], bio: "汉初大将，破赵燕齐楚，垓下围项羽，后遭诛。", links: wiki("韩信") },
  { id: "zhang-liang", name: "张良", birth: ym(-250), death: ym(-186), roles: ["政治家", "军事家"], bio: "汉初谋臣，鸿门宴护刘邦，功成身退。", links: wiki("张良") },
  { id: "liu-ying", name: "刘盈", birth: ym(-211), death: ym(-188), roles: ["皇帝"], bio: "汉惠帝，高祖嫡子，在位推行与民休息。", links: wiki("刘盈") },
  { id: "liu-gong", name: "刘恭", roles: ["皇帝"], bio: "史称前少帝，惠帝子，为吕后所废杀，汉朝未正式承认。", links: wiki("刘恭") },
  { id: "liu-hong-shao", name: "刘弘", roles: ["皇帝"], bio: "史称后少帝，吕氏所立，文帝即位后被废，汉朝未正式承认。", links: wiki("刘弘") },
  { id: "liu-heng", name: "刘恒", birth: ym(-203), death: ym(-157), roles: ["皇帝"], bio: "汉文帝，铲除诸吕后即位，与景帝共创文景之治。", links: wiki("汉文帝") },
  { id: "liu-qi", name: "刘启", birth: ym(-188), death: ym(-141), roles: ["皇帝"], bio: "汉景帝，平定七国之乱，延续轻徭薄赋。", links: wiki("汉景帝") },
  { id: "liu-che", name: "刘彻", birth: ym(-156), death: ym(-87), roles: ["皇帝"], bio: "汉武帝，开疆拓土、独尊儒术，西汉国力达于鼎盛。", links: wiki("汉武帝") },
  { id: "liu-fuling", name: "刘弗陵", birth: ym(-94), death: ym(-74), roles: ["皇帝"], bio: "汉昭帝，武帝少子，与宣帝之间史称昭宣之治。", links: wiki("汉昭帝") },
  { id: "liu-he", name: "刘贺", roles: ["皇帝"], bio: "汉废帝，昭帝崩后由霍光等拥立，在位仅二十七日即被废。", links: wiki("刘贺") },
  { id: "liu-xun", name: "刘询", birth: ym(-91), death: ym(-48), roles: ["皇帝"], bio: "汉宣帝，武帝曾孙，中兴汉室，史称昭宣之治。", links: wiki("汉宣帝") },
  { id: "liu-shi", name: "刘奭", birth: ym(-75), death: ym(-33), roles: ["皇帝"], bio: "汉元帝，昭君出塞在其朝。", links: wiki("汉元帝") },
  { id: "liu-ao", name: "刘骜", birth: ym(-51), death: ym(-7), roles: ["皇帝"], bio: "汉成帝，外戚王氏势力渐盛。", links: wiki("汉成帝") },
  { id: "liu-xin", name: "刘欣", birth: ym(-27), death: ym(-1), roles: ["皇帝"], bio: "汉哀帝，在位短暂，西汉由盛转衰。", links: wiki("汉哀帝") },
  { id: "liu-kan", name: "刘衎", birth: ym(-9), death: ym(6), roles: ["皇帝"], bio: "汉平帝，王莽摄政，西汉实亡于其朝。", links: wiki("汉平帝") },
  { id: "ruzi-ying", name: "刘婴", roles: ["君主"], bio: "孺子婴，平帝死后王莽立为太子而未正式登基，新莽代汉。", links: wiki("孺子婴") },
  { id: "zhang-qian", name: "张骞", birth: ym(-164), death: ym(-114), roles: ["外交家"], bio: "汉武帝时两次出使西域，开辟丝绸之路。", links: wiki("张骞") },
  { id: "zhang-han", name: "章邯", roles: ["将领"], bio: "秦末名将，巨鹿败后降楚，后降汉封雍王。", links: wiki("章邯") },
  { id: "xiang-liang", name: "项梁", roles: ["起义领袖", "将领"], bio: "项羽叔父，会稽起兵反秦，立楚怀王，战死于定陶。", links: wiki("项梁") },
  { id: "wei-bao", name: "魏豹", roles: ["诸侯"], bio: "魏王豹，秦末复立魏国，楚汉间反复，终为韩信所灭。", links: wiki("魏王豹") },
  { id: "wei-qing", name: "卫青", roles: ["军事家"], bio: "汉武帝时大将，屡破匈奴，封大将军。", links: wiki("卫青") },
  { id: "huo-qubing", name: "霍去病", birth: ym(-140), death: ym(-117), roles: ["军事家"], bio: "汉武帝时名将，河西、漠北连破匈奴，封冠军侯。", links: wiki("霍去病") },
  { id: "wang-mang", name: "王莽", birth: ym(-45), death: ym(23), roles: ["皇帝"], bio: "新莽开国皇帝，外戚出身，篡汉自立，改革失败，绿林起义而亡。", links: wiki("王莽") },
  { id: "liu-xuan", name: "刘玄", roles: ["皇帝"], bio: "更始帝，绿林军拥立，新莽亡后短暂称帝，后为赤眉所杀。", links: wiki("更始帝") },
  { id: "liu-xiu", name: "刘秀", birth: ym(-5), death: ym(57), roles: ["皇帝"], bio: "光武帝，东汉开国皇帝，昆阳之战后统一天下。", links: wiki("刘秀") },
  { id: "liu-zhuang", name: "刘庄", birth: ym(28), death: ym(75), roles: ["皇帝"], bio: "汉明帝，光武帝子，继续巩固东汉统治。", links: wiki("汉明帝") },
  { id: "liu-zuo", name: "刘炟", birth: ym(57), death: ym(88), roles: ["皇帝"], bio: "汉章帝，明帝子，东汉前期国力稳固。", links: wiki("汉章帝") },
  { id: "liu-zhao", name: "刘肇", birth: ym(79), death: ym(106), roles: ["皇帝"], bio: "汉和帝，章帝子，东汉国力达于鼎盛。", links: wiki("汉和帝") },
  { id: "liu-long", name: "刘隆", roles: ["皇帝"], bio: "汉殇帝，和帝子，即位百日而崩，中国历史上最短命皇帝之一。", links: wiki("汉殇帝") },
  { id: "liu-hu", name: "刘祜", roles: ["皇帝"], bio: "汉安帝，东汉中期皇帝，外戚宦官势力渐盛。", links: wiki("汉安帝") },
  { id: "liu-yi-shao", name: "刘懿", roles: ["皇帝"], bio: "汉前少帝，安帝子，在位数月即卒。", links: wiki("汉少帝") },
  { id: "liu-bao", name: "刘保", roles: ["皇帝"], bio: "汉顺帝，东汉中后期皇帝。", links: wiki("汉顺帝") },
  { id: "liu-bing", name: "刘炳", roles: ["皇帝"], bio: "汉冲帝，顺帝子，在位不足两年。", links: wiki("汉冲帝") },
  { id: "liu-zuan", name: "刘缵", roles: ["皇帝"], bio: "汉质帝，在位一年余，为梁太后所害。", links: wiki("汉质帝") },
  { id: "liu-zhi", name: "刘志", birth: ym(132), death: ym(168), roles: ["皇帝"], bio: "汉桓帝，诛灭梁氏外戚，后期宦官专权。", links: wiki("汉桓帝") },
  { id: "liu-hong", name: "刘宏", birth: ym(157), death: ym(189), roles: ["皇帝"], bio: "汉灵帝，东汉末年皇帝，黄巾起义在其朝爆发。", links: wiki("汉灵帝") },
  { id: "liu-bian", name: "刘辩", roles: ["皇帝"], bio: "汉后少帝，灵帝长子，为董卓所废。", links: wiki("汉少帝刘辩") },
  { id: "liu-xie", name: "刘协", birth: ym(181), death: ym(234), roles: ["皇帝"], bio: "汉献帝，东汉末代皇帝，曹丕受禅后东汉终结。", links: wiki("汉献帝") },
  // 非帝王人物
  { id: "zhao-gao", name: "赵高", roles: ["政治家"], bio: "秦宦官，矫诏立胡亥，指鹿为马，后被子婴诛杀。", links: wiki("赵高") },
  { id: "huo-guang", name: "霍光", birth: ym(-68), death: ym(68), roles: ["政治家"], bio: "汉昭帝辅政大臣，废立昌邑王、拥立宣帝，权倾朝野。", links: wiki("霍光") },
  { id: "wang-zhaojun", name: "王昭君", birth: ym(-52), death: ym(-15), roles: ["后妃"], bio: "汉元帝宫人，自愿和亲匈奴，昭君出塞。", links: wiki("王昭君") },
  { id: "dou-taihou", name: "窦太后", roles: ["太后", "政治家"], bio: "汉文帝皇后，景帝生母，崇尚黄老，文景之治重要推手。", links: wiki("窦太后") },
  { id: "liang-taihou", name: "梁太后", roles: ["太后", "政治家"], bio: "汉顺帝皇后，质帝、桓帝朝临朝，毒杀质帝。", links: wiki("梁妢") },
  { id: "dong-zhongshu", name: "董仲舒", birth: ym(-179), death: ym(-104), roles: ["思想家"], bio: "汉武帝时大儒，独尊儒术理论奠基者。", links: wiki("董仲舒") },
  { id: "si-ma-qian", name: "司马迁", birth: ym(-145), death: ym(-86), roles: ["史学家"], bio: "汉武帝时太史令，著史记，中国第一部纪传体通史。", links: wiki("司马迁") },
  { id: "ban-chao", name: "班超", birth: ym(32), death: ym(102), roles: ["外交家", "军事家"], bio: "东汉名将，投笔从戎，通西域三十六年。", links: wiki("班超") },
  { id: "cai-lun", name: "蔡伦", roles: ["发明家"], bio: "东汉宦官，改进造纸术，纸张普及为之勃兴。", links: wiki("蔡伦") },
];

// qin dynasty row is owned by chunqiu-zhanguo (feudal span -770..-207); this pack only adds imperial reigns.
const dynasties = [
  {
    id: "chu-west",
    name: "西楚",
    altNames: ["楚"],
    scope: "cn",
    region: "east_asia",
    start: ym(-206),
    end: ym(-202, 12),
    precision: "year",
    colorToken: "indigo",
    note: "项羽分封后自立西楚霸王，都彭城；垓下败亡，政权终结。",
  },
  {
    id: "han-west",
    name: "西汉",
    altNames: ["前汉", "汉"],
    scope: "cn",
    region: "east_asia",
    start: ym(-202),
    end: ym(8, 11),
    precision: "year",
    colorToken: "mineral",
    note: "刘邦称帝定都长安；孺子婴被废、王莽代汉，前8年十一月西汉终结。",
  },
  {
    id: "xin",
    name: "新",
    altNames: ["新莽"],
    scope: "cn",
    region: "east_asia",
    start: ym(9),
    end: ym(23, 10),
    precision: "year",
    colorToken: "moss",
    note: "王莽篡汉自立，国号新；地皇四年绿林攻入长安，王莽被杀。",
  },
  {
    id: "han-gengshi",
    name: "更始",
    altNames: ["玄汉"],
    scope: "cn",
    region: "east_asia",
    start: ym(23),
    end: ym(25, 10),
    precision: "year",
    colorToken: "wisteria",
    note: "绿林军拥立更始帝刘玄，复汉号；赤眉入长安后刘玄降被杀。",
  },
  {
    id: "han-east",
    name: "东汉",
    altNames: ["后汉"],
    scope: "cn",
    region: "east_asia",
    start: ym(25),
    end: ym(220, 12),
    precision: "year",
    colorToken: "cinnabar",
    note: "光武帝刘秀建立，定都洛阳；献帝禅让曹丕，东汉终结。",
  },
];

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
  return reign({
    id: `reign-${personId}`,
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

function hanReign(personId, title, posthumous, temple, startYear, endYear, eraNames = []) {
  return dynastyReign("han-west", personId, title, posthumous, temple, startYear, endYear, eraNames);
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

const qinReigns = [
  reign({
    id: "reign-ying-zheng",
    dynastyId: "qin",
    personId: "ying-zheng",
    title: "秦始皇帝",
    preferred: { kind: "regnal", name: "秦始皇" },
    start: ym(-221),
    end: ym(-210, 12),
  }),
  reign({
    id: "reign-ying-huhai",
    dynastyId: "qin",
    personId: "ying-huhai",
    title: "秦二世皇帝",
    preferred: { kind: "regnal", name: "秦二世" },
    start: ym(-210),
    end: ym(-207, 12),
  }),
  reign({
    id: "reign-ying-ziying",
    dynastyId: "qin",
    personId: "ying-ziying",
    title: "秦王子婴",
    preferred: { kind: "regnal", name: "秦王子婴" },
    start: ym(-207),
    end: ym(-207, 12),
  }),
];

const chuReigns = [
  reign({
    id: "reign-xiang-yu",
    dynastyId: "chu-west",
    personId: "xiang-yu",
    title: "西楚霸王",
    preferred: { kind: "regnal", name: "西楚霸王" },
    start: ym(-206),
    end: ym(-202, 12),
  }),
];

const hanReigns = [
  hanReign("liu-bang", "汉高祖", "高皇帝", "太祖", -202, -195),
  hanReign("liu-ying", "汉惠帝", "孝惠皇帝", null, -195, -188),
  hanReign("liu-gong", "汉前少帝", null, null, -188, -184),
  hanReign("liu-hong-shao", "汉后少帝", null, null, -184, -180),
  hanReign("liu-heng", "汉文帝", "孝文皇帝", "太宗", -180, -157),
  hanReign("liu-qi", "汉景帝", "孝景皇帝", null, -157, -141),
  hanReign(
    "liu-che",
    "汉武帝",
    "孝武皇帝",
    "世宗",
    -141,
    -87,
    eras("reign-liu-che", [
      { name: "建元", sy: -140, ey: -135 },
      { name: "元光", sy: -134, ey: -129 },
      { name: "元朔", sy: -128, ey: -123 },
      { name: "元狩", sy: -122, ey: -117 },
      { name: "元鼎", sy: -116, ey: -111 },
      { name: "元封", sy: -110, ey: -105 },
      { name: "太初", sy: -104, ey: -101 },
      { name: "天汉", sy: -100, ey: -97 },
      { name: "太始", sy: -96, ey: -93 },
      { name: "征和", sy: -92, ey: -89 },
      { name: "后元", sy: -88, ey: -87 },
    ]),
  ),
  hanReign(
    "liu-fuling",
    "汉昭帝",
    "孝昭皇帝",
    null,
    -87,
    -74,
    eras("reign-liu-fuling", [
      { name: "始元", sy: -86, ey: -81 },
      { name: "元凤", sy: -80, ey: -75 },
      { name: "元平", sy: -74, ey: -74 },
    ]),
  ),
  hanReign("liu-he", "汉废帝", null, null, -74, -74),
  hanReign(
    "liu-xun",
    "汉宣帝",
    "孝宣皇帝",
    null,
    -74,
    -48,
    eras("reign-liu-xun", [
      { name: "本初", sy: -74, ey: -70 },
      { name: "地节", sy: -69, ey: -66 },
      { name: "元康", sy: -65, ey: -62 },
      { name: "神爵", sy: -61, ey: -58 },
      { name: "五凤", sy: -57, ey: -54 },
      { name: "甘露", sy: -53, ey: -50 },
      { name: "黄龙", sy: -49, ey: -48 },
    ]),
  ),
  hanReign(
    "liu-shi",
    "汉元帝",
    "孝元皇帝",
    null,
    -48,
    -33,
    eras("reign-liu-shi", [
      { name: "初元", sy: -48, ey: -44 },
      { name: "永光", sy: -43, ey: -39 },
      { name: "建昭", sy: -38, ey: -34 },
      { name: "竟宁", sy: -33, ey: -33 },
    ]),
  ),
  hanReign(
    "liu-ao",
    "汉成帝",
    "孝成皇帝",
    null,
    -33,
    -7,
    eras("reign-liu-ao", [
      { name: "建始", sy: -32, ey: -28 },
      { name: "河平", sy: -28, ey: -25 },
      { name: "阳朔", sy: -24, ey: -21 },
      { name: "鸿嘉", sy: -20, ey: -17 },
      { name: "永始", sy: -16, ey: -13 },
      { name: "元延", sy: -12, ey: -9 },
      { name: "绥和", sy: -8, ey: -7 },
    ]),
  ),
  hanReign(
    "liu-xin",
    "汉哀帝",
    "孝哀皇帝",
    null,
    -7,
    -1,
    eras("reign-liu-xin", [
      { name: "建平", sy: -6, ey: -3 },
      { name: "元寿", sy: -2, ey: -1 },
    ]),
  ),
  hanReign(
    "liu-kan",
    "汉平帝",
    "孝平皇帝",
    null,
    -1,
    6,
    eras("reign-liu-kan", [{ name: "元始", sy: 1, ey: 5 }]),
  ),
  hanReign(
    "ruzi-ying",
    "孺子婴",
    null,
    null,
    6,
    8,
    eras("reign-ruzi-ying", [{ name: "居摄", sy: 6, ey: 8 }]),
  ),
];

const xinReigns = [
  dynastyReign(
    "xin",
    "wang-mang",
    "新莽皇帝",
    null,
    null,
    9,
    23,
    eras("reign-wang-mang", [
      { name: "始建国", sy: 9, ey: 13 },
      { name: "天凤", sy: 14, ey: 19 },
      { name: "地皇", sy: 20, ey: 23 },
    ]),
    { kind: "regnal", name: "王莽" },
  ),
];

const gengshiReigns = [
  dynastyReign(
    "han-gengshi",
    "liu-xuan",
    "更始帝",
    null,
    null,
    23,
    25,
    eras("reign-liu-xuan", [{ name: "更始", sy: 23, ey: 25 }]),
    { kind: "regnal", name: "更始帝" },
  ),
];

const hanEastReigns = [
  dynastyReign(
    "han-east",
    "liu-xiu",
    "汉光武帝",
    "光武皇帝",
    "世祖",
    25,
    57,
    eras("reign-liu-xiu", [
      { name: "建武", sy: 25, ey: 56 },
      { name: "建武中元", sy: 56, ey: 57 },
    ]),
  ),
  dynastyReign("han-east", "liu-zhuang", "汉明帝", "孝明皇帝", "显宗", 57, 75, eras("reign-liu-zhuang", [{ name: "永平", sy: 58, ey: 75 }])),
  dynastyReign(
    "han-east",
    "liu-zuo",
    "汉章帝",
    "孝章皇帝",
    "肃宗",
    75,
    88,
    eras("reign-liu-zuo", [
      { name: "建初", sy: 76, ey: 84 },
      { name: "元和", sy: 84, ey: 87 },
      { name: "章和", sy: 87, ey: 88 },
    ]),
  ),
  dynastyReign(
    "han-east",
    "liu-zhao",
    "汉和帝",
    "孝和皇帝",
    null,
    88,
    106,
    eras("reign-liu-zhao", [
      { name: "永元", sy: 89, ey: 105 },
      { name: "元兴", sy: 105, ey: 105 },
    ]),
  ),
  dynastyReign("han-east", "liu-long", "汉殇帝", "孝殇皇帝", null, 106, 106),
  dynastyReign("han-east", "liu-hu", "汉安帝", "孝安皇帝", null, 106, 125),
  dynastyReign("han-east", "liu-yi-shao", "汉前少帝", null, null, 125, 125),
  dynastyReign("han-east", "liu-bao", "汉顺帝", "孝顺皇帝", null, 125, 144),
  dynastyReign("han-east", "liu-bing", "汉冲帝", "孝冲皇帝", null, 144, 145),
  dynastyReign("han-east", "liu-zuan", "汉质帝", "孝质皇帝", null, 145, 146),
  dynastyReign("han-east", "liu-zhi", "汉桓帝", "孝桓皇帝", null, 146, 168),
  dynastyReign("han-east", "liu-hong", "汉灵帝", "孝灵皇帝", null, 168, 189),
  dynastyReign("han-east", "liu-bian", "汉后少帝", null, null, 189, 189),
  dynastyReign("han-east", "liu-xie", "汉献帝", "孝献皇帝", null, 189, 220),
];

const reigns = applyDocumentedDatesToReigns([
  ...qinReigns,
  ...chuReigns,
  ...hanReigns,
  ...xinReigns,
  ...gengshiReigns,
  ...hanEastReigns,
]);

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
    id: "qin-unify",
    name: "秦灭六国",
    kind: "politics",
    precision: "year",
    dateNote: "秦王政先后灭韩赵魏楚燕齐，前221年称帝",
    at: ym(-221),
    dynastyIds: ["qin"],
    participantIds: ["ying-zheng"],
    summary: "秦完成统一战争，建立中国历史上首个大一统帝国。",
  }),
  eventRange({
    id: "qin-standardize",
    name: "书同文车同轨",
    kind: "culture",
    timeMode: "span",
    precision: "year",
    dateNote: "统一后推行文字、度量衡、车轨及郡县制，具体月份不详",
    start: ym(-221),
    end: ym(-210, 12),
    dynastyIds: ["qin"],
    participantIds: ["ying-zheng", "li-si"],
    summary: "秦始皇统一文字、度量衡与道路车轨，推行郡县制。",
  }),
  eventRange({
    id: "burn-books",
    name: "焚书坑儒",
    kind: "culture",
    timeMode: "circa",
    precision: "year",
    dateNote: "焚书约前213年，坑儒约前212年，取两年窗口",
    start: ym(-213),
    end: ym(-212, 12),
    at: ym(-213),
    dynastyIds: ["qin"],
    participantIds: ["ying-zheng", "li-si"],
    summary: "秦始皇下令焚毁非实用典籍，后又坑杀批评朝政的儒生。",
  }),
  eventRange({
    id: "great-wall-qin",
    name: "修筑长城",
    kind: "other",
    timeMode: "circa",
    precision: "decade",
    dateNote: "秦统一后连接燕赵秦旧塞，具体起工年月诸说不一",
    start: ym(-221),
    end: ym(-210, 12),
    at: ym(-215),
    dynastyIds: ["qin"],
    participantIds: ["ying-zheng"],
    summary: "秦将战国北方边塞连接延展，形成后世长城雏形。",
  }),
  eventPoint({
    id: "yingzheng-death",
    name: "秦始皇驾崩",
    kind: "politics",
    precision: "year",
    dateNote: "始皇三十七年，前210年，死于沙丘",
    at: ym(-210),
    dynastyIds: ["qin"],
    participantIds: ["ying-zheng"],
    summary: "秦始皇东巡途中病逝，赵高与李斯篡改遗诏立胡亥。",
  }),
  eventPoint({
    id: "daze-uprising",
    name: "大泽乡起义",
    kind: "politics",
    precision: "year",
    dateNote: "秦二世元年七月，前209年",
    at: ym(-209),
    dynastyIds: ["qin"],
    participantIds: ["chen-sheng", "wu-guang"],
    summary: "陈胜、吴广揭竿而起，秦末农民战争爆发。",
  }),
  eventPoint({
    id: "julu-battle",
    name: "巨鹿之战",
    kind: "battle",
    precision: "year",
    dateNote: "秦二世三年，前207年，项羽破秦军主力",
    at: ym(-207),
    dynastyIds: ["qin", "chu-west"],
    participantIds: ["xiang-yu", "zhang-han", "xiang-liang"],
    summary: "项羽破釜沉舟，大破章邯所率秦军，秦亡势成。",
  }),
  eventPoint({
    id: "xiangliang-death",
    name: "项梁战死定陶",
    kind: "battle",
    precision: "year",
    dateNote: "秦二世三年九月，前208年",
    at: ym(-208),
    dynastyIds: ["chu-west"],
    participantIds: ["xiang-liang", "xiang-yu"],
    summary: "项梁战死于定陶，项羽继其军权。",
  }),
  eventPoint({
    id: "liu-enter-xianyang",
    name: "刘邦入关",
    kind: "politics",
    precision: "year",
    dateNote: "秦王子婴投降，前207年",
    at: ym(-207),
    dynastyIds: ["qin"],
    participantIds: ["liu-bang", "ying-ziying"],
    summary: "刘邦率军入咸阳，子婴投降，秦朝名义上灭亡。",
  }),
  eventPoint({
    id: "hongmen-banquet",
    name: "鸿门宴",
    kind: "politics",
    precision: "year",
    dateNote: "汉王元年，前206年",
    at: ym(-206),
    dynastyIds: ["chu-west", "han-west"],
    participantIds: ["liu-bang", "xiang-yu", "zhang-liang"],
    summary: "刘邦赴项羽之会，张良等周旋，刘邦脱险。",
  }),
  eventRange({
    id: "chu-han-war",
    name: "楚汉战争",
    kind: "battle",
    timeMode: "span",
    precision: "year",
    dateNote: "项羽自立西楚霸王至垓下败亡，前206–前202年",
    start: ym(-206),
    end: ym(-202, 12),
    dynastyIds: ["chu-west", "han-west"],
    participantIds: ["liu-bang", "xiang-yu", "han-xin", "zhang-liang"],
    summary: "刘邦与项羽争夺天下，历时四年。",
  }),
  eventPoint({
    id: "gaixia",
    name: "垓下之战",
    kind: "battle",
    precision: "year",
    dateNote: "汉五年十二月，前202年",
    at: ym(-202),
    dynastyIds: ["chu-west", "han-west"],
    participantIds: ["liu-bang", "xiang-yu", "han-xin"],
    summary: "韩信等合围项羽于垓下，项羽兵败自刎，楚亡汉兴。",
  }),
  eventPoint({
    id: "han-founded",
    name: "西汉建立",
    kind: "politics",
    precision: "year",
    dateNote: "汉五年二月甲午，前202年，刘邦称帝于定陶",
    at: ym(-202),
    dynastyIds: ["han-west"],
    participantIds: ["liu-bang"],
    summary: "刘邦称帝，定国号汉，初都洛阳后迁长安。",
  }),
  eventPoint({
    id: "baiteng-siege",
    name: "白登之围",
    kind: "battle",
    precision: "year",
    dateNote: "汉七年，前200年，高祖被匈奴围困于白登山",
    at: ym(-200),
    dynastyIds: ["han-west"],
    participantIds: ["liu-bang"],
    summary: "刘邦北击匈奴失利被围，脱险后改行和亲政策。",
  }),
  eventRange({
    id: "qiguo-rebellion",
    name: "七国之乱",
    kind: "battle",
    timeMode: "span",
    precision: "year",
    dateNote: "景帝三年，前154年",
    start: ym(-154),
    end: ym(-154, 12),
    dynastyIds: ["han-west"],
    participantIds: ["liu-qi"],
    summary: "吴楚等七国起兵反中央，景帝命周亚夫平定。",
  }),
  eventRange({
    id: "lv-regency",
    name: "吕后称制",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    dateNote: "惠帝崩后吕后临朝，前188–前180年",
    start: ym(-188),
    end: ym(-180, 12),
    dynastyIds: ["han-west"],
    participantIds: ["lv-zhi"],
    summary: "吕后专擅朝政，大封吕氏，至文帝即位结束。",
  }),
  eventRange({
    id: "wenjing-rule",
    name: "文景之治",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    start: ym(-180),
    end: ym(-141, 12),
    dynastyIds: ["han-west"],
    participantIds: ["liu-heng", "liu-qi"],
    summary: "文帝景帝轻徭薄赋、与民休息，国力恢复。",
  }),
  eventRange({
    id: "wu-han-expansion",
    name: "汉武帝开疆",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    start: ym(-141),
    end: ym(-87, 12),
    dynastyIds: ["han-west"],
    participantIds: ["liu-che"],
    summary: "武帝北击匈奴、通西域、南平百越、东并闽越，西汉疆域大幅扩展。",
  }),
  eventRange({
    id: "zhangqian-mission",
    name: "张骞通西域",
    kind: "culture",
    timeMode: "circa",
    precision: "year",
    dateNote: "武帝建元三年首次出使，前138年；二使前119年，取主要窗口",
    start: ym(-138),
    end: ym(-114, 12),
    at: ym(-138),
    dynastyIds: ["han-west"],
    participantIds: ["liu-che", "zhang-qian"],
    summary: "张骞两次出使西域，开辟丝绸之路，沟通中西。",
  }),
  eventPoint({
    id: "hexi-battle",
    name: "河西之战",
    kind: "battle",
    precision: "year",
    dateNote: "元狩二年，前121年，霍去病两次西进",
    at: ym(-121),
    dynastyIds: ["han-west"],
    participantIds: ["liu-che", "huo-qubing"],
    summary: "霍去病大破匈奴，夺取河西走廊，置武威、酒泉等郡。",
  }),
  eventPoint({
    id: "mobei-battle",
    name: "漠北之战",
    kind: "battle",
    precision: "year",
    dateNote: "元狩四年，前119年，卫青、霍去病分道出击",
    at: ym(-119),
    dynastyIds: ["han-west"],
    participantIds: ["liu-che", "wei-qing", "huo-qubing"],
    summary: "汉军深入漠北，大破匈奴主力，匈奴远遁，无力南犯。",
  }),
  eventRange({
    id: "dayuan-expedition",
    name: "远征大宛",
    kind: "battle",
    timeMode: "circa",
    precision: "year",
    dateNote: "太初二年，前103–前101年，李广利两征大宛",
    start: ym(-103),
    end: ym(-101, 12),
    at: ym(-102),
    dynastyIds: ["han-west"],
    participantIds: ["liu-che"],
    summary: "汉武帝遣军远征大宛，历时三年，终斩其王。",
  }),
  eventPoint({
    id: "wugu-case",
    name: "巫蛊之祸",
    kind: "politics",
    precision: "year",
    dateNote: "征和二年，前91年",
    at: ym(-91),
    dynastyIds: ["han-west"],
    participantIds: ["liu-che"],
    summary: "武帝晚年巫蛊案牵连太子刘据，朝局动荡。",
  }),
  eventRange({
    id: "zhaoxuan-rule",
    name: "昭宣之治",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    start: ym(-87),
    end: ym(-48, 12),
    dynastyIds: ["han-west"],
    participantIds: ["liu-fuling", "liu-xun"],
    summary: "昭帝、宣帝励精图治，西汉中兴。",
  }),
  eventPoint({
    id: "zhaojun-chusai",
    name: "昭君出塞",
    kind: "culture",
    precision: "year",
    dateNote: "竟宁元年，前33年",
    at: ym(-33),
    dynastyIds: ["han-west"],
    participantIds: ["liu-shi", "wang-zhaojun"],
    summary: "元帝以王昭君嫁呼韩邪单于，汉匈和好。",
  }),
  eventPoint({
    id: "wang-mang-usurp",
    name: "王莽篡汉",
    kind: "politics",
    precision: "year",
    dateNote: "始建国元年，9年，孺子婴被废",
    at: ym(9),
    dynastyIds: ["han-west", "xin"],
    participantIds: ["wang-mang", "ruzi-ying"],
    summary: "王莽受孺子婴禅让，改国号为新，西汉终结。",
  }),
  eventPoint({
    id: "kunyang-battle",
    name: "昆阳之战",
    kind: "battle",
    precision: "year",
    dateNote: "更始元年，23年，刘秀以少胜多破王莽军",
    at: ym(23),
    dynastyIds: ["xin", "han-gengshi"],
    participantIds: ["liu-xiu", "wang-mang"],
    summary: "刘秀率绿林军于昆阳大破王莽主力，新莽覆亡在即。",
  }),
  eventPoint({
    id: "han-east-founded",
    name: "东汉建立",
    kind: "politics",
    precision: "year",
    dateNote: "建武元年，25年，刘秀称帝于鄗城",
    at: ym(25),
    dynastyIds: ["han-east"],
    participantIds: ["liu-xiu"],
    summary: "刘秀击败各路割据，定都洛阳，东汉开始。",
  }),
  eventPoint({
    id: "yellow-turban",
    name: "黄巾起义",
    kind: "politics",
    precision: "year",
    dateNote: "灵帝建宁二年，184年",
    at: ym(184),
    dynastyIds: ["han-east"],
    participantIds: ["liu-hong"],
    summary: "张角领导黄巾起义，东汉统治根基动摇，群雄割据。",
  }),
  eventPoint({
    id: "han-east-end",
    name: "东汉终结",
    kind: "politics",
    precision: "year",
    dateNote: "献帝延康元年十一月，220年，曹丕受禅",
    at: ym(220),
    dynastyIds: ["han-east"],
    participantIds: ["liu-xie"],
    summary: "曹丕篡汉，献帝禅让，东汉灭亡，曹魏建立。",
  }),
];

function successionPairs(list) {
  const pairs = [];
  for (let i = 0; i < list.length - 1; i++) {
    pairs.push([list[i].personId, list[i + 1].personId]);
  }
  return pairs;
}

const relations = [];
for (const [fromId, toId] of [
  ...successionPairs(qinReigns),
  ...successionPairs(chuReigns),
  ...successionPairs(hanReigns),
  ...successionPairs(xinReigns),
  ...successionPairs(gengshiReigns),
  ...successionPairs(hanEastReigns),
]) {
  relations.push({
    id: `rel-${fromId}-${toId}-succession`,
    fromRef: `person:${fromId}`,
    toRef: `person:${toId}`,
    kind: "succession",
  });
}
relations.push(
  { id: "rel-gaixia-liu-bang", fromRef: "event:gaixia", toRef: "person:liu-bang", kind: "battle" },
  { id: "rel-gaixia-xiang-yu", fromRef: "event:gaixia", toRef: "person:xiang-yu", kind: "battle" },
  { id: "rel-chu-han-liu-bang", fromRef: "event:chu-han-war", toRef: "person:liu-bang", kind: "battle" },
  { id: "rel-julu-xiang-yu", fromRef: "event:julu-battle", toRef: "person:xiang-yu", kind: "battle" },
  { id: "rel-mobei-huo-qubing", fromRef: "event:mobei-battle", toRef: "person:huo-qubing", kind: "battle" },
  { id: "rel-kunyang-liu-xiu", fromRef: "event:kunyang-battle", toRef: "person:liu-xiu", kind: "battle" },
);

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

const { persons: importPersons, reigns: importReigns } = finalizeImportReigns("qin-han", persons, reigns);

const reignsWithEras = importReigns.filter((r) => r.eraNames.length > 0);
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
  "-- EraLens period import: qin-han",
  "-- Window: -221-01 .. 220-12",
  "-- Chronology: Shiji + Wikipedia Han dynasty emperor list",
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
  slug: "qin-han",
  title: "秦汉（含新莽、更始、东汉）",
  window: { startYear: -221, startMonth: 1, endYear: 220, endMonth: 12 },
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
    { label: "秦朝", url: "https://zh.wikipedia.org/wiki/秦朝" },
    { label: "西汉", url: "https://zh.wikipedia.org/wiki/西汉" },
    { label: "东汉", url: "https://zh.wikipedia.org/wiki/东汉" },
    { label: "新朝", url: "https://zh.wikipedia.org/wiki/新朝" },
    { label: "更始政权", url: "https://zh.wikipedia.org/wiki/更始政权" },
    { label: "汉朝君主列表", url: "https://zh.wikipedia.org/wiki/汉朝君主列表" },
    { label: "西楚", url: "https://zh.wikipedia.org/wiki/西楚" },
    { label: "楚汉战争", url: "https://zh.wikipedia.org/wiki/楚汉战争" },
    { label: "漠北之战", url: "https://zh.wikipedia.org/wiki/漠北之战" },
    { label: "巨鹿之战", url: "https://zh.wikipedia.org/wiki/巨鹿之战" },
  ],
  notes: [
    "覆盖秦统一（前221）至东汉终结（220年），含西楚、新莽、更始等过渡政权。",
    "王朝与皇帝在位年取《史记》《后汉书》系统常见年表（与维基百科汉朝君主列表一致），precision=year。",
    "秦末诸侯（章邯、项梁、魏豹等）以人物与事件收录，不另建诸侯国王朝行。",
    "武帝时期补录河西之战、漠北之战、远征大宛等重大战役。",
    "吕后临朝不建皇帝 reign，以 span 事件「吕后称制」表示。",
    "东汉前/后少帝在位极短，仍列入在位卡片；年号自武帝（西汉）及光武（东汉）起写入 era_names。",
    "未收录三国曹魏及赤眉军刘盆子政权，以免超出两汉主线。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);

console.log(
  `Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`,
);
console.log("Sample abs:", {
  qinStart: absMonth(-221, 1),
  hanWestStart: absMonth(-202, 1),
  hanEastEnd: absMonth(220, 12),
});
