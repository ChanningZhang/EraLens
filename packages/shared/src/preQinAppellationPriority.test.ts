import { describe, expect, it } from "vitest";
import { ReignSchema, DynastySchema, PersonSchema } from "./schema";
import { absMonth } from "./time";
import {
  resolvePersonDetailTitle, resolveReignPrimaryLabel,
  resolveReignCardMeta, resolveReignDetailHeading,
} from "./emperorAppellation";
import { buildEntityDetail } from "./timelineData";

const reign = ReignSchema.parse({
  id: "test-reign", dynastyId: "test-state", personId: "test-person", title: "",
  start: { year: -700, month: 1 }, end: { year: -680, month: 12 },
  startAbs: absMonth(-700, 1), endAbs: absMonth(-680, 12), precision: "year",
});

describe("pre-Qin pure posthumous names and display priorities", () => {
  it.each([
    ["特定在位称号", "庄公", ["庄"], "克", "特定在位称号"],
    ["", "庄公", ["庄"], "克", "庄公"],
    ["", "", ["庄"], "克", "庄"],
    ["", "", [], "克", "克"],
  ])("shares card and detail primary for %s / %s", (title, personTitle, posthumousNames, name, expected) => {
    const context = { title: personTitle, posthumousNames };
    expect(resolveReignPrimaryLabel({ ...reign, title }, name, context)).toBe(expected);
    expect(resolvePersonDetailTitle(name, context, { preQin: true, reignTitle: title })).toBe(expected);
  });

  it("keeps distinct given names as meta and skips the large title", () => {
    expect(resolveReignCardMeta(reign, "克", { title: "庄公", posthumousNames: ["庄"] }))
      .toEqual({ label: "名", name: "克" });
    expect(resolveReignCardMeta({ ...reign, title: "克" }, "克", {})).toBeNull();
  });

  it("uses full title with a reign focus and pure posthumous name without focus", () => {
    const context = { title: "庄公", posthumousNames: ["庄"] };
    expect(resolveReignDetailHeading(reign, "邾", "克", context)).toBe("邾 · 庄公");
    expect(resolveReignDetailHeading(reign, "邾", "克", context, { focusedReign: false, periodYear: -700 }))
      .toBe("邾 · 庄");
    expect(resolveReignDetailHeading(reign, "邾", "克", { posthumousNames: ["庄"] })).toBe("邾 · 庄");
  });

  it("shows pure posthumous facts and the representative dynasty name in actual details", () => {
    const store = {
      dynasties: [DynastySchema.parse({
        id: "test-state", name: "邹", altNames: ["邾"], scope: "cn", region: "east_asia",
        start: { year: -1000, month: 1 }, end: { year: -300, month: 12 },
        startAbs: absMonth(-1000, 1), endAbs: absMonth(-300, 12), precision: "year",
      })],
      persons: [PersonSchema.parse({ id: "test-person", name: "克", title: "庄公", dynastyId: "test-state", posthumousNames: ["庄"] })],
      reigns: [reign], events: [], relations: [],
    };
    const detail = buildEntityDetail(store, { type: "reign", id: reign.id });
    expect(detail).toMatchObject({ title: "庄公", subtitle: "邾 · 庄公" });
    expect(detail.facts).toContainEqual({ label: "谥号", value: "庄" });
    expect(buildEntityDetail({ ...store, reigns: [{ ...reign, claimLabel: "并立称号" }] }, { type: "reign", id: reign.id }).subtitle)
      .toBe("并立称号 · 庄公");
  });

  it("keeps imperial heading priorities unchanged", () => {
    expect(resolveReignDetailHeading({ ...reign, start: { ...reign.start, year: 700 } }, "唐", "李世民", {
      title: "人物称号", templeNames: ["太宗"], posthumousNames: ["文皇帝"],
    })).toBe("唐 · 太宗");
  });
});
