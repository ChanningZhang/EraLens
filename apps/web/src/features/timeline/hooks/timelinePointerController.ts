type Point = { x: number; y: number };
type Gesture = Point & {
  mode: "pending" | "pan" | "scroll" | "pinch" | "map-pan";
  time: number;
  velocity: number;
  distance: number;
};

type Options = {
  stage: HTMLElement;
  lifecycleTarget: EventTarget;
  visibilityTarget: EventTarget & { hidden: boolean };
  pan: { queue(delta: number): void; flush(): void; cancel(): void };
  zoom: { queue(factor: number, clientX: number): void; flush(): void; cancel(): void };
  isMapPanTarget(event: PointerEvent): boolean;
  moveMap(dx: number, dy: number): void;
  stopInertia(): void;
  startInertia(velocity: number): void;
};

/** Own the entire pointer lifecycle, including endings outside the stage. */
export function createTimelinePointerController(options: Options) {
  const { stage, lifecycleTarget, visibilityTarget, pan, zoom } = options;
  const pointers = new Map<number, Point>();
  let gesture: Gesture | null = null;
  let mapPanTimer: ReturnType<typeof setTimeout> | null = null;

  const clearMapPanTimer = () => {
    if (mapPanTimer !== null) clearTimeout(mapPanTimer);
    mapPanTimer = null;
  };
  const releasePointer = (id: number) => {
    if (stage.hasPointerCapture(id)) stage.releasePointerCapture(id);
  };
  const pendingGesture = (point: Point): Gesture => ({
    ...point, mode: "pending", time: performance.now(), velocity: 0, distance: 0,
  });
  const reset = () => {
    clearMapPanTimer();
    options.stopInertia();
    pan.cancel();
    zoom.cancel();
    const ids = [...pointers.keys()];
    pointers.clear();
    gesture = null;
    ids.forEach(releasePointer);
  };

  const onPointerDown = (rawEvent: Event) => {
    const event = rawEvent as PointerEvent;
    if (event.pointerType === "mouse") {
      if (event.button !== 0 || !options.isMapPanTarget(event)) return;
      reset();
    } else if (event.pointerType === "touch") {
      // A new primary touch means no previous fingers remain on the screen.
      // Recover even if WebKit never delivered their terminal pointer events.
      if (event.isPrimary) reset();
    } else return;
    options.stopInertia();
    pointers.set(event.pointerId, { x: event.clientX, y: event.clientY });
    const points = [...pointers.values()];
    if (points.length >= 2) {
      clearMapPanTimer();
      pan.flush();
      zoom.flush();
      const [a, b] = points;
      gesture = {
        ...pendingGesture({ x: (a.x + b.x) / 2, y: (a.y + b.y) / 2 }),
        mode: "pinch",
        distance: Math.max(1, Math.hypot(a.x - b.x, a.y - b.y)),
      };
    } else {
      gesture = pendingGesture({ x: event.clientX, y: event.clientY });
      if (event.pointerType === "mouse") gesture.mode = "map-pan";
    }
    stage.setPointerCapture(event.pointerId);
    if (event.pointerType === "touch" && points.length === 1 && options.isMapPanTarget(event)) {
      mapPanTimer = setTimeout(() => {
        if (gesture?.mode === "pending" && pointers.size === 1) gesture.mode = "map-pan";
        mapPanTimer = null;
      }, 450);
    }
  };

  const onPointerMove = (rawEvent: Event) => {
    const event = rawEvent as PointerEvent;
    if (!pointers.has(event.pointerId) || !gesture) return;
    pointers.set(event.pointerId, { x: event.clientX, y: event.clientY });
    const points = [...pointers.values()];
    if (points.length >= 2) {
      const [a, b] = points;
      const distance = Math.max(1, Math.hypot(a.x - b.x, a.y - b.y));
      const midpointX = (a.x + b.x) / 2;
      if (gesture.mode === "pinch" && gesture.distance > 0) {
        zoom.queue(distance / gesture.distance, midpointX);
      }
      gesture = { ...gesture, mode: "pinch", distance, x: midpointX, y: (a.y + b.y) / 2 };
      event.preventDefault();
      return;
    }

    const dx = event.clientX - gesture.x;
    const dy = event.clientY - gesture.y;
    if (gesture.mode === "map-pan") {
      options.moveMap(dx, dy);
      gesture = { ...gesture, x: event.clientX, y: event.clientY };
    } else if (gesture.mode === "pending") {
      if (Math.max(Math.abs(dx), Math.abs(dy)) < 7) return;
      clearMapPanTimer();
      if (Math.abs(dx) >= Math.abs(dy) * 1.2) {
        gesture = { ...gesture, mode: "pan", x: event.clientX, y: event.clientY, time: performance.now() };
      } else {
        stage.scrollTop -= dy;
        gesture = { ...gesture, mode: "scroll", x: event.clientX, y: event.clientY };
      }
    } else if (gesture.mode === "scroll") {
      stage.scrollTop -= dy;
      gesture = { ...gesture, x: event.clientX, y: event.clientY };
    } else if (gesture.mode === "pan") {
      const now = performance.now();
      const dt = now - gesture.time;
      pan.queue(dx);
      gesture = { ...gesture, x: event.clientX, y: event.clientY, time: now, velocity: dt > 0 ? dx / dt : gesture.velocity };
    } else return;
    event.preventDefault();
  };

  const endPointer = (rawEvent: Event) => {
    const event = rawEvent as PointerEvent;
    if (!pointers.has(event.pointerId)) return;
    // A bubbled capture loss from a child is not loss of the stage's capture.
    if (event.type === "lostpointercapture" && event.target !== stage) return;
    clearMapPanTimer();
    pointers.delete(event.pointerId);
    const previous = gesture;
    const remaining = [...pointers.values()];
    // Rebase at the remaining finger, so pinch -> one finger immediately pans.
    gesture = remaining.length === 1 ? pendingGesture(remaining[0]) : null;
    if (remaining.length >= 2) {
      const [a, b] = remaining;
      gesture = {
        ...pendingGesture({ x: (a.x + b.x) / 2, y: (a.y + b.y) / 2 }),
        mode: "pinch",
        distance: Math.max(1, Math.hypot(a.x - b.x, a.y - b.y)),
      };
    }
    if (event.type === "pointerup") {
      pan.flush();
      zoom.flush();
    } else {
      pan.cancel();
      zoom.cancel();
      options.stopInertia();
    }
    releasePointer(event.pointerId);
    if (event.type === "pointerup" && previous?.mode === "pan" && pointers.size === 0) {
      options.startInertia(previous.velocity);
    }
  };

  const onTouchEnd = (event: Event) => {
    // Touch identifiers need not equal pointerIds. Only use the authoritative
    // empty touch list as a fallback when a pointer ending was lost.
    if ((event as TouchEvent).touches.length === 0 && pointers.size > 0) reset();
  };
  const onVisibilityChange = () => { if (visibilityTarget.hidden) reset(); };
  stage.addEventListener("lostpointercapture", endPointer);
  lifecycleTarget.addEventListener("pointerup", endPointer, true);
  lifecycleTarget.addEventListener("pointercancel", endPointer, true);
  lifecycleTarget.addEventListener("touchend", onTouchEnd, true);
  lifecycleTarget.addEventListener("touchcancel", onTouchEnd, true);
  lifecycleTarget.addEventListener("blur", reset);
  lifecycleTarget.addEventListener("pagehide", reset);
  visibilityTarget.addEventListener("visibilitychange", onVisibilityChange);

  return {
    pointerDown: onPointerDown,
    pointerMove: onPointerMove,
    dispose: () => {
      stage.removeEventListener("lostpointercapture", endPointer);
      lifecycleTarget.removeEventListener("pointerup", endPointer, true);
      lifecycleTarget.removeEventListener("pointercancel", endPointer, true);
      lifecycleTarget.removeEventListener("touchend", onTouchEnd, true);
      lifecycleTarget.removeEventListener("touchcancel", onTouchEnd, true);
      lifecycleTarget.removeEventListener("blur", reset);
      lifecycleTarget.removeEventListener("pagehide", reset);
      visibilityTarget.removeEventListener("visibilitychange", onVisibilityChange);
      reset();
    },
  };
}
