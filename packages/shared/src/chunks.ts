import type { Lod, Reign } from "./schema";
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

function normalizeReignTitle(title: string): string {
  return title.replace(/莊/g, "庄").replace(/國/g, "国").trim();
}

function reignSpanMonths(reign: Reign): number {
  return reign.endAbs - reign.startAbs + 1;
}

function reignQualityScore(reign: Reign): number {
  let score = 0;
  if (reign.preferredAppellation?.kind === "posthumous") score += 4;
  else if (reign.preferredAppellation?.kind === "temple") score += 3;
  else if (reign.preferredAppellation?.kind === "era") score += 2;
  if (reign.posthumousName) score += 1;
  // Stale imports often keep an overly wide span for the same title.
  score -= reignSpanMonths(reign) / 1000;
  return score;
}

function pickBetterReign(a: Reign, b: Reign): Reign {
  const scoreA = reignQualityScore(a);
  const scoreB = reignQualityScore(b);
  if (scoreA !== scoreB) return scoreA > scoreB ? a : b;
  const spanA = reignSpanMonths(a);
  const spanB = reignSpanMonths(b);
  if (spanA !== spanB) return spanA < spanB ? a : b;
  return a.id.localeCompare(b.id) <= 0 ? a : b;
}

function spansOverlap(a: Reign, b: Reign): boolean {
  const start = Math.max(a.startAbs, b.startAbs);
  const end = Math.min(a.endAbs, b.endAbs);
  if (start > end) return false;
  const overlap = end - start + 1;
  const smaller = Math.min(reignSpanMonths(a), reignSpanMonths(b));
  return overlap >= smaller * 0.5;
}

/** Drop superseded reign rows that share a title and overlap in time. */
export function dedupeOverlappingReigns(reigns: Reign[]): Reign[] {
  const kept: Reign[] = [];

  for (const reign of reigns) {
    const key = normalizeReignTitle(reign.title);
    const index = kept.findIndex(
      (item) =>
        item.dynastyId === reign.dynastyId &&
        normalizeReignTitle(item.title) === key &&
        spansOverlap(item, reign),
    );
    if (index < 0) {
      kept.push(reign);
      continue;
    }
    const existing = kept[index]!;
    if (existing.personId === reign.personId) {
      kept[index] = pickBetterReign(existing, reign);
      continue;
    }
    // Same generic title (楚王 / 闽主) across successive rulers is not a duplicate import.
    const scoreDiff = Math.abs(reignQualityScore(existing) - reignQualityScore(reign));
    if (scoreDiff >= 2) {
      kept[index] = pickBetterReign(existing, reign);
      continue;
    }
    kept.push(reign);
  }

  return kept;
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

  const reigns = dedupeOverlappingReigns([...reignMap.values()]);
  const reignPersonIds = new Set(reigns.map((reign) => reign.personId));
  const persons = [...personMap.values()].filter((person) => {
    if (reignPersonIds.has(person.id)) return true;
    if (person.roles.includes("君主")) return false;
    return true;
  });

  return TimelineSliceSchema.parse({
    dynasties: [...dynastyMap.values()],
    reigns,
    events: [...eventMap.values()],
    persons,
  });
}
