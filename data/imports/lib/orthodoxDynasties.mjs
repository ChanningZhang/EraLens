import { absMonth } from "./sqlHelpers.mjs";

/** Keep in sync with packages/shared/src/orthodoxDynasties.ts */
export const ORTHODOX_FROM_START = new Set([
  "xia",
  "shang",
  "zhou-west",
  "zhou-east",
  "han-east",
  "jin-west",
  "jin-east",
  "sui",
  "tang",
  "zhou-wu",
  "song-north",
  "song-south",
  "ming",
  "roc",
]);

export const ORTHODOX_FROM_ABS = {
  qin: absMonth(-221),
  /** 刘邦称帝建汉后始为正统；沛公/汉王起兵至称帝前不计金色。 */
  "han-west": absMonth(-202, 2),
  qing: absMonth(1644),
  /** 宋恭帝降元后始为中原正统；定国号至恭帝投降前世祖拆段非正统。 */
  yuan: absMonth(1276, 2),
};

export const ORTHODOX_END_ABS = {
  /**
   * 王朝行止于 618 正月以对接唐，金色覆盖整年，使江都续统杨浩仍算正统。
   */
  sui: absMonth(618, 12),
  yuan: absMonth(1368),
  /** 恭帝降元后南宋正统终结；端宗、帝昺续统不计正统。 */
  "song-south": absMonth(1276, 2),
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
