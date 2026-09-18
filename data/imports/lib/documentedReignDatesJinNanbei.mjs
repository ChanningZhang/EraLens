/**
 * Documented reign dates for Two Jin + Northern/Southern Dynasties.
 * Sources: 维基百科君主条目 / 南北朝君主列表公历换算.
 */
export const JIN_NANBEI_REIGN_DATES = {
  // ── 西晋 ────────────────────────────────────────────────────────────────
  "reign-sima-yan": { start: [266, 2, 8], end: [290, 5, 16] },
  "reign-sima-zhong": { start: [290, 5, 17], end: [307, 2, 3] },
  "reign-sima-chi": { start: [307, 5, 15], end: [313, 3, 14] },
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
  "reign-fu-jian-ming": { start: [357, 7], end: [385, 10, 16] },
  "reign-murong-xi": { start: [401, 9, 14], end: [407, 9, 14] },
  "reign-murong-chao": { start: [405, 11, 18], end: [410, 3, 25] },
};
