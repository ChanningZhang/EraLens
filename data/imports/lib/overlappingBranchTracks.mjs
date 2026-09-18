/**
 * When one dynasty lane merges two clans (姜齐 / 田齐), overlapping reigns of
 * the incoming clan are parallel claimants, not sequential successors.
 *
 * The earliest clan stays on the main track. A later clan's reign that overlaps
 * any earlier-clan reign gets `claimTrack` so the UI does not clip the incumbent.
 */

const BRANCH_TRACKS = {
  姜: "jiang",
  田: "tian",
  曲沃: "quwo",
};

function yearOf(reign, side) {
  if (side === "start") return reign.startYear ?? reign.start;
  return reign.endYear ?? reign.end;
}

function branchOf(reign) {
  return reign.clan ?? reign.branch ?? null;
}

export function trackKeyForBranch(branch) {
  if (branch == null) return null;
  if (BRANCH_TRACKS[branch]) return BRANCH_TRACKS[branch];
  if (/^[a-z0-9-]+$/i.test(branch)) return branch.toLowerCase();
  return null;
}

function yearsOverlap(a, b) {
  return yearOf(a, "start") <= yearOf(b, "end") && yearOf(a, "end") >= yearOf(b, "start");
}

/**
 * Mutates overlapping incoming-clan reigns with claimTrack / claimLabel / claimRole.
 * Returns the same array.
 */
export function assignOverlappingBranchTracks(rulers) {
  const indexed = rulers
    .map((reign, index) => ({ reign, index, branch: branchOf(reign) }))
    .filter((item) => item.branch);

  const firstStart = new Map();
  for (const item of indexed) {
    const start = yearOf(item.reign, "start");
    const prev = firstStart.get(item.branch);
    if (prev == null || start < prev) firstStart.set(item.branch, start);
  }
  if (firstStart.size < 2) return rulers;

  const clanOrder = [...firstStart.entries()]
    .sort((a, b) => a[1] - b[1] || a[0].localeCompare(b[0]))
    .map(([clan]) => clan);

  for (const item of indexed) {
    const { reign, branch } = item;
    const rank = clanOrder.indexOf(branch);
    if (rank <= 0) continue;
    const track = trackKeyForBranch(branch);
    if (!track) continue;

    const overlapsIncumbent = indexed.some((other) => {
      if (other.branch === branch) return false;
      if (clanOrder.indexOf(other.branch) >= rank) return false;
      return yearsOverlap(reign, other.reign);
    });
    if (!overlapsIncumbent) continue;

    reign.claimTrack = track;
    reign.claimLabel = branch;
    reign.claimRole = "rival";
  }

  return rulers;
}
