# EraLens

数据驱动的中国历史时间轴。底部标尺滑动时间窗口，王朝泳道随窗口进出；皇帝卡片、非帝王人物、事件层与跨王朝命运虚线联动。点击卡片或左侧王朝名打开右侧抽屉详情（不挤压主舞台）。

覆盖约夏商至民国：王室与列国行、正统金色、一朝多帝、史料缺/失考/留白的区分，以及末代君主被杀、投降、禅让、被俘的跨王朝关系。

## 技术栈

- **Frontend**: React 19 + TypeScript + Vite
- **Backend**: Fastify + Prisma + PostgreSQL 16（Docker）
- **Shared**: `@eralens/shared`（AbsMonth、Zod 契约、正统/称谓/命运线等领域逻辑）
- **State**: Zustand（视口瞬时订阅）+ TanStack Query（按 LOD 分块缓存）
- **Animation**: Framer Motion（王朝行 FLIP）
- **Data**: HTTP Repository（默认，读 PostgreSQL）/ Mock Repository（`VITE_DATA_SOURCE=mock`）

## 架构

```text
浏览器  →  apps/web          视口、LOD、泳道投影、卡片/命运线渲染
         →  GET /api/timeline  窗口内 dynasties / reigns / events / persons / relations
apps/api →  Prisma + PG       span 范围查询；详情与搜索在共享层拼装
         →  @eralens/shared   校验、AbsMonth、正统、称谓、cluster/lane、命运解析
data/imports/{slug}           时期包 generate.mjs → import.sql（真实数据）
data/seed/*.json              仅 Mock / db:seed 样本，不参与 db:setup
```

时间坐标 `AbsMonth`：

```text
absMonth(year, month) = toAstroYear(year) * 12 + (month - 1)
toAstroYear(year) = year > 0 ? year : year + 1   // 前 221 → astro -220
```

日历年公元前用负数写入 `*_year`。LOD（millennium / century / decade / month）随 `pxPerMonth` 切换，查询按 chunk 对齐。

## Docker 启动

需要已安装 [Docker](https://docs.docker.com/get-docker/) 与 Docker Compose。一条命令同时启动 PostgreSQL 和应用（前端静态资源由 API 同端口提供）：

```bash
docker compose up --build
```

首次写入种子（容器内 `data/seed` JSON，不是时期包）时：

```bash
RUN_SEED=true docker compose up --build
```

本地完整真实数据请用下面的 `pnpm db:setup`。浏览器打开 http://localhost:8080

后台：`docker compose up --build -d`。停止：`docker compose down`（数据卷 `eralens_pg_data` 保留）。

## 本地开发

```bash
pnpm install
pnpm db:setup      # Docker PostgreSQL + migrate + 导入 data/imports
pnpm dev:all       # 前端 :5173 + API :3001
```

仅前端（Mock，无需 API）：

```bash
VITE_DATA_SOURCE=mock pnpm dev
```

浏览器打开 http://localhost:5173。默认 HTTP 模式需要 API，推荐 `pnpm dev:all`。

## 环境变量

| 变量 | 说明 | 默认 |
|------|------|------|
| `VITE_DATA_SOURCE` | `mock` 或 `http` | `http` |
| `VITE_API_BASE` | HTTP 模式 API 前缀 | `/api` |
| `VITE_PERF_DATA` | `1` 时注入 2200+ 合成数据做性能验证 | 未设置 |

API 见 `apps/api/.env.example`（`DATABASE_URL`、`PORT`）。

## 目录结构

```
packages/shared/                 # 时间、Zod schema、正统、称谓、命运线、泳道分组
apps/web/src/features/timeline/  # 舞台、泳道、卡片、事件/人物/命运层、标尺
apps/web/src/features/detail/    # 右侧抽屉详情
apps/api/                        # Fastify + Prisma
data/imports/{slug}/             # 时期包：generate.mjs、import.sql、manifest.json
data/imports/lib/                # 共享生成器（AbsMonth、切年、正统、命运校验）
data/imports/cross-dynasty-fate/ # 跨王朝命运关系
data/seed/                       # Mock 样本 JSON（东汉—三国量级）
.cursor/skills/eralens-period-import/  # 搜集与入库 Skill
docker-compose.yml
```

## 后端对接

Mock 与 HTTP Repository 同一契约：

- `GET /api/timeline?from=&to=&lod=&scope=` — 窗口切片，含 `relations`
- `GET /api/entities/:type/:id`
- `GET /api/search?q=` — 只匹配 dynasty / person / event 的 `name`
- `GET /api/bounds`

复制 `apps/web/.env.example` 为 `.env`（默认 `http`）；离线可设 `VITE_DATA_SOURCE=mock`。

## 数据库

```bash
pnpm db:up        # 仅启动 PostgreSQL
pnpm db:migrate   # 应用迁移
pnpm db:import    # 按 manifest 窗口排序导入 data/imports（会 TRUNCATE 后重灌）
pnpm db:seed      # 灌 data/seed JSON；会冲掉时期包，开发真实轴不要用
pnpm db:down      # 停止容器
```

增量搜集某时期：Skill **eralens-period-import**，生成 SQL 后校验、`apply-sql.sh` 入库。不要手填 `*_abs`，不要写入生成列 `span`。

## 时间轴数据语义

时间轴上的「空白」不是同一种历史状况。

### 视觉对照

| 情形 | 时间轴表现 | 历史含义 | 数据层 |
|------|------------|----------|--------|
| **正常在位** | 实心君主卡片，本色底；正统窗口内叠金 | 有明确国君与在位年 | 普通 `reigns`，confidence 空视为确定 |
| **年代失考** | 首尾相接且两侧均失考的交界：波浪线 + 细缝 | 世系连续、年份为推算或约数 | 两侧 `interpolated` / `approximate`，仅日历相接时画 |
| **史料缺** | 虚线框「史料缺」 | 应有国君，姓名/世次失载 | `person_id = system-missing-ruler`；**不**按年份缺口自动生成 |
| **无国君 / 中断** | 自然留白 | 亡国、未复立、该行本不设君（武周的唐行） | 不写 reign |
| **一朝多帝** | 同行上下分行，高度为正常行 2/3，并立虚线描边 | 同时另立的朝廷，非前后继任 | `claim_track` + 可选 `claim_label`；`claim_role = rival` |
| **跨王朝命运** | 从 A 卡拉出本色虚线，在事件年接到 B 卡 | 被杀 / 投降 / 禅让 / 被俘 | `relations.kind` ∈ killed、surrender、abdication、captured |

虚线框留给史料缺；并立卡也是虚线描边但有浅填。波浪线只表示年代推算。命运虚线是跨泳道折线，颜色用**源泳道本色**（不是金色）。

### 年精度继位（先秦）

仅知年份、顺序继位：**死年整年归旧王，新王从下一年起算**（逾年改元）。维基若把死年同时写作新王起年，时间轴不把该年画成并立。一年短祚、未逾年改元、真正并立（`claim_track` / 曲沃与翼）除外。月日有史料则用月日。

年精度的 1 月/12 月只是年桶占位：**界面不显示「×月」**，避免假精确。

### 一朝多帝

同一王朝占**一行**。建模：

- **主线**（不填 `claim_track`）：通行继承。前帝**身后**即位，哪怕权臣傀儡，仍接在其后（文帝→炀帝→杨浩）。
- **并行 track**（据点 kebab-case，如 `changan`、`lu-jian`）：前任仍在位，或同年另立。卡片分行，高度 2/3，互不裁切。
- **`claim_label`**：副标题据点（长安 / 绍兴监国）。
- **`claim_role`**：并行一律 `rival`。是否并行只看「同时另立」。

实现：`packages/shared/src/claimTracks.ts`，组件 `ReignCard`。

### 王朝 cluster group

并存王朝各占一行、同属一个时期时，用 `dynasty_groups` + `dynasties.group_id`：

- 组有独立起止（三国 220–280、五胡十六国 304–439、南朝 420–589、五代 907–960）。外框按**组 span** 投影，不被成员更早建国年撑大（北魏 386、前凉 301、吴 902 可露在框外）。
- 组内仍按各王朝 `startAbs → endAbs → id` 自上而下；组与组同一套比较（同起年时更短 `endAbs` 在上）。
- 组名在背景框左上角，来自 `dynasty_groups.name`。

与「相续泳道合并」不同：cluster **不折叠**行，只贴在一起套框。

### 相续泳道合并

`dynasty_lane_groups` 表（包 `data/imports/dynasty-lane-groups/`）把前后相续的政权压成一行；运行时 `dynastyLaneGroups.ts` 只读 API 下发的配置，不再硬编码组列表。左侧冻结名与名牌金色随**舞台中线**切换，例如：

- 西周 → 东周
- 蒙古帝国 → 元（金色正统仍按元的 `orthodox_*` 截断，北元段不上金）
- 吴政权 → 明 → 南明

合并行的排序跨度取配置的 `laneOrderStartAbs/EndAbs`，不因早期相位滚出视口而缩短。西晋/东晋是分开的两行（曾合并过，已拆回）。

### 史料缺、无国君、年代失考

**史料缺**——应该有王，但不知道是谁。必须有文献或学界共识支持缺载，才插入 `reign-missing-*`。导入脚本不会因年份不连续自动生成。

**无国君**——这一时段确实没有该国君主。例如前 223 年秦灭楚至前 209 年项梁复楚，楚行留白；武周不在唐行填占位皇帝。

**年代失考**——知道是谁，在位年为插值。例如西周齐国早期在锚点年间按世系均分，标 `interpolated`。仅当前后两位都标失考时才在交界画波浪；一侧有《史记》锚点、一年短祚（卫戴公）、灭国留白都不画。

史料缺与普通在位都是 `reigns` 行，前端只按 `person_id` 换样式；卡片几何与命运线锚点走同一套 `layoutLaneReignBar`。

### 失考年代的导入与前端

1. **导入**：`chunqiu-zhanguo/build-rulers.mjs` 的 `fillUndatedYears` 在锚点间按世系均分（不设单条年上限），写入 `interpolated`。
2. **库表**：`reigns.start_date_confidence` / `end_date_confidence`（`certain` 存 NULL）。
3. **前端**：`findReignUncertaintyBoundaries` 检测交界；`ReignUncertaintyGap` 画波浪，`ReignGapCard` 画史料缺框。

更完整入库规范：[eralens-period-import](.cursor/skills/eralens-period-import/SKILL.md)。

## 正统金色

金色是运行时覆盖。泳道本色由前端 `assignLaneColorTokens` 按视口泳道顺序分配（24 色：cinnabar、mineral、ochre、indigo、moss、wisteria、grape、stone、jade、coral、plum、azure、amber、clay、sage、slate、crimson、bronze、rose、lime、navy、peacock、copper、mulberry）；库内 `color_token` 仅为 NOT NULL 占位。`gold` 不作为泳道本色。左侧冻结名牌在舞台中线落入该行正统窗口时叠金，移出后回到本色；命运虚线与泳道底始终本色。

**运行时**只读库字段 `orthodox_from_abs` / `orthodox_end_abs`（`packages/shared/src/orthodoxDynasties.ts` 不再用内置表 fallback）。**导入**时用 `data/imports/lib/orthodoxDynasties.mjs` 烘焙到各包 `dynasties` INSERT。并立 track 不上金；延迟起算的 12 月宽限（如清入关）仍是 runtime 抽象规则。

| 类型 | 例子 |
|------|------|
| 自起始即正统 | 夏商西周东周、东汉、西东晋、隋唐、武周、北宋南宋、明、中华民国、中华人民共和国 |
| 延迟起算 | 秦前 221；西汉刘邦称帝（前 202.2），起兵至称帝前不上金；清 1644 福临起，努尔哈赤/皇太极不上金；元 1276.2 宋恭帝降后，定国号至降宋前非正统 |
| 截断 | 隋可盖到 618 年末（江都杨浩）；元止 1368（北元非正统）；南宋止 1276.2（端宗、帝昺非正统） |

魏蜀吴在汉献帝禅位、各自称帝前不建帝王卡。王莽、更始等非约定主线不上金。

## 帝王称谓

卡片主行默认是 `persons.name`。**始皇帝以前**（`start.year < -221`）主行改为谥号或诸侯称号（不带国名，国名在泳道上），副行才是私名，并去掉姬、姜、嬴等姓前缀（吕尚、熊侣、田氏、三晋的氏保留）。

其余时期副行由 `resolveEmperorAppellation` 按在位起始年选择：

- 唐以前：谥号或诸侯称号
- 唐至元：庙号优先
- 明清：年号优先（英宗前后两段年号不同则分段显示）

`posthumous_name` / `temple_name` 只存「太宗」「孝文皇帝」，不写「唐太宗」。`reigns.title` 存卡片称号/史称（先秦去国号如 `禹`、`君舍`；帝制后如 `唐太宗`、`少帝`）。618 以后庙号/谥号须在 generate 显式写入 person 字段；运行时不从 `title` 推测庙谥。史称（少帝/末帝/后主等）留在 `title`，不进 `posthumous_name`。

人物搜索别名写入 `persons.alt_names`（如 `lv-shang` → `姜子牙`），不再维护 runtime 硬编码表。

空间不够时：左右排主行+副行 → 只留主行 → 字溢到行间，**不**为塞字改变在位条宽度。先秦窄条保「桓公」，不保「小白」。

## 人物层

无 `reign`、且生卒可核的人物画在当前可见王朝行下方（名臣、将领、后妃、学者等）。皇帝只出现在王朝行，不进人物层。缩放不够时整层隐藏。

## 跨王朝命运线

帝王 A 被帝王 B 杀害，或向 B 投降、禅让、被俘时：从 A 卡片拉出虚线，在事件发生的时间刻度接到 B。

- 数据：`relations`，`kind` 为 `killed` | `surrender` | `abdication` | `captured`，必须有 `atAbs`。`fromRef` 为 `person:` 或 `reign:`，`toRef` 为 `person:`。同朝继承不画。
- 解析：受害方取当时在位或最近已结束的 reign；接收方取当时在位或其后 24 个月内即位的 reign。B 在时间轴上无卡时，改挂当时在位君主。无接收方（未收录的后续政权等）不画。
- 几何：`relation.atAbs` 投影出的事件列是命运线唯一的纵向主轴；上下两端如因卡片锚点不在该列而需要连接，只添加水平段接到 A 卡中线与 B 卡朝向边。接收方尚未即位时，不能把纵向段推到其卡片起点。颜色为 A 所在泳道本色。命中热区加宽，便于 tooltip。
- 主数据包：`data/imports/cross-dynasty-fate/`（与各时期 events、`documentedReignDates` 对齐）。有明确灭国对象的王朝，末代通常应有一条线；非末代被他朝杀死或俘虏的也画。

实现：`packages/shared/src/reignFateRelations.ts`，布局 `apps/web/src/features/timeline/model/reignFateLayout.ts`，绘制 `ReignFateLayer`。

## 交互

- 底部标尺拖拽平移；触控板两指横向平移（已避免与浏览器前进/后退、系统通知中心冲突）
- `Cmd/Ctrl + 滚轮` 或触控板捏合缩放
- `←/→` 步进，`Shift+←/→` 大步，`Home/End` 跳数据首尾
- 舞台随鼠标的竖向参考线；泳道中央另有中线，用于切换冻结王朝名，并决定名牌是否叠正统金
- 悬停卡片：起止年（compact，无「公元」）与时长；年精度不展示占位月。年精度点事件落在该年 12 月，与泳道年桶右缘、命运线对齐。
- 悬停命运虚线：`甲 → 乙（被杀|投降|禅让|被俘）`
- 点击皇帝 / 事件 / 人物 / 左侧王朝名：右侧抽屉详情（可拖宽，双击分隔条复位）
- 顶栏搜索跳转到实体（比拖标尺快）。`Home` 到 `bounds.minAbs`（可能早于最早王朝，若有更早 circa 事件）

入库后若界面未更新，硬刷新（bounds 的 `staleTime: Infinity`）。仍为 Mock 时检查 `VITE_DATA_SOURCE`。

## 数据覆盖

`data/imports/` 按时期分包，`pnpm db:import` 按 manifest 窗口排序灌入。主要包：

| 包 | 内容 |
|----|------|
| `xia-shang-zhou` | 夏商周王室 |
| `chunqiu-zhanguo` / `chunqiu-minor` | 春秋战国主要列国与次要诸侯 |
| `qin-han` / `qin-han-extra` | 秦汉及同时人物事件 |
| `three-kingdoms-*` | 魏蜀吴、晚段、战役、称帝前割据 |
| `jin-sixteen` | 两晋与五胡十六国 |
| `nanbei-chao` / `nanbei-sixteen-extra` | 南北朝及十六国余绪 |
| `sui-tang-wudai-song` / `tang-border` | 隋唐五代北宋、唐周边 |
| `song-liao-jin` / `xixia` / `liao-remnants` | 宋辽金夏、辽遗 |
| `mongol-pre-yuan` / `yuan-ming-qing` / `ming-end` | 蒙古、元明清、明末 |
| `nanzhao-dali` / `xinan-guozheng` | 南诏大理、西南国政 |
| `taiping` / `minguo` / `prc` | 太平天国、民国、中华人民共和国 |
| `cross-dynasty-fate` | 跨王朝命运关系（不建新王朝） |

列国名用国号（齐、楚），一般不带「国」。战国「东周国」「西周国」保留「国」以免与西周/东周王室行混淆。

## 测试

```bash
pnpm test
```
