-- EraLens period import: three-kingdoms-warlord
-- Window: 208-12 .. 280-05
BEGIN;

-- cleanup
DELETE FROM event_dynasties WHERE dynasty_id IN ('yuan-hebei', 'yizhou-liu');
DELETE FROM era_names WHERE reign_id IN ('reign-cao-cao-wei', 'reign-cao-pi-king', 'reign-liu-bei-warlord', 'reign-sun-quan-warlord');
DELETE FROM relations WHERE id IN ('rel-cao-cao-cao-pi-succession', 'rel-cao-pi-cao-pi-succession', 'rel-liu-bei-liu-bei-succession', 'rel-sun-quan-sun-quan-succession');
DELETE FROM reigns WHERE id IN ('reign-yuan-shao-hebei', 'reign-liu-zhang-yizhou', 'reign-cao-cao-wei', 'reign-cao-pi-king', 'reign-liu-bei-warlord', 'reign-sun-quan-warlord');
DELETE FROM dynasties WHERE id IN ('yuan-hebei', 'yizhou-liu');

-- persons
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('cao-cao', '曹操', 155, 1, 220, 3, ARRAY['政治家','军事家','文学家'], '东汉末权臣，魏武帝（追尊），官渡之战主将。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹操"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('cao-pi', '曹丕', 187, 1, 226, 6, ARRAY['皇帝'], '曹魏开国皇帝，魏文帝，受汉献帝禅让。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹丕"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('cao-rui', '曹叡', 206, 1, 239, 1, ARRAY['皇帝'], '曹魏第二位皇帝，魏明帝；无子，传位养子曹芳。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹叡"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('liu-bei', '刘备', 161, 1, 223, 6, ARRAY['皇帝'], '蜀汉开国皇帝，昭烈帝。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘备"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('liu-shan', '刘禅', 207, 1, 271, 1, ARRAY['皇帝'], '蜀汉后主，刘备之子；263年降魏，蜀汉亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘禅"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('sun-quan', '孙权', 182, 7, 252, 5, ARRAY['皇帝'], '孙吴开国皇帝，先称吴王，后称帝。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孙权"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('zhuge-liang', '诸葛亮', 181, 1, 234, 8, ARRAY['政治家','军事家'], '蜀汉丞相，赤壁之战参与者，后主朝北伐。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/诸葛亮"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('zhou-yu', '周瑜', 175, 1, 210, 1, ARRAY['军事家'], '孙吴名将，赤壁之战主将之一。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周瑜"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yuan-shao', '袁绍', 154, 1, 202, 6, ARRAY['军阀'], '东汉末北方军阀，官渡之战曹操对手。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/袁绍"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('liu-zhang', '刘璋', 176, 1, 219, 1, ARRAY['军阀'], '益州牧，刘焉之子；引刘备入蜀后失益州，东汉末地方势力。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘璋"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;

-- dynasty_groups
INSERT INTO dynasty_groups (id, name, alt_names, scope, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, note)
VALUES ('sanguo', '三国', ARRAY[]::text[], 'cn', 220, 1, 280, 12, 2640, 3371, 'year', '220–280年三国（曹魏、蜀汉、孙吴）；狭义自曹丕代汉至晋灭吴。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, scope = EXCLUDED.scope, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, note = EXCLUDED.note;

-- dynasties
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES ('wei', '曹魏', ARRAY['魏'], 'cn', 'east_asia', 220, 12, 266, 2, 2651, 3193, 'month', 'indigo', 2651, 3193, NULL, 'sanguo', '220年曹丕受禅称帝，代汉建魏。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES ('shu', '蜀汉', ARRAY['蜀','季汉'], 'cn', 'east_asia', 221, 5, 263, 12, 2656, 3167, 'month', 'moss', NULL, NULL, NULL, 'sanguo', '221年刘备于成都称帝，国号汉，史称蜀汉。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES ('wu', '孙吴', ARRAY['吴'], 'cn', 'east_asia', 222, 10, 280, 5, 2673, 3364, 'month', 'mineral', NULL, NULL, NULL, 'sanguo', '222年孙权称吴王，229年称帝；王朝行自称王始。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;

-- reigns
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-cao-pi', 'wei', 'cao-pi', '魏文帝', '文皇帝', '高祖', NULL, 220, 12, 11, 226, 6, 29, 2651, 2717, 'day', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-cao-rui', 'wei', 'cao-rui', '魏明帝', '明皇帝', '烈祖', NULL, 226, 6, 29, 239, 1, 22, 2717, 2868, 'day', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-liu-bei', 'shu', 'liu-bei', '昭烈帝', '昭烈皇帝', '烈祖', NULL, 221, 5, 15, 223, 6, 10, 2656, 2681, 'day', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-liu-shan', 'shu', 'liu-shan', '蜀汉后主', '孝怀皇帝', NULL, NULL, 223, 6, 10, 263, 12, 23, 2681, 3167, 'day', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence)
VALUES ('reign-sun-quan', 'wu', 'sun-quan', '大皇帝', '大皇帝', '太祖', NULL, 222, 10, 19, 252, 5, 21, 2673, 3028, 'day', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence;

-- era_names
DELETE FROM era_names WHERE reign_id = 'reign-cao-pi';
DELETE FROM era_names WHERE reign_id = 'reign-cao-rui';
DELETE FROM era_names WHERE reign_id = 'reign-liu-bei';
DELETE FROM era_names WHERE reign_id = 'reign-liu-shan';
DELETE FROM era_names WHERE reign_id = 'reign-sun-quan';
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-cao-pi', '黄初', 220, 12, 226, 6, 2651, 2717, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-cao-rui', '太和', 227, 1, 233, 12, 2724, 2807, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-cao-rui', '青龙', 233, 1, 237, 12, 2796, 2855, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-cao-rui', '景初', 237, 1, 239, 1, 2844, 2868, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-bei', '章武', 221, 5, 223, 6, 2656, 2681, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-shan', '建兴', 223, 5, 237, 12, 2680, 2855, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-shan', '延熙', 238, 1, 257, 12, 2856, 3095, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-shan', '景耀', 258, 1, 263, 7, 3096, 3162, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-shan', '炎兴', 263, 8, 263, 11, 3163, 3166, 3);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-sun-quan', '黄武', 222, 10, 229, 4, 2673, 2751, 0);

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('guandu', '官渡之战', 'battle', 'point', 'month', '建安五年六月，曹操大败袁绍', 200, 6, 2405, NULL, NULL, NULL, NULL, NULL, NULL, '曹操以少胜多，大败袁绍，奠定统一北方基础。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('chibi', '赤壁之战', 'battle', 'point', 'month', '建安十三年十二月，孙刘联军大败曹操', 208, 12, 2507, NULL, NULL, NULL, NULL, NULL, NULL, '孙刘联军于赤壁大败曹操，三国鼎立格局初步形成。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('liu-bei-takes-yizhou', '刘备取益州', 'politics', 'point', 'year', '建安十九年，214年', 214, 1, 2568, NULL, NULL, NULL, NULL, NULL, NULL, '刘备围成都，刘璋出降，益州归刘备。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('yiling', '夷陵之战', 'battle', 'span', 'month', '章武元年七月至二年八月', NULL, NULL, NULL, 221, 7, 2658, 222, 8, 2671, '刘备伐吴复仇，于夷陵大败，蜀汉元气大伤。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;

-- event_dynasties
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('guandu', 'wei') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chibi', 'wei') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chibi', 'shu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chibi', 'wu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('liu-bei-takes-yizhou', 'shu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yiling', 'shu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yiling', 'wu') ON CONFLICT DO NOTHING;

-- event_participants
INSERT INTO event_participants (event_id, person_id) VALUES ('guandu', 'cao-cao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('guandu', 'yuan-shao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chibi', 'cao-cao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chibi', 'liu-bei') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chibi', 'sun-quan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chibi', 'zhuge-liang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chibi', 'zhou-yu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('liu-bei-takes-yizhou', 'liu-bei') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('liu-bei-takes-yizhou', 'liu-zhang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yiling', 'liu-bei') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yiling', 'sun-quan') ON CONFLICT DO NOTHING;

-- relations
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-cao-pi-cao-rui-succession', 'person', 'cao-pi', 'person', 'cao-rui', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-liu-bei-liu-shan-succession', 'person', 'liu-bei', 'person', 'liu-shan', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-guandu-cao-cao', 'event', 'guandu', 'person', 'cao-cao', 'battle') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-chibi-cao-cao', 'event', 'chibi', 'person', 'cao-cao', 'battle') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-chibi-zhuge', 'event', 'chibi', 'person', 'zhuge-liang', 'battle') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-yiling-liu-bei', 'event', 'yiling', 'person', 'liu-bei', 'battle') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;

COMMIT;
