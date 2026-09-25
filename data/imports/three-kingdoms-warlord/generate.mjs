#!/usr/bin/env node
/**
 * Model Wei / Shu / Wu from each polity's enthronement (称帝/立国).
 * Yuan Shao and Liu Zhang remain persons only (no separatist dynasty rows).
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
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
const WEI_FOUNDED = ym(220, 12);
const SHU_FOUNDED = ym(221, 5);
const SHU_ENDED = ym(263, 12);
const WU_FOUNDED = ym(222, 10);
const WU_ENDED = ym(280, 5);

const dynastyGroups = [
  {
    id: "sanguo",
    name: "三国",
    altNames: [],
    scope: "cn",
    start: ym(220),
    end: ym(280, 12),
    precision: "year",
    note: "220–280年三国（曹魏、蜀汉、孙吴）；狭义自曹丕代汉至晋灭吴。",
  },
];

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
) {
  return reign({
    id,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    start: ym(startYear, startMonth),
    end: ym(endYear, endMonth),
    eraNames: eraList.length ? eras(id, eraList) : [],
    precision: "month",
  });
}

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  person(
    "cao-cao",
    "曹操",
    ["政治家", "军事家", "文学家"],
    "东汉末权臣，魏武帝（追尊），官渡之战主将。",
    "曹操",
    ym(155),
    ym(220, 3),
  ),
  person(
    "cao-pi",
    "曹丕",
    ["皇帝"],
    "曹魏开国皇帝，魏文帝，受汉献帝禅让。",
    "曹丕",
    ym(187),
    ym(226, 6),
  ),
  person(
    "cao-rui",
    "曹叡",
    ["皇帝"],
    "曹魏第二位皇帝，魏明帝；无子，传位养子曹芳。",
    "曹叡",
    ym(206),
    ym(239, 1),
  ),
  person(
    "liu-bei",
    "刘备",
    ["皇帝"],
    "蜀汉开国皇帝，昭烈帝。",
    "刘备",
    ym(161),
    ym(223, 6),
  ),
  person(
    "liu-shan",
    "刘禅",
    ["皇帝"],
    "蜀汉后主，刘备之子；263年降魏，蜀汉亡。",
    "刘禅",
    ym(207),
    ym(271),
  ),
  person(
    "sun-quan",
    "孙权",
    ["皇帝"],
    "孙吴开国皇帝，先称吴王，后称帝。",
    "孙权",
    ym(182, 7),
    ym(252, 5),
  ),
  person(
    "zhuge-liang",
    "诸葛亮",
    ["政治家", "军事家"],
    "蜀汉丞相，赤壁之战参与者，后主朝北伐。",
    "诸葛亮",
    ym(181),
    ym(234, 8),
  ),
  person(
    "zhou-yu",
    "周瑜",
    ["军事家"],
    "孙吴名将，赤壁之战主将之一。",
    "周瑜",
    ym(175),
    ym(210),
  ),
  person(
    "deng-ai",
    "邓艾",
    ["军事家", "将领"],
    "曹魏将领，景元四年率军由阴平道奇袭江油，参与灭蜀之战。",
    "邓艾",
    ym(197),
    ym(264),
  ),
  person(
    "yuan-shao",
    "袁绍",
    ["军阀"],
    "东汉末北方军阀，官渡之战曹操对手。",
    "袁绍",
    ym(154),
    ym(202, 6),
  ),
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
    start: WEI_FOUNDED,
    end: ym(266, 2),
    precision: "month",
    groupId: "sanguo",
    note: "220年曹丕受禅称帝，代汉建魏。",
  },
  {
    id: "shu",
    name: "蜀汉",
    altNames: ["蜀", "季汉"],
    scope: "cn",
    region: "east_asia",
    start: SHU_FOUNDED,
    end: SHU_ENDED,
    precision: "month",
    groupId: "sanguo",
    note: "221年刘备于成都称帝，国号汉，史称蜀汉。",
  },
  {
    id: "wu",
    name: "孙吴",
    altNames: ["吴"],
    scope: "cn",
    region: "east_asia",
    start: WU_FOUNDED,
    end: WU_ENDED,
    precision: "month",
    groupId: "sanguo",
    note: "222年孙权称吴王，229年称帝；王朝行自称王始。",
  },
];

// ── reigns ─────────────────────────────────────────────────────────────────

const weiReigns = [
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
  ),
  dynastyReignMonth(
    "reign-cao-rui",
    "wei",
    "cao-rui",
    "魏明帝",
    "明皇帝",
    "烈祖",
    226,
    6,
    239,
    1,
    [
      { name: "太和", sy: 227, ey: 233 },
      { name: "青龙", sy: 233, ey: 237 },
      { name: "景初", sy: 237, ey: 239, em: 1 },
    ],
  ),
];

const shuReigns = [
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
  dynastyReignMonth(
    "reign-liu-shan",
    "shu",
    "liu-shan",
    "蜀汉后主",
    "孝怀皇帝",
    null,
    223,
    6,
    263,
    12,
    [
      { name: "建兴", sy: 223, sm: 5, ey: 237 },
      { name: "延熙", sy: 238, ey: 257 },
      { name: "景耀", sy: 258, ey: 263, em: 7 },
      { name: "炎兴", sy: 263, sm: 8, ey: 263, em: 11 },
    ],
  ),
];

const wuReigns = [
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
    dynastyIds: [],
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
    dynastyIds: [],
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
  eventPoint({
    id: "deng-ai-crosses-yinping",
    name: "邓艾偷渡阴平",
    kind: "battle",
    precision: "month",
    dateNote: "景元四年冬十月（263年），邓艾自阴平道行军入蜀",
    at: ym(263, 10),
    dynastyIds: ["wei", "shu"],
    participantIds: ["deng-ai", "liu-shan"],
    summary: "钟会军受阻于剑阁时，邓艾率军由阴平道穿越险阻，进至江油并击败蜀军，迫使蜀汉政权迅速瓦解。",
  }),
];

const supplementalEventDynasties = [];

const preSql = [
  "DELETE FROM event_dynasties WHERE event_id IN ('guandu', 'liu-bei-takes-yizhou');",
  "DELETE FROM event_dynasties WHERE dynasty_id IN ('yuan-hebei', 'yizhou-liu');",
  "DELETE FROM relations WHERE id IN ('rel-cao-cao-cao-pi-succession', 'rel-cao-pi-cao-pi-succession', 'rel-liu-bei-liu-bei-succession', 'rel-sun-quan-sun-quan-succession');",
  "DELETE FROM reigns WHERE id IN ('reign-yuan-shao-hebei', 'reign-liu-zhang-yizhou', 'reign-cao-cao-wei', 'reign-cao-pi-king', 'reign-liu-bei-warlord', 'reign-sun-quan-warlord');",
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
  generatedAt: "2026-09-18",
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "三国", url: "https://zh.wikipedia.org/wiki/三国" },
    { label: "赤壁之战", url: "https://zh.wikipedia.org/wiki/赤壁之战" },
    { label: "曹魏", url: "https://zh.wikipedia.org/wiki/曹魏" },
    { label: "蜀汉", url: "https://zh.wikipedia.org/wiki/蜀汉" },
    { label: "孙吴", url: "https://zh.wikipedia.org/wiki/孙吴" },
    { label: "刘璋", url: "https://zh.wikipedia.org/wiki/刘璋" },
    { label: "曹操", url: "https://zh.wikipedia.org/wiki/曹操" },
    { label: "三国志·魏书·邓艾传", url: "https://zh.wikisource.org/zh-hans/三國志/卷28" },
    { label: "阴平古道（路线与今地）", url: "https://cbgc.scol.com.cn/news/5026693" },
  ],
  notes: [
    "魏蜀吴同属 dynasty_groups.sanguo（狭义 220–280，据中文维基「三国」）；组 span 用年精度，不被成员月精度撑开或截短。",
    "魏蜀吴王朝行分别自曹丕称帝（220-12）、刘备称帝（221-5）、孙权称王（222-10）起；称帝前不建 reign。",
    "wei 的 主线起点 与王朝始年同为 220 年 12 月曹丕称帝。",
    "袁绍（yuan-shao）、刘璋（liu-zhang）仅作人物收录，不建割据王朝行。",
    "曹叡、刘禅在位及年号本包写入；曹芳及孙吴末帝见 three-kingdoms-late。",
    "刘禅降魏日据中文维基 263-12-23，蜀汉王朝行迄月对齐为 263-12。",
    "在位起止日经 documentedReignDates 提升至 day。",
    "邓艾偷渡阴平据《三国志·魏书·邓艾传》‘冬十月，艾自阴平道行无人之地七百余里’；事件定位点采用阴平故城区域（今甘肃文县鹄衣坝附近），不代表整条古道。",
  ],
};

writeImportPackage(__dirname, {
  slug: "three-kingdoms-warlord",
  window: manifest.window,
  persons,
  dynastyGroups,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  supplementalEventDynasties,
  preSql,
  manifest,
});
