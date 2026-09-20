#!/usr/bin/env node
/**
 * Fetch Wikipedia zh intro extracts for chunqiu-zhanguo rulers and write ruler-bios.mjs.
 * Uses a local cache so the job can resume after rate limits.
 */
import { readFileSync, writeFileSync, existsSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { rulersByDynasty } from "./rulers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const CACHE_PATH = path.join(__dirname, "ruler-bio-cache.json");
const OUT_PATH = path.join(__dirname, "ruler-bios.mjs");

const DYNASTY_LABELS = {
  "qi-chunqiu": "齐国",
  "jin-chunqiu": "晋国",
  "chu-chunqiu": "楚国",
  "yan-chunqiu": "燕国",
  "song-chunqiu": "宋国",
  "lu-chunqiu": "鲁国",
  "wei-weiguo": "卫国",
  "zheng-chunqiu": "郑国",
  "cao-chunqiu": "曹国",
  "wu-chunqiu": "吴国",
  "yue-chunqiu": "越国",
  zhongshan: "中山",
  "han-warring": "韩国",
  "zhao-warring": "赵国",
  "wei-warring": "魏国",
  qin: "秦国",
};

const SKIP_PERSON_IDS = new Set([
  "lv-shang",
  "song-weizi",
  "jiang-dai",
  "tian-he",
  "song-r16",
  "song-r28",
  "qi-r11",
  "weiguo-r10",
  "weiguo-r21",
  "cao-r11",
  "weiguo-r43",
  "weiguo-r44",
  "weiguo-r45",
  "song-r32",
  "yue-r6",
  "yue-r8",
  "zhongshan-r0",
  "zhongshan-r1",
  "zhongshan-r2",
  "zhongshan-r3",
  "zhongshan-r4",
  "zhongshan-r5",
  "zhongshan-r6",
]);

export const WIKI_TITLE_BY_PERSON_ID = {
  "lv-shang": "姜子牙",
  "song-weizi": "微子",
  "jiang-dai": "齐康公",
  "tian-he": "田和",
  "song-r28": "宋昭公特",
  "qi-r11": "齐庄公",
  "song-r32": "剔成君",
  "yue-r6": "鹿郢",
  "yue-r8": "朱勾",
  "zhongshan-r0": "中山文公",
  "zhongshan-r1": "中山武公",
  "zhongshan-r2": "中山桓公",
  "zhongshan-r3": "中山成公",
  "zhongshan-r4": "中山王厝",
  "zhongshan-r5": "中山王𧊒",
  "zhongshan-r6": "中山王尚",
  "wu-r1": "吴王寿梦",
  "wu-r2": "吴王诸樊",
  "wu-r3": "吴王余祭",
  "wu-r4": "吴王余昧",
  "wu-r5": "吴王阖闾",
  "wu-r6": "吴王夫差",
  "ji-shuyu": "唐叔虞",
  "ji-chonger": "晋文公",
};

function wikiTitleFor(r) {
  return WIKI_TITLE_BY_PERSON_ID[r.personId] ?? r.title;
}

function stripPersonPrefix(name) {
  if (!name) return null;
  return name.replace(/^(子|姜|姬|嬴|芈|妫|曹|风|任|白|允|于|陆|余|诸|句|无|鹿|不|朱|州|与|御|兹|王|鲍|头|辟|购|禄|诸|阖|夫|寿|鹿|州|御|杵|特|喜|窟|尚|厝|𧊒|白|成|武|桓|平|元|景|昭|文|共|成|襄|庄|殇|穆|宣|武|戴|哀|惠|釐|厉|炀|湣|闵|丁|微|公|王|君)+/, "").trim() || name;
}

function toBcYear(year) {
  if (year == null) return null;
  return year < 0 ? `前${Math.abs(year)}年` : `${year}年`;
}

function reignSpanText(startYear, endYear) {
  if (startYear == null || endYear == null) return null;
  if (startYear === endYear) return `${toBcYear(startYear)}在位`;
  return `${toBcYear(startYear)}–${toBcYear(endYear)}在位`;
}

function fallbackBio(r) {
  const state = DYNASTY_LABELS[r.dynastyId] ?? "诸侯国";
  const span = reignSpanText(r.startYear, r.endYear);
  const given = stripPersonPrefix(r.personName);
  const namePart = given && given !== r.title ? `（${given}）` : "";
  if (span) return `${r.title}${namePart}，${state}君主。${span}。`;
  return `${r.title}${namePart}，${state}君主。`;
}

function cleanExtract(text) {
  return text
    .replace(/\[\d+\]/g, "")
    .replace(/\(图\)/g, "")
    .replace(/\s+/g, " ")
    .trim();
}

function stripDisambiguation(text) {
  const m = text.match(/^提示：此条目的主题不是.+?(?=[\u4e00-\u9fff（(])/);
  if (m) return text.slice(m[0].length).trim();
  return text;
}

function splitSentences(text) {
  return text
    .split(/(?<=[。！？])/)
    .map((s) => s.trim())
    .filter((s) => {
      if (s.length < 10) return false;
      if (/^(查|论|编|展开|编辑|参考文献|参见|另见)/.test(s)) return false;
      if (/^提示：/.test(s)) return false;
      if (/^坐标/.test(s)) return false;
      return true;
    });
}

function summarizeExtract(title, extract, ruler) {
  let text = stripDisambiguation(cleanExtract(extract));
  if (!text) return fallbackBio(ruler);

  // Drop leading parenthetical lifespan if present, e.g. （？—前685年）
  text = text.replace(/^（[^）]{0,40}）\s*/, "").replace(/^\([^)]{0,40}\)\s*/, "");

  if (text.startsWith(title)) {
    text = text.slice(title.length).trim();
  }

  const sentences = splitSentences(text);
  if (!sentences.length) return fallbackBio(ruler);

  const picked = [];
  let chars = 0;
  for (const sentence of sentences) {
    if (chars >= 220) break;
    if (/^[（(—－\-~～0-9前至]+[）)]?$/.test(sentence)) continue;
    picked.push(sentence);
    chars += sentence.length;
    if (picked.length >= 2) break;
  }

  let body = picked.join("");
  if (!body.endsWith("。")) body += "。";
  if (body.length < 18) return fallbackBio(ruler);

  const titleCore = title.replace(/^./, "");
  if (!body.includes(titleCore)) {
    return `${title}。${body}`;
  }
  return body;
}

function loadCache() {
  if (!existsSync(CACHE_PATH)) return {};
  return JSON.parse(readFileSync(CACHE_PATH, "utf8"));
}

function saveCache(cache) {
  writeFileSync(CACHE_PATH, JSON.stringify(cache, null, 2), "utf8");
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function fetchOneExtract(title, attempt = 0) {
  const url =
    "https://zh.wikipedia.org/w/api.php?" +
    new URLSearchParams({
      action: "query",
      prop: "extracts",
      exintro: "1",
      explaintext: "1",
      exsentences: "4",
      redirects: "1",
      format: "json",
      origin: "*",
      titles: title,
    });

  const res = await fetch(url, {
    headers: { "User-Agent": "EraLens/1.0 (historical data import; zh-cn)" },
  });
  if (res.status === 429 && attempt < 8) {
    await sleep(3000 * (attempt + 1));
    return fetchOneExtract(title, attempt + 1);
  }
  if (!res.ok) throw new Error(`${title}: Wikipedia API ${res.status}`);
  const data = await res.json();
  const page = Object.values(data.query?.pages ?? {})[0];
  if (!page || page.missing) return "";
  return page.extract ?? "";
}

function writeRulerBios(rulers, bios) {
  const lines = [
    "/**",
    " * Ruler bio overrides (auto-summarized from zh.wikipedia.org).",
    " * Regenerate: node data/imports/chunqiu-zhanguo/fetch-ruler-bios.mjs",
    " */",
    "",
    "export const WIKI_TITLE_BY_PERSON_ID = " + JSON.stringify(WIKI_TITLE_BY_PERSON_ID, null, 2) + ";",
    "",
    "export const RULER_BIO_OVERRIDES = {",
  ];

  for (const r of rulers.sort((a, b) => a.personId.localeCompare(b.personId))) {
    if (SKIP_PERSON_IDS.has(r.personId)) continue;
    const entry = bios[r.personId];
    if (!entry) continue;
    lines.push(`  ${JSON.stringify(r.personId)}: { bio: ${JSON.stringify(entry.bio)} },`);
  }

  lines.push("};", "");
  writeFileSync(OUT_PATH, lines.join("\n"), "utf8");
}

async function main() {
  const cacheOnly = process.argv.includes("--cache-only");
  const rulers = Object.values(rulersByDynasty)
    .flat()
    .filter((r) => !SKIP_PERSON_IDS.has(r.personId));

  const cache = loadCache();
  const uniqueTitles = [...new Set(rulers.map((r) => wikiTitleFor(r)))];
  let fetchedNow = 0;

  if (!cacheOnly) {
    for (let i = 0; i < uniqueTitles.length; i += 1) {
      const title = uniqueTitles[i];
      if (Object.prototype.hasOwnProperty.call(cache, title)) continue;
      cache[title] = await fetchOneExtract(title);
      fetchedNow += 1;
      saveCache(cache);
      if (fetchedNow % 10 === 0) {
        console.log(`cached ${i + 1}/${uniqueTitles.length}: ${title}`);
      }
      await sleep(700);
    }
  } else {
    console.log(`cache-only: ${Object.keys(cache).length} cached titles`);
  }

  const bios = {};
  let fromWiki = 0;
  let fallback = 0;
  for (const r of rulers) {
    const title = wikiTitleFor(r);
    const extract = cache[title] ?? "";
    const bio = extract ? summarizeExtract(r.title, extract, r) : fallbackBio(r);
    if (extract && bio !== fallbackBio(r)) fromWiki += 1;
    else fallback += 1;
    bios[r.personId] = { bio };
  }

  writeRulerBios(rulers, bios);
  console.log(`Wrote ${OUT_PATH}: ${Object.keys(bios).length} bios (${fromWiki} wiki, ${fallback} fallback)`);
}

import { pathToFileURL } from "node:url";

const isMain = process.argv[1] && pathToFileURL(path.resolve(process.argv[1])).href === import.meta.url;

if (isMain) {
  main().catch((err) => {
    console.error(err);
    process.exit(1);
  });
}