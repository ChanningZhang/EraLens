ALTER TABLE "persons"
ADD COLUMN "search_terms" TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[];

-- Rebuild one person, or every person when target_person_id is NULL. Search terms
-- are normalized once on write so indexed lookup never has to join reigns/dynasties.
CREATE OR REPLACE FUNCTION rebuild_person_search_terms(target_person_id TEXT DEFAULT NULL)
RETURNS VOID
LANGUAGE SQL
AS $$
  WITH rebuilt AS (
    SELECT
      p.id,
      COALESCE(
        array_agg(DISTINCT normalized.term ORDER BY normalized.term)
          FILTER (WHERE normalized.term <> ''),
        ARRAY[]::TEXT[]
      ) AS terms
    FROM persons p
    LEFT JOIN LATERAL (
      SELECT p.name AS term
      UNION ALL
      SELECT unnest(COALESCE(p.alt_names, ARRAY[]::TEXT[]))
      UNION ALL
      SELECT regexp_split_to_table(COALESCE(p.posthumous_name, ''), '\s*,\s*')
      UNION ALL
      SELECT regexp_split_to_table(COALESCE(p.temple_name, ''), '\s*,\s*')
      UNION ALL
      SELECT p.ancestral_xing || CASE
        WHEN p.ancestral_xing IS NOT NULL AND p.name LIKE p.ancestral_xing || '%'
          THEN substr(p.name, char_length(p.ancestral_xing) + 1)
        WHEN p.clan_shi IS NOT NULL AND p.name LIKE p.clan_shi || '%'
          THEN substr(p.name, char_length(p.clan_shi) + 1)
        ELSE p.name
      END
      WHERE p.ancestral_xing IS NOT NULL
      UNION ALL
      SELECT p.clan_shi || CASE
        WHEN p.ancestral_xing IS NOT NULL AND p.name LIKE p.ancestral_xing || '%'
          THEN substr(p.name, char_length(p.ancestral_xing) + 1)
        WHEN p.clan_shi IS NOT NULL AND p.name LIKE p.clan_shi || '%'
          THEN substr(p.name, char_length(p.clan_shi) + 1)
        ELSE p.name
      END
      WHERE p.clan_shi IS NOT NULL
      UNION ALL
      SELECT r.title
      FROM reigns r
      WHERE r.person_id = p.id
      UNION ALL
      SELECT dynasty_name.name || appellation.name
      FROM reigns r
      JOIN dynasties d ON d.id = r.dynasty_id
      CROSS JOIN LATERAL unnest(array_prepend(d.name, COALESCE(d.alt_names, ARRAY[]::TEXT[]))) AS dynasty_name(name)
      CROSS JOIN LATERAL regexp_split_to_table(
        concat_ws(',', NULLIF(p.posthumous_name, ''), NULLIF(p.temple_name, '')),
        '\s*,\s*'
      ) AS appellation(name)
      WHERE r.person_id = p.id
    ) raw ON TRUE
    CROSS JOIN LATERAL (
      SELECT lower(regexp_replace(btrim(COALESCE(raw.term, '')), '[[:space:]]+', '', 'g')) AS term
    ) normalized
    WHERE target_person_id IS NULL OR p.id = target_person_id
    GROUP BY p.id
  )
  UPDATE persons p
  SET search_terms = rebuilt.terms
  FROM rebuilt
  WHERE p.id = rebuilt.id
    AND p.search_terms IS DISTINCT FROM rebuilt.terms;
$$;

CREATE OR REPLACE FUNCTION refresh_person_search_terms_from_person()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
  PERFORM rebuild_person_search_terms(NEW.id);
  RETURN NEW;
END;
$$;

CREATE TRIGGER persons_refresh_search_terms
AFTER INSERT OR UPDATE OF name, alt_names, ancestral_xing, clan_shi, posthumous_name, temple_name
ON persons
FOR EACH ROW
EXECUTE FUNCTION refresh_person_search_terms_from_person();

CREATE OR REPLACE FUNCTION refresh_person_search_terms_from_reign()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    PERFORM rebuild_person_search_terms(OLD.person_id);
    RETURN OLD;
  END IF;

  PERFORM rebuild_person_search_terms(NEW.person_id);
  IF TG_OP = 'UPDATE' AND OLD.person_id IS DISTINCT FROM NEW.person_id THEN
    PERFORM rebuild_person_search_terms(OLD.person_id);
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER reigns_refresh_person_search_terms
AFTER INSERT OR DELETE OR UPDATE OF person_id, dynasty_id, title
ON reigns
FOR EACH ROW
EXECUTE FUNCTION refresh_person_search_terms_from_reign();

CREATE OR REPLACE FUNCTION refresh_person_search_terms_from_dynasty()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
  affected_person_id TEXT;
BEGIN
  FOR affected_person_id IN
    SELECT DISTINCT person_id
    FROM reigns
    WHERE dynasty_id = NEW.id
  LOOP
    PERFORM rebuild_person_search_terms(affected_person_id);
  END LOOP;
  RETURN NEW;
END;
$$;

CREATE TRIGGER dynasties_refresh_person_search_terms
AFTER UPDATE OF name, alt_names
ON dynasties
FOR EACH ROW
EXECUTE FUNCTION refresh_person_search_terms_from_dynasty();

SELECT rebuild_person_search_terms();

CREATE INDEX "persons_search_terms_gin_idx"
ON "persons" USING GIN ("search_terms");
