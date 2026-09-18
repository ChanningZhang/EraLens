import {
  groupByClaimTrack,
  isParallelClaim,
  isSystemMissingReign,
  layoutBucketsForLaneReigns,
  reignsInLayoutBucket,
  reignsInSameClaimTrack,
  type Reign,
} from "@eralens/shared";

export const LANE_PADDING_Y = 16;
/** Matches the painted card height so stacked contemporaneous reigns sit flush. */
export const STACK_ROW_HEIGHT = 48;
/** Parallel claimants (`claimTrack` ≠ main) use 2/3 of a normal stack row. */
export const PARALLEL_STACK_ROW_RATIO = 2 / 3;
export const PARALLEL_STACK_ROW_HEIGHT = STACK_ROW_HEIGHT * PARALLEL_STACK_ROW_RATIO;

export type StackedReign = {
  reign: Reign;
  stackIndex: number;
};

export function stackRowHeightForReign(reign: Pick<Reign, "claimTrack">): number {
  return isParallelClaim(reign) ? PARALLEL_STACK_ROW_HEIGHT : STACK_ROW_HEIGHT;
}

export function stackRowHeights(
  items: readonly StackedReign[],
  rowCount: number,
): number[] {
  const heights = Array.from(
    { length: Math.max(1, rowCount) },
    () => STACK_ROW_HEIGHT,
  );
  for (const item of items) {
    if (item.stackIndex < 0 || item.stackIndex >= heights.length) continue;
    heights[item.stackIndex] = stackRowHeightForReign(item.reign);
  }
  return heights;
}

export function stackRowOffset(
  rowHeights: readonly number[],
  stackIndex: number,
): number {
  let top = 0;
  for (let index = 0; index < stackIndex; index += 1) {
    top += rowHeights[index] ?? STACK_ROW_HEIGHT;
  }
  return top;
}

export function dynastyBarHeight(rowHeights: readonly number[]): number {
  if (rowHeights.length === 0) return STACK_ROW_HEIGHT;
  return rowHeights.reduce((sum, height) => sum + height, 0);
}

export function dynastyLaneHeight(rowHeights: readonly number[]): number {
  return LANE_PADDING_Y + dynastyBarHeight(rowHeights);
}

export function partitionReignRecords(reigns: Reign[]): {
  rulers: Reign[];
  missing: Reign[];
} {
  return {
    rulers: reigns.filter((reign) => !isSystemMissingReign(reign)),
    missing: reigns.filter(isSystemMissingReign),
  };
}

function sortReigns(reigns: readonly Reign[]): Reign[] {
  return [...reigns].sort(
    (a, b) => a.startAbs - b.startAbs || a.endAbs - b.endAbs || a.id.localeCompare(b.id),
  );
}

function sameStartGroup(reign: Reign, reigns: readonly Reign[]): Reign[] {
  return sortReigns(reigns).filter((item) => item.startAbs === reign.startAbs);
}

function sameSpanGroup(group: Reign[]): boolean {
  return group.length > 1 && group.every((item) => item.endAbs === group[0]!.endAbs);
}

/**
 * Sub-rows needed inside one claim track. Same-start, same-end rulers (哀王 /
 * 思王) cannot be split by calendar month, so they stack; everything else
 * sequences on a single sub-row.
 */
function trackSubRowCount(trackReigns: readonly Reign[]): number {
  const sorted = sortReigns(trackReigns);
  let rowCount = 1;
  let index = 0;
  while (index < sorted.length) {
    let end = index + 1;
    while (end < sorted.length && sorted[end]!.startAbs === sorted[index]!.startAbs) {
      end += 1;
    }
    const group = sorted.slice(index, end);
    if (sameSpanGroup(group)) rowCount = Math.max(rowCount, group.length);
    index = end;
  }
  return rowCount;
}

type TrackPlacement = {
  /** First lane row occupied by the reign's claim track. */
  rowOffset: number;
  /** Reigns sharing the same dynasty phase *and* claim track. */
  peers: Reign[];
};

/**
 * Row offsets for every reign in a lane. Dynasty phases (西周 / 东周) keep their
 * independent buckets; inside a bucket each claim track gets its own rows so
 * concurrent claimants (隋末三帝, 南明鲁监国 / 绍武) render side by side.
 */
function resolveTrackPlacements(laneReigns: readonly Reign[]): {
  placements: Map<string, TrackPlacement>;
  rowCount: number;
} {
  const buckets = layoutBucketsForLaneReigns(laneReigns);
  const effectiveBuckets = buckets.length > 0 ? buckets : [[...laneReigns]];
  const placements = new Map<string, TrackPlacement>();
  let rowCount = 1;

  for (const bucket of effectiveBuckets) {
    let rowOffset = 0;
    for (const lane of groupByClaimTrack(bucket)) {
      for (const reign of lane.reigns) {
        placements.set(reign.id, { rowOffset, peers: lane.reigns });
      }
      rowOffset += trackSubRowCount(lane.reigns);
    }
    rowCount = Math.max(rowCount, rowOffset);
  }

  return { placements, rowCount };
}

function trackPeersOf(reign: Reign, laneReigns: readonly Reign[]): Reign[] {
  const { placements } = resolveTrackPlacements(laneReigns);
  const placement = placements.get(reign.id);
  if (placement) return placement.peers;
  return reignsInSameClaimTrack(reign, reignsInLayoutBucket(reign, laneReigns));
}

function subStackIndexOf(reign: Reign, trackPeers: readonly Reign[]): number {
  const group = sameStartGroup(reign, trackPeers);
  if (!sameSpanGroup(group)) return 0;
  return Math.max(0, group.findIndex((item) => item.id === reign.id));
}

/**
 * Visible span and lane row for a card. Sequential clipping only considers
 * peers on the same claim track, so a rival claimant never truncates the main
 * line's card.
 */
export function resolveReignVisualSpan(
  reign: Reign,
  reigns: Reign[],
): { startAbs: number; endExclusive: number; stackIndex: number } {
  const { placements } = resolveTrackPlacements(reigns);
  const placement = placements.get(reign.id);
  const trackPeers = placement?.peers ?? trackPeersOf(reign, reigns);
  const rowOffset = placement?.rowOffset ?? 0;
  const group = sameStartGroup(reign, trackPeers);
  const nextLater = nextLaterStartAbs(reign, trackPeers);

  if (sameSpanGroup(group)) {
    const stackIndex = group.findIndex((item) => item.id === reign.id);
    const { endExclusive } = reignCardSpan(reign.startAbs, reign.endAbs, nextLater);
    return {
      startAbs: reign.startAbs,
      endExclusive,
      stackIndex: rowOffset + Math.max(0, stackIndex),
    };
  }

  const ordered = [...group].sort(
    (a, b) => a.endAbs - b.endAbs || a.id.localeCompare(b.id),
  );
  const index = ordered.findIndex((item) => item.id === reign.id);
  const visualStart =
    index <= 0 ? reign.startAbs : ordered[index - 1]!.endAbs + 1;
  const { endExclusive } = reignCardSpan(visualStart, reign.endAbs, nextLater);
  return { startAbs: visualStart, endExclusive, stackIndex: rowOffset };
}

export function assignReignStacks(reigns: Reign[]): {
  items: StackedReign[];
  rowCount: number;
  rowHeights: number[];
} {
  const { placements, rowCount } = resolveTrackPlacements(reigns);
  const buckets = layoutBucketsForLaneReigns(reigns);
  const effectiveBuckets = buckets.length > 0 ? buckets : [[...reigns]];
  const items: StackedReign[] = [];

  for (const bucket of effectiveBuckets) {
    for (const lane of groupByClaimTrack(bucket)) {
      for (const reign of sortReigns(lane.reigns)) {
        const rowOffset = placements.get(reign.id)?.rowOffset ?? 0;
        items.push({
          reign,
          stackIndex: rowOffset + subStackIndexOf(reign, lane.reigns),
        });
      }
    }
  }

  return { items, rowCount, rowHeights: stackRowHeights(items, rowCount) };
}

export function nextLaterStartAbs(
  reign: Reign,
  reigns: readonly Reign[],
): number | undefined {
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
