import { describe, expect, it } from "vitest";
import { EventSchema } from "./schema";
import {
  eventKindLabel,
  eventModeForCalendarDuration,
  eventSpanAbs,
  formatEventTime,
  shouldShowEventAtLod,
} from "./eventTime";
import { absMonth } from "./time";

function parseEvent(input: Record<string, unknown>) {
  return EventSchema.parse(input);
}

describe("eventKindLabel", () => {
  it("maps stored kinds to Chinese labels", () => {
    expect(eventKindLabel("battle")).toBe("军事");
    expect(eventKindLabel("politics")).toBe("政治");
    expect(eventKindLabel("culture")).toBe("文化");
    expect(eventKindLabel("disaster")).toBe("灾害");
    expect(eventKindLabel("poetry")).toBe("诗歌");
    expect(eventKindLabel("other")).toBe("其他");
  });
});

describe("eventSpanAbs", () => {
  it("uses atAbs for point events", () => {
    expect(eventSpanAbs({ atAbs: 2405 })).toEqual({
      startAbs: 2405,
      endAbs: 2405,
      anchorAbs: 2405,
    });
  });

  it("uses an explicit representative point when present", () => {
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
      atConfidence: "approximate_year",
    });
    expect(formatEventTime(event)).toBe("约200年");
  });

  it("keeps month for month-precision points", () => {
    const event = parseEvent({
      id: "chibi",
      name: "赤壁之战",
      at: { year: 208, month: 12, confidence: "month" },
      atAbs: absMonth(208, 12),
      precision: "month",
    });
    expect(formatEventTime(event)).toBe("208年12月");
  });

  it("formats duration spans", () => {
    const event = parseEvent({
      id: "yiling",
      name: "夷陵之战",
      timeMode: "span",
      precision: "month",
      start: { year: 221, month: 7, confidence: "month" },
      end: { year: 222, month: 8, confidence: "month" },
      startAbs: absMonth(221, 7),
      endAbs: absMonth(222, 8),
    });
    expect(formatEventTime(event)).toBe("221年7月 — 222年8月");
  });

  it("formats a point with approximate confidence", () => {
    const event = parseEvent({
      id: "jianan",
      name: "建安文学",
      timeMode: "point",
      at: { year: 196, month: 12 },
      atAbs: absMonth(196, 12),
      atConfidence: "approximate_year",
    });
    expect(formatEventTime(event)).toBe("约196年");
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

  it("shows all events at decade and month", () => {
    expect(shouldShowEventAtLod(pointMonth, "decade")).toBe(true);
    expect(shouldShowEventAtLod(pointMonth, "month")).toBe(true);
  });

  it("keeps all events participating at every LOD", () => {
    expect(shouldShowEventAtLod(pointMonth, "century")).toBe(true);
    expect(shouldShowEventAtLod(pointMonth, "millennium")).toBe(true);
  });
});

describe("eventModeForCalendarDuration", () => {
  it("uses point below the one calendar-year threshold and span at one year", () => {
    expect(eventModeForCalendarDuration(
      { year: 200, month: 1, confidence: "month" },
      { year: 200, month: 12, confidence: "month" },
    )).toBe("point");
    expect(eventModeForCalendarDuration(
      { year: 200, month: 1, confidence: "month" },
      { year: 201, month: 1, confidence: "month" },
    )).toBe("span");
  });

  it("does not infer duration from year-bucket placeholder months", () => {
    expect(eventModeForCalendarDuration(
      { year: 200, month: 1, confidence: "year" },
      { year: 201, month: 12, confidence: "year" },
    )).toBeNull();
  });
});
