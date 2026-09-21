import { SYSTEM_MISSING_RULER_PERSON_ID } from "./missingReigns.mjs";
import {
  FEUDAL_DYNASTY_CLAN,
  FEUDAL_PERSON_CLAN_OVERRIDES,
  FEUDAL_PERSON_CLAN_RULES,
} from "./feudalClanMetadata.mjs";

/**
 * Stamp wiki-sourced 姓/氏 onto person objects before SQL generation.
 *
 * Person rows inherit FEUDAL_DYNASTY_CLAN defaults by dynasty, then
 * name-prefix rules (田/吕/戴), then per-person overrides.
 * `system-missing-ruler` is shared across dynasties and must not receive a 姓.
 *
 * @param {{
 *   persons: Array<{ id: string, name: string, ancestralXing?: string, clanShi?: string }>,
 *   dynasties?: Array<{ id: string }>,
 *   personDynastyId?: Map<string, string> | Record<string, string>,
 * }} input
 */
export function applyFeudalClanMetadata({ persons, personDynastyId }) {
  const dynastyMap =
    personDynastyId instanceof Map
      ? personDynastyId
      : new Map(Object.entries(personDynastyId ?? {}));

  for (const person of persons) {
    if (person.id === SYSTEM_MISSING_RULER_PERSON_ID) continue;

    const dynastyId = dynastyMap.get(person.id);
    const meta = dynastyId ? FEUDAL_DYNASTY_CLAN[dynastyId] : undefined;
    if (meta?.ancestralXing && !person.ancestralXing) {
      person.ancestralXing = meta.ancestralXing;
    }
    if (meta?.clanShi && !person.clanShi) {
      person.clanShi = meta.clanShi;
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

  return { persons };
}
