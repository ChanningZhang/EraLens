# iOS 数据更新发布

EraLens 启动和浏览不请求网络。数据更新仅从“数据与来源”页面由用户手动检查；manifest 与 SQLite 文件均走 HTTPS。搜索内容、浏览位置和设备标识不会随更新请求发送。

## 签名格式

`sign-mobile-manifest.mjs` 读取 SQLite 快照和 Ed25519 PKCS#8 私钥，输出 `{ payload, signature }` JSON envelope。`payload` 是字段名按字典序稳定序列化后的 JSON 字节再做 Base64；签名为 Ed25519 Base64。payload 包含不可变 HTTPS 下载地址、文件大小、SHA-256、数据版本、schema/contract 版本、最低应用 build 和来源提交。

私钥只保存在受控发布机或密钥管理器中，绝不提交仓库，也不要将私钥内容写入 shell 命令参数。签名脚本只接受私钥文件路径。它会输出对应的 32 字节公钥 Base64；将公钥与 manifest URL 注入 iOS target 的 `ERA_DATA_PUBLIC_KEY` 和 `ERA_DATA_MANIFEST_URL` build settings，再构建应用。两项留空时更新器关闭，离线数据仍可用。

示例（将变量指向受控路径和已发布的不可变 asset）：

```bash
pnpm data:mobile:sign-manifest -- \
  --private-key=/secure/keys/eralens-ed25519.pem \
  --dataset-version=2026.09.27.1 \
  --url=https://downloads.example.org/eralens/2026.09.27.1/eralens-content.sqlite \
  --min-app-build=1 \
  --out=/secure/release/latest.json
```

不要覆盖已发布的数据版本 URL；仅 `latest.json` 指向新版本。`datasetVersion` 应由发布流程显式传入，不能直接发布本地快照的 `local-*` 版本。

## 客户端更新顺序

原生插件先验 Ed25519 签名和兼容版本，再下载候选库；随后校验大小、SHA-256、SQLite `integrity_check`、`foreign_key_check`、metadata 及版本号。只有全部通过才会写入候选路径。用户点击安装时，客户端先关闭 SQLite 连接，将当前库保留为上一版本，再以文件替换安装候选库。失败时保留原库；下次启动继续从当前本地库离线工作。更新器不执行数据包中的 SQL、migration、脚本或 Web 资源。

`@capacitor/preferences` 在原生首次读取或写入时迁移旧版 WebView 的 localStorage，并在迁移成功后移除旧副本；更新内容库不会改动偏好设置。
