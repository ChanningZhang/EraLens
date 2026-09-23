import { useQuery } from "@tanstack/react-query";
import type { EntityDetail, EntityRef } from "@eralens/shared";
import { getRepository } from "@/data/repository";
import { useLaneColorValue } from "@/features/timeline/hooks/useLaneColor";
import { useSelection } from "@/features/timeline/hooks/useSelection";
import { useViewport } from "@/features/timeline/hooks/useViewport";
import {
  type SelectionState,
  selectionStore,
} from "@/features/timeline/state/selectionStore";
import { viewportStore } from "@/features/timeline/state/viewportStore";
import styles from "./DetailPanel.module.css";

const RELATED_GROUPS = [
  { key: "capital", title: "都城" },
  { key: "event", title: "事件" },
  { key: "idiom", title: "成语" },
  { key: "reign", title: "在位" },
  { key: "person", title: "人物" },
  { key: "dynasty", title: "王朝" },
] as const;

function groupRelatedItems(items: EntityDetail["related"]) {
  if (!items.length) return [];
  const grouped: Array<{
    title: string | null;
    items: EntityDetail["related"];
  }> = RELATED_GROUPS.map(({ key, title }) => ({
    title,
    items: items.filter((item) => item.group === key),
  })).filter((group) => group.items.length > 0);
  const ungrouped = items.filter((item) => !item.group);
  if (ungrouped.length > 0) {
    grouped.push({ title: null, items: ungrouped });
  }
  return grouped;
}

function selectRelatedItem(
  item: EntityDetail["related"][number],
  selection: SelectionState,
  centerAbs: number,
) {
  if (
    item.ref.type === "reign" &&
    selection.selected?.type === "person" &&
    item.abs !== undefined
  ) {
    selectionStore.setHighlightAbs(item.abs);
    viewportStore.jumpToAbs(item.abs);
    selectionStore.syncToUrl(centerAbs);
    return;
  }
  selectionStore.select(item.ref, item.abs);
  if (item.abs !== undefined) {
    viewportStore.jumpToAbs(item.abs);
  }
  selectionStore.syncToUrl(centerAbs);
}

function selectDetailRef(
  ref: EntityRef,
  abs: number,
  centerAbs: number,
) {
  selectionStore.select(ref, abs);
  viewportStore.jumpToAbs(abs);
  selectionStore.syncToUrl(centerAbs);
}

function selectTenureRef(
  tenure: EntityDetail["capitalTenures"][number]["tenure"],
  selection: SelectionState,
  centerAbs: number,
) {
  if (selection.selected?.type === "person") {
    selectionStore.setHighlightAbs(tenure.abs);
    viewportStore.jumpToAbs(tenure.abs);
    selectionStore.syncToUrl(centerAbs);
    return;
  }
  selectionStore.select(tenure.ref, tenure.abs);
  viewportStore.jumpToAbs(tenure.abs);
  selectionStore.syncToUrl(centerAbs);
}

export function DetailPanel() {
  const selection = useSelection();
  const viewport = useViewport();

  const detailQuery = useQuery({
    queryKey: [
      "entity",
      selection.selected?.type,
      selection.selected?.id,
      selection.focusReignId,
    ],
    queryFn: async () => {
      if (!selection.selected) throw new Error("No selection");
      const repo = await getRepository();
      if (selection.selected.type === "person") {
        return repo.getEntity(selection.selected, {
          focusReignId: selection.focusReignId ?? undefined,
        });
      }
      return repo.getEntity(selection.selected);
    },
    enabled: Boolean(selection.selected),
  });

  const dynastyId =
    selection.selected?.type === "dynasty"
      ? selection.selected.id
      : detailQuery.data?.dynastyId;
  const accent = useLaneColorValue(dynastyId) ?? "var(--color-accent)";

  const capitalTenures = detailQuery.data?.capitalTenures ?? [];
  const relatedItems = detailQuery.data?.related ?? [];

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
                <div
                  key={fact.label}
                  className={
                    fact.value.length > 36
                      ? `${styles.fact} ${styles.factBlock}`
                      : styles.fact
                  }
                >
                  <span className={styles.factLabel}>{fact.label}</span>
                  <span className={styles.factValue}>{fact.value}</span>
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

        {capitalTenures.length > 0 && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>在位</h3>
            <div className={styles.capitalTenureList}>
              {capitalTenures.map((row) => (
                <div
                  key={`${row.tenure.ref.id}:${row.tenure.abs}:${row.capital?.ref.id ?? "solo"}`}
                  className={
                    row.capital
                      ? styles.capitalTenureRow
                      : `${styles.capitalTenureRow} ${styles.capitalTenureRowSingle}`
                  }
                >
                  <button
                    type="button"
                    className={
                      selection.highlightAbs === row.tenure.abs
                        ? `${styles.capitalTenureCell} ${styles.capitalTenureCellActive}`
                        : styles.capitalTenureCell
                    }
                    onClick={() =>
                      selectTenureRef(row.tenure, selection, viewport.centerAbs)
                    }
                  >
                    <span
                      className={`${styles.capitalTenureLabel} ${styles.tenureLabel}`}
                    >
                      {row.tenure.label}
                    </span>
                  </button>
                  {row.capital && (
                    <button
                      type="button"
                      className={styles.capitalTenureCell}
                      onClick={() =>
                        selectDetailRef(row.capital!.ref, row.tenure.abs, viewport.centerAbs)
                      }
                    >
                      <span className={styles.capitalTenureLabel}>{row.capital.label}</span>
                      {row.capital.subtitle && (
                        <span className={styles.capitalTenureSub}>{row.capital.subtitle}</span>
                      )}
                    </button>
                  )}
                </div>
              ))}
            </div>
          </section>
        )}

        {relatedItems.length > 0 && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>关联</h3>
            {groupRelatedItems(relatedItems).map((group) => (
              <div key={group.title ?? "default"} className={styles.relatedGroup}>
                {group.title && (
                  <h4 className={styles.relatedGroupTitle}>{group.title}</h4>
                )}
                <div className={styles.relatedList}>
                  {group.items.map((item) => (
                    <button
                      key={`${item.ref.type}:${item.ref.id}`}
                      type="button"
                      className={
                        item.ref.type === "reign" &&
                        item.abs !== undefined &&
                        selection.highlightAbs === item.abs
                          ? `${styles.relatedItem} ${styles.relatedItemActive}`
                          : styles.relatedItem
                      }
                      onClick={() =>
                        selectRelatedItem(item, selection, viewport.centerAbs)
                      }
                    >
                      <span className={styles.relatedLabel}>{item.label}</span>
                      {item.subtitle && (
                        <span className={styles.relatedSub}>{item.subtitle}</span>
                      )}
                    </button>
                  ))}
                </div>
              </div>
            ))}
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
