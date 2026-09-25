import type { Event, Reign } from "@eralens/shared";
import { activeReignsAtAbs, eventSpanAbs } from "@eralens/shared";
import { projectAbs, projectRange, type ViewportState } from "./coordinates";

/** Maximum visual width of an event pill, matching `.marker { max-width }`. */
export const EVENT_MARKER_WIDTH = 132;
const EVENT_MARKER_CHROME_WIDTH = 27;
const EVENT_LABEL_FONT_SIZE = 11;
/** Border + left padding + half the 5px dot; keeps the pill origin on the time. */
export const EVENT_MARKER_DOT_OFFSET = 10;
/** Inset from the stage edge so a stuck label is not flush with the viewport. */
export const EVENT_MARKER_VIEW_PAD = 8;
export const EVENT_ROW_TOP = 8;
export const EVENT_ROW_STEP = 28;
export const EVENT_BADGE_HALF_HEIGHT = 12;
/** A badge may nudge within its date column, but must not drift along the lane. */
export const EVENT_BADGE_MAX_NUDGE = 16;
export const EVENT_LANE_PAD = 8;
export const EVENT_RAIL_MIN_HEIGHT = 64;

export type PlacedEvent = {
  event: Event;
  lane: number;
  showBand: boolean;
  markerWidth: number;
  anchorX: number;
  bandLeft: number;
  bandWidth: number;
  top: number;
};

/**
 * Estimate the inline width used by the event label without reading the DOM.
 * Timeline layout runs before the markers mount, so the estimate must be
 * deterministic and mirror the 11px sans-serif label closely. CJK glyphs in
 * the product font are full-em; Latin glyphs use compact approximations.
 */
export function eventMarkerWidth(name: string, approximate = false): number {
  let labelWidth = 0;
  for (const character of Array.from(name)) {
    if (/\s/u.test(character)) {
      labelWidth += EVENT_LABEL_FONT_SIZE * 0.35;
    } else if (/[\u1100-\u11ff\u2e80-\ua4cf\uf900-\ufaff\uff00-\uffef]/u.test(character)) {
      labelWidth += EVENT_LABEL_FONT_SIZE;
    } else if (/[ilI1'.,:;!|]/u.test(character)) {
      labelWidth += EVENT_LABEL_FONT_SIZE * 0.35;
    } else if (/[MW@#%&]/u.test(character)) {
      labelWidth += EVENT_LABEL_FONT_SIZE * 0.9;
    } else {
      labelWidth += EVENT_LABEL_FONT_SIZE * 0.62;
    }
  }
  return Math.min(EVENT_MARKER_WIDTH, EVENT_MARKER_CHROME_WIDTH + labelWidth + (approximate ? 18 : 0));
}

export function eventHasBand(event: Event): boolean {
  return event.kind !== "poetry" && (event.timeMode === "span" || event.timeMode === "circa");
}

function clamp(value: number, min: number, max: number): number {
  return Math.min(max, Math.max(min, value));
}

/**
 * Keep a span/circa label on-screen while any of its gray range is visible.
 * Natural time-anchor is used when that pill is fully on the page and still
 * overlaps the remaining band; otherwise the pill pins to the left of the
 * visible band (pulled inward if the remaining sliver is on the far right).
 */
export function stickyEventMarkerX(options: {
  anchorX: number;
  bandLeft: number;
  bandWidth: number;
  viewportWidth: number;
  markerWidth?: number;
  pad?: number;
  gutter?: number;
}): number {
  const markerWidth = options.markerWidth ?? EVENT_MARKER_WIDTH;
  const pad = options.pad ?? EVENT_MARKER_VIEW_PAD;
  const gutter = options.gutter ?? 0;
  const bandRight = options.bandLeft + options.bandWidth;
  const visLeft = Math.max(gutter, options.bandLeft);
  const visRight = Math.min(options.viewportWidth, bandRight);
  if (visRight <= visLeft) return options.anchorX;

  const viewLeft = gutter + pad;
  const viewRight = Math.max(viewLeft, options.viewportWidth - pad);
  const pillLeft = options.anchorX - EVENT_MARKER_DOT_OFFSET;
  const pillRight = pillLeft + markerWidth;
  const fullyOnPage = pillLeft >= viewLeft && pillRight <= viewRight;
  const overlapsBand = pillRight > visLeft && pillLeft < visRight;
  if (fullyOnPage && overlapsBand) return options.anchorX;

  const maxPillLeft = Math.max(viewLeft, viewRight - markerWidth);
  const stuckLeft = clamp(visLeft, viewLeft, maxPillLeft);
  return stuckLeft + EVENT_MARKER_DOT_OFFSET;
}

/** Horizontal interval this event occupies, including label pill and range band. */
export function eventHitInterval(
  event: Event,
  viewport: ViewportState,
): { left: number; right: number } {
  const span = eventSpanAbs(event);
  const x = projectAbs(viewport, span.anchorAbs);
  const markerWidth = eventMarkerWidth(event.name, event.isApproximate);
  let left = x - EVENT_MARKER_DOT_OFFSET;
  let right = left + markerWidth;
  if (eventHasBand(event)) {
    const range = projectRange(viewport, span.startAbs, span.endAbs);
    left = Math.min(left, range.left);
    right = Math.max(right, range.left + range.width);
  }
  return { left: left - EVENT_LANE_PAD, right: right + EVENT_LANE_PAD };
}

/** Query chunks include events outside the current view; only visible marks take layout space. */
export function filterViewportEvents(events: Event[], viewport: ViewportState): Event[] {
  const gutter = viewport.gutterPx ?? 0;
  return events.filter((event) => {
    const { left, right } = eventHitInterval(event, viewport);
    return left < viewport.widthPx && right > gutter;
  });
}

export function packEventLanes(
  intervals: { id: string; left: number; right: number }[],
): Map<string, number> {
  const sorted = [...intervals].sort(
    (a, b) => a.left - b.left || a.right - b.right || a.id.localeCompare(b.id),
  );
  const laneEnds: number[] = [];
  const lanes = new Map<string, number>();
  for (const item of sorted) {
    let lane = laneEnds.findIndex((end) => end <= item.left);
    if (lane === -1) {
      lane = laneEnds.length;
      laneEnds.push(item.right);
    } else {
      laneEnds[lane] = item.right;
    }
    lanes.set(item.id, lane);
  }
  return lanes;
}

export type EventBadgePosition = { laneId: string; anchorX: number; edge: "top" | "bottom" };

function eventCanDriftHorizontally(event: Event): boolean {
  return event.isApproximate;
}

/** Anchor a dated event to its unique active card, using participants to disambiguate overlap. */
export function eventTargetReign(event: Event, reigns: readonly Reign[]): Reign | null {
  const { anchorAbs } = eventSpanAbs(event);
  const active = activeReignsAtAbs(reigns, anchorAbs).filter((reign) =>
    event.dynastyIds.includes(reign.dynastyId),
  );
  const participants = active.filter((reign) => event.participantIds.includes(reign.personId));
  if (participants.length === 1) return participants[0]!;
  if (participants.length > 1) return null;
  return active.length === 1 ? active[0]! : null;
}

const EVENT_PRECISION_ORDER: Record<Event["precision"], number> = {
  day: 5,
  month: 4,
  year: 3,
  decade: 2,
  century: 1,
};

/** Place single-dynasty badges on lane edges, preferring top and prioritizing precision. */
export function layoutEventBadges(
  events: Event[],
  viewport: ViewportState,
  laneIdByDynastyId: ReadonlyMap<string, string>,
): Map<string, EventBadgePosition> {
  return layoutPlacedEventBadges(layoutEvents(events, viewport), laneIdByDynastyId, viewport.widthPx);
}

/** Reuse already projected events so panning does not lay out every badge twice. */
export function layoutPlacedEventBadges(
  placed: readonly PlacedEvent[],
  laneIdByDynastyId: ReadonlyMap<string, string>,
  viewportWidth = Number.POSITIVE_INFINITY,
): Map<string, EventBadgePosition> {
  const byLane = new Map<string, { item: PlacedEvent; left: number }[]>();
  for (const item of placed) {
    const { event } = item;
    if (event.timeMode !== "point") continue;
    if (event.dynastyIds.length !== 1) continue;
    const laneId = laneIdByDynastyId.get(event.dynastyIds[0]!);
    if (!laneId) continue;
    const items = byLane.get(laneId) ?? [];
    const left = item.anchorX - EVENT_MARKER_DOT_OFFSET;
    items.push({ item, left });
    byLane.set(laneId, items);
  }
  const positions = new Map<string, EventBadgePosition>();
  for (const [laneId, items] of byLane) {
    items.sort((a, b) =>
      EVENT_PRECISION_ORDER[b.item.event.precision] - EVENT_PRECISION_ORDER[a.item.event.precision] ||
      eventSpanAbs(a.item.event).anchorAbs - eventSpanAbs(b.item.event).anchorAbs ||
      a.item.event.id.localeCompare(b.item.event.id),
    );
    const occupied: Record<"top" | "bottom", { left: number; right: number }[]> = { top: [], bottom: [] };
    for (const entry of items) {
      const width = entry.item.markerWidth;
      const minLeft = EVENT_MARKER_VIEW_PAD;
      const maxLeft = Math.max(minLeft, viewportWidth - EVENT_MARKER_VIEW_PAD - width);
      const canDrift = eventCanDriftHorizontally(entry.item.event);
      const naturalLeft = canDrift ? entry.left : clamp(entry.left, minLeft, maxLeft);
      let chosen: { edge: "top" | "bottom"; left: number } | undefined;
      const searchRadius = canDrift
        ? Math.max(1, items.length) * (EVENT_MARKER_WIDTH + EVENT_LANE_PAD)
        : EVENT_BADGE_MAX_NUDGE;
      for (const edge of ["top", "bottom"] as const) {
        const intervals = occupied[edge];
        const candidates = [naturalLeft];
        if (canDrift) {
          for (let offset = 12; offset <= searchRadius; offset += 12) {
            candidates.push(naturalLeft - offset, naturalLeft + offset);
          }
        } else {
          for (const interval of intervals) candidates.push(interval.right + EVENT_LANE_PAD);
        }
        const left = candidates
          .filter((candidate) => canDrift || (candidate >= minLeft && candidate <= maxLeft))
          .filter((candidate) => Math.abs(candidate - naturalLeft) <= searchRadius)
          .filter((candidate) => intervals.every((interval) =>
            candidate + width + EVENT_LANE_PAD <= interval.left ||
            candidate >= interval.right + EVENT_LANE_PAD,
          ))
          .sort((a, b) => a - b)[0];
        if (left != null) { chosen = { edge, left }; break; }
      }
      if (!chosen) continue;
      positions.set(entry.item.event.id, {
        laneId,
        anchorX: chosen.left + EVENT_MARKER_DOT_OFFSET,
        edge: chosen.edge,
      });
      const list = occupied[chosen.edge];
      const insertAt = list.findIndex((interval) => interval.left > chosen!.left);
      list.splice(insertAt < 0 ? list.length : insertAt, 0, { left: chosen.left, right: chosen.left + width });
    }
  }
  return positions;
}

export function layoutEvents(events: Event[], viewport: ViewportState): PlacedEvent[] {
  const exactEvents = events.filter((event) => !(event.isApproximate && event.timeMode === "point"));
  const intervals = exactEvents.map((event) => ({
    id: event.id,
    ...eventHitInterval(event, viewport),
  }));
  const lanes = packEventLanes(intervals);
  const approximatePoints = events
    .filter((event) => event.isApproximate && event.timeMode === "point")
    .map((event) => ({ event, naturalX: projectAbs(viewport, eventSpanAbs(event).anchorAbs), width: eventMarkerWidth(event.name, event.isApproximate) }))
    .sort((a, b) => a.naturalX - b.naturalX || a.event.id.localeCompare(b.event.id));
  const occupied: { left: number; right: number }[][] = [];
  for (const event of exactEvents) {
    const lane = lanes.get(event.id) ?? 0;
    const list = occupied[lane] ?? (occupied[lane] = []);
    list.push(eventHitInterval(event, viewport));
  }
  const approximatePlacement = new Map<string, { lane: number; anchorX: number }>();
  for (const entry of approximatePoints) {
    const naturalLeft = entry.naturalX - EVENT_MARKER_DOT_OFFSET;
    // Candidate offsets are relative to the absolute time anchor, never to the
    // viewport edges. Panning therefore translates labels without reassigning
    // their slots or lanes.
    const searchRadius = Math.max(1, events.length) * (EVENT_MARKER_WIDTH + EVENT_LANE_PAD);
    const candidates = [naturalLeft];
    for (let offset = 12; offset <= searchRadius; offset += 12) {
      candidates.push(naturalLeft - offset, naturalLeft + offset);
    }
    let lane = 0;
    let chosenLeft: number | undefined;
    for (; lane < occupied.length + 1; lane += 1) {
      const laneIntervals = occupied[lane] ?? (occupied[lane] = []);
      chosenLeft = candidates.find((left) => laneIntervals.every((interval) =>
        left + entry.width + EVENT_LANE_PAD <= interval.left ||
        left >= interval.right + EVENT_LANE_PAD,
      ));
      if (chosenLeft != null) {
        laneIntervals.push({ left: chosenLeft, right: chosenLeft + entry.width });
        break;
      }
    }
    if (chosenLeft != null) {
      approximatePlacement.set(entry.event.id, {
        lane,
        anchorX: chosenLeft + EVENT_MARKER_DOT_OFFSET,
      });
    }
  }
  return events.map((event) => {
    const span = eventSpanAbs(event);
    const showBand = eventHasBand(event);
    const range = projectRange(viewport, span.startAbs, span.endAbs);
    const bandWidth = Math.max(8, range.width);
    const naturalX = projectAbs(viewport, span.anchorAbs);
    const approximate = approximatePlacement.get(event.id);
    const lane = approximate?.lane ?? lanes.get(event.id) ?? 0;
    const markerWidth = eventMarkerWidth(event.name, event.isApproximate);
    return {
      event,
      lane,
      showBand,
      markerWidth,
      anchorX: approximate?.anchorX ?? (showBand
        ? stickyEventMarkerX({
            anchorX: naturalX,
            bandLeft: range.left,
            bandWidth,
            viewportWidth: viewport.widthPx,
            gutter: viewport.gutterPx,
            markerWidth,
          })
        : naturalX),
      bandLeft: range.left,
      bandWidth,
      top: EVENT_ROW_TOP + lane * EVENT_ROW_STEP,
    };
  });
}

export function eventLaneCount(placed: PlacedEvent[]): number {
  if (placed.length === 0) return 0;
  return Math.max(...placed.map((item) => item.lane)) + 1;
}

/** Remove rows vacated by badges without repeating event projection and packing. */
export function compactEventLanes(placed: PlacedEvent[]): PlacedEvent[] {
  const used = [...new Set(placed.map((item) => item.lane))].sort((a, b) => a - b);
  const ranks = new Map(used.map((lane, index) => [lane, index]));
  return placed.map((item) => {
    const lane = ranks.get(item.lane) ?? 0;
    return { ...item, lane, top: EVENT_ROW_TOP + lane * EVENT_ROW_STEP };
  });
}

export function eventRailHeight(laneCount: number): number {
  if (laneCount <= 0) return EVENT_RAIL_MIN_HEIGHT;
  return Math.max(
    EVENT_RAIL_MIN_HEIGHT,
    EVENT_ROW_TOP + laneCount * EVENT_ROW_STEP + EVENT_ROW_TOP,
  );
}
