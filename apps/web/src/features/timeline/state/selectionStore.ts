import type { EntityRef } from "@eralens/shared";
import { encodeYearMonthParam, parseYearMonthParam, type AbsMonth } from "@eralens/shared";

export type SelectionState = {
  selected: EntityRef | null;
  detailOpen: boolean;
  detailWidth: number;
  highlightAbs: AbsMonth | null;
  focusReignId: string | null;
};

type SelectionListener = () => void;

type SelectOptions = {
  focusReignId?: string | null;
};

const DETAIL_WIDTH_KEY = "eralens.detailWidth";
const DEFAULT_WIDTH = 400;
const MIN_WIDTH = 360;
const MAX_WIDTH = 640;

function readStoredWidth(): number {
  const raw = localStorage.getItem(DETAIL_WIDTH_KEY);
  const parsed = raw ? Number(raw) : DEFAULT_WIDTH;
  if (Number.isFinite(parsed)) {
    return Math.min(MAX_WIDTH, Math.max(MIN_WIDTH, parsed));
  }
  return DEFAULT_WIDTH;
}

function parseUrlState(): Partial<SelectionState> {
  const params = new URLSearchParams(window.location.search);
  const sel = params.get("sel");
  const w = params.get("w");
  const y = params.get("y");
  const focusReign = params.get("r");
  const next: Partial<SelectionState> = {};
  if (sel) {
    const [type, ...rest] = sel.split(":");
    const id = rest.join(":");
    if (
      type === "dynasty" ||
      type === "reign" ||
      type === "person" ||
      type === "event" ||
      type === "capital"
    ) {
      next.selected = { type, id };
      next.detailOpen = true;
    }
  }
  if (w) {
    const width = Number(w);
    if (Number.isFinite(width)) next.detailWidth = width;
  }
  if (y) {
    const abs = parseYearMonthParam(y);
    if (abs !== null) next.highlightAbs = abs;
  }
  if (focusReign) {
    next.focusReignId = focusReign;
  } else if (next.selected?.type === "reign") {
    next.focusReignId = next.selected.id;
  }
  return next;
}

function syncUrl(state: SelectionState, centerAbs?: AbsMonth) {
  const params = new URLSearchParams(window.location.search);
  if (state.selected && state.detailOpen) {
    params.set("sel", `${state.selected.type}:${state.selected.id}`);
    params.set("w", String(Math.round(state.detailWidth)));
  } else {
    params.delete("sel");
    params.delete("w");
  }
  if (state.focusReignId) {
    params.set("r", state.focusReignId);
  } else {
    params.delete("r");
  }
  if (centerAbs !== undefined) {
    params.set("y", encodeYearMonthParam(centerAbs));
  }
  const next = `${window.location.pathname}?${params.toString()}`;
  window.history.replaceState(null, "", next);
}

let state: SelectionState = {
  selected: null,
  detailOpen: false,
  detailWidth: readStoredWidth(),
  highlightAbs: null,
  focusReignId: null,
  ...parseUrlState(),
};

const listeners = new Set<SelectionListener>();

function notify() {
  for (const listener of listeners) {
    listener();
  }
}

function resolveFocusReignId(
  ref: EntityRef,
  options?: SelectOptions,
): string | null {
  if (options?.focusReignId !== undefined) {
    return options.focusReignId;
  }
  if (ref.type === "reign") {
    return ref.id;
  }
  if (ref.type === "person") {
    return null;
  }
  return null;
}

export const selectionStore = {
  subscribe(listener: SelectionListener) {
    listeners.add(listener);
    return () => listeners.delete(listener);
  },
  getSnapshot() {
    return state;
  },
  getServerSnapshot() {
    return state;
  },
  select(ref: EntityRef, abs?: AbsMonth, options?: SelectOptions) {
    const focusReignId = resolveFocusReignId(ref, options);
    if (
      state.detailOpen &&
      state.selected?.type === ref.type &&
      state.selected.id === ref.id &&
      state.focusReignId === focusReignId &&
      (abs === undefined || abs === state.highlightAbs)
    ) {
      selectionStore.clearSelection();
      return;
    }
    state = {
      ...state,
      selected: ref,
      detailOpen: true,
      highlightAbs: abs ?? state.highlightAbs,
      focusReignId,
    };
    notify();
  },
  clearSelection() {
    state = {
      ...state,
      selected: null,
      detailOpen: false,
      highlightAbs: null,
      focusReignId: null,
    };
    syncUrl(state);
    notify();
  },
  setDetailWidth(width: number) {
    const clamped = Math.min(MAX_WIDTH, Math.max(MIN_WIDTH, width));
    state = { ...state, detailWidth: clamped };
    localStorage.setItem(DETAIL_WIDTH_KEY, String(clamped));
    syncUrl(state);
    notify();
  },
  resetDetailWidth() {
    selectionStore.setDetailWidth(DEFAULT_WIDTH);
  },
  setHighlightAbs(abs: AbsMonth | null) {
    state = { ...state, highlightAbs: abs };
    notify();
  },
  syncToUrl(centerAbs: AbsMonth) {
    syncUrl(state, centerAbs);
  },
};

export const DETAIL_WIDTH_LIMITS = { min: MIN_WIDTH, max: MAX_WIDTH, default: DEFAULT_WIDTH };
