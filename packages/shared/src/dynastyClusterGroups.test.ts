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


function capital(
  id: string,
  dynastyId: string,
  modernName: string,
  startAbs: number,
  endAbs: number,
): import("./schema").DynastyCapital {
  const startYear = startAbs > 0 ? Math.floor(startAbs / 12) : -Math.floor(-startAbs / 12);
  const endYear = endAbs > 0 ? Math.floor(endAbs / 12) : -Math.floor(-endAbs / 12);
  return {
    id,
    dynastyId,
    historicalName: modernName,
    modernName,
    longitude: 108.9,
    latitude: 34.3,
    coordinateSystem: "GCJ02",
    start: { year: startYear, month: 1 },
    end: { year: endYear, month: 12 },
    startAbs,
    endAbs,
    precision: "year",
    role: "primary",
    links: [],
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

  it("uses shorter endAbs to order units with the same startAbs", () => {
    expect(
      compareTimedOrder(
        { id: "bei-chao", startAbs: absMonth(420), endAbs: absMonth(581, 12) },
        { id: "nan-chao", startAbs: absMonth(420), endAbs: absMonth(589, 12) },
      ),
    ).toBeLessThan(0);
  });


  it("pulls a same-capital near successor ahead of an earlier foreign-capital rival", () => {
    // 前秦 (长安) ends 394; 后燕 (中山) starts 384; 后秦 (长安) starts 384.
    // Timed order would keep 后燕 before 后秦 when both start together after
    // an intervening pick — with capitals, 后秦 sticks under 前秦.
    const qinQian = dynasty("qin-front", absMonth(351), absMonth(394, 12));
    const yanHou = dynasty("yan-back", absMonth(384), absMonth(409, 12));
    const qinHou = dynasty("qin-back", absMonth(384, 6), absMonth(417, 12));
    const capitals = [
      capital("cap-qin-front", "qin-front", "陕西省西安市", absMonth(351), absMonth(394, 12)),
      capital("cap-yan-back", "yan-back", "河北省定州市", absMonth(384), absMonth(409, 12)),
      capital("cap-qin-back", "qin-back", "陕西省西安市", absMonth(384, 6), absMonth(417, 12)),
    ];

    // Without capitals: startAbs order — yan-back (384-1) before qin-back (384-6).
    expect(
      orderDynastiesForLanes([qinHou, yanHou, qinQian], []).map((d) => d.id),
    ).toEqual(["qin-front", "yan-back", "qin-back"]);

    // With capitals: after 前秦, prefer 后秦 (same 西安) over 后燕.
    expect(
      orderDynastiesForLanes([qinHou, yanHou, qinQian], [], capitals).map((d) => d.id),
    ).toEqual(["qin-front", "qin-back", "yan-back"]);
  });

  it("does not pull a same-capital dynasty across centuries", () => {
    const hanWest = dynasty("han-west", absMonth(-202), absMonth(8, 11));
    const xin = dynasty("xin", absMonth(9), absMonth(23, 10));
    const tang = dynasty("tang", absMonth(618), absMonth(907, 12));
    const capitals = [
      capital("cap-han", "han-west", "陕西省西安市", absMonth(-202), absMonth(8, 11)),
      capital("cap-xin", "xin", "陕西省西安市", absMonth(9), absMonth(23, 10)),
      capital("cap-tang", "tang", "陕西省西安市", absMonth(618), absMonth(907, 12)),
    ];

    expect(
      orderDynastiesForLanes([tang, xin, hanWest], [], capitals).map((d) => d.id),
    ).toEqual(["han-west", "xin", "tang"]);
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
