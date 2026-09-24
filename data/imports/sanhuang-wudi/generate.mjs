#!/usr/bin/env node
/**
 * 三皇（伏羲、女娲、神农）与五帝（黄帝→挚→舜）。
 * 在位年取《帝王世纪》/《史记》相对年数，下锚夏始前2070；两侧标 interpolated。
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyFeudalClanMetadata } from "../lib/applyFeudalClanMetadata.mjs";
import { validateReignDateConfidenceSeams } from "../lib/validateReignSeams.mjs";
import {
  eventPoint,
  reign,
  successionPairs,
  writeImportPackage,
  ym,
} from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const wiki = (title) => [
  { label: "维基百科", url: `https://zh.wikipedia.org/wiki/${title}` },
];

function legendReign({
  id,
  dynastyId,
  personId,
  title,
  card,
  startYear,
  endYear,
  startInterpolated = true,
  endInterpolated = true,
}) {
  return reign({
    id,
    dynastyId,
    personId,
    title: card ?? title,
    start: ym(startYear),
    end: ym(endYear, 12),
    startDateConfidence: startInterpolated ? "interpolated" : null,
    endDateConfidence: endInterpolated ? "interpolated" : null,
  });
}

const persons = [
  {
    id: "feng-fuxi",
    name: "伏羲",
    altNames: ["伏羲", "太昊", "庖牺"],
    ancestralXing: "风",
    roles: ["君主"],
    bio: "太昊伏羲氏，司马贞《三皇本纪》三皇之一。制嫁娶、作网罟，传说文明之始。在位年取《帝王世纪》一百十年，绝对年代为传说推算。",
    links: wiki("伏羲"),
  },
  {
    id: "feng-nuwa",
    name: "女娲",
    altNames: ["女娲", "娲皇"],
    ancestralXing: "风",
    roles: ["君主"],
    bio: "女娲氏，司马贞《三皇本纪》承伏羲制度。补天、抟土造人传说。无单独在位年，此取与伏羲相同一百十年，manifest 注明无出典。",
    links: wiki("女娲"),
  },
  {
    id: "jiang-shinian",
    name: "石年",
    altNames: ["神农", "炎帝", "神农氏"],
    ancestralXing: "姜",
    roles: ["君主"],
    bio: "炎帝神农氏，司马贞《三皇本纪》三皇末位。尝百草、教稼穑。在位年取《帝王世纪》一百二十年。",
    links: wiki("神农氏"),
  },
  {
    id: "ji-xuanyuan",
    name: "轩辕",
    altNames: ["黄帝", "轩辕", "有熊"],
    ancestralXing: "姬",
    roles: ["君主"],
    bio: "黄帝轩辕氏，《史记·五帝本纪》五帝之首。阪泉、涿鹿传说。在位一百年取《帝王世纪》。",
    links: wiki("黄帝"),
  },
  {
    id: "ji-zhuanxu",
    name: "颛顼",
    altNames: ["颛顼", "高阳"],
    ancestralXing: "姬",
    roles: ["君主"],
    bio: "帝颛顼高阳氏，黄帝孙。在位七十八年取《帝王世纪》。",
    links: wiki("颛顼"),
  },
  {
    id: "ji-ku",
    name: "夋",
    altNames: ["帝喾", "高辛", "俊"],
    ancestralXing: "姬",
    roles: ["君主"],
    bio: "帝喾高辛氏，黄帝曾孙。在位七十年取《帝王世纪》（不用今本竹书六十三）。",
    links: wiki("帝喾"),
  },
  {
    id: "ji-zhi",
    name: "挚",
    altNames: ["帝挚", "挚"],
    ancestralXing: "姬",
    roles: ["君主"],
    bio: "帝挚，帝喾子；立不善，放勋代之。《帝王世纪》在位九年，史记过渡人物。",
    links: wiki("帝挚"),
  },
  {
    id: "yiqi-fangxun",
    name: "放勋",
    altNames: ["尧", "唐尧", "陶唐", "伊祁放勋", "放勋"],
    ancestralXing: "祁",
    clanShi: "陶唐",
    roles: ["君主"],
    bio: "帝尧陶唐氏，帝喾子，祁姓，名放勋。通行称陶唐氏；后世或作伊祁，维基条目取姓祁。在位九十八年取《帝王世纪》。",
    links: wiki("尧"),
  },
  {
    id: "yao-chonghua",
    name: "重华",
    altNames: ["舜", "虞舜", "重华"],
    ancestralXing: "姚",
    roles: ["君主"],
    bio: "帝舜有虞氏。史记践帝位后三十九年；不用尚书「五十载」以免与尧世摄政重叠。",
    links: wiki("舜"),
  },
];

const dynasties = [
  {
    id: "san-huang",
    name: "三皇",
    altNames: ["伏羲氏", "女娲氏", "神农氏"],
    scope: "cn",
    region: "east_asia",
    start: ym(-2804),
    end: ym(-2465, 12),
    precision: "year",
    note: "司马贞《三皇本纪》：伏羲、女娲、神农。在位年取《帝王世纪》伏羲一百十年、神农一百二十年；女娲无年，与伏羲同长。",
  },
  {
    id: "wu-di",
    name: "五帝",
    altNames: ["黄帝", "颛顼", "帝喾", "尧", "舜"],
    scope: "cn",
    region: "east_asia",
    start: ym(-2464),
    end: ym(-2071, 12),
    precision: "year",
    note: "《史记·五帝本纪》世系，含帝挚过渡。相对在位年下锚夏始前2071，绝对年代为传说推算。",
  },
];

const reigns = [
  legendReign({
    id: "reign-feng-fuxi",
    dynastyId: "san-huang",
    personId: "feng-fuxi",
    title: "伏羲",
    card: "伏羲",
    startYear: -2804,
    endYear: -2695,
  }),
  legendReign({
    id: "reign-feng-nuwa",
    dynastyId: "san-huang",
    personId: "feng-nuwa",
    title: "女娲",
    card: "女娲",
    startYear: -2694,
    endYear: -2585,
  }),
  legendReign({
    id: "reign-jiang-shinian",
    dynastyId: "san-huang",
    personId: "jiang-shinian",
    title: "神农",
    card: "神农",
    startYear: -2584,
    endYear: -2465,
  }),
  legendReign({
    id: "reign-ji-xuanyuan",
    dynastyId: "wu-di",
    personId: "ji-xuanyuan",
    title: "黄帝",
    card: "黄帝",
    startYear: -2464,
    endYear: -2365,
  }),
  legendReign({
    id: "reign-ji-zhuanxu",
    dynastyId: "wu-di",
    personId: "ji-zhuanxu",
    title: "颛顼",
    card: "颛顼",
    startYear: -2364,
    endYear: -2287,
  }),
  legendReign({
    id: "reign-ji-ku",
    dynastyId: "wu-di",
    personId: "ji-ku",
    title: "帝喾",
    card: "帝喾",
    startYear: -2286,
    endYear: -2217,
  }),
  legendReign({
    id: "reign-ji-zhi",
    dynastyId: "wu-di",
    personId: "ji-zhi",
    title: "帝挚",
    card: "挚",
    startYear: -2216,
    endYear: -2208,
  }),
  legendReign({
    id: "reign-yiqi-fangxun",
    dynastyId: "wu-di",
    personId: "yiqi-fangxun",
    title: "尧",
    card: "尧",
    startYear: -2207,
    endYear: -2110,
  }),
  legendReign({
    id: "reign-yao-chonghua",
    dynastyId: "wu-di",
    personId: "yao-chonghua",
    title: "舜",
    card: "舜",
    startYear: -2109,
    endYear: -2071,
  }),
];

const seamErrors = validateReignDateConfidenceSeams(reigns);
if (seamErrors.length) {
  console.error("Reign seam validation failed:");
  for (const err of seamErrors) console.error(" ", err);
  process.exit(1);
}

const personDynastyId = {
  "feng-fuxi": "san-huang",
  "feng-nuwa": "san-huang",
  "jiang-shinian": "san-huang",
  "ji-xuanyuan": "wu-di",
  "ji-zhuanxu": "wu-di",
  "ji-ku": "wu-di",
  "ji-zhi": "wu-di",
  "yiqi-fangxun": "wu-di",
  "yao-chonghua": "wu-di",
};

applyFeudalClanMetadata({ persons, dynasties, personDynastyId });

const events = [
  eventPoint({
    id: "banquan-zhulu",
    name: "阪泉、涿鹿",
    kind: "battle",
    precision: "year",
    dateNote: "炎黄之际传说战役，年代不可考；取神农末至黄帝初窗口。",
    at: ym(-2465, 12),
    summary: "传说炎帝末与黄帝阪泉之战，又逐鹿之战胜蚩尤。年代为文献系年，非考古断代。",
  }),
  eventPoint({
    id: "yao-shun-abdication",
    name: "尧舜禅让",
    kind: "politics",
    precision: "year",
    dateNote: "尧世末舜摄政、禅让传说；取尧在位末年约前2110年。",
    at: ym(-2110, 12),
    summary: "《史记》载尧禅舜；舜摄政不另建在位卡，以事件标于尧世末。",
  }),
  eventPoint({
    id: "shun-yu-abdication",
    name: "舜禹禅让",
    kind: "politics",
    precision: "year",
    dateNote: "舜禅禹、禹继夏后氏；取舜迄年前2071年。",
    at: ym(-2071, 12),
    summary: "舜禅禹，禹建夏后氏，接断代工程夏始前2070年。",
  }),
];

const successionChain = [
  { personId: "feng-fuxi" },
  { personId: "feng-nuwa" },
  { personId: "jiang-shinian" },
  { personId: "ji-xuanyuan" },
  { personId: "ji-zhuanxu" },
  { personId: "ji-ku" },
  { personId: "ji-zhi" },
  { personId: "yiqi-fangxun" },
  { personId: "yao-chonghua" },
  { personId: "si-yu" },
];
const relations = successionPairs(successionChain).map(([fromId, toId]) => ({
  id: `rel-${fromId}-${toId}-succession`,
  fromRef: `person:${fromId}`,
  toRef: `person:${toId}`,
  kind: "succession",
}));

const manifest = {
  slug: "sanhuang-wudi",
  title: "三皇五帝",
  window: { startYear: -2804, startMonth: 1, endYear: -2071, endMonth: 12 },
  scope: "cn",
  depth: "minimal",
  generatedAt: new Date().toISOString().slice(0, 10),
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "史记·五帝本纪", url: "https://zh.wikisource.org/wiki/史記/卷01" },
    { label: "史记·三皇本纪（司马贞补）", url: "https://zh.wikisource.org/wiki/史記/卷01" },
    { label: "帝王世纪", url: "https://zh.wikipedia.org/wiki/帝王世纪" },
    { label: "伏羲", url: "https://zh.wikipedia.org/wiki/伏羲" },
    { label: "女娲", url: "https://zh.wikipedia.org/wiki/女娲" },
    { label: "神农氏", url: "https://zh.wikipedia.org/wiki/神农氏" },
    { label: "黄帝", url: "https://zh.wikipedia.org/wiki/黄帝" },
    { label: "夏商周断代工程", url: "https://zh.wikipedia.org/wiki/夏商周断代工程" },
  ],
  notes: [
    "三皇取司马贞《三皇本纪》伏羲、女娲、神农；五帝取《史记》黄帝、颛顼、帝喾、挚、尧、舜。",
    "相对在位年：《帝王世纪》伏羲110、神农120；女娲无年与伏羲同110；五帝黄帝100、颛顼78、喾70、挚9、尧98、舜39（史记践帝位）。下锚舜迄前2071接夏禹前2070。",
    "全部在位起迄标 interpolated；黄帝纪元前2697仅作后世纪年参照，不作在位元年。",
    "三皇、五帝不上正统金色。舜禹禅让 relation 指向夏包 si-yu。",
    "尧取维基「姓祁、名放勋、陶唐氏」；伊祁为索隐/帝王世纪一说，不写入 ancestral_xing。",
  ],
};

writeImportPackage(__dirname, {
  slug: "sanhuang-wudi",
  window: manifest.window,
  persons,
  dynasties,
  reigns,
  events,
  relations,
  manifest,
});
