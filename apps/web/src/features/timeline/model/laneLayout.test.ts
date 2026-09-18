import { compareTimedOrder } from "@eralens/shared";
import { describe, expect, it } from "vitest";
import { generateBulkDynasties } from "@/data/mock/bulkGenerator";
import { assignLanes } from "@/features/timeline/model/laneLayout";
import { filterVisibleDynasties } from "@/features/timeline/model/visible";

describe("timeline performance helpers", () => {
  it("gives every visible dynasty its own row even when periods do not overlap", () => {
    const dynasties = generateBulkDynasties(4);
    const ordered = [...dynasties].sort(compareTimedOrder);
    const placed = assignLanes(ordered);

    expect(placed.map((item) => item.id)).toEqual(ordered.map((item) => item.id));
    expect(placed.map((item) => item.lane)).toEqual([0, 1, 2, 3]);
  });

  it("preserves relative order and only shifts later rows after one exits", () => {
    const dynasties = generateBulkDynasties(4);
    const ordered = [...dynasties].sort(compareTimedOrder);
    const before = assignLanes(ordered);
    const after = assignLanes(ordered.slice(1));

    expect(after.map((item) => item.id)).toEqual(before.slice(1).map((item) => item.id));
    expect(after.map((item) => item.lane)).toEqual([0, 1, 2]);
  });

  it("assigns lanes for 80 dynasties within budget", () => {
    const dynasties = generateBulkDynasties(80);
    const visible = filterVisibleDynasties(dynasties, 2400, 2800);
    const start = performance.now();
    const placed = assignLanes([...visible].sort(compareTimedOrder));
    const elapsed = performance.now() - start;
    expect(placed.length).toBeGreaterThan(0);
    expect(elapsed).toBeLessThan(20);
  });
});
