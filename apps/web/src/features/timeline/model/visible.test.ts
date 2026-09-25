import { describe, expect, it } from "vitest";
import type { Reign } from "@eralens/shared";
import { prepareLaneReignGeometry, resolveReignVisualSpan } from "./reignClusters";
import { filterVisibleCardReigns, filterVisibleGapReigns, filterVisiblePlacedPersons } from "./visible";

function reign(id: string, startAbs: number, endAbs: number): Reign {
  return {
    id, dynastyId: "d", personId: id, title: id, eraNames: [],
    start: { year: 1, month: 1 }, end: { year: 1, month: 12 },
    startAbs, endAbs, precision: "year",
  };
}

describe("viewport card mounting", () => {
  it("uses ownership-adjusted visual spans and keeps boundary cards in overscan", () => {
    const first = reign("first", 0, 24);
    const second = reign("second", 24, 48);
    const far = reign("far", 1000, 1011);
    const all = [first, second, far];
    const prepared = prepareLaneReignGeometry(all);
    expect(prepared.byId.get(first.id)?.endExclusive).toBe(resolveReignVisualSpan(first, all).endExclusive);
    expect(filterVisibleCardReigns(all, prepared.byId, 24, 48, 2).map((item) => item.id))
      .toEqual(["first", "second"]);
    expect(filterVisibleCardReigns(all, prepared.byId, 500, 600, 2)).toEqual([]);
  });

  it("mounts missing cards and person labels before they enter the viewport", () => {
    const near = reign("near", -40, -20);
    const far = reign("far", -1000, -900);
    expect(filterVisibleGapReigns([near, far], 0, 100, 2)).toEqual([near]);
    const persons = [
      { left: -100, width: 20 },
      { left: -500, width: 20 },
      { left: 1100, width: 20 },
    ];
    expect(filterVisiblePlacedPersons(persons, 1000, 100)).toEqual([persons[0], persons[2]]);
  });
});
