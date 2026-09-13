---
name: eralens-period-import
description: >-
  为 EraLens 搜集指定历史时期数据，校验 AbsMonth 与 schema，生成完整 PostgreSQL
  INSERT/UPSERT 脚本并导入 Docker 数据库。Use when the user asks to collect historical
  period data, generate seed SQL, import dynasties/reigns/events into EraLens, or
  expand timeline coverage for a dynasty or era.
---

# EraLens 时期数据导入

将用户指定的历史时期（如「唐朝贞观」「北宋仁宗」）转为可执行的 SQL，写入 PostgreSQL。不要生成或更新 `data/seed/*.json`。

## 触发后先确认

向用户确认（缺省可推断）：

| 项 | 说明 |
|---|---|
| 时期 | 起止年/月，或朝代名 + 在位区间 |
| 深度 | `minimal`（王朝+主要皇帝+3–5 事件）/ `standard`（在位+年号+主要人物）/ `detailed` |
| 冲突策略 | `upsert`（默认，ON CONFLICT UPDATE）/ `skip-existing` |

## 工作流

```
Task Progress:
- [ ] 1. 调研：列出王朝、在位、人物、事件、关系及来源
- [ ] 2. 建模：分配 id、color_token、计算 start_abs/end_abs
- [ ] 3. 冲突检查：查询 DB 已有 id
- [ ] 4. 写 SQL：data/imports/{slug}/import.sql + manifest.json
- [ ] 5. 校验：node .cursor/skills/eralens-period-import/scripts/validate-import.mjs
- [ ] 6. 入库：scripts/apply-sql.sh
- [ ] 7. 验收：curl timeline/entity + 浏览器时间轴
```

### 1. 调研

- 用 WebSearch / 百科 / 正史条目搜集**可核对**的事实。通行年代框架（如夏商周断代工程、《史记》年表）优先于个人推算。
- 日期分清三种语义，不要把不确定年代写成精确到月的点事件：
  - **point**：发生时刻明确（或仅知年份）。填 `at_*`；月未知则 `precision: year`，月用 1 占位，界面不会显示「1 月」。
  - **span**：事件真实持续一段时间。填 `start_*` + `end_*`，`time_mode: span`。
  - **circa**：大约发生于某窗口（或诸说不一）。窗口填 `start_*` + `end_*`，`time_mode: circa`；学界常用估计可另填 `at_*`；原文说法写入 `date_note`。
- 王朝 / 在位月不确定：标 `precision: year`，用月初 / 月末占位。
- 收集完在位记录后，逐段核对王朝时间范围内的空档，不能仅凭相邻年份自动判定其含义：
  - 来源明确表明该期存在国君、但姓名或具体世次失载，才写一条系统缺失占位 reign。
  - 历史上确实无人统治该王朝行（改朝换号、中断、摄政期不设君等），不写 reign，前端自然留白。例如武周期间的唐行不写占位。
  - 只是本次导入深度不足或尚未搜集完整，必须继续查证/补齐，不能标成「史料缺」。
- 无实测或无通行王年（夏代、商前期常见）：只收关键人物，事件用 `circa` + `date_note`。禁止用传统积年填满每一王来「补齐」时间轴。
- 摄政、共和等非王时期建**事件**，不建 reign。
- **并立称君**（隋末三帝、南明鲁监国/绍武）留在同一王朝行，用 `claim_track` 分行同时显示，不要拆成多个王朝，也不要靠先后裁切卡片冒充「接位」：
  - 通行主线不填 `claim_track`（文帝→炀帝，弘光→隆武→永历）。
  - 并行政权填 `claim_track`（据点 kebab-case，如 `changan`、`lu-jian`）、`claim_label`（长安 / 绍兴监国）、`claim_role`（`puppet` 傀儡 / `rival` 对峙 / `regent` 监国）。
  - succession 只串主线，不把并行傀儡/监国串进继承链。
- 按用户字面范围收录：说「夏商周」只收三代王室，不自动展开春秋列国；同一王室可按习惯分期拆行（`zhou-west` / `zhou-east`，比照东汉）。
- 每条实体记录来源（URL 或书名卷页），写入 `manifest.json` 的 `sources`；争议取舍写入 `notes`。
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

`persons.name` 用可检索的常用名（禹、姬发、孔子、韦后）。**时间轴卡片主行显示 `persons.name`，因此君主姓名须带姓**（如莒郊公写 `己狂` 而非 `狂`，薛献公写 `任谷` 而非 `谷`）。维基诸侯表若只给「国君本名」，须结合该国姓氏（如莒己、滕姬、杞姒）补全；仅知谥号而本名失考时，可用 `{姓}{谥号}`（如 `姒武公`）。搜索只匹配 dynasty/person/event 的 `name`，不匹配 `title` 或谥号；谥号/庙号放 `title` + `preferred_appellation`。先秦角色用 `君主`/`天子`，不用 `皇帝`。年号自汉武帝起；先秦省略 `era_names`。

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

数十条以上的王世/事件：在 `data/imports/{slug}/` 写生成器调用同一 `absMonth()`，禁止手填 `*_abs`。

**枚举**（见 [reference.md](reference.md)）：

- `color_token`: cinnabar | mineral | ochre | indigo | moss | wisteria | grape | stone
- `precision`（王朝/在位）: year | month | day
- `event.precision`: day | month | year | decade | century
- `event.time_mode`: point | span | circa
- `event.kind`: battle | politics | culture | disaster | other
- `relation.kind`: succession | battle | alliance | other
- `scope`: cn（默认）| global

**不要写入生成列**：`dynasties.span`、`reigns.span`、`events.span*` 均由 DB 自动生成。

**国君资料缺失占位**：

- 先 UPSERT 系统人物：`id = 'system-missing-ruler'`、`name = '史料缺'`、`roles = ARRAY['系统占位']`。
- 缺失区间仍写入普通 `reigns` 表，`person_id = 'system-missing-ruler'`，`title = '史料缺'`，起止时间为查证后的缺失范围。
- 不添加年号、谥号、庙号或 preferred_appellation。
- 不增加 `missing` 字段、不建单独 gap 表。前端只根据保留的 `person_id` 将该 reign 渲染为虚线框。
- 没有占位 reign 的时间空档一律留白，不由前端自动推断为资料缺失。

### 3. 冲突检查

导入前查询已有 id：

```bash
docker exec eralens-postgres psql -U eralens -d eralens -c \
  "SELECT id FROM dynasties UNION ALL SELECT id FROM persons ORDER BY 1;"
```

新 id 不得与库中已有重复（除非 upsert 同一实体）。不要改 `data/seed/*.json`：那是 Mock / `pnpm db:seed` 用的样本，本 skill 只产出 SQL 并写入 PostgreSQL。

### 4. 生成 SQL

输出目录：`data/imports/{period-slug}/`

- `import.sql` — 完整可执行脚本
- `manifest.json` — 元数据（见 [reference.md](reference.md)）

**脚本结构**（顺序不可乱）：

1. `BEGIN;`
2. `persons`
3. `dynasties`
4. `reigns`
5. `era_names`（可选；先秦无年号则整步省略。有则按 reign_id + sort_order，DELETE 后 INSERT）
6. `events`
7. `event_dynasties`
8. `event_participants`
9. `relations`
10. `COMMIT;`

默认用 `INSERT ... ON CONFLICT (id) DO UPDATE SET ...`（persons/dynasties/reigns/events/relations）。连接表用 `ON CONFLICT DO NOTHING`。

模板与转义规则见 [reference.md](reference.md)；完整示例见 [examples.md](examples.md)。

### 5. 校验

```bash
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/{slug}/import.sql
```

必须通过后再入库。若失败，修复 SQL 并重跑。校验只看 INSERT **列名**里的生成列 `span`；`time_mode` 取值 `'span'` 合法。`era_names` 缺失不报错。

### 6. 入库

确保数据库已启动：`pnpm db:up`

```bash
.cursor/skills/eralens-period-import/scripts/apply-sql.sh data/imports/{slug}/import.sql
```

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

浏览器默认读 HTTP（数据库）。入库后若界面未更新，**硬刷新**（bounds 查询 `staleTime: Infinity`）。用搜索跳到朝代名或事件名，比拖标尺快。`Home` 跳到 `bounds.minAbs`（可能早于王朝始年，若有更早的 circa 事件）。若仍为 Mock 数据，检查 `VITE_DATA_SOURCE` 是否为 `http`。

确认：王朝行、在位卡片、事件标记出现；`circa` 淡色虚线带，`span` 细条，point 无虚假跨度。

## 质量要求

- 所有 `*_abs` 必须用 `compute-abs.mjs` 或 `absMonth()` 验算，禁止手填。
- 外键顺序：reign 引用的 person/dynasty 必须先存在。
- 事件时间字段：
  - `point`：`at_abs IS NOT NULL`
  - `span` / `circa`：`start_abs` 与 `end_abs` 均非空；circa 的 `at_abs` 可选（最佳估计）
- 不要用 `span` 去表示「大约何时」。持续用 `time_mode=span`，不确定用 `circa` + `date_note`。
- 中文名称用 UTF-8；SQL 字符串中单引号写 `''`。
- 对争议年代在 `manifest.json` 的 `notes` 与事件 `date_note` 说明取舍，不 silently 编造精确到月。
- 生卒不明则 `birth_*` / `death_*` 用 NULL，不要用正月占位冒充已知。

## 附加资源

- 列定义与 INSERT 模板：[reference.md](reference.md)
- 贞观示例：[examples.md](examples.md)
- 先秦大批量：`data/imports/xia-shang-zhou/`（generate.mjs → import.sql）
