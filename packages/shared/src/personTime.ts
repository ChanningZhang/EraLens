import type { Person } from "./schema";
import { absFromPoint, rangeIntersectsWindow } from "./time";

export type PersonLifeSpan = {
  startAbs: number;
  endAbs: number;
};

export type PersonPointKind = "birth" | "death";

export type PersonTimelinePlacement =
  | {
      mode: "span";
      startAbs: number;
      endAbs: number;
      anchorAbs: number;
    }
  | {
      mode: "point";
      anchorAbs: number;
      pointKind: PersonPointKind;
    };

/** Full lifespan bar when both birth and death are known. */
export function personLifeAbs(person: Person): PersonLifeSpan | null {
  const placement = personTimelinePlacement(person);
  if (!placement || placement.mode !== "span") return null;
  return { startAbs: placement.startAbs, endAbs: placement.endAbs };
}

/**
 * Timeline placement for a non-reign person.
 * - both dates → span bar
 * - only birth or death → point marker at that date
 * - neither → not placeable
 */
export function personTimelinePlacement(
  person: Person,
): PersonTimelinePlacement | null {
  if (person.birth && person.death) {
    const startAbs = absFromPoint(person.birth);
    const endAbs = Math.max(startAbs, absFromPoint(person.death));
    return { mode: "span", startAbs, endAbs, anchorAbs: startAbs };
  }
  if (person.birth) {
    return {
      mode: "point",
      anchorAbs: absFromPoint(person.birth),
      pointKind: "birth",
    };
  }
  if (person.death) {
    return {
      mode: "point",
      anchorAbs: absFromPoint(person.death),
      pointKind: "death",
    };
  }
  return null;
}

/** Window used for viewport intersection tests. */
export function personPlacementWindow(
  placement: PersonTimelinePlacement,
): PersonLifeSpan {
  if (placement.mode === "span") {
    return { startAbs: placement.startAbs, endAbs: placement.endAbs };
  }
  return { startAbs: placement.anchorAbs, endAbs: placement.anchorAbs };
}

/** True when a non-reign person has a placeable birth/death in the abs window. */
export function personIntersectsAbsWindow(
  person: Person,
  fromAbs: number,
  toAbs: number,
): boolean {
  const placement = personTimelinePlacement(person);
  if (!placement) return false;
  const window = personPlacementWindow(placement);
  return rangeIntersectsWindow(window.startAbs, window.endAbs, fromAbs, toAbs);
}

export function personPointKindLabel(kind: PersonPointKind): string {
  return kind === "birth" ? "生" : "卒";
}
