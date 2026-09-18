import { readFileSync, readdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { ym, fromAbsMonth } from "./sqlHelpers.mjs";
import { DOCUMENTED_REIGN_DATES, applyDocumentedDates } from "./documentedReignDates.mjs";
import { ymDay } from "./reignDateHelpers.mjs";

const FATE_VICTIM_MAX_LAG_MONTHS = 24;
const REIGN_ROW_RE =
  /VALUES\s*\(\s*'(reign-[^']+)',\s*'([^']+)',\s*'([^']+)'[\s\S]*?,\s*(-?\d+),\s*(-?\d+),\s*(?:NULL|-?\d+),\s*(-?\d+),\s*(-?\d+),\s*(?:NULL|-?\d+),\s*(-?\d+),\s*(-?\d+)/g;

export function atFromReignEnd(reignId, fallbackYear, fallbackMonth = 12) {
  const doc = DOCUMENTED_REIGN_DATES[reignId];
  if (doc?.end) {
    const [y, m, d] = doc.end;
    return d != null ? ymDay(y, m, d) : ym(y, m);
  }
  return ym(fallbackYear, fallbackMonth);
}

/** Load reign rows from all period import.sql files (for catalog validation). */
export function loadReignsFromImports(importsRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..")) {
  const reigns = [];
  for (const slug of readdirSync(importsRoot)) {
    const sqlPath = path.join(importsRoot, slug, "import.sql");
    try {
      const sql = readFileSync(sqlPath, "utf8");
      for (const match of sql.matchAll(REIGN_ROW_RE)) {
        const [, id, dynastyId, personId, startYear, startMonth, endYear, endMonth, startAbs, endAbs] =
          match;
        reigns.push(
          applyDocumentedDates({
            id,
            dynastyId,
            personId,
            title: "",
            eraNames: [],
            start: { year: Number(startYear), month: Number(startMonth) },
            end: { year: Number(endYear), month: Number(endMonth) },
            startAbs: Number(startAbs),
            endAbs: Number(endAbs),
            precision: "year",
          }),
        );
      }
    } catch {
      // package without import.sql
    }
  }
  return reigns;
}

function resolveVictimReignAt(personId, atAbs, reigns) {
  const matches = reigns.filter((reign) => reign.personId === personId);
  const active = matches.find((reign) => reign.startAbs <= atAbs && atAbs <= reign.endAbs);
  if (active) return { reign: active, mode: "active" };
  const ended = matches
    .filter((reign) => reign.endAbs <= atAbs)
    .sort((a, b) => b.endAbs - a.endAbs || b.startAbs - a.startAbs || b.id.localeCompare(a.id));
  return ended[0] ? { reign: ended[0], mode: "ended" } : null;
}

/**
 * Ensure fate victim was in power near atAbs (or within 24 months of reign end).
 * Catches catalog entries that point at founding/early rulers instead of末代君主.
 */
export function validateFateCatalogEntry(entry, reigns) {
  const atAbs = entry.resolveAt().abs;
  if (entry.fromReignId) {
    const reign = reigns.find((item) => item.id === entry.fromReignId);
    if (!reign) {
      return { ok: false, reason: `fromReignId not found: ${entry.fromReignId}` };
    }
    const contains = reign.startAbs <= atAbs && atAbs <= reign.endAbs;
    const lagMonths = atAbs - reign.endAbs;
    if (!contains && lagMonths > FATE_VICTIM_MAX_LAG_MONTHS) {
      return {
        ok: false,
        reason: `fromReign ended ${Math.round(lagMonths / 12)}y before atAbs`,
        reignId: reign.id,
        reignEnd: fromAbsMonth(reign.endAbs),
        at: fromAbsMonth(atAbs),
      };
    }
    return { ok: true };
  }
  if (!entry.fromPersonId) {
    return { ok: false, reason: "catalog entry needs fromPersonId or fromReignId" };
  }
  const resolved = resolveVictimReignAt(entry.fromPersonId, atAbs, reigns);
  if (!resolved) {
    return { ok: true, skipped: true, reason: "no reign row parsed for fromPersonId" };
  }
  const contains = resolved.reign.startAbs <= atAbs && atAbs <= resolved.reign.endAbs;
  const lagMonths = atAbs - resolved.reign.endAbs;
  if (!contains && lagMonths > FATE_VICTIM_MAX_LAG_MONTHS) {
    const reignEnd = fromAbsMonth(resolved.reign.endAbs);
    const at = fromAbsMonth(atAbs);
    return {
      ok: false,
      reason: `fromPerson reign ended ${Math.round(lagMonths / 12)}y before atAbs`,
      reignId: resolved.reign.id,
      reignEnd,
      at,
    };
  }
  return { ok: true };
}

export function validateFateCatalog(catalog, reigns) {
  const failures = [];
  for (const entry of catalog) {
    const result = validateFateCatalogEntry(entry, reigns);
    if (!result.ok) failures.push({ id: entry.id, fromPersonId: entry.fromPersonId, ...result });
  }
  return failures;
}

export function fateRelation({
  id,
  fromPersonId = null,
  fromReignId = null,
  toPersonId,
  kind,
  at,
  eventId = null,
  precision = null,
}) {
  const resolvedPrecision = precision ?? (at.day != null ? "day" : "year");
  const fromRef = fromReignId
    ? `reign:${fromReignId}`
    : fromPersonId
      ? `person:${fromPersonId}`
      : null;
  if (!fromRef) {
    throw new Error(`fateRelation ${id} requires fromPersonId or fromReignId`);
  }
  return {
    id,
    fromRef,
    toRef: `person:${toPersonId}`,
    kind,
    at,
    atAbs: at.abs,
    precision: resolvedPrecision,
    eventId,
  };
}
