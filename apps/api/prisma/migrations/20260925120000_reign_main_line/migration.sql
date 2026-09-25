ALTER TABLE "reigns" ADD COLUMN "is_main" BOOLEAN;

-- Preserve the old orthodox window as an explicit reign-level classification.
-- The old renderer allowed an accession up to 12 months before a delayed start
-- (notably Shunzhi); claimants and declared rivals were always excluded.
UPDATE "reigns" AS r
SET "is_main" = TRUE
FROM "dynasties" AS d
WHERE d."id" = r."dynasty_id"
  AND r."claim_track" IS NULL
  AND r."claim_role" IS DISTINCT FROM 'rival'
  AND d."orthodox_from_abs" IS NOT NULL
  AND r."end_abs" > GREATEST(d."start_abs", d."orthodox_from_abs")
  AND r."start_abs" < COALESCE(d."orthodox_end_abs", d."end_abs")
  AND (
    r."start_abs" >= GREATEST(d."start_abs", d."orthodox_from_abs")
    OR (
      d."orthodox_from_abs" > d."start_abs"
      AND GREATEST(d."start_abs", d."orthodox_from_abs") - r."start_abs" <= 12
    )
  );

ALTER TABLE "dynasties" DROP COLUMN "orthodox_from_abs";
ALTER TABLE "dynasties" DROP COLUMN "orthodox_end_abs";
