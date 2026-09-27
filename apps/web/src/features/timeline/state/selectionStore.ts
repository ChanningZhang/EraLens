import type { EntityRef } from "@eralens/shared";
import type { AbsMonth } from "@eralens/shared";
import { readSelectionUrlState, writeSelectionUrlState } from "./selectionUrlState";
import { loadDetailWidth, saveDetailWidth } from "./userSettings";

export type SelectionState = {
  selected: EntityRef | null;
  detailOpen: boolean;
  detailWidth: number;
  highlightAbs: AbsMonth | null;
  focusReignId: string | null;
  detailHistory: DetailHistoryEntry[];
};

export type DetailHistoryEntry = Pick<
  SelectionState,
  "selected" | "detailOpen" | "highlightAbs" | "focusReignId"
> & {
  viewportCenterAbs: AbsMonth;
};

type SelectionListener = () => void;

type SelectOptions = {
  focusReignId?: string | null;
};

const DEFAULT_WIDTH = 360;
const MIN_WIDTH = 360;
const MAX_WIDTH = 640;

function syncUrl(state: SelectionState, centerAbs?: AbsMonth) { writeSelectionUrlState(state, centerAbs); }

const initialUrlState = readSelectionUrlState();
let state: SelectionState = {
  selected: null,
  detailOpen: false,
  detailWidth: DEFAULT_WIDTH,
  highlightAbs: null,
  focusReignId: null,
  detailHistory: [],
  ...initialUrlState,
};

const listeners = new Set<SelectionListener>();

if (initialUrlState.detailWidth === undefined) {
  void loadDetailWidth().then((width) => {
    if (width == null) return;
    state = { ...state, detailWidth: Math.min(MAX_WIDTH, Math.max(MIN_WIDTH, width)) };
    notify();
  }).catch(() => { /* Default width remains available if settings cannot be read. */ });
}

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
      detailHistory: [],
    };
    notify();
  },
  navigateToDetail(
    ref: EntityRef,
    abs: AbsMonth | undefined,
    viewportCenterAbs: AbsMonth,
    options?: SelectOptions,
  ) {
    if (!state.selected || !state.detailOpen) {
      selectionStore.select(ref, abs, options);
      return;
    }
    const focusReignId = resolveFocusReignId(ref, options);
    state = {
      ...state,
      selected: ref,
      detailOpen: true,
      highlightAbs: abs ?? state.highlightAbs,
      focusReignId,
      detailHistory: [
        ...state.detailHistory,
        {
          selected: state.selected,
          detailOpen: state.detailOpen,
          highlightAbs: state.highlightAbs,
          focusReignId: state.focusReignId,
          viewportCenterAbs,
        },
      ],
    };
    notify();
  },
  goBack(viewportCenterAbs: AbsMonth): AbsMonth | null {
    const previous = state.detailHistory.at(-1);
    if (!previous) return null;
    state = {
      ...state,
      selected: previous.selected,
      detailOpen: previous.detailOpen,
      highlightAbs: previous.highlightAbs,
      focusReignId: previous.focusReignId,
      detailHistory: state.detailHistory.slice(0, -1),
    };
    syncUrl(state, previous.viewportCenterAbs ?? viewportCenterAbs);
    notify();
    return previous.viewportCenterAbs ?? viewportCenterAbs;
  },
  clearSelection() {
    state = {
      ...state,
      selected: null,
      detailOpen: false,
      highlightAbs: null,
      focusReignId: null,
      detailHistory: [],
    };
    syncUrl(state);
    notify();
  },
  setDetailWidth(width: number) {
    const clamped = Math.min(MAX_WIDTH, Math.max(MIN_WIDTH, width));
    state = { ...state, detailWidth: clamped };
    void saveDetailWidth(clamped);
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
