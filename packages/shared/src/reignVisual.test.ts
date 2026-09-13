import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import type { Reign } from "./schema";
import {
  formatReignSpanTooltip,
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
