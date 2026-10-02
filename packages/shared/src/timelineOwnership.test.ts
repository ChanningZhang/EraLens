import { describe, expect, it } from "vitest";
import type { Reign } from "./schema";
import { activeReignsAtAbs, capitalOwnershipInterval, reignOwnershipInterval, reignOwnsAbs } from "./timelineOwnership";
import { absMonth } from "./time";
import { resolveReignVisualSpan } from "./reignBoundaries";
import { effectiveIntervalStartPoint, effectiveIntervalEndPoint, timelineInterval } from "./timelineIntervals";

function reign(id: string, startYear: number, endYear: number): Reign {
  return {
    id, dynastyId: "han", personId: id, title: id, eraNames: [],
    start: { year: startYear, month: 1 }, end: { year: endYear, month: 12 },
    startAbs: startYear * 12, endAbs: endYear * 12 + 11, precision: "year",
  };
}

describe("reign ownership interval cache", () => {
  it("keeps month-dated short successors visible after a year-dated start and month-dated end", () => {
    const makeReign = (id: string, start: Reign["start"], end: Reign["end"], precision: Reign["precision"]): Reign => ({
      ...reign(id, start.year, end.year),
      start, end, precision,
      startAbs: absMonth(start.year, start.month),
      endAbs: absMonth(end.year, end.month),
    });
    const older = makeReign("older", { year: -676, month: 1, confidence: "year" }, { year: -651, month: 8, confidence: "approximate_month" }, "year");
    const first = makeReign("first-short", { year: -651, month: 8, confidence: "approximate_month" }, { year: -651, month: 9, confidence: "approximate_month" }, "month");
    const second = makeReign("second-short", { year: -651, month: 9, confidence: "approximate_month" }, { year: -651, month: 10, confidence: "approximate_month" }, "month");
    const following = makeReign("following", { year: -650, month: 1, confidence: "year" }, { year: -637, month: 12, confidence: "year" }, "year");
    const rulers = [older, first, second, following];
    const spans = rulers.map((item) => resolveReignVisualSpan(item, rulers));

    expect(spans[0]!.endExclusive).toBe(absMonth(-651, 9));
    expect(spans[1]!.startAbs).toBe(spans[0]!.endExclusive);
    expect(spans[1]!.endExclusive - spans[1]!.startAbs).toBe(1);
    expect(spans[2]!.startAbs).toBe(spans[1]!.endExclusive);
    expect(spans[2]!.endExclusive - spans[2]!.startAbs).toBe(1);
    expect(activeReignsAtAbs(rulers, absMonth(-651, 9))).toEqual([first]);
    expect(activeReignsAtAbs(rulers, absMonth(-651, 10))).toEqual([second]);
    expect(spans[3]!.startAbs - spans[2]!.endExclusive).toBe(2);
  });

  it("uses each endpoint confidence independently of legacy record precision", () => {
    const yearToDay = timelineInterval(
      { year: -10, month: 1, confidence: "year" },
      { year: -9, month: 8, day: 17, confidence: "approximate_day" },
      "year",
    );
    expect(effectiveIntervalStartPoint(yearToDay)).toEqual({ year: -10, month: 1, day: 1 });
    expect(effectiveIntervalEndPoint(yearToDay)).toEqual({ year: -9, month: 8, day: 17 });
    const dayToMonth = timelineInterval(
      { year: -9, month: 8, day: 18, confidence: "day" },
      { year: -9, month: 9, confidence: "month" },
      "day",
    );
    expect(effectiveIntervalStartPoint(dayToMonth)).toEqual({ year: -9, month: 8, day: 18 });
    expect(effectiveIntervalEndPoint(dayToMonth)).toEqual({ year: -9, month: 9, day: 30 });
  });

  it("reuses immutable peer sets and recalculates when the peer set changes", () => {
    const older = reign("older", 1, 3);
    const later = reign("later", 3, 4);
    const alone = [later];
    const together = [older, later];
    expect(reignOwnershipInterval(later, alone)).toBe(reignOwnershipInterval(later, alone));
    expect(reignOwnershipInterval(later, together).startExclusive)
      .toBeGreaterThan(reignOwnershipInterval(later, alone).startExclusive);
  });

  it("keeps the fast active lookup equivalent at year boundaries", () => {
    const older = reign("older", 1, 3);
    const later = reign("later", 3, 4);
    const reigns = [older, later];
    for (const atAbs of [0, 12, 24, 35, 36, 47, 48, 59, 60]) {
      expect(activeReignsAtAbs(reigns, atAbs))
        .toEqual(reigns.filter((item) => reignOwnsAbs(item, reigns, atAbs)));
    }
  });

  it("recalculates capital handoffs for a changed peer set", () => {
    const older = { dynastyId: "han", modernName: "长安", role: "primary" as const,
      startAbs: 0, endAbs: 35, start: { year: 1, month: 1 }, end: { year: 3, month: 12 }, precision: "year" as const };
    const later = { dynastyId: "han", modernName: "长安", role: "primary" as const,
      startAbs: 24, endAbs: 47, start: { year: 3, month: 1 }, end: { year: 4, month: 12 }, precision: "year" as const };
    const alone = [later];
    const together = [older, later];
    expect(capitalOwnershipInterval(later, alone)).toBe(capitalOwnershipInterval(later, alone));
    expect(capitalOwnershipInterval(later, together).startExclusive)
      .toBeGreaterThan(capitalOwnershipInterval(later, alone).startExclusive);
  });
});
