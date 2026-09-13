import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import { filterTimeline } from "./timelineData";

describe("filterTimeline persons", () => {
  const store = {
    dynasties: [
      {
        id: "han-east",
        name: "东汉",
        altNames: [],
        scope: "cn",
        region: "east_asia",
        start: { year: 25, month: 1 },
        end: { year: 220, month: 12 },
        startAbs: absMonth(25, 1),
        endAbs: absMonth(220, 12),
        precision: "year" as const,
        colorToken: "ochre" as const,
      },
    ],
    reigns: [
      {
        id: "reign-liu-bei",
        dynastyId: "han-east",
        personId: "liu-bei",
        title: "昭烈帝",
        eraNames: [],
        start: { year: 221, month: 4 },
        end: { year: 223, month: 6 },
        startAbs: absMonth(221, 4),
        endAbs: absMonth(223, 6),
        precision: "year" as const,
      },
    ],
    persons: [
      {
        id: "liu-bei",
        name: "刘备",
        birth: { year: 161, month: 1 },
        death: { year: 223, month: 6 },
        roles: ["皇帝"],
        links: [],
      },
      {
        id: "cao-cao",
        name: "曹操",
        birth: { year: 155, month: 1 },
        death: { year: 220, month: 3 },
        roles: ["政治家"],
        links: [],
      },
      {
        id: "zhuge-liang",
        name: "诸葛亮",
        birth: { year: 181, month: 1 },
        death: { year: 234, month: 8 },
        roles: ["丞相"],
        links: [],
      },
      {
        id: "liu-xiu",
        name: "刘秀",
        roles: ["皇帝"],
        links: [],
      },
    ],
    events: [],
    relations: [],
  };

  it("includes non-reign persons with full lifespan in the window", () => {
    const slice = filterTimeline(store, {
      fromAbs: absMonth(150, 1),
      toAbs: absMonth(240, 12),
      scope: "cn",
    });
    const ids = slice.persons.map((person) => person.id).sort();
    expect(ids).toEqual(["cao-cao", "liu-bei", "zhuge-liang"]);
  });

  it("includes visible reign holders so cards can render personal names", () => {
    const slice = filterTimeline(store, {
      fromAbs: absMonth(150, 1),
      toAbs: absMonth(240, 12),
      scope: "cn",
    });
    expect(slice.persons.some((person) => person.id === "liu-bei")).toBe(true);
  });

  it("excludes reign holders whose reign is outside the window", () => {
    const slice = filterTimeline(store, {
      fromAbs: absMonth(150, 1),
      toAbs: absMonth(180, 12),
      scope: "cn",
    });
    expect(slice.persons.some((person) => person.id === "liu-bei")).toBe(false);
  });

  it("includes non-reign persons with only birth or death in the window", () => {
    const storeWithPartial = {
      ...store,
      persons: [
        ...store.persons,
        {
          id: "zhang-liang",
          name: "张良",
          birth: { year: -250, month: 1 },
          roles: ["政治家"],
          links: [],
        },
        {
          id: "xiao-he",
          name: "萧何",
          death: { year: -193, month: 1 },
          roles: ["政治家"],
          links: [],
        },
      ],
    };
    const slice = filterTimeline(storeWithPartial, {
      fromAbs: absMonth(-260, 1),
      toAbs: absMonth(-180, 12),
      scope: "cn",
    });
    expect(slice.persons.map((person) => person.id).sort()).toEqual([
      "xiao-he",
      "zhang-liang",
    ]);
  });
});
