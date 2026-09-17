import { describe, expect, it } from "vitest";
import { absMonth, type Reign } from "./index";
import {
  claimDetailFacts,
  claimTrackOf,
  groupByClaimTrack,
  MAIN_CLAIM_TRACK,
  resolveConcurrencySpans,
} from "./claimTracks";

function reign(
  id: string,
  startYear: number,
  endYear: number,
  extras: Partial<Reign> = {},
): Reign {
  return {
    id,
    dynastyId: extras.dynastyId ?? "sui",
    personId: id,
    title: id,
    eraNames: [],
    start: { year: startYear, month: 1 },
    end: { year: endYear, month: 12 },
    startAbs: absMonth(startYear, 1),
    endAbs: absMonth(endYear, 12),
    precision: "year",
    ...extras,
  };
}

describe("claimTrackOf", () => {
  it("treats a missing track as the main succession", () => {
    expect(claimTrackOf(reign("yang-guang", 604, 618))).toBe(MAIN_CLAIM_TRACK);
  });
});

describe("groupByClaimTrack", () => {
  it("keeps the main line on row 0 and stacks later seats below", () => {
    const lanes = groupByClaimTrack([
      reign("yang-guang", 604, 618),
      reign("yang-tong", 618, 619, {
        claimTrack: "luoyang",
        claimLabel: "洛阳",
        claimRole: "rival",
      }),
      reign("yang-you", 617, 618, {
        claimTrack: "changan",
        claimLabel: "长安",
        claimRole: "rival",
      }),
    ]);

    expect(lanes.map((lane) => [lane.track, lane.rowIndex])).toEqual([
      [MAIN_CLAIM_TRACK, 0],
      ["changan", 1],
      ["luoyang", 2],
    ]);
  });

  it("orders southern-ming rivals by first appearance", () => {
    const lanes = groupByClaimTrack([
      reign("yongli", 1646, 1662, { dynastyId: "ming-south" }),
      reign("shaowu", 1646, 1647, {
        dynastyId: "ming-south",
        claimTrack: "shaowu",
        claimRole: "rival",
      }),
      reign("lu-jian", 1645, 1653, {
        dynastyId: "ming-south",
        claimTrack: "lu-jian",
        claimRole: "rival",
      }),
    ]);

    expect(lanes.map((lane) => lane.track)).toEqual([
      MAIN_CLAIM_TRACK,
      "lu-jian",
      "shaowu",
    ]);
  });
});

describe("groupByClaimTrack — early Zhou dual kings", () => {
  it("keeps 平王 on the main line while 携王 sits on a rival row", () => {
    const lanes = groupByClaimTrack([
      reign("ji-yijiu", -770, -720, { dynastyId: "zhou-east" }),
      reign("ji-yuchen", -771, -750, {
        dynastyId: "zhou-east",
        claimTrack: "xie",
        claimLabel: "携",
        claimRole: "rival",
      }),
    ]);

    expect(lanes.map((lane) => lane.track)).toEqual([MAIN_CLAIM_TRACK, "xie"]);
  });
});

describe("groupByClaimTrack — Northern Wei split", () => {
  it("keeps 文帝 on the main line after 孝武帝 while 邺城孝静帝 stays parallel", () => {
    const lanes = groupByClaimTrack([
      reign("yuan-xiu", 532, 534, { dynastyId: "wei-north" }),
      reign("yuan-bao-ju", 535, 551, { dynastyId: "wei-north" }),
      reign("yuan-shan-jian", 534, 550, {
        dynastyId: "wei-north",
        claimTrack: "ye",
        claimLabel: "邺",
        claimRole: "rival",
      }),
    ]);

    expect(lanes.map((lane) => lane.track)).toEqual([MAIN_CLAIM_TRACK, "ye"]);
    expect(lanes[0]?.reigns.map((item) => item.personId)).toEqual([
      "yuan-xiu",
      "yuan-bao-ju",
    ]);
  });
});

describe("resolveConcurrencySpans", () => {
  it("marks the years when Sui parallel courts overlap the main line", () => {
    const spans = resolveConcurrencySpans([
      reign("yang-guang", 604, 618),
      reign("yang-you", 617, 618, { claimTrack: "changan" }),
      reign("yang-tong", 618, 619, { claimTrack: "luoyang" }),
    ]);

    expect(spans).toEqual([
      {
        startAbs: absMonth(617, 1),
        endAbs: absMonth(617, 12),
        trackCount: 2,
      },
      {
        startAbs: absMonth(618, 1),
        endAbs: absMonth(618, 12),
        trackCount: 3,
      },
    ]);
  });
});

describe("claimDetailFacts", () => {
  it("exposes role and seat for the detail panel", () => {
    expect(
      claimDetailFacts({
        claimTrack: "lu-jian",
        claimLabel: "绍兴监国",
      }),
    ).toEqual([
      { label: "身份", value: "并立" },
      { label: "据点", value: "绍兴监国" },
    ]);
  });
});
