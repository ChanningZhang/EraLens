import { describe, expect, it } from "vitest";
import type { Reign } from "./schema";
import {
  buildPreQinClanContext,
  type PersonDisplayContext,
  resolveEmperorAppellation as resolveEmperorAppellationBase,
  resolveReignCardGivenName as resolveReignCardGivenNameBase,
  resolveReignCardLabel as resolveReignCardLabelBase,
  resolveReignCardMeta as resolveReignCardMetaBase,
  resolveReignDetailFacts as resolveReignDetailFactsBase,
  resolveReignDetailSubtitle as resolveReignDetailSubtitleBase,
  resolveReignPrimaryLabel as resolveReignPrimaryLabelBase,
  resolveReignRelatedLabel as resolveReignRelatedLabelBase,
  stripAncestralXing,
  usesPreQinCardLayout,
} from "./emperorAppellation";

type SourceOverrides = Partial<Reign> & {
  posthumousName?: string;
  templeName?: string;
  personTitle?: string;
};

const personByReign = new WeakMap<Reign, PersonDisplayContext>();

function mergePersonContext(
  reign: Reign,
  personContext?: PersonDisplayContext | null,
): PersonDisplayContext | undefined {
  const stored = personByReign.get(reign);
  if (!stored && !personContext) return undefined;
  return { ...personContext, ...stored };
}

function source(overrides: SourceOverrides = {}) {
  const { posthumousName, templeName, personTitle, ...reignOverrides } = overrides;
  const reign: Reign = {
    start: { year: 1, month: 1 },
    end: { year: 1, month: 12 },
    title: "皇帝",
    eraNames: [],
    ...reignOverrides,
  };
  if (posthumousName || templeName || personTitle) {
    personByReign.set(reign, {
      ...(personTitle ? { title: personTitle } : {}),
      ...(posthumousName ? { posthumousNames: [posthumousName] } : {}),
      ...(templeName ? { templeNames: [templeName] } : {}),
    });
  }
  return reign;
}

function resolveEmperorAppellation(
  reign: Reign,
  personContext?: PersonDisplayContext | null,
) {
  return resolveEmperorAppellationBase(reign, mergePersonContext(reign, personContext));
}

function resolveReignPrimaryLabel(
  reign: Reign,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignPrimaryLabelBase(
    reign,
    personName,
    mergePersonContext(reign, personContext),
  );
}

function resolveReignCardLabel(
  reign: Reign,
  personName?: string | null,
  options?: { cardWidthPx?: number; clan?: PersonDisplayContext | null },
) {
  return resolveReignCardLabelBase(reign, personName, {
    ...options,
    clan: mergePersonContext(reign, options?.clan),
  });
}

function resolveReignCardGivenName(
  reign: Reign,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignCardGivenNameBase(
    reign,
    personName,
    mergePersonContext(reign, personContext),
  );
}

function resolveReignCardMeta(
  reign: Reign,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignCardMetaBase(
    reign,
    personName,
    mergePersonContext(reign, personContext),
  );
}

function resolveReignDetailSubtitle(
  reign: Reign,
  dynastyName?: string | null,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignDetailSubtitleBase(
    reign,
    dynastyName,
    personName,
    mergePersonContext(reign, personContext),
  );
}

function resolveReignRelatedLabel(
  reign: Reign,
  dynastyName?: string | null,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignRelatedLabelBase(
    reign,
    dynastyName,
    personName,
    mergePersonContext(reign, personContext),
  );
}

function resolveReignDetailFacts(
  reign: Reign,
  personName?: string | null,
  personContext?: PersonDisplayContext | null,
) {
  return resolveReignDetailFactsBase(
    reign,
    personName,
    mergePersonContext(reign, personContext),
  );
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
          eraNames: ["开皇"],
        }),
      ),
    ).toEqual({ kind: "posthumous", name: "文皇帝" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 604, month: 1 },
          title: "隋炀帝",
          posthumousName: "炀皇帝",
          eraNames: ["大业"],
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
          eraNames: ["泰定","致和"],
        }),
      ),
    ).toEqual({ kind: "era", name: "泰定" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 1323, month: 9 },
          title: "元泰定帝",
          eraNames: ["泰定","致和"],
        }),
        "也孙铁木儿",
      ),
    ).toEqual({ label: "称号", name: "元泰定帝" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1328, month: 8 },
          title: "元天顺帝",
          eraNames: ["天顺"],
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
          eraNames: ["康熙"],
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
          eraNames: ["治平"],
        }),
      ),
    ).toEqual({ kind: "era", name: "治平" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1360, month: 1 },
          title: "陈汉帝",
          eraNames: ["大义"],
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
          eraNames: ["治平","太平"],
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
          eraNames: ["正统"],
        }),
      ),
    ).toEqual({ kind: "era", name: "正统" });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1457, month: 1 },
          templeName: "英宗",
          eraNames: ["天顺"],
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
          eraNames: ["康熙"],
        }),
        "爱新觉罗·玄烨",
      ),
    ).toBe("爱新觉罗·玄烨");
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: 1435, month: 1 },
          eraNames: ["正统"],
        }),
        "朱祁镇",
      ),
    ).toBe("朱祁镇");
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: 1457, month: 1 },
          eraNames: ["天顺"],
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
    const clan = buildPreQinClanContext({ ancestralXing: "嬴" });
    expect(resolveReignCardGivenName(reign, "嬴子楚", clan)).toBe("子楚");
    expect(resolveReignPrimaryLabel(reign, "嬴子楚", clan)).toBe("庄襄王");
  });

  it("uses stored regnal body for Zhongshan kings (no runtime state strip)", () => {
    const reign = source({
      start: { year: -327, month: 1 },
      title: "厝",
    });
    expect(resolveReignPrimaryLabel(reign)).toBe("厝");
    expect(resolveReignPrimaryLabel(reign, "厝")).toBe("厝");
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: -312, month: 1 },
          title: "𧊒",
        }),
        "𧊒",
      ),
    ).toBe("𧊒");
  });

  it("keeps surnames that begin with 王, such as 王莽", () => {
    expect(
      resolveReignPrimaryLabel(
        source({
          start: { year: 9, month: 1 },
          title: "王莽",
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
          title: "勾践",
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
          title: "无余",
        }),
        "越",
        "无余",
      ),
    ).toBe("越");
  });
});

describe("resolveReignCardMeta for Zhongshan kings", () => {
  it("hides given-name meta when it is already the card appellation", () => {
    const clan = buildPreQinClanContext({ ancestralXing: "姬" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -327, month: 1 },
          title: "厝",
        }),
        "厝",
        clan,
      ),
    ).toBeNull();
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -312, month: 1 },
          title: "𧊒",
        }),
        "𧊒",
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
    const clan = buildPreQinClanContext({ ancestralXing: "子" });
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

  it("shows posthumous names for Jin deposed and short-reign emperors", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 365, month: 1 },
          title: "晋海西公",
          posthumousName: "海西公",
          eraNames: ["太和"],
        }),
        "司马奕",
      ),
    ).toEqual({ label: "称号", name: "晋海西公" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 371, month: 1 },
          title: "晋简文帝",
          posthumousName: "简文皇帝",
          eraNames: ["咸安"],
        }),
        "司马昱",
      ),
    ).toEqual({ label: "称号", name: "晋简文帝" });
  });
});

describe("resolveReignCardMeta", () => {
  it("uses reign title, person appellations, era name, then person title", () => {
    expect(
      resolveReignCardMeta(
        source({
          title: "本段称号",
          posthumousName: "谥号",
          templeName: "庙号",
          eraNames: ["年号"],
          personTitle: "人物称号",
        }),
        "人物姓名",
      ),
    ).toEqual({ label: "称号", name: "本段称号" });

    expect(
      resolveReignCardMeta(
        source({
          title: "",
          posthumousName: "谥号",
          templeName: "庙号",
          eraNames: ["年号"],
          personTitle: "人物称号",
        }),
        "人物姓名",
      ),
    ).toEqual({ label: "谥号", name: "谥号" });

    expect(
      resolveReignCardMeta(
        source({
          title: "",
          templeName: "庙号",
          eraNames: ["年号"],
          personTitle: "人物称号",
        }),
        "人物姓名",
      ),
    ).toEqual({ label: "庙号", name: "庙号" });

    expect(
      resolveReignCardMeta(
        source({ title: "", eraNames: ["年号"], personTitle: "人物称号" }),
        "人物姓名",
      ),
    ).toEqual({ label: "年号", name: "年号" });

    expect(
      resolveReignCardMeta(
        source({ title: "", personTitle: "人物称号" }),
        "人物姓名",
      ),
    ).toEqual({ label: "称号", name: "人物称号" });
  });

  it("shows Ming and Qing era names stored in the reign title", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 1661, month: 1 },
          title: "康熙",
          eraNames: ["康熙"],
        }),
        "爱新觉罗·玄烨",
      ),
    ).toEqual({ label: "称号", name: "康熙" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 1435, month: 1 },
          title: "正统",
          eraNames: ["正统"],
        }),
        "朱祁镇",
      ),
    ).toEqual({ label: "称号", name: "正统" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 1457, month: 1 },
          title: "天顺",
          eraNames: ["天顺"],
        }),
        "朱祁镇",
      ),
    ).toEqual({ label: "称号", name: "天顺" });
  });

  it("uses person appellations before era names for every period", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 1661, month: 1 },
          title: "",
          templeName: "圣祖",
          eraNames: ["康熙"],
        }),
        "爱新觉罗·玄烨",
      ),
    ).toEqual({ label: "庙号", name: "圣祖" });

    expect(
      resolveReignCardMeta(
        source({
          start: { year: 1435, month: 1 },
          title: "",
          templeName: "英宗",
          eraNames: ["正统"],
        }),
        "朱祁镇",
      ),
    ).toEqual({ label: "庙号", name: "英宗" });
  });

  it("keeps the person name while separating multiple reign titles", () => {
    const liuBangReigns = [
      source({ start: { year: -209, month: 9 }, title: "沛公" }),
      source({ start: { year: -202, month: 2 }, title: "汉高祖" }),
    ];

    expect(resolveReignCardLabel(liuBangReigns[0]!, "刘邦")).toBe("刘邦");
    expect(resolveReignCardMeta(liuBangReigns[0]!, "刘邦")).toEqual({
      label: "称号",
      name: "沛公",
    });
    expect(resolveReignCardLabel(liuBangReigns[1]!, "刘邦")).toBe("刘邦");
    expect(resolveReignCardMeta(liuBangReigns[1]!, "刘邦")).toEqual({
      label: "称号",
      name: "汉高祖",
    });
  });

  it("shows temple names for Tang emperors", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 626, month: 1 },
          title: "唐太宗",
          templeName: "太宗",
        }),
        "李世民",
      ),
    ).toEqual({ label: "称号", name: "唐太宗" });
  });

  it("shows temple names for Nanzhao rulers from Tang onward", () => {
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
    ).toEqual({ label: "称号", name: "诏王" });
  });

  it("shows posthumous names for Sui emperors", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 581, month: 1 },
          title: "隋文帝",
          posthumousName: "文皇帝",
          eraNames: ["开皇"],
        }),
        "杨坚",
      ),
    ).toEqual({ label: "称号", name: "隋文帝" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 604, month: 1 },
          title: "隋炀帝",
          posthumousName: "炀皇帝",
          eraNames: ["大业"],
        }),
        "杨广",
      ),
    ).toEqual({ label: "称号", name: "隋炀帝" });
  });

  it("hides redundant regnal meta when the title is also the person name", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -778, month: 1 },
          title: "秦襄公",
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
    const clan = buildPreQinClanContext({ ancestralXing: "嬴" });
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
      eraNames: ["元兴"],
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
      eraNames: ["正元","甘露"],
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
      eraNames: ["建兴"],
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

  it("shows the stored posthumous name instead of the dynasty-prefixed title", () => {
    const liuShan = source({
      start: { year: 223, month: 6 },
      end: { year: 263, month: 11 },
      title: "蜀汉后主",
          posthumousName: "孝怀皇帝",
      eraNames: ["建兴"],
    });
    expect(resolveEmperorAppellation(liuShan)).toEqual({
      kind: "posthumous",
      name: "孝怀皇帝",
    });
    expect(resolveReignCardMeta(liuShan, "刘禅")).toEqual({
      label: "称号",
      name: "蜀汉后主",
    });
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 223, month: 6 },
          title: "蜀汉后主",
          posthumousName: "孝怀皇帝",
          eraNames: ["建兴"],
        }),
      ),
    ).toEqual({ kind: "posthumous", name: "孝怀皇帝" });
  });

  it("shows temple names for Song emperors", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 960, month: 1 },
          title: "宋太祖",
          templeName: "太祖",
          eraNames: ["建隆"],
        }),
        "赵匡胤",
      ),
    ).toEqual({ label: "称号", name: "宋太祖" });
  });

  it("shows posthumous meta for Shang rulers", () => {
    const clan = buildPreQinClanContext({ ancestralXing: "子" });
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
          start: { year: -1547, month: 1 },
          title: "商沃丁",
          posthumousName: "沃丁",
        }),
        "子绚",
        clan,
      ),
    ).toEqual({ label: "名", name: "绚" });
    expect(
      resolveReignCardLabel(
        source({
          start: { year: -1075, month: 1 },
          title: "商王帝辛",
          posthumousName: "纣",
        }),
        "子受",
        { clan },
      ),
    ).toBe("纣");
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -1075, month: 1 },
          title: "商王帝辛",
          posthumousName: "纣",
        }),
        "子受",
        clan,
      ),
    ).toEqual({ label: "名", name: "受" });
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -1101, month: 1 },
          title: "商王帝乙",
          posthumousName: "帝乙",
        }),
        "帝乙",
      ),
    ).toBeNull();
    expect(
      resolveReignCardMeta(
        source({
          start: { year: -1101, month: 1 },
          title: "商王帝乙",
          posthumousName: "帝乙",
        }),
        "子羡",
        clan,
      ),
    ).toEqual({ label: "名", name: "羡" });
    expect(
      resolveReignDetailSubtitle(
        source({
          start: { year: -1101, month: 1 },
          title: "商王帝乙",
          posthumousName: "帝乙",
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
      eraNames: ["建隆"],
    });
    const liaoReign = source({
      start: { year: 982, month: 1 },
      title: "辽圣宗",
      templeName: "圣宗",
      eraNames: ["统和"],
    });

    expect(resolveReignDetailSubtitle(songReign, "北宋", "赵匡胤")).toBe(
      "北宋 · 太祖",
    );
    expect(resolveReignDetailSubtitle(liaoReign, "辽", "耶律隆绪")).toBe(
      "辽 · 圣宗",
    );
  });

  it("uses 台湾地区 · 领导人 for ROC leaders from 1950 onward", () => {
    const chen = source({
      dynastyId: "roc",
      start: { year: 2000, month: 5 },
      end: { year: 2008, month: 5 },
      title: "总统",
      eraNames: [],
    });
    const jiang = source({
      dynastyId: "roc",
      start: { year: 1950, month: 3 },
      end: { year: 1975, month: 4 },
      title: "总统",
      eraNames: [],
    });
    const li = source({
      dynastyId: "roc",
      start: { year: 1949, month: 1 },
      end: { year: 1950, month: 3 },
      title: "代总统",
      eraNames: [],
    });

    expect(resolveReignDetailSubtitle(chen, "中华民国", "陈水扁")).toBe(
      "台湾地区 · 领导人",
    );
    expect(resolveReignDetailSubtitle(jiang, "中华民国", "蒋介石")).toBe(
      "台湾地区 · 领导人",
    );
    expect(resolveReignDetailSubtitle(li, "中华民国", "李宗仁")).toBe(
      "中华民国 · 代总统",
    );
    expect(resolveEmperorAppellation(chen)).toEqual({
      kind: "regnal",
      name: "领导人",
    });
  });
});

describe("resolveReignDetailFacts", () => {
  it("renders uncertain reign endpoints as question marks", () => {
    expect(
      resolveReignDetailFacts(
        source({
          start: { year: -899, month: 1 },
          end: { year: -863, month: 12 },
          startDateConfidence: "interpolated",
        }),
      )[0],
    ).toEqual({ label: "在位", value: "？ — -863" });
  });

  it("keeps supplementary temple and era facts", () => {
    expect(
      resolveReignDetailFacts(
        source({
          start: { year: 960, month: 1 },
          end: { year: 976, month: 12 },
          title: "宋太祖",
          templeName: "太祖",
          eraNames: ["建隆"],
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
          eraNames: ["治平","太平","天启","天定"],
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
        buildPreQinClanContext({ ancestralXing: "姬" }),
      ),
    ).toBe("发");
    expect(
      stripAncestralXing(
        "姜小白",
        buildPreQinClanContext({ ancestralXing: "姜" }),
      ),
    ).toBe("小白");
    expect(
      stripAncestralXing(
        "嬴渠梁",
        buildPreQinClanContext({ ancestralXing: "嬴" }),
      ),
    ).toBe("渠梁");
    expect(
      stripAncestralXing(
        "己狂",
        buildPreQinClanContext({ ancestralXing: "己" }),
      ),
    ).toBe("狂");
    expect(
      stripAncestralXing(
        "姒姑容",
        buildPreQinClanContext({ ancestralXing: "姒" }),
      ),
    ).toBe("姑容");
    expect(
      stripAncestralXing(
        "子成",
        buildPreQinClanContext({ ancestralXing: "子" }),
      ),
    ).toBe("成");
    expect(
      stripAncestralXing(
        "嬴子楚",
        buildPreQinClanContext({ ancestralXing: "嬴" }),
      ),
    ).toBe("子楚");
    expect(
      stripAncestralXing(
        "任好",
        buildPreQinClanContext({ ancestralXing: "嬴" }),
      ),
    ).toBe("任好");
    expect(
      stripAncestralXing(
        "姬宫湦余",
        buildPreQinClanContext({ ancestralXing: "姬" }),
      ),
    ).toBe("宫湦余");
    expect(stripAncestralXing("吕尚")).toBe("吕尚");
    expect(stripAncestralXing("熊侣")).toBe("熊侣");
    expect(stripAncestralXing("田因齐")).toBe("田因齐");
    expect(stripAncestralXing("魏斯")).toBe("魏斯");
    expect(
      stripAncestralXing(
        "妫因齐",
        buildPreQinClanContext({ ancestralXing: "妫", clanShi: "田" }),
      ),
    ).toBe("因齐");
    expect(
      stripAncestralXing(
        "芈侣",
        buildPreQinClanContext({ ancestralXing: "芈", clanShi: "熊" }),
      ),
    ).toBe("侣");
    expect(
      stripAncestralXing(
        "姜尚",
        buildPreQinClanContext({ ancestralXing: "姜", clanShi: "吕" }),
      ),
    ).toBe("尚");
  });

  it("puts appellation on the primary line and the given name on meta", () => {
    const wu = source({
      start: { year: -1046, month: 1 },
      title: "周武王",
      posthumousName: "武王",
    });
    const zhouClan = buildPreQinClanContext({ ancestralXing: "姬" });
    expect(resolveReignCardLabel(wu, "姬发")).toBe("武王");
    expect(resolveReignCardMeta(wu, "姬发", zhouClan)).toEqual({
      label: "名",
      name: "发",
    });
    expect(resolveReignDetailSubtitle(wu, "西周", "姬发", zhouClan)).toBe(
      "西周 · 发",
    );
    expect(resolveReignRelatedLabel(wu, "西周", "姬发", zhouClan)).toBe(
      "西周 · 武王",
    );

    const huan = source({
      start: { year: -685, month: 1 },
      title: "齐桓公",
      posthumousName: "桓公",
    });
    const qiClan = buildPreQinClanContext({
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
    const jinClan = buildPreQinClanContext({ ancestralXing: "姬" });
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
    const qiClan = buildPreQinClanContext({ ancestralXing: "姜", clanShi: "吕" });
    expect(resolveReignCardLabel(tai, "姜尚")).toBe("太公");
    expect(resolveReignCardMeta(tai, "姜尚", qiClan)).toEqual({
      label: "名",
      name: "尚",
    });

    const chuang = source({
      start: { year: -613, month: 1 },
      title: "楚庄王",
      posthumousName: "庄王",
    });
    const chuClan = buildPreQinClanContext({ ancestralXing: "芈", clanShi: "熊" });
    expect(resolveReignCardLabel(chuang, "芈侣")).toBe("庄王");
    expect(resolveReignCardMeta(chuang, "芈侣", chuClan)).toEqual({
      label: "名",
      name: "侣",
    });

    const fuchai = source({
      start: { year: -495, month: 1 },
      title: "夫差",
    });
    expect(resolveReignCardLabel(fuchai, "夫差")).toBe("夫差");
    expect(resolveReignCardMeta(fuchai, "夫差")).toBeNull();
  });

  it("uses stored 称号 without a runtime state-name list", () => {
    expect(
      resolveReignCardLabel(
        source({
          start: { year: -790, month: 1 },
          title: "若敖",
        }),
        "熊仪",
      ),
    ).toBe("若敖");
    expect(
      resolveReignCardLabel(
        source({
          start: { year: -2070, month: 1 },
          title: "禹",
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
    const yanClan = buildPreQinClanContext({
      ancestralXing: "姬",
      clanShi: "匽",
    });
    expect(resolveReignCardLabel(yan, "姬襄公")).toBe("襄公");
    expect(resolveReignCardMeta(yan, "姬襄公", yanClan)).toBeNull();
  });

  it("keeps imperial name-first layout from 始皇帝 onward", () => {
    const shi = source({
      start: { year: -221, month: 1 },
      title: "秦始皇",
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
      title: "赵政",
    });
    const qinClan = buildPreQinClanContext({
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
        buildPreQinClanContext({
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
    const zhouClan = buildPreQinClanContext({ ancestralXing: "姬" });
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
        buildPreQinClanContext({ ancestralXing: "姬" }),
      ),
    ).toEqual([
      { label: "在位", value: "-1046 — -1043" },
      { label: "姓", value: "姬" },
      { label: "名", value: "发" },
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
        buildPreQinClanContext({ ancestralXing: "姜", clanShi: "齐" }),
      ),
    ).toEqual([
      { label: "在位", value: "-685 — -643" },
      { label: "姓", value: "姜" },
      { label: "氏", value: "齐" },
      { label: "名", value: "小白" },
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
        "姜尚",
        buildPreQinClanContext({ ancestralXing: "姜", clanShi: "吕" }),
      ),
    ).toEqual([
      { label: "在位", value: "-1046 — -1046" },
      { label: "姓", value: "姜" },
      { label: "氏", value: "吕" },
      { label: "名", value: "尚" },
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
        "芈侣",
        buildPreQinClanContext({ ancestralXing: "芈", clanShi: "熊" }),
      ),
    ).toEqual([
      { label: "在位", value: "-613 — -591" },
      { label: "姓", value: "芈" },
      { label: "氏", value: "熊" },
      { label: "名", value: "侣" },
      { label: "谥号", value: "庄王" },
    ]);

    const fuchai = source({
      start: { year: -495, month: 1 },
      end: { year: -473, month: 12 },
      title: "夫差",
    });
    expect(
      resolveReignDetailFacts(
        fuchai,
        "夫差",
        buildPreQinClanContext({ ancestralXing: "姬", clanShi: "姑发" }),
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
        buildPreQinClanContext({ ancestralXing: "嬴", clanShi: "赵" }),
      ),
    ).toEqual([
      { label: "在位", value: "-307 — -251" },
      { label: "姓", value: "嬴" },
      { label: "氏", value: "赵" },
      { label: "名", value: "稷" },
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
        buildPreQinClanContext({ ancestralXing: "姬", clanShi: "匽" }),
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
        buildPreQinClanContext({ ancestralXing: "姬", clanShi: "卫" }),
      ),
    ).toEqual([
      { label: "在位", value: "-855 — -845" },
      { label: "姓", value: "姬" },
      { label: "氏", value: "卫" },
      { label: "谥号", value: "考伯" },
    ]);
  });
});
