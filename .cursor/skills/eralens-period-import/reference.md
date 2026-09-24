# EraLens 导入参考

## manifest.json

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
| events | id |
| event_dynasties | (event_id, dynasty_id) |
| event_participants | (event_id, person_id) |
| relations | id |

事件时间列：`time_mode`（point/span/circa）、`precision`（day/month/year/decade/century）、`date_note`（可选）。

`events.kind` 支持 `battle`、`politics`、`culture`、`disaster`、`commerce`、`finance`、`idiom`、`poetry`、`other`。`commerce` 表示贸易制度、通商格局与重要商品传播事件，界面标签为「商业」；`finance` 表示货币、银行与财政制度转折，界面标签为「金融」。新增 kind 时同步更新 `packages/shared/src/schema.ts`、共享标签函数、界面样式与本节枚举。

- `point`：`at_year` / `at_month` / `at_abs`
- `span`：`start_*` + `end_*`（真实持续）
- `circa`：`start_*` + `end_*` 为可能窗口，可选 `at_*` 为最佳估计

## INSERT 模板

### persons

生卒不明时年月日填 `NULL`，不要用正月占位冒充已知。

```sql
INSERT INTO persons (
  id, name, alt_names, ancestral_xing, clan_shi,
  birth_year, birth_month, death_year, death_month,
  roles, bio, links, posthumous_name, temple_name
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
  '文武皇帝', '太宗'
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
  temple_name = EXCLUDED.temple_name;
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

（旧模板省略 `alt_names` / 姓氏列时，请改用 `data/imports/lib/sqlHelpers.mjs` 的 `personSql`。）

### dynasty_groups

并存时期分组（三国、五胡十六国、南朝/北朝、五代/十国等）。起止为组的外框与排序锚点，不用成员 min/max。

```sql
INSERT INTO dynasty_groups (
  id, name, alt_names, scope,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, note
) VALUES (
  'wudai',
  '五代',
  ARRAY[]::text[],
  'cn',
  907, 1, 960, 12,
  10885, 11520,
  'year',
  '907–960年北方五代更迭'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  scope = EXCLUDED.scope,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  note = EXCLUDED.note;
```

### dynasties

```sql
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token,
  orthodox_from_abs, orthodox_end_abs,
  parent_id, group_id, note
) VALUES (
  'tang',
  '唐',
  ARRAY['李唐'],
  'cn', 'east_asia',
  618, 6, 907, 5,
  7420, 10889,  -- 用 compute-abs.mjs 验算
  'month', 'cinnabar',
  7420, NULL,   -- 自起始即正统；截断用 orthodox_end_abs
  NULL, NULL,
  '李渊建立，朱温篡唐终结'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  orthodox_end_abs = EXCLUDED.orthodox_end_abs,
  parent_id = EXCLUDED.parent_id,
  group_id = EXCLUDED.group_id,
  note = EXCLUDED.note;
```

正统起迄由 `data/imports/lib/orthodoxDynasties.mjs` 与 `dynastySql()` 烘焙；运行时只读这两列，不再内置 per-dynasty 表。

### reigns

卡片称谓由运行时 `resolveEmperorAppellation` / `resolveReignCardLabel` 按 `appellationPolicy.ts` 的年份阈值计算；始皇帝以前主行用谥号或诸侯称号（不带国名）。谥号/庙号读 **person** 的 CSV 字段；史称（少帝/末帝/后主等）不得写入 `posthumous_name`。无谥号的 regnal 称号直接写入 `reigns.title` 本体（`夫差`、`王厝`、`禹`），不要写 `吴王夫差`。`persons.name` 仍用可展示私名（姬发、禹），便于搜索；维基别名须在导入时清洗。

`persons.posthumous_name` / `persons.temple_name` 与商周数据一致：**只存谥号/庙号本体，不带国名**（`武王`、`孝文皇帝`、`太宗`）。同人多值用逗号连接。国名简称写在 `title`（`周武王`、`唐太宗`）。先秦副行去姓靠 `persons.ancestral_xing` / `persons.clan_shi`，运行时不再维护姓氏表。

```sql
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-li-shimin',
  'tang', 'li-shimin', '唐太宗',
  '贞观',
  626, 9, 649, 7,
  7517, 7795, 'month',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;

-- 并行称君示例（南明鲁监国）：仅当与主线皇帝同时另立时才填 claim_track；是否傀儡不影响此判定。
-- 前帝身后才即位（哪怕权臣拥立）走主线，claim_track 留 NULL。并行 track 的 claim_role 一律 rival。
-- 主行上非正统代政（有穷后羿/寒浞）不填 claim_track，只标 claim_role=rival：不上金、不分并立行、不串通行继承链。
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhu-yihai-ming-south',
  'ming-south', 'zhu-yihai', '鲁监国',
  NULL,
  '{"kind":"regnal","name":"鲁监国"}'::jsonb,
  1645, 1, 1653, 12,
  19740, 19847, 'year',
  'lu-jian', '绍兴监国', 'rival'
)
ON CONFLICT (id) DO UPDATE SET
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
```

### reigns.era_names

年号自汉武帝起，写入 `reigns.era_names` 逗号分隔名称（如 `泰定,致和`）。先秦省略（NULL）。**不再**使用 `era_names` 子表，各年号起迄年月不入库；界面与称谓只读名称列表。

### dynasty_capitals

王朝在指定时段的都城，供地图撒点。坐标烘焙入库（GCJ-02），运行时不调高德。

- `historical_name`：当时名称（长安、大都、临安）
- `modern_name`：**必填**行政区全称，格式 `{省}{市}` 或直辖市 `北京市`；禁止裸写「西安」「洛阳」
- `role`：`primary`（京师）/ `secondary`（陪都）/ `temporary`（行在）
- `claim_track`：并行政权都城时与 `reigns.claim_track` 同一 kebab-case key
- 时间字段与 `reigns` 一致；年精度起年 `start_month=1`、迄年 `end_month=12`

```sql
INSERT INTO dynasty_capitals (
  id, dynasty_id, historical_name, modern_name,
  longitude, latitude, coordinate_system,
  start_year, start_month, start_day,
  end_year, end_month, end_day,
  start_abs, end_abs, precision,
  start_date_confidence, end_date_confidence,
  role, claim_track, note, links
) VALUES (
  'cap-tang-changan',
  'tang', '长安', '陕西省西安市',
  108.9396450, 34.3432070, 'GCJ02',
  618, 1, NULL,
  904, 12, NULL,
  7416, 10848, 'year',
  NULL, NULL,
  'primary', NULL,
  '唐都长安，高祖至哀帝。',
  '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/长安"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  historical_name = EXCLUDED.historical_name,
  modern_name = EXCLUDED.modern_name,
  longitude = EXCLUDED.longitude,
  latitude = EXCLUDED.latitude,
  coordinate_system = EXCLUDED.coordinate_system,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  role = EXCLUDED.role,
  claim_track = EXCLUDED.claim_track,
  note = EXCLUDED.note,
  links = EXCLUDED.links;
```

地理编码流程见 Skill [eralens-capital-geocode](.cursor/skills/eralens-capital-geocode/SKILL.md)。

### events（点事件 point）

发生时刻明确。月未知时 `precision='year'`，`at_month` 用 **12** 占位（与泳道年桶右缘一致；界面不显示 12 月）。生成器用 `eventYear(year)` 或 `eventPoint`（会把旧的正月占位改成 12）。已知月份则 `precision='month'|'day'`。

```sql
INSERT INTO events (
  id, name, kind, at_year, at_month, at_abs,
  time_mode, precision, date_note, summary
)
VALUES (
  'xuanwumen',
  '玄武门之变',
  'politics',
              626, 7, 7518,
  'point', 'month', NULL,
  '李世民发动政变，即位太子。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  summary = EXCLUDED.summary;
```

### events（持续区间 span）

事件真实持续一段时间，时间轴画细条。不要用 span 表示「大约何时」。

```sql
INSERT INTO events (
  id, name, kind,
  start_year, start_month, start_abs,
  end_year, end_month, end_abs,
  time_mode, precision, date_note, summary
)
VALUES (
  'zhenguan-rule',
  '贞观之治',
  'politics',
  627, 1, 7524,
  649, 7, 7795,
  'span', 'year', NULL,
  '轻徭薄赋、任贤纳谏。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  summary = EXCLUDED.summary;
```

### events（不确定窗口 circa）

大约发生于某窗口，或诸说不一。窗口用 start/end；可选 `at_*` 为学界常用估计。时间轴画淡色虚线带。

```sql
INSERT INTO events (
  id, name, kind,
  start_year, start_month, start_abs,
  end_year, end_month, end_abs,
  at_year, at_month, at_abs,
  time_mode, precision, date_note, summary
)
VALUES (
  'zhenguan-code',
  '贞观律修订',
  'politics',
  627, 1, 7524,
  637, 12, 7655,
  637, 1, 7644,
  'circa', 'year',
  '具体颁布月不详，取贞观十一年为常用估计',
  '贞观年间修定律令。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  summary = EXCLUDED.summary;
```

### events（成语 idiom）

成语典故专用 `kind = idiom`，**只能** `time_mode = point`。时间轴按 `at_abs` 画时刻 marker；`meaning` 必填（释义），`summary` 写典故。

- `event_participants.person_id` 只写 `persons.id`（国君也用 person id，如 `gou-jian`），**禁止** reign id
- 不在 `relations` 中挂 `reign:*`；人物关联只走 `event_participants`
- 对照史事可用 `relations`：`event:idiom-*` → `event:*`（`kind: other`）

```sql
INSERT INTO events (
  id, name, kind, time_mode, precision, date_note,
  at_year, at_month, at_abs,
  summary, meaning
) VALUES (
  'idiom-wo-xin-chang-dan',
  '卧薪尝胆',
  'idiom',
  'point', 'year', '越灭吴，前473年',
  -473, 12, -5653,
  '勾践战败后屈身事吴，回国卧薪尝胆，最终灭吴称霸。',
  '形容刻苦自励，发愤图强。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  summary = EXCLUDED.summary,
  meaning = EXCLUDED.meaning;

INSERT INTO event_dynasties (event_id, dynasty_id)
VALUES ('idiom-wo-xin-chang-dan', 'yue-chunqiu')
ON CONFLICT DO NOTHING;

INSERT INTO event_participants (event_id, person_id)
VALUES ('idiom-wo-xin-chang-dan', 'gou-jian')
ON CONFLICT DO NOTHING;
```

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
| 正统金色起迄 | `orthodox_from_abs` / `orthodox_end_abs`（`orthodoxDynasties.mjs` + `dynastySql`） | 只读 DB 列 |
| 相续泳道合并 | `dynasty_lane_groups` | API 下发，`dynastyLaneGroups.ts` 无硬编码组 |
| 检索别名 | `persons.alt_names` | 作为人工来源字段，由触发器合并进 `search_terms` |
| 人物搜索索引 | `persons.search_terms` | 预生成姓名、别名、姓/氏组合、庙谥、title、朝代 + 庙谥；`text[]` GIN 完整词查询 |
| 庙号/谥号/先秦称号 | `persons.posthumous_name` / `persons.temple_name` / `reigns.title` | `resolveEmperorAppellation` 按 618/1368/-221 阈值读 person 庙谥 + reign 年号；**不**从 `title` 推导庙谥 |
| 年号 | `reigns.era_names` CSV | 卡片取第一个，详情 `、` 连接全部 |
| 姓/氏 | `persons.ancestral_xing` / `persons.clan_shi` | `stripAncestralXing` 读 DB |

入库审计（可选）：

```bash
node data/imports/lib/auditPreQinXingShi.mjs
node data/imports/lib/auditImperialAppellationFields.mjs
```

后者列出 618+ person 庙谥皆 NULL 的在位；史称（末帝/后主等）留在 `title` 属正常，勿写入 `posthumous_name`。

## color_token（入库占位）

`dynasties.color_token` 为 DB NOT NULL 遗留列，导入时统一写 `ochre`（`sqlHelpers.mjs` 的 `LEGACY_COLOR_TOKEN`）。**泳道配色由前端运行时 `assignLaneColorTokens` 分配**，不要在 `generate.mjs` 里轮换或手填颜色。

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
