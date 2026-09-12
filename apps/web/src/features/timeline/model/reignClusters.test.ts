import { describe, expect, it } from "vitest";
import type { Reign } from "@eralens/shared";
import {
  assignReignStacks,
  dynastyLaneHeight,
  nextLaterStartAbs,
  reignCardSpan,
} from "./reignClusters";

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

describe("assignReignStacks", () => {
  it("keeps sequential reigns on a single row", () => {
    const { items, rowCount } = assignReignStacks([
      reign("a", 0, 11),
      reign("b", 12, 23),
    ]);
    expect(rowCount).toBe(1);
    expect(items.map((item) => [item.reign.id, item.stackIndex])).toEqual([
      ["a", 0],
      ["b", 0],
    ]);
  });

  it("stacks 哀王 and 思王 who share a year but have no calendar months", () => {
    const { items, rowCount } = assignReignStacks([
      reign("jie", 0, 335),
      reign("quji", 336, 347),
      reign("shu", 336, 347),
      reign("wei", 348, 400),
    ]);
    expect(rowCount).toBe(2);
    expect(items.map((item) => [item.reign.id, item.stackIndex])).toEqual([
      ["jie", 0],
      ["quji", 0],
      ["shu", 1],
      ["wei", 0],
    ]);
    expect(dynastyLaneHeight(rowCount)).toBe(16 + 56 * 2);
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

describe("nextLaterStartAbs", () => {
  it("skips a same-start peer so 哀王 is clipped by 考王, not 思王", () => {
    const quji = reign("quji", 336, 347);
    const all = [reign("jie", 0, 335), quji, reign("shu", 336, 347), reign("wei", 348, 400)];
    expect(nextLaterStartAbs(quji, all)).toBe(348);
  });
});
