#!/usr/bin/env node
/**
 * Supplement Wei (曹魏) and Wu (孙吴) emperors after Cao Rui / Sun Quan.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import {
  person,
  reign,
  eras,
  eventPoint,
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
) {
  const reignId = `reign-${personId}`;
  return reign({
    id: reignId,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    start: ym(startYear, startMonth),
    end: ym(endYear, endMonth),
    eraNames: eraList.length ? eras(reignId, eraList) : [],
    precision: "month",
  });
}

const persons = [
  person("sima-yi", "司马懿", ["政治家", "军事家"], "曹魏权臣，正始十年发动高平陵之变，控制曹魏朝政。", "司马懿", ym(179), ym(251, 9)),
  person("cao-fang", "曹芳", ["皇帝"], "曹魏第三位皇帝，魏明帝养子，后被司马师废为齐王；晋封邵陵县公，谥厉。", "曹芳", ym(231), ym(274)),
  person("cao-mao", "曹髦", ["皇帝"], "曹魏第四位皇帝，文帝孙，甘露五年被司马昭部卒所害。史称高贵乡公；无谥号、无庙号。", "曹髦", ym(241), ym(260, 5)),
  person("cao-huan", "曹奂", ["皇帝"], "曹魏末代皇帝，咸熙二年禅位于司马炎，曹魏终结。", "曹奂", ym(246), ym(302)),
  person("sun-liang", "孙亮", ["皇帝"], "孙吴第二位皇帝，被废为会稽王，后又贬侯官侯。史称会稽王；无谥号、无庙号。", "孙亮", ym(244), ym(260, 6)),
  person("sun-xiu", "孙休", ["皇帝"], "孙吴第三位皇帝，孙权第六子，在位期间整顿吏治。", "孙休", ym(235), ym(264, 9)),
  person("sun-hao", "孙皓", ["皇帝"], "孙吴末代皇帝，天纪四年降于晋，孙吴亡；无谥号、无庙号。", "孙皓", ym(242), ym(284)),
];

const weiReigns = [
  dynastyReignMonth("wei", "cao-fang", "齐王", "邵陵厉公", null, 239, 1, 254, 10, [
    { name: "正始", sy: 239, sm: 1, ey: 249 },
    { name: "嘉平", sy: 249, ey: 254, em: 10 },
  ]),
  dynastyReignMonth(
    "wei",
    "cao-mao",
    "高贵乡公",
    null,
    null,
    254,
    10,
    260,
    5,
    [
      { name: "正元", sy: 254, sm: 10, ey: 256 },
      { name: "甘露", sy: 257, ey: 260, em: 5 },
    ],
    { kind: "regnal", name: "高贵乡公" },
  ),
  dynastyReignMonth("wei", "cao-huan", "魏元帝", "元皇帝", null, 260, 6, 266, 2, [
    { name: "景元", sy: 260, sm: 6, ey: 263 },
    { name: "咸熙", sy: 264, ey: 266, em: 2 },
  ]),
];

const wuReigns = [
  dynastyReignMonth(
    "wu",
    "sun-liang",
    "会稽王",
    null,
    null,
    252,
    5,
    258,
    11,
    [
      { name: "建兴", sy: 252, sm: 5, ey: 253 },
      { name: "五凤", sy: 254, ey: 256, em: 10 },
      { name: "太平", sy: 256, sm: 10, ey: 258, em: 11 },
    ],
    { kind: "regnal", name: "会稽王" },
  ),
  dynastyReignMonth("wu", "sun-xiu", "吴景帝", "景皇帝", null, 258, 11, 264, 9, [
    { name: "永安", sy: 258, sm: 11, ey: 264, em: 9 },
  ]),
  dynastyReignMonth("wu", "sun-hao", "吴末帝", null, null, 264, 9, 280, 5, [
    { name: "元兴", sy: 264, sm: 9, ey: 265 },
    { name: "甘露", sy: 265, ey: 266 },
    { name: "宝鼎", sy: 266, ey: 269 },
    { name: "建衡", sy: 269, ey: 271 },
    { name: "凤凰", sy: 272, ey: 274 },
    { name: "天册", sy: 275, ey: 275 },
    { name: "天玺", sy: 276, ey: 276 },
    { name: "天纪", sy: 277, ey: 280, em: 5 },
  ]),
];

const reignGroups = [weiReigns, wuReigns];
const reigns = applyDocumentedDatesToReigns(reignGroups.flat());

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
    id: "rel-sun-quan-sun-liang-succession",
    fromRef: "person:sun-quan",
    toRef: "person:sun-liang",
    kind: "succession",
  },
);

const events = [
  eventPoint({
    id: "gaoping-tombs-incident",
    name: "高平陵之变",
    kind: "politics",
    precision: "year",
    dateNote: "魏正始十年（249）；《三国志·魏书·齐王纪》系于正月甲午，未据可靠历算资料换算公历月日。",
    at: ym(249),
    locationId: "loc-gaoping-tombs-incident",
    dynastyIds: ["wei"],
    participantIds: ["sima-yi", "cao-fang"],
    summary: "曹芳赴高平陵谒陵时，司马懿控制洛阳及洛水浮桥，迫使曹爽交出兵权并夷其三族，曹魏政局转由司马氏掌握。",
  }),
];

const manifest = {
  slug: "three-kingdoms-late",
  title: "三国后期：曹魏与孙吴末帝",
  window: { startYear: 239, startMonth: 1, endYear: 280, endMonth: 5 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-18",
  counts: {
    persons: persons.length,
    dynasties: 0,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "曹魏", url: "https://zh.wikipedia.org/wiki/曹魏" },
    { label: "曹魏皇帝列表", url: "https://zh.wikipedia.org/wiki/曹魏皇帝列表" },
    { label: "曹芳", url: "https://zh.wikipedia.org/wiki/曹芳" },
    { label: "《三国志·魏书·齐王纪》", url: "https://zh.wikisource.org/zh-hans/三國志/卷04" },
    { label: "高平陵", url: "https://zh.wikipedia.org/wiki/高平陵" },
    { label: "河南省文物局：第七批全国重点文物保护单位保护范围和建设控制地带", url: "https://wgl.kaifeng.gov.cn/kfswhgdhlyj/swgljwbdw/1805436537969889280/M71CbQHO.pdf" },
    { label: "曹髦", url: "https://zh.wikipedia.org/wiki/曹髦" },
    { label: "曹奂", url: "https://zh.wikipedia.org/wiki/曹奂" },
    { label: "孙吴", url: "https://zh.wikipedia.org/wiki/孙吴" },
    { label: "孙吴皇帝列表", url: "https://zh.wikipedia.org/wiki/孙吴皇帝列表" },
    { label: "孙亮", url: "https://zh.wikipedia.org/wiki/孙亮" },
    { label: "孙休", url: "https://zh.wikipedia.org/wiki/孙休" },
    { label: "孙皓", url: "https://zh.wikipedia.org/wiki/孙皓" },
  ],
  notes: [
    "补录曹魏曹叡之后曹芳、曹髦、曹奂，及孙吴孙亮、孙休、孙皓。",
    "在位起止据《三国志》及维基百科通行公历换算，经 documentedReignDates 提升至 day。",
    "曹芳晋谥厉，作邵陵厉公；title 用《三国志》齐王。曹髦、孙亮无谥号，title 用高贵乡公、会稽王。孙皓无谥号，title 用吴末帝。封号不写入 posthumous_name。",
    "孙皓第四个年号为建衡，旧误作建兴（孙亮年号）。",
    "曹魏、孙吴王朝行与曹丕、曹叡、孙权在位由 three-kingdoms-warlord 写入，本包仅补其后人物与在位。",
    "增补高平陵之变：依据《三国志·魏书·齐王纪》记正始十年正月甲午曹芳谒高平陵、司马懿据洛水浮桥控制洛阳；年精度录入，不将农历日期换算成公历日。地点标记洛阳政变中心；高平陵遗址位于今河南省洛阳市汝阳县茹店村一带。",
  ],
};

writeImportPackage(__dirname, {
  slug: "three-kingdoms-late",
  window: manifest.window,
  persons,
  dynasties: [],
  reignGroups,
  reigns,
  events,
  relations,
  manifest,
});
