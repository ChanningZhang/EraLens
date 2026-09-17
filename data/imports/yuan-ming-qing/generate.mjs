#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Yuan, Ming, Qing (1271–1912).
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { resolveOrthodoxEndAbs, resolveOrthodoxFromAbs } from "../lib/orthodoxDynasties.mjs";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import { finalizeImportReigns, sqlDeleteSystemMissingReigns } from "../lib/missingReigns.mjs";
import { drDay } from "../lib/reignDateHelpers.mjs";
import { reignSql } from "../lib/reignSql.mjs";

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

function reign({ id, dynastyId, personId, title, posthumousName, templeName, preferred, start, end, precision = "year", eraNames = [], claimTrack, claimLabel, claimRole }) {
  return { id, dynastyId, personId, title, posthumousName, templeName, preferredAppellation: preferred, eraNames, start, end, startAbs: start.abs, endAbs: end.abs, precision, claimTrack, claimLabel, claimRole };
}

function dynastyReign(dynastyId, personId, title, posthumous, temple, startYear, endYear, eraNames = [], preferred = null, claim = null) {
  const reignId = `reign-${personId}-${dynastyId}`;
  return reign({
    id: reignId,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    preferred,
    start: ym(startYear),
    end: ym(endYear, 12),
    eraNames,
    claimTrack: claim?.track,
    claimLabel: claim?.label,
    claimRole: claim?.track ? "rival" : undefined,
  });
}

function eras(reignId, list) {
  return list.map((e, i) => ({ reignId, name: e.name, start: ym(e.sy, e.sm ?? 1), end: ym(e.ey, e.em ?? 12), sortOrder: i }));
}

function dr(dynastyId, personId, title, posthumous, temple, sy, ey, eraList = [], claim = null) {
  const reignId = `reign-${personId}-${dynastyId}`;
  const eraNames = eraList.length ? eras(reignId, eraList) : [];
  return dynastyReign(dynastyId, personId, title, posthumous, temple, sy, ey, eraNames, null, claim);
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
  // 元末割据——称帝/称王者
  person("xu-shouhui", "徐寿辉", ["皇帝"], "元末红巾军领袖，1351年称帝，国号宋，传世文献多作天完；1360年为陈友谅所杀。", "徐寿辉", ym(1320), ym(1360)),
  person("chen-youliang", "陈友谅", ["皇帝"], "元末陈汉建立者，1359年自立汉王，1360年弑徐寿辉称帝，国号汉；1363年鄱阳湖之战阵亡。", "陈友谅", ym(1320), ym(1363)),
  person("chen-li", "陈理", ["皇帝"], "陈友谅次子，1363年鄱阳湖战后继位，改元德寿；1364年降明，陈汉亡。", "陈理_(元末)", ym(1351), ym(1408)),
  person("han-liner", "韩林儿", ["皇帝"], "韩山童之子，号小明王，1355年被刘福通拥立称帝，国号宋；1366年溺亡于瓜洲渡。", "韩林儿", null, ym(1366)),
  person("zhang-shicheng", "张士诚", ["皇帝"], "盐贩出身，1354年高邮建国号大周，自称诚王；1363年再号吴王；1367年平江败亡。", "张士诚", ym(1321), ym(1367)),
  person("ming-yuzhen", "明玉珍", ["皇帝"], "元末明夏建立者，徐寿辉部将，1362年重庆称帝，国号夏，据有两川。", "明玉珍", ym(1329), ym(1366)),
  person("ming-sheng", "明升", ["皇帝"], "明玉珍之子，1366年嗣位；1371年明军灭夏，降明。", "明升", null, ym(1371)),
  person("liu-futong", "刘福通", ["起义领袖"], "红巾军首领，拥立韩林儿为小明王，三路北伐；1363年安丰之战战死。", "刘福通", null, ym(1363)),
  person("ayushiridara", "爱猷识理达腊", ["皇帝"], "北元昭宗，元顺帝长子，1370年嗣位，改元宣光。", "爱猷识理达腊"),
  person("togus-temur", "脱古思帖木儿", ["皇帝"], "北元末主天元帝，1388年捕鱼儿海之战后为也速迭儿所杀，北元终结。", "脱古思帖木儿"),
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
  person("zhu-yousong", "朱由崧", ["皇帝"], "弘光帝，南明首任，都南京，被俘处死。", "弘光帝"),
  person("zhu-yujian", "朱聿键", ["皇帝"], "隆武帝，南明，都福州，清军攻汀州时被俘。", "隆武帝"),
  person("zhu-yihai", "朱以海", ["皇帝"], "鲁监国，弘光亡后监国于绍兴，与隆武、永历并立；后入海，1653年去监国号。", "朱以海"),
  person("zhu-yuyue", "朱聿鐭", ["皇帝"], "绍武帝，隆武之弟，1646年广州称帝，与肇庆永历并立，旋为清军所破。", "绍武帝"),
  person("zhu-youlang", "朱由榔", ["皇帝"], "永历帝，南明末帝，肇庆称帝，与鲁监国、绍武并立，后为吴三桂所害。", "永历帝"),
  person("zheng-chenggong", "郑成功", ["军事家"], "抗清名将，收复台湾。", "郑成功", ym(1624), ym(1662)),
  person("yu-qian", "于谦", ["政治家", "军事家"], "土木堡之变后保卫北京，后被英宗冤杀。", "于谦", ym(1398), ym(1457)),
  // 元——非帝王人物
  person("guan-hanqing", "关汉卿", ["文学家"], "元杂剧代表作家，窦娥冤作者。", "关汉卿"),
  // 明——非帝王人物
  person("liu-ji", "刘基", ["政治家", "军事家"], "明初谋臣，辅佐朱元璋定天下，封诚意伯。", "刘基", ym(1311), ym(1375)),
  person("lan-yu", "蓝玉", ["军事家"], "明初大将，捕鱼儿海大破北元，后涉党案被诛。", "蓝玉", null, ym(1393)),
  person("zhang-juzheng", "张居正", ["政治家"], "明神宗首辅，推行考成法、一条鞭法等改革，史称万历中兴。", "张居正", ym(1525), ym(1582)),
  person("hai-rui", "海瑞", ["政治家"], "明代清官，上疏骂嘉靖，任上刚直不阿。", "海瑞", ym(1514), ym(1587)),
  person("qi-jiguang", "戚继光", ["军事家"], "明代抗倭名将，组建戚家军，平定东南倭患。", "戚继光", ym(1528), ym(1588)),
  person("wang-yangming", "王阳明", ["思想家", "军事家"], "明代心学集大成者，提出知行合一，平宁王之乱。", "王阳明", ym(1472), ym(1529)),
  person("yan-song", "严嵩", ["政治家"], "嘉靖朝权相，专擅朝政二十年，后遭徐阶等弹劾倒台。", "严嵩", ym(1480), ym(1567)),
  person("tang-yin", "唐寅", ["画家", "诗人"], "明代吴门画派代表，江南四大才子之一，桃花庵歌作者。", "唐寅", ym(1470), ym(1524)),
  person("li-shizhen", "李时珍", ["医学家"], "明代医药学家，本草纲目作者。", "李时珍", ym(1518), ym(1593)),
  person("xu-guangqi", "徐光启", ["科学家", "政治家"], "明代科学家，与利玛窦合译几何原本，主持历法改革。", "徐光启", ym(1562), ym(1633)),
  person("xu-xiake", "徐霞客", ["地理学家"], "明代地理学家、旅行家，徐霞客游记作者。", "徐霞客", ym(1587), ym(1641)),
  person("yuan-chonghuan", "袁崇焕", ["军事家"], "明末督师，宁远大捷、宁锦大捷，后被崇祯冤杀。", "袁崇焕", ym(1584), ym(1630)),
  person("zheng-guifei", "郑贵妃", ["后妃"], "万历帝宠妃，梃击案牵连其党，国本之争核心人物。", "郑贵妃", ym(1565), ym(1630)),
  person("li-xuanshi", "李选侍", ["后妃"], "明光宗宠妃，光宗死后据乾清宫不肯迁出，引发移宫案。", "李选侍", null, ym(1627)),
  person("fang-congze", "方从哲", ["政治家"], "明末首辅，泰昌朝红丸案关键人物，后被东林党弹劾。", "方从哲", ym(1562), ym(1627)),
  person("wei-zhongxian", "魏忠贤", ["政治家"], "明末权阉，天启朝专权，东林党争对手，后自缢。", "魏忠贤", ym(1568), ym(1627)),
  person("zheng-he", "郑和", ["军事家"], "明代航海家，永乐朝率船队七下西洋，沟通中外。", "郑和", ym(1371), ym(1433)),
  // 清——非帝王人物
  person("dorgon", "多尔衮", ["政治家", "军事家"], "清摄政王，入关定鼎北京，主导清初统治。", "多尔衮", ym(1612), ym(1650)),
  person("huang-zongxi", "黄宗羲", ["思想家"], "明末清初思想家，明夷待访录作者，批判君主专制。", "黄宗羲", ym(1610), ym(1695)),
  person("gu-yanwu", "顾炎武", ["思想家"], "明末清初思想家，日知录作者，经世致用代表。", "顾炎武", ym(1613), ym(1682)),
  person("cao-xueqin", "曹雪芹", ["文学家"], "清代小说家，红楼梦作者。", "曹雪芹", ym(1715), ym(1763)),
  person("ji-xiaolan", "纪晓岚", ["文学家", "政治家"], "清代学者，四库全书总纂官，阅微草堂笔记作者。", "纪晓岚", ym(1724), ym(1805)),
  person("zeng-guofan", "曾国藩", ["政治家", "军事家"], "晚清重臣，湘军创建者，平定太平天国。", "曾国藩", ym(1811), ym(1872)),
  person("li-hongzhang", "李鸿章", ["政治家", "军事家"], "晚清重臣，洋务运动代表，签订多项条约。", "李鸿章", ym(1823), ym(1901)),
  person("zuo-zongtang", "左宗棠", ["政治家", "军事家"], "晚清重臣，收复新疆，洋务派代表。", "左宗棠", ym(1812), ym(1885)),
  person("deng-shichang", "邓世昌", ["军事家"], "北洋海军管带，甲午黄海海战殉国。", "邓世昌", ym(1849), ym(1894)),
  person("kang-youwei", "康有为", ["政治家", "思想家"], "维新派领袖，戊戌变法主持者。", "康有为", ym(1858), ym(1927)),
  person("liang-qichao", "梁启超", ["政治家", "思想家"], "维新派骨干，戊戌后推动立宪与启蒙。", "梁启超", ym(1873), ym(1929)),
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
  person("lin-zexu", "林则徐", ["政治家"], "禁烟英雄，虎门销烟主持者。", "林则徐", ym(1785), ym(1850)),
  person("sun-yat-sen", "孙中山", ["政治家"], "辛亥革命领袖，中华民国临时大总统。", "孙中山", ym(1866), ym(1925)),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const dynasties = [
  { id: "yuan", name: "元", altNames: ["大元", "蒙元", "北元", "残元", "故元"], scope: "cn", region: "east_asia", start: ym(1271, 12), end: ym(1388), precision: "year", colorToken: nextColor(), note: "忽必烈1271年定国号大元；1368年顺帝北逃漠北继续称大元至1388年天元帝被杀，元朝终结。" },
  // 元末割据政权（称帝/称王）
  { id: "song-xu", name: "徐宋", altNames: ["宋", "天完"], scope: "cn", region: "east_asia", start: ym(1351, 10), end: ym(1360, 6), precision: "year", colorToken: nextColor(), note: "徐寿辉1351年蕲州称帝，国号宋，传世多作天完；1360年陈友谅弑之。" },
  { id: "song-han", name: "韩宋", altNames: ["宋", "小明王"], scope: "cn", region: "east_asia", start: ym(1355, 2), end: ym(1366, 12), precision: "year", colorToken: nextColor(), note: "刘福通拥韩林儿为帝，号小明王，年号龙凤；1366年溺亡，韩宋亡。" },
  { id: "zhou-zhang", name: "大周", altNames: ["周"], scope: "cn", region: "east_asia", start: ym(1354, 1), end: ym(1367, 9), precision: "year", colorToken: nextColor(), note: "张士诚1354年高邮建国，自称诚王；1363年再号吴王；1367年平江败亡。" },
  { id: "chen-han", name: "陈汉", altNames: ["汉", "大汉"], scope: "cn", region: "east_asia", start: ym(1360, 6), end: ym(1364), precision: "year", colorToken: nextColor(), note: "陈友谅1360年称帝，国号汉；1363年鄱阳湖阵亡，子陈理继位；1364年降明。" },
  { id: "xia-ming", name: "明夏", altNames: ["夏", "大夏"], scope: "cn", region: "east_asia", start: ym(1362), end: ym(1371), precision: "year", colorToken: nextColor(), note: "明玉珍1362年重庆称帝，国号夏，据两川；1371年明灭夏。" },
  { id: "wu-zhu", name: "吴", altNames: ["西吴"], scope: "cn", region: "east_asia", start: ym(1364), end: ym(1368, 1), precision: "year", colorToken: nextColor(), note: "朱元璋1364年自立吴王，仍用龙凤年号；1367年改元吴，1368年称帝建明。" },
  { id: "ming", name: "明", altNames: ["大明"], scope: "cn", region: "east_asia", start: ym(1368), end: ym(1644, 4), precision: "year", colorToken: nextColor(), note: "朱元璋驱逐蒙元，定都南京后迁北京；1644年崇祯自缢，明亡。" },
  { id: "ming-south", name: "南明", altNames: ["明"], scope: "cn", region: "east_asia", start: ym(1644), end: ym(1662), precision: "year", colorToken: nextColor(), note: "明亡后朱氏多支并立：通行主线弘光→隆武→永历；鲁监国、绍武为并行朝廷。1662年永历帝殉，南明终结。" },
  { id: "qing", name: "清", altNames: ["大清", "后金"], scope: "cn", region: "east_asia", start: ym(1616, 2), end: ym(1912, 2), precision: "year", colorToken: nextColor(), note: "1616年努尔哈赤建后金，1636年改国号大清；1912年宣统退位。" },
];

// ── reigns ─────────────────────────────────────────────────────────────────

// 元帝在位日取维基百科君主列表通行换算（儒略历/格里历），precision=day。
const yuanReigns = [
  drDay("yuan", "hu-bilie", "元世祖", "圣德神功文武皇帝", "世祖", 1271, 12, 18, 1294, 2, 18, [{ name: "至元", sy: 1264, ey: 1294 }]),
  drDay("yuan", "temur", "元成宗", "钦明广孝皇帝", null, 1294, 5, 10, 1307, 2, 10),
  drDay("yuan", "khayishan", "元武宗", "仁圣钦安皇帝", null, 1307, 6, 21, 1311, 1, 27),
  drDay("yuan", "ayurbarwada", "元仁宗", "圣德慈仁皇帝", null, 1311, 4, 7, 1320, 3, 1),
  drDay("yuan", "shidebala", "元英宗", "睿圣文孝皇帝", null, 1320, 4, 19, 1323, 9, 4),
  drDay("yuan", "yeshuntuemur", "元泰定帝", null, null, 1323, 9, 4, 1328, 8, 15),
  drDay("yuan", "ragibagh", "元天顺帝", null, null, 1328, 8, 15, 1328, 10, 4),
  drDay("yuan", "tugh-temur", "元文宗", "圣明元孝皇帝", null, 1328, 10, 4, 1332, 9, 2),
  drDay("yuan", "khoshila", "元明宗", "翼献景孝皇帝", null, 1329, 2, 27, 1329, 8, 30),
  drDay("yuan", "irinchibal", "元宁宗", "冲圣嗣孝皇帝", null, 1332, 9, 2, 1332, 12, 14),
  drDay("yuan", "togon-temur", "元顺帝", "宣仁普孝皇帝", null, 1333, 7, 19, 1368, 1, 23),
  // 顺帝北迁后庙号惠宗，卡片仍用至正年号。
  drDay("yuan", "togon-temur", "元惠宗", "宣仁普孝皇帝", "惠宗", 1368, 1, 23, 1370, 5, 23, [{ name: "至正", sy: 1368, ey: 1370 }], null, "reign-togon-temur-yuan-north"),
  drDay("yuan", "ayushiridara", "元昭宗", null, "昭宗", 1370, 5, 27, 1378, 5, 10, [{ name: "宣光", sy: 1371, ey: 1378 }]),
  drDay("yuan", "togus-temur", "天元帝", null, null, 1378, 5, 13, 1388, 11, 1, [{ name: "天元", sy: 1379, ey: 1388 }]),
];

const yuanMoReigns = [
  dr("song-xu", "xu-shouhui", "徐宋帝", null, null, 1351, 1360, [
    { name: "治平", sy: 1351, ey: 1355 },
    { name: "太平", sy: 1356, ey: 1358 },
    { name: "天启", sy: 1358, ey: 1359 },
    { name: "天定", sy: 1359, ey: 1360 },
  ]),
  dr("song-han", "han-liner", "小明王", null, null, 1355, 1366, [{ name: "龙凤", sy: 1355, ey: 1366 }]),
  dr("zhou-zhang", "zhang-shicheng", "诚王", null, null, 1354, 1367, [{ name: "天佑", sy: 1354, ey: 1357 }]),
  dr("chen-han", "chen-youliang", "陈汉帝", null, null, 1360, 1363, [{ name: "大义", sy: 1360, ey: 1363 }]),
  dr("chen-han", "chen-li", "陈汉帝", null, null, 1363, 1364, [{ name: "德寿", sy: 1363, ey: 1364 }]),
  dr("xia-ming", "ming-yuzhen", "明夏帝", null, null, 1362, 1366, [{ name: "天统", sy: 1363, ey: 1366 }]),
  dr("xia-ming", "ming-sheng", "明夏帝", null, null, 1366, 1371, [{ name: "天统", sy: 1366, ey: 1371 }]),
  dr("wu-zhu", "zhu-yuanzhang", "吴王", null, null, 1364, 1368, [{ name: "吴", sy: 1367, ey: 1367 }]),
];

// 明帝在位日取维基百科君主列表通行换算，precision=day。
const mingReigns = [
  drDay("ming", "zhu-yuanzhang", "明太祖", "高皇帝", "太祖", 1368, 1, 23, 1398, 6, 24, [{ name: "洪武", sy: 1368, ey: 1398 }]),
  drDay("ming", "zhu-yunwen", "建文帝", null, null, 1398, 6, 30, 1402, 7, 13, [{ name: "建文", sy: 1399, ey: 1402 }]),
  drDay("ming", "zhu-di", "明成祖", "文皇帝", "成祖", 1402, 7, 17, 1424, 8, 12, [{ name: "永乐", sy: 1403, ey: 1424 }]),
  drDay("ming", "zhu-gaochi", "明仁宗", "昭皇帝", "仁宗", 1424, 8, 12, 1425, 5, 29, [{ name: "洪熙", sy: 1425, ey: 1425 }]),
  drDay("ming", "zhu-zhanji", "明宣宗", "章皇帝", "宣宗", 1425, 5, 29, 1435, 1, 31, [{ name: "宣德", sy: 1426, ey: 1435 }]),
  // 朱祁镇两次登基：前为正统，复辟后天顺，卡片分别用年号。
  drDay("ming", "zhu-qizhen", "明英宗", "睿皇帝", "英宗", 1435, 1, 31, 1449, 9, 22, [{ name: "正统", sy: 1436, ey: 1449 }], null, "reign-zhu-qizhen-ming"),
  drDay("ming", "zhu-qiyu", "明代宗", "景皇帝", "代宗", 1449, 9, 22, 1457, 2, 24, [{ name: "景泰", sy: 1450, ey: 1457 }]),
  drDay("ming", "zhu-qizhen", "明英宗", "睿皇帝", "英宗", 1457, 2, 11, 1464, 2, 23, [{ name: "天顺", sy: 1457, ey: 1464 }], null, "reign-zhu-qizhen-ming-2"),
  drDay("ming", "zhu-jianshen", "明宪宗", "纯皇帝", "宪宗", 1464, 2, 23, 1487, 9, 9, [{ name: "成化", sy: 1465, ey: 1487 }]),
  drDay("ming", "zhu-youcheng", "明孝宗", "达皇帝", "孝宗", 1487, 9, 9, 1505, 6, 8, [{ name: "弘治", sy: 1488, ey: 1505 }]),
  drDay("ming", "zhu-houzhao", "明武宗", "毅皇帝", "武宗", 1505, 6, 8, 1521, 4, 20, [{ name: "正德", sy: 1506, ey: 1521 }]),
  drDay("ming", "zhu-houcong", "明世宗", "肃皇帝", "世宗", 1521, 5, 27, 1567, 1, 23, [{ name: "嘉靖", sy: 1522, ey: 1566 }]),
  drDay("ming", "zhu-zaihou", "明穆宗", "庄皇帝", "穆宗", 1567, 1, 23, 1572, 7, 5, [{ name: "隆庆", sy: 1567, ey: 1572 }]),
  drDay("ming", "zhu-yiming", "明神宗", "显皇帝", "神宗", 1572, 7, 5, 1620, 8, 18, [{ name: "万历", sy: 1573, ey: 1620 }]),
  drDay("ming", "zhu-changluo", "明光宗", "贞皇帝", "光宗", 1620, 8, 28, 1620, 9, 26, [{ name: "泰昌", sy: 1620, ey: 1620 }]),
  drDay("ming", "zhu-youjiao", "明熹宗", "哲皇帝", "熹宗", 1620, 9, 26, 1627, 9, 30, [{ name: "天启", sy: 1621, ey: 1627 }]),
  drDay("ming", "zhu-youjian", "明思宗", "毅皇帝", "思宗", 1627, 10, 2, 1644, 4, 25, [{ name: "崇祯", sy: 1628, ey: 1644 }]),
];

const mingSouthMain = [
  drDay("ming-south", "zhu-yousong", "弘光帝", null, null, 1644, 6, 19, 1645, 6, 15, [{ name: "弘光", sy: 1644, ey: 1645 }]),
  drDay("ming-south", "zhu-yujian", "隆武帝", null, null, 1645, 8, 18, 1646, 10, 6, [{ name: "隆武", sy: 1645, ey: 1646 }]),
  drDay("ming-south", "zhu-youlang", "永历帝", null, null, 1646, 12, 24, 1662, 6, 1, [{ name: "永历", sy: 1646, ey: 1662 }]),
];
const mingSouthParallel = [
  drDay("ming-south", "zhu-yihai", "鲁监国", null, null, 1645, 9, 7, 1653, 3, 1, [], {
    track: "lu-jian",
    label: "绍兴监国",
  }),
  drDay("ming-south", "zhu-yuyue", "绍武帝", null, null, 1646, 12, 11, 1647, 1, 20, [{ name: "绍武", sy: 1646, ey: 1647 }], {
    track: "shaowu",
    label: "广州",
  }),
];
const mingSouthReigns = [...mingSouthMain, ...mingSouthParallel];

// 清帝在位日取维基百科君主列表通行换算，precision=day。
const qingReigns = [
  drDay("qing", "nurhaci", "清太祖", "武皇帝", "太祖", 1616, 2, 17, 1626, 9, 30, [{ name: "天命", sy: 1616, ey: 1626 }]),
  drDay("qing", "huang-taiji", "清太宗", "文皇帝", "太宗", 1626, 10, 20, 1643, 9, 21, [
    { name: "天聪", sy: 1627, ey: 1636 },
    { name: "崇德", sy: 1636, ey: 1643 },
  ]),
  drDay("qing", "fulin", "清世祖", "章皇帝", "世祖", 1643, 10, 30, 1661, 2, 5, [{ name: "顺治", sy: 1644, ey: 1661 }]),
  drDay("qing", "xuanye", "清圣祖", "仁皇帝", "圣祖", 1661, 2, 5, 1722, 12, 20, [{ name: "康熙", sy: 1662, ey: 1722 }]),
  drDay("qing", "yinzhen", "清世宗", "宪皇帝", "世宗", 1722, 12, 27, 1735, 10, 8, [{ name: "雍正", sy: 1723, ey: 1735 }]),
  drDay("qing", "hongli", "清高宗", "纯皇帝", "高宗", 1735, 10, 18, 1796, 2, 8, [{ name: "乾隆", sy: 1736, ey: 1795 }]),
  drDay("qing", "yongyan", "清仁宗", "睿皇帝", "仁宗", 1796, 2, 9, 1820, 9, 2, [{ name: "嘉庆", sy: 1796, ey: 1820 }]),
  drDay("qing", "minning", "清宣宗", "成皇帝", "宣宗", 1820, 10, 3, 1850, 2, 25, [{ name: "道光", sy: 1821, ey: 1850 }]),
  drDay("qing", "yizhu", "清文宗", "显皇帝", "文宗", 1850, 3, 9, 1861, 8, 22, [{ name: "咸丰", sy: 1851, ey: 1861 }]),
  drDay("qing", "zaichun", "清穆宗", "毅皇帝", "穆宗", 1861, 11, 11, 1875, 1, 12, [{ name: "同治", sy: 1862, ey: 1874 }]),
  drDay("qing", "zaitian", "清德宗", "景皇帝", "德宗", 1875, 2, 25, 1908, 11, 14, [{ name: "光绪", sy: 1875, ey: 1908 }]),
  drDay("qing", "puyi", "清逊帝", null, null, 1908, 12, 2, 1912, 2, 12, [{ name: "宣统", sy: 1909, ey: 1912 }]),
];

const reignGroups = [yuanReigns, yuanMoReigns, mingReigns, mingSouthMain, qingReigns];
const reigns = applyDocumentedDatesToReigns(
  [yuanReigns, yuanMoReigns, mingReigns, mingSouthReigns, qingReigns].flat(),
);

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
  // 元——战争
  eventRange({ id: "war-of-two-capitals", name: "两都之战", kind: "battle", timeMode: "span", start: ym(1328), end: ym(1329), dynastyIds: ["yuan"], participantIds: ["tugh-temur", "ragibagh"], summary: "元文宗与元天顺帝阿速吉八争夺大都，文宗获胜，天顺帝在位仅一月。" }),
  eventRange({ id: "red-turban-uprising", name: "红巾起义", kind: "battle", timeMode: "span", start: ym(1351), end: ym(1368), dynastyIds: ["yuan"], participantIds: ["togon-temur", "liu-futong", "xu-shouhui"], summary: "刘福通、徐寿辉等发动红巾军起义，席卷南北，元统治根基动摇。" }),
  eventPoint({ id: "chen-kills-xu", name: "陈友谅弑徐寿辉", kind: "politics", at: ym(1360, 6), dynastyIds: ["song-xu", "chen-han"], participantIds: ["chen-youliang", "xu-shouhui"], summary: "陈友谅于采石杀徐寿辉，自立称帝，国号汉，徐宋亡。" }),
  eventPoint({ id: "poyang-lake-battle", name: "鄱阳湖之战", kind: "battle", at: ym(1363, 10), dynastyIds: ["chen-han", "wu-zhu"], participantIds: ["chen-youliang", "zhu-yuanzhang"], summary: "朱元璋与陈友谅鄱阳湖决战，陈友谅中流矢阵亡，陈汉大势已去。" }),
  eventPoint({ id: "han-liner-death", name: "韩林儿溺亡", kind: "politics", at: ym(1366, 12), dynastyIds: ["song-han", "wu-zhu"], participantIds: ["han-liner", "zhu-yuanzhang"], summary: "朱元璋遣廖永忠迎韩林儿至应天，渡江时船沉，小明王遇难，韩宋亡。" }),
  eventPoint({ id: "zhang-shicheng-defeated", name: "张士诚败亡", kind: "politics", at: ym(1367, 9), dynastyIds: ["zhou-zhang", "wu-zhu"], participantIds: ["zhang-shicheng", "zhu-yuanzhang"], summary: "徐达克平江，张士诚被俘，大周亡。" }),
  eventPoint({ id: "xia-ming-founded", name: "明夏建立", kind: "politics", at: ym(1362), dynastyIds: ["xia-ming"], participantIds: ["ming-yuzhen"], summary: "明玉珍于重庆称帝，国号夏，据有两川。" }),
  eventPoint({ id: "xia-ming-fall", name: "明夏灭亡", kind: "politics", at: ym(1371), dynastyIds: ["xia-ming", "ming"], participantIds: ["ming-sheng"], summary: "明军灭夏，明升降明，明夏终结。" }),
  eventPoint({ id: "ming-founded", name: "明朝建立", kind: "politics", at: ym(1368), dynastyIds: ["ming", "wu-zhu", "yuan"], participantIds: ["zhu-yuanzhang", "togon-temur"], summary: "朱元璋称帝，定都南京，国号大明，元顺帝北逃漠北。" }),
  eventPoint({ id: "ming-capture-dadu", name: "明军攻占大都", kind: "battle", precision: "month", dateNote: "洪武元年八月，明军克大都", at: ym(1368, 8), dynastyIds: ["ming", "yuan"], participantIds: ["zhu-yuanzhang", "togon-temur"], summary: "明军北伐攻克大都，元顺帝北逃，元朝失去中原。" }),
  eventPoint({ id: "korqin-sea-battle", name: "捕鱼儿海之战", kind: "battle", at: ym(1388), dynastyIds: ["yuan", "ming"], participantIds: ["togus-temur"], summary: "明将蓝玉率军深入漠北，大破北元，俘北元宗室。" }),
  eventPoint({ id: "yuan-end", name: "元朝灭亡", kind: "politics", at: ym(1388), dynastyIds: ["yuan"], participantIds: ["togus-temur"], summary: "捕鱼儿海之战后，也速迭儿杀天元帝脱古思帖木儿，元朝国号终结。" }),
  eventRange({ id: "yongle-rule", name: "永乐盛世", kind: "politics", timeMode: "span", start: ym(1403), end: ym(1424), dynastyIds: ["ming"], participantIds: ["zhu-di"], summary: "明成祖迁都北京，派郑和下西洋，国力强盛。" }),
  eventPoint({ id: "jingnan-campaign", name: "靖难之役", kind: "battle", precision: "month", dateNote: "建文四年六月，朱棣攻入南京", at: ym(1402, 7), dynastyIds: ["ming"], participantIds: ["zhu-di", "zhu-yunwen"], summary: "燕王朱棣起兵夺位，攻入南京，建文帝下落成谜，朱棣即位。" }),
  eventRange({ id: "zheng-he-voyages", name: "郑和下西洋", kind: "culture", timeMode: "span", start: ym(1405), end: ym(1433), dynastyIds: ["ming"], participantIds: ["zheng-he", "zhu-di"], summary: "永乐至宣德间七次远航，最远达非洲东岸，宣扬国威。" }),
  eventPoint({ id: "tumu-crisis", name: "土木堡之变", kind: "battle", at: ym(1449), dynastyIds: ["ming"], participantIds: ["zhu-qizhen"], summary: "明英宗率军北征瓦剌，土木堡被俘，明军主力覆没。" }),
  eventPoint({ id: "beijing-defense", name: "北京保卫战", kind: "battle", precision: "month", dateNote: "正统十四年十月，于谦督师保卫北京", at: ym(1449, 10), dynastyIds: ["ming"], participantIds: ["yu-qian", "zhu-qiyu"], summary: "土木堡之变后瓦剌兵临北京，于谦拥立景泰帝，击退敌军。" }),
  eventPoint({ id: "duomen-restoration", name: "夺门之变", kind: "politics", precision: "month", dateNote: "天顺元年正月，石亨等拥英宗复辟", at: ym(1457, 1), dynastyIds: ["ming"], participantIds: ["zhu-qizhen", "zhu-qiyu"], summary: "石亨、曹吉祥等拥英宗复辟，废景泰帝，于谦被害。" }),
  eventRange({ id: "wanli-campaigns", name: "万历三大征", kind: "battle", timeMode: "span", start: ym(1592), end: ym(1600), dynastyIds: ["ming"], participantIds: ["zhu-yiming"], summary: "万历朝平定宁夏哱拜、朝鲜倭乱、播州杨应龙，耗损国力。" }),
  eventRange({ id: "zhang-juzheng-reforms", name: "张居正改革", kind: "politics", timeMode: "span", start: ym(1572), end: ym(1582), dynastyIds: ["ming"], participantIds: ["zhang-juzheng", "zhu-yiming"], summary: "张居正为首辅，推行考成法、一条鞭法，整顿吏治，史称万历中兴。" }),
  // 明——战争
  eventRange({ id: "anti-wokou-campaign", name: "抗倭战争", kind: "battle", timeMode: "span", start: ym(1555), end: ym(1567), dynastyIds: ["ming"], participantIds: ["qi-jiguang", "zhu-houcong"], summary: "戚继光组建戚家军，于台州、福建等地屡败倭寇，平定东南倭患。" }),
  eventPoint({ id: "sarhu-battle", name: "萨尔浒之战", kind: "battle", precision: "month", dateNote: "万历四十七年三月，后金大败明军", at: ym(1619, 3), dynastyIds: ["ming", "qing"], participantIds: ["zhu-yiming", "nurhaci"], summary: "努尔哈赤以少胜多，明军四路溃败，辽东战局逆转。" }),
  eventPoint({ id: "ningyuan-battle", name: "宁远之战", kind: "battle", precision: "month", dateNote: "天启六年正月，袁崇焕守宁远", at: ym(1626, 1), dynastyIds: ["ming", "qing"], participantIds: ["yuan-chonghuan", "huang-taiji", "nurhaci"], summary: "袁崇焕率红夷大炮守宁远，击伤努尔哈赤，后金首次攻明受挫。" }),
  eventRange({ id: "songjin-campaign", name: "松锦之战", kind: "battle", timeMode: "span", start: ym(1640), end: ym(1642), dynastyIds: ["ming", "qing"], participantIds: ["zhu-youjian", "huang-taiji"], summary: "清军围攻松山、锦州，洪承畴降清，明军关外主力覆没，辽东防线崩溃。" }),
  eventPoint({ id: "tingji-case", name: "梃击案", kind: "politics", precision: "month", dateNote: "万历四十三年五月初四，张差闯慈庆宫击太子", at: ym(1615, 5), dynastyIds: ["ming"], participantIds: ["zhu-changluo", "zheng-guifei"], summary: "狂人张差持梃闯宫击太子朱常洛，牵连郑贵妃，晚明三大疑案之一。" }),
  eventPoint({ id: "hongwan-case", name: "红丸案", kind: "politics", precision: "month", dateNote: "泰昌元年八月二十九日，光宗服用红丸暴毙", at: ym(1620, 8), dynastyIds: ["ming"], participantIds: ["zhu-changluo", "fang-congze"], summary: "明光宗即位仅月余，服李可灼所献红丸后暴亡，疑案缠身。" }),
  eventPoint({ id: "yigong-case", name: "移宫案", kind: "politics", precision: "month", dateNote: "泰昌元年九月，熹宗即位后逼李选侍迁出乾清宫", at: ym(1620, 9), dynastyIds: ["ming"], participantIds: ["zhu-youjiao", "li-xuanshi"], summary: "光宗死后李选侍据乾清宫不肯迁出，东林党力主逼迁，熹宗即位后李选侍移居别宫。" }),
  eventPoint({ id: "yuan-chonghuan-executed", name: "袁崇焕冤杀", kind: "politics", precision: "month", dateNote: "崇祯三年八月十六日，磔于市", at: ym(1630, 8), dynastyIds: ["ming"], participantIds: ["yuan-chonghuan", "zhu-youjian"], summary: "崇祯帝中皇太极反间计，以通敌罪处死袁崇焕，辽东防线崩溃。" }),
  eventPoint({ id: "ming-fall", name: "明朝灭亡", kind: "politics", at: ym(1644, 4), dynastyIds: ["ming"], participantIds: ["zhu-youjian"], summary: "李自成攻入北京，崇祯自缢，明朝灭亡。" }),
  eventPoint({ id: "qing-founded", name: "大清建国", kind: "politics", at: ym(1636, 5), dynastyIds: ["qing"], participantIds: ["huang-taiji"], summary: "皇太极改国号大清，完善国家制度。" }),
  eventPoint({ id: "qing-enter-pass", name: "清军入关", kind: "politics", at: ym(1644), dynastyIds: ["qing", "ming"], participantIds: ["fulin"], summary: "吴三桂引清军入关，定都北京，逐鹿中原。" }),
  eventRange({ id: "kangqian-prosperity", name: "康乾盛世", kind: "politics", timeMode: "span", start: ym(1661), end: ym(1796), dynastyIds: ["qing"], participantIds: ["xuanye", "hongli"], summary: "康熙、雍正、乾隆三朝国力强盛，疆域辽阔。" }),
  // 清——战争
  eventRange({ id: "suppress-three-feudatories", name: "平定三藩", kind: "battle", timeMode: "span", start: ym(1673), end: ym(1681), dynastyIds: ["qing"], participantIds: ["xuanye"], summary: "吴三桂等三藩起兵反清，康熙帝历时八年平定，巩固中央集权。" }),
  eventRange({ id: "yaksa-conflict", name: "雅克萨之战", kind: "battle", timeMode: "span", start: ym(1685), end: ym(1686), dynastyIds: ["qing"], participantIds: ["xuanye"], summary: "清军两次进攻沙俄占据的雅克萨，驱逐俄军，奠定东北边界谈判基础。" }),
  eventPoint({ id: "qing-unify-taiwan", name: "清廷统一台湾", kind: "politics", precision: "month", dateNote: "康熙二十二年，施琅攻克台湾", at: ym(1683, 10), dynastyIds: ["qing"], participantIds: ["xuanye"], summary: "施琅率水师攻克台湾，郑氏政权灭亡，台湾纳入清朝版图。" }),
  eventRange({ id: "jinchuan-campaigns", name: "大小金川之战", kind: "battle", timeMode: "span", start: ym(1747), end: ym(1776), dynastyIds: ["qing"], participantIds: ["hongli"], summary: "乾隆朝两次征讨大小金川土司，历时近三十年，最终改土归流。" }),
  eventRange({ id: "dzungar-campaign", name: "平定准噶尔", kind: "battle", timeMode: "span", start: ym(1755), end: ym(1757), dynastyIds: ["qing"], participantIds: ["hongli"], summary: "乾隆帝平定准噶尔部，统一新疆，奠定西北版图。" }),
  eventRange({ id: "sino-burmese-war", name: "清缅战争", kind: "battle", timeMode: "span", start: ym(1765), end: ym(1769), dynastyIds: ["qing"], participantIds: ["hongli"], summary: "清军与缅甸四次交锋，虽未能彻底征服，但遏制缅军北侵。" }),
  eventPoint({ id: "humen-opium-destruction", name: "虎门销烟", kind: "politics", precision: "month", dateNote: "道光十九年六月，林则徐在虎门销毁鸦片", at: ym(1839, 6), dynastyIds: ["qing"], participantIds: ["minning", "lin-zexu"], summary: "林则徐奉命查禁鸦片，于虎门公开销毁洋商鸦片，成为第一次鸦片战争导火索。" }),
  eventRange({ id: "opium-war", name: "第一次鸦片战争", kind: "battle", timeMode: "span", start: ym(1840), end: ym(1842), dynastyIds: ["qing"], participantIds: ["minning", "lin-zexu"], summary: "英国以鸦片贸易争端发动战争，清军战败，被迫签订南京条约。" }),
  eventRange({ id: "zuo-recover-xinjiang", name: "左宗棠收复新疆", kind: "battle", timeMode: "span", start: ym(1876), end: ym(1878), dynastyIds: ["qing"], participantIds: ["zuo-zongtang", "zaitian"], summary: "左宗棠率湘军西征，先后克复乌鲁木齐、吐鲁番、喀什噶尔，平定阿古柏，新疆重归清朝。" }),
  eventRange({ id: "sino-tibetan-war", name: "隆务关之战", kind: "battle", timeMode: "span", start: ym(1888), end: ym(1889), dynastyIds: ["qing"], participantIds: ["zaitian"], summary: "英军入侵西藏隆务关，清军反击后议和，签订中英续议藏印条约。" }),
  eventRange({ id: "second-opium-war", name: "第二次鸦片战争", kind: "battle", timeMode: "span", start: ym(1856), end: ym(1860), dynastyIds: ["qing"], participantIds: ["yizhu"], summary: "英法联军再度进攻，攻陷大沽、北京，圆明园被焚，清政府签订天津、北京条约。" }),
  eventRange({ id: "sino-french-war", name: "中法战争", kind: "battle", timeMode: "span", start: ym(1883, 12), end: ym(1885, 4), dynastyIds: ["qing"], participantIds: ["zaitian", "zuo-zongtang"], summary: "法国侵略越南，清军与黑旗军在北圻、台湾等地抗击法军，镇南关大捷后议和。" }),
  eventRange({ id: "first-sino-japanese-war", name: "甲午战争", kind: "battle", timeMode: "span", start: ym(1894, 7), end: ym(1895, 4), dynastyIds: ["qing"], participantIds: ["zaitian", "deng-shichang", "li-hongzhang"], summary: "日本挑起战争，黄海海战、辽东陆战清军失利，北洋海军覆没，签订马关条约。" }),
  eventRange({ id: "boxer-rebellion", name: "义和团运动", kind: "politics", timeMode: "span", start: ym(1899), end: ym(1901), dynastyIds: ["qing"], participantIds: ["zaitian"], summary: "山东等地义和团起事，反洋教、扶清灭洋，引发八国联军侵华。" }),
  eventRange({ id: "eight-nation-invasion", name: "八国联军侵华", kind: "battle", timeMode: "span", start: ym(1900), end: ym(1901), dynastyIds: ["qing"], participantIds: ["zaitian"], summary: "八国联军攻陷北京，慈禧太后西逃，清廷被迫签订辛丑条约。" }),
  // 清——条约
  eventPoint({ id: "treaty-of-nerchinsk", name: "尼布楚条约", kind: "politics", precision: "month", dateNote: "康熙二十八年七月，中俄签订", at: ym(1689, 8), dynastyIds: ["qing"], participantIds: ["xuanye"], summary: "中俄签订首个边界条约，划定外兴安岭以南、额尔古纳河以东归属，确立东段国界。" }),
  eventPoint({ id: "treaty-of-nanjing", name: "南京条约", kind: "politics", precision: "month", dateNote: "道光二十二年七月，中英签订", at: ym(1842, 8), dynastyIds: ["qing"], participantIds: ["minning"], summary: "中国近代首个不平等条约：割香港岛、赔款、五口通商、协定关税。" }),
  eventPoint({ id: "treaty-of-bogue", name: "虎门条约", kind: "politics", precision: "month", dateNote: "道光二十三年九月，中英签订", at: ym(1843, 10), dynastyIds: ["qing"], participantIds: ["minning"], summary: "南京条约附件，英国取得片面最惠国待遇、领事裁判权及五口租地。" }),
  eventPoint({ id: "treaty-of-wanghia", name: "望厦条约", kind: "politics", precision: "month", dateNote: "道光二十四年六月，中美签订", at: ym(1844, 7), dynastyIds: ["qing"], participantIds: ["minning"], summary: "中国与美国签订的首个条约，美国获最惠国待遇、领事裁判权及五口通商。" }),
  eventPoint({ id: "treaty-of-whampoa", name: "黄埔条约", kind: "politics", precision: "month", dateNote: "道光二十四年九月，中法签订", at: ym(1844, 10), dynastyIds: ["qing"], participantIds: ["minning"], summary: "中国与法国签订的首个条约，法国获最惠国待遇、领事裁判权及五口通商。" }),
  eventPoint({ id: "treaty-of-aigun", name: "瑷珲条约", kind: "politics", precision: "month", dateNote: "咸丰八年五月，中俄签订", at: ym(1858, 5), dynastyIds: ["qing"], participantIds: ["yizhu"], summary: "俄国趁第二次鸦片战争割占黑龙江以北、乌苏里江以东大片领土。" }),
  eventPoint({ id: "treaty-of-tientsin", name: "天津条约", kind: "politics", precision: "month", dateNote: "咸丰八年五月，与英法美俄分别签订", at: ym(1858, 6), dynastyIds: ["qing"], participantIds: ["yizhu"], summary: "列强增开通商口岸、允许外国公使驻京、内河航行等特权，进一步打开中国。" }),
  eventPoint({ id: "convention-of-peking", name: "北京条约", kind: "politics", precision: "month", dateNote: "咸丰十年九月，与英法俄签订", at: ym(1860, 10), dynastyIds: ["qing"], participantIds: ["yizhu"], summary: "割九龙司、增赔款、准许英法公使驻京，俄国确认瑷珲条约并割占乌苏里江以东。" }),
  eventPoint({ id: "sino-japanese-amity-treaty", name: "中日修好条规", kind: "politics", precision: "month", dateNote: "同治十年七月，中日签订", at: ym(1871, 7), dynastyIds: ["qing"], participantIds: ["zaichun"], summary: "中国与日本签订的首个条约，互认领事裁判权，为日后甲午战争埋下伏笔。" }),
  eventPoint({ id: "treaty-of-chefoo", name: "烟台条约", kind: "politics", precision: "month", dateNote: "光绪二年八月，中英签订", at: ym(1876, 9), dynastyIds: ["qing"], participantIds: ["zaichun"], summary: "马嘉理案后签订，英国获滇缅通商、驻重庆领事等特权，并承认英国对缅甸的支配。" }),
  eventPoint({ id: "treaty-of-saint-petersburg", name: "伊犁条约", kind: "politics", precision: "month", dateNote: "光绪七年正月，中俄签订", at: ym(1881, 2), dynastyIds: ["qing"], participantIds: ["zaitian", "zuo-zongtang"], summary: "俄国归还伊犁，但割占霍尔果斯以西七万余平方公里，赔款九百万卢布。" }),
  eventPoint({ id: "treaty-of-sino-french", name: "中法新约", kind: "politics", precision: "month", dateNote: "光绪十一年六月，中法签订", at: ym(1885, 6), dynastyIds: ["qing"], participantIds: ["zaitian"], summary: "中法战争议和，中国承认法国对越南的保护权，西南门户洞开。" }),
  eventPoint({ id: "convention-of-sikkim", name: "中英续议藏印条约", kind: "politics", precision: "month", dateNote: "光绪十六年十二月，中英签订", at: ym(1890, 12), dynastyIds: ["qing"], participantIds: ["zaitian"], summary: "隆务关之战后议和，划定藏印边界，承认英国对锡金的保护。" }),
  eventPoint({ id: "convention-of-burma", name: "中英续议滇缅条约", kind: "politics", precision: "month", dateNote: "光绪二十年十二月，中英签订", at: ym(1894, 12), dynastyIds: ["qing"], participantIds: ["zaitian"], summary: "划定滇缅边界，开放蛮耗为商埠，英国进一步渗透西南边疆。" }),
  eventPoint({ id: "treaty-of-shimonoseki", name: "马关条约", kind: "politics", precision: "month", dateNote: "光绪二十一年四月，中日签订", at: ym(1895, 4), dynastyIds: ["qing"], participantIds: ["zaitian", "li-hongzhang"], summary: "割辽东、台湾及澎湖，赔款二亿两，开放沙市等口岸，允许日本在华设厂。" }),
  eventPoint({ id: "triple-intervention", name: "三国干涉还辽", kind: "politics", precision: "month", dateNote: "光绪二十一年四月，俄法德迫使日本归还辽东", at: ym(1895, 4), dynastyIds: ["qing"], participantIds: ["zaitian", "li-hongzhang"], summary: "马关条约割辽东后，俄法德联合施压，日本同意归还辽东半岛，清政府另付赎款。" }),
  eventPoint({ id: "boxer-protocol", name: "辛丑条约", kind: "politics", precision: "month", dateNote: "光绪二十七年七月，与十一国签订", at: ym(1901, 9), dynastyIds: ["qing"], participantIds: ["zaitian", "li-hongzhang"], summary: "赔款四亿五千万两、使馆区、拆炮台、惩办官员，中国完全沦为半殖民地半封建社会。" }),
  eventPoint({ id: "treaty-of-renewal-1902", name: "中俄改订条约", kind: "politics", precision: "month", dateNote: "光绪二十八年三月，中俄签订", at: ym(1902, 4), dynastyIds: ["qing"], participantIds: ["zaitian"], summary: "俄国归还庚子事变后侵占的东北三省，但获中东铁路续租等特权。" }),
  eventRange({ id: "taiping-rebellion", name: "太平天国运动", kind: "politics", timeMode: "span", precision: "month", start: ym(1851, 1), end: ym(1864, 7), dynastyIds: ["qing"], participantIds: ["yizhu"], summary: "洪秀全领导太平天国运动，1851年1月金田起义至1864年7月天京陷落，与清廷对峙十余年。" }),
  eventPoint({ id: "xinhai-revolution", name: "辛亥革命", kind: "politics", at: ym(1911), dynastyIds: ["qing"], participantIds: ["sun-yat-sen"], summary: "武昌起义爆发，各省独立，帝制走向终结。" }),
  eventPoint({ id: "qing-fall", name: "清帝退位", kind: "politics", precision: "month", dateNote: "1912年2月12日，宣统退位", at: ym(1912, 2), dynastyIds: ["qing"], participantIds: ["puyi"], summary: "溥仪颁布退位诏书，清朝终结，中华民国成立。" }),
  eventPoint({ id: "lu-jian-enthroned", name: "鲁王监国", kind: "politics", at: ym(1645), dynastyIds: ["ming-south"], participantIds: ["zhu-yihai"], summary: "弘光亡后，朱以海监国于绍兴，与福州隆武政权并立。" }),
  eventPoint({ id: "shaowu-enthroned", name: "绍武称帝", kind: "politics", at: ym(1646), dynastyIds: ["ming-south"], participantIds: ["zhu-yuyue"], summary: "隆武被俘后，朱聿鐭在广州称帝，与肇庆永历并立。" }),
  eventPoint({ id: "shaowu-fall", name: "绍武败亡", kind: "politics", at: ym(1647), dynastyIds: ["ming-south"], participantIds: ["zhu-yuyue"], summary: "清军破广州，绍武帝死，广州朝廷覆灭。" }),
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
  { id: "rel-chen-kills-xu", fromRef: "event:chen-kills-xu", toRef: "person:chen-youliang", kind: "other" },
  { id: "rel-poyang-chen-youliang", fromRef: "event:poyang-lake-battle", toRef: "person:chen-youliang", kind: "battle" },
  { id: "rel-tumu-zhu-qizhen", fromRef: "event:tumu-crisis", toRef: "person:zhu-qizhen", kind: "battle" },
  { id: "rel-jingnan-zhu-di", fromRef: "event:jingnan-campaign", toRef: "person:zhu-di", kind: "battle" },
  { id: "rel-beijing-yu-qian", fromRef: "event:beijing-defense", toRef: "person:yu-qian", kind: "battle" },
  { id: "rel-tingji-zhu-changluo", fromRef: "event:tingji-case", toRef: "person:zhu-changluo", kind: "other" },
  { id: "rel-hongwan-zhu-changluo", fromRef: "event:hongwan-case", toRef: "person:zhu-changluo", kind: "other" },
  { id: "rel-yigong-zhu-youjiao", fromRef: "event:yigong-case", toRef: "person:zhu-youjiao", kind: "other" },
  { id: "rel-opium-lin-zexu", fromRef: "event:opium-war", toRef: "person:lin-zexu", kind: "other" },
  { id: "rel-sino-japanese-deng", fromRef: "event:first-sino-japanese-war", toRef: "person:deng-shichang", kind: "battle" },
  { id: "rel-shimonoseki-li", fromRef: "event:treaty-of-shimonoseki", toRef: "person:li-hongzhang", kind: "other" },
  { id: "rel-boxer-protocol-li", fromRef: "event:boxer-protocol", toRef: "person:li-hongzhang", kind: "other" },
  { id: "rel-sino-french-zuo", fromRef: "event:sino-french-war", toRef: "person:zuo-zongtang", kind: "battle" },
  { id: "rel-humen-lin-zexu", fromRef: "event:humen-opium-destruction", toRef: "person:lin-zexu", kind: "other" },
  { id: "rel-xinjiang-zuo", fromRef: "event:zuo-recover-xinjiang", toRef: "person:zuo-zongtang", kind: "battle" },
  { id: "rel-ili-zuo", fromRef: "event:treaty-of-saint-petersburg", toRef: "person:zuo-zongtang", kind: "other" },
  { id: "rel-sarhu-nurhaci", fromRef: "event:sarhu-battle", toRef: "person:nurhaci", kind: "battle" },
  { id: "rel-ningyuan-yuan", fromRef: "event:ningyuan-battle", toRef: "person:yuan-chonghuan", kind: "battle" },
  { id: "rel-wokou-qi", fromRef: "event:anti-wokou-campaign", toRef: "person:qi-jiguang", kind: "battle" },
  { id: "rel-red-turban-liu", fromRef: "event:red-turban-uprising", toRef: "person:liu-futong", kind: "battle" },
  { id: "rel-zhang-reforms", fromRef: "event:zhang-juzheng-reforms", toRef: "person:zhang-juzheng", kind: "other" },
);

// ── SQL ──────────────────────────────────────────────────────────────────────

function personSql(p) {
  return `INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links) VALUES (${sqlStr(p.id)}, ${sqlStr(p.name)}, ${p.birth?.year ?? "NULL"}, ${p.birth?.month ?? "NULL"}, ${p.death?.year ?? "NULL"}, ${p.death?.month ?? "NULL"}, ${sqlArray(p.roles)}, ${sqlStr(p.bio)}, ${sqlJson(p.links)}) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;`;
}
function dynastySql(d) {
  const orthodoxFromAbs = resolveOrthodoxFromAbs(d);
  const orthodoxEndAbs = resolveOrthodoxEndAbs(d);
  return `INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, note) VALUES (${sqlStr(d.id)}, ${sqlStr(d.name)}, ${sqlArray(d.altNames)}, ${sqlStr(d.scope)}, ${sqlStr(d.region)}, ${d.start.year}, ${d.start.month}, ${d.end.year}, ${d.end.month}, ${d.start.abs}, ${d.end.abs}, ${sqlStr(d.precision)}, ${sqlStr(d.colorToken)}, ${orthodoxFromAbs ?? "NULL"}, ${orthodoxEndAbs ?? "NULL"}, NULL, ${sqlStr(d.note)}) ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, note = EXCLUDED.note;`;
}
function formatReignSql(r) {
  return reignSql(r, sqlStr, sqlJson);
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
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)}) ON CONFLICT (id) DO NOTHING;`;
}

const { persons: importPersons, reigns: importReigns } = finalizeImportReigns("yuan-ming-qing", persons, reigns);

const reignsWithEras = importReigns.filter((r) => r.eraNames.length > 0);
const eraDeleteSql = reignsWithEras.map((r) => `DELETE FROM era_names WHERE reign_id = ${sqlStr(r.id)};`);
const eraInsertSql = reignsWithEras.flatMap((r) => r.eraNames.map(eraNameSql));
const eventDynastySql = events.flatMap((e) => e.dynastyIds.map((d) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(e.id)}, ${sqlStr(d)}) ON CONFLICT DO NOTHING;`));
const eventParticipantSql = events.flatMap((e) => e.participantIds.map((p) => `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(e.id)}, ${sqlStr(p)}) ON CONFLICT DO NOTHING;`));

const preSql = [
  "DELETE FROM event_dynasties WHERE dynasty_id = 'yuan-north';",
  "DELETE FROM event_participants WHERE event_id = 'yuan-north-end';",
  "DELETE FROM events WHERE id = 'yuan-north-end';",
  "DELETE FROM reigns WHERE dynasty_id = 'yuan-north';",
  "DELETE FROM dynasties WHERE id = 'yuan-north';",
  "-- remove stale auto-generated 史料缺 (两都之战并行叠放、驾崩至即位短空档应留白)",
  sqlDeleteSystemMissingReigns(["yuan"], sqlStr),
].join("\n");

const sql = ["-- EraLens period import: yuan-ming-qing", "-- Window: 1271-12 .. 1912-02", "BEGIN;", "", preSql, "", "-- persons", ...importPersons.map(personSql), "", "-- dynasties", ...dynasties.map(dynastySql), "", "-- reigns", ...importReigns.map(formatReignSql), "", "-- era_names", ...eraDeleteSql, ...eraInsertSql, "", "-- events", ...events.map(eventSql), "", "-- event_dynasties", ...eventDynastySql, "", "-- event_participants", ...eventParticipantSql, "", "-- relations", ...relations.map(relationSql), "", "COMMIT;", ""].join("\n");

mkdirSync(__dirname, { recursive: true });
writeFileSync(path.join(__dirname, "import.sql"), sql);

const manifest = {
  slug: "yuan-ming-qing",
  title: "元明清（含南明）",
  window: { startYear: 1271, startMonth: 12, endYear: 1912, endMonth: 2 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-13",
  counts: { persons: persons.length, dynasties: dynasties.length, reigns: reigns.length, events: events.length, relations: relations.length },
  sources: [
    { label: "元朝", url: "https://zh.wikipedia.org/wiki/元朝" },
    { label: "北元", url: "https://zh.wikipedia.org/wiki/北元" },
    { label: "徐寿辉", url: "https://zh.wikipedia.org/wiki/徐寿辉" },
    { label: "陈友谅", url: "https://zh.wikipedia.org/wiki/陈友谅" },
    { label: "陈汉", url: "https://zh.wikipedia.org/wiki/陈汉" },
    { label: "韩林儿", url: "https://zh.wikipedia.org/wiki/韩林儿" },
    { label: "张士诚", url: "https://zh.wikipedia.org/wiki/张士诚" },
    { label: "明玉珍", url: "https://zh.wikipedia.org/wiki/明玉珍" },
    { label: "鄱阳湖之战", url: "https://zh.wikipedia.org/wiki/鄱阳湖之战" },
    { label: "爱猷识理达腊", url: "https://zh.wikipedia.org/wiki/爱猷识理达腊" },
    { label: "脱古思帖木儿", url: "https://zh.wikipedia.org/wiki/脱古思帖木儿" },
    { label: "明朝", url: "https://zh.wikipedia.org/wiki/明朝" },
    { label: "清朝", url: "https://zh.wikipedia.org/wiki/清朝" },
    { label: "南明", url: "https://zh.wikipedia.org/wiki/南明" },
    { label: "朱以海", url: "https://zh.wikipedia.org/wiki/朱以海" },
    { label: "绍武帝", url: "https://zh.wikipedia.org/wiki/绍武帝" },
    { label: "土木堡之变", url: "https://zh.wikipedia.org/wiki/土木堡之变" },
    { label: "靖难之役", url: "https://zh.wikipedia.org/wiki/靖难之役" },
    { label: "郑和下西洋", url: "https://zh.wikipedia.org/wiki/郑和下西洋" },
    { label: "梃击案", url: "https://zh.wikipedia.org/wiki/梃击案" },
    { label: "红丸案", url: "https://zh.wikipedia.org/wiki/红丸案" },
    { label: "移宫案", url: "https://zh.wikipedia.org/wiki/移宫案" },
    { label: "袁崇焕", url: "https://zh.wikipedia.org/wiki/袁崇焕" },
    { label: "张居正", url: "https://zh.wikipedia.org/wiki/张居正" },
    { label: "王阳明", url: "https://zh.wikipedia.org/wiki/王阳明" },
    { label: "严嵩", url: "https://zh.wikipedia.org/wiki/严嵩" },
    { label: "唐寅", url: "https://zh.wikipedia.org/wiki/唐寅" },
    { label: "徐光启", url: "https://zh.wikipedia.org/wiki/徐光启" },
    { label: "辛亥革命", url: "https://zh.wikipedia.org/wiki/辛亥革命" },
    { label: "平定三藩", url: "https://zh.wikipedia.org/wiki/平定三藩之乱" },
    { label: "雅克萨之战", url: "https://zh.wikipedia.org/wiki/雅克萨之战" },
    { label: "尼布楚条约", url: "https://zh.wikipedia.org/wiki/尼布楚条约" },
    { label: "南京条约", url: "https://zh.wikipedia.org/wiki/南京条约" },
    { label: "第二次鸦片战争", url: "https://zh.wikipedia.org/wiki/第二次鸦片战争" },
    { label: "中法战争", url: "https://zh.wikipedia.org/wiki/中法战争" },
    { label: "甲午战争", url: "https://zh.wikipedia.org/wiki/甲午战争" },
    { label: "马关条约", url: "https://zh.wikipedia.org/wiki/马关条约" },
    { label: "辛丑条约", url: "https://zh.wikipedia.org/wiki/辛丑条约" },
    { label: "虎门条约", url: "https://zh.wikipedia.org/wiki/虎门条约" },
    { label: "望厦条约", url: "https://zh.wikipedia.org/wiki/望厦条约" },
    { label: "黄埔条约", url: "https://zh.wikipedia.org/wiki/黄埔条约" },
    { label: "伊犁条约", url: "https://zh.wikipedia.org/wiki/中俄伊犁条约" },
    { label: "虎门销烟", url: "https://zh.wikipedia.org/wiki/虎门销烟" },
    { label: "左宗棠收复新疆", url: "https://zh.wikipedia.org/wiki/左宗棠平乱" },
  ],
  notes: [
    "覆盖元（1271–1388，含漠北延续；正统金色止于1368）、明（1368–1644）、南明（1644–1662）、清（1636–1912）。",
    "元末漠北三位君主：元惠宗（顺帝北迁续统，1368–1370）、元昭宗（1370–1378）、天元帝（1378–1388）。",
    "清王朝行自1616年努尔哈赤建后金起算，1636年改国号大清；努尔哈赤、皇太极在位计入清 reign，但正统自顺治（福临）入关（1644）起算。",
    "明清皇帝卡片优先显示年号；朱祁镇两段在位分别用正统、天顺。",
    "元世祖至元年间部分早于1271年，年号取1271年后窗口。",
    "1912年清帝退位为帝制终结；中华民国不在本包内。",
    "元末割据：徐宋（1351–1360）、韩宋（1355–1366）、大周（1354–1367）、陈汉（1360–1364）、明夏（1362–1371）、吴/西吴（1364–1368，朱元璋称帝前）。",
    "未收录明郑（1662–1683）等延续政权。",
    "南明并行用 claim_track：主线弘光→隆武→永历；lu-jian/朱以海（绍兴监国）、shaowu/朱聿鐭（广州）。不把鲁监国、绍武串进继承链。",
    "晚明三大疑案：梃击案（1615）、红丸案（1620）、移宫案（1620），均取通行月日写入 date_note。",
    "清战争：平定三藩、雅克萨、统一台湾、大小金川、准噶尔、清缅、两次鸦片战争、中法战争、甲午战争、义和团、八国联军。",
    "清条约：尼布楚（1689，平等边界条约）、南京、虎门、望厦、黄埔、瑷珲、天津、北京、中日修好条规、烟台、伊犁、中法新约、藏印、滇缅、马关、辛丑、中俄改订；条约月日取通行说法写入 date_note。",
    "鸦片战争事件 id 仍为 opium-war，名称改为「第一次鸦片战争」并改为 span（1840–1842）。",
    "补充战争：虎门销烟、左宗棠收复新疆、隆务关之战；三国干涉还辽为马关条约后续外交事件。",
    "元明战争：两都之战、红巾起义、明军攻占大都、抗倭战争、萨尔浒、宁远、松锦之战。",
    "明非帝王人物：张居正、海瑞、戚继光、王阳明、严嵩、唐寅、李时珍、徐光启、徐霞客、魏忠贤、刘基、于谦、郑和等；张居正改革（1572–1582）为 span 事件。",
    "元明清皇帝在位日取维基百科君主列表通行换算，precision=day；南明弘光/隆武/永历及鲁监国、绍武亦升级日精度。",
    "元两都之战文宗与明宗并行、帝位短空档等不标史料缺，时间轴自然留白。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);
console.log(`Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`);
