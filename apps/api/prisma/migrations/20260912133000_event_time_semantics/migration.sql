ALTER TABLE "events"
  ADD COLUMN "time_mode" TEXT NOT NULL DEFAULT 'point',
  ADD COLUMN "precision" TEXT NOT NULL DEFAULT 'year',
  ADD COLUMN "date_note" TEXT;

ALTER TABLE "events"
  ADD CONSTRAINT "events_time_mode_check"
  CHECK ("time_mode" IN ('point', 'span', 'circa'));

ALTER TABLE "events"
  ADD CONSTRAINT "events_precision_check"
  CHECK ("precision" IN ('day', 'month', 'year', 'decade', 'century'));

ALTER TABLE "events"
  ADD CONSTRAINT "events_time_mode_fields_check"
  CHECK (
    ("time_mode" = 'point' AND "at_abs" IS NOT NULL)
    OR (
      "time_mode" IN ('span', 'circa')
      AND "start_abs" IS NOT NULL
      AND "end_abs" IS NOT NULL
    )
  );
