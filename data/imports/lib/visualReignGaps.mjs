/**
 * Mirror apps/web/src/features/timeline/model/reignClusters.ts visual span logic
 * so import SQL can insert missing placeholders for holes the UI actually shows.
 */

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
  const group = sameStartGroup(reign, reigns);
  const nextLater = nextLaterStartAbs(reign, reigns);

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

function assignReignStacks(reigns) {
  const sorted = sortReigns(reigns);
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
      const { stackIndex } = resolveReignVisualSpan(reign, reigns);
      items.push({ reign, stackIndex });
    }
    index = end;
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
