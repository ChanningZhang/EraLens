import { describe, expect, it } from "vitest";
import type { Reign } from "@eralens/shared";
import { clusterSameStartReigns, reignCardSpan } from "./reignClusters";

function reign(id: string, startAbs: number, endAbs: number): Reign {
  return {
    id,
    dynastyId: "zhou-east",
    personId: id,
    title: id,
    eraNames: [],
    start: { year: 1, month: 1 },
    end: { year: 1, month: 12 },
    startAbs,
    endAbs,
    precision: "year",
  };
}

describe("clusterSameStartReigns", () => {
  it("keeps sequential reigns on their own cards", () => {
    const clusters = clusterSameStartReigns([
      reign("a", 0, 11),
      reign("b", 12, 23),
    ]);
    expect(clusters.map((group) => group.map((item) => item.id))).toEqual([
      ["a"],
      ["b"],
    ]);
  });

  it("groups 哀王 and 思王 who share the same year", () => {
    const clusters = clusterSameStartReigns([
      reign("jie", 0, 335),
      reign("quji", 336, 347),
      reign("shu", 336, 347),
      reign("wei", 348, 400),
    ]);
    expect(clusters.map((group) => group.map((item) => item.id))).toEqual([
      ["jie"],
      ["quji", "shu"],
      ["wei"],
    ]);
  });
});

describe("reignCardSpan", () => {
  it("clips a card when the next reign starts later inside it", () => {
    expect(reignCardSpan(0, 335, 324)).toEqual({
      startAbs: 0,
      endExclusive: 324,
    });
  });

  it("does not collapse a reign to zero width when the next one starts at the same instant", () => {
    expect(reignCardSpan(336, 347, 336)).toEqual({
      startAbs: 336,
      endExclusive: 348,
    });
  });
});
