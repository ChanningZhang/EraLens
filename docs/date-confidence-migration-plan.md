# 日期 confidence schema 迁移方案

## 范围冻结

以 2026-10-02 导入包与 PostgreSQL 为基线，按原字段筛选 `approximate`、`interpolated` 和事件 `is_approximate=true`：在位 154 条/273 个端点，都城 4 条/5 个端点，事件 27 条/27 个时点，共 185 条、305 个端点，分布于九个所有者包。approximate 23 个端点、interpolated 255 个端点、事件 is_approximate 27 个时点；两条在位记录具有两类端点，记录数去重。

实施前冻结了包名、类型、ID、端点、原日期、原置信字段、manifest 哈希与数据库快照，见 [date-confidence-review-baseline.json](./date-confidence-review-baseline.json)。同一批记录中的 38 个未标记端点只作区间结构一致性核对。其余数据暂缓；空间定位 `approximate` 不属于日期范围。

## 字段变更

新增以下 endpoint-level confidence 字段：

- `persons`: `birth_confidence`, `death_confidence`；补齐 `birth_day`, `death_day`。
- `dynasties`: `start_confidence`, `end_confidence`；补齐 `start_day`, `end_day`。
- `dynasty_groups`: `start_confidence`, `end_confidence`；补齐 `start_day`, `end_day`。
- `reigns`: `start_confidence`, `end_confidence`。
- `events`: `at_confidence`, `start_confidence`, `end_confidence`。
- `relations`: `at_confidence`。
- `dynasty_capitals`: `start_confidence`, `end_confidence`。

confidence 值为 `day/month/year`、`approximate_day/approximate_month/approximate_year`、`interpolated_by_other/interpolated_by_generation`。事件仅 point/span 的最终 schema 与兼容数据清理需一起完成；不增加 `displayScale`。

## 明确废弃并已 DROP 的列

用户于 2026-10-02 验收通过后，日期 confidence 新模型已接管数据与应用读取，独立迁移 `20261002150000_drop_legacy_date_columns` 已删除明确废弃的 12 列：

- `dynasties.precision`
- `dynasty_groups.precision`
- `reigns.precision`
- `reigns.start_date_confidence`
- `reigns.end_date_confidence`
- `events.precision`
- `events.is_approximate`
- `relations.precision`
- `dynasty_capitals.precision`
- `dynasty_capitals.end_precision`
- `dynasty_capitals.start_date_confidence`
- `dynasty_capitals.end_date_confidence`

保留 `event_locations.precision`（空间定位精度）、日期数值列、`time_mode`、`date_note`、AbsMonth、关联列与生成列 `span`。

## 执行顺序

1. 备份 PostgreSQL 与源数据，冻结所选端点与源校验值。
2. **已执行：**加新列、补齐缺少的日期 day 列，按旧字段无损回填；在应用切换完成前暂留旧列。
3. 对 185 条优先记录逐条、逐端点查证；无更高精度来源时保留值，confidence 明确表达推断/近似类型。只核对 38 个未标记端点的区间一致性。
4. 更新唯一所有者包 cache，执行全量所有权审计、SQL 生成和逐包验证，再增量更新 PostgreSQL。
   旧 circa 行全部转换后验证 `events_time_mode_point_span_check`，确保事件库只接受 point/span。
5. 同步 Prisma、Zod、shared、API、Web、SQLite 和移动端契约；集中保留旧格式兼容转换，不添加实体特判。
6. **已执行：**发布逐记录 JSON diff 与 Markdown 报告；验收前旧列保留。
7. **已完成：**用户明确确认迁移验收通过后，应用独立 DROP，清理兼容代码，导出并验证匹配版本的 SQLite 快照。DROP 前 PostgreSQL 备份位于 `/tmp/eralens-date-confidence-pre-drop-20261002.sql`，源数据归档位于 `/tmp/eralens-date-confidence-imports-20261002.tar.gz`。通过与该版本匹配的完整备份恢复；不清库重导、不运行 `db:seed`。

## 预期验证

核对八类 confidence 展示、日/月/年精度、历法换算、混合端点、两类插值、开放终点、事件不足一年阈值、导入包所有权、PostgreSQL/API 与 SQLite 契约一致性。详细逐条变更与依据见 [date-confidence-change-report.md](./date-confidence-change-report.md)。
