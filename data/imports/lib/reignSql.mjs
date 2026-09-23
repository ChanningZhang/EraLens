import { resolveReignTitle } from "./reignTitleSelections.mjs";

/**
 * Shared reign INSERT so claim_track / claim_label / claim_role stay in sync
 * across period generators.
 */
export function reignSql(r, sqlStr, sqlJson, formatAppellationCsv) {
  return `INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES (${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(resolveReignTitle(r))}, ${sqlStr(formatAppellationCsv(r.eraNames))}, ${r.start.year}, ${r.start.month}, ${r.start.day ?? "NULL"}, ${r.end.year}, ${r.end.month}, ${r.end.day ?? "NULL"}, ${r.startAbs}, ${r.endAbs}, ${sqlStr(r.precision)}, ${sqlStr(r.startDateConfidence ?? null)}, ${sqlStr(r.endDateConfidence ?? null)}, ${sqlStr(r.claimTrack ?? null)}, ${sqlStr(r.claimLabel ?? null)}, ${sqlStr(r.claimRole ?? null)}, ${r.isInformalMonarch ?? false})
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;`;
}
