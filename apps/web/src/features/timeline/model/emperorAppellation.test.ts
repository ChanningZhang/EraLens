import { describe, expect, it } from "vitest";
import type { Reign } from "@eralens/shared";
import { resolveEmperorAppellation } from "./emperorAppellation";

function source(overrides: Partial<Reign>) {
  return {
    start: { year: 1, month: 1 },
    title: "皇帝",
    posthumousName: undefined,
    templeName: undefined,
    eraNames: [],
    preferredAppellation: undefined,
    ...overrides,
  };
}

describe("resolveEmperorAppellation", () => {
  it("uses a posthumous name before Tang", () => {
    expect(
      resolveEmperorAppellation(
        source({ start: { year: 141, month: 1 }, posthumousName: "孝景皇帝" }),
      ),
    ).toEqual({ kind: "posthumous", name: "孝景皇帝" });
  });

  it("uses a temple name from Tang through Yuan", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 626, month: 1 },
          posthumousName: "文皇帝",
          templeName: "太宗",
        }),
      ),
    ).toEqual({ kind: "temple", name: "太宗" });
  });

  it("uses an era name for Ming and Qing", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1661, month: 1 },
          templeName: "圣祖",
          eraNames: [{ name: "康熙" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "era", name: "康熙" });
  });

  it("falls back to a regnal title when Qin-style names do not exist", () => {
    expect(
      resolveEmperorAppellation(
        source({ start: { year: -221, month: 1 }, title: "始皇帝" }),
      ),
    ).toEqual({ kind: "regnal", name: "始皇帝" });
  });

  it("lets explicit historical exceptions override the era default", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1435, month: 1 },
          eraNames: [{ name: "正统" }] as Reign["eraNames"],
          preferredAppellation: { kind: "temple", name: "英宗" },
        }),
      ),
    ).toEqual({ kind: "temple", name: "英宗" });
  });
});
