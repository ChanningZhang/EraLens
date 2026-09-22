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
  /** True for cluster-group units (三国/五代/…); they never get pulled around. */
  isCluster: boolean;
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
 * capital is pulled up to sit directly below it, before other unrelated rows.
 *
 * The rule is deliberately bounded and single-level so it never scrambles the
 * timeline:
 * - The match is against the **anchor's own** primary-capital cities (for a
 *   cluster row, the union of its members' primary cities), not the last row
 *   pulled — so a mixed-capital cluster like 五代 (开封/洛阳/太原) still pulls
 *   its 开封 successor 北宋 instead of chasing an unrelated city.
 * - Only successors that **begin within the anchor's own span**
 *   (`start ∈ [anchor.start, anchor.end]`) are pulled — a genuine hand-off —
 *   so a dynasty reusing the same city centuries later (e.g. 秦 vs 大顺 at
 *   西安) is never yanked across the timeline.
 * - Pulled rows do **not** themselves pull further (no cascade), and cluster
 *   units are never pulled — they keep their chronological position.
 *
 * Same-city is keyed on the primary capital's modern city, so 大兴/长安 (both
 * 西安市) count as one capital; a successor matches on any of its own primary
 * cities (e.g. 明's later 北京 matches 元).
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
    const anchor = remaining.shift()!;
    result.push(anchor);

    const anchorCities = unitCities(anchor);
    if (anchorCities.size === 0) continue;

    // Pull every singleton successor that begins within the anchor's span and
    // shares one of its capital cities, keeping them in chronological order.
    for (let index = 0; index < remaining.length; ) {
      const candidate = remaining[index]!;
      // remaining stays chronologically sorted; nothing further can start
      // within the anchor's span once we pass its end.
      if (candidate.sortKey.startAbs > anchor.sortKey.endAbs) break;

      let shares = false;
      if (!candidate.isCluster) {
        for (const city of unitCities(candidate)) {
          if (anchorCities.has(city)) {
            shares = true;
            break;
          }
        }
      }

      if (shares) {
        result.push(candidate);
        remaining.splice(index, 1);
      } else {
        index += 1;
      }
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
