---
name: eralens-geography-import
description: >-
  为 EraLens 添加或丰富历史地理信息，包括王朝都城、在位与都城关联、事件地点、古今地名、坐标和定位争议，
  并生成和导入地理 SQL。Use when the user asks to add geography, capitals, historical places,
  event locations, coordinates, modern place names, migrations of capitals, or map data.
---

# EraLens 地理信息添加与丰富

日期遵循 [日期处理](../eralens-date-handling/SKILL.md)，字段见 [reference](../eralens-period-import/reference.md)。

## 源数据与职责

- `data/imports/locations/cache.json` 的 `locations` 集中维护稳定 ID、`modernName`、`longitude`、`latitude`、`coordinateSystem`。只有这个包写入空间记录。
- 各历史包的 `locationMappings` 维护 `id`、`locationId`、`kind`（dynasty/reign/event）、`externalId`、`historicalName`、`note`、`links`、`spatialPrecision`；都城 mapping 另有 `start`、`end` 和 `role`。
- mapping 独立 ID 是详情和搜索引用。王朝、在位、事件分别引用对应实体 ID；跨包地点引用允许，但同一行只能有一个所有者。
- 两张地理表不含 `claimTrack`。`reigns.claimTrack` 仍负责泳道分组及继位边界；并立治所的政治语义写入 mapping 说明。
- 生成器只校验和序列化显式记录，不推断、复制或补造关联。旧 `capitals`、`reignCapitals`、`eventLocations` 和 `events.locationId` 均已停用。

## 调研与名称

1. 核对正史、地方志、政府文保资料、考古报告或学术资料中的古称、今址、适用时段与定位争议，不能仅凭现代同名城市取点。
2. `historicalName` 只含对应时期的古称。禁止括号、现代对应地、遗址说明、都城角色、战役名或“代表点”等解释；解释移入 `note`，现代地名归 `modernName`。
3. 同址且在记录时期内有史料支持的别称可用 `/` 连接、去重。不要把宫殿与城市、不同地点或后世名称机械拼接。逐条核对原来源，不能统一删括号推导古称。
4. 路线、流域及多地点战役选有依据的代表点，用该点当时名称，并在 `note` 说明范围及代表点的局限。无法可靠定位时保持无关联。
5. 新增事实的直接来源写入 `links` 和所属缓存 `manifest.sources`；处理方法及取舍写入 `manifest.notes`，历史概述只写事实。

## 地点复用与坐标

- 初次迁移按现代地名、七位小数坐标和坐标系完全一致去重。ID 固定后修订名称或坐标仍使用原 ID，不重新计算 ID、不自动合并；不同遗址不能仅凭近似坐标合并。
- 中国都城现代地名使用完整省市名称，可继续细化到区县、遗址；直辖市写“北京市”等全称。
- 坐标与 `coordinateSystem` 必须匹配。都城既有点使用 GCJ02，事件既有点使用 WGS84；复用必须确认同址且坐标系一致。
- 不把行政区中心冒充遗址坐标。`spatialPrecision` 与日期 confidence 独立；约略点记录误差及争议。转换坐标必须可复现并注明方法。
- 历史名称、说明和来源属于 mapping，空间实体不承载某一个历史时期的名称。

## 都城与事件关联

- `role` 为 primary（所属政权京师）、secondary（陪都）、temporary（行在），不表示正统。并立治所必须在说明中明确所属支系及其受封、争位等阶段。
- dynasty mapping 供王朝地点及地图使用；每条 reign mapping 只属于一个在位 ID。无固定都城者保持无关联。
- reign mapping 保存原都城完整时段，展示时以共享日期交集及继位边界裁剪。禁止运行时按王朝、track 或重叠日期回退匹配。
- 在位或都城任一端点近似、插值等不确定时，不新增推断关联；详情不生成都城任期，仍显示在位事实。
- 同地多时段及不同角色可建立不同 mapping；不同地点或真实并立时段保留并行关系，不手写 `+1` 截断。
- event mapping 的日期取所属事件，不另存 start/end/role。一个事件可以有多个有依据的地点 mapping。

## 工作流

1. 核对历史实体、时间窗、名称、角色、坐标与来源。
2. 查集中地点包，复用确认一致的地点或增加永久 ID。
3. 在唯一所有者历史包写入显式 `locationMappings`，同步来源和说明。
4. 执行全量行所有权及外键审计，再生成 SQL。
5. 先导入新增地点，再导入引用它的历史包；更新完整关联集合时只清理自己拥有的 mapping ID。
6. 验收地图、君主任期、详情、搜索及来源。

```bash
node data/imports/lib/auditPackageOwnership.mjs
node data/imports/generate.mjs {slug}
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/{slug}/import.sql
```

修改唯一所有者包后运行 `pnpm data:build` 和 `pnpm data:validate`，生成的 SQL、manifest 不手改。全量内容库按缓存重建，无需数据库服务。

验收包括稳定 ID、无重复空间记录、无孤儿关联、来源保留、历史名称规范、时段及并立记录正确，以及重复增量导入幂等。
