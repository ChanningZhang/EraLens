import { confidencePrecision } from "./historicalDate";
import { HistoricalDateSchema } from "./historicalDateSchemas.mjs";
import { phaseOwnershipInterval } from "./timelineOwnership";
import { intervalContainsAbs } from "./timelineIntervals";
import { z } from "zod";

const rankPeriodSchema = z.object({
  rank: z.enum(["公", "侯", "伯", "子", "男", "王", "君", "帝"]),
  start: HistoricalDateSchema,
  end: HistoricalDateSchema,
}).strict();

const dateOrder = (date: { year: number; month: number; day?: number }) =>
  [date.year, date.month, date.day ?? 1] as const;
const compareDate = (a: ReturnType<typeof dateOrder>, b: ReturnType<typeof dateOrder>) =>
  a[0] - b[0] || a[1] - b[1] || a[2] - b[2];

export const DynastyFeudalRankDefinitionSchema = z.object({
  periods: z.array(rankPeriodSchema).min(1),
}).strict().superRefine(({ periods }, ctx) => {
  periods.forEach((period, index) => {
    if (compareDate(dateOrder(period.start), dateOrder(period.end)) > 0) {
      ctx.addIssue({ code: "custom", path: ["periods", index], message: "Feudal-rank period ends before its start" });
    }
    const previous = periods[index - 1];
    if (!previous) return;
    if (compareDate(dateOrder(previous.start), dateOrder(period.start)) >= 0) {
      ctx.addIssue({ code: "custom", path: ["periods", index, "start"], message: "Feudal-rank periods must be ordered by start date" });
    }
    if (compareDate(dateOrder(previous.end), dateOrder(period.start)) >= 0) {
      ctx.addIssue({ code: "custom", path: ["periods", index, "start"], message: "Feudal-rank periods must not overlap" });
    }
  });
});

export type DynastyFeudalRankDefinition = z.infer<typeof DynastyFeudalRankDefinitionSchema>;

export function dynastyFeudalRankPeriods(raw: DynastyFeudalRankDefinition) {
  return raw.periods.map((period, index) => ({
    ...period,
    id: String(index),
    precision: confidencePrecision(period.start.confidence),
  }));
}

/** Resolve the one-character source-table label for the lane's frozen time anchor. */
export function resolveDynastyFeudalRank(
  definition: DynastyFeudalRankDefinition | undefined,
  atAbs?: number,
): string | undefined {
  if (!definition || atAbs == null) return undefined;
  const periods = dynastyFeudalRankPeriods(definition);
  return periods.find(period => intervalContainsAbs(phaseOwnershipInterval(period, periods), atAbs))?.rank;
}
