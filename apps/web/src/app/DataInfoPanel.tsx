import { useEffect, useState } from "react";
import type { NativeAppContentInfo } from "@eralens/data-access";
import { getNativeBridge, isNativeApp } from "@/data/nativePlatform";
import styles from "./DataInfoPanel.module.css";

export function DataInfoPanel() {
  const native = isNativeApp();
  const [info, setInfo] = useState<NativeAppContentInfo | null>(null);
  const [message, setMessage] = useState("");

  useEffect(() => {
    if (!native) return;
    try {
      void getNativeBridge().getContentInfo().then(setInfo).catch((error: unknown) => {
        setMessage(error instanceof Error ? error.message : "无法读取本地数据版本。");
      });
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "无法读取本地数据版本。");
    }
  }, [native]);

  return (
    <section className={styles.panel} aria-label="数据版本与来源">
      <h2>数据与来源</h2>
      {native ? <dl className={styles.metadata}>
        <dt>数据版本</dt><dd>{info?.datasetVersion ?? "读取中…"}</dd>
        <dt>数据库契约</dt><dd>{info ? `schema ${info.schemaVersion} · contract ${info.contractVersion}` : "—"}</dd>
        <dt>源代码版本</dt><dd>{info?.sourceGitSha && info.sourceGitSha !== "unknown" ? info.sourceGitSha.slice(0, 12) : "未记录"}</dd>
        <dt>构建时间</dt><dd>{info?.builtAt && info.builtAt !== "unknown" ? new Date(info.builtAt).toLocaleString("zh-CN") : "未记录"}</dd>
        <dt>应用版本</dt><dd>{info?.appVersion ?? "读取中…"}{info?.appBuild ? ` (${info.appBuild})` : ""}</dd>
      </dl> : <p className={styles.copy}>Web 版本从当前服务读取数据；iOS 与 Mac 版本随应用附带离线数据库。</p>}
      <p className={styles.copy}>历史事实来源列在各条目详情中。应用不会上传搜索内容或浏览位置；来源链接需要联网并会在系统浏览器中打开。</p>
      {native && <p className={styles.copy}>本地离线数据随 EraLens 应用版本更新。</p>}
      {message && <p className={styles.status} role="status">{message}</p>}
    </section>
  );
}
