import { describe, expect, it } from "vitest";
import { listQueryChunks, mergeTimelineSlices } from "./chunks";
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

  it("preserves distinct reign IDs even when their spans and titles overlap", () => {
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

    expect(merged.reigns.map((reign) => reign.id)).toEqual([stale.id, current.id]);
    expect(merged.persons.map((person) => person.id)).toEqual(["qin-r30", "qin-r29"]);
  });

  it("keeps 平王 and 携王 on separate tracks when both titles are blank", () => {
    const ping: Reign = {
      id: "reign-ji-yijiu",
      dynastyId: "zhou-east",
      personId: "ji-yijiu",
      title: "",
      eraNames: [],
      start: { year: -770, month: 1 },
      end: { year: -720, month: 12 },
      startAbs: -9228,
      endAbs: -8617,
      precision: "year",
    };
    const xie: Reign = {
      ...ping,
      id: "reign-ji-yuchen",
      personId: "ji-yuchen",
      end: { year: -750, month: 12 },
      endAbs: -8977,
      claimTrack: "xie",
      claimRole: "rival",
    };
    const slice = {
      dynasties: [], dynastyGroups: [], dynastyLaneGroups: [],
      reigns: [ping, xie], events: [], persons: [], relations: [],
    };

    expect(mergeTimelineSlices([slice]).reigns.map((reign) => reign.id)).toEqual([
      ping.id,
      xie.id,
    ]);
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
