import { firstAppellation } from "./appellationFields";
import {
  isRocTaiwanLeaderReign,
  resolveRocReignDetailSubtitle,
} from "./rocTaiwanLeaderDisplay";
import {
  PRE_IMPERIAL_START_YEAR,
  REPUBLIC_ERA_START_YEAR,
  TEMPLE_ERA_START_YEAR,
} from "./appellationPolicy";
import type { AppellationKind, Reign } from "./schema";
import { formatReignDurationLabel, formatReignYearRange } from "./reignVisual";

export {
  PRE_IMPERIAL_START_YEAR,
  REPUBLIC_ERA_START_YEAR,
  TEMPLE_ERA_START_YEAR,
} from "./appellationPolicy";

export type EmperorAppellation = {
  kind: AppellationKind;
  name: string;
};

export const APPELLATION_LABELS: Record<AppellationKind, string> = {
  posthumous: "谥号",
  temple: "庙号",
  regnal: "称号",
};

const PLACEHOLDER_PERSON_NAME = /^(缺失|史料缺|不明)$/;

/** Stored 姓/氏 and person-level 庙谥 from import. */
export type PersonDisplayContext = {
  title?: string | null;
  personAncestralXing?: string | null;
  personClanShi?: string | null;
  posthumousNames?: string[];
  templeNames?: string[];
};

/** @deprecated Use PersonDisplayContext */
export type PreQinClanContext = PersonDisplayContext;

export function buildPreQinClanContext(
  person?: {
    title?: string | null;
    ancestralXing?: string | null;
    clanShi?: string | null;
    posthumousNames?: string[];
    templeNames?: string[];
  } | null,
): PersonDisplayContext {
  return {
    title: person?.title,
    personAncestralXing: person?.ancestralXing,
    personClanShi: person?.clanShi,
    posthumousNames: person?.posthumousNames,
    templeNames: person?.templeNames,
  };
}

type ReignAppellationFields = Pick<
  Reign,
  "dynastyId" | "start" | "title" | "eraNames"
>;

type ReignLabelFields = ReignAppellationFields & Pick<Reign, "title">;

function eraNameList(reign: ReignAppellationFields): string[] {
  return reign.eraNames.filter(Boolean);
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

/** Resolve the conventional appellation used by reign detail labels. */
export function resolveEmperorAppellation(
  reign: ReignAppellationFields,
  personContext?: PersonDisplayContext | null,
): EmperorAppellation | null {
  const year = reign.start.year;

  if (year >= TEMPLE_ERA_START_YEAR) {
    const temple = resolveTempleAppellation(personContext);
    if (temple) return temple;
  }

  const posthumous = resolvePosthumousAppellation(personContext);
  if (posthumous) return posthumous;

  const temple = resolveTempleAppellation(personContext);
  if (temple) return temple;

  const title = reign.title.trim();
  if (title) {
    return { kind: "regnal", name: title };
  }
  return null;
}

function firstNonEmpty(...values: Array<string | null | undefined>): string | null {
  for (const value of values) {
    const trimmed = value?.trim();
    if (trimmed) return trimmed;
  }
  return null;
}

/** Large title in person details: name, then posthumous name, then stored person title. */
export function resolvePersonDetailTitle(
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
): string {
  return firstNonEmpty(
    personName,
    resolvePosthumousAppellation(personContext)?.name,
    personContext?.title,
  ) ?? "";
}

function joinDetailHeading(dynastyName: string | undefined, appellation: string | null): string {
  return [dynastyName, appellation].filter(Boolean).join(" · ");
}

/** True for 天子/诸侯 reigns before 始皇帝; imperial cards keep name-first layout. */
export function usesPreQinCardLayout(reign: Pick<Reign, "start">): boolean {
  return reign.start.year < PRE_IMPERIAL_START_YEAR;
}

function isPlaceholderPersonName(name: string): boolean {
  return PLACEHOLDER_PERSON_NAME.test(name);
}

/** Resolve 姓/氏 for pre-imperial rulers from stored DB fields only. */
export function resolvePreQinXingShi(
  _personName?: string | null,
  clan?: PersonDisplayContext | null,
): { xing?: string; shi?: string } {
  const xing = clan?.personAncestralXing ?? undefined;
  const shi = clan?.personClanShi ?? undefined;
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
      ? personName
      : null;
  if (given) facts.push({ label: "名", value: given });
  return facts;
}

/** Pre-Qin card primary: use the stored person-level 谥号 when available. */
function resolvePreQinCardPrimary(
  personContext?: PersonDisplayContext | null,
): string | null {
  const posthumous = firstAppellation(personContext?.posthumousNames);
  return posthumous || null;
}

function resolvePreQinGivenName(
  reign: ReignLabelFields,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
): string | null {
  if (!personName || isPlaceholderPersonName(personName)) return null;
  const appellation =
    resolvePreQinCardPrimary(personContext) ??
    firstNonEmpty(reign.title) ??
    personName;
  if (!appellation || givenNameIsRedundant(appellation, personName)) return null;
  return personName;
}

function personalNamePrimary(personName?: string | null): string {
  return personName?.trim() ?? "";
}

/** Primary label for a reign card or detail title. */
export function resolveReignPrimaryLabel(
  reign: ReignLabelFields,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
): string {
  const personalName = personalNamePrimary(personName);
  if (!personalName) {
    return firstNonEmpty(
      personContext?.title,
      resolvePosthumousAppellation(personContext)?.name,
    ) ?? "";
  }
  if (usesPreQinCardLayout(reign)) {
    return (
      resolvePreQinCardPrimary(personContext) ??
      personalName
    );
  }
  return personalName;
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
  const heading = resolveReignDetailHeading(
    reign,
    isRocTaiwanLeaderReign(reign) ? undefined : dynastyName,
    personName,
    personContext,
    { focusedReign: true },
  );
  if (isRocTaiwanLeaderReign(reign)) {
    if (!heading) return "";
    return [resolveRocReignDetailSubtitle(), heading]
      .filter(Boolean)
      .join(" · ");
  }
  return heading;
}

type ReignDetailFactsFields = ReignAppellationFields &
  Pick<
    Reign,
    | "end"
    | "startAbs"
    | "endAbs"
    | "precision"
    | "isOngoing"
  >;

/** Structured facts for reign detail panels. */
export function resolveReignDetailFacts(
  reign: ReignDetailFactsFields,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
  options: { durationLabel?: string | null } = {},
): Array<{ label: string; value: string }> {
  const duration = options.durationLabel === undefined
    ? formatReignDurationLabel(reign)
    : options.durationLabel;
  const facts = [
    {
      label: "在位",
      value: duration
        ? `${formatReignYearRange(reign)} · ${duration}`
        : formatReignYearRange(reign),
    },
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
  return resolveReignDetailHeading(
    reign,
    undefined,
    personName,
    personContext,
    { focusedReign: true },
  );
}

function givenNameIsRedundant(primary: string, given: string): boolean {
  return given === primary || primary.endsWith(given) || primary.startsWith(given);
}

/** Card small-text preference, independent from the large primary label. */
export function resolveReignCardAppellation(
  reign: ReignAppellationFields | null | undefined,
  personContext?: PersonDisplayContext | null,
): EmperorAppellation | null {
  if (!reign) {
    return (
      resolvePosthumousAppellation(personContext) ??
      resolveTempleAppellation(personContext)
    );
  }

  const title = firstNonEmpty(reign.title);
  const personTitle = firstNonEmpty(personContext?.title);
  if (title) return { kind: "regnal", name: title };

  if (reign.start.year < PRE_IMPERIAL_START_YEAR) return null;
  if (reign.start.year < TEMPLE_ERA_START_YEAR) {
    return (
      resolvePosthumousAppellation(personContext) ??
      (personTitle ? { kind: "regnal", name: personTitle } : null)
    );
  }
  if (reign.start.year < REPUBLIC_ERA_START_YEAR) {
    return (
      resolveTempleAppellation(personContext) ??
      resolvePosthumousAppellation(personContext) ??
      (personTitle ? { kind: "regnal", name: personTitle } : null)
    );
  }
  return null;
}

/** Person-detail heading rule, separate from swimlane card title selection. */
export type ReignDetailHeadingOptions = {
  /** False for an unfocused person detail, which uses person-level fields only. */
  focusedReign?: boolean;
  /** Era anchor for an unfocused person, from earliest reign or birth date. */
  periodYear?: number | null;
};

/** Person-detail headings use period appellations before falling back to title. */
export function resolveReignDetailHeading(
  reign: ReignAppellationFields | null | undefined,
  dynastyName?: string | null,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
  options: ReignDetailHeadingOptions = {},
): string {
  const focusedReign = options.focusedReign ?? Boolean(reign);
  const year = focusedReign ? reign?.start.year : options.periodYear;
  const posthumous = resolvePosthumousAppellation(personContext)?.name ?? null;
  const temple = resolveTempleAppellation(personContext)?.name ?? null;
  const personTitle = firstNonEmpty(personContext?.title);

  if (focusedReign) {
    const title = firstNonEmpty(reign?.title);
    if (title) return joinDetailHeading(dynastyName ?? undefined, title);
    if (year == null || year >= REPUBLIC_ERA_START_YEAR) return "";
    const fallback =
      year < PRE_IMPERIAL_START_YEAR
        ? posthumous
        : year < TEMPLE_ERA_START_YEAR
          ? posthumous ?? personTitle
          : temple ?? posthumous ?? personTitle;
    return joinDetailHeading(dynastyName ?? undefined, fallback);
  }

  if (year == null) {
    return joinDetailHeading(dynastyName ?? undefined, personTitle ?? firstNonEmpty(personName));
  }
  if (year < TEMPLE_ERA_START_YEAR) {
    return joinDetailHeading(dynastyName ?? undefined, posthumous ?? personTitle);
  }
  if (year < REPUBLIC_ERA_START_YEAR) {
    return joinDetailHeading(
      dynastyName ?? undefined,
      temple ?? posthumous ?? personTitle,
    );
  }
  return joinDetailHeading(dynastyName ?? undefined, personTitle);
}

/** Secondary line shown when the card has enough space. */
export function resolveReignCardMeta(
  reign: ReignAppellationFields,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
): { label: string; name: string } | null {
  const primary = resolveReignPrimaryLabel(reign, personName, personContext);
  const candidates: Array<{ label: string; name: string }> = [];
  const title = firstNonEmpty(reign.title);
  if (title) candidates.push({ label: APPELLATION_LABELS.regnal, name: title });

  if (usesPreQinCardLayout(reign)) {
    const givenName = firstNonEmpty(personName);
    if (givenName) candidates.push({ label: "名", name: givenName });
  } else {
    const appellation = resolveReignCardAppellation(
      { ...reign, title: "" },
      personContext,
    );
    if (appellation) {
      candidates.push({ label: APPELLATION_LABELS[appellation.kind], name: appellation.name });
    }
  }

  return candidates.find((candidate) => candidate.name !== primary) ?? null;
}
