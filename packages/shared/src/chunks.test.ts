import { describe, expect, it } from "vitest";
import { dedupeOverlappingReigns, listQueryChunks, mergeTimelineSlices } from "./chunks";
import type { Reign } from "./schema";

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

  it("drops overlapping duplicate reigns from merged chunks", () => {
    const stale: Reign = {
      id: "reign-qin-r30-qin",
      dynastyId: "qin",
      personId: "qin-r30",
      title: "秦莊襄王",
      preferredAppellation: { kind: "regnal", name: "秦莊襄王" },
      eraNames: [],
      start: { year: -281, month: 1 },
      end: { year: -247, month: 12 },
      startAbs: -3360,
      endAbs: -2941,
      precision: "year",
    };
    const current: Reign = {
      id: "reign-qin-r29-qin",
      dynastyId: "qin",
      personId: "qin-r29",
      title: "秦庄襄王",
      posthumousName: "庄襄王",
      preferredAppellation: { kind: "posthumous", name: "秦庄襄王" },
      eraNames: [],
      start: { year: -250, month: 1 },
      end: { year: -247, month: 12 },
      startAbs: -2988,
      endAbs: -2941,
      precision: "year",
    };

    const merged = mergeTimelineSlices([
      {
        dynasties: [],
        reigns: [stale],
        events: [],
        persons: [{ id: "qin-r30", name: "原名子异", roles: ["君主"], links: [] }],
      },
      {
        dynasties: [],
        reigns: [current],
        events: [],
        persons: [{ id: "qin-r29", name: "嬴子楚", roles: ["君主"], links: [] }],
      },
    ]);

    expect(merged.reigns.map((reign) => reign.id)).toEqual(["reign-qin-r29-qin"]);
    expect(merged.persons.map((person) => person.id)).toEqual(["qin-r29"]);
  });
});

describe("dedupeOverlappingReigns", () => {
  it("keeps distinct rulers who share a title in different eras", () => {
    const first: Reign = {
      id: "reign-qin-r14-qin",
      dynastyId: "qin",
      personId: "qin-r14",
      title: "秦惠公",
      eraNames: [],
      start: { year: -501, month: 1 },
      end: { year: -492, month: 12 },
      startAbs: -6000,
      endAbs: -5893,
      precision: "year",
    };
    const second: Reign = {
      id: "reign-qin-r21-qin",
      dynastyId: "qin",
      personId: "qin-r21",
      title: "秦惠公",
      eraNames: [],
      start: { year: -400, month: 1 },
      end: { year: -387, month: 12 },
      startAbs: -4788,
      endAbs: -4633,
      precision: "year",
    };

    expect(dedupeOverlappingReigns([first, second])).toHaveLength(2);
  });
});
