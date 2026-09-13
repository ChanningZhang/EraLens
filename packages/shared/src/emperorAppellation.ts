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

/** Ming/Qing cards conventionally show era names. */
const MING_QING_START_YEAR = 1368;
/** Tang through Yuan cards conventionally show temple names. */
const TEMPLE_ERA_START_YEAR = 618;

const MESSY_PERSON_NAME =
  /出土|原名|记载|史記|史记|漢書|汉书|之子|之弟|之孫|之孙|之兄|長子|长子|少子|别名|又名|又称|或作|一名|一作|之侯|避讳|误作|旧作|左右|不满|后裔|族人|三世|不明|灭亡/;

/** Rare or inscription forms mapped to displayable modern names. */
const PERSON_NAME_ALIASES: Record<string, string> = {
  "𧊒": "胜",
};

const STATE_PREFIX =
  /^(齐|晋|楚|燕|宋|鲁|卫|郑|曹|吴|越|韩|赵|魏|秦|中山|田)/;

type ReignAppellationFields = Pick<
  Reign,
  | "start"
  | "title"
  | "posthumousName"
  | "templeName"
  | "eraNames"
  | "preferredAppellation"
>;

/** Strip wiki alias noise so cards show a short personal name, not raw table text. */
export function sanitizePersonName(
  name: string | null | undefined,
): string | null {
  if (!name) return null;
  if (PERSON_NAME_ALIASES[name]) return PERSON_NAME_ALIASES[name];
  let s = name
    .replace(/後/g, "后")
    .replace(/異/g, "异")
    .trim();
  if (!s) return null;

  const renamed = s.match(/(?:后)?改名\s*([\u4e00-\u9fff·]{1,8})/);
  if (renamed) return renamed[1];

  if (MESSY_PERSON_NAME.test(s)) {
    const tail = s
      .split(/[，,、]/)
      .pop()
      ?.replace(/(?:后)?改名\s*/, "")
      .trim();
    if (tail && tail.length <= 4 && !MESSY_PERSON_NAME.test(tail)) return tail;
    return null;
  }

  if (s.length > 8) return null;
  return PERSON_NAME_ALIASES[s] ?? s;
}

/** Pull a short given name from Warring States-style regnal titles like 中山王厝. */
export function extractGivenNameFromRegnalTitle(
  title: string,
  appellationName?: string | null,
): string | null {
  const full = appellationName ?? title;
  const prefix = full.match(STATE_PREFIX);
  if (!prefix) return null;
  const stripped = full.slice(prefix[0].length);
  const match = stripped.match(/^王([^\s]{1,2})$/);
  return match?.[1] ?? null;
}

/** Titles like 隋文帝 / 隋炀帝 that already carry the conventional shorthand. */
export function isDynasticEmperorTitle(title: string | null | undefined): boolean {
  if (!title || title === "皇帝" || title === "始皇帝") return false;
  return /^[\u4e00-\u9fff]{2,6}帝$/.test(title);
}

function firstEraName(reign: ReignAppellationFields): string | undefined {
  return reign.eraNames[0]?.name;
}

function templeDisplayName(
  title: string,
  templeName: string,
): string {
  if (title && title !== "皇帝" && title.includes(templeName)) {
    return title;
  }
  return title.length > templeName.length ? title : templeName;
}

function posthumousDisplayName(
  title: string,
  posthumousName: string,
): string {
  if (title && title !== "皇帝") return title;
  return posthumousName;
}

function resolvePosthumousAppellation(
  reign: ReignAppellationFields,
): EmperorAppellation | null {
  if (reign.posthumousName) {
    return {
      kind: "posthumous",
      name: posthumousDisplayName(reign.title, reign.posthumousName),
    };
  }
  if (isDynasticEmperorTitle(reign.title)) {
    return { kind: "posthumous", name: reign.title };
  }
  return null;
}

function resolveTempleAppellation(
  reign: ReignAppellationFields,
): EmperorAppellation | null {
  if (!reign.templeName) return null;
  return {
    kind: "temple",
    name: templeDisplayName(reign.title, reign.templeName),
  };
}

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
  const appellationName = reign.preferredAppellation?.name;
  const fromRegnal =
    reign.preferredAppellation?.kind === "regnal"
      ? extractGivenNameFromRegnalTitle(reign.title, appellationName)
      : null;
  const cleaned = sanitizePersonName(personName);
  const cleanedIsTitle =
    !cleaned || cleaned === reign.title || cleaned === appellationName;

  if (!cleanedIsTitle) return cleaned;
  if (fromRegnal) return fromRegnal;
  return cleaned ?? reign.title;
}

type ReignCardLabelOptions = {
  cardWidthPx?: number;
  dynastyId?: string;
};

/** Primary label rendered on a reign card: always the personal name when known. */
export function resolveReignCardLabel(
  reign: ReignAppellationFields & Pick<Reign, "title">,
  personName?: string | null,
  _options?: ReignCardLabelOptions,
): string {
  return resolveReignPrimaryLabel(reign, personName);
}

/** Subtitle for reign detail and dynasty related lists. */
export function resolveReignDetailSubtitle(
  reign: ReignAppellationFields,
  dynastyName?: string | null,
  _personName?: string | null,
): string {
  const dynastyPart = dynastyName ?? "";
  const appellation = resolveEmperorAppellation(reign);
  const conventional = appellation?.name ?? reign.title;
  return dynastyPart ? `${dynastyPart} · ${conventional}` : conventional;
}

type ReignDetailFactsFields = ReignAppellationFields &
  Pick<Reign, "start" | "end" | "eraNames">;

/** Structured facts for reign detail panels. */
export function resolveReignDetailFacts(
  reign: ReignDetailFactsFields,
): Array<{ label: string; value: string }> {
  const facts = [
    { label: "在位", value: `${reign.start.year} — ${reign.end.year}` },
  ];
  if (reign.posthumousName) {
    facts.push({ label: "谥号", value: reign.posthumousName });
  }
  if (reign.templeName) {
    facts.push({ label: "庙号", value: reign.templeName });
  }
  const era = firstEraName(reign);
  if (era) {
    facts.push({ label: "年号", value: era });
  }
  return facts;
}

/** Subtitle for a reign listed under its dynasty. */
export function resolveReignRelatedSubtitle(
  reign: ReignAppellationFields,
  personName?: string | null,
): string {
  const label = resolveReignPrimaryLabel(reign, personName);
  const resolvedPersonName = personName ?? reign.title;
  if (label !== resolvedPersonName) return resolvedPersonName;
  const appellation = resolveEmperorAppellation(reign);
  return appellation?.name ?? reign.title;
}

function isRedundantCardMeta(
  appellation: EmperorAppellation,
  primary: string,
  personName?: string | null,
): boolean {
  const cleanedPersonName = sanitizePersonName(personName);
  return (
    appellation.name === primary ||
    appellation.name === cleanedPersonName ||
    appellation.name === personName
  );
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
  if (isRedundantCardMeta(appellation, primary, personName)) {
    return null;
  }

  return { label: APPELLATION_LABELS[appellation.kind], name: appellation.name };
}
