import { fromAbsMonth } from "@eralens/shared";
import { LOD_THRESHOLDS } from "./lod";
import { formatRulerYear } from "./rulerTicks";

export function cursorGuideStageX(
  clientX: number,
  stageLeft: number,
  stageWidth: number,
): number | null {
  if (stageWidth <= 0) return null;
  const x = clientX - stageLeft;
  if (x < 0 || x > stageWidth) return null;
  return x;
}

export function formatCursorGuideLabel(abs: number, pxPerMonth: number): string {
  const { year, month } = fromAbsMonth(abs);
  const yearText = `${formatRulerYear(year)}年`;
  if (pxPerMonth >= LOD_THRESHOLDS.month) {
    return `${yearText}${month}月`;
  }
  return yearText;
}

export function clampCursorGuideLabelX(
  x: number,
  overlayWidth: number,
  labelWidth: number,
  pad = 4,
): number {
  const half = labelWidth / 2;
  const min = half + pad;
  const max = overlayWidth - half - pad;
  if (min >= max) return overlayWidth / 2;
  return Math.min(max, Math.max(min, x));
}
