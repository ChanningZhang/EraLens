# iOS WebKit 能力基线

产品最低系统版本：iOS/iPadOS 16.2。Vite 通过 `pnpm --filter @eralens/web build:ios` 固定生成 `safari16.2` 目标；普通 Web build 不受该目标覆盖。

| 能力 | 项目用途 | 最低版本策略 | 当前核验 |
|---|---|---|---|
| CSS `color-mix()` | 设计 token、卡片、地图与面板颜色 | iOS 16.2 WebKit 起可用；作为最低版本基线 | 等待 16.2 模拟器或真机视觉探针 |
| CSS `backdrop-filter` | 搜索、设置、图例、事件 marker、地图控件 | 同时声明 `-webkit-backdrop-filter`；背景先声明实色 fallback | 源码已核对；等待最低版本 WebKit 实测 |
| Pointer Events | 时间轴和地图拖动 | 使用统一 Pointer Events 路径 | 代码已有；触控行为留待后续交互批次实机验证 |
| `ResizeObserver` | 容器尺寸驱动布局 | 作为最低版本 API；不得依赖设备型号判断 | 源码已有；容器布局改造属于第 3 批 |
| `100dvh` 与 Safe Area | 全屏视口及刘海/Home Indicator | 根容器使用动态视口并纳入 `env(safe-area-inset-*)` | 当前布局尚未完成移动容器改造 |
| SVG | 时间轴、地图轮廓与覆盖层 | 保留当前 SVG 渲染 | 尚未在最低版本运行 |
| 网络字体 | 当前 Google Fonts 引用 | 移除远程 CSS 引用，走系统字体栈；稀有字仍随包提供 | HTML 已无 Google Fonts 请求；真机字形待确认 |

新 Web API、CSS 属性或原生桥接能力接入时，在此登记最低 WebKit 版本、降级路径与验证设备。不得用 User-Agent 代替能力检查。
