import { describe, expect, it } from "vitest";
import { fileURLToPath } from "node:url";
import { resolveFateRelations } from "@eralens/shared";
import { loadReignsFromImports } from "../../../../../../data/imports/lib/fateRelationHelpers.mjs";
import { buildFateCatalog } from "../../../../../../data/imports/cross-dynasty-fate/catalog.mjs";
import { layoutReignFates } from "./reignFateLayout";

describe("imported Chimei fate endpoints", () => {
  it("resolves and draws both connections through Liu Penzi's effective reign", () => {
    const reigns = loadReignsFromImports(fileURLToPath(new URL("../../../../../../data/imports/", import.meta.url)));
    const leader = reigns.find((reign) => reign.id === "reign-fan-chong-chimei");
    const emperor = reigns.find((reign) => reign.id === "reign-liu-panzi-chimei");
    expect(leader.end).toEqual(emperor.start);
    const ids = ["rel-liu-xuan-liu-panzi-surrender", "rel-liu-panzi-liu-xiu-surrender"];
    const relations = buildFateCatalog().filter((entry) => ids.includes(entry.id)).map((entry) => ({
      id: entry.id,
      fromRef: `person:${entry.fromPersonId}`,
      toRef: `person:${entry.toPersonId}`,
      kind: entry.kind,
      atAbs: entry.resolveAt().abs,
    }));
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
