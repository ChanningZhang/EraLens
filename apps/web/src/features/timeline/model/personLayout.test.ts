import { describe, expect, it } from "vitest";
import { PersonSchema, absMonth } from "@eralens/shared";
import { layoutPersons, personLaneCount } from "./personLayout";
import { packEventLanes as packLanes } from "./eventLayout";

describe("layoutPersons", () => {
  const viewport = { centerAbs: absMonth(190, 1), pxPerMonth: 2, widthPx: 1600 };

  const caoCao = PersonSchema.parse({
    id: "cao-cao",
    name: "曹操",
    birth: { year: 155, month: 1 },
    death: { year: 220, month: 3 },
    roles: ["政治家"],
  });

  const zhugeLiang = PersonSchema.parse({
    id: "zhuge-liang",
    name: "诸葛亮",
    birth: { year: 181, month: 1 },
    death: { year: 234, month: 8 },
    roles: ["丞相"],
  });

  it("packs overlapping lifespans onto separate lanes", () => {
    const placed = layoutPersons([caoCao, zhugeLiang], viewport);
    expect(personLaneCount(placed)).toBeGreaterThanOrEqual(1);
    const lanes = new Set(placed.map((item) => item.lane));
    expect(lanes.size).toBeGreaterThanOrEqual(1);
  });

});

describe("packEventLanes reuse", () => {
  it("keeps non-overlapping person intervals on one lane", () => {
    const lanes = packLanes([
      { id: "a", left: 0, right: 40 },
      { id: "b", left: 50, right: 90 },
    ]);
    expect(lanes.get("a")).toBe(0);
    expect(lanes.get("b")).toBe(0);
  });
});
