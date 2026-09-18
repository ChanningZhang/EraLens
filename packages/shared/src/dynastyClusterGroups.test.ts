import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import type { Dynasty, DynastyGroup } from "./schema";
import {
  clusterFramesForLanes,
  compareTimedOrder,
  orderDynastiesForLanes,
} from "./dynastyClusterGroups";

function dynasty(
  id: string,
  startAbs: number,
  endAbs: number,
  groupId?: string,
): Dynasty {
  const startYear = startAbs > 0 ? Math.floor(startAbs / 12) : -Math.floor(-startAbs / 12);
  return {
    id,
    name: id,
    altNames: [],
    scope: "cn",
    region: "east_asia",
    start: { year: startYear, month: 1 },
    end: { year: startYear + 1, month: 12 },
    startAbs,
    endAbs,
    precision: "year",
    colorToken: "ochre",
    groupId,
  };
}

function group(
  id: string,
  startAbs: number,
  endAbs: number,
  name = id,
): DynastyGroup {
  const startYear = startAbs > 0 ? Math.floor(startAbs / 12) : -Math.floor(-startAbs / 12);
  return {
    id,
    name,
    altNames: [],
    scope: "cn",
    start: { year: startYear, month: 1 },
    end: { year: startYear + 1, month: 12 },
    startAbs,
    endAbs,
    precision: "year",
  };
}

describe("dynastyClusterGroups", () => {
  it("orders cluster units by group span, not member min startAbs", () => {
    const dynastyGroups = [
      group("shiguo", absMonth(907), absMonth(979, 12), "十国"),
      group("wudai", absMonth(907), absMonth(960, 12), "五代"),
    ];
    const dynasties = [
      dynasty("wu-shi", absMonth(902), absMonth(937), "shiguo"),
      dynasty("liang-hou", absMonth(907), absMonth(923), "wudai"),
      dynasty("tang", absMonth(618), absMonth(907)),
    ];

    const ordered = orderDynastiesForLanes(dynasties, dynastyGroups);
    expect(ordered.map((item) => item.id)).toEqual([
      "tang",
      "liang-hou",
      "wu-shi",
    ]);
  });

  it("keeps cluster members contiguous and sorted by startAbs", () => {
    const dynastyGroups = [group("nan-chao", absMonth(420), absMonth(589, 12), "南朝")];
    const dynasties = [
      dynasty("chen-nan", absMonth(557), absMonth(589), "nan-chao"),
      dynasty("song-liu", absMonth(420, 7), absMonth(479), "nan-chao"),
      dynasty("qi-nan", absMonth(479), absMonth(502), "nan-chao"),
      dynasty("xiliang", absMonth(555), absMonth(587), "nan-chao"),
      dynasty("sui", absMonth(581), absMonth(618)),
    ];

    const ordered = orderDynastiesForLanes(dynasties, dynastyGroups);
    expect(ordered.map((item) => item.id)).toEqual([
      "song-liu",
      "qi-nan",
      "xiliang",
      "chen-nan",
      "sui",
    ]);
  });

  it("uses shorter endAbs to order units with the same startAbs", () => {
    expect(
      compareTimedOrder(
        { id: "bei-chao", startAbs: absMonth(420), endAbs: absMonth(581, 12) },
        { id: "nan-chao", startAbs: absMonth(420), endAbs: absMonth(589, 12) },
      ),
    ).toBeLessThan(0);
  });

  it("wraps the left-rail dynasty chips, not the time-axis lane", () => {
    const dynastyGroups = [group("wudai", absMonth(907), absMonth(960, 12), "五代")];
    const frames = clusterFramesForLanes(
      [
        {
          dynasty: { id: "liang-hou", groupId: "wudai" },
          top: 120,
          height: 64,
          chipTop: 130,
          chipHeight: 44,
        },
        {
          dynasty: { id: "tang-hou", groupId: "wudai" },
          top: 184,
          height: 64,
          chipTop: 194,
          chipHeight: 44,
        },
      ],
      dynastyGroups,
    );

    expect(frames).toHaveLength(1);
    expect(frames[0]?.group.name).toBe("五代");
    expect(frames[0]?.left).toBe(7);
    expect(frames[0]?.width).toBe(90);
    expect(frames[0]?.top).toBe(119);
    expect(frames[0]?.height).toBe(124);
  });
});
