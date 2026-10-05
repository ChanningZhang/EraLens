import { useQuery } from "@tanstack/react-query";
import type { EntityDetail, EntityRef } from "@eralens/shared";
import { entityDetailQueryOptions } from "../entityDetailQuery";
import { useLaneColorValue } from "@/features/timeline/hooks/useLaneColor";
import { useSelection } from "@/features/timeline/hooks/useSelection";
import { isNativeApp, openExternalSource } from "@/data/mobileUpdates";
import { useViewport } from "@/features/timeline/hooks/useViewport";
import {
  type SelectionState,
  selectionStore,
} from "@/features/timeline/state/selectionStore";
import { viewportStore } from "@/features/timeline/state/viewportStore";
import styles from "./DetailPanel.module.css";
import { CapitalCard } from "./CapitalCard";

const RELATED_GROUPS = [
  { key: "location_mapping", title: "都城" },
  { key: "location", title: "地点" },
  { key: "event", title: "事件" },
  { key: "idiom", title: "成语" },
  { key: "poetry", title: "诗歌" },
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
  selectionStore.navigateToDetail(item.ref, item.abs, centerAbs);
  if (item.abs !== undefined) {
    viewportStore.jumpToAbs(item.abs);
  }
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
  selectionStore.navigateToDetail(tenure.ref, tenure.abs, centerAbs);
  viewportStore.jumpToAbs(tenure.abs);
  selectionStore.syncToUrl(centerAbs);
}

export function DetailPanel() {
  const selection = useSelection();
  const viewport = useViewport();

  const detailQuery = useQuery(entityDetailQueryOptions(selection.selected, selection.focusReignId, selection.highlightAbs ?? undefined));
  const detail = detailQuery.data?.detail;
  const displayedSelection = detailQuery.data;
  const switchingDetail = detailQuery.isPlaceholderData;
  const dynastyId = displayedSelection?.selected.type === "dynasty"
    ? displayedSelection.selected.id
    : detail?.dynastyId;
  const accent = useLaneColorValue(dynastyId) ?? "var(--color-accent)";

  const capitalTenures = (detail?.capitalTenures ?? []).filter(
    (row) => row.capital?.label.trim() && row.tenure.label.trim(),
  );
  const relatedItems = detail?.related ?? [];
  const canOpenPersonOverview =
    displayedSelection?.selected.type === "person" &&
    displayedSelection.focusReignId != null &&
    (detail?.reignCount ?? 0) > 1;

  if (!selection.selected) return null;

  return (
    <aside
      className={styles.panel}
      aria-busy={detailQuery.isFetching}
      style={{ ["--detail-accent" as string]: accent }}
    >
      <div className={styles.header}>
        <div className={styles.titleBlock} inert={switchingDetail}>
          <span className={styles.accent} />
          {detailQuery.isLoading ? (
            <p className={styles.loading}>加载中…</p>
          ) : detailQuery.error ? (
            <p className={styles.error}>无法加载详情</p>
          ) : (
            <>
              <h2 className={styles.title}>
                {canOpenPersonOverview ? (
                  <button
                    type="button"
                    className={styles.titleLink}
                    title="查看人物全部在位信息"
                    onClick={() => {
                      if (selection.selected?.type !== "person") return;
                      selectionStore.navigateToDetail(
                        selection.selected,
                        undefined,
                        viewport.centerAbs,
                        { focusReignId: null },
                      );
                      selectionStore.syncToUrl(viewport.centerAbs);
                    }}
                  >
                    {detail?.title}
                  </button>
                ) : (
                  detail?.title
                )}
              </h2>
              {detail?.subtitle && (
                <p className={styles.subtitle}>{detail.subtitle}</p>
              )}
            </>
          )}
        </div>
        <div className={styles.headerActions}>
          {selection.detailHistory.length > 0 && (
            <button
              type="button"
              className={styles.back}
              aria-label="返回上一条详情"
              title="返回上一条详情"
              onClick={() => {
                const previousCenter = selectionStore.goBack(viewport.centerAbs);
                if (previousCenter !== null) {
                  viewportStore.jumpToAbs(previousCenter);
                }
              }}
            >
              <svg viewBox="0 0 20 20" aria-hidden="true">
                <path d="m12.5 4.5-5 5.5 5 5.5" />
              </svg>
            </button>
          )}
          <button
            type="button"
            className={styles.close}
            aria-label="关闭详情"
            onClick={() => selectionStore.clearSelection()}
          >
            ×
          </button>
        </div>
      </div>

      <div className={styles.body} inert={switchingDetail}>
        {detail?.facts && detail.facts.length > 0 && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>要点</h3>
            <div className={styles.facts}>
              {detail.facts.map((fact) => (
                <div
                  key={fact.label}
                  className={
                    fact.value.includes("\n")
                      ? `${styles.fact} ${styles.factMultiline}`
                      : fact.value.length > 36
                      ? `${styles.fact} ${styles.factBlock}`
                      : styles.fact
                  }
                >
                  <span className={styles.factLabel}>{fact.label}</span>
                  {fact.label === "在位" && fact.value.includes("\n") ? (
                    <span className={`${styles.factValue} ${styles.reignFactValue}`}>
                      {fact.value.split("\n").map((line, index) => {
                        const separator = line.lastIndexOf(" · ");
                        const range = separator >= 0 ? line.slice(0, separator) : line;
                        const duration = separator >= 0 ? line.slice(separator + 3) : "";
                        return (
                          <span className={styles.reignFactLine} key={`${line}:${index}`}>
                            <span>{range}</span>
                            <span className={styles.reignFactSeparator}>{duration ? "·" : ""}</span>
                            <span>{duration}</span>
                          </span>
                        );
                      })}
                    </span>
                  ) : (
                    <span className={styles.factValue}>{fact.value}</span>
                  )}
                </div>
              ))}
            </div>
          </section>
        )}

        {detail?.summary && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>概述</h3>
            <p className={styles.summary}>{detail.summary}</p>
          </section>
        )}

        {detail?.content && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>全文</h3>
            <p className={styles.poemText}>{detail.content}</p>
          </section>
        )}

        {capitalTenures.length > 0 && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>都城</h3>
            <div className={styles.capitalTenureList}>
              {capitalTenures.map((row) => (
                <div
                  key={`${row.tenure.ref.id}:${row.tenure.abs}:${row.capital?.ref.id ?? "solo"}`}
                  className={`${styles.capitalTenureRow} ${styles.capitalTenureRowSingle}`}
                >
                  {row.capital ? (
                    <CapitalCard
                      historicalName={row.capital.label}
                      modernName={row.capital.modernName}
                      subtitle={[row.tenure.label, row.tenure.duration, row.capital.subtitle].filter(Boolean).join(" · ")}
                      onClick={() => selectTenureRef(row.tenure, selection, viewport.centerAbs)}
                    />
                  ) : (
                    <button type="button" className={styles.capitalTenureCell} onClick={() => selectTenureRef(row.tenure, selection, viewport.centerAbs)}>
                      <span className={`${styles.capitalTenureLabel} ${styles.tenureLabel}`}>{row.tenure.label}</span>
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
                      item.group === "location_mapping" && item.modernName ? (
                        <CapitalCard
                          key={`${item.ref.type}:${item.ref.id}`}
                          historicalName={item.label}
                          modernName={item.modernName}
                          subtitle={item.subtitle ?? ""}
                          onClick={() => selectRelatedItem(item, selection, viewport.centerAbs)}
                        />
                      ) : (
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
                      )
                    ))}
                </div>
              </div>
            ))}
          </section>
        )}

        {detail?.links && detail.links.length > 0 && (
          <section className={styles.section}>
            <h3 className={styles.sectionTitle}>来源</h3>
            <div className={styles.links}>
              {detail.links.map((link) => (
                <a
                  key={link.url}
                  href={link.url}
                  className={styles.link}
                  target="_blank"
                  rel="noreferrer"
                  onClick={(event) => {
                    if (isNativeApp()) {
                      event.preventDefault();
                      void openExternalSource(link.url).catch(() => { /* The source can be opened again when a network is available. */ });
                    }
                  }}
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
