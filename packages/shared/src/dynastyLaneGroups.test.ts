import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import {
  collapseDynastyLaneGroups,
  collectLaneReigns,
  resolveFrozenLabelAnchorAbs,
  resolveFrozenLaneLabel,
} from "./dynastyLaneGroups";
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

    expect(resolveFrozenLaneLabel(yuan, byId, absMonth(1250))).toBe("蒙古帝国");
    expect(resolveFrozenLaneLabel(yuan, byId, absMonth(1271, 11))).toBe("蒙古帝国");
    expect(resolveFrozenLaneLabel(yuan, byId, absMonth(1271, 12))).toBe("元");
    expect(resolveFrozenLaneLabel(yuan, byId, absMonth(1300))).toBe("元");
  });

  it("uses the label anchor so a phase switch is not tied to viewport center", () => {
    const byId = new Map([
      [mongolEmpire.id, mongolEmpire],
      [yuan.id, yuan],
    ]);
    const yuanStart = yuan.startAbs;
    const pxPerMonth = 1.5;
    const halfWindow = 1200 / pxPerMonth / 2;
    const centerAbs = yuanStart + 100;
    const labelAnchorAbs = resolveFrozenLabelAnchorAbs(
      centerAbs - halfWindow,
      pxPerMonth,
    );

    expect(centerAbs).toBeGreaterThan(yuanStart);
    expect(labelAnchorAbs).toBeLessThan(yuanStart);
    expect(resolveFrozenLaneLabel(yuan, byId, labelAnchorAbs)).toBe("蒙古帝国");
    expect(resolveFrozenLaneLabel(yuan, byId, centerAbs)).toBe("元");
  });

  it("collapses mongol empire and yuan into one lane anchored on yuan", () => {
    const collapsed = collapseDynastyLaneGroups([tang, mongolEmpire, yuan]);

    expect(collapsed.map((dynasty) => dynasty.id)).toEqual(["tang", "yuan"]);
    expect(collapsed[1]).toMatchObject({
      id: "yuan",
      name: "元",
      startAbs: mongolEmpire.startAbs,
      endAbs: yuan.endAbs,
    });
  });

  it("still merges when only the pre-yuan member is visible", () => {
    const collapsed = collapseDynastyLaneGroups([mongolEmpire]);

    expect(collapsed).toHaveLength(1);
    expect(collapsed[0]).toMatchObject({
      id: "yuan",
      startAbs: mongolEmpire.startAbs,
      endAbs: yuan.endAbs,
    });
  });

  it("keeps lane sort span when only the later song phase is visible", () => {
    const catalog = new Map([
      [songNorth.id, songNorth],
      [songSouth.id, songSouth],
    ]);
    const collapsed = collapseDynastyLaneGroups([songSouth], catalog);

    expect(collapsed).toHaveLength(1);
    expect(collapsed[0]).toMatchObject({
      id: "song-north",
      startAbs: songNorth.startAbs,
      endAbs: songSouth.endAbs,
    });
  });

  it("keeps lane sort span without catalog when only the later song phase is visible", () => {
    const collapsed = collapseDynastyLaneGroups([songSouth]);

    expect(collapsed).toHaveLength(1);
    expect(collapsed[0]).toMatchObject({
      id: "song-north",
      startAbs: songNorth.startAbs,
      endAbs: songSouth.endAbs,
    });
  });

  it("collapses wu-zhu, ming, and ming-south into one lane anchored on ming", () => {
    const collapsed = collapseDynastyLaneGroups([wuZhu, ming, mingSouth, tang]);

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

    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1367))).toBe("吴");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1367, 12))).toBe("吴");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1368))).toBe("明");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1400))).toBe("明");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1643, 12))).toBe("明");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1644))).toBe("南明");
    expect(resolveFrozenLaneLabel(ming, byId, absMonth(1660))).toBe("南明");
  });

  it("collapses song-north and song-south into one lane", () => {
    const collapsed = collapseDynastyLaneGroups([tang, songNorth, songSouth]);

    expect(collapsed.map((dynasty) => dynasty.id)).toEqual(["tang", "song-north"]);
    expect(collapsed[1]).toMatchObject({
      id: "song-north",
      name: "北宋",
      startAbs: songNorth.startAbs,
      endAbs: songSouth.endAbs,
    });
  });

  it("resolves song-north to song-south across the 1127 boundary", () => {
    const byId = new Map([
      [songNorth.id, songNorth],
      [songSouth.id, songSouth],
    ]);

    expect(resolveFrozenLaneLabel(songNorth, byId, absMonth(1100))).toBe("北宋");
    expect(resolveFrozenLaneLabel(songNorth, byId, absMonth(1126, 12))).toBe("北宋");
    expect(resolveFrozenLaneLabel(songNorth, byId, absMonth(1127))).toBe("南宋");
    expect(resolveFrozenLaneLabel(songNorth, byId, absMonth(1200))).toBe("南宋");
  });

  it("collapses zhou-west and zhou-east into one lane", () => {
    const collapsed = collapseDynastyLaneGroups([tang, zhouWest, zhouEast]);

    expect(collapsed.map((dynasty) => dynasty.id)).toEqual(["zhou-west", "tang"]);
    expect(collapsed[0]).toMatchObject({
      id: "zhou-west",
      name: "西周",
      startAbs: zhouWest.startAbs,
      endAbs: zhouEast.endAbs,
    });
  });

  it("resolves zhou-west to zhou-east across the -770 boundary", () => {
    const byId = new Map([
      [zhouWest.id, zhouWest],
      [zhouEast.id, zhouEast],
    ]);

    expect(resolveFrozenLaneLabel(zhouWest, byId, absMonth(-900))).toBe("西周");
    expect(resolveFrozenLaneLabel(zhouWest, byId, absMonth(-771, 12))).toBe("西周");
    expect(resolveFrozenLaneLabel(zhouWest, byId, absMonth(-770))).toBe("东周");
    expect(resolveFrozenLaneLabel(zhouWest, byId, absMonth(-500))).toBe("东周");
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

    const reigns = collectLaneReigns("yuan", reignsByDynasty);
    expect(reigns.map((reign) => reign.id)).toEqual(["reign-temujin", "reign-hu-bilie"]);
  });
});
