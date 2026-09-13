import { describe, expect, it } from "vitest";
import type { Reign } from "@eralens/shared";
import { absMonth } from "@eralens/shared";
import {
  assignReignStacks,
  computeReignGaps,
  dynastyLaneHeight,
  nextLaterStartAbs,
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

describe("computeReignGaps", () => {
  const dynasty = { startAbs: 0, endAbs: 99 };

  it("returns the full dynasty span when there are no reigns", () => {
    expect(computeReignGaps(dynasty, [])).toEqual([
      { startAbs: 0, endExclusive: 100 },
    ]);
  });

  it("finds gaps before, between, and after reigns", () => {
    const gaps = computeReignGaps(dynasty, [
      reign("a", 20, 39),
      reign("b", 60, 79),
    ]);
    expect(gaps).toEqual([
      { startAbs: 0, endExclusive: 20 },
      { startAbs: 40, endExclusive: 60 },
      { startAbs: 80, endExclusive: 100 },
    ]);
  });

  it("skips short gaps below the minimum month threshold", () => {
    const gaps = computeReignGaps(dynasty, [reign("a", 0, 10), reign("b", 15, 30)], 12);
    expect(gaps).toEqual([{ startAbs: 31, endExclusive: 100 }]);
  });

  it("treats overlapping reign intervals as continuous coverage", () => {
    const gaps = computeReignGaps(
      dynasty,
      [reign("a", 10, 50), reign("b", 30, 70)],
      1,
    );
    expect(gaps).toEqual([
      { startAbs: 0, endExclusive: 10 },
      { startAbs: 71, endExclusive: 100 },
    ]);
  });
});

describe("nextLaterStartAbs", () => {
  it("skips a same-start peer so 哀王 is clipped by 考王, not 思王", () => {
    const quji = reign("quji", 336, 347);
    const all = [reign("jie", 0, 335), quji, reign("shu", 336, 347), reign("wei", 348, 400)];
    expect(nextLaterStartAbs(quji, all)).toBe(348);
  });
});
