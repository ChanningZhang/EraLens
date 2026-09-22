import { describe, expect, it } from "vitest";
import type { Reign } from "@eralens/shared";
import { absMonth } from "@eralens/shared";
import {
  assignReignStacks,
  dynastyBarHeightForReigns,
  dynastyLaneHeight,
  LANE_PADDING_Y,
  nextLaterStartAbs,
  PARALLEL_STACK_ROW_HEIGHT,
  partitionReignRecords,
  reignCardSpan,
  resolveReignVisualSpan,
  resolveStackedCardUnit,
  STACK_ROW_HEIGHT,
  stackRowOffset,
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
    west.dynastyId = "zhou-west";
    eastA.dynastyId = "zhou-east";
    eastB.dynastyId = "zhou-east";

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

  it("does not clip the main line when a parallel court overlaps it", () => {
    const guang = reign("yang-guang", absMonth(604, 1), absMonth(618, 12));
    const you = {
      ...reign("yang-you", absMonth(617, 1), absMonth(618, 12)),
      claimTrack: "changan",
      claimLabel: "长安",
      claimRole: "rival" as const,
    };
    const tong = {
      ...reign("yang-tong", absMonth(618, 1), absMonth(619, 12)),
      claimTrack: "luoyang",
      claimLabel: "洛阳",
      claimRole: "rival" as const,
    };
    const all = [guang, you, tong];

    const { items, rowCount, rowHeights } = assignReignStacks(all);
    expect(rowCount).toBe(3);
    expect(rowHeights).toEqual([
      STACK_ROW_HEIGHT,
      PARALLEL_STACK_ROW_HEIGHT,
      PARALLEL_STACK_ROW_HEIGHT,
    ]);
    expect(stackRowOffset(rowHeights, 1)).toBe(STACK_ROW_HEIGHT);
    expect(stackRowOffset(rowHeights, 2)).toBe(
      STACK_ROW_HEIGHT + PARALLEL_STACK_ROW_HEIGHT,
    );
    expect(dynastyLaneHeight(rowHeights)).toBeCloseTo(
      LANE_PADDING_Y + STACK_ROW_HEIGHT + PARALLEL_STACK_ROW_HEIGHT * 2,
      10,
    );
    expect(items.map((item) => [item.reign.id, item.stackIndex])).toEqual([
      ["yang-guang", 0],
      ["yang-you", 1],
      ["yang-tong", 2],
    ]);

    const main = resolveReignVisualSpan(guang, all);
    expect(main.startAbs).toBe(guang.startAbs);
    expect(main.endExclusive).toBe(guang.endAbs + 1);
    expect(resolveReignVisualSpan(you, all).startAbs).toBe(you.startAbs);
  });

  it("keeps 南明主线 sequential while 鲁监国 / 绍武 sit on their own rows", () => {
    const hongguang = reign("hongguang", absMonth(1644, 1), absMonth(1645, 12));
    const longwu = reign("longwu", absMonth(1645, 1), absMonth(1646, 12));
    const yongli = reign("yongli", absMonth(1646, 1), absMonth(1662, 12));
    const luJian = {
      ...reign("lu-jian", absMonth(1645, 1), absMonth(1653, 12)),
      claimTrack: "lu-jian",
      claimRole: "rival" as const,
    };
    const shaowu = {
      ...reign("shaowu", absMonth(1646, 1), absMonth(1647, 12)),
      claimTrack: "shaowu",
      claimRole: "rival" as const,
    };
    const all = [hongguang, longwu, yongli, luJian, shaowu];

    const { items, rowCount, rowHeights } = assignReignStacks(all);
    expect(rowCount).toBe(3);
    expect(
      items.map((item) => [item.reign.id, item.stackIndex]),
    ).toEqual([
      ["hongguang", 0],
      ["longwu", 0],
      ["yongli", 0],
      ["lu-jian", 1],
      ["shaowu", 2],
    ]);
    expect(rowHeights).toEqual([
      STACK_ROW_HEIGHT,
      PARALLEL_STACK_ROW_HEIGHT,
      PARALLEL_STACK_ROW_HEIGHT,
    ]);

    expect(resolveReignVisualSpan(hongguang, all).endExclusive).toBe(longwu.startAbs);
    expect(resolveReignVisualSpan(yongli, all).startAbs).toBe(yongli.startAbs);
    expect(resolveReignVisualSpan(luJian, all).endExclusive).toBe(luJian.endAbs + 1);
  });

  it("halves card height only for truly concurrent same-span reigns", () => {
    const song = reign("song-qingling", 336, 347);
    const dong = reign("dong-biwu", 336, 347);
    const all = [reign("liu", 300, 335), song, dong, reign("li", 348, 400)];

    const { items, rowCount } = assignReignStacks(all);
    expect(rowCount).toBe(2);
    expect(items.map((item) => [item.reign.id, item.stackIndex])).toEqual([
      ["liu", 0],
      ["dong-biwu", 0],
      ["song-qingling", 1],
      ["li", 0],
    ]);
    expect(resolveStackedCardUnit(dong, all)).toEqual({
      unitTop: 0,
      unitHeight: STACK_ROW_HEIGHT / 2,
    });
    expect(resolveStackedCardUnit(song, all)).toEqual({
      unitTop: STACK_ROW_HEIGHT / 2,
      unitHeight: STACK_ROW_HEIGHT / 2,
    });
    expect(dynastyBarHeightForReigns(all)).toBe(STACK_ROW_HEIGHT);
  });

  it("sequences 哀王 and 思王 within the same year on one row", () => {
    const quji = reign("quji", 336, 338);
    const shu = reign("shu", 339, 347);
    const all = [reign("jie", 0, 335), quji, shu, reign("wei", 348, 400)];

    const { items, rowCount } = assignReignStacks(all);
    expect(rowCount).toBe(1);
    expect(items.every((item) => item.stackIndex === 0)).toBe(true);
    expect(resolveStackedCardUnit(quji, all)).toEqual({
      unitTop: 0,
      unitHeight: STACK_ROW_HEIGHT,
    });
    expect(resolveStackedCardUnit(shu, all)).toEqual({
      unitTop: 0,
      unitHeight: STACK_ROW_HEIGHT,
    });
    expect(resolveReignVisualSpan(quji, all).endExclusive).toBe(shu.startAbs);
    expect(resolveReignVisualSpan(shu, all).startAbs).toBe(shu.startAbs);
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
