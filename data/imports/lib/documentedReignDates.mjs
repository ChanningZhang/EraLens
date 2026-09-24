/**
 * Documented reign start/end dates (proleptic Gregorian).
 * Sources: 维基百科君主列表 / 正史通行公历换算.
 *
 * Keys: reign id, or `${dynastyId}:${personId}` fallback.
 * Values: { start: [y, m, d?], end: [y, m, d?], precision?: "day"|"month" }
 */
import { JIN_NANBEI_REIGN_DATES } from "./documentedReignDatesJinNanbei.mjs";
import { ymDay } from "./reignDateHelpers.mjs";

function point([y, m, d]) {
  return d == null ? ymDay(y, m) : ymDay(y, m, d);
}

/** @type {Record<string, { start: number[], end: number[], precision?: string }>} */
export const DOCUMENTED_REIGN_DATES = {
  ...JIN_NANBEI_REIGN_DATES,

  // ── 秦 ──────────────────────────────────────────────────────────────────
  "reign-ying-zheng-qin": { start: [-246, 1], end: [-221, 9, 9] },
  "reign-ying-zheng": { start: [-221, 9, 10], end: [-210, 7, 11] },
  "reign-ying-huhai": { start: [-210, 8, 9], end: [-207, 10, 1] },
  "reign-ying-ziying": { start: [-207, 10, 1], end: [-207, 11, 17] },

  // ── 西楚 ────────────────────────────────────────────────────────────────
  "reign-xiang-yu": { start: [-206, 3, 12], end: [-202, 2, 28] },

  // ── 西汉 ──────────────────────────────────────────────────────────────
  "reign-liu-bang-han-king-han-west": { start: [-209, 9], end: [-202, 2, 27] },
  "reign-liu-bang": { start: [-202, 2, 28], end: [-195, 6, 1] },
  "reign-liu-ying": { start: [-195, 6, 26], end: [-188, 9, 26] },
  "reign-liu-gong": { start: [-188, 9, 27], end: [-184, 6, 15] },
  "reign-liu-hong-shao": { start: [-184, 6, 15], end: [-180, 11, 14] },
  "reign-liu-heng": { start: [-180, 11, 14], end: [-157, 7, 6] },
  "reign-liu-qi": { start: [-157, 7, 14], end: [-141, 3, 9] },
  "reign-liu-che": { start: [-141, 3, 9], end: [-87, 3, 29] },
  "reign-liu-fuling": { start: [-87, 3, 30], end: [-74, 6, 5] },
  "reign-liu-he": { start: [-74, 7, 18], end: [-74, 8, 14] },
  "reign-liu-xun": { start: [-74, 9, 10], end: [-48, 1, 10] },
  "reign-liu-shi": { start: [-48, 1, 29], end: [-33, 7, 8] },
  "reign-liu-ao": { start: [-33, 8, 4], end: [-7, 4, 17] },
  "reign-liu-xin": { start: [-7, 5, 7], end: [-1, 8, 15] },
  "reign-liu-kan": { start: [-1, 10, 17], end: [6, 2, 3] },
  "reign-ruzi-ying": { start: [6, 4, 17], end: [9, 1, 10] },

  // ── 新莽 ────────────────────────────────────────────────────────────────
  "reign-wang-mang": { start: [9, 1, 10], end: [23, 10, 6] },

  // ── 更始 ──────────────────────────────────────────────────────────────
  "reign-liu-xuan": { start: [23, 3, 11], end: [25, 10, 4] },

  // ── 东汉 ──────────────────────────────────────────────────────────────
  "reign-liu-xiu": { start: [25, 8, 5], end: [57, 3, 29] },
  "reign-liu-zhuang": { start: [57, 3, 29], end: [75, 9, 5] },
  "reign-liu-zuo": { start: [75, 9, 5], end: [88, 4, 9] },
  "reign-liu-zhao": { start: [88, 4, 9], end: [106, 2, 13] },
  "reign-liu-long": { start: [106, 2, 13], end: [106, 9, 21] },
  "reign-liu-hu": { start: [106, 9, 21], end: [125, 4, 30] },
  "reign-liu-yi-shao": { start: [125, 5, 18], end: [125, 12, 10] },
  "reign-liu-bao": { start: [125, 12, 10], end: [144, 9, 20] },
  "reign-liu-bing": { start: [144, 9, 20], end: [145, 2, 15] },
  "reign-liu-zuan": { start: [145, 3, 6], end: [146, 7, 26] },
  "reign-liu-zhi": { start: [146, 8, 1], end: [168, 1, 25] },
  "reign-liu-hong": { start: [168, 2, 17], end: [189, 5, 13] },
  "reign-liu-bian": { start: [189, 5, 15], end: [189, 9, 28] },
  "reign-liu-xie": { start: [189, 9, 29], end: [220, 11, 25] },

  // ── 三国（魏蜀吴称帝后）────────────────────────────────────────────────
  "reign-cao-pi": { start: [220, 12, 11], end: [226, 6, 29] },
  "reign-cao-rui": { start: [226, 6, 29], end: [239, 1, 22] },
  "reign-liu-bei": { start: [221, 5, 15], end: [223, 6, 10] },
  "reign-liu-shan": { start: [223, 6, 10], end: [263, 12, 23] },
  "reign-sun-quan": { start: [222, 10, 19], end: [252, 5, 21] },
  "reign-cao-fang": { start: [239, 1, 22], end: [254, 10, 17] },
  "reign-cao-mao": { start: [254, 10, 17], end: [260, 6, 2] },
  "reign-cao-huan": { start: [260, 6, 27], end: [266, 2, 4] },
  "reign-sun-liang": { start: [252, 5, 23], end: [258, 11, 2] },
  "reign-sun-xiu": { start: [258, 11, 2], end: [264, 9, 3] },
  "reign-sun-hao": { start: [264, 9, 3], end: [280, 5, 1] },

  // ── 隋 ──────────────────────────────────────────────────────────────────
  "reign-yang-jian": { start: [581, 3, 4], end: [604, 8, 13] },
  "reign-yang-guang": { start: [604, 8, 13], end: [618, 4, 11] },
  "reign-yang-hao": { start: [618, 4, 11], end: [618, 5, 24] },
  "reign-yang-you": { start: [617, 12, 18], end: [618, 6, 12] },
  "reign-yang-tong": { start: [618, 6, 22], end: [619, 5, 23] },

  // ── 唐 ──────────────────────────────────────────────────────────────────
  "reign-li-yuan": { start: [618, 6, 18], end: [626, 9, 4] },
  "reign-li-shimin": { start: [626, 9, 4], end: [649, 7, 10] },
  "reign-li-zhi": { start: [649, 7, 11], end: [683, 12, 27] },
  "reign-li-xian": { start: [684, 1, 3], end: [684, 2, 26] },
  "reign-li-dan": { start: [684, 2, 27], end: [690, 10, 14] },
  "reign-li-xian-2": { start: [705, 2, 23], end: [710, 7, 3] },
  "reign-li-dan-2": { start: [710, 7, 8], end: [712, 9, 8] },
  "reign-li-longji": { start: [712, 9, 8], end: [756, 8, 12] },
  "reign-li-heng": { start: [756, 8, 12], end: [762, 5, 16] },
  "reign-li-yu-tang": { start: [762, 5, 18], end: [779, 6, 10] },
  "reign-li-kuo": { start: [779, 6, 12], end: [805, 2, 25] },
  "reign-li-song": { start: [805, 2, 28], end: [805, 8, 31] },
  "reign-li-chun": { start: [805, 9, 5], end: [820, 2, 14] },
  "reign-li-heng-mu": { start: [820, 2, 20], end: [824, 2, 25] },
  "reign-li-zhan": { start: [824, 2, 25], end: [826, 12, 8] },
  "reign-li-ang": { start: [827, 1, 13], end: [840, 4, 10] },
  "reign-li-yan-tang": { start: [840, 4, 10], end: [846, 4, 22] },
  "reign-li-chen-tang": { start: [846, 4, 25], end: [859, 9, 13] },
  "reign-li-cui": { start: [859, 9, 13], end: [873, 8, 15] },
  "reign-li-xuan-tang": { start: [873, 8, 16], end: [888, 4, 20] },
  "reign-li-ye-tang": { start: [888, 4, 22], end: [904, 9, 22] },
  "reign-li-zhu-tang": { start: [904, 9, 27], end: [907, 5, 12] },

  // ── 武周 ────────────────────────────────────────────────────────────────
  "reign-wu-zetian-zhou-wu": { start: [690, 10, 16], end: [705, 2, 22] },

  // ── 五代 ────────────────────────────────────────────────────────────────
  "reign-zhu-wen-liang-hou": { start: [907, 6, 1], end: [912, 7, 2] },
  "reign-zhu-yougui-liang-hou": { start: [912, 7, 2], end: [913, 3, 27] },
  "reign-zhu-youzhen-liang-hou": { start: [913, 3, 27], end: [923, 11, 19] },
  "reign-li-cunxu-tang-hou": { start: [923, 5, 14], end: [926, 6, 5] },
  "reign-li-siyuan-tang-hou": { start: [926, 6, 11], end: [933, 12, 25] },
  "reign-li-conghou-tang-hou": { start: [933, 12, 25], end: [934, 5, 24] },
  "reign-li-congke-tang-hou": { start: [934, 5, 24], end: [937, 1, 11] },
  "reign-shi-jingtang-jin-hou": { start: [936, 11, 28], end: [942, 7, 28] },
  "reign-shi-chonggui-jin-hou": { start: [942, 7, 28], end: [947, 1, 16] },
  "reign-liu-zhiyuan-han-hou": { start: [947, 3, 10], end: [948, 3, 30] },
  "reign-liu-chengyou-han-hou": { start: [948, 3, 30], end: [951, 1, 2] },
  "reign-guo-wei-zhou-hou": { start: [951, 2, 13], end: [954, 2, 22] },
  "reign-guo-wei-regent-han-hou": { start: [951, 1, 2], end: [951, 2, 12] },
  "reign-shulvping-liao": { start: [926, 9, 6], end: [927, 12, 10] },
  "reign-tolui-mongol": { start: [1227, 8, 25], end: [1229, 9, 12] },
  "reign-toregene-mongol": { start: [1241, 12, 11], end: [1246, 8, 23] },
  "reign-oghul-qaimish-mongol": { start: [1248, 4, 20], end: [1251, 6, 30] },
  "reign-zhu-qiyu-regent-ming": { start: [1449, 9, 6], end: [1449, 9, 22] },
  "reign-chai-rong-zhou-hou": { start: [954, 2, 22], end: [959, 7, 27] },
  "reign-chai-zongxun-zhou-hou": { start: [959, 7, 28], end: [960, 2, 3] },

  // ── 十国（有可靠日的君主）────────────────────────────────────────────────
  "reign-yang-xingmi-wu-shi": { start: [902, 6, 18], end: [905, 12, 24] },
  "reign-yang-wo-wu-shi": { start: [905, 12, 24], end: [918, 6, 15] },
  "reign-yang-longyan-wu-shi": { start: [918, 6, 15], end: [920, 12, 24] },
  "reign-yang-pu-wu-shi": { start: [920, 12, 24], end: [937, 11, 17] },
  "reign-li-bian-tang-nan": { start: [937, 10, 11], end: [943, 3, 30] },
  "reign-li-jing-nantang-tang-nan": { start: [943, 3, 30], end: [961, 11, 18] },
  "reign-li-yu-nantang-tang-nan": { start: [961, 11, 18], end: [975, 11, 24] },
  "reign-qian-liu-wuyue": { start: [907, 5, 15], end: [932, 5, 6] },
  "reign-qian-yuangui-wuyue": { start: [932, 5, 6], end: [941, 8, 24] },
  "reign-qian-hongzuo-wuyue": { start: [941, 8, 24], end: [947, 3, 25] },
  "reign-qian-hongcong-wuyue": { start: [947, 3, 25], end: [948, 2, 13] },
  "reign-qian-chu-wuyue": { start: [948, 2, 13], end: [978, 5, 4] },
  "reign-wang-shenzhi-min-fujian": { start: [909, 1, 15], end: [925, 12, 30] },
  "reign-liu-yan-han-nan": { start: [917, 9, 5], end: [942, 6, 10] },
  "reign-liu-bin-han-nan": { start: [942, 6, 10], end: [943, 4, 15] },
  "reign-liu-sheng-han-nan": { start: [943, 4, 15], end: [958, 9, 18] },
  "reign-liu-chang-han-nan": { start: [958, 9, 18], end: [971, 3, 4] },
  "reign-wang-jian-shu-shu-qian": { start: [907, 4, 18], end: [918, 7, 11] },
  "reign-wang-yan-shu-shu-qian": { start: [918, 7, 11], end: [925, 11, 29] },
  "reign-meng-zhixiang-shu-hou": { start: [934, 3, 25], end: [934, 9, 7] },
  // 出降：乾德三年正月辛卯（《续资治通鉴》升仙桥）；正月朔癸酉=965-02-05 → 十九日=02-23。旧 01-11 是把正月己卯误写成公历 1 月。
  "reign-meng-chang-shu-hou": { start: [934, 9, 7], end: [965, 2, 23] },
  "reign-gao-jixing-jingnan": { start: [924, 6, 18], end: [928, 1, 28] },
  "reign-gao-conghe-jingnan": { start: [928, 1, 28], end: [948, 7, 28] },
  "reign-gao-baorong-jingnan": { start: [948, 7, 28], end: [960, 9, 9] },
  "reign-gao-baoxu-jingnan": { start: [960, 9, 9], end: [962, 11, 19] },
  "reign-gao-jichong-jingnan": { start: [962, 11, 19], end: [963, 3, 17] },
  "reign-ma-yin-chu-nan": { start: [907, 5, 15], end: [930, 12, 2] },
  "reign-ma-xisheng-chu-nan": { start: [930, 12, 2], end: [932, 8, 15] },
  "reign-ma-xifan-chu-nan": { start: [932, 8, 15], end: [947, 5, 30] },
  // 王延政：维基闽皇帝止于 945-10-02（南唐克建州）。
  "reign-wang-yanzheng-min-fujian": { start: [943, 3], end: [945, 10, 2] },
  // 马希崇：维基后主 951-10-22 — 951-11-16；起年取 951 正以免与马希萼年精度迄（950-12）之间空出大段无君。
  "reign-ma-xichong-chu-nan": { start: [951, 1], end: [951, 11, 16] },
  "reign-wang-yanhan-min-fujian": { start: [925, 12, 30], end: [927, 1, 14] },
  "reign-wang-yanjun-min-fujian": { start: [927, 1, 14], end: [935, 11, 17] },
  "reign-wang-jipeng-min-fujian": { start: [935, 11, 18], end: [939, 8, 29] },
  "reign-wang-yanxi-min-fujian": { start: [939, 8, 30], end: [944, 4, 8] },
  "reign-zhu-wenjin-min-fujian": { start: [944, 4, 8], end: [945, 2, 14] },
  "reign-liu-min-han-bei": { start: [951, 5, 18], end: [954, 11, 24] },
  "reign-liu-jun-bei-han-bei": { start: [954, 11, 24], end: [968, 10, 12] },
  "reign-liu-jiyuan-han-bei": { start: [968, 10, 12], end: [979, 6, 1] },

  // 金哀宗：天兴三年正月十日（1234-02-09）蔡州自缢。起年与宣宗迄日对齐。
  "reign-wanyan-shouxu-jin-nvzhen": { start: [1223, 1, 14], end: [1234, 2, 9] },

  // 北辽耶律淳：保大二年三月癸酉即位；六月十五卒＝1122-07-20（寿星历）。
  "reign-yelu-chun-beiliao": { start: [1122, 4, 22], end: [1122, 7, 20] },

  // 西辽耶律大石：1124年秋抵镇州可敦城称王；康国十年卒（1143）。
  "reign-yelu-dashi-xiliao": { start: [1124, 9], end: [1143, 12] },
  // 西辽屈出律：1218年春蒙古灭西辽被俘。
  "reign-qu-chulu-xiliao": { start: [1211, 1], end: [1218, 4] },

  // 东辽耶律留哥：贞祐四年三月称辽王改元天统；卒于1220年。
  "reign-yelu-liuge-dongliao": { start: [1213, 3], end: [1220, 12] },

  // 高句丽宝藏王：总章元年九月；九月十五＝668-10-25（寿星历）。
  "reign-baozang-wang-gaogouli": { start: [642, 1], end: [668, 10] },

  // ── 蒙古帝国大汗 ─────────────────────────────────────────────────────────
  "reign-temujin-mongol-empire": { start: [1206, 5, 15], end: [1227, 8, 25] },
  "reign-ogedei-mongol-empire": { start: [1229, 9, 13], end: [1241, 12, 11] },
  "reign-guyuk-mongol-empire": { start: [1246, 8, 24], end: [1248, 4, 20] },
  "reign-mongke-mongol-empire": { start: [1251, 7, 1], end: [1259, 8, 11] },
  "reign-hu-bilie-mongol-empire": { start: [1260, 5, 5], end: [1271, 12, 18] },

  // ── 元末割据 ─────────────────────────────────────────────────────────────
  "reign-xu-shouhui-song-xu": { start: [1351, 8, 15], end: [1360, 6, 16] },
  "reign-han-liner-song-han": { start: [1355, 2, 15], end: [1366, 12, 14] },
  "reign-zhang-shicheng-zhou-zhang": { start: [1354, 1, 17], end: [1367, 9, 1] },
  "reign-chen-youliang-chen-han": { start: [1360, 6, 16], end: [1363, 10, 3] },
  "reign-chen-li-chen-han": { start: [1363, 10, 3], end: [1364, 2, 28] },
  "reign-ming-yuzhen-xia-ming": { start: [1362, 3, 22], end: [1366, 3, 17] },
  "reign-ming-sheng-xia-ming": { start: [1366, 3, 17], end: [1371, 6, 21] },
  "reign-zhu-yuanzhang-wu-zhu": { start: [1364, 2, 15], end: [1368, 1, 23] },

  // ── 明郑 ─────────────────────────────────────────────────────────────────
  "reign-zheng-chenggong-mingzheng": { start: [1661, 6, 14], end: [1662, 6, 23] },
  "reign-zheng-jing-mingzheng": { start: [1662, 6, 29], end: [1681, 3, 17] },
  "reign-zheng-keshuang-mingzheng": { start: [1681, 3, 20], end: [1683, 10, 8] },

  // 大顺 / 大西末：维基百科条目公历。李自成卒年取通山九宫山说 1645-05-17；张献忠凤凰山 1647-01-02。
  "reign-li-zicheng-dashun": { start: [1644, 1], end: [1645, 5, 17] },
  "reign-zhang-xianzhong-daxi": { start: [1644, 12, 4], end: [1647, 1, 2] },

  // ── 西夏 ─────────────────────────────────────────────────────────────────
  "reign-li-yuanhao-xixia": { start: [1031, 10, 19], end: [1048, 1, 19] },
  "reign-li-liangzuo-xixia": { start: [1048, 1, 19], end: [1067, 9, 1] },
  "reign-li-bingchang-xixia": { start: [1067, 9, 1], end: [1086, 8, 21] },
  "reign-li-qianshun-xixia": { start: [1086, 8, 21], end: [1139, 7, 1] },
  "reign-li-renxiao-xixia": { start: [1139, 7, 1], end: [1193, 10, 16] },
  "reign-li-chunyou-xixia": { start: [1193, 10, 16], end: [1206, 2, 1] },
  "reign-li-anquan-xixia": { start: [1206, 2, 1], end: [1211, 9, 13] },
  "reign-li-zunxu-xixia": { start: [1211, 9, 13], end: [1223, 12, 17] },
  "reign-li-dewang-xixia": { start: [1223, 12, 17], end: [1226, 9, 17] },
  "reign-li-xian-xixia": { start: [1226, 9, 17], end: [1227, 7, 2] },

  // ── 民国元首（中华民国国家元首列表；国务院摄行建 informal reign）──────────
  "reign-sun-yat-sen-roc": { start: [1912, 1, 1], end: [1912, 3, 10] },
  "reign-yuan-shikai-roc": { start: [1912, 3, 10], end: [1916, 6, 6] },
  "reign-li-yuanhong-roc": { start: [1916, 6, 7], end: [1917, 7, 6] },
  "reign-feng-guozhang-roc": { start: [1917, 7, 6], end: [1918, 10, 10] },
  "reign-xu-shichang-roc": { start: [1918, 10, 10], end: [1922, 6, 2] },
  "reign-zhou-ziqi-roc": { start: [1922, 6, 2], end: [1922, 6, 11] },
  "reign-li-yuanhong-roc-2": { start: [1922, 6, 11], end: [1923, 6, 13] },
  "reign-gao-lingwei-roc": { start: [1923, 6, 14], end: [1923, 10, 10] },
  "reign-cao-kun-roc": { start: [1923, 10, 10], end: [1924, 11, 2] },
  "reign-huang-fu-roc": { start: [1924, 11, 2], end: [1924, 11, 24] },
  "reign-duan-qirui-roc": { start: [1924, 11, 24], end: [1926, 4, 20] },
  "reign-hu-weide-roc": { start: [1926, 4, 20], end: [1926, 5, 13] },
  "reign-yan-huiqing-roc": { start: [1926, 5, 13], end: [1926, 6, 23] },
  "reign-du-xigui-roc": { start: [1926, 6, 23], end: [1926, 10, 1] },
  "reign-gu-weijun-roc": { start: [1926, 10, 1], end: [1927, 6, 16] },
  "reign-hu-weide-roc-2": { start: [1927, 6, 16], end: [1927, 6, 18] },
  "reign-zhang-zuolin-roc": { start: [1927, 6, 18], end: [1928, 6, 3] },
  // 谭延闿维基自 1928-02-07，与张作霖并立至 6 月；主线自张作霖离京后接续。
  "reign-tan-yankai-roc": { start: [1928, 6, 4], end: [1928, 10, 10] },
  "reign-jiang-jieshi-chairman-1-roc": { start: [1928, 10, 10], end: [1931, 12, 15] },
  "reign-lin-sen-roc": { start: [1931, 12, 15], end: [1943, 8, 1] },
  "reign-jiang-jieshi-chairman-roc": { start: [1943, 8, 1], end: [1948, 5, 20] },
  "reign-jiang-jieshi-roc": { start: [1948, 5, 20], end: [1949, 1, 21] },
  "reign-li-zongren-roc": { start: [1949, 1, 21], end: [1950, 3, 1] },
  "reign-jiang-jieshi-roc-2": { start: [1950, 3, 1], end: [1975, 4, 5] },
  "reign-yan-jiagan-roc": { start: [1975, 4, 6], end: [1978, 5, 20] },
  "reign-jiang-jingguo-roc": { start: [1978, 5, 20], end: [1988, 1, 13] },
  "reign-li-denghui-roc": { start: [1988, 1, 13], end: [2000, 5, 20] },
  "reign-chen-shuibian-roc": { start: [2000, 5, 20], end: [2008, 5, 20] },
  "reign-ma-yingjiu-roc": { start: [2008, 5, 20], end: [2016, 5, 20] },
  "reign-cai-yingwen-roc": { start: [2016, 5, 20], end: [2024, 5, 20] },
  "reign-lai-qingde-roc": { start: [2024, 5, 20], end: [2026, 9], precision: "month" },

  // ── 中华人民共和国国家元首（主席 / 副主席代行 / 代主席 / 人大常委会）──
  "reign-mao-zedong-prc": { start: [1949, 10, 1], end: [1954, 9, 27] },
  "reign-mao-zedong-prc-2": { start: [1954, 9, 27], end: [1959, 4, 27] },
  "reign-liu-shaoqi-prc": { start: [1959, 4, 27], end: [1968, 10, 31] },
  "reign-song-qingling-dong-biwu-prc": { start: [1968, 10, 31], end: [1972, 2, 24] },
  "reign-dong-biwu-prc": { start: [1972, 2, 24], end: [1975, 1, 17] },
  "reign-npc-standing-committee-prc": { start: [1975, 1, 17], end: [1983, 6, 18] },
  "reign-li-xiannian-prc": { start: [1983, 6, 18], end: [1988, 4, 8] },
  "reign-yang-shangkun-prc": { start: [1988, 4, 8], end: [1993, 3, 27] },
  "reign-jiang-zemin-prc": { start: [1993, 3, 27], end: [2003, 3, 15] },
  "reign-hu-jintao-prc": { start: [2003, 3, 15], end: [2013, 3, 14] },
  "reign-xi-jinping-prc": { start: [2013, 3, 14], end: [2026, 9], precision: "month" },
};

function lookupDoc(reign) {
  return (
    DOCUMENTED_REIGN_DATES[reign.id] ??
    DOCUMENTED_REIGN_DATES[`${reign.dynastyId}:${reign.personId}`]
  );
}

export function applyDocumentedDates(reign) {
  const doc = lookupDoc(reign);
  if (!doc) return reign;
  const start = point(doc.start);
  const end = point(doc.end);
  const precision =
    doc.precision ??
    (doc.start[2] != null && doc.end[2] != null ? "day" : "month");
  return { ...reign, start, end, startAbs: start.abs, endAbs: end.abs, precision };
}

export function applyDocumentedDatesToReigns(reigns) {
  return reigns.map(applyDocumentedDates);
}
