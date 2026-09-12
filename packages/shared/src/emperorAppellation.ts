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

/** Primary label for a reign card or detail title: personal name, then title. */
export function resolveReignPrimaryLabel(
  reign: ReignAppellationFields & Pick<Reign, "title">,
  personName?: string | null,
): string {
  return personName ?? reign.title;
}

type ReignCardLabelOptions = {
  cardWidthPx?: number;
  dynastyId?: string;
};

/**
 * Label rendered on a reign card. On narrow cards, Song rulers with a 谥号
 * show the short posthumous form (平公) instead of a clipped 子+名 (子成→「了」).
 */
export function resolveReignCardLabel(
  reign: ReignAppellationFields & Pick<Reign, "title">,
  personName?: string | null,
  options?: ReignCardLabelOptions,
): string {
  const primary = resolveReignPrimaryLabel(reign, personName);
  const appellation = resolveEmperorAppellation(reign);
  const width = options?.cardWidthPx;
  if (width == null || !appellation) return primary;

  const primaryGlyphs = [...primary].length;
  const appellationGlyphs = [...appellation.name].length;

  if (
    options.dynastyId === "song-chunqiu" &&
    width < 48 &&
    appellation.kind === "posthumous"
  ) {
    return appellation.name;
  }
  if (appellationGlyphs < primaryGlyphs && width < 40) {
    return appellation.name;
  }
  return primary;
}

/** Secondary line shown when the card has enough space. */
export function resolveReignCardMeta(
  reign: ReignAppellationFields,
  personName?: string | null,
): { label: string; name: string } | null {
  const appellation = resolveEmperorAppellation(reign);
  if (!appellation) return null;
  const primary = resolveReignPrimaryLabel(reign, personName);
  // Early rulers (e.g. Qin) often lack a recorded personal name; the title
  // is used as a fallback, so skip a duplicate "称号 秦襄公" subtitle.
  if (appellation.name === primary || appellation.name === personName) {
    return null;
  }
  return { label: APPELLATION_LABELS[appellation.kind], name: appellation.name };
}
