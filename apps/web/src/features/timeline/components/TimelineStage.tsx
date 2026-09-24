import { useMemo, useRef, useState } from "react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import {
  buildLaneOrderIndex,
  capitalsActiveAtAbs,
  clusterFramesForLanes,
  collapseDynastyLaneGroups,
  collectLaneReigns,
  compareTimedOrder,
  eventSpanAbs,
  formatYear,
  fromAbsMonth,
  fallbackLaneColorToken,
  getDynastyLaneGroup,
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
import { useSelection } from "../hooks/useSelection";
import {
  eventLaneCount,
  eventTargetReign,
  EVENT_BADGE_HALF_HEIGHT,
  eventRailHeight,
  filterViewportEvents,
  layoutEvents,
  layoutPlacedEventBadges,
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
  dynastyBarHeightForReigns,
  dynastyLaneHeightForViewport,
  LANE_PADDING_TOP,
  partitionReignRecords,
  resolveStackedCardUnit,
} from "../model/reignClusters";
import { expandWindow, filterVisibleDynasties } from "../model/visible";
import { CapitalMapLayer } from "./CapitalMapLayer";
import { WarEventMapLayer } from "./WarEventMapLayer";
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
  const mapDragRef = useRef<{ pointerId: number; x: number; y: number } | null>(null);
  const [mapView, setMapView] = useState({ scale: 1, x: 0, y: 0 });
  const stageViewportHeight = useStageViewportHeight(stageRef);
  const reduceMotion = useReducedMotion();
  const viewport = useViewport();
  const selection = useSelection();
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
  const nearbyWarEvents = useMemo(() => {
    if (!data) return [];
    const windowStart = viewport.centerAbs - 60;
    const windowEnd = viewport.centerAbs + 60;
    return data.events.filter((event) => {
      if (event.kind !== "battle" || !event.location) return false;
      const isSelected = selection.selected?.type === "event" && selection.selected.id === event.id;
      if (isSelected) return true;
      const span = eventSpanAbs(event);
      return span.startAbs <= windowEnd && span.endAbs >= windowStart;
    });
  }, [data, viewport.centerAbs, selection.selected]);
  const dynastyNamesById = useMemo(() => {
    const map = new Map<string, string>();
    for (const dynasty of timelineCatalog?.dynasties ?? []) {
      map.set(dynasty.id, dynasty.name);
    }
    return map;
  }, [timelineCatalog]);

  const laneGroups = data?.dynastyLaneGroups ?? [];

  const { railEvents, badgeEvents, badgePositions } = useMemo(() => {
    if (!data) return { railEvents: [], badgeEvents: [], badgePositions: new Map() };
    const visible = filterViewportEvents(
      data.events.filter((event) => shouldShowEvent(event, viewport.lod)),
      viewport,
    );
    const laneIdByDynastyId = new Map<string, string>();
    for (const dynasty of placed) {
      laneIdByDynastyId.set(dynasty.id, dynasty.id);
      const group = getDynastyLaneGroup(dynasty.id, laneGroups);
      for (const phaseId of group?.phaseDynastyIds ?? []) {
        laneIdByDynastyId.set(phaseId, dynasty.id);
      }
    }
    const projected = layoutEvents(visible, viewport);
    const badgePositions = layoutPlacedEventBadges(projected, laneIdByDynastyId, viewport.widthPx);
    return {
      railEvents: visible.filter((event) => !badgePositions.has(event.id)),
      badgeEvents: projected.filter((item) => badgePositions.has(item.event.id)),
      badgePositions,
    };
  }, [data, viewport, placed, laneGroups]);

  const eventPlaced = useMemo(() => layoutEvents(railEvents, viewport), [railEvents, viewport]);

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
        title?: string;
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
        person.title ||
        person.posthumousNames.length ||
        person.templeNames.length
      ) {
        map.set(person.id, {
          title: person.title,
          ancestralXing: person.ancestralXing,
          clanShi: person.clanShi,
          posthumousNames: person.posthumousNames,
          templeNames: person.templeNames,
        });
      }
    }
    return map;
  }, [data]);

  // Card height depends on zoom and records, not the horizontal pan position.
  const laneHeightCache = useMemo(
    () => new Map<string, number>(),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [reignsByDynasty, laneGroups, viewport.pxPerMonth, personNames, personDisplay],
  );

  const lanes = useMemo(() => {
    let top = railHeight;
    return placed.map((dynasty) => {
      const records = collectLaneReigns(dynasty.id, reignsByDynasty, laneGroups);
      const { rulers: reigns, missing: missingReigns } = partitionReignRecords(records);
      const { rowCount } = assignReignStacks(reigns, laneGroups);
      let height = laneHeightCache.get(dynasty.id);
      if (height == null) {
        height = dynastyLaneHeightForViewport(
          reigns,
          laneGroups,
          viewport,
          personNames,
          personDisplay,
        );
        laneHeightCache.set(dynasty.id, height);
      }
      const chipHeight = TIMELINE_RAIL_CHIP_HEIGHT_PX;
      const chipTop =
        rowCount > 1
          ? top + height / 2 - chipHeight / 2
          : top + TIMELINE_RAIL_CHIP_TOP_PX;
      const badgeTop = top + LANE_PADDING_TOP - EVENT_BADGE_HALF_HEIGHT;
      const item = { dynasty, records, reigns, missingReigns, top, height, badgeTop, chipTop, chipHeight };
      top += height;
      return item;
    });
  }, [placed, railHeight, reignsByDynasty, laneGroups, viewport, personNames, personDisplay, laneHeightCache]);

  const badgePlaced = useMemo(() => {
    const laneById = new Map(lanes.map((lane) => [lane.dynasty.id, lane]));
    return badgeEvents.map((item) => {
      const position = badgePositions.get(item.event.id);
      const lane = laneById.get(position?.laneId ?? "");
      const reign = lane && eventTargetReign(item.event, lane.reigns);
      const unit = reign && lane && resolveStackedCardUnit(reign, lane.reigns, laneGroups);
      return {
        ...item,
        badgeOriginX: item.anchorX,
        anchorX: position?.anchorX ?? item.anchorX,
        top: position?.edge === "bottom"
          ? lane
            ? LANE_PADDING_TOP + (unit
              ? unit.unitTop + unit.unitHeight
              : dynastyBarHeightForReigns(lane.reigns, laneGroups)) - EVENT_BADGE_HALF_HEIGHT
            : item.top
          : unit
            ? LANE_PADDING_TOP + unit.unitTop - EVENT_BADGE_HALF_HEIGHT
            : lane ? lane.badgeTop - lane.top : item.top,
      };
    });
  }, [badgeEvents, badgePositions, lanes, laneGroups]);

  const badgesByLane = useMemo(() => {
    const map = new Map<string, typeof badgePlaced>();
    for (const badge of badgePlaced) {
      const laneId = badgePositions.get(badge.event.id)?.laneId;
      if (!laneId) continue;
      const items = map.get(laneId) ?? [];
      items.push(badge);
      map.set(laneId, items);
    }
    return map;
  }, [badgePlaced, badgePositions]);

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
      personDisplay,
    );
  }, [data, lanes, laneColorMap, viewport, personNames, personDisplay]);

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
      onPointerDown={(event) => {
        if (event.button !== 0 || !(event.target instanceof Element)) return;
        if (event.target.closest("button, a, input, textarea, select, [role='button']")) return;
        const mapBox = event.currentTarget.querySelector("[data-china-map-box]");
        const rect = mapBox?.getBoundingClientRect();
        if (!rect || event.clientX < rect.left || event.clientX > rect.right || event.clientY < rect.top || event.clientY > rect.bottom) return;
        mapDragRef.current = { pointerId: event.pointerId, x: event.clientX, y: event.clientY };
        event.currentTarget.setPointerCapture(event.pointerId);
        event.preventDefault();
      }}
      onPointerMove={(event) => {
        const drag = mapDragRef.current;
        if (!drag || drag.pointerId !== event.pointerId) return;
        setMapView((view) => ({ ...view, x: view.x + event.clientX - drag.x, y: view.y + event.clientY - drag.y }));
        mapDragRef.current = { ...drag, x: event.clientX, y: event.clientY };
      }}
      onPointerUp={(event) => {
        if (mapDragRef.current?.pointerId !== event.pointerId) return;
        mapDragRef.current = null;
        if (event.currentTarget.hasPointerCapture(event.pointerId)) event.currentTarget.releasePointerCapture(event.pointerId);
      }}
      onPointerCancel={() => { mapDragRef.current = null; }}
      style={{
        ["--center-guide-x" as string]: `${centerGuideX(viewport)}px`,
        ...(stageViewportHeight > 0
          ? { ["--stage-viewport-height" as string]: `${stageViewportHeight}px` }
          : {}),
      }}
    >
      <div className={styles.mapUnderlay} aria-hidden="true">
        <div className={styles.viewportPanel}>
          <ChinaMapBackground
            gutterPx={viewport.gutterPx}
            scale={mapView.scale}
            offset={{ x: mapView.x, y: mapView.y }}
          />
        </div>
      </div>
      <div className={styles.guideOverlay} aria-hidden="true">
        <div className={styles.viewportPanel} />
      </div>
      <motion.div
        className={styles.content}
        animate={{ minHeight: Math.max(stageViewportHeight, contentHeight) }}
        transition={{ duration: reduceMotion ? 0 : 0.24, ease: [0.2, 0.8, 0.2, 1] }}
      >
        <div className={styles.rail} aria-hidden="true" />
        <motion.div
          className={styles.lanes}
          animate={{ minHeight: contentHeight }}
          transition={{ duration: reduceMotion ? 0 : 0.24, ease: [0.2, 0.8, 0.2, 1] }}
          style={{
            position: "relative",
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
          ) : (
            <>
              {placed.length === 0 && eventPlaced.length === 0 && (
                <div className={styles.empty}>
                  <p className={styles.emptyTitle}>{emptyYearLabel} 前后暂无收录</p>
                  <p className={styles.emptyHint}>拖动底部标尺浏览其他年代</p>
                </div>
              )}
              <AnimatePresence initial={false}>
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
              </AnimatePresence>
              <AnimatePresence initial={false}>
                {lanes.map(({ dynasty, reigns, missingReigns, top, height }) => (
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
                    height={height}
                    badges={badgesByLane.get(dynasty.id) ?? []}
                  />
                ))}
              </AnimatePresence>
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
        </motion.div>
      </motion.div>
      <div className={styles.capitalOverlay} aria-hidden={activeCapitals.length === 0}>
        <div className={styles.viewportPanel}>
          <CapitalMapLayer
            capitals={activeCapitals}
            dynastiesById={dynastiesById}
            dynastyNamesById={dynastyNamesById}
            laneColorMap={laneColorMap}
            atAbs={labelAnchorAbs}
            gutterPx={viewport.gutterPx}
            scale={mapView.scale}
            offset={{ x: mapView.x, y: mapView.y }}
          />
        </div>
      </div>
      <div className={styles.warOverlay} aria-hidden={nearbyWarEvents.length === 0}>
        <div className={styles.viewportPanel}>
          <WarEventMapLayer
            events={nearbyWarEvents}
            atAbs={viewport.centerAbs}
            gutterPx={viewport.gutterPx}
            scale={mapView.scale}
            offset={{ x: mapView.x, y: mapView.y }}
          />
        </div>
      </div>
      <div className={styles.mapControlsOverlay}>
        <div className={styles.viewportPanel}>
          <div className={styles.mapControls} role="group" aria-label="地图缩放">
            <button type="button" onClick={() => setMapView((view) => ({ ...view, scale: Math.min(2.8, view.scale + 0.2) }))} aria-label="放大地图" title="放大">+</button>
            <span aria-hidden="true" />
            <button type="button" onClick={() => setMapView((view) => ({ ...view, scale: Math.max(0.7, view.scale - 0.2) }))} aria-label="缩小地图" title="缩小">−</button>
          </div>
        </div>
      </div>
    </div>
  );
}
