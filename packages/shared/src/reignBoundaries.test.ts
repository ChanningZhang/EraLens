import { describe, expect, it } from "vitest";
import type { Reign } from "./schema";
import { absMonth } from "./time";
import { findReignUncertaintyBoundaries } from "./reignBoundaries";
import { SYSTEM_MISSING_RULER_PERSON_ID } from "./systemReigns";

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
    dynastyId: "qi-chunqiu",
    personId: id,
    title: id,
    eraNames: [],
    start: { year: startYear, month: 1 },
    end: { year: endYear, month: 12 },
    startAbs,
    endAbs,
    precision: "year",
    ...extra,
  };
}

describe("findReignUncertaintyBoundaries", () => {
  it("does not wavy-line a灭国 blank between rulers", () => {
    const last = reign("changping", -223, -223, {
      endDateConfidence: "interpolated",
    });
    const restore = reign("yidi", -208, -205, {
      startDateConfidence: "interpolated",
    });
    expect(findReignUncertaintyBoundaries([last, restore])).toHaveLength(0);
  });

  it("skips gaps covered by a 史料缺 placeholder", () => {
    const a = reign("a", -100, -90);
    const b = reign("b", -80, -70);
    const missing = reign("missing", -89, -81, {
      personId: SYSTEM_MISSING_RULER_PERSON_ID,
    });
    const gaps = findReignUncertaintyBoundaries([a, b], [missing]);
    expect(gaps).toHaveLength(0);
  });

  it("does not wavy-line when only one side of the seam is uncertain", () => {
    const a = reign("a", -50, -40, { endDateConfidence: "interpolated" });
    const b = reign("b", -39, -30);
    expect(findReignUncertaintyBoundaries([a, b])).toHaveLength(0);
  });

  it("renders a junction when both sides of the seam are uncertain", () => {
    const a = reign("a", -50, -40, { endDateConfidence: "interpolated" });
    const b = reign("b", -39, -30, { startDateConfidence: "interpolated" });
    const gaps = findReignUncertaintyBoundaries([a, b]);
    expect(gaps).toHaveLength(1);
    expect(gaps[0]?.kind).toBe("junction");
  });

  it("renders junctions between every pair of contiguous interpolated rulers", () => {
    const a = reign("a", -80, -70, {
      startDateConfidence: "interpolated",
      endDateConfidence: "interpolated",
    });
    const b = reign("b", -69, -60, {
      startDateConfidence: "interpolated",
      endDateConfidence: "interpolated",
    });
    const c = reign("c", -59, -50, {
      startDateConfidence: "interpolated",
      endDateConfidence: "interpolated",
    });
    const boundaries = findReignUncertaintyBoundaries([a, b, c]);
    expect(boundaries).toHaveLength(2);
    expect(boundaries.every((b) => b.kind === "junction")).toBe(true);
  });

  it("ignores sub-year holes without confidence metadata", () => {
    const a = reign("a", -20, -10);
    const b = reign("b", -9, -1);
    expect(findReignUncertaintyBoundaries([a, b])).toHaveLength(0);
  });
});
