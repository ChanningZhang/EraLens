import { absMonth } from "./time";

/** 大一统王朝自起始即为中国正统（展示为金色）。分裂期、偏安或割据政权不在此列。 */
export const ORTHODOX_FROM_START = new Set([
  "xia",
  "shang",
  "zhou-west",
  "zhou-east",
  "han-west",
  "xin",
  "han-gengshi",
  "han-east",
  "jin-west",
  "jin-east",
  "sui",
  "tang",
  "song-north",
  "song-south",
  "yuan",
  "ming",
  "roc",
]);

/** 在特定 AbsMonth 之后才成为中国正统。 */
export const ORTHODOX_FROM_ABS: Readonly<Record<string, number>> = {
  qin: absMonth(-221),
  /** 入关定鼎后自顺治（福临）起算；努尔哈赤、皇太极在位不算正统。 */
  qing: absMonth(1644),
};

/** 在特定 AbsMonth 之前仍为中国正统（王朝存续更久时用于截断金色展示）。 */
export const ORTHODOX_END_ABS: Readonly<Record<string, number>> = {
  /** 1368 年顺帝北逃后中原正统归明；漠北延续不计正统。 */
  yuan: absMonth(1368),
};

export type OrthodoxDynasty = {
  id: string;
  startAbs: number;
  endAbs?: number;
  orthodoxFromAbs?: number;
  orthodoxEndAbs?: number;
};

export function resolveOrthodoxFromAbs(dynasty: OrthodoxDynasty): number | undefined {
  if (dynasty.orthodoxFromAbs != null) return dynasty.orthodoxFromAbs;
  const explicit = ORTHODOX_FROM_ABS[dynasty.id];
  if (explicit != null) return explicit;
  if (ORTHODOX_FROM_START.has(dynasty.id)) return dynasty.startAbs;
  return undefined;
}

export function resolveOrthodoxEndAbs(
  dynasty: OrthodoxDynasty & { endAbs: number },
): number | undefined {
  if (dynasty.orthodoxEndAbs != null) return dynasty.orthodoxEndAbs;
  const explicit = ORTHODOX_END_ABS[dynasty.id];
  if (explicit != null) return explicit;
  if (resolveOrthodoxFromAbs(dynasty) == null) return undefined;
  return dynasty.endAbs;
}

export function isOrthodoxAt(
  dynasty: OrthodoxDynasty & { endAbs?: number },
  atAbs: number,
): boolean {
  const from = resolveOrthodoxFromAbs(dynasty);
  if (from == null || atAbs < from) return false;
  if (dynasty.endAbs == null) return true;
  const end = resolveOrthodoxEndAbs(dynasty as OrthodoxDynasty & { endAbs: number });
  return end != null && atAbs <= end;
}

export function resolveOrthodoxSpan(
  dynasty: OrthodoxDynasty & { endAbs: number },
): { startAbs: number; endAbs: number } | null {
  const from = resolveOrthodoxFromAbs(dynasty);
  if (from == null) return null;
  const startAbs = Math.max(from, dynasty.startAbs);
  const endAbs = resolveOrthodoxEndAbs(dynasty);
  if (endAbs == null || startAbs > endAbs) return null;
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
  // Reigns starting at orthodox end (e.g. 元惠宗 1368) are post-orthodox.
  return startAbs < span.endAbs && endAbs >= span.startAbs;
}
