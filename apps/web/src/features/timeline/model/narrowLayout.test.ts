import { afterEach, describe, expect, it } from "vitest";
import { DEFAULT_TIMELINE_LAYOUT_PREFERENCES, clusterFramesForLanes, fromAbsMonth, resolveTimelinePresentation, type Dynasty, type Reign } from "@eralens/shared";
import { viewportStore } from "../state/viewportStore";
import { absFromStageX, centerGuideX } from "./coordinates";
import { layoutLaneReignBar } from "./reignCardLayout";
import { dynastyLaneHeightForViewport, prepareLaneReignGeometry } from "./reignClusters";
import { resolveReignBarLayout } from "./lod";

function reign(id: string, claimTrack?: string): Reign {
  const start = fromAbsMonth(12);
  const end = fromAbsMonth(131);
  return {
    id, dynastyId: "d", personId: id, title: "国君", eraNames: [],
    start: { ...start, confidence: "month" }, end: { ...end, confidence: "month" },
    startAbs: 12, endAbs: 131, precision: "year", claimTrack,
  };
}

afterEach(() => {
  viewportStore.setLayoutPreferences(DEFAULT_TIMELINE_LAYOUT_PREFERENCES);
  viewportStore.setWidthPx(1200);
  viewportStore.setCenterAbs(2400);
  viewportStore.setPxPerMonth(1.5);
});

describe("narrow timeline layout", () => {
  it("expands the visible time range without changing center or time scale while preserving the explicit rail setting", () => {
    viewportStore.setWidthPx(402);
    viewportStore.setCenterAbs(-2400);
    const before = viewportStore.getSnapshot();
    viewportStore.setLayoutPreferences({ railCollapsed: true, density: "auto" });
    const folded = viewportStore.getSnapshot();
    expect(folded.centerAbs).toBe(before.centerAbs);
    expect(folded.pxPerMonth).toBe(before.pxPerMonth);
    expect(folded.endAbs - folded.startAbs).toBeGreaterThan(before.endAbs - before.startAbs);
    expect(absFromStageX(folded, centerGuideX(folded))).toBeCloseTo(folded.centerAbs);
    viewportStore.setWidthPx(820);
    expect(viewportStore.getSnapshot().presentation.railCollapsed).toBe(true);
    expect(viewportStore.getSnapshot().gutterPx).toBe(12);
    viewportStore.setWidthPx(402);
    expect(viewportStore.getSnapshot().presentation.railCollapsed).toBe(true);
  });

  it("keeps card widths and fate anchors consistent for main, rival and missing records in either density", () => {
    const rulers = [reign("main"), reign("rival", "rival")];
    const missing = { ...reign("missing"), personId: "system-missing-ruler" };
    const widths: number[] = [];
    for (const density of ["comfortable", "compact"] as const) {
      const presentation = resolveTimelinePresentation(375, { railCollapsed: false, density });
      const viewport = { centerAbs: 72, widthPx: 375, gutterPx: presentation.gutterPx, pxPerMonth: 2, presentation };
      const prepared = prepareLaneReignGeometry(rulers, presentation.rowHeightPx);
      for (const ruler of rulers) {
        const cached = layoutLaneReignBar(ruler, "d", rulers, viewport, 50, ruler.title, null, prepared.byId.get(ruler.id))!;
        expect(cached).toEqual(layoutLaneReignBar(ruler, "d", rulers, viewport, 50, ruler.title));
        expect(cached.barHeight).toBe(prepared.byId.get(ruler.id)!.unitHeight);
      }
      const gap = layoutLaneReignBar(missing, "d", rulers, viewport, 50)!;
      const main = layoutLaneReignBar(rulers[0]!, "d", rulers, viewport, 50)!;
      expect(gap.barTop).toBe(main.barTop);
      expect(gap.barHeight).toBe(main.barHeight);
      widths.push(main.barRight - main.barLeft);
    }
    expect(widths[0]).toBe(widths[1]);
  });

  it("reserves captions below short bars while reducing plain lane height", () => {
    const ruler = reign("ruler");
    const presentation = resolveTimelinePresentation(375);
    const viewport = { centerAbs: 72, widthPx: 375, pxPerMonth: 2, presentation };
    expect(dynastyLaneHeightForViewport([ruler], viewport, new Map(), new Map())).toBe(40);
    const short = { ...ruler, endAbs: 12 };
    expect(dynastyLaneHeightForViewport([short], viewport, new Map(), new Map())).toBeGreaterThan(40);
    expect(resolveReignBarLayout(30, 4, 18).captionBelow).toBe(true);
  });

  it("fits dynasty group frames inside the responsive rail", () => {
    for (const widthPx of [320, 375, 600, 820]) {
      const presentation = resolveTimelinePresentation(widthPx);
      const frame = clusterFramesForLanes([
        { dynasty: { id: "d", groupId: "g" } as Dynasty, chipTop: 20, chipHeight: 36, top: 12, height: 44 },
      ], [{ id: "g", name: "并立", startAbs: 12, endAbs: 131 }], {
        insetPx: presentation.railInsetPx, labelWidthPx: presentation.railLabelWidthPx,
      })[0]!;
      expect(frame.left).toBeGreaterThanOrEqual(0);
      expect(frame.left + frame.width).toBeLessThan(presentation.gutterPx);
    }
  });
});
