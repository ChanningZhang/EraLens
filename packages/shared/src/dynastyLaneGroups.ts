import { resolveRocLaneRegionLabel } from "./rocTaiwanLeaderDisplay";
import type { Dynasty, DynastyLaneGroup, Reign } from "./schema";
import { absMonth } from "./time";
import { activePhaseIdAtAbs, activeReignsAtAbs } from "./timelineOwnership";

function compareReignOrder(a: Reign, b: Reign): number {
  return (
    a.startAbs - b.startAbs ||
    a.endAbs - b.endAbs ||
    a.id.localeCompare(b.id)
  );
}

/** Left padding of the dynasty-name rail. */
export const TIMELINE_RAIL_INSET_PX = 12;
/** Fixed chip width: 4 CJK glyphs at 14px plus padding. */
export const TIMELINE_RAIL_LABEL_WIDTH_PX = 80;
/** Air between name chips and time-mapped content. */
export const TIMELINE_RAIL_GAP_PX = 10;
/** Stage x where the shared time axis begins. */
export const TIMELINE_GUTTER_PX =
  TIMELINE_RAIL_INSET_PX + TIMELINE_RAIL_LABEL_WIDTH_PX + TIMELINE_RAIL_GAP_PX;
/** Frozen dynasty-name chip, matching DynastyLane.frozenLabel. */
export const TIMELINE_RAIL_CHIP_TOP_PX = 10;
export const TIMELINE_RAIL_CHIP_HEIGHT_PX = 44;

export type { DynastyLaneGroup };

function buildMemberMap(
  laneGroups: readonly DynastyLaneGroup[],
): Map<string, DynastyLaneGroup> {
  const map = new Map<string, DynastyLaneGroup>();
  for (const group of laneGroups) {
    for (const dynastyId of group.phaseDynastyIds) {
      map.set(dynastyId, group);
    }
  }
  return map;
}

export function getDynastyLaneGroup(
  dynastyId: string,
  laneGroups: readonly DynastyLaneGroup[],
): DynastyLaneGroup | undefined {
  return buildMemberMap(laneGroups).get(dynastyId);
}

function compareDynastyOrder(a: Dynasty, b: Dynasty): number {
  return (
    a.startAbs - b.startAbs ||
    a.endAbs - b.endAbs ||
    a.id.localeCompare(b.id)
  );
}

export function resolveActivePhaseDynastyId(
  group: DynastyLaneGroup,
  dynastiesById: ReadonlyMap<
    string,
    Pick<Dynasty, "id" | "startAbs" | "start" | "end" | "precision">
  >,
  labelAnchorAbs: number,
): string {
  const phases = group.phaseDynastyIds
    .map((id) => dynastiesById.get(id))
    .filter((phase): phase is NonNullable<typeof phase> => Boolean(phase));
  return activePhaseIdAtAbs(phases, labelAnchorAbs) ?? group.phaseDynastyIds[0]!;
}

export function resolveFrozenLaneLabel(
  dynasty: Pick<Dynasty, "id" | "name">,
  dynastiesById: ReadonlyMap<
    string,
    Pick<Dynasty, "id" | "name" | "startAbs" | "start" | "end" | "precision">
  >,
  labelAnchorAbs: number,
  laneGroups: readonly DynastyLaneGroup[],
): string {
  const group = getDynastyLaneGroup(dynasty.id, laneGroups);
  const base = group
    ? (dynastiesById.get(
        resolveActivePhaseDynastyId(group, dynastiesById, labelAnchorAbs),
      )?.name ?? dynasty.name)
    : dynasty.name;
  return resolveRocLaneRegionLabel(dynasty.id, base, labelAnchorAbs);
}

/** Frozen name chip follows the master reign at the shared timeline center. */
export function isFrozenLaneMaster(
  dynastyId: string,
  labelAnchorAbs: number,
  reigns: readonly Reign[],
): boolean {
  return activeReignsAtAbs(reigns, labelAnchorAbs).some(
    (reign) => reign.dynastyId === dynastyId && reign.isMain === true,
  );
}

function toDynastyMap(dynasties: Dynasty[] | ReadonlyMap<string, Dynasty>): Map<string, Dynasty> {
  if (Array.isArray(dynasties)) {
    return new Map(dynasties.map((dynasty) => [dynasty.id, dynasty]));
  }
  return new Map(dynasties);
}

/**
 * Collapse configured lane groups into one row per group. Member dynasties are
 * removed from the list; the primary dynasty is kept with the union span.
 */
export function collapseDynastyLaneGroups(
  visible: Dynasty[],
  catalog: Dynasty[] | ReadonlyMap<string, Dynasty> = visible,
  laneGroups: readonly DynastyLaneGroup[] = [],
): Dynasty[] {
  const visibleById = new Map(visible.map((dynasty) => [dynasty.id, dynasty]));
  const catalogById = toDynastyMap(catalog);
  const consumedIds = new Set<string>();
  const merged: Dynasty[] = [];

  for (const group of laneGroups) {
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

export function reignsInLayoutBucket(
  reign: Pick<Reign, "dynastyId">,
  laneReigns: readonly Reign[],
  laneGroups: readonly DynastyLaneGroup[] = [],
): Reign[] {
  const group = getDynastyLaneGroup(reign.dynastyId, laneGroups);
  if (!group) return [...laneReigns];
  return laneReigns.filter((item) => item.dynastyId === reign.dynastyId);
}

export function layoutBucketsForLaneReigns(
  laneReigns: readonly Reign[],
  laneGroups: readonly DynastyLaneGroup[] = [],
): Reign[][] {
  const buckets: Reign[][] = [];
  const groupedPhases = new Map<string, Map<string, Reign[]>>();
  const standaloneDynastyIds = new Set<string>();

  for (const reign of laneReigns) {
    const group = getDynastyLaneGroup(reign.dynastyId, laneGroups);
    if (!group) {
      standaloneDynastyIds.add(reign.dynastyId);
      continue;
    }
    let phases = groupedPhases.get(group.id);
    if (!phases) {
      phases = new Map();
      groupedPhases.set(group.id, phases);
    }
    const list = phases.get(reign.dynastyId) ?? [];
    list.push(reign);
    phases.set(reign.dynastyId, list);
  }

  for (const dynastyId of standaloneDynastyIds) {
    buckets.push(
      laneReigns
        .filter((reign) => reign.dynastyId === dynastyId)
        .sort(compareReignOrder),
    );
  }

  for (const group of laneGroups) {
    const phases = groupedPhases.get(group.id);
    if (!phases) continue;
    for (const dynastyId of group.phaseDynastyIds) {
      const list = phases.get(dynastyId);
      if (list?.length) buckets.push([...list].sort(compareReignOrder));
    }
  }

  return buckets;
}

export function collectLaneReigns(
  dynastyId: string,
  reignsByDynasty: ReadonlyMap<string, readonly Reign[]>,
  laneGroups: readonly DynastyLaneGroup[] = [],
): Reign[] {
  const group = getDynastyLaneGroup(dynastyId, laneGroups);
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

/** Test / mock fixture matching data/imports/dynasty-lane-groups. */
export const STANDARD_DYNASTY_LANE_GROUPS: readonly DynastyLaneGroup[] = [
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
];
