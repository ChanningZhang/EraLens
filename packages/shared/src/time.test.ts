import { describe, expect, it } from "vitest";
import {
  absFromPoint,
  absMonth,
  computeWindow,
  formatYear,
  fromAbsMonth,
  parseYearMonthParam,
  rangeIntersectsWindow,
  rangesIntersect,
  toAstroYear,
} from "./time";

describe("time utilities", () => {
  it("handles BCE astronomical year conversion", () => {
    expect(toAstroYear(1)).toBe(1);
    expect(toAstroYear(-1)).toBe(0);
    expect(toAstroYear(-221)).toBe(-220);
  });

  it("converts absMonth around BCE/CE boundary", () => {
    expect(absMonth(-1, 12)).toBe(11);
    expect(absMonth(1, 1)).toBe(12);
    expect(fromAbsMonth(12)).toEqual({ year: 1, month: 1 });
    expect(fromAbsMonth(-1)).toEqual({ year: -2, month: 12 });
    expect(fromAbsMonth(12.49)).toEqual({ year: 1, month: 1 });
  });

  it("formats BCE years", () => {
    expect(formatYear(-221)).toBe("公元前221年");
    expect(formatYear(200)).toBe("公元200年");
  });

  it("detects range intersection", () => {
    expect(rangesIntersect(0, 100, 50, 150)).toBe(true);
    expect(rangesIntersect(0, 100, 101, 200)).toBe(false);
    expect(rangeIntersectsWindow(1800, 1900, 1850, 1950)).toBe(true);
  });

  it("computes viewport window from center", () => {
    const { startAbs, endAbs } = computeWindow(absMonth(200, 1), 1200, 2);
    expect(endAbs - startAbs).toBeGreaterThan(500);
  });

  it("round-trips year-month URL param", () => {
    const abs = absFromPoint({ year: 200, month: 3 });
    expect(parseYearMonthParam("200-03")).toBe(abs);
  });
});
