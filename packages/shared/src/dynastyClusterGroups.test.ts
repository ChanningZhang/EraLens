import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import type { Dynasty, DynastyGroup } from "./schema";
import {
  clusterFramesForLanes,
  compareTimedOrder,
  orderDynastiesForLanes,
} from "./dynastyClusterGroups";

function dynasty(
  id: string,
  startAbs: number,
  endAbs: number,
  groupId?: string,
): Dynasty {
  const startYear = startAbs > 0 ? Math.floor(startAbs / 12) : -Math.floor(-startAbs / 12);
  return {
    id,
    name: id,
    altNames: [],
    scope: "cn",
    region: "east_asia",
    start: { year: startYear, month: 1 },
    end: { year: startYear + 1, month: 12 },
    startAbs,
    endAbs,
    precision: "year",
    colorToken: "ochre",
    groupId,
  };
}

function capital(
  dynastyId: string,
  modernName: string,
  startAbs: number,
  endAbs: number,
) {
  return { dynastyId, modernName, startAbs, endAbs };
}

function group(
  id: string,
  startAbs: number,
  endAbs: number,
  name = id,
): DynastyGroup {
  const startYear = startAbs > 0 ? Math.floor(startAbs / 12) : -Math.floor(-startAbs / 12);
  return {
    id,
    name,
    altNames: [],
    scope: "cn",
    start: { year: startYear, month: 1 },
    end: { year: startYear + 1, month: 12 },
    startAbs,
    endAbs,
    precision: "year",
  };
}

describe("dynastyClusterGroups", () => {
  it("orders cluster units by group span, not member min startAbs", () => {
    const dynastyGroups = [
      group("shiguo", absMonth(907), absMonth(979, 12), "十国"),
      group("wudai", absMonth(907), absMonth(960, 12), "五代"),
    ];
    const dynasties = [
      dynasty("wu-shi", absMonth(902), absMonth(937), "shiguo"),
      dynasty("liang-hou", absMonth(907), absMonth(923), "wudai"),
      dynasty("tang", absMonth(618), absMonth(907)),
    ];

    const ordered = orderDynastiesForLanes(dynasties, dynastyGroups);
    expect(ordered.map((item) => item.id)).toEqual([
      "tang",
      "liang-hou",
      "wu-shi",
    ]);
  });

  it("keeps cluster members contiguous and sorted by startAbs", () => {
    const dynastyGroups = [group("nan-chao", absMonth(420), absMonth(589, 12), "南朝")];
    const dynasties = [
      dynasty("chen-nan", absMonth(557), absMonth(589), "nan-chao"),
      dynasty("song-liu", absMonth(420, 7), absMonth(479), "nan-chao"),
      dynasty("qi-nan", absMonth(479), absMonth(502), "nan-chao"),
      dynasty("xiliang", absMonth(555), absMonth(587), "nan-chao"),
      dynasty("sui", absMonth(581), absMonth(618)),
    ];

    const ordered = orderDynastiesForLanes(dynasties, dynastyGroups);
    expect(ordered.map((item) => item.id)).toEqual([
      "song-liu",
      "qi-nan",
      "xiliang",
      "chen-nan",
      "sui",
    ]);
  });

  it("pulls a hand-off successor up directly below its predecessor", () => {
    const dynasties = [
      dynasty("sui", absMonth(581), absMonth(618, 12)),
      dynasty("xliang", absMonth(590), absMonth(617, 12)),
      dynasty("tang", absMonth(618), absMonth(907, 12)),
    ];
    const capitals = [
      capital("sui", "陕西省西安市", absMonth(581), absMonth(618, 12)),
      capital("xliang", "湖北省荆州市", absMonth(590), absMonth(617, 12)),
      capital("tang", "陕西省西安市", absMonth(618), absMonth(907, 12)),
    ];

    // Without capitals: pure time order.
    expect(orderDynastiesForLanes(dynasties, []).map((d) => d.id)).toEqual([
      "sui",
      "xliang",
      "tang",
    ]);

    // With capitals: 唐 (接手长安) is pulled up directly below 隋, ahead of 西梁.
    expect(orderDynastiesForLanes(dynasties, [], capitals).map((d) => d.id)).toEqual([
      "sui",
      "tang",
      "xliang",
    ]);
  });

  it("matches the capital at the hand-off moment, not one adopted later", () => {
    // 北宋 hands off in 1127 while 金's capital is 会宁; 金 only took 开封 in
    // 1214, so it must NOT be glued under 北宋.
    const dynasties = [
      dynasty("song-north", absMonth(960), absMonth(1127, 12)),
      dynasty("liao", absMonth(916), absMonth(1125, 12)),
      dynasty("jin-nv", absMonth(1115), absMonth(1234, 12)),
    ];
    const capitals = [
      capital("song-north", "河南省开封市", absMonth(960), absMonth(1127, 12)),
      capital("liao", "内蒙古自治区赤峰市巴林左旗", absMonth(916), absMonth(1125, 12)),
      capital("jin-nv", "黑龙江省哈尔滨市阿城区", absMonth(1115), absMonth(1153, 12)),
      capital("jin-nv", "北京市", absMonth(1154), absMonth(1214, 12)),
      capital("jin-nv", "河南省开封市", absMonth(1215), absMonth(1234, 12)),
    ];

    // 金 stays in plain time order (its 开封 tenure is far past the hand-off).
    expect(orderDynastiesForLanes(dynasties, [], capitals).map((d) => d.id)).toEqual([
      "liao",
      "song-north",
      "jin-nv",
    ]);
  });

  it("cascades: a pulled row recursively pulls its own successors", () => {
    const dynasties = [
      dynasty("a", absMonth(100), absMonth(200, 12)),
      dynasty("other", absMonth(150), absMonth(160, 12)),
      dynasty("b", absMonth(200), absMonth(300, 12)),
      dynasty("c", absMonth(300), absMonth(400, 12)),
    ];
    const capitals = [
      capital("a", "城甲", absMonth(100), absMonth(200, 12)),
      capital("other", "城乙", absMonth(150), absMonth(160, 12)),
      capital("b", "城甲", absMonth(200), absMonth(300, 12)),
      capital("c", "城甲", absMonth(300), absMonth(400, 12)),
    ];

    // a → b → c chain together even though c begins long after a ends.
    expect(orderDynastiesForLanes(dynasties, [], capitals).map((d) => d.id)).toEqual([
      "a",
      "b",
      "c",
      "other",
    ]);
  });

  it("matches on any shared capital city, including a 陪都", () => {
    // 唐 keeps 洛阳 as a 陪都; 武周's 洛阳 matches it even though neither is the
    // other's 正都.
    const dynasties = [
      dynasty("tang", absMonth(618), absMonth(907, 12)),
      dynasty("tuyuhun", absMonth(650), absMonth(663, 12)),
      dynasty("wu-zhou", absMonth(690), absMonth(705, 12)),
    ];
    const capitals = [
      capital("tang", "陕西省西安市", absMonth(618), absMonth(907, 12)),
      capital("tang", "河南省洛阳市", absMonth(657), absMonth(907, 12)),
      capital("tuyuhun", "青海省海南藏族自治州", absMonth(650), absMonth(663, 12)),
      capital("wu-zhou", "河南省洛阳市", absMonth(690), absMonth(705, 12)),
    ];

    // 武周 is pulled directly under 唐 (shared 洛阳), ahead of 吐谷浑.
    expect(orderDynastiesForLanes(dynasties, [], capitals).map((d) => d.id)).toEqual([
      "tang",
      "wu-zhou",
      "tuyuhun",
    ]);
  });

  it("pulls a whole cluster under a same-capital predecessor (南朝 under 东晋)", () => {
    const dynastyGroups = [group("nan-chao", absMonth(420), absMonth(589, 12), "南朝")];
    const dynasties = [
      dynasty("jin-east", absMonth(317), absMonth(420, 12)),
      dynasty("bei-wei", absMonth(386), absMonth(534, 12)),
      dynasty("song-liu", absMonth(420), absMonth(479, 12), "nan-chao"),
      dynasty("qi-nan", absMonth(479), absMonth(502, 12), "nan-chao"),
    ];
    const capitals = [
      capital("jin-east", "江苏省南京市", absMonth(317), absMonth(420, 12)),
      capital("bei-wei", "河南省洛阳市", absMonth(386), absMonth(534, 12)),
      capital("song-liu", "江苏省南京市", absMonth(420), absMonth(479, 12)),
      capital("qi-nan", "江苏省南京市", absMonth(479), absMonth(502, 12)),
    ];

    // 南朝 (whole cluster) is pulled under 东晋 (both 建康/南京), ahead of 北魏.
    expect(orderDynastiesForLanes(dynasties, dynastyGroups, capitals).map((d) => d.id)).toEqual([
      "jin-east",
      "song-liu",
      "qi-nan",
      "bei-wei",
    ]);
  });

  it("orders same-capital successors within a cluster (北朝: 西魏 next to 北周)", () => {
    const dynastyGroups = [group("bei-chao", absMonth(386), absMonth(581, 12), "北朝")];
    const dynasties = [
      dynasty("wei-north", absMonth(386), absMonth(534, 12), "bei-chao"),
      dynasty("wei-east", absMonth(534), absMonth(550, 12), "bei-chao"),
      dynasty("wei-west", absMonth(535), absMonth(557, 12), "bei-chao"),
      dynasty("qi-bei", absMonth(550), absMonth(577, 12), "bei-chao"),
      dynasty("zhou-bei", absMonth(557), absMonth(581, 12), "bei-chao"),
    ];
    const capitals = [
      capital("wei-north", "河南省洛阳市", absMonth(386), absMonth(534, 12)),
      capital("wei-east", "河北省邯郸市临漳县", absMonth(534), absMonth(550, 12)),
      capital("wei-west", "陕西省西安市", absMonth(535), absMonth(557, 12)),
      capital("qi-bei", "河北省邯郸市临漳县", absMonth(550), absMonth(577, 12)),
      capital("zhou-bei", "陕西省西安市", absMonth(557), absMonth(581, 12)),
    ];

    // 东魏→北齐 (邺/临漳) and 西魏→北周 (长安/西安) each stack together, so 北齐
    // no longer sits between 西魏 and 北周.
    expect(
      orderDynastiesForLanes(dynasties, dynastyGroups, capitals).map((d) => d.id),
    ).toEqual(["wei-north", "wei-east", "qi-bei", "wei-west", "zhou-bei"]);
  });

  it("uses shorter endAbs to order units with the same startAbs", () => {
    expect(
      compareTimedOrder(
        { id: "bei-chao", startAbs: absMonth(420), endAbs: absMonth(581, 12) },
        { id: "nan-chao", startAbs: absMonth(420), endAbs: absMonth(589, 12) },
      ),
    ).toBeLessThan(0);
  });

  it("wraps the left-rail dynasty chips, not the time-axis lane", () => {
    const dynastyGroups = [group("wudai", absMonth(907), absMonth(960, 12), "五代")];
    const frames = clusterFramesForLanes(
      [
        {
          dynasty: { id: "liang-hou", groupId: "wudai" },
          top: 120,
          height: 64,
          chipTop: 130,
          chipHeight: 44,
        },
        {
          dynasty: { id: "tang-hou", groupId: "wudai" },
          top: 184,
          height: 64,
          chipTop: 194,
          chipHeight: 44,
        },
      ],
      dynastyGroups,
    );

    expect(frames).toHaveLength(1);
    expect(frames[0]?.group.name).toBe("五代");
    expect(frames[0]?.left).toBe(7);
    expect(frames[0]?.width).toBe(90);
    expect(frames[0]?.top).toBe(119);
    expect(frames[0]?.height).toBe(124);
  });
});
