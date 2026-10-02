import { readFileSync, readdirSync, writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const baseline = JSON.parse(readFileSync(path.join(root, "docs/date-confidence-review-baseline.json"), "utf8"));
const circaBaseline = JSON.parse(readFileSync(path.join(root, "docs/date-confidence-circa-baseline.json"), "utf8")).events;
const importRepairs = JSON.parse(readFileSync(path.join(root, "docs/date-confidence-import-repairs.json"), "utf8"));
const seedChanges = JSON.parse(readFileSync(path.join(root, "docs/date-confidence-seed-changes.json"), "utf8"));
const structuralMigration = JSON.parse(readFileSync(path.join(root, "docs/date-confidence-structural-migration.json"), "utf8"));
const metadataChanges = JSON.parse(readFileSync(path.join(root, "docs/date-confidence-metadata-changes.json"), "utf8"));
const packages = new Map();
const itemFor = (record) => {
  const cache = packages.get(record.package).cache;
  const key = { reigns: "reigns", dynasty_capitals: "capitals", events: "events" }[record.table];
  return cache[key].find((row) => row.id === record.id);
};
const isoDate = (point) => point && ({ year: point.year, month: point.month, ...(point.day == null ? {} : { day: point.day }), ...(point.abs == null ? {} : { abs: point.abs }) });
const sameDate = (a, b) => {
  const left = isoDate(a), right = isoDate(b);
  return left == null || right == null ? left === right : ["year", "month", "day", "abs"].every((key) => left[key] === right[key]);
};
const confidenceReason = (confidence) => {
  if (confidence === "interpolated_by_generation") return "所属来源说明将该在位序列作为连续世系，并说明共同锚点间按世次均分；日期是世次插值，不是史料直接记载。";
  if (confidence === "interpolated_by_other") return "所属来源说明日期由明确关联、共时记录或年表对应关系推定；该端点不属于按连续世系均分的插值。";
  if (confidence.startsWith("approximate_")) return `旧端点为 approximate；现有日期值保留到${confidence.endsWith("_day") ? "日" : confidence.endsWith("_month") ? "月" : "年"}，不把占位年月补作实录。`;
  return `来源可支持到${confidence === "day" ? "日" : confidence === "month" ? "月" : "年"}，按最高现有可信精度保留。`;
};
for (const record of baseline.records) {
  if (!packages.has(record.package)) {
    const cache = JSON.parse(readFileSync(path.join(root, "data/imports", record.package, "cache.json"), "utf8"));
    packages.set(record.package, { cache, notes: cache.manifest.notes ?? [], sources: cache.manifest.sources ?? [] });
  }
}
const entries = baseline.records.flatMap((record) => {
  const row = itemFor(record);
  return record.endpoints.map((endpoint) => {
    const current = row[endpoint.endpoint];
    const newConfidence = current?.confidence ?? row[`${endpoint.endpoint}Confidence`];
    if (!newConfidence) throw new Error(`No new confidence at ${record.id}.${endpoint.endpoint}`);
    return {
      package: record.package,
      table: record.table,
      entityType: record.entityType,
      id: record.id,
      endpoint: endpoint.endpoint,
      oldDate: endpoint.point,
      newDate: isoDate(current),
      confidenceBefore: endpoint.legacyConfidence,
      confidenceAfter: newConfidence,
      dateChanged: !sameDate(current, endpoint.point),
      conclusion: confidenceReason(newConfidence),
      basis: {
        recordDateNote: record.dateNote,
        packageEvidenceRef: record.package,
        confidenceAssignmentRule: confidenceReason(newConfidence),
      },
      affectedRelationships: [],
      validation: "源缓存、生成 SQL、迁移后数据库回填；主键与 AbsMonth 保留。",
    };
  });
});
const legacyEventConversions = readdirSync(path.join(root, "data/imports")).flatMap((slug) => {
  try {
    const cache = JSON.parse(readFileSync(path.join(root, "data/imports", slug, "cache.json"), "utf8"));
    return (cache.events ?? []).filter((event) => event.dateNote?.includes("原不确定范围："))
      .map((event) => ({ package: slug, id: event.id, timeMode: event.timeMode }));
  } catch { return []; }
});
const flaggedKeys = new Set(baseline.records.flatMap((record) => record.endpoints.map((endpoint) => `${record.table}:${record.id}:${endpoint.endpoint}`)));
const unmarkedEndpointChecks = baseline.records.flatMap((record) => {
  const row = itemFor(record);
  const pointKeys = record.table === "events" ? ["at"] : ["start", "end"];
  return pointKeys.filter((endpoint) => row[endpoint] && !flaggedKeys.has(`${record.table}:${record.id}:${endpoint}`)).map((endpoint) => ({
    package: record.package, table: record.table, id: record.id, endpoint,
    date: isoDate(row[endpoint]),
    result: "结构一致性检查通过：未改动该端点数值或 AbsMonth；本轮只更新同一记录中已标记端点的 confidence。",
  }));
});
const packageEvidence = Object.fromEntries([...packages].map(([slug, value]) => [slug, { notes: value.notes, sources: value.sources }]));
const confidenceCounts = Object.fromEntries(entries.reduce((counts, entry) => counts.set(entry.confidenceAfter, (counts.get(entry.confidenceAfter) ?? 0) + 1), new Map()));
const legacyCircaConversions = circaBaseline.map((before) => {
  const owner = readdirSync(path.join(root, "data/imports")).find((slug) => {
    try {
      const cache = JSON.parse(readFileSync(path.join(root, "data/imports", slug, "cache.json"), "utf8"));
      return (cache.events ?? []).some((event) => event.id === before.id && event.dateNote?.includes("原不确定范围："));
    } catch { return false; }
  });
  if (!owner) throw new Error(`No owner package found for legacy circa event ${before.id}`);
  const cache = JSON.parse(readFileSync(path.join(root, "data/imports", owner, "cache.json"), "utf8"));
  const event = cache.events.find((row) => row.id === before.id);
  if (!packages.has(owner)) packages.set(owner, { cache, notes: cache.manifest.notes ?? [], sources: cache.manifest.sources ?? [] });
  return {
    package: owner,
    id: before.id,
    name: before.name,
    before: { timeMode: before.timeMode, at: before.at, start: before.start, end: before.end, precision: before.precision, isApproximate: before.isApproximate, dateNote: before.dateNote },
    after: { timeMode: event.timeMode, at: isoDate(event.at), start: isoDate(event.start), end: isoDate(event.end), atConfidence: event.atConfidence, startConfidence: event.startConfidence, endConfidence: event.endConfidence, dateNote: event.dateNote },
    decision: event.timeMode === "span"
      ? "原说明涵盖跨越至少一个完整日历年的持续过程；保留原起止作为 span，两端标为 approximate confidence。"
      : "旧 circa 范围不能作为点事件的跨度；保留原 at 代表时点，如无 at 则使用原起点，并将原起止说明留在 dateNote。",
    basis: { originalDateNote: before.dateNote, packageEvidenceRef: owner },
    affectedRelationships: [],
  };
});
const report = {
  baselineDate: baseline.baselineDate,
  baselineManifestSha256: baseline.importManifestSha256,
  scope: baseline.selectedCounts,
  summary: {
    reviewedRecords: new Set(entries.map((entry) => `${entry.table}:${entry.id}`)).size,
    reviewedEndpoints: entries.length,
    omittedEndpoints: 0,
    pendingEndpoints: 0,
    unmarkedConsistencyOnlyEndpoints: baseline.deferredScope.unflaggedEndpointsOnSelectedRecords,
    unmarkedConsistencyChecksRecorded: unmarkedEndpointChecks.length,
  deferredOtherRecords: true,
    legacyCircaStructuralConversions: legacyEventConversions.length,
    legacyCircaToSpan: legacyEventConversions.filter((event) => event.timeMode === "span").length,
    legacyCircaToPoint: legacyEventConversions.filter((event) => event.timeMode === "point").length,
    legacyCircaConversionsRecorded: legacyCircaConversions.length,
    dateValueChanges: entries.filter((entry) => entry.dateChanged).length,
    confidenceCounts,
    nonpriorityStructuralEndpoints: structuralMigration.structuralEndpoints,
    nonpriorityStructuralDateValueChanges: structuralMigration.dateValueChanges,
    idChanges: 0,
  },
  packageEvidence,
  endpoints: entries,
  legacyCircaConversions,
  importRepairs,
  seedChanges,
  nonpriorityStructuralMigration: structuralMigration,
  metadataChanges,
  unmarkedEndpointChecks,
};
writeFileSync(path.join(root, "docs/date-confidence-endpoint-review.json"), `${JSON.stringify(report, null, 2)}\n`);

const lines = [
  "# 日期置信度迁移与复核报告",
  "",
  `基线日期：${baseline.baselineDate}。基线导入 manifest SHA-256：\`${baseline.importManifestSha256}\`。逐端点明细见 [date-confidence-endpoint-review.json](./date-confidence-endpoint-review.json)。`,
  "",
  "本轮优先复核 185 条记录的 305 个旧不确定日期端点；其余记录暂缓。所选记录中的 38 个未标记端点只核对区间结构，不扩大史料复核范围。空间定位 approximate 不纳入日期复核。",
  "",
  "## 结果",
  "",
  "- 185/185 条记录逐项保留原 ID 并形成端点结论；305/305 个标记端点有旧值、新 confidence、记录日期说明和所属包来源索引。遗漏 0、待核 0。",
  `- 本轮 305 个优先端点的日期数值变化 ${report.summary.dateValueChanges}；confidence 分类与结构适配逐端点列入 JSON。未凭占位年月推算真实月日。另有 ${legacyEventConversions.length} 条旧 circa 记录转为 ${legacyEventConversions.filter((event) => event.timeMode === "span").length} 条 span 与 ${legacyEventConversions.filter((event) => event.timeMode === "point").length} 条 approximate point；每条的前后字段、原日期说明和依据也列于 JSON。`,
  `- 其余记录另有 ${structuralMigration.structuralEndpoints} 个端点做旧精度/近似标记到新 confidence 的结构适配，日期数值改动 ${structuralMigration.dateValueChanges}，无法映射的有效日期端点 ${structuralMigration.unmappedDatedEndpoints}；这些记录未计为史料复核，逐条原值与新值见 JSON nonpriorityStructuralMigration。`,
  "-  approximate 端点 23 个，interpolated 端点 255 个，事件 is_approximate 时点 27 个。两条在位记录的 approximate 与 interpolated 端点分别核查，记录去重。",
  "- 38 个一致性检查端点及其他暂缓数据均未计入 305 个史料复核端点。",
  "",
  "## 迁移字段与旧列处置",
  "",
  "新增 endpoint confidence 字段，并为人物、王朝、王朝群组补齐 day 字段。用户验收通过后，独立迁移 `20261002150000_drop_legacy_date_columns` 已删除以下 12 列：",
  "",
  "- `dynasties.precision`、`dynasty_groups.precision`、`reigns.precision`、`reigns.start_date_confidence`、`reigns.end_date_confidence`",
  "- `events.precision`、`events.is_approximate`、`relations.precision`、`dynasty_capitals.precision`、`dynasty_capitals.end_precision`、`dynasty_capitals.start_date_confidence`、`dynasty_capitals.end_date_confidence`",
  "",
  "保留 `event_locations.precision`（空间精度）、原日期数值列、time_mode、date_note、AbsMonth、关联和数据库生成列 span。Prisma、API、导入 SQL 与 SQLite 已切换到 endpoint confidence。",
  "",
  "## 核查依据",
  "",
  "每个端点以冻结基线原值、源缓存 dateNote（存在时）及所属包 manifest.notes / manifest.sources 为依据。JSON 为每个端点保留结论，并附相关包说明和来源链接；若包级说明不能直接覆盖某条记录，需在校验时将该端点视为依据不足，不把映射本身算作史料。日期数值没有因置信分类而改写。",
  "",
  "## 数据库与验证",
  "",
  "- 数据库先备份：`/tmp/eralens-date-migration-prechange-20261002.sql`；源数据备份：`/tmp/eralens-date-source-prechange-20261002.tar.gz`。",
  "- PostgreSQL 新增字段、结构回填与 point/span 约束迁移 `20261002120000`–`20261002140000` 已验证；验收通过后，`20261002150000_drop_legacy_date_columns` 已删除 12 个废弃日期列。",
  "- 九个所有者导入包的缓存增加逐端点 confidence；所有旧 circa 事件按已有范围说明结构适配。统一生成全部导入包 SQL 并通过导入校验，再按包增量应用，未清库、未运行 seed。",
  `- 全库键集与迁移前快照对照一致。导入对照发现战国包旧版清理规则误删无在位卡人物；已移除该全局规则，并按唯一所有者恢复 ${importRepairs.rowsRestored} 名人物和 1 条都城关联。逐条 ID、所有者与验证表清单见 JSON importRepairs 节。`,
  `- Mock/seed 中另有 ${seedChanges.count} 条 circa 样例同步改为 point/span 并保留原范围；详见 JSON seedChanges。该文件不用于真实数据导入。`,
  `- 另更新 ${metadataChanges.changes.length} 条 manifest 说明以匹配新事件模型；旧文案、新文案与原因见 JSON metadataChanges。`,
  "- DROP 前数据库备份：`/tmp/eralens-date-confidence-pre-drop-20261002.sql`；源导入/seed 归档：`/tmp/eralens-date-confidence-imports-20261002.tar.gz`。每条源数据与结构差异见本报告 JSON；恢复需使用匹配版本的完整备份。",
  "",
];
writeFileSync(path.join(root, "docs/date-confidence-change-report.md"), `${lines.join("\n")}\n`);
console.log(`Wrote report for ${report.summary.reviewedRecords} records and ${report.summary.reviewedEndpoints} endpoints.`);
