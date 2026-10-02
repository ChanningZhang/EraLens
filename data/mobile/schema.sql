PRAGMA foreign_keys = ON;

CREATE TABLE persons (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, alt_names TEXT NOT NULL DEFAULT '[]',
  ancestral_xing TEXT, clan_shi TEXT, birth_year INTEGER, birth_month INTEGER, birth_day INTEGER, birth_confidence TEXT,
  death_year INTEGER, death_month INTEGER, death_day INTEGER, death_confidence TEXT, roles TEXT NOT NULL DEFAULT '[]', bio TEXT,
  links TEXT NOT NULL DEFAULT '[]', posthumous_name TEXT, temple_name TEXT, title TEXT,
  search_terms TEXT NOT NULL DEFAULT '[]'
);
CREATE TABLE dynasty_groups (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, alt_names TEXT NOT NULL DEFAULT '[]', scope TEXT NOT NULL,
  start_year INTEGER NOT NULL, start_month INTEGER NOT NULL, end_year INTEGER NOT NULL,
  end_month INTEGER NOT NULL, end_day INTEGER, end_confidence TEXT NOT NULL, start_abs INTEGER NOT NULL, end_abs INTEGER NOT NULL,
  start_day INTEGER, start_confidence TEXT NOT NULL, note TEXT
);
CREATE TABLE dynasties (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, alt_names TEXT NOT NULL DEFAULT '[]', scope TEXT NOT NULL,
  region TEXT NOT NULL, start_year INTEGER NOT NULL, start_month INTEGER NOT NULL, end_year INTEGER NOT NULL,
  end_month INTEGER NOT NULL, end_day INTEGER, end_confidence TEXT NOT NULL, start_abs INTEGER NOT NULL, end_abs INTEGER NOT NULL,
  start_day INTEGER, start_confidence TEXT NOT NULL, color_token TEXT NOT NULL, parent_id TEXT, group_id TEXT,
  note TEXT, FOREIGN KEY(group_id) REFERENCES dynasty_groups(id)
);
CREATE TABLE reigns (
  id TEXT PRIMARY KEY, dynasty_id TEXT NOT NULL, person_id TEXT NOT NULL, title TEXT NOT NULL,
  era_names TEXT, start_year INTEGER NOT NULL, start_month INTEGER NOT NULL, start_day INTEGER,
  end_year INTEGER, end_month INTEGER, end_day INTEGER, start_abs INTEGER NOT NULL, end_abs INTEGER NOT NULL,
  start_confidence TEXT NOT NULL, end_confidence TEXT NOT NULL,
  claim_track TEXT, claim_label TEXT, claim_role TEXT, is_informal_monarch INTEGER NOT NULL,
  is_main INTEGER, FOREIGN KEY(dynasty_id) REFERENCES dynasties(id), FOREIGN KEY(person_id) REFERENCES persons(id)
);
CREATE TABLE event_locations (
  id TEXT PRIMARY KEY, historical_name TEXT NOT NULL, modern_name TEXT NOT NULL,
  longitude REAL NOT NULL, latitude REAL NOT NULL, coordinate_system TEXT NOT NULL,
  precision TEXT NOT NULL, note TEXT, links TEXT NOT NULL DEFAULT '[]'
);
CREATE TABLE events (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, kind TEXT NOT NULL, time_mode TEXT NOT NULL,
  at_confidence TEXT, start_confidence TEXT, end_confidence TEXT, date_note TEXT,
  at_year INTEGER, at_month INTEGER, at_day INTEGER, at_abs INTEGER,
  start_year INTEGER, start_month INTEGER, start_day INTEGER, start_abs INTEGER,
  end_year INTEGER, end_month INTEGER, end_day INTEGER, end_abs INTEGER,
  summary TEXT, meaning TEXT, content TEXT, location_id TEXT,
  FOREIGN KEY(location_id) REFERENCES event_locations(id) ON DELETE SET NULL
);
CREATE TABLE event_dynasties (
  event_id TEXT NOT NULL, dynasty_id TEXT NOT NULL, PRIMARY KEY(event_id, dynasty_id),
  FOREIGN KEY(event_id) REFERENCES events(id) ON DELETE CASCADE,
  FOREIGN KEY(dynasty_id) REFERENCES dynasties(id) ON DELETE CASCADE
);
CREATE TABLE event_participants (
  event_id TEXT NOT NULL, person_id TEXT NOT NULL, PRIMARY KEY(event_id, person_id),
  FOREIGN KEY(event_id) REFERENCES events(id) ON DELETE CASCADE,
  FOREIGN KEY(person_id) REFERENCES persons(id) ON DELETE CASCADE
);
CREATE TABLE relations (
  id TEXT PRIMARY KEY, from_type TEXT NOT NULL, from_id TEXT NOT NULL, to_type TEXT NOT NULL,
  to_id TEXT NOT NULL, kind TEXT NOT NULL, at_year INTEGER, at_month INTEGER, at_day INTEGER,
  at_abs INTEGER, at_confidence TEXT, event_id TEXT, UNIQUE(from_type, from_id, to_type, to_id, kind)
);
CREATE TABLE dynasty_lane_groups (
  id TEXT PRIMARY KEY, primary_dynasty_id TEXT NOT NULL, phase_dynasty_ids TEXT NOT NULL DEFAULT '[]',
  lane_order_start_abs INTEGER NOT NULL, lane_order_end_abs INTEGER NOT NULL
);
CREATE TABLE dynasty_capitals (
  id TEXT PRIMARY KEY, dynasty_id TEXT NOT NULL, historical_name TEXT NOT NULL, modern_name TEXT NOT NULL,
  longitude REAL NOT NULL, latitude REAL NOT NULL, coordinate_system TEXT NOT NULL,
  start_year INTEGER NOT NULL, start_month INTEGER NOT NULL, start_day INTEGER,
  end_year INTEGER NOT NULL, end_month INTEGER NOT NULL, end_day INTEGER,
  start_abs INTEGER NOT NULL, end_abs INTEGER NOT NULL, role TEXT NOT NULL, claim_track TEXT, note TEXT,
  start_confidence TEXT NOT NULL, end_confidence TEXT NOT NULL,
  links TEXT NOT NULL DEFAULT '[]', FOREIGN KEY(dynasty_id) REFERENCES dynasties(id)
);
CREATE TABLE reign_capitals (
  reign_id TEXT NOT NULL, capital_id TEXT NOT NULL, PRIMARY KEY(reign_id, capital_id),
  FOREIGN KEY(reign_id) REFERENCES reigns(id) ON DELETE CASCADE,
  FOREIGN KEY(capital_id) REFERENCES dynasty_capitals(id) ON DELETE CASCADE
);
CREATE TABLE search_entries (
  entity_type TEXT NOT NULL, entity_id TEXT NOT NULL, normalized_term TEXT NOT NULL,
  term_kind TEXT NOT NULL, label TEXT NOT NULL, subtitle TEXT, anchor_abs INTEGER,
  PRIMARY KEY(entity_type, entity_id, normalized_term, term_kind)
);
CREATE TABLE content_metadata (
  key TEXT PRIMARY KEY, value TEXT NOT NULL
);

CREATE INDEX persons_birth_year_idx ON persons(birth_year);
CREATE INDEX persons_death_year_idx ON persons(death_year);
CREATE INDEX persons_name_idx ON persons(name);
CREATE INDEX dynasty_groups_window_idx ON dynasty_groups(scope, start_abs, end_abs);
CREATE INDEX dynasties_window_idx ON dynasties(scope, start_abs, end_abs);
CREATE INDEX dynasties_group_idx ON dynasties(group_id);
CREATE INDEX reigns_window_idx ON reigns(start_abs, end_abs);
CREATE INDEX reigns_dynasty_idx ON reigns(dynasty_id);
CREATE INDEX reigns_person_idx ON reigns(person_id);
CREATE INDEX reigns_claim_track_idx ON reigns(claim_track);
CREATE INDEX events_at_abs_idx ON events(at_abs);
CREATE INDEX events_start_end_abs_idx ON events(start_abs, end_abs);
CREATE INDEX events_location_idx ON events(location_id);
CREATE INDEX relations_event_idx ON relations(event_id);
CREATE INDEX capitals_dynasty_idx ON dynasty_capitals(dynasty_id);
CREATE INDEX capitals_window_idx ON dynasty_capitals(start_abs, end_abs);
CREATE INDEX reign_capitals_capital_idx ON reign_capitals(capital_id);
CREATE INDEX search_entries_term_idx ON search_entries(normalized_term);
CREATE INDEX search_entries_entity_idx ON search_entries(entity_type, entity_id);
