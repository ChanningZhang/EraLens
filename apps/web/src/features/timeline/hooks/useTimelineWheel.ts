import { useEffect } from "react";
import type { AbsMonth } from "@eralens/shared";
import { absFromStageX } from "../model/coordinates";
import { viewportStore } from "../state/viewportStore";

const TIMELINE_PAN = "[data-timeline-pan]";
const TIMELINE_STAGE = "[data-timeline-stage]";
const EDITABLE = "input, textarea, select, [contenteditable='true']";
const WHEEL_OPTS: AddEventListenerOptions = { capture: true, passive: false };
const GESTURE_OPTS: AddEventListenerOptions = { capture: true, passive: false };

/** Mac trackpad pinch synthesizes ctrlKey; Cmd+scroll uses metaKey. */
export function isZoomWheel(event: Pick<WheelEvent, "ctrlKey" | "metaKey">): boolean {
  return event.ctrlKey || event.metaKey;
}

/** Exponential factor keeps pinch steps smooth across delta magnitudes. */
export function wheelZoomFactor(deltaY: number): number {
  return Math.exp(-deltaY * 0.002);
}

export type WheelAction = "zoom" | "pan" | "ignore";

export function isEditableTarget(target: EventTarget | null): boolean {
  if (!(target instanceof Element)) return false;
  return target.closest(EDITABLE) instanceof HTMLElement;
}

export function resolveWheelAction(
  deltaX: number,
  deltaY: number,
  zoom: boolean,
  onPan: boolean,
): WheelAction {
  if (zoom) return "zoom";
  if (onPan) return "pan";
  if (Math.abs(deltaX) > Math.abs(deltaY)) return "pan";
  return "ignore";
}

/** Stage content overflows vertically — vertical wheel should scroll, not pan. */
export function isStageVerticallyScrollable(
  stageEl: Pick<HTMLElement, "scrollHeight" | "clientHeight">,
): boolean {
  return stageEl.scrollHeight > stageEl.clientHeight + 1;
}

/**
 * When the stage is taller than its viewport, vertical-dominant wheel scrolls
 * lanes. Trackpad flicks almost always carry a few pixels of deltaX; those
 * must still scroll, not pan time. Horizontal-dominant swipes keep panning.
 * The wheel handler preventDefaults either way so leftover X cannot leak to
 * macOS Notification Center.
 */
export function shouldDeferToStageVerticalScroll(
  deltaX: number,
  deltaY: number,
  zoom: boolean,
  stageScrollable: boolean,
): boolean {
  if (zoom || !stageScrollable) return false;
  if (Math.abs(deltaX) >= Math.abs(deltaY)) return false;
  return Math.abs(deltaY) > 0;
}

/** Normalize wheel delta to CSS pixels. Trackpads use DOM_DELTA_PIXEL (0). */
export function wheelDeltaPx(delta: number, deltaMode: number): number {
  if (deltaMode === 1) return delta * 16;
  if (deltaMode === 2) return delta * 800;
  return delta;
}

export function applyStageVerticalScroll(
  stageEl: Pick<HTMLElement, "scrollTop">,
  deltaY: number,
  deltaMode: number,
): void {
  stageEl.scrollTop += wheelDeltaPx(deltaY, deltaMode);
}

function resolveAnchorAbs(clientX: number): AbsMonth {
  const viewport = viewportStore.getSnapshot();
  const stageEl = document.querySelector(TIMELINE_STAGE);
  if (!(stageEl instanceof HTMLElement)) return viewport.centerAbs;
  const rect = stageEl.getBoundingClientRect();
  const x = clientX - rect.left;
  if (x < viewport.gutterPx || x > rect.width) return viewport.centerAbs;
  return absFromStageX(viewport, x);
}

function onWheel(event: WheelEvent) {
  if (isEditableTarget(event.target)) return;

  const target = event.target;
  const stageEl = target instanceof Element ? target.closest(TIMELINE_STAGE) : null;
  const panEl = target instanceof Element ? target.closest(TIMELINE_PAN) : null;

  if (
    stageEl instanceof HTMLElement &&
    shouldDeferToStageVerticalScroll(
      event.deltaX,
      event.deltaY,
      isZoomWheel(event),
      isStageVerticallyScrollable(stageEl),
    )
  ) {
    // Consume the gesture in JS. Native overflow scroll on Mac lets leftover
    // horizontal overscroll escape to the OS (Notification Center / Mission Control).
    event.preventDefault();
    applyStageVerticalScroll(stageEl, event.deltaY, event.deltaMode);
    return;
  }

  const action = resolveWheelAction(
    event.deltaX,
    event.deltaY,
    isZoomWheel(event),
    panEl instanceof HTMLElement,
  );
  if (action === "ignore") return;

  event.preventDefault();

  if (action === "zoom") {
    const factor = wheelZoomFactor(event.deltaY);
    if (Math.abs(factor - 1) > 0.0005) {
      viewportStore.zoomBy(factor, resolveAnchorAbs(event.clientX));
    }
    return;
  }

  viewportStore.panByPixels(-(event.deltaX + event.deltaY));
}

type WebKitGestureEvent = Event & {
  scale: number;
  clientX: number;
};

let gestureLastScale = 1;

function onGestureStart(event: Event) {
  if (isEditableTarget(event.target)) return;
  event.preventDefault();
  gestureLastScale = (event as WebKitGestureEvent).scale;
}

function onGestureChange(event: Event) {
  if (isEditableTarget(event.target)) return;
  event.preventDefault();

  const ge = event as WebKitGestureEvent;
  const factor = ge.scale / gestureLastScale;
  gestureLastScale = ge.scale;
  if (Math.abs(factor - 1) <= 0.0005) return;

  viewportStore.zoomBy(factor, resolveAnchorAbs(ge.clientX));
}

function onGestureEnd(event: Event) {
  if (isEditableTarget(event.target)) return;
  event.preventDefault();
  gestureLastScale = 1;
}

type TimelineWheelHost = Window & {
  __eralensTimelineWheel?: (event: WheelEvent) => void;
  __eralensTimelineGestureStart?: (event: Event) => void;
  __eralensTimelineGestureChange?: (event: Event) => void;
  __eralensTimelineGestureEnd?: (event: Event) => void;
};

/** Window capture listeners — survive Ruler/Stage remounts from HMR. */
export function installTimelineWheel() {
  const host = window as TimelineWheelHost;

  if (host.__eralensTimelineWheel) {
    window.removeEventListener("wheel", host.__eralensTimelineWheel, WHEEL_OPTS);
  }
  window.addEventListener("wheel", onWheel, WHEEL_OPTS);
  host.__eralensTimelineWheel = onWheel;

  if (host.__eralensTimelineGestureStart) {
    window.removeEventListener("gesturestart", host.__eralensTimelineGestureStart, GESTURE_OPTS);
  }
  if (host.__eralensTimelineGestureChange) {
    window.removeEventListener("gesturechange", host.__eralensTimelineGestureChange, GESTURE_OPTS);
  }
  if (host.__eralensTimelineGestureEnd) {
    window.removeEventListener("gestureend", host.__eralensTimelineGestureEnd, GESTURE_OPTS);
  }
  window.addEventListener("gesturestart", onGestureStart, GESTURE_OPTS);
  window.addEventListener("gesturechange", onGestureChange, GESTURE_OPTS);
  window.addEventListener("gestureend", onGestureEnd, GESTURE_OPTS);
  host.__eralensTimelineGestureStart = onGestureStart;
  host.__eralensTimelineGestureChange = onGestureChange;
  host.__eralensTimelineGestureEnd = onGestureEnd;
}

export function useTimelineWheel() {
  useEffect(() => {
    installTimelineWheel();
  }, []);
}

if (typeof window !== "undefined") {
  installTimelineWheel();
}
