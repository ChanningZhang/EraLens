import { describe, expect, it } from "vitest";
import { absMonth, type DynastyLaneGroup, type Reign } from "@eralens/shared";
import { dynastyLaneHeightForViewport, prepareLaneReignGeometry } from "./reignClusters";

function ruler(id: string, startDay: number, endDay: number): Reign {
  return {
    id, dynastyId: "d", personId: id, title: "临时执政者", eraNames: [],
    start: { year: 1912, month: 1, day: startDay, confidence: "day" },
    end: { year: 1912, month: 1, day: endDay, confidence: "day" },
    startAbs: absMonth(1912, 1), endAbs: absMonth(1912, 1), precision: "day",
  };
}

describe("lane geometry across zoom frames", () => {
  it("reuses static layout while recalculating captions without changing previous frames", () => {
    const reigns = [ruler("a", 1, 2), ruler("b", 3, 4), ruler("c", 5, 6)];
    const groups: DynastyLaneGroup[] = [];
    const base = prepareLaneReignGeometry(reigns, groups);
    const narrow = prepareLaneReignGeometry(reigns, groups, 40, 1);
    const snapshot = [...narrow.byId].map(([id, geometry]) => [id, { ...geometry }]);
    expect([...narrow.byId.values()].some((geometry) => geometry.captionRow > 0)).toBe(true);
    const wide = prepareLaneReignGeometry(reigns, groups, 40, 1000);

    expect(narrow.items).toBe(base.items);
    expect(wide.items).toBe(base.items);
    expect([...wide.byId.values()].every((geometry) => geometry.captionRow === 0)).toBe(true);
    expect([...base.byId.values()].every((geometry) => geometry.captionRow === 0)).toBe(true);
    expect([...narrow.byId]).toEqual(snapshot);
    expect(prepareLaneReignGeometry(reigns, groups, 40, 1)).toEqual(narrow);
    for (const reign of reigns) {
      expect(wide.byId.get(reign.id)?.visualStart).toBe(narrow.byId.get(reign.id)?.visualStart);
      expect(wide.byId.get(reign.id)?.visualEndExclusive).toBe(narrow.byId.get(reign.id)?.visualEndExclusive);
    }
  });

  it("invalidates static layout for new data, grouping, and row height", () => {
    const reigns = [ruler("a", 1, 2), ruler("b", 3, 4)];
    const groups: DynastyLaneGroup[] = [];
    const base = prepareLaneReignGeometry(reigns, groups, 40);
    const revised = [{ ...reigns[0]!, end: { ...reigns[0]!.end, day: 1 } }, reigns[1]!];
    const next = prepareLaneReignGeometry(revised, groups, 40);
    expect(next.items).not.toBe(base.items);
    expect(next.byId.get("a")!.visualEndExclusive).toBeLessThan(base.byId.get("a")!.visualEndExclusive);
    expect(prepareLaneReignGeometry(reigns, [...groups], 40).items).not.toBe(base.items);
    expect(prepareLaneReignGeometry(reigns, groups, 32).byId.get("a")!.unitHeight).toBe(32);
  });

  it("derives lane height from the same geometry used to paint cards", () => {
    const reigns = [ruler("a", 1, 2), ruler("b", 3, 4), ruler("c", 5, 6)];
    const groups: DynastyLaneGroup[] = [];
    const names = new Map<string, string>();
    for (const pxPerMonth of [1, 10, 1000, 1]) {
      const viewport = { centerAbs: absMonth(1912, 1), pxPerMonth, widthPx: 390 };
      const geometry = prepareLaneReignGeometry(reigns, groups, 40, pxPerMonth, names);
      const height = dynastyLaneHeightForViewport(reigns, groups, viewport, names, new Map(), geometry);
      expect(height).toBe(12 + geometry.paintedBottom);
      expect(height).toBe(dynastyLaneHeightForViewport(reigns, groups, viewport, names, new Map()));
      expect(height).toBeGreaterThanOrEqual(12 + geometry.barHeight);
    }
  });

  it("keeps joint rulers and merged dynasty phases separate after a grouping revision", () => {
    const reigns = [ruler("a", 1, 2), ruler("b", 1, 2)];
    const joint = prepareLaneReignGeometry(reigns);
    expect(joint.rowCount).toBe(2);
    expect(joint.byId.get("a")!.unitHeight).toBe(20);
    expect(joint.byId.get("b")!.unitTop).toBe(20);
    const phases = [reigns[0]!, { ...reigns[1]!, dynastyId: "successor" }];
    const ungrouped = prepareLaneReignGeometry(phases);
    const groups: DynastyLaneGroup[] = [{
      id: "phases", primaryDynastyId: "d", phaseDynastyIds: ["successor", "d"],
      laneOrderStartAbs: absMonth(1912, 1), laneOrderEndAbs: absMonth(1912, 1),
    }];
    const grouped = prepareLaneReignGeometry(phases, groups);
    expect(ungrouped.rowCount).toBe(1);
    expect(grouped.items.map(({ reign }) => reign.id)).toEqual(["b", "a"]);
    expect(grouped.rowCount).toBe(1);
    for (const geometry of grouped.byId.values()) {
      expect(geometry.unitHeight).toBe(40);
      expect(geometry.unitTop).toBe(0);
    }
  });
});
