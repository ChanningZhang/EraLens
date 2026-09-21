-- 姓/氏仅存于 persons；王朝表不再保留默认姓氏。
ALTER TABLE dynasties DROP COLUMN IF EXISTS ancestral_xing;
ALTER TABLE dynasties DROP COLUMN IF EXISTS clan_shi;
