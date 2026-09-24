import type { Event, Reign } from "@eralens/shared";
import { eventSpanAbs } from "@eralens/shared";
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
export const EVENT_LANE_PAD = 8;
export const EVENT_RAIL_MIN_HEIGHT = 64;

export type PlacedEvent = {
  event: Event;
  lane: number;
  showBand: boolean;
  markerWidth: number;
  anchorX: number;
  badgeOriginX?: number;
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
export function eventMarkerWidth(name: string): number {
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
  return Math.min(EVENT_MARKER_WIDTH, EVENT_MARKER_CHROME_WIDTH + labelWidth);
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
  const markerWidth = eventMarkerWidth(event.name);
  let left = x - EVENT_MARKER_DOT_OFFSET;
  let right = left + markerWidth;
  if (eventHasBand(event)) {
    const range = projectRange(viewport, span.startAbs, span.endAbs);
    left = Math.min(left, range.left);
    right = Math.max(right, range.left + range.width);
  }
  return { left: left - EVENT_LANE_PAD, right: right + EVENT_LANE_PAD };
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

export type EventBadgePosition = { laneId: string; anchorX: number };

/** A participant identifies a card only when exactly one linked reign covers the event date. */
export function eventTargetReign(event: Event, reigns: readonly Reign[]): Reign | null {
  const { anchorAbs } = eventSpanAbs(event);
  const matches = reigns.filter((reign) =>
    event.dynastyIds.includes(reign.dynastyId) &&
    event.participantIds.includes(reign.personId) &&
    reign.startAbs <= anchorAbs && anchorAbs <= reign.endAbs,
  );
  return matches.length === 1 ? matches[0]! : null;
}

const EVENT_PRECISION_ORDER: Record<Event["precision"], number> = {
  day: 5,
  month: 4,
  year: 3,
  decade: 2,
  century: 1,
};

/** Place single-dynasty badges on one row, prioritizing the most precise event in each overlap group. */
export function layoutEventBadges(
  events: Event[],
  viewport: ViewportState,
  laneIdByDynastyId: ReadonlyMap<string, string>,
): Map<string, EventBadgePosition> {
  const byLane = new Map<string, { item: PlacedEvent; left: number; right: number }[]>();
  for (const item of layoutEvents(events, viewport)) {
    const { event } = item;
    if (event.dynastyIds.length !== 1) continue;
    const laneId = laneIdByDynastyId.get(event.dynastyIds[0]!);
    if (!laneId) continue;
    const items = byLane.get(laneId) ?? [];
    const left = item.anchorX - EVENT_MARKER_DOT_OFFSET;
    items.push({ item, left, right: left + item.markerWidth });
    byLane.set(laneId, items);
  }
  const positions = new Map<string, EventBadgePosition>();
  for (const [laneId, items] of byLane) {
    items.sort((a, b) => a.left - b.left || a.item.event.id.localeCompare(b.item.event.id));
    let lastRight = Number.NEGATIVE_INFINITY;
    for (let index = 0; index < items.length;) {
      const group = [items[index++]!];
      let naturalRight = group[0]!.right;
      while (index < items.length && items[index]!.left < naturalRight + EVENT_LANE_PAD) {
        group.push(items[index++]!);
        naturalRight = Math.max(naturalRight, group.at(-1)!.right);
      }
      group.sort((a, b) =>
        EVENT_PRECISION_ORDER[b.item.event.precision] - EVENT_PRECISION_ORDER[a.item.event.precision] ||
        eventSpanAbs(a.item.event).anchorAbs - eventSpanAbs(b.item.event).anchorAbs ||
        a.item.event.id.localeCompare(b.item.event.id),
      );
      for (const entry of group) {
        const left = Math.max(entry.left, lastRight + EVENT_LANE_PAD);
        positions.set(entry.item.event.id, { laneId, anchorX: left + EVENT_MARKER_DOT_OFFSET });
        lastRight = left + entry.item.markerWidth;
      }
    }
  }
  return positions;
}

export function layoutEvents(events: Event[], viewport: ViewportState): PlacedEvent[] {
  const intervals = events.map((event) => ({
    id: event.id,
    ...eventHitInterval(event, viewport),
  }));
  const lanes = packEventLanes(intervals);
  return events.map((event) => {
    const span = eventSpanAbs(event);
    const showBand = eventHasBand(event);
    const range = projectRange(viewport, span.startAbs, span.endAbs);
    const bandWidth = Math.max(8, range.width);
    const naturalX = projectAbs(viewport, span.anchorAbs);
    const lane = lanes.get(event.id) ?? 0;
    const markerWidth = eventMarkerWidth(event.name);
    return {
      event,
      lane,
      showBand,
      markerWidth,
      anchorX: showBand
        ? stickyEventMarkerX({
            anchorX: naturalX,
            bandLeft: range.left,
            bandWidth,
            viewportWidth: viewport.widthPx,
            gutter: viewport.gutterPx,
            markerWidth,
          })
        : naturalX,
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

export function eventRailHeight(laneCount: number): number {
  if (laneCount <= 0) return EVENT_RAIL_MIN_HEIGHT;
  return Math.max(
    EVENT_RAIL_MIN_HEIGHT,
    EVENT_ROW_TOP + laneCount * EVENT_ROW_STEP + EVENT_ROW_TOP,
  );
}
