import {
  FEUDAL_DYNASTY_CLAN,
  FEUDAL_PERSON_CLAN_OVERRIDES,
  FEUDAL_PERSON_CLAN_RULES,
} from "./feudalClanMetadata.mjs";

/**
 * Stamp wiki-sourced 姓/氏 onto dynasty/person objects before SQL generation.
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

  for (const dynasty of dynasties) {
    const meta = FEUDAL_DYNASTY_CLAN[dynasty.id];
    if (!meta) continue;
    if (meta.ancestralXing) dynasty.ancestralXing = meta.ancestralXing;
    if (meta.clanShi) dynasty.clanShi = meta.clanShi;
  }

  for (const person of persons) {
    const override = FEUDAL_PERSON_CLAN_OVERRIDES[person.id];
    if (override?.ancestralXing) person.ancestralXing = override.ancestralXing;
    if (override?.clanShi) person.clanShi = override.clanShi;

    const dynastyId = dynastyMap.get(person.id);
    if (!dynastyId) continue;

    for (const rule of FEUDAL_PERSON_CLAN_RULES) {
      if (rule.dynastyId && rule.dynastyId !== dynastyId) continue;
      if (!person.name.startsWith(rule.matchNamePrefix)) continue;
      if (rule.ancestralXing && !person.ancestralXing) {
        person.ancestralXing = rule.ancestralXing;
      }
      if (rule.clanShi && !person.clanShi) {
        person.clanShi = rule.clanShi;
      }
    }
  }

  return { persons, dynasties };
}
