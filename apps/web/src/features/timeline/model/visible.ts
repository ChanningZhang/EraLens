import {
  eventSpanAbs,
  rangeIntersectsWindow,
  type Dynasty,
  type Event,
  type Reign,
} from "@eralens/shared";

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
