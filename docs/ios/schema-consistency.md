# iOS 迁移 schema 一致性清单（历史记录）

本文中的 Capacitor 迁移批次、旧版本号和历史运行记录仅供追溯。当前架构使用共享 `packages/apple-native` Swift 原生桥接和 `SqliteTimelineRepository`；iOS、macOS 通过同一只读 SQLite 实现读取随应用发布的内容。设置保存在 UserDefaults，Web 使用 localStorage。

第 0 批冻结事件类型基线。`agriculture` 已存在于共享契约和真实导入数据；迁移只补齐文档枚举，不改变数据分类。第 1 批快照全量 Zod 校验另外发现真实关系数据含 `politics`，因此关系枚举同步补齐并将 SQLite `contractVersion` 从 1 提升到 2。

## 第 2 批 Repository 与查询一致性

- Repository 契约和 HTTP / SQLite 装配位于 `packages/data-access/`。Web 默认使用 HTTP；Apple 原生构建通过 `VITE_DATA_SOURCE=native` 使用共享 Swift SQLite 桥接；`VITE_DATA_SOURCE=mock` 仍只用于开发 Mock。
- `SqliteTimelineRepository` 首次访问时读取快照各实体表并按 shared Zod schema 映射，后续通过 `filterTimeline()`、`buildEntityDetail()`、`searchEntities()` 等 shared 规则提供查询结果。
- 事件显示设置由 Repository 持久化；iOS/macOS 使用 UserDefaults 原生桥接，Web 使用 localStorage，HTTP 模式沿用 API 设置端点。详情 URL 状态移入 `selectionUrlState.ts`，详情宽度设置移入 `userSettings.ts`。
- `getPersons() / getReigns() / getEvents()` 原本只有 Mock 有实现、没有调用方，已从 Repository 契约移除。
- `pnpm data:mobile:contract` 对比八个固定历史窗口、四种 LOD、五类详情、搜索、bounds、catalog 和 capitals；比较前只对无顺序语义的 ID 集合规范排序。`pnpm data:mobile:sqlite-smoke` 可在没有 API 的情况下跑 SQLite 查询冒烟检查。
- 当前 `pnpm ios:build:sim` 和 Xcode Build/Archive 会先校验正式快照，再生成 Web 资源并将只读 SQLite 与 `versions.json` 放入应用包；macOS 发布命令使用相同资源构建脚本。

历史对照记录：该次工作从本机 PostgreSQL 重建快照后，SQLite 完整性、外键与全量 Zod 校验通过（schema 1 / contract 2）；Repository 对照通过 52 组比较，覆盖八个固定窗口、四种 LOD、五类详情、搜索、bounds、catalog 和 capitals。先前发现的 11 条悬空关系已按来源修复：删除两个指向已删除事件的事件关联；重放命运线源，更新九条有效的人物命运关系，其中陈叔宝降隋改为关联现存的 `sui-unify`，其余过期事件关联清空。

iPhone 17 Pro 与 iPad (A16) / iOS 26.4 模拟器的历史 Capacitor 验证记录。当前 UIKit + WKWebView 架构的模拟器构建由 `pnpm ios:build:sim` 完成，并在 Xcode 构建阶段自动打包资源。

| 契约项 | 当前定义位置 | 当前状态 |
|---|---|---|
| `EventKindSchema` | `packages/shared/src/schema.ts` | `battle`, `politics`, `culture`, `disaster`, `commerce`, `agriculture`, `finance`, `idiom`, `poetry`, `other` |
| SQLite `events.kind` | `data/mobile/schema.sql` | `TEXT`；取值由共享 Zod 契约和导入校验约束 |
| 中文标签 | `packages/shared/src/eventTime.ts` | 含“农业” |
| 时间轴样式 | `apps/web/src/features/timeline/components/EventLayer.module.css` | 含 `agriculture` 样式 |
| 筛选默认值 | `packages/shared/src/schema.ts` | 十种类型默认启用 |
| 时期导入 Skill | `.cursor/skills/eralens-period-import/SKILL.md` | 已列出 `agriculture` |
| 事件导入 Skill | `.cursor/skills/eralens-event-import/SKILL.md` | 已列出并说明农业事件适用范围 |
| `RelationKindSchema` | `packages/shared/src/schema.ts` | 含 `politics`；与导入数据中的一般政治关联一致 |
| SQLite 导出映射 | 第 1 批 | 保留原枚举字符串，并由共享 DTO 契约校验 |
| `ReignSchema.dynastyName` / SQLite `reigns.dynasty_name` | `packages/shared/src/schema.ts` / `data/mobile/schema.sql` | 可选的在位王朝名覆盖；详情优先使用，空值回退 `dynasties.alt_names[0]` |

## 后续变更门禁

新增事件类型时，逐项更新上表涉及的 Zod、SQLite schema/数据库校验、显示标签、样式、筛选默认值、导入 Skill 和 SQLite 构建/校验。类型集合以共享 Zod 枚举为权威，不能仅新增数据值。


> 现行架构（schema 8 / contract 9）已由 `data/mobile/schema.sql`、`data/mobile/versions.json` 和共享 SQLite Repository 定义。上述 PostgreSQL 对照结果为历史记录，不代表当前构建流程。
