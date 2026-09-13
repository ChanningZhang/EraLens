import { absMonth } from "./time";

/** 自王朝起始即为中国正统（展示为金色）。 */
export const ORTHODOX_FROM_START = new Set([
  "xia",
  "shang",
  "zhou-west",
  "zhou-east",
  "han-west",
  "xin",
  "han-gengshi",
  "han-east",
  "wei",
  "jin-west",
  "jin-east",
  "song-liu",
  "qi-nan",
  "liang-nan",
  "chen-nan",
  "wei-north",
  "wei-east",
  "wei-west",
  "qi-bei",
  "zhou-bei",
  "sui",
  "tang",
  "liang-hou",
  "tang-hou",
  "jin-hou",
  "han-hou",
  "zhou-hou",
  "song-north",
  "song-south",
  "yuan",
  "ming",
  "qing",
]);

/** 在特定 AbsMonth 之后才成为中国正统。 */
export const ORTHODOX_FROM_ABS: Readonly<Record<string, number>> = {
  qin: absMonth(-221),
};

export type OrthodoxDynasty = {
  id: string;
  startAbs: number;
  orthodoxFromAbs?: number;
};

export function resolveOrthodoxFromAbs(dynasty: OrthodoxDynasty): number | undefined {
  if (dynasty.orthodoxFromAbs != null) return dynasty.orthodoxFromAbs;
  const explicit = ORTHODOX_FROM_ABS[dynasty.id];
  if (explicit != null) return explicit;
  if (ORTHODOX_FROM_START.has(dynasty.id)) return dynasty.startAbs;
  return undefined;
}

export function isOrthodoxAt(dynasty: OrthodoxDynasty, atAbs: number): boolean {
  const from = resolveOrthodoxFromAbs(dynasty);
  return from != null && atAbs >= from;
}

export function resolveOrthodoxSpan(
  dynasty: OrthodoxDynasty & { endAbs: number },
): { startAbs: number; endAbs: number } | null {
  const from = resolveOrthodoxFromAbs(dynasty);
  if (from == null) return null;
  const startAbs = Math.max(from, dynasty.startAbs);
  const endAbs = dynasty.endAbs;
  if (startAbs > endAbs) return null;
  return { startAbs, endAbs };
}

/** True when [startAbs, endAbs] overlaps the dynasty's orthodox display span. */
export function overlapsOrthodoxSpan(
  dynasty: OrthodoxDynasty & { endAbs: number },
  startAbs: number,
  endAbs: number,
): boolean {
  const span = resolveOrthodoxSpan(dynasty);
  if (!span) return false;
  return startAbs <= span.endAbs && endAbs >= span.startAbs;
}
