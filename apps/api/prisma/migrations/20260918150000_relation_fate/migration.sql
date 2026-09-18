ALTER TABLE "relations"
  ADD COLUMN "at_year" INTEGER,
  ADD COLUMN "at_month" INTEGER,
  ADD COLUMN "at_abs" INTEGER,
  ADD COLUMN "precision" TEXT DEFAULT 'year',
  ADD COLUMN "event_id" TEXT;
