import { absToX, computeWindow, type AbsMonth } from "@eralens/shared";

export type ViewportState = {
  centerAbs: AbsMonth;
  pxPerMonth: number;
  widthPx: number;
};

export function getWindow(state: ViewportState) {
  return computeWindow(state.centerAbs, state.widthPx, state.pxPerMonth);
}

export function projectAbs(state: ViewportState, abs: AbsMonth): number {
  const { startAbs } = getWindow(state);
  return absToX(abs, startAbs, state.pxPerMonth);
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
