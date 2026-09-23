#!/usr/bin/env node
/**
 * Build rulers.mjs from cached Wikipedia extracts.
 * Run: node build-rulers.mjs
 *
 * Sources are Wikipedia 大陆简体 (`zh-cn`), refreshed by fetch-wiki-zh-cn.py.
 * 在位年份 / 出身关系 / 生卒. Earlier versions
 * picked columns with heuristics (first cell matching 公|王|侯|子$), so titles
 * like 曲沃武公（前679年改称晋武公） became 「称」, 秦惠文王's 记载名驷 became
 * 「出土」, and 关系「韩须之子」 was stored as a personal name.
 */
import { readFileSync, writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDeathYearToPredecessor } from "../lib/deathYearSuccession.mjs";
import { applyMultiReignRulers } from "../lib/multiReignRulers.mjs";
import { preQinRegnalCardName } from "../lib/preQinCardAppellation.mjs";
import {
  clanHintForPerson,
  FEUDAL_DYNASTY_CLAN,
  normalizeFeudalPersonName,
  personNamePrefix,
} from "../lib/feudalClanMetadata.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const sourcesDir = path.join(__dirname, "sources");

function loadSource(name) {
  const file = path.join(sourcesDir, name);
  try {
    const raw = JSON.parse(readFileSync(file, "utf8"));
    if (typeof raw === "string") return raw;
    if (raw.raw_content) return raw.raw_content;
    const first = raw.results?.[0];
    return first?.raw_content || "";
  } catch {
    return "";
  }
}

const mainText = loadSource("wiki-zhou-feudal.json");
const qiText = loadSource("wiki-qi.json");
const qinText = loadSource("wiki-qin.json");

/** Existing person ids — keep stable across imports */
const PERSON_OVERRIDES = {
  "齐太公|吕尚": "lv-shang",
  "齐太公|姜尚": "lv-shang",
  "齐太公|尚": "lv-shang",
  "齐太公|田和": "tian-he",
  "齐太公|妫和": "tian-he",
  "齐康公|姜贷": "jiang-dai",
  "齐康公|贷": "jiang-dai",
  "齐桓公|姜小白": "jiang-xiaobai",
  "齐桓公|小白": "jiang-xiaobai",
  "晋文公|姬重耳": "ji-chonger",
  "晋文公|重耳": "ji-chonger",
  "楚庄王|熊侣": "xiong-zhuang",
  "楚庄王|芈侣": "xiong-zhuang",
  "楚庄王|熊旅": "xiong-zhuang",
  "秦襄公|秦襄公": "ying-qi",
  "秦孝公|嬴渠梁": "ying-quliang",
  "秦孝公|渠梁": "ying-quliang",
  "吴王夫差|夫差": "fu-chai",
  "夫差|夫差": "fu-chai",
  "吴王阖闾|姬光": "helu",
  "吴王阖闾|光": "helu",
  "阖闾|光": "helu",
  "越王勾践|勾践": "gou-jian",
  // Yue ids stay stable after dropping legendary undated ancestors across wiki 世不明 gaps.
  "越侯夫谭|夫谭": "yue-r3",
  "越侯允常|允常": "yue-r4",
  "越王鹿郢|与夷": "yue-r6",
  "越王不寿|不寿": "yue-r7",
  "越王朱勾|翁": "yue-r8",
  "越王翳|翳": "yue-r9",
  "越王错枝|错枝": "yue-r10",
  "越王无余|无余": "yue-r11",
  "越王无颛|无颛": "yue-r12",
  "越王无彊|无彊": "yue-r13",
  "魏文侯|魏斯": "wei-wen",
  "魏文侯|姬斯": "wei-wen",
  "韩景侯|韩虔": "han-jing",
  "韩景侯|姬虔": "han-jing",
  "赵烈侯|赵籍": "zhao-lie",
  "赵烈侯|嬴籍": "zhao-lie",
  "秦王政|嬴政": "ying-zheng",
  "秦王政|政": "ying-zheng",
  "伯禽|伯禽": "bo-qin",
  "唐叔虞|姬虞": "ji-shuyu",
  "唐叔虞|虞": "ji-shuyu",
  "燕召公|姬奭": "ji-shi",
  "燕召公|奭": "ji-shi",
  "宋微子|子启": "song-weizi",
  "宋微子|启": "song-weizi",
};

const NAME_OVERRIDES = {
  "lv-shang": "姜尚",
  "tian-he": "妫和",
  "jiang-dai": "姜贷",
  "jiang-xiaobai": "姜小白",
  "ji-chonger": "姬重耳",
  "xiong-zhuang": "芈侣",
  "ying-qi": "嬴开",
  "ying-quliang": "嬴渠梁",
  "ying-zheng": "嬴政",
  "qin-r1": "嬴康",
  "qin-r2": "嬴立",
  "qin-r4": "嬴说",
  "qin-r5": "嬴嘉",
  "qin-r6": "嬴恬",
  "qin-r7": "嬴载",
  "qin-r13": "嬴籍",
  "qin-r14": "嬴宁",
  "qin-r15": "嬴盘",
  "qin-r16": "嬴刺",
  "qin-r17": "嬴欣",
  "qin-r18": "嬴封",
  "qin-r19": "嬴肃",
  "qin-r21": "嬴仁",
  "qin-r22": "嬴昌",
  "qin-r25": "嬴驷",
  "qin-r27": "嬴稷",
  "fu-chai": "夫差",
  "helu": "阖闾",
  "wei-wen": "姬斯",
  "han-jing": "姬虔",
  "zhao-lie": "嬴籍",
  "bo-qin": "伯禽",
  "ji-shuyu": "姬虞",
  "ji-shi": "姬奭",
  "song-weizi": "子启",
  "jin-r8": "姬费",
  "yan-r25": "姬桓",
  "yan-r35": "姬讙",
  "yan-r36": "姬遇",
};

/** Title-keyed display names — do not use person index (sort order changes). */
const TITLE_NAME_OVERRIDES = {
  "song-chunqiu": {
    宋休公: "子田",
    宋剔成君: "子喜",
    宋康王: "子偃",
  },
  "wei-weiguo": {
    卫平侯: "姬劲",
    卫嗣君: "缺失",
    卫怀君: "缺失",
    卫元君: "缺失",
  },
};

/** Wiki monarch-table years that actually count clan-head / 卿 tenure. */
/** Pre-Qin card regnal overrides (e.g. 秦王政 → 赵政). Key: personId|dynastyId */
const REIGN_PREFERRED_APPELLATION_OVERRIDES = {
  "ying-zheng|qin": { kind: "regnal", name: "赵政" },
};

const REIGN_YEAR_OVERRIDES = {
  "cao-chunqiu": {
    // 《曹国》君主表给出西周早期连续年表；以曹仲君前991—前925年为锚点，
    // 不再把叔振铎至孝伯整段在前865年前的窗口内均分。
    叔振铎: { start: -1041, end: -1016, startDateConfidence: null, endDateConfidence: null },
    曹叔振铎: { start: -1041, end: -1016, startDateConfidence: null, endDateConfidence: null },
    "叔振铎|振铎": { start: -1041, end: -1016, startDateConfidence: null, endDateConfidence: null },
    曹太伯: { start: -1015, end: -992, startDateConfidence: null, endDateConfidence: null },
    仲君: { start: -991, end: -925, startDateConfidence: null, endDateConfidence: null },
    曹仲君: { start: -991, end: -925, startDateConfidence: null, endDateConfidence: null },
    "仲君|平": { start: -991, end: -925, startDateConfidence: null, endDateConfidence: null },
    曹宫伯: { start: -924, end: -885, startDateConfidence: null, endDateConfidence: null },
    曹孝伯: { start: -884, end: -865, startDateConfidence: null, endDateConfidence: null },
    曹夷伯: { start: -864, end: -835, startDateConfidence: null, endDateConfidence: null },
  },
  "qi-chunqiu": {
    // 齐国表田和起前404年接田悼子，是田氏领袖年。田和条目：前391年放逐康公、自立为齐君。
    "齐太公|田和": { start: -391, end: -384 },
    // 康公卒前379年，前391年已被放逐；齐行国君止于废立前一年，其后顺序接田齐。
    "齐康公|姜贷": { start: -404, end: -392 },
  },
};

/** Wiki 诸侯表合并复位段 → 多条 reign。Key: dynastyId → personName */
const MULTI_REIGN_SPAN_EXPANSIONS = {
  "zhongshan": {
    // 中山桓公先于魏灭中山时在位，约前380年复国后再次在位。
    "中山桓公": [
      { startYear: -406, endYear: -406 },
      { startYear: -380, endYear: -350, ordinal: 2 },
    ],
  },
  "wei-weiguo": {
    // 卫成公条目：第一次前634–前632、第二次前632–前600；诸侯表合并为前634–前600。
    姬郑: [
      { startYear: -634, endYear: -632 },
      { startYear: -632, endYear: -600, ordinal: 2 },
    ],
  },
  "zheng-chunqiu": {
    // 郑成公被晋扣留期间，郑国内短暂立公子繻；成公前581年归国复位。
    姬睔: [
      { startYear: -584, endYear: -581 },
      { startYear: -581, endYear: -571, ordinal: 2 },
    ],
  },
};

// Short enthronements absent from the merged Wikipedia ruler table.
const CURATED_REIGN_ADDITIONS = {
  "wu-chunqiu": [
    {
      dynastyId: "wu-chunqiu",
      personId: "wu-fu-gai",
      title: "夫概",
      personName: "姬夫概",
      posthumousName: null,
      startYear: -505,
      endYear: -505,
      reignId: "reign-wu-fu-gai-wu-chunqiu",
      claimTrack: "fu-gai",
      claimLabel: "夫概",
      claimRole: "rival",
    },
  ],
  "zheng-chunqiu": [
    {
      dynastyId: "zheng-chunqiu",
      personId: "zheng-gongzi-xu",
      title: "公子繻",
      personName: "姬繻",
      posthumousName: null,
      startYear: -581,
      endYear: -581,
      reignId: "reign-zheng-gongzi-xu-zheng-chunqiu",
    },
  ],
};

function applyReignYearOverrides(dynastyId, rulers) {
  const table = REIGN_YEAR_OVERRIDES[dynastyId];
  if (!table) return rulers;
  return rulers.map((r) => {
    const titleKey = normalizeTitle(r.title);
    const nameKey = normalizeTitle(r.name || "");
    const patch = table[`${titleKey}|${nameKey}`] ?? table[titleKey];
    if (!patch) return r;
    return { ...r, ...patch, complete: true, interpolated: false };
  });
}

/** Early Western Zhou founders — wiki tables omit years or use non-standard rows */
const FOUNDING_RULER_PATCHES = {
  "lu-chunqiu": [{ title: "伯禽", name: "伯禽", start: -1043, end: -998, complete: true }],
};

/** Dynasty lane start; used to bound undated early rulers (not traditional 积年). */
const DYNASTY_START = {
  "qi-chunqiu": -1046,
  "jin-chunqiu": -1042,
  "chu-chunqiu": -1042,
  "yan-chunqiu": -1044,
  "song-chunqiu": -1034,
  "lu-chunqiu": -1042,
  "wei-weiguo": -1040,
  "zheng-chunqiu": -806,
  "cao-chunqiu": -1046,
  // Wu's early ruler list is undated; use the article's 12th-century BCE
  // founding window and the certain 585 BCE reign anchor for interpolation.
  "wu-chunqiu": -1100,
  /** First remaining Yue reign after wiki 世不明 gaps; bounds undated 夫谭 before 允常. */
  "yue-chunqiu": -565,
  zhongshan: -424,
  "han-warring": -403,
  "zhao-warring": -403,
  "wei-warring": -403,
  qin: -770,
};

/** 周天子册命韩赵魏为诸侯（三家分晋），独立诸侯国起点 */
const WARRING_STATE_FOUNDING_YEAR = -403;

/** Drop Jin-era 卿大夫 rulers; clip overlapping reigns to founding year. */
function trimToIndependentState(rulers) {
  return rulers
    .filter((r) => r.end >= WARRING_STATE_FOUNDING_YEAR)
    .map((r) => ({
      ...r,
      start: Math.max(r.start, WARRING_STATE_FOUNDING_YEAR),
    }));
}

/** Warn on implausibly long single reigns after wiki parsing (not applied to interpolation). */
const MAX_PLAUSIBLE_REIGN_YEARS = 70;

const STATE_PREFIX = {
  "qi-chunqiu": "齐",
  "jin-chunqiu": "晋",
  "chu-chunqiu": "楚",
  "yan-chunqiu": "燕",
  "song-chunqiu": "宋",
  "lu-chunqiu": "鲁",
  "wei-weiguo": "卫",
  "zheng-chunqiu": "郑",
  "cao-chunqiu": "曹",
  "wu-chunqiu": "吴",
  "yue-chunqiu": "越",
  zhongshan: "中山",
  "han-warring": "韩",
  "zhao-warring": "赵",
  "wei-warring": "魏",
  qin: "秦",
};

function toSimplified(text) {
  // Sources are already zh-cn Wikipedia; normalize a few chars that still
  // appear in legacy rows or mixed tables before name extraction.
  return String(text ?? "")
    .replace(/後/g, "后")
    .replace(/異/g, "异")
    .replace(/莊/g, "庄");
}

function stripMdLinks(text) {
  let out = "";
  let i = 0;
  while (i < text.length) {
    if (text[i] === "[" && text[i + 1] !== "[") {
      const closeBracket = text.indexOf("]", i + 1);
      if (closeBracket > i && text[closeBracket + 1] === "(") {
        out += text.slice(i + 1, closeBracket);
        let depth = 0;
        let j = closeBracket + 1;
        for (; j < text.length; j++) {
          if (text[j] === "(") depth++;
          else if (text[j] === ")") {
            depth--;
            if (depth === 0) {
              j++;
              break;
            }
          }
        }
        i = j;
        continue;
      }
    }
    out += text[i];
    i++;
  }
  return out;
}

function stripMd(s) {
  return stripMdLinks(s)
    .replace(/\[\[(?:註\s*\d+|[^\]]*?)\]\]/g, "")
    .replace(/\[\[?\d+\]?\]\(#cite_note-[^)]*\)/g, "")
    .replace(/\(#cite_note-[^)]*\)?/g, "")
    .replace(/\[[^\]]+\]\([^)]*\)/g, "")
    .replace(/\*/g, "")
    .trim();
}

function firstLinkText(raw) {
  const m = String(raw ?? "").match(/\[([^\]]+)\]\(/);
  return m ? m[1].trim() : "";
}

function isBadPersonName(name) {
  return (
    !name ||
    /^[0-9]+$/.test(name) ||
    /^[0-9]+年$/.test(name) ||
    /出土|原名|记载|史記|史记|漢書|汉书|之子|之弟|之孫|之孙|之兄|長子|长子|少子|别名|又名|又称|或作|一名|一作|之侯|避讳|误作|旧作|左右|不满|后裔|族人|三世|不明|灭亡/.test(
      name,
    )
  );
}

/** Strip alias markers / trailing notes that survived column parsing. */
function finalizePersonName(name) {
  if (!name) return "";
  let s = toSimplified(String(name));
  s = s.split(/[《（(]/)[0].trim();
  s = s.split(/\s*(?:别名|又名|又称|或作|一作|一名)\s*/)[0].trim();
  s = s.split(/\s+/)[0].trim();
  s = s.replace(/[，,、].*$/, "").trim();
  s = s.replace(/\s+/g, "");
  if (isBadPersonName(s)) return "";
  if (s.length > 8) return "";
  return s;
}

function normalizeTitle(title) {
  let t = toSimplified(String(title ?? ""));
  const renamed = t.match(/改称\s*([\u4e00-\u9fff]{2,8})/);
  if (renamed) t = renamed[1];
  t = t.replace(/（前）|（后）|\(前\)|\(后\)/g, "");
  t = t.replace(/（.*?）/g, "").replace(/\(.*?\)/g, "");
  t = t.split(/或/)[0].split(/《/)[0];
  t = t.replace(/\s+/g, "");
  t = t.replace(/&action=edit&redlink=\d+/g, "");
  t = t.replace(/Cuo/gi, "厝");
  if (t === "文候") t = "文侯";
  if (t === "武候") t = "武侯";
  return t.trim();
}

function extractGivenName(raw) {
  if (!raw) return "";
  let s = toSimplified(stripMd(raw));
  if (!s) return "";

  const renamed = s.match(/(?:后)?改名\s*([\u4e00-\u9fff]{1,6})/);
  if (renamed) return renamed[1];

  const recorded = s.match(/记载名\s*([\u4e00-\u9fff]{1,6})/);
  if (recorded) return recorded[1];

  // Primary given name precedes book citations and alias markers.
  s = s.split(/[《（(]/)[0].trim();
  s = s.split(/\s*(?:别名|又名|又称|或作|一作|一名)\s*/)[0].trim();
  s = s.split(/\s+/)[0].trim();
  s = s.replace(/[，,、].*$/, "").trim();
  if (s.includes("/")) {
    const parts = s.split("/").map((p) => p.trim()).filter(Boolean);
    s = parts[0] ?? "";
  }
  return finalizePersonName(s);
}

function parseYearToken(s) {
  const m = String(s ?? "").match(/前(\d+)/);
  return m ? -parseInt(m[1], 10) : null;
}

function parseYearsFromText(s) {
  // Prefer the primary chronology; wiki often appends 旧作/旧误作 alternate ranges.
  const text = String(s ?? "")
    .replace(/前年/g, "？")
    .split(/旧(?:作|误作)/)[0];
  const range =
    text.match(/前(\d+)年\s*[—–\-－~～―─]{1,3}\s*前(\d+)年/) ||
    text.match(/前(\d+)年\s*--+?\s*(?:\[)?前(\d+)年/) ||
    text.match(/（前(\d+)年[—–\-－―─]+前(\d+)年）/) ||
    text.match(/\[前(\d+)年\][^\d]*\[前(\d+)年\]/);
  if (range) {
    return { start: -parseInt(range[1], 10), end: -parseInt(range[2], 10), complete: true };
  }
  const startOpen =
    text.match(/前(\d+)年[^前\d]*(?:以后|[—–\-－―─]\s*[？?])/) ||
    text.match(/约\s*前(\d+)年/);
  if (startOpen && !/前\d+年[^前]*前\d+年/.test(text)) {
    return { start: -parseInt(startOpen[1], 10), end: null, complete: false };
  }
  const endOpen = text.match(/[？?]\s*[—–\-－―─]\s*前(\d+)年/);
  if (endOpen) {
    return { start: null, end: -parseInt(endOpen[1], 10), complete: false };
  }
  const singles = [...text.matchAll(/前(\d+)年/g)].map((m) => -parseInt(m[1], 10));
  if (singles.length >= 2) return { start: singles[0], end: singles[1], complete: true };
  if (singles.length === 1) {
    if (/[？?]/.test(text) && text.indexOf("？") < text.indexOf(`前${-singles[0]}`)) {
      return { start: null, end: singles[0], complete: false };
    }
    if (/[？?]/.test(text)) return { start: singles[0], end: null, complete: false };
    return { start: singles[0], end: singles[0], complete: false };
  }
  return null;
}

function sectionText(text, keyword) {
  const re = new RegExp(`### [^\\n]*${keyword}[^\\n]*\\n`, "i");
  const m = text.match(re);
  if (!m) return "";
  const start = m.index + m[0].length;
  const next = text.slice(start).search(/\n### /);
  return next < 0 ? text.slice(start) : text.slice(start, start + next);
}

const TITLE_HEADER = /^(稱號|称号|諡號|谥号|谥號|君主)$/;
const NAME_HEADER = /^(國君姓名|国君姓名|國君之名|国君之名|國君名称|国君名称|國君本名|国君本名|領袖姓名|领袖姓名|姓名|名)$/;
const YEAR_HEADER = /^(在位年份|在位時間|在位时间)$/;
const YEAR_START_HEADER = /^(上任時間|上任时间)$/;
const YEAR_END_HEADER = /^(退位時間|退位时间)$/;
const DURATION_HEADER = /^(在位年數|在位年数)$/;
const SKIP_ROW = /稱號|称号|諡號|谥号|国君姓名|國君姓名|国君之名|领袖姓名|在位年數|在位年数|资料出处|出身与关系/;
/** Wiki genealogy holes such as 「中有十世不明」「中间世系失考」. */
const GENEALOGY_GAP_ROW = /世系失考|世不明|中间世系/;

function isGenealogyGapRow(rawCols) {
  return GENEALOGY_GAP_ROW.test(toSimplified(rawCols.map((c) => stripMd(c)).join("")));
}

function isCompleteReign(r) {
  return r.complete === true && r.start != null && r.end != null;
}

function splitCols(line) {
  const raw = line.split("|");
  if (raw.length >= 2 && raw[0].trim() === "") raw.shift();
  if (raw.length >= 1 && raw[raw.length - 1].trim() === "") raw.pop();
  return raw;
}

function indexHeader(rawCols) {
  const labels = rawCols.map((c) => stripMd(c).replace(/\s+/g, ""));
  const simplified = labels.map(toSimplified);
  const find = (re) => {
    const viaSimple = simplified.findIndex((c) => re.test(c));
    if (viaSimple >= 0) return viaSimple;
    return labels.findIndex((c) => re.test(c));
  };
  const titleIdx = find(TITLE_HEADER);
  const nameIdx = find(NAME_HEADER);
  const yearIdx = find(YEAR_HEADER);
  const yearStartIdx = find(YEAR_START_HEADER);
  const yearEndIdx = find(YEAR_END_HEADER);
  const durationIdx = find(DURATION_HEADER);
  if (titleIdx < 0 && nameIdx < 0) return null;
  const joined = simplified.join("");
  return {
    titleIdx,
    nameIdx,
    yearIdx,
    yearStartIdx,
    yearEndIdx,
    durationIdx,
    isLeaderTable: /领袖/.test(joined),
    labels: simplified,
  };
}

function cell(rawCols, idx) {
  if (idx == null || idx < 0 || idx >= rawCols.length) return "";
  return rawCols[idx] ?? "";
}

function ensureStatePrefix(title, dynastyId) {
  const prefix = STATE_PREFIX[dynastyId];
  if (!prefix || !title) return title;
  if (title.startsWith(prefix)) return title;
  if (/^(公孙|公子|安孺子|田|曲沃)/.test(title)) return title;
  if (/^(太公|丁公|乙公|癸公|文侯|武侯|惠成王|襄王|昭王|安僖王|景湣王)$/.test(title)) {
    return `${prefix}${title}`;
  }
  if (/^(公|侯|伯|王|君|叔)$/.test(title) === false && /[公王侯伯君叔子]$/.test(title) && title.length <= 4) {
    return `${prefix}${title}`;
  }
  return title;
}

function parseDuration(raw) {
  const text = stripMd(raw);
  if (/未改元/.test(text)) return 1;
  if (/[?？]/.test(text)) return "unknown";
  const m = text.match(/(\d+)\s*年/);
  if (m) return parseInt(m[1], 10);
  if (/^1$/.test(text.trim())) return 1;
  return null;
}

function parseRow(rawCols, header, { dynastyId } = {}) {
  const joinedPlain = toSimplified(rawCols.map(stripMd).join(" "));
  if (/未继位/.test(joinedPlain)) return null;

  const titleRaw = cell(rawCols, header.titleIdx);
  const nameRaw = cell(rawCols, header.nameIdx);
  let title = normalizeTitle(firstLinkText(titleRaw) || stripMd(titleRaw));
  if (!title) title = normalizeTitle(firstLinkText(nameRaw) || stripMd(nameRaw));
  if (!title) return null;
  if (/称號|称号|谥號|谥号|君主|国君|传位|代|领袖|关系|资料/.test(title)) return null;
  if (/^[0-9]+$/.test(title)) return null;

  title = ensureStatePrefix(title, dynastyId);

  let years = null;
  if (header.yearStartIdx >= 0 || header.yearEndIdx >= 0) {
    const start = parseYearToken(stripMd(cell(rawCols, header.yearStartIdx)));
    const end = parseYearToken(stripMd(cell(rawCols, header.yearEndIdx)));
    if (start !== null && end !== null) years = { start, end, complete: true };
    else if (start !== null || end !== null) years = { start, end, complete: false };
  }
  if (!years && header.yearIdx >= 0) years = parseYearsFromText(stripMd(cell(rawCols, header.yearIdx)));
  if (!years) years = parseYearsFromText(joinedPlain);
  const duration = header.durationIdx >= 0 ? parseDuration(cell(rawCols, header.durationIdx)) : null;
  if (years && !years.complete && duration === 1 && (years.start != null || years.end != null)) {
    const y = years.start ?? years.end;
    years = { start: y, end: y, complete: true };
  }
  if (years?.complete && years.start != null && years.end != null) {
    const span = years.end - years.start + 1;
    if (span > MAX_PLAUSIBLE_REIGN_YEARS && typeof duration !== "number") {
      years = { start: years.start, end: null, complete: false };
    }
  }

  let name = extractGivenName(nameRaw);
  if (name === title) name = extractGivenName(nameRaw) || name;
  return {
    title,
    name,
    start: years?.start ?? null,
    end: years?.end ?? null,
    complete: Boolean(years?.complete),
  };
}

function parseWikiTables(chunk, { dynastyId, includeLeaderTable = false } = {}) {
  const rulers = [];
  const pendingUndated = [];
  let header = null;
  const flushPending = () => {
    rulers.push(...pendingUndated);
    pendingUndated.length = 0;
  };
  for (const line of chunk.split("\n")) {
    if (!line.startsWith("|") || line.includes("---")) continue;
    const rawCols = splitCols(line);
    if (rawCols.length < 2) continue;
    const asHeader = indexHeader(rawCols);
    if (asHeader) {
      header = asHeader;
      continue;
    }
    if (!header) continue;
    if (header.isLeaderTable && !includeLeaderTable) continue;
    const labelsJoined = header.labels.join("");
    if (SKIP_ROW.test(toSimplified(rawCols.map(stripMd).join(""))) && rawCols.every((c) => !/前\d+/.test(c))) {
      continue;
    }
    void labelsJoined;
    if (isGenealogyGapRow(rawCols)) {
      // Do not interpolate undated names across lost generations (e.g. Xia 无余 → Spring-Autumn).
      pendingUndated.length = 0;
      continue;
    }
    const row = parseRow(rawCols, header, { dynastyId });
    if (!row) continue;
    if (isCompleteReign(row)) {
      flushPending();
      rulers.push(row);
    } else {
      pendingUndated.push(row);
    }
  }
  flushPending();
  return dedupePreserveOrder(rulers);
}

/** Evenly split [windowStart, windowEnd] across undated rulers; seams stay contiguous. */
function assignInterpolatedRun(run, windowStart, windowEnd) {
  const count = run.length;
  if (count === 0) return;
  const span = windowEnd - windowStart + 1;
  for (let k = 0; k < count; k += 1) {
    const a = windowStart + Math.floor((span * k) / count);
    const b = windowStart + Math.floor((span * (k + 1)) / count) - 1;
    run[k].start = a;
    run[k].end = Math.max(a, b);
    run[k].complete = true;
    run[k].interpolated = true;
  }
}

/** Tag interpolated reign years; anchor-adjacent sides stay certain. */
function markInterpolatedBoundaries(rulers) {
  const sorted = [...rulers].sort(
    (a, b) => a.start - b.start || a.end - b.end || a.title.localeCompare(b.title),
  );
  for (let i = 0; i < sorted.length; i += 1) {
    const reign = sorted[i];
    if (!reign.interpolated) continue;
    const prev = sorted[i - 1];
    const next = sorted[i + 1];
    const touchesPrevAnchor =
      prev?.end != null &&
      reign.start === prev.end + 1 &&
      !prev.interpolated &&
      !isUncertainConfidence(prev.endDateConfidence);
    const touchesNextAnchor =
      next?.start != null &&
      reign.end + 1 === next.start &&
      !next.interpolated &&
      !isUncertainConfidence(next.startDateConfidence);
    if (!reign.startDateConfidence && !touchesPrevAnchor) {
      reign.startDateConfidence = "interpolated";
    }
    if (!reign.endDateConfidence && !touchesNextAnchor) {
      reign.endDateConfidence = "interpolated";
    }
  }
  return clearAnchoredShortReignInterpolation(rulers);
}

function isUncertainConfidence(value) {
  return value === "interpolated" || value === "approximate";
}

/**
 * Single-year reigns pinned between dated neighbors (卫戴公、公孙无知等)
 * are documented short terms, not even-split artifacts — drop interpolated tags.
 */
function clearAnchoredShortReignInterpolation(rulers) {
  const sorted = [...rulers].sort(
    (a, b) => a.start - b.start || a.end - b.end || a.title.localeCompare(b.title),
  );
  for (let i = 0; i < sorted.length; i += 1) {
    const reign = sorted[i];
    if (!reign.interpolated || reign.start !== reign.end) continue;
    const prev = sorted[i - 1];
    const next = sorted[i + 1];
    if (prev?.end == null || next?.start == null) continue;
    const pinned =
      reign.start === prev.end && reign.end + 1 === next.start;
    if (!pinned) continue;
    reign.interpolated = false;
    delete reign.startDateConfidence;
    delete reign.endDateConfidence;
  }
  return rulers;
}

function fillUndatedYears(rulers, dynastyId) {
  const dynastyStart = DYNASTY_START[dynastyId];
  const out = rulers.map((r) => ({ ...r, startHint: r.start, endHint: r.end }));
  let i = 0;
  while (i < out.length) {
    if (isCompleteReign(out[i])) {
      i += 1;
      continue;
    }
    let j = i;
    while (j < out.length && !isCompleteReign(out[j])) j += 1;
    const prev = i > 0 ? out[i - 1] : null;
    const next = j < out.length ? out[j] : null;
    let windowStart = dynastyStart ?? null;
    if (prev?.end != null) windowStart = prev.end + 1;
    if (out[i].start != null) windowStart = out[i].start;
    if (dynastyStart != null && windowStart != null) {
      windowStart = Math.max(windowStart, dynastyStart);
    }
    let windowEnd = next?.start != null ? next.start - 1 : null;
    if (out[j - 1].end != null) {
      windowEnd = windowEnd == null ? out[j - 1].end : Math.min(windowEnd, out[j - 1].end);
    }
    if (windowStart == null || windowEnd == null || windowStart > windowEnd) {
      for (let k = i; k < j; k += 1) out[k].drop = true;
      i = j;
      continue;
    }
    assignInterpolatedRun(out.slice(i, j), windowStart, windowEnd);
    i = j;
  }
  return out.filter((r) => !r.drop && r.start != null && r.end != null);
}

function withSurname(dynastyId, name, title, surnameOverride = null) {
  const cleaned = finalizePersonName(name);
  if (!cleaned || isBadPersonName(cleaned)) return title;
  const meta = FEUDAL_DYNASTY_CLAN[dynastyId];
  if (meta?.skipXingOnGivenName && !surnameOverride) return cleaned;
  if (meta?.bareGivenNames?.includes(cleaned)) return cleaned;
  const normalized = normalizeFeudalPersonName(dynastyId, cleaned, surnameOverride);
  if (normalized !== cleaned) return normalized;
  if (/[公王侯]$/.test(cleaned) && cleaned.length >= 2) return cleaned;
  if (cleaned === title) return cleaned;
  return normalized;
}

function parseQi() {
  const jiang = qiText.split("## 姜齐君主列表")[1]?.split("## 田齐君主列表")[0] || "";
  const tian = qiText.split("## 田齐君主列表")[1]?.split("秦末")[0] || "";
  const jiangRulers = parseWikiTables(jiang, { dynastyId: "qi-chunqiu" }).map((r) => ({
    ...r,
    name: withSurname("qi-chunqiu", r.name, r.title, "姜"),
    clan: "姜",
  }));
  const tianRulers = parseWikiTables(tian, { dynastyId: "qi-chunqiu", includeLeaderTable: false }).map((r) => ({
    ...r,
    name: withSurname("qi-chunqiu", r.name, r.title, "妫"),
    clan: "田",
  }));
  return dedupePreserveOrder([...jiangRulers, ...tianRulers]);
}

function parseQin() {
  const chunk = qinText.split("## 列表")[1] || qinText;
  const rulers = parseWikiTables(chunk, { dynastyId: "qin" }).filter((r) => {
    if (r.start == null) return false;
    if (r.start < -770 && !r.title.includes("襄公")) return false;
    if (r.start > -207) return false;
    return true;
  });
  return rulers.map((r) => ({
    ...r,
    name: withSurname("qin", r.name, r.title),
  }));
}

function parseWu() {
  const chunk = sectionText(mainText, "吴国");
  const undatedGenealogy = [
    "泰伯", "仲雍", "季简", "叔达", "周章", "熊遂", "柯相", "彊鸠夷",
    "余桥疑吾", "柯卢", "周繇", "屈羽", "夷吾", "禽处", "转", "颇高", "句卑", "去齐",
  ].map((name, index) => ({
    dynastyId: "wu-chunqiu",
    personId: `wu-pre-r${index}`,
    title: name,
    name: withSurname("wu-chunqiu", name, name),
    start: null,
    end: null,
    startDateConfidence: index === 0 ? "approximate" : undefined,
  }));
  const rulers = [...undatedGenealogy, ...parseWikiTables(chunk, { dynastyId: "wu-chunqiu" })
    .filter((r) => r.start >= -585)
    .map((r) => {
      let title = r.title;
      if (!/吴|王/.test(title) && /寿梦|诸樊|僚|阖闾|夫差|余祭|余昧|余眛/.test(title)) {
        title = title === "僚" ? "吴王僚" : `吴王${title.replace("余眛", "余昧")}`;
      }
      if (title === "阖闾") title = "吴王阖闾";
      if (title === "夫差") title = "吴王夫差";
      const stablePersonId = {
        "吴王寿梦": "wu-r0",
        "吴王诸樊": "wu-r1",
        "吴王余祭": "wu-r2",
        "吴王余昧": "wu-r3",
        "吴王僚": "wu-r4",
        "吴王阖闾": "helu",
        "吴王夫差": "fu-chai",
      }[title];
      return { ...r, personId: stablePersonId, title, name: withSurname("wu-chunqiu", r.name, title) };
    })];
  return dedupePreserveOrder(rulers);
}

/** 中山国君主在位年：以维基「中山国」词条年表为准（诸侯表仅有残缺年）。 */
const ZHONGSHAN_WIKI_REIGNS = {
  中山文公: { start: -424, end: -415 },
  中山武公: { start: -414, end: -406, name: "窟" },
  // 年表把桓公的前406年在位段与复国后的在位段合并；下方统一多段配置再拆开。
  中山桓公: { start: -406, end: -350, startDateConfidence: "approximate", endDateConfidence: "approximate" },
  中山成公: { start: -349, end: -328, startDateConfidence: "approximate" },
  中山王厝: { start: -327, end: -310, name: "厝", endDateConfidence: "approximate" },
  中山王𧊒: { start: -309, end: -299, name: "𧊒", startDateConfidence: "approximate" },
  中山王尚: { start: -298, end: -296, name: "尚" },
};

function parseZhongshan() {
  const rulers = parseWikiTables(sectionText(mainText, "中山国"), { dynastyId: "zhongshan" });
  const fixed = [];
  for (const r of rulers) {
    let next = { ...r };
    if (next.title === "中山王") next.title = "中山王厝";
    if (next.title === "中山王胜") {
      next.title = "中山王𧊒";
    }
    if (next.title === "中山王厝" && !finalizePersonName(next.name)) {
      next.name = "厝";
    }
    if (next.title === "中山王𧊒" && !finalizePersonName(next.name)) {
      next.name = "𧊒";
    }
    fixed.push(next);
  }
  return dedupePreserveOrder(fixed);
}

function finalizeZhongshanRulers(rulers) {
  const byTitle = new Map(rulers.map((r) => [normalizeTitle(r.title), r]));
  for (const [title, patch] of Object.entries(ZHONGSHAN_WIKI_REIGNS)) {
    const key = normalizeTitle(title);
    const existing = byTitle.get(key);
    if (existing) {
      Object.assign(existing, patch, { complete: true });
    } else {
      rulers.push({
        title,
        name: patch.name ?? "",
        start: patch.start,
        end: patch.end,
        complete: true,
        startDateConfidence: patch.startDateConfidence,
        endDateConfidence: patch.endDateConfidence,
      });
    }
  }
  return dedupePreserveOrder(rulers).sort((a, b) => a.start - b.start || a.end - b.end);
}

function parseState(keyword, dynastyId, extra = {}) {
  const chunk = sectionText(mainText, keyword);
  let rulers = parseWikiTables(chunk, { dynastyId, includeLeaderTable: extra.includeLeaderTable ?? false });
  if (extra.keepFromTitle) {
    const idx = rulers.findIndex((r) => r.title.includes(extra.keepFromTitle));
    if (idx >= 0) rulers = rulers.slice(idx);
  }
  if (extra.minStart != null) rulers = rulers.filter((r) => r.end == null || r.end >= extra.minStart);
  if (extra.maxStart != null) rulers = rulers.filter((r) => r.start == null || r.start <= extra.maxStart);
  return rulers.map((r) => ({
    ...r,
    name: extra.skipSurname
      ? extractGivenName(r.name) || extractGivenName(r.title) || ""
      : withSurname(dynastyId, r.name, r.title),
  }));
}

function normalizeForDedup(text) {
  return normalizeTitle(text)
    .replace(/晉/g, "晋")
    .replace(/厲/g, "厉")
    .replace(/齊/g, "齐")
    .replace(/魯/g, "鲁")
    .replace(/韓/g, "韩")
    .replace(/趙/g, "赵")
    .replace(/鮒/g, "鲋")
    .replace(/魴/g, "鲂");
}

function dedupePreserveOrder(rulers) {
  const seen = new Set();
  const out = [];
  for (const r of rulers) {
    const key = `${normalizeForDedup(r.title)}|${normalizeForDedup(r.name)}|${r.start}|${r.end}`;
    if (seen.has(key)) continue;
    seen.add(key);
    out.push(r);
  }
  return out;
}

function dedupeReigns(rulers) {
  return dedupePreserveOrder(rulers).sort((a, b) => a.start - b.start || a.end - b.end);
}

function mergeFoundingRulers(dynastyId, rulers) {
  const patches = FOUNDING_RULER_PATCHES[dynastyId] ?? [];
  if (patches.length === 0) return rulers;
  const patchedTitles = new Set(patches.map((r) => normalizeTitle(r.title)));
  const rest = rulers.filter((r) => !patchedTitles.has(normalizeTitle(r.title)));
  const merged = patches.map((r) => ({
    ...r,
    complete: true,
    name: withSurname(dynastyId, r.name, r.title),
  }));
  return dedupeReigns([...merged, ...rest]);
}

function mergeSamePersonSpans(rulers) {
  const out = [];
  for (const r of [...rulers].sort((a, b) => a.start - b.start || a.end - b.end)) {
    const prev = out.find(
      (item) =>
        r.name &&
        item.name &&
        r.name === item.name &&
        item.end != null &&
        r.start != null &&
        r.start - item.end <= 2 &&
        r.start - item.end >= -1,
    );
    if (prev) {
      prev.end = Math.max(prev.end, r.end);
      if (/[王公侯]$/.test(r.title) && !/[王公侯]$/.test(prev.title)) prev.title = r.title;
      else if (r.title.length > prev.title.length) prev.title = r.title;
      continue;
    }
    out.push({ ...r });
  }
  return out.sort((a, b) => a.start - b.start);
}

function posthumousFromTitle(title) {
  const t = normalizeTitle(title);
  if (/公孙|公子|安孺子/.test(t)) return null;
  const stripped = t.replace(/^(齐|晋|楚|燕|宋|鲁|卫|郑|曹|吴|越|韩|赵|魏|秦|中山|田)/, "");
  if (!stripped || stripped === t) {
    if (/[公王侯]$/.test(t)) return t;
    return null;
  }
  if (/^(太公|桓公|武公|文公|庄王|惠王|昭王|襄王)$/.test(stripped) || /[公王侯伯叔]$/.test(stripped)) {
    return stripped;
  }
  return null;
}

function nameWithoutDynastyPrefix(dynastyId, name) {
  const prefix = personNamePrefix(dynastyId);
  if (prefix && name.startsWith(prefix) && name.length > prefix.length) {
    return name.slice(prefix.length);
  }
  return name;
}

function makePersonId(dynastyId, title, name, index) {
  const titleKey = normalizeTitle(title);
  const nameKey = normalizeTitle(name);
  const override =
    PERSON_OVERRIDES[`${titleKey}|${nameKey}`] ||
    PERSON_OVERRIDES[`${titleKey}|${nameWithoutDynastyPrefix(dynastyId, nameKey)}`];
  if (override) {
    if (override === "jiang-xiaobai" && /田/.test(name)) return "tian-wu";
    if (override === "lv-shang" && /田/.test(name)) return "tian-he";
    return override;
  }
  const prefix = dynastyId === "wei-weiguo" ? "weiguo" : dynastyId.split("-")[0];
  return `${prefix}-r${index}`;
}

function resolvePersonDisplayName(title, name) {
  const posthumous = posthumousFromTitle(title);
  const normalizedTitle = normalizeTitle(title);
  const normalizedName = normalizeTitle(name || "");
  if (!normalizedName || normalizedName === normalizedTitle) {
    return posthumous || title;
  }
  return name;
}

/** When wiki has no given name, prefix ancestral 姓 + posthumous (燕襄公 → 姬襄公). */
function clanNameWhenOnlyPosthumous(dynastyId, personName, title) {
  const surname = personNamePrefix(dynastyId);
  if (!surname) return personName;
  const posthumous = posthumousFromTitle(title);
  if (!posthumous) return personName;
  const name = normalizeTitle(personName ?? "");
  const titleNorm = normalizeTitle(title);
  if (!name || name === titleNorm || name === posthumous) {
    if (name.startsWith(surname)) return personName;
    return `${surname}${posthumous}`;
  }
  return personName;
}

function enrichRulers(dynastyId, rulers) {
  const usedIds = new Set();
  return rulers.map((r, index) => {
    let personId = r.personId ?? makePersonId(dynastyId, r.title, r.name || r.title, index);
    if (usedIds.has(personId)) personId = `${personId}-${index}`;
    usedIds.add(personId);
    const titleKey = normalizeTitle(r.title);
    const wikiNameKey = `${titleKey}|${normalizeTitle(r.name)}`;
    const explicitName =
      NAME_OVERRIDES[personId] ||
      NAME_OVERRIDES[PERSON_OVERRIDES[wikiNameKey]] ||
      TITLE_NAME_OVERRIDES[dynastyId]?.[titleKey];
    const resolvedName =
      explicitName ??
      clanNameWhenOnlyPosthumous(
        dynastyId,
        resolvePersonDisplayName(r.title, r.name),
        r.title,
      );
    const posthumousName = posthumousFromTitle(r.title);
    const override =
      REIGN_PREFERRED_APPELLATION_OVERRIDES[`${personId}|${dynastyId}`];
    const derivedRegnal = !posthumousName && !override
      ? preQinRegnalCardName(
          r.title,
          STATE_PREFIX[dynastyId],
          resolvedName,
          clanHintForPerson(dynastyId, personId, resolvedName),
        )
      : null;
    const title = override?.name ?? derivedRegnal ?? r.title;
    return {
      dynastyId,
      personId,
      title,
      personName: resolvedName,
      posthumousName,
      startYear: r.start,
      endYear: r.end,
      startDateConfidence: r.startDateConfidence ?? undefined,
      endDateConfidence: r.endDateConfidence ?? undefined,
      claimTrack: r.claimTrack ?? null,
      claimLabel: r.claimLabel ?? null,
      claimRole: r.claimRole ?? null,
    };
  });
}

const DYNASTY_SOURCES = {
  "qi-chunqiu": () => parseQi(),
  "jin-chunqiu": () => parseState("晋国", "jin-chunqiu"),
  "chu-chunqiu": () => parseState("楚国", "chu-chunqiu", { keepFromTitle: "熊绎" }),
  "yan-chunqiu": () => parseState("燕国", "yan-chunqiu"),
  "song-chunqiu": () => parseState("宋国", "song-chunqiu"),
  "lu-chunqiu": () => parseState("鲁国", "lu-chunqiu"),
  "wei-weiguo": () => parseState("卫国", "wei-weiguo"),
  "zheng-chunqiu": () => parseState("郑国", "zheng-chunqiu"),
  "cao-chunqiu": () => parseState("曹国", "cao-chunqiu"),
  "wu-chunqiu": () => parseWu(),
  "yue-chunqiu": () => parseState("越国", "yue-chunqiu", { skipSurname: true }),
  zhongshan: () => finalizeZhongshanRulers(parseZhongshan()),
  "han-warring": () =>
    trimToIndependentState(
      parseState("韩国", "han-warring", { maxStart: -230 }).filter(
        (r) => r.start <= -230 && r.end >= WARRING_STATE_FOUNDING_YEAR,
      ),
    ),
  "zhao-warring": () =>
    trimToIndependentState(
      parseState("赵国", "zhao-warring", { maxStart: -222 })
        .filter((r) => r.start <= -222 && r.end >= WARRING_STATE_FOUNDING_YEAR)
        .map((r) => ({
          ...r,
          name: withSurname("zhao-warring", r.name, r.title),
        })),
    ),
  "wei-warring": () =>
    trimToIndependentState(mergeSamePersonSpans(parseState("魏国", "wei-warring"))),
  qin: () => parseQin(),
};

const BAD_NAME = /出土|原名|之子|改称|称號|称号|别名|又名|又称|或作|一名|一作|\(|\{/;

/** Expected Song given names (wiki 国君姓名 + 子/戴 prefix). Key: title|startYear */
const SONG_EXPECTED_NAMES = {
  "宋微子|-1034": "子启",
  "宋微仲|-1009": "子衍",
  "宋公稽|-984": "子稽",
  "宋丁公|-959": "子申",
  "宋湣公|-934": "子共",
  "宋炀公|-909": "子熙",
  "宋厉公|-884": "子鲋祀",
  "宋釐公|-858": "子举",
  "宋惠公|-830": "子覵",
  "宋哀公|-800": "子哀公",
  "宋戴公|-799": "子白",
  "宋武公|-765": "子司空",
  "宋宣公|-747": "子力",
  "宋穆公|-728": "子和",
  "宋殇公|-719": "子与夷",
  "宋庄公|-710": "子冯",
  "宋闵公|-691": "子捷",
  "宋公游|-682": "子游",
  "宋桓公|-681": "子御说",
  "宋襄公|-650": "子兹甫",
  "宋成公|-636": "子王臣",
  "宋公御|-620": "子御",
  "宋昭公|-619": "子杵臼",
  "宋文公|-610": "子鲍革",
  "宋共公|-588": "子瑕",
  "宋平公|-575": "子成",
  "宋元公|-531": "子佐",
  "宋景公|-516": "子头曼",
  "宋昭公|-469": "子特",
  "宋悼公|-403": "子购由",
  "宋休公|-385": "子田",
  "宋桓公|-362": "子辟兵",
  "宋剔成君|-355": "子喜",
  "宋康王|-328": "子偃",
};

const byDynasty = {};
let total = 0;
const problems = [];
for (const [dynastyId, fn] of Object.entries(DYNASTY_SOURCES)) {
  const parsed =
    dynastyId === "zhongshan"
      ? fn()
      : fillUndatedYears(mergeFoundingRulers(dynastyId, fn()), dynastyId);
  const dated = applyReignYearOverrides(dynastyId, parsed);
  applyDeathYearToPredecessor(dated);
  const raw = markInterpolatedBoundaries(dated).sort(
    (a, b) => a.start - b.start || a.end - b.end,
  );
  const enriched = applyMultiReignRulers(dynastyId, enrichRulers(dynastyId, raw), {
    spanExpansions: MULTI_REIGN_SPAN_EXPANSIONS,
  });
  enriched.push(...(CURATED_REIGN_ADDITIONS[dynastyId] ?? []));
  applyDeathYearToPredecessor(enriched);
  enriched.sort(
    (a, b) => a.startYear - b.startYear || a.endYear - b.endYear,
  );
  byDynasty[dynastyId] = enriched;
  total += enriched.length;
  const at522 = enriched.find((r) => r.startYear <= -522 && r.endYear >= -522);
  console.log(`${dynastyId}: ${enriched.length} rulers, at -522: ${at522?.title ?? "—"} ${at522?.personName ?? ""}`);
  for (const r of enriched) {
    if (dynastyId === "song-chunqiu") {
      const expected = SONG_EXPECTED_NAMES[`${normalizeTitle(r.title)}|${r.startYear}`];
      if (expected && r.personName !== expected) {
        problems.push(`song name ${r.title} (${r.startYear}): got ${r.personName}, want ${expected}`);
      }
    }
    if (BAD_NAME.test(r.personName) || BAD_NAME.test(r.title)) {
      problems.push(`${dynastyId} ${r.title} / ${r.personName}`);
    }
    if (r.personName.length > 8 && /[\u4e00-\u9fff]/.test(r.personName) === false) {
      problems.push(`non-cjk name ${dynastyId} ${r.personName}`);
    }
    const yrs = r.endYear - r.startYear + 1;
    if (
      yrs > MAX_PLAUSIBLE_REIGN_YEARS &&
      r.startDateConfidence !== "interpolated" &&
      r.endDateConfidence !== "interpolated"
    ) {
      problems.push(`long reign ${yrs}y ${dynastyId} ${r.title} ${r.startYear}–${r.endYear}`);
    }
  }
}

if (problems.length) {
  console.error("Suspicious names:\n" + problems.slice(0, 40).join("\n"));
  process.exit(1);
}

const output = `// Auto-generated by build-rulers.mjs — do not edit manually
// Source: Wikipedia 周朝诸侯国君主列表 + 吴国 + 齐国/秦国君主列表 (Shiji chronology)
export const rulersByDynasty = ${JSON.stringify(byDynasty, null, 2)};

export const rulerStats = {
  dynasties: ${Object.keys(byDynasty).length},
  reigns: ${total},
  generatedAt: "${new Date().toISOString().slice(0, 10)}",
};
`;

writeFileSync(path.join(__dirname, "rulers.mjs"), output);
console.log(`\nWrote rulers.mjs: ${total} reigns across ${Object.keys(byDynasty).length} dynasties`);
