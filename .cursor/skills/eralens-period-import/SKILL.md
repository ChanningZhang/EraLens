---
name: eralens-period-import
description: >-
  为 EraLens 搜集指定历史时期数据，校验 AbsMonth 与 schema，生成完整 PostgreSQL
  INSERT/UPSERT 脚本并导入 Docker 数据库。Use when the user asks to collect historical
  period data, generate PostgreSQL import SQL, import dynasties/reigns/events into EraLens, or
  expand timeline coverage for a dynasty or era.
---

# EraLens 时期数据导入

所有日期录入、精度、历法和置信度以 [eralens-date-handling](../eralens-date-handling/SKILL.md) 为准；本 Skill 负责包级数据流程与继位上下文。

将用户指定的历史时期（如「唐朝贞观」「北宋仁宗」）转为可执行的 SQL，写入 PostgreSQL。不要生成或更新 `data/seed/*.json`。

真实导入包以 `data/imports/{slug}/cache.json` 为唯一记录源，来源与处理说明直接写在 `cache.json.manifest.sources` / `cache.json.manifest.notes`。已核定数据直接写进缓存；不要新增包级 `.mjs`、Wiki 抓取/加工脚本或按朝代修补代码。唯一生成入口是 `node data/imports/generate.mjs {slug}`；它只把缓存序列化为 `import.sql` 和 `manifest.json`，不补年份、不改称谓、不解析 Wiki。生成产物不手工编辑。

单项任务优先使用专门 Skill：添加或丰富事件见
[eralens-event-import](../eralens-event-import/SKILL.md)，添加或丰富在位信息见
[eralens-reign-import](../eralens-reign-import/SKILL.md)，添加都城或事件地点见
[eralens-geography-import](../eralens-geography-import/SKILL.md)。本 Skill 负责跨实体的完整时期包。

## 来源维护

- 每次新增、丰富或修复历史数据，都必须同步核对并更新来源，确保来源支持本次新增或改动的事实。
- 在记录所属包的 `cache.json.manifest.sources` 维护实际采用的来源；已有来源仍适用时保留，新增依据补入，错误或已不适用的引用修正或移除。争议与取舍写入 `manifest.notes`，`manifest.json` 由统一生成器更新。
- 对有 `links` 字段的条目（人物、都城、事件地点），同步更新记录的 `links: [{ label, url }]`，使用可核对的来源名称与直接页面链接。人物/在位详情的“来源”栏读取对应 person 的 `links`，都城详情读取 capital 的 `links`；不能只更新包级 `manifest.sources` 而遗漏详情来源。
- 导入后核对 API 返回的来源与详情抽屉“来源”栏，确认本次采用的来源已展示，标签、链接与对应事实一致。

## 触发后先确认

向用户确认（缺省可推断）：

| 项 | 说明 |
|---|---|
| 时期 | 起止年/月，或朝代名 + 在位区间 |
| 深度 | `minimal`（王朝+主要皇帝+3–5 事件）/ `standard`（在位+年号+主要人物）/ `detailed` |
| 冲突策略 | `upsert`（默认，ON CONFLICT UPDATE）/ `skip-existing` |

### 事件收集口径

事件层不是王朝泳道的旁白。收录前先问：**如果只看王朝泳道、在位卡片和都城数据，这条信息是否仍然不可知？** 如果答案是否定的，就不新增事件。

默认不收录：

- 某王朝取代前一王朝的常规事件（如「南齐代宋」「南梁代齐」「朱温篡唐」）；
- 普通建国、改国号、称帝、禅让、皇帝即位或退位；
- 已由王朝起止、reign 接续、claim track 或都城记录表达的普通边界变化；
- 只是把某位皇帝的生平换一种说法重复一遍的事件。

优先收录：

- 泳道无法表达的疆域割让、收复、边界重划和长期控制权变化；
- 跨政权同盟、和约、会盟等改变长期关系的节点；
- 泳道无法表达的政治象征、制度转折或社会结构变化；
- 少数特别重大的统一、分裂或战争转折，即使泳道能够间接看出（例如「秦统一中国」「隋灭陈统一」）。

一个事件可以改变王朝归属，但若其价值只是说明「A 代替 B」，仍不收录；只有同时表达疆域、国际关系、制度或特别重大的历史结构变化时才保留。成组事件应拆成各自具有独立信息的节点，不用一个「某地全部收复」概括分期复杂的割让与反复易手。

## 工作流

```
Task Progress:
- [ ] 1. 调研：列出王朝、在位、人物、事件、关系及来源
- [ ] 2. 将已核定记录直接写入 `data/imports/{slug}/cache.json`（计算 `start_abs/end_abs`，不写缓存加工脚本）
- [ ] 3. 冲突检查：查询 DB 已有 id
- [ ] 4. 运行统一生成器，输出 PostgreSQL `import.sql` 并刷新 `manifest.json`
- [ ] 5. 校验：`node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/{slug}/import.sql`
- [ ] 6. 入库：scripts/apply-sql.sh
- [ ] 7. 验收：curl timeline/entity + 浏览器时间轴
```

缓存采用 camelCase 字段；日期以 `{ year, month, day?, abs, confidence }` 结构保存。人物、王朝、在位、事件和关系分别放在顶层数组中。都城与事件地点使用 `capitals` / `eventLocations` 等缓存集合；来源说明位于同一个文件的 `manifest` 对象内。SQL 列名由共享序列化器映射。包结构、示例和完整生成命令见 [`data/imports/README.md`](../../../data/imports/README.md)。

### 1. 调研

- 用 WebSearch / 百科 / 正史条目搜集**可核对**的事实。通行年代框架（如夏商周断代工程、《史记》年表）优先于个人推算。
- 日期精度、历法、confidence 与事件 point/span 规则遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。年精度 point 的月占位及年桶位置也以该 Skill 为准。
- **年精度顺序继位切年**（先秦通行，与英文维基国王表 / 逾年改元一致；按以下规则核定后，将最终日期直接写入 `cache.json`）：
  - **死年整年归旧王**，新王从**下一年**起算。维基「在位年份」常把死年同时写作新王起年（如秦文公「前766年－前716年」叠在襄公卒年），时间轴按年桶绘制时不要把这一年画成两人并立。
  - 不要把公历 1 月 1 日当成即位日；1–12 月只是年桶占位。中国年本身也不是公历元旦起算。
  - 切年检测必须用维基/来源的**原始起迄年**，不要在已经后移的前王上再判断（否则秦孝文王占死后，庄襄王会停在死年）。同一人改元续任（魏惠王称王）先合并为一条在位，再切年。
  - **例外（保持同年，不后移）**：
    1. 短祚只存在于该死年（一年实录，如公孙无知、卫戴公、周哀王/思王）；
    2. 史料写明**未逾年改元**（秦灵公、秦简公、秦献公）；
    3. 真正并立 / 旁支（`claim_track`、曲沃与翼）；
    4. 同年内有可核时长（史记「立三月」）→ 按月切开该年，confidence 仍为 `year`，不冒充历月。
  - 田氏代齐是姜齐之后的**顺序接续**，不是并立。田和称君取前391年自立；齐国表前404年是田悼子卒后的田氏领袖年，不要与康公画成同年并立。
  - 月/日有史料则用月日，不再套这条年桶规则。身后才立的并行对手（如携王相对幽王）与正统次年改元对齐（携王起年与平王同为前770），不要从前王死年正月画起。
- **所有精度的相邻边界**：在位、都城以及其他有先后接续关系的时间段，对象归属统一调用 `@eralens/shared` 的 `timelineOwnership.ts`；其底层 `timelineIntervals.ts` 按 year/month/day 精度转成日历日比较，支持精度不同的前后记录及同一记录起止边界采用不同精度。重叠部分归较早记录，后记录从旧记录终点后的第一天开始。分组规则也集中在归属入口，生成器、布局、查询、详情关联不得复制对象分组、边界比较或手写年/月偏移。真正并立的君主、不同都城/角色等可共存记录要保留为并行区间，并用 `claim_track` 或实体语义分组区分。
- 收集完在位记录后，逐段核对王朝时间范围内的空档，不能仅凭相邻年份自动判定其含义：
  - 来源明确表明该期存在国君、但姓名或具体世次失载，才写一条系统缺失占位 reign。
  - 历史上确实无人统治该王朝行（改朝换号、中断、摄政期不设君等），不写 reign，前端自然留白。例如武周期间的唐行不写占位。
  - 只是本次导入深度不足或尚未搜集完整，必须继续查证/补齐，不能标成「史料缺」。
- **君主有世系、仅部分在位年可考**：共同锚点、连续世系均分和端点 confidence 遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。已知某段确有君主而姓名失载时，依“史料缺”规则用占位 reign，不要把它误当作无国君空白。
- 无实测或无通行王年（夏代、商前期常见）：遵循上一条先找共同锚点和连续世系；仅当缺少可交叉验证的起讫锚点、世系有断层或只能依传统积年推算时，才只收关键人物，事件按日期处理 Skill 记录有依据的 point/span 与 confidence，不得跨断层补满君主。
- 摄政、共和等非王时期建**事件**，不建 reign。
- **并立称君**（隋末三帝、南明鲁监国/绍武）留在同一王朝行，用 `claim_track` 分行同时显示，不要拆成多个王朝：
  - **判定并列只看是否「同时另立」**，与是否权臣拥立无关。
  - **并行 `claim_track`**：在前任**仍在位**时，或与之**同年分立**的另一政权另立皇帝——如炀帝尚在时的杨侑/杨侗、南明鲁监国/绍武与弘光/隆武并存。填 `claim_track`（据点 kebab-case，如 `changan`、`lu-jian`）、`claim_label`（长安 / 洛阳 / 绍兴监国）。并行卡片统一并立虚线描边，`claim_role` 固定 `rival`。
  - **主线（不填 `claim_track`）**：前帝**身后**才即位，哪怕实为权臣傀儡，仍算**继任**，接在前帝继承链之后——如文帝→炀帝→弑帝后杨浩续统。不要用裁切卡片把继任硬接在前帝尾巴上冒充同时并存。
  - 通行主线 succession 只串不填 track、且无 `claim_role=rival` 的君主（文帝→炀帝，弘光→隆武→永历）；并行 track 内的君主彼此可串，但不与主线混链。
  - 正统金色只覆主线。炀帝尚在时被拥立的杨侑不镀金；弑帝后的江都续统（杨浩）走主线。先后代政、不入正统世次的君主（有穷后羿/寒浞）走主行串行，不填 `claim_track`；标 `claim_role=rival`，不上金、不串进通行继承链，二人之间可另写 succession。
- 按用户字面范围收录：说「夏商周」只收三代王室，不自动展开春秋列国；同一王室可按习惯分期拆行（`zhou-west` / `zhou-east`，`wei-east` / `wei-west`，比照东汉）。东魏、西魏虽仍用国号魏，通行史书作独立北朝王朝，各占一行，不用把孝静帝/西魏诸帝留在北魏 `claim_track`。
- 每条实体记录来源（URL 或书名卷页），写入 `cache.json.manifest.sources`；争议取舍写入 `cache.json.manifest.notes`。`manifest.json` 是统一生成器输出的文件。
- 只收录与**指定时期窗口相交**的实体；长跨度王朝（如唐）可只补窗口内在位与事件，勿重复插入已存在的完整王朝行（用 upsert 更新或跳过）。
- **非帝王人物**（`persons`，不建 `reign`）与君主同等重要，按深度收录：
  - **standard / detailed**：除主要皇帝外，应补**影响政局或广为检索**的非君主——名臣、名将、诗人学者，以及**后宫/宗室政治人物**（如吕后、韦后、太平公主、上官婉儿）。
  - 若某皇帝 `bio` 或事件已点名某人（如「韦后乱政」），必须为其建 `person`，不可只在文本里提及。
  - 后宫/宗室人物：`roles` 用 `皇后` / `后妃` / `公主` 等身份标签，若实际干政再加 `政治家`；**不**用 `皇帝` / `君主`。
  - `name` 用通行检索名（韦后、吕后、太平公主）；本名可写在 `bio`，维基链接仍指向条目全名。
  - `id` 优先 `{姓拼音}-{名/通称拼音}`（`lv-zhi`、`wei-hou`）；通称固定时可用 `{family}-hou` / `{family}-gongzhu`。
  - 生卒能核对则填 `birth_*` / `death_*`（时间轴人物层需要）；仅知卒年或生年可只填一侧，其余 `NULL`。

### 2. 建模规则

**ID 约定**（kebab-case，英文或拼音）：

- 王朝 `{name}`：`tang`、`song-north`、`zhou-west`
- 人物 `{family}-{given}`：`li-shimin`、`ji-fa`。先查库中已有 id（`zhou-yu` 已是周瑜）。
- 后宫/宗室通称人物：`wei-hou`（韦后）、`pingyang-gongzhu`（平阳公主）；与 `{family}-{given}` 并存，以库内无冲突为准。
- 在位 `reign-{person}` 或 `reign-{person}-{ordinal}`
- 经查证的缺失占位 `reign-missing-{dynasty}-{start-year}`，其 `person_id` 固定为 `system-missing-ruler`
- 事件 `{topic}`：`xuanwumen`、`muye`
- 关系 `rel-{from}-{to}-{kind}`

`persons.name` 使用常用姓名。先秦人物若姓、氏分别写在 `ancestralXing` / `clanShi`，`name` 只存私名/常用名，不拼姓或氏（如莒郊公存 `狂`，不存 `己狂`；未知姓名存 `？`，不拼姓氏）。其他时期保留通行可检索全名。时间轴卡片在始皇帝以前主行显示谥号/称号，由 `resolveReignCardLabel` 处理，不要为迁就卡片去改姓名字段。先秦王朝/人物须在 `cache.json` 直接写入 `ancestralXing` / `clanShi`；生成器和运行时不套姓氏默认表。常用称呼与人工别名仍写 `persons.alt_names`；数据库会把姓名、别名、姓/氏组合、庙谥、reign title、朝代名 + 庙谥预生成到 `persons.search_terms`，因此移除 `name` 中的姓氏不会丢失姓氏检索。

**人物搜索词与索引（强制）**：

- `persons.search_terms` 是预计算的标准化 `text[]`，用于完整词命中；API 使用数组包含查询，依赖 `persons_search_terms_gin_idx`，禁止在请求时遍历全量 person/reign/dynasty 临时拼词。
- 搜索词包括：`name`、`alt_names`、按结构化 `ancestral_xing` / `clan_shi` 生成的姓+名/氏+名、`posthumous_name`、`temple_name`、人物关联的 `reigns.title`，以及关联王朝 `name` / `alt_names` + 庙号或谥号（如 `唐太宗`、`唐文皇帝`）。不要把带朝代的组合词写回庙谥字段。
- `name`、`alt_names`、`ancestral_xing`、`clan_shi`、`posthumous_name`、`temple_name` 发生变化，或关联 reign 的 `person_id` / `dynasty_id` / `title`、王朝 `name` / `alt_names` 发生变化后，必须刷新 `search_terms`。数据库触发器会自动刷新受影响人物。
- 大批量脚本改写人物、在位或王朝相关字段后，必须显式执行 `SELECT rebuild_person_search_terms();` 全量重建搜索词并抽查目标人物。更新 `search_terms` 时 PostgreSQL 会自动维护 GIN 条目；正常数据变更禁止额外执行锁表的 `REINDEX`，只有索引损坏时才物理重建。
- `personSql` 不手填 `search_terms`；继续写结构化来源字段，由数据库统一派生，避免各导入包算法漂移。

**谥号 / 庙号 / 年号字段**（与商周一致）：
- **谥号、庙号**写在 `persons.posthumous_name` / `persons.temple_name`（逗号分隔 CSV，同人多值按在位顺序）；卡片取第一个，详情用 `、` 展示全部。
- **年号**写在 `reigns.era_names`（逗号分隔完整名称列表，如 `泰定,致和`）；不再使用 `era_names` 子表，各年号起迄年月不入库。该列用于事实展示和检索，不参与运行时称呼选择。
- 泳道卡片优先展示非空 `reigns.title`；人物详情页按年代优先展示庙谥，只有庙谥缺失时才回退 title。明清皇帝用于泳道卡片展示的年号式称呼须在导入时直接写入 `reigns.title`；生成器和运行时都不从 `era_names` 挑选称呼。朱元璋吴王段（`吴`）、努尔哈赤（`太祖`）、皇太极（`太宗`）保留原称号例外。人物详情按年代取庙谥：唐代起（包括明清）庙号优先于谥号，唐以前谥号优先。
- 字段只存谥号/庙号本体，**不带国名或王朝前缀**（如 `武王`、`孝文皇帝`、`太宗`；不要写 `周武王`、`汉孝文皇帝`、`唐太宗`）。
- **史称**（少帝/废帝/末帝/后主等）写在 `title`，**不得**写入 `posthumous_name`。
- 国名 + 简称写在 `title`（如 `周武王`、`唐太宗`、`后唐庄宗`），明清年号式泳道卡片称呼也预存于 `title`。运行时 `resolveEmperorAppellation` 仅按唐代阈值选择人物庙号/谥号，并在两者均缺失时回退到 `title`；不会从 `title` 推测庙谥。
- 若 `title` 已含国号简称（`唐肃宗`、`吴越武肃王`），须在 `cache.json` 对应 **person** 记录上直接写出无国号的庙谥 CSV（`肃宗`、`武肃王`）；庙谥不在生成阶段从 reign 合并。
- 无谥号的先秦/regnal 称号直接写入 `reigns.title` 的**不带国名本体**（`若敖`、`夫差`、`王厝`、`禹`）；在 `cache.json` 直接维护不带国名的 `reigns.title`。
- `persons.name` 入库即为可展示私名（不带维基「原名/后改名」残渣）；古文异体可留在 `bio`。

先秦角色用 `君主`/`天子`，不用 `皇帝`。年号自汉武帝起，写入 `reigns.era_names`；先秦省略该列（NULL）。

**非帝王人物 roles 示例**（可多选）：`政治家`、`军事家`、`诗人`、`文学家`、`史学家`、`科学家`、`将领`、`起义领袖`、`皇后`、`后妃`、`公主`、`宗室`、`高僧`、`学者`、`医学家` 等。干政后妃/太后/公主：`ARRAY['皇后','政治家']` 或 `ARRAY['公主','政治家']`。

**AbsMonth**（必须与 `@eralens/shared` 一致）：

```text
absMonth(year, month) = toAstroYear(year) * 12 + (month - 1)
toAstroYear(year) = year > 0 ? year : year + 1   // 公元前 221 → year -221，astro -220
```

日历年公元前用**负数**写入 `*_year`。验算：

```bash
node .cursor/skills/eralens-period-import/scripts/compute-abs.mjs 627 1     # 7524
node .cursor/skills/eralens-period-import/scripts/compute-abs.mjs -2070 1  # -24828
node .cursor/skills/eralens-period-import/scripts/compute-abs.mjs -1046 1  # -12540
```

批量核算 `*_abs` 时使用同一 `absMonth()` 定义或 `compute-abs.mjs`；把核定结果直接写入缓存。不要为导入包增加生成/加工脚本，也不要让生成器推算或改写这些值。

**枚举**（见 [reference.md](reference.md)）：

- `color_token`：入库占位 `ochre`；运行时 24 色见 reference.md（前端分配，导入勿轮换）
- 日期 confidence 与历史日期结构：见 [日期处理 Skill](../eralens-date-handling/SKILL.md)
- `event.time_mode`: point | span
- `event.kind`: battle | politics | culture | disaster | commerce | agriculture | finance | idiom | poetry | other
- `relation.kind`: succession | battle | alliance | enthronement | other | killed | surrender | abdication | captured
- `scope`: cn（默认）| global

**不要写入生成列**：`dynasties.span`、`reigns.span`、`events.span*` 均由 DB 自动生成。

**国君资料缺失占位**：

- 先 UPSERT 系统人物：`id = 'system-missing-ruler'`、`name = '史料缺'`、`roles = ARRAY['系统占位']`。
- 缺失区间仍写入普通 `reigns` 表，`person_id = 'system-missing-ruler'`，`title = '史料缺'`，起止时间为查证后的缺失范围。
- 不添加年号、谥号、庙号（`title` 保持 `史料缺`）。
- 不增加 `missing` 字段、不建单独 gap 表。前端只根据保留的 `person_id` 将该 reign 渲染为虚线框。
- 没有占位 reign 的时间空档一律留白，不由前端自动推断为资料缺失；统一生成器不会根据相邻君主间隔自动插入 `reign-missing-*`，缓存中必须显式列出经核实的占位记录。

**在位年失考 / 推算边界**遵循 [日期处理 Skill](../eralens-date-handling/SKILL.md) 的端点 confidence 与插值依据要求。历史空白仍须先区分史料缺、无国君与年代失考；只有日期处理 Skill 规定的可靠锚点和连续世系可用于世次均分。数据库兼容旧列在迁移验收前保留。

### 3. 冲突检查

导入前查询已有 id：

```bash
docker exec eralens-postgres psql -U eralens -d eralens -c \
  "SELECT id FROM dynasties UNION ALL SELECT id FROM persons ORDER BY 1;"
```

新 id 不得与库中已有重复（除非 upsert 同一实体）。不要改 `data/seed/*.json`：那是 Mock / `pnpm db:seed` 用的样本，本 skill 只产出 SQL 并写入 PostgreSQL。

### 4. 从缓存生成 SQL

唯一事实源是 `data/imports/{period-slug}/cache.json`；史料来源和取舍也记入该文件内的 `manifest.sources` / `manifest.notes`。目录中的 `import.sql` 和 `manifest.json` 都是生成产物，不要直接维护。

运行统一入口：

```bash
node data/imports/generate.mjs {slug}
```

这会从 `cache.json` 序列化 PostgreSQL `import.sql` 和 `manifest.json`；清点后同步维护缓存内 `manifest.counts` / `manifest.generatedAt`。全量重新生成：`node data/imports/generate.mjs --all`。每个包不再有自己的生成器；序列化规则只维护在 `data/imports/lib/sqlHelpers.mjs`。

**统一生成器输出顺序**（不要手写或在包里另造这条序列化逻辑）：

1. `BEGIN;`，然后执行 `preSql` 中的旧库清理
2. `persons`、`dynasty_groups`、`dynasties`
3. `dynasty_capitals`、`dynasty_lane_groups`
4. `reigns`（含 `era_names` CSV）与 `reign_capitals`
5. `events`、`event_dynasties`、`event_participants`
6. `relations`、`event_locations` 及缓存显式列出的更新
7. 执行 `postSql` 中的旧库清理，再 `COMMIT;`

默认用 `INSERT ... ON CONFLICT (id) DO UPDATE SET ...`（persons/dynasties/reigns/events/relations）。连接表用 `ON CONFLICT DO NOTHING`。

SQL 列映射示例见 [reference.md](reference.md)；数据录入请以 `cache.json` 结构为准，不能把 SQL 示例当作手写源文件。

### 5. 校验

导入包新增或修改王朝名、人物名、称谓、庙号或谥号后，先检查时间轴衬线字体子集是否覆盖这些字形：

```bash
# 只检查当前导入包
node .cursor/skills/eralens-period-import/scripts/check-timeline-font-coverage.mjs {slug}

# 不带 slug 时检查所有导入包
node .cursor/skills/eralens-period-import/scripts/check-timeline-font-coverage.mjs
```

检查器读取 `cache.json` 中的王朝名、人物名/称谓、谥号/庙号和在位称号，与 `apps/web/src/design/timelineSerifFont.css` 的 `unicode-range` 及其字体文件核对。若列出缺字，需把缺失字形加入 `EraLens Lane Serif` 的 WOFF2 子集及对应 CSS 声明，再运行检查器确认通过；新增王朝或人物不能仅因现有字体文件已打包就视为覆盖。

```bash
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/{slug}/import.sql
```

必须通过后再入库。校验会检查 SQL 结构，并读取同目录 `cache.json` 校验在位接续边界；若失败，回到缓存修正后重新生成，再重跑校验。它只看 INSERT **列名**里的生成列 `span`；`time_mode` 取值 `'span'` 合法。禁止再写 `era_names` 表或 `reigns.posthumous_name`/`temple_name`。

### 6. 入库

确保数据库已启动：`pnpm db:up`。单包增量导入前运行 `node data/imports/generate.mjs {slug}`、校验后用 `apply-sql.sh`；全量 `pnpm db:import` 前运行 `node data/imports/generate.mjs --all`，因为 db:import 本身不会从缓存生成 SQL。

```bash
.cursor/skills/eralens-period-import/scripts/apply-sql.sh data/imports/{slug}/import.sql
```

上面是单包增量导入。`pnpm db:import` 会清空并重载本地 PostgreSQL 的真实数据包，随后从 PostgreSQL 构建并校验移动端 SQLite 数据库；不要把它当作 Xcode 启动时执行的脚本。Xcode 使用已导出的 SQLite 文件。导入包本身只生成 PostgreSQL `import.sql`。

导入后若时间轴出现君主卡片上下叠放，运行去重脚本清理旧版 import 残留的孤儿记录：

```bash
node .cursor/skills/eralens-period-import/scripts/dedupe-database.mjs --dry-run
node .cursor/skills/eralens-period-import/scripts/dedupe-database.mjs
```

连接串默认 `postgresql://eralens:eralens@localhost:5432/eralens`（与 `apps/api/.env` 一致）。不要跑 `pnpm db:seed`：它会清空表再灌 JSON，冲掉本次 SQL 导入。

### 7. 验收

```bash
# from/to 是 AbsMonth；公元前为负数（夏初约 -24828）
curl -s "http://localhost:3001/api/timeline?from=START&to=END&scope=cn" | jq '.dynasties[].name,.reigns[].title,.events[].name'
curl -s "http://localhost:3001/api/bounds"
```

浏览器默认读 HTTP（数据库）。入库后若界面未更新，**硬刷新**（bounds 查询 `staleTime: Infinity`）。用搜索跳到朝代名或事件名，比拖标尺快。`Home` 跳到 `bounds.minAbs`（可能早于王朝始年，若有更早的 approximate point）。若仍为 Mock 数据，检查 `VITE_DATA_SOURCE` 是否为 `http`。

确认：王朝行、在位卡片和事件标记出现；point 显示时点，span 显示真实持续过程，近似和插值按各端点 confidence 展示。

## 质量要求

- 所有 `*_abs` 必须用 `compute-abs.mjs` 或 `absMonth()` 验算，禁止手填。
- 外键顺序：reign 引用的 person/dynasty 必须先存在。
- 事件时间字段：
  - `point`：`at_abs IS NOT NULL`
- `span`：`start_abs` 与 `end_abs` 均非空；point 必须有 `at_abs`。
- 事件只用 point/span；不确定性写入各日期端点 confidence，原起止说明保留在 `date_note`。
- 中文名称用 UTF-8；SQL 字符串中单引号写 `''`。
- 对争议年代在 `cache.json.manifest.notes` 与事件 `dateNote` 说明取舍，不 silently 编造精确到月。
- 生卒不明则 `birth_*` / `death_*` 用 NULL，不要用正月占位冒充已知。
- 人物、在位等记录写入 `cache.json`；所有 SQL 统一由 `data/imports/lib/sqlHelpers.mjs` 序列化，禁止在导入包里调用模板另造生成路径。
- 修改人物、reign 归属/称号或王朝名称后，确认 `persons.search_terms` 已由触发器刷新；批量更新后运行 `SELECT rebuild_person_search_terms();` 并验证 GIN 查询。
- `isMain` 等事实标记直接维护在 `cache.json`；相续泳道组记录维护在 `data/imports/dynasty-lane-groups/cache.json`，再用统一生成器生成 SQL。

## 成语典故（`data/imports/idioms/`）

成语单独成包，不与王朝/在位包混写。

- **入库形态**：`events.kind = idiom`，`time_mode = point`（禁止 span）；`at_*` 决定时间轴 marker 位置；`meaning` 存释义，`summary` 存典故。
- **关联**：
  - 故事发生国 / 背景王朝 → `event_dynasties`
  - 典故人物 → `event_participants.person_id`，**只能写 `persons.id`**
  - **禁止**写 `reign` id、禁止在 `relations` 中挂 `reign:*`
  - 国君引用各时期包已入库的 person id（如 `gou-jian`、`qi-r25`），不要写 `reign-gou-jian-*`
  - 库内尚无的人物由 idioms 包 `upsert`（蔺相如、荆轲等）
- **史事对照**：有明确对应 battle/politics 事件时，用 `relations` 从成语 `event:idiom-*` 指向已有 `event:*`（`kind: other`），不写 reign 端点。
- **展示语义**：成语详情关联 person；person 详情关联成语；reign 详情**不**因 person 间接列出成语。时间轴上成语只按 `at_abs` 画点。

生成：`node data/imports/generate.mjs idioms` → `import.sql` + `manifest.json`。

## 附加资源

- 列定义与 INSERT 模板：[reference.md](reference.md)
- 贞观示例：[examples.md](examples.md)
- 先秦大批量：`data/imports/xia-shang-zhou/`（统一生成器 → PostgreSQL SQL）
