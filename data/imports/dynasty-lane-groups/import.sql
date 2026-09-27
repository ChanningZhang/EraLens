-- EraLens period import: dynasty-lane-groups
-- Window: -9999-01 .. 9999-12
BEGIN;

-- cleanup
DELETE FROM dynasty_lane_groups WHERE id = 'zhou-west-east';

-- dynasty_lane_groups
INSERT INTO dynasty_lane_groups (id, primary_dynasty_id, phase_dynasty_ids, lane_order_start_abs, lane_order_end_abs)
VALUES ('mongol-yuan', 'yuan', ARRAY['mongol-empire','yuan'], 14472, 16656)
ON CONFLICT (id) DO UPDATE SET primary_dynasty_id = EXCLUDED.primary_dynasty_id, phase_dynasty_ids = EXCLUDED.phase_dynasty_ids, lane_order_start_abs = EXCLUDED.lane_order_start_abs, lane_order_end_abs = EXCLUDED.lane_order_end_abs;
INSERT INTO dynasty_lane_groups (id, primary_dynasty_id, phase_dynasty_ids, lane_order_start_abs, lane_order_end_abs)
VALUES ('wu-ming', 'ming', ARRAY['wu-zhu','ming','ming-south'], 16368, 19944)
ON CONFLICT (id) DO UPDATE SET primary_dynasty_id = EXCLUDED.primary_dynasty_id, phase_dynasty_ids = EXCLUDED.phase_dynasty_ids, lane_order_start_abs = EXCLUDED.lane_order_start_abs, lane_order_end_abs = EXCLUDED.lane_order_end_abs;

COMMIT;
