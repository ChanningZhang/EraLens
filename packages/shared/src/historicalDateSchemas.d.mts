import type { z } from "zod";
export type DateConfidence = "day" | "month" | "year" | "approximate_day" | "approximate_month" | "approximate_year" | "interpolated_by_other" | "interpolated_by_generation";
export type DatePoint = { year: number; month: number; day?: number; confidence?: DateConfidence };
export const TimePointSchema: z.ZodType<DatePoint>;
export const DateConfidenceSchema: z.ZodType<DateConfidence>;
export const HistoricalDateSchema: z.ZodType<DatePoint & { confidence: DateConfidence }>;
