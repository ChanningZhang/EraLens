import { describe, expect, it } from "vitest";
import { absMonth } from "@eralens/shared";
import {
  absFromStageX,
  centerGuideX,
  laneLabelAnchorAbs,
  projectAbs,
  projectRange,
} from "./coordinates";

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

  it("starts the time axis after the dynasty-name rail", () => {
    const viewport = {
      centerAbs: absMonth(225, 1),
      pxPerMonth: 2,
      widthPx: 1200,
      gutterPx: 100,
    };
    const contentWidth = 1100;
    const halfMonths = contentWidth / viewport.pxPerMonth / 2;

    expect(projectAbs(viewport, viewport.centerAbs)).toBe(100 + halfMonths * 2);
    expect(absFromStageX(viewport, 100)).toBe(viewport.centerAbs - halfMonths);
  });

  it("places the center guide at the temporal midpoint of the lane axis", () => {
    const viewport = {
      centerAbs: absMonth(225, 1),
      pxPerMonth: 2,
      widthPx: 1200,
      gutterPx: 100,
    };
    const contentWidth = 1100;

    expect(centerGuideX(viewport)).toBe(100 + contentWidth / 2);
    expect(laneLabelAnchorAbs(viewport)).toBe(viewport.centerAbs);
  });
});
