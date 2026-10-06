import { memo, useEffect, useMemo, useRef, useState } from "react";
import { ExpandToggle } from "@/components/ExpandToggle";
import {
  buildLaneOrderIndex,
  capitalsActiveAtAbs,
  capitalsForReigns,
  clusterLaneGapForPresentation,
  clusterFramesForLanes,
  collectLaneReigns,
  compareTimedOrder,
  eventSpanAbs,
  formatYear,
  fromAbsMonth,
  rangesIntersect,
  fallbackLaneColorToken,
  resolveDynastyColorValue,
  resolveFateRelations,
  type Dynasty,
  type EventDisplayConfig,
  type Reign,
} from "@eralens/shared";
import { useDataBounds, useTimelineData } from "../hooks/useTimelineData";
import { useCapitalLocations } from "../hooks/useDynastyCapitals";
import { useLaneColorCatalog } from "../hooks/useLaneColorCatalog";
import { useStageViewportSize } from "../hooks/useStageViewportHeight";
import { resolveChinaMapInsets, resolveChinaMapLayout } from "../model/chinaMapProjection";
import { useTimelineCatalog } from "../hooks/useTimelineCatalog";
import { createFramePanAccumulator, createFrameZoomAccumulator } from "../hooks/useTimelineWheel";
import { createTimelinePointerController } from "../hooks/timelinePointerController";
import { useViewport } from "../hooks/useViewport";
import { useSelection } from "../hooks/useSelection";
import { viewportStore } from "../state/viewportStore";
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
import { absFromStageX, centerGuideX, laneLabelAnchorAbs } from "../model/coordinates";
import {
  layoutPersons,
  PERSON_LAYER_BOTTOM_PAD,
  PERSON_LAYER_GAP,
  personLayerHeight,
} from "../model/personLayout";
import {
  dynastyBarHeightForReigns,
  dynastyLaneHeightForViewport,
  partitionReignRecords,
  prepareLaneReignGeometry,
} from "../model/reignClusters";
import { expandWindow, filterVisibleCardReigns, filterVisibleDynasties, filterVisibleGapReigns, filterVisiblePlacedPersons } from "../model/visible";
import { CapitalMapLayer } from "./CapitalMapLayer";
import { EventMapLayer } from "./EventMapLayer";
import { ChinaMapBackground } from "./ChinaMapBackground";
import { DynastyClusterFrame } from "./DynastyClusterFrame";
import { DynastyLane } from "./DynastyLane";
import { EventLayer } from "./EventLayer";
import { PersonLayer } from "./PersonLayer";
import { ReignFateLayer } from "./ReignFateLayer";
import styles from "./TimelineStage.module.css";
import { layoutReignFates } from "../model/reignFateLayout";

const StableChinaMapBackground = memo(ChinaMapBackground);
const EVENT_CONTROL_LANE_CLEARANCE = 10;
const DEFAULT_VISIBLE_EVENT_LANES = 2;

function laneColorTokenFor(
  map: ReadonlyMap<string, ReturnType<typeof fallbackLaneColorToken>>,
  dynastyId: string,
) {
  return map.get(dynastyId) ?? fallbackLaneColorToken(dynastyId);
}

function sameReignIds(a: readonly Reign[] | undefined, b: readonly Reign[]): boolean {
  return a !== undefined && a.length === b.length && a.every((reign, index) => reign.id === b[index]?.id);
}

export function TimelineStage({ eventDisplay }: { eventDisplay: EventDisplayConfig }) {
  const stageRef = useRef<HTMLDivElement>(null);
  const timelineInertiaRef = useRef<number | null>(null);
  const timelinePanRef = useRef<ReturnType<typeof createFramePanAccumulator> | null>(null);
  const timelineZoomRef = useRef<ReturnType<typeof createFrameZoomAccumulator> | null>(null);
  const pointerControllerRef = useRef<ReturnType<typeof createTimelinePointerController> | null>(null);
  const [eventsExpanded, setEventsExpanded] = useState(false);
  const [mapScale, setMapScale] = useState(1);
  const [mapOffset, setMapOffset] = useState({ x: 0, y: 0 });
  const stageViewportSize = useStageViewportSize(stageRef);
  const stageViewportHeight = stageViewportSize.height;
  const viewport = useViewport();
  const mapVerticalAlignment = "bottom";
  const mapLayout = useMemo(() => {
    if (stageViewportSize.width < 1 || stageViewportSize.height < 1) return null;
    return resolveChinaMapLayout(
      stageViewportSize.width,
      stageViewportSize.height,
      resolveChinaMapInsets(viewport.gutterPx),
      mapVerticalAlignment,
    );
  }, [mapVerticalAlignment, stageViewportSize.height, stageViewportSize.width, viewport.gutterPx]);
  const selection = useSelection();
  const { data, context, isLoading, error } = useTimelineData();
  const fateReigns = useMemo(() => [...new Map([...(data?.reigns ?? []),...(context?.reigns ?? [])].map(r => [r.id,r])).values()], [data?.reigns,context?.reigns]);

  const stopTimelineInertia = () => {
    if (timelineInertiaRef.current !== null) {
      cancelAnimationFrame(timelineInertiaRef.current);
      timelineInertiaRef.current = null;
    }
  };

  const timelinePan = () => {
    timelinePanRef.current ??= createFramePanAccumulator(
      (deltaPx) => viewportStore.panByPixels(deltaPx),
      (callback) => requestAnimationFrame(callback),
      (id) => cancelAnimationFrame(id),
    );
    return timelinePanRef.current;
  };

  const timelineZoom = () => {
    timelineZoomRef.current ??= createFrameZoomAccumulator(
      (factor, clientX) => {
        const stage = stageRef.current;
        if (!stage) return;
        // Resolve the anchor once per frame, before that frame's DOM writes.
        const rect = stage.getBoundingClientRect();
        const localX = clientX - rect.left;
        const viewport = viewportStore.getSnapshot();
        const anchorAbs = localX < viewport.gutterPx || localX > rect.width
          ? viewport.centerAbs
          : absFromStageX(viewport, localX);
        viewportStore.zoomBy(factor, anchorAbs);
      },
      (callback) => requestAnimationFrame(callback),
      (id) => cancelAnimationFrame(id),
    );
    return timelineZoomRef.current;
  };

  const startTimelineInertia = (initialVelocity: number) => {
    let velocity = initialVelocity;
    const step = () => {
      if (Math.abs(velocity) < 0.012) {
        timelineInertiaRef.current = null;
        return;
      }
      const before = viewportStore.getSnapshot().centerAbs;
      viewportStore.panByPixels(velocity * 16);
      if (viewportStore.getSnapshot().centerAbs === before) {
        timelineInertiaRef.current = null;
        return;
      }
      velocity *= 0.9;
      timelineInertiaRef.current = requestAnimationFrame(step);
    };
    if (Math.abs(velocity) > 0.045) timelineInertiaRef.current = requestAnimationFrame(step);
  };

  const isPointOverMap = (clientX: number, clientY: number) => {
    const stage = stageRef.current;
    if (!stage || !mapLayout) return false;
    const rect = stage.getBoundingClientRect();
    const x = clientX - rect.left;
    const y = clientY - rect.top;
    const left = mapOffset.x + mapLayout.left * mapScale;
    const top = mapOffset.y + mapLayout.top * mapScale;
    return x >= left && x <= left + mapLayout.width * mapScale &&
      y >= top && y <= top + mapLayout.height * mapScale;
  };

  const isInteractiveTarget = (target: EventTarget | null) =>
    target instanceof Element && Boolean(
      target.closest("button, a, [role='button'], [data-map-pan-exclude]"),
    );

  // The installed listeners read the latest map geometry after renders.
  const mapPanTargetRef = useRef<(event: PointerEvent) => boolean>(() => false);
  mapPanTargetRef.current = (event) =>
    !isInteractiveTarget(event.target) && isPointOverMap(event.clientX, event.clientY);

  useEffect(() => {
    const stage = stageRef.current;
    if (!stage) return;
    const controller = createTimelinePointerController({
      stage,
      lifecycleTarget: window,
      visibilityTarget: document,
      pan: timelinePan(),
      zoom: timelineZoom(),
      isMapPanTarget: (event) => mapPanTargetRef.current(event),
      moveMap: (dx, dy) => setMapOffset((offset) => ({ x: offset.x + dx, y: offset.y + dy })),
      stopInertia: stopTimelineInertia,
      startInertia: startTimelineInertia,
    });
    pointerControllerRef.current = controller;
    return () => {
      pointerControllerRef.current = null;
      controller.dispose();
    };
  }, []);

  const dynastiesById = useMemo(() => {
    const map = new Map<string, Dynasty>();
    if (!data) return map;
    for (const dynasty of data.dynasties) {
      map.set(dynasty.id, dynasty);
    }
    return map;
  }, [data]);

  const boundsQuery = useDataBounds();
  const capitalsQuery = useCapitalLocations(boundsQuery.data, data?.reigns);
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
        rangesIntersect(dynasty.startAbs, dynasty.endAbs, viewport.startAbs, viewport.endAbs),
    );
    const ordered = [...visible].sort((a, b) => {
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
    () => {
      const capitals = capitalsQuery.data ?? [];
      // Reign-mapped capitals are only shown for the selected reign, never as ambient map points.
      const visible = capitalsActiveAtAbs(
        capitals.filter((capital) => capital.mappingKind !== "reign"),
        labelAnchorAbs,
      );
      const selected = selection.selected;
      if (!selected) {
        return visible;
      }
      const reign = selected.type === "reign"
        ? data?.reigns.find((item) => item.id === selected.id)
        : selected.type === "person" && selection.focusReignId
          ? data?.reigns.find((item) => item.id === selection.focusReignId)
          : undefined;
      const personReigns = selected.type === "person" ? data?.reigns.filter((item) => item.personId === selected.id) ?? [] : [];
      const selectedCapitals = selected.type === "location_mapping"
        ? capitals.filter((capital) => capital.id === selected.id)
        : selected.type === "dynasty"
          ? capitals.filter((capital) => capital.dynastyId === selected.id)
          : reign
            ? capitals.filter((capital) => capital.reignIds?.includes(reign.id))
            : capitalsForReigns(personReigns, data?.reigns ?? [], capitals);
      return [...new Map([...visible, ...selectedCapitals].map((capital) => [capital.id, capital])).values()];
    },
    [capitalsQuery.data, labelAnchorAbs, selection.selected, selection.focusReignId, data?.reigns],
  );
  const nearbyEvents = useMemo(() => {
    if (!data) return [];
    const windowStart = viewport.centerAbs - 12;
    const windowEnd = viewport.centerAbs + 12;
    const selectedEventId = selection.selected?.type === "event" ? selection.selected.id : undefined;
    return data.events.filter((event) => {
      if ((!eventDisplay.kinds[event.kind] && event.id !== selectedEventId) || event.locationMappings.length === 0) return false;
      if (event.id === selectedEventId) return true;
      const span = eventSpanAbs(event);
      return rangesIntersect(span.startAbs, span.endAbs, windowStart, windowEnd);
    });
  }, [data, viewport.centerAbs, eventDisplay, selection.selected]);
  const catalogDynastiesById = useMemo(() => {
    const map = new Map<string, Dynasty>();
    for (const dynasty of timelineCatalog?.dynasties ?? []) {
      map.set(dynasty.id, dynasty);
    }
    return map;
  }, [timelineCatalog]);


  const { railEvents, badgeEvents, badgePositions } = useMemo(() => {
    if (!data) return { railEvents: [], badgeEvents: [], badgePositions: new Map() };
    const visible = filterViewportEvents(
      data.events.filter((event) => eventDisplay.kinds[event.kind] && shouldShowEvent(event, viewport.lod)),
      viewport,
    );
    const laneIdByDynastyId = new Map<string, string>();
    for (const dynasty of placed) {
      laneIdByDynastyId.set(dynasty.id, dynasty.id);

    }
    const projected = layoutEvents(visible, viewport);
    const badgePositions = layoutPlacedEventBadges(projected, laneIdByDynastyId, viewport.widthPx);
    const visibleIds = new Set(visible.map((event) => event.id));
    return {
      railEvents: visible.filter((event) => !badgePositions.has(event.id)),
      badgeEvents: projected.filter((item) => visibleIds.has(item.event.id) && badgePositions.has(item.event.id)),
      badgePositions,
    };
  }, [data, viewport, placed, eventDisplay]);

  const eventPlaced = useMemo(() => layoutEvents(railEvents, viewport), [railEvents, viewport]);

  const totalEventLanes = eventLaneCount(eventPlaced);
  const canExpandEvents = totalEventLanes > DEFAULT_VISIBLE_EVENT_LANES;
  const showAllEvents = !canExpandEvents || eventsExpanded;
  const visibleEventPlaced = showAllEvents
    ? eventPlaced
    : eventPlaced.filter((item) => item.lane < DEFAULT_VISIBLE_EVENT_LANES);
  const railHeight = eventRailHeight(eventLaneCount(visibleEventPlaced));
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
    for (const person of [...data.persons,...(context?.persons ?? [])]) {
      map.set(person.id, person.name);
    }
    return map;
  }, [data,context?.persons]);

  const personDisplay = useMemo(() => {
    const map = new Map<
      string,
      {
        title?: string;
        personAltNames?: string[];
        ancestralXing?: string;
        clanShi?: string;
        posthumousNames?: string[];
        templeNames?: string[];
      }
    >();
    if (!data) return map;
    for (const person of [...data.persons,...(context?.persons ?? [])]) {
      if (
        person.ancestralXing ||
        person.clanShi ||
        person.title ||
        person.altNames.length ||
        person.posthumousNames.length ||
        person.templeNames.length
      ) {
        map.set(person.id, {
          title: person.title,
          personAltNames: person.altNames,
          ancestralXing: person.ancestralXing,
          clanShi: person.clanShi,
          posthumousNames: person.posthumousNames,
          templeNames: person.templeNames,
        });
      }
    }
    return map;
  }, [data,context?.persons]);

  // Keep lane record identities across zoom frames so static geometry stays cached.
  const lanePreparedCache = useMemo(
    () => new Map<string, {
      records: NonNullable<typeof data>["reigns"];
      reigns: NonNullable<typeof data>["reigns"];
      missingReigns: NonNullable<typeof data>["reigns"];
      geometry: ReturnType<typeof prepareLaneReignGeometry>;
      height: number;
      pxPerMonth: number;
      visibleReigns?: Reign[];
      visibleMissingReigns?: Reign[];
    }>(),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [reignsByDynasty, viewport.presentation.rowHeightPx, viewport.presentation.lanePaddingPx, personNames, personDisplay],
  );

  const lanes = useMemo(() => {
    let top = railHeight + EVENT_CONTROL_LANE_CLEARANCE;
    const clusterGroupIds = new Set((data?.dynastyGroups ?? []).map((group) => group.id));
    let previousClusterId: string | null = null;
    let hasPreviousLane = false;
    return placed.map((dynasty) => {
      const clusterId =
        dynasty.groupId && clusterGroupIds.has(dynasty.groupId) ? dynasty.groupId : null;
      if (
        hasPreviousLane &&
        previousClusterId !== clusterId &&
        (previousClusterId !== null || clusterId !== null)
      ) {
        top += clusterLaneGapForPresentation(viewport.presentation, clusterId !== null);
      }
      previousClusterId = clusterId;
      hasPreviousLane = true;
      let prepared = lanePreparedCache.get(dynasty.id);
      if (!prepared || prepared.pxPerMonth !== viewport.pxPerMonth) {
        const records = prepared?.records ?? collectLaneReigns(dynasty.id, reignsByDynasty);
        const { rulers: reigns, missing: missingReigns } = prepared
          ? { rulers: prepared.reigns, missing: prepared.missingReigns }
          : partitionReignRecords(records);
        const geometry = prepareLaneReignGeometry(
          reigns,

          viewport.presentation.rowHeightPx,
          viewport.pxPerMonth,
          personNames,
          personDisplay,
        );
        const height = dynastyLaneHeightForViewport(
          reigns,

          viewport,
          personNames,
          personDisplay,
          geometry,
        );
        prepared = { ...prepared, records, reigns, missingReigns, geometry, height, pxPerMonth: viewport.pxPerMonth };
        lanePreparedCache.set(dynasty.id, prepared);
      }
      const { records, reigns, missingReigns, geometry, height } = prepared;
      const { rowCount } = geometry;
      const nextVisibleReigns = filterVisibleCardReigns(reigns, geometry.byId, viewport.startAbs, viewport.endAbs, viewport.pxPerMonth);
      const nextVisibleMissingReigns = filterVisibleGapReigns(missingReigns, viewport.startAbs, viewport.endAbs, viewport.pxPerMonth);
      if (!sameReignIds(prepared.visibleReigns, nextVisibleReigns)) prepared.visibleReigns = nextVisibleReigns;
      if (!sameReignIds(prepared.visibleMissingReigns, nextVisibleMissingReigns)) prepared.visibleMissingReigns = nextVisibleMissingReigns;
      const visibleReigns = prepared.visibleReigns!;
      const visibleMissingReigns = prepared.visibleMissingReigns!;
      const chipHeight = viewport.presentation.railChipHeightPx;
      const chipTop =
        rowCount > 1
          ? top + height / 2 - chipHeight / 2
          : top + viewport.presentation.railChipTopPx;
      const badgeTop = top + viewport.presentation.lanePaddingPx - EVENT_BADGE_HALF_HEIGHT;
      const item = { dynasty, records, reigns, missingReigns, visibleReigns, visibleMissingReigns, geometry, top, height, badgeTop, chipTop, chipHeight };
      top += height;
      return item;
    });
  }, [data?.dynastyGroups, placed, railHeight, reignsByDynasty, viewport, personNames, personDisplay, lanePreparedCache]);

  const badgePlaced = useMemo(() => {
    const laneById = new Map(lanes.map((lane) => [lane.dynasty.id, lane]));
    return badgeEvents.map((item) => {
      const position = badgePositions.get(item.event.id);
      const lane = laneById.get(position?.laneId ?? "");
      const reign = lane && eventTargetReign(item.event, lane.reigns);
      const unit = reign && lane && lane.geometry.byId.get(reign.id);
      return {
        ...item,
        anchorX: position?.anchorX ?? item.anchorX,
        top: position?.edge === "bottom"
          ? lane
            ? viewport.presentation.lanePaddingPx + (unit
              ? unit.unitTop + unit.unitHeight
              : dynastyBarHeightForReigns(lane.reigns, viewport.presentation.rowHeightPx)) - EVENT_BADGE_HALF_HEIGHT
            : item.top
          : unit
            ? viewport.presentation.lanePaddingPx + unit.unitTop - EVENT_BADGE_HALF_HEIGHT
            : lane ? lane.badgeTop - lane.top : item.top,
      };
    });
  }, [badgeEvents, badgePositions, lanes, viewport.presentation]);

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
    () => viewport.presentation.railCollapsed ? [] : clusterFramesForLanes(lanes, data?.dynastyGroups ?? [], {
      insetPx: viewport.presentation.railInsetPx,
      labelWidthPx: viewport.presentation.railLabelWidthPx,
    }),
    [lanes, data?.dynastyGroups, viewport.presentation],
  );

  const resolvedFates = useMemo(
    () => data?.relations?.length ? resolveFateRelations(data.relations, fateReigns) : [],
    [data,fateReigns],
  );

  const fatePlaced = useMemo(() => {
    if (!data?.relations?.length || resolvedFates.length === 0) return [];
    return layoutReignFates(
      data.relations,
      fateReigns,
      lanes.map(({ dynasty, records, geometry, top }) => ({
        dynastyId: dynasty.id,
        top,
        records,
        geometryByReignId: geometry.byId,
        color: resolveDynastyColorValue(
          dynasty,
          laneColorTokenFor(laneColorMap, dynasty.id),
        ),
      })),
      viewport,
      personNames,
      personDisplay,
      resolvedFates,
    );
  }, [data, fateReigns, lanes, laneColorMap, viewport, personNames, personDisplay, resolvedFates]);

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
  const mountedPersons = useMemo(
    () => filterVisiblePlacedPersons(personPlaced, viewport.widthPx, viewport.gutterPx),
    [personPlaced, viewport.widthPx, viewport.gutterPx],
  );

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
      data-testid="timeline-workspace"
      data-map-vertical-alignment={mapVerticalAlignment}
      onPointerDown={(event) => pointerControllerRef.current?.pointerDown(event.nativeEvent)}
      onPointerMove={(event) => pointerControllerRef.current?.pointerMove(event.nativeEvent)}
      style={{
        ["--center-guide-x" as string]: `${centerGuideX(viewport)}px`,
        ...(stageViewportHeight > 0
          ? { ["--stage-viewport-height" as string]: `${stageViewportHeight}px` }
          : {}),
      }}
    >
      <div className={styles.mapUnderlay} aria-hidden="true">
        <div className={styles.viewportPanel}>
          <StableChinaMapBackground
            layout={mapLayout}
            scale={mapScale}
            offset={mapOffset}
          />
        </div>
      </div>
      <div className={styles.guideOverlay} aria-hidden="true">
        <div className={styles.viewportPanel} />
      </div>
      <div
        className={styles.content}
        style={{ minHeight: Math.max(stageViewportHeight, contentHeight) }}
      >
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
              <p className={styles.emptyTitle}>
                {import.meta.env.VITE_DATA_SOURCE === "sqlite" ? "本地数据加载失败" : "数据加载失败"}
              </p>
              <p className={styles.emptyHint}>
                {import.meta.env.VITE_DATA_SOURCE === "sqlite"
                  ? "正在自动重试；若持续出现，请完全退出后重新打开应用"
                  : "请确认 API 服务已启动（pnpm --filter @eralens/api dev）"}
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
              {lanes.map(({ dynasty, reigns, visibleReigns, visibleMissingReigns, geometry, top, height }) => (
                <DynastyLane
                  key={dynasty.id}
                  dynasty={dynasty}
                  laneColorToken={laneColorTokenFor(laneColorMap, dynasty.id)}
                  reigns={reigns}
                  visibleReigns={visibleReigns}
                  visibleMissingReigns={visibleMissingReigns}
                  reignGeometry={geometry.byId}
                  rowCount={geometry.rowCount}
                  barHeight={geometry.barHeight}
                  dynastiesById={dynastiesById}
                  personNames={personNames}
                  personClans={personDisplay}
                  top={top}
                  height={height}
                  badges={badgesByLane.get(dynasty.id) ?? []}
                />
              ))}
            </>
          )}
          {eventPlaced.length > 0 && (
            <>
              <EventLayer placed={visibleEventPlaced} height={railHeight} />
              {canExpandEvents && (
                <ExpandToggle
                  className={styles.eventExpandButton}
                  style={{ top: railHeight - 7 }}
                  expanded={eventsExpanded}
                  expandLabel="展开更多事件"
                  collapseLabel="收拢事件"
                  onClick={() => setEventsExpanded((expanded) => !expanded)}
                />
              )}
            </>
          )}
          {data && placed.length > 0 && fatePlaced.length > 0 && (
            <ReignFateLayer placed={fatePlaced} height={contentHeight} />
          )}
          {showPersonLayer && (
            <PersonLayer
              placed={mountedPersons}
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
            catalogDynastiesById={catalogDynastiesById}
            laneColorMap={laneColorMap}
            atAbs={labelAnchorAbs}
            layout={mapLayout}
            scale={mapScale}
            offset={mapOffset}
          />
        </div>
      </div>
      <div className={styles.eventOverlay} aria-hidden={nearbyEvents.length === 0}>
        <div className={styles.viewportPanel}>
          <EventMapLayer
            events={nearbyEvents}
            atAbs={viewport.centerAbs}
            layout={mapLayout}
            scale={mapScale}
            offset={mapOffset}
          />
        </div>
      </div>
      <div className={styles.mapControlsOverlay}>
        <div className={styles.viewportPanel}>
          <div className={styles.mapControls} role="group" aria-label="地图缩放">
            <button
              type="button"
              onClick={() => setMapScale((scale) => Math.min(2.8, Math.round((scale + 0.2) * 10) / 10))}
              aria-label="放大地图"
              title="放大"
              disabled={mapScale >= 2.8}
            >
              +
            </button>
            <span aria-hidden="true" />
            <button
              type="button"
              onClick={() => setMapScale((scale) => Math.max(0.7, Math.round((scale - 0.2) * 10) / 10))}
              aria-label="缩小地图"
              title="缩小"
              disabled={mapScale <= 0.7}
            >
              −
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
