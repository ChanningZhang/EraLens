# 真实数据导入包

导入包的 JSON 缓存是事实源；数据有误时直接编辑缓存，并把史料依据与取舍写入同包 `manifest.notes`。生成脚本只读取缓存并调用共用 SQL 序列化器，不解析 Wiki、不补年份、不改称谓，也不为单个时期写数据覆盖逻辑。

缓存驱动包使用统一结构：

- `cache.json`：已核定的 persons、dynasties、reigns、events、relations 等记录。`*_abs`、时间精度、置信度、别名和来源均随记录保存。
- `data/imports/generate.mjs`：唯一生成入口；只读取指定包缓存并调用共用 SQL 序列化器。
- `import.sql`、`manifest.json`：生成文件，不手工维护。`import.sql` 用于导入 PostgreSQL。

重新生成单个包：

```sh
node data/imports/generate.mjs {slug}
# 或重新生成全部缓存包
node data/imports/generate.mjs --all
```

缓存中的 `preSql` / `postSql` 仅用于升级时清理旧数据库记录；它们不负责修改缓存记录。正式移动端 SQLite 数据库由 `pnpm db:import` 从 PostgreSQL 导出，导入包只生成 PostgreSQL SQL。Xcode 构建和运行不会执行导入包 SQL。
