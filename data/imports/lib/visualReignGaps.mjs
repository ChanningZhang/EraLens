/**
 * Mirror apps/web/src/features/timeline/model/reignClusters.ts visual span logic
 * so import SQL can insert missing placeholders for holes the UI actually shows.
 */

const MAIN_CLAIM_TRACK = "main";

function claimTrackOf(reign) {
  return reign.claimTrack ?? MAIN_CLAIM_TRACK;
}

function earliestStart(reigns) {
  return reigns.reduce((min, reign) => Math.min(min, reign.startAbs), Infinity);
}

function groupByClaimTrack(reigns) {
  const byTrack = new Map();
  for (const reign of reigns) {
    const track = claimTrackOf(reign);
    const list = byTrack.get(track);
    if (list) list.push(reign);
    else byTrack.set(track, [reign]);
  }

  const mainReigns = byTrack.get(MAIN_CLAIM_TRACK);
  byTrack.delete(MAIN_CLAIM_TRACK);

  const rivals = [...byTrack.entries()]
    .map(([track, list]) => ({ track, reigns: list }))
    .sort(
      (a, b) =>
        earliestStart(a.reigns) - earliestStart(b.reigns) ||
        a.track.localeCompare(b.track),
    );

  return mainReigns?.length
    ? [{ track: MAIN_CLAIM_TRACK, reigns: mainReigns }, ...rivals]
    : rivals;
}

function sortReigns(reigns) {
  return [...reigns].sort(
    (a, b) => a.startAbs - b.startAbs || a.endAbs - b.endAbs || a.id.localeCompare(b.id),
  );
}

function sameStartGroup(reign, reigns) {
  return sortReigns(reigns).filter((item) => item.startAbs === reign.startAbs);
}

function sameSpanGroup(group) {
  return group.length > 1 && group.every((item) => item.endAbs === group[0].endAbs);
}

function nextLaterStartAbs(reign, reigns) {
  return sortReigns(reigns).find((item) => item.startAbs > reign.startAbs)?.startAbs;
}

function reignCardSpan(startAbs, endAbs, nextStartAbs) {
  const naturalEndExclusive = endAbs + 1;
  const endExclusive =
    nextStartAbs !== undefined &&
    nextStartAbs > startAbs &&
    nextStartAbs <= naturalEndExclusive
      ? nextStartAbs
      : naturalEndExclusive;
  return { startAbs, endExclusive };
}

function resolveReignVisualSpan(reign, reigns) {
  const peers = reigns.filter((item) => claimTrackOf(item) === claimTrackOf(reign));
  const group = sameStartGroup(reign, peers);
  const nextLater = nextLaterStartAbs(reign, peers);

  if (sameSpanGroup(group)) {
    const stackIndex = group.findIndex((item) => item.id === reign.id);
    const { endExclusive } = reignCardSpan(reign.startAbs, reign.endAbs, nextLater);
    return { startAbs: reign.startAbs, endExclusive, stackIndex };
  }

  const ordered = [...group].sort(
    (a, b) => a.endAbs - b.endAbs || a.id.localeCompare(b.id),
  );
  const index = ordered.findIndex((item) => item.id === reign.id);
  const visualStart = index === 0 ? reign.startAbs : ordered[index - 1].endAbs + 1;
  const { endExclusive } = reignCardSpan(visualStart, reign.endAbs, nextLater);
  return { startAbs: visualStart, endExclusive, stackIndex: 0 };
}

function assignReignStacksInTrack(trackReigns) {
  const sorted = sortReigns(trackReigns);
  const items = [];
  let rowCount = 1;
  let index = 0;
  while (index < sorted.length) {
    let end = index + 1;
    while (end < sorted.length && sorted[end].startAbs === sorted[index].startAbs) {
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

function assignReignStacks(reigns) {
  const items = [];
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

function mergeIntervals(intervals) {
  const sorted = [...intervals].sort((a, b) => a.startAbs - b.startAbs);
  const merged = [];
  for (const interval of sorted) {
    const last = merged.at(-1);
    if (!last || interval.startAbs >= last.endExclusive) {
      merged.push({ ...interval });
      continue;
    }
    last.endExclusive = Math.max(last.endExclusive, interval.endExclusive);
    last.dynastyId = last.dynastyId ?? interval.dynastyId;
  }
  return merged;
}

/**
 * Find holes on each stack row after applying the same card layout as the timeline UI.
 */
export function findVisualLaneGaps(reigns, { minGapMonths = 12 } = {}) {
  if (reigns.length === 0) return [];

  const { items, rowCount } = assignReignStacks(reigns);
  const gaps = [];

  for (let row = 0; row < rowCount; row += 1) {
    const rowItems = items.filter((item) => item.stackIndex === row);
    const intervals = rowItems.map(({ reign }) => {
      const span = resolveReignVisualSpan(reign, reigns);
      return {
        startAbs: span.startAbs,
        endExclusive: span.endExclusive,
        dynastyId: reign.dynastyId,
      };
    });
    const merged = mergeIntervals(intervals);
    for (let i = 0; i < merged.length - 1; i += 1) {
      const gapStart = merged[i].endExclusive;
      const gapEnd = merged[i + 1].startAbs - 1;
      const gapMonths = gapEnd - gapStart + 1;
      if (gapMonths < minGapMonths) continue;
      gaps.push({
        dynastyId: merged[i + 1].dynastyId,
        gapStart,
        gapEnd,
      });
    }
  }

  return gaps;
}
