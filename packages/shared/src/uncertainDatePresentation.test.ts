import { describe, expect, it } from "vitest";
import { buildReignCapitalTenures, buildReignTenureCapitalRows, capitalDateRangeLabel } from "./dynastyCapitals";
import { formatHistoricalDate, hasUncertainDateRange } from "./historicalDate";
import { formatReignDurationLabel, formatReignSpanTooltip } from "./reignVisual";
import { DynastyCapitalSchema, DynastySchema, PersonSchema, ReignSchema, type HistoricalDateConfidence } from "./schema";
import { absMonth } from "./time";
import { buildEntityDetail, type TimelineDataStore } from "./timelineData";
import { timelineInterval } from "./timelineIntervals";
import { capitalsForReigns } from "./timelineOwnership";

const knownReign = ReignSchema.parse({
  id: "reign-test", dynastyId: "dynasty-test", personId: "person-test", title: "君主",
  start: { year: -1024, month: 1, confidence: "year" },
  end: { year: -986, month: 12, confidence: "year" },
  startAbs: absMonth(-1024, 1), endAbs: absMonth(-986, 12), precision: "year",
});
const capital = DynastyCapitalSchema.parse({
  id: "capital-test", dynastyId: knownReign.dynastyId, historicalName: "商丘", modernName: "河南省商丘市",
  longitude: 115.65, latitude: 34.44,
  start: { year: -1040, month: 1, confidence: "year" },
  end: { year: -900, month: 12, confidence: "year" },
  startAbs: absMonth(-1040, 1), endAbs: absMonth(-900, 12),
});
const dynasty = DynastySchema.parse({
  id: knownReign.dynastyId, name: "宋", start: capital.start, end: capital.end,
  startAbs: capital.startAbs, endAbs: capital.endAbs,
});
const person = PersonSchema.parse({ id: knownReign.personId, name: "子衍", roles: ["君主"] });
const uncertainConfidences: HistoricalDateConfidence[] = [
  "approximate_year", "approximate_month", "approximate_day",
  "interpolated_by_other", "interpolated_by_generation",
];

describe("uncertain date presentation", () => {
  it.each(uncertainConfidences)("keeps %s endpoints out of precise durations and reign capital assignments", (confidence) => {
    for (const side of ["start", "end"] as const) {
      const reign = { ...knownReign, [side]: { ...knownReign[side], day: 9, confidence } };
      const interval = timelineInterval(reign.start, reign.end, reign.precision);
      expect(hasUncertainDateRange(reign)).toBe(true);
      expect(formatReignSpanTooltip(reign)).toBe(
        `${formatHistoricalDate(reign.start)} — ${formatHistoricalDate(reign.end)}`,
      );
      expect(formatReignDurationLabel(reign)).toBeUndefined();
      expect(formatReignDurationLabel(reign, interval)).toBeUndefined();
      expect(buildReignCapitalTenures(reign, [capital])).toEqual([]);
      expect(buildReignTenureCapitalRows(reign, [capital])).toEqual([]);
      expect(buildReignTenureCapitalRows(reign, [])).toEqual([]);
      expect(capitalsForReigns([reign], [reign], [capital])).toEqual([]);
      // Explicit links must not bypass uncertain dating.
      expect(buildReignCapitalTenures(reign, [{ ...capital, reignIds: [reign.id] }])).toEqual([]);
    }
  });

  it("removes the screenshot's 39-year capital tenure while preserving dynasty capital information", () => {
    const reign = {
      ...knownReign,
      start: { ...knownReign.start, confidence: "interpolated_by_generation" as const },
      end: { ...knownReign.end, confidence: "interpolated_by_generation" as const },
    };
    const store: TimelineDataStore = {
      dynasties: [dynasty], reigns: [reign], persons: [person], capitals: [capital], events: [], relations: [],
    };
    for (const ref of [{ type: "reign" as const, id: reign.id }, { type: "person" as const, id: person.id }]) {
      const detail = buildEntityDetail(store, ref);
      expect(detail.facts.find((fact) => fact.label === "在位")?.value).toBe("? — ?");
      expect(detail.capitalTenures).toEqual([]);
    }
    const dynastyDetail = buildEntityDetail(store, { type: "dynasty", id: dynasty.id });
    expect(dynastyDetail.related).toContainEqual(expect.objectContaining({
      ref: { type: "capital", id: capital.id }, label: "商丘", group: "capital",
    }));
  });

  it.each(uncertainConfidences)("retains a %s capital at dynasty level even for a certain reign", (confidence) => {
    for (const side of ["start", "end"] as const) {
      const uncertainCapital = { ...capital, [side]: { ...capital[side], confidence }, reignIds: [knownReign.id] };
      expect(buildReignCapitalTenures(knownReign, [uncertainCapital])).toEqual([]);
      expect(capitalsForReigns([knownReign], [knownReign], [uncertainCapital])).toEqual([]);
      expect(capitalDateRangeLabel(uncertainCapital)).toBe(
        `${formatHistoricalDate(uncertainCapital.start)} — ${formatHistoricalDate(uncertainCapital.end)}`,
      );
      const detail = buildEntityDetail({
        dynasties: [dynasty], reigns: [knownReign], persons: [person], capitals: [uncertainCapital], events: [], relations: [],
      }, { type: "dynasty", id: dynasty.id });
      expect(detail.related.map((item) => item.ref.id)).toContain(capital.id);
    }
  });

  it("honors approximate day dates before the day-duration tooltip branch", () => {
    const reign = {
      ...knownReign, precision: "day" as const,
      start: { year: 1234, month: 2, day: 9, confidence: "approximate_day" as const },
      end: { year: 1234, month: 2, day: 20, confidence: "day" as const },
      startAbs: absMonth(1234, 2), endAbs: absMonth(1234, 2),
    };
    expect(formatReignSpanTooltip(reign)).toBe("约1234年2月9日 — 1234年2月20日");
    expect(formatReignDurationLabel(reign)).toBeUndefined();
  });

  it("keeps certain year tenures and their duration", () => {
    const row = buildReignCapitalTenures(knownReign, [capital])[0];
    expect(row?.capital?.ref.id).toBe(capital.id);
    expect(row?.tenure.label).toBe("-1024年 — -986年");
    expect(row?.tenure.duration).toBe("39年");
    expect(formatReignDurationLabel(knownReign)).toBe("39年");
  });

  it("formats certain capital days and clips their tenure using shared ownership", () => {
    const reign = {
      ...knownReign, precision: "day" as const,
      start: { year: 1644, month: 4, day: 25, confidence: "day" as const },
      end: { year: 1644, month: 5, day: 17, confidence: "day" as const },
      startAbs: absMonth(1644, 4), endAbs: absMonth(1644, 5),
    };
    const seat = {
      ...capital, precision: "day" as const,
      start: reign.start,
      end: { year: 1644, month: 4, day: 30, confidence: "day" as const },
      startAbs: reign.startAbs, endAbs: reign.startAbs,
    };
    expect(buildReignCapitalTenures(reign, [seat])[0]?.tenure).toMatchObject({
      label: "1644年4月25日 — 1644年4月30日", duration: "6天",
    });
    expect(capitalDateRangeLabel(seat)).toBe("1644年4月25日 — 1644年4月30日");
  });
});
