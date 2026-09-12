import type { AppellationKind, Reign } from "@eralens/shared";

export type EmperorAppellation = {
  kind: AppellationKind;
  name: string;
};

export const APPELLATION_LABELS: Record<AppellationKind, string> = {
  posthumous: "谥号",
  temple: "庙号",
  era: "年号",
  regnal: "称号",
};

/**
 * Resolve the one conventional appellation shown on a ruler card.
 *
 * Historical defaults:
 * - Before Tang: short posthumous names were the common shorthand.
 * - Tang through Yuan: temple names became the common shorthand.
 * - Ming and Qing: era names became the common shorthand.
 *
 * `preferredAppellation` always wins because individual rulers have
 * exceptions. If no posthumous/temple/era name exists (for example Qin),
 * the regnal title remains a valid fallback.
 */
export function resolveEmperorAppellation(
  reign: Pick<
    Reign,
    | "start"
    | "title"
    | "posthumousName"
    | "templeName"
    | "eraNames"
    | "preferredAppellation"
  >,
): EmperorAppellation | null {
  if (reign.preferredAppellation) return reign.preferredAppellation;

  const eraName = reign.eraNames[0]?.name;
  const year = reign.start.year;

  if (year >= 1368 && eraName) {
    return { kind: "era", name: eraName };
  }
  if (year >= 618 && reign.templeName) {
    return { kind: "temple", name: reign.templeName };
  }
  if (reign.posthumousName) {
    return { kind: "posthumous", name: reign.posthumousName };
  }
  if (reign.templeName) {
    return { kind: "temple", name: reign.templeName };
  }
  if (eraName) {
    return { kind: "era", name: eraName };
  }
  if (reign.title) {
    return { kind: "regnal", name: reign.title };
  }
  return null;
}
