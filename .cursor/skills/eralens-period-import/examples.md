# 示例：贞观时期数据包

所有日期和事件 point/span 语义遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。日期记录在 `cache.json`；手写 SQL 只能用于理解生成结果，不得作为数据源。

## cache.json 片段

```json
{
  "persons": [
    {
      "id": "li-shimin",
      "name": "李世民",
      "birth": { "year": 598, "month": 1, "confidence": "year" },
      "death": { "year": 649, "month": 7, "confidence": "month" }
    }
  ],
  "dynasties": [
    {
      "id": "tang",
      "name": "唐",
      "start": { "year": 618, "month": 6, "abs": 7421, "confidence": "month" },
      "end": { "year": 907, "month": 5, "abs": 10888, "confidence": "month" }
    }
  ],
  "reigns": [
    {
      "id": "reign-li-shimin",
      "dynastyId": "tang",
      "personId": "li-shimin",
      "title": "唐太宗",
      "start": { "year": 626, "month": 9, "abs": 7520, "confidence": "month" },
      "end": { "year": 649, "month": 7, "abs": 7794, "confidence": "month" },
      "isMain": true
    }
  ],
  "events": [
    {
      "id": "zhenguan-rule",
      "name": "贞观之治",
      "kind": "politics",
      "timeMode": "span",
      "start": { "year": 627, "month": 1, "abs": 7524, "confidence": "year" },
      "end": { "year": 649, "month": 7, "abs": 7794, "confidence": "month" },
      "dateNote": "制度性治理过程；端点精度分别记录。"
    },
    {
      "id": "example-accession",
      "name": "即位",
      "kind": "politics",
      "timeMode": "point",
      "at": { "year": 626, "month": 9, "confidence": "approximate_month" },
      "dateNote": "原史料记载及历法换算依据写在这里。"
    }
  ],
  "manifest": {
    "slug": "tang-zhenguan",
    "title": "唐太宗贞观年间",
    "generatedAt": "2026-10-02",
    "counts": { "persons": 1, "dynasties": 1, "reigns": 1, "events": 2 },
    "sources": [],
    "notes": []
  }
}
```

`abs` 必须由共享 `absMonth()` 或导入工具计算。上例的正月是年精度占位，confidence 为 `year`，不得展示为已知月份。实际导入时只录入史料支持的事件；点事件不足一日历年使用 `point`，持续至少一完整日历年的真实过程使用 `span`，不得用占位年月计算持续时间。

普通关联另写入 `data/imports/entity-associations/cache.json.associations`：

```json
[
  { "aRef": "dynasty:tang", "bRef": "event:zhenguan-rule" },
  { "aRef": "event:zhenguan-rule", "bRef": "person:li-shimin" }
]
```

同步集中包 `manifest.counts.associations` 和来源，再生成两个包；历史包不维护关联数组。

## 生成 SQL 的日期列示意

以下仅示意统一生成器生成的列；真实记录仍须由缓存生成，不得手工维护 `import.sql`。日期置信度按端点写入。

```sql
-- persons: 日期字段与置信度按生、卒端点独立写入
INSERT INTO persons (
  id, name, birth_year, birth_month, birth_day, birth_confidence,
  death_year, death_month, death_day, death_confidence
) VALUES (
  'li-shimin', '李世民', 598, 1, NULL, 'year',
  649, 7, NULL, 'month'
);

-- reigns: 起止端点各有 confidence
INSERT INTO reigns (
  id, start_year, start_month, start_day, start_confidence,
  end_year, end_month, end_day, end_confidence
) VALUES (
  'reign-li-shimin', 626, 9, NULL, 'month',
  649, 7, NULL, 'month', 'month'
);

-- events: point 写 at_*；span 写 start_* / end_*
INSERT INTO events (
  id, time_mode, at_year, at_month, at_day, at_confidence, date_note
) VALUES (
  'example-accession', 'point', 626, 9, NULL, 'approximate_month',
  '保留原记载和历法换算依据。'
);
```

## 执行与验收

```bash
node data/imports/generate.mjs tang-zhenguan
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/tang-zhenguan/import.sql
pnpm data:build && pnpm data:validate
curl -s "http://localhost:3001/api/timeline?from=7524&to=7795&scope=cn" | jq '.dynasties[].name,.reigns[].title'
```

日期精度、历法转换、端点 confidence 和 SQL 迁移规则详见 [reference.md](reference.md) 与日期处理 Skill。
