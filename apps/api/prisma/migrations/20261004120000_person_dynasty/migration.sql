ALTER TABLE "persons"
  ADD COLUMN "dynasty_id" TEXT;

WITH reign_candidates AS (
  SELECT
    r.person_id,
    MIN(r.dynasty_id) AS dynasty_id
  FROM "reigns" r
  GROUP BY r.person_id
  HAVING COUNT(DISTINCT r.dynasty_id) = 1
)
UPDATE "persons" p
SET "dynasty_id" = rc.dynasty_id
FROM reign_candidates rc
WHERE p.id = rc.person_id;

WITH direct_association_candidates AS (
  SELECT a.a_id AS person_id, a.b_id AS dynasty_id
  FROM "entity_associations" a
  WHERE a.a_type = 'person' AND a.b_type = 'dynasty'
  UNION
  SELECT a.b_id AS person_id, a.a_id AS dynasty_id
  FROM "entity_associations" a
  WHERE a.b_type = 'person' AND a.a_type = 'dynasty'
), unique_direct_association AS (
  SELECT person_id, MIN(dynasty_id) AS dynasty_id
  FROM direct_association_candidates
  GROUP BY person_id
  HAVING COUNT(DISTINCT dynasty_id) = 1
)
UPDATE "persons" p
SET "dynasty_id" = uda.dynasty_id
FROM unique_direct_association uda
WHERE p.id = uda.person_id AND p."dynasty_id" IS NULL;

CREATE INDEX "persons_dynasty_id_idx" ON "persons"("dynasty_id");

ALTER TABLE "persons"
  ADD CONSTRAINT "persons_dynasty_id_fkey"
  FOREIGN KEY ("dynasty_id") REFERENCES "dynasties"("id")
  ON DELETE SET NULL ON UPDATE CASCADE;
