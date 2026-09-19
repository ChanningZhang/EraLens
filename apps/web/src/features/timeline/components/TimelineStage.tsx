import { useMemo } from "react";
import {
  clusterFramesForLanes,
  collapseDynastyLaneGroups,
  collectLaneReigns,
  formatYear,
  fromAbsMonth,
  orderDynastiesForLanes,
  fallbackLaneColorToken,
  resolveDynastyColorValue,
  TIMELINE_RAIL_CHIP_HEIGHT_PX,
  TIMELINE_RAIL_CHIP_TOP_PX,
  type Dynasty,
} from "@eralens/shared";
import { useLaneColorCatalog } from "../hooks/useLaneColorCatalog";
import { useTimelineData } from "../hooks/useTimelineData";
import { useViewport } from "../hooks/useViewport";
import {
  eventLaneCount,
  eventRailHeight,
  layoutEvents,
} from "../model/eventLayout";
import { assignLanes } from "../model/laneLayout";
import { shouldShowEvent, shouldShowPersons } from "../model/lod";
import { centerGuideX } from "../model/coordinates";
import {
  layoutPersons,
  PERSON_LAYER_BOTTOM_PAD,
  PERSON_LAYER_GAP,
  personLayerHeight,
} from "../model/personLayout";
import {
  assignReignStacks,
  dynastyLaneHeight,
  partitionReignRecords,
} from "../model/reignClusters";
import { expandWindow, filterVisibleDynasties } from "../model/visible";
import { DynastyClusterFrame } from "./DynastyClusterFrame";
import { DynastyLane } from "./DynastyLane";
import { EventLayer } from "./EventLayer";
import { PersonLayer } from "./PersonLayer";
import { ReignFateLayer } from "./ReignFateLayer";
import styles from "./TimelineStage.module.css";
import { layoutReignFates } from "../model/reignFateLayout";

function laneColorTokenFor(
  map: ReadonlyMap<string, ReturnType<typeof fallbackLaneColorToken>>,
  dynastyId: string,
) {
  return map.get(dynastyId) ?? fallbackLaneColorToken(dynastyId);
}

export function TimelineStage() {
  const viewport = useViewport();
  const { data, isLoading, error } = useTimelineData();

  const dynastiesById = useMemo(() => {
    const map = new Map<string, Dynasty>();
    if (!data) return map;
    for (const dynasty of data.dynasties) {
      map.set(dynasty.id, dynasty);
    }
    return map;
  }, [data]);

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
    const collapsed = collapseDynastyLaneGroups(
      visible,
      dynastiesById,
      data?.dynastyLaneGroups ?? [],
    );
    return assignLanes(
      orderDynastiesForLanes(collapsed, data?.dynastyGroups ?? []),
    );
  }, [data, viewport.startAbs, viewport.endAbs, dynastiesById]);

  const laneColorMap = useLaneColorCatalog();

  const laneGroups = data?.dynastyLaneGroups ?? [];

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

  const personClans = useMemo(() => {
    const map = new Map<string, { ancestralXing?: string; clanShi?: string }>();
    if (!data) return map;
    for (const person of data.persons) {
      if (person.ancestralXing || person.clanShi) {
        map.set(person.id, {
          ancestralXing: person.ancestralXing,
          clanShi: person.clanShi,
        });
      }
    }
    return map;
  }, [data]);

  const lanes = useMemo(() => {
    let top = railHeight;
    return placed.map((dynasty) => {
      const records = collectLaneReigns(dynasty.id, reignsByDynasty, laneGroups);
      const { rulers: reigns, missing: missingReigns } = partitionReignRecords(records);
      const { rowCount, rowHeights } = assignReignStacks(reigns, laneGroups);
      const height = dynastyLaneHeight(rowHeights);
      const chipHeight = TIMELINE_RAIL_CHIP_HEIGHT_PX;
      const chipTop =
        rowCount > 1
          ? top + height / 2 - chipHeight / 2
          : top + TIMELINE_RAIL_CHIP_TOP_PX;
      const item = { dynasty, records, reigns, missingReigns, top, height, chipTop, chipHeight };
      top += height;
      return item;
    });
  }, [placed, railHeight, reignsByDynasty, laneGroups]);

  const clusterFrames = useMemo(
    () => clusterFramesForLanes(lanes, data?.dynastyGroups ?? []),
    [lanes, data?.dynastyGroups],
  );

  const fatePlaced = useMemo(() => {
    if (!data?.relations?.length) return [];
    return layoutReignFates(
      data.relations,
      data.reigns,
      lanes.map(({ dynasty, records, top }) => ({
        dynastyId: dynasty.id,
        top,
        records,
        color: resolveDynastyColorValue(
          dynasty,
          laneColorTokenFor(laneColorMap, dynasty.id),
        ),
      })),
      viewport,
      personNames,
    );
  }, [data, lanes, laneColorMap, viewport, personNames]);

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
    <div
      className={styles.stage}
      data-timeline-pan
      data-timeline-stage
      style={{
        ["--center-guide-x" as string]: `${Math.round(centerGuideX(viewport))}px`,
      }}
    >
      <div
        className={styles.content}
        style={{ minHeight: `max(100%, ${contentHeight}px)` }}
      >
        <div className={styles.rail} aria-hidden="true" />
        <div
          className={styles.lanes}
          style={{
            position: "relative",
            minHeight: contentHeight,
            height: "100%",
          }}
        >
          {!data && isLoading ? (
            <div className={styles.empty}>
              <p className={styles.emptyHint}>加载中…</p>
            </div>
          ) : error && !data ? (
            <div className={styles.empty}>
              <p className={styles.emptyTitle}>数据加载失败</p>
              <p className={styles.emptyHint}>
                请确认 API 服务已启动（pnpm --filter @eralens/api dev）
              </p>
            </div>
          ) : placed.length === 0 && eventPlaced.length === 0 ? (
            <div className={styles.empty}>
              <p className={styles.emptyTitle}>{emptyYearLabel} 前后暂无收录</p>
              <p className={styles.emptyHint}>拖动底部标尺浏览其他年代</p>
            </div>
          ) : (
            <>
              {clusterFrames.map(({ group, top, height, left, width }) => (
                <DynastyClusterFrame
                  key={group.id}
                  group={group}
                  top={top}
                  height={height}
                  left={left}
                  width={width}
                />
              ))}
              {lanes.map(({ dynasty, reigns, missingReigns, top }) => (
                <DynastyLane
                  key={dynasty.id}
                  dynasty={dynasty}
                  laneColorToken={laneColorTokenFor(laneColorMap, dynasty.id)}
                  reigns={reigns}
                  missingReigns={missingReigns}
                  dynastiesById={dynastiesById}
                  personNames={personNames}
                  personClans={personClans}
                  laneGroups={laneGroups}
                  top={top}
                />
              ))}
            </>
          )}
          {eventPlaced.length > 0 && (
            <EventLayer placed={eventPlaced} height={railHeight} />
          )}
          {data && placed.length > 0 && fatePlaced.length > 0 && (
            <ReignFateLayer placed={fatePlaced} height={contentHeight} />
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
