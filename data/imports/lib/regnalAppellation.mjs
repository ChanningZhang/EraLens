/**
 * Derive posthumous_name / temple_name from a regnal title that embeds the state
 * prefix (e.g. 唐肃宗 → temple 肃宗; 汉赵末帝 → posthumous 末帝).
 * title keeps the full form; short forms never repeat the prefix.
 */

/** Multi-char state prefixes, longest match first at runtime. */
export const REGNAL_TITLE_PREFIXES = [
  "成汉",
  "汉赵",
  "后赵",
  "前凉",
  "前燕",
  "前秦",
  "后燕",
  "后秦",
  "西秦",
  "后凉",
  "南凉",
  "西凉",
  "北凉",
  "南燕",
  "北燕",
  "胡夏",
  "东魏",
  "西魏",
  "西燕",
  "前蜀",
  "后蜀",
  "南唐",
  "南汉",
  "北汉",
  "吴越",
  "后梁",
  "后唐",
  "后晋",
  "后汉",
  "后周",
  "仇池",
  "荆南",
  "马楚",
];

/** Single-char prefixes on imperial shorthand titles (晋元帝、魏道武帝). */
const SINGLE_CHAR_PREFIXES = ["晋", "隋", "唐", "宋", "魏", "梁", "齐", "陈", "周", "汉", "吴", "闽", "楚"];

const SKIP_BODIES = new Set(["皇帝", "王", "主", "奠基者"]);

/** @deprecated use title-based matching */
export const REGNAL_TITLE_PREFIX = {
  sui: "隋",
  tang: "唐",
  "song-north": "宋",
  "song-south": "宋",
  "jin-west": "晋",
  "jin-east": "晋",
  "han-west": "汉",
  "han-east": "汉",
  "liang-hou": "后梁",
  "tang-hou": "后唐",
  "jin-hou": "后晋",
  "han-hou": "后汉",
  "zhou-hou": "后周",
  "wu-shi": "吴",
  "tang-nan": "南唐",
  wuyue: "吴越",
  "min-fujian": "闽",
  "han-nan": "南汉",
  "shu-qian": "前蜀",
  "shu-hou": "后蜀",
  jingnan: "荆南",
  "chu-nan": "楚",
  "han-bei": "北汉",
  "cheng-han": "成汉",
  "han-zhao": "汉赵",
  "zhao-back": "后赵",
  "liang-front": "前凉",
  "yan-front": "前燕",
  "qin-front": "前秦",
  "yan-back": "后燕",
  "qin-back": "后秦",
  "qin-xi": "西秦",
  "liang-back": "后凉",
  "liang-south": "南凉",
  "liang-xi": "西凉",
  "liang-north": "北凉",
  "yan-south": "南燕",
  "yan-north": "北燕",
  "xia-hu": "胡夏",
  "wei-north": "魏",
  "wei-east": "魏",
  "wei-west": "魏",
  xiyan: "西燕",
  ranwei: "魏",
  xiliang: "梁",
  chouchi: "仇池",
  "song-liu": "宋",
  "qi-nan": "齐",
  "liang-nan": "梁",
  "chen-nan": "陈",
};

/** @deprecated */
export const WUDAI_SHIGUO_TITLE_PREFIX = REGNAL_TITLE_PREFIX;

function regnalTitlePrefix(title, dynastyId) {
  const sorted = [...REGNAL_TITLE_PREFIXES].sort((a, b) => b.length - a.length);
  for (const prefix of sorted) {
    if (title.startsWith(prefix)) return prefix;
  }
  const mapped = REGNAL_TITLE_PREFIX[dynastyId];
  if (mapped && title.startsWith(mapped)) return mapped;
  for (const prefix of SINGLE_CHAR_PREFIXES) {
    if (title.startsWith(prefix) && title.length > prefix.length + 1) {
      return prefix;
    }
  }
  return null;
}

/**
 * @returns {{ posthumousName: string | null, templeName: string | null }}
 */
export function appellationFieldsFromRegnalTitle(dynastyId, title) {
  const prefix = regnalTitlePrefix(title, dynastyId);
  if (!prefix) {
    return { posthumousName: null, templeName: null };
  }
  const body = title.slice(prefix.length);
  if (!body || body.length < 2 || SKIP_BODIES.has(body)) {
    return { posthumousName: null, templeName: null };
  }
  if (/[祖宗]$/.test(body)) {
    return { posthumousName: null, templeName: body };
  }
  return { posthumousName: body, templeName: null };
}

/**
 * Fill missing posthumous/temple from title; explicit values always win.
 */
export function resolveRegnalAppellationFields(
  dynastyId,
  title,
  posthumous,
  temple,
) {
  const derived = appellationFieldsFromRegnalTitle(dynastyId, title);
  return {
    posthumousName: posthumous ?? derived.posthumousName,
    templeName: temple ?? derived.templeName,
  };
}
