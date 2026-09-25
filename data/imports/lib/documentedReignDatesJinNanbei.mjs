/**
 * Documented reign dates for Two Jin + Northern/Southern Dynasties.
 * Sources: 维基百科君主条目 / 南北朝君主列表公历换算.
 */
export const JIN_NANBEI_REIGN_DATES = {
  // ── 西晋 ────────────────────────────────────────────────────────────────
  "reign-sima-yan": { start: [266, 2, 8], end: [290, 5, 16] },
  "reign-sima-zhong": { start: [290, 5, 17], end: [307, 1, 8] },
  // 怀帝统治迄日取洛阳陷落被俘（维基条目「统治」），非 313-03-14 卒年。
  "reign-sima-chi": { start: [307, 1, 11], end: [311, 7, 13] },
  "reign-sima-ye": { start: [313, 6, 12], end: [316, 12, 11] },

  // ── 东晋 ────────────────────────────────────────────────────────────────
  "reign-sima-rui": { start: [317, 4, 26], end: [323, 1, 3] },
  "reign-sima-shao": { start: [323, 1, 3], end: [325, 10, 18] },
  "reign-sima-yan-cheng": { start: [325, 10, 18], end: [342, 7, 26] },
  "reign-sima-yue": { start: [342, 7, 26], end: [344, 11, 17] },
  "reign-sima-dan": { start: [344, 11, 17], end: [361, 7, 10] },
  "reign-sima-pi": { start: [361, 7, 10], end: [365, 5, 10] },
  "reign-sima-yi-jin": { start: [365, 5, 10], end: [371, 11, 6] },
  "reign-sima-yu-jin": { start: [371, 11, 6], end: [372, 9, 12] },
  "reign-sima-yao": { start: [372, 9, 12], end: [396, 11, 6] },
  "reign-sima-dezong": { start: [396, 11, 6], end: [419, 1, 28] },
  "reign-sima-dewen": { start: [419, 1, 28], end: [420, 7, 10] },

  // ── 南朝宋 ──────────────────────────────────────────────────────────────
  "reign-liu-yu-jin": { start: [420, 7, 10], end: [422, 6, 26] },
  "reign-liu-yifu": { start: [422, 6, 26], end: [424, 7, 27] },
  "reign-liu-yilong": { start: [424, 8, 11], end: [453, 3, 16] },
  "reign-liu-shao": { start: [453, 3, 16], end: [453, 5, 27] },
  "reign-liu-jun": { start: [453, 5, 27], end: [464, 7, 12] },
  "reign-liu-ziye": { start: [464, 7, 12], end: [465, 8, 12] },
  "reign-liu-yu-song": { start: [465, 8, 12], end: [472, 5, 10] },
  "reign-liu-yu-fei": { start: [472, 9, 10], end: [477, 8, 15] },
  "reign-liu-zhun": { start: [477, 8, 15], end: [479, 3, 30] },

  // ── 南朝齐 ──────────────────────────────────────────────────────────────
  "reign-xiao-daocheng": { start: [479, 4, 11], end: [482, 4, 11] },
  "reign-xiao-ze": { start: [482, 4, 11], end: [493, 7, 5] },
  "reign-xiao-zhaoye": { start: [494, 1, 10], end: [494, 11, 7] },
  "reign-xiao-zhaowen": { start: [494, 11, 7], end: [495, 1, 4] },
  "reign-xiao-luan": { start: [494, 12, 5], end: [498, 9, 7] },
  "reign-xiao-baojuan": { start: [499, 2, 16], end: [501, 12, 31] },
  "reign-xiao-baorong": { start: [501, 12, 31], end: [502, 4, 30] },

  // ── 南朝梁 ──────────────────────────────────────────────────────────────
  "reign-xiao-yan": { start: [502, 5, 1], end: [549, 6, 12] },
  "reign-xiao-gang": { start: [549, 6, 12], end: [551, 11, 14] },
  "reign-xiao-dong": { start: [551, 10, 2], end: [552, 1, 1] },
  "reign-hou-jing": { start: [552, 1, 1], end: [552, 5, 26] },
  "reign-xiao-yi": { start: [552, 11, 15], end: [555, 1, 27] },
  "reign-xiao-fangzhi": { start: [555, 1, 27], end: [557, 11, 16] },

  // ── 西梁（江陵，维基公历月；萧琮亡国取广运二年九月十九）────────────────
  "reign-xiao-cha-xiliang": { start: [555, 2], end: [562, 2] },
  "reign-xiao-kui-xiliang": { start: [562, 2], end: [585, 5] },
  "reign-xiao-cong-xiliang": { start: [585, 5], end: [587, 10, 26] },

  // ── 南朝陈 ──────────────────────────────────────────────────────────────
  "reign-chen-baxian": { start: [557, 11, 16], end: [559, 8, 12] },
  "reign-chen-qian": { start: [559, 8, 12], end: [566, 11, 24] },
  "reign-chen-bozong": { start: [566, 11, 24], end: [568, 12, 4] },
  "reign-chen-xu": { start: [568, 12, 4], end: [582, 2, 17] },
  "reign-chen-shubao": { start: [582, 2, 17], end: [589, 2, 10] },

  // ── 北朝魏 ──────────────────────────────────────────────────────────────
  "reign-tuoba-gui": { start: [386, 2, 20], end: [409, 11, 6] },
  "reign-tuoba-si": { start: [409, 11, 6], end: [423, 12, 6] },
  "reign-tuoba-tao": { start: [424, 1, 19], end: [452, 3, 11] },
  "reign-tuoba-yu": { start: [452, 3, 11], end: [452, 12, 19] },
  "reign-tuoba-jun": { start: [452, 12, 19], end: [465, 6, 25] },
  "reign-tuoba-hong": { start: [465, 6, 25], end: [471, 9, 20] },
  "reign-yuan-hong": { start: [471, 9, 20], end: [499, 4, 26] },
  "reign-yuan-ke": { start: [499, 4, 26], end: [515, 4, 2] },
  "reign-yuan-xu": { start: [515, 4, 2], end: [528, 3, 31] },
  "reign-yuan-zi-you": { start: [528, 4, 1], end: [530, 1, 24] },
  "reign-yuan-ye": { start: [530, 1, 24], end: [531, 3, 26] },
  "reign-yuan-lang": { start: [531, 3, 26], end: [532, 5, 17] },
  "reign-yuan-xiu": { start: [532, 2, 20], end: [535, 2, 3] },
  "reign-yuan-bao-ju": { start: [535, 2, 18], end: [551, 3, 8] },
  "reign-yuan-qin": { start: [551, 3, 8], end: [554, 12, 12] },
  "reign-tuoba-kuo": { start: [554, 12, 12], end: [557, 2, 16] },
  "reign-yuan-shan-jian": { start: [534, 11, 8], end: [550, 2, 9] },

  // ── 北朝齐 ──────────────────────────────────────────────────────────────
  "reign-gao-yang": { start: [550, 6, 9], end: [559, 11, 25] },
  "reign-gao-yin": { start: [559, 12, 27], end: [560, 9, 8] },
  "reign-gao-yan": { start: [560, 9, 8], end: [565, 11, 23] },
  "reign-gao-zhan": { start: [565, 11, 23], end: [569, 8, 4] },
  "reign-gao-wei": { start: [569, 8, 4], end: [577, 12, 14] },
  "reign-gao-heng": { start: [577, 12, 14], end: [578, 1, 18] },

  // ── 北朝周 ──────────────────────────────────────────────────────────────
  "reign-yuwen-jue": { start: [557, 2, 16], end: [557, 9, 19] },
  "reign-yuwen-yu": { start: [557, 9, 19], end: [560, 5, 31] },
  "reign-yuwen-yong": { start: [560, 5, 31], end: [578, 6, 21] },
  "reign-yuwen-yun": { start: [578, 6, 21], end: [579, 4, 16] },
  "reign-yuwen-yan": { start: [579, 4, 16], end: [581, 3, 4] },

  // ── 十六国（维基百科条目已给出公历月/日）────────────────────────────────
  // 后秦：姚苌白雀元年四月甲寅即万年秦王，公历 384-05-07；其余据年号起讫与《资治通鉴》所载在位年/月，未将农历日期伪换算为公历日。
  "reign-yao-chang": { start: [384, 5, 7], end: [393, 12], precision: "month" },
  "reign-yao-xing": { start: [393, 12], end: [416, 1], precision: "month" },
  "reign-yao-hong": { start: [416, 1], end: [417, 9], precision: "month" },
  // 前秦：苻健正月丙辰即天王位（公历 351-03-04）；其后各段依皇始、寿光、永兴/太初、延初年号月序，保留月精度，不把农历月日伪作公历日。
  "reign-fu-jian": { start: [351, 3, 4], end: [355, 7], precision: "month" },
  "reign-fu-sheng": { start: [355, 7], end: [357, 7], precision: "month" },
  "reign-fu-jian-ming": { start: [357, 7], end: [385, 10, 16] },
  // 苻丕：坚死（385-10-16）后至晋阳称帝；太元十一年十月为晋将冯该所杀（该月＝386-11-08–12-07）。
  "reign-fu-pi": { start: [385, 10], end: [386, 11] },
  // 苻登：太初 386 年十一月–394 年七月。十一月望约公历 12 月；七月接苻崇延初。
  "reign-fu-deng": { start: [386, 12], end: [394, 7] },
  "reign-murong-chui": { start: [384, 2, 9], end: [396, 6, 2] },
  "reign-murong-bao": { start: [396, 6, 21], end: [398, 5, 27] },
  "reign-murong-sheng": { start: [398, 8, 19], end: [401, 9, 13] },
  "reign-murong-xi": { start: [401, 9, 14], end: [407, 9, 14] },
  "reign-murong-chao": { start: [405, 11, 18], end: [410, 3, 25] },

  // 刘曜洛阳兵败被俘：咸和三年十二月乙未 = 329-02-06（维基注）。
  "reign-liu-yao-jin": { start: [318, 10], end: [329, 2, 6] },
  // 慕容暐：维基 360-02-27 — 370-12-10（十一月丁丑邺城降秦）。
  "reign-murong-wei": { start: [360, 2, 27], end: [370, 12, 10] },
  // 冉闵：永兴始闰二月（350年闰二月望≈4月）；维基逝世 352-06-01（永和八年四月被俘，五月辛卯慕容儁斩于龙城）。
  "reign-ran-min-ranwei": { start: [350, 4], end: [352, 6, 1] },
  // 石世：石虎死日（349-05-26）即位，在位三十三日，望在六月。
  "reign-shi-shi": { start: [349, 5], end: [349, 6] },
  // 石遵：废石世自立，太宁元年十一月被杀（在位183日）。十一月望≈12月。
  "reign-shi-zun": { start: [349, 6], end: [349, 12] },
  // 石鉴：十一月即位，青龙止350年闰二月（在位103日）。闰二月望≈4月。
  "reign-shi-jian": { start: [349, 12], end: [350, 4] },
  // 石祗：闻石鉴死于襄国称帝；351年四月刘显杀之。四月望≈5月。
  "reign-shi-zhi": { start: [350, 4], end: [351, 5] },

  // ── 十六国农历→格里历（寿星历 sxtwl；仅月者取望日所在公历月）────────
  // 嘉宁二年三月十七日降表＝347-04-13。
  "reign-li-shi": { start: [343, 1], end: [347, 4, 13], precision: "day" },
  // 维基 349-05-26＝太宁元年四月廿三。
  "reign-shi-hu": { start: [334, 1], end: [349, 5, 26], precision: "day" },
  // 升平至 376 年八月；八月十五＝376-09-14。
  "reign-zhang-tianxi": { start: [363, 1], end: [376, 9] },
  // 永和至 417 年八月；八月十五＝417-09-11。
  // 胜光 / 永弘至 431 年六月；六月十五＝431-07-10。
  "reign-helian-ding": { start: [428, 1], end: [431, 7] },
  "reign-qifu-mumo": { start: [428, 1], end: [431, 7] },
  // 神鼎至 403 年八月；八月十五＝403-09-16。
  "reign-lu-long": { start: [401, 1], end: [403, 9] },
  // 嘉平至 414 年七月；七月十五＝414-08-16。
  "reign-tufa-rutan": { start: [402, 1], end: [414, 8] },
  // 延初 394 年七月–十月；十月十五＝394-11-24。
  "reign-fu-chong": { start: [394, 7], end: [394, 11] },
  // 太兴至 436 年五月；五月十五＝436-06-14。
  "reign-feng-hong": { start: [430, 1], end: [436, 6] },
  // 太延五年九月丙戌二十五日姑臧降＝439-10-18。
  "reign-juqu-mujian": { start: [433, 1], end: [439, 10, 18], precision: "day" },
  // 嘉兴四年七月蓼泉之败；七月十五＝420-08-09。
  "reign-li-xin": { start: [417, 1], end: [420, 8] },
  // 西燕七帝：泓二月称王、冲385正月称帝、386二–六月政变链、永六月称河东王十月称帝。
  "reign-murong-hong-xiyan": { start: [384, 2], end: [384, 11] },
  "reign-murong-chong-xiyan": { start: [385, 1], end: [386, 2] },
  "reign-duan-sui-xiyan": { start: [386, 2], end: [386, 3] },
  "reign-murong-hao-xiyan": { start: [386, 3], end: [386, 3] },
  "reign-murong-yao-xiyan": { start: [386, 3], end: [386, 3] },
  "reign-murong-zhong-xiyan": { start: [386, 3], end: [386, 6] },
  // 中兴九年八月长子城破；八月十五＝394-09-26。
  "reign-murong-yong-xiyan": { start: [386, 6], end: [394, 9] },
};
