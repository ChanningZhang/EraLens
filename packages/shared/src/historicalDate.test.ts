import { describe, expect, it } from "vitest";
import { formatHistoricalDate, isInterpolatedConfidence } from "./historicalDate";

describe("historical date confidence", () => {
  it.each([
    ["day", "685年9月27日"],
    ["month", "685年9月"],
    ["year", "685年"],
    ["approximate_day", "约685年9月27日"],
    ["approximate_month", "约685年9月"],
    ["approximate_year", "约685年"],
    ["interpolated_by_other", "?"],
    ["interpolated_by_generation", "?"],
  ] as const)("formats %s", (confidence, expected) => {
    expect(formatHistoricalDate({ year: 685, month: 9, day: 27, confidence })).toBe(expected);
    expect(isInterpolatedConfidence(confidence)).toBe(expected === "?");
  });
});
