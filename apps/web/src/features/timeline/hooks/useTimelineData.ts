import { useQueries, useQuery, useQueryClient } from "@tanstack/react-query";
import { useEffect, useMemo, useRef } from "react";
import {
  getAdjacentChunk,
  listQueryChunks,
  mergeTimelineSlices,
  type Lod,
  type QueryChunk,
  type TimelineSlice,
} from "@eralens/shared";
import { getRepository } from "@/data/repository";
import { useViewport } from "./useViewport";

const SCOPE = "cn";
const TIMELINE_CACHE_VERSION = 32;
/** Historical slices do not change at runtime; keep them hot across tab idle. */
const STALE_TIME = Infinity;
/** Prefetched neighbors have 0 observers; default 5 min gc would drop them overnight. */
const GC_TIME = 24 * 60 * 60_000;

function chunkKey(chunk: QueryChunk) {
  return ["timeline-chunk", TIMELINE_CACHE_VERSION, chunk.fromAbs, chunk.toAbs, SCOPE] as const;
}

async function fetchTimelineChunk(chunk: QueryChunk, lod: Lod) {
  const repo = await getRepository();
  return repo.getTimeline({
    fromAbs: chunk.fromAbs,
    toAbs: chunk.toAbs,
    lod,
    scope: SCOPE,
  });
}

const CHUNK_QUERY_OPTIONS = {
  staleTime: STALE_TIME,
  gcTime: GC_TIME,
  refetchOnWindowFocus: false,
  refetchOnReconnect: false,
} as const;

export function useTimelineData() {
  const viewport = useViewport();
  const queryClient = useQueryClient();

  const chunks = useMemo(
    () => listQueryChunks(viewport.startAbs, viewport.endAbs, viewport.lod),
    [viewport.startAbs, viewport.endAbs, viewport.lod],
  );

  const chunkQueries = useQueries({
    queries: chunks.map((chunk) => ({
      queryKey: chunkKey(chunk),
      queryFn: () => fetchTimelineChunk(chunk, viewport.lod),
      ...CHUNK_QUERY_OPTIONS,
    })),
  });

  const lastCompleteDataRef = useRef<TimelineSlice | undefined>(undefined);
  const sliceRevision = [
    chunks.map((chunk) => `${chunk.fromAbs}-${chunk.toAbs}`).join(","),
    chunkQueries.map((query) => query.dataUpdatedAt).join(":"),
  ].join("|");

  const mergedData = useMemo(() => {
    const slices = chunkQueries.map((query) => query.data);
    const allChunksReady = slices.length > 0 && slices.every(Boolean);
    if (!allChunksReady) {
      return lastCompleteDataRef.current;
    }
    const merged = mergeTimelineSlices(slices as TimelineSlice[]);
    lastCompleteDataRef.current = merged;
    return merged;
    // useQueries returns a new array every render; dataUpdatedAt is the stable signal.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [sliceRevision]);

  const isLoading = chunkQueries.some((query) => query.isLoading);
  const isFetching = chunkQueries.some((query) => query.isFetching);
  const error = chunkQueries.find((query) => query.error)?.error ?? null;

  useEffect(() => {
    if (chunks.length === 0) return;

    const neighbors = [
      getAdjacentChunk(chunks[0]!, -1, viewport.lod),
      getAdjacentChunk(chunks[chunks.length - 1]!, 1, viewport.lod),
    ];

    for (const prefetchChunk of neighbors) {
      void queryClient.prefetchQuery({
        queryKey: chunkKey(prefetchChunk),
        queryFn: () => fetchTimelineChunk(prefetchChunk, viewport.lod),
        ...CHUNK_QUERY_OPTIONS,
      });
    }
  }, [chunks, queryClient, viewport.lod]);

  return {
    data: mergedData,
    isLoading,
    isFetching,
    error,
  };
}

export function useDataBounds() {
  return useQuery({
    queryKey: ["bounds", 8],
    queryFn: async () => {
      const repo = await getRepository();
      return repo.getBounds();
    },
    staleTime: Infinity,
  });
}
