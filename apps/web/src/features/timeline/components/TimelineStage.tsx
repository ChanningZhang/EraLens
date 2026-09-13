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
import { assignLanes } from "../model/laneLayout";
import { shouldShowEvent, shouldShowPersons } from "../model/lod";
import {
  layoutPersons,
  PERSON_LAYER_BOTTOM_PAD,
  PERSON_LAYER_GAP,
  personLayerHeight,
} from "../model/personLayout";
import { assignReignStacks, dynastyLaneHeight } from "../model/reignClusters";
import { expandWindow, filterVisibleDynasties } from "../model/visible";
import { DynastyLane } from "./DynastyLane";
import { EventLayer } from "./EventLayer";
import { PersonLayer } from "./PersonLayer";
import styles from "./TimelineStage.module.css";

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

  const personNames = useMemo(() => {
    const map = new Map<string, string>();
    if (!data) return map;
    for (const person of data.persons) {
      map.set(person.id, person.name);
    }
    return map;
  }, [data]);

  const lanes = useMemo(() => {
    let top = railHeight;
    return placed.map((dynasty) => {
      const reigns = reignsByDynasty.get(dynasty.id) ?? [];
      const { rowCount } = assignReignStacks(reigns);
      const height = dynastyLaneHeight(rowCount);
      const item = { dynasty, reigns, top, height };
      top += height;
      return item;
    });
  }, [placed, railHeight, reignsByDynasty]);

  const dynastiesBottom = lanes.at(-1)
    ? lanes.at(-1)!.top + lanes.at(-1)!.height
    : railHeight;

  const visiblePersons = useMemo(() => {
    if (!data || !shouldShowPersons(viewport.lod)) return [];
    const reignPersonIds = new Set(data.reigns.map((reign) => reign.personId));
    return data.persons.filter((person) => !reignPersonIds.has(person.id));
  }, [data, viewport.lod]);

  const personPlaced = useMemo(() => {
    if (visiblePersons.length === 0) return [];
    return layoutPersons(visiblePersons, viewport);
  }, [visiblePersons, viewport]);

  const personAreaHeight = personLayerHeight(personPlaced);
  const personLayerTop = dynastiesBottom + (personAreaHeight > 0 ? PERSON_LAYER_GAP : 0);
  const contentHeight = Math.max(
    personLayerTop + personAreaHeight + PERSON_LAYER_BOTTOM_PAD,
    240,
  );
  const showPersonLayer =
    Boolean(data) && placed.length > 0 && visiblePersons.length > 0;

  const emptyYearLabel = useMemo(() => {
    const { year } = fromAbsMonth(Math.round(viewport.centerAbs));
    return formatYear(year);
  }, [viewport.centerAbs]);

  return (
    <div className={styles.stage} data-timeline-pan data-timeline-stage>
      <div
        className={styles.content}
        style={{ minHeight: `max(100%, ${contentHeight}px)` }}
      >
        <div
          className={styles.lanes}
          style={{
            position: "relative",
            minHeight: contentHeight,
            height: "100%",
          }}
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
              {lanes.map(({ dynasty, reigns, top }) => (
                <DynastyLane
                  key={dynasty.id}
                  dynasty={dynasty}
                  reigns={reigns}
                  personNames={personNames}
                  top={top}
                />
              ))}
            </LayoutGroup>
          )}
          {data && placed.length > 0 && (
            <EventLayer placed={eventPlaced} height={railHeight} />
          )}
          {showPersonLayer && (
            <PersonLayer
              placed={personPlaced}
              top={personLayerTop}
              height={personAreaHeight}
            />
          )}
        </div>
      </div>
    </div>
  );
}
