#!/usr/bin/env node
/**
 * Generate EraLens import SQL for the Taiping Heavenly Kingdom (太平天国).
 * Sources: 维基百科·太平天国, 洪秀全, 洪天贵福, 天京事变
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  person,
  ym,
  eventPoint,
  writeImportPackage,
  successionPairs,
} from "../lib/sqlHelpers.mjs";
import { drDay, ymDay } from "../lib/reignDateHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const persons = [
  person(
    "hong-xiuquan",
    "洪秀全",
    ["皇帝", "起义领袖"],
    "太平天国创建者，金田起义后称天王，定都天京；同治三年四月二十七日（1864年6月1日）病逝于南京。",
    "洪秀全",
    ym(1814, 1),
    ym(1864, 6),
  ),
  person(
    "hong-tianguifu",
    "洪天贵福",
    ["皇帝"],
    "洪秀全长子，幼天王；洪秀全死后于六月初六继位，天京陷落后被俘处死。",
    "洪天贵福",
    ym(1849, 11),
    ym(1864, 11),
  ),
  person(
    "yang-xiuqing",
    "杨秀清",
    ["政治家", "军事家"],
    "太平天国东王，定都天京后掌军政大权；咸丰六年八月初四（1856年9月2日）天京事变中被北王韦昌辉所杀。",
    "杨秀清",
    ym(1823),
    ym(1856, 9),
  ),
  person(
    "li-xiucheng",
    "李秀成",
    ["军事家", "政治家"],
    "太平天国忠王，后期主持军政；同治三年七月初六（1864年8月7日）城破后被俘处死。",
    "李秀成",
    ym(1823),
    ym(1864, 8),
  ),
  person(
    "shi-dakai",
    "石达开",
    ["军事家"],
    "太平天国翼王，西征名将；咸丰七年出走后转战西南，同治二年五月初十（1863年6月10日）大渡河兵败被俘。",
    "石达开",
    ym(1831),
    ym(1863, 6),
  ),
];

const dynasties = [
  {
    id: "taiping",
    name: "太平天国",
    altNames: ["太平天囯", "天囯"],
    scope: "cn",
    region: "east_asia",
    start: ymDay(1851, 3),
    end: ymDay(1864, 7),
    precision: "month",
    note: "1851年3月23日洪秀全登基称天王、正号太平天国；1853年3月定都天京（南京）；1864年7月19日天京陷落，政权覆亡。与清廷并立，非正统。",
  },
];

const taipingReigns = [
  drDay("taiping", "hong-xiuquan", "天王", null, null, 1851, 3, 23, 1864, 6, 1),
  drDay("taiping", "hong-tianguifu", "幼天王", null, null, 1864, 6, 6, 1864, 7, 19),
];

const reignGroups = [taipingReigns];
const reigns = reignGroups.flat();

const events = [
  eventPoint({
    id: "jintian-uprising",
    name: "金田起义",
    kind: "politics",
    precision: "day",
    dateNote: "咸丰元年十一月十一日，1851年1月11日",
    at: ym(1851, 1),
    dynastyIds: ["taiping"],
    participantIds: ["hong-xiuquan"],
    summary: "洪秀全于广西桂平金田举兵，揭开太平天国运动序幕；称帝建号另见三月登基。",
  }),
  eventPoint({
    id: "hong-xiuquan-enthroned",
    name: "洪秀全登基",
    kind: "politics",
    precision: "day",
    dateNote: "咸丰元年二月二十一日，1851年3月23日，广西武宣",
    at: ym(1851, 3),
    dynastyIds: ["taiping"],
    participantIds: ["hong-xiuquan"],
    summary: "洪秀全于广西武宣登基，称太平天王，后改称天王，正号太平天国。",
  }),
  eventPoint({
    id: "taiping-capital-tianjing",
    name: "定都天京",
    kind: "politics",
    precision: "day",
    dateNote: "咸丰三年二月初十，1853年3月19日攻克江宁；三月十九日洪秀全入城",
    at: ym(1853, 3),
    dynastyIds: ["taiping", "qing"],
    participantIds: ["hong-xiuquan"],
    summary: "太平军攻克江宁，改南京为天京并定都，与清朝形成南北对峙。",
  }),
  eventPoint({
    id: "tianjing-incident",
    name: "天京事变",
    kind: "politics",
    precision: "day",
    dateNote: "咸丰六年八月初四，1856年9月2日东王杨秀清被诛",
    at: ym(1856, 9),
    dynastyIds: ["taiping"],
    participantIds: ["yang-xiuqing", "hong-xiuquan"],
    summary: "北王韦昌辉诛杀东王杨秀清，太平天国领导层内讧，元气大伤。",
  }),
  eventPoint({
    id: "fall-of-tianjing",
    name: "天京陷落",
    kind: "battle",
    precision: "day",
    dateNote: "同治三年六月十六日，1864年7月19日",
    at: ym(1864, 7),
    dynastyIds: ["taiping", "qing"],
    participantIds: ["hong-tianguifu", "li-xiucheng"],
    summary: "湘军攻破天京，幼天王洪天贵福出逃，太平天国政权覆亡。",
  }),
  eventPoint({
    id: "hong-tianguifu-captured",
    name: "幼天王被俘",
    kind: "politics",
    precision: "day",
    dateNote: "同治三年九月二十二日，1864年10月25日，江西石城",
    at: ymDay(1864, 10, 25),
    dynastyIds: ["taiping", "qing"],
    participantIds: ["hong-tianguifu", "zaichun"],
    summary: "湘军追擒幼天王洪天贵福于江西石城，太平天国余绪终结。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "taiping-rebellion", dynastyId: "taiping" },
];

const supplementalEventParticipants = [
  { eventId: "taiping-rebellion", personId: "hong-xiuquan" },
  { eventId: "fall-of-tianjing", personId: "zeng-guofan" },
  { eventId: "hong-tianguifu-captured", personId: "hong-tianguifu" },
  { eventId: "hong-tianguifu-captured", personId: "zaichun" },
];

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
  { id: "rel-jintian-hong", fromRef: "event:jintian-uprising", toRef: "person:hong-xiuquan", kind: "politics" },
  { id: "rel-hong-enthroned", fromRef: "event:hong-xiuquan-enthroned", toRef: "person:hong-xiuquan", kind: "succession" },
  { id: "rel-tianjing-capital", fromRef: "event:taiping-capital-tianjing", toRef: "dynasty:taiping", kind: "politics" },
  { id: "rel-tianjing-incident-yang", fromRef: "event:tianjing-incident", toRef: "person:yang-xiuqing", kind: "politics" },
  { id: "rel-fall-tianjing", fromRef: "event:fall-of-tianjing", toRef: "dynasty:taiping", kind: "battle" },
);

const manifest = {
  slug: "taiping",
  title: "太平天国",
  window: { startYear: 1851, startMonth: 1, endYear: 1864, endMonth: 7 },
  scope: "cn",
  depth: "standard",
  generatedAt: new Date().toISOString().slice(0, 10),
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
    supplementalEventDynastyLinks: supplementalEventDynasties.length,
    supplementalEventParticipantLinks: supplementalEventParticipants.length,
  },
  sources: [
    { label: "太平天国", url: "https://zh.wikipedia.org/wiki/太平天国" },
    { label: "洪秀全", url: "https://zh.wikipedia.org/wiki/洪秀全" },
    { label: "洪天贵福", url: "https://zh.wikipedia.org/wiki/洪天贵福" },
    { label: "天京事变", url: "https://zh.wikipedia.org/wiki/天京事变" },
    { label: "李秀成", url: "https://zh.wikipedia.org/wiki/李秀成" },
  ],
  notes: [
    "收录太平天国王朝行及洪秀全、幼天王洪天贵福在位；与清廷并立，不设正统。",
    "君主在位日取维基百科通行公历换算，precision=day；王朝行仅至月（schema 无 start_day）。",
    "洪秀全在位自 1851-03-23 武宣登基（非金田起义）；至 1864-06-01 病逝。幼天王：1864-06-06 继位至 1864-07-19 天京陷落。",
    "太平天国以干支纪年，不设传统年号，故省略 era_names。",
    "taiping-rebellion 事件沿用 yuan-ming-qing 已有 id，本包补 taiping 王朝与洪秀全参与关联。",
  ],
};

writeImportPackage(__dirname, {
  slug: "taiping",
  window: manifest.window,
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  supplementalEventDynasties,
  supplementalEventParticipants,
  manifest,
});
