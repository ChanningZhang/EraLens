import { encodeYearMonthParam, parseYearMonthParam, type EntityRef, type AbsMonth } from "@eralens/shared";

type UrlSelection = {
  selected: EntityRef | null;
  detailOpen: boolean;
  detailWidth: number;
  highlightAbs: AbsMonth | null;
  focusReignId: string | null;
};

export function readSelectionUrlState(): Partial<UrlSelection> {
  const params = new URLSearchParams(window.location.search);
  const sel = params.get("sel");
  const width = params.get("w");
  const yearMonth = params.get("y");
  const focusReign = params.get("r");
  const next: Partial<UrlSelection> = {};
  if (sel) {
    const [type, ...rest] = sel.split(":");
    const id = rest.join(":");
    if (["dynasty", "reign", "person", "event", "capital"].includes(type ?? "")) {
      next.selected = { type: type as EntityRef["type"], id };
      next.detailOpen = true;
    }
  }
  if (width) {
    const parsed = Number(width);
    if (Number.isFinite(parsed)) next.detailWidth = parsed;
  }
  if (yearMonth) {
    const parsed = parseYearMonthParam(yearMonth);
    if (parsed !== null) next.highlightAbs = parsed;
  }
  if (focusReign) next.focusReignId = focusReign;
  else if (next.selected?.type === "reign") next.focusReignId = next.selected.id;
  return next;
}

export function writeSelectionUrlState(state: UrlSelection, centerAbs?: AbsMonth): void {
  const params = new URLSearchParams(window.location.search);
  if (state.selected && state.detailOpen) {
    params.set("sel", `${state.selected.type}:${state.selected.id}`);
    params.set("w", String(Math.round(state.detailWidth)));
  } else {
    params.delete("sel");
    params.delete("w");
  }
  if (state.focusReignId) params.set("r", state.focusReignId);
  else params.delete("r");
  if (centerAbs !== undefined) params.set("y", encodeYearMonthParam(centerAbs));
  window.history.replaceState(null, "", `${window.location.pathname}?${params.toString()}`);
}
