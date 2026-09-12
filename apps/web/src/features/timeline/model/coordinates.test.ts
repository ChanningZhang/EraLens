import { describe, expect, it } from "vitest";
import { absMonth } from "@eralens/shared";
import { projectRange } from "./coordinates";

describe("projectRange", () => {
  it("aligns both card edges to reign dates on the ruler scale", () => {
    const viewport = {
      centerAbs: absMonth(225, 1),
      pxPerMonth: 2,
      widthPx: 1200,
    };
    const startAbs = absMonth(220, 1);
    const endAbs = absMonth(226, 1);
    const range = projectRange(viewport, startAbs, endAbs);

    expect(range.left).toBe((startAbs - (viewport.centerAbs - 300)) * 2);
    expect(range.width).toBe((endAbs - startAbs + 1) * 2);
  });
});
