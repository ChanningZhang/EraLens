import type { Dynasty, DynastyCapital, DynastyGroup } from "./schema";
import {
  TIMELINE_RAIL_CHIP_HEIGHT_PX,
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

type LaneUnit = {
  sortKey: TimedSortKey;
  dynasties: Dynasty[];
  /** True for cluster-group units (三国/五代/…). */
  isCluster: boolean;
};

/** Capital fields the lane rule needs; a subset of `DynastyCapital`. */
export type LaneCapital = Pick<
  DynastyCapital,
  "dynastyId" | "modernName" | "startAbs" | "endAbs"
>;

type CapitalTenure = { city: string; startAbs: number; endAbs: number };

/** All capital tenures (any role) per dynasty, for point-in-time lookup. */
function capitalTenuresByDynastyId(
  capitals: readonly LaneCapital[],
): Map<string, CapitalTenure[]> {
  const byDynasty = new Map<string, CapitalTenure[]>();
  for (const capital of capitals) {
    const city = capital.modernName.trim();
    if (!city) continue;
    const list = byDynasty.get(capital.dynastyId) ?? [];
    list.push({ city, startAbs: capital.startAbs, endAbs: capital.endAbs });
    byDynasty.set(capital.dynastyId, list);
  }
  return byDynasty;
}

/**
 * Lane-ordering rule: a later dynasty that takes over an earlier dynasty's
 * capital is pulled up to sit directly below it, before other unrelated rows.
 *
 * Matching is by the capital **at the hand-off moment** — the instant the
 * successor begins. At that month the anchor and the successor must each hold a
 * capital in the same modern city; capitals a dynasty only held at some *other*
 * time never match (so 金 taking 开封 in 1214 does not glue it under 北宋, whose
 * hand-off was 1127). All capital roles count, and a dynasty can hold several
 * capitals at once, so any shared city (e.g. 唐's 洛阳 陪都 vs 武周's 洛阳)
 * qualifies. The pull cascades: a pulled row recursively pulls its own
 * same-capital successors (西魏 → 北周 → 隋 → 唐). Cluster units participate on
 * both sides — a whole cluster (e.g. 南朝) can be pulled under 东晋.
 */
function orderBySameCapitalSuccession(
  units: readonly LaneUnit[],
  capitals: readonly LaneCapital[],
): LaneUnit[] {
  const tenuresByDynasty = capitalTenuresByDynastyId(capitals);

  /** Cities a unit holds at absolute month `t` (any member, any capital role). */
  const citiesAt = (unit: LaneUnit, t: number): Set<string> => {
    const cities = new Set<string>();
    for (const dynasty of unit.dynasties) {
      for (const tenure of tenuresByDynasty.get(dynasty.id) ?? []) {
        if (tenure.startAbs <= t && t <= tenure.endAbs) cities.add(tenure.city);
      }
    }
    return cities;
  };

  /** The month a unit begins (its earliest member start) — the hand-off point. */
  const handoffStart = (unit: LaneUnit): number =>
    Math.min(...unit.dynasties.map((dynasty) => dynasty.startAbs));

  const intersects = (a: Set<string>, b: Set<string>): boolean => {
    for (const city of a) if (b.has(city)) return true;
    return false;
  };

  const remaining = [...units];
  const result: LaneUnit[] = [];

  const pullCascade = (anchor: LaneUnit): void => {
    for (;;) {
      let bestIndex = -1;
      let bestStart = Infinity;
      for (let index = 0; index < remaining.length; index += 1) {
        const candidate = remaining[index]!;
        // Successor only: it must begin at or after the anchor.
        if (candidate.sortKey.startAbs < anchor.sortKey.startAbs) continue;
        const t = handoffStart(candidate);
        if (!intersects(citiesAt(anchor, t), citiesAt(candidate, t))) continue;
        if (candidate.sortKey.startAbs < bestStart) {
          bestStart = candidate.sortKey.startAbs;
          bestIndex = index;
        }
      }
      if (bestIndex === -1) return;
      const pulled = remaining.splice(bestIndex, 1)[0]!;
      result.push(pulled);
      // Cascade: the pulled row becomes an anchor for its own successors.
      pullCascade(pulled);
    }
  };

  while (remaining.length > 0) {
    const anchor = remaining.shift()!;
    result.push(anchor);
    pullCascade(anchor);
  }

  return result;
}

function toSingletonUnit(dynasty: Dynasty): LaneUnit {
  return {
    sortKey: { id: dynasty.id, startAbs: dynasty.startAbs, endAbs: dynasty.endAbs },
    dynasties: [dynasty],
    isCluster: false,
  };
}

/**
 * Order dynasties chronologically, then apply the same-capital pull-up. Used
 * both for standalone rows and for members inside a cluster (三国/五代/北朝…),
 * so e.g. 西魏 → 北周 (长安) sit together inside 北朝 instead of being split by
 * 北齐 (邺).
 */
function orderDynastiesBySameCapital(
  dynasties: readonly Dynasty[],
  capitals: readonly LaneCapital[],
): Dynasty[] {
  if (capitals.length === 0) return [...dynasties].sort(compareTimedOrder);
  const subUnits = [...dynasties].sort(compareTimedOrder).map(toSingletonUnit);
  return orderBySameCapitalSuccession(subUnits, capitals).flatMap((unit) => unit.dynasties);
}

/**
 * Cluster members stay on separate rows but are placed contiguously.
 * Unit sort uses the group's own span, not member min/max.
 *
 * When `capitals` are supplied, same-capital successor dynasties are pulled up
 * to sit directly below their predecessor (see `orderBySameCapitalSuccession`),
 * both across standalone rows and within each cluster's members.
 */
export function orderDynastiesForLanes(
  dynasties: readonly Dynasty[],
  dynastyGroups: readonly DynastyGroup[],
  capitals: readonly LaneCapital[] = [],
): Dynasty[] {
  const groupById = new Map(dynastyGroups.map((group) => [group.id, group]));
  const membersByGroupId = new Map<string, Dynasty[]>();
  const consumedIds = new Set<string>();
  const units: LaneUnit[] = [];

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
    units.push({
      sortKey: {
        id: group.id,
        startAbs: group.startAbs,
        endAbs: group.endAbs,
      },
      dynasties: orderDynastiesBySameCapital(members, capitals),
      isCluster: true,
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
      isCluster: false,
    });
  }

  const sorted = units.sort((a, b) => compareTimedOrder(a.sortKey, b.sortKey));
  const ordered =
    capitals.length > 0 ? orderBySameCapitalSuccession(sorted, capitals) : sorted;
  return ordered.flatMap((unit) => unit.dynasties);
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
