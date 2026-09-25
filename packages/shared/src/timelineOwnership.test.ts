import { describe, expect, it } from "vitest";
import type { Reign } from "./schema";
import { activeReignsAtAbs, capitalOwnershipInterval, reignOwnershipInterval, reignOwnsAbs } from "./timelineOwnership";

function reign(id: string, startYear: number, endYear: number): Reign {
  return {
    id, dynastyId: "han", personId: id, title: id, eraNames: [],
    start: { year: startYear, month: 1 }, end: { year: endYear, month: 12 },
    startAbs: startYear * 12, endAbs: endYear * 12 + 11, precision: "year",
  };
}

describe("reign ownership interval cache", () => {
  it("reuses immutable peer sets and recalculates when the peer set changes", () => {
    const older = reign("older", 1, 3);
    const later = reign("later", 3, 4);
    const alone = [later];
    const together = [older, later];
    expect(reignOwnershipInterval(later, alone)).toBe(reignOwnershipInterval(later, alone));
    expect(reignOwnershipInterval(later, together).startExclusive)
      .toBeGreaterThan(reignOwnershipInterval(later, alone).startExclusive);
  });

  it("keeps the fast active lookup equivalent at year boundaries", () => {
    const older = reign("older", 1, 3);
    const later = reign("later", 3, 4);
    const reigns = [older, later];
    for (const atAbs of [0, 12, 24, 35, 36, 47, 48, 59, 60]) {
      expect(activeReignsAtAbs(reigns, atAbs))
        .toEqual(reigns.filter((item) => reignOwnsAbs(item, reigns, atAbs)));
    }
  });

  it("recalculates capital handoffs for a changed peer set", () => {
    const older = { dynastyId: "han", modernName: "长安", role: "primary" as const,
      startAbs: 0, endAbs: 35, start: { year: 1, month: 1 }, end: { year: 3, month: 12 }, precision: "year" as const };
    const later = { dynastyId: "han", modernName: "长安", role: "primary" as const,
      startAbs: 24, endAbs: 47, start: { year: 3, month: 1 }, end: { year: 4, month: 12 }, precision: "year" as const };
    const alone = [later];
    const together = [older, later];
    expect(capitalOwnershipInterval(later, alone)).toBe(capitalOwnershipInterval(later, alone));
    expect(capitalOwnershipInterval(later, together).startExclusive)
      .toBeGreaterThan(capitalOwnershipInterval(later, alone).startExclusive);
  });
});
