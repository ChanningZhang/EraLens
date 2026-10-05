import type { CapitalLocation } from "./schema";
import { locationFixture } from "../test/locationFixtures";
import { describe, expect, it } from "vitest";
import { EventSchema, type Reign } from "./schema";
import { absMonth } from "./time";
import { buildEntityDetail } from "./timelineData";

function capitalMappingsFor(reigns: readonly Reign[]) {
  return reigns.map((r) => locationFixture({
    id: `capital-${r.id}`,
    dynastyId: r.dynastyId,
    historicalName: "测试都城",
    modernName: "测试今址",
    longitude: 110,
    latitude: 30,
    coordinateSystem: "GCJ02",
    start: r.start,
    end: r.end,
    startAbs: r.startAbs,
    endAbs: r.endAbs,
    role: "primary",
    links: [],
  }, "reign", r.id));
}

function reign(overrides: Partial<Reign> & { templeName?: string }): Reign {
  const { templeName, ...reignOverrides } = overrides;
  const start = reignOverrides.start ?? { year: 960, month: 1 };
  const end = reignOverrides.end ?? { year: 976, month: 12 };
  const precision = reignOverrides.precision ?? "year";
  return {
    id: "reign-test",
    dynastyId: "song-north",
    personId: "zhao-kuangyin",
    title: "宋太祖",
    eraNames: ["建隆"],
    ...reignOverrides,
    start: { ...start, confidence: start.confidence ?? precision },
    end: { ...end, confidence: end.confidence ?? precision },
    startAbs: absMonth(start.year, start.month),
    endAbs: absMonth(end.year, end.month),
    precision,
  };
}

describe("buildEntityDetail reign", () => {
  it("uses the focused reign title in the detail subtitle", () => {
    const store = {
      dynasties: [
        {
          id: "song-north",
          name: "北宋",
          scope: "cn",
          region: "east_asia",
          start: { year: 960, month: 1 },
          end: { year: 1127, month: 12 },
          startAbs: 0,
          endAbs: 1,
          precision: "year",
          colorToken: "moss",
        },
      ],
      reigns: [reign({})],
      persons: [
        {
          id: "zhao-kuangyin",
          name: "赵匡胤",
          roles: ["皇帝"],
          links: [],
          templeNames: ["太祖"],
        },
      ],
      events: [],
      relations: [],
    };

    const detail = buildEntityDetail(store, { type: "reign", id: "reign-test" });

    expect(detail.ref).toEqual({ type: "person", id: "zhao-kuangyin" });
    expect(detail.title).toBe("赵匡胤");
    expect(detail.subtitle).toBe("北宋 · 宋太祖");
    expect(detail.facts).toEqual([
      { label: "在位", value: "960年 — 976年 · 17年" },
      { label: "庙号", value: "太祖" },
      { label: "年号", value: "建隆" },
    ]);
    expect(detail.capitalTenures).toEqual([]);
  });

  it("pairs capitals with reign tenure rows while retaining focused reign facts", () => {
    const store = {
      dynasties: [
        {
          id: "tang",
          name: "唐",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 618, month: 1 },
          end: { year: 907, month: 12 },
          startAbs: 7416,
          endAbs: 10848,
          precision: "year" as const,
          colorToken: "indigo" as const,
        },
      ],
      reigns: [
        reign({
          id: "reign-tang-test",
          dynastyId: "tang",
          personId: "li-longji",
          title: "唐玄宗",
          start: { year: 712, month: 9 },
          end: { year: 756, month: 8 },
          startAbs: 8544,
          endAbs: 9071,
          precision: "month",
          eraNames: ["开元"],
        }),
      ],
      persons: [
        {
          id: "li-longji",
          name: "李隆基",
          roles: ["皇帝"],
          links: [],
          templeNames: ["玄宗"],
        },
      ],
      events: [],
      relations: [],
      locationMappings: [
        {
          id: "cap-tang-changan",
          dynastyId: "tang",
          historicalName: "长安",
          modernName: "陕西省西安市",
          longitude: 108.939645,
          latitude: 34.343207,
          coordinateSystem: "GCJ02",
          start: { year: 618, month: 1 },
          end: { year: 904, month: 12 },
          startAbs: 7416,
          endAbs: 10848,
          precision: "year",
          role: "primary",
          links: [],
        },
        {
          id: "cap-tang-luoyang",
          dynastyId: "tang",
          historicalName: "洛阳",
          modernName: "河南省洛阳市",
          longitude: 112.453895,
          latitude: 34.619702,
          coordinateSystem: "GCJ02",
          start: { year: 657, month: 1 },
          end: { year: 904, month: 12 },
          startAbs: 7884,
          endAbs: 10848,
          precision: "year",
          role: "secondary",
          links: [],
        },
      ].map(c => locationFixture(c as CapitalLocation,"reign","reign-tang-test")),
    };

    const detail = buildEntityDetail(store, { type: "reign", id: "reign-tang-test" });

    expect(detail.facts).toContainEqual({ label: "在位", value: "712年9月 — 756年8月 · 44年" });
    expect(detail.capitalTenures).toHaveLength(2);
    expect(detail.capitalTenures[0]?.capital.label).toBe("长安");
    expect(detail.capitalTenures[0]?.tenure.label).toBe("712年9月 — 756年8月");
  });

  it("adds claim seat facts for a parallel court", () => {
    const store = {
      dynasties: [
        {
          id: "ming-south",
          name: "南明",
          scope: "cn",
          region: "east_asia",
          start: { year: 1644, month: 1 },
          end: { year: 1662, month: 12 },
          startAbs: 0,
          endAbs: 1,
          precision: "year",
          colorToken: "mineral",
        },
      ],
      reigns: [
        reign({
          id: "reign-zhu-yihai-ming-south",
          dynastyId: "ming-south",
          personId: "zhu-yihai",
          title: "鲁监国",
          start: { year: 1645, month: 1 },
          end: { year: 1653, month: 12 },
          eraNames: [],
          claimTrack: "lu-jian",
          claimLabel: "绍兴监国",
        }),
      ],
      persons: [
        {
          id: "zhu-yihai",
          name: "朱以海",
          roles: ["皇帝"],
          links: [],
        },
      ],
      events: [],
      relations: [],
    };

    const detail = buildEntityDetail(store, {
      type: "reign",
      id: "reign-zhu-yihai-ming-south",
    });
    expect(detail.facts).toEqual(
      expect.arrayContaining([
        { label: "身份", value: "并立" },
        { label: "据点", value: "绍兴监国" },
      ]),
    );
  });

  it("includes person-linked idioms in the unified person detail", () => {
    const store = {
      dynasties: [
        {
          id: "yue-chunqiu",
          name: "越",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: -496, month: 1 },
          end: { year: -306, month: 12 },
          startAbs: -5932,
          endAbs: -3652,
          precision: "year" as const,
          colorToken: "moss" as const,
        },
      ],
      reigns: [
        reign({
          id: "reign-gou-jian-yue-chunqiu",
          dynastyId: "yue-chunqiu",
          personId: "gou-jian",
          title: "越王勾践",
          start: { year: -496, month: 1 },
          end: { year: -464, month: 12 },
          startAbs: -5932,
          endAbs: -5548,
        }),
      ],
      persons: [
        {
          id: "gou-jian",
          name: "勾践",
          roles: ["君主"],
          links: [],
        },
      ],
      events: [
        {
          id: "idiom-wo-xin-chang-dan",
          name: "卧薪尝胆",
          kind: "idiom" as const,
          timeMode: "point" as const,
          precision: "year" as const,
          at: { year: -473, month: 12 },
          atAbs: -5653,
          dynastyIds: ["yue-chunqiu"],
          participantIds: ["gou-jian"],
          meaning: "形容刻苦自励，发愤图强。",
          summary: "勾践战败后屈身事吴，回国卧薪尝胆，最终灭吴称霸。",
        },
      ],
      relations: [],
      associations: [
        {aRef:"event:idiom-wo-xin-chang-dan",bRef:"person:gou-jian"},
      ],

    };

    const detail = buildEntityDetail(store, {
      type: "reign",
      id: "reign-gou-jian-yue-chunqiu",
    });

    expect(detail.related.map((item) => item.group)).toEqual(["idiom"]);
    expect(detail.related[0]?.label).toBe("卧薪尝胆");
  });
});

describe("buildEntityDetail event", () => {
  it("shows a Chinese kind label instead of the stored enum", () => {
    const store = {
      dynasties: [],
      reigns: [],
      persons: [],
      events: [
        {
          id: "muye",
          name: "牧野之战",
          kind: "politics" as const,
          timeMode: "point" as const,
          precision: "year" as const,
          at: { year: -1046, month: 12 },
          atAbs: -12540,
          dynastyIds: [],
          participantIds: [],
          summary: "周武王会师牧野克商，商周分界。",
        },
      ],
      relations: [],
    };

    const detail = buildEntityDetail(store, { type: "event", id: "muye" });

    expect(detail.title).toBe("牧野之战");
    expect(detail.subtitle).toBe("政治");
    expect(detail.facts).toEqual([
      { label: "时间", value: "-1046年" },
      { label: "类型", value: "政治" },
    ]);
  });

  it("shows linked dynasty names for events with dynastyIds", () => {
    const store = {
      dynasties: [
        {
          id: "daxi",
          name: "大西",
          altNames: [],
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 1644, month: 12 },
          end: { year: 1647, month: 12 },
          startAbs: 19739,
          endAbs: 19775,
          precision: "month" as const,
        },
      ],
      reigns: [],
      persons: [],
      events: [
        {
          id: "daxi-founded",
          name: "大西政权建立",
          kind: "battle" as const,
          timeMode: "point" as const,
          precision: "month" as const,
          at: { year: 1644, month: 12, confidence: "month" },
          atAbs: 19739,
          dynastyIds: ["daxi"],
          participantIds: [],
        },
      ],
      relations: [],
      associations: [
        {aRef:"dynasty:daxi",bRef:"event:daxi-founded"},
      ],

    };

    const detail = buildEntityDetail(store, { type: "event", id: "daxi-founded" });

    expect(detail.subtitle).toBe("大西");
    expect(detail.dynastyId).toBe("daxi");
    expect(detail.related).toEqual([
      expect.objectContaining({ ref: { type: "dynasty", id: "daxi" }, label: "大西" }),
    ]);
    expect(detail.facts).toEqual([
      { label: "时间", value: "1644年12月" },
      { label: "类型", value: "军事" },
    ]);
  });

  it("includes all linked dynasties in a political event's related entities", () => {
    const store = {
      dynasties: [
        {
          id: "zhou-east", name: "东周", altNames: [], scope: "cn" as const,
          region: "east_asia", start: { year: -770, month: 1 },
          end: { year: -256, month: 12 }, startAbs: -9228, endAbs: -3049,
          precision: "year" as const,
        },
        {
          id: "jin", name: "晋", altNames: [], scope: "cn" as const,
          region: "east_asia", start: { year: -1033, month: 1 },
          end: { year: -376, month: 12 }, startAbs: -12384, endAbs: -4489,
          precision: "year" as const,
        },
      ],
      reigns: [], persons: [], relations: [],
      associations: [
        {aRef:"dynasty:jin",bRef:"event:xie-wang-killed"},
        {aRef:"dynasty:zhou-east",bRef:"event:xie-wang-killed"},
      ],

      events: [EventSchema.parse({
        id: "xie-wang-killed", name: "晋文侯杀携王", kind: "politics",
        atAbs: -8977, dynastyIds: ["zhou-east", "jin"], participantIds: [],
      })],
    };
    const detail = buildEntityDetail(store, { type: "event", id: "xie-wang-killed" });
    expect(detail.related).toEqual([
      expect.objectContaining({ ref: { type: "dynasty", id: "jin" }, label: "晋" }),
      expect.objectContaining({ ref: { type: "dynasty", id: "zhou-east" }, label: "东周" }),
    ]);
  });

  it("shows dateNote as a reader-facing 说明 fact", () => {
    const store = {
      dynasties: [],
      reigns: [],
      persons: [],
      events: [
        {
          id: "sanxingdui",
          name: "三星堆文化",
          kind: "culture" as const,
          timeMode: "span" as const,
          precision: "century" as const,
          dateNote:
            "遗址约前2800–前1100。一期属宝墩文化；二三期三星堆文化约前2000–前1400；著名祭祀坑约前1200–前1000，属四期十二桥。不含宝墩一期。",
          start: { year: -2000, month: 1 },
          end: { year: -1100, month: 12 },
          startAbs: -23988,
          endAbs: -13177,
          at: { year: -1200, month: 1 },
          atAbs: -14388,
          dynastyIds: [],
          participantIds: [],
        },
      ],
      relations: [],
    };

    const detail = buildEntityDetail(store, { type: "event", id: "sanxingdui" });

    expect(detail.subtitle).toBe("文化");
    expect(detail.facts).toEqual([
      { label: "时间", value: "-2000年 — -1100年" },
      { label: "类型", value: "文化" },
      {
        label: "说明",
        value:
          "遗址约前2800–前1100。一期属宝墩文化；二三期三星堆文化约前2000–前1400；著名祭祀坑约前1200–前1000，属四期十二桥。不含宝墩一期。",
      },
    ]);
  });
});

describe("buildEntityDetail dynasty", () => {
  it("groups related capitals, idioms and events", () => {
    const store = {
      dynasties: [
        {
          id: "shu",
          name: "蜀汉",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 221, month: 5 },
          end: { year: 263, month: 12 },
          startAbs: 100,
          endAbs: 200,
          precision: "year" as const,
          colorToken: "moss" as const,
        },
      ],
      reigns: [],
      persons: [],
      events: [
        {
          id: "idiom-san-gu-mao-lu",
          name: "三顾茅庐",
          kind: "idiom" as const,
          timeMode: "point" as const,
          precision: "year" as const,
          at: { year: 207, month: 12 },
          atAbs: 90,
          dynastyIds: ["shu"],
          participantIds: ["liu-bei"],
          meaning: "比喻诚心诚意地一再邀请或拜访。",
          summary: "刘备三请诸葛亮。",
        },
        {
          id: "chibi",
          name: "赤壁之战",
          kind: "battle" as const,
          timeMode: "point" as const,
          precision: "year" as const,
          at: { year: 208, month: 12 },
          atAbs: 102,
          dynastyIds: ["shu"],
          participantIds: [],
        },
      ],
      relations: [],
      associations: [
        {aRef:"dynasty:shu",bRef:"event:chibi"},
        {aRef:"dynasty:shu",bRef:"event:idiom-san-gu-mao-lu"},
      ],

      locationMappings: [
        {
          id: "cap-shu-chengdu",
          dynastyId: "shu",
          historicalName: "成都",
          modernName: "四川省成都市",
          longitude: 104.066301,
          latitude: 30.572961,
          coordinateSystem: "GCJ02",
          start: { year: 221, month: 5 },
          end: { year: 263, month: 12 },
          startAbs: 100,
          endAbs: 200,
          precision: "year",
          role: "primary",
          links: [],
        },
      ].map(c => locationFixture(c as CapitalLocation,"dynasty",c.dynastyId)),
    };

    const detail = buildEntityDetail(store, { type: "dynasty", id: "shu" });

    expect(detail.related.map((item) => item.group)).toEqual(["location_mapping", "idiom", "event"]);
    expect(detail.related[0]?.label).toBe("成都");
    expect(detail.related[0]?.subtitle).toBe("221年 — 263年 · 主要治所");
    expect(detail.related[1]?.label).toBe("三顾茅庐");
    expect(detail.related[2]?.label).toBe("赤壁之战");
  });
});

describe("buildEntityDetail undated dynasty associations", () => {
  it("shows undated association endpoints without inventing dates", () => {
    const store = {
      dynasties: [{
        id: "test-state", name: "测试", scope: "cn", region: "east_asia",
        start: { year: -1000, month: 1 }, end: { year: -700, month: 12 },
        startAbs: -11988, endAbs: -8377, precision: "year", colorToken: "moss",
      }],
      reigns: [], events: [],
      persons: ["first", "second", "unrelated"].map((id) => ({
        id, name: id, roles: ["君主身份待考"], links: [],
      })),
      relations: [],
      associations: [
        {aRef:"dynasty:test-state",bRef:"person:first"},
        {aRef:"dynasty:test-state",bRef:"person:second"},
      ],
    };
    const detail = buildEntityDetail(store, { type: "dynasty", id: "test-state" });
    expect(detail.related.map((item) => item.ref.id)).toEqual(["first", "second"]);
    expect(detail.related.every((item) => item.group === "person" && item.abs === undefined)).toBe(true);
  });
});

describe("buildEntityDetail person", () => {
  it("uses person title without focus but only period fallback for a focused reign", () => {
    const store = {
      dynasties: [{
        id: "han-west", name: "西汉", scope: "cn" as const, region: "east_asia",
        altNames: ["西汉"],
        start: { year: -202, month: 1 }, end: { year: 9, month: 12 },
        startAbs: -2412, endAbs: 119, precision: "year" as const,
        colorToken: "moss" as const,
      }],
      reigns: [reign({
        id: "reign-unnamed-ruler", dynastyId: "han-west", personId: "unnamed-ruler",
        title: "", eraNames: [],
        start: { year: -188, month: 9 }, end: { year: -184, month: 6 },
        startAbs: -2236, endAbs: -2191,
      })],
      persons: [{
        id: "unnamed-ruler", name: "刘？", dynastyId: "han-west", title: "汉前少帝", roles: ["皇帝"],
        links: [], posthumousNames: [], templeNames: [],
      }],
      events: [], relations: [],
    };
    expect(buildEntityDetail(store, { type: "person", id: "unnamed-ruler" })).toMatchObject({
      title: "刘？", subtitle: "西汉 · 汉前少帝",
    });
    expect(buildEntityDetail(store, { type: "reign", id: "reign-unnamed-ruler" })).toMatchObject({
      title: "刘？", subtitle: "西汉 · 汉前少帝",
    });
  });

  it("uses birth year to choose an unfocused heading and generic fields without a date", () => {
    const store = {
      dynasties: [],
      reigns: [],
      persons: [
        {
          id: "born-pre-qin", name: "先秦人物", birth: { year: -500, month: 1 },
          title: "人物称号", roles: ["君主"], posthumousNames: ["某公"], templeNames: [], links: [],
        },
        {
          id: "born-tang", name: "唐代人物", birth: { year: 700, month: 1 },
          title: "人物称号", roles: ["君主"], posthumousNames: ["谥号"], templeNames: ["某宗"], links: [],
        },
        {
          id: "undated", name: "无年代人物", title: "通用称号", roles: ["人物"],
          posthumousNames: [], templeNames: [], links: [],
        },
        {
          id: "undated-untitled", name: "无称号人物", roles: ["人物"],
          posthumousNames: [], templeNames: [], links: [],
        },
      ],
      events: [],
      relations: [],
    };

    expect(buildEntityDetail(store, { type: "person", id: "born-pre-qin" }).subtitle).toBe("某公");
    expect(buildEntityDetail(store, { type: "person", id: "born-tang" }).subtitle).toBe("某宗");
    expect(buildEntityDetail(store, { type: "person", id: "undated" }).subtitle).toBe("通用称号");
    expect(buildEntityDetail(store, { type: "person", id: "undated-untitled" }).subtitle).toBe("无称号人物");
  });

  it("lists related idioms for participants", () => {
    const store = {
      dynasties: [],
      reigns: [],
      persons: [
        {
          id: "lin-xiangru",
          name: "蔺相如",
          roles: ["政治家"],
          posthumousNames: [],
          templeNames: [],
        },
      ],
      events: [
        {
          id: "idiom-wan-bi-gui-zhao",
          name: "完璧归赵",
          kind: "idiom" as const,
          timeMode: "point" as const,
          precision: "year" as const,
          at: { year: -259, month: 12 },
          atAbs: -3085,
          dynastyIds: ["zhao-warring", "qin"],
          participantIds: ["lin-xiangru"],
          meaning: "比喻把原物完好地归还本人。",
          summary: "蔺相如持和氏璧入秦。",
        },
      ],
      relations: [],
      associations: [
        {aRef:"event:idiom-wan-bi-gui-zhao",bRef:"person:lin-xiangru"},
      ],

    };

    const detail = buildEntityDetail(store, { type: "person", id: "lin-xiangru" });

    expect(detail.related.map((item) => item.group)).toEqual(["idiom"]);
    expect(detail.related[0]?.label).toBe("完璧归赵");
  });

  it("lists reign cards for monarch participants", () => {
    const store = {
      dynasties: [
        {
          id: "yue-chunqiu",
          name: "越",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: -496, month: 1 },
          end: { year: -306, month: 12 },
          startAbs: -5932,
          endAbs: -3652,
          precision: "year" as const,
          colorToken: "moss" as const,
        },
      ],
      reigns: [
        {
          id: "reign-gou-jian-yue-chunqiu",
          dynastyId: "yue-chunqiu",
          personId: "gou-jian",
          title: "越王勾践",
          start: { year: -496, month: 1 },
          end: { year: -464, month: 12 },
          startAbs: -5932,
          endAbs: -5548,
          precision: "year",
          eraNames: [],
        },
      ],
      persons: [
        {
          id: "gou-jian",
          name: "勾践",
          roles: ["君主"],
          posthumousNames: [],
          templeNames: [],
          bio: "越王勾践，越国君主。",
        },
      ],
      events: [
        {
          id: "idiom-wo-xin-chang-dan",
          name: "卧薪尝胆",
          kind: "idiom" as const,
          timeMode: "point" as const,
          precision: "year" as const,
          at: { year: -473, month: 12 },
          atAbs: -5653,
          dynastyIds: ["yue-chunqiu"],
          participantIds: ["gou-jian"],
          meaning: "形容刻苦自励，发愤图强。",
          summary: "勾践战败后屈身事吴，回国卧薪尝胆，最终灭吴称霸。",
        },
      ],
      relations: [],
      associations: [
        {aRef:"event:idiom-wo-xin-chang-dan",bRef:"person:gou-jian"},
      ],

    };

    const detail = buildEntityDetail(store, { type: "person", id: "gou-jian" });

    expect(detail.related.map((item) => item.group)).toEqual(["idiom"]);
    expect(detail.related[0]?.label).toBe("卧薪尝胆");
    expect(detail.capitalTenures).toEqual([]);
  });

  it("shows pre-Qin appellation as title and dynasty-appellation on reign cards", () => {
    const store = {
      dynasties: [
        {
          id: "cao-chunqiu",
          name: "曹",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: -1046, month: 1 },
          end: { year: -487, month: 12 },
          startAbs: -100,
          endAbs: -50,
          precision: "year" as const,
          colorToken: "rose" as const,
        },
      ],
      reigns: [
        {
          id: "reign-cao-gongbo",
          dynastyId: "cao-chunqiu",
          personId: "cao-gongbo",
          title: "曹宫伯",
          start: { year: -938, month: 1 },
          end: { year: -903, month: 12 },
          startAbs: absMonth(-938, 1),
          endAbs: absMonth(-903, 12),
          precision: "year",
          eraNames: [],
        },
      ],
      persons: [
        {
          id: "cao-gongbo",
          name: "侯",
          ancestralXing: "姬",
          clanShi: "曹",
          roles: ["君主"],
          posthumousNames: ["宫伯"],
          templeNames: [],
          bio: "曹宫伯，曹国君主。",
        },
      ],
      events: [],
      relations: [],
    };

    const detail = buildEntityDetail(store, { type: "person", id: "cao-gongbo" });

    expect(detail.title).toBe("侯");
    expect(detail.facts).toEqual([
      { label: "在位", value: "-938年 — -903年 · 36年" },
      { label: "姓", value: "姬" },
      { label: "氏", value: "曹" },
      { label: "名", value: "侯" },
      { label: "谥号", value: "宫伯" },
    ]);
    expect(detail.related).toEqual([]);
    expect(detail.capitalTenures).toEqual([]);
  });

  it("lists multiple reigns in chronological order", () => {
    const store = {
      dynasties: [
        {
          id: "ming",
          name: "明",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 1368, month: 1 },
          end: { year: 1644, month: 12 },
          startAbs: 100,
          endAbs: 200,
          precision: "year" as const,
          colorToken: "moss" as const,
        },
      ],
      reigns: [
        reign({
          id: "reign-zhu-qizhen-zhengtong",
          dynastyId: "ming",
          personId: "zhu-qizhen",
          title: "明英宗",
          start: { year: 1436, month: 1 },
          end: { year: 1449, month: 12 },
          startAbs: 10,
          endAbs: 20,
          eraNames: ["正统"],
        }),
        reign({
          id: "reign-zhu-qizhen-tianshun",
          dynastyId: "ming",
          personId: "zhu-qizhen",
          title: "明英宗",
          start: { year: 1457, month: 1 },
          end: { year: 1464, month: 12 },
          startAbs: 30,
          endAbs: 40,
          eraNames: [],
        }),
      ],
      persons: [
        {
          id: "zhu-qizhen",
          name: "朱祁镇",
          roles: ["皇帝"],
          posthumousNames: [],
          templeNames: [],
          links: [],
        },
      ],
      events: [],
      relations: [],
    };

    const detail = buildEntityDetail({ ...store, locationMappings: capitalMappingsFor(store.reigns) }, { type: "person", id: "zhu-qizhen" });

    expect(detail.related).toEqual([]);
    expect(detail.capitalTenures.map((row) => row.tenure.ref.id)).toEqual([
      "reign-zhu-qizhen-zhengtong",
      "reign-zhu-qizhen-tianshun",
    ]);
    expect(detail.capitalTenures[0]?.tenure.label).toBe("1436年 — 1449年");
    expect(detail.capitalTenures[1]?.tenure.label).toBe("1457年 — 1464年");
    expect(detail.capitalTenures.map((row) => row.tenure.name)).toEqual([
      undefined,
      undefined,
    ]);
  });

  it("keeps dates visible when multiple reigns have no stored title or era name", () => {
    const store = {
      dynasties: [],
      reigns: [
        reign({
          id: "first-reign",
          personId: "ruler",
          title: "",
          eraNames: [],
          start: { year: 684, month: 1 },
          end: { year: 690, month: 12 },
          startAbs: 10,
          endAbs: 20,
        }),
        reign({
          id: "second-reign",
          personId: "ruler",
          title: "",
          eraNames: [],
          start: { year: 710, month: 1 },
          end: { year: 712, month: 12 },
          startAbs: 30,
          endAbs: 40,
        }),
      ],
      persons: [{
        id: "ruler",
        name: "李旦",
        roles: ["皇帝"],
        posthumousNames: [],
        templeNames: [],
        links: [],
      }],
      events: [],
      relations: [],
    };

    const detail = buildEntityDetail({ ...store, locationMappings: capitalMappingsFor(store.reigns) }, { type: "person", id: "ruler" });
    expect(detail.capitalTenures.map((row) => row.tenure.name)).toEqual([
      undefined,
      undefined,
    ]);
    expect(detail.capitalTenures.map((row) => row.tenure.label)).toEqual([
      "684年 — 690年",
      "710年 — 712年",
    ]);
  });

  it("orders reigns starting in the same month by day", () => {
    const store = {
      dynasties: [],
      reigns: [
        reign({
          id: "reign-zhu-qiyu-ming",
          personId: "zhu-qiyu",
          start: { year: 1449, month: 9, day: 22 },
          end: { year: 1457, month: 2, day: 24 },
          startAbs: 17396,
          endAbs: 17485,
          precision: "day",
          isInformalMonarch: false,
        }),
        reign({
          id: "reign-zhu-qiyu-regent-ming",
          personId: "zhu-qiyu",
          start: { year: 1449, month: 9, day: 6 },
          end: { year: 1449, month: 9, day: 22 },
          startAbs: 17396,
          endAbs: 17396,
          precision: "day",
          isInformalMonarch: true,
        }),
      ],
      persons: [{
        id: "zhu-qiyu",
        name: "朱祁钰",
        roles: ["皇帝"],
        posthumousNames: [],
        templeNames: [],
        links: [],
      }],
      events: [],
      relations: [],
    };

    const detail = buildEntityDetail({ ...store, locationMappings: capitalMappingsFor(store.reigns) }, { type: "person", id: "zhu-qiyu" });
    expect(detail.capitalTenures.map((row) => row.tenure.ref.id)).toEqual([
      "reign-zhu-qiyu-regent-ming",
      "reign-zhu-qiyu-ming",
    ]);
    expect(detail.capitalTenures.map((row) => row.tenure.label)).toEqual([
      "1449年9月6日 — 1449年9月22日",
      "1449年9月23日 — 1457年2月24日",
    ]);
    expect(detail.capitalTenures.map((row) => row.tenure.isInformalMonarch)).toEqual([
      true,
      undefined,
    ]);
  });

  it("matches reign detail when focusing a single reign on a person", () => {
    const store = {
      dynasties: [
        {
          id: "song-north",
          name: "北宋",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 960, month: 1 },
          end: { year: 1127, month: 12 },
          startAbs: 0,
          endAbs: 1,
          precision: "year" as const,
          colorToken: "moss" as const,
        },
      ],
      reigns: [reign({})],
      persons: [
        {
          id: "zhao-kuangyin",
          name: "赵匡胤",
          roles: ["皇帝"],
          links: [],
          templeNames: ["太祖"],
        },
      ],
      events: [],
      relations: [],
    };

    const reignDetail = buildEntityDetail(store, { type: "reign", id: "reign-test" });
    const personDetail = buildEntityDetail(
      store,
      { type: "person", id: "zhao-kuangyin" },
      { focusReignId: "reign-test" },
    );

    expect(reignDetail.ref).toEqual({ type: "person", id: "zhao-kuangyin" });
    expect(personDetail).toMatchObject({
      title: reignDetail.title,
      subtitle: reignDetail.subtitle,
      facts: reignDetail.facts,
      capitalTenures: reignDetail.capitalTenures,
    });
  });

  it("limits capital tenures to the focused reign on a multi-reign person", () => {
    const store = {
      dynasties: [
        {
          id: "wu-zhu",
          name: "吴",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 1364, month: 1 },
          end: { year: 1368, month: 1 },
          startAbs: 10,
          endAbs: 20,
          precision: "year" as const,
          colorToken: "cinnabar" as const,
        },
        {
          id: "ming",
          name: "明",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 1368, month: 1 },
          end: { year: 1644, month: 12 },
          startAbs: 30,
          endAbs: 40,
          precision: "year" as const,
          colorToken: "cinnabar" as const,
        },
      ],
      reigns: [
        reign({
          id: "reign-zhu-yuanzhang-wu-zhu",
          dynastyId: "wu-zhu",
          personId: "zhu-yuanzhang",
          title: "吴王",
          start: { year: 1364, month: 2 },
          end: { year: 1368, month: 1 },
          startAbs: 11,
          endAbs: 19,
          precision: "month",
          eraNames: ["吴"],
        }),
        reign({
          id: "reign-zhu-yuanzhang-ming",
          dynastyId: "ming",
          personId: "zhu-yuanzhang",
          title: "洪武",
          start: { year: 1368, month: 1 },
          end: { year: 1398, month: 6 },
          startAbs: 31,
          endAbs: 39,
          precision: "month",
          eraNames: ["洪武"],
        }),
      ],
      persons: [
        {
          id: "zhu-yuanzhang",
          name: "朱元璋",
          roles: ["皇帝"],
          links: [],
          templeNames: ["太祖"],
        },
      ],
      events: [],
      relations: [],
    };

    const detail = buildEntityDetail(
      { ...store, locationMappings: capitalMappingsFor(store.reigns) },
      { type: "person", id: "zhu-yuanzhang" },
      { focusReignId: "reign-zhu-yuanzhang-ming" },
    );

    expect(detail.title).toBe("朱元璋");
    expect(detail.subtitle).toBe("明 · 洪武 · 2/2");
    expect(detail.capitalTenures.map((row) => row.tenure.ref.id)).toEqual([
      "reign-zhu-yuanzhang-ming",
    ]);
  });

  it("uses the same appellation heading without a focus reign, minus the ordinal", () => {
    const store = {
      dynasties: [
        {
          id: "ming",
          name: "明",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 1368, month: 1 },
          end: { year: 1644, month: 12 },
          startAbs: 100,
          endAbs: 200,
          precision: "year" as const,
          colorToken: "cinnabar" as const,
        },
      ],
      reigns: [
        reign({
          id: "reign-zhu-qizhen-ming",
          dynastyId: "ming",
          personId: "zhu-qizhen",
          title: "正统",
          start: { year: 1435, month: 1 },
          end: { year: 1449, month: 9 },
          startAbs: 17220,
          endAbs: 17396,
          eraNames: ["正统"],
        }),
        reign({
          id: "reign-zhu-qizhen-ming-2",
          dynastyId: "ming",
          personId: "zhu-qizhen",
          title: "天顺",
          start: { year: 1457, month: 2 },
          end: { year: 1464, month: 2 },
          startAbs: 17485,
          endAbs: 17569,
          eraNames: ["天顺"],
        }),
      ],
      persons: [
        {
          id: "zhu-qizhen",
          name: "朱祁镇",
          title: "皇帝",
          roles: ["皇帝"],
          posthumousNames: ["睿皇帝"],
          templeNames: ["英宗"],
          links: [],
        },
      ],
      events: [],
      relations: [],
    };

    const unfocused = buildEntityDetail(store, { type: "person", id: "zhu-qizhen" });
    const focused = buildEntityDetail(
      store,
      { type: "person", id: "zhu-qizhen" },
      { focusReignId: "reign-zhu-qizhen-ming", reignCount: 2, focusReignIndex: 1 },
    );

    expect(unfocused.subtitle).toBe("明 · 英宗");
    expect(focused.subtitle).toBe("明 · 正统 · 1/2");
    expect(unfocused.reignCount).toBe(2);
    expect(focused.reignCount).toBe(2);
    expect(unfocused.facts.filter((fact) => fact.label === "在位")).toEqual([
      { label: "在位", value: "1435年 — 1449年 · 15年\n1457年 — 1464年 · 8年" },
    ]);
    expect(focused.facts.filter((fact) => fact.label === "在位")).toEqual([
      { label: "在位", value: "1435年 — 1449年 · 15年" },
    ]);
    expect(unfocused.facts.filter((fact) => fact.label === "年号")).toEqual([
      { label: "年号", value: "正统，天顺" },
    ]);
    expect(focused.facts.filter((fact) => fact.label === "年号")).toEqual([
      { label: "年号", value: "正统" },
    ]);
  });
});

describe("buildEntityDetail idiom event", () => {
  it("shows meaning and 典故年代 facts", () => {
    const store = {
      dynasties: [
        {
          id: "shu",
          name: "蜀汉",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 221, month: 5 },
          end: { year: 263, month: 12 },
          startAbs: 100,
          endAbs: 200,
          precision: "year" as const,
          colorToken: "moss" as const,
        },
      ],
      reigns: [],
      persons: [],
      events: [
        {
          id: "idiom-san-gu-mao-lu",
          name: "三顾茅庐",
          kind: "idiom" as const,
          timeMode: "point" as const,
          precision: "year" as const,
          at: { year: 207, month: 12 },
          atAbs: 90,
          dynastyIds: ["shu"],
          participantIds: [],
          meaning: "比喻诚心诚意地一再邀请或拜访。",
          summary: "刘备三请诸葛亮。",
        },
      ],
      relations: [],
    };

    const detail = buildEntityDetail(store, { type: "event", id: "idiom-san-gu-mao-lu" });

    expect(detail.facts).toEqual([
      { label: "释义", value: "比喻诚心诚意地一再邀请或拜访。" },
      { label: "典故年代", value: "207年" },
      { label: "类型", value: "成语" },
    ]);
    expect(detail.summary).toBe("刘备三请诸葛亮。");
  });

  it("lists linked dynasties and participants in related", () => {
    const store = {
      dynasties: [
        {
          id: "shu",
          name: "蜀汉",
          scope: "cn" as const,
          region: "east_asia",
          start: { year: 221, month: 5 },
          end: { year: 263, month: 12 },
          startAbs: 100,
          endAbs: 200,
          precision: "year" as const,
          colorToken: "moss" as const,
        },
      ],
      reigns: [],
      persons: [
        {
          id: "liu-bei",
          name: "刘备",
          roles: ["皇帝"],
          posthumousNames: [],
          templeNames: [],
        },
      ],
      events: [
        {
          id: "idiom-san-gu-mao-lu",
          name: "三顾茅庐",
          kind: "idiom" as const,
          timeMode: "point" as const,
          precision: "year" as const,
          at: { year: 207, month: 12 },
          atAbs: 90,
          dynastyIds: ["shu"],
          participantIds: ["liu-bei"],
          meaning: "比喻诚心诚意地一再邀请或拜访。",
          summary: "刘备三请诸葛亮。",
        },
      ],
      relations: [],
      associations: [
        {aRef:"dynasty:shu",bRef:"event:idiom-san-gu-mao-lu"},
        {aRef:"event:idiom-san-gu-mao-lu",bRef:"person:liu-bei"},
      ],

    };

    const detail = buildEntityDetail(store, { type: "event", id: "idiom-san-gu-mao-lu" });

    expect(detail.related.map((item) => item.group)).toEqual(["dynasty", "person"]);
    expect(detail.related[0]?.label).toBe("蜀汉");
    expect(detail.related[1]?.label).toBe("刘备");
  });
});

describe("buildEntityDetail poetry event", () => {
  it("keeps the poem title and labels its type as 诗歌", () => {
    const store = {
      dynasties: [],
      reigns: [],
      persons: [],
      events: [
        {
          id: "poetry-fengqiao-yebo",
          name: "枫桥夜泊",
          kind: "poetry" as const,
          timeMode: "span" as const,
          precision: "year" as const,
          start: { year: 750, month: 1 },
          end: { year: 770, month: 12 },
          startAbs: 100,
          endAbs: 200,
          dynastyIds: [],
          participantIds: [],
          dateNote: "安史之乱后，约8世纪中叶",
          summary: "张继羁旅途中泊舟枫桥，写下唐代最著名的羁旅诗篇之一。",
          content: "月落乌啼霜满天，江枫渔火对愁眠。\n姑苏城外寒山寺，夜半钟声到客船。",
        },
      ],
      relations: [],
    };

    const detail = buildEntityDetail(store, {
      type: "event",
      id: "poetry-fengqiao-yebo",
    });

    expect(detail.title).toBe("枫桥夜泊");
    expect(detail.subtitle).toBe("诗歌");
    expect(detail.facts).toEqual([
      { label: "类型", value: "诗歌" },
      { label: "说明", value: "安史之乱后，约8世纪中叶" },
    ]);
    expect(detail.content).toBe(
      "月落乌啼霜满天，江枫渔火对愁眠。\n姑苏城外寒山寺，夜半钟声到客船。",
    );
  });
});

describe("buildEntityDetail capital", () => {
  it("shows capital facts and links to the owning dynasty", () => {
    const store = {
      dynasties: [
        {
          id: "tang",
          name: "唐",
          scope: "cn",
          region: "east_asia",
          start: { year: 618, month: 1 },
          end: { year: 907, month: 12 },
          startAbs: 7416,
          endAbs: 10848,
          precision: "year",
          colorToken: "indigo",
        },
      ],
      reigns: [],
      persons: [],
      events: [],
      relations: [],
      locationMappings: [
        {
          id: "cap-tang-changan",
          dynastyId: "tang",
          historicalName: "长安",
          modernName: "陕西省西安市",
          longitude: 108.939645,
          latitude: 34.343207,
          coordinateSystem: "GCJ02",
          start: { year: 618, month: 1 },
          end: { year: 904, month: 12 },
          startAbs: 7416,
          endAbs: 10848,
          precision: "year",
          role: "primary",
          note: "隋唐京师",
          links: [],
        },
      ].map(c => locationFixture(c as CapitalLocation,"dynasty",c.dynastyId)),
    };

    const detail = buildEntityDetail(store, {
      type: "location_mapping",
      id: "cap-tang-changan",
    });

    expect(detail.title).toBe("长安");
    expect(detail.subtitle).toBe("唐 · 陕西省西安市");
    expect(detail.dynastyId).toBe("tang");
    expect(detail.facts).toEqual([
      { label: "归属", value: "唐" },
      { label: "今址", value: "陕西省西安市" },
      { label: "时段", value: "618年 — 904年" },
      { label: "地位", value: "主要治所" },
    ]);
    expect(detail.summary).toBe("隋唐京师");
    expect(detail.related).toEqual([
      {
        ref: { type: "dynasty", id: "tang" },
        label: "唐",
        subtitle: undefined,
        abs: 7416,
        group: "dynasty",
      },
    ]);
  });
});

describe("EventSchema idiom", () => {
  it("rejects span idiom events", () => {
    const result = EventSchema.safeParse({
      id: "bad-idiom",
      name: "错误成语",
      kind: "idiom",
      timeMode: "span",
      startAbs: 1,
      endAbs: 2,
      meaning: "释义",
    });
    expect(result.success).toBe(false);
  });
});
