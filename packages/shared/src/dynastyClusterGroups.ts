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
};

/** Capital fields the lane rule needs; a subset of `DynastyCapital`. */
export type LaneCapital = Pick<DynastyCapital, "dynastyId" | "modernName" | "role">;

/** Map each dynasty to the set of cities where it held a primary capital. */
function primaryCapitalCitiesByDynastyId(
  capitals: readonly LaneCapital[],
): Map<string, Set<string>> {
  const byDynasty = new Map<string, Set<string>>();
  for (const capital of capitals) {
    if (capital.role !== "primary") continue;
    const city = capital.modernName.trim();
    if (!city) continue;
    const cities = byDynasty.get(capital.dynastyId) ?? new Set<string>();
    cities.add(city);
    byDynasty.set(capital.dynastyId, cities);
  }
  return byDynasty;
}

/**
 * Lane-ordering rule: a later dynasty that takes over an earlier dynasty's
 * capital is pulled up to sit directly below it (before other, unrelated rows).
 *
 * "Takes over" is bounded to a genuine hand-off — the successor must begin on
 * or before the anchor's own end (overlap / direct succession), so a dynasty
 * that reuses the same city centuries later (e.g. 秦 vs 大顺 at 西安) is never
 * yanked across the timeline. Chaining is transitive, so a run such as
 * 隋 → 唐 at 长安 stacks together. Same-city is keyed on the primary capital's
 * modern city, so 大兴/长安 (both 西安) count as one capital.
 */
function orderBySameCapitalSuccession(
  units: readonly LaneUnit[],
  capitals: readonly LaneCapital[],
): LaneUnit[] {
  const citiesByDynasty = primaryCapitalCitiesByDynastyId(capitals);
  const unitCities = (unit: LaneUnit): Set<string> => {
    const cities = new Set<string>();
    for (const dynasty of unit.dynasties) {
      for (const city of citiesByDynasty.get(dynasty.id) ?? []) cities.add(city);
    }
    return cities;
  };

  const remaining = [...units];
  const result: LaneUnit[] = [];

  while (remaining.length > 0) {
    let current = remaining.shift()!;
    result.push(current);

    // Pull up same-capital successors that begin during / at this row's hand-off.
    for (;;) {
      const anchorCities = unitCities(current);
      if (anchorCities.size === 0) break;

      const nextIndex = remaining.findIndex((candidate) => {
        if (candidate.sortKey.startAbs < current.sortKey.startAbs) return false;
        if (candidate.sortKey.startAbs > current.sortKey.endAbs) return false;
        for (const city of unitCities(candidate)) {
          if (anchorCities.has(city)) return true;
        }
        return false;
      });
      if (nextIndex === -1) break;

      current = remaining.splice(nextIndex, 1)[0]!;
      result.push(current);
    }
  }

  return result;
}

/**
 * Cluster members stay on separate rows but are placed contiguously.
 * Unit sort uses the group's own span, not member min/max.
 *
 * When `capitals` are supplied, same-capital successor dynasties are pulled up
 * to sit directly below their predecessor (see `orderBySameCapitalSuccession`).
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
      dynasties: [...members].sort(compareTimedOrder),
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
