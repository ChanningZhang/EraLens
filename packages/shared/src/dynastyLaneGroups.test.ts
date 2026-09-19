import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import {
  collapseDynastyLaneGroups,
  collectLaneReigns,
  isFrozenLaneOrthodox,
  layoutBucketsForLaneReigns,
  reignsInLayoutBucket,
  resolveFrozenLaneLabel,
  STANDARD_DYNASTY_LANE_GROUPS,
  TIMELINE_GUTTER_PX,
  TIMELINE_RAIL_GAP_PX,
  TIMELINE_RAIL_INSET_PX,
  TIMELINE_RAIL_LABEL_WIDTH_PX,
} from "./dynastyLaneGroups";

const LANE_GROUPS = STANDARD_DYNASTY_LANE_GROUPS;

import type { Dynasty, Reign } from "./schema";

const mongolEmpire: Dynasty = {
  id: "mongol-empire",
  name: "蒙古帝国",
  altNames: [],
  scope: "cn",
  region: "east_asia",
  start: { year: 1206, month: 1 },
  end: { year: 1271, month: 12 },
  startAbs: absMonth(1206),
  endAbs: absMonth(1271, 12),
  precision: "year",
  colorToken: "ochre",
};

const yuan: Dynasty = {
  id: "yuan",
  name: "元",
  altNames: ["大元"],
  scope: "cn",
  region: "east_asia",
  start: { year: 1271, month: 12 },
  end: { year: 1388, month: 1 },
  startAbs: absMonth(1271, 12),
  endAbs: absMonth(1388),
  precision: "year",
  colorToken: "indigo",
  orthodoxEndAbs: absMonth(1368),
};

const wuZhu: Dynasty = {
  id: "wu-zhu",
  name: "吴",
  altNames: ["西吴"],
  scope: "cn",
  region: "east_asia",
  start: { year: 1364, month: 1 },
  end: { year: 1368, month: 1 },
  startAbs: absMonth(1364),
  endAbs: absMonth(1368, 1),
  precision: "year",
  colorToken: "moss",
};

const ming: Dynasty = {
  id: "ming",
  name: "明",
  altNames: ["大明"],
  scope: "cn",
  region: "east_asia",
  start: { year: 1368, month: 1 },
  end: { year: 1644, month: 4 },
  startAbs: absMonth(1368),
  endAbs: absMonth(1644, 4),
  precision: "year",
  colorToken: "plum",
};

const mingSouth: Dynasty = {
  id: "ming-south",
  name: "南明",
  altNames: ["明"],
  scope: "cn",
  region: "east_asia",
  start: { year: 1644, month: 1 },
  end: { year: 1662, month: 1 },
  startAbs: absMonth(1644),
  endAbs: absMonth(1662),
  precision: "year",
  colorToken: "mineral",
};

const songNorth: Dynasty = {
  id: "song-north",
  name: "北宋",
  altNames: ["宋"],
  scope: "cn",
  region: "east_asia",
  start: { year: 960, month: 1 },
  end: { year: 1127, month: 1 },
  startAbs: absMonth(960),
  endAbs: absMonth(1127),
  precision: "year",
  colorToken: "cinnabar",
};

const songSouth: Dynasty = {
  id: "song-south",
  name: "南宋",
  altNames: ["宋"],
  scope: "cn",
  region: "east_asia",
  start: { year: 1127, month: 1 },
  end: { year: 1279, month: 1 },
  startAbs: absMonth(1127),
  endAbs: absMonth(1279),
  precision: "year",
  colorToken: "jade",
};

const zhouWest: Dynasty = {
  id: "zhou-west",
  name: "西周",
  altNames: ["周"],
  scope: "cn",
  region: "east_asia",
  start: { year: -1046, month: 1 },
  end: { year: -771, month: 12 },
  startAbs: absMonth(-1046),
  endAbs: absMonth(-771, 12),
  precision: "year",
  colorToken: "indigo",
};

const zhouEast: Dynasty = {
  id: "zhou-east",
  name: "东周",
  altNames: ["周"],
  scope: "cn",
  region: "east_asia",
  start: { year: -770, month: 1 },
  end: { year: -256, month: 12 },
  startAbs: absMonth(-770),
  endAbs: absMonth(-256, 12),
  precision: "year",
  colorToken: "moss",
};

const jinWest: Dynasty = {
  id: "jin-west",
  name: "西晋",
  altNames: ["晋", "司马晋"],
  scope: "cn",
  region: "east_asia",
  start: { year: 266, month: 2 },
  end: { year: 316, month: 4 },
  startAbs: absMonth(266, 2),
  endAbs: absMonth(316, 4),
  precision: "year",
  colorToken: "stone",
};

const jinEast: Dynasty = {
  id: "jin-east",
  name: "东晋",
  altNames: ["晋"],
  scope: "cn",
  region: "east_asia",
  start: { year: 317, month: 1 },
  end: { year: 420, month: 7 },
  startAbs: absMonth(317),
  endAbs: absMonth(420, 7),
  precision: "year",
  colorToken: "jade",
};

const tang: Dynasty = {
  id: "tang",
  name: "唐",
  altNames: [],
  scope: "cn",
  region: "east_asia",
  start: { year: 618, month: 1 },
  end: { year: 907, month: 1 },
  startAbs: absMonth(618),
  endAbs: absMonth(907),
  precision: "year",
  colorToken: "cinnabar",
};

describe("dynastyLaneGroups", () => {
  it("resolves frozen label from the label anchor abs across phases", () => {
    const byId = new Map([
      [mongolEmpire.id, mongolEmpire],
      [yuan.id, yuan],
    ]);

    expect(resolveFrozenLaneLabel(yuan, byId, absMonth(1250), LANE_GROUPS)).toBe("蒙古帝国");
    expect(resolveFrozenLaneLabel(yuan, byId, absMonth(1271, 11), LANE_GROUPS)).toBe("蒙古帝国");
    expect(resolveFrozenLaneLabel(yuan, byId, absMonth(1271, 12), LANE_GROUPS)).toBe("元");
    expect(resolveFrozenLaneLabel(yuan, byId, absMonth(1300), LANE_GROUPS)).toBe("元");
  });

  it("reserves a shared gutter for the dynasty-name rail", () => {
    expect(TIMELINE_GUTTER_PX).toBe(
      TIMELINE_RAIL_INSET_PX + TIMELINE_RAIL_LABEL_WIDTH_PX + TIMELINE_RAIL_GAP_PX,
    );
  });

  it("switches the frozen label at the center guide, not the left edge", () => {
    const byId = new Map([
      [mongolEmpire.id, mongolEmpire],
      [yuan.id, yuan],
    ]);
    const yuanStart = yuan.startAbs;
    const pxPerMonth = 1.5;
    const contentWidth = 1200 - TIMELINE_GUTTER_PX;
    const halfWindow = contentWidth / pxPerMonth / 2;
    const centerAbs = yuanStart + 100;
    const leftEdgeAbs = centerAbs - halfWindow;

    expect(centerAbs).toBeGreaterThan(yuanStart);
    expect(leftEdgeAbs).toBeLessThan(yuanStart);
    expect(resolveFrozenLaneLabel(yuan, byId, leftEdgeAbs, LANE_GROUPS)).toBe("蒙古帝国");
    expect(resolveFrozenLaneLabel(yuan, byId, centerAbs, LANE_GROUPS)).toBe("元");
  });

  it("paints frozen-chip gold from the same center abs as the phase label", () => {
    const yuanOrthodox = {
      ...yuan,
      orthodoxFromAbs: absMonth(1276, 2),
    };
    const byId = new Map([
      [mongolEmpire.id, mongolEmpire],
      [yuanOrthodox.id, yuanOrthodox],
    ]);

    expect(isFrozenLaneOrthodox(yuanOrthodox, byId, absMonth(1250), LANE_GROUPS)).toBe(
      false,
    );
    expect(isFrozenLaneOrthodox(yuanOrthodox, byId, absMonth(1271, 12), LANE_GROUPS)).toBe(
      false,
    );
    expect(isFrozenLaneOrthodox(yuanOrthodox, byId, absMonth(1276, 2), LANE_GROUPS)).toBe(
      true,
    );
    expect(isFrozenLaneOrthodox(yuanOrthodox, byId, absMonth(1300), LANE_GROUPS)).toBe(
      true,
    );
    expect(isFrozenLaneOrthodox(yuanOrthodox, byId, absMonth(1368), LANE_GROUPS)).toBe(
      true,
    );
    expect(isFrozenLaneOrthodox(yuanOrthodox, byId, absMonth(1369), LANE_GROUPS)).toBe(
      false,
    );
  });

  it("collapses mongol empire and yuan into one lane anchored on yuan", () => {
    const collapsed = collapseDynastyLaneGroups([tang, mongolEmpire, yuan], undefined, LANE_GROUPS);

    expect(collapsed.map((dynasty) => dynasty.id)).toEqual(["tang", "yuan"]);
    expect(collapsed[1]).toMatchObject({
      id: "yuan",
      name: "元",
      startAbs: mongolEmpire.startAbs,
      endAbs: yuan.endAbs,
    });
  });

  it("still merges when only the pre-yuan member is visible", () => {
    const collapsed = collapseDynastyLaneGroups([mongolEmpire], undefined, LANE_GROUPS);

    expect(collapsed).toHaveLength(1);
    expect(collapsed[0]).toMatchObject({
      id: "yuan",
      startAbs: mongolEmpire.startAbs,
      endAbs: yuan.endAbs,
    });
  });

  it("collapses wu-zhu, ming, and ming-south into one lane anchored on ming", () => {
    const collapsed = collapseDynastyLaneGroups([wuZhu, ming, mingSouth, tang], undefined, LANE_GROUPS);

    expect(collapsed.map((dynasty) => dynasty.id)).toEqual(["tang", "ming"]);
    expect(collapsed[1]).toMatchObject({
      id: "ming",
      name: "明",
      startAbs: wuZhu.startAbs,
      endAbs: mingSouth.endAbs,
    });
  });

  it("resolves wu, ming, and ming-south across phase boundaries", () => {
    const byId = new Map([
      [wuZhu.id, wuZhu],
      [ming.id, ming],
      [mingSouth.id, mingSouth],
    ]);

    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1367), LANE_GROUPS)).toBe("吴");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1367, 12), LANE_GROUPS)).toBe("吴");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1368), LANE_GROUPS)).toBe("明");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1400), LANE_GROUPS)).toBe("明");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1643, 12), LANE_GROUPS)).toBe("明");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1644), LANE_GROUPS)).toBe("南明");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1660), LANE_GROUPS)).toBe("南明");
  });

  it("keeps song-north and song-south as separate lanes", () => {
    const collapsed = collapseDynastyLaneGroups([tang, songNorth, songSouth], undefined, LANE_GROUPS);

    expect(collapsed.map((dynasty) => dynasty.id)).toEqual(["tang", "song-north", "song-south"]);
  });

  it("keeps zhou-west and zhou-east as separate lanes", () => {
    const collapsed = collapseDynastyLaneGroups([tang, zhouWest, zhouEast], undefined, LANE_GROUPS);

    expect(collapsed.map((dynasty) => dynasty.id)).toEqual(["zhou-west", "zhou-east", "tang"]);
  });

  it("keeps jin-west and jin-east as separate lanes", () => {
    const collapsed = collapseDynastyLaneGroups([tang, jinWest, jinEast], undefined, LANE_GROUPS);

    expect(collapsed.map((dynasty) => dynasty.id)).toEqual(["jin-west", "jin-east", "tang"]);
  });

  it("scopes layout buckets to phase dynasties inside a lane group", () => {
    const laneReigns: Reign[] = [
      {
        id: "reign-temujin",
        dynastyId: "mongol-empire",
        personId: "temujin",
        title: "成吉思汗",
        eraNames: [],
        start: { year: 1206, month: 1 },
        end: { year: 1227, month: 1 },
        startAbs: mongolEmpire.startAbs,
        endAbs: absMonth(1227),
        precision: "year",
      },
      {
        id: "reign-hu-bilie",
        dynastyId: "yuan",
        personId: "hu-bilie",
        title: "元世祖",
        eraNames: [],
        start: { year: 1271, month: 12 },
        end: { year: 1294, month: 1 },
        startAbs: yuan.startAbs,
        endAbs: absMonth(1294),
        precision: "year",
      },
    ];

    expect(layoutBucketsForLaneReigns(laneReigns, LANE_GROUPS).map((bucket) => bucket.map((reign) => reign.id))).toEqual([
      ["reign-temujin"],
      ["reign-hu-bilie"],
    ]);
    expect(reignsInLayoutBucket(laneReigns[1]!, laneReigns, LANE_GROUPS).map((reign) => reign.id)).toEqual([
      "reign-hu-bilie",
    ]);
  });

  it("collects reigns from every member dynasty in a lane group", () => {
    const reignsByDynasty = new Map<string, Reign[]>([
      [
        "mongol-empire",
        [
          {
            id: "reign-temujin",
            dynastyId: "mongol-empire",
            personId: "temujin",
            start: { year: 1206, month: 1 },
            end: { year: 1227, month: 1 },
            startAbs: absMonth(1206),
            endAbs: absMonth(1227),
            eraNames: [],
          },
        ],
      ],
      [
        "yuan",
        [
          {
            id: "reign-hu-bilie",
            dynastyId: "yuan",
            personId: "hu-bilie",
            start: { year: 1271, month: 12 },
            end: { year: 1294, month: 1 },
            startAbs: absMonth(1271, 12),
            endAbs: absMonth(1294),
            eraNames: [],
          },
        ],
      ],
    ]);

    const reigns = collectLaneReigns("yuan", reignsByDynasty, LANE_GROUPS);
    expect(reigns.map((reign) => reign.id)).toEqual(["reign-temujin", "reign-hu-bilie"]);
  });
});
