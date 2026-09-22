#!/usr/bin/env node
/**
 * Compile dynasty capital research data → capitals-raw.json (no coordinates).
 * Sources: 维基百科各政权/都城条目，正史年表，EraLens 王朝起迄窗口。
 */
import { writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { absMonth, wiki, ym } from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

/** Romanized slug for auto id generation. */
const PLACE_KEBAB = {
  宛丘: "wanqiu",
  有熊: "youxiong",
  帝丘: "diqiu",
  亳: "bo",
  平阳: "pingyang",
  阳城: "yangcheng",
  斟鄩: "zhenxun",
  西河: "xihe",
  殷: "yin",
  镐京: "haojing",
  洛邑: "luoyi",
  陶丘: "taoqiu",
  临淄: "linzi",
  蓟: "ji",
  曲阜: "qufu",
  绛: "jiang",
  新绛: "xinjiang",
  丹阳: "danyang",
  郢: "ying",
  陈: "chen",
  寿春: "shouchun",
  朝歌: "chaoge",
  商丘: "shangqiu",
  新郑: "xinzheng",
  西垂: "xiqi",
  "汧渭之会": "qianhui",
  雍: "yong",
  栎阳: "liyue",
  咸阳: "xianyang",
  杞: "qi",
  莒: "ju",
  滕: "teng",
  姑苏: "gusu",
  会稽: "kuaiji",
  琅琊: "langya",
  薛: "xue",
  王城: "wangcheng",
  灵寿: "lingshou",
  邯郸: "handan",
  大梁: "daliang",
  晋阳: "jinyang",
  邯郸赵: "handan-zhao",
  夜郎: "yelang",
  滇池: "dianchi",
  代: "dai",
  即墨: "jimo",
  彭城: "pengcheng",
  番禺: "panyu",
  国内城: "guoneicheng",
  长安: "changan",
  洛阳: "luoyang",
  成都: "chengdu",
  建业: "jianye",
  姑臧: "guzang",
  襄国: "xiangguo",
  邺: "ye",
  龙城: "longcheng",
  长子: "changzi",
  中山: "zhongshan",
  桴罕: "fuhan",
  统万城: "tongwancheng",
  广固: "guanggu",
  酒泉: "jiuquan",
  敦煌: "dunhuang",
  盛乐: "shengle",
  平城: "pingcheng",
  乐都: "ledu",
  张掖: "zhangye",
  仇池: "chouchi",
  建康: "jiankang",
  江陵: "jiangling",
  大兴城: "daxing",
  逻些: "luosuo",
  太和城: "taihecheng",
  羊苴咩城: "yangjumei",
  莫贺延碛: "moheyanshi",
  伏俟城: "fushicheng",
  平壤: "pyongyang",
  神都: "shendu",
  杭州: "hangzhou",
  广陵: "guangling",
  汴州: "bianzhou",
  长乐府: "changlefu",
  兴王府: "xingwangfu",
  南京析津府: "nanjing-xijinfu",
  临潢府: "linhuangfu",
  虎思斡耳朵: "husihu-ordu",
  西京: "xijing",
  扬州: "yangzhou",
  福州: "fuzhou",
  成都蜀: "chengdu-shu",
  太原: "taiyuan",
  开封: "kaifeng",
  金陵: "jinling",
  上京临潢府: "shangjing",
  兴庆府: "xingqing",
  会宁府: "huining",
  中都: "zhongdu",
  汴京: "bianjing",
  哈拉和林: "karakorum",
  开平: "kaiping",
  上都: "shangdu",
  大都: "dadu",
  应天: "yingtian",
  顺天: "shuntian",
  盛京: "shengjing",
  天京: "tianjing",
  武昌: "wuchang",
  承天: "chengtian",
  南宁: "nanning",
  安龙: "anlong",
  昆明: "kunming",
  西充: "xichong",
  台南: "tainan",
  重庆: "chongqing",
  北京: "beijing",
  临安: "linan",
  应天府: "yingtianfu",
};

function toKebab(historicalName) {
  if (PLACE_KEBAB[historicalName]) return PLACE_KEBAB[historicalName];
  return historicalName
    .normalize("NFKD")
    .replace(/[^\w\u4e00-\u9fff]+/g, "-")
    .replace(/^-|-$/g, "")
    .toLowerCase();
}

/**
 * @param {string} dynastyId
 * @param {string} historicalName
 * @param {string} modernName
 * @param {number} startYear
 * @param {number} [startMonth]
 * @param {number} endYear
 * @param {number} [endMonth]
 * @param {{ role?: string, note?: string, wikiTitle?: string, id?: string }} [opts]
 */
export function entry(
  dynastyId,
  historicalName,
  modernName,
  startYear,
  startMonth = 1,
  endYear,
  endMonth = 12,
  { role = "primary", note, wikiTitle, id } = {},
) {
  const start = ym(startYear, startMonth);
  const end = ym(endYear, endMonth);
  const kebab = toKebab(historicalName);
  const capId = id ?? `cap-${dynastyId}-${kebab}-${Math.abs(startYear)}`;
  return {
    id: capId,
    dynastyId,
    historicalName,
    modernName,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    precision: "year",
    role,
    note,
    links: wikiTitle ? wiki(wikiTitle) : [],
  };
}

/** Shorthand: year-precision (month 1 → 12). */
const e = (dynastyId, historicalName, modernName, startYear, endYear, opts) =>
  entry(dynastyId, historicalName, modernName, startYear, 1, endYear, 12, opts);

export const capitals = [
  // ── 传说时代 ──────────────────────────────────────────────────────────────
  e("san-huang", "宛丘", "河南省周口市淮阳区", -2804, -2465, {
    note: "三皇传说都城，伏羲女娲神农皆传都宛丘（陈）。",
    wikiTitle: "淮阳区",
  }),

  e("wu-di", "有熊", "河南省郑州市新郑市", -2464, -2357, {
    note: "黄帝轩辕氏传说都城有熊（新郑）。",
    wikiTitle: "黄帝",
  }),
  e("wu-di", "帝丘", "河南省濮阳市", -2356, -2209, {
    note: "帝颛顼高阳氏都帝丘。",
    wikiTitle: "颛顼",
  }),
  e("wu-di", "亳", "河南省商丘市", -2208, -2140, {
    note: "帝喾高辛氏及帝挚都亳。",
    wikiTitle: "帝喾",
  }),
  e("wu-di", "平阳", "山西省临汾市", -2139, -2071, {
    note: "帝尧、帝舜都平阳。",
    wikiTitle: "尧",
  }),

  // ── 夏商周 ────────────────────────────────────────────────────────────────
  e("xia", "阳城", "河南省郑州市登封市", -2070, -1990, {
    note: "夏禹都阳城。",
    wikiTitle: "阳城",
  }),
  e("xia", "帝丘", "河南省濮阳市", -1989, -1900, {
    note: "夏启、相等帝丘。",
    wikiTitle: "帝丘",
  }),
  e("xia", "斟鄩", "河南省洛阳市偃师区", -1899, -1700, {
    note: "太康失国后夏多都斟鄩。",
    wikiTitle: "斟鄩",
  }),
  e("xia", "西河", "河南省安阳市内黄县", -1699, -1600, {
    note: "夏桀都西河。",
    wikiTitle: "西河",
  }),

  e("shang", "亳", "河南省商丘市", -1600, -1300, {
    note: "商初都亳。",
    wikiTitle: "亳",
  }),
  e("shang", "斟鄩", "河南省洛阳市偃师区", -1299, -1210, {
    note: "商中期西亳（偃师）。",
    wikiTitle: "偃师区",
  }),
  e("shang", "殷", "河南省安阳市", -1209, -1046, {
    note: "盘庚迁殷后商都殷。",
    wikiTitle: "殷墟",
  }),

  e("zhou-west", "镐京", "陕西省西安市", -1046, -771, {
    note: "西周都城镐京（宗周）。",
    wikiTitle: "镐京",
  }),

  e("zhou-east", "洛邑", "河南省洛阳市", -770, -256, {
    note: "东周都城洛邑（王城）。",
    wikiTitle: "洛邑",
  }),

  // ── 春秋战国诸侯 ──────────────────────────────────────────────────────────
  e("cao-chunqiu", "陶丘", "山东省菏泽市定陶区", -1046, -487, {
    note: "曹国都城陶丘。",
    wikiTitle: "曹国",
  }),
  e("qi-chunqiu", "临淄", "山东省淄博市临淄区", -1046, -221, {
    note: "齐国都城临淄。",
    wikiTitle: "临淄",
  }),
  e("yan-chunqiu", "蓟", "北京市", -1044, -222, {
    note: "燕国都城蓟。",
    wikiTitle: "蓟城",
  }),
  e("lu-chunqiu", "曲阜", "山东省济宁市曲阜市", -1042, -256, {
    note: "鲁国都城曲阜。",
    wikiTitle: "曲阜",
  }),
  e("jin-chunqiu", "绛", "山西省运城市绛县", -1042, -585, {
    note: "晋国初都绛。",
    wikiTitle: "绛县",
  }),
  e("jin-chunqiu", "新绛", "山西省临汾市侯马市", -584, -349, {
    note: "晋景公迁新绛。",
    wikiTitle: "侯马市",
  }),
  e("chu-chunqiu", "丹阳", "河南省南阳市淅川县", -1042, -689, {
    note: "楚国初都丹阳。",
    wikiTitle: "丹阳",
  }),
  e("chu-chunqiu", "郢", "湖北省荆州市江陵区", -688, -278, {
    note: "楚武王后都郢（纪南城）。",
    wikiTitle: "郢",
  }),
  e("chu-chunqiu", "陈", "河南省周口市淮阳区", -277, -241, {
    note: "秦攻郢后楚昭王迁陈。",
    wikiTitle: "淮阳区",
  }),
  e("chu-chunqiu", "寿春", "安徽省淮南市寿县", -240, -223, {
    note: "楚考烈王迁寿春。",
    wikiTitle: "寿县",
  }),
  e("wei-weiguo", "朝歌", "河南省鹤壁市淇县", -1040, -559, {
    note: "卫国初都朝歌。",
    wikiTitle: "朝歌",
  }),
  e("wei-weiguo", "帝丘", "河南省濮阳市", -558, -209, {
    note: "卫懿公后迁都帝丘。",
    wikiTitle: "卫国",
  }),
  e("song-chunqiu", "商丘", "河南省商丘市", -1034, -286, {
    note: "宋国都城商丘。",
    wikiTitle: "商丘",
  }),
  e("zheng-chunqiu", "新郑", "河南省郑州市新郑市", -806, -375, {
    note: "郑国都城新郑。",
    wikiTitle: "新郑市",
  }),

  // 秦（含迁都序列）
  e("qin", "西垂", "甘肃省陇南市礼县", -778, -710, {
    note: "秦非子至秦仲都西垂。",
    wikiTitle: "西垂",
  }),
  e("qin", "汧渭之会", "甘肃省天水市清水县", -709, -677, {
    note: "秦宪公至秦武公居汧渭之会。",
    wikiTitle: "清水县",
  }),
  e("qin", "平阳", "陕西省宝鸡市眉县", -714, -677, {
    note: "秦宪公迁平阳。",
    wikiTitle: "眉县",
  }),
  e("qin", "雍", "陕西省宝鸡市凤翔县", -677, -383, {
    note: "秦德公迁雍，武公后长期为秦都。",
    wikiTitle: "雍城",
  }),
  e("qin", "栎阳", "陕西省西安市阎良区", -424, -351, {
    note: "秦献公迁栎阳。",
    wikiTitle: "栎阳",
  }),
  e("qin", "咸阳", "陕西省咸阳市", -350, -207, {
    note: "秦孝公迁咸阳；统一后仍为京师。",
    wikiTitle: "咸阳",
    id: "cap-qin-xianyang",
  }),

  e("qi-state-chunqiu", "杞", "河南省开封市杞县", -750, -445, {
    note: "杞国都城杞。",
    wikiTitle: "杞国",
  }),
  e("ju-chunqiu", "莒", "山东省日照市莒县", -615, -431, {
    note: "莒国都城莒。",
    wikiTitle: "莒国",
  }),
  e("teng-chunqiu", "滕", "山东省枣庄市滕州市", -599, -296, {
    note: "滕国都城滕。",
    wikiTitle: "滕国",
  }),
  e("wu-chunqiu", "姑苏", "江苏省苏州市", -585, -473, {
    note: "吴国都城姑苏。",
    wikiTitle: "姑苏",
  }),
  e("yue-chunqiu", "会稽", "浙江省绍兴市", -565, -334, {
    note: "越国初都会稽。",
    wikiTitle: "会稽",
  }),
  e("yue-chunqiu", "琅琊", "山东省青岛市黄岛区", -333, -306, {
    note: "越王勾践后迁琅琊。",
    wikiTitle: "琅琊",
  }),
  e("xue-chunqiu", "薛", "山东省枣庄市滕州市", -511, -327, {
    note: "薛国都城薛。",
    wikiTitle: "薛国",
  }),
  e("zhou-guo-west", "王城", "河南省洛阳市", -440, -256, {
    note: "西周国都城王城（洛阳）。",
    wikiTitle: "东周国",
  }),
  e("zhongshan", "灵寿", "河北省石家庄市灵寿县", -424, -296, {
    note: "中山国都城灵寿。",
    wikiTitle: "中山国",
  }),

  // 战国七雄（韩：平阳→新郑，无阳翟）
  e("han-warring", "平阳", "山西省临汾市", -403, -375, {
    note: "战国韩都平阳。",
    wikiTitle: "韩国_(战国)",
  }),
  e("han-warring", "新郑", "河南省郑州市新郑市", -375, -230, {
    note: "韩哀侯迁新郑。",
    wikiTitle: "新郑市",
  }),
  e("zhao-warring", "晋阳", "山西省太原市", -403, -386, {
    note: "赵国初都晋阳。",
    wikiTitle: "晋阳",
  }),
  e("zhao-warring", "邯郸", "河北省邯郸市", -385, -222, {
    note: "赵敬侯迁邯郸。",
    wikiTitle: "邯郸",
  }),
  e("wei-warring", "安邑", "山西省运城市夏县", -403, -361, {
    note: "战国魏初都安邑。",
    wikiTitle: "安邑",
    id: "cap-wei-warring-anyi-2397",
  }),
  e("wei-warring", "大梁", "河南省开封市", -360, -225, {
    note: "魏惠王迁大梁。",
    wikiTitle: "大梁",
  }),
  e("zhou-guo-east", "王城", "河南省洛阳市", -367, -249, {
    note: "东周国都城王城。",
    wikiTitle: "东周国",
  }),

  // ── 西南与战国末小国 ──────────────────────────────────────────────────────
  e("yelang", "夜郎", "贵州省毕节市赫章县", -300, -27, {
    note: "夜郎国都城牂牁江一带，今赫章可乐遗址。",
    wikiTitle: "夜郎",
  }),
  e("dian", "滇池", "云南省昆明市晋宁区", -279, -109, {
    note: "滇国都城滇池（石寨山）。",
    wikiTitle: "滇国",
  }),
  e("dai-warring", "代", "河北省张家口市蔚县", -228, -222, {
    note: "代国都城代。",
    wikiTitle: "代国",
  }),
  e("jiaodong-warring", "即墨", "山东省青岛市即墨区", -221, -206, {
    note: "胶东国都城即墨。",
    wikiTitle: "胶东国",
  }),

  // ── 秦汉之际 ──────────────────────────────────────────────────────────────
  e("chu-west", "彭城", "江苏省徐州市", -206, -202, {
    note: "西楚霸王项羽都彭城。",
    wikiTitle: "彭城",
  }),
  e("nanyue", "番禺", "广东省广州市", -203, -111, {
    note: "南越国都城番禺。",
    wikiTitle: "南越国",
  }),
  e("gaogouli", "国内城", "吉林省通化市集安市", -37, 427, {
    note: "高句丽初都国内城（丸都）。",
    wikiTitle: "高句丽",
  }),
  e("gaogouli", "平壤", "朝鲜民主主义人民共和国平壤市", 428, 668, {
    note: "广开土王迁平壤。",
    wikiTitle: "平壤",
  }),
  e("xin", "长安", "陕西省西安市", 9, 23, {
    note: "王莽新朝都长安。",
    wikiTitle: "新朝",
  }),
  entry("han-west", "长安", "陕西省西安市", -202, 1, 8, 11, {
    note: "刘邦称帝定都长安；王莽代汉，西汉终结。",
    wikiTitle: "长安",
    id: "cap-han-west-changan",
  }),
  e("han-east", "洛阳", "河南省洛阳市", 25, 220, {
    note: "光武帝定都洛阳；献帝禅让曹丕，东汉终结。",
    wikiTitle: "洛阳",
    id: "cap-han-east-luoyang",
  }),
  e("han-gengshi", "长安", "陕西省西安市", 23, 25, {
    note: "更始政权都长安。",
    wikiTitle: "更始政权",
  }),
  e("chimei", "长安", "陕西省西安市", 23, 27, {
    note: "赤眉军据长安。",
    wikiTitle: "赤眉军",
  }),

  // ── 三国 ──────────────────────────────────────────────────────────────────
  e("wei", "洛阳", "河南省洛阳市", 220, 266, {
    note: "曹魏都城洛阳。",
    wikiTitle: "曹魏",
  }),
  e("shu", "成都", "四川省成都市", 221, 263, {
    note: "蜀汉都城成都。",
    wikiTitle: "蜀汉",
  }),
  e("wu", "建业", "江苏省南京市", 222, 280, {
    note: "东吴都城建业。",
    wikiTitle: "东吴",
  }),

  // ── 两晋十六国 ────────────────────────────────────────────────────────────
  e("jin-west", "洛阳", "河南省洛阳市", 266, 316, {
    note: "西晋都城洛阳。",
    wikiTitle: "西晋",
  }),
  e("chouchi", "仇池", "甘肃省陇南市成县", 296, 371, {
    note: "仇池氏据仇池。",
    wikiTitle: "仇池国",
  }),
  e("liang-front", "姑臧", "甘肃省武威市", 301, 376, {
    note: "前凉都城姑臧。",
    wikiTitle: "前凉",
  }),
  e("han-zhao", "长安", "陕西省西安市", 304, 329, {
    note: "前赵（汉赵）都城长安。",
    wikiTitle: "前赵",
  }),
  e("cheng-han", "成都", "四川省成都市", 304, 347, {
    note: "成汉都城成都。",
    wikiTitle: "成汉",
  }),
  e("jin-east", "建康", "江苏省南京市", 317, 420, {
    note: "东晋都城建康。",
    wikiTitle: "东晋",
  }),
  e("zhao-back", "襄国", "河北省邢台市", 319, 335, {
    note: "后赵初都襄国。",
    wikiTitle: "后赵",
  }),
  e("zhao-back", "邺", "河北省邯郸市临漳县", 336, 351, {
    note: "后赵迁邺。",
    wikiTitle: "邺城",
  }),
  e("tuyuhun", "伏俟城", "青海省海南藏族自治州共和县", 329, 663, {
    note: "吐谷浑汗国都城伏俟城（莫贺延碛南）。",
    wikiTitle: "吐谷浑",
  }),
  e("yan-front", "龙城", "辽宁省朝阳市", 337, 347, {
    note: "前燕初都龙城。",
    wikiTitle: "前燕",
  }),
  e("yan-front", "蓟", "北京市", 348, 357, {
    note: "前燕迁都蓟。",
    wikiTitle: "蓟城",
  }),
  e("yan-front", "邺", "河北省邯郸市临漳县", 358, 370, {
    note: "前燕慕容垂迁邺。",
    wikiTitle: "邺城",
  }),
  e("ranwei", "邺", "河北省邯郸市临漳县", 350, 352, {
    note: "冉魏据邺。",
    wikiTitle: "冉魏",
  }),
  e("qin-front", "长安", "陕西省西安市", 351, 394, {
    note: "前秦都城长安。",
    wikiTitle: "前秦",
  }),
  e("xiyan", "长子", "山西省长治市长子县", 384, 394, {
    note: "西燕都城长子。",
    wikiTitle: "西燕",
  }),
  e("yan-back", "中山", "河北省保定市定州市", 384, 397, {
    note: "后燕初都中山。",
    wikiTitle: "后燕",
  }),
  e("yan-back", "龙城", "辽宁省朝阳市", 398, 409, {
    note: "后燕慕容宝迁龙城。",
    wikiTitle: "龙城",
  }),
  e("qin-back", "长安", "陕西省西安市", 384, 417, {
    note: "后秦都城长安。",
    wikiTitle: "后秦",
  }),
  e("qin-xi", "桴罕", "甘肃省临夏回族自治州临夏市", 385, 431, {
    note: "西秦都城桴罕。",
    wikiTitle: "西秦",
  }),
  e("liang-back", "姑臧", "甘肃省武威市", 386, 403, {
    note: "后凉都城姑臧。",
    wikiTitle: "后凉",
  }),
  e("wei-north", "盛乐", "内蒙古自治区呼和浩特市和林格尔县", 386, 398, {
    note: "北魏初都盛乐。",
    wikiTitle: "盛乐",
  }),
  e("wei-north", "平城", "山西省大同市", 398, 493, {
    note: "北魏迁都平城。",
    wikiTitle: "平城",
  }),
  e("wei-north", "洛阳", "河南省洛阳市", 494, 535, {
    note: "孝文帝迁洛阳。",
    wikiTitle: "北魏",
  }),
  e("liang-south", "姑臧", "甘肃省武威市", 397, 404, {
    note: "南凉初都姑臧。",
    wikiTitle: "南凉",
  }),
  e("liang-south", "乐都", "青海省海东市乐都区", 405, 414, {
    note: "南凉迁都乐都。",
    wikiTitle: "乐都区",
  }),
  e("liang-north", "张掖", "甘肃省张掖市", 397, 439, {
    note: "北凉都城张掖→姑臧。",
    wikiTitle: "北凉",
  }),
  e("yan-south", "广固", "山东省潍坊市青州市", 398, 410, {
    note: "南燕都城广固。",
    wikiTitle: "南燕",
  }),
  e("liang-xi", "酒泉", "甘肃省酒泉市", 400, 421, {
    note: "西凉都城酒泉→敦煌。",
    wikiTitle: "西凉",
  }),
  e("xia-hu", "统万城", "陕西省榆林市靖边县", 407, 431, {
    note: "胡夏都城统万城。",
    wikiTitle: "统万城",
  }),
  e("yan-north", "龙城", "辽宁省朝阳市", 407, 436, {
    note: "北燕都城龙城。",
    wikiTitle: "北燕",
  }),

  // ── 南北朝 ────────────────────────────────────────────────────────────────
  e("song-liu", "建康", "江苏省南京市", 420, 479, {
    note: "刘宋都城建康。",
    wikiTitle: "刘宋",
  }),
  e("qi-nan", "建康", "江苏省南京市", 479, 502, {
    note: "南齐都城建康。",
    wikiTitle: "南齐",
  }),
  e("liang-nan", "建康", "江苏省南京市", 502, 557, {
    note: "南梁都城建康。",
    wikiTitle: "南梁",
  }),
  e("wei-east", "邺", "河北省邯郸市临漳县", 534, 550, {
    note: "东魏都城邺。",
    wikiTitle: "东魏",
  }),
  e("wei-west", "长安", "陕西省西安市", 535, 557, {
    note: "西魏都城长安。",
    wikiTitle: "西魏",
  }),
  e("qi-bei", "邺", "河北省邯郸市临漳县", 550, 577, {
    note: "北齐都城邺。",
    wikiTitle: "北齐",
  }),
  e("xiliang", "江陵", "湖北省荆州市", 555, 587, {
    note: "西梁（萧梁）都城江陵。",
    wikiTitle: "西梁",
  }),
  e("chen-nan", "建康", "江苏省南京市", 557, 589, {
    note: "南陈都城建康。",
    wikiTitle: "南陈",
  }),
  e("zhou-bei", "长安", "陕西省西安市", 557, 581, {
    note: "北周都城长安。",
    wikiTitle: "北周",
  }),

  // ── 隋唐 ──────────────────────────────────────────────────────────────────
  e("sui", "大兴城", "陕西省西安市", 581, 618, {
    note: "隋都大兴城（长安）。",
    wikiTitle: "大兴城",
  }),
  e("tang", "长安", "陕西省西安市", 618, 903, {
    note: "唐都长安。",
    wikiTitle: "长安",
    id: "cap-tang-changan",
  }),
  e("tang", "洛阳", "河南省洛阳市", 657, 903, {
    role: "secondary",
    note: "唐东都洛阳。",
    wikiTitle: "洛阳",
    id: "cap-tang-luoyang",
  }),
  e("tang", "洛阳", "河南省洛阳市", 904, 907, {
    note: "904年朱全忠逼唐昭宗迁都洛阳；李柷（唐哀帝）继位后至907年唐亡，洛阳为唐正都。",
    wikiTitle: "唐哀帝",
    id: "cap-tang-luoyang-904",
  }),

  // ── 边疆政权 ──────────────────────────────────────────────────────────────
  e("tubo", "逻些", "西藏自治区拉萨市", 618, 842, {
    note: "吐蕃都城逻些（拉萨）。",
    wikiTitle: "吐蕃",
  }),
  e("nanzhao", "太和城", "云南省大理白族自治州巍山彝族回族自治县", 739, 779, {
    note: "南诏前期都城太和城（巍山）；779年迁都羊苴咩城。",
    wikiTitle: "南诏",
    id: "cap-nanzhao-taihecheng-739",
  }),
  e("nanzhao", "羊苴咩城", "云南省大理白族自治州大理市", 779, 902, {
    note: "南诏779年迁都羊苴咩城（又作阳苴咩城、苴咩城）。",
    wikiTitle: "阳苴咩城",
    id: "cap-nanzhao-yangjumei-779",
  }),
  e("zhou-wu", "神都", "河南省洛阳市", 690, 705, {
    note: "武周以洛阳为神都。",
    wikiTitle: "武周",
  }),
  e("huihu", "回鹘牙帐", "蒙古国前杭爱省哈拉和林苏木", 744, 840, {
    note: "回鹘汗国牙帐，漠北草原都城。",
    wikiTitle: "回鹘",
    id: "cap-huihu-yahzhang-8928",
  }),

  // ── 五代十国 ──────────────────────────────────────────────────────────────
  e("wu-shi", "广陵", "江苏省扬州市", 902, 937, {
    note: "杨吴都广陵（今扬州），治所为江都府；不是吴越杭州。",
    wikiTitle: "杨吴",
    id: "cap-wu-shi-hangzhou-902",
  }),
  e("liang-hou", "汴州", "河南省开封市", 907, 923, {
    note: "朱温建后梁，都汴；汴州升为东京开封府。",
    wikiTitle: "后梁",
    id: "cap-liang-hou-kaifeng-907",
  }),
  e("chu-nan", "长沙", "湖南省长沙市", 907, 951, {
    note: "楚国都城长沙。",
    wikiTitle: "楚国_(十国)",
    id: "cap-chu-nan-changsha-10884",
  }),
  e("shu-qian", "成都", "四川省成都市", 907, 925, {
    note: "前蜀都城成都。",
    wikiTitle: "前蜀",
  }),
  e("wuyue", "杭州", "浙江省杭州市", 907, 978, {
    note: "吴越都城杭州。",
    wikiTitle: "吴越国",
  }),
  e("min-fujian", "长乐府", "福建省福州市", 909, 945, {
    note: "闽国都福州；933年升为长乐府。",
    wikiTitle: "闽国",
    id: "cap-min-fujian-fuzhou-909",
  }),
  e("han-nan", "兴王府", "广东省广州市", 917, 971, {
    note: "南汉都兴王府（今广州）；971年宋灭南汉后复称广州。",
    wikiTitle: "兴王府 (南汉)",
    id: "cap-han-nan-guangzhou-11004",
  }),
  e("tang-hou", "洛阳", "河南省洛阳市", 923, 936, {
    note: "后唐都城洛阳。",
    wikiTitle: "后唐",
  }),
  e("jingnan", "江陵", "湖北省荆州市", 924, 963, {
    note: "荆南都城江陵。",
    wikiTitle: "荆南",
  }),
  e("shu-hou", "成都", "四川省成都市", 934, 965, {
    note: "后蜀都城成都。",
    wikiTitle: "后蜀",
  }),
  e("jin-hou", "汴州", "河南省开封市", 936, 947, {
    note: "后晋936年自洛阳迁都汴州（东京开封府）；太原为其兴王之地，不是国都。",
    wikiTitle: "后晋",
    id: "cap-jin-hou-taiyuan-936",
  }),
  e("tang-nan", "金陵", "江苏省南京市", 937, 975, {
    note: "南唐都城金陵。",
    wikiTitle: "南唐",
  }),
  e("dali", "羊苴咩城", "云南省大理白族自治州大理市", 937, 1253, {
    note: "大理国都羊苴咩城（又作阳苴咩城、苴咩城）。",
    wikiTitle: "阳苴咩城",
    id: "cap-dali-taihecheng-11244",
  }),
  e("han-hou", "汴州", "河南省开封市", 947, 951, {
    note: "后汉都汴州（东京开封府）。",
    wikiTitle: "后汉",
    id: "cap-han-hou-kaifeng-947",
  }),
  e("han-bei", "太原", "山西省太原市", 951, 979, {
    note: "北汉都城太原。",
    wikiTitle: "北汉",
  }),
  e("zhou-hou", "汴州", "河南省开封市", 951, 960, {
    note: "后周都汴州（东京开封府）。",
    wikiTitle: "后周",
    id: "cap-zhou-hou-kaifeng-951",
  }),

  // ── 宋辽金夏 ──────────────────────────────────────────────────────────────
  e("song-north", "汴京", "河南省开封市", 960, 1127, {
    note: "北宋都城汴京（开封）。",
    wikiTitle: "汴京",
    id: "cap-song-north-bianjing",
  }),
  e("xixia", "兴庆府", "宁夏回族自治区银川市", 982, 1227, {
    note: "西夏都城兴庆府。",
    wikiTitle: "兴庆府",
  }),
  e("liao", "上京临潢府", "内蒙古自治区赤峰市巴林左旗", 916, 1125, {
    note: "辽上京临潢府。",
    wikiTitle: "上京临潢府",
  }),
  e("liao", "南京析津府", "北京市", 938, 1125, {
    role: "secondary",
    note: "辽南京（析津府，今北京）。",
    wikiTitle: "南京_(辽朝)",
    id: "cap-liao-南京-938",
  }),
  e("jin-nvzhen", "会宁府", "黑龙江省哈尔滨市阿城区", 1115, 1153, {
    note: "金初都会宁府。",
    wikiTitle: "会宁府",
  }),
  e("jin-nvzhen", "中都", "北京市", 1154, 1214, {
    note: "金迁都中都（今北京）。",
    wikiTitle: "金中都",
  }),
  e("jin-nvzhen", "汴京", "河南省开封市", 1215, 1234, {
    note: "金末迁都汴京。",
    wikiTitle: "汴京",
  }),
  e("beiliao", "临潢府", "内蒙古自治区赤峰市巴林左旗", 1122, 1123, {
    note: "北辽据辽上京临潢府。",
    wikiTitle: "北辽",
    id: "cap-beiliao-linhuang-13464",
  }),
  e("xiliao", "虎思斡耳朵", "吉尔吉斯斯坦楚河州托克马克市", 1124, 1218, {
    note: "西辽都城虎思斡耳朵（今托克马克附近）。",
    wikiTitle: "西辽",
    id: "cap-xiliao-husi-13476",
  }),
  e("song-south", "应天府", "河南省商丘市", 1127, 1129, {
    role: "temporary",
    note: "南宋初暂都应天府。",
    wikiTitle: "应天府",
    id: "cap-song-south-yingtian",
  }),
  e("song-south", "临安", "浙江省杭州市", 1130, 1279, {
    note: "南宋行在临安。",
    wikiTitle: "临安",
    id: "cap-song-south-linan",
  }),

  // ── 蒙元明初群雄 ──────────────────────────────────────────────────────────
  e("mongol-empire", "哈拉和林", "蒙古国前杭爱省哈拉和林苏木", 1206, 1271, {
    note: "蒙古帝国汗庭哈拉和林。",
    wikiTitle: "哈拉和林",
  }),
  e("dongliao", "开原", "辽宁省铁岭市开原市", 1213, 1269, {
    note: "东辽都城开原。",
    wikiTitle: "东辽",
    id: "cap-dongliao-kaiyuan-14556",
  }),
  e("yuan", "开平", "内蒙古自治区锡林郭勒盟正蓝旗", 1271, 1273, {
    note: "元初开平（上都前身）。",
    wikiTitle: "开平",
    id: "cap-yuan-kaiping-15252",
  }),
  entry("yuan", "上都", "内蒙古自治区锡林郭勒盟正蓝旗", 1260, 1, 1368, 12, {
    role: "secondary",
    note: "元上都（开平）。",
    wikiTitle: "元上都",
    id: "cap-yuan-shangdu-15120",
  }),
  e("yuan", "中都", "北京市", 1264, 1271, {
    note: "元中都（大都前身）。",
    wikiTitle: "元中都",
    id: "cap-yuan-zhongdu-15168",
  }),
  e("yuan", "大都", "北京市", 1272, 1368, {
    note: "元大都（今北京）。",
    wikiTitle: "大都",
    id: "cap-yuan-dadu",
  }),
  e("song-xu", "安丰", "安徽省淮南市寿县", 1351, 1360, {
    note: "徐寿辉天完政权都安丰。",
    wikiTitle: "徐寿辉",
    id: "cap-song-xu-anfeng-16212",
  }),
  e("zhou-zhang", "滁州", "安徽省滁州市", 1354, 1367, {
    note: "张士诚大周政权据滁州→高邮。",
    wikiTitle: "张士诚",
    id: "cap-zhou-zhang-chuzhou-16248",
  }),
  e("song-han", "沔阳", "湖北省仙桃市", 1355, 1366, {
    note: "陈友谅汉政权初都沔阳。",
    wikiTitle: "陈友谅",
    id: "cap-song-han-mianyang-16260",
  }),
  e("chen-han", "武昌", "湖北省武汉市", 1360, 1364, {
    note: "陈友谅迁都武昌。",
    wikiTitle: "陈友谅",
  }),
  e("xia-ming", "重庆", "重庆市", 1362, 1371, {
    note: "明玉珍大夏都城重庆。",
    wikiTitle: "明玉珍",
  }),
  e("wu-zhu", "应天", "江苏省南京市", 1364, 1368, {
    note: "朱元璋吴国都城应天。",
    wikiTitle: "朱元璋",
  }),

  // ── 明清民国 ──────────────────────────────────────────────────────────────
  e("ming", "应天", "江苏省南京市", 1368, 1420, {
    note: "明初都应天府。",
    wikiTitle: "南京",
    id: "cap-ming-nanjing",
  }),
  entry("ming", "顺天", "北京市", 1421, 1, 1644, 4, {
    note: "永乐迁都顺天府。",
    wikiTitle: "北京",
    id: "cap-ming-beijing",
  }),
  entry("qing", "盛京", "辽宁省沈阳市", 1636, 1, 1644, 4, {
    role: "secondary",
    note: "清定都盛京后入关。",
    wikiTitle: "沈阳",
    id: "cap-qing-shengjing",
  }),
  entry("qing", "顺天", "北京市", 1644, 5, 1912, 2, {
    note: "清入关后都北京。",
    wikiTitle: "北京",
    id: "cap-qing-beijing",
  }),
  e("ming-south", "应天", "江苏省南京市", 1644, 1645, {
    note: "弘光政权都南京。",
    wikiTitle: "南明",
  }),
  e("ming-south", "福州", "福建省福州市", 1645, 1646, {
    note: "隆武政权都福州。",
    wikiTitle: "南明",
  }),
  e("ming-south", "广州", "广东省广州市", 1646, 1647, {
    note: "绍武政权都广州。",
    wikiTitle: "南明",
  }),
  e("ming-south", "肇庆", "广东省肇庆市", 1646, 1647, {
    note: "永历帝于肇庆登基。",
    wikiTitle: "南明",
    id: "cap-ming-south-zhaoqing-1646",
  }),
  e("ming-south", "桂林", "广西壮族自治区桂林市", 1647, 1649, {
    note: "绍武败后永历退守广西。",
    wikiTitle: "南明",
    id: "cap-ming-south-guilin-1647",
  }),
  e("ming-south", "南宁", "广西壮族自治区南宁市", 1649, 1651, {
    note: "永历驻南宁，入黔前倚仗孙可望。",
    wikiTitle: "南明",
  }),
  e("ming-south", "安龙", "贵州省黔西南布依族苗族自治州安龙县", 1651, 1656, {
    note: "孙可望安置永历于安龙府。",
    wikiTitle: "南明",
  }),
  e("ming-south", "昆明", "云南省昆明市", 1656, 1659, {
    note: "李定国迎驾入滇；1659年后流亡缅甸，1662年遇害于昆明。",
    wikiTitle: "南明",
  }),
  e("dashun", "西安", "陕西省西安市", 1644, 1644, {
    note: "大顺政权初据西安。",
    wikiTitle: "大顺",
    id: "cap-dashun-xian-19728",
  }),
  e("dashun", "北京", "北京市", 1644, 1645, {
    note: "李自成入京。",
    wikiTitle: "大顺",
    id: "cap-dashun-beijing-19728",
  }),
  e("daxi", "西京", "四川省成都市", 1644, 1646, {
    note: "大西以成都为西京。",
    wikiTitle: "大西",
    id: "cap-daxi-chengdu-1644",
  }),
  e("daxi", "西充", "四川省南充市西充县", 1646, 1647, {
    note: "张献忠迁西充。",
    wikiTitle: "大西",
  }),
  e("mingzheng", "东宁", "台湾省台南市", 1661, 1683, {
    note: "明郑东宁王国都东宁（今台南）。",
    wikiTitle: "明郑",
    id: "cap-mingzheng-dongning-19932",
  }),
  e("taiping", "天京", "江苏省南京市", 1853, 1864, {
    note: "太平天国天京（南京）。",
    wikiTitle: "天京",
  }),
  entry("roc", "南京", "江苏省南京市", 1912, 1, 1937, 11, {
    note: "民国初都南京。",
    wikiTitle: "中华民国",
  }),
  entry("roc", "重庆", "重庆市", 1937, 11, 1946, 5, {
    role: "temporary",
    note: "抗战陪都重庆。",
    wikiTitle: "重庆陪都",
  }),
  entry("roc", "南京", "江苏省南京市", 1946, 5, 1949, 4, {
    note: "抗战后还都南京。",
    wikiTitle: "中华民国",
    id: "cap-roc-nanjing-23348",
  }),
  entry("prc", "北京", "北京市", 1949, 10, 2026, 12, {
    note: "中华人民共和国首都北京。",
    wikiTitle: "北京市",
  }),
];

// ── Validation ──────────────────────────────────────────────────────────────
const EXPECTED_DYNASTY_IDS = [
  "san-huang", "wu-di", "xia", "shang", "zhou-west", "zhou-east",
  "cao-chunqiu", "qi-chunqiu", "yan-chunqiu", "lu-chunqiu", "jin-chunqiu", "chu-chunqiu",
  "wei-weiguo", "song-chunqiu", "zheng-chunqiu", "qin", "qi-state-chunqiu", "ju-chunqiu",
  "teng-chunqiu", "wu-chunqiu", "yue-chunqiu", "xue-chunqiu", "zhou-guo-west", "zhongshan",
  "han-warring", "zhao-warring", "wei-warring", "zhou-guo-east", "yelang", "dian",
  "dai-warring", "jiaodong-warring", "chu-west", "nanyue", "gaogouli", "xin", "han-west",
  "han-east", "han-gengshi",
  "chimei", "wei", "shu", "wu", "jin-west", "chouchi", "liang-front", "han-zhao", "cheng-han",
  "jin-east", "zhao-back", "tuyuhun", "yan-front", "ranwei", "qin-front", "xiyan", "yan-back",
  "qin-back", "qin-xi", "liang-back", "wei-north", "liang-south", "liang-north", "yan-south",
  "liang-xi", "xia-hu", "yan-north", "song-liu", "qi-nan", "liang-nan", "wei-east", "wei-west",
  "qi-bei", "xiliang", "chen-nan", "zhou-bei", "sui", "tang", "tubo", "nanzhao", "zhou-wu",
  "huihu", "wu-shi", "liang-hou", "chu-nan", "shu-qian", "wuyue", "min-fujian", "liao",
  "han-nan", "tang-hou", "jingnan", "shu-hou", "jin-hou", "tang-nan", "dali", "han-hou",
  "han-bei", "zhou-hou", "song-north", "xixia", "jin-nvzhen", "beiliao", "xiliao", "song-south",
  "mongol-empire", "dongliao", "yuan", "song-xu", "zhou-zhang", "song-han", "chen-han",
  "xia-ming", "wu-zhu", "ming", "qing", "ming-south", "dashun", "daxi", "mingzheng", "taiping",
  "roc", "prc",
];

const covered = new Set(capitals.map((c) => c.dynastyId));
const missing = EXPECTED_DYNASTY_IDS.filter((id) => !covered.has(id));
if (missing.length) {
  console.error(`[compile-capitals-data] Missing dynasty IDs: ${missing.join(", ")}`);
  process.exit(1);
}

const outPath = path.join(__dirname, "capitals-raw.json");
writeFileSync(outPath, `${JSON.stringify(capitals, null, 2)}\n`);
console.log(`[compile-capitals-data] Wrote ${capitals.length} capitals for ${covered.size} dynasties → ${outPath}`);
