import { describe, expect, it } from "vitest";
import type { Reign } from "./schema";
import {
  resolveEmperorAppellation,
  resolveReignCardMeta,
  resolveReignPrimaryLabel,
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

  it("uses a temple name from Tang through Yuan", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 626, month: 1 },
          posthumousName: "文皇帝",
          templeName: "太宗",
        }),
      ),
    ).toEqual({ kind: "temple", name: "太宗" });
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

  it("lets an explicit preferred appellation override the default", () => {
    expect(
      resolveEmperorAppellation(
        source({
          start: { year: 1294, month: 1 },
          templeName: "成宗",
          preferredAppellation: { kind: "temple", name: "元成宗" },
        }),
      ),
    ).toEqual({ kind: "temple", name: "元成宗" });
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

  it("shows temple name for Tang emperors", () => {
    expect(
      resolveReignCardMeta(
        source({
          start: { year: 626, month: 1 },
          templeName: "太宗",
        }),
        "李世民",
      ),
    ).toEqual({ label: "庙号", name: "太宗" });
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
});
