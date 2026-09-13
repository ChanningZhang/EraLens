#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Liao remnants: Western Liao, Northern Liao, Eastern Liao.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  person,
  dr,
  eventPoint,
  eventRange,
  writeImportPackage,
  nextColor,
  successionPairs,
  ym,
} from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  // 西辽
  person("yelu-dashi", "耶律大石", ["皇帝"], "西辽德宗，辽亡后西迁建国，定都虎思，称霸中亚。", "耶律大石", ym(1087), ym(1143)),
  person("xiao-tabuyan", "萧塔不烟", ["皇帝", "政治家"], "西辽感天皇后，耶律大石妻，1143–1150年临朝称制。", "萧塔不烟"),
  person("yelu-yilie", "耶律夷列", ["皇帝"], "西辽仁宗，耶律大石之子，1150–1163年在位。", "耶律夷列"),
  person("yelu-pusuwan", "耶律普速完", ["皇帝", "政治家"], "西辽承天太后，耶律夷列之妹，1163–1177年临朝称制。", "耶律普速完"),
  person("yelu-zhilugu", "耶律直鲁古", ["皇帝"], "西辽第五任君主，1177–1211年在位，后被屈出律篡位。", "耶律直鲁古"),
  person("qu-chulu", "屈出律", ["皇帝"], "乃蛮部王子，娶耶律直鲁古之女，1211年篡位，1218年西辽亡于蒙古。", "屈出律"),
  // 北辽
  person("yelu-chun", "耶律淳", ["皇帝"], "辽末宗室，金攻辽时于燕京称帝，国号北辽，在位仅一年余。", "耶律淳"),
  person("xiao-defei", "萧德妃", ["后妃", "政治家"], "耶律淳妃，耶律淳死后临朝称制，北辽旋亡。", "萧德妃"),
  // 东辽
  person("yelu-liuge", "耶律留哥", ["皇帝"], "金末契丹将领，1213年称王建国号辽，史称东辽。", "耶律留哥", ym(1165), ym(1220)),
  person("yao-li-shi", "姚里氏", ["皇帝", "皇后"], "耶律留哥妻，留哥死后嗣位，1220–1226年在位。", "姚里氏"),
  person("yelu-xieshe", "耶律薛阇", ["皇帝"], "耶律留哥之弟，1226–1238年在位。", "耶律薛阇"),
  person("yelu-shouguonu", "耶律收国奴", ["皇帝"], "耶律薛阇之子，1238–1259年在位。", "耶律收国奴"),
  person("yelu-gunai", "耶律古乃", ["皇帝"], "东辽末代君主，1259–1269年在位，后降蒙古。", "耶律古乃"),
  person("yelu-sibu", "耶律厮不", ["宗室"], "耶律留哥之弟，封郡王，后叛留哥，东辽内乱。", "耶律厮不"),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "xiliao",
    name: "西辽",
    altNames: ["哈剌契丹", "黑契丹"],
    scope: "cn",
    region: "east_asia",
    start: ym(1124),
    end: ym(1218, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "耶律大石辽亡后西迁，1124年镇州称王；1218年蒙古攻灭。",
  },
  {
    id: "beiliao",
    name: "北辽",
    altNames: ["燕京辽"],
    scope: "cn",
    region: "east_asia",
    start: ym(1122),
    end: ym(1123, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "1122年耶律淳于燕京称帝，1123年旋亡；萧德妃称制不另建 reign。",
  },
  {
    id: "dongliao",
    name: "东辽",
    altNames: ["辽"],
    scope: "cn",
    region: "east_asia",
    start: ym(1213),
    end: ym(1269, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "1213年耶律留哥称王；1269年末代君主耶律古乃降蒙古。",
  },
];

// ── reigns ───────────────────────────────────────────────────────────────────

const xiliaoReigns = [
  dr("xiliao", "yelu-dashi", "西辽德宗", null, "德宗", 1124, 1143, [
    { name: "延庆", sy: 1124, ey: 1134 },
    { name: "康国", sy: 1134, ey: 1143 },
  ]),
  dr("xiliao", "xiao-tabuyan", "感天皇后", null, null, 1143, 1150, [{ name: "咸清", sy: 1143, ey: 1150 }]),
  dr("xiliao", "yelu-yilie", "西辽仁宗", null, "仁宗", 1150, 1163, [{ name: "绍兴", sy: 1150, ey: 1163 }]),
  dr("xiliao", "yelu-pusuwan", "承天太后", null, null, 1163, 1177, [{ name: "崇福", sy: 1163, ey: 1177 }]),
  dr("xiliao", "yelu-zhilugu", "西辽皇帝", null, null, 1177, 1211, [{ name: "天禧", sy: 1177, ey: 1211 }]),
  dr("xiliao", "qu-chulu", "西辽皇帝", null, null, 1211, 1218),
];

const beiliaoReigns = [
  dr("beiliao", "yelu-chun", "北辽皇帝", null, null, 1122, 1123),
];

const dongliaoReigns = [
  dr("dongliao", "yelu-liuge", "东辽国王", null, null, 1213, 1220, [{ name: "天统", sy: 1213, ey: 1220 }]),
  dr("dongliao", "yao-li-shi", "东辽国王", null, null, 1220, 1226),
  dr("dongliao", "yelu-xieshe", "东辽国王", null, null, 1226, 1238),
  dr("dongliao", "yelu-shouguonu", "东辽国王", null, null, 1238, 1259),
  dr("dongliao", "yelu-gunai", "东辽国王", null, null, 1259, 1269),
];

const reignGroups = [xiliaoReigns, beiliaoReigns, dongliaoReigns];
const reigns = reignGroups.flat();

// ── events ───────────────────────────────────────────────────────────────────

const events = [
  eventPoint({
    id: "xiliao-founded",
    name: "西辽建立",
    kind: "politics",
    dateNote: "1124年耶律大石镇州称王；1132年叶密立称帝",
    at: ym(1124),
    dynastyIds: ["xiliao"],
    participantIds: ["yelu-dashi"],
    summary: "耶律大石辽亡后西迁，于镇州称王改元延庆，西辽政权肇始。",
  }),
  eventPoint({
    id: "xiliao-fallen",
    name: "西辽灭亡",
    kind: "battle",
    at: ym(1218),
    dynastyIds: ["xiliao", "mongol-empire"],
    participantIds: ["qu-chulu"],
    summary: "蒙古军攻灭西辽，屈出律被俘处死，西辽亡。",
  }),
  eventPoint({
    id: "beiliao-founded",
    name: "北辽建立",
    kind: "politics",
    at: ym(1122),
    dynastyIds: ["beiliao", "liao"],
    participantIds: ["yelu-chun"],
    summary: "金军攻辽，耶律淳于燕京称帝，国号北辽，旋即覆灭。",
  }),
  eventRange({
    id: "beiliao-xiao-defei-regency",
    name: "萧德妃称制",
    kind: "politics",
    timeMode: "span",
    start: ym(1122),
    end: ym(1123),
    dynastyIds: ["beiliao"],
    participantIds: ["xiao-defei"],
    summary: "耶律淳死后萧德妃临朝称制，北辽不久即亡。",
  }),
  eventPoint({
    id: "dongliao-founded",
    name: "东辽建立",
    kind: "politics",
    at: ym(1213),
    dynastyIds: ["dongliao"],
    participantIds: ["yelu-liuge"],
    summary: "耶律留哥于辽东称王，定国号辽，改元天统，史称东辽。",
  }),
  eventPoint({
    id: "dongliao-yelu-sibu-rebel",
    name: "耶律厮不叛乱",
    kind: "politics",
    dateNote: "1213年前后，封郡王后叛留哥",
    at: ym(1214),
    dynastyIds: ["dongliao"],
    participantIds: ["yelu-sibu", "yelu-liuge"],
    summary: "耶律厮不等宗室叛东辽，留哥平定内乱，东辽政局动荡。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "jin-destroy-liao", dynastyId: "beiliao" },
];
const supplementalEventParticipants = [
  { eventId: "xiliao-fallen", personId: "temujin" },
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
  { id: "rel-xiliao-founded", fromRef: "event:xiliao-founded", toRef: "dynasty:xiliao", kind: "other" },
  { id: "rel-xiliao-fallen", fromRef: "event:xiliao-fallen", toRef: "dynasty:xiliao", kind: "battle" },
  { id: "rel-beiliao-founded", fromRef: "event:beiliao-founded", toRef: "dynasty:beiliao", kind: "other" },
  { id: "rel-dongliao-founded", fromRef: "event:dongliao-founded", toRef: "dynasty:dongliao", kind: "other" },
);

// ── output ───────────────────────────────────────────────────────────────────

writeImportPackage(__dirname, {
  slug: "liao-remnants",
  window: { startYear: 1122, startMonth: 1, endYear: 1269, endMonth: 12 },
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  supplementalEventDynasties,
  supplementalEventParticipants,
  manifest: {
    slug: "liao-remnants",
    title: "辽残余政权（西辽、北辽、东辽）",
    window: { startYear: 1122, startMonth: 1, endYear: 1269, endMonth: 12 },
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
      { label: "西辽", url: "https://zh.wikipedia.org/wiki/西辽" },
      { label: "耶律大石", url: "https://zh.wikipedia.org/wiki/耶律大石" },
      { label: "北辽", url: "https://zh.wikipedia.org/wiki/北辽" },
      { label: "东辽", url: "https://zh.wikipedia.org/wiki/东辽" },
      { label: "耶律留哥", url: "https://zh.wikipedia.org/wiki/耶律留哥" },
      { label: "辽朝君主列表", url: "https://zh.wikipedia.org/wiki/辽朝君主列表" },
    ],
    notes: [
      "覆盖西辽（1124–1218）、北辽（1122–1123）、东辽（1213–1269）三个残余政权。",
      "song-liao-jin 有 yelu-* 辽朝皇帝但无 yelu-dashi，本包新建西辽人物。",
      "萧德妃称制以事件收录，不建 reign；耶律厮不等叛乱亦以事件收录。",
      "西辽灭亡事件补充关联 mongol-empire 与 temujin（见 mongol-pre-yuan）。",
      "北辽建立事件补充关联 liao 王朝（见 song-liao-jin）。",
      "在位年取维基百科常见年表，precision=year。",
    ],
  },
});
