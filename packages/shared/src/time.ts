/** Absolute month index using astronomical year numbering (no year 0). */
export type AbsMonth = number;

export type TimePoint = {
  year: number;
  month: number;
};

export type TimeRange = {
  start: TimePoint;
  end: TimePoint;
  precision?: "year" | "month" | "day";
};

/** Convert calendar year to astronomical year (BCE positive offset). */
export function toAstroYear(year: number): number {
  return year > 0 ? year : year + 1;
}

export function fromAstroYear(astroYear: number): number {
  return astroYear > 0 ? astroYear : astroYear - 1;
}

export function absMonth(year: number, month = 1): AbsMonth {
  const astro = toAstroYear(year);
  return astro * 12 + (month - 1);
}

export function fromAbsMonth(abs: AbsMonth): TimePoint {
  const wholeAbs = Math.round(abs);
  const astroYear = Math.floor(wholeAbs / 12);
  const month = wholeAbs - astroYear * 12 + 1;
  return { year: fromAstroYear(astroYear), month };
}

export function absFromPoint(point: TimePoint): AbsMonth {
  return absMonth(point.year, point.month);
}

export function rangeToAbs(range: TimeRange): { startAbs: AbsMonth; endAbs: AbsMonth } {
  const startAbs = absFromPoint(range.start);
  const endAbs = absFromPoint(range.end);
  return { startAbs, endAbs: Math.max(startAbs, endAbs) };
}

export function rangesIntersect(
  aStart: AbsMonth,
  aEnd: AbsMonth,
  bStart: AbsMonth,
  bEnd: AbsMonth,
): boolean {
  return aStart <= bEnd && bStart <= aEnd;
}

export function rangeIntersectsWindow(
  entityStart: AbsMonth,
  entityEnd: AbsMonth,
  windowStart: AbsMonth,
  windowEnd: AbsMonth,
): boolean {
  return rangesIntersect(entityStart, entityEnd, windowStart, windowEnd);
}

export function formatYear(year: number): string {
  if (year < 0) {
    return `公元前${Math.abs(year)}年`;
  }
  if (year === 0) {
    return "公元元年";
  }
  return `公元${year}年`;
}

export function formatYearMonth(year: number, month: number): string {
  return `${formatYear(year)}${month}月`;
}

export function formatYearMonthFromAbs(abs: AbsMonth): string {
  const { year, month } = fromAbsMonth(abs);
  return formatYearMonth(year, month);
}

function formatDurationMonths(totalMonths: number): string {
  if (totalMonths <= 0) return "不足1个月";
  const years = Math.floor(totalMonths / 12);
  const months = totalMonths % 12;
  if (years === 0) return `${months}个月`;
  if (months === 0) return `${years}年`;
  return `${years}年${months}个月`;
}

function formatAbsSpanDuration(start: TimePoint, end: TimePoint, startAbs: AbsMonth, endAbs: AbsMonth): string {
  if (start.month === 1 && end.month === 1) {
    const years = toAstroYear(end.year) - toAstroYear(start.year) + 1;
    return `${years}年`;
  }
  return formatDurationMonths(endAbs - startAbs + 1);
}

/** Hover label for an abs-month span: years, or a single year when start equals end. */
export function formatAbsSpanTooltip(startAbs: AbsMonth, endAbs: AbsMonth): string {
  const start = fromAbsMonth(startAbs);
  const end = fromAbsMonth(endAbs);
  if (startAbs === endAbs) {
    return start.month === 1 ? formatYear(start.year) : formatYearMonth(start.year, start.month);
  }
  const startLabel =
    start.month === 1 ? formatYear(start.year) : formatYearMonth(start.year, start.month);
  const endLabel = end.month === 1 ? formatYear(end.year) : formatYearMonth(end.year, end.month);
  const duration = formatAbsSpanDuration(start, end, startAbs, endAbs);
  return `${startLabel} — ${endLabel} · ${duration}`;
}

export function parseYearMonthParam(value: string): AbsMonth | null {
  const match = value.match(/^(-?\d+)(?:-(\d{1,2}))?$/);
  if (!match) return null;
  const year = Number(match[1]);
  const month = match[2] ? Number(match[2]) : 1;
  if (month < 1 || month > 12) return null;
  return absMonth(year, month);
}

export function encodeYearMonthParam(abs: AbsMonth): string {
  const { year, month } = fromAbsMonth(abs);
  return `${year}-${String(month).padStart(2, "0")}`;
}

export function clampAbs(abs: AbsMonth, min: AbsMonth, max: AbsMonth): AbsMonth {
  return Math.min(max, Math.max(min, abs));
}

export function computeWindow(
  centerAbs: AbsMonth,
  widthPx: number,
  pxPerMonth: number,
): { startAbs: AbsMonth; endAbs: AbsMonth } {
  const halfMonths = widthPx / pxPerMonth / 2;
  const startAbs = Math.floor(centerAbs - halfMonths);
  const endAbs = Math.ceil(centerAbs + halfMonths);
  return { startAbs, endAbs };
}

export function absToX(abs: AbsMonth, startAbs: AbsMonth, pxPerMonth: number): number {
  return (abs - startAbs) * pxPerMonth;
}

export function xToAbs(x: number, startAbs: AbsMonth, pxPerMonth: number): AbsMonth {
  return startAbs + x / pxPerMonth;
}

export function quantizeWindowForQuery(
  startAbs: AbsMonth,
  endAbs: AbsMonth,
  chunkMonths = 600,
): { fromAbs: AbsMonth; toAbs: AbsMonth } {
  const fromAbs = Math.floor(startAbs / chunkMonths) * chunkMonths;
  const toAbs = Math.ceil(endAbs / chunkMonths) * chunkMonths;
  return { fromAbs, toAbs };
}
