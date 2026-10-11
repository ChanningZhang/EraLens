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
  ])("prefers card titles for %s / %s", (title, personTitle, posthumousNames, name, expected) => {
    const context = { title: personTitle, posthumousNames };
    expect(resolveReignPrimaryLabel({ ...reign, title }, name, context)).toBe(expected);
  });

  it.each([
    { name: "克", shi: "曹", expected: "曹克" },
    { name: "克", shi: undefined, expected: "克" },
    { name: " 克 ", shi: " 曹 ", expected: "曹克" },
    { name: "克", shi: " ", expected: "克" },
    { name: "？", shi: "曹", expected: "曹？" },
  ])("uses the present personal name in details: $name / $shi", ({ name, shi, expected }) => {
    expect(resolvePersonDetailTitle(name, {
      personClanShi: shi, personAncestralXing: "姬", title: "庄公", posthumousNames: ["庄"],
    }, { preQin: true })).toBe(expected);
  });

  it.each([null, undefined, "", " "])("uses posthumous name then person title when name is %s", (name) => {
    const context = { personClanShi: "曹", title: "庄公", posthumousNames: ["庄"] };
    expect(resolvePersonDetailTitle(name, context, { preQin: true })).toBe("庄");
    expect(resolvePersonDetailTitle(name, { ...context, posthumousNames: [] }, { preQin: true })).toBe("庄公");
    expect(resolvePersonDetailTitle(name, { ...context, posthumousNames: [], title: "" }, { preQin: true })).toBe("");
  });

  it("keeps distinct given names as meta and skips the large title", () => {
    expect(resolveReignCardMeta(reign, "克", { title: "庄公", posthumousNames: ["庄"] }))
      .toEqual({ label: "名", name: "克" });
    expect(resolveReignCardMeta({ ...reign, title: "克" }, "克", {})).toBeNull();
  });

  it.each([
    { name: "克", shi: "曹", expected: "曹克" },
    { name: "克", shi: undefined, expected: "克" },
    { name: " 克 ", shi: " 曹 ", expected: "曹克" },
    { name: "克", shi: " ", expected: "克" },
    { name: "", shi: "曹", expected: null },
    { name: " ", shi: "曹", expected: null },
  ])("uses clan and personal name in card meta: $name / $shi", ({ name, shi, expected }) => {
    const context = { personClanShi: shi, personAncestralXing: "姬", title: "庄公" };
    expect(resolveReignCardMeta(reign, name, context))
      .toEqual(expected ? { label: "名", name: expected } : null);
    expect(resolveReignCardMeta({ ...reign, title: "在位称号" }, name, context))
      .toEqual(expected ? { label: "名", name: expected } : null);
  });

  it("skips a clan and personal name matching the card primary", () => {
    const context = { personClanShi: "曹", title: "曹克" };
    expect(resolveReignCardMeta(reign, "克", context)).toBeNull();
    expect(resolveReignCardMeta({ ...reign, title: "曹克" }, "克", context)).toBeNull();
    expect(resolveReignCardMeta({ ...reign, title: "克" }, "克", context))
      .toEqual({ label: "名", name: "曹克" });
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
      persons: [PersonSchema.parse({ id: "test-person", name: "克", clanShi: "曹", title: "庄公", dynastyId: "test-state", posthumousNames: ["庄"] })],
      reigns: [{ ...reign, title: "在位称号" }], events: [], relations: [],
    };
    const detail = buildEntityDetail(store, { type: "reign", id: reign.id });
    expect(detail).toMatchObject({ title: "曹克", subtitle: "邾 · 在位称号" });
    expect(buildEntityDetail(store, { type: "person", id: "test-person" }))
      .toMatchObject({ title: "曹克", subtitle: "邾 · 庄" });
    expect(detail.facts).toContainEqual({ label: "谥号", value: "庄" });
    expect(buildEntityDetail({ ...store, reigns: [{ ...reign, dynastyName: "并立称号" }] }, { type: "reign", id: reign.id }).subtitle)
      .toBe("并立称号 · 庄公");
    const unnamedStore = { ...store, persons: [{ ...store.persons[0]!, name: "" }] };
    expect(buildEntityDetail(unnamedStore, { type: "reign", id: reign.id }).title).toBe("庄");
    expect(buildEntityDetail(unnamedStore, { type: "person", id: "test-person" }).title).toBe("庄");
    const untitledStore = { ...unnamedStore, persons: [{ ...unnamedStore.persons[0]!, posthumousNames: [] }] };
    expect(buildEntityDetail(untitledStore, { type: "reign", id: reign.id }).title).toBe("庄公");
    expect(buildEntityDetail(untitledStore, { type: "person", id: "test-person" }).title).toBe("庄公");
  });

  it("keeps imperial heading priorities unchanged", () => {
    expect(resolvePersonDetailTitle("李世民", { personClanShi: "李", title: "人物称号", posthumousNames: ["文皇帝"] }))
      .toBe("李世民");
    expect(resolveReignDetailHeading({ ...reign, start: { ...reign.start, year: 700 } }, "唐", "李世民", {
      title: "人物称号", templeNames: ["太宗"], posthumousNames: ["文皇帝"],
    })).toBe("唐 · 太宗");
  });
});
