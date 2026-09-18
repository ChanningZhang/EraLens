-- EraLens period import: xinan-guozheng
-- Window: -300-01 .. -27-12
BEGIN;

-- cleanup
DELETE FROM event_dynasties WHERE dynasty_id IN ('qiongdu', 'zuodu', 'ranmang', 'baima', 'qielan', 'laomo');
DELETE FROM event_dynasties WHERE event_id = 'han-destroy-qielan';
DELETE FROM event_participants WHERE person_id IN ('qiong-jun', 'zuo-hou', 'qielan-jun');
DELETE FROM event_participants WHERE event_id = 'han-destroy-qielan';
DELETE FROM relations WHERE id = 'rel-han-destroy-qielan';
DELETE FROM reigns WHERE id IN ('reign-qiong-jun-qiongdu', 'reign-zuo-hou-zuodu', 'reign-qielan-jun-qielan');
DELETE FROM reigns WHERE dynasty_id IN ('qiongdu', 'zuodu', 'ranmang', 'baima', 'qielan', 'laomo');
DELETE FROM persons WHERE id IN ('qiong-jun', 'zuo-hou', 'qielan-jun');
DELETE FROM dynasties WHERE id IN ('qiongdu', 'zuodu', 'ranmang', 'baima', 'qielan', 'laomo');
DELETE FROM events WHERE id = 'han-destroy-qielan';

-- persons
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('system-missing-ruler', '史料缺', NULL, NULL, NULL, NULL, ARRAY['系统占位'], 'EraLens 系统保留人物，仅用于标记经考证确认的国君资料缺失区间。', '[]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelang-duotong', '多同', NULL, NULL, NULL, NULL, ARRAY['君主'], '夜郎侯，汉武帝遣唐蒙通夜郎时在位；《史记》载其国为西南夷最大。在位起讫无通行记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/夜郎"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelang-xin', '兴', NULL, NULL, -27, 1, ARRAY['君主'], '夜郎王，前27年被邛郿侯陈立所杀，夜郎国亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/夜郎"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('zhuang-qiao', '庄蹻', NULL, NULL, -256, 1, ARRAY['君主'], '楚将，入滇称滇王，据滇池，开创滇国世系。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄蹻"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('dian-changqiang', '尝羌', NULL, NULL, NULL, NULL, ARRAY['君主'], '滇王，汉武帝元封二年率众降汉，设益州郡。中间世系多失考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/滇国"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;

-- dynasties
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES ('yelang', '夜郎', ARRAY['夜郎国'], 'cn', 'east_asia', -300, 1, -27, 1, -3588, -312, 'year', 'ochre', NULL, NULL, NULL, NULL, '战国时已有夜郎；汉武帝时夜郎侯多同，末王兴前27年被诛。君主在位年多失考，不强行拉满王朝跨度。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES ('dian', '滇', ARRAY['滇国'], 'cn', 'east_asia', -279, 1, -109, 1, -3336, -1296, 'year', 'indigo', NULL, NULL, NULL, NULL, '楚将庄蹻入滇称王；武帝元封二年（前109）尝羌降汉，设益州郡。庄蹻与尝羌之间世系失考。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;

-- reigns
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-yelang-duotong-yelang', 'yelang', 'yelang-duotong', '夜郎侯', NULL, NULL, NULL, -140, 1, NULL, -120, 12, NULL, -1668, -1417, 'year', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-yelang-xin-yelang', 'yelang', 'yelang-xin', '夜郎王', NULL, NULL, NULL, -30, 1, NULL, -27, 12, NULL, -348, -301, 'year', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-zhuang-qiao-dian', 'dian', 'zhuang-qiao', '滇王', NULL, NULL, NULL, -279, 1, NULL, -256, 12, NULL, -3336, -3049, 'year', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-dian-changqiang-dian', 'dian', 'dian-changqiang', '滇王', NULL, NULL, NULL, -115, 1, NULL, -109, 12, NULL, -1368, -1285, 'year', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-missing-yelang--119', 'yelang', 'system-missing-ruler', '史料缺', NULL, NULL, NULL, -119, 1, NULL, -31, 12, NULL, -1416, -349, 'year', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-missing-dian--255', 'dian', 'system-missing-ruler', '史料缺', NULL, NULL, NULL, -255, 1, NULL, -116, 12, NULL, -3048, -1369, 'year', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;

-- era_names

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('tangmeng-tong-yelang', '唐蒙通夜郎', 'politics', 'point', 'year', NULL, -135, 1, -1608, NULL, NULL, NULL, NULL, NULL, NULL, '汉武帝遣唐蒙出使夜郎，夜郎侯多同归附，开西南夷通道。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('han-pacify-southwest-yi', '汉平西南夷', 'battle', 'point', 'year', NULL, -111, 1, -1320, NULL, NULL, NULL, NULL, NULL, NULL, '汉武帝遣郭昌、卫广等伐西南夷，且兰（头兰）及邛都、莋都、冉駹、白马等国为汉所灭。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('dian-surrender-han', '滇国降汉', 'politics', 'point', 'year', NULL, -109, 1, -1296, NULL, NULL, NULL, NULL, NULL, NULL, '汉武帝元封二年，滇王尝羌率众降汉，设益州郡。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('yelang-xin-killed', '夜郎王兴被杀', 'politics', 'point', 'year', NULL, -27, 1, -312, NULL, NULL, NULL, NULL, NULL, NULL, '夜郎王兴为邛郿侯陈立所杀，夜郎国亡。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;

-- event_dynasties
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('tangmeng-tong-yelang', 'yelang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('dian-surrender-han', 'dian') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yelang-xin-killed', 'yelang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('tangmeng-tong-yelang', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('han-pacify-southwest-yi', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('dian-surrender-han', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yelang-xin-killed', 'han-west') ON CONFLICT DO NOTHING;

-- event_participants
INSERT INTO event_participants (event_id, person_id) VALUES ('tangmeng-tong-yelang', 'yelang-duotong') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('dian-surrender-han', 'dian-changqiang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yelang-xin-killed', 'yelang-xin') ON CONFLICT DO NOTHING;

-- relations
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id) VALUES ('rel-yelang-duotong-yelang-xin-succession', 'person', 'yelang-duotong', 'person', 'yelang-xin', 'succession', NULL, NULL, NULL, NULL, NULL) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id) VALUES ('rel-zhuang-qiao-dian-changqiang-succession', 'person', 'zhuang-qiao', 'person', 'dian-changqiang', 'succession', NULL, NULL, NULL, NULL, NULL) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id) VALUES ('rel-tangmeng-yelang', 'event', 'tangmeng-tong-yelang', 'dynasty', 'yelang', 'other', NULL, NULL, NULL, NULL, NULL) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id) VALUES ('rel-han-pacify-southwest-yi', 'event', 'han-pacify-southwest-yi', 'dynasty', 'han-west', 'battle', NULL, NULL, NULL, NULL, NULL) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id) VALUES ('rel-dian-surrender', 'event', 'dian-surrender-han', 'dynasty', 'dian', 'other', NULL, NULL, NULL, NULL, NULL) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id) VALUES ('rel-yelang-xin-killed', 'event', 'yelang-xin-killed', 'person', 'yelang-xin', 'other', NULL, NULL, NULL, NULL, NULL) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;

COMMIT;
