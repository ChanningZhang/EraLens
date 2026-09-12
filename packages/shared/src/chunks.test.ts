import { describe, expect, it } from "vitest";
import { listQueryChunks, mergeTimelineSlices } from "./chunks";

describe("listQueryChunks", () => {
  it("splits decade window into aligned chunks", () => {
    const chunks = listQueryChunks(2350, 2700, "decade");
    expect(chunks).toEqual([
      { fromAbs: 1800, toAbs: 2400 },
      { fromAbs: 2400, toAbs: 3000 },
    ]);
  });

  it("returns one chunk when window fits", () => {
    const chunks = listQueryChunks(2405, 2507, "decade");
    expect(chunks).toEqual([{ fromAbs: 2400, toAbs: 3000 }]);
  });
});

describe("mergeTimelineSlices", () => {
  it("deduplicates entities by id", () => {
    const merged = mergeTimelineSlices([
      {
        dynasties: [
          {
            id: "han-east",
            name: "东汉",
            altNames: [],
            scope: "cn",
            region: "east_asia",
            start: { year: 25, month: 1 },
            end: { year: 220, month: 12 },
            startAbs: 300,
            endAbs: 2651,
            precision: "year",
            colorToken: "ochre",
          },
        ],
        reigns: [],
        events: [],
        persons: [
          {
            id: "cao-cao",
            name: "曹操",
            birth: { year: 155, month: 1 },
            death: { year: 220, month: 3 },
            roles: ["政治家"],
            links: [],
          },
        ],
      },
      {
        dynasties: [
          {
            id: "han-east",
            name: "东汉",
            altNames: [],
            scope: "cn",
            region: "east_asia",
            start: { year: 25, month: 1 },
            end: { year: 220, month: 12 },
            startAbs: 300,
            endAbs: 2651,
            precision: "year",
            colorToken: "ochre",
          },
        ],
        reigns: [],
        events: [],
        persons: [
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
        ],
      },
    ]);

    expect(merged.dynasties).toHaveLength(1);
    expect(merged.persons.map((person) => person.id).sort()).toEqual([
      "cao-cao",
      "zhuge-liang",
    ]);
  });
});
