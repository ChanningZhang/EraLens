---
name: eralens-ios-cli
description: >-
  使用命令行构建、同步、运行、测试和诊断 EraLens 的 Capacitor iOS/iPadOS 应用。
  Use when the user asks to compile or debug EraLens for an iPhone/iPad simulator or device,
  run xcodebuild/simctl/devicectl, inspect an iOS build failure, or avoid the Xcode GUI.
---

# EraLens iOS CLI

以命令行为默认工作面。完整 Xcode 应用仍是必需依赖，因为 iOS SDK、模拟器、`xcodebuild`、`xcrun` 和签名工具由它提供；日常构建、安装、启动、日志和测试不要求打开 Xcode 界面。

## 开始前

1. 阅读仓库根目录 `AGENTS.md` 和 `IOS_MIGRATION_PLAN.md`。
2. 用 `rg --files` 查找实际的 `capacitor.config.*`、`.xcworkspace`、`.xcodeproj`、`ExportOptions.plist` 和相关 package scripts。
3. 先判断任务属于哪一种：
   - **环境检查**：验证 Xcode、SDK、模拟器和签名环境；
   - **同步/构建**：构建 Web/数据并同步 Capacitor，再执行原生构建；
   - **模拟器运行**：选择一个明确 UDID，安装并启动应用；
   - **真机运行**：检查签名后用 `devicectl` 安装和启动；
   - **测试/诊断**：运行 XCTest/XCUITest、读取日志或分析构建结果；
   - **归档**：生成 Archive/IPA，但只有用户要求发布产物时才执行。
4. 如果仓库还没有 iOS 工程：
   - 用户只要求“编译/运行”时，报告尚无可编译工程和缺少的前置批次，不擅自 scaffold；
   - 用户要求“创建/迁移并编译”时，按迁移计划建立 Capacitor 工程后继续。

需要具体命令模板时阅读 [references/commands.md](references/commands.md)。只读取与当前模式有关的部分。

## 固定约束

- 优先使用仓库已经提供的 `pnpm ios:*` 和 `data:mobile:*` 脚本；没有脚本时才组合底层命令。
- iOS 同步顺序必须是：数据快照（如该构建需要）→ Web production build → `cap sync ios` → `xcodebuild`。不能用旧 Web bundle 或手工向 Xcode 拖数据库。
- 离线验收构建不得配置 live reload URL，也不得从开发服务器加载页面。
- 从工程中发现 workspace、scheme、bundle id、product name 和 App 路径；不要假定它们永远叫 `App` 或 `EraLens`。
- 模拟器命令使用明确 UDID。存在多个 booted 设备时不要使用含糊的 `booted` 目标。
- 模拟器编译通常设置 `CODE_SIGNING_ALLOWED=NO`；真机编译不得关闭签名。
- 不自动修改 Apple Team、Bundle ID、证书、provisioning profile 或 keychain。缺少签名材料时说明准确缺项。
- 不把 Apple ID、App Store Connect 密钥、证书密码或 provisioning 内容写入仓库、日志或命令输出。
- `DerivedData` 使用仓库内的专用临时路径（如 `.build/ios/DerivedData`）。禁止清空用户的整个 `~/Library/Developer/Xcode/DerivedData`。
- 不 erase 全部模拟器、不删除全部 runtimes、不切换全局 `xcode-select`，除非用户明确要求相应系统级操作。
- 不用原生代码重写 `@eralens/shared` 的时间、称谓、正统、区间或布局逻辑。

## 标准工作流

### 1. 环境与工程发现

检查并记录：

- `xcode-select -p` 指向完整 Xcode；
- `xcodebuild -version`；
- 已安装 SDK：`xcodebuild -showsdks`；
- 可用模拟器 runtime/device：`xcrun simctl list runtimes`、`xcrun simctl list devices available`；
- Node/pnpm 版本；
- Capacitor依赖版本是否同一主版本；
- workspace 中的实际 scheme：`xcodebuild -workspace ... -list`。

只在命令明确报 license / first-launch 未完成时建议 `xcodebuild -runFirstLaunch` 或接受许可；涉及管理员权限时留给用户执行。

### 2. 同步 Web 与数据

先查看根目录和相关 workspace 的 `package.json`。若存在 `pnpm ios:sync`，使用它。否则按项目实际路径运行数据构建、Web build 和 Capacitor sync。同步后确认：

- 原生工程内的 Web assets 来自当前提交；
- SQLite 内容快照及 metadata 已复制；
- Capacitor config 的 `webDir` 指向真实构建目录；
- iOS 工程依赖已同步。

### 3. 构建

先做无需签名的 generic simulator build，尽早发现 Swift、插件、资源和链接错误。需要运行时，再针对一个已选模拟器 UDID 构建。

始终保留完整 `xcodebuild` 退出码。输出很长时用 `-resultBundlePath` 保存结果，并向用户报告第一处根因错误，而不是最后一串连带错误。

### 4. 模拟器运行与调试

1. 从 `simctl list devices available` 选择设备和 UDID。
2. boot 并等待 `bootstatus -b`。
3. 构建后通过 build settings 获得 `TARGET_BUILD_DIR`、`WRAPPER_NAME`、`PRODUCT_BUNDLE_IDENTIFIER`。
4. `simctl install`，再 `simctl launch`。
5. 日志使用目标进程名或 subsystem 过滤；避免输出全部系统日志。
6. 截图使用 `simctl io <UDID> screenshot`。
7. 横竖屏自动化通过 XCUITest 设置 `XCUIDevice.shared.orientation`，不要依赖手工操作 Simulator 界面。

WKWebView/Capacitor 问题按以下顺序诊断：Web build → `webDir`/base path → `cap sync` 产物 → 本地资源/字体 → SQLite 复制与版本 → Capacitor bridge → React 运行日志。白屏时先确认 `index.html` 和静态资源确实进入应用包。

### 5. 真机

先用 `xcrun devicectl list devices` 确认设备连接和 Developer Mode。真机构建需要已经安装的有效签名证书、匹配的 provisioning profile、正确 Team 与唯一 Bundle ID。

配置齐全后可完全通过 `xcodebuild` + `devicectl` 构建、安装、启动和读取启动控制台。若机器从未配置 Apple 开发账号，Xcode GUI 是最方便的一次性配置方式；也可以由用户提供已经安装的证书/profile，或另行配置受保护的 CI signing。不要为了“全 CLI”把密钥写进项目。

### 6. 测试与离线验收

- 共享 TypeScript 测试先按仓库脚本运行；只有用户要求测试/验证时执行。
- 原生单元/UI 测试使用 `xcodebuild test`，并指定 workspace、scheme、destination 和专用 DerivedData。
- 方向、竖屏地图底部对齐和旋转状态保持应由 XCUITest 断言；竖屏不检查固定上下区域比例。
- 完全离线验收使用 production Web bundle 和本地 SQLite；不要把开发服务器不可达误判为离线能力通过。
- 数据热更新测试分别覆盖：无网络、无更新、正常更新、错误签名、错误 hash、schema 不兼容、下载中断和回退。

### 7. 结果报告

报告必须包含：

- 使用的 Xcode/SDK、workspace、scheme 和 destination；
- Web/Capacitor sync 是否执行；
- build/test 的明确成功或第一处失败根因；
- 模拟器或真机是否完成安装和启动；
- 离线、横竖屏、数据库版本中实际验证了哪些；
- 生成的 `.app`、`.xcresult`、archive 或日志的绝对路径；
- 未验证项及其具体阻塞条件。

## 常见失败的处理边界

- **找不到 Web assets**：检查 Vite 输出和 `webDir`，重新 build + sync；不手改生成目录冒充修复。
- **旧页面/旧数据库**：检查同步顺序、资源时间戳和数据 metadata；不要清空全局 Xcode cache。
- **签名失败**：区分模拟器、真机、archive；模拟器无需签名，真机报告缺少的 Team/certificate/profile。
- **destination 找不到**：重新列举可用 runtime 和 device，使用 UDID；不硬编码设备名称。
- **数据库打不开**：检查包内资源、复制路径、文件权限、schema/contract 版本、hash 和 SQLite integrity。
- **JS 白屏**：捕获 Capacitor/WebKit 日志，检查 base URL、资源 404、未捕获异常和插件注册。
- **旋转不工作**：检查 Info.plist 的 iPhone/iPad orientations、容器尺寸响应和 XCUITest，而不是只检查 CSS media query。
