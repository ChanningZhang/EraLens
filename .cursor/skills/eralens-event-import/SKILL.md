---
name: eralens-event-import
description: >-
  为 EraLens 调研、筛选、添加或丰富历史事件及其王朝、人物、地点关联，并生成和导入事件 SQL。
  Use when the user asks to add historical events, enrich event details, dates, participants,
  dynasty links, event locations, or audit whether an event belongs on the timeline.
---

# EraLens 事件添加与丰富

只处理事件及其直接关联。新建完整时期包时仍使用
[eralens-period-import](../eralens-period-import/SKILL.md)；需要单独补地点时同时使用
[eralens-geography-import](../eralens-geography-import/SKILL.md)。

## 开始前

1. 明确事件范围、时间窗口与期望深度；可从用户描述推断时不要停下来追问。
2. 搜索维基百科、正史、政府或学术资料核对事实。不能只根据现有 `generate.mjs` 改写。
3. 搜索 `data/imports/**` 和数据库中的同名、同义事件。已有同一事实时补字段或关联，不新建重复事件。
4. 找到事件所属时期包；跨时期集中数据按既有专包维护，不要把修订只写进生成后的 `import.sql`。

## 收录判断

事件层只表达王朝泳道、在位卡片和都城数据无法表达的信息。收录前回答：**不看事件层，这条历史信息是否仍然不可知？**

默认不新增：

- 常规建国、改国号、称帝、禅让、普通即位或退位；
- 仅重复王朝起止、reign 接续、`claim_track` 或都城时段的更替；
- 只把人物简介换一种说法的事件；
- 只说明“A 取代 B”、没有额外历史结构信息的事件。

优先新增：

- 疆域割让、收复、边界重划和长期控制权变化；
- 跨政权同盟、和约、会盟及长期关系转折；
- 制度、政治象征、商业金融或社会结构变化；
- 少数重大统一、分裂、战争转折；
- 摄政、共和等无法建模为 reign 的非王时期。

复杂疆域变化按独立事实拆分。一个事实已有事件时，补 `event_dynasties`、`event_participants`、`location_id` 或内容字段，不建同义事件。

## 时间建模

- `point`：明确时点。填 `at_*`；只知年份时 `precision='year'`，占位月必须为 12，可用 `eventYear()` / `eventPoint()`。
- 确知公历年月日时用 `precision='day'`，`at` / `start` / `end` 带 `day` 字段（SQL 对应 `at_day` / `start_day` / `end_day`）；农历月日须先可靠换算，不能直接写入公历日字段。
- `span`：事件真实持续一段时间。填 `start_*`、`end_*`；不能用来表示“大约”。
- `circa`：发生于估计窗口或诸说不一。填 `start_*`、`end_*`；可另填通行估计 `at_*`，并在 `date_note` 说明。
- `precision` 只能使用 `day | month | year | decade | century`；已知月份才写 `month`，已知日期才写 `day`。
- 来源写“约某年”但只给一个年份时，忠实记为该年桶，不自动扩成 `circa`。只有跨年范围、多说冲突或导入者推算才使用不确定窗口。
- 先确认日期使用农历还是公历。不得把农历月日直接当公历录入；不能可靠换算时保留原文并降低精度，换算后须在 `date_note` 写依据。
- 所有 `*_abs` 用 `absMonth()` 或项目生成器计算，禁止手填。

`kind` 使用现有枚举：`battle | politics | culture | disaster | commerce | finance | idiom | poetry | other`。新增枚举必须同步 Zod、Prisma、共享标签、界面样式和入库 Skill，不能只在数据里发明新值。

## 内容与关联

- `name` 简短可检索；`summary` 写事实摘要；长说明放 `content`；争议日期放 `date_note`。
- **事件概述不能过于简单**：应让读者不看其他资料也能简略理解事件的历史背景、起因或前因、关键经过/转折、结果与影响，并点明相关政权、主要人物及事件年代。按事件重要性取舍细节，避免只写「某年发生某事」或一句空泛结论；不确定的内容须保留限定，不补造细节。
- 概述只写历史内容。收录取舍、编辑方法和推算过程写 `manifest.json` 的 `notes`。
- `event_dynasties` 关联事件实际涉及或直接影响的王朝，不因同年存在就泛关联。
- 起义或新政权自身的建号、领袖即位、迁都/定都、内部政变、末代君主被俘等事件，默认只关联该政权。事件发生于反抗旧朝、由旧朝军队镇压或影响双方，并不足以自动关联旧朝；只有旧朝作为事件主体直接参战、签约、被取代等且事件本身表达该关系时，才关联旧朝。长期战争/运动跨度事件可关联交战双方；单次战役也可关联直接交战双方。摘要中可照实叙述对手和影响，但不要用摘要中的对抗关系替代关联判定。
- `event_participants.person_id` 只能引用 `persons.id`；国君也引用 person，不引用 reign。
- 缺少人物时先在合适时期包创建或复用 person，禁止用文本替代应有实体。
- 成语事件固定 `kind='idiom'`、`time_mode='point'`，`meaning` 存释义、`summary` 存典故；与史事的对应使用 event→event `relations`。
- 可可靠定位时才填 `location_id`。地点不确定、跨大范围或存在多说时按
  [eralens-geography-import](../eralens-geography-import/SKILL.md) 记录代表点和说明；不能定位则留空。

## 数据工作流

```text
Task Progress:
- [ ] 1. 查史料并列出候选事件、日期、关联和来源
- [ ] 2. 查重并执行收录判断
- [ ] 3. 修改 data/imports/{slug}/ 的源数据或生成器
- [ ] 4. 运行 generate.mjs 生成 import.sql 与 manifest.json
- [ ] 5. 校验 SQL
- [ ] 6. 增量导入或全量重灌
- [ ] 7. 验证 API、详情关联与时间轴显示
```

使用 `data/imports/lib/sqlHelpers.mjs` 的 `eventSql()` 和共享日期助手。默认 UPSERT `events`，连接表 `ON CONFLICT DO NOTHING`；删除已废弃事件时同时清理其连接与关系。不要修改 `data/seed/*.json` 修生产数据，也不要手改生成后的 SQL 而不改源。

```bash
node data/imports/{slug}/generate.mjs
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/{slug}/import.sql
.cursor/skills/eralens-period-import/scripts/apply-sql.sh data/imports/{slug}/import.sql
```

## 验收

- [ ] 每条事件都有可核来源，争议取舍进入 `date_note` 或 manifest notes
- [ ] 概述简洁但交代背景、相关人物、年代、经过和结果/影响，不是过短标签或空泛结论
- [ ] 无同义重复；事件提供泳道、reign、都城无法表达的新信息
- [ ] `point/span/circa` 与精度语义正确，年精度点落在 12 月
- [ ] 王朝、人物、地点关联引用正确实体
- [ ] 校验通过，API 与详情抽屉能读取，时间轴形态符合 time mode

字段与 SQL 模板见 [eralens-period-import reference](../eralens-period-import/reference.md)。
