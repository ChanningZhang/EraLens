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
  "notes": ["即位月取史料常见说法，争议处标 precision=year"]
}
```

## 表与主键

| 表 | 主键 |
|---|---|
| persons | id |
| dynasties | id |
| reigns | id |
| era_names | DB serial（按 `reign_id` + `sort_order`） |
| events | id |
| event_dynasties | (event_id, dynasty_id) |
| event_participants | (event_id, person_id) |
| relations | id |

事件时间列：`time_mode`（point/span/circa）、`precision`（day/month/year/decade/century）、`date_note`（可选）。

- `point`：`at_year` / `at_month` / `at_abs`
- `span`：`start_*` + `end_*`（真实持续）
- `circa`：`start_*` + `end_*` 为可能窗口，可选 `at_*` 为最佳估计

## INSERT 模板

### persons

生卒不明时年月日填 `NULL`，不要用正月占位冒充已知。

```sql
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'li-shimin',
  '李世民',
  598, 1, 649, 7,
  ARRAY['皇帝','军事家'],
  '唐太宗，开创贞观之治。',
  '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李世民"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
```

后宫/宗室政治人物示例（无 `reign`，`name` 用通行检索名）：

```sql
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'wei-hou',
  '韦后',
  644, 1, 710, 7,
  ARRAY['皇后','政治家'],
  '唐中宗皇后，神龙政变后擅权，景龙政变中被杀。',
  '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韦皇后"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
```

### dynasties

```sql
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'tang',
  '唐',
  ARRAY['李唐'],
  'cn', 'east_asia',
  618, 6, 907, 5,
  7420, 10889,  -- 用 compute-abs.mjs 验算
  'month', 'cinnabar', NULL,
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
  parent_id = EXCLUDED.parent_id,
  note = EXCLUDED.note;
```

### reigns

卡片称谓由运行时 `resolveEmperorAppellation` 按 `appellationPolicy.ts` 的年份阈值计算；`preferred_appellation` 仅用于 **regnal** 例外（先秦称号、秦襄公等）。导入时不要写入庙号/谥号/年号的默认 preferred。`persons.name` 仍用名（姬发、禹），便于搜索。

```sql
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-li-shimin',
  'tang', 'li-shimin', '唐太宗',
  '文武皇帝', '太宗',
  '{"kind":"temple","name":"唐太宗"}'::jsonb,
  626, 9, 649, 7,
  7517, 7795, 'month',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
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
-- 前帝身后才即位（哪怕傀儡）走主线，claim_track 留 NULL。claim_role: puppet | rival | regent
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhu-yihai-ming-south',
  'ming-south', 'zhu-yihai', '鲁监国',
  NULL, NULL,
  '{"kind":"regnal","name":"鲁监国"}'::jsonb,
  1645, 1, 1653, 12,
  19740, 19847, 'year',
  'lu-jian', '绍兴监国', 'regent'
)
ON CONFLICT (id) DO UPDATE SET
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
```

### era_names

年号自汉武帝起。先秦省略本段。有年号则先删该 reign 旧年号再插（避免 serial 重复），或 `WHERE NOT EXISTS`：

```sql
DELETE FROM era_names WHERE reign_id = 'reign-li-shimin';

INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES
  ('reign-li-shimin', '贞观', 627, 1, 649, 7, 7524, 7795, 0);
```

### events（点事件 point）

发生时刻明确。月未知时 `precision='year'`，`at_month` 用 1 占位（界面不显示 1 月）。

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

## 禁止写入的列

- `dynasties.span`
- `reigns.span`
- `events.span_start_abs`, `events.span_end_abs`, `events.span`

## color_token 轮换建议

同一时期并存王朝按顺序分配，避免相邻行同色：ochre → indigo → moss → mineral → cinnabar → stone → grape → wisteria

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
