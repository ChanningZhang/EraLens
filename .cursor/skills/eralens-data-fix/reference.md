# 数据修复参考

## persons / reigns 相关列（SQLite）

| DB 列 | 类型 | 说明 |
|---|---|---|
| `persons.name` | text | 常用姓名；先秦人物不带已单列到姓/氏字段的前缀 |
| `persons.alt_names` | JSON text | 别名，供搜索 |
| `persons.ancestral_xing` | text? | 姓 |
| `persons.clan_shi` | text? | 氏 |
| `persons.posthumous_name` | text? | 谥号 CSV；先秦仅谥字，爵称放 persons.title |
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

- 姓写入 `ancestral_xing`，氏写入 `clan_shi`；先秦 `persons.name` 只写私名/常用名，不重复姓或氏。未知姓名仍写 `？`，不拼接姓氏。
- 搜索词由数据库根据 `ancestral_xing` / `clan_shi` 与 `name` 组合生成；需要补充通行叫法时写入 `alt_names`。
- `ancestralXing`、`clanShi` 及适用数据标记直接写入 `cache.json`；SQL 生成不补默认值。
- 审计：`node data/imports/lib/auditPreQinXingShi.mjs`

## 时间与在位

- 大批量 `*_abs` 用 `absMonth()` / `compute-abs.mjs`，禁止手填。
- 年精度继位切年：按 period-import skill 的规则核定后直接修正 `cache.json` 中的日期。
- 年代由导入者推算或插值：`start_confidence` / `end_confidence` = `interpolated_by_other`, `interpolated_by_generation` 或对应 approximate confidence。来源原文记作“约某年 / 约前某年”时，按该年作为确定年桶入库，不加 confidence 标记。
- 空白：`system-missing-ruler`（史料缺）vs 不写 reign（无国君）。

## 修改入口（按优先级）

1. **JSON 源缓存**：`data/imports/{slug}/cache.json`
2. **manifest**：缓存内的 `manifest.sources` / `manifest.notes`（来源、争议与年代取舍）
3. **共享 SQLite 输出器**：`data/imports/lib/sqlitePackageRows.mjs`（只维护通用序列化规则）
4. **直接 SQL**：仅作生成产物；修复应回写 JSON 缓存

禁止：在 `apps/web`、`apps/api` 加 `displayNameOverrides['li-shimin'] = …`。

## cache.json 中的 manifest notes 示例

```json
"manifest": {
  "sources": [{ "label": "《左传》昭公三十一年", "url": "https://example.invalid/source" }],
  "notes": [
  "曹髦无谥，title 用高贵乡公；封号不写入 posthumous_name",
  "莒郊公本名狂，入库 name=狂，姓己写入 ancestral_xing"
  ]
}
```

该对象位于包 `cache.json` 顶层；`manifest.json` 是统一生成器写出的副本，不直接编辑。

先秦称谓约定：`posthumousNames: ["庄"]`、`title: "庄公"`；卡片大字优先级为 `reigns.title → persons.title → posthumousNames → persons.name`；卡片小字按 `reigns.title → persons.clan_shi + persons.name` 取值（氏为空时仅显示本名，本名为空时不拼接氏），跳过与大字相同的候选。详情大字在 `persons.name` 非空时显示 `persons.clan_shi + persons.name`（氏为空时仅显示本名），本名为空时按 `posthumousNames → persons.title` 回退。详情称呼有 reign 焦点时按 `reigns.title → persons.title → posthumousNames` 取值；无焦点仍为谥字 → persons.title。

无可靠谥号记载的先秦人物：`name: "车辅"`、`title: "邾子车辅"`、`posthumousNames: []`。完整称呼允许含国名与本名，不能仅存「子」「侯」「君」等孤立爵称；单字本名和通称不按长度机械扩写。
