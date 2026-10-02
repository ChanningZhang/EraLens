import type { HistoricalDateConfidence } from "./schema";

export type DatePrecision = "day" | "month" | "year";

export function precisionOfDate(date: { month?: number; day?: number }): DatePrecision {
  return date.day != null ? "day" : date.month != null ? "month" : "year";
}

export function confidencePrecision(confidence: HistoricalDateConfidence): DatePrecision {
  if (confidence.endsWith("_day") || confidence === "day") return "day";
  if (confidence.endsWith("_month") || confidence === "month") return "month";
  return "year";
}

export function isInterpolatedConfidence(confidence?: HistoricalDateConfidence | null): boolean {
  return confidence === "interpolated_by_other" || confidence === "interpolated_by_generation";
}

export function isApproximateConfidence(confidence?: HistoricalDateConfidence | null): boolean {
  return confidence === "approximate_day" || confidence === "approximate_month" || confidence === "approximate_year";
}

export function formatHistoricalDate(date: {
  year: number;
  month?: number;
  day?: number;
  confidence?: HistoricalDateConfidence;
}): string {
  const confidence = date.confidence ?? (date.day != null ? "day" : date.month != null ? "month" : "year");
  if (isInterpolatedConfidence(confidence)) return "?";
  const precision = confidencePrecision(confidence);
  const pieces = [`${date.year}年`];
  if (precision !== "year" && date.month != null) pieces.push(`${date.month}月`);
  if (precision === "day" && date.day != null) pieces.push(`${date.day}日`);
  return `${isApproximateConfidence(confidence) ? "约" : ""}${pieces.join("")}`;
}
