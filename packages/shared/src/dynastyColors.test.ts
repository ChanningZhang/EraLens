import { describe, expect, it } from "vitest";
import { COLOR_TOKENS, type ColorToken } from "./schema";
import { absMonth } from "./time";
import {
  assignLaneColorTokens,
  buildDynastyColorMap,
  buildLaneOrderIndex,
  buildStableLaneColorMap,
  colorTokenDistance,
  fallbackLaneColorToken,
  MASTER_COLOR_TOKEN,
  resolveDynastyColorToken,
  resolveReignColorToken,
} from "./dynastyColors";
import type { Dynasty, DynastyGroup, DynastyLaneGroup } from "./schema";

function mockDynasties(count: number) {
  return Array.from({ length: count }, (_, index) => ({
    id: `dynasty-${index}`,
    startAbs: index * 120,
  }));
}

describe("assignLaneColorTokens", () => {
  it("supports twenty-four assignable palette tokens plus master gold", () => {
    expect(COLOR_TOKENS).toHaveLength(25);
    expect(COLOR_TOKENS).toContain("gold");
  });

  it("assigns a stable fallback token per dynasty id", () => {
    expect(fallbackLaneColorToken("qin")).toBe(fallbackLaneColorToken("qin"));
    expect(fallbackLaneColorToken("qin")).not.toBe(fallbackLaneColorToken("tang"));
  });

  it("avoids repeating the same token on adjacent lanes", () => {
    const ordered = Array.from({ length: 12 }, (_, index) => ({
      id: `d-${index}`,
    }));
    const assigned = assignLaneColorTokens(ordered);

    for (let index = 1; index < ordered.length; index += 1) {
      const current = assigned.get(`d-${index}`);
      const previous = assigned.get(`d-${index - 1}`);
      expect(current).toBeDefined();
      expect(previous).toBeDefined();
      expect(current).not.toBe(previous);
    }
  });

  it("uses many distinct colors in a long contiguous cluster, not a short cycle", () => {
    const ordered = Array.from({ length: 16 }, (_, index) => ({
      id: `sixteen-${index}`,
    }));
    const assigned = assignLaneColorTokens(ordered);
    const tokens = ordered.map((dynasty) => assigned.get(dynasty.id)!);
    const unique = new Set(tokens);
    expect(unique.size).toBe(16);
  });

  it("resolveDynastyColorToken uses the lane token without a time context", () => {
    const dynasty = {
      id: "tang",
      startAbs: 1000,
    };
    expect(resolveDynastyColorToken(dynasty, "indigo")).toBe("indigo");
  });

  it("buildDynastyColorMap walks the palette in sorted lane order", () => {
    const dynasties = mockDynasties(8);
    const map = buildDynastyColorMap(dynasties);
    const tokens = dynasties.map((dynasty) => map.get(dynasty.id)!);
    expect(new Set(tokens).size).toBe(8);
    for (let index = 1; index < tokens.length; index += 1) {
      expect(tokens[index]).not.toBe(tokens[index - 1]);
    }
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
      expect(current).not.toBe(previous);
    }
  });

  it("cycles the palette in lane order for adjacent lanes", () => {
    const assigned = assignLaneColorTokens([
      { id: "a" },
      { id: "b" },
      { id: "c" },
    ]);

    const second = assigned.get("b");
    const first = assigned.get("a");
    expect(second).not.toBe(first);
    expect(colorTokenDistance(second!, first!)).toBeGreaterThan(60);
  });
});

describe("buildStableLaneColorMap", () => {
  function mockDynasty(id: string, startAbs: number, endAbs = startAbs + 120): Dynasty {
    return {
      id,
      name: id,
      altNames: [],
      scope: "cn",
      region: "east_asia",
      start: { year: 0, month: 1 },
      end: { year: 10, month: 12 },
      startAbs,
      endAbs,
      precision: "year",
    };
  }

  it("keeps dynasty colors stable regardless of which subset is visible", () => {
    const dynasties = [
      mockDynasty("a", 0),
      mockDynasty("b", 120),
      mockDynasty("c", 240),
      mockDynasty("d", 360),
    ];
    const full = buildStableLaneColorMap(dynasties);
    const again = buildStableLaneColorMap(dynasties);
    expect(again.get("b")).toBe(full.get("b"));
    expect(again.get("c")).toBe(full.get("c"));
  });
});

describe("buildLaneOrderIndex (stable placement)", () => {
  function d(id: string, startAbs: number, endAbs: number, groupId?: string): Dynasty {
    return {
      id,
      name: id,
      altNames: [],
      scope: "cn",
      region: "east_asia",
      start: { year: 0, month: 1 },
      end: { year: 10, month: 12 },
      startAbs,
      endAbs,
      precision: "year",
      groupId,
    };
  }
  const cap = (dynastyId: string, modernName: string, startAbs: number, endAbs: number) => ({
    dynastyId,
    modernName,
    startAbs,
    endAbs,
  });

  it("ranks a same-capital successor above an earlier-starting neighbour, independent of the anchor being visible", () => {
    // 五代(开封 cluster) → 北宋(开封); 大理 starts earlier than 北宋 but at a
    // different city. 北宋 should outrank 大理 globally.
    const dynasties = [
      d("zhou-hou", absMonth(951), absMonth(960, 12), "wudai"),
      d("dali", absMonth(937), absMonth(1253, 12)),
      d("song-north", absMonth(960), absMonth(1127, 12)),
    ];
    const groups: DynastyGroup[] = [
      {
        id: "wudai",
        name: "五代",
        altNames: [],
        scope: "cn",
        start: { year: 907, month: 1 },
        end: { year: 960, month: 12 },
        startAbs: absMonth(907),
        endAbs: absMonth(960, 12),
        precision: "year",
      },
    ];
    const capitals = [
      cap("zhou-hou", "河南省开封市", absMonth(951), absMonth(960, 12)),
      cap("song-north", "河南省开封市", absMonth(960), absMonth(1127, 12)),
      cap("dali", "云南省大理市", absMonth(937), absMonth(1253, 12)),
    ];

    const rank = buildLaneOrderIndex(dynasties, groups, [], capitals);
    // 北宋 outranks 大理 (pulled up under 五代).
    expect(rank.get("song-north")!).toBeLessThan(rank.get("dali")!);

    // Simulate a viewport where 五代 has scrolled off: sorting the remaining
    // rows by the global rank keeps 北宋 above 大理 (no jump).
    const visibleAfterWudaiLeaves = [d("dali", absMonth(937), absMonth(1253, 12)), d("song-north", absMonth(960), absMonth(1127, 12))];
    const ordered = [...visibleAfterWudaiLeaves].sort(
      (x, y) => rank.get(x.id)! - rank.get(y.id)!,
    );
    expect(ordered.map((x) => x.id)).toEqual(["song-north", "dali"]);
  });

  it("does not pull a merged lane up by a capital it only holds later (蒙古→元)", () => {
    // 蒙古/元 merges into one row keyed by 元. At its 1206 start the merged
    // lane sits at 哈拉和林, which nobody shares, so it must stay below the
    // earlier-starting 西辽 / 南宋 rather than being yanked under 金 via 元's
    // later 北京.
    const dynasties = [
      d("jin-nv", absMonth(1115), absMonth(1234, 12)),
      d("xiliao", absMonth(1124), absMonth(1218, 12)),
      d("song-south", absMonth(1127), absMonth(1279, 12)),
      d("mongol-empire", absMonth(1206), absMonth(1271, 12)),
      d("yuan", absMonth(1271), absMonth(1368, 12)),
    ];
    const laneGroups: DynastyLaneGroup[] = [
      {
        id: "mongol-yuan",
        primaryDynastyId: "yuan",
        phaseDynastyIds: ["mongol-empire", "yuan"],
        laneOrderStartAbs: absMonth(1206),
        laneOrderEndAbs: absMonth(1388),
      },
    ];
    const capitals = [
      cap("jin-nv", "黑龙江省哈尔滨市阿城区", absMonth(1115), absMonth(1153, 12)),
      cap("jin-nv", "北京市", absMonth(1154), absMonth(1214, 12)),
      cap("xiliao", "吉尔吉斯斯坦楚河州", absMonth(1124), absMonth(1218, 12)),
      cap("song-south", "浙江省杭州市", absMonth(1130), absMonth(1279, 12)),
      cap("mongol-empire", "蒙古国哈拉和林", absMonth(1206), absMonth(1271, 12)),
      cap("yuan", "北京市", absMonth(1272), absMonth(1368, 12)),
    ];

    const rank = buildLaneOrderIndex(dynasties, [], laneGroups, capitals);
    expect(rank.get("yuan")!).toBeGreaterThan(rank.get("xiliao")!);
    expect(rank.get("yuan")!).toBeGreaterThan(rank.get("song-south")!);
    expect(rank.get("yuan")!).toBeGreaterThan(rank.get("jin-nv")!);
  });

  it("gives every dynasty a rank without capitals (pure time order preserved)", () => {
    const dynasties = [d("c", 240, 300), d("a", 0, 60), d("b", 120, 180)];
    const rank = buildLaneOrderIndex(dynasties);
    expect(rank.get("a")!).toBeLessThan(rank.get("b")!);
    expect(rank.get("b")!).toBeLessThan(rank.get("c")!);
  });
});

describe("resolveReignColorToken", () => {
  const dynasty = { id: "sample" };
  const laneColor = "indigo" as const;

  it("uses the gold overlay only for explicitly marked main-line reigns", () => {
    expect(resolveReignColorToken(dynasty, { isMain: true }, laneColor)).toBe(
      MASTER_COLOR_TOKEN,
    );
    expect(resolveReignColorToken(dynasty, { isMain: null }, laneColor)).toBe(
      laneColor,
    );
    expect(resolveReignColorToken(dynasty, { isMain: false }, laneColor)).toBe(
      laneColor,
    );
  });
});
