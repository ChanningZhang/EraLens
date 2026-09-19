import {
  isSystemMissingReign,
  isUncertainDateConfidence,
  reignVisualBounds,
  resolveReignCardLabel,
  type PreQinClanContext,
  type Reign,
} from "@eralens/shared";
import {
  LANE_PADDING_TOP,
  resolveReignVisualSpan,
  resolveStackedCardUnit,
  STACK_ROW_HEIGHT,
} from "./reignClusters";
import { projectAbs, type ViewportState } from "./coordinates";
import { resolveReignBarLayout } from "./lod";

/** Breathing room at interpolated seams so wavy junctions stay visible. */
const UNCERTAIN_SEAM_GAP_PX = 3;

export type ReignCardLayout = {
  reignId: string;
  dynastyId: string;
  barLeft: number;
  barRight: number;
  barTop: number;
  barMidY: number;
  barHeight: number;
};

function layoutMissingReignBar(
  gap: Reign,
  dynastyId: string,
  laneTop: number,
  viewport: ViewportState,
): ReignCardLayout | null {
  const endExclusive = gap.endAbs + 1;
  const barLeft = projectAbs(viewport, gap.startAbs);
  const barRight = projectAbs(viewport, endExclusive);
  if (barRight <= barLeft) return null;
  const barTop = laneTop + LANE_PADDING_TOP;
  const barHeight = STACK_ROW_HEIGHT;
  return {
    reignId: gap.id,
    dynastyId,
    barLeft,
    barRight,
    barTop,
    barMidY: barTop + barHeight / 2,
    barHeight,
  };
}

/** Shared bar geometry for `ReignCard` and `ReignGapCard` (and fate anchors). */
export function layoutLaneReignBar(
  reign: Reign,
  dynastyId: string,
  rulers: Reign[],
  viewport: ViewportState,
  laneTop: number,
  personName?: string,
  clan?: PreQinClanContext | null,
): ReignCardLayout | null {
  if (isSystemMissingReign(reign)) {
    return layoutMissingReignBar(reign, dynastyId, laneTop, viewport);
  }
  return layoutRulerReignBar(reign, dynastyId, rulers, viewport, laneTop, personName, clan);
}

function layoutRulerReignBar(
  reign: Reign,
  dynastyId: string,
  reigns: Reign[],
  viewport: ViewportState,
  laneTop: number,
  personName?: string,
  clan?: PreQinClanContext | null,
): ReignCardLayout | null {
  const { startAbs, endExclusive } = resolveReignVisualSpan(reign, reigns);
  const { unitTop, unitHeight } = resolveStackedCardUnit(reign, reigns);
  const visual = reignVisualBounds(reign, startAbs, endExclusive);
  const durationMonths = visual.endExclusive - visual.start;
  const visualWidth = Math.max(0, durationMonths * viewport.pxPerMonth);
  if (visualWidth <= 0) return null;

  const anchor = (visual.start + visual.endExclusive) / 2;
  const seamInsetLeft = isUncertainDateConfidence(reign.startDateConfidence)
    ? UNCERTAIN_SEAM_GAP_PX
    : 0;
  const seamInsetRight = isUncertainDateConfidence(reign.endDateConfidence)
    ? UNCERTAIN_SEAM_GAP_PX
    : 0;

  const label = resolveReignCardLabel(reign, personName, {
    cardWidthPx: visualWidth,
    clan,
  });
  const barLayout = resolveReignBarLayout(visualWidth, [...label].length);
  const unitLeft = barLayout.centerOnAnchor
    ? projectAbs(viewport, anchor) - barLayout.unitWidthPx / 2
    : projectAbs(viewport, visual.start);
  const barTop = laneTop + LANE_PADDING_TOP + unitTop;
  const rowHeight = unitHeight;

  let barLeft: number;
  let barRight: number;
  if (barLayout.markerStyle) {
    barLeft = unitLeft + barLayout.barInsetPx;
    barRight = barLeft + barLayout.barWidthPx;
  } else {
    barLeft = unitLeft + seamInsetLeft;
    barRight = unitLeft + barLayout.unitWidthPx - seamInsetRight;
  }

  return {
    reignId: reign.id,
    dynastyId,
    barLeft,
    barRight,
    barTop,
    barMidY: barTop + rowHeight / 2,
    barHeight: rowHeight,
  };
}

/** @deprecated Use {@link layoutLaneReignBar} */
export const layoutReignCard = layoutRulerReignBar;

export function clampAbsToBarX(
  abs: number,
  layout: Pick<ReignCardLayout, "barLeft" | "barRight">,
  viewport: ViewportState,
): number {
  const x = projectAbs(viewport, abs);
  return Math.min(layout.barRight, Math.max(layout.barLeft, x));
}
