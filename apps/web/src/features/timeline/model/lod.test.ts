import { describe, expect, it } from "vitest";
import {
  cardDetailLevel,
  personDetailLevel,
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

  it("wraps vertically when only one glyph fits per line", () => {
    expect(cardDetailLevel(16, 2)).toBe("wrap");
    expect(cardDetailLevel(16, 3)).toBe("wrap");
  });

  it("places the name below the card when wrapping cannot fit", () => {
    expect(cardDetailLevel(15, 3)).toBe("below");
    expect(cardDetailLevel(8, 2)).toBe("below");
    expect(cardDetailLevel(16, 4)).toBe("below");
    expect(cardDetailLevel(16, 5)).toBe("below");
  });
});

describe("shouldShowReignCardMeta", () => {
  it("shows meta for wide cards and short-reign narrow cards", () => {
    expect(shouldShowReignCardMeta(80, 3)).toBe(true);
    expect(shouldShowReignCardMeta(72, 3)).toBe(true);
    expect(shouldShowReignCardMeta(50, 3)).toBe(true);
  });

  it("hides meta when the name must wrap or hang below the card", () => {
    expect(shouldShowReignCardMeta(16, 4)).toBe(false);
    expect(shouldShowReignCardMeta(15, 3)).toBe(false);
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
