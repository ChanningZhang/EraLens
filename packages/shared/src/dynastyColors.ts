import { COLOR_TOKENS, COLOR_VALUES, type ColorToken } from "./schema";

const LOOKBACK = 3;

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

const TOKEN_RGB = Object.fromEntries(
  COLOR_TOKENS.map((token) => [token, parseHex(COLOR_VALUES[token])]),
) as Record<ColorToken, [number, number, number]>;

export function colorTokenDistance(a: ColorToken, b: ColorToken): number {
  return rgbDistance(TOKEN_RGB[a], TOKEN_RGB[b]);
}

function scoreToken(token: ColorToken, recent: ColorToken[]): number {
  if (recent.length === 0) return 0;
  return Math.min(...recent.map((prev) => colorTokenDistance(token, prev)));
}

function pickBestToken(recent: ColorToken[]): ColorToken {
  let best = COLOR_TOKENS[0]!;
  let bestScore = -1;

  for (const token of COLOR_TOKENS) {
    const score = scoreToken(token, recent);
    if (score > bestScore) {
      bestScore = score;
      best = token;
    }
  }

  const previous = recent.at(-1);
  if (previous && best === previous) {
    const alternative = COLOR_TOKENS
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

/**
 * Runtime display color for a dynasty. Uses the persisted token so panning
 * never changes colors when timeline data is loaded in chunks.
 */
export function resolveDynastyColorToken(
  dynasty: { colorToken: ColorToken },
): ColorToken {
  return dynasty.colorToken;
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
