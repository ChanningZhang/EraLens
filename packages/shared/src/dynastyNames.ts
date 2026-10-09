import { parseDynastyName, resolveDynastyDefaultName } from "./dynastyNameFormat.mjs";
import { confidencePrecision } from "./historicalDate";
import { phaseOwnershipInterval, reignOwnershipInterval } from "./timelineOwnership";
import { effectiveIntervalStartAbs, intervalContainsAbs, intervalOverlapDays } from "./timelineIntervals";
import type { Reign } from "./schema";

export { DynastyNameDefinitionSchema, parseDynastyName, resolveDynastyDefaultName, dynastyNameTerms, validateDynastyName } from "./dynastyNameFormat.mjs";
export type { DynastyNameDefinition } from "./dynastyNameFormat.mjs";

export function dynastyNamePeriods(raw: string) {
  const parsed = parseDynastyName(raw);
  return typeof parsed === "string" ? [] : parsed.periods.map((period, index) => ({
    ...period, id: String(index), precision: confidencePrecision(period.start.confidence),
  }));
}

/** Names depend on dynasty dates, independently of reign boundaries. */
export function resolveDynastyName(dynasty: { name: string; altNames?: string[] }, atAbs?: number): string {
  const parsed = parseDynastyName(dynasty.name);
  if (typeof parsed === "string") return parsed;
  if (atAbs == null) return resolveDynastyDefaultName(dynasty);
  const periods = dynastyNamePeriods(dynasty.name);
  return periods.find(period => intervalContainsAbs(phaseOwnershipInterval(period, periods), atAbs))?.name ?? resolveDynastyDefaultName(dynasty);
}

export function dynastyNameSearchEntries(dynasty: { name: string; altNames?: string[] }, fallbackAbs: number): Array<{ name: string; abs: number }> {
  const parsed = parseDynastyName(dynasty.name);
  if (typeof parsed === "string") return [{ name: parsed, abs: fallbackAbs }];
  const periods = dynastyNamePeriods(dynasty.name);
  const entries = periods.map(period => ({ name: period.name, abs: effectiveIntervalStartAbs(phaseOwnershipInterval(period, periods)) }));
  const defaultName = resolveDynastyDefaultName(dynasty);
  if (!entries.some(entry => entry.name === defaultName)) entries.push({ name: defaultName, abs: fallbackAbs });
  return entries;
}

/** Import-time assignment; repeated phases with the same name count together. */
export function reignDynastyNameDurations(dynasty: { name: string }, reign: Reign, reigns: readonly Reign[]): Array<{ name: string; days: number }> {
  const interval = reignOwnershipInterval(reign, reigns);
  const totalDays = Math.max(0, interval.endInclusive - interval.startExclusive);
  if (!totalDays) return [{ name: resolveDynastyName(dynasty, reign.startAbs), days: 0 }];
  const periods = dynastyNamePeriods(dynasty.name);
  const durations = new Map<string, number>();
  let coveredDays = 0;
  for (const period of periods) {
    const days = intervalOverlapDays(interval, phaseOwnershipInterval(period, periods));
    if (!days) continue;
    coveredDays += days;
    durations.set(period.name, (durations.get(period.name) ?? 0) + days);
  }
  const uncoveredDays = Math.max(0, totalDays - coveredDays);
  if (uncoveredDays) {
    const name = resolveDynastyDefaultName(dynasty);
    durations.set(name, (durations.get(name) ?? 0) + uncoveredDays);
  }
  return [...durations].map(([name, days]) => ({ name, days }));
}

/** Ties retain the earliest represented name phase. */
export function resolveReignDynastyNameByDuration(dynasty: { name: string }, reign: Reign, reigns: readonly Reign[]): string {
  return reignDynastyNameDurations(dynasty, reign, reigns).reduce((best, candidate) => candidate.days > best.days ? candidate : best).name;
}
