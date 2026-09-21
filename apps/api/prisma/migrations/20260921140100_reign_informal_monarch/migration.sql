-- Add is_informal_monarch flag to reigns table for non-formal sovereigns
-- (regents, acting heads, joint vice-chairs, etc.)

ALTER TABLE reigns ADD COLUMN is_informal_monarch BOOLEAN NOT NULL DEFAULT false;

CREATE INDEX idx_reigns_informal_monarch ON reigns(is_informal_monarch) WHERE is_informal_monarch = true;
