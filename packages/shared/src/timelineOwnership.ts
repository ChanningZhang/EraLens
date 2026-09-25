import { claimTrackOf } from "./claimTracks";
import type { Dynasty, DynastyCapital, Reign } from "./schema";
import {
  effectiveIntervalEndAbs,
  intervalContainsAbs,
  intervalPrecedes,
  intervalsIntersect,
  leftOpenRightClosedInterval,
  preserveEarlierIntervalAtOverlap,
  timelineInterval,
  type LeftOpenRightClosedInterval,
} from "./timelineIntervals";

/** A partial capital record is also used while ordering dynasty lanes. */
export type TimedCapital = Pick<
  DynastyCapital,
  "dynastyId" | "modernName" | "startAbs" | "endAbs"
> & Partial<Pick<DynastyCapital, "id" | "start" | "end" | "precision" | "endPrecision" | "role" | "claimTrack">>;

type OwnershipRecord = Reign | TimedCapital | Pick<Dynasty, "id" | "start" | "end" | "precision">;
type OwnershipRequest =
  | { kind: "reign"; item: Reign; peers: readonly Reign[]; scope?: "dynasty" | "lane" }
  | { kind: "capital"; item: TimedCapital; peers: readonly TimedCapital[] }
  | { kind: "phase"; item: Pick<Dynasty, "id" | "start" | "end" | "precision">; peers: readonly Pick<Dynasty, "id" | "start" | "end" | "precision">[] };

function sameReignSeries(a: Reign, b: Reign, scope: "dynasty" | "lane"): boolean {
  return claimTrackOf(a) === claimTrackOf(b) &&
    (scope === "lane" || a.dynastyId === b.dynastyId);
}

export function reignOwnershipPeers(
  reign: Reign,
  reigns: readonly Reign[],
  scope: "dynasty" | "lane" = "dynasty",
): Reign[] {
  return reigns.filter((item) => sameReignSeries(item, reign, scope));
}

function recordedInterval(item: OwnershipRecord): LeftOpenRightClosedInterval {
  if ("start" in item && item.start && "end" in item && item.end) {
    const endPrecision = "endPrecision" in item ? item.endPrecision : undefined;
    return timelineInterval(item.start, item.end, item.precision ?? "month", endPrecision ?? item.precision ?? "month");
  }
  if ("startAbs" in item && "endAbs" in item) {
    return leftOpenRightClosedInterval(item.startAbs, item.endAbs);
  }
  throw new Error("Timeline ownership requires dated boundaries");
}

function sameOwnershipSeries(request: OwnershipRequest, peer: OwnershipRecord): boolean {
  const { item } = request;
  if (peer === item || ("id" in peer && "id" in item && peer.id && peer.id === item.id)) return false;
  if (request.kind === "phase") return true;
  if (request.kind === "reign") {
    const other = peer as Reign;
    return sameReignSeries(other, request.item, request.scope ?? "dynasty");
  }
  const other = peer as TimedCapital;
  return request.item.modernName.trim() !== "" &&
    other.modernName.trim() === request.item.modernName.trim() &&
    (request.item.role == null || other.role === request.item.role) &&
    (other.claimTrack ?? null) === (request.item.claimTrack ?? null);
}

/** The sole category-aware arbitration point for adjacent timeline ownership. */
export function timelineOwnershipInterval(request: OwnershipRequest): LeftOpenRightClosedInterval {
  const interval = recordedInterval(request.item);
  const earlier = request.peers
    .filter((peer) => sameOwnershipSeries(request, peer))
    .map(recordedInterval)
    .filter((peerInterval) => intervalPrecedes(peerInterval, interval));
  return preserveEarlierIntervalAtOverlap(interval, earlier);
}

/** Timeline slices and lane records are immutable; a new array is a new ownership revision. */
const reignIntervalCache = new WeakMap<readonly Reign[], {
  length: number;
  dynasty: WeakMap<Reign, LeftOpenRightClosedInterval>;
  lane: WeakMap<Reign, LeftOpenRightClosedInterval>;
}>();
const capitalIntervalCache = new WeakMap<readonly TimedCapital[], {
  length: number;
  intervals: WeakMap<TimedCapital, LeftOpenRightClosedInterval>;
}>();

export function reignOwnershipInterval(reign: Reign, reigns: readonly Reign[], scope: "dynasty" | "lane" = "dynasty") {
  let cached = reignIntervalCache.get(reigns);
  if (!cached || cached.length !== reigns.length) {
    cached = { length: reigns.length, dynasty: new WeakMap(), lane: new WeakMap() };
    reignIntervalCache.set(reigns, cached);
  }
  const byReign = cached[scope];
  const existing = byReign.get(reign);
  if (existing) return existing;
  const interval = timelineOwnershipInterval({ kind: "reign", item: reign, peers: reigns, scope });
  byReign.set(reign, interval);
  return interval;
}

export function capitalOwnershipInterval(capital: TimedCapital, capitals: readonly TimedCapital[]) {
  let cached = capitalIntervalCache.get(capitals);
  if (!cached || cached.length !== capitals.length) {
    cached = { length: capitals.length, intervals: new WeakMap() };
    capitalIntervalCache.set(capitals, cached);
  }
  const existing = cached.intervals.get(capital);
  if (existing) return existing;
  const interval = timelineOwnershipInterval({ kind: "capital", item: capital, peers: capitals });
  cached.intervals.set(capital, interval);
  return interval;
}

export function phaseOwnershipInterval(
  phase: Pick<Dynasty, "id" | "start" | "end" | "precision">,
  phases: readonly Pick<Dynasty, "id" | "start" | "end" | "precision">[],
) {
  return timelineOwnershipInterval({ kind: "phase", item: phase, peers: phases });
}

export function phaseOwnsAbs(
  phase: Pick<Dynasty, "id" | "start" | "end" | "precision">,
  phases: readonly Pick<Dynasty, "id" | "start" | "end" | "precision">[],
  atAbs: number,
): boolean {
  return intervalContainsAbs(phaseOwnershipInterval(phase, phases), atAbs);
}

export function activePhaseIdAtAbs(
  phases: readonly Pick<Dynasty, "id" | "start" | "end" | "precision">[],
  atAbs: number,
): string | undefined {
  let active = phases[0]?.id;
  for (const phase of phases) {
    if (phaseOwnsAbs(phase, phases, atAbs)) active = phase.id;
  }
  const latest = phases.at(-1);
  if (latest && atAbs >= effectiveIntervalEndAbs(phaseOwnershipInterval(latest, phases))) {
    return latest.id;
  }
  return active;
}

export function reignOwnsAbs(reign: Reign, reigns: readonly Reign[], atAbs: number): boolean {
  return intervalContainsAbs(reignOwnershipInterval(reign, reigns), atAbs);
}

export function capitalOwnsAbs(capital: TimedCapital, capitals: readonly TimedCapital[], atAbs: number): boolean {
  return intervalContainsAbs(capitalOwnershipInterval(capital, capitals), atAbs);
}

export function activeReignsAtAbs(reigns: readonly Reign[], atAbs: number): Reign[] {
  // Recorded month bounds are a cheap superset of the precise ownership interval.
  return reigns.filter((reign) =>
    reign.startAbs <= atAbs && atAbs < reign.endAbs + 1 && reignOwnsAbs(reign, reigns, atAbs),
  );
}

export function activeCapitalsAtAbs<T extends TimedCapital>(capitals: readonly T[], atAbs: number): T[] {
  return capitals.filter((capital) =>
    capital.startAbs <= atAbs && atAbs < capital.endAbs + 1 && capitalOwnsAbs(capital, capitals, atAbs),
  );
}

/** Prefer explicit reign-capital links; otherwise match dynasty, track, and owned date ranges. */
export function capitalSegmentsForReign(
  reign: Reign,
  reigns: readonly Reign[],
  capitals: readonly DynastyCapital[],
): Array<{
  capital: DynastyCapital;
  overlapInterval: LeftOpenRightClosedInterval;
  startsAtReignBoundary: boolean;
  endsAtReignBoundary: boolean;
}> {
  const reignInterval = reignOwnershipInterval(reign, reigns);
  const linked = capitals.filter((capital) => capital.reignIds?.includes(reign.id));
  const candidates = linked.length > 0
    ? linked
    : capitals.filter((capital) => capital.dynastyId === reign.dynastyId);
  return candidates.flatMap((capital) => {
    if (linked.length === 0 && (capital.claimTrack ?? null) !== (reign.claimTrack ?? null)) return [];
    const capitalInterval = capitalOwnershipInterval(capital, capitals);
    if (!intervalsIntersect(reignInterval, capitalInterval)) return [];
    // A one-day handoff is owned by the older interval even if a viewport
    // slice omitted the predecessor reign that would otherwise clip this start.
    if (reignInterval.startExclusive + 1 === capitalInterval.endInclusive &&
      capitalInterval.startExclusive < reignInterval.startExclusive) return [];
    return [{
      capital,
      overlapInterval: {
        startExclusive: Math.max(reignInterval.startExclusive, capitalInterval.startExclusive),
        endInclusive: Math.min(reignInterval.endInclusive, capitalInterval.endInclusive),
      },
      startsAtReignBoundary: reignInterval.startExclusive >= capitalInterval.startExclusive,
      endsAtReignBoundary: reignInterval.endInclusive <= capitalInterval.endInclusive,
    }];
  });
}

export function capitalsForReigns(
  selectedReigns: readonly Reign[],
  allReigns: readonly Reign[],
  capitals: readonly DynastyCapital[],
): DynastyCapital[] {
  const ids = new Set(
    selectedReigns.flatMap((reign) =>
      capitalSegmentsForReign(reign, allReigns, capitals).map(({ capital }) => capital.id),
    ),
  );
  return capitals.filter((capital) => ids.has(capital.id));
}
