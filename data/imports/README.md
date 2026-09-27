# 真实数据导入包

导入包的 `cache.json` 是事实源；数据有误时直接编辑缓存。史料依据与取舍写入 `cache.json` 内的 `manifest.sources` / `manifest.notes`。不要手改生成的 `manifest.json`。

缓存驱动包使用统一结构：

- `cache.json`：已核定的 `persons`、`dynasties`、`reigns`、`events`、`relations` 等记录。`*_abs`、时间精度、置信度、别名、来源与取舍均随记录保存；字段采用 camelCase，`manifest` 是缓存中的元数据对象。
- `data/imports/generate.mjs`：唯一生成入口；只读取指定包缓存并调用共用 SQL 序列化器。
- `import.sql`、`manifest.json`：由统一生成器从缓存生成，不手工维护。`import.sql` 用于导入 PostgreSQL；移动端 SQLite 由 PostgreSQL 导出，不在导入包内生成 SQLite SQL。

## 包间行所有权

每条数据库行只能由一个导入包拥有。同一 `id` 的人物、王朝、在位、事件等主记录不得在多个缓存中重复；关系和关联表按数据库主键/唯一键去重。补充包可以引用其他包的行，但不得再次写入同一关联行，也不得通过 `updates` 覆盖其他包的记录。需要补充字段时，直接编辑该行所属包的 `cache.json`。

`generate.mjs` 在生成任何包之前都会全量审计所有缓存的行所有权；发现重复主键、唯一键、关联行或跨包更新即停止生成并列出冲突。可单独运行审计：

```sh
node data/imports/lib/auditPackageOwnership.mjs
```

重新生成单个包：

```sh
node data/imports/generate.mjs {slug}
# 或重新生成全部缓存包
node data/imports/generate.mjs --all
```

缓存中的 `preSql` / `postSql` 仅用于升级时清理旧数据库记录；它们不负责修改缓存记录。正式移动端 SQLite 数据库由 `pnpm db:import` 从 PostgreSQL 导出，导入包只生成 PostgreSQL SQL。Xcode 构建和运行不会执行导入包 SQL。

单包变更流程：编辑 `cache.json`（含 `manifest.sources` / `manifest.notes` / `manifest.counts`）→ `node data/imports/generate.mjs {slug}` → 校验对应 `import.sql` → `apply-sql.sh`。全量流程：先运行 `node data/imports/generate.mjs --all`，再运行 `pnpm db:import`。`db:import` 不会替缓存生成 SQL，并会清空后重载本地 PostgreSQL，再构建移动端 SQLite。
