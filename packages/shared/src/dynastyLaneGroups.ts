import type { Dynasty, Reign } from "./schema";

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
};

export const DYNASTY_LANE_GROUPS: readonly DynastyLaneGroup[] = [
  {
    id: "mongol-yuan",
    primaryDynastyId: "yuan",
    phaseDynastyIds: ["mongol-empire", "yuan"],
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

/**
 * Collapse configured lane groups into one row per group. Member dynasties are
 * removed from the list; the primary dynasty is kept with the union span.
 */
export function collapseDynastyLaneGroups(dynasties: Dynasty[]): Dynasty[] {
  const byId = new Map(dynasties.map((dynasty) => [dynasty.id, dynasty]));
  const consumedIds = new Set<string>();
  const merged: Dynasty[] = [];

  for (const group of DYNASTY_LANE_GROUPS) {
    const members = group.phaseDynastyIds
      .map((dynastyId) => byId.get(dynastyId))
      .filter((dynasty): dynasty is Dynasty => Boolean(dynasty));
    if (members.length === 0) continue;

    for (const member of members) consumedIds.add(member.id);

    const primary = byId.get(group.primaryDynastyId) ?? members[0]!;
    const startAbs = Math.min(...members.map((member) => member.startAbs));
    const endAbs = Math.max(...members.map((member) => member.endAbs));
    const earliest = members.reduce((left, right) =>
      left.startAbs <= right.startAbs ? left : right,
    );
    const latest = members.reduce((left, right) =>
      left.endAbs >= right.endAbs ? left : right,
    );

    merged.push({
      ...primary,
      id: group.primaryDynastyId,
      startAbs,
      endAbs,
      start: earliest.start,
      end: latest.end,
    });
  }

  const rest = dynasties.filter((dynasty) => !consumedIds.has(dynasty.id));
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
