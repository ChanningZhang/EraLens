import { describe, expect, it } from "vitest";
import { REIGN_GAP_COVERAGE_FROM } from "./reignGapCoverage";

describe("reignGapCoverage", () => {
  it("fills Tang gaps with Wu Zhou reign coverage", () => {
    expect(REIGN_GAP_COVERAGE_FROM.tang).toEqual(["zhou-wu"]);
  });
});
