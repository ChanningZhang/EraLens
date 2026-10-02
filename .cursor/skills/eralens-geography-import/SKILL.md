---
name: eralens-geography-import
description: >-
  为 EraLens 添加或丰富历史地理信息，包括王朝都城、在位与都城关联、事件地点、古今地名、坐标和定位争议，
  并生成和导入地理 SQL。Use when the user asks to add geography, capitals, historical places,
  event locations, coordinates, modern place names, migrations of capitals, or map data.
---

# EraLens 地理信息添加与丰富

都城时段及其他地理实体涉及的日期遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。地点坐标自身的空间定位精度仍使用本 Skill 的 `event_locations.precision` 规则。

地理记录也以对应包 `cache.json` 为唯一事实源：都城写入 `capitals`，地点写入 `eventLocations`，事件引用写入 `events[].locationId`；来源与取舍写入同一缓存的 `manifest.sources` / `manifest.notes`。缓存字段用 camelCase（如 `historicalName`、`modernName`、`dynastyId`、`coordinateSystem`）；下文的 snake_case 名称是数据库列名。不要维护另外的 raw JSON、坐标文件或包级生成器。

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
5. 历史概述只写历史事实。地理编码方法、代表点选择和数据取舍写入 `note` 或 `cache.json.manifest.notes`。

## 坐标与地名

- `historical_name`：当时名称或史料通称，如长安、大都、白登山。
- `modern_name`：可核验的现代行政区或遗址全称。中国境内都城使用 `{省}{市}` 起步，能定位区县、乡镇、遗址时继续细化；直辖市写 `北京市` 等全称。
- 不把行政区中心坐标冒充遗址坐标。只能定位到城市时明确写城市范围并降低精度。
- `longitude` / `latitude` 必须与 `coordinate_system` 匹配，禁止把高德返回的 GCJ-02 标成 WGS84。
- `dynasty_capitals` 沿用 `GCJ02`，优先用高德地理编码并反查省市；坐标在导入期烘焙，运行时不调用地图服务。
- `event_locations` 沿用 `WGS84`。坐标来源须明确为 WGS84；若原始来源是 GCJ-02，必须用项目认可、可复现的转换后再入库并记录方法。
- 地点 `links` 保存支持古今对应和定位的直接来源；地图搜索只能辅助定位，不能替代历史依据。
- 新增或丰富都城、事件地点时必须同步更新记录的 `links` 与所属包的 `manifest.sources`，按 [来源维护](../eralens-period-import/SKILL.md#来源维护) 执行，并核对都城详情“来源”栏。

## 王朝都城

- `role`：`primary`（京师）、`secondary`（陪都）、`temporary`（行在）。不要因短期驻跸就自动建都城。
- 时段端点日期、精度和置信度遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。
- 不确定时段的都城仅保留在王朝级，不下沉到各段在位；在位或都城任一端点为近似/插值时，不生成君主都城任期，也不以显式关联绕过。具体展示与时长规则见 [不确定区间的展示与都城归属](../eralens-date-handling/SKILL.md#不确定区间的展示与都城归属)。
- 相邻都城时段的归属统一走 `timelineOwnership.ts`；不得手写 `+1` 截断。不同角色、不同地点或并行政权可真实并存，不由区间解析器互相裁掉。
- 并立政权的都城用与 reign 相同的 `claim_track`。同一王朝/track 在同一时段有多个都城时，必须由角色或史料语义说明共存。
- 都城只属于特定君主或不能由王朝、track、日期无歧义推断时，写 `reign_capitals` 显式关联。更新前先清理该 reign 的陈旧关联，再 `ON CONFLICT DO NOTHING` 插入正确集合。
- 王朝更名、合并泳道或相位变化不改变历史都城实体；不要为了布局复制同一都城记录。
- 同一实际城址仅发生改名时，不要按古称拆成多条都城记录；在 `historical_name` 按历史先后用 `/` 连接旧名与新名（如“沈阳/盛京”），保留一条连续都城记录。若都城角色、claim track 或具体城址另有真实变化，按其语义保留必要时段/实体区分，名称仍可用 `/` 表示同址别名；现代行政区或近似坐标相同本身不足以证明同一城址。

ID 使用 `cap-{dynasty}-{place-kebab}`；同地多次迁入时追加起年。都城记录直接写入 `data/imports/dynasty-capitals/cache.json` 的 `capitals` 数组；坐标和地名都随记录保存。

## 事件地点

- 只有事件能指向一个有史料支持的具体地点或代表性中心时才建 `event_locations`。
- 一条事件当前只有一个 `location_id`。涉及多处时选叙事中心或关键转折点，并在 `historical_name`、`modern_name`、`note` 清楚说明范围；不要伪装成精确单点。
- 地点 id 使用 `loc-{event-or-place-kebab}`。先查是否已有可复用地点，但只有历史语义和代表点完全一致时才复用。
- `precision` 默认 `approximate`；只有坐标确指已确认遗址或设施时才使用更高精度，并保留来源。
- 地点记录直接写入 `data/imports/event-locations/cache.json` 的 `eventLocations` 数组。事件的 `locationId` 写在对应事件记录中；事件不存在时先处理事件本体，不能留下无效关联。

## 日期

日期和历法规则统一见 [eralens-date-handling](../eralens-date-handling/SKILL.md)。
- 所有 `start.abs` / `end.abs` 使用 `absMonth()` 或 `compute-abs.mjs` 核算后直接写入缓存；统一生成器只负责 SQL 序列化。

## 工作流

```text
Task Progress:
- [ ] 1. 确定地理对象类型、时间窗和关联实体
- [ ] 2. 查史料核对古称、今址、角色、时段和争议
- [ ] 3. 获取与坐标系一致的坐标并反向核验
- [ ] 4. 直接编辑对应包 `cache.json` 与 manifest 来源说明
- [ ] 5. 运行生成器并校验 SQL、外键和现代地名
- [ ] 6. 导入数据库
- [ ] 7. 验收地图点、时间轴归属、详情关联和争议说明
```

```bash
# 王朝都城或事件地点包
node data/imports/generate.mjs {slug}

# 通用校验与导入
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/{slug}/import.sql
.cursor/skills/eralens-period-import/scripts/apply-sql.sh data/imports/{slug}/import.sql
```

生成器为全部导入包共用，只生成 PostgreSQL `import.sql`。校验器从 SQL 同目录的 `cache.json` 检查 reign 接续精度；失败时应修缓存并重新生成。单包增量导入用 `apply-sql.sh`；全量 `pnpm db:import` 前运行 `node data/imports/generate.mjs --all`，因为 db:import 会清空并重载本地 PostgreSQL、导出移动端 SQLite，但不会从缓存生成 SQL。Xcode 不执行包内 SQL。

需要全量重灌时使用 `pnpm db:import`；不要运行 `pnpm db:seed` 覆盖真实数据。不要只改生成后的 `import.sql`；直接改对应 `cache.json` 和其中的 `manifest.sources` / `manifest.notes` / `manifest.counts`。计数要在缓存中维护，最终 `manifest.json` 由统一生成器输出。

## 验收

- [ ] 古称、今址、坐标、坐标系和来源一致
- [ ] `links` 与 `manifest.sources` 已同步更新，适用详情的“来源”栏已核对
- [ ] 争议位置、代表点和范围误差已写入 note
- [ ] 都城 role、时段、track 与 reign 关联无歧义
- [ ] 事件地点不是把大范围行动伪装成精确点
- [ ] 无重复地点、无孤儿外键、无陈旧 `reign_capitals`
- [ ] 生成与校验通过，地图和详情展示正确

表字段见 [eralens-period-import reference](../eralens-period-import/reference.md)。
