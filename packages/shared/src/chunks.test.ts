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
        dynastyGroups: [],
        dynastyLaneGroups: [],
        reigns: [],
        events: [],
        persons: [
          {
            id: "cao-cao",
            name: "曹操",
            altNames: [],
            birth: { year: 155, month: 1 },
            death: { year: 220, month: 3 },
            roles: ["政治家"],
            links: [],
          },
        ],
        relations: [],
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
        dynastyGroups: [],
        dynastyLaneGroups: [],
        reigns: [],
        events: [],
        persons: [
          {
            id: "cao-cao",
            name: "曹操",
            altNames: [],
            birth: { year: 155, month: 1 },
            death: { year: 220, month: 3 },
            roles: ["政治家"],
            links: [],
          },
          {
            id: "zhuge-liang",
            name: "诸葛亮",
            altNames: [],
            birth: { year: 181, month: 1 },
            death: { year: 234, month: 8 },
            roles: ["丞相"],
            links: [],
          },
        ],
        relations: [],
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
        dynastyGroups: [],
        dynastyLaneGroups: [],
        reigns: [stale],
        events: [],
        persons: [{ id: "qin-r30", name: "原名子异", altNames: [], roles: ["君主"], links: [] }],
        relations: [],
      },
      {
        dynasties: [],
        dynastyGroups: [],
        dynastyLaneGroups: [],
        reigns: [current],
        events: [],
        persons: [{ id: "qin-r29", name: "嬴子楚", altNames: [], roles: ["君主"], links: [] }],
        relations: [],
      },
    ]);

    expect(merged.reigns.map((reign) => reign.id)).toEqual(["reign-qin-r29-qin"]);
    expect(merged.persons.map((person) => person.id)).toEqual(["qin-r29"]);
  });

  it("preserves dynasty lane group config across chunks", () => {
    const laneGroup = {
      id: "mongol-yuan",
      primaryDynastyId: "yuan",
      phaseDynastyIds: ["mongol-empire", "yuan"],
      laneOrderStartAbs: 14472,
      laneOrderEndAbs: 16656,
    };

    const merged = mergeTimelineSlices([
      {
        dynasties: [],
        dynastyGroups: [],
        dynastyLaneGroups: [laneGroup],
        reigns: [],
        events: [],
        persons: [],
        relations: [],
      },
      {
        dynasties: [],
        dynastyGroups: [],
        dynastyLaneGroups: [],
        reigns: [],
        events: [],
        persons: [],
        relations: [],
      },
    ]);

    expect(merged.dynastyLaneGroups).toEqual([laneGroup]);
  });
});

describe("dedupeOverlappingReigns", () => {
  it("keeps successive rulers who share a generic regnal title", () => {
    const reign = (
      id: string,
      personId: string,
      dynastyId: string,
      title: string,
      startAbs: number,
      endAbs: number,
    ): Reign => ({
      id,
      dynastyId,
      personId,
      title,
      eraNames: [],
      start: { year: 1, month: 1 },
      end: { year: 1, month: 12 },
      startAbs,
      endAbs,
      precision: "year",
    });

    const chu = [
      reign("reign-ma-yin", "ma-yin", "chu-nan", "楚王", 10884, 11171),
      reign("reign-ma-xisheng", "ma-xisheng", "chu-nan", "楚王", 11160, 11195),
      reign("reign-ma-xifan", "ma-xifan", "chu-nan", "楚王", 11184, 11375),
      reign("reign-ma-xiguang", "ma-xiguang", "chu-nan", "楚王", 11364, 11375),
      reign("reign-ma-xie", "ma-xie", "chu-nan", "楚王", 11364, 11411),
      reign("reign-ma-xichong", "ma-xichong", "chu-nan", "楚王", 11400, 11423),
    ];
    expect(dedupeOverlappingReigns(chu).map((item) => item.personId)).toEqual([
      "ma-yin",
      "ma-xisheng",
      "ma-xifan",
      "ma-xiguang",
      "ma-xie",
      "ma-xichong",
    ]);

    const min = [
      reign("reign-wang-yanjun", "wang-yanjun", "min-fujian", "闽主", 11112, 11231),
      reign("reign-wang-jipeng", "wang-jipeng", "min-fujian", "闽主", 11220, 11279),
      reign("reign-wang-yanxi", "wang-yanxi", "min-fujian", "闽主", 11268, 11327),
      reign("reign-zhu-wenjin", "zhu-wenjin", "min-fujian", "闽主", 11328, 11339),
      reign("reign-wang-yanzheng", "wang-yanzheng", "min-fujian", "闽主", 11316, 11351),
    ];
    expect(dedupeOverlappingReigns(min).map((item) => item.personId)).toEqual([
      "wang-yanjun",
      "wang-jipeng",
      "wang-yanxi",
      "zhu-wenjin",
      "wang-yanzheng",
    ]);
  });

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

  it("keeps a long reign when a successor overlaps only its boundary year", () => {
    const reign = (id: string, personId: string, startAbs: number, endAbs: number): Reign => ({
      id,
      dynastyId: "tubo",
      personId,
      title: "赞普",
      eraNames: [],
      start: { year: 1, month: 1 },
      end: { year: 1, month: 12 },
      startAbs,
      endAbs,
      precision: "year",
    });

    const trisong = reign("reign-tri-song-detsen", "tri-song-detsen", 9060, 9575);
    const mune = reign("reign-mu-ne-btsan", "mu-ne-btsan", 9564, 9587);

    expect(dedupeOverlappingReigns([trisong, mune]).map((item) => item.personId)).toEqual([
      "tri-song-detsen",
      "mu-ne-btsan",
    ]);
  });
});
