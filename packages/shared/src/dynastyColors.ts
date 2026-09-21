import { isNonOrthodoxLine } from "./claimTracks";
import { orderDynastiesForLanes, type LaneCapital } from "./dynastyClusterGroups";
import { collapseDynastyLaneGroups } from "./dynastyLaneGroups";
import {
  isOrthodoxAt,
  isOrthodoxReign,
  resolveOrthodoxEndAbs,
  type OrthodoxDynasty,
} from "./orthodoxDynasties";
import {
  COLOR_TOKENS,
  COLOR_VALUES,
  type ColorToken,
  type Dynasty,
  type DynastyGroup,
  type DynastyLaneGroup,
  type Reign,
} from "./schema";

export const ORTHODOX_COLOR_TOKEN: ColorToken = "gold";

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

/** Palette tokens used for dynasty assignment; orthodox gold is runtime-only. */
const ASSIGNABLE_COLOR_TOKENS = COLOR_TOKENS.filter(
  (token) => token !== ORTHODOX_COLOR_TOKEN && COLOR_VALUES[token] != null,
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
export function buildStableLaneColorMap(
  dynasties: readonly Dynasty[],
  dynastyGroups: readonly DynastyGroup[] = [],
  dynastyLaneGroups: readonly DynastyLaneGroup[] = [],
  capitals: readonly LaneCapital[] = [],
): Map<string, ColorToken> {
  const catalogById = new Map(dynasties.map((dynasty) => [dynasty.id, dynasty]));
  const collapsed = collapseDynastyLaneGroups(
    [...dynasties],
    catalogById,
    dynastyLaneGroups,
  );
  const ordered = orderDynastiesForLanes(collapsed, dynastyGroups, capitals);
  const map = assignLaneColorTokens(ordered);

  for (const group of dynastyLaneGroups) {
    const token = map.get(group.primaryDynastyId);
    if (!token) continue;
    for (const dynastyId of group.phaseDynastyIds) {
      map.set(dynastyId, token);
    }
  }

  return map;
}

/**
 * Runtime display color for a dynasty lane. Uses the assigned lane token;
 * orthodox windows still override to gold when `atAbs` is given.
 */
export function resolveDynastyColorToken(
  dynasty: OrthodoxDynasty,
  laneColorToken: ColorToken,
  atAbs?: number,
): ColorToken {
  if (atAbs != null && isOrthodoxAt(dynasty, atAbs)) {
    return ORTHODOX_COLOR_TOKEN;
  }
  return laneColorToken;
}

export function resolveDynastyColorValue(
  dynasty: OrthodoxDynasty,
  laneColorToken: ColorToken,
  atAbs?: number,
): string {
  return COLOR_VALUES[resolveDynastyColorToken(dynasty, laneColorToken, atAbs)];
}

/**
 * Reign-card / reign-detail color. Gold only when the reign itself is
 * orthodox — not merely because its start month still sits on the dynasty's
 * orthodox cutoff (e.g. 元惠宗 1368 after Yuan orthodox ends).
 */
export function resolveReignColorToken(
  dynasty: OrthodoxDynasty & { endAbs: number },
  reign: Pick<Reign, "startAbs" | "endAbs" | "claimTrack" | "claimRole">,
  laneColorToken: ColorToken,
): ColorToken {
  if (isOrthodoxReign(dynasty, reign)) return ORTHODOX_COLOR_TOKEN;
  if (isNonOrthodoxLine(reign)) return laneColorToken;
  const orthodoxEnd = resolveOrthodoxEndAbs(dynasty);
  if (orthodoxEnd != null && reign.startAbs >= orthodoxEnd) {
    return laneColorToken;
  }
  return resolveDynastyColorToken(dynasty, laneColorToken, reign.startAbs);
}

export function resolveReignColorValue(
  dynasty: OrthodoxDynasty & { endAbs: number },
  reign: Pick<Reign, "startAbs" | "endAbs" | "claimTrack" | "claimRole">,
  laneColorToken: ColorToken,
): string {
  return COLOR_VALUES[resolveReignColorToken(dynasty, reign, laneColorToken)];
}

export function isOrthodoxDisplayAt(
  dynasty: OrthodoxDynasty,
  atAbs: number,
): boolean {
  return isOrthodoxAt(dynasty, atAbs);
}
