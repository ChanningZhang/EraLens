import { QueryClient } from "@tanstack/react-query";
import { describe, expect, it, vi } from "vitest";
import { shouldPruneTimelineChunk, TIMELINE_CHUNK_OPTIONS } from "./useTimelineData";

it("keeps a nearby prefetched chunk available after a long idle", async () => {
  vi.useFakeTimers();
  const client = new QueryClient();
  const queryKey = ["timeline-layer", 36, 0, 600, "cn", "events", "v1"];
  const fetchChunk = vi.fn(async () => ({ datasetVersion: "v1", events: [] }));
  try {
    await client.prefetchQuery({ queryKey, queryFn: fetchChunk, ...TIMELINE_CHUNK_OPTIONS });
    await vi.advanceTimersByTimeAsync(60 * 60_000);
    await client.fetchQuery({ queryKey, queryFn: fetchChunk, ...TIMELINE_CHUNK_OPTIONS });
    expect(fetchChunk).toHaveBeenCalledTimes(1);
    client.removeQueries({ predicate: q => shouldPruneTimelineChunk(q.queryKey, 1200, 3600) });
    expect(client.getQueryData(queryKey)).toBeUndefined();
  } finally {
    client.clear();
    vi.useRealTimers();
  }
});

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
