import { useMemo, useRef } from "react";
import {
  buildLaneOrderIndex,
  capitalsActiveAtAbs,
  clusterFramesForLanes,
  collapseDynastyLaneGroups,
  collectLaneReigns,
  compareTimedOrder,
  formatYear,
  fromAbsMonth,
  fallbackLaneColorToken,
  resolveDynastyColorValue,
  TIMELINE_RAIL_CHIP_HEIGHT_PX,
  TIMELINE_RAIL_CHIP_TOP_PX,
  type Dynasty,
} from "@eralens/shared";
import { useDataBounds, useTimelineData } from "../hooks/useTimelineData";
import { useDynastyCapitals } from "../hooks/useDynastyCapitals";
import { useLaneColorCatalog } from "../hooks/useLaneColorCatalog";
import { useStageViewportHeight } from "../hooks/useStageViewportHeight";
import { useTimelineCatalog } from "../hooks/useTimelineCatalog";
import { useViewport } from "../hooks/useViewport";
import {
  eventLaneCount,
  eventRailHeight,
  layoutEvents,
} from "../model/eventLayout";
import { assignLanes } from "../model/laneLayout";
import { shouldShowEvent, shouldShowPersons } from "../model/lod";
import { centerGuideX, laneLabelAnchorAbs } from "../model/coordinates";
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
import { CapitalMapLayer } from "./CapitalMapLayer";
import { ChinaMapBackground } from "./ChinaMapBackground";
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
  const stageRef = useRef<HTMLDivElement>(null);
  const stageViewportHeight = useStageViewportHeight(stageRef);
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

  const boundsQuery = useDataBounds();
  const capitalsQuery = useDynastyCapitals(boundsQuery.data);
  const allCapitals = capitalsQuery.data;
  const timelineCatalog = useTimelineCatalog();

  // Stable, viewport-independent lane order from the full catalog. Sorting the
  // visible rows by this rank keeps a row in place even when the neighbour that
  // anchored its same-capital pull-up scrolls out of view (e.g. 北宋 stays under
  // 后周/五代 instead of dropping below 大理 once 五代 leaves the window).
  const laneOrderRank = useMemo(
    () =>
      buildLaneOrderIndex(
        timelineCatalog?.dynasties ?? [],
        timelineCatalog?.dynastyGroups ?? [],
        timelineCatalog?.dynastyLaneGroups ?? [],
        allCapitals ?? [],
      ),
    [timelineCatalog, allCapitals],
  );

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
    const ordered = [...collapsed].sort((a, b) => {
      const ra = laneOrderRank.get(a.id);
      const rb = laneOrderRank.get(b.id);
      if (ra != null && rb != null && ra !== rb) return ra - rb;
      if (ra != null && rb == null) return -1;
      if (ra == null && rb != null) return 1;
      return compareTimedOrder(a, b);
    });
    return assignLanes(ordered);
  }, [data, viewport.startAbs, viewport.endAbs, dynastiesById, laneOrderRank]);

  const laneColorMap = useLaneColorCatalog(allCapitals);
  const labelAnchorAbs = laneLabelAnchorAbs(viewport);
  const activeCapitals = useMemo(
    () => capitalsActiveAtAbs(capitalsQuery.data ?? [], labelAnchorAbs),
    [capitalsQuery.data, labelAnchorAbs],
  );
  const dynastyNamesById = useMemo(() => {
    const map = new Map<string, string>();
    for (const dynasty of timelineCatalog?.dynasties ?? []) {
      map.set(dynasty.id, dynasty.name);
    }
    return map;
  }, [timelineCatalog]);

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

  const personDisplay = useMemo(() => {
    const map = new Map<
      string,
      {
        ancestralXing?: string;
        clanShi?: string;
        posthumousNames?: string[];
        templeNames?: string[];
      }
    >();
    if (!data) return map;
    for (const person of data.persons) {
      if (
        person.ancestralXing ||
        person.clanShi ||
        person.posthumousNames.length ||
        person.templeNames.length
      ) {
        map.set(person.id, {
          ancestralXing: person.ancestralXing,
          clanShi: person.clanShi,
          posthumousNames: person.posthumousNames,
          templeNames: person.templeNames,
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
      const height = dynastyLaneHeight(rowHeights, reigns, laneGroups);
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
      ref={stageRef}
      className={styles.stage}
      data-timeline-pan
      data-timeline-stage
      style={{
        ["--center-guide-x" as string]: `${centerGuideX(viewport)}px`,
        ...(stageViewportHeight > 0
          ? { ["--stage-viewport-height" as string]: `${stageViewportHeight}px` }
          : {}),
      }}
    >
      <div className={styles.mapUnderlay} aria-hidden="true">
        <div className={styles.viewportPanel}>
          <ChinaMapBackground gutterPx={viewport.gutterPx} />
        </div>
      </div>
      <div className={styles.guideOverlay} aria-hidden="true">
        <div className={styles.viewportPanel} />
      </div>
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
                  personClans={personDisplay}
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
      <div className={styles.capitalOverlay} aria-hidden={activeCapitals.length === 0}>
        <div className={styles.viewportPanel}>
          <CapitalMapLayer
            capitals={activeCapitals}
            dynastiesById={dynastiesById}
            dynastyNamesById={dynastyNamesById}
            laneColorMap={laneColorMap}
            atAbs={labelAnchorAbs}
            gutterPx={viewport.gutterPx}
          />
        </div>
      </div>
    </div>
  );
}
