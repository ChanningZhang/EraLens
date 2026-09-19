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
    note: "战国时已有夜郎；汉武帝时夜郎侯多同，末王兴前27年被诛。君主在位年多失考，不强行拉满王朝跨度。",
  },
  {
    id: "dian",
    name: "滇",
    altNames: ["滇国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-279),
    end: ym(-109),
    precision: "year",
    note: "楚将庄蹻入滇称王；武帝元封二年（前109）尝羌降汉，设益州郡。庄蹻与尝羌之间世系失考。",
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

const reignGroups = [yelangReigns, dianReigns];
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
    id: "han-pacify-southwest-yi",
    name: "汉平西南夷",
    kind: "battle",
    at: ym(-111),
    dynastyIds: [],
    participantIds: [],
    summary: "汉武帝遣郭昌、卫广等伐西南夷，且兰（头兰）及邛都、莋都、冉駹、白马等国为汉所灭。",
  }),
  eventPoint({
    id: "dian-surrender-han",
    name: "滇国降汉",
    kind: "politics",
    at: ym(-109),
    dynastyIds: ["dian"],
    participantIds: ["dian-changqiang"],
    summary: "汉武帝元封二年，滇王尝羌率众降汉，设益州郡。",
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
  { eventId: "han-pacify-southwest-yi", dynastyId: "han-west" },
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
  { id: "rel-han-pacify-southwest-yi", fromRef: "event:han-pacify-southwest-yi", toRef: "dynasty:han-west", kind: "battle" },
  { id: "rel-dian-surrender", fromRef: "event:dian-surrender-han", toRef: "dynasty:dian", kind: "other" },
  { id: "rel-yelang-xin-killed", fromRef: "event:yelang-xin-killed", toRef: "person:yelang-xin", kind: "other" },
);

const removedDynastyIds = ["qiongdu", "zuodu", "ranmang", "baima", "qielan", "laomo"];
const removedPersonIds = ["qiong-jun", "zuo-hou", "qielan-jun"];
const removedReignIds = [
  "reign-qiong-jun-qiongdu",
  "reign-zuo-hou-zuodu",
  "reign-qielan-jun-qielan",
];

const preSql = [
  `DELETE FROM event_dynasties WHERE dynasty_id IN (${removedDynastyIds.map((id) => `'${id}'`).join(", ")});`,
  `DELETE FROM event_dynasties WHERE event_id = 'han-destroy-qielan';`,
  `DELETE FROM event_participants WHERE person_id IN (${removedPersonIds.map((id) => `'${id}'`).join(", ")});`,
  `DELETE FROM event_participants WHERE event_id = 'han-destroy-qielan';`,
  "DELETE FROM relations WHERE id = 'rel-han-destroy-qielan';",
  `DELETE FROM reigns WHERE id IN (${removedReignIds.map((id) => `'${id}'`).join(", ")});`,
  `DELETE FROM reigns WHERE dynasty_id IN (${removedDynastyIds.map((id) => `'${id}'`).join(", ")});`,
  `DELETE FROM persons WHERE id IN (${removedPersonIds.map((id) => `'${id}'`).join(", ")});`,
  `DELETE FROM dynasties WHERE id IN (${removedDynastyIds.map((id) => `'${id}'`).join(", ")});`,
  "DELETE FROM events WHERE id = 'han-destroy-qielan';",
].join("\n");

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
  ],
  notes: [
    "覆盖夜郎、滇国两大西南夷政权；其余小国仅保留汉平西南夷事件，不单独建王朝行。",
    "君主在位年无通行记载时，仅取史料锚点前后短窗口，禁止用王朝起讫年硬填。",
    "多同取唐蒙通夜郎（前135）前后约二十年；兴取被杀前数年；尝羌取降汉前数年。",
    "庄蹻与尝羌之间、多同与兴之间世系失考，中间空缺不补齐。",
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
  preSql,
  manifest,
});
