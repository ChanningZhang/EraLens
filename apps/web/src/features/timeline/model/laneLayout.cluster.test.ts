import { describe, expect, it } from "vitest";
import { absMonth, orderDynastiesForLanes, type Dynasty, type DynastyGroup } from "@eralens/shared";
import { assignLanes } from "./laneLayout";

function dynasty(id: string, startYear: number, endYear: number, groupId?: string): Dynasty {
  return {
    id,
    name: id,
    altNames: [],
    scope: "cn",
    region: "east_asia",
    start: { year: startYear, month: 1 },
    end: { year: endYear, month: 12 },
    startAbs: absMonth(startYear),
    endAbs: absMonth(endYear, 12),
    precision: "year",
    colorToken: "ochre",
    groupId,
  };
}

function dynastyGroup(
  id: string,
  name: string,
  startYear: number,
  endYear: number,
): DynastyGroup {
  return {
    id,
    name,
    altNames: [],
    scope: "cn",
    start: { year: startYear, month: 1 },
    end: { year: endYear, month: 12 },
    startAbs: absMonth(startYear),
    endAbs: absMonth(endYear, 12),
    precision: "year",
  };
}

describe("assignLanes with cluster groups", () => {
  it("places wudai above shiguo when both start in 907", () => {
    const dynastyGroups = [
      dynastyGroup("shiguo", "十国", 907, 979),
      dynastyGroup("wudai", "五代", 907, 960),
    ];
    const dynasties = [
      dynasty("wu-shi", 902, 937, "shiguo"),
      dynasty("liang-hou", 907, 923, "wudai"),
      dynasty("wuyue", 907, 978, "shiguo"),
    ];

    const placed = assignLanes(orderDynastiesForLanes(dynasties, dynastyGroups));
    expect(placed.map((item) => item.id)).toEqual(["liang-hou", "wu-shi", "wuyue"]);
    expect(placed.map((item) => item.lane)).toEqual([0, 1, 2]);
  });
});
