import { z } from "zod";

export const TimePointSchema = z.object({
  year: z.number(),
  month: z.number().int().min(1).max(12),
  day: z.number().int().min(1).max(31).optional(),
  /** Endpoint-level confidence. Optional only for older/mock inputs during rollout. */
  confidence: z.enum([
    "day", "month", "year", "approximate_day", "approximate_month", "approximate_year",
    "interpolated_by_other", "interpolated_by_generation",
  ]).optional(),
});
export const DateConfidenceSchema = z.enum([
  "day", "month", "year", "approximate_day", "approximate_month", "approximate_year",
  "interpolated_by_other", "interpolated_by_generation",
]);
export const HistoricalDateSchema = TimePointSchema.extend({ confidence: DateConfidenceSchema });

