-- EraLens period import: informal-monarchs
-- Window: -841-01 .. 2026-09
BEGIN;

-- cleanup
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-ruzi-ying';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-duan-qirui-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-zhang-zuolin-roc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-song-qingling-prc';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-dong-biwu-prc-vice';
UPDATE reigns SET is_informal_monarch = true WHERE id = 'reign-npc-standing-committee-prc';
UPDATE reigns SET is_informal_monarch = false WHERE id = 'reign-zhu-yihai-ming-south';
UPDATE reigns SET is_informal_monarch = false WHERE id = 'reign-dong-biwu-prc';

-- persons
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('gonghe-regency', '周公、召公', ARRAY['共伯和','周公','召公'], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['摄政'], '周厉王出奔后，周公、召公共和行政（一说共伯和摄政）。前841–前828年，共和行政。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共和_(西周)"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('wang-mang-regent', '王莽', ARRAY[]::text[], NULL, NULL, -45, 1, 23, 10, ARRAY['摄政','权臣'], '西汉末年权臣，6–8年以摄皇帝/假皇帝名义摄政，后于9年篡汉建新。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王莽"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('shulvping', '述律平', ARRAY[]::text[], NULL, NULL, 879, 1, 953, 1, ARRAY['太后'], '辽太祖耶律阿保机皇后，应天太后。926年太祖崩后称制，927年推举太宗即位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/述律平"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('toregene-khatun', '乃马真后', ARRAY[]::text[], NULL, NULL, NULL, NULL, 1246, 1, ARRAY['皇后'], '窝阔台皇后，窝阔台汗崩后称制，1241–1246年监国，直到贵由即位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/乃马真后"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('oghul-qaimish', '海迷失后', ARRAY[]::text[], NULL, NULL, NULL, NULL, 1251, 1, ARRAY['皇后'], '贵由皇后，贵由汗崩后称制，1248–1251年监国，蒙哥即位后被处死。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/海迷失后"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;

-- dynasties

-- reigns
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-gonghe-zhou-west', 'zhou-west', 'gonghe-regency', '共和行政', NULL, -841, 12, NULL, -828, 12, NULL, -10069, -9913, 'year', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-wang-mang-regent', 'han-west', 'wang-mang-regent', '摄皇帝', NULL, 6, 4, NULL, 8, 11, NULL, 75, 106, 'year', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-shulvping-liao', 'liao', 'shulvping', '应天太后称制', NULL, 926, 7, NULL, 927, 11, NULL, 11118, 11134, 'year', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-guo-wei-regent-han-hou', 'han-hou', 'guo-wei', '监国', NULL, 950, 12, NULL, 951, 1, NULL, 11411, 11412, 'year', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-tolui-mongol', 'mongol-empire', 'tolui', '监国', NULL, 1227, 8, NULL, 1229, 9, NULL, 14731, 14756, 'year', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-toregene-mongol', 'mongol-empire', 'toregene-khatun', '称制皇后', NULL, 1241, 12, NULL, 1246, 8, NULL, 14903, 14959, 'year', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-oghul-qaimish-mongol', 'mongol-empire', 'oghul-qaimish', '称制皇后', NULL, 1248, 4, NULL, 1251, 7, NULL, 14979, 15018, 'year', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, is_informal_monarch)
VALUES ('reign-zhu-qiyu-regent-ming', 'ming', 'zhu-qiyu', '郕王监国', NULL, 1449, 9, 6, 1449, 9, 22, 17396, 17396, 'day', NULL, NULL, true)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, is_informal_monarch = EXCLUDED.is_informal_monarch;

-- events

-- event_dynasties

-- event_participants

-- relations

COMMIT;
