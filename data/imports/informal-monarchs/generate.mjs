#!/usr/bin/env node
/**
 * Generate EraLens import SQL for informal monarchs / non-formal sovereigns.
 * Marks existing reigns and inserts missing ones with is_informal_monarch = true.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { writeImportPackage, person, reign, ym, absMonth, sqlStr } from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Helper for reigns with informal flag
function informalReign(data) {
  const baseReign = reign(data);
  return { ...baseReign, isInformalMonarch: true };
}

const persons = [
  // 共伯和 (周公、召公 or 共伯和本人，史料有争议)
  person(
    "gonghe-regency",
    "共伯和",
    ["摄政"],
    "周厉王出奔后，一说周公、召公共和行政，一说共伯和摄政。前841–前828年，共和行政。",
    "共伯和",
    null,
    null,
    ["周公", "召公"],
  ),
  // 王莽摄政期
  person(
    "wang-mang-regent",
    "王莽",
    ["摄政", "权臣"],
    "西汉末年权臣，6–8年以摄皇帝/假皇帝名义摄政，后于9年篡汉建新。",
    "王莽",
    ym(-45),
    ym(23, 10),
  ),
  // 述律平
  person(
    "shulvping",
    "述律平",
    ["太后"],
    "辽太祖耶律阿保机皇后，应天太后。926年太祖崩后称制，927年推举太宗即位。",
    "述律平",
    ym(879),
    ym(953),
  ),
  // 乃马真后
  person(
    "toregene-khatun",
    "乃马真后",
    ["皇后"],
    "窝阔台皇后，窝阔台汗崩后称制，1241–1246年监国，直到贵由即位。",
    "乃马真后",
    null,
    ym(1246),
  ),
  // 海迷失后
  person(
    "oghul-qaimish",
    "海迷失后",
    ["皇后"],
    "贵由皇后，贵由汗崩后称制，1248–1251年监国，蒙哥即位后被处死。",
    "海迷失后",
    null,
    ym(1251),
  ),
];

const reigns = [
  // 1. 西周 - 共和行政 (前841–前828)
  informalReign({
    id: "reign-gonghe-zhou-west",
    dynastyId: "zhou-west",
    personId: "gonghe-regency",
    title: "共和行政",
    posthumousName: null,
    templeName: null,
    start: ym(-841, 12),
    end: ym(-828, 12),
    precision: "year",
  }),

  // 3. 西汉末期 - 王莽摄政期 (6–8年)
  informalReign({
    id: "reign-wang-mang-regent",
    dynastyId: "han-west",
    personId: "wang-mang-regent",
    title: "摄皇帝",
    posthumousName: null,
    templeName: null,
    start: ym(6, 4),
    end: ym(8, 11),
    precision: "year",
  }),

  // 4. 辽朝 - 述律平称制 (926–927)
  informalReign({
    id: "reign-shulvping-liao",
    dynastyId: "liao",
    personId: "shulvping",
    title: "应天太后称制",
    posthumousName: null,
    templeName: null,
    start: ym(926, 7),
    end: ym(927, 11),
    precision: "year",
  }),

  // 5. 五代·后汉 - 郭威监国 (950–951)
  informalReign({
    id: "reign-guo-wei-regent-han-hou",
    dynastyId: "han-hou",
    personId: "guo-wei",
    title: "监国",
    posthumousName: null,
    templeName: null,
    start: ym(950, 12),
    end: ym(951, 1),
    precision: "year",
  }),

  // 6. 蒙古帝国 - 拖雷监国 (1227–1229)
  informalReign({
    id: "reign-tolui-mongol",
    dynastyId: "mongol",
    personId: "tolui",
    title: "监国",
    posthumousName: null,
    templeName: null,
    start: ym(1227, 8),
    end: ym(1229, 9),
    precision: "year",
  }),

  // 6. 蒙古帝国 - 乃马真后称制 (1241–1246)
  informalReign({
    id: "reign-toregene-mongol",
    dynastyId: "mongol",
    personId: "toregene-khatun",
    title: "称制皇后",
    posthumousName: null,
    templeName: null,
    start: ym(1241, 12),
    end: ym(1246, 8),
    precision: "year",
  }),

  // 6. 蒙古帝国 - 海迷失后称制 (1248–1251)
  informalReign({
    id: "reign-oghul-qaimish-mongol",
    dynastyId: "mongol",
    personId: "oghul-qaimish",
    title: "称制皇后",
    posthumousName: null,
    templeName: null,
    start: ym(1248, 4),
    end: ym(1251, 7),
    precision: "year",
  }),

  // 7. 明朝 - 朱祁钰监国 (1449年约1个月)
  informalReign({
    id: "reign-zhu-qiyu-regent-ming",
    dynastyId: "ming",
    personId: "zhu-qiyu",
    title: "郕王监国",
    posthumousName: null,
    templeName: null,
    start: { year: 1449, month: 9, day: 6, abs: absMonth(1449, 9) },
    end: { year: 1449, month: 9, day: 22, abs: absMonth(1449, 9) },
    precision: "day",
  }),
];

const dynasties = [];
const events = [];
const relations = [];
const reignGroups = [];

// UPDATE statements for existing reigns to mark as informal
const existingInformalReigns = [
  // 2. 西汉末期 - 孺子婴
  "reign-ruzi-ying",
  // 8. 南明 - 鲁王朱以海
  "reign-zhu-yihai-ming-south",
  // 9. 中华民国 - 段祺瑞
  "reign-duan-qirui-roc",
  // 9. 中华民国 - 张作霖
  "reign-zhang-zuolin-roc",
  // 10. 中华人民共和国 - 宋庆龄
  "reign-song-qingling-prc",
  // 10. 中华人民共和国 - 董必武 (副主席)
  "reign-dong-biwu-prc-vice",
  // 10. 中华人民共和国 - 董必武 (代主席)
  "reign-dong-biwu-prc",
  // 10. 中华人民共和国 - 全国人大常委会
  "reign-npc-standing-committee-prc",
];

const manifest = {
  slug: "informal-monarchs",
  title: "非正式国君",
  window: { startYear: -841, startMonth: 1, endYear: 2026, endMonth: 9 },
  scope: "cn",
  depth: "supplemental",
  generatedAt: new Date().toISOString().split("T")[0],
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  description:
    "Informal monarchs: regents, acting heads, joint vice-chairs, and non-formal sovereigns. Marks existing reigns and inserts missing ones with is_informal_monarch = true.",
  sources: [
    {
      label: "维基百科 - 共和行政",
      url: "https://zh.wikipedia.org/wiki/共和_(西周)",
    },
    {
      label: "维基百科 - 王莽",
      url: "https://zh.wikipedia.org/wiki/王莽",
    },
    {
      label: "维基百科 - 述律平",
      url: "https://zh.wikipedia.org/wiki/述律平",
    },
    {
      label: "维基百科 - 郭威",
      url: "https://zh.wikipedia.org/wiki/郭威",
    },
    {
      label: "维基百科 - 拖雷",
      url: "https://zh.wikipedia.org/wiki/拖雷",
    },
    {
      label: "维基百科 - 乃马真后",
      url: "https://zh.wikipedia.org/wiki/乃马真后",
    },
    {
      label: "维基百科 - 海迷失后",
      url: "https://zh.wikipedia.org/wiki/海迷失后",
    },
    {
      label: "维基百科 - 朱祁钰",
      url: "https://zh.wikipedia.org/wiki/朱祁钰",
    },
    {
      label: "维基百科 - 朱以海",
      url: "https://zh.wikipedia.org/wiki/朱以海",
    },
  ],
  notes: [
    "共和行政（前841–828）：史料争议，一说周公、召公共和，一说共伯和摄政；此处建 reign 以承载非正式国君标记。",
    "王莽摄政期（6–8）：以摄皇帝/假皇帝名义摄政，9年篡汉建新；摄政期为非正式国君。",
    "述律平（926–927）：应天太后称制，推举太宗前为非正式国君。",
    "郭威监国（950–951）：后汉末年监国，后建后周；监国期为非正式国君。",
    "拖雷、乃马真后、海迷失后：蒙古帝国监国/称制，非正式可汗。",
    "朱祁钰监国（1449-09-06 至 09-22）：土木堡之变后监国约16天，9月22日即位为明代宗。",
    "鲁王朱以海：绍兴监国，南明并立政权，非正式皇帝。",
    "段祺瑞、张作霖：北洋军阀时期临时执政、陆海军大元帅，非正式国家元首。",
    "宋庆龄、董必武、全国人大常委会：国家副主席代行、代主席、机构行使元首职权，非正式国家主席。",
  ],
};

// Generate UPDATE SQL for existing reigns
const updateSql = existingInformalReigns
  .map((reignId) => `UPDATE reigns SET is_informal_monarch = true WHERE id = ${sqlStr(reignId)};`)
  .join("\n");

writeImportPackage(__dirname, {
  slug: "informal-monarchs",
  window: manifest.window,
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  preSql: updateSql,
  manifest,
});
