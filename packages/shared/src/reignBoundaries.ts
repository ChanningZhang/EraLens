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

/** @deprecated Wavy edges render per-card from start/end_date_confidence. */
export function isUncertainReignSeam(left: Reign, right: Reign): boolean {
  return (
    isUncertainDateConfidence(left.endDateConfidence) &&
    isUncertainDateConfidence(right.startDateConfidence)
  );
}

function reignEndExclusive(reign: Reign): number {
  return reign.endAbs + 1;
}

function isParallelPair(left: Reign, right: Reign): boolean {
  const leftTrack = claimTrackOf(left);
  const rightTrack = claimTrackOf(right);
  if (leftTrack == null && rightTrack == null) return false;
  return leftTrack !== rightTrack;
}

/** Same-dynasty succession, or cross-dynasty handoff without in-dynasty continuations. */
function isCalendarSeamPair(
  left: Reign,
  right: Reign,
  active: readonly Reign[],
): boolean {
  if (isParallelPair(left, right)) return false;
  if (reignEndExclusive(left) !== right.startAbs) return false;
  if (left.dynastyId === right.dynastyId) return true;

  const leftHasDynastySuccessor = active.some(
    (reign) =>
      reign.id !== left.id &&
      reign.dynastyId === left.dynastyId &&
      reign.startAbs === right.startAbs,
  );
  if (leftHasDynastySuccessor) return false;

  const rightHasDynastyPredecessor = active.some(
    (reign) =>
      reign.id !== right.id &&
      reign.dynastyId === right.dynastyId &&
      reignEndExclusive(reign) === right.startAbs,
  );
  if (rightHasDynastyPredecessor) return false;

  return true;
}

/**
 * Calendar-adjacent reign seams must mark uncertainty on both sides or neither.
 * Skips 亡国留白 (calendar holes) and parallel claim_track rivals.
 */
export function validateReignDateConfidenceSeams(
  reigns: readonly Reign[],
): string[] {
  const active = reigns.filter((reign) => !isSystemMissingReign(reign));
  const errors: string[] = [];

  for (const left of active) {
    const successors = active.filter(
      (right) =>
        right.id !== left.id && isCalendarSeamPair(left, right, active),
    );
    for (const right of successors) {
      const leftUncertain = isUncertainDateConfidence(left.endDateConfidence);
      const rightUncertain = isUncertainDateConfidence(right.startDateConfidence);
      if (leftUncertain === rightUncertain) continue;
      errors.push(
        `${left.id} end (${left.endDateConfidence ?? "certain"}) / ${right.id} start (${right.startDateConfidence ?? "certain"}) mismatch`,
      );
    }
  }

  return errors;
}

/**
 * @deprecated Uncertainty waves render on each reign card edge. Kept for callers/tests.
 */
export function findReignUncertaintyBoundaries(
  _rulers: readonly Reign[],
  _missingReigns: readonly Reign[] = [],
): ReignUncertaintyBoundary[] {
  return [];
}

export function uncertaintyBoundaryTooltip(
  boundary: ReignUncertaintyBoundary,
  rulers: readonly Reign[],
): string {
  const left = rulers.find((r) => r.id === boundary.leftReignId);
  const right = rulers.find((r) => r.id === boundary.rightReignId);
  const confidence =
    left && right && isUncertainReignSeam(left, right)
      ? (left.endDateConfidence ?? right.startDateConfidence)
      : undefined;
  const label = confidence ? DATE_CONFIDENCE_LABEL[confidence] : "年代失考";
  const note =
    boundary.kind === "gap"
      ? "世系连续，在位年为推算值，具体年代不确定"
      : "交界年代为推算值";
  const names = [left?.title, right?.title].filter(Boolean).join(" → ");
  return names ? `${label}\n${note}\n${names}` : `${label}\n${note}`;
}
