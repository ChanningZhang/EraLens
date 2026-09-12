import { useEffect } from "react";
import { viewportStore } from "../state/viewportStore";

const TIMELINE_PAN = "[data-timeline-pan]";
const WHEEL_OPTS: AddEventListenerOptions = { capture: true, passive: false };

export type WheelAction = "zoom" | "pan" | "ignore";

export function resolveWheelAction(
  deltaX: number,
  deltaY: number,
  pinch: boolean,
  onTimeline: boolean,
): WheelAction {
  if (pinch && onTimeline) return "zoom";
  if (onTimeline) return "pan";
  if (Math.abs(deltaX) > Math.abs(deltaY)) return "pan";
  return "ignore";
}

function onWheel(event: WheelEvent) {
  const target = event.target;
  const timelineEl = target instanceof Element ? target.closest(TIMELINE_PAN) : null;
  const action = resolveWheelAction(
    event.deltaX,
    event.deltaY,
    event.ctrlKey || event.metaKey,
    timelineEl instanceof HTMLElement,
  );
  if (action === "ignore") return;

  event.preventDefault();

  if (action === "zoom" && timelineEl instanceof HTMLElement) {
    const viewport = viewportStore.getSnapshot();
    const rect = timelineEl.getBoundingClientRect();
    const x = event.clientX - rect.left + timelineEl.scrollLeft;
    const anchorAbs = viewport.startAbs + x / viewport.pxPerMonth;
    viewportStore.zoomBy(event.deltaY > 0 ? 0.92 : 1.08, anchorAbs);
    return;
  }

  viewportStore.panByPixels(-(event.deltaX + event.deltaY));
}

type WheelHost = Window & {
  __eralensTimelineWheel?: (event: WheelEvent) => void;
};

/** Window capture listener — survives Ruler/Stage remounts from HMR. */
export function installTimelineWheel() {
  const host = window as WheelHost;
  if (host.__eralensTimelineWheel) {
    window.removeEventListener("wheel", host.__eralensTimelineWheel, WHEEL_OPTS);
  }
  window.addEventListener("wheel", onWheel, WHEEL_OPTS);
  host.__eralensTimelineWheel = onWheel;
}

export function useTimelineWheel() {
  useEffect(() => {
    installTimelineWheel();
  }, []);
}
