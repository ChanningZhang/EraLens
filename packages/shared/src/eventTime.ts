import type { Event, HistoricalDateConfidence, Lod } from "./schema";
import { formatHistoricalDate } from "./historicalDate";
import { absMonthAtDay, formatYear, formatYearMonth } from "./time";

export type EventSpan = {
  startAbs: number;
  endAbs: number;
  anchorAbs: number;
};

export function eventKindLabel(kind: Event["kind"]): string {
  switch (kind) {
    case "battle":
      return "军事";
    case "politics":
      return "政治";
    case "culture":
      return "文化";
    case "disaster":
      return "灾害";
    case "commerce":
      return "商业";
    case "agriculture":
      return "农业";
    case "finance":
      return "金融";
    case "idiom":
      return "成语";
    case "poetry":
      return "诗歌";
    case "other":
      return "其他";
  }
}

export function eventSpanAbs(event: {
  at?: { year: number; month: number; day?: number };
  atAbs?: number;
  start?: { year: number; month: number; day?: number };
  end?: { year: number; month: number; day?: number };
  startAbs?: number;
  endAbs?: number;
}): EventSpan {
  const atAbs = event.at ? absMonthAtDay(event.at) : event.atAbs;
  const startAbs = event.start ? absMonthAtDay(event.start) : event.startAbs ?? atAbs ?? 0;
  const endAbs = event.end ? absMonthAtDay(event.end) : event.endAbs ?? atAbs ?? startAbs;
  const anchorAbs =
    atAbs ?? (startAbs === endAbs ? startAbs : (startAbs + endAbs) / 2);
  return { startAbs, endAbs, anchorAbs };
}

export function formatEventTime(event: Event): string {
  const pointLabel = (point: NonNullable<Event["at"]>, confidence?: HistoricalDateConfidence) =>
    formatHistoricalDate({ ...point, confidence: confidence ?? point.confidence ?? "year" });
  if (event.timeMode === "span" && event.start && event.end) {
    return `${pointLabel(event.start, event.startConfidence)} — ${pointLabel(event.end, event.endConfidence)}`;
  }
  if (event.at) return pointLabel(event.at, event.atConfidence);
  return "年代不详";
}

export function shouldShowEventAtLod(event: Event, lod: Lod): boolean {
  void event;
  void lod;
  return true;
}

/** Classify only when endpoint calendar granularity is known; placeholder years return null. */
export function eventModeForCalendarDuration(
  start: { year: number; month: number; confidence?: HistoricalDateConfidence },
  end: { year: number; month: number; confidence?: HistoricalDateConfidence },
): "point" | "span" | null {
  const realMonth = (confidence?: HistoricalDateConfidence) =>
    confidence === "month" || confidence === "day" || confidence === "approximate_month" || confidence === "approximate_day";
  if (!realMonth(start.confidence) || !realMonth(end.confidence)) return null;
  const durationMonths = (end.year - start.year) * 12 + end.month - start.month;
  return durationMonths >= 12 ? "span" : "point";
}
