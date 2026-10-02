import {
  clampAbs,
  absMonth,
  quantizeWindowForQuery,
  DEFAULT_TIMELINE_LAYOUT_PREFERENCES,
  resolveTimelinePresentation,
  type TimelineLayoutPreferences,
  type TimelinePresentation,
  type AbsMonth,
} from "@eralens/shared";
import { createPlatformSettings } from "@eralens/data-access";
import { getWindow } from "../model/coordinates";
import { resolveLod } from "../model/lod";

export type ViewportSnapshot = {
  centerAbs: AbsMonth;
  pxPerMonth: number;
  widthPx: number;
  gutterPx: number;
  presentation: TimelinePresentation;
  startAbs: AbsMonth;
  endAbs: AbsMonth;
  lod: ReturnType<typeof resolveLod>;
};

type ViewportListener = () => void;

const DEFAULT_CENTER = absMonth(-221, 1); // Qin Shi Huang's unification of China
const DEFAULT_PX_PER_MONTH = 1.5;
const MIN_PX = 0.08;
const MAX_PX = 12;
const PERSISTENCE_KEY = "eralens.timeline-viewport.v1";
const PERSISTENCE_DELAY_MS = 250;
const settings = createPlatformSettings();
/** Wide defaults until /bounds loads; 5000 abs ≈ 416 CE and blocked post-Han history. */
const DEFAULT_MIN_ABS = -30_000;
const DEFAULT_MAX_ABS = 25_000;

let centerAbs = DEFAULT_CENTER;
let pxPerMonth = DEFAULT_PX_PER_MONTH;
let widthPx = 1200;
let layoutPreferences = DEFAULT_TIMELINE_LAYOUT_PREFERENCES;
let presentation = resolveTimelinePresentation(widthPx, layoutPreferences);
let minAbs = DEFAULT_MIN_ABS;
let maxAbs = DEFAULT_MAX_ABS;

const listeners = new Set<ViewportListener>();

function buildSnapshot(): ViewportSnapshot {
  const gutterPx = presentation.gutterPx;
  const { startAbs, endAbs } = getWindow({
    centerAbs,
    pxPerMonth,
    widthPx,
    gutterPx,
  });
  return {
    centerAbs,
    pxPerMonth,
    widthPx,
    gutterPx,
    startAbs,
    presentation,
    endAbs,
    lod: resolveLod(pxPerMonth),
  };
}

/** Must keep a stable reference between updates for useSyncExternalStore. */
let snapshot = buildSnapshot();
let persistenceTimer: ReturnType<typeof setTimeout> | undefined;
let persistenceEnabled = false;

function notify() {
  snapshot = buildSnapshot();
  for (const listener of listeners) {
    listener();
  }
  schedulePersistence();
}

function schedulePersistence() {
  if (!persistenceEnabled) return;
  if (persistenceTimer !== undefined) clearTimeout(persistenceTimer);
  persistenceTimer = setTimeout(() => {
    persistenceTimer = undefined;
    void persistCurrentViewport();
  }, PERSISTENCE_DELAY_MS);
}

async function persistCurrentViewport() {
  try {
    await settings.set(PERSISTENCE_KEY, JSON.stringify({ centerAbs, pxPerMonth }));
  } catch {
    // Keep the current session usable if native preferences are unavailable.
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
  async restorePersistedState() {
    try {
      const raw = await settings.get(PERSISTENCE_KEY);
      if (!raw) return;
      const saved = JSON.parse(raw) as { centerAbs?: unknown; pxPerMonth?: unknown };
      if (typeof saved.centerAbs !== "number" || !Number.isFinite(saved.centerAbs)) return;
      if (typeof saved.pxPerMonth !== "number" || !Number.isFinite(saved.pxPerMonth)) return;
      centerAbs = saved.centerAbs;
      pxPerMonth = Math.min(MAX_PX, Math.max(MIN_PX, saved.pxPerMonth));
      notify();
    } catch {
      // Ignore missing or malformed saved state and use the default viewport.
    }
  },
  enablePersistence() {
    if (persistenceEnabled) return;
    persistenceEnabled = true;
    document.addEventListener("visibilitychange", () => {
      if (document.visibilityState !== "hidden") return;
      if (persistenceTimer !== undefined) clearTimeout(persistenceTimer);
      persistenceTimer = undefined;
      void persistCurrentViewport();
    });
  },
  setLayoutPreferences(next: TimelineLayoutPreferences) {
    if (layoutPreferences.railCollapsed === next.railCollapsed && layoutPreferences.density === next.density) return;
    layoutPreferences = next;
    presentation = resolveTimelinePresentation(widthPx, layoutPreferences);
    notify();
  },
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
    presentation = resolveTimelinePresentation(widthPx, layoutPreferences);
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
