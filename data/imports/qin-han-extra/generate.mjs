#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Nanyue and Chimei (南越、赤眉).
 * Supplements qin-han with regional/transitional polities.
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
  person("zhao-tuo", "赵佗", ["君主"], "南越开国君主，秦将，秦亡后据岭南自立，前203年建南越国。", "赵佗", ym(-240), ym(-137)),
  person("zhao-mo", "赵眜", ["君主"], "南越文王，赵佗孙，在位期间与汉朝修好。", "赵眜"),
  person("zhao-yingqi", "赵婴齐", ["君主"], "南越明王，赵眜之子，归汉入朝，卒于长安。", "赵婴齐"),
  person("zhao-xing", "赵兴", ["君主"], "南越末王之一，赵婴齐之子，年幼即位，为吕嘉所杀。", "赵兴"),
  person("zhao-jiande", "赵建德", ["君主"], "南越末代君主，吕嘉所立，前111年汉军灭南越时被俘。", "赵建德"),
  person("liu-panzi", "刘盆子", ["君主"], "赤眉军所立皇帝，西汉末被立为帝，后降刘秀。", "刘盆子"),
  person("fan-chong", "樊崇", ["起义领袖"], "赤眉军首领，拥立刘盆子称帝，后降刘秀。", "樊崇"),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "nanyue",
    name: "南越",
    altNames: ["南越国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-203),
    end: ym(-111),
    precision: "year",
    colorToken: nextColor(),
    note: "赵佗据岭南自立，前203年建国；前111年汉武帝遣军灭南越，设九郡。",
  },
  {
    id: "chimei",
    name: "赤眉",
    altNames: ["赤眉军"],
    scope: "cn",
    region: "east_asia",
    start: ym(23),
    end: ym(27),
    precision: "year",
    colorToken: nextColor(),
    note: "新莽末赤眉起义军政权，樊崇为首，25年立刘盆子为帝，27年降刘秀。",
  },
];

// ── reigns ─────────────────────────────────────────────────────────────────

const nanyueReigns = [
  dr("nanyue", "zhao-tuo", "南越武王", null, null, -203, -137),
  dr("nanyue", "zhao-mo", "南越文王", null, null, -137, -122),
  dr("nanyue", "zhao-yingqi", "南越明王", null, null, -122, -112),
  dr("nanyue", "zhao-xing", "南越王", null, null, -112, -111),
  dr("nanyue", "zhao-jiande", "南越王", null, null, -111, -111),
];

const chimeiReigns = [
  dr("chimei", "fan-chong", "赤眉首领", null, null, 23, 27),
  dr("chimei", "liu-panzi", "赤眉帝", null, null, 25, 27),
];

const reignGroups = [nanyueReigns, chimeiReigns];
const reigns = reignGroups.flat();

// ── events ───────────────────────────────────────────────────────────────────

const events = [
  eventPoint({
    id: "nanyue-founded",
    name: "南越建国",
    kind: "politics",
    at: ym(-203),
    dynastyIds: ["nanyue"],
    participantIds: ["zhao-tuo"],
    summary: "赵佗据岭南自立，建南越国，都番禺。",
  }),
  eventPoint({
    id: "nanyue-destroyed",
    name: "汉灭南越",
    kind: "battle",
    at: ym(-111),
    dynastyIds: ["nanyue"],
    participantIds: ["zhao-jiande"],
    summary: "汉武帝遣路博德、杨仆等伐南越，俘赵建德，南越亡，设岭南九郡。",
  }),
  eventPoint({
    id: "chimei-capture-changan",
    name: "赤眉入长安",
    kind: "battle",
    at: ym(25),
    dynastyIds: ["chimei"],
    participantIds: ["fan-chong", "liu-panzi"],
    summary: "赤眉军攻入长安，杀更始帝刘玄，立刘盆子为帝，更始政权终结。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "nanyue-destroyed", dynastyId: "han-west" },
  { eventId: "chimei-capture-changan", dynastyId: "han-gengshi" },
];

const supplementalEventParticipants = [
  { eventId: "chimei-capture-changan", personId: "liu-xuan" },
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
  { id: "rel-nanyue-founded", fromRef: "event:nanyue-founded", toRef: "dynasty:nanyue", kind: "other" },
  { id: "rel-nanyue-destroyed", fromRef: "event:nanyue-destroyed", toRef: "dynasty:nanyue", kind: "battle" },
  { id: "rel-chimei-changan", fromRef: "event:chimei-capture-changan", toRef: "dynasty:chimei", kind: "battle" },
);

// ── manifest & write ─────────────────────────────────────────────────────────

const manifest = {
  slug: "qin-han-extra",
  title: "秦汉补充：南越与赤眉",
  window: { startYear: -203, startMonth: 1, endYear: 27, endMonth: 12 },
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
    { label: "南越国", url: "https://zh.wikipedia.org/wiki/南越国" },
    { label: "赵佗", url: "https://zh.wikipedia.org/wiki/赵佗" },
    { label: "南越国君主列表", url: "https://zh.wikipedia.org/wiki/南越国君主列表" },
    { label: "赤眉军", url: "https://zh.wikipedia.org/wiki/赤眉军" },
    { label: "刘盆子", url: "https://zh.wikipedia.org/wiki/刘盆子" },
    { label: "樊崇", url: "https://zh.wikipedia.org/wiki/樊崇" },
  ],
  notes: [
    "南越赵氏五世（赵佗至赵建德），前203–前111；赤眉为西汉末过渡政权（23–27）。",
    "赵兴为吕嘉所杀后赵建德即位，同年汉军灭南越。",
    "赤眉入长安事件关联更始帝刘玄（见 qin-han 包 liu-xuan）。",
    "西汉、更始关联见 qin-han 包，本包以 supplemental 补充。",
    "precision=year，scope=cn，region=east_asia。",
  ],
};

writeImportPackage(__dirname, {
  slug: "qin-han-extra",
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
