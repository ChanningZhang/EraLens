# 修复示例

## ✅ 正确：拆列写入

**现象**：李世民卡片主行应有「太宗」，详情庙号栏为空。

**错误做法**：在 `emperorAppellation.ts` 加 `if (personId === 'li-shimin') return '太宗'`。

**正确做法**（`data/imports/tang-…/generate.mjs` 或 rulers 源）：

```javascript
{
  personId: "li-shimin",
  name: "李世民",
  templeName: "太宗",
  posthumousName: "文武皇帝",
  title: "唐太宗",
}
```

`mergeAppellationsIntoPersons()` 会把庙谥合并进 `persons` 再导出 SQL。

---

## ✅ 正确：先秦私名与姓

**现象**：周武王副行显示「姬姬发」或「姬发」但姓重复。

**错误做法**：前端 `stripXing('姬', name)` 特判周王室。

**正确做法**：

```javascript
{
  id: "ji-fa",
  name: "姬发",           // 检索带姓
  ancestralXing: "姬",
  clanShi: null,
  posthumousName: "武王",
  title: "周武王",
}
```

副行由 `ancestral_xing` 去姓展示「发」。

---

## ✅ 正确：史称不进谥号列

**现象**：「汉少帝」被当成谥号显示。

**错误做法**：`posthumous_name = '少帝'`。

**正确做法**：

```javascript
{
  posthumousName: null,   // 或无正式谥号则 NULL
  title: "汉少帝",
}
```

---

## ✅ 正确：检索别名

**现象**：搜「姜子牙」找不到「吕尚」。

**错误做法**：API `WHERE name ILIKE` 加硬编码同义词表。

**正确做法**：

```sql
alt_names = ARRAY['姜子牙','姜尚']
```

---

## ❌ 反例：代码掩盖脏数据

```typescript
// 禁止
const DISPLAY_FIX: Record<string, string> = {
  "reign-qin-xianggong": "秦襄公",
  "chu-huaiwang": "楚怀王",
};
```

应改为：在 import 源补 `reigns.title = "襄公"` 或正确 `posthumous_name`。

---

## ❌ 反例：在 title 堆一切

```javascript
// 禁止：把庙号、谥号、年号全塞进 title，person 列全 NULL
title: "唐高宗天皇大帝大和孝皇帝",
```

应拆为 `temple_name`、`posthumous_name`、`era_names` 各列，title 保留通行简称 `唐高宗`。

---

## ❌ 反例：修 seed 冒充修库

```bash
# 禁止用于生产问题
vim data/seed/timeline.json
pnpm db:seed
```

应改 `data/imports/{slug}/` 并 `pnpm db:import`。
