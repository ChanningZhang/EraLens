# EraLens 代理规范

本文件面向开发、入库和排查。产品使用与启动说明见 [README.md](README.md)；入库细则见 Skill [eralens-period-import](.cursor/skills/eralens-period-import/SKILL.md)；数据修复见 Skill [eralens-data-fix](.cursor/skills/eralens-data-fix/SKILL.md)。

## 开发入口

- 技术栈：React 19 + TypeScript + Vite；Fastify + Prisma + PostgreSQL 16；Zustand 管视口瞬时状态，TanStack Query 管 LOD 分块缓存，Framer Motion 管王朝行过渡。
- `packages/shared/`：`AbsMonth`、Zod 契约、正统、称谓、命运线和泳道分组等领域逻辑。
- `apps/web/src/features/timeline/`：时间轴舞台、泳道、卡片、事件/人物/命运层与标尺；`apps/web/src/features/detail/`：详情抽屉。
- `apps/api/`：Fastify 路由、查询映射及 Prisma schema；`data/imports/{slug}/`：真实时期包；`data/imports/lib/`：共享生成器；`data/seed/`：Mock 和 `db:seed` 样本。

本地开发用 `pnpm install`、`pnpm db:setup`、`pnpm dev:all`（前端 5173，API 3001）。`db:setup` 依次启动 PostgreSQL、执行迁移、运行 `db:import`；`db:import` 会 TRUNCATE 后重灌真实数据。只开发前端时可用 `VITE_DATA_SOURCE=mock pnpm dev`，无需 API。`pnpm test`、`pnpm lint`、`pnpm build` 分别用于验证。

Docker 镜像只包含 `data/seed/`，`docker compose up --build` 会启动应用与 PostgreSQL，但不会导入完整时期包。`RUN_SEED=true docker compose up --build` 会写入样本；不要在真实数据卷上使用。`docker compose down` 会保留 `eralens_pg_data`。数据库单独管理命令为 `pnpm db:up`、`pnpm db:migrate`、`pnpm db:import`、`pnpm db:down`。

Web 环境变量见 `apps/web/.env.example`：`VITE_DATA_SOURCE` 默认 `http`，可设为 `mock`；`VITE_API_BASE` 默认 `/api`；`VITE_PERF_DATA=1` 注入合成性能数据。API 的 `DATABASE_URL`、`PORT` 见 `apps/api/.env.example`。HTTP 与 Mock Repository 使用同一契约；主要接口为 `GET /api/timeline?from=&to=&lod=&scope=`、`GET /api/entities/:type/:id`、`GET /api/search?q=` 和 `GET /api/bounds`。入库后界面未更新，先硬刷新，再检查 `VITE_DATA_SOURCE`。

时间坐标统一用 `AbsMonth`：`absMonth(year, month) = toAstroYear(year) * 12 + (month - 1)`，其中 `toAstroYear(year) = year > 0 ? year : year + 1`。公元前日历年以负数写入 `*_year`；LOD（millennium / century / decade / month）随 `pxPerMonth` 切换，查询按 chunk 对齐。

## 技术规范

1. 绝大部分逻辑必须基于抽象规则，而非特殊处理。
2. 通过抽象规则 + 数据上的标记处理大多数例外。
3. 代码层面所有特殊处理逻辑都必须用户同意。禁止为单个王朝、帝王、事件写 if-id 分支。
4. 王朝名、泳道、帝王卡片、tooltip、字体大小、谥号/庙号/年号等展示，必须以共用组件与共用函数完成，不允许对某个对象单独画一套。
5. 领域规则放 `@eralens/shared`（时间、schema、正统、称谓、命运线解析、cluster/lane group）。前端只负责投影与渲染；API 只负责查询与映射。
6. 真实数据只走 `data/imports/{slug}/` 的 generate → SQL → `pnpm db:import`。不要改 `data/seed/*.json` 来「修生产数据」——那是 Mock / `pnpm db:seed` 样本。`pnpm db:setup` 导入的是 imports，不是 seed。
7. 同一语义只保留一条代码路径。史料缺 reign 与普通 reign 都是 `Reign`：布局走 `layoutLaneReignBar`，命运线锚点同一套几何。禁止为 missing 再写一套坐标。

## 业务规范

1. 同一王朝、结束时间与下一位开始时间相同的帝王，默认按时间先后串行排列；同时另立才用 `claim_track`（一朝多帝）。前帝身后即位（含权臣拥立）走主线，不填 track。
2. 君主有连续世系但大多数在位年失载时，先交叉核对若干可考君主、明确纪事或可靠年表锚点；在共同的起讫锚点间按世次均分失考君主的区段，并标 `interpolated`，锚点本身及其相接确定边界保持确定。若世系中断、锚点不足或只剩传统积年，不跨断层插值；继续查证并说明无法填充的区段。不能因此让有连续世系和足够锚点支撑的泳道没有国君卡。
3. 年精度顺序继位（先秦通行）：死年整年归旧王，新王从下一年起算。一年短祚、史料写明未逾年改元、真正并立除外。月日有史料则用月日。不要把维基「在位年份」的死年重叠画成两人并立。
4. 甄别史料日期使用的历法，明确区分农历与公历；不得把农历月日直接当作公历日期入库或换算。来源只给农历日期时，保留原始记载并注明历法；只有在可靠依据支持换算时，才录入对应公历日期，并记录换算依据。
5. 空白必须先定性，再决定是否写数据：
   - **史料缺**：应有国君但姓名/世次失载 → `person_id = system-missing-ruler` 的占位 reign，虚线框。
   - **无国君**：亡国、尚未复立、该行本不设君（武周的唐行、秦灭楚后）→ 不写 reign，自然留白。
   - **年代失考**：知道是谁、年份为均分/约数 → `start/end_date_confidence`（`interpolated` / `approximate`）。有失考标记的边在卡片上画波浪线；日历相接的两王交界两侧必须同为失考或同为确定（灭国留白不相接，各画自己的失考边）。
   - 禁止用相邻年份不连续自动插入「史料缺」。深度不够就继续查，不要标成缺载。
6. 王朝名用国号，一般不带「国」（齐、楚、汉赵）。例外须有通行称呼依据：战国「东周国」「西周国」（区别于西周/东周王室行）、滇国等。
7. `persons.name` 入库仍带姓以便检索（莒郊公写 `己狂` 不写 `狂`）。先秦卡片主行用谥号/称号（不带国名），副行用私名并去掉姬姜嬴等姓；`posthumous_name` / `temple_name` 只存本体，不带国名前缀。国名写在 `title`。
8. 年精度占位月不得展示为「×月」，以免假精确。界面 tooltip 用 compact 年份（`前221年`），不要写「公元」。泳道起年占位 1 月、迄年占位 12 月；**年精度点事件与命运线用 12 月**，与泳道年桶右缘对齐。已知月份则标 `precision: month|day`，不要把正月当年来用。
9. 金色是正统**覆盖色**，不是泳道本色。泳道本色由运行时按完整目录的泳道顺序稳定分配；库内 `color_token` 目前只是 NOT NULL 占位。卡片在正统窗口内叠金，命运虚线和泳道底使用本色。左侧名牌与冻结名同一套舞台中线：该处在正统窗口内叠金，否则本色。

## 事件收录

事件层只补充泳道、在位卡片和都城数据无法表达的信息。常规建国、改国号、称帝、禅让、普通即位退位，以及仅由王朝起止或 `claim_track` 表达的更替，不另建事件。优先收录疆域与长期控制权变化、跨政权同盟或和约、制度与社会结构转折，以及少数重大统一、分裂或战争转折。

复杂疆域变化按独立事实拆分；同一事实已有事件时，补 `event_dynasties` 或修正原事件，不另建同义事件。事件可以与王朝更替同年，但必须提供更替本身以外的信息。

## 排查

1. 任何数据问题，必须搜索维基百科等权威资料核对，不能仅凭 `generate.mjs` 里的现成数据开工。
2. 先分清是数据、导入残留重复、还是渲染规则。页面上下叠卡优先查库内重复 id/同名宽跨度旧行，而不是先改 CSS。
3. 修复数据问题时，必须从数据库层面修复，而不是在中间层加hardcode。
4. 改精度、切年、正统窗口前，用原始史料起迄年判断，不要在已经后移过的日期上再切一次。

## 展示与布局

- **概述**：面向界面读者，简洁说明王朝/人物的身份、历史脉络与关键事实。只写历史内容；收录范围、资料取舍、年代推算、绘制方式等编辑/实现规范写入导入包的 `manifest.json` `notes`，不要混入概述。

- **称谓**：`resolveEmperorAppellation` 按在位起始年——唐以前偏谥号/称号，唐至元偏庙号，明清偏年号。泳道卡片小字先显示非空 `reigns.title`；title 为空时，先秦显示 `persons.name`，秦至南北朝优先谥号，隋至元优先庙号，明清优先 `reigns.era_names`，民国及以后仍沿用 title 优先原则。明清普通皇帝的 `reigns.title` 留空，年号只存 `era_names`；仅朱元璋吴王时期（“吴”）、努尔哈赤（“太祖”）、皇太极（“太宗”）三条保留 title。明清空 title 时年号优先于庙号、谥号。谥号只读 `posthumous_name`（史称如少帝/末帝/后主不得写入该字段）；庙号/年号同理读正规字段，运行时不从 `title` 推测。`reigns.title` 存其余卡片称号/史称（先秦常去国号，如 `禹`、`君舍`）；不要为「默认该显示庙号」去填 title。先秦（始皇帝以前）卡片主行用入库字段，副行私名靠 `ancestral_xing` / `clan_shi` 去姓，不靠运行时国名表或姓氏表。
- **卡片**：宽度由在位时长 × `pxPerMonth` 决定，不要为了塞字而拉宽/缩小条。字排不下时改字号或把字写到行空隙（`wrap` / `below`），不改条的时间几何。
- **并立**：`claim_track` 分行，高度为正常行的 2/3，虚线描边 + 浅填，互不裁切。
- **相续泳道合并**（`dynasty_lane_groups` + `dynastyLaneGroups.ts`）：配置入库（包 `data/imports/dynasty-lane-groups/`），西周/东周、蒙古/元、吴政权/明/南明等压成一行；左侧冻结名与名牌金色都由泳道**中线**所在相位/是否有 `is_main=true` 的 reign 覆盖中线决定，不是以左缘为准。组的 lane-order span 不随视口收缩。
- **并存 cluster**（`dynasty_groups`）：三国、五胡十六国、南北朝、五代十国等各占一行、贴在一起套框。框的起止用组自己的 span，不被成员更早建国年撑大。
- **人物层**：无 reign 且有可核生卒的 `persons` 画在王朝行下方。皇帝不要再出现在人物栏。
- **详情**：右侧抽屉覆盖，不挤压泳道和标尺。点击帝王卡、事件、人物、左侧王朝名都走同一详情组件。
- **事件**：灰色横轴仍在视口内时，事件名必须可见（可钉在边缘），不能只剩一条匿名轴。

相关实现：`packages/shared/src/claimTracks.ts` 处理并立；`dynasty_groups` 处理同时并存的 cluster，组框使用组自身 span，成员仍各占一行；`dynasty_lane_groups` 处理前后相续的合并行，配置来自 `data/imports/dynasty-lane-groups/`，排序跨度不随视口变化。`ReignUncertaintyGap` 画年代失考边界，`ReignGapCard` 画史料缺框；两者与普通卡共用时间几何。人物搜索别名写 `persons.alt_names`，不维护运行时硬编码别名表。

## 正统金色

主线标记保存在 `reigns.is_main`。金色为主线 reign 的展示覆盖色；并立 track、`claim_role=rival` 不标主线。

- 大一统自起始即为正统：商周、东汉、西东晋、隋唐、武周、南北宋、明、中华民国、中华人民共和国。夏自启（家天下）始为正统，禹受禅不上金。
- 延迟起算：秦自前 221；西汉自刘邦称帝（前 202 年 2 月），沛公/汉王段不上金；清自 1644（福临），努尔哈赤、皇太极不上金；元自 1276 年 2 月宋恭帝降，忽必烈定国号至降宋前拆段非正统。
- 截断：隋金色可覆盖到 618 年末（江都杨浩）；元止于 1368（北逃后北元非正统）；南宋止于 1276 年 2 月（端宗、帝昺非正统）。
- 并立 track、主行 `claim_role=rival`（有穷代夏等非约定主线）、王莽/更始等不上金。魏蜀吴称帝前不建帝王卡。
- 左侧冻结名牌用与相位名相同的舞台中线 `labelAnchorAbs`：中线落在 `is_main=true` 的 reign 内则叠金，否则本色。

## 跨王朝命运线

`relations.kind ∈ killed | surrender | abdication | captured`，仅跨王朝。数据主包：`data/imports/cross-dynasty-fate/`。

- **语义**：帝王 A 被杀 / 投降 / 禅让 / 被俘于帝王 B。从 A 卡拉出虚线，在事件 `atAbs` 的时间刻度接到 B 卡。
- **端点**：`fromRef` 为 `person:` 或 `reign:`，`toRef` 必须为 `person:`。必须有 `atAbs`。同朝 succession 不画。
- **解析**：受害方取 `atAbs` 时在位，否则最近已结束的 reign；接收方取当时在位，否则 `atAbs` 后 24 个月内即将即位的 reign（禅让/降后称帝）。B 侧时间轴上无卡时，改挂当时在位君主，不硬画空对端。
- **几何**：共用 `layoutLaneReignBar`（含史料缺框）。`atAbs` 投影出的事件列是命运线唯一的纵向主轴；上下两端如与卡片锚点错列，只添加水平线连接 A 卡中线与 B 卡朝向边。接收方尚未即位时，禁止把纵向段推到接收方卡片起点；卡片只提供横向锚点，不改变事件列。颜色 = 源泳道本色。
- **覆盖预期**：有明确灭国/禅代对象的王朝，末代通常应有一条线。非末代被他朝杀死或俘虏（如楚怀王、晋惠公、齐湣王、晋怀帝、梁元帝、宋徽宗、陈友谅）同样画。无时间轴接收方（如吐蕃末代被僧人杀、回鹘亡于黠戛斯、南诏之后为大长和未收录、明英宗对瓦剌）则不画，并在 manifest notes 说明。
- **时间必须落在双方有效在位附近**。禁止把开国祖与百年后的亡国事件连在一起；`validateFateCatalogEntry` 会拦受害方 reign 结束过久的条目。

解析在 `packages/shared/src/reignFateRelations.ts`，布局在 `apps/web/src/features/timeline/model/reignFateLayout.ts`，绘制在 `ReignFateLayer`。导入条目需与事件及可考在位日期相互核对。

## 导入与 ID

新增或修复时期数据时，依 [eralens-period-import](.cursor/skills/eralens-period-import/SKILL.md) 的 generate → SQL → 校验流程操作；需要增量应用时使用该 Skill 的 `apply-sql.sh`。`pnpm db:import` 会按 manifest 窗口排序并重灌全部时期包。

- 大批量禁止手填 `*_abs`，用 `absMonth()` / `compute-abs.mjs`。
- 不要写入生成列 `span`。
- 不要跑 `pnpm db:seed` 覆盖真实库。
- `gold` 仅运行时覆盖，不要给王朝 `color_token = gold`；当前导入器用占位 token，展示色由 `buildStableLaneColorMap` 分配。
- Skill 与 `reference.md` 未列出的新枚举（如命运 kind、新色板）改 schema 时必须同步 skill、Zod、Prisma。

真实数据按时期放在 `data/imports/`：夏商周、春秋战国、秦汉、三国、两晋十六国、南北朝、隋唐五代、宋辽金夏、蒙古元明清、西南政权及近现代等各有时期包；跨王朝命运关系集中在 `cross-dynasty-fate/`。完整包清单以目录和 manifest 为准。
