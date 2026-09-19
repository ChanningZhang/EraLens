# 示例：贞观窗口增量导入

用户请求：「导入唐太宗贞观年间（627–649）数据」

## manifest.json

```json
{
  "slug": "tang-zhenguan",
  "title": "唐太宗贞观年间",
  "window": { "startYear": 627, "startMonth": 1, "endYear": 649, "endMonth": 7 },
  "scope": "cn",
  "depth": "standard"
}
```

## import.sql（节选）

```sql
-- EraLens period import: tang-zhenguan
-- Window: 627-01 .. 649-07 (AbsMonth 7524 .. 7795)
BEGIN;

INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'li-shimin', '李世民', 598, 1, 649, 7,
  ARRAY['皇帝'], '唐太宗，贞观之治。',
  '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李世民"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, bio = EXCLUDED.bio;

INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, note
) VALUES (
  'tang', '唐', ARRAY['李唐'], 'cn', 'east_asia',
  618, 6, 907, 5, 7420, 10889, 'month', 'cinnabar', '李渊建立'
)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs;

INSERT INTO persons (
  id, name, roles, bio, links, posthumous_name, temple_name
) VALUES (
  'li-shimin', '李世民', ARRAY['皇帝'], '唐太宗。', '[]'::jsonb, '文武皇帝', '太宗'
)
ON CONFLICT (id) DO UPDATE SET posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;

INSERT INTO reigns (
  id, dynasty_id, person_id, title, era_names,
  start_year, start_month, end_year, end_month, start_abs, end_abs, precision
) VALUES (
  'reign-li-shimin', 'tang', 'li-shimin', '唐太宗', '贞观',
  626, 9, 649, 7, 7517, 7795, 'month'
)
ON CONFLICT (id) DO UPDATE SET start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs;

INSERT INTO events (
  id, name, kind,
  start_year, start_month, start_abs,
  end_year, end_month, end_abs,
  time_mode, precision, summary
)
VALUES (
  'zhenguan-rule', '贞观之治', 'politics',
  627, 1, 7524, 649, 7, 7795,
  'span', 'year', '轻徭薄赋、任贤纳谏。'
)
ON CONFLICT (id) DO UPDATE SET
  summary = EXCLUDED.summary, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision;

INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhenguan-rule', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhenguan-rule', 'li-shimin') ON CONFLICT DO NOTHING;

COMMIT;
```

## 执行

```bash
node .cursor/skills/eralens-period-import/scripts/compute-abs.mjs 627 1   # → 7524
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/tang-zhenguan/import.sql
.cursor/skills/eralens-period-import/scripts/apply-sql.sh data/imports/tang-zhenguan/import.sql
curl -s "http://localhost:3001/api/timeline?from=7524&to=7795&scope=cn" | jq '.dynasties[].name,.reigns[].title'
```

## 先秦大批量

`data/imports/xia-shang-zhou/`：`generate.mjs` 用同一套 `absMonth()` 写出 `import.sql`。年份用负数（前 1046 年 → `-1046`），无年号则省略 `era_names`。验收窗口例如：

```bash
curl -s "http://localhost:3001/api/timeline?from=-12540&to=-9228&scope=cn" | jq '.dynasties[].name'
```
