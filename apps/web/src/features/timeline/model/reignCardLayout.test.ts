import { describe, expect, it } from "vitest";
import { absMonth, type Reign } from "@eralens/shared";
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
  it("joins a month-dated end to short successors across zoom levels", () => {
    const dated = (id: string, start: Reign["start"], end: Reign["end"], precision: Reign["precision"]): Reign => ({
      ...reign(id, absMonth(start.year, start.month), absMonth(end.year, end.month)),
      start, end, precision,
    });
    const rulers = [
      dated("older", { year: -676, month: 1, confidence: "year" }, { year: -651, month: 8, confidence: "approximate_month" }, "year"),
      dated("first", { year: -651, month: 8, confidence: "approximate_month" }, { year: -651, month: 9, confidence: "approximate_month" }, "month"),
      dated("second", { year: -651, month: 9, confidence: "approximate_month" }, { year: -651, month: 10, confidence: "approximate_month" }, "month"),
    ];
    for (const pxPerMonth of [1.5, 6, 12]) {
      const viewport = { centerAbs: absMonth(-651, 9), pxPerMonth, widthPx: 1000, gutterPx: 102 };
      const prepared = prepareLaneReignGeometry(rulers);
      const bars = rulers.map((item) => layoutLaneReignBar(item, "d", rulers, viewport, 50, item.title, null, prepared.byId.get(item.id))!);
      expect(bars[0]!.barRight).toBeCloseTo(bars[1]!.barLeft);
      expect(bars[1]!.barRight).toBeCloseTo(bars[2]!.barLeft);
      for (const bar of bars.slice(1)) expect(bar.barRight - bar.barLeft).toBeCloseTo(pxPerMonth);
    }
  });

  it("keeps fate anchors on the same painted bar after pan and zoom", () => {
    const rulers = [reign("a", 0, 35), reign("b", 36, 71)];
    const prepared = prepareLaneReignGeometry(rulers);
    for (const viewport of [
      { centerAbs: 35, pxPerMonth: 2, widthPx: 1000, gutterPx: 102 },
      { centerAbs: 49, pxPerMonth: 5, widthPx: 1000, gutterPx: 102 },
    ]) {
      for (const ruler of rulers) {
        expect(layoutLaneReignBar(ruler, "d", rulers, viewport, 50, ruler.title, null, prepared.byId.get(ruler.id)))
          .toEqual(layoutLaneReignBar(ruler, "d", rulers, viewport, 50, ruler.title));
      }
    }
  });
});
