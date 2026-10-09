# EraLens 代理规范

本文件只保留跨任务通用约束。产品说明与开发启动见 [README.md](README.md)；具体数据工作流见：

- [完整时期导入](.cursor/skills/eralens-period-import/SKILL.md)
- [事件添加与丰富](.cursor/skills/eralens-event-import/SKILL.md)
- [在位信息添加与丰富](.cursor/skills/eralens-reign-import/SKILL.md)
- [地理信息添加与丰富](.cursor/skills/eralens-geography-import/SKILL.md)
- [数据修复](.cursor/skills/eralens-data-fix/SKILL.md)
- [日期处理](.cursor/skills/eralens-date-handling/SKILL.md)

## 项目结构

- Web：React + TypeScript + Vite，位于 `apps/web/`；API：Fastify + Node.js 内置 SQLite，位于 `apps/api/`。
- `packages/shared/` 存领域规则与数据契约；`data/imports/` 存真实数据源；`data/seed/` 仅供 Mock 和示例数据。
- 本地命令、环境变量和 Docker 说明以 README 与各 `.env.example` 为准。

## 通用技术约束

1. 用可复用规则处理大多数情况；例外尽量通过数据标记表达。单个王朝、人物或事件的代码特判必须先得到用户同意。
2. 时间、schema、正统、称谓、时间区间归属、命运线和泳道分组等领域逻辑放在 `@eralens/shared` 或 `data/imports/lib/`；前端负责投影与渲染，API 负责查询与映射。
3. 同一语义只保留一条实现路径；缺载 reign、普通 reign 共用 `Reign` 和 `layoutLaneReignBar`，不得为单一数据类型另造坐标或布局逻辑。
4. 展示使用共用组件和函数。卡片宽度遵循时间几何，不为塞入文字拉伸时间跨度；王朝本色、正统覆盖色和卡片称谓遵循共享规则。

## 时间与数据约束

- 所有时间使用 `AbsMonth`：`absMonth(year, month) = toAstroYear(year) * 12 + month - 1`，其中公元前年份 `toAstroYear(year) = year + 1`。公元前年份以负数存入 `*_year`。
- 相邻时间区间的归属统一经过 `packages/shared/src/timelineOwnership.ts`，按精度由 `timelineIntervals.ts` 裁定。调用侧不得自建端点判断、分组规则或手写 `+1 年/月` 截断。
- 真正并立或语义上可共存的区间保留并行记录；在位轨道用 `claim_track` 表达，实体分组只用于聚类独立实体，不代替并立轨道；不得让接续裁定合并并存数据。
- 年精度点事件与命运线使用 12 月作为年桶右缘；泳道起年和迄年的占位月份分别为 1 月和 12 月。占位月份不得显示成已知月份。
- 所有日期的史料精度、历法换算、置信度和展示统一遵循 [日期处理 Skill](.cursor/skills/eralens-date-handling/SKILL.md)。界面年份仍统一显示带符号年份（如「-221年」「2026年」），事件轴仍在视口内时事件名必须可见。

## 真实数据与验证

- 真实数据只修改 `data/imports/{slug}/` 的源文件，经行所有权审计 → 包级 SQLite SQL 生成 → `pnpm db:import` 在事务中更新现有内容库并校验。不要用 `data/seed/*.json` 修生产数据。
- 普通数据更新不得随意重建或替换 SQLite 文件；默认使用 `pnpm db:import`。仅首次初始化、schema 变更或确有必要时使用 `pnpm data:build` / `pnpm db:setup`。重建或替换文件后必须重启正在运行的 API，核对 `/api/health` 的 `datasetVersion` 与库内版本一致，再验证相关 API 返回值和刷新后的页面；不能只检查磁盘快照就声称更新完成。
- 导入包按数据库行隔离所有权：同一主键/唯一键只能出现在一个包；补充包可引用其他包的记录，但不得重复写关联行或通过 `updates` 覆盖其他包的字段。生成前运行全量行所有权审计，冲突时先合并到唯一所有者包。
- 大批量数据的 `*_abs` 使用 `absMonth()` 或共享生成器计算；不要写入数据库生成列 `span`。
- 数据问题先核对可靠史料，再区分源数据错误、导入残留和渲染规则问题。修复数据应回到导入源与数据库层，不在 API/前端 hardcode 掩盖。
- 新枚举或 schema 字段须同步 SQLite schema、Zod、共享逻辑及对应 Skill/reference。

## 历史数据判定

- 王朝 `alt_names`（导入源 `altNames`）首项放经史料核实的国号或自称，供详情副标题使用；其余项保留史称、地域称呼和检索别名。首项允许与 `name` 相同，不凭史称机械去前缀推导自称。跨改号时期采用代表自称并在所属包 `manifest.notes` 注明取舍；三皇、五帝等无统一政权自称的集合记录清空该字段。分时名称王朝的 `name` 为含 `default` 与 `periods` 的 JSON 字符串；`default` 保存俗称（如「成汉」），供无时点或阶段范围外展示使用；`alt_names` 首项仍为代表国号或自称，供人物总览和在位详情回退使用，两者独立。在位详情可由 `reigns.dynasty_name` 指定该段王朝名。按分时名称回填该字段时仅处理主线 reign，并立政权保留其已有名称。
- 年精度顺序继位通常由旧王占有死年，新王从下一年开始；短祚、明确未逾年改元和真实并立按史料处理。所有判断依据原始史料日期。
- 空档先判为史料缺、无国君或年代失考。只有明确应有君主但姓名/世次失载才建 `system-missing-ruler`；无国君留白；有名但年代推算用 confidence 标记。禁止按年份不连续自动造缺载 reign。
- 连续世系可在共同、可靠的起讫锚点间按世次均分失考在位年并标 `interpolated`；世系中断、锚点不足或仅依传统积年时不跨断层插值。
- 王朝名称通常使用国号，不加「国」，只有通行称谓例外除外。先秦人物的姓、氏分别写入 `ancestral_xing` / `clan_shi`，`persons.name` 不重复姓或氏；搜索词由结构化字段补全姓氏组合。其他时期的 `persons.name` 保留常用可检索全名。谥号、庙号和完整年号列表分别写入各自字段。先秦谥号只存谥字（如「庄」「文」），不含公、伯、侯、子、男、王、君等称谓；完整称谓（如「庄公」「文侯」）放在 `persons.title`，不带国名。无可靠谥号记载者的 `persons.title` 保留有来源的完整称呼（如「邾子车辅」「邾君庆」），允许包含国名与本名，不缩为孤立爵称；本名与空谥号仍分别保存。先秦卡片与详情大字按 `reigns.title → persons.title → persons.posthumous_name → persons.name` 取值；详情称呼有 reign 焦点时按前三项取值，无焦点时按 `persons.posthumous_name → persons.title` 取值。明清皇帝用于泳道卡片展示的年号式称呼预先写入 `reigns.title`，运行时称呼规则不读取 `era_names`；朱元璋吴王段（吴）、努尔哈赤（太祖）、皇太极（太宗）保留原称号例外。
- 概述只写历史事实；收录取舍、年代推算与资料处理说明写入导入包 `cache.json` 内的 `manifest.notes`（来源写入 `manifest.sources`），再由统一生成器更新 `manifest.json`。

## 关键展示语义

- 金色是正统覆盖色，泳道本色由完整目录顺序稳定分配；禁止把 `color_token` 写为 `gold`。正统覆盖由 `reigns.is_main` 标记，并立 track 不标为正统主线。
- 同一王朝行内的并立君主、竞争政权或政治主张用 `claim_track` 分行，并以 `reigns.dynasty_name` 标明轨道名称；不得把 `dynasty_groups` 当作并立政权轨道。`dynasty_groups` 仅将多条独立王朝记录聚为共同历史类别/时期。确需独立王朝泳道时才新增 `dynasties` 记录。同一王朝的改名阶段合并为一条 `dynasties` 记录，`name` 的 JSON `periods` 保存分时名称。人物总览读取 `alt_names` 首项；在位详情王朝名按 `reigns.dynasty_name`、`dynasties.alt_names[0]`、王朝默认名顺序回退；泳道按视口时间通过共享解析函数取名，名称切换不依赖 reign 边界。
- 卡片宽度遵循在位时长与缩放比例；文字放不下时调整排版，不改变时间几何。相续泳道的标签颜色取舞台中线对应相位。
- 无 reign 且生卒可核的人物显示在人物层，君主不重复进入人物层。帝王卡、事件、人物和王朝名点击共用详情抽屉。
- 跨王朝命运线表达有史料依据的杀害、投降、禅让、被俘或灭国关系；灭国线从末君指向灭国方当时的君主，不据此推断末君被杀或被俘。事件时点是纵向主轴，端点解析与绘制沿用 `reignFateRelations.ts` 和 `reignFateLayout.ts`。

更细的日期、正统窗口、称谓字段、布局和命运线规则，按对应数据 Skill、共享实现与导入包 manifest 执行。
