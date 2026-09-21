import { describe, expect, it } from "vitest";
import { buildReignCapitalTenures, buildReignTenureCapitalRows, capitalsActiveAtAbs } from "./dynastyCapitals";
import type { DynastyCapital, Reign } from "./schema";

const tangChangan: DynastyCapital = {
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

const tangLuoyang: DynastyCapital = {
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

const qinXianyang: DynastyCapital = {
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
  start: { year: 712, month: 9 },
  end: { year: 756, month: 8 },
  startAbs: 8544,
  endAbs: 9071,
  precision: "month",
};

describe("buildReignCapitalTenures", () => {
  it("pairs overlapping capitals with intersected reign segments", () => {
    const rows = buildReignCapitalTenures(tangReign, [tangChangan, tangLuoyang, qinXianyang]);
    expect(rows).toEqual([
      {
        capital: {
          ref: { type: "capital", id: "cap-tang-changan" },
          label: "长安",
          subtitle: "陕西省西安市",
        },
        tenure: {
          ref: { type: "reign", id: "reign-tang-xuanzong" },
          label: "712年9月 — 756年8月",
          abs: 8544,
        },
      },
      {
        capital: {
          ref: { type: "capital", id: "cap-tang-luoyang" },
          label: "洛阳",
          subtitle: "陪都 · 河南省洛阳市",
        },
        tenure: {
          ref: { type: "reign", id: "reign-tang-xuanzong" },
          label: "712年9月 — 756年8月",
          abs: 8544,
        },
      },
    ]);
  });

  it("returns empty when no capitals overlap the reign", () => {
    expect(buildReignTenureCapitalRows(tangReign, [qinXianyang])).toEqual([
      {
        tenure: {
          ref: { type: "reign", id: "reign-tang-xuanzong" },
          label: "712年9月 — 756年8月",
          abs: 8544,
        },
      },
    ]);
  });
});
