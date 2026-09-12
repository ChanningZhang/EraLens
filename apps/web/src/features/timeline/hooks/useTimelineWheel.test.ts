import { describe, expect, it } from "vitest";
import { resolveWheelAction } from "./useTimelineWheel";

describe("resolveWheelAction", () => {
  it("zooms when pinching on the timeline", () => {
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
    expect(resolveWheelAction(0, 40, true, false)).toBe("ignore");
  });
});
