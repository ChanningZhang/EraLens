-- Pre-imperial 姓/氏: sourced in data/imports, not hardcoded in app logic.
ALTER TABLE persons ADD COLUMN IF NOT EXISTS ancestral_xing TEXT;
ALTER TABLE persons ADD COLUMN IF NOT EXISTS clan_shi TEXT;

ALTER TABLE dynasties ADD COLUMN IF NOT EXISTS ancestral_xing TEXT;
ALTER TABLE dynasties ADD COLUMN IF NOT EXISTS clan_shi TEXT;
