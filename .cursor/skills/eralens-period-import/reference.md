# EraLens 导入参考

## 当前数据源与文件格式

日期统一遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。缓存中的日期为 `{ year, month, day?, abs, confidence }`；每个端点分别记录八类 confidence 之一。其余缓存结构和来源维护方法见下方；日期规则不在本参考重复定义。

缓存示意（省略非必要字段）：

```json
{
  "slug": "example-period",
  "window": { "startYear": 626, "startMonth": 1, "endYear": 649, "endMonth": 12 },
  "persons": [{ "id": "li-shimin", "name": "李世民", "title": "唐太宗", "posthumousNames": ["文武皇帝"], "templeNames": ["太宗"] }],
  "dynastyGroups": [],
  "dynastyLaneGroups": [],
  "dynasties": [{ "id": "tang", "name": "唐", "start": { "year": 618, "month": 6, "abs": 7421, "confidence": "month" }, "end": { "year": 907, "month": 5, "abs": 10888, "confidence": "month" } }],
  "capitals": [],
  "reigns": [{ "id": "reign-li-shimin", "dynastyId": "tang", "personId": "li-shimin", "title": "唐太宗", "start": { "year": 626, "month": 9, "abs": 7520, "confidence": "month" }, "end": { "year": 649, "month": 7, "abs": 7794, "confidence": "month" }, "startAbs": 7520, "endAbs": 7794, "eraNames": ["贞观"], "isMain": true }],
  "reignCapitals": [],
  "events": [{ "id": "example-event", "name": "示例事件", "kind": "politics", "timeMode": "point", "at": { "year": 627, "month": 12, "abs": 7535, "confidence": "year" }, "dynastyIds": ["tang"], "participantIds": ["li-shimin"] }],
  "eventLocations": [],
  "relations": [],
  "supplementalEventDynasties": [],
  "supplementalEventParticipants": [],
  "manifest": { "slug": "example-period", "title": "示例时期", "generatedAt": "2026-09-27", "counts": { "persons": 1, "dynasties": 1, "reigns": 1, "events": 1 }, "sources": [], "notes": [] },
  "preSql": "",
  "postSql": ""
}
```

正常录入只改这些缓存记录及 `manifest`。新增或删除记录时同步维护缓存中的 `manifest.counts`，修订时更新 `manifest.generatedAt`；生成器按缓存原样输出元数据，不自动计算或修复数量。`preSql` / `postSql` 仅在确实需要清理历史数据库残留时使用，不能用于转换或覆盖缓存数据。生成与导入步骤见 [时期数据导入 Skill](./SKILL.md) 和 [数据包说明](../../../data/imports/README.md)。

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
| dynasty_lane_groups | id |
| reigns | id |
| dynasty_capitals | id |
| reign_capitals | (reign_id, capital_id) |
| events | id |
| event_locations | id |
| event_dynasties | (event_id, dynasty_id) |
| event_participants | (event_id, person_id) |
| relations | id |

事件日期列：`time_mode`（point/span）、`at_confidence` / `start_confidence` / `end_confidence`、`date_note`（可选）。日期精度只由每个端点的 confidence 表达；空间定位的 `event_locations.precision` 单独保留。

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
| `dynasty_capitals` | `start_year/month/day`, `start_confidence`, `end_year/month/day`, `end_confidence` |
| `events` | point 用 `at_year/month/day`, `at_confidence`；span 用独立 `start_*` / `end_*` 与对应 confidence |
| `relations` | `at_year/month/day`, `at_confidence` |

SQL 模板不得使用已删除的日期精度列。以下 SQL 片段只示意其他列的映射，不能据其省略的新日期字段手写真实导入 SQL。

## 生成 SQL 的列映射示例（不是数据录入格式）

以下 SQL 仅说明缓存字段如何映射到数据库列，不能作为源文件编辑。需要新增/修复数据时改上方所示 `cache.json`，再运行统一生成器。

### persons

生卒不明时年月日填 `NULL`，不要用正月占位冒充已知。

```sql
INSERT INTO persons (
  id, name, alt_names, ancestral_xing, clan_shi,
  birth_year, birth_month, death_year, death_month,
  roles, bio, links, posthumous_name, temple_name, title
)
VALUES (
  'li-shimin',
  '李世民',
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

起止日期分别写 `start_year/month/day/start_confidence` 和 `end_year/month/day/end_confidence`。开放终点仍保留空 end date 与 display cap `end_abs`。并立君主使用 `claim_track`、`claim_role` 表达，不改变日期归属规则。

```sql
INSERT INTO reigns (
  id, dynasty_id, person_id, title, era_names,
  start_year, start_month, start_day, start_confidence,
  end_year, end_month, end_day, end_confidence,
  start_abs, end_abs, claim_track, claim_label, claim_role
) VALUES (...);
```

### dynasty_capitals

都城时间端点与在位日期规则一致，分别使用年月日和 `start_confidence` / `end_confidence`。年桶占位月份不得显示为史料记载的月份。城市坐标的空间定位精度使用 `event_locations.precision`；日期 confidence 不复用空间精度字段。

```sql
INSERT INTO dynasty_capitals (
  id, dynasty_id, historical_name, modern_name,
  longitude, latitude, coordinate_system,
  start_year, start_month, start_day, start_confidence,
  end_year, end_month, end_day, end_confidence,
  start_abs, end_abs, role, claim_track, note, links
) VALUES (...);
```

### events（point / span）

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

成语典故专用 `kind = idiom`，只能 `time_mode = point`。时间轴按 `at_abs` 画时刻 marker；`meaning` 必填，`summary` 写典故。人物关联使用 `event_participants.person_id`，必须为 `persons.id`；对照史事关联写入 `relations`。

### event_dynasties / event_participants

```sql
INSERT INTO event_dynasties (event_id, dynasty_id)
VALUES ('xuanwumen', 'tang')
ON CONFLICT DO NOTHING;

INSERT INTO event_participants (event_id, person_id)
VALUES ('xuanwumen', 'li-shimin')
ON CONFLICT DO NOTHING;
```

### relations

```sql
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-li-yuan-li-shimin', 'person', 'li-yuan', 'person', 'li-shimin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
```

### dynasty_lane_groups

相续泳道合并（西周/东周、蒙古/元、吴/明/南明）写入独立包 `data/imports/dynasty-lane-groups/`，不要在前端 hardcode。

```sql
INSERT INTO dynasty_lane_groups (
  id, primary_dynasty_id, phase_dynasty_ids,
  lane_order_start_abs, lane_order_end_abs
) VALUES (
  'zhou-west-east',
  'zhou-west',
  ARRAY['zhou-west','zhou-east'],
  -12540, -3049
)
ON CONFLICT (id) DO UPDATE SET
  primary_dynasty_id = EXCLUDED.primary_dynasty_id,
  phase_dynasty_ids = EXCLUDED.phase_dynasty_ids,
  lane_order_start_abs = EXCLUDED.lane_order_start_abs,
  lane_order_end_abs = EXCLUDED.lane_order_end_abs;
```

跨王朝帝王命运边（时间轴虚线，`killed` / `surrender` / `abdication` / `captured`）：

- 端点：`person:{victim}` → `person:{receiver}`，不写 event/dynasty 端点
- 必填 `at_year` / `at_month` / `at_abs`；年精度时 `at_abs` 取受害方末年在位 `end_abs`（通常 `end_year` 的 12 月）
- 可选 `event_id` 挂灭国/禅让等事件，不参与几何
- 同朝 succession 不画虚线；仅跨王朝边进入时间轴

## 禁止写入的列

- `dynasties.span`
- `reigns.span`
- `events.span_start_abs`, `events.span_end_abs`, `events.span`

## Runtime 与 import 边界

| 数据 | 入库 | 运行时 |
|---|---|---|
| 主线分类 | `cache.json.reigns[].isMain` → `reigns.is_main` | 运行时据此展示主线/正统标记 |
| 相续泳道合并 | `dynasty_lane_groups` | API 下发，`dynastyLaneGroups.ts` 无硬编码组 |
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
