import { useQueries, useQuery, useQueryClient } from "@tanstack/react-query";
import { useEffect, useMemo, useRef } from "react";
import {
  getAdjacentChunk,
  listQueryChunks,
  mergeTimelineSlices,
  type QueryChunk,
  type TimelineSlice,
} from "@eralens/shared";
import { getRepository } from "@/data/repository";
import { useViewport } from "./useViewport";

const SCOPE = "cn";
const STALE_TIME = 5 * 60_000;
const TIMELINE_CACHE_VERSION = 25;

function chunkKey(chunk: QueryChunk) {
  return ["timeline-chunk", TIMELINE_CACHE_VERSION, chunk.fromAbs, chunk.toAbs, SCOPE] as const;
}

export function useTimelineData() {
  const viewport = useViewport();
  const queryClient = useQueryClient();
  const prevCenterRef = useRef(viewport.centerAbs);

  const chunks = useMemo(
    () => listQueryChunks(viewport.startAbs, viewport.endAbs, viewport.lod),
    [viewport.startAbs, viewport.endAbs, viewport.lod],
  );

  const chunkQueries = useQueries({
    queries: chunks.map((chunk) => ({
      queryKey: chunkKey(chunk),
      queryFn: async () => {
        const repo = await getRepository();
        return repo.getTimeline({
          fromAbs: chunk.fromAbs,
          toAbs: chunk.toAbs,
          lod: viewport.lod,
          scope: SCOPE,
        });
      },
      staleTime: STALE_TIME,
    })),
  });

  const lastCompleteDataRef = useRef<TimelineSlice | undefined>(undefined);

  const mergedData = useMemo(() => {
    const slices = chunkQueries.map((query) => query.data);
    const allChunksReady = slices.length > 0 && slices.every(Boolean);
    if (!allChunksReady) {
      return lastCompleteDataRef.current;
    }
    const merged = mergeTimelineSlices(slices as TimelineSlice[]);
    lastCompleteDataRef.current = merged;
    return merged;
  }, [chunkQueries]);

  const isLoading = chunkQueries.some((query) => query.isLoading);
  const isFetching = chunkQueries.some((query) => query.isFetching);
  const error = chunkQueries.find((query) => query.error)?.error ?? null;

  useEffect(() => {
    const prevCenter = prevCenterRef.current;
    const direction = Math.sign(viewport.centerAbs - prevCenter);
    prevCenterRef.current = viewport.centerAbs;

    if (direction === 0 || chunks.length === 0) return;

    const edgeChunk = direction > 0 ? chunks[chunks.length - 1]! : chunks[0]!;
    const prefetchChunk = getAdjacentChunk(edgeChunk, direction as -1 | 1, viewport.lod);

    void queryClient.prefetchQuery({
      queryKey: chunkKey(prefetchChunk),
      queryFn: async () => {
        const repo = await getRepository();
        return repo.getTimeline({
          fromAbs: prefetchChunk.fromAbs,
          toAbs: prefetchChunk.toAbs,
          lod: viewport.lod,
          scope: SCOPE,
        });
      },
      staleTime: STALE_TIME,
    });
  }, [chunks, queryClient, viewport.centerAbs, viewport.lod]);

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
