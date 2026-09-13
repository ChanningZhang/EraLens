#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Nanzhao (南诏) and Dali (大理).
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  person,
  dr,
  eventPoint,
  writeImportPackage,
  nextColor,
  successionPairs,
  ym,
} from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// ── persons ────────────────────────────────────────────────────────────────

const persons = [
  // 南诏十三世
  person("xi-nuoluo", "细奴逻", ["君主"], "南诏始祖，蒙舍诏首领，649年即位。", "细奴逻"),
  person("luo-sheng", "逻盛", ["君主"], "南诏第二任君主，细奴逻之子。", "逻盛"),
  person("sheng-luopi", "盛逻皮", ["君主"], "南诏第三任君主，逻盛之子。", "盛逻皮"),
  person("pi-luoge", "皮逻阁", ["君主"], "南诏第四任君主，738年统一六诏，南诏国号始显。", "皮逻阁"),
  person("ge-luofeng", "阁罗凤", ["皇帝"], "南诏第五任君主，在位期间与唐多次交战，国势强盛。", "阁罗凤"),
  person("yi-mouxun", "异牟寻", ["皇帝"], "南诏第六任君主，与吐蕃结盟后复与唐修好。", "异牟寻"),
  person("xun-gequan", "寻阁劝", ["皇帝"], "南诏第七任君主，在位仅一年。", "寻阁劝"),
  person("quan-longsheng", "劝龙晟", ["皇帝"], "南诏第八任君主。", "劝龙晟"),
  person("quan-lisheng", "劝利晟", ["皇帝"], "南诏第九任君主。", "劝利晟"),
  person("quan-fengyou", "劝丰祐", ["皇帝"], "南诏第十任君主，在位三十余年。", "劝丰祐"),
  person("shi-long", "世隆", ["皇帝"], "南诏第十一任君主，改国号大礼，与唐战争频繁。", "世隆"),
  person("long-shun", "隆舜", ["皇帝"], "南诏第十二任君主，改国号大封民。", "隆舜"),
  person("shun-huazhen", "舜化贞", ["皇帝"], "南诏末代君主，902年亡于郑买嗣。", "舜化贞"),
  // 大理
  person("duan-siping", "段思平", ["皇帝"], "大理太祖，937年灭大义宁建国，国号大理。", "段思平"),
  person("duan-siying", "段思英", ["皇帝"], "大理第二任皇帝，段思平之子，在位一年。", "段思英"),
  person("duan-siliang", "段思良", ["皇帝"], "大理第三任皇帝，段思平之弟。", "段思良"),
  person("duan-sicong", "段思聪", ["皇帝"], "大理第四任皇帝。", "段思聪"),
  person("duan-sushun", "段素顺", ["皇帝"], "大理第五任皇帝。", "段素顺"),
  person("duan-suying", "段素英", ["皇帝"], "大理第六任皇帝，在位二十四年。", "段素英"),
  person("duan-sulian", "段素廉", ["皇帝"], "大理第七任皇帝。", "段素廉"),
  person("duan-sulong", "段素隆", ["皇帝"], "大理第八任皇帝。", "段素隆"),
  person("duan-suzhen", "段素真", ["皇帝"], "大理第九任皇帝。", "段素真"),
  person("duan-suxing", "段素兴", ["皇帝"], "大理第十任皇帝，荒淫失政被废。", "段素兴"),
  person("duan-silian", "段思廉", ["皇帝"], "大理世宗，在位三十一年，大理中期重要君主。", "段思廉"),
  person("duan-lianyi", "段廉义", ["皇帝"], "大理第十二任皇帝。", "段廉义"),
  person("yang-yizhen", "杨义贞", ["皇帝"], "1080年篡位，杀段廉义，不被广泛承认为正统君主。", "杨义贞"),
  person("duan-shouhui", "段寿辉", ["皇帝"], "大理第十四任皇帝，杨义贞之后即位。", "段寿辉"),
  person("duan-zhengming", "段正明", ["皇帝"], "大理第十五任皇帝，后让位于高升泰。", "段正明"),
  person("gao-shengtai", "高升泰", ["皇帝"], "1094–1096年称帝，国号大中国，后还政段氏。", "高升泰"),
  person("duan-zhengchun", "段正淳", ["皇帝"], "大理中宗，金庸《天龙八部》段誉原型，在位十二年。", "段正淳"),
  person("duan-zhengyan", "段正严", ["皇帝"], "大理宪宗，本名段和誉，与宋修好，国势安定。", "段和誉"),
  person("duan-zhengxing", "段正兴", ["皇帝"], "大理景宗，在位二十四年。", "段正兴"),
  person("duan-zhixing", "段智兴", ["皇帝"], "大理宣宗，崇佛兴盛，在位近三十年。", "段智兴"),
  person("duan-zhilian", "段智廉", ["皇帝"], "大理第十九任皇帝。", "段智廉"),
  person("duan-zhixiang", "段智祥", ["皇帝"], "大理神宗，在位三十四年。", "段智祥"),
  person("duan-xiangxing", "段祥兴", ["皇帝"], "大理第二十任皇帝，蒙古南侵之际在位。", "段祥兴"),
  person("duan-xingzhi", "段兴智", ["皇帝"], "大理末代皇帝，1253年蒙古灭大理，后任云南总管。", "段兴智"),
];

// ── dynasties ──────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "nanzhao",
    name: "南诏",
    altNames: ["蒙舍诏", "大礼", "大封民"],
    scope: "cn",
    region: "east_asia",
    start: ym(649),
    end: ym(902, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "蒙舍诏细奴逻起于649年；738年皮逻阁统一六诏后南诏国号始显；902年亡于郑买嗣。",
  },
  {
    id: "dali",
    name: "大理",
    altNames: ["大理国", "后大理"],
    scope: "cn",
    region: "east_asia",
    start: ym(937),
    end: ym(1253, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "937年段思平建国；1094–1096年高升泰短暂称帝（大中国）；1253年蒙古灭大理。",
  },
];

// ── reigns ───────────────────────────────────────────────────────────────────

const nanzhaoReigns = [
  dr("nanzhao", "xi-nuoluo", "奇嘉王", null, "高祖", 649, 674),
  dr("nanzhao", "luo-sheng", "兴宗王", null, "世宗", 674, 712),
  dr("nanzhao", "sheng-luopi", "威成王", null, "太宗", 712, 728),
  dr("nanzhao", "pi-luoge", "归义王", null, null, 728, 748),
  dr("nanzhao", "ge-luofeng", "南诏王", "神武王", null, 748, 779),
  dr("nanzhao", "yi-mouxun", "南诏王", "孝桓王", null, 779, 808),
  dr("nanzhao", "xun-gequan", "南诏王", "孝惠王", null, 808, 809),
  dr("nanzhao", "quan-longsheng", "南诏王", "幽王", null, 809, 816),
  dr("nanzhao", "quan-lisheng", "南诏王", "靖王", null, 816, 823),
  dr("nanzhao", "quan-fengyou", "南诏王", "昭成王", null, 823, 859),
  dr("nanzhao", "shi-long", "景庄帝", null, null, 859, 877),
  dr("nanzhao", "long-shun", "武宣帝", null, null, 877, 897),
  dr("nanzhao", "shun-huazhen", "孝哀帝", null, null, 897, 902),
];

const daliReigns = [
  dr("dali", "duan-siping", "大理太祖", "圣神文武皇帝", "太祖", 937, 944, [
    { name: "文德", sy: 937, ey: 944 },
  ]),
  dr("dali", "duan-siying", "大理皇帝", null, null, 944, 945),
  dr("dali", "duan-siliang", "大理皇帝", "圣慈文武皇帝", null, 945, 952),
  dr("dali", "duan-sicong", "大理皇帝", "至道广慈皇帝", null, 952, 968),
  dr("dali", "duan-sushun", "大理皇帝", "应道皇帝", null, 968, 985),
  dr("dali", "duan-suying", "大理皇帝", "昭明皇帝", null, 985, 1009),
  dr("dali", "duan-sulian", "大理皇帝", "宣肃皇帝", null, 1009, 1022),
  dr("dali", "duan-sulong", "大理皇帝", "秉义皇帝", null, 1022, 1026),
  dr("dali", "duan-suzhen", "大理皇帝", "圣德皇帝", null, 1026, 1041),
  dr("dali", "duan-suxing", "大理皇帝", "天明皇帝", null, 1041, 1044),
  dr("dali", "duan-silian", "大理世宗", "孝德皇帝", "世宗", 1044, 1075),
  dr("dali", "duan-lianyi", "大理皇帝", "上德皇帝", null, 1075, 1080),
  dr("dali", "yang-yizhen", "大理皇帝", "上明皇帝", null, 1080, 1080),
  dr("dali", "duan-shouhui", "大理皇帝", "上明皇帝", null, 1080, 1081),
  dr("dali", "duan-zhengming", "大理皇帝", "保定皇帝", null, 1081, 1094),
  dr("dali", "gao-shengtai", "大中国皇帝", "富有圣德表正皇帝", null, 1094, 1096, [
    { name: "上治", sy: 1094, ey: 1096 },
  ]),
  dr("dali", "duan-zhengchun", "大理中宗", "文安皇帝", "中宗", 1096, 1108),
  dr("dali", "duan-zhengyan", "大理宪宗", "宣仁皇帝", "宪宗", 1108, 1147),
  dr("dali", "duan-zhengxing", "大理景宗", "正康皇帝", "景宗", 1147, 1171),
  dr("dali", "duan-zhixing", "大理宣宗", "功极皇帝", "宣宗", 1171, 1200),
  dr("dali", "duan-zhilian", "大理皇帝", "亨天皇帝", null, 1200, 1204),
  dr("dali", "duan-zhixiang", "大理神宗", null, "神宗", 1204, 1238),
  dr("dali", "duan-xiangxing", "大理皇帝", "孝义皇帝", null, 1238, 1251),
  dr("dali", "duan-xingzhi", "大理皇帝", null, null, 1251, 1254),
];

const reignGroups = [nanzhaoReigns, daliReigns];
const reigns = reignGroups.flat();

// ── events ───────────────────────────────────────────────────────────────────

const events = [
  eventPoint({
    id: "nanzhao-founded",
    name: "南诏立国",
    kind: "politics",
    dateNote: "649年细奴逻即位；738年皮逻阁统一六诏为南诏全盛起点",
    at: ym(738),
    dynastyIds: ["nanzhao"],
    participantIds: ["pi-luoge"],
    summary: "皮逻阁受唐册封为云南王，统一六诏，南诏正式成为西南强国。",
  }),
  eventPoint({
    id: "dali-founded",
    name: "大理建国",
    kind: "politics",
    at: ym(937),
    dynastyIds: ["dali"],
    participantIds: ["duan-siping"],
    summary: "段思平灭大义宁，建国号大理，定都羊苴咩城（今大理）。",
  }),
  eventPoint({
    id: "mongol-conquer-dali",
    name: "蒙古灭大理",
    kind: "battle",
    dateNote: "1253年忽必烈攻大理，1254年段兴智降",
    at: ym(1253),
    dynastyIds: ["dali", "mongol-empire"],
    participantIds: ["duan-xingzhi"],
    summary: "蒙哥汗命忽必烈南征，1253年攻破大理，段兴智出降，大理国亡。",
  }),
];

const supplementalEventDynasties = [];
const supplementalEventParticipants = [
  { eventId: "mongol-conquer-dali", personId: "hu-bilie" },
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
  { id: "rel-nanzhao-founded", fromRef: "event:nanzhao-founded", toRef: "dynasty:nanzhao", kind: "other" },
  { id: "rel-dali-founded", fromRef: "event:dali-founded", toRef: "dynasty:dali", kind: "other" },
  { id: "rel-mongol-conquer-dali", fromRef: "event:mongol-conquer-dali", toRef: "dynasty:dali", kind: "battle" },
);

// ── output ───────────────────────────────────────────────────────────────────

writeImportPackage(__dirname, {
  slug: "nanzhao-dali",
  window: { startYear: 649, startMonth: 1, endYear: 1254, endMonth: 12 },
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  supplementalEventDynasties,
  supplementalEventParticipants,
  manifest: {
    slug: "nanzhao-dali",
    title: "南诏与大理",
    window: { startYear: 649, startMonth: 1, endYear: 1254, endMonth: 12 },
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
      { label: "六诏君主列表", url: "https://zh.wikipedia.org/wiki/六诏君主列表" },
      { label: "南诏", url: "https://zh.wikipedia.org/wiki/南诏" },
      { label: "大理君主列表", url: "https://zh.wikipedia.org/wiki/大理君主列表" },
      { label: "大理国", url: "https://zh.wikipedia.org/wiki/大理国" },
      { label: "段思平", url: "https://zh.wikipedia.org/wiki/段思平" },
      { label: "蒙古攻灭大理", url: "https://zh.wikipedia.org/wiki/蒙古攻灭大理" },
    ],
    notes: [
      "覆盖南诏十三世君主（649–902）与大理国皇帝（937–1253）。",
      "南诏王朝始年取细奴逻即位（649），立国事件取738年皮逻阁统一六诏。",
      "杨义贞（1080）与高升泰（1094–1096）按维基君主列表收录。",
      "蒙古灭大理事件补充关联 mongol-empire 王朝与 hu-bilie（忽必烈，见 mongol-pre-yuan）。",
      "在位年取维基百科君主列表常见年表，precision=year。",
    ],
  },
});
