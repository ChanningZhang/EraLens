import type { Dynasty, Person, Reign } from "./schema";

/** Search terms are stored without whitespace so DB and mock lookup agree. */
export function normalizeSearchTerm(term: string): string {
  return term.trim().toLowerCase().replace(/\s+/gu, "");
}

function appellations(person: Person): string[] {
  return [...(person.posthumousNames ?? []), ...(person.templeNames ?? [])];
}

function privateNameWithoutStoredClan(person: Person): string {
  for (const prefix of [person.ancestralXing, person.clanShi]) {
    if (prefix && person.name.startsWith(prefix) && person.name.length > prefix.length) {
      return person.name.slice(prefix.length);
    }
  }
  return person.name;
}

/**
 * Build the persisted person search aliases from structured fields.
 * PostgreSQL mirrors this rule in rebuild_person_search_terms().
 */
export function buildPersonSearchTerms(
  person: Person,
  reigns: Reign[],
  dynasties: Dynasty[],
): string[] {
  const terms = new Set<string>();
  const add = (value: string | undefined) => {
    if (!value) return;
    const normalized = normalizeSearchTerm(value);
    if (normalized) terms.add(normalized);
  };

  add(person.name);
  for (const alias of person.altNames ?? []) add(alias);
  for (const appellation of appellations(person)) add(appellation);

  const privateName = privateNameWithoutStoredClan(person);
  if (person.ancestralXing) add(`${person.ancestralXing}${privateName}`);
  if (person.clanShi) add(`${person.clanShi}${privateName}`);

  const dynastyById = new Map(dynasties.map((dynasty) => [dynasty.id, dynasty]));
  for (const reign of reigns) {
    if (reign.personId !== person.id) continue;
    add(reign.title);
    const dynasty = dynastyById.get(reign.dynastyId);
    if (!dynasty) continue;
    for (const dynastyName of [dynasty.name, ...(dynasty.altNames ?? [])]) {
      for (const appellation of appellations(person)) {
        add(`${dynastyName}${appellation}`);
      }
    }
  }

  return [...terms].sort((left, right) => left.localeCompare(right, "zh-CN"));
}
