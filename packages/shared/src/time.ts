import { intervalsIntersect, leftOpenRightClosedInterval } from "./timelineIntervals";

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
  return intervalsIntersect(
    leftOpenRightClosedInterval(aStart, aEnd),
    leftOpenRightClosedInterval(bStart, bEnd),
  );
}

export function rangeIntersectsWindow(
  entityStart: AbsMonth,
  entityEnd: AbsMonth,
  windowStart: AbsMonth,
  windowEnd: AbsMonth,
): boolean {
  return rangesIntersect(entityStart, entityEnd, windowStart, windowEnd);
}

export type YearLabelStyle = "era" | "compact";

export function formatYear(year: number, style: YearLabelStyle = "era"): string {
  if (year < 0) {
    const prefix = style === "compact" ? "前" : "公元前";
    return `${prefix}${Math.abs(year)}年`;
  }
  if (year === 0) {
    return style === "compact" ? "元年" : "公元元年";
  }
  return style === "compact" ? `${year}年` : `公元${year}年`;
}

export function formatYearMonth(
  year: number,
  month: number,
  style: YearLabelStyle = "era",
): string {
  return `${formatYear(year, style)}${month}月`;
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

function formatSpanPointLabel(
  point: TimePoint,
  precision?: TimeRange["precision"],
  style: YearLabelStyle = "era",
): string {
  if (precision === "month" || precision === "day") {
    return formatYearMonth(point.year, point.month, style);
  }
  if (precision === "year") {
    return formatYear(point.year, style);
  }
  return point.month === 1
    ? formatYear(point.year, style)
    : formatYearMonth(point.year, point.month, style);
}

function formatAbsSpanDuration(
  start: TimePoint,
  end: TimePoint,
  startAbs: AbsMonth,
  endAbs: AbsMonth,
  precision?: TimeRange["precision"],
): string {
  if (precision === "year" || (precision == null && start.month === 1 && end.month === 1)) {
    const years = toAstroYear(end.year) - toAstroYear(start.year) + 1;
    return `${years}年`;
  }
  return formatDurationMonths(endAbs - startAbs + 1);
}

/** Hover label for an abs-month span: years, or a single year when start equals end. */
export function formatAbsSpanTooltip(
  startAbs: AbsMonth,
  endAbs: AbsMonth,
  precision?: TimeRange["precision"],
): string {
  const start = fromAbsMonth(startAbs);
  const end = fromAbsMonth(endAbs);
  if (precision === "year" && start.year === end.year) {
    return formatYear(start.year, "compact");
  }
  if (startAbs === endAbs) {
    return formatSpanPointLabel(start, precision, "compact");
  }
  const startLabel = formatSpanPointLabel(start, precision, "compact");
  const endLabel = formatSpanPointLabel(end, precision, "compact");
  const duration = formatAbsSpanDuration(start, end, startAbs, endAbs, precision);
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
