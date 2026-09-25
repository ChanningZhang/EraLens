import { useEffect, useRef, useState } from "react";
import { getRepository } from "@/data/repository";
import {
  DEFAULT_EVENT_DISPLAY_CONFIG,
  EventKindSchema,
  eventKindLabel,
  TIMELINE_GUTTER_PX,
  TIMELINE_RAIL_INSET_PX,
  TIMELINE_RAIL_LABEL_WIDTH_PX,
  type SearchHit,
} from "@eralens/shared";
import type { EventDisplayConfig } from "@eralens/shared";
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
  const [eventDisplay, setEventDisplay] = useState<EventDisplayConfig>(DEFAULT_EVENT_DISPLAY_CONFIG);
  const eventKinds = EventKindSchema.options;

  useEffect(() => {
    let active = true;
    const source = import.meta.env.VITE_DATA_SOURCE ?? "http";
    const load = async () => {
      try {
        if (source === "http") {
          const response = await fetch(`${import.meta.env.VITE_API_BASE ?? "/api"}/settings/events`);
          if (response.ok && active) setEventDisplay(await response.json());
        } else {
          const stored = localStorage.getItem("eralens-event-display");
          if (stored && active) setEventDisplay(JSON.parse(stored));
        }
      } catch { /* Keep defaults available while settings are unreachable. */ }
    };
    void load();
    return () => { active = false; };
  }, []);

  const updateEventKind = async (kind: (typeof eventKinds)[number], enabled: boolean) => {
    const next = { kinds: { ...eventDisplay.kinds, [kind]: enabled } };
    setEventDisplay(next);
    const source = import.meta.env.VITE_DATA_SOURCE ?? "http";
    try {
      if (source === "http") {
        await fetch(`${import.meta.env.VITE_API_BASE ?? "/api"}/settings/events`, {
          method: "PUT", headers: { "content-type": "application/json" }, body: JSON.stringify(next),
        });
      } else localStorage.setItem("eralens-event-display", JSON.stringify(next));
    } catch { /* The current session still uses the selected values. */ }
  };

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
      style={{
        ["--timeline-gutter" as string]: `${TIMELINE_GUTTER_PX}px`,
        ["--timeline-rail-inset" as string]: `${TIMELINE_RAIL_INSET_PX}px`,
        ["--timeline-rail-label-width" as string]: `${TIMELINE_RAIL_LABEL_WIDTH_PX}px`,
      }}
    >
      <header className={styles.header} aria-label="EraLens 导航与图例">
        <div className={styles.brand}>
          <h1 className={styles.brandTitle}>EraLens</h1>
          <p className={styles.brandSub}>历史透镜</p>
        </div>
        <div className={styles.searchWrap}>
          <input
            className={styles.searchInput}
            placeholder="搜索人物、王朝、年号、都城、事件…"
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
        <div className={styles.legend} aria-label="图例">
          <div className={styles.legendItems}>
            <span className={styles.legendItem}>
              <span className={`${styles.legendSwatch} ${styles.legendStripes}`} aria-hidden="true" />
              非正式君主
            </span>
            <span className={styles.legendItem}>
              <svg className={`${styles.legendSwatch} ${styles.legendWave}`} viewBox="0 0 24 12" aria-hidden="true">
                <path d="M3 0 C1 1 5 2 3 3 C1 4 5 5 3 6 C1 7 5 8 3 9 C1 10 5 11 3 12" />
                <path d="M21 0 C19 1 23 2 21 3 C19 4 23 5 21 6 C19 7 23 8 21 9 C19 10 23 11 21 12" />
              </svg>
              年代失考
            </span>
          </div>
        </div>
        <div className={styles.settingsWrap}>
          <button type="button" className={styles.settingsButton} aria-label="事件显示设置" title="事件显示设置" aria-expanded={eventSettingsOpen} onClick={() => setEventSettingsOpen((open) => !open)}>
            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 8.5a3.5 3.5 0 1 0 0 7 3.5 3.5 0 0 0 0-7Zm8 4.7v-2.4l-2-.7a6.2 6.2 0 0 0-.6-1.4l.9-1.9-1.7-1.7-1.9.9a6.2 6.2 0 0 0-1.4-.6l-.7-2h-2.4l-.7 2a6.2 6.2 0 0 0-1.4.6l-1.9-.9-1.7 1.7.9 1.9a6.2 6.2 0 0 0-.6 1.4l-2 .7v2.4l2 .7c.1.5.3 1 .6 1.4l-.9 1.9 1.7 1.7 1.9-.9c.4.3.9.5 1.4.6l.7 2h2.4l.7-2c.5-.1 1-.3 1.4-.6l1.9.9 1.7-1.7-.9-1.9c.3-.4.5-.9.6-1.4l2-.7Z"/></svg>
          </button>
          {eventSettingsOpen && <section className={styles.settingsPanel} aria-label="事件展示设置">
            <h2>事件展示</h2>
            {eventKinds.map((kind) => <label key={kind} className={styles.settingsOption}>
              <input type="checkbox" aria-label={`显示${eventKindLabel(kind)}事件`} checked={eventDisplay.kinds[kind] ?? true} onChange={(event) => void updateEventKind(kind, event.target.checked)} />
              <EventKindPreview kind={kind} label={eventKindLabel(kind)} />
            </label>)}
          </section>}
        </div>
      </header>

      <div className={styles.body}>
        <div ref={stageRef} className={styles.stageWrap}>
          <TimelineStage eventDisplay={eventDisplay} />
        </div>
      </div>

      <Ruler />
      <CursorGuide stageRef={stageRef} />
      {selection.detailOpen && (
        <div
          className={styles.detailDrawer}
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
