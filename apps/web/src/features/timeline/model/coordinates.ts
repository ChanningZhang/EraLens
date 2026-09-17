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

/** Stage x of the temporal center; frozen dynasty names switch when a phase crosses this line. */
export function centerGuideX(state: ViewportState): number {
  return projectAbs(state, state.centerAbs);
}

/** Abs used to resolve frozen lane labels and phase colors. */
export function laneLabelAnchorAbs(state: Pick<ViewportState, "centerAbs">): AbsMonth {
  return state.centerAbs;
}
