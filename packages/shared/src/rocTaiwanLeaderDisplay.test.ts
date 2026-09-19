import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import {
  isRocTaiwanLeaderEra,
  isRocTaiwanLeaderReign,
  resolveRocLaneRegionLabel,
  resolveRocReignDetailSubtitle,
  resolveRocReignRegionLabel,
} from "./rocTaiwanLeaderDisplay";

describe("rocTaiwanLeaderDisplay", () => {
  it("switches lane label to 台湾地区 from 1950 onward", () => {
    expect(
      resolveRocLaneRegionLabel("roc", "中华民国", absMonth(1949, 12)),
    ).toBe("中华民国");
    expect(
      resolveRocLaneRegionLabel("roc", "中华民国", absMonth(1950)),
    ).toBe("台湾地区");
    expect(
      resolveRocLaneRegionLabel("roc", "中华民国", absMonth(2024)),
    ).toBe("台湾地区");
    expect(
      resolveRocLaneRegionLabel("ming", "明", absMonth(2024)),
    ).toBe("明");
  });

  it("uses 台湾地区 · 领导人 for ROC reigns starting in 1950 or later", () => {
    expect(
      isRocTaiwanLeaderReign({
        dynastyId: "roc",
        start: { year: 1949, month: 1 },
      }),
    ).toBe(false);
    expect(
      isRocTaiwanLeaderReign({
        dynastyId: "roc",
        start: { year: 1950, month: 3 },
      }),
    ).toBe(true);
    expect(
      isRocTaiwanLeaderReign({
        dynastyId: "roc",
        start: { year: 2000, month: 5 },
      }),
    ).toBe(true);
    expect(resolveRocReignDetailSubtitle()).toBe("台湾地区 · 领导人");
    expect(
      resolveRocReignRegionLabel(
        { dynastyId: "roc", start: { year: 2016, month: 5 } },
        "中华民国",
      ),
    ).toBe("台湾地区");
  });

  it("marks 1950 as the Taiwan leader era boundary", () => {
    expect(isRocTaiwanLeaderEra(absMonth(1949, 12))).toBe(false);
    expect(isRocTaiwanLeaderEra(absMonth(1950))).toBe(true);
  });
});
