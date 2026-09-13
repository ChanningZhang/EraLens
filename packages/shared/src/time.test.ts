import { describe, expect, it } from "vitest";
import {
  absFromPoint,
  absMonth,
  computeWindow,
  formatAbsSpanTooltip,
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

  it("formats abs span tooltip for multi-year ranges", () => {
    expect(formatAbsSpanTooltip(absMonth(-221), absMonth(-210))).toBe(
      "公元前221年 — 公元前210年 · 12年",
    );
  });

  it("formats abs span tooltip for a single year", () => {
    expect(formatAbsSpanTooltip(absMonth(200), absMonth(200))).toBe("公元200年");
  });

  it("hides month for year-precision spans stored as Jan–Dec", () => {
    expect(
      formatAbsSpanTooltip(absMonth(-356, 1), absMonth(-320, 12), "year"),
    ).toBe("公元前356年 — 公元前320年 · 37年");
  });

  it("shows months for month-precision spans", () => {
    expect(
      formatAbsSpanTooltip(absMonth(-356, 3), absMonth(-320, 12), "month"),
    ).toBe("公元前356年3月 — 公元前320年12月 · 36年10个月");
  });

  it("collapses same-calendar-year year-precision spans", () => {
    expect(formatAbsSpanTooltip(absMonth(200, 1), absMonth(200, 12), "year")).toBe(
      "公元200年",
    );
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
