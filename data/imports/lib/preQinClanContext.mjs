/**
 * Keep in sync with packages/shared/src/emperorAppellation.ts
 * (buildPreQinClanContext, resolvePreQinXingShi).
 */

/** @param {object | null | undefined} person */
/** @param {object | null | undefined} dynasty */
export function buildPreQinClanContext(person, dynasty) {
  return {
    personAncestralXing: person?.ancestralXing,
    personClanShi: person?.clanShi,
    dynastyAncestralXing: dynasty?.ancestralXing,
    dynastyClanShi: dynasty?.clanShi,
  };
}

/** @param {string | null | undefined} _personName */
/** @param {ReturnType<typeof buildPreQinClanContext> | null | undefined} clan */
export function resolvePreQinXingShi(_personName, clan) {
  const xing = clan?.personAncestralXing ?? clan?.dynastyAncestralXing ?? undefined;
  const shi = clan?.personClanShi ?? clan?.dynastyClanShi ?? undefined;
  if (!xing && !shi) return {};
  return { ...(xing ? { xing } : {}), ...(shi ? { shi } : {}) };
}
