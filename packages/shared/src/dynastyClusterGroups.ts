import type { Dynasty, DynastyCapital, DynastyGroup } from "./schema";
import {
  TIMELINE_RAIL_INSET_PX,
  TIMELINE_RAIL_LABEL_WIDTH_PX,
} from "./dynastyLaneGroups";

export type TimedSortKey = {
  id: string;
  startAbs: number;
  endAbs: number;
};

/** Shared lane ordering: startAbs → endAbs → id. */
export function compareTimedOrder(a: TimedSortKey, b: TimedSortKey): number {
  return (
    a.startAbs - b.startAbs ||
    a.endAbs - b.endAbs ||
    a.id.localeCompare(b.id)
  );
}

/**
 * How far after a dynasty ends we still treat a same-capital regime as its
 * "near successor" for lane packing (months). Keeps Tang→Five Dynasties style
 * handoffs sticky without yanking same-city regimes across centuries.
 */
export const SAME_CAPITAL_SUCCESSOR_WINDOW_MONTHS = 12 * 5;

type LaneUnit = {
  sortKey: TimedSortKey;
  dynasties: Dynasty[];
  /** Place identity of the unit's lead dynasty (modernName of primary capital). */
  capitalKey: string | null;
};

const CAPITAL_ROLE_RANK: Record<string, number> = {
  primary: 0,
  secondary: 1,
  temporary: 2,
};

/** Stable place id for lane affinity: prefer primary capital covering `atAbs`. */
export function dynastyCapitalPlaceKey(
  dynastyId: string,
  atAbs: number,
  capitals: readonly DynastyCapital[],
): string | null {
  const owned = capitals.filter((capital) => capital.dynastyId === dynastyId);
  if (owned.length === 0) return null;

  const covering = owned.filter(
    (capital) => capital.startAbs <= atAbs && capital.endAbs >= atAbs,
  );
  const pool = covering.length > 0 ? covering : owned;
  const best = [...pool].sort(
    (a, b) =>
      (CAPITAL_ROLE_RANK[a.role] ?? 9) - (CAPITAL_ROLE_RANK[b.role] ?? 9) ||
      a.startAbs - b.startAbs ||
      a.id.localeCompare(b.id),
  )[0];
  const key = best?.modernName?.trim();
  return key ? key : null;
}

function isNearSuccessor(prev: TimedSortKey, next: TimedSortKey): boolean {
  return (
    next.startAbs >= prev.startAbs &&
    next.startAbs <= prev.endAbs + SAME_CAPITAL_SUCCESSOR_WINDOW_MONTHS
  );
}

/**
 * Timed order, but after each pick prefer a near successor that shares the
 * previous unit's capital place so same-city continuations sit just below.
 */
export function orderByTimedWithCapitalAffinity<T>(
  items: readonly T[],
  timedKey: (item: T) => TimedSortKey,
  capitalKey: (item: T) => string | null,
): T[] {
  const remaining = [...items].sort((a, b) =>
    compareTimedOrder(timedKey(a), timedKey(b)),
  );
  const ordered: T[] = [];

  while (remaining.length > 0) {
    if (ordered.length === 0) {
      ordered.push(remaining.shift()!);
      continue;
    }

    const prev = timedKey(ordered[ordered.length - 1]!);
    const prevCapital = capitalKey(ordered[ordered.length - 1]!);
    let bestIndex = 0;

    if (prevCapital) {
      for (let i = 0; i < remaining.length; i++) {
        const candidate = remaining[i]!;
        const candidateKey = timedKey(candidate);
        const candidateCapital = capitalKey(candidate);
        if (candidateCapital !== prevCapital) continue;
        if (!isNearSuccessor(prev, candidateKey)) continue;

        const best = remaining[bestIndex]!;
        const bestKey = timedKey(best);
        const bestCapital = capitalKey(best);
        const bestIsMatch =
          bestCapital === prevCapital && isNearSuccessor(prev, bestKey);

        if (!bestIsMatch) {
          bestIndex = i;
          continue;
        }
        if (compareTimedOrder(candidateKey, bestKey) < 0) {
          bestIndex = i;
        }
      }
    }

    ordered.push(remaining.splice(bestIndex, 1)[0]!);
  }

  return ordered;
}

/**
 * Cluster members stay on separate rows but are placed contiguously.
 * Unit sort uses the group's own span, not member min/max.
 *
 * Optional `capitals`: near successors that share a capital place with the
 * dynasty above are pulled forward so they sit just below it.
 */
export function orderDynastiesForLanes(
  dynasties: readonly Dynasty[],
  dynastyGroups: readonly DynastyGroup[],
  capitals: readonly DynastyCapital[] = [],
): Dynasty[] {
  const groupById = new Map(dynastyGroups.map((group) => [group.id, group]));
  const membersByGroupId = new Map<string, Dynasty[]>();
  const consumedIds = new Set<string>();
  const units: LaneUnit[] = [];

  const capitalKeyFor = (dynasty: Dynasty): string | null =>
    dynastyCapitalPlaceKey(dynasty.id, dynasty.startAbs, capitals);

  for (const dynasty of dynasties) {
    const groupId = dynasty.groupId;
    if (!groupId || !groupById.has(groupId)) continue;
    const list = membersByGroupId.get(groupId) ?? [];
    list.push(dynasty);
    membersByGroupId.set(groupId, list);
  }

  for (const [groupId, members] of membersByGroupId) {
    const group = groupById.get(groupId);
    if (!group || members.length === 0) continue;
    for (const member of members) consumedIds.add(member.id);
    const orderedMembers = orderByTimedWithCapitalAffinity(
      members,
      (dynasty) => dynasty,
      capitalKeyFor,
    );
    units.push({
      sortKey: {
        id: group.id,
        startAbs: group.startAbs,
        endAbs: group.endAbs,
      },
      dynasties: orderedMembers,
      capitalKey: capitalKeyFor(orderedMembers[0]!),
    });
  }

  for (const dynasty of dynasties) {
    if (consumedIds.has(dynasty.id)) continue;
    units.push({
      sortKey: {
        id: dynasty.id,
        startAbs: dynasty.startAbs,
        endAbs: dynasty.endAbs,
      },
      dynasties: [dynasty],
      capitalKey: capitalKeyFor(dynasty),
    });
  }

  return orderByTimedWithCapitalAffinity(
    units,
    (unit) => unit.sortKey,
    (unit) => unit.capitalKey,
  ).flatMap((unit) => unit.dynasties);
}

export type PlacedLaneMetrics = {
  dynasty: Pick<Dynasty, "id" | "groupId">;
  top: number;
  height: number;
  /** Stage y of the frozen dynasty-name chip. */
  chipTop: number;
  chipHeight: number;
};

export type ClusterFramePlacement = {
  group: DynastyGroup;
  top: number;
  height: number;
  left: number;
  width: number;
};

/** Horizontal / bottom air around left-rail dynasty chips. */
export const CLUSTER_CHIP_FRAME_PAD_X_PX = 5;
export const CLUSTER_CHIP_FRAME_PAD_BOTTOM_PX = 5;
/** Extra top air so the group name can sit on the frame edge. */
export const CLUSTER_CHIP_FRAME_PAD_TOP_PX = 11;

export function clusterFramesForLanes(
  lanes: readonly PlacedLaneMetrics[],
  dynastyGroups: readonly DynastyGroup[],
): ClusterFramePlacement[] {
  const groupById = new Map(dynastyGroups.map((group) => [group.id, group]));
  const lanesByGroupId = new Map<string, PlacedLaneMetrics[]>();

  for (const lane of lanes) {
    const groupId = lane.dynasty.groupId;
    if (!groupId || !groupById.has(groupId)) continue;
    const list = lanesByGroupId.get(groupId) ?? [];
    list.push(lane);
    lanesByGroupId.set(groupId, list);
  }

  const frames: ClusterFramePlacement[] = [];
  const padX = CLUSTER_CHIP_FRAME_PAD_X_PX;
  const padTop = CLUSTER_CHIP_FRAME_PAD_TOP_PX;
  const padBottom = CLUSTER_CHIP_FRAME_PAD_BOTTOM_PX;
  const left = TIMELINE_RAIL_INSET_PX - padX;
  const width = TIMELINE_RAIL_LABEL_WIDTH_PX + padX * 2;

  for (const [groupId, groupLanes] of lanesByGroupId) {
    const group = groupById.get(groupId);
    if (!group || groupLanes.length === 0) continue;
    const chipTop = Math.min(...groupLanes.map((lane) => lane.chipTop));
    const chipBottom = Math.max(
      ...groupLanes.map((lane) => lane.chipTop + lane.chipHeight),
    );
    frames.push({
      group,
      left,
      width,
      top: chipTop - padTop,
      height: chipBottom - chipTop + padTop + padBottom,
    });
  }

  return frames.sort((a, b) => compareTimedOrder(a.group, b.group));
}
