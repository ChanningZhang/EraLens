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
          templeName: undefined,
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
  });
});
