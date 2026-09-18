import { isParallelClaim } from "./claimTracks";
import type { Reign } from "./schema";
import { absMonth } from "./time";

/** 大一统王朝自起始即为中国正统（展示为金色）。分裂期、偏安或割据政权不在此列。 */
export const ORTHODOX_FROM_START = new Set([
  "xia",
  "shang",
  "zhou-west",
  "zhou-east",
  "han-east",
  "jin-west",
  "jin-east",
  "sui",
  "tang",
  "zhou-wu",
  "song-north",
  "song-south",
  "ming",
  "roc",
]);

/** 在特定 AbsMonth 之后才成为中国正统。 */
export const ORTHODOX_FROM_ABS: Readonly<Record<string, number>> = {
  qin: absMonth(-221),
  /** 刘邦称帝建汉后始为正统；沛公/汉王起兵至称帝前不计金色。 */
  "han-west": absMonth(-202, 2),
  /** 入关定鼎后自顺治（福临）起算；努尔哈赤、皇太极在位不算正统。 */
  qing: absMonth(1644),
  /** 宋恭帝降元后始为中原正统；定国号至恭帝投降前世祖拆段非正统。 */
  yuan: absMonth(1276, 2),
};

/** 在特定 AbsMonth 之前仍为中国正统（王朝存续更久时用于截断金色展示）。 */
export const ORTHODOX_END_ABS: Readonly<Record<string, number>> = {
  /**
   * 王朝行止于 618 正月以对接唐，金色覆盖整年，使江都续统杨浩
   * （618 起，炀帝被弑后）仍算正统。
   */
  sui: absMonth(618, 12),
  /** 1368 年顺帝北逃后中原正统归明；漠北延续不计正统。 */
  yuan: absMonth(1368),
  /** 恭帝降元后南宋正统终结；端宗、帝昺续统不计正统。 */
  "song-south": absMonth(1276, 2),
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
  // Reigns ending at orthodox start (e.g. 曹丕魏王嗣位 220-12) are pre-orthodox.
  return startAbs < span.endAbs && endAbs > span.startAbs;
}

/**
 * Gold on a card: the dynasty span is orthodox *and* the reign is the
 * conventionally counted line. Parallel claimants (隋恭帝杨侑 while 炀帝
 * still lived, 南明鲁监国) stay on their own row without gold.
 */
/** Months between accession and delayed-orthodox begin that still count (e.g. 顺治 1643→1644). */
const DELAYED_ORTHODOX_ACCESSION_GRACE = 12;

export function isOrthodoxReign(
  dynasty: OrthodoxDynasty & { endAbs: number },
  reign: Pick<Reign, "startAbs" | "endAbs" | "claimTrack">,
): boolean {
  if (isParallelClaim(reign)) return false;
  const span = resolveOrthodoxSpan(dynasty);
  if (!span) return false;
  if (reign.endAbs <= span.startAbs) return false;
  // Gold when the reign *begins* inside the orthodox window (秦始皇, not 秦王政).
  if (reign.startAbs >= span.startAbs && reign.startAbs < span.endAbs) return true;

  const orthodoxFrom = resolveOrthodoxFromAbs(dynasty);
  // Delayed-orthodox dynasties (秦、清): accession shortly before orthodox
  // begin still counts if the reign continues past it (顺治 vs 入关).
  if (
    orthodoxFrom != null &&
    orthodoxFrom > dynasty.startAbs &&
    reign.startAbs < span.startAbs &&
    span.startAbs - reign.startAbs <= DELAYED_ORTHODOX_ACCESSION_GRACE
  ) {
    return true;
  }

  return false;
}
