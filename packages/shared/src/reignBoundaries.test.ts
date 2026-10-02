import { describe, expect, it } from "vitest";
import type { Reign } from "./schema";
import { absMonth } from "./time";
import { isUncertainDateConfidence, validateReignDateConfidenceSeams } from "./reignBoundaries";

function reign(
  id: string,
  startYear: number,
  endYear: number,
  extra: Partial<Reign> = {},
): Reign {
  const startAbs = absMonth(startYear, 1);
  const endAbs = absMonth(endYear, 12);
  return {
    id,
    dynastyId: extra.dynastyId ?? "qi-chunqiu",
    personId: id,
    title: id,
    eraNames: [],
    start: { year: startYear, month: 1, confidence: extra.start?.confidence ?? "year" },
    end: { year: endYear, month: 12, confidence: extra.end?.confidence ?? "year" },
    startAbs,
    endAbs,
    precision: "year",
    ...extra,
  };
}

describe("isUncertainDateConfidence", () => {
  it("treats interpolated and approximate as uncertain", () => {
    expect(isUncertainDateConfidence("interpolated_by_generation")).toBe(true);
    expect(isUncertainDateConfidence("approximate_year")).toBe(true);
    expect(isUncertainDateConfidence(undefined)).toBe(false);
    expect(isUncertainDateConfidence(null)).toBe(false);
  });
});

describe("validateReignDateConfidenceSeams", () => {
  it("allows matching uncertain seams within a dynasty", () => {
    const a = reign("a", -50, -40, { end: { year: -40, month: 12, confidence: "interpolated_by_generation" } });
    const b = reign("b", -39, -30, { start: { year: -39, month: 1, confidence: "interpolated_by_generation" } });
    expect(validateReignDateConfidenceSeams([a, b])).toEqual([]);
  });

  it("rejects one-sided uncertain seams", () => {
    const a = reign("a", -50, -40, { end: { year: -40, month: 12, confidence: "interpolated_by_generation" } });
    const b = reign("b", -39, -30);
    expect(validateReignDateConfidenceSeams([a, b]).length).toBeGreaterThan(0);
  });

  it("validates cross-dynasty calendar seams", () => {
    const left = reign("shennong", -2584, -2465, {
      dynastyId: "san-huang",
      end: { year: -2465, month: 12, confidence: "interpolated_by_generation" },
    });
    const right = reign("huangdi", -2464, -2365, {
      dynastyId: "wu-di",
      start: { year: -2464, month: 1, confidence: "interpolated_by_generation" },
    });
    expect(validateReignDateConfidenceSeams([left, right])).toEqual([]);
  });

  it("ignores灭国 blanks between rulers", () => {
    const last = reign("changping", -223, -223, {
      end: { year: -223, month: 12, confidence: "interpolated_by_generation" },
    });
    const restore = reign("yidi", -208, -205, {
      start: { year: -208, month: 1, confidence: "interpolated_by_generation" },
    });
    expect(validateReignDateConfidenceSeams([last, restore])).toEqual([]);
  });

  it("allows certain seams at dynasty anchors", () => {
    const jie = reign("jie", -1629, -1600, {
      dynastyId: "xia",
      endDateConfidence: undefined,
    });
    const tang = reign("tang", -1600, -1549, {
      dynastyId: "shang",
      startDateConfidence: undefined,
    });
    expect(validateReignDateConfidenceSeams([jie, tang])).toEqual([]);
  });
});
