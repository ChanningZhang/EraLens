import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import {
  isOrthodoxAt,
  overlapsOrthodoxSpan,
  ORTHODOX_FROM_ABS,
  resolveOrthodoxFromAbs,
  resolveOrthodoxSpan,
} from "./orthodoxDynasties";
import {
  ORTHODOX_COLOR_TOKEN,
  resolveDynastyColorToken,
} from "./dynastyColors";

describe("orthodoxDynasties", () => {
  it("marks qin as orthodox only after unification", () => {
    const qin = { id: "qin", startAbs: absMonth(-770) };
    expect(resolveOrthodoxFromAbs(qin)).toBe(ORTHODOX_FROM_ABS.qin);
    expect(isOrthodoxAt(qin, absMonth(-770))).toBe(false);
    expect(isOrthodoxAt(qin, absMonth(-221))).toBe(true);
  });

  it("marks xia as orthodox from dynasty start", () => {
    const xia = { id: "xia", startAbs: absMonth(-2070) };
    expect(resolveOrthodoxFromAbs(xia)).toBe(xia.startAbs);
    expect(isOrthodoxAt(xia, xia.startAbs)).toBe(true);
  });

  it("prefers persisted orthodoxFromAbs override", () => {
    const dynasty = { id: "qin", startAbs: absMonth(-770), orthodoxFromAbs: absMonth(-220) };
    expect(resolveOrthodoxFromAbs(dynasty)).toBe(absMonth(-220));
  });

  it("builds orthodox span from orthodox start through dynasty end", () => {
    const qin = {
      id: "qin",
      startAbs: absMonth(-770),
      endAbs: absMonth(-206),
    };
    expect(resolveOrthodoxSpan(qin)).toEqual({
      startAbs: ORTHODOX_FROM_ABS.qin,
      endAbs: absMonth(-206),
    });
  });

  it("marks reigns that overlap orthodox span even when startAbs is earlier", () => {
    const jinWest = {
      id: "jin-west",
      startAbs: absMonth(266, 2),
      endAbs: absMonth(316, 4),
    };
    expect(isOrthodoxAt(jinWest, absMonth(266, 1))).toBe(false);
    expect(
      overlapsOrthodoxSpan(jinWest, absMonth(266, 1), absMonth(290, 12)),
    ).toBe(true);
    expect(
      overlapsOrthodoxSpan(jinWest, absMonth(266, 2), absMonth(290, 12)),
    ).toBe(true);
  });
});

describe("resolveDynastyColorToken orthodox display", () => {
  it("returns gold for orthodox periods and base token otherwise", () => {
    const qin = {
      id: "qin",
      startAbs: absMonth(-770),
      colorToken: "ochre" as const,
    };
    expect(resolveDynastyColorToken(qin, absMonth(-500))).toBe("ochre");
    expect(resolveDynastyColorToken(qin, absMonth(-221))).toBe(ORTHODOX_COLOR_TOKEN);
  });
});
