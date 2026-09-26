---
name: eralens-geography-import
description: >-
  为 EraLens 添加或丰富历史地理信息，包括王朝都城、在位与都城关联、事件地点、古今地名、坐标和定位争议，
  并生成和导入地理 SQL。Use when the user asks to add geography, capitals, historical places,
  event locations, coordinates, modern place names, migrations of capitals, or map data.
---

# EraLens 地理信息添加与丰富

本 Skill 统一处理两类地理数据：

- `dynasty_capitals` / `reign_capitals`：王朝都城、陪都、行在及其时段和君主对应；
- `event_locations` / `events.location_id`：可可靠定位的事件地点。

只补都城坐标时可参考更专门的
[eralens-capital-geocode](../eralens-capital-geocode/SKILL.md)；新增事件本体使用
[eralens-event-import](../eralens-event-import/SKILL.md)。

## 调研原则

1. 先查维基百科、正史、地方志、政府文保资料、考古报告或学术资料，分别核对古称、现代对应地、使用时段和定位争议。
2. 不能只凭同名现代城市定位。古城遗址、迁址、同城不同遗址必须区分；同一古称在不同时期可能对应不同地点。
3. 对长距离战役、路线、流域或多地点事件，只选有历史意义的代表点，并在 `note` 说明该点不代表全部范围。
4. 无法可靠定位或诸说无法取舍时宁可留空；若采用一种通行说，`precision='approximate'` 并记录其他说法和来源。
5. 历史概述只写历史事实。地理编码方法、代表点选择和数据取舍写入 `note` 或 manifest notes。

## 坐标与地名

- `historical_name`：当时名称或史料通称，如长安、大都、白登山。
- `modern_name`：可核验的现代行政区或遗址全称。中国境内都城使用 `{省}{市}` 起步，能定位区县、乡镇、遗址时继续细化；直辖市写 `北京市` 等全称。
- 不把行政区中心坐标冒充遗址坐标。只能定位到城市时明确写城市范围并降低精度。
- `longitude` / `latitude` 必须与 `coordinate_system` 匹配，禁止把高德返回的 GCJ-02 标成 WGS84。
- `dynasty_capitals` 沿用 `GCJ02`，优先用高德地理编码并反查省市；坐标在导入期烘焙，运行时不调用地图服务。
- `event_locations` 沿用 `WGS84`。坐标来源须明确为 WGS84；若原始来源是 GCJ-02，必须用项目认可、可复现的转换后再入库并记录方法。
- 地点 `links` 保存支持古今对应和定位的直接来源；地图搜索只能辅助定位，不能替代历史依据。

## 王朝都城

- `role`：`primary`（京师）、`secondary`（陪都）、`temporary`（行在）。不要因短期驻跸就自动建都城。
- 年精度起点用 1 月占位、终点用 12 月占位；已知月日才提升精度。
- 起止精度不同可用 `precision` + `end_precision`，不要把占位正月或十二月冒充已知月份。
- 相邻都城时段的归属统一走 `timelineOwnership.ts`；不得手写 `+1` 截断。不同角色、不同地点或并行政权可真实并存，不由区间解析器互相裁掉。
- 并立政权的都城用与 reign 相同的 `claim_track`。同一王朝/track 在同一时段有多个都城时，必须由角色或史料语义说明共存。
- 都城只属于特定君主或不能由王朝、track、日期无歧义推断时，写 `reign_capitals` 显式关联。更新前先清理该 reign 的陈旧关联，再 `ON CONFLICT DO NOTHING` 插入正确集合。
- 王朝更名、合并泳道或相位变化不改变历史都城实体；不要为了布局复制同一都城记录。

ID 使用 `cap-{dynasty}-{place-kebab}`；同地多次迁入时追加起年。优先修改 `data/imports/dynasty-capitals/capitals-raw.json` 与坐标文件，再运行其生成器。

## 事件地点

- 只有事件能指向一个有史料支持的具体地点或代表性中心时才建 `event_locations`。
- 一条事件当前只有一个 `location_id`。涉及多处时选叙事中心或关键转折点，并在 `historical_name`、`modern_name`、`note` 清楚说明范围；不要伪装成精确单点。
- 地点 id 使用 `loc-{event-or-place-kebab}`。先查是否已有可复用地点，但只有历史语义和代表点完全一致时才复用。
- `precision` 默认 `approximate`；只有坐标确指已确认遗址或设施时才使用更高精度，并保留来源。
- 维护 `data/imports/event-locations/locations.mjs`，通过 `eventLocationSql()` UPSERT 地点，再更新 `events.location_id`。事件不存在时先处理事件本体，不能留下无效 UPDATE。

## 时间、历法与不确定性

- 都城时段也必须核对原始史料日期和历法。农历月日不得直接当公历；可靠换算后在 `note` 记录原日期与依据。
- `start_date_confidence` / `end_date_confidence` 仅表示导入者推算或插值边界。史料只写“约某年”但可忠实落入该年桶时，不自动加 confidence。
- 所有 `start_abs` / `end_abs` 使用 `absMonth()` 或共享生成器计算，不手填。

## 工作流

```text
Task Progress:
- [ ] 1. 确定地理对象类型、时间窗和关联实体
- [ ] 2. 查史料核对古称、今址、角色、时段和争议
- [ ] 3. 获取与坐标系一致的坐标并反向核验
- [ ] 4. 修改 capitals-raw/coordinates 或 event-locations 源数据
- [ ] 5. 运行生成器并校验 SQL、外键和现代地名
- [ ] 6. 导入数据库
- [ ] 7. 验收地图点、时间轴归属、详情关联和争议说明
```

```bash
# 王朝都城
node data/imports/dynasty-capitals/generate.mjs

# 事件地点
node data/imports/event-locations/generate.mjs

# 通用校验与导入
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/{slug}/import.sql
.cursor/skills/eralens-period-import/scripts/apply-sql.sh data/imports/{slug}/import.sql
```

需要全量重灌时使用 `pnpm db:import`；不要运行 `pnpm db:seed` 覆盖真实数据。不要只改生成后的 `import.sql`，必须同步源文件和 `manifest.json` 的来源、计数、notes。

## 验收

- [ ] 古称、今址、坐标、坐标系和来源一致
- [ ] 争议位置、代表点和范围误差已写入 note
- [ ] 都城 role、时段、track 与 reign 关联无歧义
- [ ] 事件地点不是把大范围行动伪装成精确点
- [ ] 无重复地点、无孤儿外键、无陈旧 `reign_capitals`
- [ ] 生成与校验通过，地图和详情展示正确

表字段见 [eralens-period-import reference](../eralens-period-import/reference.md)。
