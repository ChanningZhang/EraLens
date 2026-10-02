-- Approved after user acceptance of the date-confidence migration report.
ALTER TABLE "dynasties" DROP COLUMN "precision";
ALTER TABLE "dynasty_groups" DROP COLUMN "precision";
ALTER TABLE "reigns"
  DROP COLUMN "precision",
  DROP COLUMN "start_date_confidence",
  DROP COLUMN "end_date_confidence";
ALTER TABLE "events"
  DROP COLUMN "precision",
  DROP COLUMN "is_approximate";
ALTER TABLE "relations" DROP COLUMN "precision";
ALTER TABLE "dynasty_capitals"
  DROP COLUMN "precision",
  DROP COLUMN "end_precision",
  DROP COLUMN "start_date_confidence",
  DROP COLUMN "end_date_confidence";
