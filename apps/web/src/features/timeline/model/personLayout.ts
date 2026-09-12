import type { Person } from "@eralens/shared";
import { personLifeAbs } from "@eralens/shared";
import { projectRange, type ViewportState } from "./coordinates";
import { packEventLanes } from "./eventLayout";

export const PERSON_ROW_TOP = 8;
export const PERSON_ROW_STEP = 28;
export const PERSON_LANE_PAD = 4;
export const PERSON_BAR_HEIGHT = 24;

export type PlacedPerson = {
  person: Person;
  lane: number;
  left: number;
  width: number;
  top: number;
  startAbs: number;
  endAbs: number;
};

export function personHitInterval(
  person: Person,
  viewport: ViewportState,
): { left: number; right: number } | null {
  const life = personLifeAbs(person);
  if (!life) return null;
  const range = projectRange(viewport, life.startAbs, life.endAbs + 1);
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
      const life = personLifeAbs(person);
      const interval = personHitInterval(person, viewport);
      if (!life || !interval) return null;
      return { person, life, interval };
    })
    .filter((entry): entry is NonNullable<typeof entry> => entry !== null);

  const lanes = packEventLanes(
    entries.map((entry) => ({ id: entry.person.id, ...entry.interval })),
  );

  return entries.map((entry) => {
    const range = projectRange(
      viewport,
      entry.life.startAbs,
      entry.life.endAbs + 1,
    );
    const lane = lanes.get(entry.person.id) ?? 0;
    return {
      person: entry.person,
      lane,
      left: range.left,
      width: Math.max(8, range.width),
      top: PERSON_ROW_TOP + lane * PERSON_ROW_STEP,
      startAbs: entry.life.startAbs,
      endAbs: entry.life.endAbs,
    };
  });
}

export function personLaneCount(placed: PlacedPerson[]): number {
  if (placed.length === 0) return 0;
  return Math.max(...placed.map((item) => item.lane)) + 1;
}
