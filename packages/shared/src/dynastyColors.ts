import { orderDynastiesForLanes, type LaneCapital } from "./dynastyClusterGroups";
import {
  COLOR_TOKENS,
  COLOR_VALUES,
  type ColorToken,
  type Dynasty,
  type DynastyGroup,
  type Reign,
} from "./schema";

export const MASTER_COLOR_TOKEN: ColorToken = "gold";

function parseHex(hex: string): [number, number, number] {
  const value = hex.slice(1);
  return [
    Number.parseInt(value.slice(0, 2), 16),
    Number.parseInt(value.slice(2, 4), 16),
    Number.parseInt(value.slice(4, 6), 16),
  ];
}

function rgbDistance(a: [number, number, number], b: [number, number, number]): number {
  const dr = a[0] - b[0];
  const dg = a[1] - b[1];
  const db = a[2] - b[2];
  return Math.sqrt(dr * dr + dg * dg + db * db);
}

/** Palette tokens used for dynasty assignment; master gold is runtime-only. */
const ASSIGNABLE_COLOR_TOKENS = COLOR_TOKENS.filter(
  (token) => token !== MASTER_COLOR_TOKEN && COLOR_VALUES[token] != null,
);

const TOKEN_RGB = Object.fromEntries(
  ASSIGNABLE_COLOR_TOKENS.map((token) => [token, parseHex(COLOR_VALUES[token])]),
) as Record<ColorToken, [number, number, number]>;

export function colorTokenDistance(a: ColorToken, b: ColorToken): number {
  return rgbDistance(TOKEN_RGB[a], TOKEN_RGB[b]);
}

function hashDynastyId(dynastyId: string): number {
  let hash = 0;
  for (let index = 0; index < dynastyId.length; index += 1) {
    hash = (hash * 33 + dynastyId.charCodeAt(index)) | 0;
  }
  return Math.abs(hash);
}

function compareDynastyStart(
  a: { id: string; startAbs: number },
  b: { id: string; startAbs: number },
): number {
  return a.startAbs - b.startAbs || a.id.localeCompare(b.id);
}

/** Stable fallback when a dynasty is not in the current lane color map. */
export function fallbackLaneColorToken(dynastyId: string): ColorToken {
  return ASSIGNABLE_COLOR_TOKENS[hashDynastyId(dynastyId) % ASSIGNABLE_COLOR_TOKENS.length]!;
}

/**
 * Assign display colors for an ordered dynasty list. Walks the 24-color
 * palette in lane order so long clusters (e.g. 十六国) get many distinct hues
 * instead of alternating among the last few unused slots.
 */
export function assignLaneColorTokens(
  ordered: ReadonlyArray<{ id: string }>,
): Map<string, ColorToken> {
  const assigned = new Map<string, ColorToken>();
  const paletteSize = ASSIGNABLE_COLOR_TOKENS.length;
  if (ordered.length === 0 || paletteSize === 0) return assigned;

  const startOffset = hashDynastyId(ordered[0]!.id) % paletteSize;

  for (let index = 0; index < ordered.length; index += 1) {
    assigned.set(
      ordered[index]!.id,
      ASSIGNABLE_COLOR_TOKENS[(startOffset + index) % paletteSize]!,
    );
  }

  return assigned;
}

/** @deprecated Use assignLaneColorTokens — kept for tests and tooling. */
export const assignDistinctColorTokens = assignLaneColorTokens;

/**
 * Build a color map from chronologically ordered dynasties. For offline
 * previews.
 */
export function buildDynastyColorMap(
  dynasties: ReadonlyArray<{ id: string; startAbs: number }>,
): Map<string, ColorToken> {
  const sorted = [...dynasties].sort(compareDynastyStart);
  return assignLaneColorTokens(sorted);
}

/**
 * Stable per-dynasty lane colors from the full catalog. Uses the same lane
 * collapse and ordering rules as the timeline, but does not depend on the
 * current viewport — panning will not recolor rows.
 */
/**
 * Full-catalog lane order (cluster/capital ordering).
 * Viewport-independent: the same list underlies both stable colors and stable
 * row placement, so panning never reshuffles rows.
 */
export function orderCatalogLanes(
  dynasties: readonly Dynasty[],
  dynastyGroups: readonly DynastyGroup[] = [],
  capitals: readonly LaneCapital[] = [],
): Dynasty[] {
  return orderDynastiesForLanes([...dynasties], dynastyGroups, capitals);
}

/**
 * Stable lane rank per dynasty id from the full catalog. The viewport sorts its
 * visible rows by this rank so a row keeps its place even when the neighbour
 * that anchored a same-capital pull-up scrolls out of view.
 */
export function buildLaneOrderIndex(
  dynasties: readonly Dynasty[],
  dynastyGroups: readonly DynastyGroup[] = [],
  capitals: readonly LaneCapital[] = [],
): Map<string, number> {
  const ordered = orderCatalogLanes(dynasties, dynastyGroups, capitals);
  const rank = new Map<string, number>();
  ordered.forEach((dynasty, index) => rank.set(dynasty.id, index));
  return rank;
}

export function buildStableLaneColorMap(
  dynasties: readonly Dynasty[],
  dynastyGroups: readonly DynastyGroup[] = [],
  capitals: readonly LaneCapital[] = [],
): Map<string, ColorToken> {
  const ordered = orderCatalogLanes(dynasties, dynastyGroups, capitals);
  const map = assignLaneColorTokens(ordered);


  return map;
}

/**
 * Runtime display color for a dynasty lane. Uses the assigned lane token;
 * master status is stored on individual reigns, so dynasty lanes use their base color.
 */
export function resolveDynastyColorToken(
  _dynasty: Pick<Dynasty, "id">,
  laneColorToken: ColorToken,
): ColorToken {
  return laneColorToken;
}

export function resolveDynastyColorValue(
  dynasty: Pick<Dynasty, "id">,
  laneColorToken: ColorToken,
): string {
  return COLOR_VALUES[resolveDynastyColorToken(dynasty, laneColorToken)];
}

/** Master reigns receive the gold overlay; other reigns keep their lane color. */
export function resolveReignColorToken(
  _dynasty: Pick<Dynasty, "id">,
  reign: Pick<Reign, "isMain">,
  laneColorToken: ColorToken,
): ColorToken {
  return reign.isMain === true ? MASTER_COLOR_TOKEN : laneColorToken;
}

export function resolveReignColorValue(
  dynasty: Pick<Dynasty, "id">,
  reign: Pick<Reign, "isMain">,
  laneColorToken: ColorToken,
): string {
  return COLOR_VALUES[resolveReignColorToken(dynasty, reign, laneColorToken)];
}
