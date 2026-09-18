import { isParallelClaim } from "./claimTracks";
import {
  MING_QING_START_YEAR,
  PRE_IMPERIAL_START_YEAR,
  TEMPLE_ERA_START_YEAR,
} from "./appellationPolicy";
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

const MESSY_PERSON_NAME =
  /出土|原名|记载|史記|史记|漢書|汉书|之子|之弟|之孫|之孙|之兄|長子|长子|少子|别名|又名|又称|或作|一名|一作|之侯|避讳|误作|旧作|左右|不满|后裔|族人|三世|不明|灭亡/;

/** Rare or inscription forms mapped to displayable modern names. */
const PERSON_NAME_ALIASES: Record<string, string> = {
  "𧊒": "胜",
};

const STATE_PREFIX =
  /^(齐|晋|楚|燕|宋|鲁|卫|郑|曹|吴|越|韩|赵|魏|秦|中山|田)/;

/**
 * Ancestral 姓 that import pipelines prefix onto given names (姬发, 姜小白).
 * 氏 such as 熊/田/吕/赵/魏/韩/戴/公孙 are not in this list and stay.
 * 任 is omitted so 秦穆公「任好」is not reduced to 「好」.
 */
const ANCESTRAL_XING = ["姬", "姜", "嬴", "姒", "子", "己", "芈", "妫", "姚"] as const;

/** 氏 prefixes embedded in import-time personal names (吕尚, 熊侣, 田因齐). */
const CLAN_SHI_PREFIXES = ["公孙", "吕", "田", "熊", "赵", "魏", "韩", "戴"] as const;

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

/** Leftover after stripping 姓 that would look like a state, not a given name. */
const XING_STRIP_BLOCKLIST = new Set(["楚"]);

const PLACEHOLDER_PERSON_NAME = /^(缺失|史料缺|不明)$/;

/** Last syllable of a regime name, used to reject placeholders like 徐宋帝 / 陈汉帝. */
const REGIME_NAME_FINAL =
  /[齐晋楚燕宋鲁卫郑曹吴越韩赵魏秦汉夏唐隋梁陈周闽元辽金明清蜀]$/;

type ReignAppellationFields = Pick<
  Reign,
  | "start"
  | "title"
  | "posthumousName"
  | "templeName"
  | "eraNames"
  | "preferredAppellation"
  | "claimTrack"
  | "claimLabel"
>;

type ReignLabelFields = ReignAppellationFields & Pick<Reign, "title">;

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
  if (!/^[\u4e00-\u9fff]{2,6}帝$/.test(title)) return false;
  const stem = title.slice(0, -1);
  // "{政权名}帝" (徐宋帝、陈汉帝、明夏帝) has no 谥 body: the last syllable
  // of a 1–2 character stem is the state name itself, not 文/炀/献.
  if (stem.length <= 2 && REGIME_NAME_FINAL.test(stem)) return false;
  return true;
}

function eraNameList(reign: ReignAppellationFields): string[] {
  return reign.eraNames.map((era) => era.name).filter(Boolean);
}

function firstEraName(reign: ReignAppellationFields): string | undefined {
  return eraNameList(reign)[0];
}

function templeDisplayName(_title: string, templeName: string): string {
  return templeName;
}

function posthumousDisplayName(_title: string, posthumousName: string): string {
  return posthumousName;
}

function titleEmbedsEraName(title: string, eraNames: string[]): boolean {
  return eraNames.some((era) => era.length >= 2 && title.includes(era));
}

/** 少帝 / 废帝 / 末帝 / 后主 are conventional 史称, not 谥号. */
export function isConventionalRulerTitle(
  title: string | null | undefined,
): boolean {
  if (!title) return false;
  return /(?:少|废|末)帝$/.test(title) || /后主$/.test(title);
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
  // 元泰定帝 / 元天顺帝 are era-based 史称, not 谥号.
  // 吴末帝 is a conventional 史称, not a 谥号.
  if (
    isDynasticEmperorTitle(reign.title) &&
    !isConventionalRulerTitle(reign.title) &&
    !titleEmbedsEraName(reign.title, eraNameList(reign))
  ) {
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
 * `preferredAppellation` is only honored for regnal overrides (先秦称号、
 * 秦襄公等). Era/temple/posthumous display follows the year thresholds below
 * so changing `TEMPLE_ERA_START_YEAR` applies to every dynasty without
 * re-importing baked SQL defaults.
 */
export function resolveEmperorAppellation(
  reign: ReignAppellationFields,
): EmperorAppellation | null {
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

  if (isConventionalRulerTitle(reign.title)) {
    return { kind: "regnal", name: reign.title };
  }

  if (eraName) {
    return { kind: "era", name: eraName };
  }
  if (reign.title) {
    const stripped = stripStatePrefixFromTitle(reign.title);
    return { kind: "regnal", name: stripped };
  }
  return null;
}

/**
 * Drop state + rank prefixes from pre-imperial titles.
 * 越王无余 → 无余 (wiki 国君姓名); 齐威王 → 威王 (short posthumous-style body).
 */
function stripStatePrefixFromTitle(title: string): string {
  const match = title.match(STATE_PREFIX);
  const stripped = match ? title.slice(match[0].length) : title;
  if (stripped.length < 2) return title;

  const rank = stripped.match(/^([侯王伯])(.+)$/);
  if (!rank) return stripped;

  const body = rank[2];
  // 桓公、威王等谥号式简称保留爵位字后的整体。
  if (/^.{1,2}[公王]$/.test(body)) return stripped;
  return body.length >= 1 ? body : stripped;
}

/** True for 天子/诸侯 reigns before 始皇帝; imperial cards keep name-first layout. */
export function usesPreQinCardLayout(reign: Pick<Reign, "start">): boolean {
  return reign.start.year < PRE_IMPERIAL_START_YEAR;
}

/** Drop import-time 姓 prefixes; keep 氏 (熊侣, 吕尚, 田因齐, 魏斯). */
export function stripAncestralXing(name: string): string {
  for (const xing of ANCESTRAL_XING) {
    if (!name.startsWith(xing) || name.length <= xing.length) continue;
    const rest = name.slice(xing.length);
    if (rest.length < 1 || rest.length > 3) continue;
    if (XING_STRIP_BLOCKLIST.has(rest)) continue;
    return rest;
  }
  return name;
}

function isPlaceholderPersonName(name: string): boolean {
  return PLACEHOLDER_PERSON_NAME.test(name);
}

function looksLikePersonalGivenName(name: string): boolean {
  if (!name || name.length < 1 || name.length > 4) return false;
  if (PLACEHOLDER_PERSON_NAME.test(name)) return false;
  if (/[公王侯伯]$/.test(name) && name.length >= 2) return false;
  return true;
}

/** Honorific-only bodies stored for search when given names are lost (姬襄公, 姬考伯). */
function isHonorificOnlyName(name: string): boolean {
  return /^.{1,3}(公|侯|伯|王|叔)$/.test(name);
}

function parseAncestralXingPrefix(name: string): { xing: string; rest: string } | null {
  for (const xing of ANCESTRAL_XING) {
    if (!name.startsWith(xing) || name.length <= xing.length) continue;
    const rest = name.slice(xing.length);
    if (rest.length < 1 || rest.length > 3) continue;
    if (XING_STRIP_BLOCKLIST.has(rest)) continue;
    if (looksLikePersonalGivenName(rest) || isHonorificOnlyName(rest)) {
      return { xing, rest };
    }
  }
  return null;
}

function parseClanShiPrefix(name: string): { shi: string; rest: string } | null {
  for (const shi of CLAN_SHI_PREFIXES) {
    if (!name.startsWith(shi) || name.length <= shi.length) continue;
    const rest = name.slice(shi.length);
    if (rest.length < 1 || rest.length > 3) continue;
    if (!looksLikePersonalGivenName(rest)) continue;
    return { shi, rest };
  }
  return null;
}

function resolveStoredAncestralXing(
  personName: string | null | undefined,
  clan?: PreQinClanContext | null,
): string | undefined {
  if (clan?.personAncestralXing) return clan.personAncestralXing;
  const cleaned = sanitizePersonName(personName);
  if (cleaned) {
    const ancestral = parseAncestralXingPrefix(cleaned);
    if (ancestral) return ancestral.xing;
    if (parseClanShiPrefix(cleaned)) {
      return clan?.dynastyAncestralXing ?? undefined;
    }
  }
  if (
    cleaned &&
    (looksLikePersonalGivenName(cleaned) ||
      isHonorificOnlyName(cleaned) ||
      isPlaceholderPersonName(cleaned))
  ) {
    return clan?.dynastyAncestralXing ?? undefined;
  }
  return undefined;
}

function resolveStoredClanShi(
  personName: string | null | undefined,
  clan?: PreQinClanContext | null,
): string | undefined {
  if (clan?.personClanShi) return clan.personClanShi;
  const cleaned = sanitizePersonName(personName);
  if (cleaned) {
    const parsed = parseClanShiPrefix(cleaned);
    if (parsed) return parsed.shi;
  }
  return clan?.dynastyClanShi ?? undefined;
}

/** Resolve 姓/氏 for pre-imperial rulers from stored DB fields + name parsing. */
export function resolvePreQinXingShi(
  personName: string | null | undefined,
  clan?: PreQinClanContext | null,
): { xing?: string; shi?: string } {
  const xing = resolveStoredAncestralXing(personName, clan);
  const shi = resolveStoredClanShi(personName, clan);
  if (!xing && !shi) return {};
  return { ...(xing ? { xing } : {}), ...(shi ? { shi } : {}) };
}

function resolveRegnalClanShi(
  reign?: ReignLabelFields | null,
): string | undefined {
  const regnal =
    reign?.preferredAppellation?.kind === "regnal"
      ? reign.preferredAppellation.name
      : null;
  if (!regnal) return undefined;
  return parseClanShiPrefix(regnal)?.shi;
}

/** Detail-panel facts for pre-imperial personal names. */
export function resolvePreQinNameFacts(
  personName: string | null | undefined,
  clan?: PreQinClanContext | null,
  reign?: ReignLabelFields | null,
): Array<{ label: string; value: string }> {
  const regnalShi = resolveRegnalClanShi(reign);
  const { xing, shi } = resolvePreQinXingShi(personName, clan);
  const resolvedShi = regnalShi ?? shi;
  const facts: Array<{ label: string; value: string }> = [];
  if (xing && !regnalShi) facts.push({ label: "姓", value: xing });
  if (resolvedShi) facts.push({ label: "氏", value: resolvedShi });
  return facts;
}

/**
 * 秦王政 / 中山王厝 — title is 国名+王+私名, not a posthumous-style body.
 */
function extractGivenNameBody(personName: string): string | null {
  const cleaned = sanitizePersonName(personName);
  if (!cleaned || isPlaceholderPersonName(cleaned)) return null;
  const ancestral = parseAncestralXingPrefix(cleaned);
  if (ancestral) return ancestral.rest;
  const clan = parseClanShiPrefix(cleaned);
  if (clan) return clan.rest;
  return cleaned;
}

function isPersonalNameKingTitle(
  title: string,
  personName?: string | null,
): boolean {
  const givenBody = extractGivenNameBody(personName ?? "");
  if (!givenBody) return false;
  const match = title.match(/^.+王([^\s]{1,2})$/);
  if (!match) return false;
  return match[1] === givenBody;
}

/**
 * Pre-Qin card primary: stored 谥号/称号 as-is (already without 国名).
 * `{国}王{私名}` titles without preferred fall through to the given name.
 * Other titles without stored fields are used as-is (公孙无知, 熊绎).
 */
function resolvePreQinCardAppellation(
  reign: ReignLabelFields,
  personName?: string | null,
): string | null {
  if (reign.posthumousName) return reign.posthumousName;
  const preferred =
    reign.preferredAppellation?.kind === "regnal"
      ? reign.preferredAppellation.name
      : null;
  if (preferred) return preferred;
  if (reign.title && isPersonalNameKingTitle(reign.title, personName)) {
    return null;
  }
  return reign.title || null;
}

function resolvePreQinGivenName(
  reign: ReignLabelFields,
  personName?: string | null,
): string | null {
  const cleaned = sanitizePersonName(personName);
  if (!cleaned || isPlaceholderPersonName(cleaned)) return null;
  if (cleaned === reign.title || cleaned === reign.preferredAppellation?.name) {
    return null;
  }
  const given = stripAncestralXing(cleaned);
  if (!given) return null;
  const appellation = resolvePreQinCardAppellation(reign, personName);
  if (appellation && givenNameIsRedundant(appellation, given)) return null;
  return given;
}

function personalNamePrimary(
  reign: ReignLabelFields,
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

/** Primary label for a reign card or detail title. */
export function resolveReignPrimaryLabel(
  reign: ReignLabelFields,
  personName?: string | null,
): string {
  if (usesPreQinCardLayout(reign)) {
    return (
      resolvePreQinCardAppellation(reign, personName) ??
      personalNamePrimary(reign, personName)
    );
  }
  return personalNamePrimary(reign, personName);
}

type ReignCardLabelOptions = {
  cardWidthPx?: number;
  dynastyId?: string;
};

/** Primary label rendered on a reign card. */
export function resolveReignCardLabel(
  reign: ReignLabelFields,
  personName?: string | null,
  _options?: ReignCardLabelOptions,
): string {
  return resolveReignPrimaryLabel(reign, personName);
}

/** Given name shown as card meta / tooltip for pre-Qin rulers. */
export function resolveReignCardGivenName(
  reign: ReignLabelFields,
  personName?: string | null,
): string | null {
  if (!usesPreQinCardLayout(reign)) return sanitizePersonName(personName);
  return resolvePreQinGivenName(reign, personName);
}

/** Subtitle for reign detail and dynasty related lists. */
export function resolveReignDetailSubtitle(
  reign: ReignAppellationFields,
  dynastyName?: string | null,
  personName?: string | null,
): string {
  const dynastyPart = dynastyName ?? "";
  const primary = resolveReignPrimaryLabel(reign, personName);
  if (usesPreQinCardLayout(reign)) {
    const given = resolvePreQinGivenName(reign, personName);
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
): string {
  const label = resolveReignPrimaryLabel(reign, personName);
  if (usesPreQinCardLayout(reign)) {
    const given = resolvePreQinGivenName(reign, personName);
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

function claimSeatIsRedundant(primary: string, seat: string): boolean {
  return primary.includes(seat);
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
  const primary = resolveReignPrimaryLabel(reign, personName);
  // Seat labels (长安 / 洛阳) distinguish parallel courts. Skip when the
  // appellation already carries the seat, e.g. 携王 + 据点「携」.
  if (
    isParallelClaim(reign) &&
    reign.claimLabel &&
    !claimSeatIsRedundant(primary, reign.claimLabel)
  ) {
    return { label: "据点", name: reign.claimLabel };
  }

  if (usesPreQinCardLayout(reign)) {
    const given = resolvePreQinGivenName(reign, personName);
    if (!given || givenNameIsRedundant(primary, given)) return null;
    return { label: "名", name: given };
  }

  const appellation = resolveEmperorAppellation(reign);
  if (!appellation) return null;

  // Early rulers (e.g. Qin) often lack a recorded personal name; the title
  // is used as a fallback, so skip a duplicate "称号 秦襄公" subtitle.
  if (isRedundantCardMeta(appellation, primary, personName)) {
    return null;
  }

  return { label: APPELLATION_LABELS[appellation.kind], name: appellation.name };
}
