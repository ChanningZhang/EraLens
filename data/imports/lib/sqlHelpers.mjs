
export function toAstroYear(year) {
  return year > 0 ? year : year + 1;
}
export function absMonth(year, month = 1) {
  return toAstroYear(year) * 12 + (month - 1);
}
export function fromAbsMonth(abs) {
  const wholeAbs = Math.round(abs);
  const astroYear = Math.floor(wholeAbs / 12);
  const month = wholeAbs - astroYear * 12 + 1;
  return { year: astroYear > 0 ? astroYear : astroYear - 1, month };
}
export function sqlStr(value) {
  if (value == null) return "NULL";
  return `'${String(value).replace(/'/g, "''")}'`;
}
export function sqlArray(values) {
  if (!values?.length) return "ARRAY[]::text[]";
  return `ARRAY[${values.map(sqlStr).join(",")}]`;
}
export function sqlJson(value) {
  if (value == null) return "NULL";
  return `${sqlStr(JSON.stringify(value))}::jsonb`;
}

export function ym(year, month = 1) {
  return { year, month, abs: absMonth(year, month) };
}

/** Year-precision point: December, matching lane year-end and fate `atAbs`. */
export function eventYear(year) {
  return ym(year, 12);
}

/**
 * Year-confidence `at` uses month 12 (lane year-end). January is the old
 * placeholder and is rewritten; explicit month confidence preserves January.
 */
export function normalizeYearPrecisionAt(at, confidence = "year") {
  if (!at || confidence !== "year" || at.day != null) return at;
  if (at.month !== 1) return at;
  return ym(at.year, 12);
}
export function wiki(title) {
  return [{ label: "维基百科", url: `https://zh.wikipedia.org/wiki/${title}` }];
}

export function formatAppellationCsv(values) {
  if (!values?.length) return null;
  const cleaned = values.map((v) => String(v).trim()).filter(Boolean);
  return cleaned.length ? cleaned.join(",") : null;
}

export function endpointDateConfidence(explicit, date = null) {
  if (explicit) return explicit;
  if (date?.day != null) return "day";
  if (date?.month != null && date.month !== 1) return "month";
  return "year";
}

export function parseAppellationCsv(raw) {
  if (!raw) return [];
  return raw
    .split(",")
    .map((part) => part.trim())
    .filter(Boolean);
}

export function person(
  id,
  name,
  roles,
  bio,
  wikiTitle,
  birth = null,
  death = null,
  altNames = [],
  posthumousNames = [],
  templeNames = [],
) {
  return {
    id,
    name,
    roles,
    bio,
    links: wiki(wikiTitle),
    birth,
    death,
    altNames,
    posthumousNames,
    templeNames,
  };
}

export function normalizeEraNameList(eraNames = []) {
  if (!eraNames.length) return [];
  if (typeof eraNames[0] === "string") return eraNames.filter(Boolean);
  return eraNames.map((e) => e.name).filter(Boolean);
}

export function reign({
  id,
  dynastyId,
  personId,
  title,
  posthumousName,
  templeName,
  start,
  end,
  endAbs: explicitEndAbs = null,
  eraNames = [],
  claimTrack = null,
  claimLabel = null,
}) {
  return {
    id,
    dynastyId,
    personId,
    title,
    posthumousName,
    templeName,
    eraNames: normalizeEraNameList(eraNames),
    start,
    end,
    startAbs: start.abs,
    endAbs: explicitEndAbs ?? end?.abs ?? null,
    claimTrack,
    claimLabel,
  };
}

export function dynastyReign(dynastyId, personId, title, posthumous, temple, startYear, endYear, eraNames = []) {
  return reign({
    id: `reign-${personId}-${dynastyId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    start: ym(startYear),
    end: ym(endYear, 12),
    eraNames,
  });
}

export function eras(_reignId, list) {
  return list.map((e) => e.name).filter(Boolean);
}

export function dr(dynastyId, personId, title, posthumous, temple, sy, ey, eraList = []) {
  const reignId = `reign-${personId}-${dynastyId}`;
  return dynastyReign(
    dynastyId,
    personId,
    title,
    posthumous,
    temple,
    sy,
    ey,
    eraList.length ? eras(reignId, eraList) : [],
  );
}


export function eventPoint(partial) {
  const atConfidence = endpointDateConfidence(partial.at?.confidence ?? partial.atConfidence, partial.at);
  const at = normalizeYearPrecisionAt(partial.at, atConfidence);
  return {
    kind: "other",
    timeMode: "point",
    ...partial,
    at,
    atAbs: at.abs,
  };
}

export function idiomPoint(partial) {
  if (!partial.meaning?.trim()) {
    throw new Error(`idiomPoint requires meaning: ${partial.id ?? partial.name ?? "unknown"}`);
  }
  const point = eventPoint({ ...partial, kind: "idiom" });
  return {
    ...point,
    kind: "idiom",
    meaning: partial.meaning.trim(),
  };
}

export function eventRange(partial) {
  const start = partial.start;
  const end = partial.end;
  const atConfidence = endpointDateConfidence(partial.at?.confidence ?? partial.atConfidence, partial.at);
  const at = partial.at ? normalizeYearPrecisionAt(partial.at, atConfidence) : undefined;
  return {
    kind: "other",
    timeMode: "span",
    ...partial,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    ...(at ? { at, atAbs: at.abs } : {}),
  };
}

export function successionPairs(list) {
  const pairs = [];
  for (let i = 0; i < list.length - 1; i++) pairs.push([list[i].personId, list[i + 1].personId]);
  return pairs;
}
