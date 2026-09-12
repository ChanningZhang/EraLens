import { describe, expect, it } from "vitest";
import { EventSchema, absMonth } from "@eralens/shared";
import { projectAbs } from "./coordinates";
import {
  EVENT_LANE_PAD,
  EVENT_MARKER_DOT_OFFSET,
  EVENT_MARKER_WIDTH,
  eventHitInterval,
  layoutEvents,
  packEventLanes,
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
});
