import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import {
  isOrthodoxAt,
  overlapsOrthodoxSpan,
  ORTHODOX_END_ABS,
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

  it("marks qing as orthodox only from shunzhi after entering china proper", () => {
    const qing = {
      id: "qing",
      startAbs: absMonth(1616, 2),
      endAbs: absMonth(1912, 2),
    };
    expect(resolveOrthodoxFromAbs(qing)).toBe(ORTHODOX_FROM_ABS.qing);
    expect(isOrthodoxAt(qing, absMonth(1636))).toBe(false);
    expect(isOrthodoxAt(qing, absMonth(1643))).toBe(false);
    expect(isOrthodoxAt(qing, absMonth(1644))).toBe(true);
    expect(
      overlapsOrthodoxSpan(qing, absMonth(1616), absMonth(1626)),
    ).toBe(false);
    expect(
      overlapsOrthodoxSpan(qing, absMonth(1626), absMonth(1643)),
    ).toBe(false);
    expect(
      overlapsOrthodoxSpan(qing, absMonth(1643), absMonth(1661)),
    ).toBe(true);
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

  it("marks roc as orthodox from dynasty start", () => {
    const roc = { id: "roc", startAbs: absMonth(1912, 1) };
    expect(resolveOrthodoxFromAbs(roc)).toBe(roc.startAbs);
    expect(isOrthodoxAt(roc, absMonth(1912, 1))).toBe(true);
    expect(isOrthodoxAt(roc, absMonth(1911))).toBe(false);
  });

  it("marks yuan as orthodox only until 1368 even when dynasty ends in 1388", () => {
    const yuan = {
      id: "yuan",
      startAbs: absMonth(1271, 12),
      endAbs: absMonth(1388),
    };
    expect(resolveOrthodoxSpan(yuan)).toEqual({
      startAbs: yuan.startAbs,
      endAbs: ORTHODOX_END_ABS.yuan,
    });
    expect(isOrthodoxAt(yuan, absMonth(1367))).toBe(true);
    expect(isOrthodoxAt(yuan, absMonth(1368))).toBe(true);
    expect(isOrthodoxAt(yuan, absMonth(1369))).toBe(false);
    expect(
      overlapsOrthodoxSpan(yuan, absMonth(1368), absMonth(1370)),
    ).toBe(false);
    expect(
      overlapsOrthodoxSpan(yuan, absMonth(1370), absMonth(1378)),
    ).toBe(false);
    expect(
      overlapsOrthodoxSpan(yuan, absMonth(1367), absMonth(1370)),
    ).toBe(true);
  });

  it("does not mark split-period dynasties as orthodox", () => {
    const songLiu = { id: "song-liu", startAbs: absMonth(420, 7) };
    const weiNorth = { id: "wei-north", startAbs: absMonth(386) };
    const jinEast = { id: "jin-east", startAbs: absMonth(317) };
    const songNorth = { id: "song-north", startAbs: absMonth(960) };
    const sui = { id: "sui", startAbs: absMonth(581) };

    expect(resolveOrthodoxFromAbs(songLiu)).toBeUndefined();
    expect(resolveOrthodoxFromAbs(weiNorth)).toBeUndefined();
    expect(resolveOrthodoxFromAbs(jinEast)).toBe(jinEast.startAbs);
    expect(resolveOrthodoxFromAbs(songNorth)).toBe(songNorth.startAbs);
    expect(resolveOrthodoxFromAbs(sui)).toBe(sui.startAbs);
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
