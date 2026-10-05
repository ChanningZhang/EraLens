import { resolveDynastyName } from "./dynastyNames";
import { activeReignsAtAbs } from "./timelineOwnership";
import type { Dynasty, Reign } from "./schema";

/** Left padding of the dynasty-name rail. */
export const TIMELINE_RAIL_INSET_PX = 12;
/** Fixed chip width: 4 CJK glyphs at 12px plus padding. */
export const TIMELINE_RAIL_LABEL_WIDTH_PX = 64;
/** Air between name chips and time-mapped content. */
export const TIMELINE_RAIL_GAP_PX = 10;
/** Stage x where the shared time axis begins. */
export const TIMELINE_GUTTER_PX =
  TIMELINE_RAIL_INSET_PX + TIMELINE_RAIL_LABEL_WIDTH_PX + TIMELINE_RAIL_GAP_PX;
/** Frozen dynasty-name chip, matching DynastyLane.frozenLabel. */
export const TIMELINE_RAIL_CHIP_TOP_PX = 10;
export const TIMELINE_RAIL_CHIP_HEIGHT_PX = 44;

export function resolveFrozenLaneLabel(dynasty: Pick<Dynasty, "id" | "name" | "altNames">, labelAnchorAbs: number): string {
  return resolveDynastyName(dynasty, labelAnchorAbs);
}

export function isFrozenLaneMaster(dynastyId: string, labelAnchorAbs: number, reigns: readonly Reign[]): boolean {
  return activeReignsAtAbs(reigns, labelAnchorAbs).some(reign => reign.dynastyId === dynastyId && reign.isMain === true);
}

export function reignsInLayoutBucket(reign: Pick<Reign, "dynastyId">, laneReigns: readonly Reign[]): Reign[] {
  return laneReigns.filter(item => item.dynastyId === reign.dynastyId);
}

export function layoutBucketsForLaneReigns(laneReigns: readonly Reign[]): Reign[][] {
  const buckets = new Map<string, Reign[]>();
  for (const reign of laneReigns) {
    const bucket = buckets.get(reign.dynastyId) ?? [];
    bucket.push(reign);
    buckets.set(reign.dynastyId, bucket);
  }
  return [...buckets.values()];
}

export function collectLaneReigns(dynastyId: string, reignsByDynasty: ReadonlyMap<string, readonly Reign[]>): Reign[] {
  return [...(reignsByDynasty.get(dynastyId) ?? [])];
}
