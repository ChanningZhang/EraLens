---
name: eralens-date-handling
description: >-
  统一处理 EraLens 的历史日期、历法换算、日期置信度、事件时点与区间、日期插值和展示。
  Use whenever historical dates are added, changed, reviewed, imported, migrated, or displayed.
---

# EraLens 日期处理

所有历史日期工作统一遵守本 Skill。事件、在位、王朝、都城、人物日期、关系日期和数据修复流程均须链接并遵循本文件。

## 日期与精度

- 每次录入、修改或复核日期，都应尽可能从可靠史料获取最高可信精度；史料能可靠确认月日时不得只保留年份。
- 日期值采用 `HistoricalDate = { year, month, day?, confidence }`。年月日只记录可确认的历法日期；每个起止端点独立填写置信度，不得用一条记录的总精度覆盖端点差异。
- `year` 使用项目带符号公历纪年，公元前年份为负数；AbsMonth 使用共享 `absMonth()`。
- 先辨明历法。农历月日不得直接作为公历录入；只有可靠换算后才写换算后的公历月日，并保留原记载、历法和换算依据。不能可靠换算时保留原文并降低精度。
- 日期精度指史料日期本身的粒度；confidence 指该日期主张的可信状态，二者不可互相替代。

## Confidence

端点使用以下八类：

| confidence | 含义 | 示例展示 |
| --- | --- | --- |
| `day` | 确定到日 | `685年9月27日` |
| `month` | 确定到月 | `685年9月` |
| `year` | 确定到年 | `685年` |
| `approximate_day` | 推定到日 | `约685年9月27日` |
| `approximate_month` | 推定到月 | `约685年9月` |
| `approximate_year` | 推定到年 | `约685年` |
| `interpolated_by_other` | 依明确关联史料或共时记录推定 | `?` |
| `interpolated_by_generation` | 连续世系在可靠双端锚点间按世次均分 | `?` |

确定类显示日期并使用竖线；近似类显示“约”并使用竖线；插值类显示“?”并使用波浪线。日期精度与置信度不一致时，以来源可支持的较低精度记录；不得用空间定位精度表示日期置信度。

## 推断与插值

- 关联推断必须存在明确的对应关系或共时依据，参照日期必须属于前六类确定/近似 confidence；禁止循环推断。
- `interpolated_by_generation` 仅用于连续世系且有可靠双端锚点、可按世次均分的区间。世系中断、锚点不足或仅依传统积年时不得插值。
- 无可靠依据的传统积年撤下虚构日期定位，保留人物、世系和可证事实，并说明依据不足。
- 推断结果显式写入导入缓存；依据、历法和取舍写入 `manifest.notes`，来源写入 `manifest.sources`。

## 事件

- 事件只使用 `point` 和 `span`，不使用 `circa`；不增加 `displayScale`。日期不确定性由端点 confidence 表达。
- 持续时间不足一个日历年时使用 `point`；满一个日历年及以上的真实持续过程使用 `span`。不得从占位年月推算真实时长。
- 短事件优先使用史料支持的代表时点，否则使用核实后的起点；保留原起止叙述和取舍依据于 `date_note`。
- `span` 表达实际持续过程，不可仅因日期模糊而使用；模糊点事件仍为 `point` 并设置近似 confidence。
- 年精度 point 的轴时点使用该年 12 月桶右缘；占位月份不得显示为史料已知月份。

## 共享实现与复核

- 日历区间归属调用 `packages/shared/src/timelineOwnership.ts` 和 `timelineIntervals.ts`；调用侧不得重写端点比较或手工加减年月。
- 先记录原值和来源，再逐端点复核；不得用批量字段映射冒充史料复核。无改动、依据不足、待核及暂缓记录都要保留 ID、结论和理由。
- 真实数据只改 `data/imports/{slug}/cache.json`，执行全量所有权审计、统一生成器、导入校验，再增量更新数据库。
- 数据库精度旧列只在用户校验迁移报告并明确确认通过后，才可在独立 DROP 迁移中删除。
