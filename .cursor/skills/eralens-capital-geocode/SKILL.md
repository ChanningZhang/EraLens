---
name: eralens-capital-geocode
description: >-
  为 EraLens dynasty_capitals 表调研都城时段、用高德 MCP 地理编码并烘焙坐标进
  data/imports。Use when collecting dynasty capital locations, geocoding historical
  seats, or adding rows to dynasty_capitals.
---

# EraLens 都城地理编码

为 `dynasty_capitals` 表补数据：调研都城时段 → 高德取点 → 烘焙进 `generate.mjs` → 生成 SQL 导入。

**不要**在运行时 API 调高德；坐标与 `modern_name` 一并写入 `data/imports/{slug}/`。

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
- [ ] 4. 写入 generate.mjs，运行 node generate.mjs
- [ ] 5. 校验：node .cursor/skills/eralens-period-import/scripts/validate-import.mjs
- [ ] 6. 入库：pnpm db:import 或 scripts/apply-sql.sh
```

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
5. 将 `longitude`、`latitude`（GCJ-02）硬编码进 `generate.mjs`。
6. 在 `manifest.json` 的 `notes` 记录 geocode 来源（地址串、日期）。

## dynasty_capitals 字段

见 [eralens-period-import reference.md](../eralens-period-import/reference.md) 的 `dynasty_capitals` 节。

要点：

- `historical_name`：当时名称（长安、大都、临安）
- `dynasty_id`：引用已有 `dynasties.id`
- `role`：`primary` / `secondary` / `temporary`
- `claim_track`：并行政权都城时与 `reigns.claim_track` 同一 key
- 时间：`start_abs` / `end_abs` 用 `absMonth()`；年精度起 1 月、迄 12 月
- `coordinate_system`：固定 `GCJ02`

## ID 约定

`cap-{dynasty}-{place-kebab}` 或迁都多次时 `cap-{dynasty}-{place}-{startYear}`。

示例：`cap-tang-changan`、`cap-ming-beijing`。

## 试点包

参考 [data/imports/dynasty-capitals/generate.mjs](../../../data/imports/dynasty-capitals/generate.mjs)。
