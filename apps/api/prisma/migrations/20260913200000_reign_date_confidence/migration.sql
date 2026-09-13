-- Optional trust level for reign boundary years (NULL = certain).
ALTER TABLE reigns
  ADD COLUMN start_date_confidence TEXT,
  ADD COLUMN end_date_confidence TEXT;
