import {
  isOrthodoxAt,
  isOrthodoxReign,
  type OrthodoxDynasty,
} from "./orthodoxDynasties";
import {
  COLOR_TOKENS,
  COLOR_VALUES,
  type ColorToken,
  type Reign,
} from "./schema";

const LOOKBACK = 3;

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

function scoreToken(token: ColorToken, recent: ColorToken[]): number {
  if (recent.length === 0) return 0;
  return Math.min(...recent.map((prev) => colorTokenDistance(token, prev)));
}

function pickBestToken(recent: ColorToken[]): ColorToken {
  let best = ASSIGNABLE_COLOR_TOKENS[0]!;
  let bestScore = -1;

  for (const token of ASSIGNABLE_COLOR_TOKENS) {
    const score = scoreToken(token, recent);
    if (score > bestScore) {
      bestScore = score;
      best = token;
    }
  }

  const previous = recent.at(-1);
  if (previous && best === previous) {
    const alternative = ASSIGNABLE_COLOR_TOKENS
      .filter((token) => token !== previous)
      .sort((a, b) => colorTokenDistance(b, previous) - colorTokenDistance(a, previous))[0];
    if (alternative) return alternative;
  }

  return best;
}

function compareDynastyStart(
  a: { id: string; startAbs: number },
  b: { id: string; startAbs: number },
): number {
  return a.startAbs - b.startAbs || a.id.localeCompare(b.id);
}

type DynastyColorInput = OrthodoxDynasty & { colorToken: ColorToken };

/**
 * Runtime display color for a dynasty. Uses the persisted token so panning
 * never changes colors when timeline data is loaded in chunks.
 * When `atAbs` is given and the dynasty is orthodox at that time, returns gold.
 */
export function resolveDynastyColorToken(
  dynasty: DynastyColorInput,
  atAbs?: number,
): ColorToken {
  if (atAbs != null && isOrthodoxAt(dynasty, atAbs)) {
    return ORTHODOX_COLOR_TOKEN;
  }
  return dynasty.colorToken;
}

export function resolveDynastyColorValue(
  dynasty: DynastyColorInput,
  atAbs?: number,
): string {
  return COLOR_VALUES[resolveDynastyColorToken(dynasty, atAbs)];
}

/**
 * Reign-card / reign-detail color. Gold only when the reign itself is
 * orthodox — not merely because its start month still sits on the dynasty's
 * orthodox cutoff (e.g. 元惠宗 1368 after Yuan orthodox ends).
 */
export function resolveReignColorToken(
  dynasty: DynastyColorInput & { endAbs: number },
  reign: Pick<Reign, "startAbs" | "endAbs" | "claimTrack">,
): ColorToken {
  if (isOrthodoxReign(dynasty, reign)) return ORTHODOX_COLOR_TOKEN;
  return dynasty.colorToken;
}

export function resolveReignColorValue(
  dynasty: DynastyColorInput & { endAbs: number },
  reign: Pick<Reign, "startAbs" | "endAbs" | "claimTrack">,
): string {
  return COLOR_VALUES[resolveReignColorToken(dynasty, reign)];
}

export function isOrthodoxDisplayAt(
  dynasty: OrthodoxDynasty,
  atAbs: number,
): boolean {
  return isOrthodoxAt(dynasty, atAbs);
}

/**
 * Build a color map from an ordered dynasty list. Intended for import scripts
 * or other offline tooling — not for viewport rendering, because chunked
 * timeline loading only exposes a subset of dynasties at a time.
 */
export function buildDynastyColorMap(
  dynasties: ReadonlyArray<{ id: string; colorToken: ColorToken; startAbs: number }>,
): Map<string, ColorToken> {
  const sorted = [...dynasties].sort(compareDynastyStart);
  return assignDistinctColorTokens(sorted);
}

/**
 * Reassign display colors for chronologically ordered dynasties so adjacent
 * lanes stay visually distinct.
 */
export function assignDistinctColorTokens(
  ordered: ReadonlyArray<{ id: string; colorToken: ColorToken }>,
): Map<string, ColorToken> {
  const assigned = new Map<string, ColorToken>();
  const recent: ColorToken[] = [];

  for (const dynasty of ordered) {
    const token =
      recent.length === 0 ? dynasty.colorToken : pickBestToken(recent);
    assigned.set(dynasty.id, token);
    recent.push(token);
    if (recent.length > LOOKBACK) recent.shift();
  }

  return assigned;
}
