-- Fill date confidences for unreviewed records by lossless structural mapping.
-- These rows are not counted as historical re-reviews.
UPDATE persons SET
  birth_confidence = CASE WHEN birth_year IS NULL THEN NULL WHEN birth_month IS NOT NULL AND birth_month <> 1 THEN 'month' ELSE 'year' END,
  death_confidence = CASE WHEN death_year IS NULL THEN NULL WHEN death_month IS NOT NULL AND death_month <> 1 THEN 'month' ELSE 'year' END;

UPDATE dynasty_groups SET
  start_confidence = CASE precision WHEN 'day' THEN 'day' WHEN 'month' THEN 'month' ELSE 'year' END,
  end_confidence = CASE precision WHEN 'day' THEN 'day' WHEN 'month' THEN 'month' ELSE 'year' END;

UPDATE dynasties SET
  start_confidence = CASE precision WHEN 'day' THEN 'day' WHEN 'month' THEN 'month' ELSE 'year' END,
  end_confidence = CASE precision WHEN 'day' THEN 'day' WHEN 'month' THEN 'month' ELSE 'year' END;

UPDATE events SET
  at_confidence = CASE WHEN at_year IS NULL THEN NULL
    WHEN is_approximate OR precision IN ('decade', 'century') THEN CASE precision WHEN 'day' THEN 'approximate_day' WHEN 'month' THEN 'approximate_month' ELSE 'approximate_year' END
    ELSE CASE precision WHEN 'day' THEN 'day' WHEN 'month' THEN 'month' ELSE 'year' END END,
  start_confidence = CASE WHEN start_year IS NULL THEN NULL
    WHEN precision IN ('decade', 'century') THEN 'approximate_year'
    ELSE CASE precision WHEN 'day' THEN 'day' WHEN 'month' THEN 'month' ELSE 'year' END END,
  end_confidence = CASE WHEN end_year IS NULL THEN NULL
    WHEN precision IN ('decade', 'century') THEN 'approximate_year'
    ELSE CASE precision WHEN 'day' THEN 'day' WHEN 'month' THEN 'month' ELSE 'year' END END;

UPDATE relations SET at_confidence = CASE
  WHEN at_year IS NULL THEN NULL
  WHEN precision IN ('decade', 'century') THEN 'approximate_year'
  WHEN precision = 'day' THEN 'day'
  WHEN precision = 'month' THEN 'month'
  ELSE 'year' END;
