/**
 * Pre-imperial 姓/氏 sourced from wiki/史记 for import pipelines.
 * Runtime reads persons.ancestral_xing / clan_shi and dynasties.* — not this file.
 *
 * Each entry must cite a source URL or 史记卷次.
 */

/** @typedef {{ ancestralXing?: string, clanShi?: string, source: string }} FeudalClanEntry */

/** @type {Record<string, FeudalClanEntry>} */
export const FEUDAL_DYNASTY_CLAN = {
  xia: {
    ancestralXing: "姒",
    source: "https://zh.wikipedia.org/wiki/夏朝 — 姒姓",
  },
  shang: {
    ancestralXing: "子",
    clanShi: "殷",
    source: "https://zh.wikipedia.org/wiki/商朝 — 子姓殷氏",
  },
  "zhou-west": {
    ancestralXing: "姬",
    source: "https://zh.wikipedia.org/wiki/西周 — 国君姓氏姬姓",
  },
  "zhou-east": {
    ancestralXing: "姬",
    source: "https://zh.wikipedia.org/wiki/东周 — 姬姓",
  },
  "qi-chunqiu": {
    ancestralXing: "姜",
    clanShi: "齐",
    source: "https://zh.wikipedia.org/wiki/齐国 — 姜齐：姜姓、齐氏",
  },
  "jin-chunqiu": {
    ancestralXing: "姬",
    clanShi: "晋",
    source: "https://zh.wikipedia.org/wiki/晋国 — 姬姓晋氏",
  },
  "chu-chunqiu": {
    ancestralXing: "芈",
    clanShi: "熊",
    source: "https://zh.wikipedia.org/wiki/楚国 — 芈姓熊氏",
  },
  "yan-chunqiu": {
    ancestralXing: "姬",
    clanShi: "匽",
    source: "https://zh.wikipedia.org/wiki/燕国 — 姬姓匽氏",
  },
  "song-chunqiu": {
    ancestralXing: "子",
    clanShi: "宋",
    source: "https://zh.wikipedia.org/wiki/宋国 — 子姓宋氏",
  },
  "lu-chunqiu": {
    ancestralXing: "姬",
    clanShi: "鲁",
    source: "https://zh.wikipedia.org/wiki/鲁国 — 姬姓鲁氏",
  },
  "wei-weiguo": {
    ancestralXing: "姬",
    clanShi: "卫",
    source: "https://zh.wikipedia.org/wiki/卫国 — 姬姓卫氏",
  },
  "zheng-chunqiu": {
    ancestralXing: "姬",
    clanShi: "郑",
    source: "https://zh.wikipedia.org/wiki/郑国 — 姬姓郑氏",
  },
  "cao-chunqiu": {
    ancestralXing: "姬",
    clanShi: "曹",
    source: "https://zh.wikipedia.org/wiki/曹国 — 姬姓曹氏",
  },
  "wu-chunqiu": {
    ancestralXing: "姬",
    clanShi: "姑发",
    source: "https://zh.wikipedia.org/wiki/吴国 — 姬姓姑发氏",
  },
  "han-warring": {
    ancestralXing: "姬",
    clanShi: "韩",
    source: "https://zh.wikipedia.org/wiki/韩国_(战国) — 姬姓韩氏",
  },
  "zhao-warring": {
    ancestralXing: "嬴",
    clanShi: "赵",
    source: "https://zh.wikipedia.org/wiki/赵国 — 嬴姓赵氏",
  },
  "wei-warring": {
    ancestralXing: "姬",
    clanShi: "魏",
    source: "https://zh.wikipedia.org/wiki/魏国 — 姬姓魏氏",
  },
  qin: {
    ancestralXing: "嬴",
    clanShi: "赵",
    source: "《史记·秦本纪》造父封赵城为赵氏；《秦始皇本纪》姓赵氏",
  },
};

/** @type {Record<string, { ancestralXing?: string, clanShi?: string, source: string }>} */
export const FEUDAL_PERSON_CLAN_OVERRIDES = {
  "lv-shang": {
    clanShi: "吕",
    source: "https://zh.wikipedia.org/wiki/齐国 — 姜齐吕氏（吕尚）",
  },
  "tian-he": {
    ancestralXing: "妫",
    clanShi: "田",
    source: "https://zh.wikipedia.org/wiki/齐国 — 田齐：妫姓田氏",
  },
};

/**
 * Import-time rules when person.name carries 氏 prefix (田因齐、吕尚).
 * @type {Array<{ dynastyId?: string, matchNamePrefix: string, ancestralXing?: string, clanShi?: string, source: string }>}
 */
export const FEUDAL_PERSON_CLAN_RULES = [
  {
    dynastyId: "qi-chunqiu",
    matchNamePrefix: "田",
    ancestralXing: "妫",
    clanShi: "田",
    source: "https://zh.wikipedia.org/wiki/齐国 — 田齐妫姓田氏",
  },
  {
    dynastyId: "qi-chunqiu",
    matchNamePrefix: "吕",
    clanShi: "吕",
    source: "https://zh.wikipedia.org/wiki/齐国 — 姜齐吕氏",
  },
];
