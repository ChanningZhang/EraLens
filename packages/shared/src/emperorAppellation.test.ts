import { describe, expect, it } from "vitest";
import type { Reign } from "./schema";
import {
  buildPreQinClanContext,
  resolveEmperorAppellation,
  resolveReignCardGivenName,
  resolveReignCardLabel,
  resolveReignCardMeta,
  resolveReignDetailFacts,
  resolveReignDetailSubtitle,
  resolveReignPrimaryLabel,
  stripAncestralXing,
  usesPreQinCardLayout,
} from "./emperorAppellation";

function source(overrides: Partial<Reign>) {
  return {
    start: { year: 1, month: 1 },
    end: { year: 1, month: 12 },
    title: "皇帝",
    posthumousName: undefined,
    templeName: undefined,
    eraNames: [],
    preferredAppellation: undefined,
    ...overrides,
  };
}

describe("resolveEmperorAppellation", () => {
  it("uses a posthumous name before Tang", () => {
    expect(
      resolveEmperorAppellation(
        source({ start: { year: 141, month: 1 }, posthumousName: "孝景皇帝" }),
      ),
    ).toEqual({ kind: "posthumous", name: "孝景皇帝" });
  });

  it("uses the dynastic title for Sui posthumous shorthand", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 581, month: 1 },
          title: "隋文帝",
          posthumousName: "文皇帝",
          eraNames: [{ name: "开皇" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "posthumous", name: "文皇帝" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 604, month: 1 },
          title: "隋炀帝",
          posthumousName: "炀皇帝",
          eraNames: [{ name: "大业" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "posthumous", name: "炀皇帝" });
  });

  it("uses era name for Yuan rulers who never received a temple name", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1323, month: 9 },
          title: "元泰定帝",
          eraNames: [{ name: "泰定" }, { name: "致和" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "era", name: "泰定" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 1323, month: 9 },
          title: "元泰定帝",
          eraNames: [{ name: "泰定" }, { name: "致和" }] as Reign["eraNames"],
        }),
        "也孙铁木儿",
      ),
    ).toEqual({ label: "年号", name: "泰定" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1328, month: 8 },
          title: "元天顺帝",
          eraNames: [{ name: "天顺" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "era", name: "天顺" });
  });

  it("uses a temple name from Tang through Yuan", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 626, month: 1 },
          posthumousName: "文皇帝",
          templeName: "太宗",
          title: "唐太宗",
        }),
      ),
    ).toEqual({ kind: "temple", name: "太宗" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 960, month: 1 },
          posthumousName: "启运立极英武睿文神德圣功至明大孝皇帝",
          templeName: "太祖",
          title: "宋太祖",
        }),
      ),
    ).toEqual({ kind: "temple", name: "太祖" });
  });

  it("prefers temple over posthumous from Tang onward", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 649, month: 1 },
          title: "诏王",
          posthumousName: "奇嘉王",
          templeName: "高祖",
        }),
      ),
    ).toEqual({ kind: "temple", name: "高祖" });
  });

  it("uses an era name for Ming and Qing", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1661, month: 1 },
          templeName: "圣祖",
          eraNames: [{ name: "康熙" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "era", name: "康熙" });
  });

  it("does not treat {regime}帝 placeholders as posthumous names", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1351, month: 1 },
          title: "徐宋帝",
          eraNames: [{ name: "治平" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "era", name: "治平" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1360, month: 1 },
          title: "陈汉帝",
          eraNames: [{ name: "大义" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "era", name: "大义" });
  });

  it("uses the temple name for a late Yuan emperor with a recorded 庙号", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1351, month: 1 },
          title: "徐宋世宗",
          posthumousName: "应天启运献武皇帝",
          templeName: "世宗",
          eraNames: [{ name: "治平" }, { name: "太平" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "temple", name: "世宗" });
  });

  it("falls back to a regnal title when Qin-style names do not exist", () => {
    expect(
      resolveEmperorAppellation(
        source({ start: { year: -221, month: 1 }, title: "始皇帝" }),
      ),
    ).toEqual({ kind: "regnal", name: "始皇帝" });
  });

  it("honors regnal preferred overrides", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: -678, month: 1 },
          title: "秦襄公",
          preferredAppellation: { kind: "regnal", name: "秦襄公" },
        }),
      ),
    ).toEqual({ kind: "regnal", name: "秦襄公" });
  });

  it("ignores stored temple/posthumous preferred and follows year rules", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 649, month: 1 },
          title: "诏王",
          posthumousName: "奇嘉王",
          templeName: "高祖",
          preferredAppellation: { kind: "posthumous", name: "奇嘉王" },
        }),
      ),
    ).toEqual({ kind: "temple", name: "高祖" });
  });

  it("uses 正统 then 天顺 for Zhu Qizhen's two reigns", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1435, month: 1 },
          templeName: "英宗",
          eraNames: [{ name: "正统" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "era", name: "正统" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1457, month: 1 },
          templeName: "英宗",
          eraNames: [{ name: "天顺" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "era", name: "天顺" });
  });
});

describe("resolveReignPrimaryLabel", () => {
  it("shows person name for Ming and Qing emperors", () => {
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: 1661, month: 1 },
          eraNames: [{ name: "康熙" }] as Reign["eraNames"],
        }),
        "爱新觉罗·玄烨",
      ),
    ).toBe("爱新觉罗·玄烨");
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: 1435, month: 1 },
          eraNames: [{ name: "正统" }] as Reign["eraNames"],
        }),
        "朱祁镇",
      ),
    ).toBe("朱祁镇");
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: 1457, month: 1 },
          eraNames: [{ name: "天顺" }] as Reign["eraNames"],
        }),
        "朱祁镇",
      ),
    ).toBe("朱祁镇");
  });

  it("shows person name for earlier dynasties", () => {
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: 626, month: 1 },
          templeName: "太宗",
        }),
        "李世民",
      ),
    ).toBe("李世民");
  });

  it("shows stored posthumous on the card when the person name is clean", () => {
    const reign = source({
      start: { year: -250, month: 1 },
      title: "秦庄襄王",
      posthumousName: "庄襄王",
    });
    const clan = buildPreQinClanContext(null, { ancestralXing: "嬴" });
    expect(resolveReignCardGivenName(reign, "嬴子楚", clan)).toBe("子楚");
    expect(resolveReignPrimaryLabel(reign, "嬴子楚", clan)).toBe("庄襄王");
  });

  it("uses stored regnal body for Zhongshan kings (no runtime state strip)", () => {
    const reign = source({
      start: { year: -327, month: 1 },
      title: "中山王厝",
      preferredAppellation: { kind: "regnal", name: "厝" },
    });
    expect(resolveReignPrimaryLabel(reign)).toBe("厝");
    expect(resolveReignPrimaryLabel(reign, "厝")).toBe("厝");
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: -312, month: 1 },
          title: "中山王胜",
          preferredAppellation: { kind: "regnal", name: "胜" },
        }),
        "胜",
      ),
    ).toBe("胜");
  });

  it("keeps surnames that begin with 王, such as 王莽", () => {
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: 9, month: 1 },
          title: "新莽皇帝",
          preferredAppellation: { kind: "regnal", name: "王莽" },
        }),
        "王莽",
      ),
    ).toBe("王莽");
  });
});

describe("resolveEmperorAppellation for feudal regnal titles", () => {
  it("honors stored regnal preferred bodies", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: -496, month: 1 },
          title: "越王勾践",
          preferredAppellation: { kind: "regnal", name: "勾践" },
        }),
      ),
    ).toEqual({ kind: "regnal", name: "勾践" });
  });

  it("reads posthumous from the stored field, not title parsing", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: -350, month: 1 },
          title: "齐威王",
          posthumousName: "威王",
        }),
      ),
    ).toEqual({ kind: "posthumous", name: "威王" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: -372, month: 1 },
          title: "越王无余",
        }),
      ),
    ).toEqual({ kind: "regnal", name: "越王无余" });
  });
});

describe("resolveReignDetailSubtitle for Yue kings", () => {
  it("omits a redundant personal name from the dynasty subtitle", () => {
    expect(
      resolveReignDetailSubtitle(
        source({
          start: { year: -372, month: 1 },
          title: "越王无余",
          preferredAppellation: { kind: "regnal", name: "无余" },
        }),
        "越",
        "无余",
      ),
    ).toBe("越");
  });
});

describe("resolveReignCardMeta for Zhongshan kings", () => {
  it("hides given-name meta when it is already the card appellation", () => {
    const clan = buildPreQinClanContext(null, { ancestralXing: "姬" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -327, month: 1 },
          title: "中山王厝",
          preferredAppellation: { kind: "regnal", name: "厝" },
        }),
        "厝",
        clan,
      ),
    ).toBeNull();
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -312, month: 1 },
          title: "中山王胜",
          preferredAppellation: { kind: "regnal", name: "胜" },
        }),
        "胜",
        clan,
      ),
    ).toBeNull();
  });
});

describe("resolveReignCardLabel", () => {
  it("shows the pre-Qin appellation regardless of card width", () => {
    const reign = source({
      start: { year: -575, month: 1 },
      title: "宋平公",
      posthumousName: "平公",
    });
    const clan = buildPreQinClanContext(null, { ancestralXing: "子" });
    expect(
      resolveReignCardLabel(reign, "子成", {
        cardWidthPx: 32,
        clan,
      }),
    ).toBe("平公");
    expect(
      resolveReignCardLabel(reign, "子成", {
        cardWidthPx: 80,
        clan,
      }),
    ).toBe("平公");
    expect(resolveReignCardMeta(reign, "子成", clan)).toEqual({
      label: "名",
      name: "成",
    });
  });

  it("shows posthumous meta for Jin deposed and short-reign emperors", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 365, month: 1 },
          title: "晋海西公",
          posthumousName: "海西公",
          preferredAppellation: { kind: "posthumous", name: "晋海西公" },
          eraNames: [{ name: "太和" }] as Reign["eraNames"],
        }),
        "司马奕",
      ),
    ).toEqual({ label: "谥号", name: "海西公" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 371, month: 1 },
          title: "晋简文帝",
          posthumousName: "简文皇帝",
          preferredAppellation: { kind: "posthumous", name: "晋简文帝" },
          eraNames: [{ name: "咸安" }] as Reign["eraNames"],
        }),
        "司马昱",
      ),
    ).toEqual({ label: "谥号", name: "简文皇帝" });
  });
});

describe("resolveReignCardMeta", () => {
  it("shows era name under the personal name for Ming and Qing", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 1661, month: 1 },
          eraNames: [{ name: "康熙" }] as Reign["eraNames"],
        }),
        "爱新觉罗·玄烨",
      ),
    ).toEqual({ label: "年号", name: "康熙" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 1435, month: 1 },
          eraNames: [{ name: "正统" }] as Reign["eraNames"],
        }),
        "朱祁镇",
      ),
    ).toEqual({ label: "年号", name: "正统" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 1457, month: 1 },
          eraNames: [{ name: "天顺" }] as Reign["eraNames"],
        }),
        "朱祁镇",
      ),
    ).toEqual({ label: "年号", name: "天顺" });
  });

  it("shows temple meta for Tang emperors", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 626, month: 1 },
          title: "唐太宗",
          templeName: "太宗",
        }),
        "李世民",
      ),
    ).toEqual({ label: "庙号", name: "太宗" });
  });

  it("shows temple meta for Nanzhao rulers from Tang onward", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 649, month: 1 },
          title: "诏王",
          posthumousName: "奇嘉王",
          templeName: "高祖",
        }),
        "细奴逻",
      ),
    ).toEqual({ label: "庙号", name: "高祖" });
  });

  it("shows posthumous meta for Sui emperors", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 581, month: 1 },
          title: "隋文帝",
          posthumousName: "文皇帝",
          eraNames: [{ name: "开皇" }] as Reign["eraNames"],
        }),
        "杨坚",
      ),
    ).toEqual({ label: "谥号", name: "文皇帝" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 604, month: 1 },
          title: "隋炀帝",
          posthumousName: "炀皇帝",
          eraNames: [{ name: "大业" }] as Reign["eraNames"],
        }),
        "杨广",
      ),
    ).toEqual({ label: "谥号", name: "炀皇帝" });
  });

  it("hides redundant regnal meta when the title is also the person name", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -778, month: 1 },
          title: "秦襄公",
          preferredAppellation: { kind: "regnal", name: "秦襄公" },
        }),
        "秦襄公",
      ),
    ).toBeNull();
  });

  it("shows the given name under a stored pre-Qin posthumous name", () => {
    const reign = source({
      start: { year: -660, month: 1 },
      title: "秦穆公",
      posthumousName: "穆公",
    });
    const clan = buildPreQinClanContext(null, { ancestralXing: "嬴" });
    expect(resolveReignCardLabel(reign, "嬴任好")).toBe("穆公");
    expect(resolveReignCardMeta(reign, "嬴任好", clan)).toEqual({
      label: "名",
      name: "任好",
    });
  });

  it("does not treat 吴末帝 or 后主 as 谥号", () => {
    const sunHao = source({
      start: { year: 264, month: 9 },
      end: { year: 280, month: 5 },
      title: "吴末帝",
      eraNames: [{ name: "元兴" }] as Reign["eraNames"],
    });
    expect(resolveEmperorAppellation(sunHao)).toEqual({
      kind: "regnal",
      name: "吴末帝",
    });
    expect(resolveReignCardMeta(sunHao, "孙皓")).toEqual({
      label: "称号",
      name: "吴末帝",
    });
    expect(resolveReignDetailFacts(sunHao)).toEqual([
      { label: "在位", value: "264 — 280" },
      { label: "年号", value: "元兴" },
    ]);

    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 239, month: 1 },
          title: "邵陵厉公",
          posthumousName: "邵陵厉公",
        }),
      ),
    ).toEqual({ kind: "posthumous", name: "邵陵厉公" });

    const caoMao = source({
      start: { year: 254, month: 10 },
      end: { year: 260, month: 5 },
      title: "高贵乡公",
      preferredAppellation: { kind: "regnal", name: "高贵乡公" },
      eraNames: [{ name: "正元" }, { name: "甘露" }] as Reign["eraNames"],
    });
    expect(resolveEmperorAppellation(caoMao)).toEqual({
      kind: "regnal",
      name: "高贵乡公",
    });
    expect(resolveReignCardMeta(caoMao, "曹髦")).toEqual({
      label: "称号",
      name: "高贵乡公",
    });
    expect(resolveReignDetailFacts(caoMao)).not.toEqual(
      expect.arrayContaining([{ label: "谥号", value: expect.anything() }]),
    );

    const sunLiang = source({
      start: { year: 252, month: 5 },
      end: { year: 258, month: 11 },
      title: "会稽王",
      preferredAppellation: { kind: "regnal", name: "会稽王" },
      eraNames: [{ name: "建兴" }] as Reign["eraNames"],
    });
    expect(resolveEmperorAppellation(sunLiang)).toEqual({
      kind: "regnal",
      name: "会稽王",
    });
    expect(resolveReignCardMeta(sunLiang, "孙亮")).toEqual({
      label: "称号",
      name: "会稽王",
    });
  });

  it("uses posthumous name when title is not a dynastic emperor shorthand", () => {
    const liuShan = {
      ...source({
        start: { year: 223, month: 6 },
        end: { year: 263, month: 11 },
        title: "蜀汉后主",
        posthumousName: "孝怀皇帝",
        preferredAppellation: { kind: "posthumous", name: "孝怀皇帝" },
        eraNames: [{ name: "建兴" }] as Reign["eraNames"],
      }),
    };
    expect(resolveEmperorAppellation(liuShan)).toEqual({
      kind: "posthumous",
      name: "孝怀皇帝",
    });
    expect(resolveReignCardMeta(liuShan, "刘禅")).toEqual({
      label: "谥号",
      name: "孝怀皇帝",
    });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 223, month: 6 },
          title: "蜀汉后主",
          posthumousName: "孝怀皇帝",
          eraNames: [{ name: "建兴" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual({ kind: "posthumous", name: "孝怀皇帝" });
  });

  it("shows temple meta for Song emperors with temple names", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 960, month: 1 },
          title: "宋太祖",
          templeName: "太祖",
          preferredAppellation: { kind: "temple", name: "宋太祖" },
          eraNames: [{ name: "建隆" }] as Reign["eraNames"],
        }),
        "赵匡胤",
      ),
    ).toEqual({ label: "庙号", name: "太祖" });
  });

  it("shows posthumous meta for Shang rulers", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -1547, month: 1 },
          title: "商沃丁",
          posthumousName: "沃丁",
        }),
        "沃丁",
      ),
    ).toBeNull();
    expect(
      resolveReignCardLabel(
        source({
          start: { year: -1075, month: 1 },
          title: "商王帝辛",
          posthumousName: "纣",
        }),
        "帝辛",
      ),
    ).toBe("纣");
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -1075, month: 1 },
          title: "商王帝辛",
          posthumousName: "纣",
        }),
        "帝辛",
      ),
    ).toEqual({ label: "名", name: "帝辛" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -1101, month: 1 },
          title: "商王帝乙",
          posthumousName: "帝乙",
          preferredAppellation: { kind: "posthumous", name: "帝乙" },
        }),
        "帝乙",
      ),
    ).toBeNull();
    expect(
      resolveReignDetailSubtitle(
        source({
          start: { year: -1101, month: 1 },
          title: "商王帝乙",
          posthumousName: "帝乙",
          preferredAppellation: { kind: "posthumous", name: "帝乙" },
        }),
        "商",
      ),
    ).toBe("商");
  });
});

describe("resolveReignDetailSubtitle", () => {
  it("matches reign card appellation for Song and Liao emperors", () => {
    const songReign = source({
      start: { year: 960, month: 1 },
      title: "宋太祖",
      templeName: "太祖",
      preferredAppellation: { kind: "temple", name: "宋太祖" },
      eraNames: [{ name: "建隆" }] as Reign["eraNames"],
    });
    const liaoReign = source({
      start: { year: 982, month: 1 },
      title: "辽圣宗",
      templeName: "圣宗",
      preferredAppellation: { kind: "temple", name: "辽圣宗" },
      eraNames: [{ name: "统和" }] as Reign["eraNames"],
    });

    expect(resolveReignDetailSubtitle(songReign, "北宋", "赵匡胤")).toBe(
      "北宋 · 太祖",
    );
    expect(resolveReignDetailSubtitle(liaoReign, "辽", "耶律隆绪")).toBe(
      "辽 · 圣宗",
    );
  });
});

describe("resolveReignDetailFacts", () => {
  it("keeps supplementary temple and era facts", () => {
    expect(
      resolveReignDetailFacts(
        source({
          start: { year: 960, month: 1 },
          end: { year: 976, month: 12 },
          title: "宋太祖",
          templeName: "太祖",
          preferredAppellation: { kind: "temple", name: "宋太祖" },
          eraNames: [{ name: "建隆" }] as Reign["eraNames"],
        }),
      ),
    ).toEqual([
      { label: "在位", value: "960 — 976" },
      { label: "庙号", value: "太祖" },
      { label: "年号", value: "建隆" },
    ]);
  });

  it("lists every era name instead of only the first", () => {
    expect(
      resolveReignDetailFacts(
        source({
          start: { year: 1351, month: 1 },
          end: { year: 1360, month: 6 },
          title: "徐宋世宗",
          posthumousName: "应天启运献武皇帝",
          templeName: "世宗",
          eraNames: [
            { name: "治平" },
            { name: "太平" },
            { name: "天启" },
            { name: "天定" },
          ] as Reign["eraNames"],
        }),
      ),
    ).toEqual([
      { label: "在位", value: "1351 — 1360" },
      { label: "谥号", value: "应天启运献武皇帝" },
      { label: "庙号", value: "世宗" },
      { label: "年号", value: "治平、太平、天启、天定" },
    ]);
  });
});

describe("pre-Qin card layout", () => {
  it("treats years before 始皇帝 as pre-Qin", () => {
    expect(usesPreQinCardLayout(source({ start: { year: -222, month: 1 } }))).toBe(
      true,
    );
    expect(usesPreQinCardLayout(source({ start: { year: -221, month: 1 } }))).toBe(
      false,
    );
  });

  it("strips stored 姓 but keeps 氏 in personal names", () => {
    expect(
      stripAncestralXing(
        "姬发",
        buildPreQinClanContext(null, { ancestralXing: "姬" }),
      ),
    ).toBe("发");
    expect(
      stripAncestralXing(
        "姜小白",
        buildPreQinClanContext(null, { ancestralXing: "姜" }),
      ),
    ).toBe("小白");
    expect(
      stripAncestralXing(
        "嬴渠梁",
        buildPreQinClanContext(null, { ancestralXing: "嬴" }),
      ),
    ).toBe("渠梁");
    expect(
      stripAncestralXing(
        "己狂",
        buildPreQinClanContext(null, { ancestralXing: "己" }),
      ),
    ).toBe("狂");
    expect(
      stripAncestralXing(
        "姒姑容",
        buildPreQinClanContext(null, { ancestralXing: "姒" }),
      ),
    ).toBe("姑容");
    expect(
      stripAncestralXing(
        "子成",
        buildPreQinClanContext(null, { ancestralXing: "子" }),
      ),
    ).toBe("成");
    expect(
      stripAncestralXing(
        "嬴子楚",
        buildPreQinClanContext(null, { ancestralXing: "嬴" }),
      ),
    ).toBe("子楚");
    expect(
      stripAncestralXing(
        "任好",
        buildPreQinClanContext(null, { ancestralXing: "嬴" }),
      ),
    ).toBe("任好");
    expect(
      stripAncestralXing(
        "姬宫湦余",
        buildPreQinClanContext(null, { ancestralXing: "姬" }),
      ),
    ).toBe("宫湦余");
    expect(stripAncestralXing("吕尚")).toBe("吕尚");
    expect(stripAncestralXing("熊侣")).toBe("熊侣");
    expect(stripAncestralXing("田因齐")).toBe("田因齐");
    expect(stripAncestralXing("魏斯")).toBe("魏斯");
  });

  it("puts appellation on the primary line and the given name on meta", () => {
    const wu = source({
      start: { year: -1046, month: 1 },
      title: "周武王",
      posthumousName: "武王",
    });
    const zhouClan = buildPreQinClanContext(null, { ancestralXing: "姬" });
    expect(resolveReignCardLabel(wu, "姬发")).toBe("武王");
    expect(resolveReignCardMeta(wu, "姬发", zhouClan)).toEqual({
      label: "名",
      name: "发",
    });
    expect(resolveReignDetailSubtitle(wu, "西周", "姬发", zhouClan)).toBe(
      "西周 · 发",
    );

    const huan = source({
      start: { year: -685, month: 1 },
      title: "齐桓公",
      posthumousName: "桓公",
    });
    const qiClan = buildPreQinClanContext(null, {
      ancestralXing: "姜",
      clanShi: "齐",
    });
    expect(resolveReignCardLabel(huan, "姜小白")).toBe("桓公");
    expect(resolveReignCardMeta(huan, "姜小白", qiClan)).toEqual({
      label: "名",
      name: "小白",
    });

    const wen = source({
      start: { year: -636, month: 1 },
      title: "晋文公",
      posthumousName: "文公",
    });
    const jinClan = buildPreQinClanContext(null, { ancestralXing: "姬" });
    expect(resolveReignCardLabel(wen, "姬重耳")).toBe("文公");
    expect(resolveReignCardMeta(wen, "姬重耳", jinClan)).toEqual({
      label: "名",
      name: "重耳",
    });
  });

  it("keeps clan-style given names and drops duplicate meta", () => {
    const tai = source({
      start: { year: -1046, month: 1 },
      title: "齐太公",
      posthumousName: "太公",
    });
    expect(resolveReignCardLabel(tai, "吕尚")).toBe("太公");
    expect(resolveReignCardMeta(tai, "吕尚")).toEqual({
      label: "名",
      name: "吕尚",
    });

    const chuang = source({
      start: { year: -613, month: 1 },
      title: "楚庄王",
      posthumousName: "庄王",
    });
    expect(resolveReignCardLabel(chuang, "熊侣")).toBe("庄王");
    expect(resolveReignCardMeta(chuang, "熊侣")).toEqual({
      label: "名",
      name: "熊侣",
    });

    const fuchai = source({
      start: { year: -495, month: 1 },
      title: "吴王夫差",
      preferredAppellation: { kind: "regnal", name: "夫差" },
    });
    expect(resolveReignCardLabel(fuchai, "夫差")).toBe("夫差");
    expect(resolveReignCardMeta(fuchai, "夫差")).toBeNull();
  });

  it("uses stored 称号 without a runtime state-name list", () => {
    expect(
      resolveReignCardLabel(
        source({
          start: { year: -790, month: 1 },
          title: "楚若敖",
          preferredAppellation: { kind: "regnal", name: "若敖" },
        }),
        "熊仪",
      ),
    ).toBe("若敖");
    expect(
      resolveReignCardLabel(
        source({
          start: { year: -2070, month: 1 },
          title: "夏禹",
          preferredAppellation: { kind: "regnal", name: "禹" },
        }),
        "禹",
      ),
    ).toBe("禹");
    expect(
      resolveReignCardLabel(
        source({
          start: { year: -686, month: 1 },
          title: "公孙无知",
        }),
        "姜无知",
      ),
    ).toBe("公孙无知");
  });

  it("does not invent a 姓 when the given name is missing", () => {
    const yan = source({
      start: { year: -657, month: 1 },
      title: "燕襄公",
      posthumousName: "襄公",
    });
    const yanClan = buildPreQinClanContext(null, {
      ancestralXing: "姬",
      clanShi: "匽",
    });
    expect(resolveReignCardLabel(yan, "姬襄公")).toBe("襄公");
    expect(resolveReignCardMeta(yan, "姬襄公", yanClan)).toBeNull();
  });

  it("keeps imperial name-first layout from 始皇帝 onward", () => {
    const shi = source({
      start: { year: -221, month: 1 },
      title: "始皇帝",
      preferredAppellation: { kind: "regnal", name: "秦始皇" },
    });
    expect(resolveReignCardLabel(shi, "嬴政")).toBe("嬴政");
    expect(resolveReignCardMeta(shi, "嬴政")).toEqual({
      label: "称号",
      name: "秦始皇",
    });
  });

  it("uses 赵政 for the pre-imperial Qin king (赵氏，非王政)", () => {
    const zheng = source({
      start: { year: -246, month: 1 },
      title: "秦王政",
      preferredAppellation: { kind: "regnal", name: "赵政" },
    });
    const qinClan = buildPreQinClanContext(null, {
      ancestralXing: "嬴",
      clanShi: "赵",
    });
    expect(resolveReignCardLabel(zheng, "嬴政")).toBe("赵政");
    expect(resolveReignCardMeta(zheng, "嬴政", qinClan)).toBeNull();
    expect(resolveReignDetailSubtitle(zheng, "秦", "嬴政", qinClan)).toBe("秦");
    expect(
      resolveReignDetailFacts(
        zheng,
        "嬴政",
        buildPreQinClanContext(null, {
          ancestralXing: "嬴",
          clanShi: "赵",
        }),
      ),
    ).toEqual([
      { label: "在位", value: "-246 — 1" },
      { label: "姓", value: "嬴" },
      { label: "氏", value: "赵" },
    ]);
  });

  it("shows 余臣 under 携王 instead of repeating the 携 seat", () => {
    const xie = source({
      start: { year: -770, month: 1 },
      title: "周携王",
      posthumousName: "携王",
      claimTrack: "xie",
      claimLabel: "携",
    });
    const zhouClan = buildPreQinClanContext(null, { ancestralXing: "姬" });
    expect(resolveReignCardLabel(xie, "姬余臣")).toBe("携王");
    expect(resolveReignCardMeta(xie, "姬余臣", zhouClan)).toEqual({
      label: "名",
      name: "余臣",
    });
  });

  it("adds 姓/氏 facts to pre-Qin reign detail panels", () => {
    const wu = source({
      start: { year: -1046, month: 1 },
      end: { year: -1043, month: 12 },
      title: "周武王",
      posthumousName: "武王",
    });
    expect(
      resolveReignDetailFacts(
        wu,
        "姬发",
        buildPreQinClanContext(null, { ancestralXing: "姬" }),
      ),
    ).toEqual([
      { label: "在位", value: "-1046 — -1043" },
      { label: "姓", value: "姬" },
      { label: "谥号", value: "武王" },
    ]);

    const huan = source({
      start: { year: -685, month: 1 },
      end: { year: -643, month: 12 },
      title: "齐桓公",
      posthumousName: "桓公",
    });
    expect(
      resolveReignDetailFacts(
        huan,
        "姜小白",
        buildPreQinClanContext(null, { ancestralXing: "姜", clanShi: "齐" }),
      ),
    ).toEqual([
      { label: "在位", value: "-685 — -643" },
      { label: "姓", value: "姜" },
      { label: "氏", value: "齐" },
      { label: "谥号", value: "桓公" },
    ]);

    const tai = source({
      start: { year: -1046, month: 1 },
      end: { year: -1046, month: 12 },
      title: "齐太公",
      posthumousName: "太公",
    });
    expect(
      resolveReignDetailFacts(
        tai,
        "吕尚",
        buildPreQinClanContext({ clanShi: "吕" }, { ancestralXing: "姜", clanShi: "齐" }),
      ),
    ).toEqual([
      { label: "在位", value: "-1046 — -1046" },
      { label: "姓", value: "姜" },
      { label: "氏", value: "吕" },
      { label: "谥号", value: "太公" },
    ]);

    const chuang = source({
      start: { year: -613, month: 1 },
      end: { year: -591, month: 12 },
      title: "楚庄王",
      posthumousName: "庄王",
    });
    expect(
      resolveReignDetailFacts(
        chuang,
        "熊侣",
        buildPreQinClanContext(null, { ancestralXing: "芈", clanShi: "熊" }),
      ),
    ).toEqual([
      { label: "在位", value: "-613 — -591" },
      { label: "姓", value: "芈" },
      { label: "氏", value: "熊" },
      { label: "谥号", value: "庄王" },
    ]);

    const fuchai = source({
      start: { year: -495, month: 1 },
      end: { year: -473, month: 12 },
      title: "吴王夫差",
      preferredAppellation: { kind: "regnal", name: "夫差" },
    });
    expect(
      resolveReignDetailFacts(
        fuchai,
        "夫差",
        buildPreQinClanContext(null, { ancestralXing: "姬", clanShi: "姑发" }),
      ),
    ).toEqual([
      { label: "在位", value: "-495 — -473" },
      { label: "姓", value: "姬" },
      { label: "氏", value: "姑发" },
    ]);

    const zhaoxiang = source({
      start: { year: -307, month: 1 },
      end: { year: -251, month: 12 },
      title: "秦昭襄王",
      posthumousName: "昭襄王",
    });
    expect(
      resolveReignDetailFacts(
        zhaoxiang,
        "嬴稷",
        buildPreQinClanContext(null, { ancestralXing: "嬴", clanShi: "赵" }),
      ),
    ).toEqual([
      { label: "在位", value: "-307 — -251" },
      { label: "姓", value: "嬴" },
      { label: "氏", value: "赵" },
      { label: "谥号", value: "昭襄王" },
    ]);
  });

  it("does not invent 姓/氏 for placeholder or posthumous-only names", () => {
    const yan = source({
      start: { year: -657, month: 1 },
      end: { year: -617, month: 12 },
      title: "燕襄公",
      posthumousName: "襄公",
    });
    expect(
      resolveReignDetailFacts(
        yan,
        "姬襄公",
        buildPreQinClanContext(null, { ancestralXing: "姬", clanShi: "匽" }),
      ),
    ).toEqual([
      { label: "在位", value: "-657 — -617" },
      { label: "姓", value: "姬" },
      { label: "氏", value: "匽" },
      { label: "谥号", value: "襄公" },
    ]);

    const wei = source({
      start: { year: -855, month: 1 },
      end: { year: -845, month: 12 },
      title: "卫考伯",
      posthumousName: "考伯",
    });
    expect(
      resolveReignDetailFacts(
        wei,
        "考伯",
        buildPreQinClanContext(null, { ancestralXing: "姬", clanShi: "卫" }),
      ),
    ).toEqual([
      { label: "在位", value: "-855 — -845" },
      { label: "姓", value: "姬" },
      { label: "氏", value: "卫" },
      { label: "谥号", value: "考伯" },
    ]);
  });
});
