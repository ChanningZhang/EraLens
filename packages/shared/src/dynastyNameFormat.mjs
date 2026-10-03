import { z } from "zod";
import { HistoricalDateSchema } from "./historicalDateSchemas.mjs";

const periodSchema = z.object({
  name: z.string().trim().min(1),
  start: HistoricalDateSchema,
  end: HistoricalDateSchema,
}).strict().refine(({ start, end }) =>
  start.year < end.year || (start.year === end.year &&
    (start.month < end.month || (start.month === end.month && (start.day ?? 1) <= (end.day ?? 31)))),
{ message: "Name period ends before its start" });

export const DynastyNameDefinitionSchema = z.object({
  periods: z.array(periodSchema).min(1),
}).strict().refine(({ periods }) => periods.every((period, i) => {
  if (i === 0) return true;
  const previous = periods[i - 1].start;
  const start = period.start;
  return previous.year < start.year || (previous.year === start.year &&
    (previous.month < start.month || (previous.month === start.month && (previous.day ?? 1) < (start.day ?? 1))));
}), { message: "Name periods must be ordered by start date" });

/** Shared by the application and the plain-Node import tooling. */
export function parseDynastyName(raw) {
  let parsed;
  try { parsed = JSON.parse(raw); }
  catch (error) {
    if (/^\s*[\[{]/u.test(raw)) throw new Error(`Invalid dynasty name JSON: ${error.message}`);
    return raw;
  }
  return DynastyNameDefinitionSchema.parse(parsed);
}

export function validateDynastyName(dynasty) {
  const parsed = parseDynastyName(dynasty.name);
  if (typeof parsed !== "string" && !dynasty.altNames?.[0]?.trim()) throw new Error("A timed dynasty name requires altNames[0] as its representative name");
  return parsed;
}

export function resolveDynastyDefaultName(dynasty) {
  const parsed = validateDynastyName(dynasty);
  return typeof parsed === "string" ? parsed : dynasty.altNames[0];
}

export function dynastyNameTerms(raw) {
  const parsed = parseDynastyName(raw);
  return typeof parsed === "string" ? [parsed] : [...new Set(parsed.periods.map(p => p.name))];
}
