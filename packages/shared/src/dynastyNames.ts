import { parseDynastyName, resolveDynastyDefaultName } from "./dynastyNameFormat.mjs";
import { confidencePrecision } from "./historicalDate";
import { phaseOwnershipInterval } from "./timelineOwnership";
import { effectiveIntervalStartAbs, intervalContainsAbs } from "./timelineIntervals";

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
