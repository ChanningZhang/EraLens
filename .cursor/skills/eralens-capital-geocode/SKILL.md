---
name: eralens-capital-geocode
description: >-
  为 EraLens locations / location_mapping 表调研都城时段、用高德 MCP 地理编码并烘焙坐标进
  data/imports。Use when collecting dynasty capital locations, geocoding historical
  seats, or adding capital location mappings.
---

# EraLens 都城地理编码

都城起止日期遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)；本 Skill 的 `precision` 仅描述空间坐标定位精度。

为 `locations` 与 `location_mapping` 表补数据：调研都城时段 → 高德取点 → 写入对应包 `cache.json` → 统一生成 SQL。

`data/imports/dynasty-capitals/cache.json` 是都城事实与来源说明的唯一源文件：历史记录放入 `locationMappings`，坐标放入集中地点包 `data/imports/locations/cache.json` 的 `locations`，来源/编码说明放入其中的 `manifest.sources` / `manifest.notes`。不要另建重复坐标文件、raw 文件或包级生成脚本；生成的 `manifest.json` 和 `import.sql` 不手工修改。

**不要**在运行时 API 调高德；坐标与 `modernName` 一并写入 `data/imports/locations/cache.json` 的 `locations` 记录。

每次补充或修改都城数据，必须按 [来源维护](../eralens-period-import/SKILL.md#来源维护) 同步更新 capital 的 `links` 与 `manifest.sources`；地理编码说明不能替代历史依据，导入后核对都城详情“来源”栏。

## 前置

本机 Cursor 已配置 MCP **`user-amap-maps-streamableHTTP`**，主要工具：

| 工具 | 用途 |
|------|------|
| `maps_geo` | 结构化地址 → 经纬度（主用） |
| `maps_text_search` | 古城/遗址歧义时 POI 搜索 |
| `maps_regeocode` | 坐标反查，校验行政区 |

## 工作流

```
Task Progress:
- [ ] 1. 调研：核对维基/年表，确定 historical_name、时段、role
- [ ] 2. 写 modern_name：省/市全称（见下）
- [ ] 3. 高德取点：maps_geo → maps_regeocode 校验
- [ ] 4. 将核实后的坐标直接写入 `data/imports/locations/cache.json` 的 `locations` 记录，并维护历史包 `locationMappings`及 `manifest.sources` / `manifest.notes`
- [ ] 5. 运行统一生成器并用同目录缓存校验 SQL
- [ ] 6. 用 `apply-sql.sh` 单包增量导入，或按需执行全量 `pnpm db:import`
```

导入包只生成 PostgreSQL `import.sql`；单包增量导入生成该包后用 `apply-sql.sh`。全量 `pnpm db:import` 前先运行 `node data/imports/generate.mjs --all`；db:import 会清空并重载本地 PostgreSQL 后构建移动端 SQLite，但不会生成 SQL。Xcode 启动不会运行这条数据导入命令。

## modern_name 规范（必填）

必须写成 **`{省}{市}`** 或直辖市 **`北京市`** / **`上海市`** / **`天津市`** / **`重庆市`**。

| 正确 | 错误 |
|------|------|
| `陕西省西安市` | `西安` |
| `河南省洛阳市` | `洛阳市`（缺省） |
| `北京市` | `北京` |

能落到区县则写到区县，防止全国重名。

## 地理编码步骤

1. 确定完整 `modernName`（如 `陕西省西安市`）。
2. 调用 `maps_geo`：`address` = 完整 modernName，`city` = 市级简称 hint（如 `西安`）。
3. 用 `maps_regeocode` 反查返回坐标，确认 `province` / `city` 与 modernName 一致。
4. 歧义时用 `maps_text_search` + `maps_search_detail`，仍须落到唯一行政区全称。
5. 将 `longitude`、`latitude`（GCJ-02）直接写入 `cache.json`。
6. 在 `cache.json.manifest.notes` 记录 geocode 来源（地址串、日期）。

## 地点及 mapping 字段

缓存字段采用 camelCase（如 `historicalName`、`modernName`、`dynastyId`、`coordinateSystem`、`start`、`end`）；SQL 列名与缓存字段对应关系见 [eralens-period-import reference.md](../eralens-period-import/reference.md) 的 `locations / location_mapping` 节。

要点：

- `historical_name`：当时名称（长安、大都、临安）
- `kind` / `external_id`：引用王朝或在位实体；`location_id` 引用集中地点
- `role`：`primary` / `secondary` / `temporary`
- 地理表不保存 `claim_track`，并立治所归属在说明中表达，每条 reign mapping 显式关联一个在位 ID
- 时间：`start_abs` / `end_abs` 用 `absMonth()`；日期端点遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)
- `coordinate_system`：固定 `GCJ02`

## ID 约定

`cap-{dynasty}-{place-kebab}` 或迁都多次时 `cap-{dynasty}-{place}-{startYear}`。

示例：`cap-tang-changan`、`cap-ming-beijing`。

## 试点包

参考 [data/imports/dynasty-capitals/cache.json](../../../data/imports/dynasty-capitals/cache.json)。

地点 ID 永久保留，不因坐标修订重新计算；历史名称、说明、角色、时段和来源保存于 mapping。完整规范见 [地理信息 Skill](../eralens-geography-import/SKILL.md)。
