import { useEffect, useRef, useState } from "react";
import { getRepository } from "@/data/repository";
import { ExpandToggle } from "@/components/ExpandToggle";
import {
  EventKindSchema,
  eventKindLabel,
  type SearchHit,
} from "@eralens/shared";
import { DetailPanel } from "@/features/detail/components/DetailPanel";
import { ResizeHandle } from "@/features/detail/components/ResizeHandle";
import { CursorGuide } from "@/features/timeline/components/CursorGuide";
import { Ruler } from "@/features/timeline/components/Ruler";
import { TimelineStage } from "@/features/timeline/components/TimelineStage";
import { EventKindPreview } from "@/features/timeline/components/EventLayer";
import { useSelection } from "@/features/timeline/hooks/useSelection";
import { useTimelineWheel } from "@/features/timeline/hooks/useTimelineWheel";
import { useViewport } from "@/features/timeline/hooks/useViewport";
import { useDataBounds } from "@/features/timeline/hooks/useTimelineData";
import { useEventDisplaySettings } from "./useEventDisplaySettings";
import { useTimelineLayoutSettings } from "./useTimelineLayoutSettings";
import { selectionStore } from "@/features/timeline/state/selectionStore";
import { viewportStore } from "@/features/timeline/state/viewportStore";
import styles from "./AppShell.module.css";

export function AppShell() {
  const viewport = useViewport();
  const selection = useSelection();
  const boundsQuery = useDataBounds();
  const stageRef = useRef<HTMLDivElement>(null);
  useTimelineWheel();
  const [search, setSearch] = useState("");
  const [searchHits, setSearchHits] = useState<SearchHit[]>([]);
  const [eventSettingsOpen, setEventSettingsOpen] = useState(false);
  const { eventDisplay, updateEventKind } = useEventDisplaySettings();
  const { preferences, updateLayout } = useTimelineLayoutSettings();
  const presentation = viewport.presentation;
  const eventKinds = EventKindSchema.options;

  useEffect(() => {
    if (boundsQuery.data) {
      viewportStore.setBounds(boundsQuery.data.minAbs, boundsQuery.data.maxAbs);
      return;
    }
    if (boundsQuery.isError) {
      // Keep BCE panning usable when /bounds is temporarily unavailable.
      viewportStore.setBounds(-30_000, 25_000);
    }
  }, [boundsQuery.data, boundsQuery.isError]);

  useEffect(() => {
    if (selection.highlightAbs !== null) {
      viewportStore.jumpToAbs(selection.highlightAbs);
    }
  }, []);

  useEffect(() => {
    const el = stageRef.current;
    if (!el) return;
    const applyWidth = (width: number) => {
      if (width < 320) return;
      viewportStore.setWidthPx(width);
    };
    const observer = new ResizeObserver((entries) => {
      if (document.hidden) return;
      applyWidth(entries[0]?.contentRect.width ?? 0);
    });
    observer.observe(el);
    const onVisible = () => {
      if (document.hidden) return;
      applyWidth(el.getBoundingClientRect().width);
    };
    document.addEventListener("visibilitychange", onVisible);
    return () => {
      observer.disconnect();
      document.removeEventListener("visibilitychange", onVisible);
    };
  }, []);

  useEffect(() => {
    // URL persistence must not run on every animation frame while panning.
    const timer = window.setTimeout(() => {
      selectionStore.syncToUrl(viewport.centerAbs);
    }, 180);
    return () => window.clearTimeout(timer);
  }, [viewport.centerAbs, selection.selected, selection.detailOpen, selection.detailWidth]);

  useEffect(() => {
    const onKey = (event: KeyboardEvent) => {
      if (event.target instanceof HTMLInputElement || event.target instanceof HTMLTextAreaElement) {
        return;
      }
      const step = event.shiftKey ? 120 : 12;
      if (event.key === "ArrowLeft") {
        event.preventDefault();
        viewportStore.panByMonths(-step);
      }
      if (event.key === "ArrowRight") {
        event.preventDefault();
        viewportStore.panByMonths(step);
      }
      if (event.key === "Home" && boundsQuery.data) {
        viewportStore.jumpToAbs(boundsQuery.data.minAbs);
      }
      if (event.key === "End" && boundsQuery.data) {
        viewportStore.jumpToAbs(boundsQuery.data.maxAbs);
      }
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [boundsQuery.data]);

  return (
    <div
      className={styles.appShell}
      onClick={(event) => {
        if (!selection.detailOpen) return;
        const target = event.target;
        if (
          target instanceof Element &&
          target.closest("button, a, input, textarea, select, [role='button'], [role='dialog'], [aria-modal='true'], [data-detail-drawer]")
        ) {
          return;
        }
        selectionStore.clearSelection();
      }}
      data-narrow={presentation.narrow}
      data-compact={presentation.compact}
      data-rail-collapsed={presentation.railCollapsed}
      style={{
        ["--timeline-gutter" as string]: `${presentation.gutterPx}px`,
        ["--timeline-rail-inset" as string]: `${presentation.railInsetPx}px`,
        ["--timeline-rail-label-width" as string]: `${presentation.railLabelWidthPx}px`,
        ["--timeline-rail-chip-top" as string]: `${presentation.railChipTopPx}px`,
        ["--timeline-rail-chip-height" as string]: `${presentation.railChipHeightPx}px`,
        ["--stack-row-height" as string]: `${presentation.rowHeightPx}px`,
        ["--lane-padding" as string]: `${presentation.lanePaddingPx}px`,
      }}
    >
      <header className={styles.header} aria-label="EraLens 导航">
        {presentation.narrow && <ExpandToggle
          className={styles.railToggle}
          axis="horizontal"
          expanded={!presentation.railCollapsed}
          expandLabel="展开王朝栏"
          collapseLabel="折叠王朝栏"
          onClick={() => {
            const nextCollapsed = !preferences.railCollapsed;
            updateLayout({ railCollapsed: nextCollapsed });
            if (nextCollapsed) setEventSettingsOpen(false);
          }}
        />}
        <div className={styles.brand}>
          {!presentation.railCollapsed && <>
            <h1 className={styles.brandTitle}>EraLens</h1>
            <p className={styles.brandSub}>历史透镜</p>
          </>}
        </div>
        <div className={styles.searchWrap}>
          <input
            className={styles.searchInput}
            placeholder="搜索人物、王朝、年号、都城、事件…"
            aria-label="搜索人物、王朝、年号、都城、事件"
            value={search}
            onChange={async (e) => {
              const value = e.target.value;
              setSearch(value);
              if (value.trim().length < 1) {
                setSearchHits([]);
                return;
              }
              const repo = await getRepository();
              setSearchHits(await repo.search(value));
            }}
            onKeyDown={(e) => {
              if (e.key === "Enter" && searchHits[0]) {
                const hit = searchHits[0];
                selectionStore.select(hit.ref, hit.abs);
                if (hit.abs !== undefined) viewportStore.jumpToAbs(hit.abs);
                setSearchHits([]);
              }
            }}
          />
          {searchHits.length > 0 && (
            <div className={styles.searchResults}>
              {searchHits.map((hit) => (
                <button
                  key={`${hit.ref.type}:${hit.ref.id}`}
                  type="button"
                  className={styles.searchResult}
                  onClick={() => {
                    selectionStore.select(hit.ref, hit.abs);
                    if (hit.abs !== undefined) viewportStore.jumpToAbs(hit.abs);
                    setSearch("");
                    setSearchHits([]);
                  }}
                >
                  <span>{hit.label}</span>
                  {hit.subtitle && <span className={styles.searchSub}>{hit.subtitle}</span>}
                </button>
              ))}
            </div>
          )}
        </div>
      </header>

      <div className={styles.body}>
        <div ref={stageRef} className={styles.stageWrap}>
          <TimelineStage eventDisplay={eventDisplay} />
        </div>
      </div>

      <Ruler />
      {!presentation.railCollapsed && <div className={styles.settingsWrap}>
        <button type="button" className={styles.settingsButton} aria-label="显示设置" title="显示设置" aria-expanded={eventSettingsOpen} onClick={() => setEventSettingsOpen((open) => !open)}>
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="m9.9 2.5 4.2 0 .6 2.1c.7.2 1.3.5 1.9.9l2-.7 2.1 3.6-1.5 1.5a7 7 0 0 1 0 2.2l1.5 1.5-2.1 3.6-2-.7c-.6.4-1.2.7-1.9.9l-.6 2.1H9.9l-.6-2.1c-.7-.2-1.3-.5-1.9-.9l-2 .7-2.1-3.6 1.5-1.5a7 7 0 0 1 0-2.2L3.3 8.4l2.1-3.6 2 .7c.6-.4 1.2-.7 1.9-.9Z" />
            <circle cx="12" cy="11" r="3.2" />
          </svg>
        </button>
        {eventSettingsOpen && <section className={styles.settingsPanel} aria-label="显示设置">
          <h2>时间轴布局</h2>
          <label className={styles.settingsOption}>
            <input type="checkbox" checked={presentation.compact} onChange={(event) => updateLayout({ density: event.target.checked ? "compact" : "comfortable" })} />
            紧凑泳道
          </label>
          <button className={styles.autoLayoutButton} type="button" onClick={() => updateLayout({ density: "auto" })} disabled={preferences.density === "auto"}>按屏幕自动调整</button>
          <h2>事件展示</h2>
          <div className={styles.eventSettingsGrid}>
            {eventKinds.map((kind) => <label key={kind} className={styles.settingsOption}>
              <input type="checkbox" aria-label={`显示${eventKindLabel(kind)}事件`} checked={eventDisplay.kinds[kind] ?? true} onChange={(event) => void updateEventKind(kind, event.target.checked)} />
              <EventKindPreview kind={kind} label={eventKindLabel(kind)} />
            </label>)}
          </div>
        </section>}
      </div>}
      <CursorGuide stageRef={stageRef} />
      {selection.detailOpen && (
        <div
          className={styles.detailDrawer}
          data-detail-drawer
          style={{ ["--detail-width" as string]: `${selection.detailWidth}px` }}
        >
          <ResizeHandle />
          <div className={styles.detailWrap}>
            <DetailPanel />
          </div>
        </div>
      )}
    </div>
  );
}
