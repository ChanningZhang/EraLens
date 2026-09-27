# iOS 迁移 schema 一致性清单

第 0 批冻结事件类型基线。`agriculture` 已存在于共享契约和真实导入数据；迁移只补齐文档枚举，不改变数据分类。第 1 批快照全量 Zod 校验另外发现真实关系数据含 `politics`，因此关系枚举同步补齐并将 SQLite `contractVersion` 从 1 提升到 2。

| 契约项 | 当前定义位置 | 当前状态 |
|---|---|---|
| `EventKindSchema` | `packages/shared/src/schema.ts` | `battle`, `politics`, `culture`, `disaster`, `commerce`, `agriculture`, `finance`, `idiom`, `poetry`, `other` |
| Prisma `Event.kind` | `apps/api/prisma/schema.prisma` | `String`；取值由共享 Zod 契约和导入校验约束 |
| 中文标签 | `packages/shared/src/eventTime.ts` | 含“农业” |
| 时间轴样式 | `apps/web/src/features/timeline/components/EventLayer.module.css` | 含 `agriculture` 样式 |
| 筛选默认值 | `packages/shared/src/schema.ts` | 十种类型默认启用 |
| 时期导入 Skill | `.cursor/skills/eralens-period-import/SKILL.md` | 已列出 `agriculture` |
| 事件导入 Skill | `.cursor/skills/eralens-event-import/SKILL.md` | 已列出并说明农业事件适用范围 |
| `RelationKindSchema` | `packages/shared/src/schema.ts` | 含 `politics`；与导入数据中的一般政治关联一致 |
| SQLite 导出映射 | 第 1 批 | 保留原枚举字符串，并由共享 DTO 契约校验 |

## 后续变更门禁

新增事件类型时，逐项更新上表涉及的 Zod、Prisma/数据库校验、显示标签、样式、筛选默认值、导入 Skill 和 SQLite 导出/校验。类型集合以共享 Zod 枚举为权威，不能仅新增数据值。
