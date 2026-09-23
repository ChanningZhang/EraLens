ALTER TABLE "persons" ADD COLUMN "title" TEXT;

WITH ranked_reigns AS (
  SELECT
    "person_id",
    "title",
    ROW_NUMBER() OVER (
      PARTITION BY "person_id"
      ORDER BY "start_abs" DESC, "end_abs" DESC, "id" DESC
    ) AS position
  FROM "reigns"
)
UPDATE "persons" AS person
SET "title" = ranked_reigns."title"
FROM ranked_reigns
WHERE ranked_reigns."person_id" = person."id"
  AND ranked_reigns.position = 1;

UPDATE "persons" SET "title" = '明代宗' WHERE "id" = 'zhu-qiyu';
UPDATE "persons" SET "title" = '史料缺' WHERE "id" = 'system-missing-ruler';
