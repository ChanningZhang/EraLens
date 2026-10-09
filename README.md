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

日常修改 `cache.json` 后运行 `pnpm db:import`：它生成全部包级 SQL，在一个事务中按表依赖顺序加载各包、生成搜索索引和版本元信息并校验现有内容库，不需重启 API；`pnpm data:validate` 可单独校验现有快照。`pnpm db:setup` / `pnpm data:build` 会构建临时 SQLite 并替换内容快照，仅用于首次初始化、schema 变更或确有必要的重建。重建或替换文件后必须重启正在运行的 API，否则其连接可能继续读取旧文件；随后核对 `/api/health` 的 `datasetVersion` 与库内版本、相关实体返回值和刷新后的页面。数据变更后运行 `pnpm ios:sync` 将同一快照同步到 iOS。

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

普通王朝的 `name` 为名称文本。改名阶段合并为同一条王朝记录后，`name` 保存含 `default` 与 `periods` 的 JSON 字符串，每个阶段包含 `name`、`start`、`end`（带 confidence 的历史日期）。`default` 保存俗称（如「成汉」），用于无时点或时点不在任何阶段内时的展示；`altNames[0]` 保存代表国号或自称（如「成」），与 default 独立。人物总览读取 `altNames[0]`；在位详情优先使用 `reigns.dynastyName`，其次回退 `altNames[0]` 和 default。泳道与地图按视口时间切换阶段名称，阶段范围外回退 default。整库构建以导入源的最终记录和引用为准，不再运行旧的增量合并脚本。

### 时间轴分层查询与性能验证

时间轴分别读取 `/api/timeline/reigns`、`/api/timeline/events`、`/api/timeline/persons`，参数为 `from`、`to`、`lod` 和可选 `scope`。三个响应都带 `datasetVersion`；传入期望版本 `datasetVersion` 时，版本不一致返回 409。在位响应附带 `context`，供命运线解析使用；事件自带关联 ID 与地点映射。底部人物接口在全库排除已有在位记录者，千年视图不发起该层查询。旧 `/api/timeline` 聚合接口保持可用。

前端各层独立缓存、取消和预取，相同窗口及数据版本就绪后才组合关联展示。内容版本每 30 秒及窗口重新聚焦时检查；普通导入不需要重建数据库。

性能与契约验证命令：

```bash
pnpm performance:contract
pnpm performance:http
pnpm performance:before
pnpm performance:after
```

前后基准使用冻结的旧 Repository 和当前实现，预热 10 次、采样 200 次，并将原始数据写入 `docs/performance/`。应依次运行两个基准，避免并行构建或测试造成干扰。测试只读访问内容库，不运行数据构建或导入。方法、结果和局限见 [SQL 性能报告](docs/sqlite-performance.md)。
