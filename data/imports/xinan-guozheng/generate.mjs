#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Southwestern Yi states (西汉西南夷，含夜郎).
 * Sources: 史记·西南夷列传, 汉书·西南夷两粤朝鲜传
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  person,
  dr,
  eventPoint,
  writeImportPackage,
  nextColor,
  ym,
  successionPairs,
} from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  person(
    "yelang-duotong",
    "多同",
    ["君主"],
    "夜郎侯，汉武帝遣唐蒙通夜郎时在位；《史记》载其国为西南夷最大。在位起讫无通行记载。",
    "夜郎",
  ),
  person(
    "yelang-xin",
    "兴",
    ["君主"],
    "夜郎王，前27年被邛郿侯陈立所杀，夜郎国亡。",
    "夜郎",
    null,
    ym(-27),
  ),
  person(
    "zhuang-qiao",
    "庄蹻",
    ["君主"],
    "楚将，入滇称滇王，据滇池，开创滇国世系。",
    "庄蹻",
    null,
    ym(-256),
  ),
  person(
    "dian-changqiang",
    "尝羌",
    ["君主"],
    "滇王，汉武帝元封二年率众降汉，设益州郡。中间世系多失考。",
    "滇国",
  ),
  person(
    "qiong-jun",
    "邛君",
    ["君主"],
    "邛都国君主，武帝元鼎六年为汉所诛。",
    "邛都国",
    null,
    ym(-111),
  ),
  person(
    "zuo-hou",
    "莋侯",
    ["君主"],
    "莋都国君主，武帝元鼎六年为汉所诛。",
    "莋都",
    null,
    ym(-111),
  ),
  person(
    "qielan-jun",
    "头兰",
    ["君主"],
    "且兰（头兰）君，武帝元鼎六年为汉军所破。",
    "且兰",
    null,
    ym(-111),
  ),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "yelang",
    name: "夜郎",
    altNames: ["夜郎国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-300),
    end: ym(-27),
    precision: "year",
    colorToken: nextColor(),
    note: "战国时已有夜郎；汉武帝时夜郎侯多同，末王兴前27年被诛。君主在位年多失考，不强行拉满王朝跨度。",
  },
  {
    id: "dian",
    name: "滇国",
    altNames: ["滇"],
    scope: "cn",
    region: "east_asia",
    start: ym(-279),
    end: ym(-109),
    precision: "year",
    colorToken: nextColor(),
    note: "楚将庄蹻入滇称王；武帝元封二年（前109）尝羌降汉，设益州郡。庄蹻与尝羌之间世系失考。",
  },
  {
    id: "qiongdu",
    name: "邛都",
    altNames: ["邛都国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-200),
    end: ym(-111),
    precision: "year",
    colorToken: nextColor(),
    note: "据今四川西昌；武帝元鼎六年（前111）为汉所灭。君主名仅见于灭国之年。",
  },
  {
    id: "zuodu",
    name: "莋都",
    altNames: ["莋都国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-200),
    end: ym(-111),
    precision: "year",
    colorToken: nextColor(),
    note: "据今四川盐源；武帝元鼎六年（前111）为汉所灭。",
  },
  {
    id: "ranmang",
    name: "冉駹",
    altNames: ["冉駹国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-200),
    end: ym(-111),
    precision: "year",
    colorToken: nextColor(),
    note: "川西高原古国；武帝元鼎六年（前111）纳入汉朝版图。无通行君主名，仅建王朝行与事件。",
  },
  {
    id: "baima",
    name: "白马",
    altNames: ["白马国", "白狼国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-200),
    end: ym(-111),
    precision: "year",
    colorToken: nextColor(),
    note: "据今甘肃东南部；武帝元鼎六年（前111）为汉所灭。无通行君主名。",
  },
  {
    id: "qielan",
    name: "且兰",
    altNames: ["头兰", "且兰国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-200),
    end: ym(-111),
    precision: "year",
    colorToken: nextColor(),
    note: "滇东小国，君主称头兰；武帝元鼎六年（前111）为汉军所破。",
  },
  {
    id: "laomo",
    name: "劳深靡莫",
    altNames: ["劳深", "靡莫"],
    scope: "cn",
    region: "east_asia",
    start: ym(-200),
    end: ym(-109),
    precision: "year",
    colorToken: nextColor(),
    note: "滇东北古国联盟；武帝元封二年（前109）前后为汉所平定。无通行君主名。",
  },
];

// ── reigns ─────────────────────────────────────────────────────────────────
// 仅收录有史料锚点的在位窗口；禁止用王朝起讫年硬填君主在位。

const yelangReigns = [
  // 唐蒙通夜郎约前135年，多同在位年不详，取事件前后短窗口
  dr("yelang", "yelang-duotong", "夜郎侯", null, null, -140, -120),
  // 兴仅知前27年被杀
  dr("yelang", "yelang-xin", "夜郎王", null, null, -30, -27),
];

const dianReigns = [
  dr("dian", "zhuang-qiao", "滇王", null, null, -279, -256),
  // 尝羌仅知元封二年降汉，不承接庄蹻终点硬拉147年
  dr("dian", "dian-changqiang", "滇王", null, null, -115, -109),
];

const qiongduReigns = [dr("qiongdu", "qiong-jun", "邛君", null, null, -111, -111)];
const zuoduReigns = [dr("zuodu", "zuo-hou", "莋侯", null, null, -111, -111)];
const qielanReigns = [dr("qielan", "qielan-jun", "且兰君", null, null, -111, -111)];

const reignGroups = [yelangReigns, dianReigns, qiongduReigns, zuoduReigns, qielanReigns];
const reigns = reignGroups.flat();

// ── events ───────────────────────────────────────────────────────────────────

const events = [
  eventPoint({
    id: "tangmeng-tong-yelang",
    name: "唐蒙通夜郎",
    kind: "politics",
    at: ym(-135),
    dynastyIds: ["yelang"],
    participantIds: ["yelang-duotong"],
    summary: "汉武帝遣唐蒙出使夜郎，夜郎侯多同归附，开西南夷通道。",
  }),
  eventPoint({
    id: "han-destroy-qielan",
    name: "汉灭且兰",
    kind: "battle",
    at: ym(-111),
    dynastyIds: ["qielan", "qiongdu", "zuodu", "ranmang", "baima"],
    participantIds: ["qielan-jun", "qiong-jun", "zuo-hou"],
    summary: "汉武帝遣郭昌、卫广等伐西南夷，且兰（头兰）及邛都、莋都、冉駹、白马等国为汉所灭。",
  }),
  eventPoint({
    id: "dian-surrender-han",
    name: "滇国降汉",
    kind: "politics",
    at: ym(-109),
    dynastyIds: ["dian", "laomo"],
    participantIds: ["dian-changqiang"],
    summary: "汉武帝元封二年，滇王尝羌率众降汉，设益州郡，劳深靡莫等部亦平定。",
  }),
  eventPoint({
    id: "yelang-xin-killed",
    name: "夜郎王兴被杀",
    kind: "politics",
    at: ym(-27),
    dynastyIds: ["yelang"],
    participantIds: ["yelang-xin"],
    summary: "夜郎王兴为邛郿侯陈立所杀，夜郎国亡。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "tangmeng-tong-yelang", dynastyId: "han-west" },
  { eventId: "han-destroy-qielan", dynastyId: "han-west" },
  { eventId: "dian-surrender-han", dynastyId: "han-west" },
  { eventId: "yelang-xin-killed", dynastyId: "han-west" },
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
  { id: "rel-tangmeng-yelang", fromRef: "event:tangmeng-tong-yelang", toRef: "dynasty:yelang", kind: "other" },
  { id: "rel-han-destroy-qielan", fromRef: "event:han-destroy-qielan", toRef: "dynasty:qielan", kind: "battle" },
  { id: "rel-dian-surrender", fromRef: "event:dian-surrender-han", toRef: "dynasty:dian", kind: "other" },
  { id: "rel-yelang-xin-killed", fromRef: "event:yelang-xin-killed", toRef: "person:yelang-xin", kind: "other" },
);

const manifest = {
  slug: "xinan-guozheng",
  title: "西汉西南夷诸国（含夜郎）",
  window: { startYear: -300, startMonth: 1, endYear: -27, endMonth: 12 },
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
    { label: "史记·西南夷列传", url: "https://zh.wikipedia.org/wiki/西南夷" },
    { label: "夜郎", url: "https://zh.wikipedia.org/wiki/夜郎" },
    { label: "滇国", url: "https://zh.wikipedia.org/wiki/滇国" },
    { label: "庄蹻", url: "https://zh.wikipedia.org/wiki/庄蹻" },
    { label: "邛都", url: "https://zh.wikipedia.org/wiki/邛都" },
    { label: "且兰", url: "https://zh.wikipedia.org/wiki/且兰" },
  ],
  notes: [
    "覆盖夜郎、滇国及邛都、莋都、冉駹、白马、且兰、劳深靡莫等西南夷古国。",
    "君主在位年无通行记载时，仅取史料锚点前后短窗口，禁止用王朝起讫年硬填。",
    "多同取唐蒙通夜郎（前135）前后约二十年；兴取被杀前数年；尝羌取降汉前数年。",
    "庄蹻与尝羌之间、多同与兴之间世系失考，中间空缺不补齐。",
    "冉駹、白马、劳深靡莫无通行君主名，仅王朝行与事件。",
    "precision=year，scope=cn，region=east_asia。",
  ],
};

writeImportPackage(__dirname, {
  slug: "xinan-guozheng",
  window: manifest.window,
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  supplementalEventDynasties,
  manifest,
});
