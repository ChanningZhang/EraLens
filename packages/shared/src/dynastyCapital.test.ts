import { describe, expect, it } from "vitest";
import { DynastyCapitalSchema } from "./schema";

const baseCapital = {
  id: "cap-tang-changan",
  dynastyId: "tang",
  historicalName: "长安",
  modernName: "陕西省西安市",
  longitude: 108.939645,
  latitude: 34.343207,
  start: { year: 618, month: 1 },
  end: { year: 904, month: 12 },
  startAbs: 7416,
  endAbs: 10848,
};

describe("DynastyCapitalSchema", () => {
  it("parses capital records without modernName format checks", () => {
    expect(DynastyCapitalSchema.parse(baseCapital).modernName).toBe("陕西省西安市");
    expect(
      DynastyCapitalSchema.parse({
        ...baseCapital,
        modernName: "西安",
      }).modernName,
    ).toBe("西安");
  });
});
