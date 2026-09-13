/**
 * Default preferred_appellation for import scripts.
 * Mirrors packages/shared/src/emperorAppellation.ts::resolveEmperorAppellation,
 * but uses title (often with dynasty prefix) for posthumous/temple display names.
 */
export function defaultPreferredAppellation({
  title,
  posthumous,
  temple,
  startYear,
  eraNames = [],
}) {
  const eraName = eraNames[0]?.name;
  if (startYear >= 1368 && eraName) {
    return { kind: "era", name: eraName };
  }
  if (startYear >= 618 && temple) {
    return { kind: "temple", name: title };
  }
  if (posthumous) {
    return { kind: "posthumous", name: posthumous };
  }
  if (temple) {
    return { kind: "temple", name: temple };
  }
  if (eraName) {
    return { kind: "era", name: eraName };
  }
  return { kind: "regnal", name: title };
}
