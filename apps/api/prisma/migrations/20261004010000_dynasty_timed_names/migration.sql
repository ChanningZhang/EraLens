-- Names remain TEXT; timed names contain only periods. alt_names[1] owns the representative name.
CREATE OR REPLACE FUNCTION dynasty_name_terms(raw TEXT, aliases TEXT[])
RETURNS TEXT[] LANGUAGE plpgsql IMMUTABLE AS $$
DECLARE definition JSONB; result TEXT[];
BEGIN
  BEGIN
    definition := raw::jsonb;
  EXCEPTION WHEN invalid_text_representation THEN
    IF btrim(raw) ~ '^[\[{]' THEN RAISE EXCEPTION 'Invalid dynasty name JSON'; END IF;
    RETURN array_prepend(raw, COALESCE(aliases, ARRAY[]::TEXT[]));
  END;
  IF jsonb_typeof(definition) IS DISTINCT FROM 'object'
     OR jsonb_typeof(definition->'periods') IS DISTINCT FROM 'array'
     OR jsonb_array_length(definition->'periods') = 0
     OR EXISTS (SELECT 1 FROM jsonb_object_keys(definition) k WHERE k <> 'periods')
     OR COALESCE(btrim(aliases[1]), '') = '' THEN
    RAISE EXCEPTION 'Timed dynasty name requires periods and alt_names[1]';
  END IF;
  IF EXISTS (SELECT 1 FROM jsonb_array_elements(definition->'periods') p
    WHERE jsonb_typeof(p->'name') IS DISTINCT FROM 'string' OR COALESCE(btrim(p->>'name'), '') = '') THEN
    RAISE EXCEPTION 'Invalid dynasty name period';
  END IF;
  SELECT array_agg(DISTINCT value) INTO result FROM (
    SELECT p->>'name' AS value FROM jsonb_array_elements(definition->'periods') p
    UNION SELECT unnest(COALESCE(aliases, ARRAY[]::TEXT[]))
  ) terms;
  RETURN result;
END;
$$;

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
      CROSS JOIN LATERAL unnest(dynasty_name_terms(d.name, d.alt_names)) AS dynasty_name(name)
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

SELECT rebuild_person_search_terms();
DROP TABLE dynasty_lane_groups;
