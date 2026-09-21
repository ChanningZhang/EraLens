/**
 * Import-side mirror of @eralens/shared emperorAppellation
 * (buildPreQinClanContext, resolvePreQinXingShi).
 */

/** @param {{ ancestralXing?: string, clanShi?: string } | null | undefined} person */
export function buildPreQinClanContext(person) {
  return {
    personAncestralXing: person?.ancestralXing,
    personClanShi: person?.clanShi,
  };
}

/** @param {ReturnType<typeof buildPreQinClanContext> | null | undefined} clan */
export function resolvePreQinXingShi(_personName, clan) {
  const xing = clan?.personAncestralXing ?? undefined;
  const shi = clan?.personClanShi ?? undefined;
  if (!xing && !shi) return {};
  return { ...(xing ? { xing } : {}), ...(shi ? { shi } : {}) };
}
