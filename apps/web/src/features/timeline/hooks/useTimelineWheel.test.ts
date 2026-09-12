import { describe, expect, it } from "vitest";
import {
  isStageVerticallyScrollable,
  isZoomWheel,
  resolveWheelAction,
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
