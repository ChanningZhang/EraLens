import { describe, expect, it } from "vitest";
import { EventSchema, absMonth, type Reign } from "@eralens/shared";
import { projectAbs } from "./coordinates";
import {
  compactEventLanes,
  layoutEventBadges,
  layoutPlacedEventBadges,
  eventTargetReign,
  EVENT_LANE_PAD,
  EVENT_MARKER_DOT_OFFSET,
  EVENT_MARKER_VIEW_PAD,
  EVENT_MARKER_WIDTH,
  eventMarkerWidth,
  eventHitInterval,
  filterViewportEvents,
  layoutEvents,
  packEventLanes,
  stickyEventMarkerX,
  eventRailHeight,
} from "./eventLayout";

describe("compactEventLanes", () => {
  it("removes vacated badge rows while retaining collision-free rail placement", () => {
    const atAbs = absMonth(500, 12);
    const viewport = { centerAbs: atAbs, pxPerMonth: 2, widthPx: 1000 };
    const events = ["badge", "rail-a", "rail-b"].map((id) => EventSchema.parse({
      id, name: id, atAbs, precision: "year", dynastyIds: ["d"],
    }));
    const all = layoutEvents(events, viewport);
    const rail = compactEventLanes(all.filter((item) => item.event.id !== "badge"));
    expect(rail.map((item) => item.lane)).toEqual([0, 1]);
  });
});

describe("layoutEventBadges", () => {
  const viewport = { centerAbs: absMonth(-356, 12), pxPerMonth: 3, widthPx: 1000 };
  const dynastyLanes = new Map([
    ["qin", "qin"],
    ["zhou-east", "zhou-west"],
  ]);
  const event = (
    id: string,
    dynastyIds: string[],
    atAbs: number,
    precision: "day" | "month" | "year" | "decade" | "century" = "year",
  ) => EventSchema.parse({ id, name: id, dynastyIds, atAbs, precision });

  it("puts every single-dynasty event on its visible lane, including a merged phase", () => {
    const positions = layoutEventBadges([
      event("reform", ["qin"], absMonth(-356, 12)),
      event("zhou", ["zhou-east"], absMonth(-356, 12)),
      event("battle", ["qin", "zhou-east"], absMonth(-356, 12)),
      event("unmapped", ["unknown"], absMonth(-356, 12)),
    ], viewport, dynastyLanes);
    expect(positions.get("reform")?.laneId).toBe("qin");
    expect(positions.get("zhou")?.laneId).toBe("zhou-west");
    expect(positions.has("battle")).toBe(false);
    expect(positions.has("unmapped")).toBe(false);
  });

  it("keeps span and circa events in the event area even when they belong to one dynasty", () => {
    const at = absMonth(-356, 12);
    const point = event("point", ["qin"], at);
    const ranged = (id: string, timeMode: "span" | "circa") => EventSchema.parse({
      id,
      name: id,
      dynastyIds: ["qin"],
      timeMode,
      startAbs: at - 12,
      endAbs: at + 12,
      atAbs: at,
    });
    const positions = layoutEventBadges([
      ranged("span", "span"),
      ranged("circa", "circa"),
      point,
    ], viewport, dynastyLanes);

    expect([...positions.keys()]).toEqual(["point"]);
    expect(positions.get("point")?.anchorX).toBe(projectAbs(viewport, at));
  });

  it("keeps the most precise overlapping badge at its time and uses the opposite edge for conflicts", () => {
    const at = absMonth(-356, 12);
    const imprecise = event("imprecise", ["qin"], at - 2, "year");
    const precise = event("precise", ["qin"], at, "day");
    const month = event("month", ["qin"], at, "month");
    const positions = layoutEventBadges([imprecise, month, precise], viewport, dynastyLanes);
    expect(positions.get("precise")!.anchorX).toBe(projectAbs(viewport, at));
    expect(positions.get("precise")!.edge).toBe("top");
    expect(positions.get("month")!.edge).toBe("bottom");
    expect(positions.get("month")!.anchorX).toBe(projectAbs(viewport, at));
    expect(positions.has("imprecise")).toBe(false);
  });

  it("keeps separate badges near their own dates", () => {
    const early = absMonth(-356, 12);
    const late = absMonth(-350, 12);
    const positions = layoutEventBadges([
      event("early", ["qin"], early),
      event("late", ["qin"], late),
    ], viewport, dynastyLanes);
    expect(positions.get("early")!.anchorX).toBe(projectAbs(viewport, early));
    expect(positions.get("late")!.anchorX).toBe(projectAbs(viewport, late));
  });

  it("reserves a later high-precision badge and moves a conflicting earlier badge below", () => {
    const placed = [
      { id: "early", anchorX: 10, precision: "year" as const },
      { id: "middle", anchorX: 80, precision: "year" as const },
      { id: "precise", anchorX: 190, precision: "month" as const },
    ].map(({ id, anchorX, precision }) => ({
      event: event(id, ["qin"], absMonth(-356, 12), precision),
      anchorX,
      markerWidth: 100,
      lane: 0,
      showBand: false,
      bandLeft: 0,
      bandWidth: 0,
      top: 0,
    }));
    const positions = layoutPlacedEventBadges(placed, dynastyLanes);

    expect(positions.get("precise")?.anchorX).toBe(190);
    expect(positions.get("precise")?.edge).toBe("top");
    expect(positions.get("early")?.edge).toBe("top");
    expect(positions.get("middle")?.edge).toBe("bottom");
    expect(positions.get("middle")?.anchorX).toBe(80);
  });
});

describe("filterViewportEvents", () => {
  const viewport = { centerAbs: absMonth(-845, 12), pxPerMonth: 2, widthPx: 1000, gutterPx: 100 };
  const point = (id: string, year: number) => EventSchema.parse({
    id,
    name: id,
    atAbs: absMonth(year, 12),
    precision: "year",
  });

  it("excludes events returned by neighboring query chunks when their marks are off-screen", () => {
    const current = point("current", -845);
    const future = point("future", -770);
    const past = point("past", -900);

    expect(filterViewportEvents([past, current, future], viewport).map((event) => event.id))
      .toEqual(["current"]);
  });

  it("keeps a span while its band is visible after its date label passes the edge", () => {
    const span = EventSchema.parse({
      id: "long-span",
      name: "long-span",
      timeMode: "span",
      precision: "year",
      startAbs: absMonth(-900, 1),
      endAbs: absMonth(-830, 12),
    });

    expect(filterViewportEvents([span], viewport)).toEqual([span]);
  });
});

describe("approximate events", () => {
  it("use the same vertical lane packing as other point events", () => {
    const at = absMonth(-138, 12);
    const events = ["胡瓜传入", "石榴传入", "核桃传入", "胡蒜传入", "胡荽传入", "胡麻传入", "胡椒传入", "豌豆传入"].map((name, index) =>
      EventSchema.parse({
        id: `crop-${index}`,
        name,
        atAbs: at,
        precision: "year",
        isApproximate: true,
      }),
    );
    const viewport = { centerAbs: at, pxPerMonth: 3, widthPx: 1200 };
    const placed = layoutEvents(events, viewport);

    expect(new Set(placed.map((item) => item.anchorX))).toEqual(new Set([projectAbs(viewport, at)]));
    expect(new Set(placed.map((item) => item.lane)).size).toBe(events.length);
  });
});

describe("eventRailHeight", () => {
  it("reserves the full height for all event lanes", () => {
    expect(eventRailHeight(8)).toBeGreaterThan(eventRailHeight(6));
  });
});

describe("eventTargetReign", () => {
  const startAbs = absMonth(-770, 1);
  const endAbs = absMonth(-750, 12);
  const reign = (id: string, personId: string): Reign => ({
    id,
    personId,
    dynastyId: "zhou-east",
    title: "",
    start: { year: -770, month: 1 },
    end: { year: -750, month: 12 },
    startAbs,
    endAbs,
    precision: "year",
    eraNames: [],
  });
  const ping = reign("reign-ji-yijiu", "ji-yijiu");
  const xie = { ...reign("reign-ji-yuchen", "ji-yuchen"), claimTrack: "xie" };

  it("resolves a dated participant to the parallel claimant card", () => {
    const event = EventSchema.parse({
      id: "xie-wang-killed",
      name: "晋文侯杀携王",
      atAbs: endAbs,
      dynastyIds: ["zhou-east"],
      participantIds: ["ji-yuchen"],
    });
    expect(eventTargetReign(event, [ping, xie])?.id).toBe(xie.id);
    expect(eventTargetReign({ ...event, participantIds: ["ji-yijiu", "ji-yuchen"] }, [ping, xie])).toBeNull();
  });
});

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
      x - EVENT_MARKER_DOT_OFFSET + eventMarkerWidth(event.name) + EVENT_LANE_PAD,
    );
  });

  it("lets short, visually separate labels share a lane", () => {
    const guiSuiShou = EventSchema.parse({
      id: "poetry-gui-sui-shou",
      name: "龟虽寿",
      kind: "poetry",
      timeMode: "circa",
      precision: "year",
      start: { year: 207, month: 1 },
      end: { year: 210, month: 12 },
      startAbs: absMonth(207, 1),
      endAbs: absMonth(210, 12),
    });
    const liuBeiTakesYizhou = EventSchema.parse({
      id: "liu-bei-takes-yizhou",
      name: "刘备取益州",
      kind: "politics",
      precision: "year",
      at: { year: 214, month: 12 },
      atAbs: absMonth(214, 12),
    });

    const placed = layoutEvents([guiSuiShou, liuBeiTakesYizhou], viewport);
    expect(placed[0]?.lane).toBe(0);
    expect(placed[1]?.lane).toBe(0);
    expect(eventMarkerWidth(guiSuiShou.name)).toBeLessThan(EVENT_MARKER_WIDTH);
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
