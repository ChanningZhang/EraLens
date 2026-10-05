# 真实数据导入包

导入包的 `cache.json` 是事实源；数据有误时直接编辑缓存。史料依据与取舍写入 `cache.json` 内的 `manifest.sources` / `manifest.notes`。不要手改生成的 `manifest.json`。

支持多级目录。包路径相对于 `data/imports/`，例如 `chunqiu-zhanguo/qi-chunqiu`；缓存与 manifest 的 `slug` 使用这个完整相对路径。分组目录可以只放 README，不放 `cache.json` 或 `import.sql`。生成、审计及全量导入共用递归包发现规则，按实际缓存或 SQL 文件识别包，保留现有一级包兼容性。

缓存驱动包使用统一结构：

- `cache.json`：已核定的 `persons`、`dynasties`、`reigns`、`events`、`relations` 等记录。`*_abs`、时间精度、置信度、别名、来源与取舍均随记录保存；字段采用 camelCase，`manifest` 是缓存中的元数据对象。
- `data/imports/generate.mjs`：唯一生成入口；只读取指定包缓存并调用共用 SQL 序列化器。
- `import.sql`、`manifest.json`：由统一生成器从缓存生成，不手工维护。`import.sql` 是唯一落盘的历史数据 SQL，同时供审阅和 Web/iOS 内容库加载；`pnpm data:sql` 从全部缓存重新生成包级 SQL。统一导入器剥离包级事务包装，按表依赖顺序加载全部包，再生成搜索索引和版本元信息；不生成全库 `.sqlite.sql` / `.refresh.sql`。`data/mobile/schema.sql` 仅定义数据库结构，继续独立保留。

## 普通关联与有向关系

普通关联唯一维护在 `entity-associations/cache.json.associations`：`{ aRef, bRef }`，端点限定 `dynasty:` / `event:` / `person:`，按完整引用的 UTF-8 字节顺序排列；同一对实体只存一条，不保存方向、kind、日期或独立 ID。各历史包不写 associations，也不写事件 dynastyIds/participantIds 或 supplemental 连接数组。

`relations` 只保存人物→人物的 succession，以及 killed/surrender/abdication/captured/conquered 命运关系。事件与人物、王朝、其他事件的普通关联都进入集中包；在位归属与地理映射继续保留专用结构。运行时事件的 dynastyIds/participantIds 由关联表投影，详情统一双向展示。

集中包的 manifest.sources/notes/counts 维护关联依据与数量，所有实体导入完成后才写关联。关联的最终状态由唯一所有者包的缓存完整表达；整库构建不运行 preSql/postSql 清理。实体删除自动级联清关联。其他包不能直接维护关联表。生成前审计拒绝旧字段、重复/非法端点与数量不符；生成器不补算 manifest 数量。

## 包间行所有权

每条数据库行只能由一个导入包拥有。同一 `id` 的人物、王朝、在位、事件等主记录不得在多个缓存中重复；关系和关联表按数据库主键/唯一键去重。补充包可以引用其他包的行，但不得再次写入同一关联行，也不得通过 `updates` 覆盖其他包的记录。需要补充字段时，直接编辑该行所属包的 `cache.json`。

`generate.mjs` 在生成任何包之前都会全量审计所有缓存的行所有权；发现重复主键、唯一键、关联行或跨包更新即停止生成并列出冲突。可单独运行审计：

```sh
node data/imports/lib/auditPackageOwnership.mjs
```

重新生成单个包：

```sh
node data/imports/generate.mjs {slug}
# 多级目录中的独立王朝包
node data/imports/generate.mjs chunqiu-zhanguo/qi-chunqiu
# 或重新生成全部缓存包
node data/imports/generate.mjs --all
```

缓存不再支持 `preSql` / `postSql`、跨包 `updates` 或增量合并指令。整库构建直接表达所有源包的最终状态，并在事务中按外键依赖顺序载入。Xcode 构建和运行不会执行导入包 SQL。

单包变更流程：编辑 `cache.json`（含 `manifest.sources` / `manifest.notes`）→ `node data/imports/generate.mjs {slug}` → 检查包 SQL → `pnpm db:import`。全量更新前可运行 `node data/imports/generate.mjs --all`；`pnpm db:import` 会审计所有包，重新生成全部包级 SQL，在单事务内按表依赖顺序加载全部包、生成搜索索引与版本元信息并校验现有内容库，API 无需重启。普通数据更新不得随意重建文件；`pnpm db:setup` / `pnpm data:build` 仅用于首次初始化、schema 变更或确有必要的重建。重建或替换 SQLite 文件后必须重启正在运行的 API，并核对 `/api/health` 的版本、相关实体返回值和刷新后的页面，详见项目 `AGENTS.md`。

API 与移动 SQLite 的契约对比使用 `pnpm data:mobile:contract`；附加 `--all-entities` 可检查全部王朝、人物、事件与在位详情。

## 统一内容数据契约（schema 10 / contract 10）

`dynasties.ethnicity` 是可选的非汉族属显示字段，按该政权皇帝所属皇族/宗族的族属填写简短通行称谓，不按摄政者或实际掌权集团填写。王朝分期中皇族变更且无法用一个称谓准确表达，或皇族族属有争议时留空。该字段用于时间轴左侧王朝标签，不替代王朝概述、国号或别名。`dynasties.feudalRank` 是可选分期 JSON `{periods:[{rank,start,end}]}`，每段日期都带 `HistoricalDate` 精度，保存来源表括号中的单字爵称/君主称谓并由共享时间分期规则解析。`君`不属于公侯伯子男五等爵；它在来源中有不同语境，须按具体条目核实。来源表只按春秋、战国分栏而未明确改称时间时，使用 `approximate_year` 表示分类栏界，并在包级 `manifest.notes` 说明不可视作确切改爵年。该字段记录来源用语，不把所有标签定义成可严格比较的爵位等级。

## 地理数据

`locations/cache.json` 唯一维护空间地点，历史包的 `locationMappings` 显式引用地点与 dynasty/reign/event 实体。名称、说明、来源、空间精度和都城完整时段属于 mapping；事件日期沿用所属事件。运行时和生成器都不推断君主都城关联。地点 ID 修订字段后仍保持不变。

全量构建按地点、实体和 mapping 的外键依赖排序；schema 结构变更通过 `data/mobile/schema.sql` 与 `versions.json` 管理。字段与历史名称规范见 [地理信息 Skill](../../.cursor/skills/eralens-geography-import/SKILL.md)。
