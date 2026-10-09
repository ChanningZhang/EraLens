import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import { DynastySchema, type Reign } from "./schema";
import { buildEntityDetail, searchEntities, type TimelineDataStore } from "./timelineData";
import { resolveReignVisualSpan } from "./reignBoundaries";
import { resolveFrozenLaneLabel } from "./timelineLanes";
import { parseDynastyName, resolveDynastyName, resolveDynastyDefaultName, dynastyNameSearchEntries, reignDynastyNameDurations, resolveReignDynastyNameByDuration } from "./dynastyNames";
import { buildPersonSearchTerms } from "./personSearchTerms";

const date = (year: number, month = 1, day = 1) => ({ year, month, day, confidence: "day" as const });
const dynasty = DynastySchema.parse({
  id: "changing-state", altNames: ["代表名称", "检索别名"],
  name: JSON.stringify({ default: "俗称", periods: [
    { name: "旧名", start: date(1900), end: date(1901, 1, 15) },
    { name: "新名", start: date(1901, 1, 15), end: date(1902, 12, 31) },
  ] }),
  start: date(1900), end: date(1902, 12, 31), startAbs: absMonth(1900), endAbs: absMonth(1902, 12),
});
const reign: Reign = {
  id: "one-continuous-reign", dynastyId: dynasty.id, personId: "ruler", title: "君主", eraNames: [],
  start: date(1900), end: date(1902, 12, 31), startAbs: absMonth(1900), endAbs: absMonth(1902, 12),
  precision: "day", isInformalMonarch: false,
};
const store: TimelineDataStore = {
  dynasties: [dynasty], reigns: [reign], events: [], relations: [],
  persons: [{ id: "ruler", name: "某人", dynastyId: dynasty.id, roles: ["君主"], altNames: [], links: [], posthumousNames: [], templeNames: ["太祖"] }],
};

describe("dynasty names", () => {
  it("assigns a reign spanning a rename to the name used longest", () => {
    expect(resolveReignDynastyNameByDuration(dynasty, reign, [reign])).toBe("新名");
    const short = { ...reign, end: date(1901, 2), endAbs: absMonth(1901, 2) };
    expect(resolveReignDynastyNameByDuration(dynasty, short, [short])).toBe("旧名");
    expect(reignDynastyNameDurations(dynasty, reign, [reign])).toEqual([
      { name: "旧名", days: 380 }, { name: "新名", days: 715 },
    ]);
  });

  it("sums repeated name phases and uses default for uncovered days", () => {
    const changing = { name: JSON.stringify({ default: "默认", periods: [
      { name: "同名", start: date(1900), end: date(1900, 12, 31) },
      { name: "别名", start: date(1901), end: date(1901, 12, 31) },
      { name: "同名", start: date(1902), end: date(1902, 12, 31) },
    ] }) };
    expect(resolveReignDynastyNameByDuration(changing, reign, [reign])).toBe("同名");
    const outside = { ...reign, end: date(1910), endAbs: absMonth(1910) };
    expect(resolveReignDynastyNameByDuration(changing, outside, [outside])).toBe("默认");
  });

  it("leaves plain names unchanged even when aliases differ", () => {
    expect(resolveDynastyName({ name: "唐", altNames: ["大唐"] }, absMonth(700))).toBe("唐");
    expect(resolveDynastyDefaultName({ name: "唐", altNames: ["大唐"] })).toBe("唐");
  });

  it("takes the default name independently of aliases", () => {
    expect(resolveDynastyDefaultName(dynasty)).toBe("俗称");
    expect(resolveDynastyName(dynasty)).toBe("俗称");
    expect(resolveDynastyName(dynasty, absMonth(1800))).toBe("俗称");
    expect(resolveDynastyName(dynasty, absMonth(2000))).toBe("俗称");
    expect(resolveDynastyDefaultName({ ...dynasty, altNames: ["新的国号"] })).toBe("俗称");
    expect(resolveDynastyDefaultName({ ...dynasty, altNames: [] })).toBe("俗称");
  });

  it("switches in the middle of one reign without changing its geometry or ID", () => {
    const before = resolveReignVisualSpan(reign, [reign]);
    expect(resolveFrozenLaneLabel(dynasty, absMonth(1900, 12))).toBe("旧名");
    expect(resolveFrozenLaneLabel(dynasty, absMonth(1901, 2))).toBe("新名");
    expect(resolveReignVisualSpan(reign, [reign])).toEqual(before);
    expect(reign.id).toBe("one-continuous-reign");
  });

  it("uses default in a gap between name periods without using the first alias", () => {
    const gap = { ...dynasty, name: JSON.stringify({ default: "俗称", periods: [
      { name: "旧名", start: date(1900), end: date(1900, 12, 31) },
      { name: "新名", start: date(1902), end: date(1902, 12, 31) },
    ] }) };
    expect(resolveDynastyName(gap, absMonth(1901, 6))).toBe("俗称");
  });

  it("uses shared ownership at a day boundary", () => {
    const start = dynastyNameSearchEntries(dynasty, dynasty.startAbs).find(entry => entry.name === "新名")!.abs;
    expect(start).toBeCloseTo(absMonth(1901) + 15 / 31);
    expect(resolveDynastyName(dynasty, start - 1 / 31)).toBe("旧名");
    expect(resolveDynastyName(dynasty, start)).toBe("新名");
  });

  it("keeps year ownership despite a more precise later start", () => {
    const timed = { altNames: ["代表"], name: JSON.stringify({ default: "俗称", periods: [
      { name: "旧", start: { year: 1364, month: 1, confidence: "year" }, end: { year: 1368, month: 12, confidence: "year" } },
      { name: "新", start: { year: 1368, month: 1, confidence: "month" }, end: { year: 1400, month: 12, confidence: "year" } },
    ] }) };
    expect(resolveDynastyName(timed, absMonth(1368, 12))).toBe("旧");
    expect(resolveDynastyName(timed, absMonth(1369))).toBe("新");
  });

  it("supports BCE/CE intervals without a year zero", () => {
    const timed = { altNames: ["代表"], name: JSON.stringify({ default: "俗称", periods: [
      { name: "前", start: date(-2), end: date(-1, 12, 31) },
      { name: "后", start: date(1), end: date(2, 12, 31) },
    ] }) };
    expect(resolveDynastyName(timed, absMonth(-1, 12))).toBe("前");
    expect(resolveDynastyName(timed, absMonth(1))).toBe("后");
  });

  it("rejects malformed JSON, wrong shapes, and missing or empty defaults", () => {
    for (const name of ["{bad", "[]", "null", '{"periods":[]}', JSON.stringify({ periods: JSON.parse(dynasty.name).periods }), JSON.stringify({ default: "  ", periods: JSON.parse(dynasty.name).periods })]) {
      expect(() => parseDynastyName(name)).toThrow();
    }
    expect(DynastySchema.safeParse({ ...dynasty, altNames: [] }).success).toBe(true);
  });

  it("uses the representative name in focused and overview person details, including related summaries", () => {
    expect(buildEntityDetail(store, { type: "person", id: "ruler" }).subtitle).toBe("代表名称 · 太祖");
    for (const options of [{ focusReignId: reign.id }, { focusReignId: reign.id, atAbs: absMonth(1900) }]) {
      expect(buildEntityDetail(store, { type: "person", id: "ruler" }, options).subtitle).toBe("代表名称 · 君主");
    }
    expect(buildEntityDetail(store, { type: "reign", id: reign.id }).subtitle).toBe("代表名称 · 君主");
    const associated = { ...store, associations: [{ aRef: `dynasty:${dynasty.id}`, bRef: "person:ruler" }] };
    expect(buildEntityDetail(associated, { type: "dynasty", id: dynasty.id }).related.find(item => item.ref.type === "person")?.subtitle).toBe("代表名称 · 太祖");
  });

  it.each([
    ["蜀汉", ["汉", "蜀", "季汉"], undefined, "汉"],
    ["蜀汉", ["汉", "蜀", "季汉"], "并立称号", "并立称号"],
    ["蜀汉", ["汉", "蜀", "季汉"], "  ", "汉"],
    ["蜀汉", [], undefined, "蜀汉"],
  ])("uses claim label then first alias for a focused plain dynasty: %s / %s / %s", (name, altNames, claimLabel, expected) => {
    const plainStore: TimelineDataStore = {
      ...store,
      dynasties: [{ ...dynasty, name, altNames }],
      reigns: [{ ...reign, claimLabel }],
    };
    expect(buildEntityDetail(plainStore, { type: "reign", id: reign.id }).subtitle).toBe(`${expected} · 君主`);
    expect(buildEntityDetail(plainStore, { type: "person", id: "ruler" }, { focusReignId: reign.id }).subtitle)
      .toBe(`${expected} · 君主`);
    expect(buildEntityDetail(plainStore, { type: "person", id: "ruler" }).subtitle)
      .toBe(`${altNames[0] || name} · 太祖`);
  });

  it("resolves dynasty detail titles from optional time context", () => {
    expect(buildEntityDetail(store, { type: "dynasty", id: dynasty.id }).title).toBe("俗称");
    expect(buildEntityDetail(store, { type: "dynasty", id: dynasty.id }, { atAbs: absMonth(1901, 2) }).title).toBe("新名");
  });

  it("searches all periods and aliases, deduplicates a dynasty, and anchors matched names", () => {
    expect(searchEntities(store, "旧名")[0]).toMatchObject({ ref: { type: "dynasty", id: dynasty.id }, label: "旧名" });
    const newer = searchEntities(store, "新名")[0]!;
    expect(resolveDynastyName(dynasty, newer.abs)).toBe("新名");
    expect(searchEntities(store, "名").filter(hit => hit.ref.type === "dynasty")).toHaveLength(1);
    expect(searchEntities(store, "检索别名")[0]?.label).toBe("俗称");
    expect(searchEntities(store, "俗称")[0]?.label).toBe("俗称");
    const terms = buildPersonSearchTerms({ ...store.persons[0]!, templeNames: ["太祖"] }, [reign], [dynasty]);
    expect(terms).toEqual(expect.arrayContaining(["俗称太祖", "旧名太祖", "新名太祖", "代表名称太祖"]));
    expect(terms.some(term => term.includes("periods"))).toBe(false);
  });
});
