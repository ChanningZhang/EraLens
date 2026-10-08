import { describe, expect, it } from "vitest";
import { absMonth } from "@eralens/shared";
import {
  clampCursorGuideLabelX,
  cursorGuideStageX,
  formatCursorGuideLabel,
} from "./cursorGuide";

describe("cursorGuideStageX", () => {
  it("returns x relative to the stage", () => {
    expect(cursorGuideStageX(140, 40, 800)).toBe(100);
  });

  it("hides when the pointer is outside the stage width", () => {
    expect(cursorGuideStageX(20, 40, 800)).toBeNull();
    expect(cursorGuideStageX(900, 40, 800)).toBeNull();
  });

  it("hides when the pointer is over the dynasty-name rail", () => {
    expect(cursorGuideStageX(80, 40, 800, 100)).toBeNull();
    expect(cursorGuideStageX(150, 40, 800, 100)).toBe(110);
  });
});

describe("formatCursorGuideLabel", () => {
  it("always shows the month at every zoom level", () => {
    expect(formatCursorGuideLabel(absMonth(200, 6))).toBe("200年6月");
    expect(formatCursorGuideLabel(absMonth(-221, 10))).toBe("-221年10月");
  });
});

describe("clampCursorGuideLabelX", () => {
  it("keeps the label inside the overlay", () => {
    expect(clampCursorGuideLabelX(10, 400, 80)).toBe(44);
    expect(clampCursorGuideLabelX(390, 400, 80)).toBe(356);
    expect(clampCursorGuideLabelX(200, 400, 80)).toBe(200);
  });

  it("does not place the label over the dynasty-name rail", () => {
    expect(clampCursorGuideLabelX(10, 400, 80, 4, 100)).toBe(144);
  });
});
