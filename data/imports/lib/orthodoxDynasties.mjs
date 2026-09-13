import { absMonth } from "./sqlHelpers.mjs";

/** Keep in sync with packages/shared/src/orthodoxDynasties.ts */
export const ORTHODOX_FROM_START = new Set([
  "xia",
  "shang",
  "zhou-west",
  "zhou-east",
  "han-west",
  "xin",
  "han-gengshi",
  "han-east",
  "jin-west",
  "jin-east",
  "sui",
  "tang",
  "song-north",
  "song-south",
  "yuan",
  "ming",
  "roc",
]);

export const ORTHODOX_FROM_ABS = {
  qin: absMonth(-221),
  qing: absMonth(1644),
};

export const ORTHODOX_END_ABS = {
  yuan: absMonth(1368),
};

export function resolveOrthodoxFromAbs(dynasty) {
  if (dynasty.orthodoxFromAbs != null) return dynasty.orthodoxFromAbs;
  const explicit = ORTHODOX_FROM_ABS[dynasty.id];
  if (explicit != null) return explicit;
  const startAbs = dynasty.start?.abs ?? dynasty.startAbs;
  if (ORTHODOX_FROM_START.has(dynasty.id) && startAbs != null) return startAbs;
  return null;
}

export function resolveOrthodoxEndAbs(dynasty) {
  if (dynasty.orthodoxEndAbs != null) return dynasty.orthodoxEndAbs;
  const explicit = ORTHODOX_END_ABS[dynasty.id];
  if (explicit != null) return explicit;
  if (resolveOrthodoxFromAbs(dynasty) == null) return null;
  const endAbs = dynasty.end?.abs ?? dynasty.endAbs;
  return endAbs ?? null;
}
