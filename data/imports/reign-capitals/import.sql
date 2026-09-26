-- EraLens period import: reign-capitals
-- Associate each capital seat with all rulers whose reign overlaps its recorded interval.
-- Track-specific capitals are limited to the matching claim track.
BEGIN;

-- Rebuild from current reign and capital intervals so corrected periods do not leave stale links.
DELETE FROM reign_capitals;

INSERT INTO reign_capitals (reign_id, capital_id)
SELECT r.id, c.id
FROM reigns r
JOIN dynasty_capitals c
  ON c.dynasty_id = r.dynasty_id
 AND c.start_abs <= r.end_abs
 AND r.start_abs <= c.end_abs
 AND c.claim_track IS NOT DISTINCT FROM r.claim_track
 -- Exact adjacent day-precision handoffs share an AbsMonth bucket; ownership stays with the earlier seat.
 AND NOT (
   c.end_abs = r.start_abs
   AND c.end_precision = 'day'
   AND r.precision = 'day'
   AND c.end_year = r.start_year
   AND c.end_month = r.start_month
   AND c.end_day = r.start_day
 )
ON CONFLICT DO NOTHING;

-- Kublai's reign straddles the catalog split from Mongol Empire to Yuan (1271);
-- Zhongdu remained his capital before the yuan dynasty_id begins.
INSERT INTO reign_capitals (reign_id, capital_id)
VALUES ('reign-hu-bilie-mongol-empire', 'cap-yuan-zhongdu-15168')
ON CONFLICT DO NOTHING;

COMMIT;
