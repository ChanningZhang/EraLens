/**
 * Day/month-precision reign helpers for post-Tang imports.
 * Dates use proleptic Gregorian calendar (Wikipedia / 实录通行换算).
 */
import { defaultPreferredAppellation } from "./defaultPreferredAppellation.mjs";
import { absMonth } from "./sqlHelpers.mjs";

export function ymDay(year, month = 1, day = null) {
  const point = { year, month, abs: absMonth(year, month) };
  return day == null ? point : { ...point, day };
}

export function reignBase({
  id,
  dynastyId,
  personId,
  title,
  posthumousName,
  templeName,
  preferred,
  start,
  end,
  precision = "year",
  eraNames = [],
  claimTrack,
  claimLabel,
  claimRole,
}) {
  return {
    id,
    dynastyId,
    personId,
    title,
    posthumousName,
    templeName,
    preferredAppellation: preferred,
    eraNames,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    precision,
    claimTrack,
    claimLabel,
    claimRole,
  };
}

export function dynastyReignMonth(
  dynastyId,
  personId,
  title,
  posthumous,
  temple,
  startYear,
  startMonth,
  endYear,
  endMonth,
  eraNames = [],
  preferred = null,
  claim = null,
  id = null,
) {
  const pref =
    preferred ??
    defaultPreferredAppellation({ title, posthumous, temple, startYear, eraNames });
  return reignBase({
    id: id ?? `reign-${personId}-${dynastyId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    preferred: pref,
    start: ymDay(startYear, startMonth),
    end: ymDay(endYear, endMonth),
    eraNames,
    precision: "month",
    claimTrack: claim?.track,
    claimLabel: claim?.label,
    claimRole: claim?.role,
  });
}

export function dynastyReignDay(
  dynastyId,
  personId,
  title,
  posthumous,
  temple,
  startYear,
  startMonth,
  startDay,
  endYear,
  endMonth,
  endDay,
  eraNames = [],
  preferred = null,
  claim = null,
  id = null,
) {
  const pref =
    preferred ??
    defaultPreferredAppellation({ title, posthumous, temple, startYear, eraNames });
  return reignBase({
    id: id ?? `reign-${personId}-${dynastyId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    preferred: pref,
    start: ymDay(startYear, startMonth, startDay),
    end: ymDay(endYear, endMonth, endDay),
    eraNames,
    precision: "day",
    claimTrack: claim?.track,
    claimLabel: claim?.label,
    claimRole: claim?.role,
  });
}

/** Day-precision reign with optional custom id (e.g. split reigns). */
export function drDay(
  dynastyId,
  personId,
  title,
  posthumous,
  temple,
  sy,
  sm,
  sd,
  ey,
  em,
  ed,
  eraList = [],
  claim = null,
  id = null,
) {
  const reignId = id ?? `reign-${personId}-${dynastyId}`;
  const eraNames = eraList.length
    ? eraList.map((e, i) => ({
        reignId,
        name: e.name,
        start: ymDay(e.sy, e.sm ?? 1),
        end: ymDay(e.ey, e.em ?? 12),
        sortOrder: i,
      }))
    : [];
  return dynastyReignDay(
    dynastyId,
    personId,
    title,
    posthumous,
    temple,
    sy,
    sm,
    sd,
    ey,
    em,
    ed,
    eraNames,
    null,
    claim,
    reignId,
  );
}
