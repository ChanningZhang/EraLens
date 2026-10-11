# iOS 迁移前基线（历史记录）

本文记录 Capacitor 迁移阶段的历史基线，不代表当前原生架构。当前 iOS 使用 UIKit + 系统 WKWebView，并通过共享 `packages/apple-native` Swift 包读取只读 SQLite；数据随应用版本更新。迁移方案见仓库根目录 `IOS_MIGRATION_PLAN.md`（该文件也保留为历史记录）。

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
| 原生容器 | UIKit + 系统 WKWebView；桥接与 SQLite 服务见 `packages/apple-native` |

Apple Team 尚未配置；这不阻止无签名模拟器构建，连接开发者账号后用于真机签名。

## 页面、查询窗口与数据量

迁移对照窗口固定为夏商周、公元前后交界、三国、南北朝、隋唐、宋辽金、明清和近现代。每个窗口需保存 timeline、catalog、搜索、entity detail、bounds、capitals 响应样本，并覆盖 `month/decade/century/millennium` LOD。固定实体详情类型为 dynasty、reign、person、event、capital。

仓库盘点记录的导入数据约 6.3 MB、40 个目录；manifest 至少包含 1,448 人物、1,220 条 reign、440 个事件、198 个都城和 876 条关系。这些是迁移计划中的数据规模参考，当前批次未连接 PostgreSQL 重算。

本机 API 可读时已记录八个窗口的响应计数、AbsMonth 范围、样本 id、都城数量及代表搜索结果，见 [baseline-query-samples.json](baseline-query-samples.json)。人物、王朝、reign、事件、都城的详情抽屉响应未纳入此样本文件；本机 API 在详情样本采集期间停止响应，后续需在 API 恢复后补采。当前 `/api/timeline` 路由不使用传入的 `lod` 值；iOS 仓库契约应在第 2 批显式对照四种 LOD。

## 视觉与性能采集

基线截图目录：[baseline-screenshots](baseline-screenshots/)。已保存 iPhone 17 Pro 模拟器 iOS 26.4 的首页竖屏与横屏截图；页面外壳正常显示，数据区显示 API 不可用提示。应补采桌面首页、上述八个历史窗口和五类详情抽屉的 Web 截图；最低版本与 iPad 截图也待补。

性能记录项：冷启动至首屏、首个 timeline 响应、窗口切换、搜索响应、详情打开、缩放期间帧率与峰值内存。桌面/浏览器和最低版本 iOS 设备分别记录。尚未采集这些性能数值；不要将 Vite 构建耗时当成应用性能基线。

## 当前可重复构建记录

历史 Capacitor 包体数据已不再适用。当前通过 `pnpm ios:build:sim` 构建模拟器应用，Xcode 构建阶段会自动生成并嵌入 Web 与 SQLite 资源。

## 设备覆盖状态

- Xcode 26.4 已安装，iOS SDK 26.4 可用。
- 已安装 iOS 26.4 Simulator runtime；iPhone 17 Pro 与 iPad (A16) 模拟器可用。
- `xcrun devicectl list devices` 当前未发现连接设备。
- iOS 16.2 runtime 和真机仍不可用，最低版本及真机运行验证尚未完成。
- iOS 26.4 iPhone 17 Pro 已完成空壳构建、启动和横竖屏旋转；探针 SQLite `integrity_check` 为 `ok`，参数查询回执为“秦始皇统一六国 / -221”，WebKit 返回 `color(srgb 0.5 0 0.5)`。
- 第 2 批构建已在 iPhone 17 Pro / iOS 26.4 安装启动，首页显示本地 SQLite 时间轴数据。
- iPad (A16) iOS 26.4 已安装并启动第 2 批构建；竖屏与横屏都显示本地 SQLite 时间轴数据。2:1 分屏适配尚未验证，留在第 3 批。
- 真机 SQLite 探针和 iOS 16.2 运行时仍待完成。
