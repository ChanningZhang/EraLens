import { describe, expect, it } from "vitest";
import { EventSchema, type Reign } from "./schema";
import { buildEntityDetail } from "./timelineData";

function reign(overrides: Partial<Reign> & { templeName?: string }): Reign {
  const { templeName, ...reignOverrides } = overrides;
  return {
    id: "reign-test",
    dynastyId: "song-north",
    personId: "zhao-kuangyin",
    title: "宋太祖",
    start: { year: 960, month: 1 },
    end: { year: 976, month: 12 },
    startAbs: 0,
    endAbs: 1,
    precision: "year",
    eraNames: ["建隆"],
    preferredAppellation: { kind: "temple", name: "宋太祖" },
    ...reignOverrides,
  };
}

describe("buildEntityDetail reign", () => {
  it("uses the same appellation on cards and detail panels", () => {
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

    expect(detail.title).toBe("赵匡胤");
    expect(detail.subtitle).toBe("北宋 · 太祖");
    expect(detail.facts).toEqual([
      { label: "在位", value: "960 — 976" },
      { label: "庙号", value: "太祖" },
      { label: "年号", value: "建隆" },
    ]);
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
          preferredAppellation: { kind: "regnal", name: "鲁监国" },
          claimTrack: "lu-jian",
          claimLabel: "绍兴监国",
          claimRole: "rival",
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

  it("does not list idioms linked only through person participants", () => {
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
          preferredAppellation: { kind: "regnal", name: "勾践" },
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
    };

    const detail = buildEntityDetail(store, {
      type: "reign",
      id: "reign-gou-jian-yue-chunqiu",
    });

    expect(detail.related).toEqual([]);
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
          kind: "battle" as const,
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
    expect(detail.subtitle).toBe("战事");
    expect(detail.facts).toEqual([
      { label: "时间", value: "公元前1046年" },
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
          kind: "politics" as const,
          timeMode: "point" as const,
          precision: "day" as const,
          at: { year: 1644, month: 12 },
          atAbs: 19739,
          dynastyIds: ["daxi"],
          participantIds: [],
        },
      ],
      relations: [],
    };

    const detail = buildEntityDetail(store, { type: "event", id: "daxi-founded" });

    expect(detail.subtitle).toBe("大西");
    expect(detail.dynastyId).toBe("daxi");
    expect(detail.facts).toEqual([
      { label: "时间", value: "公元1644年12月" },
      { label: "类型", value: "政治" },
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
          timeMode: "circa" as const,
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
      { label: "时间", value: "约公元前2000年 — 公元前1100年" },
      {
        label: "说明",
        value:
          "遗址约前2800–前1100。一期属宝墩文化；二三期三星堆文化约前2000–前1400；著名祭祀坑约前1200–前1000，属四期十二桥。不含宝墩一期。",
      },
    ]);
  });
});

describe("buildEntityDetail dynasty", () => {
  it("groups related idioms and events", () => {
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
    };

    const detail = buildEntityDetail(store, { type: "dynasty", id: "shu" });

    expect(detail.related.map((item) => item.group)).toEqual(["idiom", "event"]);
    expect(detail.related[0]?.label).toBe("三顾茅庐");
    expect(detail.related[1]?.label).toBe("赤壁之战");
  });
});

describe("buildEntityDetail person", () => {
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
    };

    const detail = buildEntityDetail(store, { type: "person", id: "gou-jian" });

    expect(detail.related.map((item) => item.group)).toEqual(["reign", "idiom"]);
    expect(detail.related[0]).toMatchObject({
      ref: { type: "reign", id: "reign-gou-jian-yue-chunqiu" },
      label: "越 · 越王勾践",
      subtitle: "-496 — -464",
      group: "reign",
    });
    expect(detail.related[1]?.label).toBe("卧薪尝胆");
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
          ancestralXing: "姬",
          clanShi: "曹",
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
          startAbs: -200,
          endAbs: -150,
          precision: "year",
          eraNames: [],
        },
      ],
      persons: [
        {
          id: "cao-gongbo",
          name: "姬侯",
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

    expect(detail.title).toBe("宫伯");
    expect(detail.facts).toEqual([
      { label: "姓", value: "姬" },
      { label: "氏", value: "曹" },
      { label: "名", value: "侯" },
      { label: "谥号", value: "宫伯" },
    ]);
    expect(detail.related[0]).toMatchObject({
      ref: { type: "reign", id: "reign-cao-gongbo" },
      label: "曹 · 宫伯",
      subtitle: "-938 — -903",
      group: "reign",
    });
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
          preferredAppellation: { kind: "era", name: "正统" },
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
          eraNames: ["天顺"],
          preferredAppellation: { kind: "era", name: "天顺" },
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

    const detail = buildEntityDetail(store, { type: "person", id: "zhu-qizhen" });

    expect(detail.related.map((item) => item.ref.id)).toEqual([
      "reign-zhu-qizhen-zhengtong",
      "reign-zhu-qizhen-tianshun",
    ]);
    expect(detail.related[0]?.label).toBe("明 · 正统");
    expect(detail.related[1]?.label).toBe("明 · 天顺");
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
      { label: "典故年代", value: "公元207年" },
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
    };

    const detail = buildEntityDetail(store, { type: "event", id: "idiom-san-gu-mao-lu" });

    expect(detail.related.map((item) => item.group)).toEqual(["dynasty", "person"]);
    expect(detail.related[0]?.label).toBe("蜀汉");
    expect(detail.related[1]?.label).toBe("刘备");
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
      capitals: [
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
      ],
    };

    const detail = buildEntityDetail(store, {
      type: "capital",
      id: "cap-tang-changan",
    });

    expect(detail.title).toBe("长安");
    expect(detail.subtitle).toBe("唐 · 陕西省西安市");
    expect(detail.dynastyId).toBe("tang");
    expect(detail.facts).toEqual([
      { label: "归属", value: "唐" },
      { label: "今址", value: "陕西省西安市" },
      { label: "时段", value: "618 — 904" },
      { label: "地位", value: "正都" },
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
