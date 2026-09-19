#!/usr/bin/env node
/**
 * Cross-dynasty fate relations for timeline dashed lines.
 * Only INSERT/UPSERT relations — persons/reigns/events live in period imports.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { writeImportPackage } from "../lib/sqlHelpers.mjs";
import {
  fateRelation,
  loadEventsFromImports,
  loadReignsFromImports,
  validateEventFateAlignment,
  validateFateCatalog,
} from "../lib/fateRelationHelpers.mjs";
import { buildFateCatalog } from "./catalog.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const importsRoot = path.join(__dirname, "..");
const catalog = buildFateCatalog();
const reigns = loadReignsFromImports(importsRoot);
const events = loadEventsFromImports(importsRoot);
const validationFailures = validateFateCatalog(catalog, reigns);
if (validationFailures.length > 0) {
  console.error("[cross-dynasty-fate] fate catalog validation failed:");
  for (const failure of validationFailures) {
    console.error(`  - ${failure.id} (${failure.fromPersonId}): ${failure.reason}`);
  }
  process.exit(1);
}
const eventAlignmentFailures = validateEventFateAlignment(catalog, events);
if (eventAlignmentFailures.length > 0) {
  console.error("[cross-dynasty-fate] event↔fate alignment failed:");
  for (const failure of eventAlignmentFailures) {
    console.error(`  - ${failure.id} (${failure.eventId}): ${failure.reason}`);
  }
  process.exit(1);
}
const relations = catalog.map((entry) =>
  fateRelation({
    id: entry.id,
    fromPersonId: entry.fromPersonId ?? null,
    fromReignId: entry.fromReignId ?? null,
    toPersonId: entry.toPersonId,
    kind: entry.kind,
    at: entry.resolveAt(),
    eventId: entry.eventId,
    precision: entry.precision,
  }),
);

writeImportPackage(__dirname, {
  slug: "cross-dynasty-fate",
  window: { startYear: -2100, startMonth: 1, endYear: 1900, endMonth: 12 },
  persons: [],
  dynasties: [],
  reigns: [],
  events: [],
  relations,
  // One-time cleanup: old catalog wrongly linked 慕容永 to 苻坚 (died 385).
  preSql: [
    "DELETE FROM relations WHERE id = 'rel-murong-yong-fu-jian-ming-killed';",
    "DELETE FROM relations WHERE id = 'rel-yang-nandang-fu-jian-ming-surrender';",
    "DELETE FROM relations WHERE id IN (",
    "  'rel-zhou-guo-gen-qin-r29-killed',",
    "  'rel-xue-r4-qi-r35-captured',",
    "  'rel-teng-r6-yue-r8-captured',",
    "  'rel-teng-r6-song-r32-captured',",
    "  'rel-missing-teng-chunqiu-yue-r8-captured',",
    "  'rel-ju-r7-chu-r30-captured',",
    "  'rel-qi-state-r6-qi-r31-captured',",
    "  'rel-zhongshan-r6-zhao-r5-captured',",
    "  'rel-yelang-xin-liu-che-killed',",
    "  'rel-li-shi-huan-wen-surrender',",
    "  'rel-murong-chao-liu-yu-jin-captured',",
    "  'rel-tufa-rutan-liu-yu-jin-surrender',",
    "  'rel-yao-hong-liu-yu-jin-killed',",
    "  'rel-qifu-gan-yao-xing-killed',",
    "  'rel-yuan-shan-jian-yuwen-jue-abdication',",
    "  'rel-gao-jichong-zhao-kuangyi-surrender',",
    "  'rel-meng-chang-zhao-kuangyi-surrender',",
    "  'rel-liu-chang-zhao-kuangyi-surrender',",
    "  'rel-li-yu-nantang-zhao-kuangyi-captured',",
    "  'rel-duan-xingzhi-hu-bilie-surrender',",
    "  'rel-hong-tianguifu-zeng-guofan-captured',",
    "  'rel-sima-ye-liu-yao-jin-surrender',",
    "  'rel-shi-hu-ran-min-killed'",
    ");",
  ].join("\n"),
  manifest: {
    slug: "cross-dynasty-fate",
    title: "跨朝代帝王命运线",
    window: { startYear: -2100, startMonth: 1, endYear: 1900, endMonth: 12 },
    scope: "cn",
    depth: "standard",
    generatedAt: "2026-09-18",
    counts: {
      persons: 0,
      dynasties: 0,
      reigns: 0,
      events: 0,
      relations: relations.length,
    },
    sources: [
      {
        label: "各时期 import 包 events 与 documentedReignDates",
        url: "https://zh.wikipedia.org/wiki/中国朝代",
      },
      { label: "楚怀王", url: "https://zh.wikipedia.org/wiki/楚怀王" },
      { label: "韩原之战", url: "https://zh.wikipedia.org/wiki/韩原之战" },
      { label: "淖齿", url: "https://zh.wikipedia.org/wiki/淖齿" },
      { label: "晋怀帝", url: "https://zh.wikipedia.org/wiki/晋怀帝" },
      { label: "晋愍帝", url: "https://zh.wikipedia.org/wiki/晋愍帝" },
      { label: "梁元帝", url: "https://zh.wikipedia.org/wiki/梁元帝" },
      { label: "陈友谅", url: "https://zh.wikipedia.org/wiki/陈友谅" },
      { label: "靖康之变 / 金太宗", url: "https://zh.wikipedia.org/wiki/金太宗" },
      { label: "洪天贵福", url: "https://zh.wikipedia.org/wiki/洪天贵福" },
      { label: "慕容暐", url: "https://zh.wikipedia.org/wiki/慕容暐" },
      { label: "金哀宗", url: "https://zh.wikipedia.org/wiki/金哀宗" },
      { label: "刘盆子", url: "https://zh.wikipedia.org/wiki/刘盆子" },
      { label: "段兴智", url: "https://zh.wikipedia.org/wiki/段兴智" },
    ],
    notes: [
      "仅 person→person，kind∈killed|surrender|abdication|captured。",
      "at_abs 优先取受害方 documented / 已入库月日迄；年精度事件取 event 年 12 月。有月/日史料的事件须同步升 precision，与命运线 at_abs 一致。",
      "同朝 succession 不写入；B 方无 reign 卡者改挂当时在位君主（成汉/南燕/后秦→晋帝，太平天国→同治）。",
      "秦灭六国等边自 chunqiu-zhanguo 迁入本包，避免重复维护。",
      "吐蕃、回鹘、南诏末代无时间轴上的灭国接收方（僧人刺杀 / 黠戛斯 / 大长和未收录），不硬画。",
      "非末代被他朝杀/俘：楚怀王（秦昭襄王扣武关）、晋惠公（韩原为秦穆公所俘后释归）、齐湣王（楚将淖齿杀）、晋怀帝（刘聪鸩杀，愍帝继立）、梁元帝（西魏杀于江陵，敬帝继立）、陈友谅（鄱阳湖阵亡，陈理继立）；宋徽宗、南越赵兴原目录已有。",
      "愍帝 316 年出降时刘曜尚未称帝，改挂汉赵当时在位的刘聪，不把虚线拖到 318。",
      "明英宗土木堡被瓦剌也先所俘，时间轴无瓦剌君主卡，不硬画。唐昭宗为朱温所弑时后梁尚未建（907，距 904 逾 24 个月），不硬画。",
      "孟昶降宋取 documented 在位迄日（乾德三年正月辛卯，965-02），不用卒年六月或年精度 12 月占位。",
      "秦之后虚线：在位行已有月/日则改挂 documented 迄；靖康之变取 1127-03-20 废二帝，不用徽宗禅位日；幼天王被俘单独事件 hong-tianguifu-captured（1864-10-25），与天京陷落分列。",
      "刘盆子降光武取维基公历 27-03-15；段兴智被俘取在位迄年 1254（城破 1253 次年昆泽），仍年精度。",
      "先降/俘后被杀：怀愍二帝、冉闵、慕容超、秃发傉檀、王衍、李煜等同时保留 capture/surrender 与 killed；前端优先显示 killed。",
      "十六国等农历月用寿星历 sxtwl 换公历：有日（李势三月十七、牧犍九月丙戌、石虎四月廿三）升日；仅月者取望日所在公历月。宝藏王九月＝668-10，耶律淳六月＝1122-07。",
      "石虎349年病死，旧目录误作冉闵所杀已删；改挂石鉴→冉闵（永和六年闰二月）。",
    ],
  },
});

console.log(`[cross-dynasty-fate] ${relations.length} fate relations`);
