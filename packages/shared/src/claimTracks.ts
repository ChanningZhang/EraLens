import type { Reign } from "./schema";
import { rangesIntersect } from "./time";

/**
 * Concurrent claimants on one dynasty lane (隋末长安杨侑 / 洛阳杨侗, 南明鲁监国 / 绍武).
 *
 * Do **not** invent extra dynasty rows, and do **not** clip cards sequentially
 * across rival courts. Each power base is a `claimTrack`:
 *
 * - omitted / `main` — conventionally counted succession (文帝→炀帝, 弘光→隆武→永历)
 * - other kebab-case keys — one vertical sub-row per seat (`changan`, `lu-jian`)
 * - `claimLabel` — seat shown in tooltip / detail (长安 / 绍兴监国)
 * - `claimRole` — `rival` for a reign that is not the conventionally counted
 *   line. With `claimTrack` it is a concurrent claimant on a secondary row.
 *   Without `claimTrack` it stays sequential on the main row (有穷代夏) but
 *   still skips master gold and the main succession chain.
 *
 * Sequencing, clipping, and succession chains stay *inside* a track. Tracks
 * stack so overlapping reigns render side by side.
 */
export const MAIN_CLAIM_TRACK = "main";

export function claimTrackOf(reign: Pick<Reign, "claimTrack">): string {
  return reign.claimTrack ?? MAIN_CLAIM_TRACK;
}

export function isParallelClaim(reign: Pick<Reign, "claimTrack">): boolean {
  return claimTrackOf(reign) !== MAIN_CLAIM_TRACK;
}

/** Not the conventionally counted master line (parallel track or rival marker). */
export function isNonMasterLine(
  reign: Pick<Reign, "claimTrack" | "claimRole">,
): boolean {
  return isParallelClaim(reign) || reign.claimRole === "rival";
}

export type ClaimTrackLane = {
  track: string;
  /** Row offset inside the lane; the main track is always row 0. */
  rowIndex: number;
  reigns: Reign[];
  startAbs: number;
  endAbs: number;
};

function earliestStart(reigns: readonly Reign[]): number {
  return reigns.reduce((min, reign) => Math.min(min, reign.startAbs), Infinity);
}

function latestEnd(reigns: readonly Reign[]): number {
  return reigns.reduce((max, reign) => Math.max(max, reign.endAbs), -Infinity);
}

/**
 * Split reigns into claim tracks. When the main line is in the current set it
 * occupies row 0; leftover tracks are ordered by first appearance, then key.
 * Off-screen tracks are omitted so the lane does not keep empty rows.
 */
export function groupByClaimTrack(reigns: readonly Reign[]): ClaimTrackLane[] {
  const byTrack = new Map<string, Reign[]>();
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

  const ordered = mainReigns?.length
    ? [{ track: MAIN_CLAIM_TRACK, reigns: mainReigns }, ...rivals]
    : rivals;

  return ordered.map((entry, rowIndex) => ({
    track: entry.track,
    rowIndex,
    reigns: entry.reigns,
    startAbs: earliestStart(entry.reigns),
    endAbs: latestEnd(entry.reigns),
  }));
}

/** Peers used for sequential clipping: same dynasty phase *and* same track. */
export function reignsInSameClaimTrack(
  reign: Pick<Reign, "claimTrack">,
  peers: readonly Reign[],
): Reign[] {
  const track = claimTrackOf(reign);
  return peers.filter((item) => claimTrackOf(item) === track);
}

export type ConcurrencySpan = {
  startAbs: number;
  endAbs: number;
  /** Number of tracks simultaneously active across the span. */
  trackCount: number;
};

/**
 * Abs ranges where two or more tracks are active at once.
 */
export function resolveConcurrencySpans(
  reigns: readonly Reign[],
): ConcurrencySpan[] {
  const lanes = groupByClaimTrack(reigns);
  if (lanes.length < 2) return [];

  const edges = new Set<number>();
  for (const lane of lanes) {
    edges.add(lane.startAbs);
    edges.add(lane.endAbs + 1);
  }
  const points = [...edges].sort((a, b) => a - b);

  const spans: ConcurrencySpan[] = [];
  for (let i = 0; i < points.length - 1; i += 1) {
    const startAbs = points[i]!;
    const endAbs = points[i + 1]! - 1;
    if (endAbs < startAbs) continue;
    const trackCount = lanes.filter(
      (lane) => rangesIntersect(lane.startAbs, lane.endAbs, startAbs, endAbs),
    ).length;
    if (trackCount < 2) continue;

    const previous = spans.at(-1);
    if (previous && previous.trackCount === trackCount && previous.endAbs + 1 === startAbs) {
      previous.endAbs = endAbs;
      continue;
    }
    spans.push({ startAbs, endAbs, trackCount });
  }
  return spans;
}

export const PARALLEL_CLAIM_LABEL = "并立";

export function claimDetailFacts(
  reign: Pick<Reign, "claimTrack" | "claimLabel">,
): Array<{ label: string; value: string }> {
  const facts: Array<{ label: string; value: string }> = [];
  if (isParallelClaim(reign)) {
    facts.push({ label: "身份", value: PARALLEL_CLAIM_LABEL });
  }
  if (reign.claimLabel) {
    facts.push({ label: "据点", value: reign.claimLabel });
  }
  return facts;
}
