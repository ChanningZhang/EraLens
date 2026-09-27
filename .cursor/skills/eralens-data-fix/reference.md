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
| `reigns.title` | text | 卡片称号/史称（先秦去国号如 `禹`；帝制如 `唐太宗`、`少帝`） |
| `reigns.era_names` | text? | 年号 CSV |

运行时称谓：`packages/shared/src/emperorAppellation.ts`  
先秦姓氏展示：`ancestral_xing` / `clan_shi` + `resolvePreQinPrivateName`  
源缓存字段直接写入：在对应导入包 `cache.json` 中维护 `persons.posthumousNames`、`persons.templeNames` 和 `reigns.title`。

## 拆分流程（称谓类 bug）

对一条错误展示，按顺序提问：

1. **这是私名、谥号、庙号、年号、还是史称/封号？**
2. **国号是否应出现在展示主行？** 国号 → `reigns.title`；庙谥本体 → person 列。
3. **先秦吗？** 是 → 检查 `cache.json` 中对应人物的 `ancestralXing` / `clanShi`。
4. **是否仅个别时代用特殊称号？** 是 → 写入 `reigns.title`（regnal 本体），不是代码分支。
5. **`name` 是否应能被搜索？** 需要别名 → `alt_names`。

## 先秦姓/氏

- 姓写入 `ancestral_xing`，氏写入 `clan_shi`；`persons.name` 前缀用**姓**，氏不进 `name` 前缀。
- `ancestralXing`、`clanShi` 及适用数据标记直接写入 `cache.json`；SQL 生成不补默认值。
- 审计：`node data/imports/lib/auditPreQinXingShi.mjs`

## 时间与在位

- 大批量 `*_abs` 用 `absMonth()` / `compute-abs.mjs`，禁止手填。
- 年精度继位切年：按 period-import skill 的规则核定后直接修正 `cache.json` 中的日期。
- 年代由导入者推算或插值：`start_date_confidence` / `end_date_confidence` = `interpolated` | `approximate`。来源原文记作“约某年 / 约前某年”时，按该年作为确定年桶入库，不加 confidence 标记。
- 空白：`system-missing-ruler`（史料缺）vs 不写 reign（无国君）。

## 修改入口（按优先级）

1. **JSON 源缓存**：`data/imports/{slug}/cache.json`
2. **manifest**：`data/imports/{slug}/manifest.json`（来源、争议与年代取舍）
3. **共享 SQL 输出器**：`data/imports/lib/sqlHelpers.mjs`（只维护通用序列化规则）
4. **直接 SQL**：仅作生成产物；修复应回写 JSON 缓存

禁止：在 `apps/web`、`apps/api` 加 `displayNameOverrides['li-shimin'] = …`。

## manifest notes 示例

```json
"notes": [
  "曹髦无谥，title 用高贵乡公；封号不写入 posthumous_name",
  "莒郊公本名狂，入库 name=己狂，姓己来自诸侯表"
]
```
