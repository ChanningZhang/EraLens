# iOS 迁移前基线

记录日期：2026-09-27。来源为当前工作树与现有生产数据导入包；屏幕视觉及设备运行数据必须在装有 iOS 16.2 runtime 的 Xcode 主机和真机上补采。

## 工具与应用

| 项目 | 基线 |
|---|---|
| Xcode | 26.4 (Build 17E192) |
| iOS SDK / Simulator SDK | 26.4 |
| Node / pnpm | 23.7.0 / 9.15.4 |
| Web | React 19 + TypeScript + Vite；HTTP Repository 为默认数据源 |
| Bundle ID / 显示名 | `com.eralens.app` / `EraLens` |
| 最低系统版本 | iOS/iPadOS 16.2（工程配置） |
| Capacitor | core / CLI / iOS 均固定 8.5.2 |
| SQLite 插件 | `@capacitor-community/sqlite` 8.1.1 |

Apple Team 尚未配置；这不阻止无签名模拟器构建，连接开发者账号后用于真机签名。

## 页面、查询窗口与数据量

迁移对照窗口固定为夏商周、公元前后交界、三国、南北朝、隋唐、宋辽金、明清和近现代。每个窗口需保存 timeline、catalog、搜索、entity detail、bounds、capitals 响应样本，并覆盖 `month/decade/century/millennium` LOD。固定实体详情类型为 dynasty、reign、person、event、capital。

仓库盘点记录的导入数据约 6.3 MB、40 个目录；manifest 至少包含 1,448 人物、1,220 条 reign、440 个事件、198 个都城和 876 条关系。这些是迁移计划中的数据规模参考，当前批次未连接 PostgreSQL 重算。

本机 API 可读时已记录八个窗口的响应计数、AbsMonth 范围、样本 id、都城数量及代表搜索结果，见 [baseline-query-samples.json](baseline-query-samples.json)。人物、王朝、reign、事件、都城的详情抽屉响应未纳入此样本文件；本机 API 在详情样本采集期间停止响应，后续需在 API 恢复后补采。当前 `/api/timeline` 路由不使用传入的 `lod` 值；iOS 仓库契约应在第 2 批显式对照四种 LOD。

## 视觉与性能采集

基线截图目录：[baseline-screenshots](baseline-screenshots/)。已保存 iPhone 17 Pro 模拟器 iOS 26.4 的首页竖屏与横屏截图；页面外壳正常显示，数据区显示 API 不可用提示。应补采桌面首页、上述八个历史窗口和五类详情抽屉的 Web 截图；最低版本与 iPad 截图也待补。

性能记录项：冷启动至首屏、首个 timeline 响应、窗口切换、搜索响应、详情打开、缩放期间帧率与峰值内存。桌面/浏览器和最低版本 iOS 设备分别记录。当前主机没有可用 Simulator runtime 或已连接设备，尚未采集这些截图与运行时数值；不要将 Vite 构建耗时当成应用性能基线。

## 当前可重复构建记录

`pnpm --filter @eralens/web build:ios`：Vite 6.4.3 成功，输出 CSS 45.61 kB、repository chunk 1.39 kB、主 JS 716.48 kB（gzip 分别为 9.09 / 0.57 / 234.53 kB）。主 JS 超过 500 kB 的 Vite 提示作为首轮包体记录，不在第 0 批调整代码拆分。

## 设备覆盖状态

- Xcode 26.4 已安装，iOS SDK 26.4 可用。
- `xcrun simctl list runtimes` 当前没有已安装的模拟器 runtime。
- `xcrun devicectl list devices` 当前未发现连接设备。
- iOS 16.2 离线启动、旋转、`color-mix()` 运行时显示和 SQLite 真机探针因此尚未完成。
- iOS 26.4 iPhone 17 Pro 已完成空壳构建、启动和横竖屏旋转；探针 SQLite `integrity_check` 为 `ok`，参数查询回执为“秦始皇统一六国 / -221”，WebKit 返回 `color(srgb 0.5 0 0.5)`。
- iPad (A16) iOS 26.4 已安装并启动空壳；iPad 可旋转，但现有 Web 界面尚未适配横屏与 2:1 分区，此项留在第 3 批。
- 真机 SQLite 探针和 iOS 16.2 运行时仍待完成。
