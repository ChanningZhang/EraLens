import {
  MING_QING_START_YEAR,
  PRE_IMPERIAL_START_YEAR,
  TEMPLE_ERA_START_YEAR,
} from "./appellationPolicy";
import {
  isRocTaiwanLeaderReign,
  ROC_TAIWAN_LEADER_OFFICE_LABEL,
  resolveRocReignDetailSubtitle,
} from "./rocTaiwanLeaderDisplay";
import type { AppellationKind, Reign } from "./schema";

export {
  MING_QING_START_YEAR,
  PRE_IMPERIAL_START_YEAR,
  TEMPLE_ERA_START_YEAR,
} from "./appellationPolicy";

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

const PLACEHOLDER_PERSON_NAME = /^(缺失|史料缺|不明)$/;

/** Stored 姓/氏 from import (person + dynasty rows). */
export type PreQinClanContext = {
  personAncestralXing?: string | null;
  personClanShi?: string | null;
  dynastyAncestralXing?: string | null;
  dynastyClanShi?: string | null;
};

export function buildPreQinClanContext(
  person?: {
    ancestralXing?: string | null;
    clanShi?: string | null;
  } | null,
  dynasty?: {
    ancestralXing?: string | null;
    clanShi?: string | null;
  } | null,
): PreQinClanContext {
  return {
    personAncestralXing: person?.ancestralXing,
    personClanShi: person?.clanShi,
    dynastyAncestralXing: dynasty?.ancestralXing,
    dynastyClanShi: dynasty?.clanShi,
  };
}

type ReignAppellationFields = Pick<
  Reign,
  | "dynastyId"
  | "start"
  | "title"
  | "posthumousName"
  | "templeName"
  | "eraNames"
  | "preferredAppellation"
>;

type ReignLabelFields = ReignAppellationFields & Pick<Reign, "title">;

function eraNameList(reign: ReignAppellationFields): string[] {
  return reign.eraNames.map((era) => era.name).filter(Boolean);
}

function firstEraName(reign: ReignAppellationFields): string | undefined {
  return eraNameList(reign)[0];
}

function resolvePosthumousAppellation(
  reign: ReignAppellationFields,
): EmperorAppellation | null {
  if (!reign.posthumousName) return null;
  return { kind: "posthumous", name: reign.posthumousName };
}

function resolveTempleAppellation(
  reign: ReignAppellationFields,
): EmperorAppellation | null {
  if (!reign.templeName) return null;
  return { kind: "temple", name: reign.templeName };
}

/**
 * Resolve the one conventional appellation shown on a ruler card.
 *
 * Historical defaults:
 * - Before Tang: short posthumous names were the common shorthand;
 *   if none, the stored title (史称 live here, not in posthumous_name).
 * - Tang through Yuan: temple names became the common shorthand.
 * - Ming and Qing: era names became the common shorthand.
 *
 * `preferredAppellation` is only honored for regnal overrides (先秦称号、
 * 秦襄公等). Era/temple/posthumous display follows the year thresholds below
 * so changing `TEMPLE_ERA_START_YEAR` applies to every dynasty without
 * re-importing baked SQL defaults.
 */
export function resolveEmperorAppellation(
  reign: ReignAppellationFields,
): EmperorAppellation | null {
  if (isRocTaiwanLeaderReign(reign)) {
    return { kind: "regnal", name: ROC_TAIWAN_LEADER_OFFICE_LABEL };
  }
  if (reign.preferredAppellation?.kind === "regnal") {
    return reign.preferredAppellation;
  }

  const eraName = firstEraName(reign);
  const year = reign.start.year;

  if (year >= MING_QING_START_YEAR && eraName) {
    return { kind: "era", name: eraName };
  }
  if (year >= TEMPLE_ERA_START_YEAR) {
    const temple = resolveTempleAppellation(reign);
    if (temple) return temple;
  }

  const posthumous = resolvePosthumousAppellation(reign);
  if (posthumous) return posthumous;

  const temple = resolveTempleAppellation(reign);
  if (temple) return temple;

  if (year < TEMPLE_ERA_START_YEAR && reign.title) {
    return { kind: "regnal", name: reign.title };
  }

  if (eraName) {
    return { kind: "era", name: eraName };
  }
  if (reign.title) {
    return { kind: "regnal", name: reign.title };
  }
  return null;
}

/** True for 天子/诸侯 reigns before 始皇帝; imperial cards keep name-first layout. */
export function usesPreQinCardLayout(reign: Pick<Reign, "start">): boolean {
  return reign.start.year < PRE_IMPERIAL_START_YEAR;
}

/** Drop stored 姓 prefix; keep 氏 embedded in names (熊侣, 吕尚). */
export function stripAncestralXing(
  name: string,
  clan?: PreQinClanContext | null,
): string {
  const xing = clan?.personAncestralXing ?? clan?.dynastyAncestralXing;
  if (!xing || !name.startsWith(xing) || name.length <= xing.length) {
    return name;
  }
  return name.slice(xing.length);
}

function isPlaceholderPersonName(name: string): boolean {
  return PLACEHOLDER_PERSON_NAME.test(name);
}

/** Resolve 姓/氏 for pre-imperial rulers from stored DB fields only. */
export function resolvePreQinXingShi(
  _personName?: string | null,
  clan?: PreQinClanContext | null,
): { xing?: string; shi?: string } {
  const xing =
    clan?.personAncestralXing ?? clan?.dynastyAncestralXing ?? undefined;
  const shi = clan?.personClanShi ?? clan?.dynastyClanShi ?? undefined;
  if (!xing && !shi) return {};
  return { ...(xing ? { xing } : {}), ...(shi ? { shi } : {}) };
}

/** Detail-panel facts for pre-imperial personal names. */
export function resolvePreQinNameFacts(
  personName: string | null | undefined,
  clan?: PreQinClanContext | null,
  _reign?: ReignLabelFields | null,
): Array<{ label: string; value: string }> {
  const { xing, shi } = resolvePreQinXingShi(personName, clan);
  const facts: Array<{ label: string; value: string }> = [];
  if (xing) facts.push({ label: "姓", value: xing });
  if (shi) facts.push({ label: "氏", value: shi });
  return facts;
}

/**
 * Pre-Qin card primary: stored 谥号, then regnal preferred, else title.
 * `{国}王{私名}` bodies are baked into preferred at import
 * (`preQinRegnalCardName`); runtime does not parse title.
 */
function resolvePreQinCardAppellation(reign: ReignLabelFields): string | null {
  if (reign.posthumousName) return reign.posthumousName;
  const preferred =
    reign.preferredAppellation?.kind === "regnal"
      ? reign.preferredAppellation.name
      : null;
  if (preferred) return preferred;
  return reign.title || null;
}

function resolvePreQinGivenName(
  reign: ReignLabelFields,
  personName?: string | null,
  clan?: PreQinClanContext | null,
): string | null {
  if (!personName || isPlaceholderPersonName(personName)) return null;
  if (personName === reign.title || personName === reign.preferredAppellation?.name) {
    return null;
  }
  const given = stripAncestralXing(personName, clan);
  if (!given) return null;
  const appellation = resolvePreQinCardAppellation(reign);
  if (appellation && givenNameIsRedundant(appellation, given)) return null;
  return given;
}

function personalNamePrimary(
  reign: ReignLabelFields,
  personName?: string | null,
): string {
  const appellationName = reign.preferredAppellation?.name;
  if (
    !personName ||
    personName === reign.title ||
    personName === appellationName
  ) {
    return personName || reign.title;
  }
  return personName;
}

/** Primary label for a reign card or detail title. */
export function resolveReignPrimaryLabel(
  reign: ReignLabelFields,
  personName?: string | null,
  clan?: PreQinClanContext | null,
): string {
  if (usesPreQinCardLayout(reign)) {
    return (
      resolvePreQinCardAppellation(reign) ??
      personalNamePrimary(reign, personName)
    );
  }
  return personalNamePrimary(reign, personName);
}

type ReignCardLabelOptions = {
  cardWidthPx?: number;
  clan?: PreQinClanContext | null;
};

/** Primary label rendered on a reign card. */
export function resolveReignCardLabel(
  reign: ReignLabelFields,
  personName?: string | null,
  options?: ReignCardLabelOptions,
): string {
  return resolveReignPrimaryLabel(reign, personName, options?.clan);
}

/** Given name shown as card meta / tooltip for pre-Qin rulers. */
export function resolveReignCardGivenName(
  reign: ReignLabelFields,
  personName?: string | null,
  clan?: PreQinClanContext | null,
): string | null {
  if (!usesPreQinCardLayout(reign)) return personName || null;
  return resolvePreQinGivenName(reign, personName, clan);
}

/** Subtitle for reign detail and dynasty related lists. */
export function resolveReignDetailSubtitle(
  reign: ReignAppellationFields,
  dynastyName?: string | null,
  personName?: string | null,
  clan?: PreQinClanContext | null,
): string {
  if (isRocTaiwanLeaderReign(reign)) {
    return resolveRocReignDetailSubtitle();
  }
  const dynastyPart = dynastyName ?? "";
  const primary = resolveReignPrimaryLabel(reign, personName, clan);
  if (usesPreQinCardLayout(reign)) {
    const given = resolvePreQinGivenName(reign, personName, clan);
    if (given && given !== primary) {
      return dynastyPart ? `${dynastyPart} · ${given}` : given;
    }
    return dynastyPart || primary;
  }
  const appellation = resolveEmperorAppellation(reign);
  const conventional = appellation?.name ?? reign.title;
  if (conventional === primary || conventional === personName) {
    return dynastyPart || primary;
  }
  return dynastyPart ? `${dynastyPart} · ${conventional}` : conventional;
}

type ReignDetailFactsFields = ReignAppellationFields &
  Pick<Reign, "start" | "end" | "eraNames">;

/** Structured facts for reign detail panels. */
export function resolveReignDetailFacts(
  reign: ReignDetailFactsFields,
  personName?: string | null,
  clan?: PreQinClanContext | null,
): Array<{ label: string; value: string }> {
  const facts = [
    { label: "在位", value: `${reign.start.year} — ${reign.end.year}` },
  ];
  if (usesPreQinCardLayout(reign)) {
    facts.push(...resolvePreQinNameFacts(personName, clan, reign));
  }
  if (reign.posthumousName) {
    facts.push({ label: "谥号", value: reign.posthumousName });
  }
  if (reign.templeName) {
    facts.push({ label: "庙号", value: reign.templeName });
  }
  const eras = eraNameList(reign);
  if (eras.length) {
    facts.push({ label: "年号", value: eras.join("、") });
  }
  return facts;
}

/** Subtitle for a reign listed under its dynasty. */
export function resolveReignRelatedSubtitle(
  reign: ReignAppellationFields,
  personName?: string | null,
  clan?: PreQinClanContext | null,
): string {
  const label = resolveReignPrimaryLabel(reign, personName, clan);
  if (usesPreQinCardLayout(reign)) {
    const given = resolvePreQinGivenName(reign, personName, clan);
    if (given && given !== label) return given;
  }
  const resolvedPersonName = personName ?? reign.title;
  if (label !== resolvedPersonName) return resolvedPersonName;
  const appellation = resolveEmperorAppellation(reign);
  return appellation?.name ?? reign.title;
}

function givenNameIsRedundant(primary: string, given: string): boolean {
  return given === primary || primary.endsWith(given) || primary.startsWith(given);
}

function isRedundantCardMeta(
  appellation: EmperorAppellation,
  primary: string,
  personName?: string | null,
): boolean {
  return appellation.name === primary || appellation.name === personName;
}

/** Secondary line shown when the card has enough space. */
export function resolveReignCardMeta(
  reign: ReignAppellationFields,
  personName?: string | null,
  clan?: PreQinClanContext | null,
): { label: string; name: string } | null {
  const primary = resolveReignPrimaryLabel(reign, personName, clan);
  if (usesPreQinCardLayout(reign)) {
    const given = resolvePreQinGivenName(reign, personName, clan);
    if (!given || givenNameIsRedundant(primary, given)) return null;
    return { label: "名", name: given };
  }

  const appellation = resolveEmperorAppellation(reign);
  if (!appellation) return null;

  if (isRedundantCardMeta(appellation, primary, personName)) {
    return null;
  }

  return { label: APPELLATION_LABELS[appellation.kind], name: appellation.name };
}
