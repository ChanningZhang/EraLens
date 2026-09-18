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
  loadReignsFromImports,
  validateFateCatalog,
} from "../lib/fateRelationHelpers.mjs";
import { buildFateCatalog } from "./catalog.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const catalog = buildFateCatalog();
const reigns = loadReignsFromImports(path.join(__dirname, ".."));
const validationFailures = validateFateCatalog(catalog, reigns);
if (validationFailures.length > 0) {
  console.error("[cross-dynasty-fate] fate catalog validation failed:");
  for (const failure of validationFailures) {
    console.error(`  - ${failure.id} (${failure.fromPersonId}): ${failure.reason}`);
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
    "  'rel-hong-tianguifu-zeng-guofan-captured'",
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
      { label: "梁元帝", url: "https://zh.wikipedia.org/wiki/梁元帝" },
      { label: "陈友谅", url: "https://zh.wikipedia.org/wiki/陈友谅" },
    ],
    notes: [
      "仅 person→person，kind∈killed|surrender|abdication|captured。",
      "at_abs 优先取受害方 documented end；年精度事件取 event 年 12 月。",
      "同朝 succession 不写入；B 方无 reign 卡者改挂当时在位君主（成汉/南燕/后秦→晋帝，太平天国→同治）。",
      "秦灭六国等边自 chunqiu-zhanguo 迁入本包，避免重复维护。",
      "吐蕃、回鹘、南诏末代无时间轴上的灭国接收方（僧人刺杀 / 黠戛斯 / 大长和未收录），不硬画。",
      "非末代被他朝杀/俘：楚怀王（秦昭襄王扣武关）、晋惠公（韩原为秦穆公所俘后释归）、齐湣王（楚将淖齿杀）、晋怀帝（刘聪鸩杀，愍帝继立）、梁元帝（西魏杀于江陵，敬帝继立）、陈友谅（鄱阳湖阵亡，陈理继立）；宋徽宗、南越赵兴原目录已有。",
      "明英宗土木堡被瓦剌也先所俘，时间轴无瓦剌君主卡，不硬画。唐昭宗为朱温所弑时后梁尚未建（907，距 904 逾 24 个月），不硬画。",
    ],
  },
});

console.log(`[cross-dynasty-fate] ${relations.length} fate relations`);
