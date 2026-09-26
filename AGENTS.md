# EraLens 代理规范

本文件只保留跨任务通用约束。产品说明与开发启动见 [README.md](README.md)；具体数据工作流见：

- [完整时期导入](.cursor/skills/eralens-period-import/SKILL.md)
- [事件添加与丰富](.cursor/skills/eralens-event-import/SKILL.md)
- [在位信息添加与丰富](.cursor/skills/eralens-reign-import/SKILL.md)
- [地理信息添加与丰富](.cursor/skills/eralens-geography-import/SKILL.md)
- [数据修复](.cursor/skills/eralens-data-fix/SKILL.md)

## 项目结构

- Web：React + TypeScript + Vite，位于 `apps/web/`；API：Fastify + Prisma，位于 `apps/api/`。
- `packages/shared/` 存领域规则与数据契约；`data/imports/` 存真实数据源；`data/seed/` 仅供 Mock 和 `db:seed`。
- 本地命令、环境变量和 Docker 说明以 README 与各 `.env.example` 为准。

## 通用技术约束

1. 用可复用规则处理大多数情况；例外尽量通过数据标记表达。单个王朝、人物或事件的代码特判必须先得到用户同意。
2. 时间、schema、正统、称谓、时间区间归属、命运线和泳道分组等领域逻辑放在 `@eralens/shared` 或 `data/imports/lib/`；前端负责投影与渲染，API 负责查询与映射。
3. 同一语义只保留一条实现路径；缺载 reign、普通 reign 共用 `Reign` 和 `layoutLaneReignBar`，不得为单一数据类型另造坐标或布局逻辑。
4. 展示使用共用组件和函数。卡片宽度遵循时间几何，不为塞入文字拉伸时间跨度；王朝本色、正统覆盖色和卡片称谓遵循共享规则。

## 时间与数据约束

- 所有时间使用 `AbsMonth`：`absMonth(year, month) = toAstroYear(year) * 12 + month - 1`，其中公元前年份 `toAstroYear(year) = year + 1`。公元前年份以负数存入 `*_year`。
- 相邻时间区间的归属统一经过 `packages/shared/src/timelineOwnership.ts`，按精度由 `timelineIntervals.ts` 裁定。调用侧不得自建端点判断、分组规则或手写 `+1 年/月` 截断。
- 真正并立或语义上可共存的区间保留并行记录，并用 `claim_track` 或对应实体分组表达；不得让接续裁定合并并存数据。
- 年精度点事件与命运线使用 12 月作为年桶右缘；泳道起年和迄年的占位月份分别为 1 月和 12 月。占位月份不得显示成已知月份。
- Tooltip 使用紧凑年份（如「前221年」），不写「公元」；事件轴仍在视口内时，事件名必须可见。
- 录入历史日期前辨明历法。农历月日不得直接当作公历日期；无可靠换算依据时保留原记载并说明历法。

## 真实数据与验证

- 真实数据只修改 `data/imports/{slug}/` 的源文件，经 generate → SQL → 校验 → 导入流程更新数据库。不要用 `data/seed/*.json` 修生产数据，也不要运行 `pnpm db:seed` 覆盖真实库。
- 大批量数据的 `*_abs` 使用 `absMonth()` 或共享生成器计算；不要写入数据库生成列 `span`。
- 数据问题先核对可靠史料，再区分源数据错误、导入残留和渲染规则问题。修复数据应回到导入源与数据库层，不在 API/前端 hardcode 掩盖。
- 新枚举或 schema 字段须同步 Prisma、Zod、共享逻辑及对应 Skill/reference。

## 历史数据判定

- 年精度顺序继位通常由旧王占有死年，新王从下一年开始；短祚、明确未逾年改元和真实并立按史料处理。所有判断依据原始史料日期。
- 空档先判为史料缺、无国君或年代失考。只有明确应有君主但姓名/世次失载才建 `system-missing-ruler`；无国君留白；有名但年代推算用 confidence 标记。禁止按年份不连续自动造缺载 reign。
- 连续世系可在共同、可靠的起讫锚点间按世次均分失考在位年并标 `interpolated`；世系中断、锚点不足或仅依传统积年时不跨断层插值。
- 王朝名称通常使用国号，不加「国」，只有通行称谓例外除外。`persons.name` 保留可检索全名且君主带姓；姓、氏、谥号、庙号、年号和卡片称号分别写入各自字段。
- 概述只写历史事实；收录取舍、年代推算与资料处理说明写入导入包 `manifest.json` 的 `notes`。

## 关键展示语义

- 金色是正统覆盖色，泳道本色由完整目录顺序稳定分配；禁止把 `color_token` 写为 `gold`。主线由 `reigns.is_main` 标记，并立 track 与 `claim_role='rival'` 不标主线。
- 并立君主用 `claim_track` 分行；同时并存的政权用 `dynasty_groups` 聚类；前后相续的政权行用 `dynasty_lane_groups` 合并。三种关系不能互相替代。
- 卡片宽度遵循在位时长与缩放比例；文字放不下时调整排版，不改变时间几何。相续泳道的标签颜色取舞台中线对应相位。
- 无 reign 且生卒可核的人物显示在人物层，君主不重复进入人物层。帝王卡、事件、人物和王朝名点击共用详情抽屉。
- 跨王朝命运线只表达明确的杀害、投降、禅让或被俘关系；事件时点是纵向主轴，端点解析与绘制沿用 `reignFateRelations.ts` 和 `reignFateLayout.ts`。

更细的日期、正统窗口、称谓字段、布局和命运线规则，按对应数据 Skill、共享实现与导入包 manifest 执行。
