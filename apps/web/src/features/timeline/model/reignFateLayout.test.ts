import { describe, expect, it } from "vitest";
import {
  absMonth,
  COLOR_VALUES,
  TIMELINE_GUTTER_PX,
  type Dynasty,
  type Reign,
  type Relation,
} from "@eralens/shared";
import { layoutReignFates } from "./reignFateLayout";
import { LANE_PADDING_TOP, STACK_ROW_HEIGHT } from "./reignClusters";

function pathCoords(path: string): { x: number; y: number }[] {
  const nums = [...path.matchAll(/-?\d+(?:\.\d+)?/g)].map((match) => Number(match[0]));
  const points: { x: number; y: number }[] = [];
  for (let index = 0; index + 1 < nums.length; index += 2) {
    points.push({ x: nums[index]!, y: nums[index + 1]! });
  }
  return points;
}

const viewport = {
  centerAbs: absMonth(-225, 6),
  pxPerMonth: 4,
  widthPx: 1200,
  startAbs: absMonth(-225, 6) - 150,
  endAbs: absMonth(-225, 6) + 150,
  gutterPx: TIMELINE_GUTTER_PX,
};

const yingZhengQin: Reign = {
  id: "reign-ying-zheng-qin",
  dynastyId: "qin",
  personId: "ying-zheng",
  title: "秦王政",
  eraNames: [],
  start: { year: -246, month: 1 },
  end: { year: -221, month: 12 },
  startAbs: absMonth(-246, 1),
  endAbs: absMonth(-221, 12),
  precision: "year",
};

const hanLast: Reign = {
  id: "reign-han-r10-han-warring",
  dynastyId: "han-warring",
  personId: "han-r10",
  title: "韩王安",
  eraNames: [],
  start: { year: -238, month: 1 },
  end: { year: -230, month: 12 },
  startAbs: absMonth(-238, 1),
  endAbs: absMonth(-230, 12),
  precision: "year",
};

describe("layoutReignFates", () => {
  it("builds nearly vertical path when atAbs matches victim end", () => {
    const relation: Relation = {
      id: "rel-han-r10-ying-zheng-surrender",
      fromRef: "person:han-r10",
      toRef: "person:ying-zheng",
      kind: "surrender",
      atAbs: absMonth(-230, 12),
      precision: "year",
    };
    const placed = layoutReignFates(
      [relation],
      [hanLast, yingZhengQin],
      [
        { dynastyId: "han-warring", top: 80, records: [hanLast], color: COLOR_VALUES.grape },
        { dynastyId: "qin", top: 140, records: [yingZhengQin], color: COLOR_VALUES.cinnabar },
      ],
      viewport,
      new Map([
        ["han-r10", "韩王安"],
        ["ying-zheng", "嬴政"],
      ]),
    );
    expect(placed).toHaveLength(1);
    expect(placed[0]?.path.startsWith("M ")).toBe(true);
    expect(placed[0]?.path.includes(" L ")).toBe(true);
    expect(placed[0]?.tooltip).toContain("投降");
    expect(placed[0]?.color).toBe(COLOR_VALUES.grape);
    const origin = pathCoords(placed[0]!.path)[0];
    expect(placed[0]?.originX).toBe(origin?.x);
    expect(placed[0]?.originY).toBe(origin?.y);
    const hanBarBottom = 80 + LANE_PADDING_TOP + STACK_ROW_HEIGHT;
    expect(placed[0]?.originY).toBe(hanBarBottom);
  });

  it("stops an upward connector at the lower edge of the upper card", () => {
    const relation: Relation = {
      id: "rel-han-r10-ying-zheng-surrender",
      fromRef: "person:han-r10",
      toRef: "person:ying-zheng",
      kind: "surrender",
      atAbs: absMonth(-230, 12),
      precision: "year",
    };
    const qinTop = 80;
    const hanTop = 200;
    const placed = layoutReignFates(
      [relation],
      [hanLast, yingZhengQin],
      [
        { dynastyId: "qin", top: qinTop, records: [yingZhengQin], color: COLOR_VALUES.cinnabar },
        { dynastyId: "han-warring", top: hanTop, records: [hanLast], color: COLOR_VALUES.grape },
      ],
      viewport,
      new Map([
        ["han-r10", "韩王安"],
        ["ying-zheng", "嬴政"],
      ]),
    );
    expect(placed).toHaveLength(1);
    const qinBarTop = qinTop + LANE_PADDING_TOP;
    const qinBarBottom = qinBarTop + STACK_ROW_HEIGHT;
    const hanBarTop = hanTop + LANE_PADDING_TOP;
    const ys = pathCoords(placed[0]!.path).map((point) => point.y);
    const minY = Math.min(...ys);
    const maxY = Math.max(...ys);
    expect(minY).toBeGreaterThan(qinBarBottom);
    expect(minY).toBeLessThan(qinBarBottom + 4);
    expect(placed[0]!.originY).toBe(hanBarTop);
    expect(maxY).toBe(hanBarTop);
    expect(placed[0]!.tickTop + placed[0]!.tickHeight).toBe(qinBarBottom);
  });

  it("starts a rightward leader at the source card mid-height, not the bottom", () => {
    const relation: Relation = {
      id: "rel-han-r10-ying-zheng-surrender-later",
      fromRef: "person:han-r10",
      toRef: "person:ying-zheng",
      kind: "surrender",
      atAbs: absMonth(-221, 12),
      precision: "year",
    };
    const hanTop = 80;
    const qinTop = 200;
    const placed = layoutReignFates(
      [relation],
      [hanLast, yingZhengQin],
      [
        { dynastyId: "han-warring", top: hanTop, records: [hanLast], color: COLOR_VALUES.grape },
        { dynastyId: "qin", top: qinTop, records: [yingZhengQin], color: COLOR_VALUES.cinnabar },
      ],
      viewport,
      new Map([
        ["han-r10", "韩王安"],
        ["ying-zheng", "嬴政"],
      ]),
    );
    expect(placed).toHaveLength(1);
    const points = pathCoords(placed[0]!.path);
    expect(points.length).toBeGreaterThanOrEqual(2);
    const xs = points.map((point) => point.x);
    expect(Math.max(...xs) - Math.min(...xs)).toBeGreaterThan(2);
    const hanMidY = hanTop + LANE_PADDING_TOP + STACK_ROW_HEIGHT / 2;
    expect(points[0]!.y).toBeCloseTo(hanMidY, 0);
    const hanBarBottom = hanTop + LANE_PADDING_TOP + STACK_ROW_HEIGHT;
    expect(points[0]!.y).toBeLessThan(hanBarBottom - 8);
    expect(placed[0]!.originX).toBe(points[0]!.x);
    expect(placed[0]!.originY).toBe(points[0]!.y);
  });

  it("uses the source lane 本色, never orthodox gold", () => {
    const jinWest: Dynasty = {
      id: "jin-west",
      name: "西晋",
      altNames: [],
      scope: "cn",
      region: "east_asia",
      start: { year: 266, month: 2 },
      end: { year: 316, month: 12 },
      startAbs: absMonth(266, 2),
      endAbs: absMonth(316, 12),
      precision: "year",
      colorToken: "stone",
    };
    const hanZhao: Dynasty = {
      id: "han-zhao",
      name: "汉赵",
      altNames: [],
      scope: "cn",
      region: "east_asia",
      start: { year: 304, month: 1 },
      end: { year: 329, month: 12 },
      startAbs: absMonth(304, 1),
      endAbs: absMonth(329, 12),
      precision: "year",
      colorToken: "cinnabar",
    };
    const simaYe: Reign = {
      id: "reign-sima-ye",
      dynastyId: "jin-west",
      personId: "sima-ye",
      title: "晋愍帝",
      eraNames: [],
      start: { year: 313, month: 6 },
      end: { year: 316, month: 12 },
      startAbs: absMonth(313, 6),
      endAbs: absMonth(316, 12),
      precision: "year",
    };
    const liuCong: Reign = {
      id: "reign-liu-cong",
      dynastyId: "han-zhao",
      personId: "liu-cong",
      title: "刘聪",
      eraNames: [],
      start: { year: 310, month: 8 },
      end: { year: 318, month: 8 },
      startAbs: absMonth(310, 8),
      endAbs: absMonth(318, 8),
      precision: "month",
    };
    const jinViewport = {
      ...viewport,
      centerAbs: absMonth(316, 12),
      startAbs: absMonth(316, 12) - 150,
      endAbs: absMonth(316, 12) + 150,
    };
    const placed = layoutReignFates(
      [
        {
          id: "rel-sima-ye-liu-cong-surrender",
          fromRef: "person:sima-ye",
          toRef: "person:liu-cong",
          kind: "surrender",
          atAbs: absMonth(316, 12),
          precision: "year",
        },
      ],
      [simaYe, liuCong],
      [
        { dynastyId: "jin-west", top: 80, records: [simaYe], color: COLOR_VALUES.stone },
        { dynastyId: "han-zhao", top: 200, records: [liuCong], color: COLOR_VALUES.cinnabar },
      ],
      jinViewport,
      new Map([
        ["sima-ye", "司马邺"],
        ["liu-cong", "刘聪"],
      ]),
    );
    expect(placed).toHaveLength(1);
    expect(placed[0]?.color).toBe(COLOR_VALUES.stone);
    expect(placed[0]?.color).not.toBe(COLOR_VALUES.gold);
    expect(placed[0]?.tickX).toBe(placed[0]?.originX);
  });

  it("anchors fate lines on system missing-ruler gap cards", () => {
    const missing: Reign = {
      id: "reign-missing-zhou-guo-east--360",
      dynastyId: "zhou-guo-east",
      personId: "system-missing-ruler",
      title: "史料缺",
      eraNames: [],
      start: { year: -360, month: 1 },
      end: { year: -249, month: 12 },
      startAbs: absMonth(-360, 1),
      endAbs: absMonth(-249, 12),
      precision: "year",
    };
    const zhuangxiang: Reign = {
      id: "reign-qin-r29-qin",
      dynastyId: "qin",
      personId: "qin-r29",
      title: "秦庄襄王",
      eraNames: [],
      start: { year: -249, month: 1 },
      end: { year: -247, month: 12 },
      startAbs: absMonth(-249, 1),
      endAbs: absMonth(-247, 12),
      precision: "year",
    };
    const fateViewport = {
      ...viewport,
      centerAbs: absMonth(-249, 6),
      startAbs: absMonth(-249, 6) - 150,
      endAbs: absMonth(-249, 6) + 150,
    };
    const placed = layoutReignFates(
      [
        {
          id: "rel-missing-zhou-guo-east-qin-r29-killed",
          fromRef: "reign:reign-missing-zhou-guo-east--360",
          toRef: "person:qin-r29",
          kind: "killed",
          atAbs: absMonth(-249, 12),
          precision: "year",
        },
      ],
      [missing, zhuangxiang],
      [
        {
          dynastyId: "zhou-guo-east",
          top: 80,
          records: [missing],
          color: COLOR_VALUES.mineral,
        },
        {
          dynastyId: "qin",
          top: 140,
          records: [zhuangxiang],
          color: COLOR_VALUES.cinnabar,
        },
      ],
      fateViewport,
      new Map([
        ["system-missing-ruler", "史料缺"],
        ["qin-r29", "嬴子楚"],
      ]),
    );
    expect(placed).toHaveLength(1);
    expect(placed[0]?.tooltip).toContain("史料缺");
    expect(placed[0]?.tooltip).toContain("被杀");
    const xs = pathCoords(placed[0]!.path).map((point) => point.x);
    expect(Math.max(...xs) - Math.min(...xs)).toBeLessThan(3);
  });

  it("returns empty when receiver reign is missing from lanes", () => {
    const relation: Relation = {
      id: "rel-han-r10-ying-zheng-surrender",
      fromRef: "person:han-r10",
      toRef: "person:ying-zheng",
      kind: "surrender",
      atAbs: absMonth(-230, 12),
    };
    const placed = layoutReignFates(
      [relation],
      [hanLast, yingZhengQin],
      [{ dynastyId: "han-warring", top: 80, records: [hanLast], color: COLOR_VALUES.grape }],
      viewport,
      new Map(),
    );
    expect(placed).toHaveLength(0);
  });
});
