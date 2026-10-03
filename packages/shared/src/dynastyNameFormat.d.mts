import type { z } from "zod";
import type { HistoricalDate } from "./schema";
export type DynastyNameDefinition = {
  periods: Array<{ name: string; start: HistoricalDate; end: HistoricalDate }>;
};
export const DynastyNameDefinitionSchema: z.ZodType<DynastyNameDefinition>;
export function parseDynastyName(raw: string): string | DynastyNameDefinition;
export function resolveDynastyDefaultName(dynasty: { name: string; altNames?: string[] }): string;
export function dynastyNameTerms(raw: string): string[];
export function validateDynastyName(dynasty: { name: string; altNames?: string[] }): string | DynastyNameDefinition;
