# EraLens 导入参考

## 当前数据源与文件格式

日期统一遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。缓存中的日期为 `{ year, month, day?, abs, confidence }`；每个端点分别记录八类 confidence 之一。其余缓存结构和来源维护方法见下方；日期规则不在本参考重复定义。

缓存示意（省略非必要字段）：

```json
{
  "slug": "example-period",
  "window": { "startYear": 626, "startMonth": 1, "endYear": 649, "endMonth": 12 },
  "persons": [{ "id": "li-shimin", "name": "李世民", "dynastyId": "tang", "title": "唐太宗", "posthumousNames": ["文武皇帝"], "templeNames": ["太宗"] }],
  "dynastyGroups": [],
  "dynasties": [{ "id": "tang", "name": "唐", "start": { "year": 618, "month": 6, "abs": 7421, "confidence": "month" }, "end": { "year": 907, "month": 5, "abs": 10888, "confidence": "month" } }],
  "locations": [],
  "locationMappings": [],
  "reigns": [{ "id": "reign-li-shimin", "dynastyId": "tang", "personId": "li-shimin", "title": "唐太宗", "start": { "year": 626, "month": 9, "abs": 7520, "confidence": "month" }, "end": { "year": 649, "month": 7, "abs": 7794, "confidence": "month" }, "startAbs": 7520, "endAbs": 7794, "eraNames": ["贞观"], "isMain": true }],
  "events": [{ "id": "example-event", "name": "示例事件", "kind": "politics", "timeMode": "point", "at": { "year": 627, "month": 12, "abs": 7535, "confidence": "year" } }],
  "relations": [],
  "manifest": { "slug": "example-period", "title": "示例时期", "generatedAt": "2026-09-27", "counts": { "persons": 1, "dynasties": 1, "reigns": 1, "events": 1 }, "sources": [], "notes": [] },
}
```

正常录入只改这些缓存记录及 `manifest`。生成器按缓存中的 manifest 输出计数、来源和说明；不得添加 `preSql` / `postSql`、`updates` 或 `dynastyMerges` 增量指令。实体合并应直接维护最终记录与所有引用。生成与导入步骤见 [时期数据导入 Skill](./SKILL.md) 和 [数据包说明](../../../data/imports/README.md)。

## 生成的 manifest.json 格式

```json
{
  "slug": "tang-zhenguan",
  "title": "唐太宗贞观年间",
  "window": { "startYear": 627, "startMonth": 1, "endYear": 649, "endMonth": 7 },
  "scope": "cn",
  "depth": "standard",
  "generatedAt": "2026-09-12",
  "counts": { "persons": 2, "dynasties": 1, "reigns": 1, "events": 2, "relations": 1 },
  "sources": [
    { "label": "维基百科", "url": "https://zh.wikipedia.org/wiki/贞观之治" }
  ],
  "notes": ["年精度顺序继位：死年归旧王、新王次年起算；未逾年改元与一年短祚除外"]
}
```

## 表与主键

| 表 | 主键 |
|---|---|
| persons | id |
| dynasty_groups | id |
| dynasties | id |
| reigns | id |
| locations | id（集中地点包唯一维护） |
| location_mapping | id |
| events | id |
| entity_associations | (a_type, a_id, b_type, b_id)，唯一维护包 entity-associations |
| relations | id |

事件日期列：`time_mode`（point/span）、`at_confidence` / `start_confidence` / `end_confidence`、`date_note`（可选）。日期精度只由每个端点的 confidence 表达；空间定位的 `location_mapping.spatial_precision` 单独保留。

`events.kind` 支持 `battle`、`politics`、`culture`、`disaster`、`commerce`、`agriculture`、`finance`、`idiom`、`poetry`、`other`。`commerce` 表示贸易制度、通商格局与重要商品传播事件，界面标签为「商业」；`finance` 表示货币、银行与财政制度转折，界面标签为「金融」。新增 kind 时同步更新 `packages/shared/src/schema.ts`、共享标签函数、界面样式与本节枚举。

- `point`：`at_*` 及单独的 `at_confidence`
- `span`：`start_*` + `end_*` 及独立端点 confidence，仅用于真实持续过程

### 日期相关 SQL 列模板

统一生成器按端点输出这些日期列；未出现的年月日仍为 `NULL`。数据库已删除旧日期精度列；新数据不得再写入这些字段。

| 实体 | 新日期列 |
|---|---|
| `persons` | `birth_year/month/day`, `birth_confidence`, `death_year/month/day`, `death_confidence` |
| `dynasties`, `dynasty_groups` | `start_year/month/day`, `start_confidence`, `end_year/month/day`, `end_confidence` |
| `reigns` | `start_year/month/day`, `start_confidence`, `end_year/month/day`, `end_confidence` |
| `location_mapping`（dynasty/reign） | `start_year/month/day`, `start_confidence`, `end_year/month/day`, `end_confidence` |
| `events` | point 用 `at_year/month/day`, `at_confidence`；span 用独立 `start_*` / `end_*` 与对应 confidence |
| `relations` | `at_year/month/day`, `at_confidence` |

SQL 模板不得使用已删除的日期精度列。以下 SQL 片段只示意其他列的映射，不能据其省略的新日期字段手写真实导入 SQL。

## 生成 SQL 的列映射示例（不是数据录入格式）

以下 SQL 仅说明缓存字段如何映射到数据库列，不能作为源文件编辑。需要新增/修复数据时改上方所示 `cache.json`，再运行统一生成器。

### persons

生卒不明时年月日填 `NULL`，不要用正月占位冒充已知。

```sql
INSERT INTO persons (
  id, name, dynasty_id, alt_names, ancestral_xing, clan_shi,
  birth_year, birth_month, death_year, death_month,
  roles, bio, links, posthumous_name, temple_name, title
)
VALUES (
  'li-shimin',
  '李世民',
  'tang',
  ARRAY[]::text[],
  NULL, NULL,
  598, 1, 649, 7,
  ARRAY['皇帝','军事家'],
  '唐太宗，开创贞观之治。',
  '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李世民"}]'::jsonb,
  '文武皇帝', '太宗', '唐太宗'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  dynasty_id = EXCLUDED.dynasty_id,
  alt_names = EXCLUDED.alt_names,
  ancestral_xing = EXCLUDED.ancestral_xing,
  clan_shi = EXCLUDED.clan_shi,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  title = EXCLUDED.title;
```

检索别名（如 `lv-shang` → `姜子牙`）写入 `alt_names`，不要在前端或 shared 维护硬编码映射。`search_terms` 不写进 INSERT；数据库触发器根据人物字段、关联 reign 与王朝统一生成。

`persons.dynastyId` 保存人物主要所属王朝，适用于君主和非君主人物；无可靠的单一归属时留空。新增或修改人物归属时在所属包的 `cache.json` 填写该字段。打开人物详情时按 `dynastyId` 实时读取王朝 `altNames[0]`，不从 `reign` 推导人物归属。

人物相关字段、reign 的人物/王朝归属或称号、王朝名称发生变化时，触发器会刷新对应 `persons.search_terms`，GIN 索引随行更新自动维护。批量 SQL 改写后必须执行：

```sql
SELECT rebuild_person_search_terms();
```

完整词查询使用数组包含操作符以命中 GIN：

```sql
SELECT id, name
FROM persons
WHERE search_terms @> ARRAY['唐太宗']::text[];
```

后宫/宗室政治人物示例（无 `reign`，`name` 用通行检索名）：

```sql
INSERT INTO persons (
  id, name, alt_names, ancestral_xing, clan_shi,
  birth_year, birth_month, death_year, death_month,
  roles, bio, links
)
VALUES (
  'wei-hou',
  '韦后',
  ARRAY[]::text[],
  NULL, NULL,
  644, 1, 710, 7,
  ARRAY['皇后','政治家'],
  '唐中宗皇后，神龙政变后擅权，景龙政变中被杀。',
  '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韦皇后"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  ancestral_xing = EXCLUDED.ancestral_xing,
  clan_shi = EXCLUDED.clan_shi,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
```

新人物同样写入缓存中的 `persons` 数组，再由统一生成器写出完整字段。

### dynasty_groups 与 dynasties

分组和王朝边界分别写入 `dynasty_groups` 与 `dynasties`。两端日期使用独立的年月日和 confidence；`start_abs` / `end_abs` 继续按 AbsMonth 计算。SQL 由统一生成器从 cache 产生。

`dynasties.ethnicity` 保存有史料依据的族属标签；`dynasties.feudalRank` 为可选 JSON 对象 `{ "periods": [{ "rank": "侯", "start": HistoricalDate, "end": HistoricalDate }] }`。`rank` 为一个汉字，按“周代诸侯列国”来源表录入，允许 `公、侯、伯、子、男、王、君、帝`；后者在秦统一后对应“皇帝”的单字显示。每个时期必须有史料精度日期，按 `phaseOwnershipInterval` 裁定时期归属，禁止另写端点判断。仅来源表春秋/战国分栏、没有实际改称年份证据时，可用 `approximate_year` 记录表格栏界，但须在 `manifest.notes` 明示它不是确定的改称日期。字段反映该表的爵称/君主称谓，不代表这些标签构成一套严格可比的五等爵序列。“君”按具体国别与语境解释，不由名称或 ID 推导。

```sql
INSERT INTO dynasties (
  id, name, scope, region,
  start_year, start_month, start_day, start_confidence,
  end_year, end_month, end_day, end_confidence,
  start_abs, end_abs, color_token, parent_id, group_id, note
) VALUES (...);
```

### reigns

泳道卡片优先读取 `reigns.title`；人物详情页按日期处理 Skill 展示置信日期。人物庙号和谥号仍写入 `persons.temple_name` / `persons.posthumous_name`。称呼选择不读取 `era_names`。明清年号式卡片称呼直接写入 `reigns.title`，原有吴王、努尔哈赤和皇太极称号例外照旧。

起止日期分别写 `start_year/month/day/start_confidence` 和 `end_year/month/day/end_confidence`。开放终点仍保留空 end date 与 display cap `end_abs`。并立君主使用 `claim_track` 区分轨道，并用 `dynasty_name` 写该 reign 的政权/称谓，不改变日期归属规则。

```sql
INSERT INTO reigns (
  id, dynasty_id, person_id, title, era_names,
  start_year, start_month, start_day, start_confidence,
  end_year, end_month, end_day, end_confidence,
  start_abs, end_abs, claim_track, dynasty_name
) VALUES (...);
```

### locations / location_mapping

`locations` 仅存稳定 ID、现代地名及坐标。`location_mapping` 的 kind 为 dynasty/reign/event，external_id 分别引用对应实体；location_id 外键引用集中地点包。两表都不保存 claim_track，reigns 仍保留该字段。

缓存使用 `locations` 与 `locationMappings`。mapping 含 `id, locationId, kind, externalId, historicalName, note?, links, spatialPrecision?`；dynasty/reign 另有 `start, end, role`，event 的日期取所属事件。historicalName 只含当时古称，史料支持的同期同址别称可用 `/`，解释写入 note。

```sql
INSERT INTO locations (id, modern_name, longitude, latitude, coordinate_system) VALUES (...);
INSERT INTO location_mapping (
  id, location_id, kind, external_id, historical_name, spatial_precision,
  start_year, start_month, start_day, start_confidence,
  end_year, end_month, end_day, end_confidence,
  start_abs, end_abs, role, note, links
) VALUES (...);
```

首次迁移按现代地名、七位小数坐标和坐标系完全一致去重；此后 ID 不随字段修订变化、不自动合并。显式 reign mapping 保存都城完整时段，由共享规则在展示时裁剪；生成器及运行时均不推断关联。年桶占位月份不展示为已知月份。

### events（point / span）

缓存中的 `links: [{label,url}]` 写入 `events.links`（JSON 文本，默认 `[]`），由共享详情映射到“来源”。`content` 用于正文，不能放史料来源目录。

事件只用 `point` 或 `span`。point 使用 `at_year/month/day/at_confidence`；span 使用独立起止日期与 confidence。真实持续不足一个日历年的过程记为 point，满一年及以上记为 span；不得从占位年月计算持续时间。点事件无需持续时间精度字段。

```sql
INSERT INTO events (
  id, name, kind, time_mode, at_year, at_month, at_day, at_confidence,
  date_note, summary, meaning
) VALUES (...);

INSERT INTO events (
  id, name, kind, time_mode,
  start_year, start_month, start_day, start_confidence,
  end_year, end_month, end_day, end_confidence,
  date_note, summary
) VALUES (...);
```

### 旧 circa 记录迁移

新模型不再使用 `circa`；模糊时点用 point 与 approximate confidence，确有持续过程才用 span。存量 circa 记录须按 [日期处理 Skill](../eralens-date-handling/SKILL.md) 逐项判断能否无损转为 point/span；需要新增史料判断的记录暂缓并登记，不得只按跨度机械转成真实持续过程。

### events（成语 idiom）

成语典故专用 `kind = idiom`，只能 `time_mode = point`。时间轴按 `at_abs` 画时刻 marker；`meaning` 必填，`summary` 写典故。人物、王朝、史事对照均使用集中包 `associations`。人物端点必须为 `person:`，国君也不使用 reign 端点。

### entity_associations（集中普通关联）

唯一源：`data/imports/entity-associations/cache.json` 的 `associations` 数组。示例：

```json
[
  { "aRef": "dynasty:tang", "bRef": "event:xuanwumen" },
  { "aRef": "event:xuanwumen", "bRef": "person:li-shimin" }
]
```

无方向、无标签；完整 ref 按 UTF-8 字节顺序排列，禁止自关联或重复。人物—王朝、事件—事件等遵循同一结构，两侧详情均可查询。来源、迁移取舍与计数放在集中包 manifest。禁止各历史包写事件 dynastyIds/participantIds 或 supplementalEventDynasties/supplementalEventParticipants。接口中的同名事件数组是计算结果。

### relations（仅命运与人物继承）

```sql
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-li-yuan-li-shimin', 'person', 'li-yuan', 'person', 'li-shimin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
```

### 王朝分时名称

`dynasties.name` 仍为文本。普通名称原样保存；分时名称保存 JSON 字符串，顶层字段为 `default` 与 `periods`，各项含 `name`、`start`、`end`，日期使用带 confidence 的 HistoricalDate。default 存俗称（如「成汉」），用于无时点或阶段范围外展示；altNames[0] 存代表国号或自称（如「成」），两者独立，其余别名保留检索词。

人物总览读取 altNames[0]；在位详情及相关人物摘要优先 reign.dynastyName，其次 altNames[0] 和王朝 default。泳道及有明确时点的展示通过 `resolveDynastyName()` 解析；区间归属复用共享时间规则，支持在一条 reign 内部切换名称。普通文本名称保持原显示。所有显示和搜索必须解析名称，禁止展示或索引 JSON 原文。

同一王朝的改名阶段使用单一王朝 ID，跨包只能引用，不能重复拥有王朝行。整库构建直接从唯一所有者缓存写入最终王朝 ID 和全部引用；不再使用 `dynastyMerges` 增量入口。

跨王朝帝王命运边（时间轴虚线，`killed` / `surrender` / `abdication` / `captured` / `conquered`）：

- 端点：`person:{victim}` → `person:{receiver}`，不写 event/dynasty 端点
- 必填 `at_year` / `at_month` / `at_abs`；年精度时 `at_abs` 取受害方末年在位 `end_abs`（通常 `end_year` 的 12 月）
- 可选 `event_id` 挂灭国/禅让等事件，不参与几何
- 同朝 succession 不画虚线；仅跨王朝边进入时间轴
- `conquered`（灭国）从末君连向灭国方当时的君主，表达政权覆亡；末君可能出奔或结局失载，不能将灭国自动写成 `killed` / `captured` / `surrender`。人物实际结局独立保留在 bio 与来源中。

## 禁止写入的列

- `dynasties.span`
- `reigns.span`
- `events.span_start_abs`, `events.span_end_abs`, `events.span`

## Runtime 与 import 边界

| 数据 | 入库 | 运行时 |
|---|---|---|
| 主线分类 | `cache.json.reigns[].isMain` → `reigns.is_main` | 运行时据此展示主线/正统标记 |
| 王朝分时名称 | `dynasties.name` JSON 字符串，俗称在 `default`，国号/自称在 `alt_names[0]` | 共享解析器；阶段切换独立于 reign 边界 |
| 检索别名 | `persons.alt_names` | 作为人工来源字段，由触发器合并进 `search_terms` |
| 人物搜索索引 | `persons.search_terms` | 预生成姓名、别名、姓/氏组合、庙谥、title、朝代 + 庙谥；`text[]` GIN 完整词查询 |
| 庙号/谥号/称呼 | `persons.posthumous_name` / `persons.temple_name` / `reigns.title` | 泳道卡片优先 title；人物详情独立按年代优先 person 庙谥（618 年及以后优先庙号），缺失时才回退 title；**不**从 title 推导庙谥 |
| 年号 | `reigns.era_names` CSV | 详情以 `、` 连接全部；不参与称呼选择（明清泳道卡片用语已预存 title） |
| 姓/氏 | `persons.ancestral_xing` / `persons.clan_shi` | `stripAncestralXing` 读 DB |

入库审计（可选）：

```bash
node data/imports/lib/auditPreQinXingShi.mjs
node data/imports/lib/auditImperialAppellationFields.mjs
```

后者列出 618+ person 庙谥皆 NULL 的在位；史称（末帝/后主等）留在 `title` 属正常，勿写入 `posthumous_name`。

## color_token（入库占位）

`dynasties.color_token` 为 DB NOT NULL 遗留列，缓存中统一写 `ochre`。**泳道配色由前端运行时 `assignLaneColorTokens` 分配**，不要在缓存中轮换或手填颜色。

运行时色板 24 色（另加 orthodox `gold`）：cinnabar、mineral、ochre、indigo、moss、wisteria、grape、stone、jade、coral、plum、azure、amber、clay、sage、slate、crimson、bronze、rose、lime、navy、peacock、copper、mulberry。

## 常用 AbsMonth 验算

| 年月 | abs |
|---|---|
| -2070-01 | -24828 |
| -1046-01 | -12540 |
| -256-12 | -3049 |
| -221-01 | -2640 |
| 25-01 | 300 |
| 220-12 | 2651 |
| 618-06 | 7420 |
| 627-01 | 7524 |
