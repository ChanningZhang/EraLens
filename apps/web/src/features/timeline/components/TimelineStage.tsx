import { memo, useEffect, useMemo, useRef, useState, type PointerEvent as ReactPointerEvent } from "react";
import { ExpandToggle } from "@/components/ExpandToggle";
import {
  activeReignsAtAbs,
  buildLaneOrderIndex,
  capitalsActiveAtAbs,
  capitalsForReigns,
  clusterLaneGapForPresentation,
  clusterFramesForLanes,
  collapseDynastyLaneGroups,
  collectLaneReigns,
  compareTimedOrder,
  eventSpanAbs,
  formatYear,
  fromAbsMonth,
  hasUncertainDateRange,
  rangesIntersect,
  fallbackLaneColorToken,
  getDynastyLaneGroup,
  resolveDynastyColorValue,
  resolveFateRelations,
  type Dynasty,
  type EventDisplayConfig,
  type Reign,
} from "@eralens/shared";
import { useDataBounds, useTimelineData } from "../hooks/useTimelineData";
import { useDynastyCapitals } from "../hooks/useDynastyCapitals";
import { useLaneColorCatalog } from "../hooks/useLaneColorCatalog";
import { useStageViewportSize } from "../hooks/useStageViewportHeight";
import { resolveChinaMapInsets, resolveChinaMapLayout } from "../model/chinaMapProjection";
import { useTimelineCatalog } from "../hooks/useTimelineCatalog";
import { createFramePanAccumulator } from "../hooks/useTimelineWheel";
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
  assignReignStacks,
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
  const timelinePointersRef = useRef(new Map<number, { x: number; y: number }>());
  const timelineGestureRef = useRef<{
    mode: "pending" | "pan" | "scroll" | "pinch";
    x: number;
    y: number;
    time: number;
    velocity: number;
    distance: number;
  } | null>(null);
  const timelineInertiaRef = useRef<number | null>(null);
  const timelinePanRef = useRef<ReturnType<typeof createFramePanAccumulator> | null>(null);
  const [eventsExpanded, setEventsExpanded] = useState(false);
  const [mapScale, setMapScale] = useState(1);
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
  const { data, isLoading, error } = useTimelineData();

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

  const onStagePointerDown = (event: ReactPointerEvent<HTMLDivElement>) => {
    if (event.pointerType !== "touch") return;
    stopTimelineInertia();
    timelinePointersRef.current.set(event.pointerId, { x: event.clientX, y: event.clientY });
    const points = [...timelinePointersRef.current.values()];
    if (points.length >= 2) {
      timelinePanRef.current?.flush();
      const [a, b] = points;
      timelineGestureRef.current = {
        mode: "pinch",
        x: (a.x + b.x) / 2,
        y: (a.y + b.y) / 2,
        time: performance.now(),
        velocity: 0,
        distance: Math.max(1, Math.hypot(a.x - b.x, a.y - b.y)),
      };
    } else {
      timelineGestureRef.current = {
        mode: "pending",
        x: event.clientX,
        y: event.clientY,
        time: performance.now(),
        velocity: 0,
        distance: 0,
      };
    }
    event.currentTarget.setPointerCapture(event.pointerId);
  };

  const onStagePointerMove = (event: ReactPointerEvent<HTMLDivElement>) => {
    if (!timelinePointersRef.current.has(event.pointerId)) return;
    timelinePointersRef.current.set(event.pointerId, { x: event.clientX, y: event.clientY });
    const points = [...timelinePointersRef.current.values()];
    const gesture = timelineGestureRef.current;
    if (!gesture) return;
    if (points.length >= 2) {
      const [a, b] = points;
      const distance = Math.max(1, Math.hypot(a.x - b.x, a.y - b.y));
      const midpointX = (a.x + b.x) / 2;
      if (gesture.mode === "pinch" && gesture.distance > 0) {
        timelinePan().flush();
        const rect = event.currentTarget.getBoundingClientRect();
        const localX = midpointX - rect.left;
        const viewport = viewportStore.getSnapshot();
        const anchorAbs = localX < viewport.gutterPx || localX > rect.width
          ? viewport.centerAbs
          : absFromStageX(viewport, localX);
        viewportStore.zoomBy(distance / gesture.distance, anchorAbs);
      }
      timelineGestureRef.current = { ...gesture, mode: "pinch", distance, x: midpointX, y: (a.y + b.y) / 2 };
      event.preventDefault();
      return;
    }

    const dx = event.clientX - gesture.x;
    const dy = event.clientY - gesture.y;
    if (gesture.mode === "pending") {
      if (Math.max(Math.abs(dx), Math.abs(dy)) < 7) return;
      if (Math.abs(dx) >= Math.abs(dy) * 1.2) {
        timelineGestureRef.current = { ...gesture, mode: "pan", x: event.clientX, y: event.clientY, time: performance.now() };
      } else {
        event.currentTarget.scrollTop -= dy;
        timelineGestureRef.current = { ...gesture, mode: "scroll", x: event.clientX, y: event.clientY };
      }
      event.preventDefault();
      return;
    }
    if (gesture.mode === "scroll") {
      event.currentTarget.scrollTop -= dy;
      timelineGestureRef.current = { ...gesture, x: event.clientX, y: event.clientY };
      event.preventDefault();
      return;
    }
    if (gesture.mode !== "pan") return;
    const now = performance.now();
    const delta = event.clientX - gesture.x;
    const dt = now - gesture.time;
    timelinePan().queue(delta);
    timelineGestureRef.current = {
      ...gesture,
      x: event.clientX,
      y: event.clientY,
      time: now,
      velocity: dt > 0 ? delta / dt : gesture.velocity,
    };
    event.preventDefault();
  };

  const onStagePointerUp = (event: ReactPointerEvent<HTMLDivElement>) => {
    if (!timelinePointersRef.current.has(event.pointerId)) return;
    timelinePointersRef.current.delete(event.pointerId);
    const gesture = timelineGestureRef.current;
    timelineGestureRef.current = null;
    timelinePanRef.current?.flush();
    if (event.currentTarget.hasPointerCapture(event.pointerId)) event.currentTarget.releasePointerCapture(event.pointerId);
    if (gesture?.mode === "pan" && timelinePointersRef.current.size === 0) startTimelineInertia(gesture.velocity);
  };
  useEffect(() => () => {
    stopTimelineInertia();
    timelinePanRef.current?.cancel();
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
        rangesIntersect(dynasty.startAbs, dynasty.endAbs, viewport.startAbs, viewport.endAbs),
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
    () => {
      const capitals = capitalsQuery.data ?? [];
      const activeReigns = activeReignsAtAbs(data?.reigns ?? [], labelAnchorAbs);
      // An inferred reign cannot narrow the dynasty's own capital map records.
      const activeReignDynasties = new Set(
        activeReigns.filter((reign) => !hasUncertainDateRange(reign)).map((reign) => reign.dynastyId),
      );
      const ownedAtAnchor = capitalsForReigns(activeReigns, data?.reigns ?? [], capitals)
        .filter((capital) => capital.startAbs <= labelAnchorAbs && capital.endAbs >= labelAnchorAbs);
      const ownedIds = new Set(ownedAtAnchor.map((capital) => capital.id));
      const visible = capitalsActiveAtAbs(capitals, labelAnchorAbs).filter(
        (capital) => !activeReignDynasties.has(capital.dynastyId) || ownedIds.has(capital.id),
      );
      const selected = selection.selected;
      if (!selected) {
        return [...new Map([...visible, ...ownedAtAnchor].map((capital) => [capital.id, capital])).values()];
      }
      const reign = selected.type === "reign" ? data?.reigns.find((item) => item.id === selected.id) : undefined;
      const personReigns = selected.type === "person" ? data?.reigns.filter((item) => item.personId === selected.id) ?? [] : [];
      const dynastyIds = new Set<string>();
      if (selected.type === "dynasty") dynastyIds.add(selected.id);
      if (reign) dynastyIds.add(reign.dynastyId);
      for (const item of personReigns) dynastyIds.add(item.dynastyId);
      const selectedCapitals = selected.type === "capital"
        ? capitals.filter((capital) => capital.id === selected.id)
        : selected.type === "dynasty"
          ? capitals.filter((capital) => dynastyIds.has(capital.dynastyId))
          : capitalsForReigns(reign ? [reign] : personReigns, data?.reigns ?? [], capitals);
      return [...new Map([...visible, ...selectedCapitals].map((capital) => [capital.id, capital])).values()];
    },
    [capitalsQuery.data, labelAnchorAbs, selection.selected, data?.reigns],
  );
  const nearbyEvents = useMemo(() => {
    if (!data) return [];
    const windowStart = viewport.centerAbs - 12;
    const windowEnd = viewport.centerAbs + 12;
    const selectedEventId = selection.selected?.type === "event" ? selection.selected.id : undefined;
    return data.events.filter((event) => {
      if ((!eventDisplay.kinds[event.kind] && event.id !== selectedEventId) || (!event.location && event.locations.length === 0)) return false;
      if (event.id === selectedEventId) return true;
      const span = eventSpanAbs(event);
      return rangesIntersect(span.startAbs, span.endAbs, windowStart, windowEnd);
    });
  }, [data, viewport.centerAbs, eventDisplay, selection.selected]);
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
      data.events.filter((event) => eventDisplay.kinds[event.kind] && shouldShowEvent(event, viewport.lod)),
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
    const visibleIds = new Set(visible.map((event) => event.id));
    return {
      railEvents: visible.filter((event) => !badgePositions.has(event.id)),
      badgeEvents: projected.filter((item) => visibleIds.has(item.event.id) && badgePositions.has(item.event.id)),
      badgePositions,
    };
  }, [data, viewport, placed, laneGroups, eventDisplay]);

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

  // Ownership, stacking, and caption height are independent of pan position.
  const lanePreparedCache = useMemo(
    () => new Map<string, {
      records: NonNullable<typeof data>["reigns"];
      reigns: NonNullable<typeof data>["reigns"];
      missingReigns: NonNullable<typeof data>["reigns"];
      geometry: ReturnType<typeof prepareLaneReignGeometry>;
      height: number;
      visibleReigns?: Reign[];
      visibleMissingReigns?: Reign[];
    }>(),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [reignsByDynasty, laneGroups, viewport.pxPerMonth, viewport.presentation.rowHeightPx, viewport.presentation.lanePaddingPx, personNames, personDisplay],
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
      if (!prepared) {
        const records = collectLaneReigns(dynasty.id, reignsByDynasty, laneGroups);
        const { rulers: reigns, missing: missingReigns } = partitionReignRecords(records);
        const geometry = prepareLaneReignGeometry(
          reigns,
          laneGroups,
          viewport.presentation.rowHeightPx,
          viewport.pxPerMonth,
          personNames,
          personDisplay,
        );
        const height = dynastyLaneHeightForViewport(
          reigns,
          laneGroups,
          viewport,
          personNames,
          personDisplay,
        );
        prepared = { records, reigns, missingReigns, geometry, height };
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
  }, [data?.dynastyGroups, placed, railHeight, reignsByDynasty, laneGroups, viewport, personNames, personDisplay, lanePreparedCache]);

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
              : dynastyBarHeightForReigns(lane.reigns, laneGroups, viewport.presentation.rowHeightPx)) - EVENT_BADGE_HALF_HEIGHT
            : item.top
          : unit
            ? viewport.presentation.lanePaddingPx + unit.unitTop - EVENT_BADGE_HALF_HEIGHT
            : lane ? lane.badgeTop - lane.top : item.top,
      };
    });
  }, [badgeEvents, badgePositions, lanes, laneGroups, viewport.presentation]);

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
    () => data?.relations?.length ? resolveFateRelations(data.relations, data.reigns) : [],
    [data],
  );

  const fatePlaced = useMemo(() => {
    if (!data?.relations?.length || resolvedFates.length === 0) return [];
    return layoutReignFates(
      data.relations,
      data.reigns,
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
  }, [data, lanes, laneColorMap, viewport, personNames, personDisplay, resolvedFates]);

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
      onPointerDown={onStagePointerDown}
      onPointerMove={onStagePointerMove}
      onPointerUp={onStagePointerUp}
      onPointerCancel={onStagePointerUp}
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
            offset={{ x: 0, y: 0 }}
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
                  laneGroups={laneGroups}
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
            dynastyNamesById={dynastyNamesById}
            laneColorMap={laneColorMap}
            atAbs={labelAnchorAbs}
            layout={mapLayout}
            scale={mapScale}
            offset={{ x: 0, y: 0 }}
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
            offset={{ x: 0, y: 0 }}
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
