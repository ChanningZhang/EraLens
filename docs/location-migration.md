# 地理模型迁移（2026-10-03）

空间地点集中维护于 `data/imports/locations/cache.json`；历史包维护显式 `locationMappings`。PostgreSQL 和 SQLite 均使用 `locations` / `location_mapping`。SQLite schemaVersion=3，contractVersion=4。

首次迁移结果：193 个空间地点；224 条王朝 mapping、1,261 条在位 mapping、85 条事件 mapping，共 1,570 条。原有 1,257 对显式在位关联全部保留，另固化 4 对有效时间回退结果。5 个原 track 都城的 7 对关联全部保留。曲沃、隋末及南明的并立关联由各 reign 独立维护；仅 reign 保留 claimTrack。

地点初次按现代地名、七位小数坐标及坐标系完全一致去重。ID 固化后由源数据显式保存，生成器不会重新计算或合并。范阳相关记录现代地名的“古城址约略定位”注释归入原有定位说明，统一使用北京市，与同坐标点复用。

历史名称逐项保留古称，括号、现代对应地、宫殿及战役代表点说明保留在 note 或 modernName。例如中都、北平、上海等取所选地点的当时名称；1370 年后的和林/哈拉和林保留同址别称，赫图阿拉不拼接后世兴京。上都的 1271–1273 段及盛京的 1636–1644 段仅保留时段内名称；1260–1368 的开平/上都、1625–1635 的沈阳/盛京仍覆盖真实改名时点。同址别称包含新田/新绛、东都/东宁、邺/安成府、范阳/燕京、洛阳/周京，保留原记录来源及说明。

名称取舍新增来源：[正蓝旗政府（1263 年改上都）](https://www.zlq.gov.cn/zlq/mlzlq/ysdwh/ysdyz/a2734909246a4c1290578dd4d88aa954/index.shtml)、[故宫博物院（赫图阿拉与后世兴京）](https://www.dpm.org.cn/lemmas/244892.html)。旧 manifest 注释作为处理历史保留，新增迁移注释说明现行模型。

迁移采用事务内回填与行数核对，保留既有主库实体及有效记录，随后删除旧三表和事件旧地点列。多态归属触发器验证实体存在、父实体删除/改 ID 的关联维护；空间外键及唯一约束拒绝孤儿和重复地点。迁移兼容本地存量的额外 events.location_capital_id 外键。未通过检查时事务回滚。

验证覆盖：现有库升级、空白库全量导入、显式地点跨包引用、同地点多时段、名称与来源、无孤儿关系、增量导入幂等、共享/Web 测试及 HTTP/SQLite 契约。迁移前后 1,106 段有效君主都城任期及边界完全一致。历史实体数据原有的库/源差异保持原范围，未用全量重灌覆盖主库。

可重复执行的审计入口：

```bash
node data/imports/lib/auditPackageOwnership.mjs
node data/imports/generate.mjs --all
pnpm --filter @eralens/api exec tsx scripts/validate-location-migration.ts --baseline=<tenures-before.json> --db=<upgraded.sqlite>
node scripts/test-location-incremental.mjs --db=eralens_locations_<isolated-db>
pnpm data:mobile:contract
```

`apps/api/scripts/test-location-integrity.sql` 在隔离库用回滚事务检查外键、多态引用、缺少角色和重复地点拒绝行为。升级前 SQL、SQLite、缓存及任期快照保存在工作区 `.build/backups/20261003-locations/`（不进入 Git）。主库通过 Prisma 增量迁移升级，SQLite 随后从主库重建。
