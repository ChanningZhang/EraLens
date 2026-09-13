import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import type { Reign } from "./schema";
import {
  formatReignSpanTooltip,
  isSubMonthReign,
  reignDurationDays,
  reignVisualBounds,
} from "./reignVisual";

function reign(partial: Partial<Reign> & Pick<Reign, "startAbs" | "endAbs">): Reign {
  return {
    id: "test",
    dynastyId: "jin",
    personId: "test",
    title: "test",
    eraNames: [],
    start: { year: 1234, month: 2, day: 9 },
    end: { year: 1234, month: 2, day: 9 },
    precision: "day",
    ...partial,
  };
}

describe("reignVisualBounds", () => {
  it("uses sub-month width for day-precision same-day reigns", () => {
    const bounds = reignVisualBounds(
      reign({
        start: { year: 1234, month: 2, day: 9 },
        end: { year: 1234, month: 2, day: 9 },
        startAbs: absMonth(1234, 2),
        endAbs: absMonth(1234, 2),
      }),
    );
    expect(bounds.endExclusive - bounds.start).toBeCloseTo(1 / 28, 5);
  });

  it("keeps full calendar months for year precision", () => {
    const bounds = reignVisualBounds(
      reign({
        precision: "year",
        start: { year: 1234, month: 1 },
        end: { year: 1234, month: 12 },
        startAbs: absMonth(1234, 1),
        endAbs: absMonth(1234, 12),
      }),
    );
    expect(bounds.start).toBe(absMonth(1234, 1));
    expect(bounds.endExclusive).toBe(absMonth(1234, 12) + 1);
  });

  it("defaults missing end day to start day, not the full month", () => {
    const bounds = reignVisualBounds(
      reign({
        start: { year: 1234, month: 2, day: 9 },
        end: { year: 1234, month: 2 },
        startAbs: absMonth(1234, 2),
        endAbs: absMonth(1234, 2),
      }),
    );
    expect(bounds.endExclusive - bounds.start).toBeCloseTo(1 / 28, 5);
  });

  it("clips visual bounds to the resolved lane span", () => {
    const bounds = reignVisualBounds(
      reign({
        start: { year: 1234, month: 2, day: 9 },
        end: { year: 1234, month: 2, day: 9 },
        startAbs: absMonth(1234, 2),
        endAbs: absMonth(1234, 2),
      }),
      absMonth(1234, 2),
      absMonth(1234, 2) + 1,
    );
    expect(bounds.start).toBeGreaterThanOrEqual(absMonth(1234, 2));
    expect(bounds.endExclusive).toBeLessThanOrEqual(absMonth(1234, 2) + 1);
  });
});

describe("formatReignSpanTooltip", () => {
  it("formats a one-day reign", () => {
    expect(
      formatReignSpanTooltip(
        reign({
          start: { year: 1234, month: 2, day: 9 },
          end: { year: 1234, month: 2, day: 9 },
          startAbs: absMonth(1234, 2),
          endAbs: absMonth(1234, 2),
        }),
      ),
    ).toBe("公元1234年2月9日 · 1天");
  });

  it("formats multi-year day-precision reigns as years and months", () => {
    expect(
      formatReignSpanTooltip(
        reign({
          start: { year: 712, month: 9, day: 8 },
          end: { year: 756, month: 8, day: 12 },
          startAbs: absMonth(712, 9),
          endAbs: absMonth(756, 8),
        }),
      ),
    ).toBe("公元712年9月8日 — 公元756年8月12日 · 43年11个月");
  });

  it("formats sub-year spans in months", () => {
    expect(
      formatReignSpanTooltip(
        reign({
          start: { year: 1234, month: 2, day: 9 },
          end: { year: 1234, month: 8, day: 15 },
          startAbs: absMonth(1234, 2),
          endAbs: absMonth(1234, 8),
        }),
      ),
    ).toBe("公元1234年2月9日 — 公元1234年8月15日 · 6个月");
  });

  it("formats sub-month spans in days", () => {
    expect(
      formatReignSpanTooltip(
        reign({
          start: { year: 1234, month: 2, day: 9 },
          end: { year: 1234, month: 2, day: 20 },
          startAbs: absMonth(1234, 2),
          endAbs: absMonth(1234, 2),
        }),
      ),
    ).toBe("公元1234年2月9日 — 公元1234年2月20日 · 12天");
  });
});

describe("isSubMonthReign", () => {
  it("returns false for multi-year day-precision reigns", () => {
    expect(
      isSubMonthReign(
        reign({
          start: { year: 1127, month: 6, day: 12 },
          end: { year: 1162, month: 7, day: 24 },
          startAbs: absMonth(1127, 6),
          endAbs: absMonth(1162, 7),
        }),
      ),
    ).toBe(false);
  });

  it("returns true for same-day day-precision reigns", () => {
    expect(
      isSubMonthReign(
        reign({
          start: { year: 1234, month: 2, day: 9 },
          end: { year: 1234, month: 2, day: 9 },
          startAbs: absMonth(1234, 2),
          endAbs: absMonth(1234, 2),
        }),
      ),
    ).toBe(true);
  });
});

describe("reignDurationDays", () => {
  it("counts inclusive days within one month", () => {
    expect(
      reignDurationDays(
        reign({
          start: { year: 1234, month: 2, day: 9 },
          end: { year: 1234, month: 2, day: 9 },
          startAbs: absMonth(1234, 2),
          endAbs: absMonth(1234, 2),
        }),
      ),
    ).toBe(1);
  });
});
