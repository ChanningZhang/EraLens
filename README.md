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
pnpm db:setup      # 仅启动 Docker PostgreSQL + migrate + seed
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
pnpm db:seed      # 导入 data/seed JSON
pnpm db:down      # 停止容器
```

按时期增量导入历史数据：使用项目 Skill **eralens-period-import**（`.cursor/skills/eralens-period-import/`），生成 SQL 至 `data/imports/{slug}/` 后执行校验与入库。

## 交互

- 底部标尺拖拽平移，滚轮横向浏览
- `Cmd/Ctrl + 滚轮` 缩放
- `←/→` 步进，`Shift+←/→` 大步，`Home/End` 跳转数据首尾
- 点击皇帝卡片 / 事件标记打开右侧详情栏（可拖拽调宽，双击分隔条复位）

## 测试

```bash
pnpm test
```
