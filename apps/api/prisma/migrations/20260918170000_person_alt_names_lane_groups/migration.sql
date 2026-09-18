ALTER TABLE persons
  ADD COLUMN alt_names text[] NOT NULL DEFAULT ARRAY[]::text[];

CREATE TABLE dynasty_lane_groups (
  id text PRIMARY KEY,
  primary_dynasty_id text NOT NULL,
  phase_dynasty_ids text[] NOT NULL,
  lane_order_start_abs integer NOT NULL,
  lane_order_end_abs integer NOT NULL
);
