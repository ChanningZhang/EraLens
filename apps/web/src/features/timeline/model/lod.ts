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

export type ReignCardTextLayout = {
  level: CardDetailLevel;
  nameFontPx: number;
  metaFontPx: number;
};

const CARD_HEIGHT = 48;
const FULL_PAD_X = 20;
/** Matches `.wrap { padding: 3px 2px }` — the old 20px pad made year-slivers unwrappable. */
const WRAP_PAD_X = 4;
const ROW_GAP = 6;
const WRAP_PAD_Y = 6;
const NAME_FONT_DEFAULT = 17;
const NAME_FONT_WRAP_DEFAULT = 16;
const META_FONT_DEFAULT = 13;
const MIN_WRAP_FONT = 11;
const FULL_MIN_WIDTH = 80;

/** Minimum clickable row width when the duration-accurate bar is thinner. */
export const REIGN_BAR_HIT_MIN_PX = 8;

export type ReignBarLayout = {
  /** Painted bar width from reign duration × pxPerMonth. */
  barWidthPx: number;
  /** Row width; wider than the bar only to preserve a hit target. */
  unitWidthPx: number;
  /** Offset of the painted bar inside the unit when hit target is expanded. */
  barInsetPx: number;
  captionBelow: boolean;
  /** Zero-padding marker styling so the painted bar matches `barWidthPx`. */
  markerStyle: boolean;
  centerOnAnchor: boolean;
  textLayout: ReignCardTextLayout;
};

/**
 * One layout path for all reign bars: duration sets `barWidthPx`; marker styling
 * and caption placement follow pixel width, not calendar-month heuristics.
 */
export function resolveReignBarLayout(
  visualWidthPx: number,
  labelGlyphCount = 3,
): ReignBarLayout {
  const barWidthPx = Math.max(0, visualWidthPx);
  const hitExpanded = barWidthPx < REIGN_BAR_HIT_MIN_PX;
  const unitWidthPx = hitExpanded ? REIGN_BAR_HIT_MIN_PX : barWidthPx;
  const barInsetPx = hitExpanded ? (unitWidthPx - barWidthPx) / 2 : 0;
  const textLayout = resolveReignCardTextLayout(barWidthPx, labelGlyphCount);
  const captionBelow = textLayout.level === "below";

  return {
    barWidthPx,
    unitWidthPx,
    barInsetPx,
    captionBelow,
    markerStyle: captionBelow || hitExpanded,
    centerOnAnchor: hitExpanded,
    textLayout,
  };
}

function glyphPxForFont(fontPx: number): number {
  return fontPx * 0.94;
}

function lineHeightForFont(fontPx: number): number {
  return Math.ceil(fontPx * 1.1);
}

function contentWidth(cardWidthPx: number, padX = FULL_PAD_X): number {
  return Math.max(0, cardWidthPx - padX);
}

function wrappedLineCount(
  cardWidthPx: number,
  glyphCount: number,
  fontPx: number,
): number | null {
  const charsPerLine = Math.floor(
    contentWidth(cardWidthPx, WRAP_PAD_X) / glyphPxForFont(fontPx),
  );
  if (charsPerLine < 1) return null;
  return Math.ceil(glyphCount / charsPerLine);
}

function wrappedFits(
  cardWidthPx: number,
  glyphCount: number,
  fontPx: number,
): boolean {
  const lines = wrappedLineCount(cardWidthPx, glyphCount, fontPx);
  if (lines === null) return false;
  const innerHeight = CARD_HEIGHT - WRAP_PAD_Y;
  return lines * lineHeightForFont(fontPx) <= innerHeight;
}

function singleLineFits(
  cardWidthPx: number,
  glyphCount: number,
  fontPx: number,
): boolean {
  return glyphCount * glyphPxForFont(fontPx) <= contentWidth(cardWidthPx);
}

/**
 * Card text uses the full name and follows pixel width, not global zoom.
 * Prefer wrapping inside the card at the default size; if that still cannot
 * fit, step down the font size before moving the name below the bar.
 */
export function resolveReignCardTextLayout(
  cardWidthPx: number,
  glyphCount = 3,
): ReignCardTextLayout {
  if (
    cardWidthPx >= FULL_MIN_WIDTH &&
    singleLineFits(cardWidthPx, glyphCount, NAME_FONT_DEFAULT)
  ) {
    return {
      level: "full",
      nameFontPx: NAME_FONT_DEFAULT,
      metaFontPx: META_FONT_DEFAULT,
    };
  }

  for (let fontPx = NAME_FONT_WRAP_DEFAULT; fontPx >= MIN_WRAP_FONT; fontPx--) {
    if (wrappedFits(cardWidthPx, glyphCount, fontPx)) {
      return {
        level: "wrap",
        nameFontPx: fontPx,
        metaFontPx: Math.max(
          10,
          Math.round((fontPx * META_FONT_DEFAULT) / NAME_FONT_DEFAULT),
        ),
      };
    }
  }

  return {
    level: "below",
    nameFontPx: NAME_FONT_WRAP_DEFAULT,
    metaFontPx: META_FONT_DEFAULT,
  };
}

export type CaptionPlacement = "below" | "above";

/**
 * Hang the name under the bar unless a lower stack row already occupies that
 * x-range (隋主线杨浩 above 杨侑). Then flip the caption above the bar.
 */
export function resolveReignCaptionPlacement(options: {
  stackIndex: number;
  rowCount: number;
  overlapsLowerRow: boolean;
}): CaptionPlacement {
  if (options.stackIndex >= options.rowCount - 1 || !options.overlapsLowerRow) {
    return "below";
  }
  return "above";
}

export function cardDetailLevel(
  cardWidthPx: number,
  glyphCount = 3,
): CardDetailLevel {
  return resolveReignCardTextLayout(cardWidthPx, glyphCount).level;
}

/** Show era/temple/posthumous meta when name and meta fit on one horizontal row. */
export function shouldShowReignCardMeta(
  cardWidthPx: number,
  nameGlyphCount = 3,
  metaGlyphCount = 0,
): boolean {
  const layout = resolveReignCardTextLayout(cardWidthPx, nameGlyphCount);
  if (layout.level !== "full" || metaGlyphCount <= 0) return false;

  const nameWidth = nameGlyphCount * glyphPxForFont(layout.nameFontPx);
  const metaWidth = metaGlyphCount * glyphPxForFont(layout.metaFontPx);
  const available = contentWidth(cardWidthPx) - ROW_GAP;
  return nameWidth + metaWidth <= available;
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
