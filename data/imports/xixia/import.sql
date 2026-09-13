-- EraLens period import: xixia
-- Window: 982-01 .. 1227-12
BEGIN;

-- persons
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-jiqian', '李继迁', NULL, NULL, NULL, NULL, ARRAY['君主'], '党项首领，982年叛宋自立，奠定西夏基业；追谥夏太祖。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李继迁"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-deming', '李德明', NULL, NULL, NULL, NULL, ARRAY['君主'], '李继迁之子，1004年嗣位，与宋辽修好，为李元昊称帝奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李德明"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-yuanhao', '李元昊', 1003, 1, 1048, 1, ARRAY['皇帝'], '夏景宗，1038年称帝，国号大夏，创西夏文字，屡败宋军。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李元昊"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-liangzuo', '李谅祚', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '夏毅宗，幼年即位，母没藏太后摄政，1064年亲政。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李谅祚"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-bingchang', '李秉常', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '夏惠宗，幼年即位，母梁太后摄政，与宋长期交战。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李秉常"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-qianshun', '李乾顺', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '夏崇宗，在位五十余年，西夏国力鼎盛期之一。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李乾顺"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-renxiao', '李仁孝', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '夏仁宗，推行儒学，设科举，西夏文化繁荣。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李仁孝"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-chunyou', '李纯佑', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '夏桓宗，在位十三年，蒙古势力崛起之际。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李纯佑"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-anquan', '李安全', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '夏襄宗，篡位夺嫡，1211年蒙古首次大举攻夏。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李安全"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-zunxu', '李遵顼', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '夏神宗，蒙古反复侵夏，国力日衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李遵顼"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-dewang', '李德旺', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '夏献宗，1223年嗣位，蒙古持续围攻。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李德旺"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('li-xian-xixia', '李睍', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '夏末帝，1226年即位，1227年西夏亡于蒙古。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李睍"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('mo-nang-e-pang', '没藏讹庞', NULL, NULL, NULL, NULL, ARRAY['政治家','军事家'], '西夏权臣，毅宗朝没藏太后之父，长期摄政干政。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/没藏讹庞"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('liang-taihou', '梁太后', NULL, NULL, NULL, NULL, ARRAY['后妃','政治家'], '惠宗李秉常之母，两度摄政，主张对宋用兵。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/梁太后"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;

-- dynasties
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, parent_id, note)
VALUES ('xixia', '西夏', ARRAY['大夏','党项西夏'], 'cn', 'east_asia', 982, 1, 1227, 1, 11784, 14724, 'year', 'grape', NULL, '党项李氏，982年李继迁叛宋自立；1038年李元昊称帝，国号大夏；1227年蒙古攻灭。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, note = EXCLUDED.note;

-- cleanup renamed / orphaned reigns (li-xian person id collision with 唐中宗)
DELETE FROM era_names WHERE reign_id = 'reign-li-xian-xixia-xixia';
DELETE FROM reigns WHERE id = 'reign-li-xian-xixia-xixia';

-- reigns
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-jiqian-xixia', 'xixia', 'li-jiqian', '夏太祖', '光天皇帝', '太祖', '{"kind":"temple","name":"夏太祖"}'::jsonb, 982, 1, NULL, 1004, 12, NULL, 11784, 12059, 'year', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-deming-xixia', 'xixia', 'li-deming', '西夏王', NULL, NULL, '{"kind":"regnal","name":"西夏王"}'::jsonb, 1004, 1, NULL, 1031, 12, NULL, 12048, 12383, 'year', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-yuanhao-xixia', 'xixia', 'li-yuanhao', '夏景宗', '武烈皇帝', '景宗', '{"kind":"temple","name":"夏景宗"}'::jsonb, 1031, 10, 19, 1048, 1, 19, 12381, 12576, 'day', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-liangzuo-xixia', 'xixia', 'li-liangzuo', '夏毅宗', '昭英皇帝', '毅宗', '{"kind":"temple","name":"夏毅宗"}'::jsonb, 1048, 1, 19, 1067, 9, 1, 12576, 12812, 'day', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-bingchang-xixia', 'xixia', 'li-bingchang', '夏惠宗', '昭简皇帝', '惠宗', '{"kind":"temple","name":"夏惠宗"}'::jsonb, 1067, 9, 1, 1086, 8, 21, 12812, 13039, 'day', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-qianshun-xixia', 'xixia', 'li-qianshun', '夏崇宗', '康靖皇帝', '崇宗', '{"kind":"temple","name":"夏崇宗"}'::jsonb, 1086, 8, 21, 1139, 7, 1, 13039, 13674, 'day', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-renxiao-xixia', 'xixia', 'li-renxiao', '夏仁宗', '圣德皇帝', '仁宗', '{"kind":"temple","name":"夏仁宗"}'::jsonb, 1139, 7, 1, 1193, 10, 16, 13674, 14325, 'day', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-chunyou-xixia', 'xixia', 'li-chunyou', '夏桓宗', '昭简皇帝', '桓宗', '{"kind":"temple","name":"夏桓宗"}'::jsonb, 1193, 10, 16, 1206, 2, 1, 14325, 14473, 'day', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-anquan-xixia', 'xixia', 'li-anquan', '夏襄宗', '敬穆皇帝', '襄宗', '{"kind":"temple","name":"夏襄宗"}'::jsonb, 1206, 2, 1, 1211, 9, 13, 14473, 14540, 'day', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-zunxu-xixia', 'xixia', 'li-zunxu', '夏神宗', '英武皇帝', '神宗', '{"kind":"temple","name":"夏神宗"}'::jsonb, 1211, 9, 13, 1223, 12, 17, 14540, 14687, 'day', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-dewang-xixia', 'xixia', 'li-dewang', '夏献宗', '南平王', '献宗', '{"kind":"temple","name":"夏献宗"}'::jsonb, 1223, 12, 17, 1226, 9, 17, 14687, 14720, 'day', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, claim_track, claim_label, claim_role)
VALUES ('reign-li-xian-xixia', 'xixia', 'li-xian-xixia', '夏末帝', NULL, NULL, '{"kind":"posthumous","name":"夏末帝"}'::jsonb, 1226, 9, 17, 1227, 7, 2, 14720, 14730, 'day', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role;

-- era_names
DELETE FROM era_names WHERE reign_id = 'reign-li-yuanhao-xixia';
DELETE FROM era_names WHERE reign_id = 'reign-li-qianshun-xixia';
DELETE FROM era_names WHERE reign_id = 'reign-li-renxiao-xixia';
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-li-yuanhao-xixia', '显道', 1032, 1, 1034, 12, 12384, 12419, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-li-yuanhao-xixia', '开运', 1034, 1, 1036, 12, 12408, 12443, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-li-yuanhao-xixia', '广运', 1036, 1, 1038, 12, 12432, 12467, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-li-yuanhao-xixia', '大庆', 1038, 1, 1044, 12, 12456, 12539, 3);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-li-yuanhao-xixia', '天授礼法延祚', 1044, 1, 1048, 12, 12528, 12587, 4);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-li-qianshun-xixia', '天安礼定', 1086, 1, 1089, 12, 13032, 13079, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-li-qianshun-xixia', '贞观', 1089, 1, 1139, 12, 13068, 13679, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-li-renxiao-xixia', '乾佑', 1139, 1, 1193, 12, 13668, 14327, 0);

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('xixia-li-jiqian-rebel', '李继迁叛宋', 'politics', 'point', 'year', NULL, 982, 1, 11784, NULL, NULL, NULL, NULL, NULL, NULL, '党项首领李继迁叛宋，据有夏州，西夏政权肇始。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('xixia-yuanhao-empire', '李元昊称帝', 'politics', 'point', 'year', NULL, 1038, 1, 12456, NULL, NULL, NULL, NULL, NULL, NULL, '李元昊称帝，国号大夏，定都兴庆府，与宋辽金并立。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('xixia-haoshuichuan-battle', '好水川之战', 'battle', 'point', 'year', NULL, 1040, 1, 12480, NULL, NULL, NULL, NULL, NULL, NULL, '李元昊设伏于好水川，大败宋军，宋名将任福等阵亡。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('xixia-qingli-treaty', '宋夏庆历和议', 'politics', 'point', 'year', NULL, 1044, 1, 12528, NULL, NULL, NULL, NULL, NULL, NULL, '宋夏议和，宋承认西夏帝号，岁赐银绢，双方罢兵。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;

-- event_dynasties
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xixia-li-jiqian-rebel', 'xixia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xixia-yuanhao-empire', 'xixia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xixia-haoshuichuan-battle', 'xixia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xixia-haoshuichuan-battle', 'song-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xixia-qingli-treaty', 'xixia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xixia-qingli-treaty', 'song-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('mongol-fall-xixia', 'xixia') ON CONFLICT DO NOTHING;

-- event_participants
INSERT INTO event_participants (event_id, person_id) VALUES ('xixia-li-jiqian-rebel', 'li-jiqian') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('xixia-yuanhao-empire', 'li-yuanhao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('xixia-haoshuichuan-battle', 'li-yuanhao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('xixia-qingli-treaty', 'li-yuanhao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('mongol-fall-xixia', 'li-xian-xixia') ON CONFLICT DO NOTHING;

-- relations
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-jiqian-li-deming-succession', 'person', 'li-jiqian', 'person', 'li-deming', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-deming-li-yuanhao-succession', 'person', 'li-deming', 'person', 'li-yuanhao', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-yuanhao-li-liangzuo-succession', 'person', 'li-yuanhao', 'person', 'li-liangzuo', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-liangzuo-li-bingchang-succession', 'person', 'li-liangzuo', 'person', 'li-bingchang', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-bingchang-li-qianshun-succession', 'person', 'li-bingchang', 'person', 'li-qianshun', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-qianshun-li-renxiao-succession', 'person', 'li-qianshun', 'person', 'li-renxiao', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-renxiao-li-chunyou-succession', 'person', 'li-renxiao', 'person', 'li-chunyou', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-chunyou-li-anquan-succession', 'person', 'li-chunyou', 'person', 'li-anquan', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-anquan-li-zunxu-succession', 'person', 'li-anquan', 'person', 'li-zunxu', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-zunxu-li-dewang-succession', 'person', 'li-zunxu', 'person', 'li-dewang', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-li-dewang-li-xian-xixia-succession', 'person', 'li-dewang', 'person', 'li-xian-xixia', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-xixia-yuanhao-empire', 'event', 'xixia-yuanhao-empire', 'dynasty', 'xixia', 'other') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-xixia-haoshuichuan-yuanhao', 'event', 'xixia-haoshuichuan-battle', 'person', 'li-yuanhao', 'battle') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-mongol-fall-xixia', 'event', 'mongol-fall-xixia', 'dynasty', 'xixia', 'battle') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;

COMMIT;
