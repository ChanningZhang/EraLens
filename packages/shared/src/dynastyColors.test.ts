import { describe, expect, it } from "vitest";
import { COLOR_TOKENS, type ColorToken } from "./schema";
import { absMonth } from "./time";
import {
  assignDistinctColorTokens,
  buildDynastyColorMap,
  colorTokenDistance,
  ORTHODOX_COLOR_TOKEN,
  resolveDynastyColorToken,
  resolveReignColorToken,
} from "./dynastyColors";

function mockDynasties(count: number) {
  return Array.from({ length: count }, (_, index) => ({
    id: `dynasty-${index}`,
    colorToken: COLOR_TOKENS[index % COLOR_TOKENS.length] as ColorToken,
    startAbs: index * 120,
  }));
}

describe("assignDistinctColorTokens", () => {
  it("supports seventeen palette tokens including gold for orthodox dynasties", () => {
    expect(COLOR_TOKENS).toHaveLength(17);
  });

  it("keeps the first dynasty color unchanged", () => {
    const assigned = assignDistinctColorTokens([
      { id: "a", colorToken: "ochre" },
      { id: "b", colorToken: "wisteria" },
    ]);

    expect(assigned.get("a")).toBe("ochre");
  });

  it("avoids repeating the same token on adjacent lanes", () => {
    const ordered = Array.from({ length: 12 }, (_, index) => ({
      id: `d-${index}`,
      colorToken: "ochre" as const,
    }));
    const assigned = assignDistinctColorTokens(ordered);

    for (let index = 1; index < ordered.length; index += 1) {
      const current = assigned.get(`d-${index}`);
      const previous = assigned.get(`d-${index - 1}`);
      expect(current).toBeDefined();
      expect(previous).toBeDefined();
      expect(current).not.toBe(previous);
    }
  });

  it("resolveDynastyColorToken returns the persisted token without a time context", () => {
    const dynasty = {
      id: "tang",
      colorToken: "indigo" as ColorToken,
      startAbs: 1000,
    };
    expect(resolveDynastyColorToken(dynasty)).toBe("indigo");
  });

  it("buildDynastyColorMap depends on which dynasties are in the set", () => {
    const dynasties = mockDynasties(8);
    const full = buildDynastyColorMap(dynasties);
    const withoutPrefix = buildDynastyColorMap(dynasties.slice(2));

    expect(withoutPrefix.get("dynasty-3")).not.toBe(full.get("dynasty-3"));
  });

  it("keeps each dynasty color stable across repeated builds", () => {
    const dynasties = mockDynasties(20);
    const first = buildDynastyColorMap(dynasties);
    const second = buildDynastyColorMap(dynasties);

    for (const dynasty of dynasties) {
      expect(first.get(dynasty.id)).toBe(second.get(dynasty.id));
    }
  });

  it("keeps globally adjacent chronology visually distinct", () => {
    const dynasties = mockDynasties(16);
    const map = buildDynastyColorMap(dynasties);

    for (let index = 1; index < dynasties.length; index += 1) {
      const current = map.get(dynasties[index]!.id);
      const previous = map.get(dynasties[index - 1]!.id);
      expect(current).not.toBe(previous);
      expect(colorTokenDistance(current!, previous!)).toBeGreaterThan(40);
    }
  });

  it("prefers contrasting colors over similar imported tokens", () => {
    const assigned = assignDistinctColorTokens([
      { id: "a", colorToken: "ochre" },
      { id: "b", colorToken: "wisteria" },
      { id: "c", colorToken: "stone" },
    ]);

    const second = assigned.get("b");
    expect(second).not.toBe("ochre");
    expect(colorTokenDistance(second!, "ochre")).toBeGreaterThan(
      colorTokenDistance("wisteria", "ochre"),
    );
  });
});

describe("resolveReignColorToken", () => {
  const yuan = {
    id: "yuan",
    startAbs: absMonth(1271, 12),
    endAbs: absMonth(1388),
    colorToken: "indigo" as const,
  };

  it("keeps gold for orthodox Yuan reigns but not for 元惠宗 starting at the cutoff", () => {
    expect(
      resolveReignColorToken(yuan, {
        startAbs: absMonth(1333, 7),
        endAbs: absMonth(1368, 1),
      }),
    ).toBe(ORTHODOX_COLOR_TOKEN);
    expect(
      resolveReignColorToken(yuan, {
        startAbs: absMonth(1368),
        endAbs: absMonth(1370, 5),
      }),
    ).toBe("indigo");
    expect(
      resolveReignColorToken(yuan, {
        startAbs: absMonth(1370, 5),
        endAbs: absMonth(1378, 5),
      }),
    ).toBe("indigo");
  });

  it("does not use the cutoff month's orthodox-at color for the post-orthodox card", () => {
    expect(resolveDynastyColorToken(yuan, absMonth(1368))).toBe(
      ORTHODOX_COLOR_TOKEN,
    );
    expect(
      resolveReignColorToken(yuan, {
        startAbs: absMonth(1368),
        endAbs: absMonth(1370, 5),
      }),
    ).not.toBe(resolveDynastyColorToken(yuan, absMonth(1368)));
  });

  it("keeps song-south post-orthodox reigns on the dynasty base token", () => {
    const songSouth = {
      id: "song-south",
      startAbs: absMonth(1127),
      endAbs: absMonth(1279),
      colorToken: "jade" as const,
      orthodoxFromAbs: absMonth(1127),
      orthodoxEndAbs: absMonth(1276, 2, 4),
    };

    expect(
      resolveReignColorToken(songSouth, {
        startAbs: absMonth(1276, 6),
        endAbs: absMonth(1278, 5),
      }),
    ).toBe("jade");
    expect(resolveDynastyColorToken(songSouth)).toBe("jade");
    expect(
      resolveReignColorToken(songSouth, {
        startAbs: absMonth(1276, 6),
        endAbs: absMonth(1278, 5),
      }),
    ).toBe(resolveDynastyColorToken(songSouth));
  });
});
