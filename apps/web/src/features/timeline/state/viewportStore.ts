import {
  clampAbs,
  computeWindow,
  quantizeWindowForQuery,
  type AbsMonth,
} from "@eralens/shared";
import { resolveLod } from "../model/lod";

export type ViewportSnapshot = {
  centerAbs: AbsMonth;
  pxPerMonth: number;
  widthPx: number;
  startAbs: AbsMonth;
  endAbs: AbsMonth;
  lod: ReturnType<typeof resolveLod>;
};

type ViewportListener = () => void;

const DEFAULT_CENTER = 2400; // ~200 CE
const DEFAULT_PX_PER_MONTH = 1.5;
const MIN_PX = 0.08;
const MAX_PX = 12;
/** Wide defaults until /bounds loads; 5000 abs ≈ 416 CE and blocked post-Han history. */
const DEFAULT_MIN_ABS = -30_000;
const DEFAULT_MAX_ABS = 25_000;

let centerAbs = DEFAULT_CENTER;
let pxPerMonth = DEFAULT_PX_PER_MONTH;
let widthPx = 1200;
let minAbs = DEFAULT_MIN_ABS;
let maxAbs = DEFAULT_MAX_ABS;

const listeners = new Set<ViewportListener>();

function buildSnapshot(): ViewportSnapshot {
  const { startAbs, endAbs } = computeWindow(centerAbs, widthPx, pxPerMonth);
  return {
    centerAbs,
    pxPerMonth,
    widthPx,
    startAbs,
    endAbs,
    lod: resolveLod(pxPerMonth),
  };
}

/** Must keep a stable reference between updates for useSyncExternalStore. */
let snapshot = buildSnapshot();

function notify() {
  snapshot = buildSnapshot();
  for (const listener of listeners) {
    listener();
  }
}

function getSnapshot(): ViewportSnapshot {
  return snapshot;
}

export const viewportStore = {
  subscribe(listener: ViewportListener) {
    listeners.add(listener);
    return () => listeners.delete(listener);
  },
  getSnapshot,
  getServerSnapshot: getSnapshot,
  setBounds(min: AbsMonth, max: AbsMonth) {
    if (minAbs === min && maxAbs === max) return;
    minAbs = min;
    maxAbs = max;
    centerAbs = clampAbs(centerAbs, minAbs, maxAbs);
    notify();
  },
  setWidthPx(width: number) {
    const nextWidth = Math.max(320, width);
    if (Math.abs(widthPx - nextWidth) < 0.5) return;
    widthPx = nextWidth;
    notify();
  },
  setCenterAbs(next: AbsMonth, { clamp = true } = {}) {
    const nextCenter = clamp ? clampAbs(next, minAbs, maxAbs) : next;
    if (Math.abs(centerAbs - nextCenter) < 0.001) return;
    centerAbs = nextCenter;
    notify();
  },
  panByMonths(deltaMonths: number) {
    viewportStore.setCenterAbs(centerAbs + deltaMonths);
  },
  panByPixels(deltaPx: number) {
    const deltaMonths = deltaPx / pxPerMonth;
    viewportStore.setCenterAbs(centerAbs - deltaMonths);
  },
  setPxPerMonth(next: number, anchorAbs?: AbsMonth) {
    const clamped = Math.min(MAX_PX, Math.max(MIN_PX, next));
    if (anchorAbs !== undefined) {
      const beforeX = (anchorAbs - centerAbs) * pxPerMonth;
      pxPerMonth = clamped;
      centerAbs = clampAbs(anchorAbs - beforeX / pxPerMonth, minAbs, maxAbs);
    } else {
      pxPerMonth = clamped;
    }
    notify();
  },
  zoomBy(factor: number, anchorAbs?: AbsMonth) {
    viewportStore.setPxPerMonth(pxPerMonth * factor, anchorAbs ?? centerAbs);
  },
  getQueryWindow() {
    const { startAbs, endAbs } = getSnapshot();
    return quantizeWindowForQuery(startAbs, endAbs);
  },
  jumpToAbs(abs: AbsMonth) {
    viewportStore.setCenterAbs(abs);
  },
};

export function useViewportStore<T>(selector: (state: ViewportSnapshot) => T): T {
  return selector(getSnapshot());
}
