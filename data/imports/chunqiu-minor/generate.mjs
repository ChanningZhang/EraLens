#!/usr/bin/env node
/**
 * Generate EraLens import SQL for minor Spring-Autumn states and Warring States remnants.
 * Only rulers with documented reign windows from Wikipedia / 左传 are included.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  person,
  dr,
  ym,
  nextColor,
  eventPoint,
  writeImportPackage,
  successionPairs,
} from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

function rulerPerson(id, name, dynastyLabel, title, bio, wikiTitle = name) {
  return person(id, name, ["君主"], bio ?? `${title}，${dynastyLabel}君主。`, wikiTitle);
}

// ── reign definitions (维基诸侯君主表 / 左传可考年) ─────────────────────────

const xueReigns = [
  // 左传仅载昭公三十一年（前511）薛伯谷卒，在位始年不详
  dr("xue-chunqiu", "xue-r1", "薛献公", "献公", null, -511, -511),
  dr("xue-chunqiu", "xue-r2", "薛襄公", "襄公", null, -510, -498),
  dr("xue-chunqiu", "xue-r3", "薛公比", null, null, -497, -497),
  dr("xue-chunqiu", "xue-r4", "薛惠公", "惠公", null, -496, -485),
];

const tengReigns = [
  dr("teng-chunqiu", "teng-r2", "滕文公", "文公", null, -599, -575),
  dr("teng-chunqiu", "teng-r3", "滕成公", "成公", null, -574, -539),
  dr("teng-chunqiu", "teng-r4", "滕悼公", "悼公", null, -538, -513),
  dr("teng-chunqiu", "teng-r5", "滕顷公", "顷公", null, -512, -491),
  dr("teng-chunqiu", "teng-r6", "滕隐公", "隐公", null, -490, -484),
];

const qiStateReigns = [
  dr("qi-state-chunqiu", "qi-state-r1", "杞武公", "武公", null, -750, -704),
  dr("qi-state-chunqiu", "qi-state-r1b", "杞靖公", "靖公", null, -719, -685),
  dr("qi-state-chunqiu", "qi-state-r1c", "杞成公", "成公", null, -654, -637),
  dr("qi-state-chunqiu", "qi-state-r2", "杞桓公", "桓公", null, -636, -567),
  dr("qi-state-chunqiu", "qi-state-r3", "杞文公", "文公", null, -549, -536),
  dr("qi-state-chunqiu", "qi-state-r4", "杞平公", "平公", null, -535, -518),
  dr("qi-state-chunqiu", "qi-state-r5", "杞湣公", "湣公", null, -486, -471),
  dr("qi-state-chunqiu", "qi-state-r6", "杞简公", "简公", null, -448, -445),
];

const juReigns = [
  dr("ju-chunqiu", "ju-r1", "莒纪公", "纪公", null, -615, -609),
  dr("ju-chunqiu", "ju-r1b", "莒厉公", "厉公", null, -608, -580),
  dr("ju-chunqiu", "ju-r2", "莒渠丘公", "渠丘公", null, -579, -577),
  dr("ju-chunqiu", "ju-r3", "莒犂比公", "犂比公", null, -576, -542),
  dr("ju-chunqiu", "ju-r4", "莒子舆", null, null, -541, -541),
  dr("ju-chunqiu", "ju-r5", "莒著丘公", "著丘公", null, -540, -528),
  dr("ju-chunqiu", "ju-r6", "莒共公", "共公", null, -527, -519),
  dr("ju-chunqiu", "ju-r7", "莒郊公", "郊公", null, -518, -481),
];

const daiReigns = [dr("dai-warring", "zhao-jia-dai", "代王", null, null, -228, -222)];

const jiaodongReigns = [dr("jiaodong-warring", "tian-shi", "胶东王", null, null, -221, -206)];

const reignGroups = [xueReigns, tengReigns, qiStateReigns, juReigns, daiReigns, jiaodongReigns];
const reigns = reignGroups.flat();

const RULER_META = {
  "xue-r1": { name: "任谷", wiki: "薛献公", bio: "《左传·昭公三十一年》载前511年卒；在位始年不详，不承接前代拉满。" },
  "xue-r2": { name: "任定", wiki: "薛襄公" },
  "xue-r3": { name: "薛公比", wiki: "薛公比" },
  "xue-r4": { name: "任夷", wiki: "薛惠公" },
  "teng-r2": { name: "寿", wiki: "滕文公_(春秋)" },
  "teng-r3": { name: "原", wiki: "滕成公" },
  "teng-r4": { name: "宁", wiki: "滕悼公" },
  "teng-r5": { name: "结", wiki: "滕顷公" },
  "teng-r6": { name: "虞毋", wiki: "滕隐公" },
  "qi-state-r1": { name: "杞武公", wiki: "杞武公" },
  "qi-state-r1b": { name: "杞靖公", wiki: "杞靖公" },
  "qi-state-r1c": { name: "杞成公", wiki: "杞成公" },
  "qi-state-r2": { name: "姑容", wiki: "杞桓公" },
  "qi-state-r3": { name: "益姑", wiki: "杞文公" },
  "qi-state-r4": { name: "郁", wiki: "杞平公" },
  "qi-state-r5": { name: "维", wiki: "杞湣公" },
  "qi-state-r6": { name: "春", wiki: "杞简公" },
  "ju-r1": { name: "庶其", wiki: "莒纪公" },
  "ju-r1b": { name: "季佗", wiki: "莒厉公" },
  "ju-r2": { name: "朱", wiki: "莒渠丘公" },
  "ju-r3": { name: "密州", wiki: "莒犂比公" },
  "ju-r4": { name: "舆", wiki: "莒子舆" },
  "ju-r5": { name: "去疾", wiki: "莒著丘公" },
  "ju-r6": { name: "庚舆", wiki: "莒共公" },
  "ju-r7": { name: "狂", wiki: "莒郊公" },
  "zhao-jia-dai": { name: "赵嘉", wiki: "代王嘉" },
  "tian-shi": { name: "田市", wiki: "田市" },
};

const DYNASTY_LABELS = {
  "xue-chunqiu": "薛国",
  "teng-chunqiu": "滕国",
  "qi-state-chunqiu": "杞国",
  "ju-chunqiu": "莒国",
  "dai-warring": "代国",
  "jiaodong-warring": "胶东",
};

const persons = reigns.map((r) => {
  const meta = RULER_META[r.personId];
  const state = DYNASTY_LABELS[r.dynastyId];
  return rulerPerson(r.personId, meta.name, state, r.title, meta.bio ?? null, meta.wiki);
});

const dynasties = [
  {
    id: "xue-chunqiu",
    name: "薛国",
    altNames: ["薛"],
    scope: "cn",
    region: "east_asia",
    start: ym(-578),
    end: ym(-327, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "任姓小国；可考君主自薛献公（前511年卒）起；前327年齐魏共灭薛。西周薛伯等早期君主在位年失考，不收录。",
  },
  {
    id: "teng-chunqiu",
    name: "滕国",
    altNames: ["滕"],
    scope: "cn",
    region: "east_asia",
    start: ym(-599),
    end: ym(-414, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "周武王封弟错叔绣于滕；本包仅收录春秋可考君主（文公至隐公）。错叔绣至宣公等早期世系在位年失考。",
  },
  {
    id: "qi-state-chunqiu",
    name: "杞国",
    altNames: ["杞"],
    scope: "cn",
    region: "east_asia",
    start: ym(-750),
    end: ym(-445, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "自杞武公起有通行在位年；东楼公等更早君主失考。前445年为齐所灭。",
  },
  {
    id: "ju-chunqiu",
    name: "莒国",
    altNames: ["莒"],
    scope: "cn",
    region: "east_asia",
    start: ym(-615),
    end: ym(-431, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "兹舆期受封后多世失考；本包自春秋可见于《左传》的莒纪公起收录。前431年为楚所灭。",
  },
  {
    id: "dai-warring",
    name: "代国",
    altNames: ["代"],
    scope: "cn",
    region: "east_asia",
    start: ym(-228),
    end: ym(-222, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "前228年赵嘉于代郡自立代王；前222年秦将王贲灭代。",
  },
  {
    id: "jiaodong-warring",
    name: "胶东",
    altNames: ["胶东国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-221),
    end: ym(-206, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "秦灭齐后即墨一带齐宗室残余；田市等据胶东，至楚汉之际并入分封格局。",
  },
];

const events = [
  eventPoint({
    id: "dai-founded",
    name: "代王嘉自立",
    kind: "politics",
    dateNote: "赵幽缪王八年，前228年，秦占邯郸后赵嘉逃代自立",
    at: ym(-228),
    dynastyIds: ["dai-warring", "zhao-warring"],
    participantIds: ["zhao-jia-dai"],
    summary: "赵公子嘉逃至代郡，被大夫拥立为代王，延续赵国宗祀。",
  }),
  eventPoint({
    id: "qin-destroy-dai",
    name: "秦灭代",
    kind: "battle",
    dateNote: "秦王政二十五年，前222年",
    at: ym(-222),
    dynastyIds: ["dai-warring", "qin"],
    participantIds: ["zhao-jia-dai"],
    summary: "秦将王贲攻代，俘代王嘉，代国灭亡。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "chunqiu", dynastyId: "xue-chunqiu" },
  { eventId: "chunqiu", dynastyId: "teng-chunqiu" },
  { eventId: "chunqiu", dynastyId: "qi-state-chunqiu" },
  { eventId: "chunqiu", dynastyId: "ju-chunqiu" },
  { eventId: "zhanguo", dynastyId: "dai-warring" },
  { eventId: "zhanguo", dynastyId: "jiaodong-warring" },
  { eventId: "qin-destroy-han", dynastyId: "dai-warring" },
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
  { id: "rel-dai-founded-zhao-jia", fromRef: "event:dai-founded", toRef: "person:zhao-jia-dai", kind: "politics" },
  { id: "rel-qin-destroy-dai-zhao-jia", fromRef: "event:qin-destroy-dai", toRef: "person:zhao-jia-dai", kind: "battle" },
);

const cleanupSql = [
  "DELETE FROM reigns WHERE id IN (",
  "  'reign-xue-r0-xue-chunqiu',",
  "  'reign-teng-r0-teng-chunqiu',",
  "  'reign-teng-r1-teng-chunqiu',",
  "  'reign-teng-r7-teng-chunqiu',",
  "  'reign-qi-state-r0-qi-state-chunqiu',",
  "  'reign-ju-r0-ju-chunqiu',",
  "  'reign-ju-r6-ju-chunqiu'",
  ");",
  "DELETE FROM persons WHERE id IN ('xue-r0','teng-r0','teng-r1','teng-r7','qi-state-r0','ju-r0')",
  "  AND id NOT IN (SELECT person_id FROM reigns);",
].join("\n");

const manifest = {
  slug: "chunqiu-minor",
  title: "春秋小国与战国残余",
  window: { startYear: -750, startMonth: 1, endYear: -206, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-13",
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
    supplementalEventDynastyLinks: supplementalEventDynasties.length,
  },
  sources: [
    { label: "薛国", url: "https://zh.wikipedia.org/wiki/薛国" },
    { label: "滕国", url: "https://zh.wikipedia.org/wiki/滕国" },
    { label: "杞国", url: "https://zh.wikipedia.org/wiki/杞国" },
    { label: "莒国", url: "https://zh.wikipedia.org/wiki/莒国" },
    { label: "代国 (战国)", url: "https://zh.wikipedia.org/wiki/代国_(战国)" },
  ],
  notes: [
    "仅收录维基/左传有明确在位年的君主；早期失考君主不强行拉满王朝跨度。",
    "薛献公仅知前511年卒（左传），不填虚始年；齐庄公/卫武公/曹桓公/宋昭公长年在维基或史记有载，保留。",
    "薛国自薛献公起；滕国自春秋滕文公起；杞国自武公起；莒国自纪公起。",
    "杞桓公在位70年、高句丽太祖王等长年在史料中有记载，保留。",
    "代王嘉 person id 为 zhao-jia-dai，与赵桓子 zhao-r2 区分。",
  ],
};

writeImportPackage(__dirname, {
  slug: "chunqiu-minor",
  window: { startYear: -750, startMonth: 1, endYear: -206, endMonth: 12 },
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  supplementalEventDynasties,
  preSql: cleanupSql,
  manifest,
});
