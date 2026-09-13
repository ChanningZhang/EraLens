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
      endAbs: mongolEmpire.endAbs,
    });
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
