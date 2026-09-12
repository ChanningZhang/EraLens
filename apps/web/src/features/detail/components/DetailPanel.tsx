import { useQuery } from "@tanstack/react-query";
import { COLOR_VALUES } from "@eralens/shared";
import { getRepository } from "@/data/repository";
import { useSelection } from "@/features/timeline/hooks/useSelection";
import { useViewport } from "@/features/timeline/hooks/useViewport";
import { selectionStore } from "@/features/timeline/state/selectionStore";
import { viewportStore } from "@/features/timeline/state/viewportStore";
import styles from "./DetailPanel.module.css";

export function DetailPanel() {
  const selection = useSelection();
  const viewport = useViewport();

  const detailQuery = useQuery({
    queryKey: ["entity", selection.selected?.type, selection.selected?.id],
    queryFn: async () => {
      if (!selection.selected) throw new Error("No selection");
      const repo = await getRepository();
      return repo.getEntity(selection.selected);
    },
    enabled: Boolean(selection.selected),
  });

  const accent = detailQuery.data?.colorToken
    ? COLOR_VALUES[detailQuery.data.colorToken]
    : "var(--color-accent)";

  if (!selection.selected) return null;

  return (
    <aside
      className={styles.panel}
      style={{ ["--detail-accent" as string]: accent }}
    >
      <div className={styles.header}>
        <div className={styles.titleBlock}>
          <span className={styles.accent} />
          {detailQuery.isLoading ? (
            <p className={styles.loading}>加载中…</p>
          ) : detailQuery.error ? (
            <p className={styles.error}>无法加载详情</p>
          ) : (
            <>
              <h2 className={styles.title}>{detailQuery.data?.title}</h2>
              {detailQuery.data?.subtitle && (
                <p className={styles.subtitle}>{detailQuery.data.subtitle}</p>
              )}
            </>
          )}
        </div>
        <button
          type="button"
          className={styles.close}
          aria-label="关闭详情"
          onClick={() => selectionStore.clearSelection()}
        >
          ×
        </button>
      </div>

      <div className={styles.body}>
        {detailQuery.data?.facts && detailQuery.data.facts.length > 0 && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>要点</h3>
            <div className={styles.facts}>
              {detailQuery.data.facts.map((fact) => (
                <div key={fact.label} className={styles.fact}>
                  <span className={styles.factLabel}>{fact.label}</span>
                  <span>{fact.value}</span>
                </div>
              ))}
            </div>
          </section>
        )}

        {detailQuery.data?.summary && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>概述</h3>
            <p className={styles.summary}>{detailQuery.data.summary}</p>
          </section>
        )}

        {detailQuery.data?.related && detailQuery.data.related.length > 0 && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>关联</h3>
            <div className={styles.relatedList}>
              {detailQuery.data.related.map((item) => (
                <button
                  key={`${item.ref.type}:${item.ref.id}`}
                  type="button"
                  className={styles.relatedItem}
                  onClick={() => {
                    selectionStore.select(item.ref, item.abs);
                    if (item.abs !== undefined) {
                      viewportStore.jumpToAbs(item.abs);
                    }
                    selectionStore.syncToUrl(viewport.centerAbs);
                  }}
                >
                  <span className={styles.relatedLabel}>{item.label}</span>
                  {item.subtitle && (
                    <span className={styles.relatedSub}>{item.subtitle}</span>
                  )}
                </button>
              ))}
            </div>
          </section>
        )}

        {detailQuery.data?.links && detailQuery.data.links.length > 0 && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>来源</h3>
            <div className={styles.links}>
              {detailQuery.data.links.map((link) => (
                <a
                  key={link.url}
                  href={link.url}
                  className={styles.link}
                  target="_blank"
                  rel="noreferrer"
                >
                  {link.label}
                </a>
              ))}
            </div>
          </section>
        )}
      </div>
    </aside>
  );
}
