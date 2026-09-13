/**
 * Shared reign INSERT so claim_track / claim_label / claim_role stay in sync
 * across period generators.
 */
export function reignSql(r, sqlStr, sqlJson) {
  return `INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES (${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(r.title)}, ${sqlStr(r.posthumousName ?? null)}, ${sqlStr(r.templeName ?? null)}, ${sqlJson(r.preferredAppellation)}, ${r.start.year}, ${r.start.month}, ${r.start.day ?? "NULL"}, ${r.end.year}, ${r.end.month}, ${r.end.day ?? "NULL"}, ${r.startAbs}, ${r.endAbs}, ${sqlStr(r.precision)}, ${sqlStr(r.claimTrack ?? null)}, ${sqlStr(r.claimLabel ?? null)}, ${sqlStr(r.claimRole ?? null)})
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;`;
}
