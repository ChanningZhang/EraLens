import {
  isSystemMissingReign,
  layoutBucketsForLaneReigns,
  reignsInLayoutBucket,
  type Reign,
} from "@eralens/shared";

export const LANE_PADDING_Y = 16;
export const STACK_ROW_HEIGHT = 56;

export function dynastyLaneHeight(rowCount: number): number {
  return LANE_PADDING_Y + Math.max(1, rowCount) * STACK_ROW_HEIGHT;
}

export type StackedReign = {
  reign: Reign;
  stackIndex: number;
};

export function partitionReignRecords(reigns: Reign[]): {
  rulers: Reign[];
  missing: Reign[];
} {
  return {
    rulers: reigns.filter((reign) => !isSystemMissingReign(reign)),
    missing: reigns.filter(isSystemMissingReign),
  };
}

function sortReigns(reigns: Reign[]): Reign[] {
  return [...reigns].sort(
    (a, b) => a.startAbs - b.startAbs || a.endAbs - b.endAbs || a.id.localeCompare(b.id),
  );
}

function sameStartGroup(reign: Reign, reigns: Reign[]): Reign[] {
  return sortReigns(reigns).filter((item) => item.startAbs === reign.startAbs);
}

function sameSpanGroup(group: Reign[]): boolean {
  return group.length > 1 && group.every((item) => item.endAbs === group[0]!.endAbs);
}

/**
 * Same-start, same-end rulers (哀王 / 思王) cannot be split by calendar month,
 * so they occupy stacked rows. Same-start rulers with different end years are
 * laid out sequentially on one row (郑昭公忽 / 郑厉公突).
 */
export function resolveReignVisualSpan(
  reign: Reign,
  reigns: Reign[],
): { startAbs: number; endExclusive: number; stackIndex: number } {
  const layoutReigns = reignsInLayoutBucket(reign, reigns);
  const group = sameStartGroup(reign, layoutReigns);
  const nextLater = nextLaterStartAbs(reign, layoutReigns);

  if (sameSpanGroup(group)) {
    const stackIndex = group.findIndex((item) => item.id === reign.id);
    const { endExclusive } = reignCardSpan(reign.startAbs, reign.endAbs, nextLater);
    return { startAbs: reign.startAbs, endExclusive, stackIndex };
  }

  const ordered = [...group].sort(
    (a, b) => a.endAbs - b.endAbs || a.id.localeCompare(b.id),
  );
  const index = ordered.findIndex((item) => item.id === reign.id);
  const visualStart =
    index === 0 ? reign.startAbs : ordered[index - 1]!.endAbs + 1;
  const { endExclusive } = reignCardSpan(visualStart, reign.endAbs, nextLater);
  return { startAbs: visualStart, endExclusive, stackIndex: 0 };
}

function assignReignStacksInBucket(reigns: Reign[]): {
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
    const group = sorted.slice(index, end);
    const groupSize = sameSpanGroup(group) ? group.length : 1;
    rowCount = Math.max(rowCount, groupSize);
    for (const reign of group) {
      const { stackIndex } = resolveReignVisualSpan(reign, reigns);
      items.push({ reign, stackIndex });
    }
    index = end;
  }
  return { items, rowCount };
}

export function assignReignStacks(reigns: Reign[]): {
  items: StackedReign[];
  rowCount: number;
} {
  const buckets = layoutBucketsForLaneReigns(reigns);
  if (buckets.length <= 1) {
    return assignReignStacksInBucket(reigns);
  }

  const items: StackedReign[] = [];
  let rowCount = 1;
  for (const bucket of buckets) {
    const bucketLayout = assignReignStacksInBucket(bucket);
    items.push(...bucketLayout.items);
    rowCount = Math.max(rowCount, bucketLayout.rowCount);
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
