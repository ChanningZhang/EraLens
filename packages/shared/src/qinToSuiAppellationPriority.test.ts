import { describe, expect, it } from "vitest";
import { ReignSchema } from "./schema";
import { absMonth } from "./time";
import {
  resolvePersonDetailTitle,
  resolveReignCardLabel,
  resolveReignCardMeta,
  resolveReignDetailHeading,
} from "./emperorAppellation";

function reignAt(year: number, title = "在位称号") {
  return ReignSchema.parse({
    id: "test-reign", dynastyId: "test-dynasty", personId: "test-person", title,
    start: { year, month: 1 }, end: { year, month: 12 },
    startAbs: absMonth(year, 1), endAbs: absMonth(year, 12),
  });
}

describe("Qin-to-Sui card primary priority", () => {
  it.each([-221, -202, 1, 220, 581, 617])(
    "prefers person title over name and other appellations for year %i",
    (year) => {
      expect(resolveReignCardLabel(reignAt(year), "姓名", {
        clan: { title: " 人物称号 ", posthumousNames: ["谥号"], templeNames: ["庙号"] },
      })).toBe("人物称号");
    },
  );

  it.each([undefined, null, "", " "])("uses the personal name when title is %s", (title) => {
    expect(resolveReignCardLabel(reignAt(581), " 姓名 ", {
      clan: { title, posthumousNames: ["谥号"] },
    })).toBe("姓名");
    expect(resolveReignCardLabel(reignAt(581), " ", {
      clan: { title, posthumousNames: ["谥号"] },
    })).toBe("");
  });

  it("shows 始皇帝 as primary and skips a duplicate reign title", () => {
    const reign = reignAt(-221, "始皇帝");
    const context = { title: "始皇帝", personClanShi: "赵", personAncestralXing: "嬴" };
    expect(resolveReignCardLabel(reign, "政", { clan: context })).toBe("始皇帝");
    expect(resolveReignCardMeta(reign, "政", context)).toBeNull();
    expect(resolvePersonDetailTitle("政", context)).toBe("政");
    expect(resolveReignDetailHeading(reign, "秦", "政", context)).toBe("秦 · 始皇帝");
  });

  it("keeps a distinct reign title as meta and falls back to posthumous after a duplicate", () => {
    const context = { title: "人物称号", posthumousNames: ["谥号"] };
    expect(resolveReignCardMeta(reignAt(581), "姓名", context))
      .toEqual({ label: "称号", name: "在位称号" });
    expect(resolveReignCardMeta(reignAt(581, "人物称号"), "姓名", context))
      .toEqual({ label: "谥号", name: "谥号" });
  });

  it.each([
    { year: -222, expected: "在位称号" },
    { year: -221, expected: "人物称号" },
    { year: 617, expected: "人物称号" },
    { year: 618, expected: "姓名" },
    { year: 1912, expected: "姓名" },
  ])("uses the correct period rule for year $year", ({ year, expected }) => {
    expect(resolveReignCardLabel(reignAt(year), "姓名", {
      clan: { title: "人物称号", posthumousNames: ["谥号"], templeNames: ["庙号"] },
    })).toBe(expected);
  });
});
