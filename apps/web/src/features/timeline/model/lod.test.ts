import { describe, expect, it } from "vitest";
import {
  cardDetailLevel,
  personDetailLevel,
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
    expect(cardDetailLevel(28, 3)).toBe("below");
  });

  it("wraps vertically when only one glyph fits per line", () => {
    expect(cardDetailLevel(44, 4)).toBe("wrap");
    expect(cardDetailLevel(16, 2)).toBe("below");
    expect(cardDetailLevel(16, 3)).toBe("below");
  });

  it("places the name below the card when wrapping cannot fit", () => {
    expect(cardDetailLevel(15, 3)).toBe("below");
    expect(cardDetailLevel(8, 2)).toBe("below");
    expect(cardDetailLevel(16, 4)).toBe("below");
    expect(cardDetailLevel(16, 5)).toBe("below");
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
    expect(resolveReignCardTextLayout(50, 3).level).toBe("wrap");
    expect(resolveReignCardTextLayout(50, 3).nameFontPx).toBeLessThan(16);
    expect(resolveReignCardTextLayout(44, 4).level).toBe("wrap");
    expect(resolveReignCardTextLayout(44, 4).nameFontPx).toBeLessThan(16);
  });
});

describe("shouldShowReignCardMeta", () => {
  it("shows meta when name and appellation fit on one horizontal row", () => {
    expect(shouldShowReignCardMeta(120, 2, 4)).toBe(true);
    expect(shouldShowReignCardMeta(100, 2, 3)).toBe(true);
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
