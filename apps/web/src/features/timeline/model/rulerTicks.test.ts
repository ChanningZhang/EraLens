import { describe, expect, it } from "vitest";
import { buildRulerTicks, getRulerTickSteps } from "./rulerTicks";

describe("rulerTicks", () => {
  it("uses 10-year labels at default zoom", () => {
    expect(getRulerTickSteps(1.5)).toEqual({ labelYears: 10, minorYears: 1 });
  });

  it("uses 5-year labels when zoomed in", () => {
    expect(getRulerTickSteps(3)).toEqual({ labelYears: 5, minorYears: 1 });
  });

  it("uses 1-year labels when zoomed further", () => {
    expect(getRulerTickSteps(8)).toEqual({ labelYears: 1, minorYears: 0 });
    const ticks = buildRulerTicks(2388, 2424, 8);
    expect(ticks.length).toBeGreaterThan(0);
    expect(ticks.every((tick) => tick.kind === "label")).toBe(true);
  });

  it("builds decade labels with yearly minors", () => {
    const ticks = buildRulerTicks(2280, 2532, 1.5);
    const labels = ticks.filter((t) => t.kind === "label").map((t) => t.text);
    expect(labels).toContain("190");
    expect(labels).toContain("200");
    expect(labels).toContain("210");
    expect(ticks.some((t) => t.kind === "minor")).toBe(true);
  });
});
