#!/usr/bin/env node
/**
 * Model Wei / Shu / Wu as post-Chibi warlord polities (208–).
 * Yuan Shao and Liu Zhang remain persons only (no separatist dynasty rows).
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import { defaultPreferredAppellation } from "../lib/defaultPreferredAppellation.mjs";
import {
  person,
  reign,
  eras,
  eventPoint,
  eventRange,
  writeImportPackage,
  ym,
  successionPairs,
} from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const CHIBI = ym(208, 12);

function dynastyReignMonth(
  id,
  dynastyId,
  personId,
  title,
  posthumous,
  temple,
  startYear,
  startMonth,
  endYear,
  endMonth,
  eraList = [],
  preferred = null,
) {
  const pref =
    preferred ??
    defaultPreferredAppellation({
      title,
      posthumous,
      temple,
      startYear,
      eraNames: eraList.length ? eras(id, eraList) : [],
    });
  return reign({
    id,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    preferred: pref,
    start: ym(startYear, startMonth),
    end: ym(endYear, endMonth),
    eraNames: eraList.length ? eras(id, eraList) : [],
    precision: "month",
  });
}

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  person(
    "liu-zhang",
    "刘璋",
    ["军阀"],
    "益州牧，刘焉之子；引刘备入蜀后失益州，东汉末地方势力。",
    "刘璋",
    ym(176),
    ym(219),
  ),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "wei",
    name: "曹魏",
    altNames: ["魏"],
    scope: "cn",
    region: "east_asia",
    start: CHIBI,
    end: ym(266, 2),
    precision: "month",
    colorToken: "indigo",
    orthodoxFromAbs: ym(220, 12).abs,
    note: "赤壁战后曹操据北方为割据；216年封魏王，220年曹丕称帝。王朝行自208年赤壁后与东汉并行。",
  },
  {
    id: "shu",
    name: "蜀汉",
    altNames: ["蜀", "季汉"],
    scope: "cn",
    region: "east_asia",
    start: CHIBI,
    end: ym(263, 11),
    precision: "month",
    colorToken: "moss",
    note: "赤壁战后孙刘联盟中刘备一系；219年称汉中王，221年称帝。王朝行自208年赤壁后与东汉并行。",
  },
  {
    id: "wu",
    name: "孙吴",
    altNames: ["吴"],
    scope: "cn",
    region: "east_asia",
    start: CHIBI,
    end: ym(280, 5),
    precision: "month",
    colorToken: "mineral",
    note: "赤壁战后孙权据江东为割据；222年称吴王，229年称帝。王朝行自208年赤壁后与东汉并行。",
  },
];

// ── reigns ─────────────────────────────────────────────────────────────────

const weiReigns = [
  dynastyReignMonth(
    "reign-cao-cao-wei",
    "wei",
    "cao-cao",
    "丞相",
    "武皇帝",
    "太祖",
    208,
    12,
    220,
    3,
    [],
    { kind: "posthumous", name: "魏武帝" },
  ),
  dynastyReignMonth(
    "reign-cao-pi-king",
    "wei",
    "cao-pi",
    "魏王",
    null,
    null,
    220,
    3,
    220,
    12,
    [],
    { kind: "regnal", name: "魏王" },
  ),
  dynastyReignMonth(
    "reign-cao-pi",
    "wei",
    "cao-pi",
    "魏文帝",
    "文皇帝",
    "高祖",
    220,
    12,
    226,
    6,
    [{ name: "黄初", sy: 220, sm: 12, ey: 226, em: 6 }],
    { kind: "posthumous", name: "魏文帝" },
  ),
];

const shuReigns = [
  dynastyReignMonth(
    "reign-liu-bei-warlord",
    "shu",
    "liu-bei",
    "左将军",
    null,
    null,
    208,
    12,
    221,
    4,
  ),
  dynastyReignMonth(
    "reign-liu-bei",
    "shu",
    "liu-bei",
    "昭烈帝",
    "昭烈皇帝",
    "烈祖",
    221,
    5,
    223,
    6,
    [{ name: "章武", sy: 221, sm: 5, ey: 223, em: 6 }],
  ),
];

const wuReigns = [
  dynastyReignMonth(
    "reign-sun-quan-warlord",
    "wu",
    "sun-quan",
    "吴侯",
    null,
    null,
    208,
    12,
    222,
    9,
  ),
  dynastyReignMonth(
    "reign-sun-quan",
    "wu",
    "sun-quan",
    "大皇帝",
    "大皇帝",
    "太祖",
    222,
    10,
    252,
    4,
    [{ name: "黄武", sy: 222, sm: 10, ey: 229, em: 4 }],
  ),
];

const reignGroups = [weiReigns, shuReigns, wuReigns];
const reigns = applyDocumentedDatesToReigns(reignGroups.flat());

// ── events ───────────────────────────────────────────────────────────────────

const events = [
  eventPoint({
    id: "guandu",
    name: "官渡之战",
    kind: "battle",
    precision: "month",
    dateNote: "建安五年六月，曹操大败袁绍",
    at: ym(200, 6),
    dynastyIds: ["wei"],
    participantIds: ["cao-cao", "yuan-shao"],
    summary: "曹操以少胜多，大败袁绍，奠定统一北方基础。",
  }),
  eventPoint({
    id: "chibi",
    name: "赤壁之战",
    kind: "battle",
    precision: "month",
    dateNote: "建安十三年十二月，孙刘联军大败曹操",
    at: CHIBI,
    dynastyIds: ["wei", "shu", "wu"],
    participantIds: ["cao-cao", "liu-bei", "sun-quan", "zhuge-liang", "zhou-yu"],
    summary: "孙刘联军于赤壁大败曹操，三国鼎立格局初步形成。",
  }),
  eventPoint({
    id: "liu-bei-takes-yizhou",
    name: "刘备取益州",
    kind: "politics",
    precision: "year",
    dateNote: "建安十九年，214年",
    at: ym(214),
    dynastyIds: ["shu"],
    participantIds: ["liu-bei", "liu-zhang"],
    summary: "刘备围成都，刘璋出降，益州归刘备。",
  }),
  eventRange({
    id: "yiling",
    name: "夷陵之战",
    kind: "battle",
    timeMode: "span",
    precision: "month",
    dateNote: "章武元年七月至二年八月",
    start: ym(221, 7),
    end: ym(222, 8),
    dynastyIds: ["shu", "wu"],
    participantIds: ["liu-bei", "sun-quan"],
    summary: "刘备伐吴复仇，于夷陵大败，蜀汉元气大伤。",
  }),
];

const supplementalEventDynasties = [];

const preSql = [
  "DELETE FROM event_dynasties WHERE dynasty_id IN ('yuan-hebei', 'yizhou-liu');",
  "DELETE FROM reigns WHERE id IN ('reign-yuan-shao-hebei', 'reign-liu-zhang-yizhou');",
  "DELETE FROM dynasties WHERE id IN ('yuan-hebei', 'yizhou-liu');",
].join("\n");

// ── relations ────────────────────────────────────────────────────────────────

const relations = [];
for (const group of reignGroups) {
  for (const [fromId, toId] of successionPairs(group)) {
    relations.push({
      id: `rel-${fromId}-${toId}-succession`,
      fromRef: `person:${fromId}`,
      toRef: `person:${toId}`,
      kind: "succession",
    });
  }
}
relations.push(
  { id: "rel-guandu-cao-cao", fromRef: "event:guandu", toRef: "person:cao-cao", kind: "battle" },
  { id: "rel-chibi-cao-cao", fromRef: "event:chibi", toRef: "person:cao-cao", kind: "battle" },
  { id: "rel-chibi-zhuge", fromRef: "event:chibi", toRef: "person:zhuge-liang", kind: "battle" },
  { id: "rel-yiling-liu-bei", fromRef: "event:yiling", toRef: "person:liu-bei", kind: "battle" },
);

const manifest = {
  slug: "three-kingdoms-warlord",
  title: "三国割据：赤壁后魏蜀吴",
  window: { startYear: 208, startMonth: 12, endYear: 280, endMonth: 5 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-13",
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "赤壁之战", url: "https://zh.wikipedia.org/wiki/赤壁之战" },
    { label: "曹魏", url: "https://zh.wikipedia.org/wiki/曹魏" },
    { label: "蜀汉", url: "https://zh.wikipedia.org/wiki/蜀汉" },
    { label: "孙吴", url: "https://zh.wikipedia.org/wiki/孙吴" },
    { label: "刘璋", url: "https://zh.wikipedia.org/wiki/刘璋" },
    { label: "曹操", url: "https://zh.wikipedia.org/wiki/曹操" },
  ],
  notes: [
    "魏蜀吴王朝行起点取208年12月赤壁战后，与东汉（至220年12月）并行展示。",
    "wei 的 orthodox_from_abs 仍为220年12月曹丕称帝；shu、wu 为割据政权。",
    "袁绍（yuan-shao）、刘璋（liu-zhang）仅作人物收录，不建割据王朝行。",
    "曹操、刘备、孙权各拆为割据期与称帝/称王期两段 reign；曹丕另拆魏王嗣位（220-3-15）与称帝（220-12-11）两段；曹叡及以后见 seed 与 three-kingdoms-late 包。",
    "在位起止日经 documentedReignDates 提升至 day（赤壁起点无日则 month）。",
  ],
};

writeImportPackage(__dirname, {
  slug: "three-kingdoms-warlord",
  window: manifest.window,
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  supplementalEventDynasties,
  preSql,
  manifest,
});
