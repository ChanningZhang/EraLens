import type { Precision } from "./schema";
import type { AbsMonth } from "./time";

type TimePoint = { year: number; month: number; day?: number };

/**
 * Absolute-day coordinates avoid rounding year-, month-, and day-precision
 * boundaries to the same AbsMonth. The stored interval is (startExclusive,
 * endInclusive], while its first represented calendar day is included.
 */
export type LeftOpenRightClosedInterval = {
  startExclusive: number;
  endInclusive: number;
};

function astronomicalYear(year: number): number {
  return year > 0 ? year : year + 1;
}

function calendarYear(astroYear: number): number {
  return astroYear > 0 ? astroYear : astroYear - 1;
}

function daysInMonth(year: number, month: number): number {
  const astroYear = astronomicalYear(year);
  const leap = astroYear % 4 === 0 && (astroYear % 100 !== 0 || astroYear % 400 === 0);
  if (month === 2) return leap ? 29 : 28;
  return [4, 6, 9, 11].includes(month) ? 30 : 31;
}

/** Proleptic Gregorian day number; works across BCE/CE without a year zero. */
function dayNumber({ year, month, day: inputDay }: TimePoint): number {
  const day = inputDay ?? 1;
  let y = astronomicalYear(year);
  y -= month <= 2 ? 1 : 0;
  const era = Math.floor(y / 400);
  const yearOfEra = y - era * 400;
  const shiftedMonth = month + (month > 2 ? -3 : 9);
  const dayOfYear = Math.floor((153 * shiftedMonth + 2) / 5) + day - 1;
  const dayOfEra =
    yearOfEra * 365 +
    Math.floor(yearOfEra / 4) -
    Math.floor(yearOfEra / 100) +
    dayOfYear;
  return era * 146097 + dayOfEra - 719468;
}

function pointForPrecision(point: TimePoint, precision: Precision, isEnd: boolean): TimePoint {
  if (precision === "year") {
    if (!isEnd) return { year: point.year, month: 1, day: 1 };
    const nextYear = point.year === -1 ? 1 : point.year + 1;
    return { year: nextYear, month: 1, day: 1 };
  }
  if (precision === "month") {
    if (!isEnd) return { year: point.year, month: point.month, day: 1 };
    const nextYear = point.month === 12 ? (point.year === -1 ? 1 : point.year + 1) : point.year;
    const nextMonth = point.month === 12 ? 1 : point.month + 1;
    return { year: nextYear, month: nextMonth, day: 1 };
  }
  const datedPoint = {
    ...point,
    day: point.day ?? (isEnd ? daysInMonth(point.year, point.month) : 1),
  };
  return isEnd ? pointFromDayNumber(dayNumber(datedPoint) + 1) : datedPoint;
}

/** Build a full-range interval using each record's actual dating precision. */
export function timelineInterval(
  start: TimePoint,
  end: TimePoint,
  startPrecision: Precision,
  endPrecision: Precision = startPrecision,
): LeftOpenRightClosedInterval {
  const normalizedEnd =
    endPrecision === "day" && end.day == null
      ? {
          ...end,
          day:
            start.year === end.year && start.month === end.month
              ? start.day ?? 1
              : daysInMonth(end.year, end.month),
        }
      : end;
  const firstDay = dayNumber(pointForPrecision(start, startPrecision, false));
  const dayAfterLast = dayNumber(pointForPrecision(normalizedEnd, endPrecision, true));
  return { startExclusive: firstDay - 1, endInclusive: dayAfterLast - 1 };
}

function pointFromAbsMonth(abs: AbsMonth): TimePoint {
  const wholeAbs = Math.floor(abs);
  const astroYear = Math.floor(wholeAbs / 12);
  const month = wholeAbs - astroYear * 12 + 1;
  const year = calendarYear(astroYear);
  const day = Math.min(
    daysInMonth(year, month),
    Math.floor((abs - wholeAbs) * daysInMonth(year, month)) + 1,
  );
  return { year, month, day };
}

/** Compatibility adapter for inclusive AbsMonth ranges and month windows. */
export function leftOpenRightClosedInterval(
  startInclusive: AbsMonth,
  endInclusive: AbsMonth,
): LeftOpenRightClosedInterval {
  return timelineInterval(
    pointFromAbsMonth(startInclusive),
    pointFromAbsMonth(endInclusive),
    "month",
  );
}

export function intervalContainsAbs(
  interval: LeftOpenRightClosedInterval,
  abs: AbsMonth,
): boolean {
  const day = dayNumber(pointFromAbsMonth(abs));
  return interval.startExclusive < day && day <= interval.endInclusive;
}

export function intervalsIntersect(
  a: LeftOpenRightClosedInterval,
  b: LeftOpenRightClosedInterval,
): boolean {
  return a.startExclusive < a.endInclusive &&
    b.startExclusive < b.endInclusive &&
    a.startExclusive < b.endInclusive &&
    b.startExclusive < a.endInclusive;
}

export function intervalPrecedes(
  candidate: LeftOpenRightClosedInterval,
  interval: LeftOpenRightClosedInterval,
): boolean {
  return candidate.startExclusive < interval.startExclusive ||
    (candidate.startExclusive === interval.startExclusive && candidate.endInclusive < interval.endInclusive);
}

/** Keep a shared boundary with the earlier record; later records begin next day. */
export function preserveEarlierIntervalAtOverlap(
  interval: LeftOpenRightClosedInterval,
  earlier: readonly LeftOpenRightClosedInterval[],
): LeftOpenRightClosedInterval {
  const startExclusive = earlier.reduce(
    (start, candidate) =>
      intervalPrecedes(candidate, interval) &&
      candidate.endInclusive >= interval.startExclusive + 1
        ? Math.max(start, candidate.endInclusive)
        : start,
    interval.startExclusive,
  );
  return { ...interval, startExclusive };
}

function pointFromDayNumber(value: number): TimePoint {
  let z = value + 719468;
  const era = Math.floor(z / 146097);
  const dayOfEra = z - era * 146097;
  const yearOfEra = Math.floor(
    (dayOfEra - Math.floor(dayOfEra / 1460) + Math.floor(dayOfEra / 36524) - Math.floor(dayOfEra / 146096)) / 365,
  );
  let year = yearOfEra + era * 400;
  const dayOfYear = dayOfEra - (365 * yearOfEra + Math.floor(yearOfEra / 4) - Math.floor(yearOfEra / 100));
  const monthPrime = Math.floor((5 * dayOfYear + 2) / 153);
  const day = dayOfYear - Math.floor((153 * monthPrime + 2) / 5) + 1;
  const month = monthPrime + (monthPrime < 10 ? 3 : -9);
  year += month <= 2 ? 1 : 0;
  return { year: calendarYear(year), month, day };
}

/** First included day after the exclusive boundary. */
export function effectiveIntervalStartPoint(
  interval: LeftOpenRightClosedInterval,
): TimePoint {
  return pointFromDayNumber(interval.startExclusive + 1);
}

/** Last included calendar day. */
export function effectiveIntervalEndPoint(
  interval: LeftOpenRightClosedInterval,
): TimePoint {
  return pointFromDayNumber(interval.endInclusive);
}

/** Convert an effective date back to the fractional AbsMonth used by layout. */
export function effectiveIntervalStartAbs(
  interval: LeftOpenRightClosedInterval,
): AbsMonth {
  const point = effectiveIntervalStartPoint(interval);
  const astroYear = astronomicalYear(point.year);
  const absMonth = astroYear * 12 + point.month - 1;
  return absMonth + ((point.day ?? 1) - 1) / daysInMonth(point.year, point.month);
}

/** Exclusive right boundary in the fractional AbsMonth coordinate system. */
export function effectiveIntervalEndAbs(
  interval: LeftOpenRightClosedInterval,
): AbsMonth {
  const point = pointFromDayNumber(interval.endInclusive + 1);
  const astroYear = astronomicalYear(point.year);
  const absMonth = astroYear * 12 + point.month - 1;
  return absMonth + ((point.day ?? 1) - 1) / daysInMonth(point.year, point.month);
}
