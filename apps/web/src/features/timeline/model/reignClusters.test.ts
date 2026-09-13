import { describe, expect, it } from "vitest";
import type { Reign } from "@eralens/shared";
import { absMonth } from "@eralens/shared";
import {
  assignReignStacks,
  dynastyLaneHeight,
  nextLaterStartAbs,
  partitionReignRecords,
  reignCardSpan,
  resolveReignVisualSpan,
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
  it("separates only the reserved missing-ruler records", () => {
    const ruler = reign("ruler", 0, 11);
    const missing = {
      ...reign("missing", 12, 23),
      personId: "system-missing-ruler",
    };

    expect(partitionReignRecords([ruler, missing])).toEqual({
      rulers: [ruler],
      missing: [missing],
    });
  });

  it("lays out merged lane-group phases independently on one row", () => {
    const west = reign("west-r1", 100, 199);
    const eastA = reign("east-r1", 250, 349);
    const eastB = reign("east-r2", 350, 449);
    west.dynastyId = "jin-west";
    eastA.dynastyId = "jin-east";
    eastB.dynastyId = "jin-east";

    const { items, rowCount } = assignReignStacks([west, eastA, eastB]);
    expect(rowCount).toBe(1);
    expect(items.map((item) => item.reign.id)).toEqual(["west-r1", "east-r1", "east-r2"]);

    const firstEast = resolveReignVisualSpan(eastA, [west, eastA, eastB]);
    const secondEast = resolveReignVisualSpan(eastB, [west, eastA, eastB]);
    expect(firstEast.endExclusive).toBe(eastB.startAbs);
    expect(secondEast.startAbs).toBe(eastA.endAbs + 1);
  });

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

  it("keeps same-start rivals with different end years on one row", () => {
    const huFirst = reign("zheng-r3", absMonth(-700, 1), absMonth(-700, 12));
    const tu = reign("zheng-r4", absMonth(-700, 1), absMonth(-697, 12));
    const huSecond = reign("zheng-r5", absMonth(-696, 1), absMonth(-695, 12));
    const all = [huFirst, tu, huSecond];

    const { items, rowCount } = assignReignStacks(all);
    expect(rowCount).toBe(1);
    expect(items.every((item) => item.stackIndex === 0)).toBe(true);

    const first = resolveReignVisualSpan(huFirst, all);
    const second = resolveReignVisualSpan(tu, all);
    expect(first.startAbs).toBe(huFirst.startAbs);
    expect(second.startAbs).toBe(huFirst.endAbs + 1);
    expect(second.startAbs).toBeGreaterThan(first.endExclusive - 1);
  });

  it("shows both reigns when a ruler returns after an interregnum (明英宗复辟)", () => {
    const qizhenFirst = reign("zhu-qizhen-1", absMonth(1435, 1), absMonth(1449, 12));
    const qiyu = reign("zhu-qiyu", absMonth(1449, 1), absMonth(1457, 12));
    const qizhenSecond = reign("zhu-qizhen-2", absMonth(1457, 1), absMonth(1464, 12));
    const jianshen = reign("zhu-jianshen", absMonth(1464, 1), absMonth(1487, 12));
    const all = [qizhenFirst, qiyu, qizhenSecond, jianshen];

    const first = resolveReignVisualSpan(qizhenFirst, all);
    const second = resolveReignVisualSpan(qizhenSecond, all);
    expect(first.endExclusive).toBe(qiyu.startAbs);
    expect(second.startAbs).toBe(qizhenSecond.startAbs);
    expect(second.endExclusive).toBe(jianshen.startAbs);
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
