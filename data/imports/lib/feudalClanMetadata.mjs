/**
 * Pre-imperial 姓/氏 sourced from wiki/史记 for import pipelines.
 * Runtime reads persons.ancestral_xing / clan_shi — not this file.
 *
 * Each entry must cite a source URL or 史记卷次.
 *
 * `skipXingOnGivenName`: keep wiki given names as-is (勾践).
 * `bareGivenNames`: do not prefix 姓 when the wiki cell is already the search name (夫差).
 */

/** @typedef {{
 *   ancestralXing?: string,
 *   clanShi?: string,
 *   skipXingOnGivenName?: boolean,
 *   bareGivenNames?: string[],
 *   source: string,
 * }} FeudalClanEntry */

/** @type {Record<string, FeudalClanEntry>} */
export const FEUDAL_DYNASTY_CLAN = {
  "zou-state": {
    ancestralXing: "曹",
    source: "https://shandong-chorography.org/database/zzmj/section/19/article/7/ — 春秋邾国、战国邹国为曹姓封国",
  },
  xia: {
    ancestralXing: "姒",
    clanShi: "夏",
    source: "https://zh.wikipedia.org/wiki/夏朝 — 姒姓夏氏",
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
    bareGivenNames: ["夫差", "阖闾", "寿梦", "诸樊", "僚"],
    source: "https://zh.wikipedia.org/wiki/吴国 — 姬姓姑发氏",
  },
  "yue-chunqiu": {
    ancestralXing: "姒",
    skipXingOnGivenName: true,
    source: "https://zh.wikipedia.org/wiki/越国 — 姒姓",
  },
  zhongshan: {
    ancestralXing: "姬",
    source: "https://zh.wikipedia.org/wiki/中山国 — 姬姓",
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
  "xue-chunqiu": {
    ancestralXing: "任",
    source: "https://zh.wikipedia.org/wiki/薛国 — 任姓",
  },
  "teng-chunqiu": {
    ancestralXing: "姬",
    source: "https://zh.wikipedia.org/wiki/滕国 — 姬姓",
  },
  "qi-state-chunqiu": {
    ancestralXing: "姒",
    source: "https://zh.wikipedia.org/wiki/杞国 — 姒姓",
  },
  "ju-chunqiu": {
    ancestralXing: "己",
    source: "https://zh.wikipedia.org/wiki/莒国 — 己姓",
  },
  "dai-warring": {
    ancestralXing: "嬴",
    clanShi: "赵",
    source: "https://zh.wikipedia.org/wiki/代国_(战国) — 赵嘉，嬴姓赵氏",
  },
  "jiaodong-warring": {
    ancestralXing: "妫",
    clanShi: "田",
    source: "https://zh.wikipedia.org/wiki/田巿 — 妫姓田氏",
  },
  "zhou-guo-west": {
    ancestralXing: "姬",
    source: "https://zh.wikipedia.org/wiki/西周国 — 姬姓",
  },
  "zhou-guo-east": {
    ancestralXing: "姬",
    source: "https://zh.wikipedia.org/wiki/东周国 — 姬姓",
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
  "qi-r33": { ancestralXing: "妫", clanShi: "田", source: "https://zh.wikipedia.org/wiki/齐国 — 田齐：妫姓田氏" },
  "qi-r34": { ancestralXing: "妫", clanShi: "田", source: "https://zh.wikipedia.org/wiki/齐国 — 田齐：妫姓田氏" },
  "qi-r35": { ancestralXing: "妫", clanShi: "田", source: "https://zh.wikipedia.org/wiki/齐国 — 田齐：妫姓田氏" },
  "qi-r36": { ancestralXing: "妫", clanShi: "田", source: "https://zh.wikipedia.org/wiki/齐国 — 田齐：妫姓田氏" },
  "qi-r37": { ancestralXing: "妫", clanShi: "田", source: "https://zh.wikipedia.org/wiki/齐国 — 田齐：妫姓田氏" },
  "qi-r38": { ancestralXing: "妫", clanShi: "田", source: "https://zh.wikipedia.org/wiki/齐国 — 田齐：妫姓田氏" },
  "qi-r39": { ancestralXing: "妫", clanShi: "田", source: "https://zh.wikipedia.org/wiki/齐国 — 田齐：妫姓田氏" },
  "hou-yi": {
    ancestralXing: null,
    clanShi: "有穷",
    source: "https://zh.wikipedia.org/wiki/后羿_(夏朝) — 有穷氏，代夏而未称夏后",
  },
  "han-zhuo": {
    ancestralXing: "妘",
    clanShi: "寒",
    source: "https://zh.wikipedia.org/wiki/寒浞 — 妘姓寒氏",
  },
  "weiguo-r42": {
    clanShi: "子南",
    source: "https://zh.wikipedia.org/wiki/卫国 — 公子郢字子南，后裔以子南为氏",
  },
};

/**
 * Import-time rules when person.name carries 氏 prefix (田因齐、吕尚、戴喜).
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
    matchNamePrefix: "妫",
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
  {
    dynastyId: "song-chunqiu",
    matchNamePrefix: "戴",
    ancestralXing: "子",
    clanShi: "戴",
    source: "https://zh.wikipedia.org/wiki/宋国 — 戴氏出于戴公",
  },
  {
    dynastyId: "wei-weiguo",
    matchNamePrefix: "子南",
    clanShi: "子南",
    source: "https://zh.wikipedia.org/wiki/卫国 — 公子郢字子南，后裔以子南为氏",
  },
];

/** Prefix written into persons.name — always 姓, never 氏 (氏 goes in clan_shi). */
export function personNamePrefix(dynastyId) {
  const meta = FEUDAL_DYNASTY_CLAN[dynastyId];
  if (!meta) return undefined;
  return meta.ancestralXing;
}

/**
 * Normalize wiki/import names that still carry 氏 or branch prefix into 姓+私名.
 * @param {string} dynastyId
 * @param {string} name
 * @param {string} [surnameOverride] import-time 姓 override (姜齐 vs 田齐)
 */
export function normalizeFeudalPersonName(dynastyId, name, surnameOverride = null) {
  const cleaned = String(name ?? "").trim();
  if (!cleaned) return cleaned;
  const meta = FEUDAL_DYNASTY_CLAN[dynastyId];
  const xing = surnameOverride ?? meta?.ancestralXing;
  if (!xing) return cleaned;

  for (const rule of FEUDAL_PERSON_CLAN_RULES) {
    if (rule.dynastyId && rule.dynastyId !== dynastyId) continue;
    if (!cleaned.startsWith(rule.matchNamePrefix)) continue;
    const ruleXing = rule.ancestralXing ?? meta?.ancestralXing;
    if (!ruleXing || cleaned.length <= rule.matchNamePrefix.length) continue;
    return `${ruleXing}${cleaned.slice(rule.matchNamePrefix.length)}`;
  }

  const shi = meta?.clanShi;
  if (shi && cleaned.startsWith(shi) && cleaned.length > shi.length) {
    return `${xing}${cleaned.slice(shi.length)}`;
  }

  if (cleaned.startsWith(xing)) return cleaned;
  return `${xing}${cleaned}`;
}

/** Resolve 姓/氏 hints for one person (dynasty defaults + per-person overrides + prefix rules). */
export function clanHintForPerson(dynastyId, personId, personName) {
  const base = FEUDAL_DYNASTY_CLAN[dynastyId];
  const override = FEUDAL_PERSON_CLAN_OVERRIDES[personId];
  const rule = FEUDAL_PERSON_CLAN_RULES.find(
    (r) =>
      (!r.dynastyId || r.dynastyId === dynastyId) &&
      personName?.startsWith(r.matchNamePrefix),
  );
  return {
    ancestralXing:
      override?.ancestralXing ?? rule?.ancestralXing ?? base?.ancestralXing,
    clanShi: override?.clanShi ?? rule?.clanShi ?? base?.clanShi,
  };
}
