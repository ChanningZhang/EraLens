import type { Dynasty, DynastyGroup } from "./schema";
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

/**
 * Cluster members stay on separate rows but are placed contiguously.
 * Unit sort uses the group's own span, not member min/max.
 */
export function orderDynastiesForLanes(
  dynasties: readonly Dynasty[],
  dynastyGroups: readonly DynastyGroup[],
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

  return units
    .sort((a, b) => compareTimedOrder(a.sortKey, b.sortKey))
    .flatMap((unit) => unit.dynasties);
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
