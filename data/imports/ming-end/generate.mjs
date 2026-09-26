#!/usr/bin/env node
/**
 * Generate EraLens import SQL for late Ming transitional regimes:
 * Dashun, Daxi, and Ming Zheng (Dongning).
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import {
  person,
  dr,
  ym,
  eras,
  eventPoint,
  writeImportPackage,
  successionPairs,
} from "../lib/sqlHelpers.mjs";
import { ymDay } from "../lib/reignDateHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const persons = [
  person(
    "li-zicheng",
    "李自成",
    ["皇帝", "起义领袖"],
    "明末闯王，1644年在西安称帝建大顺，旋克北京，明亡；次年兵败被杀。",
    "李自成",
    ym(1606, 9),
    ym(1645, 5),
  ),
  person(
    "zhang-xianzhong",
    "张献忠",
    ["皇帝", "起义领袖"],
    "明末农民军领袖，1644年于成都称帝，国号大西；1647年1月2日战死于西充凤凰山。",
    "张献忠",
    ym(1606),
    ym(1647, 1),
  ),
  person(
    "zheng-chenggong",
    "郑成功",
    ["君主", "军事家"],
    "南明延平王，1662年驱逐荷兰、收复台湾，建立明郑东宁政权；同年病逝。",
    "郑成功",
    ym(1624),
    ym(1662, 6),
  ),
  person(
    "zheng-jing",
    "郑经",
    ["君主"],
    "郑成功嫡长子，1662年嗣延平王，据台湾奉永历正朔；1681年卒。",
    "郑经",
    ym(1642, 10),
    ym(1681, 3),
  ),
  person(
    "zheng-keshuang",
    "郑克塽",
    ["君主"],
    "郑经之子，1681年嗣延平王；1683年澎湖战败降清，明郑终结。",
    "郑克塽",
    ym(1670),
    ym(1707),
  ),
];

const dynasties = [
  {
    id: "dashun",
    name: "大顺",
    altNames: ["李顺"],
    scope: "cn",
    region: "east_asia",
    start: ym(1644),
    end: ym(1645, 12),
    precision: "year",
    note: "李自成1644年正月西安称帝，年号永昌；克北京后旋败，1645年李自成阵亡，政权瓦解。",
  },
  {
    id: "daxi",
    name: "大西",
    altNames: ["西"],
    scope: "cn",
    region: "east_asia",
    start: ym(1644, 12),
    end: ym(1647, 12),
    precision: "month",
    note: "张献忠1644年十二月成都称帝，年号大顺；1647年1月战死于西充，余部至同年归顺南明。",
  },
  {
    id: "mingzheng",
    name: "明郑",
    altNames: ["东宁", "延平"],
    scope: "cn",
    region: "east_asia",
    start: ym(1661, 6),
    end: ym(1683, 10),
    precision: "month",
    note: "郑成功1662年收复台湾后建承天府，奉永历正朔；1683年郑克塽降清，东宁终结。",
  },
];

const dashunReignId = "reign-li-zicheng-dashun";
const daxiReignId = "reign-zhang-xianzhong-daxi";

const dashunReigns = [
  {
    ...dr("dashun", "li-zicheng", "大顺皇帝", null, null, 1644, 1645),
    eraNames: eras(dashunReignId, [{ name: "永昌", sy: 1644, ey: 1645 }]),
  },
];

const daxiReigns = [
  {
    ...dr("daxi", "zhang-xianzhong", "大西皇帝", null, null, 1644, 1647),
    eraNames: eras(daxiReignId, [{ name: "大顺", sy: 1644, sm: 12, ey: 1647 }]),
  },
];

const mingzhengReigns = [
  dr("mingzheng", "zheng-chenggong", "延平王", "武王", null, 1662, 1662),
  dr("mingzheng", "zheng-jing", "延平王", "文王", null, 1662, 1681),
  dr("mingzheng", "zheng-keshuang", "延平王", null, null, 1681, 1683),
];

const reignGroups = [dashunReigns, daxiReigns, mingzhengReigns];
const reigns = applyDocumentedDatesToReigns(reignGroups.flat());

const events = [
  eventPoint({
    id: "qing-conquer-taiwan",
    name: "清军攻克台湾",
    kind: "battle",
    precision: "day",
    dateNote: "康熙二十二年十月初八，1683年10月8日郑克塽降清",
    at: ymDay(1683, 10, 8),
    dynastyIds: ["mingzheng", "qing"],
    participantIds: ["zheng-keshuang", "xuanye"],
    summary: "施琅率清军在澎湖海战取胜，郑克塽于同年十月降清，明郑灭亡，台湾纳入清朝统治。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "zheng-recover-taiwan", dynastyId: "mingzheng" },
];

const supplementalEventParticipants = [];

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
  { id: "rel-mingzheng-taiwan-zheng", fromRef: "event:zheng-recover-taiwan", toRef: "person:zheng-chenggong", kind: "politics" },
  { id: "rel-qing-taiwan-zheng-keshuang", fromRef: "event:qing-conquer-taiwan", toRef: "person:zheng-keshuang", kind: "battle" },
);

const manifest = {
  slug: "ming-end",
  title: "明末清初过渡政权",
  window: { startYear: 1644, startMonth: 1, endYear: 1683, endMonth: 10 },
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
    { label: "大顺 (政权)", url: "https://zh.wikipedia.org/wiki/大顺_(政权)" },
    { label: "大西", url: "https://zh.wikipedia.org/wiki/大西" },
    { label: "李自成", url: "https://zh.wikipedia.org/wiki/李自成" },
    { label: "张献忠", url: "https://zh.wikipedia.org/wiki/张献忠" },
    { label: "明郑", url: "https://zh.wikipedia.org/wiki/明郑" },
    { label: "郑经", url: "https://zh.wikipedia.org/wiki/郑经" },
    { label: "澎湖海战", url: "https://zh.wikipedia.org/wiki/澎湖海战" },
  ],
  notes: [
    "收录大顺（1644–1645）、大西（1644–1647）、明郑/东宁（1661–1683）。",
    "明郑三代延平王在位日取维基百科条目公历换算（documentedReignDates，precision=day）。",
    "郑成功、郑经、郑克塽在位与 yuan-ming-qing 已有人物 upsert 衔接。",
    "大西年号亦作大顺，与李自成大顺国号同名异政权。",
    "郑成功收复台湾（1662）与郑克塽降清（1683）各保留一条跨包共用事件，合并原重复记录的信息与关联。",
    "明朝灭亡、清军入关、南明终结等事件沿用已有 id，补 event_dynasties。",
  ],
};

writeImportPackage(__dirname, {
  slug: "ming-end",
  window: { startYear: 1644, startMonth: 1, endYear: 1683, endMonth: 10 },
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  supplementalEventDynasties,
  supplementalEventParticipants,
  preSql: `DELETE FROM event_dynasties WHERE event_id IN ('mingzheng-taiwan-founded', 'qing-unify-taiwan');
DELETE FROM event_dynasties WHERE event_id = 'qing-enter-pass' AND dynasty_id = 'dashun';
DELETE FROM event_participants WHERE event_id IN ('mingzheng-taiwan-founded', 'qing-unify-taiwan');
UPDATE relations SET from_id = 'zheng-recover-taiwan' WHERE from_type = 'event' AND from_id = 'mingzheng-taiwan-founded';
DELETE FROM events WHERE id IN ('mingzheng-taiwan-founded', 'qing-unify-taiwan');`,
  manifest,
});
