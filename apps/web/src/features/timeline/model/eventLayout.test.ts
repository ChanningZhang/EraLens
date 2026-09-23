import { describe, expect, it } from "vitest";
import { EventSchema, absMonth } from "@eralens/shared";
import { projectAbs } from "./coordinates";
import {
  EVENT_LANE_PAD,
  EVENT_MARKER_DOT_OFFSET,
  EVENT_MARKER_VIEW_PAD,
  EVENT_MARKER_WIDTH,
  eventHitInterval,
  layoutEvents,
  packEventLanes,
  stickyEventMarkerX,
} from "./eventLayout";

describe("packEventLanes", () => {
  it("keeps non-overlapping items on one lane", () => {
    const lanes = packEventLanes([
      { id: "a", left: 0, right: 40 },
      { id: "b", left: 40, right: 80 },
    ]);
    expect(lanes.get("a")).toBe(0);
    expect(lanes.get("b")).toBe(0);
  });

  it("moves overlapping items to another lane", () => {
    const lanes = packEventLanes([
      { id: "wide", left: 0, right: 400 },
      { id: "mid", left: 120, right: 180 },
    ]);
    expect(lanes.get("wide")).toBe(0);
    expect(lanes.get("mid")).toBe(1);
  });
});

describe("layoutEvents", () => {
  const viewport = { centerAbs: absMonth(208, 1), pxPerMonth: 1.5, widthPx: 1200 };

  it("does not place point events on a circa band they overlap", () => {
    const circa = EventSchema.parse({
      id: "jianan-literature",
      name: "建安文学",
      timeMode: "circa",
      precision: "decade",
      start: { year: 196, month: 1 },
      end: { year: 220, month: 12 },
      startAbs: absMonth(196, 1),
      endAbs: absMonth(220, 12),
      at: { year: 215, month: 1 },
      atAbs: absMonth(215, 1),
    });
    const chibi = EventSchema.parse({
      id: "chibi",
      name: "赤壁之战",
      precision: "month",
      at: { year: 208, month: 12 },
      atAbs: absMonth(208, 12),
    });
    const yiling = EventSchema.parse({
      id: "yiling",
      name: "夷陵之战",
      timeMode: "span",
      precision: "month",
      start: { year: 221, month: 7 },
      end: { year: 222, month: 8 },
      startAbs: absMonth(221, 7),
      endAbs: absMonth(222, 8),
    });

    const placed = layoutEvents([circa, chibi, yiling], viewport);
    const byId = Object.fromEntries(placed.map((item) => [item.event.id, item]));

    expect(byId["jianan-literature"]?.showBand).toBe(true);
    expect(byId["chibi"]?.lane).not.toBe(byId["jianan-literature"]?.lane);
    expect(byId["yiling"]?.lane).not.toBe(byId["jianan-literature"]?.lane);

    const band = eventHitInterval(circa, viewport);
    const chibiHit = eventHitInterval(chibi, viewport);
    expect(chibiHit.left < band.right && chibiHit.right > band.left).toBe(true);
  });

  it("extends a point-event pill to the right of the time anchor", () => {
    const event = EventSchema.parse({
      id: "wei-founded",
      name: "曹丕称帝",
      timeMode: "point",
      precision: "month",
      at: { year: 220, month: 12 },
      atAbs: absMonth(220, 12),
    });
    const x = projectAbs(viewport, event.atAbs!);
    const hit = eventHitInterval(event, viewport);

    expect(hit.left).toBe(x - EVENT_MARKER_DOT_OFFSET - EVENT_LANE_PAD);
    expect(hit.right).toBe(
      x - EVENT_MARKER_DOT_OFFSET + EVENT_MARKER_WIDTH + EVENT_LANE_PAD,
    );
  });

  it("uses a circa poem's anchor without displaying its time band", () => {
    const poem = EventSchema.parse({
      id: "poetry-fengqiao-yebo",
      name: "《枫桥夜泊》",
      kind: "poetry",
      timeMode: "circa",
      precision: "year",
      start: { year: 750, month: 1 },
      end: { year: 770, month: 12 },
      startAbs: absMonth(750, 1),
      endAbs: absMonth(770, 12),
    });

    const placed = layoutEvents([poem], viewport)[0]!;

    expect(placed.showBand).toBe(false);
    expect(placed.anchorX).toBe(projectAbs(viewport, (poem.startAbs! + poem.endAbs!) / 2));
  });
});

describe("stickyEventMarkerX", () => {
  const viewportWidth = 1000;
  const pad = EVENT_MARKER_VIEW_PAD;
  const viewLeft = pad;
  const viewRight = viewportWidth - pad;
  const maxPillLeft = viewRight - EVENT_MARKER_WIDTH;

  it("keeps the natural anchor when the pill is on-page and on the band", () => {
    const x = stickyEventMarkerX({
      anchorX: 400,
      bandLeft: 100,
      bandWidth: 600,
      viewportWidth,
    });
    expect(x).toBe(400);
  });

  it("pins to the left of the remaining band when the name has left the page", () => {
    const x = stickyEventMarkerX({
      anchorX: -800,
      bandLeft: -2000,
      bandWidth: 5000,
      viewportWidth,
    });
    expect(x).toBe(viewLeft + EVENT_MARKER_DOT_OFFSET);
  });

  it("pins to the left of the viewport when the name is still to the right of the page", () => {
    const x = stickyEventMarkerX({
      anchorX: 2400,
      bandLeft: -2000,
      bandWidth: 5000,
      viewportWidth,
    });
    expect(x).toBe(viewLeft + EVENT_MARKER_DOT_OFFSET);
  });

  it("keeps the full name on-page when only a right-side sliver of the band remains", () => {
    const x = stickyEventMarkerX({
      anchorX: 200,
      bandLeft: 960,
      bandWidth: 80,
      viewportWidth,
    });
    const pillLeft = x - EVENT_MARKER_DOT_OFFSET;
    expect(pillLeft).toBe(maxPillLeft);
    expect(pillLeft + EVENT_MARKER_WIDTH).toBeLessThanOrEqual(viewRight);
    expect(pillLeft + EVENT_MARKER_WIDTH).toBeGreaterThan(960);
  });

  it("pins sticky labels to the rail edge when a gutter is reserved", () => {
    const x = stickyEventMarkerX({
      anchorX: -800,
      bandLeft: -2000,
      bandWidth: 5000,
      viewportWidth: 1000,
      gutter: 102,
    });
    expect(x).toBe(102 + EVENT_MARKER_VIEW_PAD + EVENT_MARKER_DOT_OFFSET);
  });

  it("leaves an off-screen band at its natural position", () => {
    const x = stickyEventMarkerX({
      anchorX: -400,
      bandLeft: -500,
      bandWidth: 40,
      viewportWidth,
    });
    expect(x).toBe(-400);
  });
});

describe("layoutEvents sticky labels", () => {
  it("keeps a long circa label on-page while the gray band is still visible", () => {
    const viewport = { centerAbs: absMonth(-300, 1), pxPerMonth: 1.5, widthPx: 1200 };
    const baijia = EventSchema.parse({
      id: "baijia-zhengming",
      name: "百家争鸣",
      timeMode: "circa",
      precision: "century",
      start: { year: -551, month: 1 },
      end: { year: -221, month: 12 },
      startAbs: absMonth(-551, 1),
      endAbs: absMonth(-221, 12),
      at: { year: -400, month: 1 },
      atAbs: absMonth(-400, 1),
    });

    const placed = layoutEvents([baijia], viewport)[0]!;
    const pillLeft = placed.anchorX - EVENT_MARKER_DOT_OFFSET;
    const pillRight = pillLeft + EVENT_MARKER_WIDTH;

    expect(placed.showBand).toBe(true);
    expect(placed.bandLeft).toBeLessThan(0);
    expect(placed.bandLeft + placed.bandWidth).toBeGreaterThan(viewport.widthPx);
    expect(pillLeft).toBeGreaterThanOrEqual(EVENT_MARKER_VIEW_PAD);
    expect(pillRight).toBeLessThanOrEqual(viewport.widthPx - EVENT_MARKER_VIEW_PAD);
  });

  it("does not move a point-event pill", () => {
    const viewport = { centerAbs: absMonth(220, 1), pxPerMonth: 1.5, widthPx: 1200 };
    const event = EventSchema.parse({
      id: "wei-founded",
      name: "曹丕称帝",
      timeMode: "point",
      precision: "month",
      at: { year: 220, month: 12 },
      atAbs: absMonth(220, 12),
    });
    const placed = layoutEvents([event], viewport)[0]!;
    expect(placed.anchorX).toBe(projectAbs(viewport, event.atAbs!));
  });
});
