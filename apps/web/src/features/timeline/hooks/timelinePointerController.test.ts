import { afterEach, describe, expect, it, vi } from "vitest";
import { createTimelinePointerController } from "./timelinePointerController";

class Stage extends EventTarget {
  scrollTop = 100;
  captures = new Set<number>();
  setPointerCapture(id: number) { this.captures.add(id); }
  hasPointerCapture(id: number) { return this.captures.has(id); }
  releasePointerCapture(id: number) {
    this.captures.delete(id);
    this.dispatchEvent(pointer("lostpointercapture", id));
  }
}

function pointer(type: string, id: number, x = 100, y = 100, isPrimary = true) {
  return Object.assign(new Event(type, { cancelable: true }), {
    pointerId: id, pointerType: "touch", button: 0, clientX: x, clientY: y, isPrimary,
  });
}

function harness(map = false) {
  const stage = new Stage();
  const lifecycle = new EventTarget();
  const visibility = Object.assign(new EventTarget(), { hidden: false });
  const pan = { queue: vi.fn(), flush: vi.fn(), cancel: vi.fn() };
  const zoom = { queue: vi.fn(), flush: vi.fn(), cancel: vi.fn() };
  const moveMap = vi.fn();
  const startInertia = vi.fn();
  const controller = createTimelinePointerController({
    stage: stage as unknown as HTMLElement,
    lifecycleTarget: lifecycle,
    visibilityTarget: visibility,
    pan, zoom, moveMap, startInertia,
    stopInertia: vi.fn(),
    isMapPanTarget: () => map,
  });
  stage.addEventListener("pointerdown", controller.pointerDown);
  stage.addEventListener("pointermove", controller.pointerMove);
  const cleanup = () => {
    stage.removeEventListener("pointerdown", controller.pointerDown);
    stage.removeEventListener("pointermove", controller.pointerMove);
    controller.dispose();
  };
  const down = (id: number, x = 100, y = 100, primary = true) => stage.dispatchEvent(pointer("pointerdown", id, x, y, primary));
  const move = (id: number, x: number, y = 100) => stage.dispatchEvent(pointer("pointermove", id, x, y));
  const swipe = (id: number, primary = true) => { down(id, 100, 100, primary); move(id, 112); move(id, 140); };
  return { stage, lifecycle, visibility, pan, zoom, moveMap, startInertia, cleanup, down, move, swipe };
}

afterEach(() => vi.useRealTimers());

describe("timeline pointer lifecycle", () => {
  it("recovers from a missing end event when a fresh single finger arrives", () => {
    const h = harness();
    h.down(1); // Earlier tap on a card; WebKit did not deliver the ending.
    h.swipe(2);
    expect(h.zoom.queue).not.toHaveBeenCalled();
    expect(h.pan.queue).toHaveBeenCalledWith(28);
    expect(h.stage.captures).toEqual(new Set([2]));
    h.cleanup();
  });

  it("cleans a card tap ending outside the stage before another finger arrives", () => {
    const h = harness();
    h.down(1);
    h.lifecycle.dispatchEvent(pointer("pointerup", 1)); // e.g. overlay/other target
    h.swipe(2, false);
    expect(h.pan.queue).toHaveBeenCalledWith(28);
    expect(h.zoom.queue).not.toHaveBeenCalled();
    h.cleanup();
  });

  it("cleans lost capture after dragging the map", () => {
    vi.useFakeTimers();
    const h = harness(true);
    h.down(1);
    vi.advanceTimersByTime(450);
    h.move(1, 130, 120);
    expect(h.moveMap).toHaveBeenCalledWith(30, 20);
    h.stage.releasePointerCapture(1);
    h.swipe(2, false);
    expect(h.pan.queue).toHaveBeenCalledWith(28);
    expect(h.zoom.queue).not.toHaveBeenCalled();
    h.cleanup();
  });

  it("zooms with two actual fingers and resumes panning with the remaining finger", () => {
    const h = harness();
    h.down(1, 100);
    h.down(2, 200, 100, false);
    h.move(2, 240);
    expect(h.zoom.queue).toHaveBeenCalledWith(1.4, 170);
    h.lifecycle.dispatchEvent(pointer("pointerup", 2, 240, 100, false));
    h.zoom.queue.mockClear();
    h.move(1, 112);
    h.move(1, 140);
    expect(h.pan.queue).toHaveBeenCalledWith(28);
    expect(h.zoom.queue).not.toHaveBeenCalled();
    h.cleanup();
  });

  it("discards canceled movement without starting inertia", () => {
    const h = harness();
    h.swipe(1);
    h.lifecycle.dispatchEvent(pointer("pointercancel", 1));
    expect(h.pan.cancel).toHaveBeenCalled();
    expect(h.pan.flush).not.toHaveBeenCalled();
    expect(h.startInertia).not.toHaveBeenCalled();
    h.swipe(2, false);
    expect(h.zoom.queue).not.toHaveBeenCalled();
    h.cleanup();
  });

  it.each(["touchend", "touchcancel"])("uses an empty %s list to recover from missing pointer events", (type) => {
    const h = harness();
    h.down(1);
    h.lifecycle.dispatchEvent(Object.assign(new Event(type), { touches: [] }));
    h.swipe(2, false);
    expect(h.pan.queue).toHaveBeenCalledWith(28);
    expect(h.zoom.queue).not.toHaveBeenCalled();
    h.cleanup();
  });

  it.each(["blur", "pagehide", "visibilitychange"])("clears pending map gestures on %s", (type) => {
    vi.useFakeTimers();
    const h = harness(true);
    h.down(1);
    if (type === "visibilitychange") {
      h.visibility.hidden = true;
      h.visibility.dispatchEvent(new Event(type));
    } else h.lifecycle.dispatchEvent(new Event(type));
    vi.advanceTimersByTime(500);
    h.swipe(2, false);
    expect(h.moveMap).not.toHaveBeenCalled();
    expect(h.pan.queue).toHaveBeenCalledWith(28);
    expect(h.zoom.queue).not.toHaveBeenCalled();
    h.cleanup();
  });

  it("keeps vertical swipes scrolling the stage", () => {
    const h = harness();
    h.down(1);
    h.move(1, 102, 120);
    h.move(1, 103, 150);
    expect(h.stage.scrollTop).toBe(50);
    expect(h.pan.queue).not.toHaveBeenCalled();
    expect(h.zoom.queue).not.toHaveBeenCalled();
    h.cleanup();
  });

  it("keeps mouse map dragging separate from timeline zoom and pan", () => {
    const h = harness(true);
    h.stage.dispatchEvent(Object.assign(pointer("pointerdown", 1), { pointerType: "mouse" }));
    h.stage.dispatchEvent(Object.assign(pointer("pointermove", 1, 130, 120), { pointerType: "mouse" }));
    expect(h.moveMap).toHaveBeenCalledWith(30, 20);
    expect(h.pan.queue).not.toHaveBeenCalled();
    expect(h.zoom.queue).not.toHaveBeenCalled();
    h.cleanup();
  });

  it("removes listeners and cancels the long press on unmount", () => {
    vi.useFakeTimers();
    const h = harness(true);
    h.down(1);
    h.cleanup();
    vi.advanceTimersByTime(500);
    h.swipe(2);
    expect(h.moveMap).not.toHaveBeenCalled();
    expect(h.pan.queue).not.toHaveBeenCalled();
    expect(h.zoom.queue).not.toHaveBeenCalled();
    expect(h.stage.captures.size).toBe(0);
  });
});
