---
name: eralens-event-import
description: >-
  为 EraLens 调研、筛选、添加或丰富历史事件及其王朝、人物、地点关联，并生成和导入事件 SQL。
  Use when the user asks to add historical events, enrich event details, dates, participants,
  dynasty links, event locations, or audit whether an event belongs on the timeline.
---

# EraLens 事件添加与丰富

所有事件日期、精度、历法与置信度遵循 [eralens-date-handling](../eralens-date-handling/SKILL.md)。

只处理事件及其直接关联。真实数据的唯一记录源是 `data/imports/{slug}/cache.json`，新增或修改的事件及关联直接写入对应数组；来源和取舍写入同一缓存内的 `manifest.sources` / `manifest.notes`。不要新增包级 `.mjs`、Wiki 加工脚本或手写生成 SQL。新建完整时期包时仍使用
[eralens-period-import](../eralens-period-import/SKILL.md)；需要单独补地点时同时使用
[eralens-geography-import](../eralens-geography-import/SKILL.md)。

## 开始前

1. 明确事件范围、时间窗口与期望深度；可从用户描述推断时不要停下来追问。
2. 搜索维基百科、正史、政府或学术资料核对事实。不能只根据现有缓存改写。
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

复杂疆域变化按独立事实拆分。一个事实已有事件时，补集中包的普通关联、地理映射或内容字段，不建同义事件。

## 时间建模

日期和 point/span 的规则以 [eralens-date-handling](../eralens-date-handling/SKILL.md) 为准。事件缓存仍使用 `at`、`start`、`end` 及对应 AbsMonth 字段；`*_abs` 用共享 `absMonth()` 或 `compute-abs.mjs` 核算。

`kind` 使用现有枚举：`battle | politics | culture | disaster | commerce | agriculture | finance | idiom | poetry | other`。`agriculture` 用于农业生产、作物引种及相关农业技术传播。新增枚举必须同步 Zod、Prisma、共享标签、界面样式和入库 Skill，不能只在数据里发明新值。

## 内容与关联

- `name` 简短可检索；`summary` 写事实摘要；长说明放 `content`；争议日期放 `date_note`。
- **事件概述不能过于简单**：应让读者不看其他资料也能简略理解事件的历史背景、起因或前因、关键经过/转折、结果与影响，并点明相关政权、主要人物及事件年代。按事件重要性取舍细节，避免只写「某年发生某事」或一句空泛结论；不确定的内容须保留限定，不补造细节。
- 概述只写历史内容。收录取舍、编辑方法和推算过程写 `cache.json.manifest.notes`；来源写 `cache.json.manifest.sources`。
- 新增或丰富事件时必须同步更新来源；直接关联的人物、地点记录的 `links` 也须核对，按 [来源维护](../eralens-period-import/SKILL.md#来源维护) 执行。
- 事件—王朝关联写入 `entity-associations/cache.json.associations`，只关联实际涉及或直接影响的王朝，不因同年存在就泛关联。
- 起义或新政权自身的建号、领袖即位、迁都/定都、内部政变、末代君主被俘等事件，默认只关联该政权。事件发生于反抗旧朝、由旧朝军队镇压或影响双方，并不足以自动关联旧朝；只有旧朝作为事件主体直接参战、签约、被取代等且事件本身表达该关系时，才关联旧朝。长期战争/运动跨度事件可关联交战双方；单次战役也可关联直接交战双方。摘要中可照实叙述对手和影响，但不要用摘要中的对抗关系替代关联判定。
- 事件—人物关联写入集中包 associations，人物端点必须为 `person:`；国君也引用 person，不引用 reign。
- 缺少人物时先在合适时期包创建或复用 person，禁止用文本替代应有实体。
- 成语事件固定 `kind='idiom'`、`time_mode='point'`，`meaning` 存释义、`summary` 存典故；与史事的对应使用集中包中无方向的 event—event associations。
- 可可靠定位时才填 `location_id`。地点不确定、跨大范围或存在多说时按
  [eralens-geography-import](../eralens-geography-import/SKILL.md) 记录代表点和说明；不能定位则留空。

## 数据工作流

```text
Task Progress:
- [ ] 1. 查史料并列出候选事件、日期、关联和来源
- [ ] 2. 查重并执行收录判断
- [ ] 3. 直接修改 data/imports/{slug}/cache.json
- [ ] 4. 运行统一生成命令，生成 PostgreSQL `import.sql` 与 manifest.json
- [ ] 5. 校验 SQL
- [ ] 6. 增量导入或全量重灌
- [ ] 7. 验证 API、详情关联与时间轴显示
```

事件记录使用缓存中的 camelCase 字段，例如 `at: { year, month, abs }`。所有普通关联唯一维护在 `entity-associations/cache.json.associations`（`{aRef,bRef}`，规范 UTF-8 排序，无方向、无标签）；历史包不存 dynastyIds/participantIds 或 supplemental 关联数组。事件地点放在 `locationMappings`。relations 仅保留命运与人物继承关系。实体修改在原包，关联修改在集中包，来源和数量随所属包维护，再统一生成、审计、导入。删除实体自动级联清关联；单独移除关联时由集中包维护四字段完整键清理语句。不要手改 SQL，也不要用 seed 更新真实库。

```bash
node data/imports/generate.mjs {slug}
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/{slug}/import.sql
.cursor/skills/eralens-period-import/scripts/apply-sql.sh data/imports/{slug}/import.sql
```

校验器会读取 SQL 同目录的 `cache.json` 检查在位边界；失败时修缓存、重新生成，再校验。单包增量写 PostgreSQL 用 `apply-sql.sh`；全量重载前先运行 `node data/imports/generate.mjs --all`，再执行 `pnpm db:import`。该命令会清空并重载本地 PostgreSQL，随后导出和校验移动端 SQLite，但不会从缓存生成 SQL。Xcode 不执行导入包 SQL。

## 验收

- [ ] 每条事件都有可核来源，争议取舍进入 `date_note` 或 `cache.json.manifest.notes`
- [ ] 本次采用的来源已同步到 `manifest.sources` 与适用条目的 `links`，详情“来源”栏已核对
- [ ] 概述简洁但交代背景、相关人物、年代、经过和结果/影响，不是过短标签或空泛结论
- [ ] 无同义重复；事件提供泳道、reign、都城无法表达的新信息
- [ ] `point/span` 与日期置信度语义正确，年精度点落在 12 月
- [ ] 王朝、人物、地点关联引用正确实体
- [ ] 校验通过，API 与详情抽屉能读取，时间轴形态符合 time mode

字段与 SQL 模板见 [eralens-period-import reference](../eralens-period-import/reference.md)。
