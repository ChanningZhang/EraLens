# 春秋战国数据包

本包只保留一份可人工维护的在位数据缓存和一份人物资料缓存。缓存是本包生成数据的事实源；修正史料、称号、姓名、年代、多次在位和条目链接时，直接编辑对应 JSON，不要从 Wiki 原始文本自动重建或覆盖它们。

## 文件

- `sources/wiki-*.json`：Wiki 页面原文缓存，供查证来源；可直接更新或编辑。
- `rulers.json`：已核对的君主和在位区间缓存。这里保留 id、起讫年、精度置信度和并立字段。
- `ruler-bios.json`：人物简介修订及 person id 到 Wiki 标题的映射。
- `generate.mjs`：读取君主、人物缓存和包内其余实体数据，生成 PostgreSQL `import.sql`、SQLite `import.sqlite.sql` 和 `manifest.json`。
- `fetch-wiki-zh-cn.py`：仅抓取 Wiki 页面并保存原文缓存，不解析或修订缓存内容。

君主表与人物资料的日常修改只需编辑 JSON 缓存并运行：

```sh
node data/imports/chunqiu-zhanguo/generate.mjs
```

Wiki 原文仅作查证，已核定的在位事实直接维护在 JSON 缓存，不再经过 `build-rulers.mjs` 里的 ID 覆盖表、年份补丁、表格解析规则和自动重建步骤。记录数量由生成器从缓存计算。

两个 SQL 文件来自同一份缓存和实体数据；生成器只在 SQL 方言层处理 PostgreSQL 数组、JSON 与旧数据清理语法。`import.sqlite.sql` 目前是生成产物，仓库没有命令自动执行它。正式移动端 SQLite 数据库由 `pnpm db:import` 从 PostgreSQL 导出；`pnpm ios:sync` 校验并打包该数据库，Xcode 构建/运行不会执行本包的 SQL 文件。
