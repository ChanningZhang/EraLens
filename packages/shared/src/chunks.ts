import type { Lod } from "./schema";
import { TimelineSliceSchema, type TimelineSlice } from "./schema";

export type QueryChunk = {
  fromAbs: number;
  toAbs: number;
};

export const CHUNK_MONTHS_BY_LOD: Record<Lod, number> = {
  month: 120,
  decade: 600,
  century: 2400,
  millennium: 12000,
};

export function chunkMonthsForLod(lod: Lod): number {
  return CHUNK_MONTHS_BY_LOD[lod];
}

export function listQueryChunks(
  startAbs: number,
  endAbs: number,
  lod: Lod,
): QueryChunk[] {
  const chunkMonths = chunkMonthsForLod(lod);
  const alignedStart = Math.floor(startAbs / chunkMonths) * chunkMonths;
  const alignedEnd = Math.ceil(endAbs / chunkMonths) * chunkMonths;
  const chunks: QueryChunk[] = [];

  for (let fromAbs = alignedStart; fromAbs < alignedEnd; fromAbs += chunkMonths) {
    chunks.push({
      fromAbs,
      toAbs: fromAbs + chunkMonths,
    });
  }

  return chunks;
}

export function getAdjacentChunk(
  chunk: QueryChunk,
  direction: -1 | 1,
  lod: Lod,
): QueryChunk {
  const chunkMonths = chunkMonthsForLod(lod);
  const delta = direction * chunkMonths;
  return {
    fromAbs: chunk.fromAbs + delta,
    toAbs: chunk.toAbs + delta,
  };
}

export function mergeTimelineSlices(slices: TimelineSlice[]): TimelineSlice {
  const dynastyMap = new Map<string, TimelineSlice["dynasties"][number]>();
  const reignMap = new Map<string, TimelineSlice["reigns"][number]>();
  const eventMap = new Map<string, TimelineSlice["events"][number]>();
  const personMap = new Map<string, TimelineSlice["persons"][number]>();

  for (const slice of slices) {
    for (const dynasty of slice.dynasties) {
      dynastyMap.set(dynasty.id, dynasty);
    }
    for (const reign of slice.reigns) {
      reignMap.set(reign.id, reign);
    }
    for (const event of slice.events) {
      eventMap.set(event.id, event);
    }
    for (const person of slice.persons) {
      personMap.set(person.id, person);
    }
  }

  return TimelineSliceSchema.parse({
    dynasties: [...dynastyMap.values()],
    reigns: [...reignMap.values()],
    events: [...eventMap.values()],
    persons: [...personMap.values()],
  });
}
