import { claimTrackOf, groupByClaimTrack } from "./claimTracks";
import type { Reign } from "./schema";
import { isSystemMissingReign } from "./systemReigns";

/**
 * How trustworthy a reign boundary date is.
 *
 * - `certain` — documented anchor (default when omitted)
 * - `approximate` — scholarly estimate with some external support
 * - `interpolated` — filled algorithmically between anchors (e.g. early Zhou gaps)
 */
export type DateConfidence = "certain" | "approximate" | "interpolated";

export const DATE_CONFIDENCE_LABEL: Record<DateConfidence, string> = {
  certain: "有年表依据",
  approximate: "年代约数",
  interpolated: "年代推算",
};

export type ReignUncertaintyBoundaryKind = "gap" | "junction";

/** Visual decoration between two reign cards whose dating is uncertain at the seam. */
export type ReignUncertaintyBoundary = {
  id: string;
  kind: ReignUncertaintyBoundaryKind;
  stackIndex: number;
  /** Inclusive abs month at the left wavy edge. */
  startAbs: number;
  /** Inclusive abs month at the right wavy edge. */
  endAbs: number;
  leftReignId: string;
  rightReignId: string;
};

export function isUncertainDateConfidence(
  confidence?: DateConfidence | null,
): boolean {
  return confidence === "approximate" || confidence === "interpolated";
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

function nextLaterStartAbs(reign: Reign, reigns: readonly Reign[]): number | undefined {
  return sortReigns(reigns).find((item) => item.startAbs > reign.startAbs)?.startAbs;
}

function reignCardSpan(startAbs: number, endAbs: number, nextStartAbs?: number) {
  const naturalEndExclusive = endAbs + 1;
  const endExclusive =
    nextStartAbs !== undefined &&
    nextStartAbs > startAbs &&
    nextStartAbs <= naturalEndExclusive
      ? nextStartAbs
      : naturalEndExclusive;
  return { startAbs, endExclusive };
}

/** Mirror apps/web reignClusters — keep card layout in sync with the timeline UI. */
export function resolveReignVisualSpan(
  reign: Reign,
  reigns: readonly Reign[],
): { startAbs: number; endExclusive: number; stackIndex: number } {
  const trackPeers = reigns.filter((item) => claimTrackOf(item) === claimTrackOf(reign));
  const group = sameStartGroup(reign, trackPeers);
  const nextLater = nextLaterStartAbs(reign, trackPeers);

  if (sameSpanGroup(group)) {
    const stackIndex = group.findIndex((item) => item.id === reign.id);
    const { endExclusive } = reignCardSpan(reign.startAbs, reign.endAbs, nextLater);
    return { startAbs: reign.startAbs, endExclusive, stackIndex: Math.max(0, stackIndex) };
  }

  const ordered = [...group].sort(
    (a, b) => a.endAbs - b.endAbs || a.id.localeCompare(b.id),
  );
  const index = ordered.findIndex((item) => item.id === reign.id);
  const visualStart =
    index <= 0 ? reign.startAbs : ordered[index - 1]!.endAbs + 1;
  const { endExclusive } = reignCardSpan(visualStart, reign.endAbs, nextLater);
  return { startAbs: visualStart, endExclusive, stackIndex: 0 };
}

type StackedReign = { reign: Reign; stackIndex: number };

function assignReignStacksInTrack(trackReigns: readonly Reign[]): {
  items: StackedReign[];
  rowCount: number;
} {
  const sorted = sortReigns(trackReigns);
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
      const { stackIndex } = resolveReignVisualSpan(reign, trackReigns);
      items.push({ reign, stackIndex });
    }
    index = end;
  }
  return { items, rowCount };
}

function assignReignStacks(reigns: readonly Reign[]): {
  items: StackedReign[];
  rowCount: number;
} {
  const items: StackedReign[] = [];
  let rowCount = 1;
  let rowOffset = 0;
  for (const lane of groupByClaimTrack(reigns)) {
    const trackLayout = assignReignStacksInTrack(lane.reigns);
    for (const item of trackLayout.items) {
      items.push({ reign: item.reign, stackIndex: rowOffset + item.stackIndex });
    }
    rowOffset += trackLayout.rowCount;
    rowCount = Math.max(rowCount, rowOffset);
  }
  return { items, rowCount };
}

type VisualInterval = {
  startAbs: number;
  endExclusive: number;
  reignId: string;
  stackIndex: number;
};

function mergeIntervals(intervals: VisualInterval[]): VisualInterval[] {
  const sorted = [...intervals].sort((a, b) => a.startAbs - b.startAbs);
  const merged: VisualInterval[] = [];
  for (const interval of sorted) {
    const last = merged.at(-1);
    if (!last || interval.startAbs >= last.endExclusive) {
      merged.push({ ...interval });
      continue;
    }
    last.endExclusive = Math.max(last.endExclusive, interval.endExclusive);
  }
  return merged;
}

function spansOverlap(
  startAbs: number,
  endAbs: number,
  otherStart: number,
  otherEnd: number,
): boolean {
  return startAbs <= otherEnd && endAbs >= otherStart;
}

function missingCoversGap(
  missingReigns: readonly Reign[],
  gapStart: number,
  gapEnd: number,
): boolean {
  return missingReigns.some((gap) =>
    spansOverlap(gapStart, gapEnd, gap.startAbs, gap.endAbs),
  );
}

/** Wavy seams only when both sides agree the junction year is uncertain. */
export function isUncertainReignSeam(left: Reign, right: Reign): boolean {
  return (
    isUncertainDateConfidence(left.endDateConfidence) &&
    isUncertainDateConfidence(right.startDateConfidence)
  );
}

function boundaryConfidenceAtSeam(
  left: Reign,
  right: Reign,
): DateConfidence | undefined {
  if (!isUncertainReignSeam(left, right)) return undefined;
  return left.endDateConfidence ?? right.startDateConfidence;
}

/**
 * Locate reign seams that should show the wavy "年代失考" treatment.
 *
 * Only **junction** — two cards touch and **both** sides mark the seam year uncertain.
 * Calendar holes (亡国、留白) never get wavy lines even if nearby reigns are
 * interpolated; 史料缺 keeps the dashed card.
 */
export function findReignUncertaintyBoundaries(
  rulers: readonly Reign[],
  missingReigns: readonly Reign[] = [],
): ReignUncertaintyBoundary[] {
  const activeRulers = rulers.filter((reign) => !isSystemMissingReign(reign));
  if (activeRulers.length < 2) return [];

  const { items, rowCount } = assignReignStacks(activeRulers);
  const boundaries: ReignUncertaintyBoundary[] = [];

  for (let row = 0; row < rowCount; row += 1) {
    const rowItems = items.filter((item) => item.stackIndex === row);
    const intervals: VisualInterval[] = rowItems.map(({ reign, stackIndex }) => {
      const span = resolveReignVisualSpan(reign, activeRulers);
      return {
        startAbs: span.startAbs,
        endExclusive: span.endExclusive,
        reignId: reign.id,
        stackIndex,
      };
    });
    const merged = mergeIntervals(intervals);

    for (let i = 0; i < merged.length - 1; i += 1) {
      const left = merged[i]!;
      const right = merged[i + 1]!;
      const gapStart = left.endExclusive;
      const gapEnd = right.startAbs - 1;
      const gapMonths = gapEnd - gapStart + 1;

      const leftReign = activeRulers.find((r) => r.id === left.reignId)!;
      const rightReign = activeRulers.find((r) => r.id === right.reignId)!;
      const confidence = boundaryConfidenceAtSeam(leftReign, rightReign);

      if (!confidence) continue;
      if (gapMonths > 0) continue;
      if (missingCoversGap(missingReigns, gapStart, gapEnd)) continue;

      const seamAbs = Math.max(left.endExclusive - 1, right.startAbs);
      boundaries.push({
        id: `uncertain-junction-${left.reignId}-${right.reignId}`,
        kind: "junction",
        stackIndex: row,
        startAbs: seamAbs,
        endAbs: seamAbs,
        leftReignId: left.reignId,
        rightReignId: right.reignId,
      });
    }
  }

  return boundaries;
}

export function uncertaintyBoundaryTooltip(
  boundary: ReignUncertaintyBoundary,
  rulers: readonly Reign[],
): string {
  const left = rulers.find((r) => r.id === boundary.leftReignId);
  const right = rulers.find((r) => r.id === boundary.rightReignId);
  const confidence =
    left && right ? boundaryConfidenceAtSeam(left, right) : undefined;
  const label = confidence ? DATE_CONFIDENCE_LABEL[confidence] : "年代失考";
  const note =
    boundary.kind === "gap"
      ? "世系连续，在位年为推算值，具体年代不确定"
      : "交界年代为推算值";
  const names = [left?.title, right?.title].filter(Boolean).join(" → ");
  return names ? `${label}\n${note}\n${names}` : `${label}\n${note}`;
}
