---
name: eralens-data-fix
description: >-
  修复 EraLens 历史数据问题：在 data/imports 源数据与 SQLite 内容快照层纠正字段，禁止用代码 hardcode
  掩盖脏数据。Use when the user reports wrong names, titles, dates, duplicates, missing
  reigns, display bugs caused by bad import data, or asks to fix/clean historical records.
---

# EraLens 数据修复

涉及日期值、端点精度、历法或置信度的修复遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。

修复展示、检索、时间轴上的历史数据问题。**默认改数据，不改渲染逻辑。**

## 铁律

1. **任何数据修复任务，都不允许在代码中 hardcode。**
2. **对于人名称呼问题，库里有姓、氏、名、谥号、庙号等列，你应该识别出对应的信息，放入正确的列里。**
3. **不允许在混乱的数据上做各种 hardcode。**

与 [AGENTS.md](../../../AGENTS.md) 一致：绝大部分逻辑基于抽象规则；代码层面对单个王朝、帝王、事件的 `if (id === …)` 分支须用户明确同意。展示问题先查数据，再查渲染。

## 触发后先定性

向用户确认（可推断则省略）：

| 项 | 说明 |
|---|---|
| 现象 | 卡片错字、称谓错、叠卡、空白、年份错、检索不到等 |
| 实体 | `person_id` / `reign_id` / `dynasty_id` 或页面截图 |
| 范围 | 单条 / 某朝 / 某 import 包 |

**三分法**（必须先做）：

1. **数据错**：字段填错列、缺列、重复行、年代与史料不符 → 走本 skill，改 `data/imports/`。
2. **导入残留**：同 id 或同名宽跨度旧行 → 核对快照与全部所有者源包，修源缓存并通过 `pnpm db:import` 更新现有内容库。
3. **渲染规则**：数据已正确仍显示错 → 才查 `@eralens/shared` / 前端；若需新规则，写抽象逻辑，不写个案分支。

```bash
# 查询已构建的本地内容快照
sqlite3 data/mobile/eralens-content.sqlite \
  "SELECT id,name,ancestral_xing,clan_shi,posthumous_name,temple_name FROM persons WHERE id='…';"
```


## 工作流

```
Task Progress:
- [ ] 1. 核对史料（维基/正史），不要只信当前缓存值
- [ ] 2. 对照 schema，判定每个字符串应进哪一列
- [ ] 3. 直接改 `data/imports/{slug}/cache.json`，来源/取舍写入该文件的 `manifest.sources` / `manifest.notes`
- [ ] 4. 重新生成包 SQL → `pnpm db:import` 更新现有内容库并校验
- [ ] 5. 跑审计脚本 + 浏览器验收
```

各包 `cache.json` 是事实源，字段为 camelCase；来源与说明放在缓存的 `manifest.sources` / `manifest.notes`，生成器据此输出 `manifest.json` 与 SQLite `import.sql`。校验器从同目录缓存检查接续边界；失败时修缓存并重生成，不能直接修改 SQL。普通数据修复运行 `pnpm db:import`，在事务中更新现有内容库并校验。重建限制、重建后重启 API 及验收要求遵循项目 `AGENTS.md`。Xcode 启动不执行导入命令。

### 1. 调研

- 用 WebSearch / 百科 / 正史核对**原始**起迄年与姓名结构。
- 日期核实、插值与置信度统一遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。修复时不能仅因多数年份失载而只建一条无君主的泳道。
- 改年、切年、正统窗口前，用来源的**原始在位年**，不要在已后移过的日期上再切。
- 处理相邻时间段必须调用 `packages/shared/src/timelineOwnership.ts`；区间端点和混合精度归属遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。真正并存的数据保留并行，并通过 `claim_track` 或实体语义分组表达。
- 争议取舍写入对应 `cache.json.manifest.notes`，并在 `cache.json.manifest.sources` 附来源。
- 修复事实时必须同步核对并更新条目来源，按 [来源维护](../eralens-period-import/SKILL.md#来源维护) 更新适用记录的 `links` 与所属包的 `manifest.sources`，不能修完正文或日期却遗漏详情“来源”栏。

### 2. 修哪里

| 层级 | 允许 | 禁止 |
|---|---|---|
| `data/imports/{slug}/` | ✅ 源数据、generate、SQLite SQL | — |
| `pnpm db:import` / `pnpm data:validate` | ✅ 更新现有内容库与校验完整快照 | ❌ 普通数据修复随意重建文件 |
| `data/seed/*.json` | — | ❌ 不修生产数据 |
| 前端 / API 映射 | 仅当数据已正确 | ❌ 用 hardcode 掩盖脏数据 |
| `@eralens/shared` | 抽象规则、schema | ❌ 单实体特例（须用户同意） |

找到实体所属的 import 包：优先在 `data/imports/**/cache.json` 中搜人物 / 在位 ID，确认实体来源后直接修改缓存。

### 3. 生成与入库

```bash
node data/imports/generate.mjs {slug}
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/{slug}/import.sql
pnpm db:import
```

新包或字段约定不明时，同时阅读 [eralens-period-import](../eralens-period-import/SKILL.md)。

### 4. 审计（称谓 / 先秦姓氏）

```bash
node data/imports/lib/auditImperialAppellationFields.mjs   # 唐+ 缺庙谥
node data/imports/lib/auditPreQinXingShi.mjs               # 先秦姓/氏
```

## 人名与称谓：列职责

王朝 `alt_names` 与人物别名用途不同：首项为核实后的国号或自称；人物归属以 `persons.dynasty_id` 记录，人物详情副标题通过该 ID 实时读取王朝 `alt_names[0]`。其余王朝别名保留史称、地域名称及检索词。首项允许与王朝 `name` 相同。跨改号时期的静态首项取舍写入所属包 `manifest.notes`，来源写入 `manifest.sources`；三皇、五帝等无统一政权自称的集合记录清空 `altNames`，隐藏副标题。不得在生成器或前端按王朝 ID 自动改写自称。分时名称王朝例外：`name` 是仅含 `periods` 的 JSON 字符串，代表名称统一放在 `altNames[0]`，原自称保留在后续别名。人物与在位详情取代表名称，泳道按时点解析；普通名称保持现有规则。

**原则：拆开识别，各归其列。** 不要把谥号写进 `name`，不要把私名塞进 `title`，不要指望运行时代 `title` 反推庙谥。

| 列 | 存什么 | 不存什么 |
|---|---|---|
| `persons.name` | 常用可检索姓名；先秦人物不带已拆入结构化字段的姓或氏（如存 `狂`，不存 `己狂`） | 先秦姓/氏前缀、谥号/庙号/年号、国号前缀 |
| `ancestral_xing` | 姓（姬、姜、嬴） | 氏、国名 |
| `clan_shi` | 氏（齐、晋、赵） | 姓 |
| `posthumous_name` | 谥号本体 CSV（`武王`、`孝文皇帝`） | 国号、`少帝`/`末帝`/`后主` 等史称 |
| `temple_name` | 庙号本体 CSV（`太宗`、`高祖`） | 国号 |
| `reigns.title` | 泳道卡片称号/史称（先秦去国号如 `禹`；帝制如 `唐太宗`、`少帝`；明清预存年号式卡片称呼） | 不应替代庙谥列 |
| `reigns.era_names` | 完整年号 CSV（`贞观,永徽`），用于事实展示 | 不参与运行时称呼选择 |
| `alt_names` | 检索别名（`姜子牙` → `lv-shang`） | 与 `name` 重复的私名 |
| `bio` | 生平、本名异体、争议说明 | 不应替代正规列 |

### 概述叙事风格

帝王与人物概述的内容、文风、开国经历及史料边界统一遵循 [人物与帝王概述](../eralens-reign-import/SKILL.md#人物与帝王概述)。保持中立、简洁的资料式口吻，按人物经历选择起笔与叙述顺序，不统一句式或套用固定模板；主要事迹的数量以必要事实完整为准。修复开国帝王概述时须核对建国前的经历与因果，不能仅补身世或建国后的功绩。清除维基导言清洗产生的空括号、残缺姓名、模板标记或省略号。

**展示规则（只读库，不在修复时破坏）**：

- 泳道卡片小字优先显示非空 `reigns.title`；title 为空时按年代选择人物庙谥：唐代起（包括明清）庙号优先于谥号，唐以前谥号优先。`reigns.era_names` 不参与称呼选择。
- 明清皇帝的年号式泳道卡片称呼在导入时预先写入 `reigns.title`；`era_names` 仍保存完整年号列表，供详情事实展示和数据检索使用。朱元璋吴王段（`吴`）、努尔哈赤（`太祖`）、皇太极（`太宗`）保留原称号例外。
- 人物详情页不优先 `reigns.title`：按在位起始年选择庙谥，唐以前谥号优先，唐代起（包括明清）庙号优先，再回退到另一种庙谥，随后依次回退 `reigns.title`、`persons.title`、人物姓名。此规则与泳道卡片优先 title 的规则分开维护。
- 先秦在位卡片大字与人物详情大字统一按 `persons.posthumous_name` → `persons.title` → `persons.name` 回退；卡片副行仍从不带姓氏的 `persons.name` 读取私名，结构化姓氏用于检索和相关展示。
- 先秦 `persons.ancestralXing` / `persons.clanShi` 直接写入时期包 `cache.json`；不要在生成时套模板或人物覆盖。

字段细则与 INSERT 模板见 [reference.md](reference.md)；正反例见 [examples.md](examples.md)。

## 常见数据病与正确修法

| 症状 | 根因 | 修法 |
|---|---|---|
| 卡片显示「唐太宗」但详情无庙号 | 庙号只在 `title` | 写入 `persons.temple_name = '太宗'` |
| 姓氏在先秦副行重复 | `name` 已含结构化的姓或氏 | 保留 `ancestral_xing` / `clan_shi`，从 `name` 去掉重复前缀；检索组合由结构化字段生成 |
| 史称「少帝」当谥号显示 | 误写入 `posthumous_name` | 移到 `title`，清空 `posthumous_name` |
| 检索「姜子牙」无结果 | 未建 `alt_names` | 加 `alt_names`，不改 API 特判 |
| 上下叠两张卡 | 库内重复 `reign` / 旧宽跨度行 | 缓存去重或合并，禁止 CSS 遮盖 |
| 年份与维基不一致 | 源数据错或未按死年继位规则切年 | 核对史料后直接修正 `cache.json` 的日期与对应 `*_abs` |
| 空白该不该填 | 未定性 | 史料缺 → `system-missing-ruler`；无国君 → 不写 reign |

## 何时可以改代码

仅当**多条记录共用同一抽象规则**且数据已规范仍无法满足时：

1. 在 `@eralens/shared` 或 `data/imports/lib/` 写规则（阈值、字段读取顺序、schema）。
2. 用数据标记表达例外（`reigns.title`、`claim_track`、端点 confidence 等）。
3. **单实体特例必须用户书面同意**；否则一律回到数据层修。

## 验收

- [ ] 审计脚本无新增告警（或 notes 解释例外）
- [ ] `validate-import.mjs` 通过
- [ ] 时间轴卡片、详情抽屉、搜索、tooltip 与史料一致
- [ ] 本次修复依据已同步到 `manifest.sources` 与适用条目的 `links`，详情“来源”栏已核对
- [ ] 概述修复符合统一的[概述规则](../eralens-reign-import/SKILL.md#人物与帝王概述)及验收项；批量修订时抽查不同崛起路径、史料边界与连续条目的句式重复情况
- [ ] diff 中无 `if (personId ===` / `if (reignId ===` 式个案（除非用户已批准）

## 延伸阅读

- [reference.md](reference.md) — 字段映射与拆分步骤
- [examples.md](examples.md) — 正确修复 vs hardcode 反例
- [eralens-period-import](../eralens-period-import/SKILL.md) — 入库与 AbsMonth
- [AGENTS.md](../../../AGENTS.md) — 项目总规范
