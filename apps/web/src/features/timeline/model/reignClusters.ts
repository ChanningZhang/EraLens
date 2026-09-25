import {
  buildPreQinClanContext,
  groupByClaimTrack,
  isParallelClaim,
  isSystemMissingReign,
  layoutBucketsForLaneReigns,
  reignVisualBounds,
  reignsInLayoutBucket,
  reignsInSameClaimTrack,
  resolveReignCardLabel,
  resolveReignVisualSpan as resolveSharedReignVisualSpan,
  nextReignOwnershipStartAbs,
  reignsShareExactSpan,
  sameStartReigns,
  sortReignsByCalendar,
  reignCardSpan as sharedReignCardSpan,
  type DynastyLaneGroup,
  type Reign,
} from "@eralens/shared";
import type { ViewportState } from "./coordinates";
import { resolveReignBarLayout, resolveReignCaptionPlacement } from "./lod";

/** Matches `.lane { padding: 6px 0 }` in DynastyLane.module.css. */
export const LANE_PADDING_TOP = 6;
export const LANE_PADDING_Y = LANE_PADDING_TOP * 2;
/** Matches the painted card height so stacked contemporaneous reigns sit flush. */
export const STACK_ROW_HEIGHT = 40;
/** Parallel claimants (`claimTrack` ≠ main) use 2/3 of a normal stack row. */
export const PARALLEL_STACK_ROW_RATIO = 2 / 3;
export const PARALLEL_STACK_ROW_HEIGHT = STACK_ROW_HEIGHT * PARALLEL_STACK_ROW_RATIO;
/** Small visual separation between the main row and parallel claimant rows. */
export const PARALLEL_TRACK_GAP = 4;
/** Matches the caption's 2px offset and 12px × 1.2 line height in ReignCard.module.css. */
const CAPTION_BELOW_EXTENT = 2 + 12 * 1.2;

export type StackedReign = {
  reign: Reign;
  stackIndex: number;
};

export type StackedCardUnit = {
  unitTop: number;
  unitHeight: number;
};

/** Pan-independent card geometry. Build once per lane data revision. */
export type PreparedReignGeometry = StackedCardUnit & {
  startAbs: number;
  endExclusive: number;
  visualStart: number;
  visualEndExclusive: number;
  stackIndex: number;
  rowCount: number;
  overlapsLowerRow: boolean;
};

export function prepareLaneReignGeometry(
  reigns: Reign[],
  laneGroups: readonly DynastyLaneGroup[] = [],
): { items: StackedReign[]; byId: Map<string, PreparedReignGeometry>; barHeight: number; rowCount: number } {
  const { items, rowCount } = assignReignStacks(reigns, laneGroups);
  const spans = new Map(reigns.map((reign) => [reign.id, resolveReignVisualSpan(reign, reigns, laneGroups)]));
  const byId = new Map<string, PreparedReignGeometry>();
  let barHeight = STACK_ROW_HEIGHT;
  for (const { reign } of items) {
    const span = spans.get(reign.id)!;
    const visual = reignVisualBounds(reign, span.startAbs, span.endExclusive);
    const unit = resolveStackedCardUnit(reign, reigns, laneGroups);
    barHeight = Math.max(barHeight, unit.unitTop + unit.unitHeight);
    byId.set(reign.id, {
      ...span,
      ...unit,
      visualStart: visual.start,
      visualEndExclusive: visual.endExclusive,
      rowCount,
      overlapsLowerRow: items.some((item) => {
        if (item.stackIndex <= span.stackIndex) return false;
        const lower = spans.get(item.reign.id)!;
        return lower.startAbs < span.endExclusive && lower.endExclusive > span.startAbs;
      }),
    });
  }
  return { items, byId, barHeight, rowCount };
}

export function stackRowHeightForReign(reign: Pick<Reign, "claimTrack">): number {
  return isParallelClaim(reign) ? PARALLEL_STACK_ROW_HEIGHT : STACK_ROW_HEIGHT;
}

/** Vertical band consumed by one claim track inside a lane bucket. */
function trackBarHeight(trackReigns: readonly Reign[]): number {
  return trackReigns.some(isParallelClaim) ? PARALLEL_STACK_ROW_HEIGHT : STACK_ROW_HEIGHT;
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
  const tracks = groupByClaimTrack(bucket);
  for (let trackIndex = 0; trackIndex < tracks.length; trackIndex += 1) {
    const track = tracks[trackIndex]!;
    const nextTrack = tracks[trackIndex + 1];
    const span = trackSubRowCount(track.reigns);
    if (consumedRows >= targetOffset) break;
    if (consumedRows + span <= targetOffset) {
      top += trackBarHeight(track.reigns);
      if (
        nextTrack &&
        (track.reigns.some(isParallelClaim) || nextTrack.reigns.some(isParallelClaim))
      ) {
        top += PARALLEL_TRACK_GAP;
      }
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

  const group = sameStartReigns(reign, trackPeers);
  if (reignsShareExactSpan(group) && !isParallelClaim(reign)) {
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
    const height = rowHeights[index] ?? STACK_ROW_HEIGHT;
    const nextHeight = rowHeights[index + 1] ?? STACK_ROW_HEIGHT;
    top += height;
    if (height < STACK_ROW_HEIGHT || nextHeight < STACK_ROW_HEIGHT) {
      top += PARALLEL_TRACK_GAP;
    }
  }
  return top;
}

export function dynastyBarHeight(rowHeights: readonly number[]): number {
  if (rowHeights.length === 0) return STACK_ROW_HEIGHT;
  return rowHeights.reduce((sum, height, index) => {
    const nextHeight = rowHeights[index + 1];
    const gap =
      nextHeight !== undefined &&
      (height < STACK_ROW_HEIGHT || nextHeight < STACK_ROW_HEIGHT)
        ? PARALLEL_TRACK_GAP
        : 0;
    return sum + height + gap;
  }, 0);
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

/** Reserve the painted card and any caption hanging below its stack row. */
export function dynastyLaneHeightForViewport(
  reigns: Reign[],
  laneGroups: readonly DynastyLaneGroup[],
  viewport: ViewportState,
  personNames: ReadonlyMap<string, string>,
  personDisplay: ReadonlyMap<string, Parameters<typeof buildPreQinClanContext>[0]>,
): number {
  const barHeight = dynastyBarHeightForReigns(reigns, laneGroups);
  const { items, rowCount } = assignReignStacks(reigns, laneGroups);
  let paintedBottom = barHeight;

  for (const reign of reigns) {
    const { startAbs, endExclusive, stackIndex } = resolveReignVisualSpan(reign, reigns, laneGroups);
    const visual = reignVisualBounds(reign, startAbs, endExclusive);
    const width = Math.max(0, visual.endExclusive - visual.start) * viewport.pxPerMonth;
    const label = resolveReignCardLabel(reign, personNames.get(reign.personId), {
      cardWidthPx: width,
      clan: buildPreQinClanContext(personDisplay.get(reign.personId)),
    });
    if (!resolveReignBarLayout(width, [...label].length).captionBelow) continue;

    const overlapsLowerRow = items.some((item) => {
      if (item.stackIndex <= stackIndex) return false;
      const span = resolveReignVisualSpan(item.reign, reigns, laneGroups);
      return span.startAbs < endExclusive && span.endExclusive > startAbs;
    });
    if (resolveReignCaptionPlacement({ stackIndex, rowCount, overlapsLowerRow }) !== "below") continue;

    const { unitTop, unitHeight } = resolveStackedCardUnit(reign, reigns, laneGroups);
    paintedBottom = Math.max(paintedBottom, unitTop + unitHeight + CAPTION_BELOW_EXTENT);
  }

  return LANE_PADDING_Y + paintedBottom;
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

/**
 * Sub-rows needed inside one claim track. Same-start, same-end rulers that
 * truly overlap (副主席共同代行) stack; sequential same-year reigns with
 * different abs bounds stay on one sub-row.
 */
function trackSubRowCount(trackReigns: readonly Reign[]): number {
  const sorted = sortReignsByCalendar(trackReigns);
  let rowCount = 1;
  let index = 0;
  while (index < sorted.length) {
    const group = sameStartReigns(sorted[index]!, sorted);
    if (reignsShareExactSpan(group)) rowCount = Math.max(rowCount, group.length);
    index += group.length;
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
  const group = sameStartReigns(reign, trackPeers);
  if (!reignsShareExactSpan(group)) return 0;
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
  const span = resolveSharedReignVisualSpan(reign, trackPeers);
  return { ...span, stackIndex: rowOffset + span.stackIndex };
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
      for (const reign of sortReignsByCalendar(lane.reigns)) {
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
  return nextReignOwnershipStartAbs(reign, reigns);
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
  return sharedReignCardSpan(startAbs, endAbs, nextStartAbs);
}
