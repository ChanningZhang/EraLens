import { createElement } from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { describe, expect, it, vi } from "vitest";
import { absMonth, DynastySchema, type CapitalLocation } from "@eralens/shared";
import { CapitalMapLayer } from "./CapitalMapLayer";
import { resolveChinaMapLayout } from "../model/chinaMapProjection";

vi.mock("../hooks/useSelection", () => ({ useSelection: () => ({ selected: null }) }));
vi.mock("../state/selectionStore", () => ({ selectionStore: { select: vi.fn() } }));

const dynasty = DynastySchema.parse({
  id: "changing-state", altNames: ["代表名称"],
  name: JSON.stringify({ default: "俗称", periods: [
    { name: "旧名", start: { year: 1900, month: 1, confidence: "year" }, end: { year: 1901, month: 12, confidence: "year" } },
    { name: "新名", start: { year: 1902, month: 1, confidence: "year" }, end: { year: 1903, month: 12, confidence: "year" } },
  ] }),
  start: { year: 1900, month: 1 }, end: { year: 1903, month: 12 },
  startAbs: absMonth(1900), endAbs: absMonth(1903, 12),
});
const capital: CapitalLocation = {
  id: "capital", dynastyId: dynasty.id, historicalName: "都城", modernName: "今址",
  longitude: 110, latitude: 30, coordinateSystem: "GCJ02", role: "primary", links: [],
  start: dynasty.start, end: dynasty.end!, startAbs: dynasty.startAbs, endAbs: dynasty.endAbs, precision: "year",
};

describe("CapitalMapLayer catalog fallback", () => {
  it.each([[1900, "旧名"], [1902, "新名"], [1800, "俗称"], [2000, "俗称"]])(
    "renders a retained capital at %s after its dynasty leaves the visible window",
    (year, expected) => {
      const markup = renderToStaticMarkup(createElement(CapitalMapLayer, {
        capitals: [capital], dynastiesById: new Map(),
        catalogDynastiesById: new Map([[dynasty.id, dynasty]]), laneColorMap: new Map(),
        atAbs: absMonth(year), layout: resolveChinaMapLayout(800, 600), scale: 1, offset: { x: 0, y: 0 },
      }));
      expect(markup).toContain(`${expected}都城都城（今址）`);
      expect(markup).not.toContain("periods");
    },
  );
});
