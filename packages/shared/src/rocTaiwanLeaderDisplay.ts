import type { Reign } from "./schema";
import { absMonth } from "./time";

/** 1950 年迁台后续统，界面改称「台湾地区 · 领导人」。 */
export const ROC_TAIWAN_LEADER_DISPLAY_START_YEAR = 1950;
export const ROC_TAIWAN_LEADER_DISPLAY_START_ABS = absMonth(1950);
export const ROC_TAIWAN_LEADER_REGION_LABEL = "台湾地区";
export const ROC_TAIWAN_LEADER_OFFICE_LABEL = "领导人";

export type RocReignDisplayFields = Pick<Reign, "dynastyId" | "start">;

export function isRocTaiwanLeaderReign(reign: RocReignDisplayFields): boolean {
  return (
    reign.dynastyId === "roc" &&
    reign.start.year >= ROC_TAIWAN_LEADER_DISPLAY_START_YEAR
  );
}

export function isRocTaiwanLeaderEra(atAbs: number): boolean {
  return atAbs >= ROC_TAIWAN_LEADER_DISPLAY_START_ABS;
}

export function resolveRocReignRegionLabel(
  reign: RocReignDisplayFields,
  dynastyName: string,
): string {
  return isRocTaiwanLeaderReign(reign)
    ? ROC_TAIWAN_LEADER_REGION_LABEL
    : dynastyName;
}

export function resolveRocLaneRegionLabel(
  dynastyId: string,
  dynastyName: string,
  labelAnchorAbs: number,
): string {
  if (dynastyId === "roc" && isRocTaiwanLeaderEra(labelAnchorAbs)) {
    return ROC_TAIWAN_LEADER_REGION_LABEL;
  }
  return dynastyName;
}

export function resolveRocReignDetailSubtitle(): string {
  return `${ROC_TAIWAN_LEADER_REGION_LABEL} · ${ROC_TAIWAN_LEADER_OFFICE_LABEL}`;
}
