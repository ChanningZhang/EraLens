-- Run against an isolated upgraded database. Every probe is rolled back.
BEGIN;
DO $$
BEGIN
  BEGIN
    INSERT INTO location_mapping SELECT (jsonb_populate_record(NULL::location_mapping,
      to_jsonb(m)||jsonb_build_object('id','__location_probe__','external_id','__missing_owner__'))).*
      FROM location_mapping m LIMIT 1;
    RAISE EXCEPTION 'Missing polymorphic owner was accepted';
  EXCEPTION WHEN foreign_key_violation THEN NULL; END;
  BEGIN
    INSERT INTO location_mapping SELECT (jsonb_populate_record(NULL::location_mapping,
      to_jsonb(m)||jsonb_build_object('id','__location_probe__','location_id','__missing_location__'))).*
      FROM location_mapping m LIMIT 1;
    RAISE EXCEPTION 'Missing location was accepted';
  EXCEPTION WHEN foreign_key_violation THEN NULL; END;
  BEGIN
    INSERT INTO location_mapping SELECT (jsonb_populate_record(NULL::location_mapping,
      to_jsonb(m)||jsonb_build_object('id','__location_probe__','role',NULL))).*
      FROM location_mapping m WHERE kind='reign' LIMIT 1;
    RAISE EXCEPTION 'Undated capital role was accepted';
  EXCEPTION WHEN check_violation THEN NULL; END;
  BEGIN
    DELETE FROM locations WHERE id=(SELECT location_id FROM location_mapping LIMIT 1);
    RAISE EXCEPTION 'Referenced spatial record was deleted';
  EXCEPTION WHEN foreign_key_violation THEN NULL; END;
  BEGIN
    INSERT INTO locations SELECT '___duplicate_location___',modern_name,longitude,latitude,coordinate_system FROM locations LIMIT 1;
    RAISE EXCEPTION 'Duplicate spatial tuple was accepted';
  EXCEPTION WHEN unique_violation THEN NULL; END;
END $$;
ROLLBACK;
