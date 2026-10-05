import { useEffect } from "react";
import type { AbsMonth } from "@eralens/shared";
import { absFromStageX } from "../model/coordinates";
import { viewportStore } from "../state/viewportStore";

const TIMELINE_PAN = "[data-timeline-pan]";
const TIMELINE_STAGE = "[data-timeline-stage]";
const EDITABLE = "input, textarea, select, [contenteditable='true']";
const WHEEL_OPTS: AddEventListenerOptions = { capture: true, passive: false };
const GESTURE_OPTS: AddEventListenerOptions = { capture: true, passive: false };

export function createFramePanAccumulator(
  apply: (deltaPx: number) => void,
  schedule: (callback: FrameRequestCallback) => number,
  cancel: (id: number) => void,
) {
  let pending = 0;
  let frame: number | null = null;
  const flush = () => {
    if (frame !== null) cancel(frame);
    frame = null;
    const delta = pending;
    pending = 0;
    if (delta !== 0) apply(delta);
  };
  return {
    queue(deltaPx: number) {
      pending += deltaPx;
      if (frame === null) frame = schedule(() => flush());
    },
    flush,
    cancel() {
      if (frame !== null) cancel(frame);
      frame = null;
      pending = 0;
    },
  };
}

/** Fold high-frequency pinch events into one viewport update per paint. */
export function createFrameZoomAccumulator(
  apply: (factor: number, clientX: number) => void,
  schedule: (callback: FrameRequestCallback) => number,
  cancel: (id: number) => void,
) {
  let pendingFactor = 1;
  let latestClientX = 0;
  let frame: number | null = null;
  const flush = () => {
    if (frame !== null) cancel(frame);
    frame = null;
    const factor = pendingFactor;
    pendingFactor = 1;
    if (factor !== 1) apply(factor, latestClientX);
  };
  return {
    queue(factor: number, clientX: number) {
      if (!Number.isFinite(factor) || factor <= 0 || factor === 1) return;
      pendingFactor *= factor;
      latestClientX = clientX;
      if (frame === null) frame = schedule(() => flush());
    },
    flush,
    cancel() {
      if (frame !== null) cancel(frame);
      frame = null;
      pendingFactor = 1;
    },
  };
}

const wheelPan = createFramePanAccumulator(
  (deltaPx) => viewportStore.panByPixels(deltaPx),
  (callback) => requestAnimationFrame(callback),
  (id) => cancelAnimationFrame(id),
);
const wheelZoom = createFrameZoomAccumulator(
  (factor, clientX) => viewportStore.zoomBy(factor, resolveAnchorAbs(clientX)),
  (callback) => requestAnimationFrame(callback),
  (id) => cancelAnimationFrame(id),
);

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
    wheelPan.flush();
    const factor = wheelZoomFactor(event.deltaY);
    if (Math.abs(factor - 1) > 0.0005) {
      wheelZoom.queue(factor, event.clientX);
    }
    return;
  }

  wheelZoom.flush();
  wheelPan.queue(-wheelDeltaPx(event.deltaX + event.deltaY, event.deltaMode));
}

type WebKitGestureEvent = Event & {
  scale: number;
  clientX: number;
};

/** Safari trackpad gestures only; touchscreen pinch is owned by the stage. */
export function createWebKitGestureHandlers(options: {
  isTouchActive(): boolean;
  isEditableTarget(target: EventTarget | null): boolean;
  pan: Pick<ReturnType<typeof createFramePanAccumulator>, "flush">;
  zoom: Pick<ReturnType<typeof createFrameZoomAccumulator>, "flush" | "queue">;
}) {
  let lastScale = 1;
  let active = false;
  const reset = () => { active = false; lastScale = 1; };
  return {
    reset,
    start(event: Event) {
      reset();
      if (options.isEditableTarget(event.target)) return;
      event.preventDefault();
      if (options.isTouchActive()) return;
      options.pan.flush();
      options.zoom.flush();
      lastScale = (event as WebKitGestureEvent).scale;
      active = true;
    },
    change(event: Event) {
      if (options.isEditableTarget(event.target)) return;
      event.preventDefault();
      if (!active || options.isTouchActive()) { reset(); return; }
      const ge = event as WebKitGestureEvent;
      const factor = ge.scale / lastScale;
      lastScale = ge.scale;
      if (Math.abs(factor - 1) > 0.0005) options.zoom.queue(factor, ge.clientX);
    },
    end(event: Event) {
      if (!options.isEditableTarget(event.target)) event.preventDefault();
      if (active) options.zoom.flush();
      reset();
    },
  };
}

let activeTouchCount = 0;
const gestures = createWebKitGestureHandlers({
  isTouchActive: () => activeTouchCount > 0,
  isEditableTarget,
  pan: wheelPan,
  zoom: wheelZoom,
});
function onTouchChange(event: Event) {
  activeTouchCount = (event as TouchEvent).touches.length;
  gestures.reset();
}
function resetInput() {
  activeTouchCount = 0;
  gestures.reset();
  wheelPan.cancel();
  wheelZoom.cancel();
}
function onInputVisibilityChange() { if (document.hidden) resetInput(); }

type TimelineWheelHost = Window & {
  __eralensTimelineWheel?: (event: WheelEvent) => void;
  __eralensTimelineGestureStart?: (event: Event) => void;
  __eralensTimelineGestureChange?: (event: Event) => void;
  __eralensTimelineGestureEnd?: (event: Event) => void;
  __eralensTimelineTouchChange?: (event: Event) => void;
  __eralensTimelineInputReset?: () => void;
  __eralensTimelineInputVisibilityChange?: () => void;
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
  window.addEventListener("gesturestart", gestures.start, GESTURE_OPTS);
  window.addEventListener("gesturechange", gestures.change, GESTURE_OPTS);
  window.addEventListener("gestureend", gestures.end, GESTURE_OPTS);
  host.__eralensTimelineGestureStart = gestures.start;
  host.__eralensTimelineGestureChange = gestures.change;
  host.__eralensTimelineGestureEnd = gestures.end;

  for (const type of ["touchstart", "touchend", "touchcancel"]) {
    if (host.__eralensTimelineTouchChange) window.removeEventListener(type, host.__eralensTimelineTouchChange, true);
    window.addEventListener(type, onTouchChange, { capture: true, passive: true });
  }
  for (const type of ["blur", "pagehide"]) {
    if (host.__eralensTimelineInputReset) window.removeEventListener(type, host.__eralensTimelineInputReset);
    window.addEventListener(type, resetInput);
  }
  if (host.__eralensTimelineInputVisibilityChange) {
    document.removeEventListener("visibilitychange", host.__eralensTimelineInputVisibilityChange);
  }
  document.addEventListener("visibilitychange", onInputVisibilityChange);
  host.__eralensTimelineTouchChange = onTouchChange;
  host.__eralensTimelineInputReset = resetInput;
  host.__eralensTimelineInputVisibilityChange = onInputVisibilityChange;
}

export function useTimelineWheel() {
  useEffect(() => {
    installTimelineWheel();
  }, []);
}

if (typeof window !== "undefined") {
  installTimelineWheel();
}
