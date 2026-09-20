import type { CapitalRole, DynastyCapital } from "./schema";

export const CAPITAL_ROLE_LABEL: Record<CapitalRole, string> = {
  primary: "正都",
  secondary: "陪都",
  temporary: "临时都城",
};

export function capitalRoleLabel(role: CapitalRole): string {
  return CAPITAL_ROLE_LABEL[role];
}

/** Capitals whose reign span includes `atAbs` (inclusive on both ends). */
export function capitalsActiveAtAbs(
  capitals: readonly DynastyCapital[],
  atAbs: number,
): DynastyCapital[] {
  return capitals.filter((capital) => capital.startAbs <= atAbs && capital.endAbs >= atAbs);
}
