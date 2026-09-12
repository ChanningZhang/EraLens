import type { Reign } from "@eralens/shared";

/** Group rulers who share a start instant (e.g. 哀王 / 思王 in 441 BCE). */
export function clusterSameStartReigns(reigns: Reign[]): Reign[][] {
  const sorted = [...reigns].sort(
    (a, b) => a.startAbs - b.startAbs || a.endAbs - b.endAbs,
  );
  const clusters: Reign[][] = [];
  for (const reign of sorted) {
    const last = clusters[clusters.length - 1];
    if (last && last[0]!.startAbs === reign.startAbs) {
      last.push(reign);
    } else {
      clusters.push([reign]);
    }
  }
  return clusters;
}

/**
 * Visible interval for a card. Never collapse to empty: a later reign that
 * starts at the same instant must not clip this one to zero width.
 */
export function reignCardSpan(
  startAbs: number,
  endAbs: number,
  nextStartAbs?: number,
): { startAbs: number; endExclusive: number } {
  const naturalEndExclusive = endAbs + 1;
  const endExclusive =
    nextStartAbs !== undefined &&
    nextStartAbs > startAbs &&
    nextStartAbs <= naturalEndExclusive
      ? nextStartAbs
      : naturalEndExclusive;
  return { startAbs, endExclusive };
}
