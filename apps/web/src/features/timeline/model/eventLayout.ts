import type { Event } from "@eralens/shared";
import { eventSpanAbs } from "@eralens/shared";
import { projectAbs, projectRange, type ViewportState } from "./coordinates";

export const EVENT_MARKER_WIDTH = 132;
/** Border + left padding + half the 5px dot; keeps the pill origin on the time. */
export const EVENT_MARKER_DOT_OFFSET = 10;
export const EVENT_ROW_TOP = 8;
export const EVENT_ROW_STEP = 28;
export const EVENT_LANE_PAD = 8;
export const EVENT_RAIL_MIN_HEIGHT = 64;

export type PlacedEvent = {
  event: Event;
  lane: number;
  showBand: boolean;
  anchorX: number;
  bandLeft: number;
  bandWidth: number;
  top: number;
};

export function eventHasBand(event: Event): boolean {
  return event.timeMode === "span" || event.timeMode === "circa";
}

/** Horizontal interval this event occupies, including label pill and range band. */
export function eventHitInterval(
  event: Event,
  viewport: ViewportState,
): { left: number; right: number } {
  const span = eventSpanAbs(event);
  const x = projectAbs(viewport, span.anchorAbs);
  let left = x - EVENT_MARKER_DOT_OFFSET;
  let right = left + EVENT_MARKER_WIDTH;
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
    const lane = lanes.get(event.id) ?? 0;
    return {
      event,
      lane,
      showBand,
      anchorX: projectAbs(viewport, span.anchorAbs),
      bandLeft: range.left,
      bandWidth: Math.max(8, range.width),
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
