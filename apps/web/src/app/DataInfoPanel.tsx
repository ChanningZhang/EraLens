import { useEffect, useState } from "react";
import { closeRepositoryForContentUpdate } from "@/data/repository";
import {
  checkMobileDataUpdate, getMobileContentInfo, installMobileDataUpdate,
  isNativeApp, type MobileContentInfo,
} from "@/data/mobileUpdates";
import styles from "./DataInfoPanel.module.css";

export function DataInfoPanel() {
  const native = isNativeApp();
  const [info, setInfo] = useState<MobileContentInfo | null>(null);
  const [message, setMessage] = useState("");
  const [updateAvailable, setUpdateAvailable] = useState(false);
  const [busy, setBusy] = useState(false);

  useEffect(() => {
    if (!native) return;
    void getMobileContentInfo().then(setInfo).catch(() => {
      setMessage("无法读取本地数据版本，离线内容仍可继续使用。");
    });
  }, [native]);

  const checkUpdate = async () => {
    setBusy(true);
    setMessage("正在检查数据版本…");
    setUpdateAvailable(false);
    try {
      const result = await checkMobileDataUpdate();
      setMessage(result.message);
      setUpdateAvailable(result.available);
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "检查失败，当前数据仍可用。");
    } finally {
      setBusy(false);
    }
  };

  const installUpdate = async () => {
    setBusy(true);
    setMessage("正在替换数据文件…");
    try {
      await closeRepositoryForContentUpdate();
      const result = await installMobileDataUpdate();
      setMessage(`${result.message} 正在重新载入时间轴。`);
      window.setTimeout(() => window.location.reload(), 300);
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "更新未安装，原数据仍保留。");
    } finally {
      setBusy(false);
    }
  };

  return (
    <section className={styles.panel} aria-label="数据版本与来源">
      <h2>数据与来源</h2>
      {native ? <dl className={styles.metadata}>
        <dt>数据版本</dt><dd>{info?.datasetVersion ?? "读取中…"}</dd>
        <dt>数据库契约</dt><dd>{info ? `schema ${info.schemaVersion} · contract ${info.contractVersion}` : "—"}</dd>
        <dt>源代码版本</dt><dd>{info?.sourceGitSha && info.sourceGitSha !== "unknown" ? info.sourceGitSha.slice(0, 12) : "未记录"}</dd>
        <dt>构建时间</dt><dd>{info?.builtAt && info.builtAt !== "unknown" ? new Date(info.builtAt).toLocaleString("zh-CN") : "未记录"}</dd>
      </dl> : <p className={styles.copy}>Web 版本从当前服务读取数据；iOS 版本随应用附带离线数据库。</p>}
      <p className={styles.copy}>历史事实来源列在各条目详情中。应用不会上传搜索内容或浏览位置；来源链接需要联网并会在系统浏览器中打开。</p>
      {native && <div className={styles.actions}>
        <button type="button" disabled={busy} onClick={() => void checkUpdate()}>{busy ? "请稍候…" : "手动检查更新"}</button>
        {updateAvailable && <button type="button" disabled={busy} onClick={() => void installUpdate()}>安装已校验的数据</button>}
      </div>}
      {message && <p className={styles.status} role="status">{message}</p>}
    </section>
  );
}
