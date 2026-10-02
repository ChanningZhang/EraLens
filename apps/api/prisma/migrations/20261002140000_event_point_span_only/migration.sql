-- Reject new legacy circa events while allowing a staged import to convert any
-- pre-existing rows before the constraint is validated.
ALTER TABLE events
  ADD CONSTRAINT events_time_mode_point_span_check
  CHECK (time_mode IN ('point', 'span')) NOT VALID;
