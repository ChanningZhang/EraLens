# iOS 内容快照

`data/imports/` 是历史资料唯一事实源。iOS SQLite 由 PostgreSQL 导出，不手工编辑快照，也不运行导入 SQL 到设备端。

## 构建与检查

需要 Node.js 22.13 或更新版本（使用内置 `node:sqlite`），以及项目正常配置的 PostgreSQL `DATABASE_URL`：

```bash
pnpm data:mobile:build
pnpm data:mobile:validate
pnpm data:mobile:diff -- --base=/path/to/previous.sqlite
pnpm release:classify -- --base=<last-data-or-app-tag>
```

导出默认写入被 Git 忽略的 `data/mobile/eralens-content.sqlite`；可通过 `--out=/path/file.sqlite` 指定其他位置。构建会按稳定主键顺序导出实体和连接表、生成 `search_entries`、用共享 DTO mapper 和 Zod 校验数据，并执行 SQLite 完整性与外键校验。成功后才会原子替换目标快照。

每个快照的 `content_metadata` 包含 `schema_version`、`contract_version`、`dataset_version`、来源 Git SHA、内容 checksum、表计数和构建时间。checksum 覆盖所有内容表及搜索索引，不含会变化的构建时间。可用 `DATASET_VERSION` 固定发布版本标识；未设置时使用内容 checksum 派生本地版本号。

## 版本规则

- SQLite 表或索引结构变化时，在 `data/mobile/versions.json` 递增 `schemaVersion`。
- DTO、枚举或 SQLite 到共享契约映射的兼容性变化时递增 `contractVersion`。
- schema / contract 变化属于应用发布，不能分类为纯数据更新。
- `data/mobile/versions.json` 同时定义导出、校验和 SQLite Repository 支持的版本。`pnpm ios:sync` 将其复制为 `public/assets/databases/eralens-content.versions.json`，与数据库一起打包；iOS 原生启动校验与更新清单校验读取这份应用内配置，不另行维护版本常量。版本变更后必须重新同步并构建应用；旧的设备数据库会通过现有恢复流程替换为兼容的内置快照。
- 启动时 `copyFromAssets(false)` 只补齐缺失的数据库；已安装的数据更新由原生校验、升级和恢复流程处理，避免每次打开应用都被内置快照覆盖。
- `release:classify` 比较候选工作区与基线引用，输出 `DATA_ONLY`、`APP_RELEASE_REQUIRED` 或 `MANUAL_REVIEW`。生成器、SQL 导入物和非安全 manifest 字段会触发人工复核；应用、共享契约、schema、依赖和构建基础设施改动要求发应用版本。
- 快照 diff 给出各表主键维度的新增、更新和删除数量，便于发布前复核内容变动。

分类器只提供发布门禁输入，不替代历史事实审核、快照验证或签名发布流程。
