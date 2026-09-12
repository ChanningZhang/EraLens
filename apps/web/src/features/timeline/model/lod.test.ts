import { describe, expect, it } from "vitest";
import { cardDetailLevel } from "./lod";

describe("cardDetailLevel", () => {
  it("shows name and appellation when the full name fits on one line", () => {
    expect(cardDetailLevel(80, 3)).toBe("full");
    expect(cardDetailLevel(240, 3)).toBe("full");
  });

  it("wraps the full name inside the card before moving it outside", () => {
    expect(cardDetailLevel(50, 3)).toBe("wrap");
    expect(cardDetailLevel(28, 3)).toBe("wrap");
    expect(cardDetailLevel(16, 3)).toBe("wrap");
  });

  it("places the name below the card when wrapping cannot fit", () => {
    expect(cardDetailLevel(15, 3)).toBe("below");
    expect(cardDetailLevel(8, 2)).toBe("below");
    expect(cardDetailLevel(16, 5)).toBe("below");
  });
});
