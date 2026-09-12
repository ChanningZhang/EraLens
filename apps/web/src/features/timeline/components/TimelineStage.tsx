import { useMemo } from "react";
import { LayoutGroup } from "framer-motion";
import { formatYear, fromAbsMonth } from "@eralens/shared";
import { useTimelineData } from "../hooks/useTimelineData";
import { useViewport } from "../hooks/useViewport";
import {
  eventLaneCount,
  eventRailHeight,
  layoutEvents,
} from "../model/eventLayout";
import { assignLanes, getLaneCount } from "../model/laneLayout";
import { shouldShowEvent } from "../model/lod";
import { expandWindow, filterVisibleDynasties } from "../model/visible";
import { DynastyLane } from "./DynastyLane";
import { EventLayer } from "./EventLayer";
import styles from "./TimelineStage.module.css";

const LANE_HEIGHT = 72;

export function TimelineStage() {
  const viewport = useViewport();
  const { data, isLoading } = useTimelineData();

  const placed = useMemo(() => {
    if (!data) return [];
    const buffered = expandWindow(viewport.startAbs, viewport.endAbs, 120);
    const visible = filterVisibleDynasties(
      data.dynasties,
      buffered.startAbs,
      buffered.endAbs,
    ).filter(
      (dynasty) =>
        dynasty.startAbs <= viewport.endAbs && dynasty.endAbs >= viewport.startAbs,
    );
    return assignLanes(visible);
  }, [data, viewport.startAbs, viewport.endAbs]);

  const eventPlaced = useMemo(() => {
    if (!data) return [];
    const visible = data.events.filter((event) => shouldShowEvent(event, viewport.lod));
    return layoutEvents(visible, viewport);
  }, [data, viewport]);

  const railHeight = eventRailHeight(eventLaneCount(eventPlaced));
  const laneCount = getLaneCount(placed);
  const contentHeight = Math.max(
    railHeight + laneCount * LANE_HEIGHT + 32,
    240,
  );
  const reignsByDynasty = useMemo(() => {
    const map = new Map<string, typeof data extends undefined ? never : NonNullable<typeof data>["reigns"]>();
    if (!data) return map;
    for (const reign of data.reigns) {
      const list = map.get(reign.dynastyId) ?? [];
      list.push(reign);
      map.set(reign.dynastyId, list);
    }
    return map;
  }, [data]);

  const emptyYearLabel = useMemo(() => {
    const { year } = fromAbsMonth(Math.round(viewport.centerAbs));
    return formatYear(year);
  }, [viewport.centerAbs]);

  return (
    <div className={styles.stage} data-timeline-pan>
      <div className={styles.content} style={{ minHeight: contentHeight }}>
        <div
          className={styles.lanes}
          style={{ height: contentHeight, position: "relative" }}
        >
          {isLoading && placed.length === 0 ? (
            <div className={styles.empty}>
              <p className={styles.emptyHint}>加载中…</p>
            </div>
          ) : placed.length === 0 ? (
            <div className={styles.empty}>
              <p className={styles.emptyTitle}>{emptyYearLabel} 前后暂无收录</p>
              <p className={styles.emptyHint}>拖动底部标尺浏览其他年代</p>
            </div>
          ) : (
            <LayoutGroup>
              {placed.map((dynasty) => (
                <DynastyLane
                  key={dynasty.id}
                  dynasty={dynasty}
                  reigns={reignsByDynasty.get(dynasty.id) ?? []}
                  laneHeight={LANE_HEIGHT}
                  topOffset={railHeight}
                />
              ))}
            </LayoutGroup>
          )}
          {data && placed.length > 0 && (
            <EventLayer placed={eventPlaced} height={railHeight} />
          )}
        </div>
      </div>
    </div>
  );
}
