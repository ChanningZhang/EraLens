import type { Event, EventPrecision, Lod } from "./schema";
import { formatYear, formatYearMonth } from "./time";

export type EventSpan = {
  startAbs: number;
  endAbs: number;
  anchorAbs: number;
};

export function eventKindLabel(kind: Event["kind"]): string {
  switch (kind) {
    case "battle":
      return "战事";
    case "politics":
      return "政治";
    case "culture":
      return "文化";
    case "disaster":
      return "灾害";
    case "idiom":
      return "成语";
    case "poetry":
      return "诗歌";
    case "other":
      return "其他";
  }
}

export function eventSpanAbs(event: {
  atAbs?: number;
  startAbs?: number;
  endAbs?: number;
}): EventSpan {
  const startAbs = event.startAbs ?? event.atAbs ?? 0;
  const endAbs = event.endAbs ?? event.atAbs ?? startAbs;
  const anchorAbs =
    event.atAbs ?? (startAbs === endAbs ? startAbs : (startAbs + endAbs) / 2);
  return { startAbs, endAbs, anchorAbs };
}

function formatByPrecision(
  year: number,
  month: number,
  precision: EventPrecision,
): string {
  if (precision === "month" || precision === "day") {
    return formatYearMonth(year, month);
  }
  return formatYear(year);
}

function formatPoint(
  point: { year: number; month: number },
  precision: EventPrecision,
): string {
  return formatByPrecision(point.year, point.month, precision);
}

export function formatEventTime(event: Event): string {
  const precision = event.precision;
  if (event.timeMode === "span" && event.start && event.end) {
    return `${formatPoint(event.start, precision)} — ${formatPoint(event.end, precision)}`;
  }
  if (event.timeMode === "circa") {
    if (event.start && event.end) {
      const sameYear =
        event.start.year === event.end.year &&
        precision !== "month" &&
        precision !== "day";
      if (sameYear) {
        return `约${formatYear(event.start.year)}`;
      }
      return `约${formatPoint(event.start, precision)} — ${formatPoint(event.end, precision)}`;
    }
    if (event.at) {
      return `约${formatPoint(event.at, precision)}`;
    }
  }
  if (event.at) {
    return formatPoint(event.at, precision);
  }
  if (event.start && event.end) {
    return `${formatPoint(event.start, precision)} — ${formatPoint(event.end, precision)}`;
  }
  return "年代不详";
}

export function shouldShowEventAtLod(event: Event, lod: Lod): boolean {
  if (lod === "month" || lod === "decade") return true;
  if (lod === "century") {
    return (
      event.timeMode === "circa" ||
      event.precision === "decade" ||
      event.precision === "century"
    );
  }
  return event.precision === "century";
}
