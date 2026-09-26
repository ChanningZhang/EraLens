---
name: eralens-reign-import
description: >-
  为 EraLens 添加、补齐或丰富君主在位记录，核对人物称谓、起讫日期、年号、正统、并立和失考区间，
  并生成和导入 reign 数据。Use when the user asks to add rulers or reigns, fill missing reign
  information, correct succession dates, add era names or titles, or enrich an existing dynasty lane.
---

# EraLens 在位信息添加与丰富

只处理人物与 `reigns` 直接相关的数据。完整时期导入使用
[eralens-period-import](../eralens-period-import/SKILL.md)；既有错误修复还应遵守
[eralens-data-fix](../eralens-data-fix/SKILL.md)。

## 铁律

1. 先搜索维基百科、正史、可靠年表、考古或学术资料，不能只凭现有生成器补数据。
2. 修 `data/imports/{slug}/` 的源数据和生成器，不改 `data/seed/*.json`，不在前端/API 写单一人物特判。
3. 所有对象共用 `Reign`、`reignSql()`、`layoutLaneReignBar` 和 `timelineOwnership.ts`；不得为缺载、短祚或某朝另造一套坐标/裁定。
4. `*_abs` 必须由 `absMonth()` 或共享助手计算，禁止手填生成列 `span`。

## 调研与盘点

1. 明确王朝、时间窗、已有 reign 和需要丰富的字段。
2. 搜索 `person_id`、`reign_id`、姓名和称号，避免重复人物或宽跨度旧 reign。
3. 保留来源的**原始起迄年/月/日**，再做接续裁定；不要在已后移的数据上二次切年。
4. 列出连续世系、可考锚点、真正并立、无国君时段和史料缺区段，并在写数据前完成定性。

## 时间与继位

- 年精度顺序继位默认“死年整年归旧王，新王从下一年起算”。年月只是年桶占位，不把公历 1 月 1 日冒充即位日。
- 以下情况不机械后移：一年短祚、史料明确未逾年改元、真正并立/旁支、同年内有可核时长。已知月日时按史料月日。
- 混合精度和相邻区间统一走 `packages/shared/src/timelineOwnership.ts`，底层由 `timelineIntervals.ts` 按日历日执行边界归属。生成器、API、布局和详情不得另写 `+1 年/月` 或端点判断。
- 农历月日不得直接当公历。只有可靠换算后才写公历月日，并记录原记载和换算依据；否则按已知精度录入。
- 来源只写“约某年”时仍按该年桶记录，不加 `approximate` confidence。只有导入者推算、插值或来源给出跨年/冲突范围，才标不确定。

## 空白与失考

先定性再建模：

- **史料缺**：相邻可考君主之间确有应有国君的历史空白，但史料完全不能确认中间君主人数或世次。写普通 reign，`person_id='system-missing-ruler'`、`title='史料缺'`，id 为 `reign-missing-{dynasty}-{start-year}`。
- **已知有若干失名君主**：谱系、世次或其他材料明确可知两位已知君主之间有 N 任君主，即使姓名失载，也必须逐任建立独立普通 reign 和独立 person（如滕国的 `persons.name='？'`、`reigns.title='？'` 形式）。姓名未知时，数据层 `persons.name` 只存 `？`，不拼姓氏；姓氏仍由 `ancestral_xing` 等专用字段表达。按共同锚点顺序分配区间时标 `interpolated`。不得用 `system-missing-ruler` / “史料缺”代替已知任数的君主。
- **无国君**：亡国、尚未复立、改朝换号或该行本不设君。不写 reign，自然留白。
- **年代失考**：知道是谁但边界为推算/均分。使用 `start_date_confidence` / `end_date_confidence` 的 `approximate | interpolated`，不用“史料缺”占位。
- **资料未收齐**：继续查证，不能因为当前深度不足就标成“史料缺”。

若世系连续但多数王年失载：交叉核对若干可考君主、明确纪事或可靠年表作为共同起讫锚点；将同一锚点窗口内的连续世次按顺序均分，标 `interpolated`。锚点自身及贴着确定锚点的边保持确定。世系中断、锚点不足、不共时或只剩传统积年时，不跨断层插值，并在 manifest notes 写清无法填充的区段。

日历相接的两王交界两侧必须同为失考或同为确定；使用 `alignReignSeamConfidences.mjs` / `validateReignSeams.mjs` 检查。灭国留白不相接，各自保留自己的边界状态。

## 并立、主线与正统

- 前任仍在位时另一政权另立，或同年真实分立：填 `claim_track`、`claim_label`，`claim_role='rival'`。
- 前帝身后才即位，即使由权臣拥立，也走主线，不填 `claim_track`。
- 主行上的非约定正统代政可不填 track，但标 `claim_role='rival'`；不要串入通行 succession。
- `is_main` 只标正统覆盖窗口；并立 track 与 `claim_role='rival'` 不标主线。不得给王朝写 `color_token='gold'`。
- 正统覆盖窗口按以下项目约定维护；需要切段时基于原始史料日期，不从已经裁过的日期再切：
  - 大一统自起始即为正统：商周、东汉、西东晋、隋唐、武周、南北宋、明、中华民国、中华人民共和国；夏自启（家天下）起，禹受禅不上金。
  - 延迟起算：秦自前221年；西汉自刘邦称帝（前202年2月），沛公/汉王阶段不上金；清自1644年福临起，努尔哈赤、皇太极不上金；元自1276年2月宋恭帝降起，忽必烈定国号至降宋前不上金。
  - 截断：隋可覆盖至618年末（含江都杨浩）；元止于1368年；南宋止于1276年2月，端宗、帝昺不上金。
  - 并立 track、主行 `claim_role='rival'`、王莽/更始不上金；魏蜀吴称帝前不建帝王卡。

## 人物、称谓与字段

- `persons.name` 保存可检索全名；君主入库须带姓。先秦同时维护 `ancestral_xing` / `clan_shi`。
- `persons.posthumous_name`、`persons.temple_name` 只存谥号/庙号本体，不带国号；多值用逗号 CSV。
- `reigns.era_names` 存年号 CSV。自汉武帝起使用；不要再建 `era_names` 子表。
- `reigns.title` 存其余卡片称号/史称。少帝、末帝、后主不是谥号；无谥号的先秦称号写不带国名本体。
- 明清普通皇帝 `title` 留空，卡片优先取年号；仅 `AGENTS.md` 明列的三条记录保留 title。
- **人物/在位概述不能过于简单**：`bio` 应简略交代人物身份与世系/继承背景、主要相关人物或政权关系、在位年代，以及能说明其历史脉络的关键事迹或转折。保持精炼但信息完整，不能只写身份标签、单句评价或空泛结论；资料不足时如实限定，不补造细节。
- `bio` 只写历史内容，不写收录方法、年代插值或绘制规范；这些写进 manifest notes。
- 修改人物、reign 归属/称号或王朝名后，确认 `persons.search_terms` 触发器刷新；批量改写后执行 `SELECT rebuild_person_search_terms();`。

## 工作流

```text
Task Progress:
- [ ] 1. 查史料并保存原始年代、世系、称谓和来源
- [ ] 2. 盘点现有人物/reign，定性空白与并立
- [ ] 3. 修改 data/imports/{slug}/ 的人物和 reign 源数据
- [ ] 4. 运行 generate.mjs
- [ ] 5. 校验 import.sql、接续边界和称谓字段
- [ ] 6. 增量导入或全量重灌
- [ ] 7. 验收卡片、搜索、详情、正统色与并立布局
```

优先使用 `data/imports/lib/reignSql.mjs`、`reignDateHelpers.mjs`、`deathYearSuccession.mjs`、`build-rulers.mjs` 和 `sqlHelpers.mjs` 的共享能力，不复制规则。

```bash
node data/imports/{slug}/generate.mjs
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/{slug}/import.sql
node data/imports/lib/auditImperialAppellationFields.mjs
node data/imports/lib/auditPreQinXingShi.mjs
.cursor/skills/eralens-period-import/scripts/apply-sql.sh data/imports/{slug}/import.sql
```

## 验收

- [ ] 无重复 person/reign，无未定性的空白
- [ ] 原始史料日期与接续裁定可追溯，精度和 confidence 正确
- [ ] 插值只发生在连续世系与可信共同锚点之间
- [ ] 人物/在位概述简洁说明身份背景、相关人物、在位年代和关键历史脉络
- [ ] 并立、主线、`is_main` 与 `claim_role` 语义正确
- [ ] 姓氏、谥号、庙号、年号、title 各归其列
- [ ] 校验和审计通过，卡片、详情、搜索、tooltip 均符合预期

字段模板见 [eralens-period-import reference](../eralens-period-import/reference.md)，正反例见
[eralens-data-fix examples](../eralens-data-fix/examples.md)。
