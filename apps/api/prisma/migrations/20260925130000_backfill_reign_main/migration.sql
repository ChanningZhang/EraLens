-- Convert the former dynasty-level orthodox windows into a persistent reign flag.
-- NULL boundaries inherit the dynasty's own start/end. Explicit values are AbsMonth.
WITH orthodox_windows (dynasty_id, from_abs, end_abs) AS (
  VALUES
    ('shang', NULL::INTEGER, NULL::INTEGER),
    ('zhou-west', NULL::INTEGER, NULL::INTEGER),
    ('zhou-east', NULL::INTEGER, NULL::INTEGER),
    ('han-east', NULL::INTEGER, NULL::INTEGER),
    ('jin-west', NULL::INTEGER, NULL::INTEGER),
    ('jin-east', NULL::INTEGER, NULL::INTEGER),
    ('sui', NULL::INTEGER, 7427),
    ('tang', NULL::INTEGER, NULL::INTEGER),
    ('zhou-wu', NULL::INTEGER, NULL::INTEGER),
    ('song-north', NULL::INTEGER, NULL::INTEGER),
    ('song-south', NULL::INTEGER, 15313),
    ('ming', NULL::INTEGER, NULL::INTEGER),
    ('roc', NULL::INTEGER, 23396),
    ('prc', NULL::INTEGER, NULL::INTEGER),
    ('xia', -24720, NULL::INTEGER),
    ('qin', -2640, NULL::INTEGER),
    ('han-west', -2411, NULL::INTEGER),
    ('qing', 19728, NULL::INTEGER),
    ('yuan', 15313, 16416),
    ('wei', NULL::INTEGER, NULL::INTEGER)
), spans AS (
  SELECT
    d.id AS dynasty_id,
    GREATEST(d.start_abs, COALESCE(w.from_abs, d.start_abs)) AS start_abs,
    COALESCE(w.end_abs, d.end_abs) AS end_abs,
    w.from_abs
  FROM dynasties d
  JOIN orthodox_windows w ON w.dynasty_id = d.id
)
UPDATE reigns r
SET is_main = TRUE
FROM spans s, dynasties d
WHERE r.dynasty_id = s.dynasty_id
  AND d.id = r.dynasty_id
  AND COALESCE(r.claim_track, 'main') = 'main'
  AND r.claim_role IS DISTINCT FROM 'rival'
  AND r.end_abs > s.start_abs
  AND r.start_abs < s.end_abs
  AND (
    (r.start_abs >= s.start_abs AND r.start_abs < s.end_abs)
    OR (
      s.from_abs IS NOT NULL
      AND s.start_abs > d.start_abs
      AND r.start_abs < s.start_abs
      AND s.start_abs - r.start_abs <= 12
    )
  );
