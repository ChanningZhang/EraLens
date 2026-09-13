import type { Dynasty, Reign } from "./schema";
import { absMonth } from "./time";

/** Horizontal offset of the frozen dynasty label from the viewport left edge. */
export const DEFAULT_FROZEN_LABEL_LEFT_PX = 12;

/**
 * Dynasties that share one timeline row. The frozen left label follows
 * `phaseDynastyIds` in chronological order: when the abs at the label anchor
 * crosses a phase dynasty's `startAbs`, the label switches to that name.
 */
export type DynastyLaneGroup = {
  id: string;
  /** Lane key and merged span anchor; usually the longest / canonical dynasty. */
  primaryDynastyId: string;
  /** Chronological phase dynasty ids for frozen-label resolution. */
  phaseDynastyIds: readonly string[];
  /** Stable lane-order span; does not shrink when earlier phases leave the viewport. */
  laneOrderStartAbs: number;
  laneOrderEndAbs: number;
};

export const DYNASTY_LANE_GROUPS: readonly DynastyLaneGroup[] = [
  {
    id: "mongol-yuan",
    primaryDynastyId: "yuan",
    phaseDynastyIds: ["mongol-empire", "yuan"],
    laneOrderStartAbs: absMonth(1206),
    laneOrderEndAbs: absMonth(1388),
  },
  {
    id: "wu-ming",
    primaryDynastyId: "ming",
    phaseDynastyIds: ["wu-zhu", "ming", "ming-south"],
    laneOrderStartAbs: absMonth(1364),
    laneOrderEndAbs: absMonth(1662),
  },
  {
    id: "song-north-south",
    primaryDynastyId: "song-north",
    phaseDynastyIds: ["song-north", "song-south"],
    laneOrderStartAbs: absMonth(960),
    laneOrderEndAbs: absMonth(1279),
  },
  {
    id: "zhou-west-east",
    primaryDynastyId: "zhou-west",
    phaseDynastyIds: ["zhou-west", "zhou-east"],
    laneOrderStartAbs: absMonth(-1046),
    laneOrderEndAbs: absMonth(-256, 12),
  },
];

const MEMBER_TO_GROUP = new Map<string, DynastyLaneGroup>();
for (const group of DYNASTY_LANE_GROUPS) {
  for (const dynastyId of group.phaseDynastyIds) {
    MEMBER_TO_GROUP.set(dynastyId, group);
  }
}

function compareDynastyOrder(a: Dynasty, b: Dynasty): number {
  return (
    a.startAbs - b.startAbs ||
    a.endAbs - b.endAbs ||
    a.id.localeCompare(b.id)
  );
}

export function getDynastyLaneGroup(dynastyId: string): DynastyLaneGroup | undefined {
  return MEMBER_TO_GROUP.get(dynastyId);
}

/** AbsMonth sampled at the frozen label anchor (not viewport center). */
export function resolveFrozenLabelAnchorAbs(
  startAbs: number,
  pxPerMonth: number,
  leftPx = DEFAULT_FROZEN_LABEL_LEFT_PX,
): number {
  return startAbs + leftPx / pxPerMonth;
}

export function resolveActivePhaseDynastyId(
  group: DynastyLaneGroup,
  dynastiesById: ReadonlyMap<string, Pick<Dynasty, "id" | "startAbs">>,
  labelAnchorAbs: number,
): string {
  let active = group.phaseDynastyIds[0]!;
  for (const dynastyId of group.phaseDynastyIds) {
    const dynasty = dynastiesById.get(dynastyId);
    if (dynasty && labelAnchorAbs >= dynasty.startAbs) {
      active = dynastyId;
    }
  }
  return active;
}

export function resolveFrozenLaneLabel(
  dynasty: Pick<Dynasty, "id" | "name">,
  dynastiesById: ReadonlyMap<string, Pick<Dynasty, "id" | "name" | "startAbs">>,
  labelAnchorAbs: number,
): string {
  const group = getDynastyLaneGroup(dynasty.id);
  if (!group) return dynasty.name;
  const phaseId = resolveActivePhaseDynastyId(group, dynastiesById, labelAnchorAbs);
  return dynastiesById.get(phaseId)?.name ?? dynasty.name;
}

function toDynastyMap(dynasties: Dynasty[] | ReadonlyMap<string, Dynasty>): Map<string, Dynasty> {
  if (dynasties instanceof Map) return new Map(dynasties);
  return new Map(dynasties.map((dynasty) => [dynasty.id, dynasty]));
}

/**
 * Collapse configured lane groups into one row per group. Member dynasties are
 * removed from the list; the primary dynasty is kept with the union span.
 *
 * Visibility is driven by `visible`; span and sort order use `catalog` so a
 * lane keeps the group's earliest start even when earlier phases scroll off-screen.
 */
export function collapseDynastyLaneGroups(
  visible: Dynasty[],
  catalog: Dynasty[] | ReadonlyMap<string, Dynasty> = visible,
): Dynasty[] {
  const visibleById = new Map(visible.map((dynasty) => [dynasty.id, dynasty]));
  const catalogById = toDynastyMap(catalog);
  const consumedIds = new Set<string>();
  const merged: Dynasty[] = [];

  for (const group of DYNASTY_LANE_GROUPS) {
    const visibleMembers = group.phaseDynastyIds
      .map((dynastyId) => visibleById.get(dynastyId))
      .filter((dynasty): dynasty is Dynasty => Boolean(dynasty));
    if (visibleMembers.length === 0) continue;

    for (const member of visibleMembers) consumedIds.add(member.id);

    const spanMembers = group.phaseDynastyIds
      .map((dynastyId) => catalogById.get(dynastyId))
      .filter((dynasty): dynasty is Dynasty => Boolean(dynasty));

    const primary =
      catalogById.get(group.primaryDynastyId) ??
      visibleById.get(group.primaryDynastyId) ??
      spanMembers[0] ??
      visibleMembers[0]!;
    const earliest =
      spanMembers.find((member) => member.id === group.phaseDynastyIds[0]) ??
      spanMembers[0] ??
      visibleMembers[0]!;
    const latest =
      spanMembers.find(
        (member) => member.id === group.phaseDynastyIds[group.phaseDynastyIds.length - 1],
      ) ??
      spanMembers.at(-1) ??
      visibleMembers.at(-1)!;

    merged.push({
      ...primary,
      id: group.primaryDynastyId,
      startAbs: group.laneOrderStartAbs,
      endAbs: group.laneOrderEndAbs,
      start: earliest.start,
      end: latest.end,
    });
  }

  const rest = visible.filter((dynasty) => !consumedIds.has(dynasty.id));
  return [...rest, ...merged].sort(compareDynastyOrder);
}

/** Reigns for a lane, including all dynasties in the same lane group. */
export function collectLaneReigns(
  dynastyId: string,
  reignsByDynasty: ReadonlyMap<string, readonly Reign[]>,
): Reign[] {
  const group = getDynastyLaneGroup(dynastyId);
  const dynastyIds = group?.phaseDynastyIds ?? [dynastyId];
  const seen = new Set<string>();
  const reigns: Reign[] = [];
  for (const id of dynastyIds) {
    for (const reign of reignsByDynasty.get(id) ?? []) {
      if (seen.has(reign.id)) continue;
      seen.add(reign.id);
      reigns.push(reign);
    }
  }
  return reigns;
}
