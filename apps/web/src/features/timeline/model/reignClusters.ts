import type { Reign } from "@eralens/shared";

export const LANE_PADDING_Y = 16;
export const STACK_ROW_HEIGHT = 56;

export function dynastyLaneHeight(rowCount: number): number {
  return LANE_PADDING_Y + Math.max(1, rowCount) * STACK_ROW_HEIGHT;
}

export type StackedReign = {
  reign: Reign;
  stackIndex: number;
};

function sortReigns(reigns: Reign[]): Reign[] {
  return [...reigns].sort(
    (a, b) => a.startAbs - b.startAbs || a.endAbs - b.endAbs || a.id.localeCompare(b.id),
  );
}

/**
 * Same-start rulers (哀王 / 思王) cannot be split by calendar month, so they
 * occupy stacked rows instead of overlapping on one card.
 */
export function assignReignStacks(reigns: Reign[]): {
  items: StackedReign[];
  rowCount: number;
} {
  const sorted = sortReigns(reigns);
  const items: StackedReign[] = [];
  let rowCount = 1;
  let index = 0;
  while (index < sorted.length) {
    let end = index + 1;
    while (end < sorted.length && sorted[end]!.startAbs === sorted[index]!.startAbs) {
      end += 1;
    }
    const groupSize = end - index;
    rowCount = Math.max(rowCount, groupSize);
    for (let offset = 0; offset < groupSize; offset += 1) {
      items.push({ reign: sorted[index + offset]!, stackIndex: offset });
    }
    index = end;
  }
  return { items, rowCount };
}

export function nextLaterStartAbs(reign: Reign, reigns: Reign[]): number | undefined {
  const sorted = sortReigns(reigns);
  return sorted.find((item) => item.startAbs > reign.startAbs)?.startAbs;
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
