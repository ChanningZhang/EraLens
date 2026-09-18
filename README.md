# EraLens

数据驱动的历史时间轴查阅工具。通过底部标尺滑动浏览时间窗口，王朝行随窗口动态进出，皇帝卡片与事件层联动展示，点击卡片打开可调宽详情栏。

## 技术栈

- **Frontend**: React 19 + TypeScript + Vite
- **Backend**: Fastify + Prisma + PostgreSQL 16（Docker）
- **Shared**: `@eralens/shared`（AbsMonth 时间坐标 + Zod 数据契约 + 领域逻辑）
- **State**: Zustand（视口瞬时订阅）+ TanStack Query（分块缓存）
- **Animation**: Framer Motion（王朝行 FLIP 布局）
- **Data**: HTTP Repository（默认，读 PostgreSQL）/ Mock Repository（`VITE_DATA_SOURCE=mock`）

## Docker 启动

需要已安装 [Docker](https://docs.docker.com/get-docker/) 与 Docker Compose。一条命令同时启动 PostgreSQL 和应用（前端静态资源由 API 在同一端口提供）：

```bash
docker compose up --build
```

首次需要写入种子数据时：

```bash
RUN_SEED=true docker compose up --build
```

浏览器打开 http://localhost:8080

后台运行用 `-d`：`docker compose up --build -d`。停止：`docker compose down`（数据卷 `eralens_pg_data` 会保留）。

## 本地开发

```bash
pnpm install
pnpm db:setup      # 启动 Docker PostgreSQL + migrate + 导入 data/imports
pnpm dev:all       # 前端 :5173 + API :3001
```

仅前端（Mock 数据，无需 API）：

```bash
VITE_DATA_SOURCE=mock pnpm dev
```

浏览器打开 http://localhost:5173（默认 HTTP 模式需 API 已启动，推荐 `pnpm dev:all`）

## 环境变量

| 变量 | 说明 | 默认 |
|------|------|------|
| `VITE_DATA_SOURCE` | `mock` 或 `http` | `http` |
| `VITE_API_BASE` | HTTP 模式 API 前缀 | `/api` |
| `VITE_PERF_DATA` | `1` 时注入 2200+ 合成数据做性能验证 | 未设置 |

## 目录结构

```
packages/shared/     # 时间工具 + Zod schema + 领域逻辑
apps/web/            # React 前端
apps/api/            # Fastify REST API + Prisma
data/seed/           # 种子 JSON（东汉—三国）
docker-compose.yml   # PostgreSQL + 应用容器
```

## 后端对接

Mock 与 HTTP Repository 共享同一接口契约：

- `GET /api/timeline?from=&to=&lod=&scope=`
- `GET /api/entities/:type/:id`
- `GET /api/search?q=`
- `GET /api/bounds`

切换方式：复制 `apps/web/.env.example` 为 `.env`（默认 `http`）；离线开发可设 `VITE_DATA_SOURCE=mock`。

API 环境变量见 `apps/api/.env.example`（`DATABASE_URL`、`PORT`）。

## 数据库

```bash
pnpm db:up        # 仅启动 PostgreSQL 容器
pnpm db:migrate   # 应用迁移
pnpm db:import    # 导入 data/imports 各时期 SQL
pnpm db:seed      # 导入 data/seed JSON（Mock 样本）
pnpm db:down      # 停止容器
```

按时期增量导入历史数据：使用项目 Skill **eralens-period-import**（`.cursor/skills/eralens-period-import/`），生成 SQL 至 `data/imports/{slug}/` 后执行校验与入库。

## 时间轴数据语义

时间轴上「空白」并不都代表同一种历史状况。EraLens 用不同的视觉与数据字段区分以下情形，避免把灭国、失考、缺载混为一谈。

### 视觉对照

| 情形 | 时间轴表现 | 历史含义 | 数据层 |
|------|------------|----------|--------|
| **正常在位** | 实心君主卡片，首尾相接或按年表锚定 | 该国/该脉络有明确国君与在位年 | 普通 `reigns` 行，`start_date_confidence` / `end_date_confidence` 为空（视为确定） |
| **年代失考** | **首尾相接**且**两侧均标注失考**的交界**波浪线 + 细缝**（灭国留白、一侧有年表锚点、一年在位实录不画） | 世系连续、在位年为推算或约数（如西周早期诸侯均分在位年） | 交界两侧 `start/end_date_confidence` 均为 `interpolated` 或 `approximate`；仅日历相接时渲染 |
| **史料缺** | **虚线框**，标注「史料缺」 | 经考证确认：该时段应有国君，但姓名/世次失载 | `person_id = system-missing-ruler` 的占位 `reign`；**不**根据相邻年份自动推断 |
| **无国君 / 政权中断** | **自然留白**（不画卡片） | 该国已亡、尚未复立，或该王朝行此期本就不设君（如秦灭楚后、武周期间唐行） | **不写** reign；与「史料缺」不同，不是资料未收全 |
| **一朝多帝** | 同一王朝行内**上下分行**紧贴并排；并立卡片高度为正常行的 **2/3** | 同时另立的多套朝廷（非前后继任） | `claim_track` + 可选 `claim_label`；并行卡片统一虚线描边 |

虚线用于「史料缺」占位框，以及并立帝王卡片描边（并立卡片带浅色填充，以免与史料缺空框混淆）；波浪线保留给「年代推算」。

### 年精度继位（先秦）

仅知年份、顺序继位时：**死年整年归旧王，新王从下一年起算**（逾年改元，与英文维基国王表一致）。维基「在位年份」若把死年同时写作新王起年，时间轴不把这一年画成两人并立。一年短祚、史料写明未逾年改元、真正并立（`claim_track` / 曲沃与翼）除外。月日有史料则用月日。

### 一朝多帝（并行称君）

同一王朝在时间轴上占**一行**，但某一时期可能存在多个同时自称或实际执政的君主（隋末长安杨侑与洛阳杨侗、南明鲁监国与绍武等）。建模规则：

- **主线**（不填 `claim_track`，或视为 `main`）：通行史书中的继承顺序——前帝**身后**即位，哪怕实为权臣傀儡，仍接在前帝之后（如文帝→炀帝→杨浩）。
- **并行 track**（`claim_track` 为据点 kebab-case，如 `changan`、`lu-jian`）：在前任**仍在位**时，或与之**同年分立**的另一套政权另立皇帝。卡片分行显示，高度为正常泳道的 2/3，互不裁切对方在位条。
- **`claim_label`**：卡片副标题上的据点（长安 / 洛阳 / 绍兴监国）。
- **`claim_role`**：并行 track 一律为 `rival`（并立）。是否并行只看是否「同时另立」；监国、傀儡不再作为单独角色。

实现见 `packages/shared/src/claimTracks.ts`，组件见 `ReignCard`（并立虚线描边）。

### 王朝 cluster group（三国、南北朝、五代十国等）

多个**并存**王朝各占一行，但同属一个历史时期时，用 `dynasty_groups` 表 + `dynasties.group_id` 标记：

- **组**有独立起止（如三国 220–280、五胡 304–439、南朝 420–589、五代 907–960）；外框按组 span 投影，**不被**成员王朝更早的建国年撑大（北魏 386、前凉 301、吴 902 可露在框外）。
- **组内**泳道仍按各王朝 `startAbs → endAbs → id` 从上到下排列；组与组之间也用同一套比较（同起年时更短的 `endAbs` 在上，如北朝在南朝之上、五代在十国之上）。
- 组名显示在背景框左上角（如「三国」「五胡」「五代」），数据来自 `dynasty_groups.name`。

与「相续泳道合并」（北宋/南宋压成一行，`dynastyLaneGroups.ts`）不同：cluster group **不折叠**泳道，只贴在一起并套框。

### 史料缺、无国君、年代失考如何区分

**史料缺**——「应该有王，但不知道是谁」

- 例：夏代部分世次仅有「某王」而无名。
- 必须有文献或学界共识支持「此期缺载」，才插入 `reign-missing-*` 占位。
- 导入脚本**不会**仅因相邻君主年份不连续就自动生成史料缺。

**无国君**——「这一时段确实没有该国君主」

- 例：前 223 年秦灭楚后至前 209 年项梁复楚之前，楚国作为独立政权不存在，时间轴上楚行留白，**不是**史料缺。
- 例：武周时期不在唐王朝行上为「空白」填占位皇帝。
- 有意留白：改朝、亡国、监国摄政未立君等，均不写 reign。

**年代失考**——「知道是谁，不知道确切在位年」

- 例：西周齐国早期丁公、乙公、癸公等，世系清楚而《史记》无精确年表；在相邻**锚点年**之间按世系**均分**时长，并标 `interpolated`。
- 均分后君主卡片首尾相接；仅当**前后两位君主都标失考**时才在交界处画波浪线（一侧有《史记》等锚点时，或一年实录短祚如卫戴公，不画）。
- 与灭国留白不同：哀公接癸公是父子相承、卡片相接，用波浪线；昌平君与义帝熊心之间是秦灭楚后的亡国期，中间**只留白、不画波浪线**。

### 失考年代的导入与前端

1. **导入**（春秋战国等由维基表生成的包）：`data/imports/chunqiu-zhanguo/build-rulers.mjs` 中 `fillUndatedYears` 在已知起止锚点之间，对无年表的国君按世系**均匀分配**年份（不设单条在位年上限）；插值结果写入 `start_date_confidence` / `end_date_confidence = interpolated`。
2. **库表**：`reigns.start_date_confidence`、`reigns.end_date_confidence`（`certain` 存为 `NULL`）。
3. **前端**：`packages/shared/src/reignBoundaries.ts` 的 `findReignUncertaintyBoundaries` 检测失考交界；`ReignUncertaintyGap` 画波浪线，`ReignGapCard` 画史料缺虚线框。

更完整的入库规范见 Skill [eralens-period-import](.cursor/skills/eralens-period-import/SKILL.md)。

## 交互

- 底部标尺拖拽平移，滚轮横向浏览
- `Cmd/Ctrl + 滚轮` 缩放
- `←/→` 步进，`Shift+←/→` 大步，`Home/End` 跳转数据首尾
- 点击皇帝卡片 / 事件标记打开右侧详情栏（可拖拽调宽，双击分隔条复位）

## 测试

```bash
pnpm test
```
