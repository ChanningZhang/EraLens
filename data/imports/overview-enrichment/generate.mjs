#!/usr/bin/env node
/**
 * Enrich short emperor and dynasty overviews from the linked Chinese
 * Wikipedia introductions. The first run freezes the fetched source text in
 * source-records.json; later runs are deterministic and do not hit the web.
 */
import { execFileSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const dir = path.dirname(fileURLToPath(import.meta.url));
const sourcePath = path.join(dir, "source-records.json");
const sqlPath = path.join(dir, "import.sql");

const dynastyWikiTitles = {
  "cao-chunqiu": "曹国",
  "chu-nan": "南楚",
  "han-bei": "北汉",
  "han-hou": "后汉",
  "han-nan": "南汉",
  "jin-hou": "后晋",
  jingnan: "荆南",
  "liang-nan": "南梁",
  "min-fujian": "闽国",
  "qi-nan": "南齐",
  "shu-qian": "前蜀",
  "tang-nan": "南唐",
  wei: "曹魏",
  "wu-shi": "杨吴",
  wuyue: "吴越",
  "zhao-warring": "赵国",
};

function sql(value) {
  if (value == null) return "NULL";
  return `'${String(value).replaceAll("'", "''")}'`;
}

function readDbRows() {
  const query = `
    SELECT 'person' AS kind, p.id, p.name, coalesce(p.bio, ''),
           coalesce((p.links->0->>'url'), ''), min(r.start_year), max(r.end_year), min(d.name)
      FROM persons p
      JOIN reigns r ON r.person_id = p.id
      JOIN dynasties d ON d.id = r.dynasty_id
     WHERE p.id <> 'system-missing-ruler'
     GROUP BY p.id, p.name, p.bio, p.links
    HAVING char_length(coalesce(p.bio, '')) < 20
    UNION ALL
    SELECT 'dynasty', id, name, coalesce(note, ''), '', start_year, end_year, name
      FROM dynasties
     WHERE char_length(coalesce(note, '')) < 20
     ORDER BY 1, 2`;
  const out = execFileSync(
    "docker",
    ["exec", "eralens-postgres", "psql", "-U", "eralens", "-d", "eralens", "-P", "pager=off", "-At", "-F", "\t", "-c", query],
    { encoding: "utf8" },
  );
  return out.trim().split("\n").filter(Boolean).map((line) => {
    const [kind, id, name, current, url, startYear, endYear, dynastyName] = line.split("\t");
    return { kind, id, name, current, url, startYear, endYear, dynastyName };
  });
}

function titleFromUrl(url) {
  if (!url) return null;
  const part = url.split("/wiki/")[1];
  return part ? decodeURIComponent(part) : null;
}

function yearText(value) {
  const year = Number(value);
  return year < 0 ? `前${Math.abs(year)}年` : `${year}年`;
}

function cleanExtract(text, title) {
  let value = text
    .trimStart()
    .replace(/^(?:left|right|thumb|缩略图)\|[^。！？\n]{0,160}/i, "")
    .replace(/^(?:[，。；：、]|\([^)]*\)|（[^）]*）)+/, "")
    .replace(/\[[^\]]+\]/g, "")
    .replace(/（\s*）|\(\s*\)/g, "")
    .replace(/\s+/g, " ")
    .trim();
  if (title && value.startsWith(title)) value = value.slice(title.length).trim();
  value = value.replace(/^（[^）]{0,50}）\s*/, "");
  const sentences = value
    .split(/(?<=[。！？])/)
    .map((item) => item.trim())
    .filter((item) => item.length >= 8 && !/^提示：|^目录|^参考/.test(item));
  let result = sentences.slice(0, 2).join("");
  result = result.replace(/^(?:[，。；：、]|（[^）]*）|\([^)]*\))+/g, "").trim();
  if (result.length > 140) {
    result = result.slice(0, 140).replace(/[，、；：]$/, "");
  }
  return result.endsWith("。") || result.endsWith("！") || result.endsWith("？") ? result : `${result}。`;
}

const wait = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function fetchIntro(title, attempt = 0) {
  const endpoint = `https://zh.wikipedia.org/wiki/Special:Export/${encodeURIComponent(title)}`;
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 6000);
  let response;
  try {
    response = await fetch(endpoint, { headers: { "User-Agent": "EraLens/1.0 historical-data-import" }, signal: controller.signal });
  } catch (error) {
    if (attempt < 2) {
      await wait(1500 * (attempt + 1));
      return fetchIntro(title, attempt + 1);
    }
    return null;
  } finally {
    clearTimeout(timeout);
  }
  if ((response.status === 429 || response.status >= 500) && attempt < 2) {
    await wait(3000 * (attempt + 1));
    return fetchIntro(title, attempt + 1);
  }
  if (response.status === 429 || response.status >= 500) return null;
  if (response.status === 404) return null;
  if (!response.ok) throw new Error(`Wikipedia API ${response.status}: ${title}`);
  const xml = await response.text();
  const match = xml.match(/<text[^>]*>([\s\S]*?)<\/text>/i);
  if (!match) return null;
  const text = match[1]
    .replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, '"')
    .replace(/&apos;/g, "'").replace(/&amp;/g, "&");
  let lead = text.split(/\n==[^=]/)[0];
  for (let i = 0; i < 8; i += 1) lead = lead.replace(/\{\{[^{}]*\}\}/g, "");
  lead = lead
    .replace(/\{\{[\s\S]*?\}\}/g, "")
    .replace(/<ref[^>]*>[\s\S]*?<\/ref>/gi, "")
    .replace(/<ref[^>]*\/>/gi, "")
    .replace(/<!--[\s\S]*?-->/g, "")
    .replace(/^\s*\|[^\n]*$/gm, "")
    .replace(/^\s*(thumb|left|right|File|文件):[^\n]*$/gim, "")
    .replace(/^(?:left|right|thumb)\|[^。！？\n]{0,120}/i, "")
    .replace(/^\s*#REDIRECT.*$/gim, "")
    .replace(/'''?/g, "")
    .replace(/\[\[([^\]|]+)\|([^\]]+)\]\]/g, "$2")
    .replace(/\[\[([^\]]+)\]\]/g, "$1")
    .replace(/\[https?:\/\/[^\s]+\s+([^\]]+)\]/g, "$1");
  return cleanExtract(lead, title);
}

async function collect() {
  const rows = readDbRows();
  const result = [];
  for (let offset = 0; offset < rows.length; offset += 10) {
    const batch = rows.slice(offset, offset + 10);
    const fetched = await Promise.all(batch.map(async (row) => {
      const title = row.kind === "dynasty" ? dynastyWikiTitles[row.id] : (titleFromUrl(row.url) ?? row.name);
      if (!title) return null;
      const fetchedBio = await fetchIntro(title, 2);
      const span = row.startYear && row.endYear ? `（${yearText(row.startYear)}—${yearText(row.endYear)}）` : "";
      const bio = fetchedBio && fetchedBio.length >= 20
        ? fetchedBio
        : row.kind === "dynasty"
          ? `${row.current}${span}`
          : `${row.current}${row.dynastyName ? `在${row.dynastyName}${span}在位。` : span}`;
      return { kind: row.kind, id: row.id, name: row.name, title, source: `https://zh.wikipedia.org/wiki/${encodeURIComponent(title).replaceAll("%2F", "/")}`, bio, fallback: !fetchedBio || fetchedBio.length < 20 };
    }));
    result.push(...fetched.filter(Boolean));
    await wait(1000);
  }
  writeFileSync(sourcePath, `${JSON.stringify(result, null, 2)}\n`, "utf8");
  return result;
}

async function main() {
  mkdirSync(dir, { recursive: true });
  const records = existsSync(sourcePath) ? JSON.parse(readFileSync(sourcePath, "utf8")) : await collect();
  const lines = ["BEGIN;", ""];
  for (const record of records) {
    const table = record.kind === "person" ? "persons" : "dynasties";
    const column = record.kind === "person" ? "bio" : "note";
    lines.push(`UPDATE ${table} SET ${column} = ${sql(record.bio)} WHERE id = ${sql(record.id)};`);
  }
  lines.push("", "COMMIT;", "");
  writeFileSync(sqlPath, lines.join("\n"), "utf8");
  writeFileSync(path.join(dir, "manifest.json"), `${JSON.stringify({
    slug: "overview-enrichment",
    description: "补全当前概述少于20字的帝王与王朝信息。",
    sources: [...new Set(records.map((record) => record.source))],
    notes: ["优先使用中文维基百科导言最多两句；未匹配到条目的记录仅补充数据库中已核对的在位跨度，并标记 fallback。"],
  }, null, 2)}\n`, "utf8");
  console.log(`generated ${records.length} overview updates`);
}

main().catch((error) => { console.error(error); process.exitCode = 1; });
