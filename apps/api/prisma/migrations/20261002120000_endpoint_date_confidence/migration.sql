-- Add endpoint-level date confidence and day precision without deleting legacy
-- precision/confidence columns. The legacy columns remain available for review.
ALTER TABLE persons
  ADD COLUMN birth_day INTEGER,
  ADD COLUMN death_day INTEGER,
  ADD COLUMN birth_confidence TEXT,
  ADD COLUMN death_confidence TEXT;

ALTER TABLE dynasty_groups
  ADD COLUMN start_day INTEGER,
  ADD COLUMN end_day INTEGER,
  ADD COLUMN start_confidence TEXT NOT NULL DEFAULT 'year',
  ADD COLUMN end_confidence TEXT NOT NULL DEFAULT 'year';

ALTER TABLE dynasties
  ADD COLUMN start_day INTEGER,
  ADD COLUMN end_day INTEGER,
  ADD COLUMN start_confidence TEXT NOT NULL DEFAULT 'year',
  ADD COLUMN end_confidence TEXT NOT NULL DEFAULT 'year';

ALTER TABLE reigns
  ADD COLUMN start_confidence TEXT NOT NULL DEFAULT 'year',
  ADD COLUMN end_confidence TEXT NOT NULL DEFAULT 'year';

ALTER TABLE events
  ADD COLUMN at_confidence TEXT,
  ADD COLUMN start_confidence TEXT,
  ADD COLUMN end_confidence TEXT;

ALTER TABLE relations ADD COLUMN at_confidence TEXT;

ALTER TABLE dynasty_capitals
  ADD COLUMN start_confidence TEXT NOT NULL DEFAULT 'year',
  ADD COLUMN end_confidence TEXT NOT NULL DEFAULT 'year';

-- Lossless compatibility backfill. Historical re-review is tracked separately;
-- this conversion only expresses existing legacy precision/confidence in the
-- new endpoint vocabulary.
UPDATE reigns SET
  start_confidence = CASE start_date_confidence
    WHEN 'approximate' THEN CASE precision WHEN 'day' THEN 'approximate_day' WHEN 'month' THEN 'approximate_month' ELSE 'approximate_year' END
    WHEN 'interpolated' THEN 'interpolated_by_other'
    ELSE precision END,
  end_confidence = CASE end_date_confidence
    WHEN 'approximate' THEN CASE precision WHEN 'day' THEN 'approximate_day' WHEN 'month' THEN 'approximate_month' ELSE 'approximate_year' END
    WHEN 'interpolated' THEN 'interpolated_by_other'
    ELSE precision END;

UPDATE dynasty_capitals SET
  start_confidence = CASE start_date_confidence
    WHEN 'approximate' THEN CASE precision WHEN 'day' THEN 'approximate_day' WHEN 'month' THEN 'approximate_month' ELSE 'approximate_year' END
    WHEN 'interpolated' THEN 'interpolated_by_other'
    ELSE precision END,
  end_confidence = CASE end_date_confidence
    WHEN 'approximate' THEN CASE COALESCE(end_precision, precision) WHEN 'day' THEN 'approximate_day' WHEN 'month' THEN 'approximate_month' ELSE 'approximate_year' END
    WHEN 'interpolated' THEN 'interpolated_by_other'
    ELSE COALESCE(end_precision, precision) END;

UPDATE events SET
  at_confidence = CASE WHEN at_year IS NULL THEN NULL
    WHEN is_approximate THEN CASE precision WHEN 'day' THEN 'approximate_day' WHEN 'month' THEN 'approximate_month' ELSE 'approximate_year' END
    ELSE CASE precision WHEN 'day' THEN 'day' WHEN 'month' THEN 'month' ELSE 'year' END END,
  start_confidence = CASE WHEN start_year IS NULL THEN NULL
    WHEN time_mode = 'circa' THEN 'approximate_year'
    ELSE CASE precision WHEN 'day' THEN 'day' WHEN 'month' THEN 'month' ELSE 'year' END END,
  end_confidence = CASE WHEN end_year IS NULL THEN NULL
    WHEN time_mode = 'circa' THEN 'approximate_year'
    ELSE CASE precision WHEN 'day' THEN 'day' WHEN 'month' THEN 'month' ELSE 'year' END END;

UPDATE relations SET at_confidence = CASE
  WHEN at_year IS NULL THEN NULL
  WHEN precision = 'day' THEN 'day'
  WHEN precision = 'month' THEN 'month'
  ELSE 'year' END;
