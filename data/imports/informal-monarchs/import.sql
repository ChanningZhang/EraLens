-- EraLens period import: informal-monarchs
-- Window: -841-01 .. 2026-09
BEGIN;

-- cleanup
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-ruzi-ying';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-zhou-ziqi-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-gao-lingwei-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-huang-fu-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-hu-weide-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-yan-huiqing-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-du-xigui-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-gu-weijun-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-hu-weide-roc-2';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-duan-qirui-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-zhang-zuolin-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-song-qingling-dong-biwu-prc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-npc-standing-committee-prc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-zhu-yihai-ming-south';
UPDATE reigns SET is_informal_monarch = false WHERE id = 'reign-dong-biwu-prc';
DELETE FROM reigns WHERE id = 'reign-wang-mang-regent';
DELETE FROM persons WHERE id = 'wang-mang-regent';

-- persons
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('gonghe-regency', '周公、召公', ARRAY['共伯和','周公','召公'], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['摄政'], '周厉王出奔后，周公、召公共和行政（一说共伯和摄政）。前841–前828年，共和行政。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共和_(西周)"}]'::jsonb, NULL, NULL, '共和行政')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('shulvping', '述律平', ARRAY[]::text[], NULL, NULL, 879, 1, 953, 1, ARRAY['太后'], '辽太祖耶律阿保机皇后，应天太后。926年太祖崩后称制，927年推举太宗即位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/述律平"}]'::jsonb, NULL, NULL, '应天太后称制')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('toregene-khatun', '乃马真后', ARRAY[]::text[], NULL, NULL, NULL, NULL, 1246, 1, ARRAY['皇后'], '窝阔台皇后，窝阔台汗崩后称制，1241–1246年监国，直到贵由即位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/乃马真后"}]'::jsonb, NULL, NULL, '称制皇后')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('oghul-qaimish', '海迷失后', ARRAY[]::text[], NULL, NULL, NULL, NULL, 1251, 1, ARRAY['皇后'], '贵由皇后，贵由汗崩后称制，1248–1251年监国，蒙哥即位后被处死。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/海迷失后"}]'::jsonb, NULL, NULL, '称制皇后')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;

-- dynasties

-- reigns
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-gonghe-zhou-west', 'zhou-west', 'gonghe-regency', '', NULL, -841, 1, NULL, -828, 12, NULL, -10080, -9913, 'year', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-shulvping-liao', 'liao', 'shulvping', '', NULL, 926, 9, 6, 927, 12, 10, 11120, 11135, 'day', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-guo-wei-regent-han-hou', 'han-hou', 'guo-wei', '监国', NULL, 951, 1, 2, 951, 2, 12, 11412, 11413, 'day', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-tolui-mongol', 'mongol-empire', 'tolui', '', NULL, 1227, 8, 25, 1229, 9, 12, 14731, 14756, 'day', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-toregene-mongol', 'mongol-empire', 'toregene-khatun', '', NULL, 1241, 12, 11, 1246, 8, 23, 14903, 14959, 'day', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-oghul-qaimish-mongol', 'mongol-empire', 'oghul-qaimish', '', NULL, 1248, 4, 20, 1251, 6, 30, 14979, 15017, 'day', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-zhu-qiyu-regent-ming', 'ming', 'zhu-qiyu', '郕王监国', NULL, 1449, 9, 6, 1449, 9, 22, 17396, 17396, 'day', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;

-- events

-- event_dynasties

-- event_participants

-- relations

COMMIT;
