import { describe, expect, it } from "vitest";
import type { Reign } from "@eralens/shared";
import { layoutLaneReignBar } from "./reignCardLayout";
import { prepareLaneReignGeometry } from "./reignClusters";

function reign(id: string, startAbs: number, endAbs: number): Reign {
  return {
    id, dynastyId: "d", personId: id, title: id, eraNames: [],
    start: { year: 1, month: 1 }, end: { year: 1, month: 12 },
    startAbs, endAbs, precision: "year",
  };
}

describe("prepared reign bar geometry", () => {
  it("keeps fate anchors on the same painted bar after pan and zoom", () => {
    const rulers = [reign("a", 0, 35), reign("b", 36, 71)];
    const prepared = prepareLaneReignGeometry(rulers);
    for (const viewport of [
      { centerAbs: 35, pxPerMonth: 2, widthPx: 1000, gutterPx: 102 },
      { centerAbs: 49, pxPerMonth: 5, widthPx: 1000, gutterPx: 102 },
    ]) {
      for (const ruler of rulers) {
        expect(layoutLaneReignBar(ruler, "d", rulers, viewport, 50, ruler.title, null, [], prepared.byId.get(ruler.id)))
          .toEqual(layoutLaneReignBar(ruler, "d", rulers, viewport, 50, ruler.title));
      }
    }
  });
});
