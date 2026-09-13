import { describe, expect, it } from "vitest";
import type { Reign } from "./schema";
import { buildEntityDetail } from "./timelineData";

function reign(overrides: Partial<Reign>): Reign {
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
    eraNames: [{ name: "建隆", start: { year: 960, month: 1 }, end: { year: 963, month: 12 }, startAbs: 0, endAbs: 1, sortOrder: 0 }],
    templeName: "太祖",
    preferredAppellation: { kind: "temple", name: "宋太祖" },
    ...overrides,
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
        },
      ],
      events: [],
      relations: [],
    };

    const detail = buildEntityDetail(store, { type: "reign", id: "reign-test" });

    expect(detail.title).toBe("赵匡胤");
    expect(detail.subtitle).toBe("北宋 · 宋太祖");
    expect(detail.facts).toEqual([
      { label: "在位", value: "960 — 976" },
      { label: "庙号", value: "太祖" },
      { label: "年号", value: "建隆" },
    ]);
  });
});
