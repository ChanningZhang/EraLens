import { SYSTEM_MISSING_RULER_PERSON_ID } from "./missingReigns.mjs";
import {
  FEUDAL_DYNASTY_CLAN,
  FEUDAL_PERSON_CLAN_OVERRIDES,
  FEUDAL_PERSON_CLAN_RULES,
} from "./feudalClanMetadata.mjs";

/**
 * Stamp wiki-sourced 姓/氏 onto dynasty/person objects before SQL generation.
 *
 * Person rows inherit the dynasty, then name-prefix rules (田/吕/戴), then
 * per-person overrides. `system-missing-ruler` is shared across dynasties
 * and must not receive a 姓.
 *
 * @param {{
 *   persons: Array<{ id: string, name: string, ancestralXing?: string, clanShi?: string }>,
 *   dynasties: Array<{ id: string, ancestralXing?: string, clanShi?: string }>,
 *   personDynastyId?: Map<string, string> | Record<string, string>,
 * }} input
 */
export function applyFeudalClanMetadata({ persons, dynasties, personDynastyId }) {
  const dynastyMap =
    personDynastyId instanceof Map
      ? personDynastyId
      : new Map(Object.entries(personDynastyId ?? {}));
  const dynastyById = new Map(dynasties.map((row) => [row.id, row]));

  for (const dynasty of dynasties) {
    const meta = FEUDAL_DYNASTY_CLAN[dynasty.id];
    if (!meta) continue;
    if (meta.ancestralXing) dynasty.ancestralXing = meta.ancestralXing;
    if (meta.clanShi) dynasty.clanShi = meta.clanShi;
  }

  for (const person of persons) {
    if (person.id === SYSTEM_MISSING_RULER_PERSON_ID) continue;

    const dynastyId = dynastyMap.get(person.id);
    const dynasty = dynastyId ? dynastyById.get(dynastyId) : undefined;
    if (dynasty?.ancestralXing && !person.ancestralXing) {
      person.ancestralXing = dynasty.ancestralXing;
    }
    if (dynasty?.clanShi && !person.clanShi) {
      person.clanShi = dynasty.clanShi;
    }

    if (dynastyId) {
      for (const rule of FEUDAL_PERSON_CLAN_RULES) {
        if (rule.dynastyId && rule.dynastyId !== dynastyId) continue;
        if (!person.name.startsWith(rule.matchNamePrefix)) continue;
        if (rule.ancestralXing) person.ancestralXing = rule.ancestralXing;
        if (rule.clanShi) person.clanShi = rule.clanShi;
      }
    }

    const override = FEUDAL_PERSON_CLAN_OVERRIDES[person.id];
    if (override) {
      if ("ancestralXing" in override) person.ancestralXing = override.ancestralXing;
      if ("clanShi" in override) person.clanShi = override.clanShi;
    }
  }

  return { persons, dynasties };
}
