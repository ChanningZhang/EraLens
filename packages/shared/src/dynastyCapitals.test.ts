import { describe, expect, it } from "vitest";
import { buildReignCapitalTenures, buildReignTenureCapitalRows, capitalsActiveAtAbs, dynastyCapitalRelatedItems } from "./dynastyCapitals";
import { capitalsForReigns } from "./timelineOwnership";
import type { CapitalLocation, Reign } from "./schema";

const tangChangan: CapitalLocation = {
  id: "cap-tang-changan",
  dynastyId: "tang",
  historicalName: "长安",
  modernName: "陕西省西安市",
  longitude: 108.939645,
  latitude: 34.343207,
  coordinateSystem: "GCJ02",
  start: { year: 618, month: 1 },
  end: { year: 904, month: 12 },
  startAbs: 7416,
  endAbs: 10848,
  role: "primary",
  links: [],
};

const tangLuoyang: CapitalLocation = {
  id: "cap-tang-luoyang",
  dynastyId: "tang",
  historicalName: "洛阳",
  modernName: "河南省洛阳市",
  longitude: 112.453895,
  latitude: 34.619702,
  coordinateSystem: "GCJ02",
  start: { year: 657, month: 1 },
  end: { year: 904, month: 12 },
  startAbs: 7884,
  endAbs: 10848,
  role: "secondary",
  links: [],
};

const qinXianyang: CapitalLocation = {
  id: "cap-qin-xianyang",
  dynastyId: "qin",
  historicalName: "咸阳",
  modernName: "陕西省咸阳市",
  longitude: 108.708837,
  latitude: 34.329896,
  coordinateSystem: "GCJ02",
  start: { year: -350, month: 1 },
  end: { year: -207, month: 12 },
  startAbs: -4194,
  endAbs: -2484,
  role: "primary",
  links: [],
};

describe("capitalsActiveAtAbs", () => {
  it("returns empty for empty input", () => {
    expect(capitalsActiveAtAbs([], 8000)).toEqual([]);
  });

  it("returns both Tang capitals during the Eastern Capital era", () => {
    const active = capitalsActiveAtAbs([tangChangan, tangLuoyang, qinXianyang], 9000);
    expect(active.map((c) => c.id).sort()).toEqual(["cap-tang-changan", "cap-tang-luoyang"]);
  });

  it("returns only Chang'an before Luoyang became secondary capital", () => {
    const active = capitalsActiveAtAbs([tangChangan, tangLuoyang], 7500);
    expect(active.map((c) => c.id)).toEqual(["cap-tang-changan"]);
  });

  it("includes capitals on span boundaries", () => {
    expect(capitalsActiveAtAbs([tangChangan], 7416).map((c) => c.id)).toEqual([
      "cap-tang-changan",
    ]);
    expect(capitalsActiveAtAbs([tangChangan], 10848).map((c) => c.id)).toEqual([
      "cap-tang-changan",
    ]);
    expect(capitalsActiveAtAbs([tangChangan], 7415)).toEqual([]);
    expect(capitalsActiveAtAbs([tangChangan], 10849)).toEqual([]);
  });

  it("returns Qin capital in the Warring States period", () => {
    expect(capitalsActiveAtAbs([qinXianyang, tangChangan], -3000).map((c) => c.id)).toEqual([
      "cap-qin-xianyang",
    ]);
  });
});

const tangReign: Reign = {
  id: "reign-tang-xuanzong",
  dynastyId: "tang",
  personId: "li-longji",
  title: "唐玄宗",
  start: { year: 712, month: 9, confidence: "month" },
  end: { year: 756, month: 8, confidence: "month" },
  startAbs: 8552,
  endAbs: 9071,
  precision: "month",
};

describe("buildReignCapitalTenures", () => {
  it("arbitrates a year-dated move between primary cities before clipping to a day-dated reign", () => {
    const reign: Reign = {
      ...tangReign, id: "reign-moving-court",
      start: { year: 229, month: 5, day: 23, confidence: "day" },
      end: { year: 252, month: 5, day: 21, confidence: "day" },
      startAbs: 2752, endAbs: 3028, precision: "day",
    };
    const older: CapitalLocation = {
      ...tangChangan, id: "older-seat", mappingKind: "reign", reignIds: [reign.id],
      start: { year: 221, month: 1, confidence: "year" },
      end: { year: 229, month: 12, confidence: "year" },
      startAbs: 2652, endAbs: 2759,
    };
    const later: CapitalLocation = {
      ...tangLuoyang, id: "later-seat", mappingKind: "reign", reignIds: [reign.id], role: "primary",
      start: { year: 229, month: 1, confidence: "year" },
      end: { year: 265, month: 12, confidence: "year" },
      startAbs: 2748, endAbs: 3191,
    };
    const rows = buildReignCapitalTenures(reign, [later, older]);
    expect(rows.map(row => [row.capital?.ref.id, row.tenure.label])).toEqual([
      ["older-seat", "229年5月23日 — 229年"],
      ["later-seat", "230年 — 252年5月21日"],
    ]);
    // A secondary capital, another claimant, or another dynasty is not a move.
    for (const concurrent of [
      { ...later, role: "secondary" as const },
      { ...later, claimTrack: "branch" },
      { ...later, dynastyId: "other" },
    ]) {
      const concurrentRows = buildReignCapitalTenures(reign, [older, concurrent]);
      expect(concurrentRows.find(row => row.capital?.ref.id === "later-seat")?.tenure.label)
        .toBe("229年5月23日 — 252年5月21日");
    }
  });

  it("identifies a parallel claimant's primary seat in dynasty and reign details", () => {
    const branchCapital = { ...tangChangan, reignIds:["reign-tang-branch"],claimTrack: "branch" };
    const branchReign = { ...tangReign,id:"reign-tang-branch",claimTrack: "branch" };
    expect(dynastyCapitalRelatedItems("tang", [branchCapital])[0]?.subtitle)
      .toContain("并立政权治所");
    expect(buildReignCapitalTenures(branchReign, [branchCapital])[0]?.capital?.subtitle)
      .toBe("并立政权治所 · 陕西省西安市");
    expect(buildReignCapitalTenures(tangReign, [branchCapital])).toEqual([]);
    expect(dynastyCapitalRelatedItems("tang", [{ ...tangChangan, claimTrack: "main" }])[0]?.subtitle)
      .toContain("正都");
  });

  it("pairs overlapping capitals with intersected reign segments", () => {
    const rows = buildReignCapitalTenures(tangReign, [{...tangChangan,reignIds:[tangReign.id]}, {...tangLuoyang,reignIds:[tangReign.id]}, qinXianyang]);
    expect(rows).toEqual([
      {
        capital: {
          ref: { type: "location_mapping", id: "cap-tang-changan" },
          label: "长安",
          subtitle: "陕西省西安市",
        },
        tenure: {
          ref: { type: "reign", id: "reign-tang-xuanzong" },
          label: "712年9月 — 756年8月",
          abs: 8552,
          duration: "44年",
        },
      },
      {
        capital: {
          ref: { type: "location_mapping", id: "cap-tang-luoyang" },
          label: "洛阳",
          subtitle: "陪都 · 河南省洛阳市",
        },
        tenure: {
          ref: { type: "reign", id: "reign-tang-xuanzong" },
          label: "712年9月 — 756年8月",
          abs: 8552,
          duration: "44年",
        },
      },
    ]);
  });

  it("uses explicit reign-capital links ahead of dynasty time ownership", () => {
    const linkedCapital: CapitalLocation = {
      ...tangLuoyang,
      id: "cap-parallel-seat",
      dynastyId: "other-dynasty",
      historicalName: "并立据点",
      modernName: "河南省洛阳市",
      claimTrack: "other-track",
      reignIds: [tangReign.id],
    };
    const rows = buildReignCapitalTenures(tangReign, [tangChangan, tangLuoyang, linkedCapital]);
    expect(rows.map((row) => row.capital?.ref.id)).toEqual(["cap-parallel-seat"]);
    expect(capitalsForReigns([tangReign], [tangReign], [tangChangan, tangLuoyang, linkedCapital]).map((capital) => capital.id)).toEqual([
      "cap-parallel-seat",
    ]);
  });

  it("does not infer a capital from dynasty, time, or track without an explicit mapping", () => {
    const parallelReign: Reign = {
      ...tangReign,
      id: "reign-tang-claimant",
      claimTrack: "luoyang",
    };
    const trackCapital: CapitalLocation = {
      ...tangLuoyang,
      claimTrack: "luoyang",
    };
    expect(buildReignCapitalTenures(parallelReign, [tangChangan, trackCapital]).map((row) => row.capital?.ref.id)).toEqual([]);
    expect(capitalsForReigns([parallelReign], [parallelReign], [tangChangan, trackCapital]).map((capital) => capital.id)).toEqual([]);
  });

  it("returns empty when no capitals overlap the reign", () => {
    expect(buildReignTenureCapitalRows(tangReign, [qinXianyang])).toEqual([]);
    expect(buildReignTenureCapitalRows(tangReign, [])).toEqual([]);
  });

  it("renders uncertain reign endpoints as question marks", () => {
    const uncertainReign: Reign = {
      ...tangReign,
      start: { ...tangReign.start, confidence: "interpolated_by_generation" },
      end: { ...tangReign.end, confidence: "approximate_month" },
    };
    expect(buildReignTenureCapitalRows(uncertainReign, [qinXianyang])).toEqual([]);
  });

  it("preserves day-precision capital intervals instead of collapsing them to a month", () => {
    const liZichengReign: Reign = {
      id: "reign-li-zicheng-dashun",
      dynastyId: "dashun",
      personId: "li-zicheng",
      title: "大顺皇帝",
      start: { year: 1644, month: 1 },
      end: { year: 1645, month: 5, day: 17 },
      startAbs: 19728,
      endAbs: 19744,
      precision: "month",
    };
    const beijing = {
      id: "cap-dashun-beijing-19728",
      dynastyId: "dashun",
      historicalName: "北京",
      modernName: "北京市",
      longitude: 116.407387,
      latitude: 39.904179,
      coordinateSystem: "GCJ02" as const,
      start: { year: 1644, month: 4, day: 25 },
      end: { year: 1644, month: 4, day: 30 },
      startAbs: 19731,
      endAbs: 19731,
      precision: "day" as const,
      role: "primary" as const,
    };
    expect(buildReignCapitalTenures(liZichengReign, [{...beijing,reignIds:[liZichengReign.id]}])[0]?.tenure.label).toBe(
      "1644年4月25日 — 1644年4月30日",
    );
  });

  it("keeps the highest available precision independently at each tenure boundary", () => {
    const reign: Reign = {
      id: "reign-mixed-precision",
      dynastyId: "mixed",
      personId: "ruler-mixed-precision",
      title: "君主",
      start: { year: 1644, month: 4, day: 25 },
      end: { year: 1644, month: 5, day: 17 },
      startAbs: 19731,
      endAbs: 19732,
      precision: "day",
    };
    const capital: CapitalLocation = {
      id: "cap-mixed-precision",
      dynastyId: "mixed",
      historicalName: "都城",
      modernName: "某地",
      longitude: 0,
      latitude: 0,
      coordinateSystem: "GCJ02",
      start: { year: 1644, month: 1 },
      end: { year: 1644, month: 4 },
      startAbs: 19728,
      endAbs: 19731,
      precision: "month",
      role: "primary",
      links: [],
    };

    expect(buildReignCapitalTenures(reign, [{...capital,reignIds:[reign.id]}])[0]?.tenure.label).toBe(
      "1644年4月25日 — 1644年4月",
    );
  });
});
