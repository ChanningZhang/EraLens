ALTER TABLE "events"
  ADD COLUMN "at_day" INTEGER,
  ADD COLUMN "start_day" INTEGER,
  ADD COLUMN "end_day" INTEGER;

ALTER TABLE "events"
  ADD CONSTRAINT "events_at_day_check" CHECK ("at_day" IS NULL OR "at_day" BETWEEN 1 AND 31),
  ADD CONSTRAINT "events_start_day_check" CHECK ("start_day" IS NULL OR "start_day" BETWEEN 1 AND 31),
  ADD CONSTRAINT "events_end_day_check" CHECK ("end_day" IS NULL OR "end_day" BETWEEN 1 AND 31);

ALTER TABLE "relations"
  ADD COLUMN "at_day" INTEGER,
  ADD CONSTRAINT "relations_at_day_check" CHECK ("at_day" IS NULL OR "at_day" BETWEEN 1 AND 31);
