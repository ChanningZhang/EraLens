#!/usr/bin/env node
/**
 * Generate EraLens import SQL for minor Sixteen Kingdoms / Southern Dynasties states.
 * 西梁、冉魏、西燕、仇池
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  ym,
  person,
  dr,
  eventPoint,
  successionPairs,
  nextColor,
  writeImportPackage,
} from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  person("xiao-zhuang", "萧庄", ["皇帝"], "西梁皇帝，梁元帝之子，555年即位，557年禅让陈霸先。", "萧庄"),
  person("xiao-cong", "萧琮", ["皇帝"], "西梁末帝，萧庄之弟，557年嗣位，587年亡于隋。", "萧琮"),
  person("ran-min", "冉闵", ["皇帝"], "冉魏开国皇帝，杀石虎后称帝，350–352年。", "冉闵"),
  person("murong-hong", "慕容泓", ["皇帝"], "西燕开国皇帝，慕容垂之子，384年称帝，同年被杀。", "慕容泓"),
  person("murong-chong", "慕容冲", ["皇帝"], "西燕皇帝，慕容泓之弟，384–386年在位。", "慕容冲"),
  person("murong-yong", "慕容永", ["皇帝"], "西燕末帝，386–394年在位，为前秦苻坚所灭。", "慕容永"),
  person("yang-teng", "杨腾", ["君主"], "仇池早期氐族首领，为前仇池奠基，296年前后据仇池。", "杨腾"),
  person("yang-chu", "杨初", ["君主"], "前仇池君主，337–357年在位。", "杨初_(仇池)"),
  person("yang-lan", "杨兰", ["君主"], "仇池杨氏贵族，前仇池中期摄政。", "杨兰"),
  person("yang-fu", "杨馥", ["君主"], "仇池杨氏贵族，前仇池后期君主。", "杨馥"),
  person("yang-nandang", "杨难当", ["君主"], "仇池著名君主，杨氏四氏之一，371年前后。", "杨难当"),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "xiliang",
    name: "西梁",
    altNames: ["后梁", "萧梁"],
    scope: "cn",
    region: "east_asia",
    start: ym(555),
    end: ym(587),
    precision: "year",
    colorToken: nextColor(),
    note: "555年萧庄即位，都江陵；587年隋灭西梁，萧琮为末帝。",
  },
  {
    id: "ranwei",
    name: "冉魏",
    altNames: ["魏", "冉魏"],
    scope: "cn",
    region: "east_asia",
    start: ym(350),
    end: ym(352),
    precision: "year",
    colorToken: nextColor(),
    note: "350年冉闵杀石虎称帝，国号魏；352年败亡。",
  },
  {
    id: "xiyan",
    name: "西燕",
    altNames: ["燕"],
    scope: "cn",
    region: "east_asia",
    start: ym(384),
    end: ym(394),
    precision: "year",
    colorToken: nextColor(),
    note: "384年慕容泓称帝，都长子；394年慕容永为前秦所灭。",
  },
  {
    id: "chouchi",
    name: "仇池",
    altNames: ["前仇池", "氐仇池"],
    scope: "cn",
    region: "east_asia",
    start: ym(296),
    end: ym(371),
    precision: "year",
    colorToken: nextColor(),
    note: "296年杨茂搜据仇池；371年前仇池亡，杨氏四氏先后执政。",
  },
];

// ── reigns ─────────────────────────────────────────────────────────────────

const xiliangReigns = [
  dr("xiliang", "xiao-zhuang", "梁皇帝", null, null, 555, 557),
  dr("xiliang", "xiao-cong", "梁末帝", null, null, 557, 587),
];

const ranweiReigns = [dr("ranwei", "ran-min", "魏皇帝", null, null, 350, 352)];

const xiyanReigns = [
  dr("xiyan", "murong-hong", "西燕皇帝", null, null, 384, 384),
  dr("xiyan", "murong-chong", "西燕皇帝", null, null, 384, 386),
  dr("xiyan", "murong-yong", "西燕皇帝", null, null, 386, 394),
];

const chouchiReigns = [
  dr("chouchi", "yang-teng", "仇池王", null, null, 296, 317),
  dr("chouchi", "yang-chu", "仇池王", null, null, 337, 357),
  dr("chouchi", "yang-lan", "仇池王", null, null, 357, 361),
  dr("chouchi", "yang-fu", "仇池王", null, null, 361, 370),
  dr("chouchi", "yang-nandang", "仇池王", null, null, 370, 371),
];

const reignGroups = [xiliangReigns, ranweiReigns, xiyanReigns, chouchiReigns];
const reigns = reignGroups.flat();

// ── events ───────────────────────────────────────────────────────────────────

const events = [
  eventPoint({
    id: "xiliang-founded",
    name: "西梁建立",
    kind: "politics",
    at: ym(555),
    dynastyIds: ["xiliang", "liang-nan"],
    participantIds: ["xiao-zhuang"],
    summary: "萧庄于江陵即位，延续南朝梁祚，史称西梁。",
  }),
  eventPoint({
    id: "ranwei-founded",
    name: "冉魏建立",
    kind: "politics",
    at: ym(350),
    dynastyIds: ["ranwei", "zhao-back"],
    participantIds: ["ran-min"],
    summary: "冉闵杀后赵石虎，称帝建国，国号魏，史称冉魏。",
  }),
  eventPoint({
    id: "xiyan-founded",
    name: "西燕建立",
    kind: "politics",
    at: ym(384),
    dynastyIds: ["xiyan", "yan-back"],
    participantIds: ["murong-hong"],
    summary: "慕容泓于长子称帝，国号燕，史称西燕。",
  }),
];

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
  { id: "rel-xiliang-founded", fromRef: "event:xiliang-founded", toRef: "dynasty:xiliang", kind: "other" },
  { id: "rel-ranwei-founded", fromRef: "event:ranwei-founded", toRef: "dynasty:ranwei", kind: "other" },
  { id: "rel-xiyan-founded", fromRef: "event:xiyan-founded", toRef: "dynasty:xiyan", kind: "other" },
);

// ── output ───────────────────────────────────────────────────────────────────

const manifest = {
  slug: "nanbei-sixteen-extra",
  title: "南北朝与十六国补充政权",
  window: { startYear: 296, startMonth: 1, endYear: 587, endMonth: 12 },
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
    { label: "西梁", url: "https://zh.wikipedia.org/wiki/%E8%A5%BF%E6%A2%81" },
    { label: "冉魏", url: "https://zh.wikipedia.org/wiki/%E5%86%89%E9%AD%8F" },
    { label: "西燕", url: "https://zh.wikipedia.org/wiki/%E8%A5%BF%E7%87%95" },
    { label: "仇池", url: "https://zh.wikipedia.org/wiki/%E4%BB%87%E6%B1%A0" },
    { label: "五胡十六国君主列表", url: "https://zh.wikipedia.org/zh-hans/%E4%BA%94%E8%83%A1%E5%8D%81%E5%85%AD%E5%9B%BD%E5%90%9B%E4%B8%BB%E5%88%97%E8%A1%A8" },
  ],
  notes: [
    "补充 jin-sixteen / nanbei-chao 未收录的西梁、冉魏、西燕、前仇池。",
    "西梁 id 为 xiliang，与十六国西凉 liang-xi 区分。",
    "仇池取296–371前仇池窗口，杨腾至杨难当代表杨氏四氏执政序列。",
    "南梁（liang-nan）、后赵（zhao-back）、后燕（yan-back）复用已有 dynasty id 作事件关联。",
  ],
};

writeImportPackage(__dirname, {
  slug: "nanbei-sixteen-extra",
  window: { startYear: 296, startMonth: 1, endYear: 587, endMonth: 12 },
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  manifest,
});
