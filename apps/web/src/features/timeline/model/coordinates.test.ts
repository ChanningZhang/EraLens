import { describe, expect, it } from "vitest";
import { absMonth } from "@eralens/shared";
import {
  absFromStageX,
  centerGuideX,
  laneLabelAnchorAbs,
  projectAbs,
  projectClippedRange,
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

  it("keeps the center guide fixed on screen while panning", () => {
    const viewport = {
      centerAbs: absMonth(225, 1),
      pxPerMonth: 1.5,
      widthPx: 1200,
      gutterPx: 100,
    };
    const expected = 100 + 1100 / 2;

    for (let offset = 0; offset < 1; offset += 0.07) {
      expect(centerGuideX({ ...viewport, centerAbs: viewport.centerAbs + offset })).toBe(
        expected,
      );
    }
  });
});

describe("projectClippedRange", () => {
  it("does not pull the left edge to the gutter when the span starts later", () => {
    const viewport = {
      centerAbs: absMonth(500, 1),
      pxPerMonth: 1,
      widthPx: 2400,
      gutterPx: 100,
    };
    const range = projectClippedRange(
      viewport,
      absMonth(420, 1),
      absMonth(589, 12),
    );

    expect(range).not.toBeNull();
    expect(range!.left).toBeGreaterThan(100);
    expect(range!.left).toBe(projectRange(viewport, absMonth(420, 1), absMonth(589, 12)).left);
  });

  it("clips to the rail gutter instead of stretching left", () => {
    const viewport = {
      centerAbs: absMonth(500, 1),
      pxPerMonth: 2,
      widthPx: 800,
      gutterPx: 100,
    };
    const range = projectClippedRange(
      viewport,
      absMonth(100, 1),
      absMonth(589, 12),
    );

    expect(range).not.toBeNull();
    expect(range!.left).toBe(100);
    expect(range!.left + range!.width).toBeLessThanOrEqual(800);
  });

  it("returns null when the span is completely off-screen", () => {
    const viewport = {
      centerAbs: absMonth(100, 1),
      pxPerMonth: 2,
      widthPx: 400,
      gutterPx: 100,
    };
    expect(
      projectClippedRange(viewport, absMonth(800, 1), absMonth(900, 1)),
    ).toBeNull();
  });
});
