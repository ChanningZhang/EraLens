import type { AppellationKind, Reign } from "./schema";

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

type ReignAppellationFields = Pick<
  Reign,
  | "start"
  | "title"
  | "posthumousName"
  | "templeName"
  | "eraNames"
  | "preferredAppellation"
>;

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
  reign: ReignAppellationFields,
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

/** Primary label for a reign card or detail title. */
export function resolveReignPrimaryLabel(
  reign: ReignAppellationFields & Pick<Reign, "title">,
  personName?: string | null,
): string {
  const appellation = resolveEmperorAppellation(reign);
  if (appellation?.kind === "era") return appellation.name;
  return personName ?? reign.title;
}

/** Secondary line shown when the card has enough space. */
export function resolveReignCardMeta(
  reign: ReignAppellationFields,
  personName?: string | null,
): { label: string; name: string } | null {
  const appellation = resolveEmperorAppellation(reign);
  if (appellation?.kind === "era") {
    return personName ? { label: "本名", name: personName } : null;
  }
  return appellation
    ? { label: APPELLATION_LABELS[appellation.kind], name: appellation.name }
    : null;
}
