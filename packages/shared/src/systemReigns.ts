import type { Reign } from "./schema";

/** Foreign-key target reserved for researched periods whose ruler record is missing. */
export const SYSTEM_MISSING_RULER_PERSON_ID = "system-missing-ruler";

export function isSystemMissingReign(
  reign: Pick<Reign, "personId">,
): boolean {
  return reign.personId === SYSTEM_MISSING_RULER_PERSON_ID;
}
