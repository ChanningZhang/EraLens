import { fromAbsMonth, ym } from "./sqlHelpers.mjs";
import { findVisualLaneGaps } from "./visualReignGaps.mjs";

/** Matches packages/shared/src/systemReigns.ts */
export const SYSTEM_MISSING_RULER_PERSON_ID = "system-missing-ruler";

/** Lane groups that share one timeline row (mirror packages/shared dynastyLaneGroups). */
const LANE_GROUP_MEMBERS = {
  "mongol-yuan": ["mongol-empire", "yuan"],
  "wu-ming": ["wu-zhu", "ming", "ming-south"],
};

const MEMBER_TO_LANE = new Map(
  Object.entries(LANE_GROUP_MEMBERS).flatMap(([laneId, dynastyIds]) =>
    dynastyIds.map((dynastyId) => [dynastyId, laneId]),
  ),
);

export const systemMissingPerson = {
  id: SYSTEM_MISSING_RULER_PERSON_ID,
  name: "史料缺",
  roles: ["系统占位"],
  bio: "EraLens 系统保留人物，仅用于标记经考证确认的国君资料缺失区间。",
  links: [],
  birth: null,
  death: null,
};

function laneKeyForDynasty(dynastyId) {
  return MEMBER_TO_LANE.get(dynastyId) ?? dynastyId;
}

/** SQL to drop stale auto-generated 史料缺 rows before re-import (optional per package). */
export function sqlDeleteSystemMissingReigns(dynastyIds, sqlStr) {
  if (!dynastyIds.length) return "";
  const ids = dynastyIds.map((id) => sqlStr(id)).join(", ");
  return `DELETE FROM reigns WHERE dynasty_id IN (${ids}) AND person_id = ${sqlStr(SYSTEM_MISSING_RULER_PERSON_ID)};`;
}

/**
 * Build a researched missing-ruler placeholder reign.
 * ID convention: reign-missing-{dynastyId}-{start-year} or reign-missing-{dynastyId}-a{startAbs}
 */
export function missingReign({
  dynastyId,
  startYear,
  endYear,
  startMonth = 1,
  endMonth = 12,
  precision = "year",
  id = null,
}) {
  const reignId = id ?? `reign-missing-${dynastyId}-${startYear}`;
  const start = ym(startYear, startMonth);
  const end = ym(endYear, endMonth);
  return {
    id: reignId,
    dynastyId,
    personId: SYSTEM_MISSING_RULER_PERSON_ID,
    title: "史料缺",
    posthumousName: null,
    templeName: null,
    preferredAppellation: null,
    eraNames: [],
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    precision,
  };
}

export function missingReignFromAbs({ dynastyId, startAbs, endAbs, id = null }) {
  const start = fromAbsMonth(startAbs);
  const end = fromAbsMonth(endAbs);
  return missingReign({
    dynastyId,
    startYear: start.year,
    endYear: end.year,
    startMonth: start.month,
    endMonth: end.month,
    id: id ?? `reign-missing-${dynastyId}-a${startAbs}`,
  });
}

/**
 * @deprecated Import pipeline no longer auto-emits gaps. Kept for ad-hoc validation scripts.
 * Emit missing placeholders for uncovered intervals between consecutive rulers on a lane.
 */
export function buildMissingReignsFromGaps(reigns, { minGapMonths = 12 } = {}) {
  const rulers = reigns.filter((r) => r.personId !== SYSTEM_MISSING_RULER_PERSON_ID);
  const byLane = new Map();

  for (const reign of rulers) {
    const laneKey = laneKeyForDynasty(reign.dynastyId);
    if (!byLane.has(laneKey)) byLane.set(laneKey, []);
    byLane.get(laneKey).push(reign);
  }

  const missing = [];
  for (const laneReigns of byLane.values()) {
    const sorted = [...laneReigns].sort(
      (a, b) => a.startAbs - b.startAbs || a.endAbs - b.endAbs || a.id.localeCompare(b.id),
    );
    if (sorted.length === 0) continue;

    let coverageEnd = sorted[0].startAbs - 1;
    for (const reign of sorted) {
      if (reign.startAbs > coverageEnd + 1) {
        const gapStart = coverageEnd + 1;
        const gapEnd = reign.startAbs - 1;
        const gapMonths = gapEnd - gapStart + 1;
        if (gapMonths >= minGapMonths) {
          missing.push(
            missingReignFromAbs({
              dynastyId: reign.dynastyId,
              startAbs: gapStart,
              endAbs: gapEnd,
            }),
          );
        }
      }
      coverageEnd = Math.max(coverageEnd, reign.endAbs);
    }
  }

  return missing;
}

/** @deprecated Import pipeline no longer auto-emits gaps. Kept for ad-hoc validation scripts. */
export function buildMissingReignsFromVisualGaps(reigns, { minGapMonths = 12 } = {}) {
  const rulers = reigns.filter((r) => r.personId !== SYSTEM_MISSING_RULER_PERSON_ID);
  const byLane = new Map();

  for (const reign of rulers) {
    const laneKey = laneKeyForDynasty(reign.dynastyId);
    if (!byLane.has(laneKey)) byLane.set(laneKey, []);
    byLane.get(laneKey).push(reign);
  }

  const missing = [];
  for (const laneReigns of byLane.values()) {
    for (const { dynastyId, gapStart, gapEnd } of findVisualLaneGaps(laneReigns, {
      minGapMonths,
    })) {
      missing.push(
        missingReignFromAbs({
          dynastyId,
          startAbs: gapStart,
          endAbs: gapEnd,
        }),
      );
    }
  }

  return missing;
}

function buildCuratedByPackage() {
  return {
    "xia-shang-zhou": [
      missingReign({ dynastyId: "xia", startYear: -1989, endYear: -1911 }),
      missingReign({
        dynastyId: "xia",
        startYear: -1859,
        endYear: -1651,
        id: "reign-missing-xia--1859",
      }),
      missingReign({ dynastyId: "shang", startYear: -1570, endYear: -1561 }),
    ],
    "xinan-guozheng": [
      missingReign({ dynastyId: "yelang", startYear: -119, endYear: -31 }),
      missingReign({ dynastyId: "dian", startYear: -255, endYear: -116 }),
    ],
  };
}

let curatedByPackage = null;

export function getCuratedMissingReigns(slug) {
  if (!curatedByPackage) curatedByPackage = buildCuratedByPackage();
  return curatedByPackage[slug] ?? [];
}

/** @deprecated Use getCuratedMissingReigns */
export function getMissingReigns(slug) {
  return getCuratedMissingReigns(slug);
}

export function mergeMissingReigns(...lists) {
  const bySpan = new Map();
  for (const list of lists) {
    for (const reign of list) {
      const spanKey = `${reign.dynastyId}:${reign.startAbs}:${reign.endAbs}`;
      if (!bySpan.has(spanKey)) bySpan.set(spanKey, reign);
    }
  }
  return [...bySpan.values()];
}

/**
 * Only explicit, researched 史料缺 placeholders — never infer from calendar gaps.
 * Intentional blanks (武周留白、大汗监国间隔等) stay empty with no reign row.
 */
export function resolveMissingReigns(slug, _reigns, extraMissingReigns = []) {
  return mergeMissingReigns(getCuratedMissingReigns(slug), extraMissingReigns);
}

/** Resolve curated + auto-detected gaps, then merge into import persons/reigns. */
export function finalizeImportReigns(slug, persons, reigns, extraMissingReigns = []) {
  const missingReigns = resolveMissingReigns(slug, reigns, extraMissingReigns);
  return { ...withSystemMissingReigns(persons, reigns, missingReigns), missingReigns };
}

/** Prepend system person and append missing reigns when needed. */
export function withSystemMissingReigns(persons, reigns, missingReigns = []) {
  if (!missingReigns.length) {
    return { persons, reigns };
  }
  const filteredPersons = persons.filter((p) => p.id !== SYSTEM_MISSING_RULER_PERSON_ID);
  return {
    persons: [systemMissingPerson, ...filteredPersons],
    reigns: [...reigns, ...missingReigns],
  };
}
