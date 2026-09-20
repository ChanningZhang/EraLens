# 数据修复参考

## persons / reigns 相关列（Prisma）

| DB 列 | 类型 | 说明 |
|---|---|---|
| `persons.name` | text | 检索用姓名，君主带姓 |
| `persons.alt_names` | text[] | 别名，供搜索 |
| `persons.ancestral_xing` | text? | 姓 |
| `persons.clan_shi` | text? | 氏 |
| `persons.posthumous_name` | text? | 谥号 CSV |
| `persons.temple_name` | text? | 庙号 CSV |
| `reigns.title` | text | 在位称号，常含国号 |
| `reigns.era_names` | text? | 年号 CSV |
| `reigns.preferred_appellation` | jsonb? | `{ kind: "regnal", name: "…" }` |
| `dynasties.ancestral_xing` / `clan_shi` | text? | 王朝默认姓氏（先秦） |

运行时称谓：`packages/shared/src/emperorAppellation.ts`  
先秦姓氏展示：`ancestral_xing` / `clan_shi` + `resolvePreQinPrivateName`  
导入合并庙谥：`data/imports/lib/sqlHelpers.mjs` → `mergeAppellationsIntoPersons()`

## 拆分流程（称谓类 bug）

对一条错误展示，按顺序提问：

1. **这是私名、谥号、庙号、年号、还是史称/封号？**
2. **国号是否应出现在展示主行？** 国号 → `reigns.title`；庙谥本体 → person 列。
3. **先秦吗？** 是 → 检查 `ancestral_xing` / `clan_shi` / `feudalClanMetadata.mjs`。
4. **是否仅个别时代用特殊称号？** 是 → `preferred_appellation`（regnal），不是代码分支。
5. **`name` 是否应能被搜索？** 需要别名 → `alt_names`。

## 先秦姓/氏

- 姓写入 `ancestral_xing`，氏写入 `clan_shi`；`persons.name` 前缀用**姓**，氏不进 `name` 前缀。
- 王朝级默认值在 `data/imports/lib/feudalClanMetadata.mjs`（带出处 URL）。
- `applyFeudalClanMetadata` 批量套用；`skipXingOnGivenName` / `bareGivenNames` 是**数据标记**，不是运行时 if-id。
- 审计：`node data/imports/lib/auditPreQinXingShi.mjs`

## 时间与在位

- 大批量 `*_abs` 用 `absMonth()` / `compute-abs.mjs`，禁止手填。
- 年精度继位切年：`data/imports/lib/deathYearSuccession.mjs`（见 period-import skill）。
- 年代失考：`start_date_confidence` / `end_date_confidence` = `interpolated` | `approximate`。
- 空白：`system-missing-ruler`（史料缺）vs 不写 reign（无国君）。

## 修改入口（按优先级）

1. **结构化源**：`rulers.mjs`、`capitals-raw.json` 等
2. **generate 逻辑**：`data/imports/{slug}/generate.mjs`（抽象函数，不嵌个案）
3. **共享 lib**：`data/imports/lib/*.mjs`（多包复用规则）
4. **直接 SQL**：仅当 generate 尚未覆盖且改动孤立；仍须回写源以免下次 generate 覆盖

禁止：在 `apps/web`、`apps/api` 加 `displayNameOverrides['li-shimin'] = …`。

## manifest notes 示例

```json
"notes": [
  "曹髦无谥，title 用高贵乡公；封号不写入 posthumous_name",
  "莒郊公本名狂，入库 name=己狂，姓己来自诸侯表"
]
```
