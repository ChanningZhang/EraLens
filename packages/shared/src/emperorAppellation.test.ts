import { describe, expect, it } from "vitest";
import type { Reign } from "./schema";
import {
  resolveEmperorAppellation,
  resolveReignCardLabel,
  resolveReignCardMeta,
  resolveReignDetailFacts,
  resolveReignDetailSubtitle,
  resolveReignPrimaryLabel,
  sanitizePersonName,
} from "./emperorAppellation";

function source(overrides: Partial<Reign>) {
  return {
    start: { year: 1, month: 1 },
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

describe("sanitizePersonName", () => {
  it("extracts the final name from wiki alias notes", () => {
    expect(sanitizePersonName("原名子异、异人，后改名子楚")).toBe("子楚");
    expect(sanitizePersonName("原名子异、異人，後改名子楚")).toBe("子楚");
  });

  it("returns null for unusable wiki notes", () => {
    expect(sanitizePersonName("出土于某某墓")).toBeNull();
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

  it("extracts a short personal name from wiki alias notes", () => {
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: -250, month: 1 },
          title: "秦庄襄王",
        }),
        "原名子异、异人，后改名子楚",
      ),
    ).toBe("子楚");
  });

  it("extracts a given name from Zhongshan regnal titles", () => {
    const reign = source({
      start: { year: -327, month: 1 },
      title: "中山王厝",
      preferredAppellation: { kind: "regnal", name: "中山王厝" },
    });
    expect(resolveReignPrimaryLabel(reign)).toBe("厝");
    expect(resolveReignPrimaryLabel(reign, "中山王厝")).toBe("厝");
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: -312, month: 1 },
          title: "中山王胜",
          preferredAppellation: { kind: "regnal", name: "中山王胜" },
        }),
        "𧊒",
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
  it("strips state and rank prefixes for personal-name titles", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: -496, month: 1 },
          title: "越王勾践",
        }),
      ),
    ).toEqual({ kind: "regnal", name: "勾践" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: -372, month: 1 },
          title: "越王无余",
        }),
      ),
    ).toEqual({ kind: "regnal", name: "无余" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: -565, month: 1 },
          title: "越侯无余",
        }),
      ),
    ).toEqual({ kind: "regnal", name: "无余" });
  });

  it("keeps posthumous-style bodies after stripping the state", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: -350, month: 1 },
          title: "齐威王",
        }),
      ),
    ).toEqual({ kind: "regnal", name: "威王" });
  });
});

describe("resolveReignDetailSubtitle for Yue kings", () => {
  it("omits a redundant personal name from the dynasty subtitle", () => {
    expect(
      resolveReignDetailSubtitle(
        source({
          start: { year: -372, month: 1 },
          title: "越王无余",
        }),
        "越国",
        "无余",
      ),
    ).toBe("越国");
  });
});

describe("resolveReignCardMeta for Zhongshan kings", () => {
  it("shows regnal meta when the personal name is known", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -327, month: 1 },
          title: "中山王厝",
          preferredAppellation: { kind: "regnal", name: "中山王厝" },
        }),
        "姬厝",
      ),
    ).toEqual({ label: "称号", name: "中山王厝" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -312, month: 1 },
          title: "中山王胜",
          preferredAppellation: { kind: "regnal", name: "中山王胜" },
        }),
        "姬胜",
      ),
    ).toEqual({ label: "称号", name: "中山王胜" });
  });
});

describe("resolveReignCardLabel", () => {
  it("always shows the personal name regardless of card width", () => {
    const reign = source({
      start: { year: -575, month: 1 },
      title: "宋平公",
      posthumousName: "平公",
    });
    expect(
      resolveReignCardLabel(reign, "子成", {
        cardWidthPx: 32,
        dynastyId: "song-chunqiu",
      }),
    ).toBe("子成");
    expect(
      resolveReignCardLabel(reign, "子成", {
        cardWidthPx: 80,
        dynastyId: "song-chunqiu",
      }),
    ).toBe("子成");
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

  it("still shows regnal meta when a personal name is known", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -660, month: 1 },
          title: "秦穆公",
          preferredAppellation: { kind: "regnal", name: "秦穆公" },
        }),
        "任好",
      ),
    ).toEqual({ label: "称号", name: "秦穆公" });
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
      resolveReignCardMeta(
        source({
          start: { year: -1075, month: 1 },
          title: "商王帝辛",
          posthumousName: "纣",
        }),
        "帝辛",
      ),
    ).toEqual({ label: "谥号", name: "纣" });
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
    ).toBe("商 · 帝乙");
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
});
