#!/usr/bin/env node
/**
 * Supplement famous Three Kingdoms battles and key commanders.
 * Guandu / chibi / yiling are in three-kingdoms-warlord; this pack adds other famous battles.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { person, eventPoint, eventRange, writeImportPackage, ym } from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  person(
    "guan-yu",
    "关羽",
    ["将领"],
    "蜀汉名将，襄樊之战北伐曹魏，兵败被俘遇害。",
    "关羽",
    ym(160),
    ym(220, 1),
  ),
  person(
    "zhang-fei",
    "张飞",
    ["将领"],
    "蜀汉名将，长坂之战掩护刘备撤退，后镇守阆中。",
    "张飞",
    ym(168),
    ym(221, 6),
  ),
  person(
    "lu-xun",
    "陆逊",
    ["军事家", "政治家"],
    "孙吴名将，夷陵之战、石亭之战主将，后官至丞相。",
    "陆逊",
    ym(183),
    ym(245, 8),
  ),
  person(
    "huang-zhong",
    "黄忠",
    ["将领"],
    "蜀汉名将，定军山斩夏侯渊，助刘备夺取汉中。",
    "黄忠",
    null,
    ym(220),
  ),
  person(
    "xiahou-yuan",
    "夏侯渊",
    ["将领"],
    "曹魏名将，镇守汉中，定军山之战阵亡。",
    "夏侯渊",
    null,
    ym(219, 1),
  ),
  person(
    "zhang-liao",
    "张辽",
    ["将领"],
    "曹魏名将，逍遥津之战以八百破孙权十万。",
    "张辽",
    ym(169),
    ym(222, 9),
  ),
  person(
    "cao-ren",
    "曹仁",
    ["将领"],
    "曹魏名将，镇守樊城，襄樊之战拒关羽。",
    "曹仁",
    ym(168),
    ym(223, 4),
  ),
  person(
    "ma-su",
    "马谡",
    ["将领"],
    "蜀汉将领，街亭之战违诸葛亮节度，兵败被斩。",
    "马谡",
    null,
    ym(228),
  ),
  person(
    "zhang-he",
    "张郃",
    ["将领"],
    "曹魏名将，街亭之战击败马谡。",
    "张郃",
    null,
    ym(231, 8),
  ),
  person(
    "cao-xiu",
    "曹休",
    ["将领"],
    "曹魏宗室将领，石亭之战大败于陆逊。",
    "曹休",
    null,
    ym(228, 6),
  ),
];

// ── events ───────────────────────────────────────────────────────────────────

const events = [
  eventPoint({
    id: "changban",
    name: "长坂之战",
    kind: "battle",
    precision: "year",
    dateNote: "建安十三年，208年，刘备南逃于长坂遭曹军追击",
    at: ym(208),
    dynastyIds: ["han-east"],
    participantIds: ["liu-bei", "cao-cao", "zhang-fei", "zhuge-liang"],
    summary: "曹操南下荆州，刘备携百姓南奔，于长坂遭曹军追上；张飞断后，赵云救主，奠定孙刘联盟基础。",
  }),
  eventPoint({
    id: "xiaoyaojin",
    name: "逍遥津之战",
    kind: "battle",
    precision: "month",
    dateNote: "建安二十年七月，张辽八百破孙权",
    at: ym(215, 7),
    dynastyIds: ["wei", "wu"],
    participantIds: ["zhang-liao", "sun-quan", "cao-ren"],
    summary: "张辽率八百壮士夜袭逍遥津，大破孙权军，威震江东。",
  }),
  eventRange({
    id: "hanzhong",
    name: "汉中之战",
    kind: "battle",
    timeMode: "span",
    precision: "month",
    dateNote: "建安二十二年至二十四年五月",
    start: ym(217),
    end: ym(219, 5),
    dynastyIds: ["shu", "wei"],
    participantIds: ["liu-bei", "cao-cao", "huang-zhong", "xiahou-yuan"],
    summary: "刘备与曹操争夺汉中，历时近两年，刘备最终占据汉中并称汉中王。",
  }),
  eventPoint({
    id: "dingjunshan",
    name: "定军山之战",
    kind: "battle",
    precision: "month",
    dateNote: "建安二十四年正月，黄忠斩夏侯渊",
    at: ym(219, 1),
    dynastyIds: ["shu", "wei"],
    participantIds: ["huang-zhong", "xiahou-yuan"],
    summary: "黄忠于定军山斩曹魏大将夏侯渊，汉中战局逆转，刘备军占上风。",
  }),
  eventRange({
    id: "xiangfan",
    name: "襄樊之战",
    kind: "battle",
    timeMode: "span",
    precision: "month",
    dateNote: "建安二十四年七月至十二月",
    start: ym(219, 7),
    end: ym(219, 12),
    dynastyIds: ["shu", "wei"],
    participantIds: ["guan-yu", "cao-ren"],
    summary: "关羽北伐襄樊，水淹七军威震华夏，后遭吕蒙偷袭荆州，兵败被俘遇害。",
  }),
  eventRange({
    id: "ruxu",
    name: "濡须之战",
    kind: "battle",
    timeMode: "span",
    precision: "year",
    dateNote: "黄初三年至四年，222–223年",
    start: ym(222),
    end: ym(223),
    dynastyIds: ["wei", "wu"],
    participantIds: ["sun-quan", "zhang-liao"],
    summary: "曹魏攻吴濡须口，双方对峙数月，最终议和罢兵。",
  }),
  eventPoint({
    id: "jieting",
    name: "街亭之战",
    kind: "battle",
    precision: "year",
    dateNote: "建兴六年春，228年",
    at: ym(228),
    dynastyIds: ["shu", "wei"],
    participantIds: ["zhuge-liang", "ma-su", "zhang-he"],
    summary: "诸葛亮第一次北伐，马谡守街亭违令，兵败于张郃，蜀军被迫撤退。",
  }),
  eventPoint({
    id: "shiting",
    name: "石亭之战",
    kind: "battle",
    precision: "month",
    dateNote: "黄初七年七月，228年",
    at: ym(228, 7),
    dynastyIds: ["wu", "wei"],
    participantIds: ["lu-xun", "cao-xiu"],
    summary: "陆逊于石亭大败曹休，斩获甚众，孙吴北方边境得以巩固。",
  }),
  eventRange({
    id: "wuzhangyuan",
    name: "五丈原之战",
    kind: "battle",
    timeMode: "span",
    precision: "month",
    dateNote: "建兴十二年二月至八月",
    start: ym(234, 2),
    end: ym(234, 8),
    dynastyIds: ["shu", "wei"],
    participantIds: ["zhuge-liang"],
    summary: "诸葛亮最后一次北伐，屯兵五丈原与魏军对峙，八月病逝军中，蜀军退归。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "changban", dynastyId: "wei" },
  { eventId: "changban", dynastyId: "shu" },
];

const supplementalEventParticipants = [
  { eventId: "yiling", personId: "lu-xun" },
  { eventId: "xiangfan", personId: "liu-bei" },
];

// ── relations ────────────────────────────────────────────────────────────────

const relations = [
  { id: "rel-changban-liu-bei", fromRef: "event:changban", toRef: "person:liu-bei", kind: "battle" },
  { id: "rel-xiaoyaojin-zhang-liao", fromRef: "event:xiaoyaojin", toRef: "person:zhang-liao", kind: "battle" },
  { id: "rel-hanzhong-liu-bei", fromRef: "event:hanzhong", toRef: "person:liu-bei", kind: "battle" },
  { id: "rel-dingjunshan-huang-zhong", fromRef: "event:dingjunshan", toRef: "person:huang-zhong", kind: "battle" },
  { id: "rel-xiangfan-guan-yu", fromRef: "event:xiangfan", toRef: "person:guan-yu", kind: "battle" },
  { id: "rel-jieting-zhuge", fromRef: "event:jieting", toRef: "person:zhuge-liang", kind: "battle" },
  { id: "rel-shiting-lu-xun", fromRef: "event:shiting", toRef: "person:lu-xun", kind: "battle" },
  { id: "rel-wuzhangyuan-zhuge", fromRef: "event:wuzhangyuan", toRef: "person:zhuge-liang", kind: "battle" },
  { id: "rel-yiling-lu-xun", fromRef: "event:yiling", toRef: "person:lu-xun", kind: "battle" },
];

const manifest = {
  slug: "three-kingdoms-battles",
  title: "三国著名战役补充",
  window: { startYear: 208, startMonth: 1, endYear: 234, endMonth: 8 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-13",
  counts: {
    persons: persons.length,
    dynasties: 0,
    reigns: 0,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "长坂之战", url: "https://zh.wikipedia.org/wiki/长坂之战" },
    { label: "逍遥津之战", url: "https://zh.wikipedia.org/wiki/逍遥津之战" },
    { label: "汉中之战", url: "https://zh.wikipedia.org/wiki/汉中之战" },
    { label: "定军山之战", url: "https://zh.wikipedia.org/wiki/定军山之战" },
    { label: "襄樊之战", url: "https://zh.wikipedia.org/wiki/樊城之战" },
    { label: "濡须之战", url: "https://zh.wikipedia.org/wiki/濡须之战" },
    { label: "街亭之战", url: "https://zh.wikipedia.org/wiki/街亭之战" },
    { label: "石亭之战", url: "https://zh.wikipedia.org/wiki/石亭之战" },
    { label: "五丈原", url: "https://zh.wikipedia.org/wiki/五丈原" },
    { label: "关羽", url: "https://zh.wikipedia.org/wiki/关羽" },
    { label: "陆逊", url: "https://zh.wikipedia.org/wiki/陆逊" },
    { label: "张辽", url: "https://zh.wikipedia.org/wiki/张辽" },
  ],
  notes: [
    "官渡、赤壁、夷陵已在 three-kingdoms-warlord 包中，本包补充其余著名战役。",
    "长坂之战关联东汉（han-east），并 supplemental 关联魏、蜀割据行。",
    "夷陵之战补充陆逊为参战人物（supplemental participant）。",
    "定军山为汉中之战关键节点，单独建点事件以便检索。",
    "人物生卒据《三国志》及维基百科通行换算，不详处 birth/death 留 NULL。",
  ],
};

writeImportPackage(__dirname, {
  slug: "three-kingdoms-battles",
  window: manifest.window,
  persons,
  dynasties: [],
  reignGroups: [],
  reigns: [],
  events,
  relations,
  supplementalEventDynasties,
  supplementalEventParticipants,
  manifest,
});
