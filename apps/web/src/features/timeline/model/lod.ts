import { shouldShowEventAtLod, type Event, type Lod } from "@eralens/shared";

export const LOD_THRESHOLDS = {
  millennium: 0.05,
  century: 0.35,
  decade: 1.2,
  month: 4,
} as const;

export function resolveLod(pxPerMonth: number): Lod {
  if (pxPerMonth >= LOD_THRESHOLDS.month) return "month";
  if (pxPerMonth >= LOD_THRESHOLDS.decade) return "decade";
  if (pxPerMonth >= LOD_THRESHOLDS.century) return "century";
  return "millennium";
}

export type CardDetailLevel = "full" | "wrap" | "below";

const CARD_HEIGHT = 48;
const WRAP_PAD_X = 4;
const WRAP_PAD_Y = 6;
const GLYPH_PX = 12;
const LINE_HEIGHT = 13;
const FULL_MIN_WIDTH = 80;

function wrappedLineCount(cardWidthPx: number, glyphCount: number): number | null {
  const charsPerLine = Math.floor((cardWidthPx - WRAP_PAD_X) / GLYPH_PX);
  if (charsPerLine < 1) return null;
  return Math.ceil(glyphCount / charsPerLine);
}

/**
 * Card text uses the full name and follows pixel width, not global zoom.
 * Prefer wrapping inside the card; if a wrapped name still cannot fit,
 * the name hangs in the lane gap below the full-height bar.
 */
export function cardDetailLevel(
  cardWidthPx: number,
  glyphCount = 3,
): CardDetailLevel {
  const lines = wrappedLineCount(cardWidthPx, glyphCount);
  const innerHeight = CARD_HEIGHT - WRAP_PAD_Y;
  const fitsInside = lines !== null && lines * LINE_HEIGHT <= innerHeight;

  if (!fitsInside) return "below";
  if (cardWidthPx >= FULL_MIN_WIDTH && lines === 1) return "full";
  return "wrap";
}

export function shouldShowEvent(event: Event, lod: Lod): boolean {
  return shouldShowEventAtLod(event, lod);
}

export function shouldShowPersons(lod: Lod): boolean {
  return lod !== "millennium";
}

export type PersonDetailLevel = "full" | "compact" | "dot";

export function personDetailLevel(
  lod: Lod,
  barWidthPx: number,
): PersonDetailLevel {
  if (lod === "millennium") return "dot";
  if ((lod === "decade" || lod === "month") && barWidthPx >= 72) return "full";
  if (lod === "century" && barWidthPx >= 40) return "compact";
  return "dot";
}

export function tickStepForLod(lod: Lod): { major: number; minor: number } {
  switch (lod) {
    case "millennium":
      return { major: 1200, minor: 600 };
    case "century":
      return { major: 120, minor: 24 };
    case "decade":
      return { major: 12, minor: 1 };
    case "month":
      return { major: 12, minor: 1 };
  }
}
