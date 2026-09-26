#!/usr/bin/env node
/**
 * Compile dynasty capital research data → capitals-raw.json (no coordinates).
 * Sources: 维基百科各政权/都城条目，正史年表，EraLens 王朝起迄窗口。
 */
import { writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { absMonth, wiki, ym } from "../lib/sqlHelpers.mjs";
import { ymDay } from "../lib/reignDateHelpers.mjs";

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
  成周: "chengzhou",
  巩: "gong",
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
 * @param {{ role?: string, note?: string, wikiTitle?: string, id?: string, precision?: "year"|"month"|"day", endPrecision?: "year"|"month"|"day", startDay?: number, endDay?: number, claimTrack?: string }} [opts]
 */
export function entry(
  dynastyId,
  historicalName,
  modernName,
  startYear,
  startMonth = 1,
  endYear,
  endMonth = 12,
  {
    role = "primary",
    note,
    wikiTitle,
    id,
    precision = "year",
    endPrecision,
    startDay,
    endDay,
    claimTrack,
    startDateConfidence,
    endDateConfidence,
    links,
  } = {},
) {
  const start = startDay == null ? ym(startYear, startMonth) : ymDay(startYear, startMonth, startDay);
  const end = endDay == null ? ym(endYear, endMonth) : ymDay(endYear, endMonth, endDay);
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
    precision,
    endPrecision,
    startDateConfidence,
    endDateConfidence,
    role,
    claimTrack,
    note,
    links: links ?? (wikiTitle ? wiki(wikiTitle) : []),
  };
}

/** Shorthand: year-precision (month 1 → 12). */
const e = (dynastyId, historicalName, modernName, startYear, endYear, opts) =>
  entry(dynastyId, historicalName, modernName, startYear, 1, endYear, 12, opts);

export const capitals = [
  entry("zou-state", "绎（邾国故城）", "山东省济宁市邹城市峄山镇邾国故城遗址", -614, 1, -256, 12, {
    note: "邾文公于鲁文公十三年（前614）卜迁于绎，遗址位于今邹城市峄山南麓；仅覆盖有明确迁都年代的阶段。",
    id: "cap-zou-state-yi-614",
    links: [
      { label: "济宁市文化和旅游局：邾国故城", url: "https://whlyj.jining.gov.cn/art/2019/9/10/art_32544_1707935.html" },
      { label: "中国社会科学网：邾国故城遗址田野考古取得重大进展", url: "https://www.cssn.cn/dfpd/djbd/202506/t20250619_5880249.shtml" },
    ],
  }),
  entry("xu", "魏县", "河北省邯郸市大名县魏城村旧魏县城", 618, 1, 619, 12, {
    note: "宇文化及兵败后退至魏县并在此称帝建立许政权。现址采用今大名县魏城村旧魏县治定位；起讫仅按年精度记载。",
    id: "cap-xu-weixian-618",
    links: [
      { label: "刘卫民：魏县治邑新考", url: "https://m.thepaper.cn/newsDetail_forward_2333423" },
      { label: "《隋唐之际割据政权之一：许国》", url: "https://bkso.baidu.com/item/%E8%AE%B8%E5%9B%BD/9990400" },
    ],
  }),
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

  e("zhou-east", "王城", "河南省洛阳市西工区东周王城遗址", -770, -520, {
    note: "平王东迁后都王城；今址为洛阳市西工区东周王城遗址。",
    wikiTitle: "东周王城",
  }),
  e("zhou-east", "成周", "河南省洛阳市瀍河回族区汉魏洛阳故城成周遗址", -519, -315, {
    note: "周敬王迁都成周，至赧王迁回王城；今址在白马寺以东汉魏洛阳故城一带。",
    endDateConfidence: "approximate",
    wikiTitle: "成周",
  }),
  e("zhou-east", "王城", "河南省洛阳市西工区东周王城遗址", -314, -256, {
    note: "周赧王时期迁居西周国王城，具体年份未详；前314年仅作约年起点。今址为洛阳市西工区东周王城遗址。",
    startDateConfidence: "approximate",
    wikiTitle: "东周王城",
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
  e("qin", "西垂", "甘肃省陇南市礼县", -778, -763, {
    note: "秦非子至秦文公初年都西垂；前763年秦文公东迁。",
    wikiTitle: "西垂",
  }),
  e("qin", "汧渭之会", "陕西省宝鸡市陈仓区", -762, -714, {
    note: "秦文公四年营建汧渭之会；秦宪公二年（前714）迁都平阳。今址据考古与通行地理考证在宝鸡陈仓一带。",
    wikiTitle: "汧渭之会",
  }),
  e("qin", "平阳", "陕西省宝鸡市岐山县", -714, -677, {
    note: "前714年秦宪公自汧渭之会迁都平阳；故址一说在今岐山县西南，一说在陈仓区东南阳平。此处采用岐山县行政区作为地图定位。",
    wikiTitle: "平阳城",
  }),
  e("qin", "雍", "陕西省宝鸡市凤翔县", -677, -383, {
    note: "秦德公迁雍，武公后长期为秦都。",
    wikiTitle: "雍城",
  }),
  e("qin", "栎阳", "陕西省西安市阎良区", -383, -350, {
    note: "前383年秦献公迁都栎阳；前350年秦孝公迁都咸阳。",
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
  e("teng-chunqiu", "滕", "山东省枣庄市滕州市姜屯镇滕国故城遗址", -599, -296, {
    note: "滕国都城滕。",
    wikiTitle: "滕国",
  }),
  e("wu-chunqiu", "姑苏", "江苏省苏州市", -585, -473, {
    note: "吴国都城姑苏。",
    wikiTitle: "姑苏",
  }),
  e("yue-chunqiu", "会稽", "浙江省绍兴市", -565, -469, {
    note: "越国初都会稽；勾践时期迁都琅琊前，会稽为都。",
    wikiTitle: "会稽",
  }),
  e("yue-chunqiu", "琅琊", "山东省青岛市黄岛区", -468, -380, {
    note: "越王勾践灭吴后迁都琅琊；翳于前379年迁都姑苏。",
    wikiTitle: "琅琊",
  }),
  e("yue-chunqiu", "姑苏", "江苏省苏州市", -379, -361, {
    note: "越王翳于前379年迁都姑苏；无颛于前360年迁回会稽。",
    wikiTitle: "姑苏",
  }),
  e("yue-chunqiu", "会稽", "浙江省绍兴市", -360, -306, {
    note: "越王无颛迁回会稽；越国亡于前306年。",
    wikiTitle: "会稽",
  }),
  e("xue-chunqiu", "薛", "山东省枣庄市滕州市官桥镇薛国故城遗址", -511, -327, {
    note: "薛国都城薛。",
    wikiTitle: "薛国",
  }),
  e("zhou-guo-west", "王城", "河南省洛阳市西工区东周王城遗址", -440, -256, {
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
  e("zhou-guo-east", "巩", "河南省郑州市巩义市康店镇康北村东周故城遗址", -367, -249, {
    note: "东周国始封于巩；今址为巩义市康店镇康北村东周故城遗址。",
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
  entry("han-west", "长安", "陕西省西安市", -202, 1, 9, 1, {
    note: "刘邦称帝定都长安；9年1月10日王莽代汉，西汉终结。",
    wikiTitle: "长安",
    id: "cap-han-west-changan",
  }),
  entry("han-east", "洛阳", "河南省洛阳市", 25, 10, 220, 12, {
    precision: "month",
    note: "建武元年冬十月，光武帝入洛阳并定都；献帝禅让曹丕，东汉终结。",
    wikiTitle: "洛阳",
    id: "cap-han-east-luoyang",
  }),
  entry("han-gengshi", "宛", "河南省南阳市", 23, 6, 24, 2, {
    precision: "month",
    note: "更始元年六月刘玄入都宛城；更始二年二月迁都长安。",
    wikiTitle: "更始帝",
    id: "cap-han-gengshi-wan-23",
  }),
  entry("han-gengshi", "长安", "陕西省西安市", 24, 2, 25, 9, {
    precision: "month",
    note: "更始二年二月刘玄自洛阳迁都长安；更始三年九月赤眉军攻入长安后政权终结。",
    wikiTitle: "更始帝",
    id: "cap-han-gengshi-changan-24",
  }),
  entry("chimei", "长安", "陕西省西安市", 25, 9, 26, 12, {
    note: "赤眉军于25年六月拥立刘盆子，九月攻入长安；26年春退出、秋复入，岁末东撤，长安为其间歇性据点。",
    wikiTitle: "赤眉军",
    id: "cap-chimei-changan-25",
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
  entry("song-liu", "建康", "江苏省南京市", 420, 7, 479, 5, {
    precision: "month",
    note: "420年七月刘裕受禅建立刘宋，定都建康；479年五月萧道成代宋。",
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
  entry("han-houjing", "建康", "江苏省南京市", 552, 1, 552, 5, {
    precision: "month",
    note: "侯景称汉帝期间都城建康；552年五月败亡。",
    wikiTitle: "侯景",
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
  e("sui", "长安", "陕西省西安市", 581, 582, {
    note: "581年杨坚受禅建立隋朝，沿用北周旧都长安；583年迁入新建的大兴城。",
    wikiTitle: "唐长安城",
    id: "cap-sui-changan-581",
  }),
  entry("sui", "大兴城", "陕西省西安市", 583, 1, 618, 4, {
    endPrecision: "day",
    endDay: 11,
    note: "开皇三年（583）隋文帝由旧长安城迁入新都大兴城；本记录按618年4月11日江都兵变后的隋主交界结束。",
    wikiTitle: "大兴城",
    id: "cap-sui-daxing-583",
  }),
  entry("sui", "长安", "陕西省西安市", 618, 4, 618, 6, {
    startDay: 12,
    precision: "day",
    endPrecision: "month",
    claimTrack: "changan",
    note: "杨侑在长安的并立阶段：江都兵变后继续在长安，618年六月禅位。杨侑禅位公历换算有6月12日、6月18日等异说，故终点保留六月精度。",
    wikiTitle: "杨侑",
    id: "cap-sui-changan-618",
  }),
  entry("sui", "东都洛阳", "河南省洛阳市", 618, 6, 619, 5, {
    startDay: 22,
    endDay: 23,
    precision: "day",
    endPrecision: "day",
    claimTrack: "luoyang",
    note: "洛阳留守官于618年6月22日拥立杨侗，至619年5月23日禅位；作为杨侗并立在位期间的都城记录。",
    wikiTitle: "杨侗",
    id: "cap-sui-luoyang-618",
  }),
  entry("sui", "江都", "江苏省扬州市", 618, 4, 618, 10, {
    startDay: 12,
    endDay: 23,
    precision: "day",
    endPrecision: "day",
    note: "杨广于618年4月11日在江都被弑；江都自次日（4月12日）起计为杨浩时期都城，至10月23日杨浩被杀。",
    wikiTitle: "隋朝",
    id: "cap-sui-jiangdu-618",
  }),
  e("xia-dou-jiande", "乐寿（金城宫）", "河北省沧州市献县", 618, 619, {
    note: "窦建德政权初都乐寿，称金城宫；武德二年（619）迁都洺州。年精度记录覆盖迁都年。",
    links: [
      { label: "德州地方志：窦建德", url: "https://dzdywhyjzx.dzu.edu.cn/__local/A/B3/89/AF0F895C2359E0209700DEC01EB_4E11A195_227030.pdf" },
    ],
    id: "cap-xia-dou-jiande-leshou-618",
  }),
  e("xia-dou-jiande", "洺州（万春宫）", "河北省邯郸市永年区广府古城", 619, 621, {
    note: "武德二年（619）窦建德迁都洺州，筑万春宫；年精度区间与乐寿在迁都年重叠。",
    links: [
      { label: "《资治通鉴》卷188", url: "https://zh.wikisource.org/zh-hant/資治通鑑/卷188" },
      { label: "高德地图：广府古城坐标", url: "https://www.amap.com/place/B013600EA5" },
    ],
    id: "cap-xia-dou-jiande-mingzhou-619",
  }),
  e("zheng", "洛阳", "河南省洛阳市", 619, 621, {
    note: "王世充于619年在洛阳建郑称帝，621年降唐；按政权存续年份记录。",
    links: [
      { label: "洛阳历史（含郑都洛阳条目）", url: "https://zh.wikipedia.org/wiki/洛阳历史" },
      { label: "《新唐书·王世充传》", url: "https://zh.wikisource.org/zh-hans/新唐書/卷085" },
    ],
    id: "cap-zheng-luoyang-619",
  }),
  entry("tang", "长安", "陕西省西安市", 618, 6, 903, 12, {
    precision: "month",
    note: "618年六月李渊受隋恭帝杨侑禅让，在长安即皇帝位建立唐朝；903年末前唐都长安。",
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
  entry("chu-nan", "长沙", "湖南省长沙市", 907, 6, 951, 12, {
    precision: "month",
    note: "907年六月马殷受封楚王，以潭州为都；951年十二月楚亡。",
    wikiTitle: "楚国_(十国)",
    id: "cap-chu-nan-changsha-10884",
  }),
  entry("shu-qian", "成都", "四川省成都市", 907, 9, 925, 12, {
    precision: "month",
    note: "907年九月王建在成都称帝建立前蜀；925年后唐灭前蜀。",
    wikiTitle: "前蜀",
  }),
  entry("wuyue", "杭州", "浙江省杭州市", 907, 6, 978, 6, {
    precision: "month",
    note: "907年六月钱镠受后梁封为吴越王，史家以此为吴越国之始；978年六月钱俶纳土归宋。",
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
  entry("song-south", "临安", "浙江省杭州市", 1130, 1, 1276, 2, {
    precision: "year",
    endPrecision: "day",
    endDay: 4,
    note: "南宋行在临安。德祐二年正月十八日（1276年2月4日），宋廷奉传国玺降元，临安不再由南宋朝廷控制。",
    wikiTitle: "临安",
    id: "cap-song-south-linan",
  }),
  entry("song-south", "福安府", "福建省福州市", 1276, 6, 1276, 12, {
    role: "temporary",
    precision: "day",
    startDay: 14,
    endDay: 21,
    endPrecision: "day",
    note: "德祐二年五月初一（1276年6月14日）端宗在福州即位，升福州为福安府并定为行都；景炎元年十一月十五日（1276年12月21日）宋廷撤离福州。此后海上行朝辗转流动，无固定都城。",
    wikiTitle: "福安府",
    id: "cap-song-south-fuan-1276",
    links: [
      { label: "福州市档案信息网：再说帝封江的来历", url: "https://daj.fuzhou.gov.cn/zz/wszt/tslm/msfq/202104/t20210401_4066868.htm" },
    ],
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
  entry("song-xu", "蕲水", "湖北省黄冈市浠水县", 1351, 10, 1356, 1, {
    note: "至正十一年十月徐寿辉据蕲水称帝，以蕲水为都；1356年初迁都汉阳。",
    wikiTitle: "宋 (徐寿辉)",
    id: "cap-song-xu-qishui-1351",
    precision: "month",
  }),
  entry("song-xu", "汉阳", "湖北省武汉市汉阳区", 1356, 1, 1359, 12, {
    note: "1356年初徐宋迁都汉阳；1359年末受陈友谅挟持迁江州。",
    wikiTitle: "宋 (徐寿辉)",
    id: "cap-song-xu-hanyang-1356",
    precision: "month",
  }),
  entry("zhou-zhang", "高邮", "江苏省扬州市高邮市", 1354, 1, 1356, 2, {
    note: "1354年张士诚在高邮建大周、称诚王；1356年迁都平江。",
    wikiTitle: "张士诚",
    id: "cap-zhou-zhang-gaoyou-1354",
    precision: "month",
  }),
  entry("zhou-zhang", "平江", "江苏省苏州市", 1356, 3, 1367, 9, {
    note: "1356年三月张士诚据平江并迁都，改平江路为隆平府；1367年平江城破。",
    wikiTitle: "张士诚",
    id: "cap-zhou-zhang-pingjiang-1356",
    precision: "month",
  }),
  entry("song-han", "亳州", "安徽省亳州市", 1355, 2, 1356, 12, {
    note: "1355年二月刘福通拥立韩林儿于亳州，韩宋以亳州为都；1356年底亳州陷落。",
    wikiTitle: "宋 (韩林儿)",
    id: "cap-song-han-bozhou-1355",
    precision: "month",
  }),
  entry("song-han", "汴梁", "河南省开封市", 1358, 5, 1359, 8, {
    note: "1358年韩宋攻占汴梁并迁都；1359年八月城破，退守安丰。",
    wikiTitle: "宋 (韩林儿)",
    id: "cap-song-han-bianliang-1358",
    precision: "month",
  }),
  entry("song-han", "安丰", "安徽省淮南市寿县", 1359, 8, 1363, 2, {
    note: "1359年八月汴梁失守后韩林儿退守安丰；1363年张士诚围攻安丰，韩林儿被朱元璋救出。",
    wikiTitle: "宋 (韩林儿)",
    id: "cap-song-han-anfeng-1359",
    precision: "month",
  }),
  entry("chen-han", "江州", "江西省九江市", 1360, 6, 1362, 1, {
    note: "陈友谅1360年称帝，以江州（今九江）为都；1361—1362年间败退后迁都武昌。",
    wikiTitle: "陈友谅",
    id: "cap-chen-han-jiangzhou-1360",
    precision: "month",
  }),
  e("chen-han", "武昌", "湖北省武汉市", 1362, 1364, {
    note: "陈友谅败退后迁都武昌；1364年武昌陷落，陈理降明。",
    wikiTitle: "陈友谅",
    id: "cap-chen-han-wuchang-1362",
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
    precision: "month",
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
    precision: "month",
    note: "清入关后都北京。",
    wikiTitle: "北京",
    id: "cap-qing-beijing",
  }),
  entry("ming-south", "应天", "江苏省南京市", 1644, 6, 1645, 6, {
    startDay: 19,
    endDay: 15,
    precision: "day",
    note: "弘光政权都南京。",
    wikiTitle: "南明",
  }),
  entry("ming-south", "福州", "福建省福州市", 1645, 8, 1646, 10, {
    startDay: 18,
    endDay: 6,
    precision: "day",
    note: "隆武政权都福州。",
    wikiTitle: "南明",
  }),
  entry("ming-south", "广州", "广东省广州市", 1646, 12, 1647, 1, {
    startDay: 11,
    endDay: 20,
    precision: "day",
    claimTrack: "shaowu",
    note: "绍武政权都广州。",
    wikiTitle: "南明",
  }),
  entry("ming-south", "肇庆", "广东省肇庆市", 1646, 12, 1647, 2, {
    startDay: 24,
    endDay: 20,
    precision: "day",
    note: "永历帝于肇庆登基。",
    wikiTitle: "南明",
    id: "cap-ming-south-zhaoqing-1646",
  }),
  entry("ming-south", "桂林", "广西壮族自治区桂林市", 1647, 2, 1648, 12, {
    precision: "month",
    startDay: 21,
    note: "绍武败后永历退守广西。",
    wikiTitle: "南明",
    id: "cap-ming-south-guilin-1647",
  }),
  entry("ming-south", "肇庆", "广东省肇庆市", 1648, 8, 1649, 11, {
    precision: "month",
    note: "永历二年还都肇庆，至永历四年清军进犯后再度西撤。",
    wikiTitle: "南明",
    id: "cap-ming-south-zhaoqing-1648",
  }),
  entry("ming-south", "南宁", "广西壮族自治区南宁市", 1648, 2, 1648, 8, {
    precision: "month",
    note: "永历驻南宁，入黔前倚仗孙可望。",
    wikiTitle: "南明",
    id: "cap-ming-south-nanning-1648",
  }),
  entry("ming-south", "南宁", "广西壮族自治区南宁市", 1649, 11, 1652, 2, {
    precision: "month",
    note: "永历四年末再驻南宁，后于1652年二月移跸安龙。",
    wikiTitle: "南明",
    id: "cap-ming-south-nanning-1649",
  }),
  entry("ming-south", "安龙", "贵州省黔西南布依族苗族自治州安龙县", 1652, 2, 1656, 3, {
    precision: "month",
    note: "孙可望安置永历于安龙府。",
    wikiTitle: "南明",
    id: "cap-ming-south-anlong-1651",
  }),
  entry("ming-south", "昆明", "云南省昆明市", 1656, 3, 1659, 1, {
    precision: "month",
    note: "李定国迎驾入滇；1659年后流亡缅甸，1662年遇害于昆明。",
    wikiTitle: "南明",
  }),
  entry("dashun", "西安", "陕西省西安市", 1644, 2, 1644, 2, {
    precision: "day",
    startDay: 8,
    endDay: 15,
    note: "李自成于1644年2月8日（崇祯十七年正月初一）在西安称帝，2月15日率军东进北京；此处按公历日精度记载。",
    wikiTitle: "大顺",
    id: "cap-dashun-xian-19728",
  }),
  entry("dashun", "北京", "北京市", 1644, 4, 1644, 6, {
    precision: "day",
    startDay: 23,
    endDay: 4,
    note: "大顺军于1644年4月23日进入北京，至1644年6月4日退出；此处按公历日精度记载。",
    wikiTitle: "大顺",
    id: "cap-dashun-beijing-19728",
  }),
  entry("daxi", "西京", "四川省成都市", 1644, 12, 1646, 12, {
    precision: "day",
    startDay: 4,
    note: "1644年12月4日张献忠在成都称帝，国号大西，以成都为西京。",
    wikiTitle: "大西",
    id: "cap-daxi-chengdu-1644",
  }),
  entry("mingzheng", "东都", "台湾省台南市", 1661, 4, 1664, 12, {
    precision: "month",
    note: "1661年郑成功在台南建立承天府，称台湾为东都；1664年郑经改称东宁。",
    wikiTitle: "台湾首都",
    id: "cap-mingzheng-dongdu-1661",
  }),
  entry("mingzheng", "东宁", "台湾省台南市", 1664, 1, 1683, 10, {
    precision: "month",
    note: "1664年郑经将东都改称东宁；1683年十月郑克塽降清。",
    wikiTitle: "明郑",
    id: "cap-mingzheng-dongning-1664",
  }),
  entry("taiping", "天京", "江苏省南京市", 1853, 3, 1864, 7, {
    precision: "day",
    startDay: 29,
    endDay: 19,
    note: "1853年3月29日太平天国改江宁为天京并定都；1864年7月19日天京陷落。",
    wikiTitle: "天京",
  }),
  entry("roc", "南京", "江苏省南京市", 1912, 1, 1937, 11, {
    precision: "month",
    note: "民国初都南京。",
    wikiTitle: "中华民国",
  }),
  entry("roc", "重庆", "重庆市", 1937, 11, 1946, 5, {
    precision: "month",
    role: "temporary",
    note: "抗战陪都重庆。",
    wikiTitle: "重庆陪都",
  }),
  entry("roc", "南京", "江苏省南京市", 1946, 5, 1949, 4, {
    precision: "month",
    note: "抗战后还都南京。",
    wikiTitle: "中华民国",
    id: "cap-roc-nanjing-23348",
  }),
  entry("prc", "北京", "北京市", 1949, 10, 2026, 12, {
    precision: "month",
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
  "qi-bei", "xiliang", "chen-nan", "zhou-bei", "sui", "xia-dou-jiande", "zheng", "tang", "tubo", "nanzhao", "zhou-wu",
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
