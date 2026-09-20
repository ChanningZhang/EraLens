import { firstAppellation } from "./appellationFields";
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

/** Stored 姓/氏 and person-level 庙谥 from import. */
export type PersonDisplayContext = {
  personAncestralXing?: string | null;
  personClanShi?: string | null;
  dynastyAncestralXing?: string | null;
  dynastyClanShi?: string | null;
  posthumousNames?: string[];
  templeNames?: string[];
};

/** @deprecated Use PersonDisplayContext */
export type PreQinClanContext = PersonDisplayContext;

export function buildPreQinClanContext(
  person?: {
    ancestralXing?: string | null;
    clanShi?: string | null;
    posthumousNames?: string[];
    templeNames?: string[];
  } | null,
  dynasty?: {
    ancestralXing?: string | null;
    clanShi?: string | null;
  } | null,
): PersonDisplayContext {
  return {
    personAncestralXing: person?.ancestralXing,
    personClanShi: person?.clanShi,
    dynastyAncestralXing: dynasty?.ancestralXing,
    dynastyClanShi: dynasty?.clanShi,
    posthumousNames: person?.posthumousNames,
    templeNames: person?.templeNames,
  };
}

type ReignAppellationFields = Pick<
  Reign,
  "dynastyId" | "start" | "title" | "eraNames" | "preferredAppellation"
>;

type ReignLabelFields = ReignAppellationFields & Pick<Reign, "title">;

function eraNameList(reign: ReignAppellationFields): string[] {
  return reign.eraNames.filter(Boolean);
}

function firstEraName(reign: ReignAppellationFields): string | undefined {
  return eraNameList(reign)[0];
}

function resolvePosthumousAppellation(
  personContext?: PersonDisplayContext | null,
): EmperorAppellation | null {
  const name = firstAppellation(personContext?.posthumousNames);
  if (!name) return null;
  return { kind: "posthumous", name };
}

function resolveTempleAppellation(
  personContext?: PersonDisplayContext | null,
): EmperorAppellation | null {
  const name = firstAppellation(personContext?.templeNames);
  if (!name) return null;
  return { kind: "temple", name: name };
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
  personContext?: PersonDisplayContext | null,
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
    const temple = resolveTempleAppellation(personContext);
    if (temple) return temple;
  }

  const posthumous = resolvePosthumousAppellation(personContext);
  if (posthumous) return posthumous;

  const temple = resolveTempleAppellation(personContext);
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

/** Drop stored 姓 prefix from persons.name (import stores 姓+私名). */
export function stripAncestralXing(
  name: string,
  clan?: PersonDisplayContext | null,
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
  clan?: PersonDisplayContext | null,
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
  clan?: PersonDisplayContext | null,
  reign?: ReignLabelFields | null,
): Array<{ label: string; value: string }> {
  const { xing, shi } = resolvePreQinXingShi(personName, clan);
  const facts: Array<{ label: string; value: string }> = [];
  if (xing) facts.push({ label: "姓", value: xing });
  if (shi) facts.push({ label: "氏", value: shi });
  const given = reign
    ? resolvePreQinGivenName(reign, personName, clan)
    : personName && !isPlaceholderPersonName(personName)
      ? stripAncestralXing(personName, clan)
      : null;
  if (given) facts.push({ label: "名", value: given });
  return facts;
}

/**
 * Pre-Qin card primary: stored 谥号, then regnal preferred, else title.
 * `{国}王{私名}` bodies are baked into preferred at import
 * (`preQinRegnalCardName`); runtime does not parse title.
 */
function resolvePreQinCardAppellation(
  personContext?: PersonDisplayContext | null,
): string | null {
  const posthumous = firstAppellation(personContext?.posthumousNames);
  if (posthumous) return posthumous;
  return null;
}

function resolvePreQinCardPrimary(
  reign: ReignLabelFields,
  personContext?: PersonDisplayContext | null,
): string | null {
  const posthumous = resolvePreQinCardAppellation(personContext);
  if (posthumous) return posthumous;
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
  personContext?: PersonDisplayContext | null,
): string | null {
  if (!personName || isPlaceholderPersonName(personName)) return null;
  if (personName === reign.title || personName === reign.preferredAppellation?.name) {
    return null;
  }
  const given = stripAncestralXing(personName, personContext);
  if (!given) return null;
  const appellation = resolvePreQinCardPrimary(reign, personContext);
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
  personContext?: PersonDisplayContext | null,
): string {
  if (usesPreQinCardLayout(reign)) {
    return (
      resolvePreQinCardPrimary(reign, personContext) ??
      personalNamePrimary(reign, personName)
    );
  }
  return personalNamePrimary(reign, personName);
}

type ReignCardLabelOptions = {
  cardWidthPx?: number;
  clan?: PersonDisplayContext | null;
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
  personContext?: PersonDisplayContext | null,
): string | null {
  if (!usesPreQinCardLayout(reign)) return personName || null;
  return resolvePreQinGivenName(reign, personName, personContext);
}

/** Label for reign cards listed under a pre-Qin person detail panel. */
export function resolveReignRelatedLabel(
  reign: ReignLabelFields,
  dynastyName?: string | null,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
): string {
  const dynastyPart = dynastyName ?? "";
  if (usesPreQinCardLayout(reign)) {
    const primary = resolveReignPrimaryLabel(reign, personName, personContext);
    return dynastyPart ? `${dynastyPart} · ${primary}` : primary;
  }
  return resolveReignDetailSubtitle(reign, dynastyName, personName, personContext);
}

/** Subtitle for reign detail and dynasty related lists. */
export function resolveReignDetailSubtitle(
  reign: ReignAppellationFields,
  dynastyName?: string | null,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
): string {
  if (isRocTaiwanLeaderReign(reign)) {
    return resolveRocReignDetailSubtitle();
  }
  const dynastyPart = dynastyName ?? "";
  const primary = resolveReignPrimaryLabel(reign, personName, personContext);
  if (usesPreQinCardLayout(reign)) {
    const given = resolvePreQinGivenName(reign, personName, personContext);
    if (given && given !== primary) {
      return dynastyPart ? `${dynastyPart} · ${given}` : given;
    }
    return dynastyPart || primary;
  }
  const appellation = resolveEmperorAppellation(reign, personContext);
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
  personContext?: PersonDisplayContext | null,
): Array<{ label: string; value: string }> {
  const facts = [
    { label: "在位", value: `${reign.start.year} — ${reign.end.year}` },
  ];
  if (usesPreQinCardLayout(reign)) {
    facts.push(...resolvePreQinNameFacts(personName, personContext, reign));
  }
  const posthumous = personContext?.posthumousNames?.filter(Boolean) ?? [];
  if (posthumous.length) {
    facts.push({ label: "谥号", value: posthumous.join("、") });
  }
  const temples = personContext?.templeNames?.filter(Boolean) ?? [];
  if (temples.length) {
    facts.push({ label: "庙号", value: temples.join("、") });
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
  personContext?: PersonDisplayContext | null,
): string {
  const label = resolveReignPrimaryLabel(reign, personName, personContext);
  if (usesPreQinCardLayout(reign)) {
    const given = resolvePreQinGivenName(reign, personName, personContext);
    if (given && given !== label) return given;
  }
  const resolvedPersonName = personName ?? reign.title;
  if (label !== resolvedPersonName) return resolvedPersonName;
  const appellation = resolveEmperorAppellation(reign, personContext);
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
  personContext?: PersonDisplayContext | null,
): { label: string; name: string } | null {
  const primary = resolveReignPrimaryLabel(reign, personName, personContext);
  if (usesPreQinCardLayout(reign)) {
    const given = resolvePreQinGivenName(reign, personName, personContext);
    if (!given || givenNameIsRedundant(primary, given)) return null;
    return { label: "名", name: given };
  }

  const appellation = resolveEmperorAppellation(reign, personContext);
  if (!appellation) return null;

  if (isRedundantCardMeta(appellation, primary, personName)) {
    return null;
  }

  return { label: APPELLATION_LABELS[appellation.kind], name: appellation.name };
}
