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
  role: "primary" | "secondary" | "temporary" = "primary",
) {
  return { dynastyId, modernName, role };
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

  it("pulls a same-capital successor up directly below its predecessor", () => {
    const dynasties = [
      dynasty("sui", absMonth(581), absMonth(618, 12)),
      dynasty("xliang", absMonth(590), absMonth(617, 12)),
      dynasty("tang", absMonth(618), absMonth(907, 12)),
    ];
    const capitals = [
      capital("sui", "陕西省西安市"),
      capital("xliang", "湖北省荆州市"),
      capital("tang", "陕西省西安市"),
    ];

    // Without capitals: pure time order.
    expect(orderDynastiesForLanes(dynasties, []).map((d) => d.id)).toEqual([
      "sui",
      "xliang",
      "tang",
    ]);

    // With capitals: 唐 (同都长安/西安) is pulled up directly below 隋,
    // ahead of the intervening 西梁.
    expect(orderDynastiesForLanes(dynasties, [], capitals).map((d) => d.id)).toEqual([
      "sui",
      "tang",
      "xliang",
    ]);
  });

  it("does not pull a same-city dynasty that reuses the capital much later", () => {
    // 秦 and 西汉 both sat at 西安, but 西汉 begins after 秦 has ended
    // (the 楚汉 interregnum), so it stays in plain time order.
    const dynasties = [
      dynasty("qin", absMonth(-221), absMonth(-206, 12)),
      dynasty("chu", absMonth(-209), absMonth(-202, 12)),
      dynasty("han-west", absMonth(-202), absMonth(8, 12)),
    ];
    const capitals = [
      capital("qin", "陕西省西安市"),
      capital("chu", "江苏省徐州市"),
      capital("han-west", "陕西省西安市"),
    ];

    expect(orderDynastiesForLanes(dynasties, [], capitals).map((d) => d.id)).toEqual([
      "qin",
      "chu",
      "han-west",
    ]);
  });

  it("is single-level: a later same-city dynasty is not cascaded up the chain", () => {
    const dynasties = [
      dynasty("sui", absMonth(581), absMonth(618, 12)),
      dynasty("tang", absMonth(618), absMonth(907, 12)),
      dynasty("luoyang-row", absMonth(700), absMonth(760, 12)),
      dynasty("changan-late", absMonth(900), absMonth(950, 12)),
    ];
    const capitals = [
      capital("sui", "陕西省西安市"),
      capital("tang", "陕西省西安市"),
      capital("luoyang-row", "河南省洛阳市"),
      capital("changan-late", "陕西省西安市"),
    ];

    // 隋 pulls its direct successor 唐 (西安, starts within 隋's span). 唐 does
    // not itself pull further, so changan-late (西安, but starting long after 隋
    // ends) stays in plain time order rather than being cascaded up.
    expect(orderDynastiesForLanes(dynasties, [], capitals).map((d) => d.id)).toEqual([
      "sui",
      "tang",
      "luoyang-row",
      "changan-late",
    ]);
  });

  it("a cluster row pulls its same-city singleton successor but is never itself pulled", () => {
    const dynastyGroups = [group("wudai", absMonth(907), absMonth(960, 12), "五代")];
    const dynasties = [
      dynasty("liang-hou", absMonth(907), absMonth(923, 12), "wudai"),
      dynasty("zhou-hou", absMonth(951), absMonth(960, 12), "wudai"),
      dynasty("liao", absMonth(916), absMonth(1125, 12)),
      dynasty("dali", absMonth(937), absMonth(1253, 12)),
      dynasty("song-north", absMonth(960), absMonth(1127, 12)),
    ];
    const capitals = [
      capital("liang-hou", "河南省开封市"),
      capital("zhou-hou", "河南省开封市"),
      capital("liao", "内蒙古自治区赤峰市巴林左旗"),
      capital("dali", "云南省大理市"),
      capital("song-north", "河南省开封市"),
    ];

    // 北宋 (开封) is pulled directly under the 五代 cluster, ahead of 辽/大理,
    // and stays there regardless of the wider window.
    expect(orderDynastiesForLanes(dynasties, dynastyGroups, capitals).map((d) => d.id)).toEqual([
      "liang-hou",
      "zhou-hou",
      "song-north",
      "liao",
      "dali",
    ]);
  });

  it("ignores non-primary capitals when matching (只按正都)", () => {
    const dynasties = [
      dynasty("a", absMonth(100), absMonth(200, 12)),
      dynasty("b", absMonth(150), absMonth(180, 12)),
      dynasty("c", absMonth(190), absMonth(300, 12)),
    ];
    // c only shares the city as a 陪都, not its 正都 → no pull-up.
    const capitals = [
      capital("a", "城甲"),
      capital("b", "城乙"),
      capital("c", "城甲", "secondary"),
    ];

    expect(orderDynastiesForLanes(dynasties, [], capitals).map((d) => d.id)).toEqual([
      "a",
      "b",
      "c",
    ]);
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
