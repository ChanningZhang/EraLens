#!/usr/bin/env node
/**
 * Supplement Wei (曹魏) and Wu (孙吴) late emperors missing after seed import.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { defaultPreferredAppellation } from "../lib/defaultPreferredAppellation.mjs";
import {
  person,
  reign,
  eras,
  writeImportPackage,
  ym,
  successionPairs,
} from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

function dynastyReignMonth(
  dynastyId,
  personId,
  title,
  posthumous,
  temple,
  startYear,
  startMonth,
  endYear,
  endMonth,
  eraList = [],
  preferred = null,
) {
  const reignId = `reign-${personId}`;
  const pref =
    preferred ??
    defaultPreferredAppellation({ title, posthumous, temple, startYear, eraNames: eraList.length ? eras(reignId, eraList) : [] });
  return reign({
    id: reignId,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    preferred: pref,
    start: ym(startYear, startMonth),
    end: ym(endYear, endMonth),
    eraNames: eraList.length ? eras(reignId, eraList) : [],
    precision: "month",
  });
}

const persons = [
  person("cao-fang", "曹芳", ["皇帝"], "曹魏第三位皇帝，魏明帝之子，后被司马师废为齐王。", "曹芳", ym(231), ym(274)),
  person("cao-mao", "曹髦", ["皇帝"], "曹魏第四位皇帝，文帝孙，甘露五年被司马昭部卒所害。", "曹髦", ym(241), ym(260, 5)),
  person("cao-huan", "曹奂", ["皇帝"], "曹魏末代皇帝，咸熙二年禅位于司马炎，曹魏终结。", "曹奂", ym(246), ym(302)),
  person("sun-xiu", "孙休", ["皇帝"], "孙吴第三位皇帝，孙权第六子，在位期间整顿吏治。", "孙休", ym(235), ym(264, 9)),
  person("sun-hao", "孙皓", ["皇帝"], "孙吴末代皇帝，天纪四年降于晋，孙吴亡。", "孙皓", ym(242), ym(284)),
];

const weiReigns = [
  dynastyReignMonth("wei", "cao-fang", "魏少帝", "邵陵厉王", null, 239, 1, 254, 10, [
    { name: "正始", sy: 239, sm: 1, ey: 249 },
    { name: "嘉平", sy: 249, ey: 254, em: 10 },
  ]),
  dynastyReignMonth("wei", "cao-mao", "魏废帝", "高贵乡公", null, 254, 10, 260, 5, [
    { name: "正元", sy: 254, sm: 10, ey: 256 },
    { name: "甘露", sy: 257, ey: 260, em: 5 },
  ]),
  dynastyReignMonth("wei", "cao-huan", "魏元帝", "元皇帝", null, 260, 6, 266, 2, [
    { name: "景元", sy: 260, sm: 6, ey: 263 },
    { name: "咸熙", sy: 264, ey: 266, em: 2 },
  ]),
];

const wuReigns = [
  dynastyReignMonth("wu", "sun-xiu", "吴景帝", "景皇帝", null, 258, 11, 264, 9, [
    { name: "永安", sy: 258, sm: 11, ey: 264, em: 9 },
  ]),
  dynastyReignMonth("wu", "sun-hao", "吴末帝", "乌程侯", null, 264, 9, 280, 5, [
    { name: "元兴", sy: 264, sm: 9, ey: 265 },
    { name: "甘露", sy: 265, ey: 266 },
    { name: "宝鼎", sy: 266, ey: 269 },
    { name: "建兴", sy: 269, ey: 271 },
    { name: "凤凰", sy: 272, ey: 274 },
    { name: "天册", sy: 275, ey: 275 },
    { name: "天玺", sy: 276, ey: 276 },
    { name: "天纪", sy: 277, ey: 280, em: 5 },
  ]),
];

const reignGroups = [weiReigns, wuReigns];
const reigns = reignGroups.flat();

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
  {
    id: "rel-cao-rui-cao-fang-succession",
    fromRef: "person:cao-rui",
    toRef: "person:cao-fang",
    kind: "succession",
  },
  {
    id: "rel-sun-liang-sun-xiu-succession",
    fromRef: "person:sun-liang",
    toRef: "person:sun-xiu",
    kind: "succession",
  },
);

const manifest = {
  slug: "three-kingdoms-late",
  title: "三国后期：曹魏与孙吴末帝",
  window: { startYear: 239, startMonth: 1, endYear: 280, endMonth: 5 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-13",
  counts: {
    persons: persons.length,
    dynasties: 0,
    reigns: reigns.length,
    events: 0,
    relations: relations.length,
  },
  sources: [
    { label: "曹魏", url: "https://zh.wikipedia.org/wiki/曹魏" },
    { label: "曹魏皇帝列表", url: "https://zh.wikipedia.org/wiki/曹魏皇帝列表" },
    { label: "曹芳", url: "https://zh.wikipedia.org/wiki/曹芳" },
    { label: "曹髦", url: "https://zh.wikipedia.org/wiki/曹髦" },
    { label: "曹奂", url: "https://zh.wikipedia.org/wiki/曹奂" },
    { label: "孙吴", url: "https://zh.wikipedia.org/wiki/孙吴" },
    { label: "孙吴皇帝列表", url: "https://zh.wikipedia.org/wiki/孙吴皇帝列表" },
    { label: "孙休", url: "https://zh.wikipedia.org/wiki/孙休" },
    { label: "孙皓", url: "https://zh.wikipedia.org/wiki/孙皓" },
  ],
  notes: [
    "补录曹魏曹叡之后曹芳、曹髦、曹奂，及孙吴孙亮之后孙休、孙皓。",
    "在位起止据《三国志》及通行年表，precision=month。",
    "曹芳、曹髦谥号非完整皇帝谥，title 取通行称呼。",
    "曹魏、孙吴王朝行已存在于 seed，本包仅补人物与在位。",
  ],
};

writeImportPackage(__dirname, {
  slug: "three-kingdoms-late",
  window: manifest.window,
  persons,
  dynasties: [],
  reignGroups,
  reigns,
  events: [],
  relations,
  manifest,
});
