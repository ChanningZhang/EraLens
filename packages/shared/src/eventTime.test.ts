import { describe, expect, it } from "vitest";
import { EventSchema } from "./schema";
import {
  eventSpanAbs,
  formatEventTime,
  shouldShowEventAtLod,
} from "./eventTime";
import { absMonth } from "./time";

function parseEvent(input: Record<string, unknown>) {
  return EventSchema.parse(input);
}

describe("eventSpanAbs", () => {
  it("uses atAbs for point events", () => {
    expect(eventSpanAbs({ atAbs: 2405 })).toEqual({
      startAbs: 2405,
      endAbs: 2405,
      anchorAbs: 2405,
    });
  });

  it("anchors circa events on atAbs when present", () => {
    expect(eventSpanAbs({ startAbs: 100, endAbs: 200, atAbs: 150 })).toEqual({
      startAbs: 100,
      endAbs: 200,
      anchorAbs: 150,
    });
  });

  it("falls back to midpoint when range has no atAbs", () => {
    expect(eventSpanAbs({ startAbs: 100, endAbs: 200 })).toEqual({
      startAbs: 100,
      endAbs: 200,
      anchorAbs: 150,
    });
  });
});

describe("formatEventTime", () => {
  it("omits placeholder months for year-precision points", () => {
    const event = parseEvent({
      id: "guandu",
      name: "官渡之战",
      at: { year: 200, month: 1 },
      atAbs: absMonth(200, 1),
      precision: "year",
    });
    expect(formatEventTime(event)).toBe("公元200年");
  });

  it("keeps month for month-precision points", () => {
    const event = parseEvent({
      id: "chibi",
      name: "赤壁之战",
      at: { year: 208, month: 12 },
      atAbs: absMonth(208, 12),
      precision: "month",
    });
    expect(formatEventTime(event)).toBe("公元208年12月");
  });

  it("formats duration spans", () => {
    const event = parseEvent({
      id: "yiling",
      name: "夷陵之战",
      timeMode: "span",
      precision: "month",
      start: { year: 221, month: 7 },
      end: { year: 222, month: 8 },
      startAbs: absMonth(221, 7),
      endAbs: absMonth(222, 8),
    });
    expect(formatEventTime(event)).toBe("公元221年7月 — 公元222年8月");
  });

  it("prefixes circa ranges with 约", () => {
    const event = parseEvent({
      id: "jianan",
      name: "建安文学",
      timeMode: "circa",
      precision: "decade",
      start: { year: 196, month: 1 },
      end: { year: 220, month: 12 },
      startAbs: absMonth(196, 1),
      endAbs: absMonth(220, 12),
    });
    expect(formatEventTime(event)).toBe("约公元196年 — 公元220年");
  });
});

describe("shouldShowEventAtLod", () => {
  const pointMonth = parseEvent({
    id: "point",
    name: "点",
    at: { year: 200, month: 6 },
    atAbs: absMonth(200, 6),
    precision: "month",
  });
  const circaDecade = parseEvent({
    id: "circa",
    name: "约",
    timeMode: "circa",
    precision: "decade",
    start: { year: 196, month: 1 },
    end: { year: 220, month: 12 },
    startAbs: absMonth(196, 1),
    endAbs: absMonth(220, 12),
  });
  const century = parseEvent({
    id: "century",
    name: "世纪",
    timeMode: "circa",
    precision: "century",
    start: { year: 100, month: 1 },
    end: { year: 200, month: 12 },
    startAbs: absMonth(100, 1),
    endAbs: absMonth(200, 12),
  });

  it("shows all events at decade and month", () => {
    expect(shouldShowEventAtLod(pointMonth, "decade")).toBe(true);
    expect(shouldShowEventAtLod(pointMonth, "month")).toBe(true);
  });

  it("hides precise points at century, keeps circa and coarse precision", () => {
    expect(shouldShowEventAtLod(pointMonth, "century")).toBe(false);
    expect(shouldShowEventAtLod(circaDecade, "century")).toBe(true);
  });

  it("only keeps century-precision events at millennium", () => {
    expect(shouldShowEventAtLod(circaDecade, "millennium")).toBe(false);
    expect(shouldShowEventAtLod(century, "millennium")).toBe(true);
  });
});
