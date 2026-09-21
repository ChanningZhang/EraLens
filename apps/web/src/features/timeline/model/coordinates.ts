import { absToX, computeWindow, type AbsMonth } from "@eralens/shared";

export type ViewportState = {
  centerAbs: AbsMonth;
  pxPerMonth: number;
  widthPx: number;
  /** Left inset reserved for the dynasty-name rail. */
  gutterPx?: number;
};

export function gutterPxOf(state: ViewportState): number {
  return state.gutterPx ?? 0;
}

export function contentWidthPx(state: ViewportState): number {
  return Math.max(1, state.widthPx - gutterPxOf(state));
}

export function getWindow(state: ViewportState) {
  return computeWindow(state.centerAbs, contentWidthPx(state), state.pxPerMonth);
}

export function projectAbs(state: ViewportState, abs: AbsMonth): number {
  const { startAbs } = getWindow(state);
  return gutterPxOf(state) + absToX(abs, startAbs, state.pxPerMonth);
}

export function absFromStageX(state: ViewportState, x: number): AbsMonth {
  const { startAbs } = getWindow(state);
  return startAbs + (x - gutterPxOf(state)) / state.pxPerMonth;
}

export function projectWidth(state: ViewportState, startAbs: AbsMonth, endAbs: AbsMonth): number {
  return Math.max(1, (endAbs - startAbs + 1) * state.pxPerMonth);
}

export function projectRange(state: ViewportState, startAbs: AbsMonth, endAbs: AbsMonth) {
  return {
    left: projectAbs(state, startAbs),
    width: projectWidth(state, startAbs, endAbs),
  };
}

/**
 * Time-axis range clipped to the visible stage (rail gutter … viewport width).
 * Returns null when the span is off-screen or the numbers are not finite.
 */
export function projectClippedRange(
  state: ViewportState,
  startAbs: AbsMonth,
  endAbs: AbsMonth,
): { left: number; width: number } | null {
  const gutter = gutterPxOf(state);
  const rawLeft = projectAbs(state, startAbs);
  const rawRight = rawLeft + projectWidth(state, startAbs, endAbs);
  if (!Number.isFinite(rawLeft) || !Number.isFinite(rawRight)) return null;
  const left = Math.max(rawLeft, gutter);
  const right = Math.min(rawRight, state.widthPx);
  const width = right - left;
  if (width < 1) return null;
  return { left, width };
}

/** Stage x of the temporal center; frozen dynasty names switch when a phase crosses this line. */
export function centerGuideX(state: ViewportState): number {
  return gutterPxOf(state) + contentWidthPx(state) / 2;
}

/** Abs used to resolve frozen lane labels, phase colors, and name-chip gold. */
export function laneLabelAnchorAbs(state: Pick<ViewportState, "centerAbs">): AbsMonth {
  return state.centerAbs;
}
