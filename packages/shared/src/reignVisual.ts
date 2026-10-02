import type { Reign } from "./schema";
import {
  absMonth,
  formatAbsSpanDurationLabel,
  formatAbsSpanTooltip,
  formatYearMonth,
} from "./time";
import { formatHistoricalDate, hasUncertainDateRange } from "./historicalDate";
import { confidencePrecision } from "./historicalDate";
import {
  effectiveIntervalEndPoint,
  effectiveIntervalStartPoint,
  type LeftOpenRightClosedInterval,
} from "./timelineIntervals";

type ReignSpanFields = Pick<
  Reign,
  | "start"
  | "end"
  | "startAbs"
  | "endAbs"
  | "precision"
  | "isOngoing"
>;

/** Days in a Gregorian calendar month (historical dates use proleptic Gregorian). */
export function daysInCalendarMonth(year: number, month: number): number {
  return new Date(year, month, 0).getDate();
}

function monthStartFraction(point: { year: number; month: number; day?: number }): number {
  const day = point.day ?? 1;
  return (day - 1) / daysInCalendarMonth(point.year, point.month);
}

function monthEndFraction(
  point: { year: number; month: number; day?: number },
  fallbackDay?: number,
): number {
  const dim = daysInCalendarMonth(point.year, point.month);
  const day = point.day ?? fallbackDay ?? dim;
  return day / dim;
}

/** Whole-day count for day-precision reigns; null when only month/year precision is known. */
export function reignDurationDays(
  reign: Pick<Reign, "precision" | "start" | "end" | "startAbs" | "endAbs">,
): number | null {
  if (confidencePrecision(reign.start.confidence ?? "year") !== "day" || confidencePrecision(reign.end.confidence ?? "year") !== "day") return null;
  const startDay = reign.start.day ?? 1;
  const endDay = reign.end.day ?? startDay;
  if (reign.startAbs === reign.endAbs) {
    return Math.max(1, endDay - startDay + 1);
  }

  let total = 0;
  let year = reign.start.year;
  let month = reign.start.month;
  const endYear = reign.end.year;
  const endMonth = reign.end.month;

  while (year < endYear || (year === endYear && month <= endMonth)) {
    const dim = daysInCalendarMonth(year, month);
    const fromDay = year === reign.start.year && month === reign.start.month ? startDay : 1;
    const toDay =
      year === endYear && month === endMonth
        ? endDay
        : dim;
    total += Math.max(0, toDay - fromDay + 1);

    month += 1;
    if (month > 12) {
      month = 1;
      year += 1;
    }
    if (year > endYear || (year === endYear && month > endMonth)) break;
  }
  return Math.max(1, total);
}

function formatYearMonthDay(year: number, month: number, day: number): string {
  return `${formatYearMonth(year, month)}${day}日`;
}

function calendarYearsMonths(
  start: { year: number; month: number; day?: number },
  end: { year: number; month: number; day?: number },
): { years: number; months: number } {
  const startDay = start.day ?? 1;
  const endDay = end.day ?? 1;
  let years = end.year - start.year;
  let months = end.month - start.month;
  if (endDay < startDay) {
    months -= 1;
  }
  if (months < 0) {
    years -= 1;
    months += 12;
  }
  return { years, months };
}

/** Day-precision spans: days under a month, months under a year, else years + months. */
function formatSmartDayDuration(reign: Pick<Reign, "start" | "end">, days: number): string {
  if (days <= 0) return "不足1天";
  if (days === 1) return "1天";

  const { years, months } = calendarYearsMonths(reign.start, reign.end);
  if (years >= 1) {
    if (months === 0) return `${years}年`;
    return `${years}年${months}个月`;
  }
  if (months >= 1) {
    return `${months}个月`;
  }
  return `${days}天`;
}

/** Duration suffix for an exact, inclusive day interval, matching reign tooltips. */
export function formatDaySpanDuration(
  start: Reign["start"],
  end: Reign["end"],
  days: number,
): string {
  return formatSmartDayDuration({ start, end }, days);
}

/** Hover label for a reign, honoring day precision when present. */
export function formatReignSpanTooltip(reign: ReignSpanFields): string {
  const startConfidence = reign.start.confidence ?? "year";
  const endConfidence = reign.end.confidence ?? "year";
  const startLabel = formatHistoricalDate({ ...reign.start, confidence: startConfidence });
  if (reign.isOngoing) return `${startLabel} — 至今`;
  if (hasUncertainDateRange(reign)) {
    const endLabel = formatHistoricalDate({ ...reign.end, confidence: endConfidence });
    return `${startLabel} — ${endLabel}`;
  }
  if (confidencePrecision(startConfidence) === "day" && confidencePrecision(endConfidence) === "day" && reign.start.day != null && reign.end.day != null) {
    const startLabel = formatYearMonthDay(reign.start.year, reign.start.month, reign.start.day);
    const endLabel = formatYearMonthDay(reign.end.year, reign.end.month, reign.end.day);
    const days = reignDurationDays(reign);
    if (startLabel === endLabel && days === 1) {
      return `${startLabel} · 1天`;
    }
    if (days != null) {
      return `${startLabel} — ${endLabel} · ${formatSmartDayDuration(reign, days)}`;
    }
  }
  const precision = confidencePrecision(startConfidence) === "day" || confidencePrecision(endConfidence) === "day" ? "day" : confidencePrecision(startConfidence) === "month" || confidencePrecision(endConfidence) === "month" ? "month" : "year";
  return formatAbsSpanTooltip(reign.startAbs, reign.endAbs, precision);
}

/** Duration suffix from the same rules used by the reign tooltip. */
export function formatReignDurationLabel(
  reign: ReignSpanFields,
  interval?: LeftOpenRightClosedInterval,
): string | undefined {
  const startConfidence = reign.start.confidence ?? "year";
  const endConfidence = reign.end.confidence ?? "year";
  // Layout intervals may use inferred dates, but cannot make their duration certain.
  if (reign.isOngoing || hasUncertainDateRange(reign)) {
    return undefined;
  }
  if (interval) {
    const start = effectiveIntervalStartPoint(interval);
    const end = effectiveIntervalEndPoint(interval);
    if (confidencePrecision(reign.start.confidence ?? "year") === "day" || confidencePrecision(reign.end.confidence ?? "year") === "day") {
      return formatDaySpanDuration(
        start,
        end,
        interval.endInclusive - interval.startExclusive,
      );
    }
    return formatAbsSpanDurationLabel(
      start,
      end,
      absMonth(start.year, start.month),
      absMonth(end.year, end.month),
      confidencePrecision(reign.start.confidence ?? "year") === "year" && confidencePrecision(reign.end.confidence ?? "year") === "year" ? "year" : "month",
    );
  }
  const tooltipDuration = formatReignSpanTooltip(reign).match(/ · (.+)$/)?.[1];
  if (tooltipDuration) return tooltipDuration;

  // A collapsed same-year tooltip has no duration suffix. Only restore that
  // suffix when both endpoints are dated with certainty; interpolated or
  // approximate endpoints must not turn into a made-up "1 year" duration.
  if (confidencePrecision(startConfidence) === "year" && confidencePrecision(endConfidence) === "year") return "1年";
  if (confidencePrecision(startConfidence) === "month" && confidencePrecision(endConfidence) === "month") return "1个月";
  const days = reignDurationDays(reign);
  return days == null ? undefined : formatDaySpanDuration(reign.start, reign.end, days);
}

type ReignYearRangeFields = Pick<
  Reign,
  | "start"
  | "end"
  | "precision"
  | "isOngoing"
>;

/** Detail-panel year range; date-level uncertainty should not hide a known year. */
export function formatReignYearRange(reign: ReignYearRangeFields): string {
  const startConfidence = reign.start.confidence ?? "year";
  const start = formatHistoricalDate({ ...reign.start, confidence: startConfidence });
  if (reign.isOngoing) return `${start} — 至今`;
  const endConfidence = reign.end.confidence ?? "year";
  const end = formatHistoricalDate({ ...reign.end, confidence: endConfidence });
  return `${start} — ${end}`;
}

/**
 * Fractional abs-month interval for card width/position.
 * Year/month precision keeps the full calendar-month span; day precision uses
 * sub-month fractions so a one-day reign is visibly narrower than a month.
 */
export function reignVisualBounds(
  reign: Reign,
  clipStartAbs?: number,
  clipEndExclusive?: number,
): { start: number; endExclusive: number } {
  let start = reign.startAbs;
  let endExclusive = reign.endAbs + 1;

  if (confidencePrecision(reign.start.confidence ?? "year") === "day" || confidencePrecision(reign.end.confidence ?? "year") === "day") {
    const startDay = reign.start.day ?? 1;
    const endDay =
      reign.end.day ??
      (reign.startAbs === reign.endAbs ? startDay : daysInCalendarMonth(reign.end.year, reign.end.month));
    start = reign.startAbs + monthStartFraction({ ...reign.start, day: startDay });
    endExclusive = reign.endAbs + monthEndFraction({ ...reign.end, day: endDay }, startDay);
    if (endExclusive <= start) {
      endExclusive = start + 1 / daysInCalendarMonth(reign.end.year, reign.end.month);
    }
  }

  const clippedStart = clipStartAbs !== undefined ? Math.max(start, clipStartAbs) : start;
  const clippedEnd = clipEndExclusive !== undefined ? Math.min(endExclusive, clipEndExclusive) : endExclusive;

  return { start: clippedStart, endExclusive: Math.max(clippedStart, clippedEnd) };
}
