import { describe, expect, it } from "vitest";
import {
  buildReignCardTooltip,
  cardDetailLevel,
  personDetailLevel,
  resolveReignBarLayout,
  resolveReignCaptionPlacement,
  resolveReignCardTextLayout,
  shouldShowPersons,
  shouldShowReignCardMeta,
} from "./lod";

describe("cardDetailLevel", () => {
  it("shows name and appellation when the full name fits on one line", () => {
    expect(cardDetailLevel(80, 3)).toBe("full");
    expect(cardDetailLevel(240, 3)).toBe("full");
  });

  it("wraps the full name inside the card before moving it outside", () => {
    expect(cardDetailLevel(50, 3)).toBe("wrap");
    expect(cardDetailLevel(28, 3)).toBe("wrap");
  });

  it("wraps a 2-glyph sliver like 杨浩 vertically inside a year-wide card", () => {
    expect(cardDetailLevel(18, 2)).toBe("wrap");
  });

  it("wraps vertically when only one glyph fits per line", () => {
    expect(cardDetailLevel(44, 4)).toBe("wrap");
    expect(cardDetailLevel(22, 3)).toBe("wrap");
  });

  it("places the name beside the card when wrapping cannot fit", () => {
    expect(cardDetailLevel(8, 2)).toBe("below");
    expect(cardDetailLevel(16, 2)).toBe("below");
    expect(cardDetailLevel(16, 3)).toBe("below");
    expect(cardDetailLevel(16, 4)).toBe("below");
    expect(cardDetailLevel(16, 5)).toBe("below");
  });
});

describe("resolveReignBarLayout", () => {
  it("keeps a sub-month bar at its duration width with an expanded hit target", () => {
    const layout = resolveReignBarLayout(1 / 28, 4);
    expect(layout.barWidthPx).toBeCloseTo(1 / 28, 5);
    expect(layout.unitWidthPx).toBe(8);
    expect(layout.markerStyle).toBe(true);
    expect(layout.centerOnAnchor).toBe(true);
    expect(layout.captionBelow).toBe(true);
  });

  it("uses marker styling for a multi-week bar that is still too narrow for padding", () => {
    const layout = resolveReignBarLayout(2.35, 2);
    expect(layout.barWidthPx).toBe(2.35);
    expect(layout.unitWidthPx).toBe(8);
    expect(layout.markerStyle).toBe(true);
    expect(layout.captionBelow).toBe(true);
  });

  it("keeps wide bars on the normal padded card path", () => {
    const layout = resolveReignBarLayout(56.6, 2);
    expect(layout.barWidthPx).toBe(56.6);
    expect(layout.unitWidthPx).toBe(56.6);
    expect(layout.markerStyle).toBe(false);
    expect(layout.centerOnAnchor).toBe(false);
    expect(layout.textLayout.level).toBe("wrap");
  });
});

describe("resolveReignCaptionPlacement", () => {
  it("hangs the name below on the last stack row", () => {
    expect(
      resolveReignCaptionPlacement({
        stackIndex: 2,
        rowCount: 3,
        overlapsLowerRow: false,
      }),
    ).toBe("below");
  });

  it("flips the caption above when a lower row already occupies that span", () => {
    expect(
      resolveReignCaptionPlacement({
        stackIndex: 0,
        rowCount: 3,
        overlapsLowerRow: true,
      }),
    ).toBe("above");
  });
});

describe("resolveReignCardTextLayout", () => {
  it("keeps the default font size for full cards", () => {
    expect(resolveReignCardTextLayout(120, 2)).toEqual({
      level: "full",
      nameFontPx: 17,
      metaFontPx: 13,
    });
  });

  it("steps down the font size for narrow wrapped cards", () => {
    expect(resolveReignCardTextLayout(28, 3).level).toBe("wrap");
    expect(resolveReignCardTextLayout(28, 3).nameFontPx).toBeLessThan(16);
    expect(resolveReignCardTextLayout(18, 2).level).toBe("wrap");
    expect(resolveReignCardTextLayout(18, 2).nameFontPx).toBeLessThan(16);
  });

  it("steps down a 4-glyph name on a 2-year card instead of overflowing", () => {
    const layout = resolveReignCardTextLayout(36, 4);
    expect(layout.level).toBe("wrap");
    expect(layout.nameFontPx).toBeLessThanOrEqual(15);
    expect(layout.nameFontPx * 2).toBeLessThanOrEqual(36 - 6);
  });
});

describe("shouldShowReignCardMeta", () => {
  it("shows meta when name and appellation fit on one horizontal row", () => {
    expect(shouldShowReignCardMeta(120, 2, 4)).toBe(true);
    expect(shouldShowReignCardMeta(110, 2, 3)).toBe(true);
  });

  it("hides meta when the row is too narrow for name plus appellation", () => {
    expect(shouldShowReignCardMeta(80, 3, 4)).toBe(false);
    expect(shouldShowReignCardMeta(50, 3, 4)).toBe(false);
    expect(shouldShowReignCardMeta(80, 3, 0)).toBe(false);
  });

  it("hides meta when the name must wrap or hang below the card", () => {
    expect(shouldShowReignCardMeta(16, 4, 4)).toBe(false);
    expect(shouldShowReignCardMeta(15, 3, 4)).toBe(false);
  });
});

describe("buildReignCardTooltip", () => {
  const time = "公元304年1月 — 公元310年7月 · 6年7个月";

  it("shows only time when the card already shows name and meta", () => {
    expect(
      buildReignCardTooltip({
        detail: "full",
        showMeta: true,
        meta: { name: "汉赵光文皇帝" },
        tooltipName: "刘渊",
        timeTooltip: time,
      }),
    ).toBe(time);
  });

  it("adds hidden meta when the card shows the name but not the appellation", () => {
    expect(
      buildReignCardTooltip({
        detail: "full",
        showMeta: false,
        meta: { name: "汉赵光文皇帝" },
        tooltipName: "刘渊",
        timeTooltip: time,
      }),
    ).toBe(`汉赵光文皇帝\n${time}`);
  });

  it("adds name and meta when the label hangs below the bar", () => {
    expect(
      buildReignCardTooltip({
        detail: "below",
        showMeta: false,
        meta: { name: "汉赵光文皇帝" },
        tooltipName: "刘渊",
        timeTooltip: time,
      }),
    ).toBe(`刘渊　汉赵光文皇帝\n${time}`);
  });

  it("appends claim lines after the time span", () => {
    expect(
      buildReignCardTooltip({
        detail: "full",
        showMeta: false,
        meta: { name: "汉赵光文皇帝" },
        tooltipName: "刘渊",
        timeTooltip: time,
        claimTooltip: "割据・长安",
      }),
    ).toBe(`汉赵光文皇帝\n${time}\n割据・长安`);
  });
});

describe("shouldShowPersons", () => {
  it("hides persons at millennium lod", () => {
    expect(shouldShowPersons("millennium")).toBe(false);
    expect(shouldShowPersons("century")).toBe(true);
  });
});

describe("personDetailLevel", () => {
  it("shows full label at decade zoom with enough width", () => {
    expect(personDetailLevel("decade", 120)).toBe("full");
    expect(personDetailLevel("century", 20)).toBe("dot");
  });
});
