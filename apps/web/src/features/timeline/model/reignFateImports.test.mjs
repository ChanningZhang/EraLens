import { describe, expect, it } from "vitest";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { absMonth, fateRelationLabel, RelationSchema, resolveFateRelations } from "@eralens/shared";
import { loadReignsFromImports } from "../../../../../../data/imports/lib/fateRelationHelpers.mjs";
import { layoutReignFates } from "./reignFateLayout";

const fateCache = JSON.parse(readFileSync(fileURLToPath(new URL("../../../../../../data/imports/cross-dynasty-fate/cache.json", import.meta.url)), "utf8"));

describe("imported Guo conquest endpoints", () => {
  it("draws each last ruler to the ruler of the conquering state without asserting a personal fate", () => {
    const reigns = loadReignsFromImports(fileURLToPath(new URL("../../../../../../data/imports/", import.meta.url)));
    const cases = [
      ["rel-guo-east-last-shu-zheng-r1-conquered", "reign-guo-east-last-shu", "reign-zheng-r1-zheng-chunqiu", -767, "approximate_year"],
      ["rel-guo-gong-chou-jin-r20-conquered", "reign-guo-gong-chou-guo-chunqiu", "reign-jin-r20-jin-chunqiu", -655, "year"],
    ];
    expect(fateRelationLabel("conquered")).toBe("灭国");
    for (const [id, fromId, toId, year, confidence] of cases) {
      const relation = fateCache.relations.find((entry) => entry.id === id);
      expect(RelationSchema.safeParse(relation).success).toBe(true);
      expect(RelationSchema.safeParse({ ...relation, atAbs: undefined }).success).toBe(false);
      expect(relation.kind).toBe("conquered");
      expect(relation.atConfidence).toBe(confidence);
      const atAbs = absMonth(year, 12);
      expect(relation.atAbs).toBe(atAbs);
      const [resolved] = resolveFateRelations([relation], reigns);
      expect(resolved.fromReign.id).toBe(fromId);
      expect(resolved.toReign.id).toBe(toId);
      expect(resolved.fromReign.endAbs).toBe(atAbs);
      const lanes = [resolved.fromReign.dynastyId, resolved.toReign.dynastyId].map((dynastyId, index) => ({
        dynastyId,
        records: reigns.filter((reign) => reign.dynastyId === dynastyId),
        top: index * 120,
        color: "#806080",
      }));
      const [placed] = layoutReignFates([relation], reigns, lanes,
        { centerAbs: atAbs, pxPerMonth: 4, widthPx: 1200 }, new Map());
      expect(placed.id).toBe(id);
      expect(placed.eventX).toBe(600);
      expect(placed.destinationY).toBeGreaterThan(placed.originY);
      expect(placed.tooltip).toContain("灭国");
    }
  });
});

describe("imported Chimei fate endpoints", () => {
  it("resolves and draws both connections through Liu Penzi's effective reign", () => {
    const reigns = loadReignsFromImports(fileURLToPath(new URL("../../../../../../data/imports/", import.meta.url)));
    const leader = reigns.find((reign) => reign.id === "reign-fan-chong-chimei");
    const emperor = reigns.find((reign) => reign.id === "reign-liu-panzi-chimei");
    expect(leader.end).toEqual(emperor.start);
    const ids = ["rel-liu-xuan-liu-panzi-surrender", "rel-liu-panzi-liu-xiu-surrender"];
    const relations = fateCache.relations.filter((entry) => ids.includes(entry.id));
    expect(resolveFateRelations(relations, reigns).map((item) => item.relation.id)).toEqual(ids);
    expect(relations.map((relation) => relation.kind)).toEqual(["surrender", "surrender"]);
    const oldReigns = reigns.map((reign) => reign.id === leader.id
      ? { ...reign, end: { year: 27, month: 12 }, endAbs: 335, precision: "year" }
      : reign.id === emperor.id
        ? { ...reign, start: { year: 25, month: 1 }, startAbs: 300,
          end: { year: 27, month: 12 }, endAbs: 335, precision: "year" }
        : reign);
    expect(resolveFateRelations(relations, oldReigns)).toHaveLength(0);
    const lanes = ["han-gengshi", "chimei", "han-east"].map((dynastyId, index) => ({
      dynastyId,
      records: reigns.filter((reign) => reign.dynastyId === dynastyId),
      top: index * 120,
      color: "#806080",
    }));
    const placed = layoutReignFates(relations, reigns, lanes,
      { centerAbs: 310, pxPerMonth: 4, widthPx: 1200 }, new Map());
    expect(placed.map((item) => item.id)).toEqual(ids);
    for (const item of placed) {
      expect(item.destinationY).toBeGreaterThan(item.originY);
      expect(Number.isFinite(item.eventX)).toBe(true);
    }
  });
});
