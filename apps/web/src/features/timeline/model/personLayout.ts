import type { Person } from "@eralens/shared";
import {
  personPlacementWindow,
  personTimelinePlacement,
} from "@eralens/shared";
import { projectAbs, projectRange, type ViewportState } from "./coordinates";
import {
  EVENT_MARKER_DOT_OFFSET,
  EVENT_MARKER_WIDTH,
  packEventLanes,
} from "./eventLayout";

export const PERSON_LAYER_GAP = 12;
/**
 * People sit on lightweight life-lines rather than full-height cards.  Keeping
 * the rows close makes a busy historical period readable without turning the
 * map into a stack of opaque bands.
 */
export const PERSON_ROW_TOP = 12;
export const PERSON_ROW_STEP = 22;
export const PERSON_LANE_PAD = 4;
export const PERSON_BAR_HEIGHT = 18;
export const PERSON_LAYER_BOTTOM_PAD = 10;

export type PlacedPerson = {
  person: Person;
  lane: number;
  top: number;
  mode: "span" | "point";
  left: number;
  width: number;
  startAbs: number;
  endAbs: number;
  anchorX?: number;
  pointKind?: "birth" | "death";
};

export function personHitInterval(
  person: Person,
  viewport: ViewportState,
): { left: number; right: number } | null {
  const placement = personTimelinePlacement(person);
  if (!placement) return null;

  if (placement.mode === "point") {
    const x = projectAbs(viewport, placement.anchorAbs);
    const left = x - EVENT_MARKER_DOT_OFFSET;
    const right = left + EVENT_MARKER_WIDTH;
    return {
      left: left - PERSON_LANE_PAD,
      right: right + PERSON_LANE_PAD,
    };
  }

  const window = personPlacementWindow(placement);
  const range = projectRange(viewport, window.startAbs, window.endAbs + 1);
  return {
    left: range.left - PERSON_LANE_PAD,
    right: range.left + range.width + PERSON_LANE_PAD,
  };
}

export function layoutPersons(
  persons: Person[],
  viewport: ViewportState,
): PlacedPerson[] {
  const entries = persons
    .map((person) => {
      const placement = personTimelinePlacement(person);
      const interval = personHitInterval(person, viewport);
      if (!placement || !interval) return null;
      return { person, placement, interval };
    })
    .filter((entry): entry is NonNullable<typeof entry> => entry !== null);

  const lanes = packEventLanes(
    entries.map((entry) => ({ id: entry.person.id, ...entry.interval })),
  );

  return entries.map((entry) => {
    const lane = lanes.get(entry.person.id) ?? 0;
    const top = PERSON_ROW_TOP + lane * PERSON_ROW_STEP;

    if (entry.placement.mode === "point") {
      const anchorX = projectAbs(viewport, entry.placement.anchorAbs);
      return {
        person: entry.person,
        lane,
        top,
        mode: "point",
        left: anchorX,
        width: EVENT_MARKER_WIDTH,
        startAbs: entry.placement.anchorAbs,
        endAbs: entry.placement.anchorAbs,
        anchorX,
        pointKind: entry.placement.pointKind,
      };
    }

    const range = projectRange(
      viewport,
      entry.placement.startAbs,
      entry.placement.endAbs + 1,
    );
    return {
      person: entry.person,
      lane,
      top,
      mode: "span",
      left: range.left,
      width: Math.max(8, range.width),
      startAbs: entry.placement.startAbs,
      endAbs: entry.placement.endAbs,
    };
  });
}

export function personLaneCount(placed: PlacedPerson[]): number {
  if (placed.length === 0) return 0;
  return Math.max(...placed.map((item) => item.lane)) + 1;
}

export function personLayerHeight(placed: PlacedPerson[]): number {
  const laneCount = personLaneCount(placed);
  if (laneCount === 0) return 0;
  return (
    PERSON_ROW_TOP +
    (laneCount - 1) * PERSON_ROW_STEP +
    PERSON_BAR_HEIGHT +
    PERSON_LAYER_BOTTOM_PAD
  );
}
