import { describe, expect, it } from "vitest";
import { shouldPruneTimelineChunk } from "./useTimelineData";

describe("shouldPruneTimelineChunk", () => {
  it("prunes only current-version timeline chunks outside the retention window", () => {
    expect(shouldPruneTimelineChunk(
      ["timeline-layer", 36, 0, 600, "cn"],
      1200,
      3600,
    )).toBe(true);
    expect(shouldPruneTimelineChunk(
      ["timeline-layer", 36, 600, 1200, "cn"],
      1200,
      3600,
    )).toBe(false);
    expect(shouldPruneTimelineChunk(
      ["timeline-layer", 36, 3600, 4200, "cn"],
      1200,
      3600,
    )).toBe(false);
  });

  it("leaves unrelated and differently-versioned queries alone", () => {
    expect(shouldPruneTimelineChunk(["bounds", 8], 1200, 3600)).toBe(false);
    expect(shouldPruneTimelineChunk(
      ["timeline-layer", 35, 0, 600, "cn"],
      1200,
      3600,
    )).toBe(false);
  });
});
