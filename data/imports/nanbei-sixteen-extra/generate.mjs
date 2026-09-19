#!/usr/bin/env node
/**
 * Generate EraLens import SQL for extra regimes around Sixteen Kingdoms / Southern Dynasties.
 * 西梁、冉魏、西燕、仇池（冉魏、西燕不在崔鸿十六国之列）
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
  person(
    "ran-min",
    "冉闵",
    ["皇帝"],
    "石虎养孙，本姓冉，后赵时姓名石闵。石虎病死后诸子争位，350年杀石鉴称帝，国号魏，年号永兴；352年败于前燕，慕容儁斩于龙城。谥平帝；前燕谥武悼天王。",
    "冉闵",
    null,
    ym(352, 6),
  ),
  person(
    "murong-hong",
    "慕容泓",
    ["皇帝"],
    "西燕开国皇帝，前燕末帝慕容暐之弟；384年华阴称济北王，同年为部将所杀。",
    "慕容泓",
  ),
  person(
    "murong-chong",
    "慕容冲",
    ["皇帝"],
    "西燕威皇帝，慕容儁之子、慕容暐之弟；385年阿房称帝，386年为韩延所杀。",
    "慕容冲",
  ),
  person("duan-sui", "段随", ["皇帝"], "西燕将领，386年二月被拥立为燕王，三月为慕容恒、慕容永所杀。", "段隨"),
  person(
    "murong-hao",
    "慕容顗",
    ["皇帝"],
    "西燕皇帝，前燕宜都王慕容桓之子；386年三月即位，旋为慕容韬所诱杀。",
    "建明_(西燕)",
  ),
  person("murong-yao", "慕容瑶", ["皇帝"], "西燕皇帝，慕容冲之子；386年三月即位，为慕容永所擒杀。", "慕容瑶"),
  person("murong-zhong", "慕容忠", ["皇帝"], "西燕皇帝，慕容泓之子；386年三月即位，六月为刁云所杀。", "慕容忠"),
  person(
    "murong-yong",
    "慕容永",
    ["皇帝"],
    "西燕末帝，慕容廆侄孙；386年六月称河东王、十月称帝，394年为后燕慕容垂所灭。",
    "慕容永",
  ),
  person("yang-maosou", "杨茂搜", ["君主"], "前仇池开国君主，296年率部据仇池，自号辅国将军、右贤王。", "杨茂搜"),
  person("yang-nandi", "杨难敌", ["君主"], "前仇池君主，317–334年在位，前赵封为武都王。", "杨难敌"),
  person("yang-yi-chouchi", "杨毅", ["君主"], "前仇池君主，334–337年在位，自号龙骧将军、左贤王、下辨公。", "杨毅_(仇池)"),
  person("yang-chu", "杨初", ["君主"], "前仇池君主，337–355年在位，东晋封仇池公、天水公。", "杨初_(仇池)"),
  person("yang-guo-chouchi", "杨国", ["君主"], "前仇池君主，355–356年在位。", "杨国_(仇池)"),
  person("yang-jun-chouchi", "杨俊", ["君主"], "前仇池君主，356–360年在位，东晋封为仇池公。", "杨俊_(仇池)"),
  person("yang-shi-chouchi", "杨世", ["君主"], "前仇池君主，360–370年在位。", "杨世_(仇池)"),
  person("yang-tong-chouchi", "杨统", ["君主"], "前仇池君主，370年在位，史料有争议。", "杨统_(仇池)"),
  person("yang-zuan-chouchi", "杨纂", ["君主"], "前仇池末代君主，370–371年在位，371年前秦灭仇池。", "杨纂_(仇池)"),
];

// ── dynasties ──────────────────────────────────────────────────────────────

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
    end: ym(352, 12),
    precision: "year",
    note: "350年冉闵杀后赵石鉴称帝，国号魏；352年败于前燕。不入崔鸿十六国。",
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
    note: "384年慕容泓称帝，都长子；394年慕容永为后燕所灭。不入崔鸿十六国。",
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
    note: "296年杨茂搜据仇池；371年前秦灭前仇池。杨腾为东汉迁入祖，不算君主。",
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

const ranweiReigns = [dr("ranwei", "ran-min", "魏平帝", "平帝", null, 350, 352, [{ name: "永兴", sy: 350, ey: 352 }])];

const xiyanReigns = [
  dr("xiyan", "murong-hong", "西燕皇帝", null, null, 384, 384, [{ name: "燕兴", sy: 384, ey: 384 }]),
  dr("xiyan", "murong-chong", "西燕威皇帝", "威皇帝", null, 385, 386, [{ name: "更始", sy: 385, ey: 386 }]),
  dr("xiyan", "duan-sui", "西燕皇帝", null, null, 386, 386, [{ name: "昌平", sy: 386, ey: 386 }]),
  dr("xiyan", "murong-hao", "西燕皇帝", null, null, 386, 386, [{ name: "建明", sy: 386, ey: 386 }]),
  dr("xiyan", "murong-yao", "西燕皇帝", null, null, 386, 386, [{ name: "建平", sy: 386, ey: 386 }]),
  dr("xiyan", "murong-zhong", "西燕皇帝", null, null, 386, 386, [{ name: "建武", sy: 386, ey: 386 }]),
  dr("xiyan", "murong-yong", "西燕皇帝", null, null, 386, 394, [{ name: "中兴", sy: 386, ey: 394 }]),
];

const chouchiReigns = [
  dr("chouchi", "yang-maosou", "仇池王", null, null, 296, 317),
  dr("chouchi", "yang-nandi", "仇池王", null, null, 317, 334),
  dr("chouchi", "yang-yi-chouchi", "仇池王", null, null, 334, 337),
  dr("chouchi", "yang-chu", "仇池王", null, null, 337, 355),
  dr("chouchi", "yang-guo-chouchi", "仇池王", null, null, 355, 356),
  dr("chouchi", "yang-jun-chouchi", "仇池王", null, null, 356, 360),
  dr("chouchi", "yang-shi-chouchi", "仇池王", null, null, 360, 370),
  dr("chouchi", "yang-tong-chouchi", "仇池王", null, null, 370, 370),
  dr("chouchi", "yang-zuan-chouchi", "仇池王", null, null, 370, 371),
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
    at: ym(350, 4),
    precision: "month",
    dateNote: "永和六年闰二月改元永兴；350年闰二月望约公历4月。",
    dynastyIds: ["ranwei", "zhao-back"],
    participantIds: ["ran-min"],
    summary: "冉闵杀后赵石鉴，称帝于邺，国号魏，改元永兴，史称冉魏。",
  }),
  eventPoint({
    id: "xiyan-founded",
    name: "西燕建立",
    kind: "politics",
    at: ym(384, 2),
    precision: "month",
    dynastyIds: ["xiyan", "yan-back"],
    participantIds: ["murong-hong"],
    summary: "慕容泓于华阴称济北王，起兵反秦，国号燕，史称西燕。",
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
    { label: "冉闵", url: "https://zh.wikipedia.org/wiki/冉闵" },
    { label: "西燕", url: "https://zh.wikipedia.org/wiki/%E8%A5%BF%E7%87%95" },
    { label: "仇池", url: "https://zh.wikipedia.org/wiki/%E4%BB%87%E6%B1%A0" },
    { label: "五胡十六国君主列表", url: "https://zh.wikipedia.org/zh-hans/%E4%BA%94%E8%83%A1%E5%8D%81%E5%85%AD%E5%9B%BD%E5%90%9B%E4%B8%BB%E5%88%97%E8%A1%A8" },
  ],
  notes: [
    "补充 jin-sixteen / nanbei-chao 未收录的西梁、冉魏、西燕、前仇池。",
    "冉魏、西燕、仇池均不入崔鸿《十六国春秋》，不属 dynasty_groups.wuhu，单独成行（与十六国框分开）。西梁属 dynasty_groups.nan-chao（555–587，落在南朝框 420–589 内，与南陈并存）。",
    "西梁 id 为 xiliang，与十六国西凉 liang-xi 区分。三帝为萧詧、萧巋、萧琮；萧庄是王琳在郢州另立的梁帝，不属江陵西梁。",
    "萧詧起迄月取维基即位（555年2月）与《周书》保定二年二月薨；萧巋接天保始年二月，卒于天保二十四年五月；萧琮亡国取广运二年九月十九日（587年10月26日）。",
    "仇池取296–371前仇池窗口，九君为杨茂搜、杨难敌、杨毅、杨初、杨国、杨俊、杨世、杨统、杨纂；杨统年有争议仍单列。杨难当属后仇池，不在此包。",
    "南梁（liang-nan）、后赵（zhao-back）、后燕（yan-back）复用已有 dynasty id 作事件关联。",
    "冉闵杀的是后赵石鉴，不是石虎（349年病死）。称谓取染华墓志谥平帝（维基作魏平帝）；前燕追谥武悼天王写入 bio。年号永兴。起年取永兴始闰二月（350年闰二月望≈4月），迄日取维基 352-06-01。太子冉智是否继位史料有缺，不另建 reign。",
    "西燕通行七帝（慕容泓→慕容冲→段随→慕容顗→慕容瑶→慕容忠→慕容永）；386年政变频繁，诸短祚君主用 month 精度依《资治通鉴》晋纪二十八排月。",
    "慕容泓为慕容暐之弟，非慕容垂之子；慕容冲称帝在阿房（385年），非长子。",
  ],
};

const preSql = [
  "DELETE FROM event_participants WHERE event_id = 'xiliang-founded' AND person_id = 'xiao-zhuang';",
  "DELETE FROM relations WHERE id = 'rel-xiao-zhuang-xiao-cong-succession';",
  "DELETE FROM reigns WHERE id = 'reign-xiao-zhuang-xiliang';",
  "DELETE FROM persons WHERE id = 'xiao-zhuang';",
  "DELETE FROM relations WHERE id IN (",
  "  'rel-yang-teng-yang-chu-succession',",
  "  'rel-yang-chu-yang-lan-succession',",
  "  'rel-yang-lan-yang-fu-succession',",
  "  'rel-yang-fu-yang-nandang-succession'",
  ");",
  "DELETE FROM reigns WHERE id IN (",
  "  'reign-yang-teng-chouchi',",
  "  'reign-yang-lan-chouchi',",
  "  'reign-yang-fu-chouchi',",
  "  'reign-yang-nandang-chouchi'",
  ");",
  "DELETE FROM persons WHERE id IN ('yang-teng', 'yang-lan', 'yang-fu', 'yang-nandang');",
  "DELETE FROM relations WHERE id IN (",
  "  'rel-murong-chong-murong-yong-succession',",
  "  'rel-duan-sui-murong-yi-xiyan-succession',",
  "  'rel-murong-yi-xiyan-murong-yao-succession'",
  ");",
  "DELETE FROM reigns WHERE id = 'reign-murong-yi-xiyan-xiyan';",
  "DELETE FROM persons WHERE id = 'murong-yi-xiyan';",
].join("\n");

writeImportPackage(__dirname, {
  slug: "nanbei-sixteen-extra",
  window: { startYear: 296, startMonth: 1, endYear: 587, endMonth: 12 },
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  preSql,
  manifest,
});
