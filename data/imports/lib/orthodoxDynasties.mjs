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
  "wei",
  "jin-west",
  "jin-east",
  "song-liu",
  "qi-nan",
  "liang-nan",
  "chen-nan",
  "wei-north",
  "wei-east",
  "wei-west",
  "qi-bei",
  "zhou-bei",
  "sui",
  "tang",
  "liang-hou",
  "tang-hou",
  "jin-hou",
  "han-hou",
  "zhou-hou",
  "song-north",
  "song-south",
  "yuan",
  "ming",
  "qing",
]);

export const ORTHODOX_FROM_ABS = {
  qin: absMonth(-221),
};

export function resolveOrthodoxFromAbs(dynasty) {
  if (dynasty.orthodoxFromAbs != null) return dynasty.orthodoxFromAbs;
  const explicit = ORTHODOX_FROM_ABS[dynasty.id];
  if (explicit != null) return explicit;
  const startAbs = dynasty.start?.abs ?? dynasty.startAbs;
  if (ORTHODOX_FROM_START.has(dynasty.id) && startAbs != null) return startAbs;
  return null;
}
