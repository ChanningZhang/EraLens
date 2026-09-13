import { useEffect, useRef, useState } from "react";
import { getRepository } from "@/data/repository";
import type { SearchHit } from "@eralens/shared";
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
  const [theme, setTheme] = useState<"light" | "dark">("light");

  useEffect(() => {
    document.documentElement.dataset.theme = theme;
  }, [theme]);

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
    const observer = new ResizeObserver((entries) => {
      const width = entries[0]?.contentRect.width ?? 1200;
      viewportStore.setWidthPx(width);
    });
    observer.observe(el);
    return () => observer.disconnect();
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
    <div className={styles.appShell}>
      <header className={styles.header}>
        <div className={styles.brand}>
          <h1 className={styles.brandTitle}>EraLens</h1>
          <p className={styles.brandSub}>历史时间轴</p>
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
        <div className={styles.headerActions}>
          <button
            type="button"
            className={styles.chipButton}
            onClick={() => viewportStore.zoomBy(1.25)}
          >
            放大
          </button>
          <button
            type="button"
            className={styles.chipButton}
            onClick={() => viewportStore.zoomBy(0.8)}
          >
            缩小
          </button>
          <button
            type="button"
            className={styles.iconButton}
            onClick={() => setTheme((t) => (t === "light" ? "dark" : "light"))}
          >
            {theme === "light" ? "深色" : "浅色"}
          </button>
        </div>
      </header>

      <div className={styles.body}>
        <div ref={stageRef} className={styles.stageWrap}>
          <TimelineStage />
        </div>
        {selection.detailOpen && (
          <>
            <ResizeHandle />
            <div
              className={styles.detailWrap}
              style={{ width: selection.detailWidth }}
            >
              <DetailPanel />
            </div>
          </>
        )}
      </div>

      <Ruler />
      <CursorGuide stageRef={stageRef} />
    </div>
  );
}
