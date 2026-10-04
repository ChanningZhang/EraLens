import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import { DynastySchema, type Reign } from "./schema";
import { buildEntityDetail, searchEntities, type TimelineDataStore } from "./timelineData";
import { resolveReignVisualSpan } from "./reignBoundaries";
import { resolveFrozenLaneLabel } from "./timelineLanes";
import { parseDynastyName, resolveDynastyName, resolveDynastyDefaultName, dynastyNameSearchEntries } from "./dynastyNames";
import { buildPersonSearchTerms } from "./personSearchTerms";

const date = (year: number, month = 1, day = 1) => ({ year, month, day, confidence: "day" as const });
const dynasty = DynastySchema.parse({
  id: "changing-state", altNames: ["代表名称", "检索别名"],
  name: JSON.stringify({ periods: [
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
  it("leaves plain names unchanged even when aliases differ", () => {
    expect(resolveDynastyName({ name: "唐", altNames: ["大唐"] }, absMonth(700))).toBe("唐");
    expect(resolveDynastyDefaultName({ name: "唐", altNames: ["大唐"] })).toBe("唐");
  });

  it("takes the representative name only from the first alias", () => {
    expect(resolveDynastyDefaultName(dynasty)).toBe("代表名称");
    expect(resolveDynastyName(dynasty)).toBe("代表名称");
    expect(resolveDynastyName(dynasty, absMonth(1800))).toBe("代表名称");
    expect(resolveDynastyName(dynasty, absMonth(2000))).toBe("代表名称");
    expect(resolveDynastyDefaultName({ ...dynasty, altNames: ["新的代表名称"] })).toBe("新的代表名称");
  });

  it("switches in the middle of one reign without changing its geometry or ID", () => {
    const before = resolveReignVisualSpan(reign, [reign]);
    expect(resolveFrozenLaneLabel(dynasty, absMonth(1900, 12))).toBe("旧名");
    expect(resolveFrozenLaneLabel(dynasty, absMonth(1901, 2))).toBe("新名");
    expect(resolveReignVisualSpan(reign, [reign])).toEqual(before);
    expect(reign.id).toBe("one-continuous-reign");
  });

  it("uses shared ownership at a day boundary", () => {
    const start = dynastyNameSearchEntries(dynasty, dynasty.startAbs).find(entry => entry.name === "新名")!.abs;
    expect(start).toBeCloseTo(absMonth(1901) + 15 / 31);
    expect(resolveDynastyName(dynasty, start - 1 / 31)).toBe("旧名");
    expect(resolveDynastyName(dynasty, start)).toBe("新名");
  });

  it("keeps year ownership despite a more precise later start", () => {
    const timed = { altNames: ["代表"], name: JSON.stringify({ periods: [
      { name: "旧", start: { year: 1364, month: 1, confidence: "year" }, end: { year: 1368, month: 12, confidence: "year" } },
      { name: "新", start: { year: 1368, month: 1, confidence: "month" }, end: { year: 1400, month: 12, confidence: "year" } },
    ] }) };
    expect(resolveDynastyName(timed, absMonth(1368, 12))).toBe("旧");
    expect(resolveDynastyName(timed, absMonth(1369))).toBe("新");
  });

  it("supports BCE/CE intervals without a year zero", () => {
    const timed = { altNames: ["代表"], name: JSON.stringify({ periods: [
      { name: "前", start: date(-2), end: date(-1, 12, 31) },
      { name: "后", start: date(1), end: date(2, 12, 31) },
    ] }) };
    expect(resolveDynastyName(timed, absMonth(-1, 12))).toBe("前");
    expect(resolveDynastyName(timed, absMonth(1))).toBe("后");
  });

  it("rejects malformed JSON, obsolete defaults, wrong shapes, and missing representative aliases", () => {
    for (const name of ["{bad", "[]", "null", '{"periods":[]}', JSON.stringify({ default: "obsolete", periods: JSON.parse(dynasty.name).periods })]) {
      expect(() => parseDynastyName(name)).toThrow();
    }
    expect(DynastySchema.safeParse({ ...dynasty, altNames: [] }).success).toBe(false);
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

  it("resolves dynasty detail titles from optional time context", () => {
    expect(buildEntityDetail(store, { type: "dynasty", id: dynasty.id }).title).toBe("代表名称");
    expect(buildEntityDetail(store, { type: "dynasty", id: dynasty.id }, { atAbs: absMonth(1901, 2) }).title).toBe("新名");
  });

  it("searches all periods and aliases, deduplicates a dynasty, and anchors matched names", () => {
    expect(searchEntities(store, "旧名")[0]).toMatchObject({ ref: { type: "dynasty", id: dynasty.id }, label: "旧名" });
    const newer = searchEntities(store, "新名")[0]!;
    expect(resolveDynastyName(dynasty, newer.abs)).toBe("新名");
    expect(searchEntities(store, "名").filter(hit => hit.ref.type === "dynasty")).toHaveLength(1);
    expect(searchEntities(store, "检索别名")[0]?.label).toBe("代表名称");
    const terms = buildPersonSearchTerms({ ...store.persons[0]!, templeNames: ["太祖"] }, [reign], [dynasty]);
    expect(terms).toEqual(expect.arrayContaining(["旧名太祖", "新名太祖", "代表名称太祖"]));
    expect(terms.some(term => term.includes("periods"))).toBe(false);
  });
});
