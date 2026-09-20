import {
  groupByClaimTrack,
  isParallelClaim,
  isSystemMissingReign,
  layoutBucketsForLaneReigns,
  reignsInLayoutBucket,
  reignsInSameClaimTrack,
  type DynastyLaneGroup,
  type Reign,
} from "@eralens/shared";

/** Matches `.lane { padding: 8px 0 }` in DynastyLane.module.css. */
export const LANE_PADDING_TOP = 8;
export const LANE_PADDING_Y = LANE_PADDING_TOP * 2;
/** Matches the painted card height so stacked contemporaneous reigns sit flush. */
export const STACK_ROW_HEIGHT = 48;
/** Parallel claimants (`claimTrack` ≠ main) use 2/3 of a normal stack row. */
export const PARALLEL_STACK_ROW_RATIO = 2 / 3;
export const PARALLEL_STACK_ROW_HEIGHT = STACK_ROW_HEIGHT * PARALLEL_STACK_ROW_RATIO;

export type StackedReign = {
  reign: Reign;
  stackIndex: number;
};

export type StackedCardUnit = {
  unitTop: number;
  unitHeight: number;
};

export function stackRowHeightForReign(reign: Pick<Reign, "claimTrack">): number {
  return isParallelClaim(reign) ? PARALLEL_STACK_ROW_HEIGHT : STACK_ROW_HEIGHT;
}

/** Vertical band consumed by one claim track inside a lane bucket. */
function trackBarHeight(trackReigns: readonly Reign[]): number {
  if (trackReigns.some(isParallelClaim)) {
    return PARALLEL_STACK_ROW_HEIGHT;
  }
  const sorted = sortReigns(trackReigns);
  let index = 0;
  while (index < sorted.length) {
    let end = index + 1;
    while (end < sorted.length && sorted[end]!.startAbs === sorted[index]!.startAbs) {
      end += 1;
    }
    if (sameSpanGroup(sorted.slice(index, end))) {
      return STACK_ROW_HEIGHT;
    }
    index = end;
  }
  return STACK_ROW_HEIGHT;
}

function rowOffsetToUnitTop(
  reign: Reign,
  reigns: Reign[],
  laneGroups: readonly DynastyLaneGroup[],
): number {
  const placement = resolveTrackPlacements(reigns, laneGroups).placements.get(reign.id);
  const targetOffset = placement?.rowOffset ?? 0;
  if (targetOffset === 0) return 0;

  const bucket = reignsInLayoutBucket(reign, reigns, laneGroups);
  let top = 0;
  let consumedRows = 0;
  for (const track of groupByClaimTrack(bucket)) {
    const span = trackSubRowCount(track.reigns);
    if (consumedRows >= targetOffset) break;
    if (consumedRows + span <= targetOffset) {
      top += trackBarHeight(track.reigns);
      consumedRows += span;
    }
  }
  return top;
}

/**
 * Per-card vertical placement. Same-start, same-end peers that truly overlap
 * (宋庆龄/董必武共同代行) split one {@link STACK_ROW_HEIGHT} band evenly
 * instead of doubling lane height. Sequential rulers in the same year (哀王→思王)
 * have different end/start abs and stay on one row at full height.
 */
export function resolveStackedCardUnit(
  reign: Reign,
  reigns: Reign[],
  laneGroups: readonly DynastyLaneGroup[] = [],
): StackedCardUnit {
  const { placements } = resolveTrackPlacements(reigns, laneGroups);
  const placement = placements.get(reign.id);
  const trackPeers = placement?.peers ?? trackPeersOf(reign, reigns, laneGroups);
  const trackTop = rowOffsetToUnitTop(reign, reigns, laneGroups);

  const group = sameStartGroup(reign, trackPeers);
  if (sameSpanGroup(group) && !isParallelClaim(reign)) {
    const indexInGroup = group.findIndex((item) => item.id === reign.id);
    const unitHeight = STACK_ROW_HEIGHT / group.length;
    return { unitTop: trackTop + indexInGroup * unitHeight, unitHeight };
  }

  if (isParallelClaim(reign)) {
    return { unitTop: trackTop, unitHeight: PARALLEL_STACK_ROW_HEIGHT };
  }

  return { unitTop: trackTop, unitHeight: STACK_ROW_HEIGHT };
}

export function dynastyBarHeightForReigns(
  reigns: Reign[],
  laneGroups: readonly DynastyLaneGroup[] = [],
): number {
  if (reigns.length === 0) return STACK_ROW_HEIGHT;
  let maxBottom = STACK_ROW_HEIGHT;
  for (const reign of reigns) {
    const { unitTop, unitHeight } = resolveStackedCardUnit(reign, reigns, laneGroups);
    maxBottom = Math.max(maxBottom, unitTop + unitHeight);
  }
  return maxBottom;
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

export function dynastyLaneHeight(
  rowHeights: readonly number[],
  reigns?: Reign[],
  laneGroups: readonly DynastyLaneGroup[] = [],
): number {
  const barHeight =
    reigns != null
      ? dynastyBarHeightForReigns(reigns, laneGroups)
      : dynastyBarHeight(rowHeights);
  return LANE_PADDING_Y + barHeight;
}

export function partitionReignRecords(reigns: readonly Reign[]): {
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
 * Sub-rows needed inside one claim track. Same-start, same-end rulers that
 * truly overlap (副主席共同代行) stack; sequential same-year reigns with
 * different abs bounds stay on one sub-row.
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
function resolveTrackPlacements(
  laneReigns: readonly Reign[],
  laneGroups: readonly DynastyLaneGroup[] = [],
): {
  placements: Map<string, TrackPlacement>;
  rowCount: number;
} {
  const buckets = layoutBucketsForLaneReigns(laneReigns, laneGroups);
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

function trackPeersOf(
  reign: Reign,
  laneReigns: readonly Reign[],
  laneGroups: readonly DynastyLaneGroup[] = [],
): Reign[] {
  const { placements } = resolveTrackPlacements(laneReigns, laneGroups);
  const placement = placements.get(reign.id);
  if (placement) return placement.peers;
  return reignsInSameClaimTrack(reign, reignsInLayoutBucket(reign, laneReigns, laneGroups));
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
  laneGroups: readonly DynastyLaneGroup[] = [],
): { startAbs: number; endExclusive: number; stackIndex: number } {
  const { placements } = resolveTrackPlacements(reigns, laneGroups);
  const placement = placements.get(reign.id);
  const trackPeers = placement?.peers ?? trackPeersOf(reign, reigns, laneGroups);
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

export function assignReignStacks(
  reigns: Reign[],
  laneGroups: readonly DynastyLaneGroup[] = [],
): {
  items: StackedReign[];
  rowCount: number;
  rowHeights: number[];
} {
  const { placements, rowCount } = resolveTrackPlacements(reigns, laneGroups);
  const buckets = layoutBucketsForLaneReigns(reigns, laneGroups);
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
