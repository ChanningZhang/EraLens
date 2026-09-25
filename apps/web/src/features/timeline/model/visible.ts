import {
  eventSpanAbs,
  rangeIntersectsWindow,
  type Dynasty,
  type Event,
  type Reign,
} from "@eralens/shared";
import type { PreparedReignGeometry } from "./reignClusters";

/** Covers the widest caption and hit target before a card enters the viewport. */
export function cardOverscanMonths(pxPerMonth: number): number {
  return Math.max(120, 180 / pxPerMonth);
}

export function filterVisibleCardReigns(
  reigns: readonly Reign[],
  geometry: ReadonlyMap<string, PreparedReignGeometry>,
  startAbs: number,
  endAbs: number,
  pxPerMonth: number,
): Reign[] {
  const buffer = cardOverscanMonths(pxPerMonth);
  return reigns.filter((reign) => {
    const prepared = geometry.get(reign.id);
    if (!prepared) return false;
    return prepared.visualStart < endAbs + buffer && prepared.visualEndExclusive > startAbs - buffer;
  });
}

export function filterVisibleGapReigns(
  reigns: readonly Reign[],
  startAbs: number,
  endAbs: number,
  pxPerMonth: number,
): Reign[] {
  const buffer = cardOverscanMonths(pxPerMonth);
  return reigns.filter((reign) => reign.startAbs < endAbs + buffer && reign.endAbs + 1 > startAbs - buffer);
}

export function filterVisiblePlacedPersons<T extends { left: number; width: number }>(
  placed: readonly T[],
  widthPx: number,
  gutterPx: number,
): T[] {
  return placed.filter(({ left, width }) => left <= widthPx + 180 && left + width >= gutterPx - 180);
}

export function filterVisibleDynasties(
  dynasties: Dynasty[],
  startAbs: number,
  endAbs: number,
): Dynasty[] {
  return dynasties.filter((d) => rangeIntersectsWindow(d.startAbs, d.endAbs, startAbs, endAbs));
}

export function filterVisibleReigns(
  reigns: Reign[],
  dynastyIds: Set<string>,
  startAbs: number,
  endAbs: number,
): Reign[] {
  return reigns.filter(
    (r) =>
      dynastyIds.has(r.dynastyId) &&
      rangeIntersectsWindow(r.startAbs, r.endAbs, startAbs, endAbs),
  );
}

export function filterVisibleEvents(
  events: Event[],
  startAbs: number,
  endAbs: number,
): Event[] {
  return events.filter((e) => {
    const span = eventSpanAbs(e);
    return rangeIntersectsWindow(span.startAbs, span.endAbs, startAbs, endAbs);
  });
}

export function expandWindow(startAbs: number, endAbs: number, bufferMonths: number) {
  return {
    startAbs: startAbs - bufferMonths,
    endAbs: endAbs + bufferMonths,
  };
}
