# EraLens

EraLens 是中国历史时间轴。拖动底部标尺可以浏览不同时期；王朝、君主、人物和事件随时间窗口变化。点击王朝名或时间轴上的内容，可以在右侧查看详情。

时间轴收录约夏商至近现代的王朝与政权，也展示并立君主、年代失考和跨王朝的君主命运关系。

## 启动

需要 Node.js 22.16 或更新版本和 pnpm。开发环境直接构建 SQLite 内容库并启动 Web 与 API，无需 Docker 或 PostgreSQL：

```bash
pnpm install
pnpm db:setup
pnpm dev:all
```

打开 [http://localhost:5173](http://localhost:5173)。Web 请求本地 Fastify API（默认 3001 端口）；API 从 `CONTENT_DB_PATH` 只读加载内容库，并将共享事件设置保存在 `STATE_DB_PATH`。默认内容快照为 `data/mobile/eralens-content.sqlite`，设置库为 `data/mobile/eralens-state.sqlite`。

也可以通过 Docker Compose 启动打包后的 Web/API：

```bash
docker compose up --build
```

打开 [http://localhost:8080](http://localhost:8080)。Docker 构建会从真实导入源生成并校验内容快照；设置库保存在 `eralens-state` 持久卷中。无需启动数据库容器。部署切换时如需带入旧 `sys_config` 设置，可将原库导出为 `{ "key": "value" }` JSON，再执行 `pnpm settings:import -- --input=/path/to/settings.json`。

日常修改 `cache.json` 后运行 `pnpm db:import`：它生成全量 SQLite SQL，在事务中更新现有内容库并校验，不需重启 API；`pnpm data:validate` 可单独校验现有快照。`pnpm db:setup` / `pnpm data:build` 会构建临时 SQLite 并替换内容快照，仅用于首次初始化、schema 变更或确有必要的重建。重建或替换文件后必须重启正在运行的 API，否则其连接可能继续读取旧文件；随后核对 `/api/health` 的 `datasetVersion` 与库内版本、相关实体返回值和刷新后的页面。数据变更后运行 `pnpm ios:sync` 将同一快照同步到 iOS。

## 使用时间轴

- 拖动底部标尺，或用触控板双指横向滚动，平移时间窗口。
- 按 `Cmd/Ctrl + 滚轮` 或在触控板上捏合，缩放时间轴。
- 按 `←/→` 小步移动；按 `Shift+←/→` 大步移动；按 `Home/End` 跳到数据首尾。
- 用顶栏搜索查找王朝、人物或事件，并跳转到对应位置。
- 鼠标悬停、键盘聚焦或触屏长按卡片查看时间等提示；点击君主卡、事件、人物或左侧王朝名，打开右侧详情。详情面板可拖宽，双击分隔条可恢复宽度。

## 读懂时间轴

- **王朝泳道**按时间横向展开。前后相续的部分政权共用一行；同时并存的政权各占一行，相关时期可能有背景框。
- **君主卡片**的横向长度对应在位时间。金色表示该段被标为正统；其他颜色用于区分泳道。
- **并立君主**在同一泳道内上下分行，卡片用浅填充和虚线描边。
- **「史料缺」虚线框**表示有君主但姓名或世次失载；**自然留白**表示该时段没有该政权的君主。已知君主但年代靠推算的边界以波浪线提示。
- **跨泳道虚线**连接被杀、投降、禅让或被俘的君主与另一政权的接收方；灭国线连接末君与灭国方当时的君主。悬停可查看关系。
- **事件与人物**提供王朝和君主卡片以外的信息；缩小到较大时间范围时，人物层可能隐藏。

年精度的时间只显示年份，不会把用于定位的占位月份当作史实展示。

## 开发与数据维护

项目结构、接口、数据库命令、入库规则和排查约定见 [AGENTS.md](AGENTS.md)。时期数据位于 `data/imports/`；`data/seed/` 是体验和 Mock 使用的示例数据。

人物、事件、王朝的普通关联统一维护在 [entity-associations/cache.json](data/imports/entity-associations/cache.json)，数据库使用无向的 `entity_associations` 表；`relations` 仅保存命运与人物继承关系。导入规则见 [数据维护说明](data/imports/README.md)。移动数据版本统一由 [versions.json](data/mobile/versions.json) 定义；修改数据后重新生成并校验移动数据库。

### 王朝分时名称

普通王朝的 `name` 为名称文本。改名阶段合并为同一条王朝记录后，`name` 保存仅含 `periods` 的 JSON 字符串，每个阶段包含 `name`、`start`、`end`（带 confidence 的历史日期）。代表显示名称放在 `altNames[0]`；人物与在位详情使用代表名称，泳道按视口时间切换名称。整库构建以导入源的最终记录和引用为准，不再运行旧的增量合并脚本。
