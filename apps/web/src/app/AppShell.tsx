import { useEffect, useRef, useState } from "react";
import { getRepository } from "@/data/repository";
import {
  TIMELINE_GUTTER_PX,
  TIMELINE_RAIL_INSET_PX,
  TIMELINE_RAIL_LABEL_WIDTH_PX,
  type SearchHit,
} from "@eralens/shared";
import { DetailPanel } from "@/features/detail/components/DetailPanel";
import { ResizeHandle } from "@/features/detail/components/ResizeHandle";
import { CursorGuide } from "@/features/timeline/components/CursorGuide";
import { Ruler } from "@/features/timeline/components/Ruler";
import { TimelineStage } from "@/features/timeline/components/TimelineStage";
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
      <header className={styles.header}>
        <div className={styles.brand}>
          <h1 className={styles.brandTitle}>EraLens</h1>
          <p className={styles.brandSub}>历史透镜</p>
        </div>
        <div className={styles.searchWrap}>
          <input
            className={styles.searchInput}
            placeholder="搜索人物、王朝、事件…"
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
          <TimelineStage />
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
