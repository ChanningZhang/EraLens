import type { Reign } from "./schema";
import { formatAbsSpanTooltip, formatYearMonth } from "./time";

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
export function reignDurationDays(reign: Reign): number | null {
  if (reign.precision !== "day") return null;
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
  return `${formatYearMonth(year, month, "compact")}${day}日`;
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
function formatSmartDayDuration(reign: Reign, days: number): string {
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

/** Hover label for a reign, honoring day precision when present. */
export function formatReignSpanTooltip(reign: Reign): string {
  if (reign.precision === "day" && reign.start.day != null && reign.end.day != null) {
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
  return formatAbsSpanTooltip(reign.startAbs, reign.endAbs, reign.precision);
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

  if (reign.precision === "day") {
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

  if (clipStartAbs !== undefined) start = Math.max(start, clipStartAbs);
  if (clipEndExclusive !== undefined) endExclusive = Math.min(endExclusive, clipEndExclusive);

  if (endExclusive <= start) {
    endExclusive = start + 1 / daysInCalendarMonth(reign.end.year, reign.end.month);
  }

  return { start, endExclusive };
}
