BEGIN;
CREATE TABLE entity_associations (
 a_type TEXT NOT NULL CHECK(a_type IN ('dynasty','event','person')),
 a_id TEXT NOT NULL CHECK(length(a_id)>0),
 b_type TEXT NOT NULL CHECK(b_type IN ('dynasty','event','person')),
 b_id TEXT NOT NULL CHECK(length(b_id)>0),
 PRIMARY KEY(a_type,a_id,b_type,b_id),
 CHECK((a_type||':'||a_id) COLLATE "C" < (b_type||':'||b_id) COLLATE "C")
);
CREATE INDEX entity_associations_b_idx ON entity_associations(b_type,b_id);
CREATE TEMP TABLE association_before ON COMMIT DROP AS SELECT CASE WHEN a COLLATE "C" < b COLLATE "C" THEN at ELSE bt END a_type,
 CASE WHEN a COLLATE "C" < b COLLATE "C" THEN ai ELSE bi END a_id,
 CASE WHEN a COLLATE "C" < b COLLATE "C" THEN bt ELSE at END b_type,
 CASE WHEN a COLLATE "C" < b COLLATE "C" THEN bi ELSE ai END b_id
 FROM (SELECT at,ai,bt,bi,at||':'||ai a,bt||':'||bi b FROM (
 SELECT 'event'::text at,event_id ai,'person'::text bt,person_id bi FROM event_participants
 UNION SELECT 'event',event_id,'dynasty',dynasty_id FROM event_dynasties
 UNION SELECT from_type,from_id,to_type,to_id FROM relations
 WHERE kind NOT IN ('killed','surrender','abdication','captured','conquered')
 AND NOT(kind='succession' AND from_type='person' AND to_type='person')
 ) originals) refs;
INSERT INTO entity_associations SELECT DISTINCT * FROM association_before;
DO $$ BEGIN
 IF EXISTS((SELECT * FROM association_before EXCEPT SELECT * FROM entity_associations)
 UNION ALL (SELECT * FROM entity_associations EXCEPT SELECT * FROM association_before)) THEN RAISE EXCEPTION 'Association backfill changed the pair set'; END IF;
END $$;
CREATE FUNCTION validate_entity_association_endpoints() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE t TEXT; i TEXT; valid BOOLEAN;
BEGIN
 FOR t,i IN SELECT NEW.a_type,NEW.a_id UNION ALL SELECT NEW.b_type,NEW.b_id LOOP
 CASE t
 WHEN 'dynasty' THEN PERFORM 1 FROM dynasties WHERE id=i FOR KEY SHARE; valid:=FOUND;
 WHEN 'event' THEN PERFORM 1 FROM events WHERE id=i FOR KEY SHARE; valid:=FOUND;
 WHEN 'person' THEN PERFORM 1 FROM persons WHERE id=i FOR KEY SHARE; valid:=FOUND;
 ELSE valid:=false;
 END CASE;
 IF NOT valid THEN RAISE EXCEPTION 'Invalid association endpoint: %:%',t,i USING ERRCODE='23503'; END IF;
 END LOOP;
 RETURN NEW;
END $$;
CREATE TRIGGER entity_association_endpoints BEFORE INSERT OR UPDATE ON entity_associations FOR EACH ROW EXECUTE FUNCTION validate_entity_association_endpoints();
-- Validate the backfilled endpoints through the same trigger.
UPDATE entity_associations SET a_id=a_id;
CREATE FUNCTION maintain_entity_association_endpoint() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE t TEXT:=TG_ARGV[0];
BEGIN
 IF TG_OP='UPDATE' THEN
 IF NEW.id<>OLD.id AND EXISTS(SELECT 1 FROM entity_associations WHERE (a_type=t AND a_id=OLD.id) OR (b_type=t AND b_id=OLD.id)) THEN RAISE EXCEPTION 'Cannot rename an associated entity: %:%',t,OLD.id USING ERRCODE='23503'; END IF;
 RETURN NEW;
 END IF;
 DELETE FROM entity_associations WHERE (a_type=t AND a_id=OLD.id) OR (b_type=t AND b_id=OLD.id);
 RETURN OLD;
END $$;
CREATE TRIGGER dynasty_associations_delete BEFORE DELETE ON dynasties FOR EACH ROW EXECUTE FUNCTION maintain_entity_association_endpoint('dynasty');
CREATE TRIGGER dynasty_associations_update BEFORE UPDATE OF id ON dynasties FOR EACH ROW EXECUTE FUNCTION maintain_entity_association_endpoint('dynasty');
CREATE TRIGGER event_associations_delete BEFORE DELETE ON events FOR EACH ROW EXECUTE FUNCTION maintain_entity_association_endpoint('event');
CREATE TRIGGER event_associations_update BEFORE UPDATE OF id ON events FOR EACH ROW EXECUTE FUNCTION maintain_entity_association_endpoint('event');
CREATE TRIGGER person_associations_delete BEFORE DELETE ON persons FOR EACH ROW EXECUTE FUNCTION maintain_entity_association_endpoint('person');
CREATE TRIGGER person_associations_update BEFORE UPDATE OF id ON persons FOR EACH ROW EXECUTE FUNCTION maintain_entity_association_endpoint('person');
DELETE FROM relations WHERE kind NOT IN ('killed','surrender','abdication','captured','conquered') AND NOT(kind='succession' AND from_type='person' AND to_type='person');
ALTER TABLE relations ADD CONSTRAINT relations_kind_check CHECK(kind IN ('succession','killed','surrender','abdication','captured','conquered'));
ALTER TABLE relations ADD CONSTRAINT relations_endpoints_check CHECK((kind='succession' AND from_type='person' AND to_type='person') OR (kind<>'succession' AND from_type IN ('person','reign') AND to_type='person' AND at_abs IS NOT NULL));
DROP TABLE event_participants;
DROP TABLE event_dynasties;
COMMIT;
