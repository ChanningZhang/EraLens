import { describe, it } from "node:test";
import assert from "node:assert/strict";
import {
  absMonth,
  eventPoint,
  eventRange,
  eventYear,
  normalizeYearPrecisionAt,
  ym,
} from "./sqlHelpers.mjs";

describe("normalizeYearPrecisionAt", () => {
  it("moves year-precision January placeholder to December", () => {
    assert.deepEqual(normalizeYearPrecisionAt(ym(-228), "year"), eventYear(-228));
    assert.equal(eventYear(-228).abs, absMonth(-228, 12));
  });

  it("keeps a non-January month when precision is year", () => {
    assert.deepEqual(normalizeYearPrecisionAt(ym(420, 7), "year"), ym(420, 7));
  });

  it("does not rewrite month-precision January", () => {
    assert.deepEqual(normalizeYearPrecisionAt(ym(1626, 1), "month"), ym(1626, 1));
  });
});

describe("eventPoint", () => {
  it("places year-only points at December", () => {
    const event = eventPoint({ id: "qin-destroy-zhao", name: "秦灭赵", at: ym(-228) });
    assert.equal(event.at.month, 12);
    assert.equal(event.atAbs, absMonth(-228, 12));
  });

  it("keeps an explicit month when precision is month", () => {
    const event = eventPoint({
      id: "xuanwumen",
      name: "玄武门之变",
      precision: "month",
      at: ym(626, 7),
    });
    assert.equal(event.at.month, 7);
  });
});

describe("eventRange", () => {
  it("normalizes optional year-precision at without moving the span", () => {
    const event = eventRange({
      id: "window",
      timeMode: "circa",
      start: ym(-400),
      end: ym(-350, 12),
      at: ym(-380),
    });
    assert.equal(event.start.month, 1);
    assert.equal(event.end.month, 12);
    assert.equal(event.at.month, 12);
    assert.equal(event.atAbs, absMonth(-380, 12));
  });
});
