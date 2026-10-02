import { expect, it, vi } from "vitest";
import { viewportStore } from "./viewportStore";

it("does not notify subscribers while a pinch continues beyond a zoom limit", () => {
  const initial = viewportStore.getSnapshot();
  const listener = vi.fn();
  const unsubscribe = viewportStore.subscribe(listener);
  try {
    viewportStore.setPxPerMonth(12);
    const max = viewportStore.getSnapshot();
    listener.mockClear();
    viewportStore.zoomBy(1.2, max.centerAbs + 10);
    viewportStore.zoomBy(1.1, max.centerAbs + 15);
    expect(viewportStore.getSnapshot()).toBe(max);
    expect(listener).not.toHaveBeenCalled();
    viewportStore.zoomBy(0.9);
    expect(viewportStore.getSnapshot().pxPerMonth).toBeCloseTo(10.8);
    expect(listener).toHaveBeenCalledTimes(1);

    viewportStore.setPxPerMonth(0.08);
    const min = viewportStore.getSnapshot();
    listener.mockClear();
    viewportStore.zoomBy(0.8);
    expect(viewportStore.getSnapshot()).toBe(min);
    expect(listener).not.toHaveBeenCalled();
  } finally {
    unsubscribe();
    viewportStore.setPxPerMonth(initial.pxPerMonth);
    viewportStore.setCenterAbs(initial.centerAbs, { clamp: false });
  }
});
