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
const TIMELINE_CACHE_VERSION = 35;
/** Historical slices do not change at runtime; keep them hot across tab idle. */
const STALE_TIME = Infinity;
/** A short fallback GC prevents a long mobile session from retaining every visited era. */
const GC_TIME = 5 * 60_000;
const RETAINED_NEIGHBOR_CHUNKS = 2;

function chunkKey(chunk: QueryChunk) {
  return ["timeline-chunk", TIMELINE_CACHE_VERSION, chunk.fromAbs, chunk.toAbs, SCOPE] as const;
}

function sameChunks(a: readonly QueryChunk[], b: readonly QueryChunk[]): boolean {
  return a.length === b.length && a.every((chunk, index) =>
    chunk.fromAbs === b[index]?.fromAbs && chunk.toAbs === b[index]?.toAbs,
  );
}

async function fetchTimelineChunk(chunk: QueryChunk, lod: Lod, signal?: AbortSignal) {
  const repo = await getRepository();
  return repo.getTimeline({
    fromAbs: chunk.fromAbs,
    toAbs: chunk.toAbs,
    lod,
    scope: SCOPE,
    signal,
  });
}

export function shouldPruneTimelineChunk(
  queryKey: readonly unknown[],
  retainFromAbs: number,
  retainToAbs: number,
): boolean {
  if (queryKey[0] !== "timeline-chunk" || queryKey[1] !== TIMELINE_CACHE_VERSION) return false;
  const fromAbs = queryKey[2];
  const toAbs = queryKey[3];
  if (typeof fromAbs !== "number" || typeof toAbs !== "number") return false;
  return toAbs < retainFromAbs || fromAbs > retainToAbs;
}

const CHUNK_QUERY_OPTIONS = {
  staleTime: STALE_TIME,
  gcTime: GC_TIME,
  // Completed historical slices stay cached; failed chunks retry after a
  // temporary API interruption (for example while a local migration runs).
  refetchOnWindowFocus: (query: { state: { status: string } }) => query.state.status === "error",
  refetchOnReconnect: (query: { state: { status: string } }) => query.state.status === "error",
  refetchInterval: (query: { state: { status: string } }) =>
    query.state.status === "error" ? 10_000 : false,
} as const;

export function useTimelineData() {
  const viewport = useViewport();
  const queryClient = useQueryClient();

  const requestedChunks = listQueryChunks(viewport.startAbs - 60, viewport.endAbs + 60, viewport.lod);
  const stableChunksRef = useRef<{ lod: Lod; chunks: QueryChunk[] } | null>(null);
  if (!stableChunksRef.current || stableChunksRef.current.lod !== viewport.lod ||
      !sameChunks(stableChunksRef.current.chunks, requestedChunks)) {
    stableChunksRef.current = { lod: viewport.lod, chunks: requestedChunks };
  }
  const chunks = stableChunksRef.current.chunks;

  const queryOptions = useMemo(() => chunks.map((chunk) => ({
    queryKey: chunkKey(chunk),
    queryFn: ({ signal }: { signal: AbortSignal }) => fetchTimelineChunk(chunk, viewport.lod, signal),
    ...CHUNK_QUERY_OPTIONS,
  })), [chunks, viewport.lod]);
  const chunkQueries = useQueries({
    queries: queryOptions,
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

    const chunkSize = chunks[0]!.toAbs - chunks[0]!.fromAbs;
    const retainFromAbs = chunks[0]!.fromAbs - chunkSize * RETAINED_NEIGHBOR_CHUNKS;
    const retainToAbs = chunks[chunks.length - 1]!.toAbs + chunkSize * RETAINED_NEIGHBOR_CHUNKS;
    queryClient.removeQueries({
      predicate: (query) =>
        query.getObserversCount() === 0 &&
        shouldPruneTimelineChunk(query.queryKey, retainFromAbs, retainToAbs),
    });

    const neighbors = [
      getAdjacentChunk(chunks[0]!, -1, viewport.lod),
      getAdjacentChunk(chunks[chunks.length - 1]!, 1, viewport.lod),
    ];

    for (const prefetchChunk of neighbors) {
      void queryClient.prefetchQuery({
        queryKey: chunkKey(prefetchChunk),
        queryFn: ({ signal }) => fetchTimelineChunk(prefetchChunk, viewport.lod, signal),
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
