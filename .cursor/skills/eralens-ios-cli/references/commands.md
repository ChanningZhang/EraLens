# EraLens iOS CLI 命令参考

仅在执行相应模式时使用本参考。命令中的路径、scheme、bundle id、进程名和 UDID 都必须先从当前工程发现，不能照抄占位值。

## 1. 环境探针

```bash
xcode-select -p
xcodebuild -version
xcodebuild -showsdks
xcrun simctl list runtimes
xcrun simctl list devices available
xcrun devicectl list devices
node --version
pnpm --version
```

如果 `xcode-select -p` 指向 CommandLineTools 而不是完整 Xcode，报告应切换到类似 `/Applications/Xcode.app/Contents/Developer`。不要自行执行需要管理员权限的全局切换。

## 2. 工程发现

```bash
rg --files -g 'capacitor.config.*' -g '*.xcworkspace/**' -g '*.xcodeproj/**' -g 'ExportOptions.plist'
rg -n '"ios:[^"]*"|"data:mobile:[^"]*"|@capacitor/(core|cli|ios)' package.json apps/**/package.json
```

列出 workspace scheme：

```bash
xcodebuild -workspace <workspace-path> -list
```

若工程使用 `.xcodeproj` 且没有 workspace，把后续 `-workspace` 换成 `-project`。Capacitor 工程通常使用 workspace，但必须以仓库实际产物为准。

## 3. Web/数据同步

首选仓库封装脚本：

```bash
pnpm data:mobile:build
pnpm data:mobile:validate
pnpm ios:sync
```

若这些脚本尚未建立，先查看 package scripts 和 Capacitor config，再使用等价的项目命令。典型底层顺序为：

```bash
pnpm --filter @eralens/web build
pnpm exec cap sync ios
```

不要在不知道 config 所属 workspace 时从错误目录执行 `cap sync`。

## 4. 无签名模拟器编译

使用专用 DerivedData 和结果包：

```bash
xcodebuild \
  -workspace <workspace-path> \
  -scheme <scheme> \
  -configuration Debug \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath <repo>/.build/ios/DerivedData \
  -resultBundlePath <repo>/.build/ios/Build.xcresult \
  CODE_SIGNING_ALLOWED=NO \
  build
```

若结果包已存在，给本次执行使用新的明确路径；不要盲目覆盖仍需诊断的 `.xcresult`。

## 5. 选择、启动模拟器

```bash
xcrun simctl list devices available
xcrun simctl boot <simulator-udid>
xcrun simctl bootstatus <simulator-udid> -b
```

设备已经 boot 时 `simctl boot` 可能返回非零；先读错误，若只是 already booted 可继续，不要把所有错误用 `|| true` 吞掉。

针对该模拟器构建：

```bash
xcodebuild \
  -workspace <workspace-path> \
  -scheme <scheme> \
  -configuration Debug \
  -destination 'id=<simulator-udid>' \
  -derivedDataPath <repo>/.build/ios/DerivedData \
  CODE_SIGNING_ALLOWED=NO \
  build
```

获取产物信息：

```bash
xcodebuild \
  -workspace <workspace-path> \
  -scheme <scheme> \
  -configuration Debug \
  -destination 'id=<simulator-udid>' \
  -showBuildSettings
```

从输出读取：

- `TARGET_BUILD_DIR`
- `WRAPPER_NAME`
- `PRODUCT_BUNDLE_IDENTIFIER`
- `PRODUCT_NAME`

安装与启动：

```bash
xcrun simctl install <simulator-udid> <TARGET_BUILD_DIR>/<WRAPPER_NAME>
xcrun simctl launch <simulator-udid> <PRODUCT_BUNDLE_IDENTIFIER>
```

需要立即观察启动输出时可使用 `simctl launch --console-pty`；该命令会占用前台会话，应使用可管理的终端 session，并在完成后正常中止。

## 6. 日志、截图与应用状态

按进程过滤模拟器 unified log：

```bash
xcrun simctl spawn <simulator-udid> log stream \
  --style compact \
  --level debug \
  --predicate 'process == "<PRODUCT_NAME>"'
```

截图：

```bash
mkdir -p <repo>/.build/ios/screenshots
xcrun simctl io <simulator-udid> screenshot <repo>/.build/ios/screenshots/<name>.png
```

终止/重新启动应用：

```bash
xcrun simctl terminate <simulator-udid> <PRODUCT_BUNDLE_IDENTIFIER>
xcrun simctl launch <simulator-udid> <PRODUCT_BUNDLE_IDENTIFIER>
```

不要默认卸载应用，因为卸载会删除本地 SQLite、设置和升级测试状态。只有测试首次安装流程时才明确卸载目标 bundle id。

## 7. XCTest / XCUITest

```bash
xcodebuild test \
  -workspace <workspace-path> \
  -scheme <scheme> \
  -configuration Debug \
  -destination 'id=<simulator-udid>' \
  -derivedDataPath <repo>/.build/ios/DerivedData \
  -resultBundlePath <repo>/.build/ios/Tests.xcresult \
  CODE_SIGNING_ALLOWED=NO
```

只执行特定测试：

```bash
xcodebuild test \
  -workspace <workspace-path> \
  -scheme <scheme> \
  -destination 'id=<simulator-udid>' \
  -only-testing:<TestTarget>/<TestClass>/<testMethod>
```

方向测试由 XCUITest 设置：

```swift
XCUIDevice.shared.orientation = .portrait
XCUIDevice.shared.orientation = .landscapeLeft
XCUIDevice.shared.orientation = .landscapeRight
```

竖屏布局应暴露稳定 accessibility identifiers，让测试读取 workspace 和地图图形的 frame；扣除 safe area 后断言地图下边缘与可用内容区底部对齐，并确认布局没有使用垂直居中或固定上下区域比例。

## 8. 真机构建、安装与启动

列出设备：

```bash
xcrun devicectl list devices
```

签名配置存在时，使用设备 UDID 构建：

```bash
xcodebuild \
  -workspace <workspace-path> \
  -scheme <scheme> \
  -configuration Debug \
  -destination 'id=<device-udid>' \
  -derivedDataPath <repo>/.build/ios/DerivedData \
  build
```

如果工程允许 Xcode 自动管理签名且本机账号已配置，可在明确需要时增加 `-allowProvisioningUpdates`。不要把 Team ID 或登录凭据硬编码到 Skill 或仓库。

安装与启动：

```bash
xcrun devicectl device install app \
  --device <device-identifier> \
  <signed-app-path>

xcrun devicectl device process launch \
  --device <device-identifier> \
  <PRODUCT_BUNDLE_IDENTIFIER>
```

真机 CLI 能否完全工作取决于 Developer Mode、pairing、证书和 profile 是否已经配置。缺少其中任一项时，先报告具体状态。

## 9. Archive 与导出

只有用户要求生成分发产物时执行：

```bash
xcodebuild archive \
  -workspace <workspace-path> \
  -scheme <scheme> \
  -configuration Release \
  -destination 'generic/platform=iOS' \
  -archivePath <repo>/.build/ios/EraLens.xcarchive

xcodebuild -exportArchive \
  -archivePath <repo>/.build/ios/EraLens.xcarchive \
  -exportPath <repo>/.build/ios/export \
  -exportOptionsPlist <export-options-path>
```

`ExportOptions.plist`、Team、证书和上传方式由实际分发模式决定。不要生成假的签名配置，也不要提交 secrets。

## 10. 诊断顺序

### 构建失败

1. 找第一条 `error:` 及所属 target。
2. 区分 Web build、Capacitor sync、Swift compile、link、resources、signing、destination。
3. 检查 `Build.xcresult` 和当前 scheme/build configuration。
4. 修复根因后只重跑必要层级。

### 启动白屏

1. 应用包是否含 `index.html` 和 Vite assets；
2. `capacitor.config.*` 的 `webDir` 与 Vite base；
3. `cap sync` 是否在 Web build 之后执行；
4. WKWebView/Capacitor 日志中的资源 404、CSP 和 JS exception；
5. 本地 SQLite 是否存在、hash/schema 是否匹配、复制是否完成；
6. 字体和 SVG 是否仍引用网络或绝对 Web 路径。

### 数据旧或更新失败

1. 应用包和 Application Support 中的 `datasetVersion`；
2. 当前库、候选库、上一版本库路径；
3. manifest 签名、SHA-256、`schemaVersion`、`contractVersion`、`minAppBuild`；
4. `integrity_check`、`foreign_key_check`；
5. 原子替换后是否重新打开连接并清理 Query cache。
