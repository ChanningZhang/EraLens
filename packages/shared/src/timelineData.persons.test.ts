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
    expect(ids).toEqual(["cao-cao", "zhuge-liang"]);
  });

  it("excludes reign holders even when their lifespan intersects", () => {
    const slice = filterTimeline(store, {
      fromAbs: absMonth(150, 1),
      toAbs: absMonth(240, 12),
      scope: "cn",
    });
    expect(slice.persons.some((person) => person.id === "liu-bei")).toBe(false);
  });
});
