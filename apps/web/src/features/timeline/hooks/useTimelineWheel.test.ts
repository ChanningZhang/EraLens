import { describe, expect, it } from "vitest";
import {
  applyStageVerticalScroll,
  createFramePanAccumulator,
  createFrameZoomAccumulator,
  isStageVerticallyScrollable,
  isZoomWheel,
  resolveWheelAction,
  shouldDeferToStageVerticalScroll,
  wheelDeltaPx,
  wheelZoomFactor,
} from "./useTimelineWheel";

describe("resolveWheelAction", () => {
  it("zooms when pinching anywhere on the page", () => {
    expect(resolveWheelAction(0, 40, true, false)).toBe("zoom");
    expect(resolveWheelAction(0, 40, true, true)).toBe("zoom");
  });

  it("pans for any wheel on the timeline", () => {
    expect(resolveWheelAction(0, 40, false, true)).toBe("pan");
    expect(resolveWheelAction(-80, 0, false, true)).toBe("pan");
  });

  it("pans horizontal trackpad swipes anywhere so Chrome cannot steal back/forward", () => {
    expect(resolveWheelAction(80, 10, false, false)).toBe("pan");
    expect(resolveWheelAction(-80, 10, false, false)).toBe("pan");
  });

  it("leaves vertical scrolling to nested panels", () => {
    expect(resolveWheelAction(4, 40, false, false)).toBe("ignore");
  });
});

describe("createFramePanAccumulator", () => {
  it("applies one cumulative pan per frame and flushes before a zoom", () => {
    const applied: number[] = [];
    const callbacks = new Map<number, FrameRequestCallback>();
    let nextId = 1;
    const pan = createFramePanAccumulator(
      (delta) => applied.push(delta),
      (callback) => { const id = nextId++; callbacks.set(id, callback); return id; },
      (id) => { callbacks.delete(id); },
    );
    pan.queue(-12);
    pan.queue(-8);
    expect(callbacks.size).toBe(1);
    callbacks.get(1)?.(0);
    expect(applied).toEqual([-20]);
    pan.queue(9);
    pan.flush();
    expect(applied).toEqual([-20, 9]);
    expect(callbacks.size).toBe(0);
  });

  it("cancels a queued pan without applying it", () => {
    const applied: number[] = [];
    const callbacks = new Map<number, FrameRequestCallback>();
    const pan = createFramePanAccumulator(
      (delta) => applied.push(delta),
      (callback) => { callbacks.set(1, callback); return 1; },
      (id) => { callbacks.delete(id); },
    );

    pan.queue(18);
    pan.cancel();

    expect(callbacks.size).toBe(0);
    expect(applied).toEqual([]);
  });
});

describe("createFrameZoomAccumulator", () => {
  function harness() {
    const applied: Array<{ factor: number; clientX: number }> = [];
    const callbacks = new Map<number, FrameRequestCallback>();
    let nextId = 1;
    const zoom = createFrameZoomAccumulator(
      (factor, clientX) => applied.push({ factor, clientX }),
      (callback) => { const id = nextId++; callbacks.set(id, callback); return id; },
      (id) => { callbacks.delete(id); },
    );
    return { zoom, applied, callbacks };
  }

  it("combines both fingers' moves into one zoom per frame using the latest midpoint", () => {
    const { zoom, applied, callbacks } = harness();
    zoom.queue(110 / 100, 180);
    zoom.queue(120 / 110, 185);
    zoom.queue(130 / 120, 190);
    expect(callbacks.size).toBe(1);
    expect(applied).toEqual([]);
    callbacks.get(1)?.(0);
    expect(applied).toHaveLength(1);
    expect(applied[0]!.factor).toBeCloseTo(130 / 100);
    expect(applied[0]!.clientX).toBe(190);
    expect(callbacks.size).toBe(0);
    zoom.queue(0.9, 200);
    zoom.flush();
    expect(applied[1]).toEqual({ factor: 0.9, clientX: 200 });
    expect(callbacks.size).toBe(0);
  });

  it("flushes the last movement at gesture end and discards canceled frames", () => {
    const { zoom, applied, callbacks } = harness();
    zoom.queue(1.2, 150);
    zoom.flush();
    zoom.flush();
    expect(applied).toEqual([{ factor: 1.2, clientX: 150 }]);
    zoom.queue(0.8, 200);
    zoom.cancel();
    expect(callbacks.size).toBe(0);
    expect(applied).toHaveLength(1);
    zoom.queue(1.1, 210);
    zoom.flush();
    expect(applied[1]).toEqual({ factor: 1.1, clientX: 210 });
  });

  it("skips unchanged and invalid scales and folds opposing movement", () => {
    const { zoom, applied, callbacks } = harness();
    for (const factor of [1, 0, -1, NaN, Infinity]) zoom.queue(factor, 100);
    expect(callbacks.size).toBe(0);
    zoom.queue(2, 100);
    zoom.queue(0.5, 100);
    zoom.flush();
    expect(applied).toEqual([]);
  });
});

describe("shouldDeferToStageVerticalScroll", () => {
  it("allows vertical-dominant scroll when the stage overflows", () => {
    expect(shouldDeferToStageVerticalScroll(0, 40, false, true)).toBe(true);
    expect(shouldDeferToStageVerticalScroll(4, 40, false, true)).toBe(true);
    expect(shouldDeferToStageVerticalScroll(-3, 40, false, true)).toBe(true);
  });

  it("keeps horizontal-dominant trackpad swipes on panning even when the stage overflows", () => {
    expect(shouldDeferToStageVerticalScroll(-80, 10, false, true)).toBe(false);
    expect(shouldDeferToStageVerticalScroll(40, 40, false, true)).toBe(false);
  });
});

describe("applyStageVerticalScroll", () => {
  it("moves scrollTop by pixel deltas so the gesture can be preventDefaulted", () => {
    const stage = { scrollTop: 20 };
    applyStageVerticalScroll(stage, 40, 0);
    expect(stage.scrollTop).toBe(60);
  });
});

describe("wheelDeltaPx", () => {
  it("keeps pixel deltas and converts line/page modes", () => {
    expect(wheelDeltaPx(40, 0)).toBe(40);
    expect(wheelDeltaPx(2, 1)).toBe(32);
    expect(wheelDeltaPx(1, 2)).toBe(800);
  });
});

describe("isStageVerticallyScrollable", () => {
  it("is true when content is taller than the viewport", () => {
    expect(isStageVerticallyScrollable({ scrollHeight: 800, clientHeight: 400 })).toBe(true);
  });

  it("is false when content fits the viewport", () => {
    expect(isStageVerticallyScrollable({ scrollHeight: 400, clientHeight: 400 })).toBe(false);
  });
});

describe("isZoomWheel", () => {
  it("detects mac trackpad pinch and cmd+scroll", () => {
    expect(isZoomWheel({ ctrlKey: true, metaKey: false })).toBe(true);
    expect(isZoomWheel({ ctrlKey: false, metaKey: true })).toBe(true);
    expect(isZoomWheel({ ctrlKey: false, metaKey: false })).toBe(false);
  });
});

describe("wheelZoomFactor", () => {
  it("zooms in for negative deltaY and out for positive deltaY", () => {
    expect(wheelZoomFactor(-40)).toBeGreaterThan(1);
    expect(wheelZoomFactor(40)).toBeLessThan(1);
  });
});
