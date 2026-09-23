import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import { searchEntities } from "./timelineData";

describe("searchEntities person aliases", () => {
  const store = {
    dynasties: [],
    reigns: [],
    events: [],
    relations: [],
    persons: [
      {
        id: "lv-shang",
        name: "吕尚",
        altNames: ["姜子牙", "姜太公", "太公"],
        birth: { year: -1156, month: 1 },
        death: { year: -1017, month: 1 },
        roles: ["君主", "军事家", "政治家"],
        links: [],
      },
    ],
  };

  it("finds 姜子牙 by alias even when the stored name is 吕尚", () => {
    const hits = searchEntities(store, "姜子牙");
    expect(hits).toEqual([
      {
        ref: { type: "person", id: "lv-shang" },
        label: "吕尚",
        subtitle: "君主 · 军事家 · 政治家",
        abs: absMonth(-1156, 1),
      },
    ]);
  });
});

describe("searchEntities temple names", () => {
  const store = {
    dynasties: [
      {
        id: "tang",
        name: "唐",
        altNames: [],
        scope: "cn" as const,
        region: "east_asia",
        start: { year: 618, month: 6 },
        end: { year: 907, month: 5 },
        startAbs: absMonth(618, 6),
        endAbs: absMonth(907, 5),
        precision: "year" as const,
      },
    ],
    reigns: [
      {
        id: "tang-taizong",
        dynastyId: "tang",
        personId: "li-shimin",
        title: "唐太宗",
        eraNames: ["贞观"],
        start: { year: 626, month: 9 },
        end: { year: 649, month: 11 },
        startAbs: absMonth(626, 9),
        endAbs: absMonth(649, 11),
        precision: "year" as const,
      },
    ],
    relations: [],
    events: [],
    persons: [
      {
        id: "li-shimin",
        name: "李世民",
        altNames: [],
        templeNames: ["太宗"],
        searchTerms: ["李世民", "太宗", "唐太宗"],
        birth: { year: 598, month: 1 },
        death: { year: 649, month: 11 },
        roles: ["君主"],
        links: [],
      },
    ],
  };

  it("finds a person by the bare temple name", () => {
    expect(searchEntities(store, "太宗").map((hit) => hit.ref)).toEqual([
      { type: "person", id: "li-shimin" },
    ]);
  });

  it("finds a person by dynasty plus temple name", () => {
    expect(searchEntities(store, "唐太宗").map((hit) => hit.ref)).toEqual([
      { type: "person", id: "li-shimin" },
    ]);
  });
});

describe("searchEntities era names", () => {
  it("finds a matching era name and focuses its specific reign", () => {
    const store = {
      dynasties: [
        {
          id: "song",
          name: "宋",
          altNames: [],
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 960, month: 1 },
          end: { year: 1279, month: 6 },
          startAbs: absMonth(960, 1),
          endAbs: absMonth(1279, 6),
          precision: "year" as const,
        },
      ],
      reigns: [
        {
          id: "reign-song-taizu-jianlong",
          dynastyId: "song",
          personId: "song-taizu",
          title: "宋太祖",
          eraNames: ["建隆", "乾德"],
          start: { year: 960, month: 1 },
          end: { year: 976, month: 11 },
          startAbs: absMonth(960, 1),
          endAbs: absMonth(976, 11),
          precision: "year" as const,
        },
      ],
      relations: [],
      events: [],
      persons: [
        {
          id: "song-taizu",
          name: "赵匡胤",
          altNames: [],
          birth: { year: 927, month: 1 },
          death: { year: 976, month: 11 },
          roles: ["君主"],
          links: [],
        },
      ],
    };

    expect(searchEntities(store, "建隆")).toEqual([
      {
        ref: { type: "reign", id: "reign-song-taizu-jianlong" },
        label: "建隆",
        subtitle: "赵匡胤 · 宋",
        abs: absMonth(960, 1),
      },
    ]);
  });
});

describe("searchEntities capitals", () => {
  it("finds a capital by historical or modern name", () => {
    const store = {
      dynasties: [
        {
          id: "tang",
          name: "唐",
          altNames: [],
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 618, month: 6 },
          end: { year: 907, month: 5 },
          startAbs: absMonth(618, 6),
          endAbs: absMonth(907, 5),
          precision: "year" as const,
        },
      ],
      reigns: [],
      persons: [],
      events: [],
      relations: [],
      capitals: [
        {
          id: "cap-tang-changan",
          dynastyId: "tang",
          historicalName: "长安",
          modernName: "陕西省西安市",
          longitude: 108.9,
          latitude: 34.3,
          coordinateSystem: "GCJ02" as const,
          start: { year: 618, month: 1 },
          end: { year: 904, month: 12 },
          startAbs: absMonth(618, 1),
          endAbs: absMonth(904, 12),
          precision: "year" as const,
          role: "primary" as const,
          links: [],
        },
      ],
    };

    expect(searchEntities(store, "西安")).toEqual([
      {
        ref: { type: "capital", id: "cap-tang-changan" },
        label: "长安",
        subtitle: "陕西省西安市 · 唐 · 都城",
        abs: absMonth(618, 1),
      },
    ]);
  });
});
