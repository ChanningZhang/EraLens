#!/usr/bin/env node
/**
 * Generate EraLens import SQL for minor Sixteen Kingdoms / Southern Dynasties states.
 * 西梁、冉魏、西燕、仇池
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
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
  person(
    "xiao-cha",
    "萧詧",
    ["皇帝"],
    "梁武帝孙、昭明太子第三子。555年西魏立于江陵，建立西梁（后梁），年号大定。",
    "萧詧",
    ym(519),
    ym(562, 2),
  ),
  person(
    "xiao-kui",
    "萧巋",
    ["皇帝"],
    "西梁第二代皇帝，萧詧之子，562–585年在位，年号天保。",
    "萧巋",
    ym(542),
    ym(585, 5),
  ),
  person(
    "xiao-cong",
    "萧琮",
    ["皇帝"],
    "西梁末帝，萧巋之子，585–587年在位；隋废梁后封莒国公，大业三年卒。",
    "萧琮",
    ym(558),
    ym(607),
  ),
  person("ran-min", "冉闵", ["皇帝"], "冉魏开国皇帝，杀石虎后称帝，350–352年。", "冉闵"),
  person("murong-hong", "慕容泓", ["皇帝"], "西燕开国皇帝，慕容垂之子，384年称帝，同年被杀。", "慕容泓"),
  person("murong-chong", "慕容冲", ["皇帝"], "西燕皇帝，慕容泓之弟，384–386年在位。", "慕容冲"),
  person("murong-yong", "慕容永", ["皇帝"], "西燕末帝，386–394年在位，为后燕慕容垂所灭。", "慕容永"),
  person("yang-teng", "杨腾", ["君主"], "仇池早期氐族首领，为前仇池奠基，296年前后据仇池。", "杨腾"),
  person("yang-chu", "杨初", ["君主"], "前仇池君主，337–357年在位。", "杨初_(仇池)"),
  person("yang-lan", "杨兰", ["君主"], "仇池杨氏贵族，前仇池中期摄政。", "杨兰"),
  person("yang-fu", "杨馥", ["君主"], "仇池杨氏贵族，前仇池后期君主。", "杨馥"),
  person("yang-nandang", "杨难当", ["君主"], "仇池著名君主，杨氏四氏之一，371年前后。", "杨难当"),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const dynastyGroups = [
  {
    id: "wuhu",
    name: "五胡",
    altNames: ["十六国", "五胡十六国"],
    scope: "cn",
    start: ym(304),
    end: ym(439, 12),
    precision: "year",
    note: "304–439年五胡十六国；狭义自刘渊/李雄立国至北魏灭北凉。",
  },
];

const dynasties = [
  {
    id: "xiliang",
    name: "西梁",
    altNames: ["后梁", "萧梁"],
    scope: "cn",
    region: "east_asia",
    start: ym(555, 2),
    end: ym(587, 10),
    precision: "month",
    colorToken: nextColor(),
    groupId: "nan-chao",
    note: "555年萧詧在西魏支持下称帝于江陵；587年隋废西梁，萧琮为末帝。",
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
    groupId: "wuhu",
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
    groupId: "wuhu",
    note: "384年慕容泓称帝，都长子；394年慕容永为后燕所灭。",
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
  dr("xiliang", "xiao-cha", "梁宣帝", "宣皇帝", "中宗", 555, 562, [
    { name: "大定", sy: 555, ey: 562 },
  ]),
  dr("xiliang", "xiao-kui", "梁明帝", "孝明皇帝", "世宗", 562, 585, [
    { name: "天保", sy: 562, ey: 585 },
  ]),
  dr("xiliang", "xiao-cong", "梁孝靖帝", "孝靖皇帝", null, 585, 587, [
    { name: "广运", sy: 585, ey: 587 },
  ]),
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
const reigns = applyDocumentedDatesToReigns(reignGroups.flat());

// ── events ───────────────────────────────────────────────────────────────────

const events = [
  eventPoint({
    id: "xiliang-founded",
    name: "西梁建立",
    kind: "politics",
    at: ym(555, 2),
    precision: "month",
    dynastyIds: ["xiliang", "liang-nan"],
    participantIds: ["xiao-cha"],
    summary: "西魏立萧詧为梁帝于江陵，史称西梁（后梁）。",
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
  generatedAt: new Date().toISOString().slice(0, 10),
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "西梁", url: "https://zh.wikipedia.org/wiki/后梁_(南朝)" },
    { label: "萧詧", url: "https://zh.wikipedia.org/wiki/萧詧" },
    { label: "萧巋", url: "https://zh.wikipedia.org/wiki/萧巋" },
    { label: "萧琮", url: "https://zh.wikipedia.org/wiki/萧琮" },
    { label: "冉魏", url: "https://zh.wikipedia.org/wiki/%E5%86%89%E9%AD%8F" },
    { label: "西燕", url: "https://zh.wikipedia.org/wiki/%E8%A5%BF%E7%87%95" },
    { label: "仇池", url: "https://zh.wikipedia.org/wiki/%E4%BB%87%E6%B1%A0" },
    { label: "五胡十六国君主列表", url: "https://zh.wikipedia.org/zh-hans/%E4%BA%94%E8%83%A1%E5%8D%81%E5%85%AD%E5%9B%BD%E5%90%9B%E4%B8%BB%E5%88%97%E8%A1%A8" },
  ],
  notes: [
    "补充 jin-sixteen / nanbei-chao 未收录的西梁、冉魏、西燕、前仇池。",
    "冉魏、西燕属 dynasty_groups.wuhu（与崔鸿十六国同框）；西梁属 dynasty_groups.nan-chao（555–587，落在南朝框 420–589 内，与南陈并存）；仇池始年早于 304，不入五胡组。",
    "西梁 id 为 xiliang，与十六国西凉 liang-xi 区分。三帝为萧詧、萧巋、萧琮；萧庄是王琳在郢州另立的梁帝，不属江陵西梁。",
    "萧詧起迄月取维基即位（555年2月）与《周书》保定二年二月薨；萧巋接天保始年二月，卒于天保二十四年五月；萧琮亡国取广运二年九月十九日（587年10月26日）。",
    "仇池取296–371前仇池窗口，杨腾至杨难当代表杨氏四氏执政序列。",
    "南梁（liang-nan）、后赵（zhao-back）、后燕（yan-back）复用已有 dynasty id 作事件关联。",
  ],
};

const preSql = [
  "DELETE FROM event_participants WHERE event_id = 'xiliang-founded' AND person_id = 'xiao-zhuang';",
  "DELETE FROM relations WHERE id = 'rel-xiao-zhuang-xiao-cong-succession';",
  "DELETE FROM era_names WHERE reign_id IN ('reign-xiao-zhuang-xiliang', 'reign-xiao-cong-xiliang');",
  "DELETE FROM reigns WHERE id = 'reign-xiao-zhuang-xiliang';",
  "DELETE FROM persons WHERE id = 'xiao-zhuang';",
].join("\n");

writeImportPackage(__dirname, {
  slug: "nanbei-sixteen-extra",
  window: { startYear: 296, startMonth: 1, endYear: 587, endMonth: 12 },
  persons,
  dynastyGroups,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  preSql,
  manifest,
});
