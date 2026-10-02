# 日期置信度迁移与复核报告

基线日期：2026-10-02。基线导入 manifest SHA-256：`c9d85c498bc93f4b7bea7fbdb8baf7304a6fc4707381807788903a4f71d62334`。逐端点明细见 [date-confidence-endpoint-review.json](./date-confidence-endpoint-review.json)。

本轮优先复核 185 条记录的 305 个旧不确定日期端点；其余记录暂缓。所选记录中的 38 个未标记端点只核对区间结构，不扩大史料复核范围。空间定位 approximate 不纳入日期复核。

## 结果

- 185/185 条记录逐项保留原 ID 并形成端点结论；305/305 个标记端点有旧值、新 confidence、记录日期说明和所属包来源索引。遗漏 0、待核 0。
- 本轮 305 个优先端点的日期数值变化 0；confidence 分类与结构适配逐端点列入 JSON。未凭占位年月推算真实月日。另有 36 条旧 circa 记录转为 11 条 span 与 25 条 approximate point；每条的前后字段、原日期说明和依据也列于 JSON。
- 其余记录另有 3923 个端点做旧精度/近似标记到新 confidence 的结构适配，日期数值改动 0，无法映射的有效日期端点 0；这些记录未计为史料复核，逐条原值与新值见 JSON nonpriorityStructuralMigration。
-  approximate 端点 23 个，interpolated 端点 255 个，事件 is_approximate 时点 27 个。两条在位记录的 approximate 与 interpolated 端点分别核查，记录去重。
- 38 个一致性检查端点及其他暂缓数据均未计入 305 个史料复核端点。

## 迁移字段与旧列处置

新增 endpoint confidence 字段，并为人物、王朝、王朝群组补齐 day 字段。用户于 2026-10-02 验收通过后，独立迁移 `20261002150000_drop_legacy_date_columns` 已从 PostgreSQL 删除以下 12 列：

- `dynasties.precision`、`dynasty_groups.precision`、`reigns.precision`、`reigns.start_date_confidence`、`reigns.end_date_confidence`
- `events.precision`、`events.is_approximate`、`relations.precision`、`dynasty_capitals.precision`、`dynasty_capitals.end_precision`、`dynasty_capitals.start_date_confidence`、`dynasty_capitals.end_date_confidence`

保留 `event_locations.precision`（空间精度）、原日期数值列、time_mode、date_note、AbsMonth、关联和数据库生成列 span。Prisma、API 查询与映射、导入 SQL、SQLite schema/repository 已切换到 endpoint confidence；旧日期精度仅由 confidence 派生为非持久化的展示/区间辅助值。

## 核查依据

每个端点以冻结基线原值、源缓存 dateNote（存在时）及所属包 manifest.notes / manifest.sources 为依据。JSON 为每个端点保留结论，并附相关包说明和来源链接；若包级说明不能直接覆盖某条记录，需在校验时将该端点视为依据不足，不把映射本身算作史料。日期数值没有因置信分类而改写。

## 数据库与验证

- 数据库先备份：`/tmp/eralens-date-migration-prechange-20261002.sql`；源数据备份：`/tmp/eralens-date-source-prechange-20261002.tar.gz`。
- PostgreSQL 新增字段与结构回填迁移：`20261002120000_endpoint_date_confidence`、`20261002130000_backfill_endpoint_date_confidence`；事件 point/span 约束迁移 `20261002140000_event_point_span_only` 已验证通过，当前 circa 行数为 0。用户验收后已应用独立 DROP 迁移 `20261002150000_drop_legacy_date_columns`。
- 九个所有者导入包的缓存增加逐端点 confidence；所有旧 circa 事件按已有范围说明结构适配。统一生成全部导入包 SQL 并通过导入校验，再按包增量应用，未清库、未运行 seed。
- 全库键集与迁移前快照对照一致。导入对照发现战国包旧版清理规则误删无在位卡人物；已移除该全局规则，并按唯一所有者恢复 75 名人物和 1 条都城关联。逐条 ID、所有者与验证表清单见 JSON importRepairs 节。
- Mock/seed 中另有 11 条 circa 样例同步改为 point/span 并保留原范围；详见 JSON seedChanges。该文件不用于真实数据导入。
- 另更新 1 条 manifest 说明以匹配新事件模型；旧文案、新文案与原因见 JSON metadataChanges。
- DROP 前备份：`/tmp/eralens-date-confidence-pre-drop-20261002.sql`；源导入和 seed 归档：`/tmp/eralens-date-confidence-imports-20261002.tar.gz`。迁移后确认 12 列均不存在，保留 `event_locations.precision`；数据库行数核对为 persons 1436、dynasties 129、dynasty_groups 7、reigns 1232、events 442、relations 873、dynasty_capitals 219、reign_capitals 1269。SQLite 快照已重建，schema version 升至 2、contract version 为 3；结构校验通过，HTTP/SQLite 契约比较 52 项、8 个窗口、4 种 LOD 全部通过。
- DROP 迁移仅删除旧兼容列，未插入、更新或删除任何数据库记录；当前王朝、王朝组、在位、事件、关系、都城所有有效日期端点的 confidence 空值数均为 0。旧值已在此前回填并映射到端点 confidence，原逐项依据见本报告 JSON。
- 验证：`pnpm build`、移动端 SQLite 校验、HTTP/SQLite 契约对照及导入 SQL 辅助测试通过。完整 `pnpm test` 当前未全绿：shared 套件有 53 项失败，集中在旧测试输入/断言仍使用旧置信值或不带 confidence 的旧模型，以及日期显示断言；需要按新 confidence 模型更新这些测试。该结果不影响迁移结构及 52 项 API/SQLite 契约核对。
- 本轮数据库变更无清库或重导；部署恢复必须使用与日期模型匹配的完整备份，并在迁移版本一致时恢复。
- 每条源数据、SQL 与数据库的完整 diff 见本报告 JSON；数据库恢复需使用同一版本的完整备份。
