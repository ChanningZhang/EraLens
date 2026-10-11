# iOS 内容快照

`data/imports/` 是历史资料唯一事实源。Web API、iOS 与 macOS 共用由 `data/imports/` 全量构建的 SQLite 内容库；不手工编辑快照，也不运行导入 SQL 到设备端。Apple 应用把只读数据库装入应用包，内容随应用版本更新。

## 构建与检查

需要 Node.js 22.16 或更新版本（使用内置 `node:sqlite`），无需 PostgreSQL：

```bash
pnpm data:build
pnpm data:validate
pnpm data:mobile:diff -- --base=/path/to/previous.sqlite
pnpm release:classify -- --base=<last-data-or-app-tag>
```

构建默认写入被 Git 忽略的 `data/mobile/eralens-content.sqlite`；可通过 `--out=/path/file.sqlite` 指定其他位置。构建会按稳定主键顺序构建实体和连接表、生成 `search_entries`、用共享 DTO mapper 和 Zod 校验数据，并执行 SQLite 完整性与外键校验。成功后才会原子替换目标快照。

每个快照的 `content_metadata` 包含 `schema_version`、`contract_version`、`dataset_version`、来源 Git SHA、内容 checksum、表计数和构建时间。checksum 覆盖所有内容表及搜索索引，不含会变化的构建时间。可用 `DATASET_VERSION` 固定发布版本标识；未设置时使用内容 checksum 派生本地版本号。

## 版本规则

- SQLite 表或索引结构变化时，在 `data/mobile/versions.json` 递增 `schemaVersion`。
- DTO、枚举或 SQLite 到共享契约映射的兼容性变化时递增 `contractVersion`。
- schema / contract 变化属于应用发布，不能分类为纯数据更新。
- `data/mobile/versions.json` 同时定义导出、校验和 SQLite Repository 支持的版本。`pnpm ios:build:sim`、Xcode Build/Archive 和 `pnpm mac:build` 会验证快照并将版本文件与数据库一起打包；版本不兼容时应用会显示初始化错误，不回退到 HTTP。
- iOS 与 macOS 的数据库以只读方式从应用资源打开。旧 iOS Capacitor 安装不迁移偏好或下载库，需要卸载后全新安装；新版本应用会保留原生 UserDefaults 设置。
- `release:classify` 比较候选工作区与基线引用，输出 `DATA_ONLY`、`APP_RELEASE_REQUIRED` 或 `MANUAL_REVIEW`。生成器、SQL 导入物和非安全 manifest 字段会触发人工复核；应用、共享契约、schema、依赖和构建基础设施改动要求发应用版本。
- 快照 diff 给出各表主键维度的新增、更新和删除数量，便于发布前复核内容变动。

分类器只提供发布门禁输入，不替代历史事实审核或快照验证。Apple 端内容直接随应用版本发布，不提供独立的签名数据更新流程。
