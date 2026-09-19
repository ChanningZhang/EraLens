-- Move posthumous/temple names to persons; collapse era_names into reigns.era_names CSV.

ALTER TABLE "persons" ADD COLUMN "posthumous_name" TEXT;
ALTER TABLE "persons" ADD COLUMN "temple_name" TEXT;

ALTER TABLE "reigns" ADD COLUMN "era_names" TEXT;

-- Aggregate posthumous names per person (distinct, ordered by earliest reign start_abs).
UPDATE "persons" p
SET "posthumous_name" = agg.names
FROM (
  SELECT
    r.person_id,
    string_agg(DISTINCT r.posthumous_name, ',' ORDER BY r.posthumous_name) AS names
  FROM "reigns" r
  WHERE r.posthumous_name IS NOT NULL AND r.posthumous_name <> ''
  GROUP BY r.person_id
) agg
WHERE p.id = agg.person_id;

-- Aggregate temple names per person.
UPDATE "persons" p
SET "temple_name" = agg.names
FROM (
  SELECT
    r.person_id,
    string_agg(DISTINCT r.temple_name, ',' ORDER BY r.temple_name) AS names
  FROM "reigns" r
  WHERE r.temple_name IS NOT NULL AND r.temple_name <> ''
  GROUP BY r.person_id
) agg
WHERE p.id = agg.person_id;

-- Collapse era_names rows into reigns.era_names CSV (ordered by sort_order, then id).
UPDATE "reigns" r
SET "era_names" = agg.names
FROM (
  SELECT
    e.reign_id,
    string_agg(e.name, ',' ORDER BY e.sort_order, e.id) AS names
  FROM "era_names" e
  GROUP BY e.reign_id
) agg
WHERE r.id = agg.reign_id;

ALTER TABLE "reigns" DROP COLUMN "posthumous_name";
ALTER TABLE "reigns" DROP COLUMN "temple_name";

DROP TABLE "era_names";
