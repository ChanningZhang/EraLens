-- EraLens period import: chunqiu-zhanguo
-- Window: -1046-01 .. -207-12 (Spring-Autumn & Warring States feudal states)
-- Chronology: Shiji + Wikipedia state lists
BEGIN;

-- persons
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r1', '挟', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾子挟，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾子挟"}]'::jsonb, NULL, NULL, '邾子挟')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r2', '非', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾子非，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾子非"}]'::jsonb, NULL, NULL, '邾子非')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r3', '成', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾子成，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾子成"}]'::jsonb, NULL, NULL, '邾子成')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r4', '车辅', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾子车辅，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾子车辅"}]'::jsonb, NULL, NULL, '邾子车辅')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r5', '将新', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾子将新，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾子将新"}]'::jsonb, NULL, NULL, '邾子将新')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r6', '訾父', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾子訾父，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾子訾父"}]'::jsonb, NULL, NULL, '邾子訾父')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r7', '夷父', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾武公，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾武公"}]'::jsonb, '武公', NULL, '邾武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r8', '叔术', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾子叔术，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾子叔术"}]'::jsonb, NULL, NULL, '邾子叔术')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r9', '夏父', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾子夏父，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾子夏父"}]'::jsonb, NULL, NULL, '邾子夏父')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('system-missing-ruler', '史料缺', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '史料缺，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/史料缺"}]'::jsonb, NULL, NULL, '史料缺')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r11', '克', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾子克，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾子克"}]'::jsonb, NULL, NULL, '邾子克')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r12', '琐', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾子琐，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾子琐"}]'::jsonb, NULL, NULL, '邾子琐')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r13', '蘧蒢', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾文公，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾文公"}]'::jsonb, '文公', NULL, '邾文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r14', '貜且', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾定公，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾定公"}]'::jsonb, '定公', NULL, '邾定公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r15', '牼', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾宣公，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾宣公"}]'::jsonb, '宣公', NULL, '邾宣公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r16', '华', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾悼公，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾悼公"}]'::jsonb, '悼公', NULL, '邾悼公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r17', '穿', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾庄公，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾庄公"}]'::jsonb, '庄公', NULL, '邾庄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-r18', '益', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邾隐公，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邾隐公"}]'::jsonb, '隐公', NULL, '邾隐公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zou-mu-gong', '某', ARRAY[]::text[], '曹', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '邹穆公，邹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/邹穆公"}]'::jsonb, '穆公', NULL, '邹穆公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lv-shang', '尚', ARRAY['姜子牙','姜太公','太公'], '姜', '吕', -1156, 1, -1017, 1, ARRAY['君主','军事家','政治家'], '姜太公（姜子牙），辅武王克商，封于齐。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/姜子牙"}]'::jsonb, '太公', NULL, '齐太公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r1', '伋', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐丁公（伋），姜太公之子，西周初期齐国第二代君主，前1010–前974年在位。史书记载有限，为吕伋，继太公之位守齐。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐丁公"}]'::jsonb, '丁公', NULL, '齐丁公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r2', '得', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐乙公（得），丁公之子，前973–前937年在位。丁公嫡子季子让位于弟而自食采于崔，叔乙遂继兄为君。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐乙公"}]'::jsonb, '乙公', NULL, '齐乙公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r3', '慈母', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐癸公（慈母），齐国第四代君主，前936–前900年在位。史书记载有限，世次与事迹均不详。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐癸公"}]'::jsonb, '癸公', NULL, '齐癸公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r4', '不辰', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐哀公（不辰），齐国第五代君主，前899–前863年在位。据《史记》，为弟胡公所弑，齐国政局动荡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐哀公"}]'::jsonb, '哀公', NULL, '齐哀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r5', '静', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐胡公（静），哀公之弟，前862–前860年在位。迁都薄姑不得民心，仅二年即被献公谋杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐胡公"}]'::jsonb, '胡公', NULL, '齐胡公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r6', '山', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐献公（山），胡公异母弟，前859–前851年在位。杀胡公复位营丘，结束迁都之乱，齐国重归安定。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐献公"}]'::jsonb, '献公', NULL, '齐献公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r7', '寿', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐武公（寿），献公之子，前850–前825年在位。西周齐国君主，世次承续，史书记载有限。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐武公"}]'::jsonb, '武公', NULL, '齐武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r8', '无忌', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐厉公（无忌），武公之子，前824–前816年在位。据《史记》骄恣失众，终为国人诛杀，文公继立。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐厉公"}]'::jsonb, '厉公', NULL, '齐厉公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r9', '赤', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐文公（赤），厉公被杀后即位，前815–前804年在位。史书记载有限，为齐国世系承续之君。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐文公"}]'::jsonb, '文公', NULL, '齐文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r10', '脱', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐成公（脱），文公之子，前803–前795年在位。史书记载有限，为齐国守成之君。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐成公"}]'::jsonb, '成公', NULL, '齐成公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r11', '购', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐前庄公（姜购），维基齐国君主表载在位64年（前794–前731），为齐国在位最久之君。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐庄公"}]'::jsonb, '庄公', NULL, '齐庄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r12', '禄甫', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐釐公（禄甫），庄公之子，前730–前698年在位。伐纪、伐鲁，齐国国势渐强，为襄公霸业奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐釐公"}]'::jsonb, '釐公', NULL, '齐釐公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r13', '诸儿', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐襄公（诸儿），僖公之子，前697–前686年在位。与文姜乱伦，荒于政事，终为连称、管至父弑杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐襄公"}]'::jsonb, '襄公', NULL, '齐襄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r14', '无知', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '公孙无知（无知），庄公孙、僖公庶弟仲年遗腹子，前686年在位。弑襄公自立，旋为雍廪所杀，在位仅数月。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/公孙无知"}]'::jsonb, NULL, NULL, '公孙无知')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jiang-xiaobai', '小白', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐桓公（小白），僖公之子，前685–前643年在位。任用管仲改革，尊王攘夷，九合诸侯，为春秋五霸之首。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐桓公"}]'::jsonb, '桓公', NULL, '齐桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r16', '无诡', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '公子无亏（无诡），桓公之子，前643年在位。易牙、竖刁拥立，诸公子争位，旋为国人诛杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/公子无亏"}]'::jsonb, NULL, NULL, '公子无亏')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r17', '昭', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐孝公（昭），桓公之子，郑姬所生，前642–前633年在位。宋襄公会诸侯护送回国即位，霸业已衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐孝公"}]'::jsonb, '孝公', NULL, '齐孝公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r18', '潘', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐昭公（潘），桓公之子，葛嬴所生，前632–前613年在位。杀孝公之子夺位，曾随晋文公城濮伐楚。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐昭公"}]'::jsonb, '昭公', NULL, '齐昭公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r19', '舍', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐君舍（舍），昭公之子，前613年在位。即位仅数月，为弑父之齐懿公商人所杀而亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/君舍"}]'::jsonb, NULL, NULL, '君舍')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r20', '商人', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐懿公（商人），桓公之子，前612–前609年在位。骄横好杀，因夺邴氏田邑之怨，为邴歜刺杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐懿公"}]'::jsonb, '懿公', NULL, '齐懿公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r21', '元', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐惠公（元），桓公之子，少卫姬所生，前608–前599年在位。曾避国内乱出奔卫国，后回国即位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐惠公"}]'::jsonb, '惠公', NULL, '齐惠公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r22', '无野', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐顷公（无野），惠公之子，前598–前582年在位。戏晋使引发鞍之战，后又与晋议和修好。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐顷公"}]'::jsonb, '顷公', NULL, '齐顷公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r23', '环', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐灵公（环），顷公之子，前581–前554年在位。晏婴父子相继辅政，欲废太子而立公子牙，终遭弑杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐灵公"}]'::jsonb, '灵公', NULL, '齐灵公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r24', '光', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐庄公（光），灵公之子，前553–前548年在位。与栾盈私通，为崔杼所弑，引发齐国卿族内斗。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐庄公"}]'::jsonb, '庄公', NULL, '齐庄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r25', '杵臼', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐景公（杵臼），庄公异母弟，前547–前490年在位。晏婴辅政五十八年，好奢侈厚赋，国势日衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐景公"}]'::jsonb, '景公', NULL, '齐景公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r26', '荼', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '安孺子（荼），景公幼子，前489年在位。国惠子、高昭子所立，田乞政变后即被弑，在位仅数月。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/安孺子"}]'::jsonb, NULL, NULL, '安孺子')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r27', '阳生', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐悼公（阳生），景公之子，前488–前485年在位。田乞所立，杀芮子诛大夫，后被弑，田氏专权日甚。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐悼公"}]'::jsonb, '悼公', NULL, '齐悼公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r28', '壬', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐简公（壬），悼公之子，前484–前481年在位。任用田常与阚止为相，阚止被杀，简公亦遇害。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐简公"}]'::jsonb, '简公', NULL, '齐简公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r29', '骜', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐平公（骜），简公之弟，前480–前456年在位。田成子杀简公而立之，田氏为太宰，君主沦为傀儡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐平公"}]'::jsonb, '平公', NULL, '齐平公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r30', '积', ARRAY[]::text[], '姜', '齐', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐宣公（积），平公之子，前455–前405年在位。田氏把持国政，前453年韩赵魏灭智氏，春秋步入尾声。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐宣公"}]'::jsonb, '宣公', NULL, '齐宣公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jiang-dai', '贷', ARRAY[]::text[], '姜', '齐', NULL, NULL, -379, 1, ARRAY['君主'], '齐康公（姜贷），姜齐末代。前404年继宣公；前391年田和放逐于海上，姜齐在齐君位止。前379年卒，姜太公之祀绝。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐康公"}]'::jsonb, '康公', NULL, '齐康公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('tian-he', '和', ARRAY[]::text[], '妫', '田', NULL, NULL, -384, 1, ARRAY['君主'], '田齐太公（田和）。前391年放逐齐康公自立，前386年周安王列为诸侯，史称田氏代齐。前384年卒。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/田和"}]'::jsonb, '太公', NULL, '齐太公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r33', '剡', ARRAY[]::text[], '妫', '田', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐侯剡（剡），田和之子，田氏齐国第二代君主，前383–前375年在位。后被其兄田午所杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/剡"}]'::jsonb, NULL, NULL, '剡')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r34', '午', ARRAY[]::text[], '妫', '田', NULL, NULL, NULL, NULL, ARRAY['君主'], '田齐桓公（午），田午弑兄奫位，前374–前357年在位。田氏政权稳固，齐国进入战国时代。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐桓公"}]'::jsonb, '桓公', NULL, '齐桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r35', '因齐', ARRAY[]::text[], '妫', '田', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐威王（因齐），桓公之子，前356–前320年在位。任用邹忌、田忌，悬赏纳谏，齐国大治称强。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐威王"}]'::jsonb, '威王', NULL, '齐威王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r36', '辟彊', ARRAY[]::text[], '妫', '田', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐宣王（辟彊），威王之子，前319–前301年在位。招贤延士，稷下学宫兴盛，促成合纵攻秦。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐宣王"}]'::jsonb, '宣王', NULL, '齐宣王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r37', '地', ARRAY[]::text[], '妫', '田', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐湣王（地），宣王之子，前300–前284年在位。灭宋扩土，后为燕将乐毅联合五国攻破临淄，逃亡被杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐湣王"}]'::jsonb, '湣王', NULL, '齐湣王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r38', '法章', ARRAY[]::text[], '妫', '田', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐襄王（法章），湣王庶子匿民间，前283–前265年在位。田单收复临淄，齐国复国但国力大衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐襄王"}]'::jsonb, '襄王', NULL, '齐襄王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qi-r39', '建', ARRAY[]::text[], '妫', '田', NULL, NULL, NULL, NULL, ARRAY['君主'], '齐王建（建），襄王之子，前264–前221年在位。战国末代齐君，不修战备，秦将王贲攻齐，投降而亡国。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/建"}]'::jsonb, NULL, NULL, '建')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('ji-shuyu', '虞', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '唐叔虞（虞），周成王弟，初封于唐，后改国号晋，为晋国始封君。桐叶封弟典故即指其事。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/唐叔虞"}]'::jsonb, NULL, NULL, '唐叔虞')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r1', '燮', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋侯燮（燮），唐叔虞之子，晋国第二代君主，前1006–前970年在位。改国号为晋，史书记载有限。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燮"}]'::jsonb, NULL, NULL, '燮')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r2', '宁族', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋武侯（宁族），燮之子孙，前969–前933年在位。西周晋国君主，史书记载有限。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋武侯"}]'::jsonb, '武侯', NULL, '晋武侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r3', '服人', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋成侯（服人），前932–前896年在位。西周晋国君主，世次承续，史书记载有限。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋成侯"}]'::jsonb, '成侯', NULL, '晋成侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r4', '福', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋厉侯（福），成侯之子，前895–前859年在位。出土铭文作「僰马」，墓在曲沃北赵村。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋厉侯"}]'::jsonb, '厉侯', NULL, '晋厉侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r5', '宜臼', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋靖侯（宜臼），厉侯之子，前858–前841年在位。在位末年周厉王出奔，史称共和。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋靖侯"}]'::jsonb, '靖侯', NULL, '晋靖侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r6', '司徒', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋釐侯（司徒），靖侯之子，前840–前823年在位。西周晋国君主，史书记载有限。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋釐侯"}]'::jsonb, '釐侯', NULL, '晋釐侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r7', '籍', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋献侯（籍），釐侯之子，前822–前812年在位。西周晋国世系君主，史书记载有限。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋献侯"}]'::jsonb, '献侯', NULL, '晋献侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r8', '费', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋穆侯（费），献侯之子，前811–前785年在位。生太子仇与少子成师，酿成日后曲沃之乱。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋穆侯"}]'::jsonb, '穆侯', NULL, '晋穆侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r9', '殇', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋殇叔（殇），穆侯之弟，前784–前781年在位。趁太子仇年幼夺位，后被文侯逐还。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋殇叔"}]'::jsonb, '殇叔', NULL, '晋殇叔')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r10', '仇', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋文侯（仇），穆侯太子，前780–前746年在位。助周平王东迁，周室赐弓矢，晋国始强盛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋文侯"}]'::jsonb, '文侯', NULL, '晋文侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r11', '伯', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋昭侯（伯），文侯之子，前745–前740年在位。筑曲沃城封叔父成师，曲沃坐大之始。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋昭侯"}]'::jsonb, '昭侯', NULL, '晋昭侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r12', '成师', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '曲沃桓叔（成师），穆侯少子，曲沃第一代君主，前744–前731年在位。封于曲沃，渐与晋都翼城抗衡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曲沃桓叔"}]'::jsonb, NULL, NULL, '曲沃桓叔')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r13', '平', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋孝侯（平），昭侯之子，前739–前724年在位。被曲沃庄伯派人刺杀，曲沃代翼之争加剧。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋孝侯"}]'::jsonb, '孝侯', NULL, '晋孝侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r14', '鱓', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '曲沃庄伯（鱓），桓叔之子，前730–前716年在位。弑孝侯，晋鄂侯出兵反击未成。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曲沃庄伯"}]'::jsonb, NULL, NULL, '曲沃庄伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r15', '却', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋鄂侯（却），孝侯之弟，前723–前718年在位。连年抵御曲沃庄伯，终为庄伯所弑。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋鄂侯"}]'::jsonb, '鄂侯', NULL, '晋鄂侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r16', '光', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋哀侯（光），鄂侯之子，前717–前709年在位。为曲沃武公派人刺杀于宫阙之下。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋哀侯"}]'::jsonb, '哀侯', NULL, '晋哀侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r17', '称', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '曲沃武公（称），庄伯之子，前715–前677年在位。连弑三君灭小子侯，前678年入晋都即位，完成曲沃代翼。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曲沃武公"}]'::jsonb, '曲沃武公', NULL, '曲沃武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r18', '小子', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋小子侯（小子），哀侯之子，前708–前705年在位。曲沃攻晋杀之，在位仅四年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋小子侯"}]'::jsonb, '小子侯', NULL, '晋小子侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r19', '缗', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋侯缗（缗），鄂侯之子，前704–前678年在位。曲沃武公屡攻翼城，缗被弑后曲沃代晋完成。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/缗"}]'::jsonb, NULL, NULL, '缗')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r20', '诡诸', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋献公（诡诸），曲沃武公之子，前676–前651年在位。灭桓庄之族、骊姬之乱，并国十七服国三十八。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋献公"}]'::jsonb, '献公', NULL, '晋献公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r21', '夷吾', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋惠公（夷吾），献公之子，骊姬所生，前650–前637年在位。靠秦穆公回国即位，后与秦战于韩失国。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋惠公"}]'::jsonb, '惠公', NULL, '晋惠公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r22', '圉', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋怀公（圉），惠公之子，前637年在位。趁重耳在秦欲继位，秦送重耳回国，怀公被杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋怀公"}]'::jsonb, '怀公', NULL, '晋怀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('ji-chonger', '重耳', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋文公（重耳），晋献公之子。流亡十九年后即位，城濮之战败楚，践土会盟，列为春秋五霸之一。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋文公"}]'::jsonb, '文公', NULL, '晋文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r24', '欢', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋襄公（欢），文公之子，前627–前621年在位。破秦救周，殽山败秦师，维持晋国霸业。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋襄公"}]'::jsonb, '襄公', NULL, '晋襄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r25', '夷皋', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋灵公（夷皋），襄公之子，前620–前607年在位。荒淫用佞，赵盾屡谏不果，后为赵穿所弑。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋灵公"}]'::jsonb, '灵公', NULL, '晋灵公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r26', '黑臀', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋成公（黑臀），文公少母弟，前606–前600年在位。灵公被杀后赵氏拥立，寻讨弑灵公之罪。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋成公"}]'::jsonb, '成公', NULL, '晋成公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r27', '据', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋景公（据），成公之子，前599–前581年在位。灭赵氏，邲之战败楚，但六卿势力日盛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋景公"}]'::jsonb, '景公', NULL, '晋景公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r28', '寿曼', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋厉公（寿曼），景公之子，前580–前573年在位。欲集权削六卿，为栾书、中行氏弑杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋厉公"}]'::jsonb, '厉公', NULL, '晋厉公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r29', '周', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋悼公（周），襄公曾孙，前572–前558年在位。年少即位却整饬六卿，九合诸侯，晋国复振。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋悼公"}]'::jsonb, '悼公', NULL, '晋悼公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r30', '彪', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋平公（彪），悼公之子，前557–前532年在位。会诸侯于平丘，又弭兵于宋，霸业犹存。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋平公"}]'::jsonb, '平公', NULL, '晋平公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r31', '夷', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋昭公（夷），平公之子，前531–前526年在位。六卿专权加剧，昭公终死于饥贫。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋昭公"}]'::jsonb, '昭公', NULL, '晋昭公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r32', '弃疾', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋顷公（弃疾），昭公之子，前525–前512年在位。诛伯昏咎等大夫，加速六卿兼并。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋顷公"}]'::jsonb, '顷公', NULL, '晋顷公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r33', '午', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋定公（午），顷公之子，前511–前475年在位。赵襄子灭智氏，前453年韩赵魏共灭智伯，三家分晋前奏。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋定公"}]'::jsonb, '定公', NULL, '晋定公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r34', '凿', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋出公（凿），定公之子，前474–前452年在位。欲讨伐韩赵魏反被逼迁，死于齐。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋出公"}]'::jsonb, '出公', NULL, '晋出公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r35', '骄', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋哀公（骄），出公之后，前451–前434年在位。韩赵魏瓜分晋剩余公室土地，君主名存实亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋哀公"}]'::jsonb, '哀公', NULL, '晋哀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r36', '柳', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋幽公（柳），哀公之子，前433–前416年在位。正室地位为赵氏所废，政权益为傀儡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋幽公"}]'::jsonb, '幽公', NULL, '晋幽公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r37', '止', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋烈公（止），幽公之后，前415–前389年在位。三家分晋已成定局，烈公仅守附庸之位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋烈公"}]'::jsonb, '烈公', NULL, '晋烈公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r38', '颀', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋孝公（颀），烈公之后，前388–前357年在位。魏惠王会诸侯朝天子，孝公仅为陪臣。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋孝公"}]'::jsonb, '孝公', NULL, '晋孝公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('jin-r39', '俱酒', ARRAY[]::text[], '姬', '晋', NULL, NULL, NULL, NULL, ARRAY['君主'], '晋静公（俱酒），孝公之子，前356–前349年在位。三家废晋静公，晋国六卿时代终结。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋静公"}]'::jsonb, '静公', NULL, '晋静公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r0', '绎', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '芈姓熊氏，楚国始祖。周成王封鬻熊后裔熊绎于丹阳，赐子男之田；司马迁称其与鲁共事周康王，实开荆楚之基，前1042–前1019年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊绎"}]'::jsonb, NULL, NULL, '熊绎')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r1', '艾', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '熊绎之子，楚国第二代君主。世次见于《史记·楚世家》，具体事迹史料缺载，前1018–前995年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊艾"}]'::jsonb, NULL, NULL, '熊艾')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r2', '䵣', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '楚国第三代君主，仅见世系之名，政事不见详载。年代为后世系年所推，前994–前970年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊䵣"}]'::jsonb, NULL, NULL, '熊䵣')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r3', '胜', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '楚国第四代君主，早期文献记载甚略，世次可考而无显著事迹，前969–前946年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊胜"}]'::jsonb, NULL, NULL, '熊胜')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r4', '杨', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '楚国第五代君主熊杨，世系见于《楚世家》，具体作为失载，年代为后世系年所推，前945–前922年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊杨"}]'::jsonb, NULL, NULL, '熊杨')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r5', '渠', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '楚国君主，传曾分封诸子为君后又复归一家，事迹多赖后世追述，前921–前897年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊渠"}]'::jsonb, NULL, NULL, '熊渠')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r6', '挚', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '楚国君主熊挚红，一作熊挚。世次可考，政事不见详载，前896–前873年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊挚红"}]'::jsonb, NULL, NULL, '熊挚红')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r7', '延', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '楚国君主熊延，世系所载而文献甚略，具体事迹失载，前872–前848年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊延"}]'::jsonb, NULL, NULL, '熊延')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r8', '勇', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '熊严之兄，周厉王奔彘、幽王被杀后，传其曾起兵伐周。在位九年，前847–前838年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊勇"}]'::jsonb, NULL, NULL, '熊勇')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r9', '严', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '熊勇之弟熊严，继兄位为楚君。世系可考，事迹少见详载，前837–前828年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊严"}]'::jsonb, NULL, NULL, '熊严')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r10', '霜', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '熊严之子。卒后三弟争位，仲雪死、叔堪亡濮，少弟熊徇得立，前827–前822年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊霜"}]'::jsonb, NULL, NULL, '熊霜')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r11', '徇', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '熊霜少弟熊徇，平定兄弟之争后继位。在位时郑桓公初封于郑，前821–前800年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊徇"}]'::jsonb, NULL, NULL, '熊徇')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r12', '咢', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '熊徇之子熊咢，楚国世系所载君主，事迹少见详载，前799–前791年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊咢"}]'::jsonb, NULL, NULL, '熊咢')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r13', '仪', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '芈姓，称若敖。周幽王被杀、平王东迁时在位，为楚国较早有称号之君，前790–前764年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/若敖"}]'::jsonb, NULL, NULL, '若敖')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r14', '坎', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '若敖之子熊坎，称霄敖。在位六年而卒，子熊眴（蚡冒）继立，前763–前758年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/霄敖"}]'::jsonb, NULL, NULL, '霄敖')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r15', '眴', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '霄敖之子熊眴，称蚡冒。在位十七年后，弟熊通杀其子而代立，前757–前741年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/蚡冒"}]'::jsonb, NULL, NULL, '蚡冒')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r16', '通', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '芈姓，名通。杀侄代位后自立为楚王，开诸侯僭号称王先河；连年征伐，前690年伐随途中病逝，前740–前690年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚武王"}]'::jsonb, '武王', NULL, '楚武王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r17', '赀', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '武王之子，迁都郢，灭申、邓等国，楚国始成南方大国。前675年卒，前689–前675年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚文王"}]'::jsonb, '文王', NULL, '楚文王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r18', '艰', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '文王之子熊艰，称堵敖。欲杀弟熊恽未就，五年后熊恽与随国袭杀之而自立，前674–前672年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/堵敖"}]'::jsonb, NULL, NULL, '堵敖')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r19', '恽', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '杀兄堵敖即位，曾与晋、齐争霸。前626年被太子商臣围困，自知不免而死，前671–前626年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚成王"}]'::jsonb, '成王', NULL, '楚成王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r20', '商臣', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '成王太子熊商臣，弑父自立。任用子重等，与晋争夺郑国，前625–前614年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚穆王"}]'::jsonb, '穆王', NULL, '楚穆王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('xiong-zhuang', '侣', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '穆王之子。初期韬光养晦，后励精图治；邲之战大败晋军，又曾问鼎洛邑，列春秋五霸，前613–前591年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚庄王"}]'::jsonb, '庄王', NULL, '楚庄王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r22', '审', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '庄王之子熊审，在位三十年与晋国久争，鄢陵之战败于晋，前590–前560年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚共王"}]'::jsonb, '共王', NULL, '楚共王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r23', '招', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '共王之子，国事多赖令尹子囊。在位十四年，楚国与诸侯关系趋于守成，前559–前545年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚康王"}]'::jsonb, '康王', NULL, '楚康王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r24', '员', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '康王之子熊员，称郏敖。在位仅三年，叔父熊围弑之自立，是为灵王，前544–前541年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郏敖"}]'::jsonb, NULL, NULL, '郏敖')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r25', '围', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '康王弟，弑侄郏敖即位。大修章华台、征伐诸侯；前529年弟比、子弃疾谋反，灵王自杀，前540–前529年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚灵王"}]'::jsonb, '灵王', NULL, '楚灵王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r26', '比', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '共王之子熊比，灵王弟。趁兄自杀自立，仅十余日后即被弃疾逼迫自杀，前529年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/比"}]'::jsonb, NULL, NULL, '比')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r27', '居', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '弃疾改名熊居即位，诛兄比。诬陷伍奢、杀伍子胥父兄，伍子胥逃亡吴国，前528–前516年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚平王"}]'::jsonb, '平王', NULL, '楚平王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r28', '珍', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '平王之子。伍子胥引吴军入郢，昭王出走；后复国，与陈、蔡联军败吴于颍水，前515–前489年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚昭王"}]'::jsonb, '昭王', NULL, '楚昭王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r29', '章', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '昭王之子，楚国中兴之主。灭陈、伐蔡，又立新蔡；晚年灭越国，前488–前432年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚惠王"}]'::jsonb, '惠王', NULL, '楚惠王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r30', '中', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '惠王之子熊中，在位时屡伐郑、卫等国。前408年卒，前431–前408年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚简王"}]'::jsonb, '简王', NULL, '楚简王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r31', '当', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '简王之子熊当，在位五年而卒。战国初期楚国仍列大国，前407–前402年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚声王"}]'::jsonb, '声王', NULL, '楚声王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r32', '疑', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '声王之子，用吴起变法，明审法令、裁汰冗官、开疆拓土。变法未久而卒，前401–前381年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚悼王"}]'::jsonb, '悼王', NULL, '楚悼王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r33', '臧', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '悼王之子熊臧，在位十一年，国政继吴起变法之后渐趋稳定，前380–前370年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚肃王"}]'::jsonb, '肃王', NULL, '楚肃王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r34', '良夫', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '肃王弟。在位时楚为南方强国，曾与齐宣王、秦惠文王并列称雄，前369–前340年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚宣王"}]'::jsonb, '宣王', NULL, '楚宣王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r35', '商', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '宣王之子熊商，破越、灭中山，威震江淮。前329年卒，前339–前329年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚威王"}]'::jsonb, '威王', NULL, '楚威王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r36', '槐', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '威王之子。初期用昭雎，后受张仪欺诈背齐；接见秦王于武关，客死于秦，前328–前299年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚怀王"}]'::jsonb, '怀王', NULL, '楚怀王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r37', '横', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '怀王之子，秦伐楚取汉中。白起反攻，前279年鄢郢失陷，楚国迁都陈，前298–前263年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚顷襄王"}]'::jsonb, '顷襄王', NULL, '楚顷襄王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r38', '元', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '顷襄王之子，迁都淮南寿春。封春申君黄歇为令尹，相楚二十余年，前262–前238年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚考烈王"}]'::jsonb, '考烈王', NULL, '楚考烈王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r39', '悍', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '考烈王之子熊悍，谥幽王。在位时楚国国力日衰，前237–前228年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚幽王"}]'::jsonb, '幽王', NULL, '楚幽王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r40', '犹', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '考烈王少子熊犹，幽王弟。幽王死后继立，仅数月即被兄负刍所杀，前228年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚哀王"}]'::jsonb, '哀王', NULL, '楚哀王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r41', '负刍', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '考烈王庶子，杀哀王自立。秦将王翦破楚，负刍被俘，楚国灭亡，前227–前223年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/负刍"}]'::jsonb, NULL, NULL, '负刍')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r42', '启', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '考烈王庶子熊启，曾任秦相。秦末项燕立为楚王，与秦军战于淮南而败死，前223年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昌平君"}]'::jsonb, NULL, NULL, '昌平君')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('chu-r43', '心', ARRAY[]::text[], '芈', '熊', NULL, NULL, NULL, NULL, ARRAY['君主'], '楚怀王之后熊心，项羽所立义帝。后徙郴县，被项羽遣人所弑，前208–前205年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/义帝"}]'::jsonb, NULL, NULL, '义帝')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('ji-shi', '奭', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬奭，周武王同母弟，与周公同为三公，封于燕而留治镐京。后世燕国君主皆其后裔，前1044–前1000年在位（年代约数）。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕召公"}]'::jsonb, '召公', NULL, '燕召公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r1', '克', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬克，燕召公之后，世次见于诸侯系年，事迹载记甚略，前999–前955年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/克"}]'::jsonb, NULL, NULL, '克')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r2', '旨', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬旨，燕国早期君主，史料仅见世系之名，政事不见详载，前954–前910年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/旨"}]'::jsonb, NULL, NULL, '旨')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r3', '舞', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬舞，燕国世系所载君主，政事不见详载，年代为后世系年所推，前909–前865年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/舞"}]'::jsonb, NULL, NULL, '舞')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r4', '惠侯', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥惠侯。在位时周王室渐衰，燕国事迹载录稀少，前864–前827年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕惠侯"}]'::jsonb, '惠侯', NULL, '燕惠侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r5', '庄', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '名庄，谥釐。世系可考，战国前燕国少见军事政治记载，前826–前791年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕釐侯"}]'::jsonb, '釐侯', NULL, '燕釐侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r6', '顷侯', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥顷侯。事迹在《史记·燕世家》及后世追述中甚略，前790–前767年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕顷侯"}]'::jsonb, '顷侯', NULL, '燕顷侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r7', '哀侯', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥哀侯，在位仅二年。卒后由郑侯继立，前766–前765年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕哀侯"}]'::jsonb, '哀侯', NULL, '燕哀侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r8', '郑侯', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥郑侯。相传在位三十六年，事迹载录甚略，前764–前729年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕郑侯"}]'::jsonb, '郑侯', NULL, '燕郑侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r9', '穆侯', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥穆侯，世系所载君主，政事不见详载，前728–前711年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕穆侯"}]'::jsonb, '穆侯', NULL, '燕穆侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r10', '宣侯', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥宣侯，在位十三年。春秋前期燕国仍较薄弱，前710–前698年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕宣侯"}]'::jsonb, '宣侯', NULL, '燕宣侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r11', '桓侯', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥桓侯，在位七年。事迹多见世系记载，前697–前691年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕桓侯"}]'::jsonb, '桓侯', NULL, '燕桓侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r12', '庄公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '谥庄。春秋初年齐、燕屡有战事，庄公曾击退齐军于东门，前690–前658年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕庄公"}]'::jsonb, '庄公', NULL, '燕庄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r13', '襄公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥襄公，庄公之子。在位近四十年，燕国仍居东偏小国之列，前657–前618年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕襄公"}]'::jsonb, '襄公', NULL, '燕襄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r14', '桓公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '谥桓，有两段在位：前617–前602年与前372–前362年；或为同名异君，史家有争议。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕桓公"}]'::jsonb, '桓公', NULL, '燕桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r15', '宣公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥宣公，在位十四年。春秋中期燕国仍多赖世系记载，前601–前587年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕宣公"}]'::jsonb, '宣公', NULL, '燕宣公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r16', '昭公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥昭公，在位十二年，政治军事事迹载录甚略，前586–前574年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕昭公"}]'::jsonb, '昭公', NULL, '燕昭公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r17', '武公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥武公，在位十八年，世系可考而政事少见详载，前573–前555年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕武公"}]'::jsonb, '武公', NULL, '燕武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r18', '文公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '谥文公，有两段在位：前554–前549年与前361–前333年；或为同名异君，史家说法不一。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕文公"}]'::jsonb, '文公', NULL, '燕文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r19', '懿公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥懿公，在位仅四年，事迹载录甚略，前548–前545年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕懿公"}]'::jsonb, '懿公', NULL, '燕懿公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r20', '惠公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '谥惠（春秋），曾出亡齐后复位。在位时与齐、晋多有交往，前544–前536年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕惠公"}]'::jsonb, '惠公', NULL, '燕惠公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r21', '悼公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥悼公，在位六年，事迹载录甚略，前535–前529年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕悼公"}]'::jsonb, '悼公', NULL, '燕悼公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r22', '共公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥共公，在位五年，事迹载录甚略，前528–前524年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕共公"}]'::jsonb, '共公', NULL, '燕共公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r23', '平公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥平公，在位十九年，事迹载录甚略，前523–前505年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕平公"}]'::jsonb, '平公', NULL, '燕平公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r24', '简公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '谥简（春秋），在位十二年，前504–前493年在位；与战国燕简公为不同君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕简公"}]'::jsonb, '简公', NULL, '燕简公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r25', '桓', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '名桓，谥孝。在位三十七年，战国初期燕国仍偏处东北，前492–前455年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕孝公"}]'::jsonb, '孝公', NULL, '燕孝公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r26', '戴', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬戴，谥成公。在位十六年，事迹载录甚略，前454–前439年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕成公"}]'::jsonb, '成公', NULL, '燕成公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r27', '闵公', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥闵公，在位二十四年，事迹载录甚略，前438–前415年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕闵公"}]'::jsonb, '闵公', NULL, '燕闵公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r28', '载', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '名载，谥简（战国）。在位四十余年，前414–前373年；后被桓公二世所代。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕简公"}]'::jsonb, '简公', NULL, '燕简公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r31', '易王', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬姓，谥易王，文公之后。在位时燕与齐争，事迹载于战国史料，前332–前321年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕易王"}]'::jsonb, '易王', NULL, '燕易王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r32', '哙', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬哙，无谥。听信邹子之等，禅位于相子之，引发内乱，齐国田章破燕，哙死，前320–前314年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哙"}]'::jsonb, NULL, NULL, '哙')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r33', '职', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬职，燕王哙庶兄。流落赵国后复国即位；用乐毅、邹衍等，合五国伐齐，占齐七十余城，前312–前279年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕昭王"}]'::jsonb, '昭王', NULL, '燕昭王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r34', '惠王', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '谥惠（战国）。疑乐毅而召还，乐毅奔赵；后与齐、秦较量，前278–前271年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕惠王"}]'::jsonb, '惠王', NULL, '燕惠王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r35', '讙', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬讙，谥武成。在位十二年，燕国国力经昭惠之后已不如前，前270–前258年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕武成王"}]'::jsonb, '武成王', NULL, '燕武成王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r36', '遇', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬遇，谥孝王（战国）。在位仅三年，事迹载录甚略，前257–前255年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/燕孝王"}]'::jsonb, '孝王', NULL, '燕孝王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yan-r37', '喜', ARRAY[]::text[], '姬', '匽', NULL, NULL, NULL, NULL, ARRAY['君主'], '姬喜，无谥。秦将王翦、李信攻燕，喜逃亡辽东，后被俘处死，燕亡，前254–前222年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/喜"}]'::jsonb, NULL, NULL, '喜')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-weizi', '启', ARRAY['微子','微子启'], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '微子启，帝乙长子、帝辛庶兄。数谏不听而亡奔，周封之于宋，为宋国始封君。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/微子"}]'::jsonb, NULL, NULL, '微子')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r1', '衍', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '微子启之弟，继兄镇守宋地，为西周时期宋国第二代国君，世次见《史记·宋微子世家》。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/微仲"}]'::jsonb, NULL, NULL, '微仲')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r2', '稽', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '微仲之后，宋国早期君主，世次承续而事迹疏略，属西周中叶宋国世君，殷商后裔封国之一。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/稽"}]'::jsonb, NULL, NULL, '稽')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r3', '申', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '宋国第三代君主，谥丁公，在位约二十四年，承微子之封，为西周时期宋国世系中继之君。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋丁公"}]'::jsonb, '丁公', NULL, '宋丁公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r4', '共', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '丁公之后，谥湣公，在位约二十四年，宋国早期君主，除世次外史料仅存于《史记·宋微子世家》。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋湣公"}]'::jsonb, '湣公', NULL, '宋湣公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r5', '熙', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '湣公之子，谥炀公，在位约二十四年，《史记》载为伯振之父，世系承续宋国嫡系，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋炀公"}]'::jsonb, '炀公', NULL, '宋炀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r6', '鲋祀', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '炀公之弟鲋祀弑兄自立，谥厉公，在位约二十六年，终为兄子纠所杀，宋国再陷内争，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋厉公"}]'::jsonb, '厉公', NULL, '宋厉公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r7', '举', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '纠弑厉公后立，谥釐公，在位约二十八年，复正嫡系，为宋国西周后期重要世君，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋釐公"}]'::jsonb, '釐公', NULL, '宋釐公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r8', '覵', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '釐公之子，谥惠公，在位三十余年，属西周晚期宋国君主，事迹除世次外记载有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋惠公"}]'::jsonb, '惠公', NULL, '宋惠公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r9', '哀公', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '惠公之子，谥哀公，在位仅一年即卒，为宋国世系中罕见的极短祚君主，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋哀公"}]'::jsonb, '哀公', NULL, '宋哀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r10', '白', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '哀公之子，谥戴公，在位三十四年，为春秋初年以前宋国在位时间较长之君，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋戴公"}]'::jsonb, '戴公', NULL, '宋戴公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r11', '司空', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '戴公之子司空，谥武公，在位十八年，承续宋国嫡系，事迹记载疏略，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋武公"}]'::jsonb, '武公', NULL, '宋武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r12', '力', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '武公之子，谥宣公，欲传位弟穆公和，临终仍以长子与夷嗣位，开宋国传弟之先河，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋宣公"}]'::jsonb, '宣公', NULL, '宋宣公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r13', '和', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '宣公弟子和，为报兄恩拒受传位，后受托孤而立殇公与夷，穆公托孤酿成日后政乱，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋穆公"}]'::jsonb, '穆公', NULL, '宋穆公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r14', '与夷', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '宣公长子与夷，年幼继位谥殇公，大夫华元弑君并杀孔父嘉，立庄公冯，孔父之难由此而起。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋殇公"}]'::jsonb, '殇公', NULL, '宋殇公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r15', '冯', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '弑殇公自立，乘丘之战败鲁军、擒南宫长万又释归，前692年因博戏争执，为万弑于蒙泽。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋庄公"}]'::jsonb, '庄公', NULL, '宋庄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r16', '捷', ARRAY[]::text[], '子', '宋', NULL, NULL, -682, 1, ARRAY['君主'], '宋闵公（子捷），宋庄公之子，前691–前682年在位。与鲁多次交战，乘丘之役鲁擒南宫万后释归；因猎博与万争执，前682年为南宫长万所弑于蒙泽。万立子游，诸公子杀子游而立弟御说为宋桓公。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋闵公"}]'::jsonb, '湣公', NULL, '宋湣公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r17', '游', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '南宫长万弑闵公后立公子游，旋即为诸公子攻杀，在位仅数月，宋国政局再度动荡，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/游"}]'::jsonb, NULL, NULL, '游')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r18', '御说', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '闵公弟御说杀子游自立，谥桓公，会盟诸侯、援齐灭郕，使宋国在春秋初年渐成东方强国。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋桓公"}]'::jsonb, '桓公', NULL, '宋桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r19', '兹甫', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '桓公次子兹甫，谥襄公，泓水之战坚持不击半渡、不擒二毛而败于楚，部分史料列为春秋五霸之一。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋襄公"}]'::jsonb, '襄公', NULL, '宋襄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r20', '王臣', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '襄公之子王臣，谥成公，即位后大夫华氏作乱，赖晋救宋方得平定，在位约十七年，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋成公"}]'::jsonb, '成公', NULL, '宋成公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r21', '御', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '成公弟御弑兄自立，旋即为大夫攻杀，在位仅一年，宋国再度因篡弑而政局不稳，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/御"}]'::jsonb, NULL, NULL, '御')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r22', '杵臼', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '成公之子杵臼，谥昭公，在位八年，其弟鲍革结党弑兄自立，为文公夺位之先声，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋昭公"}]'::jsonb, '昭公', NULL, '宋昭公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r23', '鲍革', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '鲍革弑兄昭公自立，谥文公，任用公子鲍为政，与楚国结盟，在位约二十一年，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋文公"}]'::jsonb, '文公', NULL, '宋文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r24', '瑕', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '文公之子瑕，谥共公，在位十二年，承续文公政局，宋国已渐失春秋强国地位，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋共公"}]'::jsonb, '共公', NULL, '宋共公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r25', '成', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '共公之子成，谥平公，在位四十三年，为宋国在位最久之君之一，《左传》多有提及，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋平公"}]'::jsonb, '平公', NULL, '宋平公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r26', '佐', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '平公之子佐，谥元公，前517年欲乐氏融通晋援，遭华氏之党攻杀，在位约十四年，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋元公"}]'::jsonb, '元公', NULL, '宋元公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r27', '头曼', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '元公之子头曼，谥景公，在位四十七年，倚仗大夫谐音能，国政日衰而内乱仍频，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋景公"}]'::jsonb, '景公', NULL, '宋景公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r28', '特', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '宋昭公（子特），前469–前404年在位。《史记·宋微子世家》另有前422年卒异说。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋昭公特"}]'::jsonb, '昭公', NULL, '宋昭公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r29', '购由', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '战国初君主，谥悼公，在位约十九年，宋国已沦为中小诸侯，事迹除世次外记载有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋悼公"}]'::jsonb, '悼公', NULL, '宋悼公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r30', '田', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '悼公之子田，谥休公，在位约二十一年，属战国早期宋国世君，国势卑微，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋休公"}]'::jsonb, '休公', NULL, '宋休公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r31', '辟兵', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '休公之子辟兵，谥桓公，在位六年，与春秋宋桓公易混，为战国中期短暂在位之君，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋桓公"}]'::jsonb, '桓公', NULL, '宋桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r32', '喜', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '宋剔成君，本名戴喜，字子罕。司城子罕篡位，约前355–前329年在位，无谥号。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/剔成君"}]'::jsonb, NULL, NULL, '剔成君')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('song-r33', '偃', ARRAY[]::text[], '子', '宋', NULL, NULL, NULL, NULL, ARRAY['君主'], '剔成之弟偃废兄自立，僭号称王，灭滕伐薛、屡攻齐魏，前286年为齐湣王所灭，宋国亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋康王"}]'::jsonb, '康王', NULL, '宋康王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('bo-qin', '伯禽', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '周公旦之子，周成王封于鲁为开国君主，帅师洙泗、修礼乐，治理鲁国约四十五年，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/伯禽"}]'::jsonb, NULL, NULL, '伯禽')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r1', '酋', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '伯禽之子酋，谥考公，在位四年，为鲁国第二代君主，世次见《史记·鲁周公世家》，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁考公"}]'::jsonb, '考公', NULL, '鲁考公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r2', '熙', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '考公弟熙弑兄自立，谥炀公，在位六年，为鲁国早期因篡弑更迭之例，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁炀公"}]'::jsonb, '炀公', NULL, '鲁炀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r3', '宰', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '炀公之子宰，谥幽公，在位十四年，承续鲁国嫡系，西周时期事迹记载疏略，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁幽公"}]'::jsonb, '幽公', NULL, '鲁幽公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r4', '晞', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '幽公之子晞，谥魏公，在位近五十年，为鲁国西周时期在位时间较长之君，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁魏公"}]'::jsonb, '魏公', NULL, '鲁魏公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r5', '擢', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '魏公之子擢，谥厉公，在位三十七年，属西周晚期鲁国君主，除世次外史料有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁厉公"}]'::jsonb, '厉公', NULL, '鲁厉公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r6', '具', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '厉公之子具，谥献公，在位约三十二年，承续鲁国世系，事迹记载甚少，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁献公"}]'::jsonb, '献公', NULL, '鲁献公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r7', '濞', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '献公之子濞，谥真公，在位约三十年，为春秋以前鲁国世君之一，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁真公"}]'::jsonb, '真公', NULL, '鲁真公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r8', '敖', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '真公之子敖，谥武公，在位九年，承续鲁国嫡系，事迹除世次外记载有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁武公"}]'::jsonb, '武公', NULL, '鲁武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r9', '戏', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '武公之子戏，谥懿公，在位九年，后被侄伯御所弑，鲁国再度陷入内争，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁懿公"}]'::jsonb, '懿公', NULL, '鲁懿公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r10', '伯御', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '懿公侄伯御弑君自立，在位十一年，前796年周宣王命鲁人杀伯御，立孝公称复位，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/伯御"}]'::jsonb, NULL, NULL, '伯御')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r11', '称', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '武公之子称，谥孝公，周宣王命杀伯御后立之，在位近三十年，鲁国政局复归嫡系，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁孝公"}]'::jsonb, '孝公', NULL, '鲁孝公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r12', '弗涅', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '孝公之子弗涅，谥惠公，在位四十六年，娶孟子无子，继室声子生隐公，仲子生桓公，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁惠公"}]'::jsonb, '惠公', NULL, '鲁惠公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r13', '息姑', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '惠公庶长子息姑，谥隐公，因弟允年幼而摄政，《春秋》纪年起于此，前712年为羽父所弑。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁隐公"}]'::jsonb, '隐公', NULL, '鲁隐公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r14', '允', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '惠公嫡子允，谥桓公，隐公遇弑后继位，会盟诸侯，前694年赴齐，为齐襄公所杀，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁桓公"}]'::jsonb, '桓公', NULL, '鲁桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r15', '同', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '桓公嫡子同，谥庄公，即位初年谷丘败齐，长期与齐、晋周旋，在位三十一年，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁庄公"}]'::jsonb, '庄公', NULL, '鲁庄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r16', '启', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '庄公之子启，谥闵公，在位仅两年，庆父作乱，先后弑闵公与桓公庶子，鲁国几近亡国，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁闵公"}]'::jsonb, '闵公', NULL, '鲁闵公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r17', '申', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '庄公嫡子申，谥釐公，季友立之复位，先后败齐、败宋，在位三十二年，奠定鲁中期局势。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁釐公"}]'::jsonb, '釐公', NULL, '鲁釐公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r18', '兴', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '釐公之子兴，谥文公，在位十八年，任用季孙、孟孙、叔孙，三桓势力渐盛，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁文公"}]'::jsonb, '文公', NULL, '鲁文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r19', '馁', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '文公之子馁，谥宣公，襄仲弑文公而立之，逆天乱常，三桓专权之势由此加剧，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁宣公"}]'::jsonb, '宣公', NULL, '鲁宣公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r20', '黑肱', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '宣公之子黑肱，谥成公，在位十八年，与晋、齐会盟，鲁国已渐为大国附庸，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁成公"}]'::jsonb, '成公', NULL, '鲁成公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r21', '午', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '成公之子午，谥襄公，在位三十年，三桓专国，鲁政日衰，《春秋》后期多载其会盟，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁襄公"}]'::jsonb, '襄公', NULL, '鲁襄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r22', '野', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '襄公之子野，未得谥号，即位同年赴田而死，为鲁国罕见的即位即卒之君，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/君野"}]'::jsonb, NULL, NULL, '君野')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r23', '稠', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '襄公之子稠，谥昭公，在位三十一年，遭三桓逼迫出奔，先后流亡齐、晋，终死于国外，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁昭公"}]'::jsonb, '昭公', NULL, '鲁昭公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r24', '宋', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '昭公之弟宋，谥定公，在位十四年，孔子自卫返鲁在其任内，鲁国礼乐稍得修明，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁定公"}]'::jsonb, '定公', NULL, '鲁定公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r25', '将', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '定公之子将，谥哀公，在位二十七年，孔子卒于其治世，鲁国已完全为三桓所挟持，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁哀公"}]'::jsonb, '哀公', NULL, '鲁哀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r26', '宁', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '哀公之子宁，谥悼公，在位三十年，战国初鲁国君主，国势衰微，事迹记载有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁悼公"}]'::jsonb, '悼公', NULL, '鲁悼公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r27', '嘉', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '悼公之子嘉，谥元公，在位二十年，属战国早期鲁国世君，除世次外史料疏略，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁元公"}]'::jsonb, '元公', NULL, '鲁元公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r28', '显', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '元公之子显，谥穆公，在位三十二年，战国中期鲁国君主，国势已沦为小国，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁穆公"}]'::jsonb, '穆公', NULL, '鲁穆公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r29', '奋', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '穆公之子奋，谥共公，在位三十年，承续鲁国世系，事迹除世次外记载甚少，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁共公"}]'::jsonb, '共公', NULL, '鲁共公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r30', '屯', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '共公之子屯，谥康公，在位九年，战国中期鲁国短暂在位之君，国势已十分卑微，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁康公"}]'::jsonb, '康公', NULL, '鲁康公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r31', '匽', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '康公之子匽，谥景公，在位二十年，战国中后期鲁国君主，国势卑微，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁景公"}]'::jsonb, '景公', NULL, '鲁景公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r32', '叔', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '景公之子叔，谥平公，在位十九年，承续鲁国世系，事迹记载有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁平公"}]'::jsonb, '平公', NULL, '鲁平公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r33', '贾', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '平公之子贾，谥文公，在位二十三年，与顷公易混，为战国晚期鲁国世君之一，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁文公"}]'::jsonb, '文公', NULL, '鲁文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-r34', '仇', ARRAY[]::text[], '姬', '鲁', NULL, NULL, NULL, NULL, ARRAY['君主'], '文公之子仇，谥顷公，鲁国末代君主，前256年秦灭周，顷公附楚，前249年楚灭鲁。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲁顷公"}]'::jsonb, '顷公', NULL, '鲁顷公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r0', '封', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '周武王弟封，康叔，封于卫镇抚殷遗民，为卫国开国君主，世系为周王室同姓分支，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫康叔"}]'::jsonb, '康叔', NULL, '卫康叔')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r1', '代', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '康叔之子代，谥康伯，继父镇守卫地，为西周早期卫国第二代国君，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫康伯"}]'::jsonb, '康伯', NULL, '卫康伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r2', '考伯', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '康伯之后，谥考伯，西周时期卫国君主，世次承续而事迹记载疏略，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫考伯"}]'::jsonb, '考伯', NULL, '卫考伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r3', '嗣伯', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '考伯之后，谥嗣伯，西周时期卫国世君，除世次外史料记载甚少，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫嗣伯"}]'::jsonb, '嗣伯', NULL, '卫嗣伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r4', '疌伯', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '嗣伯之后，谥疌伯，西周时期卫国君主，世次见《史记·卫康叔世家》，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫疌伯"}]'::jsonb, '疌伯', NULL, '卫疌伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r5', '靖伯', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '疌伯之后，谥靖伯，西周时期卫国世君，承续姬姓卫国之嫡系，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫靖伯"}]'::jsonb, '靖伯', NULL, '卫靖伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r6', '贞伯', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '靖伯之后，谥贞伯，西周晚期卫国君主，在位约二十四年，事迹记载有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫贞伯"}]'::jsonb, '贞伯', NULL, '卫贞伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r7', '顷侯', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '贞伯之子，谥顷侯，曾遭戎狄侵扰，卫国在西周晚期国势一度不振，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫顷侯"}]'::jsonb, '顷侯', NULL, '卫顷侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r8', '釐侯', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '顷侯之子，谥釐侯，在位四十余年，为春秋以前卫国在位时间较长之君，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫釐侯"}]'::jsonb, '釐侯', NULL, '卫釐侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r9', '余', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '釐侯之子余，谥共伯，在位仅一年即为弟武公和所弑，卫国再度因篡弑更迭，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫共伯"}]'::jsonb, '共伯', NULL, '卫共伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r10', '和', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '卫武公（姬和），《史记·卫世家》载前812–前758年在位，共55年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫武公"}]'::jsonb, '武公', NULL, '卫武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r11', '扬', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '武公之子扬，谥庄公，宠妾生子州吁，好兵使将，石碏谏不听，乱端由此酝酿，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫庄公"}]'::jsonb, '庄公', NULL, '卫庄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r12', '完', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '庄公嫡子完，谥桓公，州吁骄奢被绌而出奔，前719年为州吁袭杀，在位十五年，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫桓公"}]'::jsonb, '桓公', NULL, '卫桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r13', '州吁', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '庄公庶子州吁，好兵弑兄自立，联合宋、陈、蔡伐郑，旋即为石碏诱杀于濮，在位仅数月。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/州吁"}]'::jsonb, NULL, NULL, '州吁')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r14', '晋', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '桓公弟晋，谥宣公，筑台华周、夺世子妻，杀急子于齐，又逐惠公朔，卫国纲纪大乱，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫宣公"}]'::jsonb, '宣公', NULL, '卫宣公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r15', '朔', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '宣公之子朔，谥惠公，宣公杀急子后立之，一度出奔，赖齐复位，前后两段子在位，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫惠公"}]'::jsonb, '惠公', NULL, '卫惠公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r16', '黔牟', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '惠公出奔期间，周平王立弟黔牟，在位八年，惠公赖齐复位后，黔牟出奔周，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/黔牟"}]'::jsonb, NULL, NULL, '黔牟')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r18', '赤', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '惠公之子赤，谥懿公，好鹤淫乐、不修政理，前660年狄人攻卫，懿公兵败被杀，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫懿公"}]'::jsonb, '懿公', NULL, '卫懿公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r19', '申', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '懿公弟申，谥戴公，狄乱中即位仅数日即卒，卫国几近亡国，为极短祚之君，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫戴公"}]'::jsonb, '戴公', NULL, '卫戴公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r20', '毁', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '戴公弟毁，谥文公，狄乱后自齐归国立国，修政理民，使卫国得以复存，在位二十五年，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫文公"}]'::jsonb, '文公', NULL, '卫文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r21', '郑', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '卫成公（姬郑）。前634年即位，出奔后弟卫君瑕代立，僖公三十年复位，前600年卒。维基分两次在位（前634–前632、前632–前600）；年桶以卫君瑕占前632年，复位段逾年改元起前631年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫成公"}]'::jsonb, '成公', NULL, '卫成公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r22', '瑕', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '成公弟瑕，未得谥号，晋助成公复位期间立之，在位仅一年即为成公所复，史称卫君瑕，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/君瑕"}]'::jsonb, NULL, NULL, '君瑕')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r23', '遫', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '成公之子遫，谥穆公，在位十一年，承续文公以来复国之局，事迹记载有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫穆公"}]'::jsonb, '穆公', NULL, '卫穆公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r24', '臧', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '穆公之子臧，谥定公，在位十二年，春秋中期卫国君主，除世次外史料疏略，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫定公"}]'::jsonb, '定公', NULL, '卫定公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r25', '衎', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '定公之子衎，谥献公，孙林父、宁殖作乱，一度出奔，后复位，前后两段子在位，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫献公"}]'::jsonb, '献公', NULL, '卫献公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r26', '秋', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '献公出奔期间，孙林父立弟秋，谥殇公，在位十二年，献公后赖晋复位，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫殇公"}]'::jsonb, '殇公', NULL, '卫殇公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r28', '恶', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '献公之子恶，谥襄公，在位九年，承续献公复位后的政局，事迹记载有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫襄公"}]'::jsonb, '襄公', NULL, '卫襄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r29', '元', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '襄公之子元，谥灵公，在位四十二年，夫人南子执政，孔子曾见之，拒立嫡子蒯聵，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫灵公"}]'::jsonb, '灵公', NULL, '卫灵公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r30', '辄', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '灵公孙辄，谥出公，灵公拒立父蒯聵而立辄，引发父子争国，前后两段子在位，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫出公"}]'::jsonb, '出公', NULL, '卫出公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r31', '蒯聩', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '灵公嫡子蒯聵，谥庄公，因得罪南子出奔，赖晋、赵氏返国夺位，在位仅两年，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫庄公"}]'::jsonb, '庄公', NULL, '卫庄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r32', '斑师', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '庄公之子斑师，未得谥号，庄公卒后继位，旋即为卫君起所弑，在位仅数月，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/斑师"}]'::jsonb, NULL, NULL, '斑师')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r33', '起', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '灵公后裔起，未得谥号，弑斑师自立，在位仅一年即为出公辄所杀，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/君起"}]'::jsonb, NULL, NULL, '君起')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r35', '黔', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '出公之叔黔，谥悼公，在位五年，出公辄被逐后即位，事迹除世次外记载有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫悼公"}]'::jsonb, '悼公', NULL, '卫悼公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r36', '弗', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '悼公之子弗，谥敬公，在位三十三年，战国初卫国君主，国势已衰，事迹疏略，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫敬公"}]'::jsonb, '敬公', NULL, '卫敬公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r37', '纠', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '敬公之子纠，谥昭公，在位六年，旋即为叔怀公所弑，卫国再度因篡弑更迭，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫昭公"}]'::jsonb, '昭公', NULL, '卫昭公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r38', '亶', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '昭公之叔亶，弑侄自立，谥怀公，在位十一年，为战国早期卫国篡弑之例，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫怀公"}]'::jsonb, '怀公', NULL, '卫怀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r39', '颓', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '怀公之子颓，谥慎公，在位三十二年，战国中期卫国君主，国势卑微，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫慎公"}]'::jsonb, '慎公', NULL, '卫慎公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r40', '训', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '慎公之子训，谥声公，在位十一年，承续卫国世系，事迹记载有限，事见《史记》本国世家记载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫声公"}]'::jsonb, '声公', NULL, '卫声公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r41', '遫', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '卫成侯（姬遫），卫声公之子，前371–前343年在位。前346年卫国自贬为侯，臣服韩、赵、魏。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫成侯"}]'::jsonb, '成侯', NULL, '卫成侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r42', '劲', ARRAY[]::text[], '姬', '子南', NULL, NULL, NULL, NULL, ARRAY['君主'], '卫平侯（姬劲），姬姓子南氏，卫灵公少子公子郢之后；前342–前335年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫平侯"}]'::jsonb, '平侯', NULL, '卫平侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r43', '？', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '卫嗣君，本名失考，前334–前293年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫嗣君"}]'::jsonb, '嗣君', NULL, '嗣君')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r44', '？', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '卫怀君，本名失考，前292–前254年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫怀君"}]'::jsonb, '怀君', NULL, '怀君')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r45', '？', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '卫元君，姬姓子南氏，本名失考，前254–前230年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫元君"}]'::jsonb, '元君', NULL, '元君')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('weiguo-r46', '角', ARRAY[]::text[], '姬', '卫', NULL, NULL, NULL, NULL, ARRAY['君主'], '卫国末代君主，未得谥号，前209年秦废卫君角为庶人，卫国至此灭亡，比秦统一早九年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/君角"}]'::jsonb, NULL, NULL, '君角')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r0', '友', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '周宣王封弟友于郑，任周室司徒。前771年犬戎陷镐京，桓公遇害，子掘突继位为武公，郑国迁于中原。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑桓公"}]'::jsonb, '桓公', NULL, '郑桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r1', '掘突', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '助平王东迁，与母申侯共灭申国。灭东虢、郐等国，郑国由畿内诸侯转为中原大国，奠定霸业基础。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑武公"}]'::jsonb, '武公', NULL, '郑武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r2', '寤生', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '春秋初年第一强国，与周王室「交质」交战。兼并小国、侵夺许国，「多行不义必自毙」典出其事。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑庄公"}]'::jsonb, '庄公', NULL, '郑庄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r3', '忽', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '庄公嫡长子，曾作人质于周。两度即位，复位不久即为大夫所弑，郑国内乱加剧，国势转衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑昭公"}]'::jsonb, '昭公', NULL, '郑昭公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r4', '突', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '庄公庶子，曾流亡宋国被立为君。两度执政，终为夫人与大夫所弑，政局动荡，郑国衰落。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑厉公"}]'::jsonb, '厉公', NULL, '郑厉公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r6', '子亹', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '厉公之子，在位仅七月。政局动荡，旋即被杀，郑国权力更迭频繁，无力维持稳定。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/子亹"}]'::jsonb, NULL, NULL, '子亹')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r7', '婴', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '厉公幼子，在位十四年。厉公死后复位，国势已远不如庄公时的鼎盛局面，郑国渐衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/子婴"}]'::jsonb, NULL, NULL, '子婴')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r9', '踕', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位四十五年，屡侵许国、干预诸侯。曾逐太子建与重耳，招致晋国日后伐郑，国势受损。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑文公"}]'::jsonb, '文公', NULL, '郑文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r10', '子兰', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '文公之子，灵公之弟。弑兄即位，在列国间周旋，维系郑国在中原的存续，国势尚可。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑穆公"}]'::jsonb, '穆公', NULL, '郑穆公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r11', '子夷', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '穆公之子，在位仅一年。因戏弄大夫子家猗指，被弑而亡，郑国再陷内乱，政局不稳。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑灵公"}]'::jsonb, '灵公', NULL, '郑灵公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r12', '子坚', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '灵公之弟，弑兄自立。楚国伐郑，襄公求和割地，郑国国势日衰，仰息于强邻。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑襄公"}]'::jsonb, '襄公', NULL, '郑襄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r13', '沸', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位不足两年，遭兄釐公内乱而被弑，郑国政局继续动荡不安，无力外争。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑悼公"}]'::jsonb, '悼公', NULL, '郑悼公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r14', '睔', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '执政期间郑国夹缝于晋楚之间，多次遣使盟楚，在列国间艰难周旋求存，国势渐弱。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑成公"}]'::jsonb, '成公', NULL, '郑成公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-gongzi-xu', '繻', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '郑成公被晋扣留期间，前581年三月由子如拥立；四月郑人杀繻，改立髡顽。仅短暂在位，见《左传·成公十年》。', '[{"label":"左传·成公十年","url":"https://ctext.org/chun-qiu-zuo-zhuan/cheng-gong-shi-nian/zhs"}]'::jsonb, NULL, NULL, '公子繻')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r15', '恽', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位五年而卒，末代君主中郑国局面尚可维持，但已无力争霸，仰息于晋楚。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑釐公"}]'::jsonb, '釐公', NULL, '郑釐公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r16', '嘉', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位三十五年，郑国已沦为二流小国，仰息于晋楚等强邻之间，无力外争。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑简公"}]'::jsonb, '简公', NULL, '郑简公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r17', '宁', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '孔子弟子子产执政之年，修城施政、作刑鼎，郑国稍得整顿，国势略有回升。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑定公"}]'::jsonb, '定公', NULL, '郑定公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r18', '趸', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '定公之弟，弑兄自立。在位十二年而亡，郑国继续衰落，无力维持大国地位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑献公"}]'::jsonb, '献公', NULL, '郑献公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r19', '胜', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位三十八年，郑国名存实亡，仅守新郑一地，无力外争，仰息于韩等强邻。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑声公"}]'::jsonb, '声公', NULL, '郑声公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r20', '易', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位仅七年，为共公之弟所弑，郑国内乱不止，国势奄奄一息。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑哀公"}]'::jsonb, '哀公', NULL, '郑哀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r21', '丑', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位三十年，郑国式微，无力外争，仰息于韩等强邻，维持小国局面。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑共公"}]'::jsonb, '共公', NULL, '郑共公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r22', '已', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位不足一年，为𦈡公所弑，郑国濒临灭亡，政局极度动荡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑幽公"}]'::jsonb, '幽公', NULL, '郑幽公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r23', '骀', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '弑幽公自立，在位二十七年。郑国已濒临灭亡，无力抵抗韩国，国势危急。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑𦈡公"}]'::jsonb, '𦈡公', NULL, '郑𦈡公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zheng-r24', '乙', ARRAY[]::text[], '姬', '郑', NULL, NULL, NULL, NULL, ARRAY['君主'], '郑国末代君主。前375年为韩武子所灭，国亡，郑国历史终结，姬姓郑国不复存在。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑康公"}]'::jsonb, '康公', NULL, '郑康公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r0', '振铎', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '周武王弟，受封于曹。为曹国始祖，西周初年立国，封地在今山东定陶一带，国势平稳。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/叔振铎"}]'::jsonb, NULL, NULL, '叔振铎')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r1', '脾', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '曹国第二代君主，太伯。西周时期在位，史料记述较少，事迹不详，维持小国局面。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹太伯"}]'::jsonb, '太伯', NULL, '曹太伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r2', '平', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '曹国第三代君主，仲君。西周时期在位，事迹不详，国势平平，无力外争。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/仲君"}]'::jsonb, NULL, NULL, '仲君')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r3', '侯', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '曹国第四代君主，宫伯。西周时期在位，事迹不详，维持小国局面，国势平稳。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹宫伯"}]'::jsonb, '宫伯', NULL, '曹宫伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r4', '云', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '曹国第五代君主，孝伯。西周时期在位，事迹不详，国力平平，维持小国。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹孝伯"}]'::jsonb, '孝伯', NULL, '曹孝伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r5', '喜', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '曹国第六代君主，夷伯。西周至春秋初年在位，事迹不详，国势平平。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹夷伯"}]'::jsonb, '夷伯', NULL, '曹夷伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r6', '彊', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '曹国第七代君主，幽伯。在位时间较短，事迹不详，国势平平，无力外争。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹幽伯"}]'::jsonb, '幽伯', NULL, '曹幽伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r7', '苏', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '曹国第八代君主，戴伯。春秋初年在位，事迹不详，维持小国局面，国势平稳。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹戴伯"}]'::jsonb, '戴伯', NULL, '曹戴伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r8', '兕', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '曹国第九代君主，惠伯。在位三十余年，国力平平，无显著事迹，维持小国。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹惠伯"}]'::jsonb, '惠伯', NULL, '曹惠伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r9', '石甫', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '惠伯之子，在位仅一年即被废。曹国政局一度动荡，旋即传位穆公，国势不稳。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹废伯"}]'::jsonb, '废伯', NULL, '曹废伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r10', '武', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '废伯之弟，在位三年。旋即传位桓公，曹国政局渐趋稳定，国势略有回升。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹穆公"}]'::jsonb, '穆公', NULL, '曹穆公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r11', '终生', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '曹桓公（姬终生），《史记·蔡世家》载前756–前702年在位，共55年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹桓公"}]'::jsonb, '桓公', NULL, '曹桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r12', '夕姑', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位三十年，曹国尚存一定影响力。春秋中期君主，国势尚可，无力争霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹庄公"}]'::jsonb, '庄公', NULL, '曹庄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r13', '夷', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '庄公之子，在位八年。曹国已渐趋式微，无力外争，仰息于晋楚等强邻。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹釐公"}]'::jsonb, '釐公', NULL, '曹釐公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r14', '班', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位仅九年，曹国继续衰落，仰息于晋楚等强邻，无力维持大国地位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹昭公"}]'::jsonb, '昭公', NULL, '曹昭公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r15', '襄', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '以刻薄闻名，《左传》载晋公子重耳过曹曾受冷遇。在位三十余年，国势日衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹共公"}]'::jsonb, '共公', NULL, '曹共公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r16', '寿', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '共公之子，在位二十余年。曹国仰息于强邻，无力争霸，维持小国局面。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹文公"}]'::jsonb, '文公', NULL, '曹文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r17', '彊', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位十六年，曹国无力外争，维持小国局面，仰息于晋楚等强邻。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹宣公"}]'::jsonb, '宣公', NULL, '曹宣公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r18', '负刍', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位二十二年，曹国继续衰落，已濒临灭亡，无力抵抗外敌。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹成公"}]'::jsonb, '成公', NULL, '曹成公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r19', '胜', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位二十六年，为曹国倒数几位君主，国势奄奄一息，无力外争。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹武公"}]'::jsonb, '武公', NULL, '曹武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r20', '须', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位仅四年，旋即传位悼公，曹国已无力抵抗外敌，国势危急。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹平公"}]'::jsonb, '平公', NULL, '曹平公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r21', '午', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位八年，曹国已濒临灭亡，无力抵抗宋国，国势奄奄一息。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹悼公"}]'::jsonb, '悼公', NULL, '曹悼公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r22', '野', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位仅四年，旋即传位隐公，曹国末代君主相继，国势危急。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹声公"}]'::jsonb, '声公', NULL, '曹声公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r23', '通', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位三年，为靖公所继，曹国已名存实亡，无力抵抗宋国。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹隐公"}]'::jsonb, '隐公', NULL, '曹隐公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r24', '露', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位仅三年，旋即传位末代伯阳，曹国濒临灭亡，国势奄奄一息。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹靖公"}]'::jsonb, '靖公', NULL, '曹靖公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cao-r25', '伯阳', ARRAY[]::text[], '姬', '曹', NULL, NULL, NULL, NULL, ARRAY['君主'], '曹国末代君主。前487年为宋国所灭，国亡，曹国历史终结，姬姓曹国不复存在。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/伯阳"}]'::jsonb, NULL, NULL, '伯阳')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r0', '泰伯', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '周太王长子。为避让季历，与弟仲雍奔荆蛮，居梅里，自号句吴；后世尊为吴国始祖。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/泰伯"}]'::jsonb, NULL, NULL, '泰伯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r1', '仲雍', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '泰伯之弟，随兄奔荆蛮，承续吴地事业；后传位季简。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/仲雍"}]'::jsonb, NULL, NULL, '仲雍')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r2', '季简', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '仲雍之后，承吴君之位，后传叔达。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/季简"}]'::jsonb, NULL, NULL, '季简')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r3', '叔达', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '季简之后，承吴君之位，后传周章。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/叔达"}]'::jsonb, NULL, NULL, '叔达')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r4', '周章', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '仲雍四世孙。周武王克商后受封为吴子，列为周代诸侯；其后熊遂继位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周章"}]'::jsonb, NULL, NULL, '周章')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r5', '熊遂', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '周章之后，承吴君之位，后传柯相。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊遂"}]'::jsonb, NULL, NULL, '熊遂')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r6', '柯相', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '熊遂之后，承吴君之位，后传彊鸠夷。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/柯相"}]'::jsonb, NULL, NULL, '柯相')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r7', '彊鸠夷', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '柯相之后，承吴君之位，后传余桥疑吾。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/彊鸠夷"}]'::jsonb, NULL, NULL, '彊鸠夷')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r8', '余桥疑吾', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '彊鸠夷之后，承吴君之位，后传柯卢。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/余桥疑吾"}]'::jsonb, NULL, NULL, '余桥疑吾')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r9', '柯卢', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '余桥疑吾之后，承吴君之位，后传周繇。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/柯卢"}]'::jsonb, NULL, NULL, '柯卢')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r10', '周繇', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '柯卢之后，承吴君之位，后传屈羽。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周繇"}]'::jsonb, NULL, NULL, '周繇')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r11', '屈羽', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '周繇之后，承吴君之位，后传夷吾。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/屈羽"}]'::jsonb, NULL, NULL, '屈羽')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r12', '夷吾', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '屈羽之后，承吴君之位，后传禽处。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/夷吾"}]'::jsonb, NULL, NULL, '夷吾')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r13', '禽处', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '夷吾之后，承吴君之位，后传转。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/禽处"}]'::jsonb, NULL, NULL, '禽处')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r14', '转', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '禽处之后，承吴君之位，后传颇高。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/转"}]'::jsonb, NULL, NULL, '转')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r15', '颇高', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '转之后，承吴君之位，后传句卑。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/颇高"}]'::jsonb, NULL, NULL, '颇高')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r16', '句卑', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '颇高之后，承吴君之位，后传去齐。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/句卑"}]'::jsonb, NULL, NULL, '句卑')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-pre-r17', '去齐', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '句卑之后，卒于前586年；寿梦继位，吴国纪年自此可考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/去齐"}]'::jsonb, NULL, NULL, '去齐')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-r0', '乘', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '吴子乘，去齐之后于前585年即位，是为寿梦；在位至前561年，吴国自此有准确纪年。晋遣巫臣教吴人车战与阵法，寿梦乘楚国内顾之机扩张，开始与中原诸侯交通并称王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吴王寿梦"}]'::jsonb, NULL, NULL, '寿梦')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-r1', '遏', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '寿梦长子，前560年即位，在位十三年。遵父命行兄终弟及，先继以王位，后传弟余祭；在位期间吴楚交战，吴军曾胜楚军于皋舟并夺回先王战船余皇。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吴王诸樊"}]'::jsonb, NULL, NULL, '诸樊')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-r2', '余祭', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '寿梦次子、诸樊之弟，前547年即位，在位四年。封季札于延陵，遣季札出使中原；其卒后弟余昧继位，兄终弟及的传位次序继续。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吴王余祭"}]'::jsonb, NULL, NULL, '余祭')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-r3', '余眛', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '寿梦第三子，前543年即位，在位十七年。趁楚国内乱攻灭州来；前527年卒后，季札辞让王位，寿梦之子公子僚继位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吴王余昧"}]'::jsonb, NULL, NULL, '余昧')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-r4', '僚', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '寿梦之子公子僚（其父系记载有异），前526年即位，在位十二年。任用公子光、伍子胥谋楚；前515年在公子光安排下被专诸刺杀，公子光继位，是为阖闾。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吴王僚"}]'::jsonb, NULL, NULL, '僚')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('helu', '阖闾', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '公子光，父系有作余眛、亦有作诸樊之说；前515年刺杀吴王僚，次年即位，在位至前496年。任用伍子胥、孙武，前506年柏举之战攻入楚都郢；后在槜李与越交战负伤而卒，太子夫差继位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/阖闾"}]'::jsonb, NULL, NULL, '阖闾')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-fu-gai', '夫概', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '阖闾之弟，前506年伐楚时任先锋并参与攻入郢都。前505年秦楚军击败吴军后回国自立为王，旋被阖闾击败而奔楚，楚封于堂谿，后称堂谿氏；在位不足一年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吴王夫概"}]'::jsonb, NULL, NULL, '夫概')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('fu-chai', '夫差', ARRAY[]::text[], '姬', '姑发', NULL, NULL, NULL, NULL, ARRAY['君主'], '阖闾之子，前495年即位，在位至前473年。前494年夫椒之战大败越军，却接受勾践求和；前482年北上黄池会盟时越袭吴都，夫差未能扭转国势，前473年兵败自尽，吴国灭亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吴王夫差"}]'::jsonb, NULL, NULL, '夫差')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yue-r3', '夫谭', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '越国早期君主，夫谭。在位时越国尚弱，处于吴国阴影之下，无力争霸，国势平平。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/夫谭"}]'::jsonb, NULL, NULL, '夫谭')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yue-r4', '允常', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '允常，勾践之父。在位时越国与吴国时有争战，国势渐起，为勾践霸业奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/允常"}]'::jsonb, NULL, NULL, '允常')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('gou-jian', '勾践', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '先败于夫差，屈身臣吴后反击灭吴，称霸东南。「卧薪尝胆」典出其事，越国霸业巅峰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/勾践"}]'::jsonb, NULL, NULL, '勾践')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yue-r6', '与夷', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '越王鹿郢，名与夷，又名鹿郢、于赐，勾践之子。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鹿郢"}]'::jsonb, NULL, NULL, '鹿郢')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yue-r7', '不寿', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '勾践之子，不寿。在位时吴国已亡，越国内部渐有纷争，国势转衰，无力维持霸业。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/不寿"}]'::jsonb, NULL, NULL, '不寿')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yue-r8', '翁', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '越王朱勾，名翁，一作州勾，不寿之子。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/朱勾"}]'::jsonb, NULL, NULL, '朱勾')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yue-r9', '翳', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '迁都琅邪，分封诸子于各地。越国由盛转衰，内乱加剧，诸侯离心，霸业渐失。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/翳"}]'::jsonb, NULL, NULL, '翳')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yue-r10', '错枝', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '在位仅两年，为弟所弑。越国内乱频仍，国势继续衰落，无力维持霸主地位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/错枝"}]'::jsonb, NULL, NULL, '错枝')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yue-r11', '无余', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '在位十一年，越国继续衰落，无力维持霸主地位，诸侯纷纷自立。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/无余"}]'::jsonb, NULL, NULL, '无余')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yue-r12', '无颛', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '在位近二十年，越国内乱不止，诸侯纷纷自立，国势奄奄一息。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/无颛"}]'::jsonb, NULL, NULL, '无颛')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('yue-r13', '无彊', ARRAY[]::text[], '姒', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '越国末代君主，无彊。扩张过度，遭楚、齐攻杀，越国分裂，霸业终结，国亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/无彊"}]'::jsonb, NULL, NULL, '无彊')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhongshan-r0', '文公', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '中山文公，维基年表载约前424–前415年在位，姓名失载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山文公"}]'::jsonb, '文公', NULL, '中山文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhongshan-r1', '窟', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '中山武公，本名姬窟，文公之子，前414–约前406年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山武公"}]'::jsonb, '武公', NULL, '中山武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhongshan-r2', '桓公', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '中山桓公，武公后即位，约前406年魏灭中山；约前380年复国，约前350年卒，姓名失载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山桓公"}]'::jsonb, '桓公', NULL, '中山桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhongshan-r3', '成公', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '中山成公，约前349–前328年在位，姓名失载。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山成公"}]'::jsonb, '成公', NULL, '中山成公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhongshan-r4', '厝', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '中山王厝（𰯼），前327–约前310年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山王厝"}]'::jsonb, NULL, NULL, '厝')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhongshan-r5', '𧊒', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '中山王𧊒，约前309–前299年在位；前299年赵破灵寿后逃齐卒。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山王𧊒"}]'::jsonb, NULL, NULL, '𧊒')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhongshan-r6', '尚', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['君主'], '中山王尚，前298–前296年在位，赵灭中山。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山王尚"}]'::jsonb, NULL, NULL, '尚')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-jing', '虔', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '前403年与魏、赵同受周室册封为诸侯，韩国正式立国，定都阳翟，开启战国历史。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩景侯"}]'::jsonb, '景侯', NULL, '韩景侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-r1', '取', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '景侯之子，烈侯。在位十二年，韩国初立，实力一般，无力争霸，国势平稳。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩烈侯"}]'::jsonb, '烈侯', NULL, '韩烈侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-r2', '猷', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '文侯，在位九年。韩国继续发展，未成大患，国势平稳，无力争霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩文侯"}]'::jsonb, '文侯', NULL, '韩文侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-r3', '屯蒙', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '哀侯，在位仅三年。韩国实力尚弱，无力外争，维持小国局面。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩哀侯"}]'::jsonb, '哀侯', NULL, '韩哀侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-r4', '若山', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '共侯，曾与赵攻魏，于浊泽大胜。因与赵争利未灭魏，魏得以存续，韩国错失良机。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩共侯"}]'::jsonb, '共侯', NULL, '韩共侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-r5', '武', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '即韩昭侯，任申不害变法，以术治国。韩国国力达于最强，诸侯不敢侵伐，为韩国巅峰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩釐侯"}]'::jsonb, '釐侯', NULL, '韩釐侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-r6', '康', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '昭侯之子，宣惠王。在位时韩国称王，参与合纵连横，国势尚可，无力争霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩宣惠王"}]'::jsonb, '宣惠王', NULL, '韩宣惠王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-r7', '仓', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '襄王，在位十五年。与诸侯周旋，韩国已渐弱，无力争霸，国势转衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩襄王"}]'::jsonb, '襄王', NULL, '韩襄王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-r8', '咎', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位二十三年，秦国东进，韩国屡遭攻伐，割地求和，国势危急。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩釐王"}]'::jsonb, '釐王', NULL, '韩釐王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-r9', '然', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '桓惠王，在位三十三年。韩国沦为秦国附庸，割地求和，国势危急，濒临灭亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩桓惠王"}]'::jsonb, '桓惠王', NULL, '韩桓惠王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-r10', '安', ARRAY[]::text[], '姬', '韩', NULL, NULL, NULL, NULL, ARRAY['君主'], '韩国末代君主。前230年秦灭韩，国亡，韩国历史终结，姬姓韩国不复存在。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/安"}]'::jsonb, NULL, NULL, '安')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhao-lie', '籍', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '前403年与魏、韩同受周室册封为诸侯，赵国正式立国，定都邯郸，开启战国历史。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵烈侯"}]'::jsonb, '烈侯', NULL, '赵烈侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhao-r1', '□', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '烈侯之子，武侯。在位十三年，名失考，事迹不详，国势平稳，无力争霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵武侯"}]'::jsonb, '武侯', NULL, '赵武侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhao-r2', '章', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '敬侯，迁都邯郸，赵国势力东移。在位十二年，国势渐起，为后世霸业奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵敬侯"}]'::jsonb, '敬侯', NULL, '赵敬侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhao-r3', '种', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '成侯，曾与韩魏分晋，俘虏晋君。在位二十五年，国势尚可，无力争霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵成侯"}]'::jsonb, '成侯', NULL, '赵成侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhao-r4', '语', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '肃侯，时赵魏大战，赵国中衰。壮志未酬而卒，传位武灵王，国势转弱。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵肃侯"}]'::jsonb, '肃侯', NULL, '赵肃侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhao-r5', '雍', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '推行胡服骑射，灭中山，拓土云中、雁门、代郡。沙丘之乱中被幽禁饿死，赵国由盛转衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵武灵王"}]'::jsonb, '武灵王', NULL, '赵武灵王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhao-r6', '何', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '武灵王之子，惠文王。杀忠臣肥义，秦赵长平之战惨败，国力大损，国势危急。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵惠文王"}]'::jsonb, '惠文王', NULL, '赵惠文王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhao-r7', '丹', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '孝成王，在位时赖名将李牧支撑赵国。长平之后赵国元气大伤，国势危急，无力争霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵孝成王"}]'::jsonb, '孝成王', NULL, '赵孝成王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhao-r8', '偃', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '悼襄王，在位九年。秦国连破赵国，国势危急，割地求和，濒临灭亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵悼襄王"}]'::jsonb, '悼襄王', NULL, '赵悼襄王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhao-r9', '迁', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '幽缪王，赵国末代君主。前228年秦灭赵，公子嘉逃代自立，旋亦亡，赵国终结。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵幽缪王"}]'::jsonb, '幽缪王', NULL, '赵幽缪王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wei-wen', '斯', ARRAY[]::text[], '姬', '魏', NULL, NULL, NULL, NULL, ARRAY['君主'], '尊师重道，任用李悝、吴起改革，灭中山。魏国率先强盛，为战国初霸，国势巅峰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏文侯"}]'::jsonb, '文侯', NULL, '魏文侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wei-r1', '击', ARRAY[]::text[], '姬', '魏', NULL, NULL, NULL, NULL, ARRAY['君主'], '文侯之子，武侯。吴起奔楚，秦攻韩赵而未全力救，国势有损，霸业渐衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏武侯"}]'::jsonb, '武侯', NULL, '魏武侯')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wei-r2', '罃', ARRAY[]::text[], '姬', '魏', NULL, NULL, NULL, NULL, ARRAY['君主'], '惠成王，迁都大梁。桂陵、马陵惨败，又遭秦齐夹击，魏国由盛转衰，无力争霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏惠成王"}]'::jsonb, '惠成王', NULL, '魏惠成王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wei-r3', '嗣', ARRAY[]::text[], '姬', '魏', NULL, NULL, NULL, NULL, ARRAY['君主'], '襄王，在位二十二年。魏国已非战国强国，无力争霸，国势转衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏襄王"}]'::jsonb, '襄王', NULL, '魏襄王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wei-r4', '遫', ARRAY[]::text[], '姬', '魏', NULL, NULL, NULL, NULL, ARRAY['君主'], '昭王，在位十八年。秦国屡攻魏国，割地求和，国势日衰，濒临灭亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏昭王"}]'::jsonb, '昭王', NULL, '魏昭王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wei-r5', '圉', ARRAY[]::text[], '姬', '魏', NULL, NULL, NULL, NULL, ARRAY['君主'], '安僖王，在位三十三年。魏国沦为秦国附庸，割地求和，国势危急。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏安僖王"}]'::jsonb, '安僖王', NULL, '魏安僖王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wei-r6', '午', ARRAY[]::text[], '姬', '魏', NULL, NULL, NULL, NULL, ARRAY['君主'], '景湣王，在位十四年。秦国攻魏取地，魏国奄奄一息，濒临灭亡，无力抵抗。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏景湣王"}]'::jsonb, '景湣王', NULL, '魏景湣王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wei-r7', '假', ARRAY[]::text[], '姬', '魏', NULL, NULL, NULL, NULL, ARRAY['君主'], '魏国末代君主。前225年秦灭魏，国亡，魏国历史终结，姬姓魏国不复存在。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/假"}]'::jsonb, NULL, NULL, '假')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('ying-qi', '开', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '护送周平王东迁有功，受封诸侯。伐戎建初功，秦国始为一方诸侯，开启霸业之路。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦襄公"}]'::jsonb, '襄公', NULL, '秦襄公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r1', '康', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '文公，在位五十年。初行大夫葬礼制度，秦国渐有起色，国势平稳，为后世奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦文公"}]'::jsonb, '文公', NULL, '秦文公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r2', '立', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '宪公，迁都徙民，国有起色。在位十二年，秦国继续发展，国势渐强。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦宪公"}]'::jsonb, '宪公', NULL, '秦宪公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r3', '曼', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '庶子，被立为君后不久为叔父武公所弑。在位仅五年，政局动荡，国势不稳。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/出子"}]'::jsonb, NULL, NULL, '出子')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r4', '说', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '武公，肃内政、平内乱。在位十九年，秦国渐稳，国势回升，为穆公霸业奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦武公"}]'::jsonb, '武公', NULL, '秦武公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r5', '嘉', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '德公，在位仅两年，迁雍都。旋即传位宣公，秦国政局平稳，国势尚可。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦德公"}]'::jsonb, '德公', NULL, '秦德公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r6', '恬', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '宣公，在位十一年。秦国维持二流强国地位，国势平稳，无力争霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦宣公"}]'::jsonb, '宣公', NULL, '秦宣公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r7', '载', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '成公，在位仅四年。旋即传位穆公，秦国迎来霸业时期，国势渐强。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦成公"}]'::jsonb, '成公', NULL, '秦成公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r8', '任好', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位三十九年，霸西戎，为春秋五霸之一。晚年兵败晋国，国力由盛转衰，霸业渐失。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦穆公"}]'::jsonb, '穆公', NULL, '秦穆公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r9', '罃', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '康公，穆公之子。在位十一年，秦国维持现状，国势平稳，无力争霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦康公"}]'::jsonb, '康公', NULL, '秦康公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r10', '和', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '共公，在位仅三年。旋即传位桓公，秦国继续衰落，国势转弱。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦共公"}]'::jsonb, '共公', NULL, '秦共公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r11', '荣', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '桓公，在位二十七年。秦国继续衰落，无力争霸，国势平平。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦桓公"}]'::jsonb, '桓公', NULL, '秦桓公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r12', '石', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '景公，在位四十年。秦国维持于二流强国，国势平平，无力外争。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦景公"}]'::jsonb, '景公', NULL, '秦景公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r13', '籍', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '哀公，在位三十六年。秦国国力平平，无力外争，维持小国局面。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦哀公"}]'::jsonb, '哀公', NULL, '秦哀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r14', '宁', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '惠公，在位仅九年。旋即传位悼公，秦国继续衰落，国势转弱。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦惠公"}]'::jsonb, '惠公', NULL, '秦惠公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r15', '盘', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '悼公，在位十四年。秦国继续衰落，国势危急，无力争霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦悼公"}]'::jsonb, '悼公', NULL, '秦悼公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r16', '刺', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '厉共公，在位三十四年。秦国国力衰弱，无力争霸，国势转弱。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦厉共公"}]'::jsonb, '厉共公', NULL, '秦厉共公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r17', '欣', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '躁公，在位十四年。秦国继续衰落，国势危急，无力外争。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦躁公"}]'::jsonb, '躁公', NULL, '秦躁公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r18', '封', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '怀公，被庶长所弑。在位仅数年，政局动荡，秦国内乱，国势不稳。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦怀公"}]'::jsonb, '怀公', NULL, '秦怀公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r19', '肃', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '灵公，在位十三年。死后献公不得立，传位简公，政局动荡，国势转弱。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦灵公"}]'::jsonb, '灵公', NULL, '秦灵公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r20', '悼子', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '简公，令吏带剑、初开徭。在位十五年，略有革新，国势渐起，为献公奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦简公"}]'::jsonb, '简公', NULL, '秦简公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r21', '仁', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '惠公（战国），伐蜀取南郑。在位十二年，旋即传位出公，秦国继续扩张，国势渐强。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦惠公"}]'::jsonb, '惠公', NULL, '秦惠公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r22', '昌', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '童主，被庶长改迎献公所弑。在位仅两年，河西地为晋所夺，国势危急，濒临衰落。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦出公"}]'::jsonb, '出公', NULL, '秦出公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r23', '师隰', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '止殉、迁栎阳，收复部分失地。商鞅入秦前秦国已有革新，国势渐起，为孝公奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦献公"}]'::jsonb, '献公', NULL, '秦献公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('ying-quliang', '渠梁', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '颁布求贤令，用商鞅变法，迁都咸阳。奠定秦国富强基础，为统一六国铺路，开启霸业新篇。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦孝公"}]'::jsonb, '孝公', NULL, '秦孝公')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r25', '驷', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '杀商鞅而沿用其法，灭巴蜀，臣平周王。秦国首称王号，国势强盛，为统一奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦惠文王"}]'::jsonb, '惠文王', NULL, '秦惠文王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r26', '荡', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '武王，举鼎绝膑而亡。在位仅四年，秦国继续扩张，国势强盛，无力维持长期霸业。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦武王"}]'::jsonb, '武王', NULL, '秦武王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r27', '稷', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '在位五十六年，诱杀楚怀王，长平灭赵。为秦国一统奠定决定性基础，国势巅峰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦昭襄王"}]'::jsonb, '昭襄王', NULL, '秦昭襄王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r28', '柱', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '孝文王，在位仅三天即卒。秦国王位匆匆传递，国势继续强盛，为庄襄王奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦孝文王"}]'::jsonb, '孝文王', NULL, '秦孝文王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qin-r29', '子楚', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '庄襄王，在位三年。秦占太原，切断韩交通要道，为灭韩铺路，国势继续强盛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦庄襄王"}]'::jsonb, '庄襄王', NULL, '秦庄襄王')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('ying-zheng', '政', ARRAY[]::text[], '嬴', '赵', NULL, NULL, NULL, NULL, ARRAY['君主'], '即位年幼，后亲政灭六国。前221年称帝，建立秦朝，中国首次大一统，开启帝制时代。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵政"}]'::jsonb, NULL, NULL, '秦始皇')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('shang-yang', '商鞅', ARRAY[]::text[], NULL, NULL, -390, 1, -338, 1, ARRAY['政治家'], '卫国人，秦孝公时主持变法，奠定秦统一基础。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/商鞅"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-qi', '吴起', ARRAY[]::text[], NULL, NULL, -440, 1, -381, 1, ARRAY['军事家','政治家'], '魏文侯时名将，后在楚主持变法。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吴起"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('sun-wu', '孙武', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['军事家'], '齐国军事家，著《孙子兵法》，传为吴王阖闾将。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孙武"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wu-zixu', '伍子胥', ARRAY[]::text[], NULL, NULL, -559, 1, -484, 1, ARRAY['军事家','政治家'], '楚人，助吴王阖闾破楚入郢，后被夫差赐死。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/伍子胥"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('fan-li', '范蠡', ARRAY[]::text[], NULL, NULL, -536, 1, -448, 1, ARRAY['政治家','军事家'], '越国大夫，助勾践灭吴，后泛舟五湖。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/范蠡"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qu-yuan', '屈原', ARRAY[]::text[], NULL, NULL, -340, 1, -278, 1, ARRAY['诗人','政治家'], '楚国诗人，楚辞代表，投汨罗江而死。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/屈原"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lao-zi', '老子', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['思想家'], '道家学派创始人，传统认为著道德经。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/老子"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('meng-ke', '孟子', ARRAY[]::text[], NULL, NULL, -372, 1, -289, 1, ARRAY['思想家'], '战国时期儒家代表，主张仁政王道。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孟子"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhuang-zhou', '庄子', ARRAY[]::text[], NULL, NULL, -369, 1, -286, 1, ARRAY['思想家'], '道家代表人物，庄子作者。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄子"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('han-fei', '韩非', ARRAY[]::text[], NULL, NULL, -280, 1, -233, 1, ARRAY['思想家'], '法家集大成者，秦王政重其书，后遭李斯害死。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩非"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('sun-bin', '孙膑', ARRAY[]::text[], NULL, NULL, -378, 1, -316, 1, ARRAY['军事家'], '孙子后裔，著孙膑兵法，桂陵、马陵大败魏军。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孙膑"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('bai-qi', '白起', ARRAY[]::text[], NULL, NULL, -332, 1, -257, 1, ARRAY['军事家'], '秦国名将，长平之战坑赵卒，封武安君。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/白起"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wang-jian-qin', '王翦', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['军事家'], '秦国名将，灭楚、灭燕，助秦统一天下。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王翦"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('bian-que', '扁鹊', ARRAY[]::text[], NULL, NULL, -407, 1, -310, 1, ARRAY['医学家'], '战国名医，望闻问切四诊法传说与其相关。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/扁鹊"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;

-- dynasties
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'zou-state', '邹', ARRAY['邹国','邾国','邾娄'], 'cn', 'east_asia',
  -1046, 1, -256, 12,
  -12540, -3049, 'year', 'ochre', NULL, NULL,
  '周代曹姓诸侯国，春秋称邾或邾娄，战国至孟子时称邹。传统始封年代按周初纪年；楚灭邹年份依战国末年通行说。君主世系跨多种文献辑录，部分在位年依可考君主锚点与连续世系均分插值；前471年至约前382年有未能交叉验证的断层，未跨段补齐。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'qi-chunqiu', '齐', ARRAY['姜齐','田齐','齐国'], 'cn', 'east_asia',
  -1046, 1, -221, 12,
  -12540, -2629, 'year', 'ochre', NULL, NULL,
  '周武王封姜太公于齐；前386年田氏代齐；前221年秦灭齐。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'jin-chunqiu', '晋', ARRAY['晋国'], 'cn', 'east_asia',
  -1042, 1, -349, 12,
  -12492, -4165, 'year', 'ochre', NULL, NULL,
  '周成王封叔虞于唐，改国号晋；前403年三家分晋；前376年公室被废、另立傀儡君，前349年静公被杀而国亡。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'chu-chunqiu', '楚', ARRAY['荆楚','楚国'], 'cn', 'east_asia',
  -1042, 1, -223, 12,
  -12492, -2653, 'year', 'ochre', NULL, NULL,
  '周成王封熊绎于楚；春秋战国南方大国，前223年秦灭楚。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'yan-chunqiu', '燕', ARRAY['燕国'], 'cn', 'east_asia',
  -1044, 1, -222, 12,
  -12516, -2641, 'year', 'ochre', NULL, NULL,
  '周武王封召公奭于燕；战国七雄之一，前222年秦灭燕。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'song-chunqiu', '宋', ARRAY['宋国'], 'cn', 'east_asia',
  -1034, 1, -286, 12,
  -12396, -3409, 'year', 'ochre', NULL, NULL,
  '周成王封微子启于宋；前286年齐湣王灭宋。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'lu-chunqiu', '鲁', ARRAY['鲁国'], 'cn', 'east_asia',
  -1042, 1, -256, 12,
  -12492, -3049, 'year', 'ochre', NULL, NULL,
  '周武王封周公旦于鲁；孔子故乡，前256年楚灭鲁。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'wei-weiguo', '卫', ARRAY['卫国'], 'cn', 'east_asia',
  -1040, 1, -209, 12,
  -12468, -2485, 'year', 'ochre', NULL, NULL,
  '周成王封康叔封于卫；小国久存，秦二世时废。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'zheng-chunqiu', '郑', ARRAY['郑国'], 'cn', 'east_asia',
  -806, 1, -375, 12,
  -9660, -4477, 'year', 'ochre', NULL, NULL,
  '周厉王少子友封于郑，后东迁新郑；前375年韩灭郑。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'cao-chunqiu', '曹', ARRAY['曹国'], 'cn', 'east_asia',
  -1046, 1, -487, 12,
  -12540, -5821, 'year', 'ochre', NULL, NULL,
  '周武王封弟振铎于曹；前487年宋灭曹。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'wu-chunqiu', '吴', ARRAY['吴国'], 'cn', 'east_asia',
  -1100, 1, -473, 12,
  -13188, -5653, 'year', 'ochre', NULL, NULL,
  '传世世系上溯至泰伯；《史记·吴太伯世家》记载武王克殷时周章已君吴，本项目以西周建国年（前1046）为周章起年确定锚点。锚点前后的无年表连续君主分别按世系均分，失考边标为 interpolated；寿梦起始保留前585年年表锚点。前473年越灭吴。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'yue-chunqiu', '越', ARRAY['越国'], 'cn', 'east_asia',
  -565, 1, -306, 12,
  -6768, -3649, 'year', 'ochre', NULL, NULL,
  '东南古国。传说夏少康庶子无余始封会稽，中间世系多缺载；有年表自允常。勾践灭吴后北进；前306年楚破越。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'zhongshan', '中山', ARRAY['中山国'], 'cn', 'east_asia',
  -424, 1, -296, 12,
  -5076, -3529, 'year', 'ochre', NULL, NULL,
  '鲜虞白狄所建。有年表自文公、武公；前406年后亡国，桓公复兴。前296年赵灭中山。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'han-warring', '韩', ARRAY['韩国'], 'cn', 'east_asia',
  -403, 1, -230, 12,
  -4824, -2737, 'year', 'ochre', NULL, NULL,
  '三家分晋后韩氏立国，前403年周天子册命；前230年秦灭韩。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'zhao-warring', '赵', ARRAY['赵国'], 'cn', 'east_asia',
  -403, 1, -222, 12,
  -4824, -2641, 'year', 'ochre', NULL, NULL,
  '三家分晋后赵氏立国；前222年秦灭赵。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'wei-warring', '魏', ARRAY['梁','魏国'], 'cn', 'east_asia',
  -403, 1, -225, 12,
  -4824, -2677, 'year', 'ochre', NULL, NULL,
  '三家分晋后魏氏立国，都大梁；前225年秦灭魏。与三国曹魏 wei 区分。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'qin', '秦', ARRAY['嬴秦','秦国'], 'cn', 'east_asia',
  -778, 1, -207, 12,
  -9324, -2461, 'year', 'ochre', -2640, NULL,
  '前778年秦襄公即位；前770年护周平王东迁列为诸侯；前221年嬴政称帝统一；前207年子婴降，秦亡。'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;

-- reigns
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r1-zou-state', 'zou-state', 'zou-r1', '',
  NULL,
  -1046, 1, NULL, -1012, 12, NULL,
  -12540, -12121, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r2-zou-state', 'zou-state', 'zou-r2', '',
  NULL,
  -1011, 1, NULL, -976, 12, NULL,
  -12120, -11689, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r3-zou-state', 'zou-state', 'zou-r3', '',
  NULL,
  -975, 1, NULL, -940, 12, NULL,
  -11688, -11257, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r4-zou-state', 'zou-state', 'zou-r4', '',
  NULL,
  -939, 1, NULL, -904, 12, NULL,
  -11256, -10825, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r5-zou-state', 'zou-state', 'zou-r5', '',
  NULL,
  -903, 1, NULL, -868, 12, NULL,
  -10824, -10393, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r6-zou-state', 'zou-state', 'zou-r6', '',
  NULL,
  -867, 1, NULL, -832, 12, NULL,
  -10392, -9961, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r7-zou-state', 'zou-state', 'zou-r7', '',
  NULL,
  -831, 1, NULL, -796, 12, NULL,
  -9960, -9529, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r8-zou-state', 'zou-state', 'zou-r8', '',
  NULL,
  -795, 1, NULL, -781, 12, NULL,
  -9528, -9349, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r9-zou-state', 'zou-state', 'zou-r9', '',
  NULL,
  -780, 1, NULL, -747, 12, NULL,
  -9348, -8941, 'year', NULL, 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-system-missing-ruler-zou-state', 'zou-state', 'system-missing-ruler', '',
  NULL,
  -746, 1, NULL, -713, 12, NULL,
  -8940, -8533, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r11-zou-state', 'zou-state', 'zou-r11', '',
  NULL,
  -712, 1, NULL, -678, 12, NULL,
  -8532, -8113, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r12-zou-state', 'zou-state', 'zou-r12', '',
  NULL,
  -677, 1, NULL, -666, 12, NULL,
  -8112, -7969, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r13-zou-state', 'zou-state', 'zou-r13', '',
  NULL,
  -665, 1, NULL, -615, 12, NULL,
  -7968, -7357, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r14-zou-state', 'zou-state', 'zou-r14', '',
  NULL,
  -614, 1, NULL, -573, 12, NULL,
  -7356, -6853, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r15-zou-state', 'zou-state', 'zou-r15', '',
  NULL,
  -572, 1, NULL, -556, 12, NULL,
  -6852, -6649, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r16-zou-state', 'zou-state', 'zou-r16', '',
  NULL,
  -555, 1, NULL, -541, 12, NULL,
  -6648, -6469, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r17-zou-state', 'zou-state', 'zou-r17', '',
  NULL,
  -540, 1, NULL, -507, 12, NULL,
  -6468, -6061, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-r18-zou-state', 'zou-state', 'zou-r18', '',
  NULL,
  -506, 1, NULL, -471, 12, NULL,
  -6060, -5629, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zou-mu-gong-zou-state', 'zou-state', 'zou-mu-gong', '',
  NULL,
  -382, 1, NULL, -330, 12, NULL,
  -4572, -3937, 'year', 'approximate', 'approximate',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lv-shang-qi-chunqiu', 'qi-chunqiu', 'lv-shang', '',
  NULL,
  -1046, 1, NULL, -1011, 12, NULL,
  -12540, -12109, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r1-qi-chunqiu', 'qi-chunqiu', 'qi-r1', '',
  NULL,
  -1010, 1, NULL, -974, 12, NULL,
  -12108, -11665, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r2-qi-chunqiu', 'qi-chunqiu', 'qi-r2', '',
  NULL,
  -973, 1, NULL, -937, 12, NULL,
  -11664, -11221, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r3-qi-chunqiu', 'qi-chunqiu', 'qi-r3', '',
  NULL,
  -936, 1, NULL, -900, 12, NULL,
  -11220, -10777, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r4-qi-chunqiu', 'qi-chunqiu', 'qi-r4', '',
  NULL,
  -899, 1, NULL, -863, 12, NULL,
  -10776, -10333, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r5-qi-chunqiu', 'qi-chunqiu', 'qi-r5', '',
  NULL,
  -862, 1, NULL, -860, 12, NULL,
  -10332, -10297, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r6-qi-chunqiu', 'qi-chunqiu', 'qi-r6', '',
  NULL,
  -859, 1, NULL, -851, 12, NULL,
  -10296, -10189, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r7-qi-chunqiu', 'qi-chunqiu', 'qi-r7', '',
  NULL,
  -850, 1, NULL, -825, 12, NULL,
  -10188, -9877, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r8-qi-chunqiu', 'qi-chunqiu', 'qi-r8', '',
  NULL,
  -824, 1, NULL, -816, 12, NULL,
  -9876, -9769, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r9-qi-chunqiu', 'qi-chunqiu', 'qi-r9', '',
  NULL,
  -815, 1, NULL, -804, 12, NULL,
  -9768, -9625, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r10-qi-chunqiu', 'qi-chunqiu', 'qi-r10', '',
  NULL,
  -803, 1, NULL, -795, 12, NULL,
  -9624, -9517, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r11-qi-chunqiu', 'qi-chunqiu', 'qi-r11', '',
  NULL,
  -794, 1, NULL, -731, 12, NULL,
  -9516, -8749, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r12-qi-chunqiu', 'qi-chunqiu', 'qi-r12', '',
  NULL,
  -730, 1, NULL, -698, 12, NULL,
  -8748, -8353, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r13-qi-chunqiu', 'qi-chunqiu', 'qi-r13', '',
  NULL,
  -697, 1, NULL, -686, 12, NULL,
  -8352, -8209, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r14-qi-chunqiu', 'qi-chunqiu', 'qi-r14', '',
  NULL,
  -686, 1, NULL, -686, 12, NULL,
  -8220, -8209, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jiang-xiaobai-qi-chunqiu', 'qi-chunqiu', 'jiang-xiaobai', '',
  NULL,
  -685, 1, NULL, -643, 12, NULL,
  -8208, -7693, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r16-qi-chunqiu', 'qi-chunqiu', 'qi-r16', '',
  NULL,
  -643, 1, NULL, -643, 12, NULL,
  -7704, -7693, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r17-qi-chunqiu', 'qi-chunqiu', 'qi-r17', '',
  NULL,
  -642, 1, NULL, -633, 12, NULL,
  -7692, -7573, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r18-qi-chunqiu', 'qi-chunqiu', 'qi-r18', '',
  NULL,
  -632, 1, NULL, -613, 12, NULL,
  -7572, -7333, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r19-qi-chunqiu', 'qi-chunqiu', 'qi-r19', '',
  NULL,
  -613, 1, NULL, -613, 12, NULL,
  -7344, -7333, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r20-qi-chunqiu', 'qi-chunqiu', 'qi-r20', '',
  NULL,
  -612, 1, NULL, -609, 12, NULL,
  -7332, -7285, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r21-qi-chunqiu', 'qi-chunqiu', 'qi-r21', '',
  NULL,
  -608, 1, NULL, -599, 12, NULL,
  -7284, -7165, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r22-qi-chunqiu', 'qi-chunqiu', 'qi-r22', '',
  NULL,
  -598, 1, NULL, -582, 12, NULL,
  -7164, -6961, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r23-qi-chunqiu', 'qi-chunqiu', 'qi-r23', '',
  NULL,
  -581, 1, NULL, -554, 12, NULL,
  -6960, -6625, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r24-qi-chunqiu', 'qi-chunqiu', 'qi-r24', '',
  NULL,
  -553, 1, NULL, -548, 12, NULL,
  -6624, -6553, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r25-qi-chunqiu', 'qi-chunqiu', 'qi-r25', '',
  NULL,
  -547, 1, NULL, -490, 12, NULL,
  -6552, -5857, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r26-qi-chunqiu', 'qi-chunqiu', 'qi-r26', '',
  NULL,
  -489, 1, NULL, -489, 12, NULL,
  -5856, -5845, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r27-qi-chunqiu', 'qi-chunqiu', 'qi-r27', '',
  NULL,
  -488, 1, NULL, -485, 12, NULL,
  -5844, -5797, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r28-qi-chunqiu', 'qi-chunqiu', 'qi-r28', '',
  NULL,
  -484, 1, NULL, -481, 12, NULL,
  -5796, -5749, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r29-qi-chunqiu', 'qi-chunqiu', 'qi-r29', '',
  NULL,
  -480, 1, NULL, -456, 12, NULL,
  -5748, -5449, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r30-qi-chunqiu', 'qi-chunqiu', 'qi-r30', '',
  NULL,
  -455, 1, NULL, -405, 12, NULL,
  -5448, -4837, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jiang-dai-qi-chunqiu', 'qi-chunqiu', 'jiang-dai', '',
  NULL,
  -404, 1, NULL, -392, 12, NULL,
  -4836, -4681, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-tian-he-qi-chunqiu', 'qi-chunqiu', 'tian-he', '',
  NULL,
  -404, 1, NULL, -384, 12, NULL,
  -4836, -4585, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r33-qi-chunqiu', 'qi-chunqiu', 'qi-r33', '',
  NULL,
  -383, 1, NULL, -375, 12, NULL,
  -4584, -4477, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r34-qi-chunqiu', 'qi-chunqiu', 'qi-r34', '',
  NULL,
  -374, 1, NULL, -357, 12, NULL,
  -4476, -4261, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r35-qi-chunqiu', 'qi-chunqiu', 'qi-r35', '',
  NULL,
  -356, 1, NULL, -320, 12, NULL,
  -4260, -3817, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r36-qi-chunqiu', 'qi-chunqiu', 'qi-r36', '',
  NULL,
  -319, 1, NULL, -301, 12, NULL,
  -3816, -3589, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r37-qi-chunqiu', 'qi-chunqiu', 'qi-r37', '',
  NULL,
  -300, 1, NULL, -284, 12, NULL,
  -3588, -3385, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r38-qi-chunqiu', 'qi-chunqiu', 'qi-r38', '',
  NULL,
  -283, 1, NULL, -265, 12, NULL,
  -3384, -3157, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qi-r39-qi-chunqiu', 'qi-chunqiu', 'qi-r39', '',
  NULL,
  -264, 1, NULL, -221, 12, NULL,
  -3156, -2629, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-ji-shuyu-jin-chunqiu', 'jin-chunqiu', 'ji-shuyu', '',
  NULL,
  -1042, 1, NULL, -1007, 12, NULL,
  -12492, -12061, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r1-jin-chunqiu', 'jin-chunqiu', 'jin-r1', '',
  NULL,
  -1006, 1, NULL, -970, 12, NULL,
  -12060, -11617, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r2-jin-chunqiu', 'jin-chunqiu', 'jin-r2', '',
  NULL,
  -969, 1, NULL, -933, 12, NULL,
  -11616, -11173, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r3-jin-chunqiu', 'jin-chunqiu', 'jin-r3', '',
  NULL,
  -932, 1, NULL, -896, 12, NULL,
  -11172, -10729, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r4-jin-chunqiu', 'jin-chunqiu', 'jin-r4', '',
  NULL,
  -895, 1, NULL, -859, 12, NULL,
  -10728, -10285, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r5-jin-chunqiu', 'jin-chunqiu', 'jin-r5', '',
  NULL,
  -858, 1, NULL, -841, 12, NULL,
  -10284, -10069, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r6-jin-chunqiu', 'jin-chunqiu', 'jin-r6', '',
  NULL,
  -840, 1, NULL, -823, 12, NULL,
  -10068, -9853, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r7-jin-chunqiu', 'jin-chunqiu', 'jin-r7', '',
  NULL,
  -822, 1, NULL, -812, 12, NULL,
  -9852, -9721, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r8-jin-chunqiu', 'jin-chunqiu', 'jin-r8', '',
  NULL,
  -811, 1, NULL, -785, 12, NULL,
  -9720, -9397, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r9-jin-chunqiu', 'jin-chunqiu', 'jin-r9', '',
  NULL,
  -784, 1, NULL, -781, 12, NULL,
  -9396, -9349, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r10-jin-chunqiu', 'jin-chunqiu', 'jin-r10', '',
  NULL,
  -780, 1, NULL, -746, 12, NULL,
  -9348, -8929, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r11-jin-chunqiu', 'jin-chunqiu', 'jin-r11', '',
  NULL,
  -745, 1, NULL, -740, 12, NULL,
  -8928, -8857, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r12-jin-chunqiu', 'jin-chunqiu', 'jin-r12', '',
  NULL,
  -744, 1, NULL, -731, 12, NULL,
  -8916, -8749, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r13-jin-chunqiu', 'jin-chunqiu', 'jin-r13', '',
  NULL,
  -739, 1, NULL, -724, 12, NULL,
  -8856, -8665, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r14-jin-chunqiu', 'jin-chunqiu', 'jin-r14', '',
  NULL,
  -730, 1, NULL, -716, 12, NULL,
  -8748, -8569, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r15-jin-chunqiu', 'jin-chunqiu', 'jin-r15', '',
  NULL,
  -723, 1, NULL, -718, 12, NULL,
  -8664, -8593, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r16-jin-chunqiu', 'jin-chunqiu', 'jin-r16', '',
  NULL,
  -717, 1, NULL, -709, 12, NULL,
  -8592, -8485, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r17-jin-chunqiu', 'jin-chunqiu', 'jin-r17', '',
  NULL,
  -715, 1, NULL, -677, 12, NULL,
  -8568, -8101, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r18-jin-chunqiu', 'jin-chunqiu', 'jin-r18', '',
  NULL,
  -708, 1, NULL, -705, 12, NULL,
  -8484, -8437, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r19-jin-chunqiu', 'jin-chunqiu', 'jin-r19', '',
  NULL,
  -704, 1, NULL, -678, 12, NULL,
  -8436, -8113, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r20-jin-chunqiu', 'jin-chunqiu', 'jin-r20', '',
  NULL,
  -676, 1, NULL, -651, 12, NULL,
  -8100, -7789, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r21-jin-chunqiu', 'jin-chunqiu', 'jin-r21', '',
  NULL,
  -650, 1, NULL, -637, 12, NULL,
  -7788, -7621, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r22-jin-chunqiu', 'jin-chunqiu', 'jin-r22', '',
  NULL,
  -637, 1, NULL, -637, 12, NULL,
  -7632, -7621, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-ji-chonger-jin-chunqiu', 'jin-chunqiu', 'ji-chonger', '',
  NULL,
  -636, 1, NULL, -628, 12, NULL,
  -7620, -7513, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r24-jin-chunqiu', 'jin-chunqiu', 'jin-r24', '',
  NULL,
  -627, 1, NULL, -621, 12, NULL,
  -7512, -7429, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r25-jin-chunqiu', 'jin-chunqiu', 'jin-r25', '',
  NULL,
  -620, 1, NULL, -607, 12, NULL,
  -7428, -7261, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r26-jin-chunqiu', 'jin-chunqiu', 'jin-r26', '',
  NULL,
  -606, 1, NULL, -600, 12, NULL,
  -7260, -7177, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r27-jin-chunqiu', 'jin-chunqiu', 'jin-r27', '',
  NULL,
  -599, 1, NULL, -581, 12, NULL,
  -7176, -6949, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r28-jin-chunqiu', 'jin-chunqiu', 'jin-r28', '',
  NULL,
  -580, 1, NULL, -573, 12, NULL,
  -6948, -6853, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r29-jin-chunqiu', 'jin-chunqiu', 'jin-r29', '',
  NULL,
  -572, 1, NULL, -558, 12, NULL,
  -6852, -6673, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r30-jin-chunqiu', 'jin-chunqiu', 'jin-r30', '',
  NULL,
  -557, 1, NULL, -532, 12, NULL,
  -6672, -6361, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r31-jin-chunqiu', 'jin-chunqiu', 'jin-r31', '',
  NULL,
  -531, 1, NULL, -526, 12, NULL,
  -6360, -6289, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r32-jin-chunqiu', 'jin-chunqiu', 'jin-r32', '',
  NULL,
  -525, 1, NULL, -512, 12, NULL,
  -6288, -6121, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r33-jin-chunqiu', 'jin-chunqiu', 'jin-r33', '',
  NULL,
  -511, 1, NULL, -475, 12, NULL,
  -6120, -5677, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r34-jin-chunqiu', 'jin-chunqiu', 'jin-r34', '',
  NULL,
  -474, 1, NULL, -452, 12, NULL,
  -5676, -5401, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r35-jin-chunqiu', 'jin-chunqiu', 'jin-r35', '',
  NULL,
  -451, 1, NULL, -434, 12, NULL,
  -5400, -5185, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r36-jin-chunqiu', 'jin-chunqiu', 'jin-r36', '',
  NULL,
  -433, 1, NULL, -416, 12, NULL,
  -5184, -4969, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r37-jin-chunqiu', 'jin-chunqiu', 'jin-r37', '',
  NULL,
  -415, 1, NULL, -389, 12, NULL,
  -4968, -4645, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r38-jin-chunqiu', 'jin-chunqiu', 'jin-r38', '',
  NULL,
  -388, 1, NULL, -357, 12, NULL,
  -4644, -4261, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-jin-r39-jin-chunqiu', 'jin-chunqiu', 'jin-r39', '',
  NULL,
  -356, 1, NULL, -349, 12, NULL,
  -4260, -4165, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r0-chu-chunqiu', 'chu-chunqiu', 'chu-r0', '',
  NULL,
  -1042, 1, NULL, -1019, 12, NULL,
  -12492, -12205, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r1-chu-chunqiu', 'chu-chunqiu', 'chu-r1', '',
  NULL,
  -1018, 1, NULL, -995, 12, NULL,
  -12204, -11917, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r2-chu-chunqiu', 'chu-chunqiu', 'chu-r2', '',
  NULL,
  -994, 1, NULL, -970, 12, NULL,
  -11916, -11617, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r3-chu-chunqiu', 'chu-chunqiu', 'chu-r3', '',
  NULL,
  -969, 1, NULL, -946, 12, NULL,
  -11616, -11329, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r4-chu-chunqiu', 'chu-chunqiu', 'chu-r4', '',
  NULL,
  -945, 1, NULL, -922, 12, NULL,
  -11328, -11041, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r5-chu-chunqiu', 'chu-chunqiu', 'chu-r5', '',
  NULL,
  -921, 1, NULL, -897, 12, NULL,
  -11040, -10741, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r6-chu-chunqiu', 'chu-chunqiu', 'chu-r6', '',
  NULL,
  -896, 1, NULL, -873, 12, NULL,
  -10740, -10453, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r7-chu-chunqiu', 'chu-chunqiu', 'chu-r7', '',
  NULL,
  -872, 1, NULL, -848, 12, NULL,
  -10452, -10153, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r8-chu-chunqiu', 'chu-chunqiu', 'chu-r8', '',
  NULL,
  -847, 1, NULL, -838, 12, NULL,
  -10152, -10033, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r9-chu-chunqiu', 'chu-chunqiu', 'chu-r9', '',
  NULL,
  -837, 1, NULL, -828, 12, NULL,
  -10032, -9913, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r10-chu-chunqiu', 'chu-chunqiu', 'chu-r10', '',
  NULL,
  -827, 1, NULL, -822, 12, NULL,
  -9912, -9841, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r11-chu-chunqiu', 'chu-chunqiu', 'chu-r11', '',
  NULL,
  -821, 1, NULL, -800, 12, NULL,
  -9840, -9577, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r12-chu-chunqiu', 'chu-chunqiu', 'chu-r12', '',
  NULL,
  -799, 1, NULL, -791, 12, NULL,
  -9576, -9469, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r13-chu-chunqiu', 'chu-chunqiu', 'chu-r13', '',
  NULL,
  -790, 1, NULL, -764, 12, NULL,
  -9468, -9145, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r14-chu-chunqiu', 'chu-chunqiu', 'chu-r14', '',
  NULL,
  -763, 1, NULL, -758, 12, NULL,
  -9144, -9073, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r15-chu-chunqiu', 'chu-chunqiu', 'chu-r15', '',
  NULL,
  -757, 1, NULL, -741, 12, NULL,
  -9072, -8869, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r16-chu-chunqiu', 'chu-chunqiu', 'chu-r16', '',
  NULL,
  -740, 1, NULL, -690, 12, NULL,
  -8868, -8257, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r17-chu-chunqiu', 'chu-chunqiu', 'chu-r17', '',
  NULL,
  -689, 1, NULL, -675, 12, NULL,
  -8256, -8077, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r18-chu-chunqiu', 'chu-chunqiu', 'chu-r18', '',
  NULL,
  -674, 1, NULL, -672, 12, NULL,
  -8076, -8041, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r19-chu-chunqiu', 'chu-chunqiu', 'chu-r19', '',
  NULL,
  -671, 1, NULL, -626, 12, NULL,
  -8040, -7489, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r20-chu-chunqiu', 'chu-chunqiu', 'chu-r20', '',
  NULL,
  -625, 1, NULL, -614, 12, NULL,
  -7488, -7345, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-xiong-zhuang-chu-chunqiu', 'chu-chunqiu', 'xiong-zhuang', '',
  NULL,
  -613, 1, NULL, -591, 12, NULL,
  -7344, -7069, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r22-chu-chunqiu', 'chu-chunqiu', 'chu-r22', '',
  NULL,
  -590, 1, NULL, -560, 12, NULL,
  -7068, -6697, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r23-chu-chunqiu', 'chu-chunqiu', 'chu-r23', '',
  NULL,
  -559, 1, NULL, -545, 12, NULL,
  -6696, -6517, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r24-chu-chunqiu', 'chu-chunqiu', 'chu-r24', '',
  NULL,
  -544, 1, NULL, -541, 12, NULL,
  -6516, -6469, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r25-chu-chunqiu', 'chu-chunqiu', 'chu-r25', '',
  NULL,
  -540, 1, NULL, -529, 12, NULL,
  -6468, -6325, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r26-chu-chunqiu', 'chu-chunqiu', 'chu-r26', '',
  NULL,
  -529, 1, NULL, -529, 12, NULL,
  -6336, -6325, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r27-chu-chunqiu', 'chu-chunqiu', 'chu-r27', '',
  NULL,
  -528, 1, NULL, -516, 12, NULL,
  -6324, -6169, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r28-chu-chunqiu', 'chu-chunqiu', 'chu-r28', '',
  NULL,
  -515, 1, NULL, -489, 12, NULL,
  -6168, -5845, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r29-chu-chunqiu', 'chu-chunqiu', 'chu-r29', '',
  NULL,
  -488, 1, NULL, -432, 12, NULL,
  -5844, -5161, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r30-chu-chunqiu', 'chu-chunqiu', 'chu-r30', '',
  NULL,
  -431, 1, NULL, -408, 12, NULL,
  -5160, -4873, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r31-chu-chunqiu', 'chu-chunqiu', 'chu-r31', '',
  NULL,
  -407, 1, NULL, -402, 12, NULL,
  -4872, -4801, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r32-chu-chunqiu', 'chu-chunqiu', 'chu-r32', '',
  NULL,
  -401, 1, NULL, -381, 12, NULL,
  -4800, -4549, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r33-chu-chunqiu', 'chu-chunqiu', 'chu-r33', '',
  NULL,
  -380, 1, NULL, -370, 12, NULL,
  -4548, -4417, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r34-chu-chunqiu', 'chu-chunqiu', 'chu-r34', '',
  NULL,
  -369, 1, NULL, -340, 12, NULL,
  -4416, -4057, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r35-chu-chunqiu', 'chu-chunqiu', 'chu-r35', '',
  NULL,
  -339, 1, NULL, -329, 12, NULL,
  -4056, -3925, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r36-chu-chunqiu', 'chu-chunqiu', 'chu-r36', '',
  NULL,
  -328, 1, NULL, -299, 12, NULL,
  -3924, -3565, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r37-chu-chunqiu', 'chu-chunqiu', 'chu-r37', '',
  NULL,
  -298, 1, NULL, -263, 12, NULL,
  -3564, -3133, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r38-chu-chunqiu', 'chu-chunqiu', 'chu-r38', '',
  NULL,
  -262, 1, NULL, -238, 12, NULL,
  -3132, -2833, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r39-chu-chunqiu', 'chu-chunqiu', 'chu-r39', '',
  NULL,
  -237, 1, NULL, -228, 12, NULL,
  -2832, -2713, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r40-chu-chunqiu', 'chu-chunqiu', 'chu-r40', '',
  NULL,
  -228, 1, NULL, -228, 12, NULL,
  -2724, -2713, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r41-chu-chunqiu', 'chu-chunqiu', 'chu-r41', '',
  NULL,
  -227, 1, NULL, -223, 12, NULL,
  -2712, -2653, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r42-chu-chunqiu', 'chu-chunqiu', 'chu-r42', '',
  NULL,
  -223, 1, NULL, -223, 12, NULL,
  -2664, -2653, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-chu-r43-chu-chunqiu', 'chu-chunqiu', 'chu-r43', '',
  NULL,
  -208, 1, NULL, -205, 12, NULL,
  -2484, -2437, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-ji-shi-yan-chunqiu', 'yan-chunqiu', 'ji-shi', '',
  NULL,
  -1044, 1, NULL, -1000, 12, NULL,
  -12516, -11977, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r1-yan-chunqiu', 'yan-chunqiu', 'yan-r1', '',
  NULL,
  -999, 1, NULL, -955, 12, NULL,
  -11976, -11437, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r2-yan-chunqiu', 'yan-chunqiu', 'yan-r2', '',
  NULL,
  -954, 1, NULL, -910, 12, NULL,
  -11436, -10897, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r3-yan-chunqiu', 'yan-chunqiu', 'yan-r3', '',
  NULL,
  -909, 1, NULL, -865, 12, NULL,
  -10896, -10357, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r4-yan-chunqiu', 'yan-chunqiu', 'yan-r4', '',
  NULL,
  -864, 1, NULL, -827, 12, NULL,
  -10356, -9901, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r5-yan-chunqiu', 'yan-chunqiu', 'yan-r5', '',
  NULL,
  -826, 1, NULL, -791, 12, NULL,
  -9900, -9469, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r6-yan-chunqiu', 'yan-chunqiu', 'yan-r6', '',
  NULL,
  -790, 1, NULL, -767, 12, NULL,
  -9468, -9181, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r7-yan-chunqiu', 'yan-chunqiu', 'yan-r7', '',
  NULL,
  -766, 1, NULL, -765, 12, NULL,
  -9180, -9157, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r8-yan-chunqiu', 'yan-chunqiu', 'yan-r8', '',
  NULL,
  -764, 1, NULL, -729, 12, NULL,
  -9156, -8725, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r9-yan-chunqiu', 'yan-chunqiu', 'yan-r9', '',
  NULL,
  -728, 1, NULL, -711, 12, NULL,
  -8724, -8509, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r10-yan-chunqiu', 'yan-chunqiu', 'yan-r10', '',
  NULL,
  -710, 1, NULL, -698, 12, NULL,
  -8508, -8353, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r11-yan-chunqiu', 'yan-chunqiu', 'yan-r11', '',
  NULL,
  -697, 1, NULL, -691, 12, NULL,
  -8352, -8269, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r12-yan-chunqiu', 'yan-chunqiu', 'yan-r12', '',
  NULL,
  -690, 1, NULL, -658, 12, NULL,
  -8268, -7873, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r13-yan-chunqiu', 'yan-chunqiu', 'yan-r13', '',
  NULL,
  -657, 1, NULL, -618, 12, NULL,
  -7872, -7393, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r14-yan-chunqiu', 'yan-chunqiu', 'yan-r14', '',
  NULL,
  -617, 1, NULL, -602, 12, NULL,
  -7392, -7201, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r15-yan-chunqiu', 'yan-chunqiu', 'yan-r15', '',
  NULL,
  -601, 1, NULL, -587, 12, NULL,
  -7200, -7021, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r16-yan-chunqiu', 'yan-chunqiu', 'yan-r16', '',
  NULL,
  -586, 1, NULL, -574, 12, NULL,
  -7020, -6865, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r17-yan-chunqiu', 'yan-chunqiu', 'yan-r17', '',
  NULL,
  -573, 1, NULL, -555, 12, NULL,
  -6864, -6637, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r18-yan-chunqiu', 'yan-chunqiu', 'yan-r18', '',
  NULL,
  -554, 1, NULL, -549, 12, NULL,
  -6636, -6565, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r19-yan-chunqiu', 'yan-chunqiu', 'yan-r19', '',
  NULL,
  -548, 1, NULL, -545, 12, NULL,
  -6564, -6517, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r20-yan-chunqiu', 'yan-chunqiu', 'yan-r20', '',
  NULL,
  -544, 1, NULL, -536, 12, NULL,
  -6516, -6409, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r21-yan-chunqiu', 'yan-chunqiu', 'yan-r21', '',
  NULL,
  -535, 1, NULL, -529, 12, NULL,
  -6408, -6325, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r22-yan-chunqiu', 'yan-chunqiu', 'yan-r22', '',
  NULL,
  -528, 1, NULL, -524, 12, NULL,
  -6324, -6265, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r23-yan-chunqiu', 'yan-chunqiu', 'yan-r23', '',
  NULL,
  -523, 1, NULL, -505, 12, NULL,
  -6264, -6037, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r24-yan-chunqiu', 'yan-chunqiu', 'yan-r24', '',
  NULL,
  -504, 1, NULL, -493, 12, NULL,
  -6036, -5893, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r25-yan-chunqiu', 'yan-chunqiu', 'yan-r25', '',
  NULL,
  -492, 1, NULL, -455, 12, NULL,
  -5892, -5437, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r26-yan-chunqiu', 'yan-chunqiu', 'yan-r26', '',
  NULL,
  -454, 1, NULL, -439, 12, NULL,
  -5436, -5245, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r27-yan-chunqiu', 'yan-chunqiu', 'yan-r27', '',
  NULL,
  -438, 1, NULL, -415, 12, NULL,
  -5244, -4957, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r28-yan-chunqiu', 'yan-chunqiu', 'yan-r28', '',
  NULL,
  -414, 1, NULL, -373, 12, NULL,
  -4956, -4453, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r14-yan-chunqiu-2', 'yan-chunqiu', 'yan-r14', '',
  NULL,
  -372, 1, NULL, -362, 12, NULL,
  -4452, -4321, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r18-yan-chunqiu-2', 'yan-chunqiu', 'yan-r18', '',
  NULL,
  -361, 1, NULL, -333, 12, NULL,
  -4320, -3973, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r31-yan-chunqiu', 'yan-chunqiu', 'yan-r31', '',
  NULL,
  -332, 1, NULL, -321, 12, NULL,
  -3972, -3829, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r32-yan-chunqiu', 'yan-chunqiu', 'yan-r32', '',
  NULL,
  -320, 1, NULL, -314, 12, NULL,
  -3828, -3745, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r33-yan-chunqiu', 'yan-chunqiu', 'yan-r33', '',
  NULL,
  -312, 1, NULL, -279, 12, NULL,
  -3732, -3325, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r34-yan-chunqiu', 'yan-chunqiu', 'yan-r34', '',
  NULL,
  -278, 1, NULL, -271, 12, NULL,
  -3324, -3229, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r35-yan-chunqiu', 'yan-chunqiu', 'yan-r35', '',
  NULL,
  -270, 1, NULL, -258, 12, NULL,
  -3228, -3073, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r36-yan-chunqiu', 'yan-chunqiu', 'yan-r36', '',
  NULL,
  -257, 1, NULL, -255, 12, NULL,
  -3072, -3037, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yan-r37-yan-chunqiu', 'yan-chunqiu', 'yan-r37', '',
  NULL,
  -254, 1, NULL, -222, 12, NULL,
  -3036, -2641, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-weizi-song-chunqiu', 'song-chunqiu', 'song-weizi', '',
  NULL,
  -1038, 1, NULL, -1025, 12, NULL,
  -12444, -12277, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r1-song-chunqiu', 'song-chunqiu', 'song-r1', '',
  NULL,
  -1024, 1, NULL, -986, 12, NULL,
  -12276, -11809, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r2-song-chunqiu', 'song-chunqiu', 'song-r2', '',
  NULL,
  -985, 1, NULL, -942, 12, NULL,
  -11808, -11281, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r3-song-chunqiu', 'song-chunqiu', 'song-r3', '',
  NULL,
  -941, 1, NULL, -919, 12, NULL,
  -11280, -11005, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r4-song-chunqiu', 'song-chunqiu', 'song-r4', '',
  NULL,
  -918, 1, NULL, -895, 12, NULL,
  -11004, -10717, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r5-song-chunqiu', 'song-chunqiu', 'song-r5', '',
  NULL,
  -894, 1, NULL, -879, 12, NULL,
  -10716, -10525, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r6-song-chunqiu', 'song-chunqiu', 'song-r6', '',
  NULL,
  -878, 1, NULL, -859, 12, NULL,
  -10524, -10285, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r7-song-chunqiu', 'song-chunqiu', 'song-r7', '',
  NULL,
  -858, 1, NULL, -831, 12, NULL,
  -10284, -9949, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r8-song-chunqiu', 'song-chunqiu', 'song-r8', '',
  NULL,
  -830, 1, NULL, -800, 12, NULL,
  -9948, -9577, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r9-song-chunqiu', 'song-chunqiu', 'song-r9', '',
  NULL,
  -800, 1, NULL, -800, 12, NULL,
  -9588, -9577, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r10-song-chunqiu', 'song-chunqiu', 'song-r10', '',
  NULL,
  -799, 1, NULL, -766, 12, NULL,
  -9576, -9169, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r11-song-chunqiu', 'song-chunqiu', 'song-r11', '',
  NULL,
  -765, 1, NULL, -748, 12, NULL,
  -9168, -8953, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r12-song-chunqiu', 'song-chunqiu', 'song-r12', '',
  NULL,
  -747, 1, NULL, -729, 12, NULL,
  -8952, -8725, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r13-song-chunqiu', 'song-chunqiu', 'song-r13', '',
  NULL,
  -728, 1, NULL, -720, 12, NULL,
  -8724, -8617, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r14-song-chunqiu', 'song-chunqiu', 'song-r14', '',
  NULL,
  -719, 1, NULL, -711, 12, NULL,
  -8616, -8509, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r15-song-chunqiu', 'song-chunqiu', 'song-r15', '',
  NULL,
  -710, 1, NULL, -692, 12, NULL,
  -8508, -8281, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r16-song-chunqiu', 'song-chunqiu', 'song-r16', '',
  NULL,
  -691, 1, NULL, -682, 12, NULL,
  -8280, -8161, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r17-song-chunqiu', 'song-chunqiu', 'song-r17', '',
  NULL,
  -682, 1, NULL, -682, 12, NULL,
  -8172, -8161, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r18-song-chunqiu', 'song-chunqiu', 'song-r18', '',
  NULL,
  -681, 1, NULL, -651, 12, NULL,
  -8160, -7789, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r19-song-chunqiu', 'song-chunqiu', 'song-r19', '',
  NULL,
  -650, 1, NULL, -637, 12, NULL,
  -7788, -7621, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r20-song-chunqiu', 'song-chunqiu', 'song-r20', '',
  NULL,
  -636, 1, NULL, -620, 12, NULL,
  -7620, -7417, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r21-song-chunqiu', 'song-chunqiu', 'song-r21', '',
  NULL,
  -620, 1, NULL, -620, 12, NULL,
  -7428, -7417, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r22-song-chunqiu', 'song-chunqiu', 'song-r22', '',
  NULL,
  -619, 1, NULL, -611, 12, NULL,
  -7416, -7309, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r23-song-chunqiu', 'song-chunqiu', 'song-r23', '',
  NULL,
  -610, 1, NULL, -589, 12, NULL,
  -7308, -7045, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r24-song-chunqiu', 'song-chunqiu', 'song-r24', '',
  NULL,
  -588, 1, NULL, -576, 12, NULL,
  -7044, -6889, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r25-song-chunqiu', 'song-chunqiu', 'song-r25', '',
  NULL,
  -575, 1, NULL, -532, 12, NULL,
  -6888, -6361, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r26-song-chunqiu', 'song-chunqiu', 'song-r26', '',
  NULL,
  -531, 1, NULL, -517, 12, NULL,
  -6360, -6181, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r27-song-chunqiu', 'song-chunqiu', 'song-r27', '',
  NULL,
  -516, 1, NULL, -469, 12, NULL,
  -6180, -5605, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r28-song-chunqiu', 'song-chunqiu', 'song-r28', '',
  NULL,
  -468, 1, NULL, -404, 12, NULL,
  -5604, -4825, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r29-song-chunqiu', 'song-chunqiu', 'song-r29', '',
  NULL,
  -403, 1, NULL, -385, 12, NULL,
  -4824, -4597, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r30-song-chunqiu', 'song-chunqiu', 'song-r30', '',
  NULL,
  -384, 1, NULL, -363, 12, NULL,
  -4596, -4333, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r31-song-chunqiu', 'song-chunqiu', 'song-r31', '',
  NULL,
  -362, 1, NULL, -356, 12, NULL,
  -4332, -4249, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r32-song-chunqiu', 'song-chunqiu', 'song-r32', '',
  NULL,
  -355, 1, NULL, -329, 12, NULL,
  -4248, -3925, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-song-r33-song-chunqiu', 'song-chunqiu', 'song-r33', '',
  NULL,
  -328, 1, NULL, -286, 12, NULL,
  -3924, -3409, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-bo-qin-lu-chunqiu', 'lu-chunqiu', 'bo-qin', '',
  NULL,
  -1043, 1, NULL, -998, 12, NULL,
  -12504, -11953, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r1-lu-chunqiu', 'lu-chunqiu', 'lu-r1', '',
  NULL,
  -997, 1, NULL, -994, 12, NULL,
  -11952, -11905, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r2-lu-chunqiu', 'lu-chunqiu', 'lu-r2', '',
  NULL,
  -993, 1, NULL, -988, 12, NULL,
  -11904, -11833, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r3-lu-chunqiu', 'lu-chunqiu', 'lu-r3', '',
  NULL,
  -987, 1, NULL, -974, 12, NULL,
  -11832, -11665, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r4-lu-chunqiu', 'lu-chunqiu', 'lu-r4', '',
  NULL,
  -973, 1, NULL, -924, 12, NULL,
  -11664, -11065, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r5-lu-chunqiu', 'lu-chunqiu', 'lu-r5', '',
  NULL,
  -923, 1, NULL, -887, 12, NULL,
  -11064, -10621, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r6-lu-chunqiu', 'lu-chunqiu', 'lu-r6', '',
  NULL,
  -886, 1, NULL, -855, 12, NULL,
  -10620, -10237, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r7-lu-chunqiu', 'lu-chunqiu', 'lu-r7', '',
  NULL,
  -854, 1, NULL, -825, 12, NULL,
  -10236, -9877, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r8-lu-chunqiu', 'lu-chunqiu', 'lu-r8', '',
  NULL,
  -824, 1, NULL, -816, 12, NULL,
  -9876, -9769, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r9-lu-chunqiu', 'lu-chunqiu', 'lu-r9', '',
  NULL,
  -815, 1, NULL, -807, 12, NULL,
  -9768, -9661, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r10-lu-chunqiu', 'lu-chunqiu', 'lu-r10', '',
  NULL,
  -806, 1, NULL, -796, 12, NULL,
  -9660, -9529, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r11-lu-chunqiu', 'lu-chunqiu', 'lu-r11', '',
  NULL,
  -795, 1, NULL, -769, 12, NULL,
  -9528, -9205, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r12-lu-chunqiu', 'lu-chunqiu', 'lu-r12', '',
  NULL,
  -768, 1, NULL, -723, 12, NULL,
  -9204, -8653, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r13-lu-chunqiu', 'lu-chunqiu', 'lu-r13', '',
  NULL,
  -722, 1, NULL, -712, 12, NULL,
  -8652, -8521, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r14-lu-chunqiu', 'lu-chunqiu', 'lu-r14', '',
  NULL,
  -711, 1, NULL, -694, 12, NULL,
  -8520, -8305, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r15-lu-chunqiu', 'lu-chunqiu', 'lu-r15', '',
  NULL,
  -693, 1, NULL, -662, 12, NULL,
  -8304, -7921, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r16-lu-chunqiu', 'lu-chunqiu', 'lu-r16', '',
  NULL,
  -661, 1, NULL, -660, 12, NULL,
  -7920, -7897, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r17-lu-chunqiu', 'lu-chunqiu', 'lu-r17', '',
  NULL,
  -659, 1, NULL, -627, 12, NULL,
  -7896, -7501, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r18-lu-chunqiu', 'lu-chunqiu', 'lu-r18', '',
  NULL,
  -626, 1, NULL, -609, 12, NULL,
  -7500, -7285, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r19-lu-chunqiu', 'lu-chunqiu', 'lu-r19', '',
  NULL,
  -608, 1, NULL, -591, 12, NULL,
  -7284, -7069, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r20-lu-chunqiu', 'lu-chunqiu', 'lu-r20', '',
  NULL,
  -590, 1, NULL, -573, 12, NULL,
  -7068, -6853, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r21-lu-chunqiu', 'lu-chunqiu', 'lu-r21', '',
  NULL,
  -572, 1, NULL, -542, 12, NULL,
  -6852, -6481, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r22-lu-chunqiu', 'lu-chunqiu', 'lu-r22', '',
  NULL,
  -542, 1, NULL, -542, 12, NULL,
  -6492, -6481, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r23-lu-chunqiu', 'lu-chunqiu', 'lu-r23', '',
  NULL,
  -541, 1, NULL, -510, 12, NULL,
  -6480, -6097, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r24-lu-chunqiu', 'lu-chunqiu', 'lu-r24', '',
  NULL,
  -509, 1, NULL, -495, 12, NULL,
  -6096, -5917, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r25-lu-chunqiu', 'lu-chunqiu', 'lu-r25', '',
  NULL,
  -494, 1, NULL, -468, 12, NULL,
  -5916, -5593, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r26-lu-chunqiu', 'lu-chunqiu', 'lu-r26', '',
  NULL,
  -467, 1, NULL, -437, 12, NULL,
  -5592, -5221, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r27-lu-chunqiu', 'lu-chunqiu', 'lu-r27', '',
  NULL,
  -436, 1, NULL, -416, 12, NULL,
  -5220, -4969, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r28-lu-chunqiu', 'lu-chunqiu', 'lu-r28', '',
  NULL,
  -415, 1, NULL, -383, 12, NULL,
  -4968, -4573, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r29-lu-chunqiu', 'lu-chunqiu', 'lu-r29', '',
  NULL,
  -382, 1, NULL, -353, 12, NULL,
  -4572, -4213, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r30-lu-chunqiu', 'lu-chunqiu', 'lu-r30', '',
  NULL,
  -352, 1, NULL, -344, 12, NULL,
  -4212, -4105, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r31-lu-chunqiu', 'lu-chunqiu', 'lu-r31', '',
  NULL,
  -343, 1, NULL, -323, 12, NULL,
  -4104, -3853, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r32-lu-chunqiu', 'lu-chunqiu', 'lu-r32', '',
  NULL,
  -322, 1, NULL, -303, 12, NULL,
  -3852, -3613, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r33-lu-chunqiu', 'lu-chunqiu', 'lu-r33', '',
  NULL,
  -302, 1, NULL, -280, 12, NULL,
  -3612, -3337, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-lu-r34-lu-chunqiu', 'lu-chunqiu', 'lu-r34', '',
  NULL,
  -279, 1, NULL, -256, 12, NULL,
  -3336, -3049, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r0-wei-weiguo', 'wei-weiguo', 'weiguo-r0', '',
  NULL,
  -1040, 1, NULL, -1017, 12, NULL,
  -12468, -12181, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r1-wei-weiguo', 'wei-weiguo', 'weiguo-r1', '',
  NULL,
  -1016, 1, NULL, -992, 12, NULL,
  -12180, -11881, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r2-wei-weiguo', 'wei-weiguo', 'weiguo-r2', '',
  NULL,
  -991, 1, NULL, -967, 12, NULL,
  -11880, -11581, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r3-wei-weiguo', 'wei-weiguo', 'weiguo-r3', '',
  NULL,
  -966, 1, NULL, -942, 12, NULL,
  -11580, -11281, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r4-wei-weiguo', 'wei-weiguo', 'weiguo-r4', '',
  NULL,
  -941, 1, NULL, -917, 12, NULL,
  -11280, -10981, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r5-wei-weiguo', 'wei-weiguo', 'weiguo-r5', '',
  NULL,
  -916, 1, NULL, -892, 12, NULL,
  -10980, -10681, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r6-wei-weiguo', 'wei-weiguo', 'weiguo-r6', '',
  NULL,
  -891, 1, NULL, -867, 12, NULL,
  -10680, -10381, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r7-wei-weiguo', 'wei-weiguo', 'weiguo-r7', '',
  NULL,
  -866, 1, NULL, -855, 12, NULL,
  -10380, -10237, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r8-wei-weiguo', 'wei-weiguo', 'weiguo-r8', '',
  NULL,
  -854, 1, NULL, -813, 12, NULL,
  -10236, -9733, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r9-wei-weiguo', 'wei-weiguo', 'weiguo-r9', '',
  NULL,
  -813, 1, NULL, -813, 12, NULL,
  -9744, -9733, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r10-wei-weiguo', 'wei-weiguo', 'weiguo-r10', '',
  NULL,
  -812, 1, NULL, -758, 12, NULL,
  -9732, -9073, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r11-wei-weiguo', 'wei-weiguo', 'weiguo-r11', '',
  NULL,
  -757, 1, NULL, -735, 12, NULL,
  -9072, -8797, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r12-wei-weiguo', 'wei-weiguo', 'weiguo-r12', '',
  NULL,
  -734, 1, NULL, -719, 12, NULL,
  -8796, -8605, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r13-wei-weiguo', 'wei-weiguo', 'weiguo-r13', '',
  NULL,
  -719, 1, NULL, -719, 12, NULL,
  -8616, -8605, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r14-wei-weiguo', 'wei-weiguo', 'weiguo-r14', '',
  NULL,
  -718, 1, NULL, -700, 12, NULL,
  -8604, -8377, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r15-wei-weiguo', 'wei-weiguo', 'weiguo-r15', '',
  NULL,
  -699, 1, NULL, -696, 12, NULL,
  -8376, -8329, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r16-wei-weiguo', 'wei-weiguo', 'weiguo-r16', '',
  NULL,
  -695, 1, NULL, -688, 12, NULL,
  -8328, -8233, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r15-wei-weiguo-2', 'wei-weiguo', 'weiguo-r15', '',
  NULL,
  -687, 1, NULL, -669, 12, NULL,
  -8232, -8005, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r18-wei-weiguo', 'wei-weiguo', 'weiguo-r18', '',
  NULL,
  -668, 1, NULL, -660, 12, NULL,
  -8004, -7897, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r19-wei-weiguo', 'wei-weiguo', 'weiguo-r19', '',
  NULL,
  -660, 1, NULL, -660, 12, NULL,
  -7908, -7897, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r20-wei-weiguo', 'wei-weiguo', 'weiguo-r20', '',
  NULL,
  -659, 1, NULL, -635, 12, NULL,
  -7896, -7597, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r21-wei-weiguo', 'wei-weiguo', 'weiguo-r21', '',
  NULL,
  -634, 1, NULL, -632, 12, NULL,
  -7596, -7561, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r22-wei-weiguo', 'wei-weiguo', 'weiguo-r22', '',
  NULL,
  -632, 1, NULL, -632, 12, NULL,
  -7572, -7561, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r21-wei-weiguo-2', 'wei-weiguo', 'weiguo-r21', '',
  NULL,
  -631, 1, NULL, -600, 12, NULL,
  -7560, -7177, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r23-wei-weiguo', 'wei-weiguo', 'weiguo-r23', '',
  NULL,
  -599, 1, NULL, -589, 12, NULL,
  -7176, -7045, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r24-wei-weiguo', 'wei-weiguo', 'weiguo-r24', '',
  NULL,
  -588, 1, NULL, -577, 12, NULL,
  -7044, -6901, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r25-wei-weiguo', 'wei-weiguo', 'weiguo-r25', '',
  NULL,
  -576, 1, NULL, -559, 12, NULL,
  -6900, -6685, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r26-wei-weiguo', 'wei-weiguo', 'weiguo-r26', '',
  NULL,
  -558, 1, NULL, -547, 12, NULL,
  -6684, -6541, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r25-wei-weiguo-2', 'wei-weiguo', 'weiguo-r25', '',
  NULL,
  -546, 1, NULL, -544, 12, NULL,
  -6540, -6505, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r28-wei-weiguo', 'wei-weiguo', 'weiguo-r28', '',
  NULL,
  -543, 1, NULL, -535, 12, NULL,
  -6504, -6397, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r29-wei-weiguo', 'wei-weiguo', 'weiguo-r29', '',
  NULL,
  -534, 1, NULL, -493, 12, NULL,
  -6396, -5893, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r30-wei-weiguo', 'wei-weiguo', 'weiguo-r30', '',
  NULL,
  -492, 1, NULL, -480, 12, NULL,
  -5892, -5737, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r31-wei-weiguo', 'wei-weiguo', 'weiguo-r31', '',
  NULL,
  -479, 1, NULL, -478, 12, NULL,
  -5736, -5713, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r32-wei-weiguo', 'wei-weiguo', 'weiguo-r32', '',
  NULL,
  -478, 1, NULL, -478, 12, NULL,
  -5724, -5713, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r33-wei-weiguo', 'wei-weiguo', 'weiguo-r33', '',
  NULL,
  -477, 1, NULL, -477, 12, NULL,
  -5712, -5701, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r30-wei-weiguo-2', 'wei-weiguo', 'weiguo-r30', '',
  NULL,
  -476, 1, NULL, -470, 12, NULL,
  -5700, -5617, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r35-wei-weiguo', 'wei-weiguo', 'weiguo-r35', '',
  NULL,
  -469, 1, NULL, -465, 12, NULL,
  -5616, -5557, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r36-wei-weiguo', 'wei-weiguo', 'weiguo-r36', '',
  NULL,
  -464, 1, NULL, -432, 12, NULL,
  -5556, -5161, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r37-wei-weiguo', 'wei-weiguo', 'weiguo-r37', '',
  NULL,
  -431, 1, NULL, -426, 12, NULL,
  -5160, -5089, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r38-wei-weiguo', 'wei-weiguo', 'weiguo-r38', '',
  NULL,
  -425, 1, NULL, -415, 12, NULL,
  -5088, -4957, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r39-wei-weiguo', 'wei-weiguo', 'weiguo-r39', '',
  NULL,
  -414, 1, NULL, -383, 12, NULL,
  -4956, -4573, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r40-wei-weiguo', 'wei-weiguo', 'weiguo-r40', '',
  NULL,
  -382, 1, NULL, -372, 12, NULL,
  -4572, -4441, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r41-wei-weiguo', 'wei-weiguo', 'weiguo-r41', '',
  NULL,
  -371, 1, NULL, -343, 12, NULL,
  -4440, -4093, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r42-wei-weiguo', 'wei-weiguo', 'weiguo-r42', '',
  NULL,
  -342, 1, NULL, -335, 12, NULL,
  -4092, -3997, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r43-wei-weiguo', 'wei-weiguo', 'weiguo-r43', '',
  NULL,
  -334, 1, NULL, -293, 12, NULL,
  -3996, -3493, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r44-wei-weiguo', 'wei-weiguo', 'weiguo-r44', '',
  NULL,
  -292, 1, NULL, -254, 12, NULL,
  -3492, -3025, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r45-wei-weiguo', 'wei-weiguo', 'weiguo-r45', '',
  NULL,
  -253, 1, NULL, -230, 12, NULL,
  -3024, -2737, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-weiguo-r46-wei-weiguo', 'wei-weiguo', 'weiguo-r46', '',
  NULL,
  -241, 1, NULL, -209, 12, NULL,
  -2880, -2485, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r0-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r0', '',
  NULL,
  -806, 1, NULL, -771, 12, NULL,
  -9660, -9229, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r1-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r1', '',
  NULL,
  -770, 1, NULL, -744, 12, NULL,
  -9228, -8905, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r2-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r2', '',
  NULL,
  -743, 1, NULL, -701, 12, NULL,
  -8904, -8389, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r3-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r3', '',
  NULL,
  -700, 1, NULL, -700, 12, NULL,
  -8388, -8377, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r4-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r4', '',
  NULL,
  -699, 1, NULL, -697, 12, NULL,
  -8376, -8341, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r3-zheng-chunqiu-2', 'zheng-chunqiu', 'zheng-r3', '',
  NULL,
  -696, 1, NULL, -695, 12, NULL,
  -8340, -8317, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r6-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r6', '',
  NULL,
  -694, 1, NULL, -694, 12, NULL,
  -8316, -8305, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r7-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r7', '',
  NULL,
  -693, 1, NULL, -680, 12, NULL,
  -8304, -8137, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r4-zheng-chunqiu-2', 'zheng-chunqiu', 'zheng-r4', '',
  NULL,
  -679, 1, NULL, -673, 12, NULL,
  -8136, -8053, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r9-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r9', '',
  NULL,
  -672, 1, NULL, -628, 12, NULL,
  -8052, -7513, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r10-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r10', '',
  NULL,
  -627, 1, NULL, -606, 12, NULL,
  -7512, -7249, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r11-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r11', '',
  NULL,
  -605, 1, NULL, -605, 12, NULL,
  -7248, -7237, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r12-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r12', '',
  NULL,
  -604, 1, NULL, -587, 12, NULL,
  -7236, -7021, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r13-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r13', '',
  NULL,
  -586, 1, NULL, -585, 12, NULL,
  -7020, -6997, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r14-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r14', '',
  NULL,
  -584, 1, NULL, -581, 12, NULL,
  -6996, -6949, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-gongzi-xu-zheng-chunqiu', 'zheng-chunqiu', 'zheng-gongzi-xu', '',
  NULL,
  -581, 1, NULL, -581, 12, NULL,
  -6960, -6949, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r14-zheng-chunqiu-2', 'zheng-chunqiu', 'zheng-r14', '',
  NULL,
  -580, 1, NULL, -571, 12, NULL,
  -6948, -6829, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r15-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r15', '',
  NULL,
  -570, 1, NULL, -566, 12, NULL,
  -6828, -6769, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r16-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r16', '',
  NULL,
  -565, 1, NULL, -530, 12, NULL,
  -6768, -6337, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r17-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r17', '',
  NULL,
  -529, 1, NULL, -514, 12, NULL,
  -6336, -6145, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r18-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r18', '',
  NULL,
  -513, 1, NULL, -501, 12, NULL,
  -6144, -5989, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r19-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r19', '',
  NULL,
  -500, 1, NULL, -463, 12, NULL,
  -5988, -5533, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r20-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r20', '',
  NULL,
  -462, 1, NULL, -455, 12, NULL,
  -5532, -5437, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r21-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r21', '',
  NULL,
  -454, 1, NULL, -424, 12, NULL,
  -5436, -5065, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r22-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r22', '',
  NULL,
  -423, 1, NULL, -423, 12, NULL,
  -5064, -5053, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r23-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r23', '',
  NULL,
  -422, 1, NULL, -396, 12, NULL,
  -5052, -4729, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zheng-r24-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r24', '',
  NULL,
  -395, 1, NULL, -375, 12, NULL,
  -4728, -4477, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r0-cao-chunqiu', 'cao-chunqiu', 'cao-r0', '',
  NULL,
  -1046, 1, NULL, -1016, 12, NULL,
  -12540, -12169, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r1-cao-chunqiu', 'cao-chunqiu', 'cao-r1', '',
  NULL,
  -1015, 1, NULL, -992, 12, NULL,
  -12168, -11881, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r2-cao-chunqiu', 'cao-chunqiu', 'cao-r2', '',
  NULL,
  -991, 1, NULL, -925, 12, NULL,
  -11880, -11077, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r3-cao-chunqiu', 'cao-chunqiu', 'cao-r3', '',
  NULL,
  -924, 1, NULL, -885, 12, NULL,
  -11076, -10597, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r4-cao-chunqiu', 'cao-chunqiu', 'cao-r4', '',
  NULL,
  -884, 1, NULL, -865, 12, NULL,
  -10596, -10357, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r5-cao-chunqiu', 'cao-chunqiu', 'cao-r5', '',
  NULL,
  -864, 1, NULL, -835, 12, NULL,
  -10356, -9997, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r6-cao-chunqiu', 'cao-chunqiu', 'cao-r6', '',
  NULL,
  -834, 1, NULL, -826, 12, NULL,
  -9996, -9889, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r7-cao-chunqiu', 'cao-chunqiu', 'cao-r7', '',
  NULL,
  -825, 1, NULL, -796, 12, NULL,
  -9888, -9529, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r8-cao-chunqiu', 'cao-chunqiu', 'cao-r8', '',
  NULL,
  -795, 1, NULL, -760, 12, NULL,
  -9528, -9097, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r9-cao-chunqiu', 'cao-chunqiu', 'cao-r9', '',
  NULL,
  -760, 1, NULL, -760, 12, NULL,
  -9108, -9097, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r10-cao-chunqiu', 'cao-chunqiu', 'cao-r10', '',
  NULL,
  -759, 1, NULL, -757, 12, NULL,
  -9096, -9061, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r11-cao-chunqiu', 'cao-chunqiu', 'cao-r11', '',
  NULL,
  -756, 1, NULL, -702, 12, NULL,
  -9060, -8401, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r12-cao-chunqiu', 'cao-chunqiu', 'cao-r12', '',
  NULL,
  -701, 1, NULL, -671, 12, NULL,
  -8400, -8029, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r13-cao-chunqiu', 'cao-chunqiu', 'cao-r13', '',
  NULL,
  -670, 1, NULL, -662, 12, NULL,
  -8028, -7921, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r14-cao-chunqiu', 'cao-chunqiu', 'cao-r14', '',
  NULL,
  -661, 1, NULL, -653, 12, NULL,
  -7920, -7813, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r15-cao-chunqiu', 'cao-chunqiu', 'cao-r15', '',
  NULL,
  -652, 1, NULL, -618, 12, NULL,
  -7812, -7393, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r16-cao-chunqiu', 'cao-chunqiu', 'cao-r16', '',
  NULL,
  -617, 1, NULL, -595, 12, NULL,
  -7392, -7117, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r17-cao-chunqiu', 'cao-chunqiu', 'cao-r17', '',
  NULL,
  -594, 1, NULL, -578, 12, NULL,
  -7116, -6913, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r18-cao-chunqiu', 'cao-chunqiu', 'cao-r18', '',
  NULL,
  -577, 1, NULL, -555, 12, NULL,
  -6912, -6637, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r19-cao-chunqiu', 'cao-chunqiu', 'cao-r19', '',
  NULL,
  -554, 1, NULL, -528, 12, NULL,
  -6636, -6313, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r20-cao-chunqiu', 'cao-chunqiu', 'cao-r20', '',
  NULL,
  -527, 1, NULL, -524, 12, NULL,
  -6312, -6265, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r21-cao-chunqiu', 'cao-chunqiu', 'cao-r21', '',
  NULL,
  -523, 1, NULL, -515, 12, NULL,
  -6264, -6157, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r22-cao-chunqiu', 'cao-chunqiu', 'cao-r22', '',
  NULL,
  -514, 1, NULL, -510, 12, NULL,
  -6156, -6097, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r23-cao-chunqiu', 'cao-chunqiu', 'cao-r23', '',
  NULL,
  -509, 1, NULL, -506, 12, NULL,
  -6096, -6049, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r24-cao-chunqiu', 'cao-chunqiu', 'cao-r24', '',
  NULL,
  -505, 1, NULL, -502, 12, NULL,
  -6048, -6001, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-cao-r25-cao-chunqiu', 'cao-chunqiu', 'cao-r25', '',
  NULL,
  -501, 1, NULL, -487, 12, NULL,
  -6000, -5821, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r0-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r0', '',
  NULL,
  -1100, 1, NULL, -1088, 12, NULL,
  -13188, -13033, 'year', 'approximate', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r1-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r1', '',
  NULL,
  -1087, 1, NULL, -1074, 12, NULL,
  -13032, -12865, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r2-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r2', '',
  NULL,
  -1073, 1, NULL, -1061, 12, NULL,
  -12864, -12709, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r3-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r3', '',
  NULL,
  -1060, 1, NULL, -1047, 12, NULL,
  -12708, -12541, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r4-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r4', '',
  NULL,
  -1046, 1, NULL, -1015, 12, NULL,
  -12540, -12157, 'year', NULL, 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r5-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r5', '',
  NULL,
  -1014, 1, NULL, -982, 12, NULL,
  -12156, -11761, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r6-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r6', '',
  NULL,
  -981, 1, NULL, -949, 12, NULL,
  -11760, -11365, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r7-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r7', '',
  NULL,
  -948, 1, NULL, -916, 12, NULL,
  -11364, -10969, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r8-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r8', '',
  NULL,
  -915, 1, NULL, -883, 12, NULL,
  -10968, -10573, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r9-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r9', '',
  NULL,
  -882, 1, NULL, -850, 12, NULL,
  -10572, -10177, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r10-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r10', '',
  NULL,
  -849, 1, NULL, -817, 12, NULL,
  -10176, -9781, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r11-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r11', '',
  NULL,
  -816, 1, NULL, -784, 12, NULL,
  -9780, -9385, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r12-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r12', '',
  NULL,
  -783, 1, NULL, -751, 12, NULL,
  -9384, -8989, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r13-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r13', '',
  NULL,
  -750, 1, NULL, -718, 12, NULL,
  -8988, -8593, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r14-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r14', '',
  NULL,
  -717, 1, NULL, -685, 12, NULL,
  -8592, -8197, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r15-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r15', '',
  NULL,
  -684, 1, NULL, -652, 12, NULL,
  -8196, -7801, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r16-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r16', '',
  NULL,
  -651, 1, NULL, -619, 12, NULL,
  -7800, -7405, 'year', 'interpolated', 'interpolated',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-pre-r17-wu-chunqiu', 'wu-chunqiu', 'wu-pre-r17', '',
  NULL,
  -618, 1, NULL, -586, 12, NULL,
  -7404, -7009, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-r0-wu-chunqiu', 'wu-chunqiu', 'wu-r0', '',
  NULL,
  -585, 1, NULL, -561, 12, NULL,
  -7008, -6709, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-r1-wu-chunqiu', 'wu-chunqiu', 'wu-r1', '',
  NULL,
  -560, 1, NULL, -548, 12, NULL,
  -6708, -6553, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-r2-wu-chunqiu', 'wu-chunqiu', 'wu-r2', '',
  NULL,
  -547, 1, NULL, -544, 12, NULL,
  -6552, -6505, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-r3-wu-chunqiu', 'wu-chunqiu', 'wu-r3', '',
  NULL,
  -543, 1, NULL, -527, 12, NULL,
  -6504, -6301, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-r4-wu-chunqiu', 'wu-chunqiu', 'wu-r4', '',
  NULL,
  -526, 1, NULL, -515, 12, NULL,
  -6300, -6157, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-helu-wu-chunqiu', 'wu-chunqiu', 'helu', '',
  NULL,
  -514, 1, NULL, -496, 12, NULL,
  -6156, -5929, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wu-fu-gai-wu-chunqiu', 'wu-chunqiu', 'wu-fu-gai', '',
  NULL,
  -505, 1, NULL, -505, 12, NULL,
  -6048, -6037, 'year', NULL, NULL,
  'fu-gai', '夫概', 'rival'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-fu-chai-wu-chunqiu', 'wu-chunqiu', 'fu-chai', '',
  NULL,
  -495, 1, NULL, -473, 12, NULL,
  -5928, -5653, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yue-r3-yue-chunqiu', 'yue-chunqiu', 'yue-r3', '',
  NULL,
  -565, 1, NULL, -511, 12, NULL,
  -6768, -6109, 'year', 'interpolated', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yue-r4-yue-chunqiu', 'yue-chunqiu', 'yue-r4', '',
  NULL,
  -510, 1, NULL, -497, 12, NULL,
  -6108, -5941, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-gou-jian-yue-chunqiu', 'yue-chunqiu', 'gou-jian', '',
  NULL,
  -496, 1, NULL, -464, 12, NULL,
  -5940, -5545, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yue-r6-yue-chunqiu', 'yue-chunqiu', 'yue-r6', '',
  NULL,
  -463, 1, NULL, -458, 12, NULL,
  -5544, -5473, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yue-r7-yue-chunqiu', 'yue-chunqiu', 'yue-r7', '',
  NULL,
  -457, 1, NULL, -448, 12, NULL,
  -5472, -5353, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yue-r8-yue-chunqiu', 'yue-chunqiu', 'yue-r8', '',
  NULL,
  -447, 1, NULL, -411, 12, NULL,
  -5352, -4909, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yue-r9-yue-chunqiu', 'yue-chunqiu', 'yue-r9', '',
  NULL,
  -410, 1, NULL, -375, 12, NULL,
  -4908, -4477, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yue-r10-yue-chunqiu', 'yue-chunqiu', 'yue-r10', '',
  NULL,
  -374, 1, NULL, -373, 12, NULL,
  -4476, -4453, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yue-r11-yue-chunqiu', 'yue-chunqiu', 'yue-r11', '',
  NULL,
  -372, 1, NULL, -361, 12, NULL,
  -4452, -4309, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yue-r12-yue-chunqiu', 'yue-chunqiu', 'yue-r12', '',
  NULL,
  -360, 1, NULL, -343, 12, NULL,
  -4308, -4093, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-yue-r13-yue-chunqiu', 'yue-chunqiu', 'yue-r13', '',
  NULL,
  -342, 1, NULL, -306, 12, NULL,
  -4092, -3649, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhongshan-r0-zhongshan', 'zhongshan', 'zhongshan-r0', '',
  NULL,
  -424, 1, NULL, -415, 12, NULL,
  -5076, -4957, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhongshan-r1-zhongshan', 'zhongshan', 'zhongshan-r1', '',
  NULL,
  -414, 1, NULL, -406, 12, NULL,
  -4956, -4849, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhongshan-r2-zhongshan', 'zhongshan', 'zhongshan-r2', '',
  NULL,
  -406, 1, NULL, -406, 12, NULL,
  -4860, -4849, 'year', 'approximate', 'approximate',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhongshan-r2-zhongshan-2', 'zhongshan', 'zhongshan-r2', '',
  NULL,
  -380, 1, NULL, -350, 12, NULL,
  -4548, -4177, 'year', 'approximate', 'approximate',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhongshan-r3-zhongshan', 'zhongshan', 'zhongshan-r3', '',
  NULL,
  -349, 1, NULL, -328, 12, NULL,
  -4176, -3913, 'year', 'approximate', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhongshan-r4-zhongshan', 'zhongshan', 'zhongshan-r4', '',
  NULL,
  -327, 1, NULL, -310, 12, NULL,
  -3912, -3697, 'year', NULL, 'approximate',
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhongshan-r5-zhongshan', 'zhongshan', 'zhongshan-r5', '',
  NULL,
  -309, 1, NULL, -299, 12, NULL,
  -3696, -3565, 'year', 'approximate', NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhongshan-r6-zhongshan', 'zhongshan', 'zhongshan-r6', '',
  NULL,
  -298, 1, NULL, -296, 12, NULL,
  -3564, -3529, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-jing-han-warring', 'han-warring', 'han-jing', '',
  NULL,
  -403, 1, NULL, -400, 12, NULL,
  -4824, -4777, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-r1-han-warring', 'han-warring', 'han-r1', '',
  NULL,
  -399, 1, NULL, -387, 12, NULL,
  -4776, -4621, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-r2-han-warring', 'han-warring', 'han-r2', '',
  NULL,
  -386, 1, NULL, -377, 12, NULL,
  -4620, -4501, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-r3-han-warring', 'han-warring', 'han-r3', '',
  NULL,
  -376, 1, NULL, -374, 12, NULL,
  -4500, -4465, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-r4-han-warring', 'han-warring', 'han-r4', '',
  NULL,
  -373, 1, NULL, -363, 12, NULL,
  -4464, -4333, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-r5-han-warring', 'han-warring', 'han-r5', '',
  NULL,
  -362, 1, NULL, -333, 12, NULL,
  -4332, -3973, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-r6-han-warring', 'han-warring', 'han-r6', '',
  NULL,
  -332, 1, NULL, -312, 12, NULL,
  -3972, -3721, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-r7-han-warring', 'han-warring', 'han-r7', '',
  NULL,
  -311, 1, NULL, -296, 12, NULL,
  -3720, -3529, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-r8-han-warring', 'han-warring', 'han-r8', '',
  NULL,
  -295, 1, NULL, -273, 12, NULL,
  -3528, -3253, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-r9-han-warring', 'han-warring', 'han-r9', '',
  NULL,
  -272, 1, NULL, -239, 12, NULL,
  -3252, -2845, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-han-r10-han-warring', 'han-warring', 'han-r10', '',
  NULL,
  -238, 1, NULL, -230, 12, NULL,
  -2844, -2737, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhao-lie-zhao-warring', 'zhao-warring', 'zhao-lie', '',
  NULL,
  -403, 1, NULL, -400, 12, NULL,
  -4824, -4777, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhao-r1-zhao-warring', 'zhao-warring', 'zhao-r1', '',
  NULL,
  -399, 1, NULL, -387, 12, NULL,
  -4776, -4621, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhao-r2-zhao-warring', 'zhao-warring', 'zhao-r2', '',
  NULL,
  -386, 1, NULL, -375, 12, NULL,
  -4620, -4477, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhao-r3-zhao-warring', 'zhao-warring', 'zhao-r3', '',
  NULL,
  -374, 1, NULL, -350, 12, NULL,
  -4476, -4177, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhao-r4-zhao-warring', 'zhao-warring', 'zhao-r4', '',
  NULL,
  -349, 1, NULL, -326, 12, NULL,
  -4176, -3889, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhao-r5-zhao-warring', 'zhao-warring', 'zhao-r5', '',
  NULL,
  -325, 1, NULL, -299, 12, NULL,
  -3888, -3565, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhao-r6-zhao-warring', 'zhao-warring', 'zhao-r6', '',
  NULL,
  -298, 1, NULL, -266, 12, NULL,
  -3564, -3169, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhao-r7-zhao-warring', 'zhao-warring', 'zhao-r7', '',
  NULL,
  -265, 1, NULL, -245, 12, NULL,
  -3168, -2917, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhao-r8-zhao-warring', 'zhao-warring', 'zhao-r8', '',
  NULL,
  -244, 1, NULL, -236, 12, NULL,
  -2916, -2809, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-zhao-r9-zhao-warring', 'zhao-warring', 'zhao-r9', '',
  NULL,
  -235, 1, NULL, -228, 12, NULL,
  -2808, -2713, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wei-wen-wei-warring', 'wei-warring', 'wei-wen', '',
  NULL,
  -403, 1, NULL, -396, 12, NULL,
  -4824, -4729, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wei-r1-wei-warring', 'wei-warring', 'wei-r1', '',
  NULL,
  -395, 1, NULL, -370, 12, NULL,
  -4728, -4417, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wei-r2-wei-warring', 'wei-warring', 'wei-r2', '',
  NULL,
  -369, 1, NULL, -319, 12, NULL,
  -4416, -3805, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wei-r3-wei-warring', 'wei-warring', 'wei-r3', '',
  NULL,
  -318, 1, NULL, -296, 12, NULL,
  -3804, -3529, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wei-r4-wei-warring', 'wei-warring', 'wei-r4', '',
  NULL,
  -295, 1, NULL, -277, 12, NULL,
  -3528, -3301, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wei-r5-wei-warring', 'wei-warring', 'wei-r5', '',
  NULL,
  -276, 1, NULL, -243, 12, NULL,
  -3300, -2893, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wei-r6-wei-warring', 'wei-warring', 'wei-r6', '',
  NULL,
  -242, 1, NULL, -228, 12, NULL,
  -2892, -2713, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-wei-r7-wei-warring', 'wei-warring', 'wei-r7', '',
  NULL,
  -227, 1, NULL, -225, 12, NULL,
  -2712, -2677, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-ying-qi-qin', 'qin', 'ying-qi', '',
  NULL,
  -778, 1, NULL, -766, 12, NULL,
  -9324, -9169, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r1-qin', 'qin', 'qin-r1', '',
  NULL,
  -765, 1, NULL, -716, 12, NULL,
  -9168, -8569, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r2-qin', 'qin', 'qin-r2', '',
  NULL,
  -715, 1, NULL, -704, 12, NULL,
  -8568, -8425, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r3-qin', 'qin', 'qin-r3', '',
  NULL,
  -703, 1, NULL, -698, 12, NULL,
  -8424, -8353, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r4-qin', 'qin', 'qin-r4', '',
  NULL,
  -697, 1, NULL, -678, 12, NULL,
  -8352, -8113, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r5-qin', 'qin', 'qin-r5', '',
  NULL,
  -677, 1, NULL, -676, 12, NULL,
  -8112, -8089, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r6-qin', 'qin', 'qin-r6', '',
  NULL,
  -675, 1, NULL, -664, 12, NULL,
  -8088, -7945, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r7-qin', 'qin', 'qin-r7', '',
  NULL,
  -663, 1, NULL, -660, 12, NULL,
  -7944, -7897, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r8-qin', 'qin', 'qin-r8', '',
  NULL,
  -659, 1, NULL, -621, 12, NULL,
  -7896, -7429, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r9-qin', 'qin', 'qin-r9', '',
  NULL,
  -620, 1, NULL, -609, 12, NULL,
  -7428, -7285, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r10-qin', 'qin', 'qin-r10', '',
  NULL,
  -608, 1, NULL, -605, 12, NULL,
  -7284, -7237, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r11-qin', 'qin', 'qin-r11', '',
  NULL,
  -604, 1, NULL, -577, 12, NULL,
  -7236, -6901, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r12-qin', 'qin', 'qin-r12', '',
  NULL,
  -576, 1, NULL, -537, 12, NULL,
  -6900, -6421, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r13-qin', 'qin', 'qin-r13', '',
  NULL,
  -536, 1, NULL, -501, 12, NULL,
  -6420, -5989, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r14-qin', 'qin', 'qin-r14', '',
  NULL,
  -500, 1, NULL, -492, 12, NULL,
  -5988, -5881, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r15-qin', 'qin', 'qin-r15', '',
  NULL,
  -491, 1, NULL, -477, 12, NULL,
  -5880, -5701, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r16-qin', 'qin', 'qin-r16', '',
  NULL,
  -476, 1, NULL, -443, 12, NULL,
  -5700, -5293, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r17-qin', 'qin', 'qin-r17', '',
  NULL,
  -442, 1, NULL, -429, 12, NULL,
  -5292, -5125, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r18-qin', 'qin', 'qin-r18', '',
  NULL,
  -428, 1, NULL, -425, 12, NULL,
  -5124, -5077, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r19-qin', 'qin', 'qin-r19', '',
  NULL,
  -425, 1, NULL, -415, 12, NULL,
  -5088, -4957, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r20-qin', 'qin', 'qin-r20', '',
  NULL,
  -415, 1, NULL, -400, 12, NULL,
  -4968, -4777, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r21-qin', 'qin', 'qin-r21', '',
  NULL,
  -399, 1, NULL, -387, 12, NULL,
  -4776, -4621, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r22-qin', 'qin', 'qin-r22', '',
  NULL,
  -386, 1, NULL, -385, 12, NULL,
  -4620, -4597, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r23-qin', 'qin', 'qin-r23', '',
  NULL,
  -385, 1, NULL, -362, 12, NULL,
  -4608, -4321, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-ying-quliang-qin', 'qin', 'ying-quliang', '',
  NULL,
  -361, 1, NULL, -338, 12, NULL,
  -4320, -4033, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r25-qin', 'qin', 'qin-r25', '',
  NULL,
  -337, 1, NULL, -311, 12, NULL,
  -4032, -3709, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r26-qin', 'qin', 'qin-r26', '',
  NULL,
  -310, 1, NULL, -307, 12, NULL,
  -3708, -3661, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r27-qin', 'qin', 'qin-r27', '',
  NULL,
  -306, 1, NULL, -251, 12, NULL,
  -3660, -2989, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r28-qin', 'qin', 'qin-r28', '',
  NULL,
  -250, 1, NULL, -250, 12, NULL,
  -2988, -2977, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-qin-r29-qin', 'qin', 'qin-r29', '',
  NULL,
  -249, 1, NULL, -247, 12, NULL,
  -2976, -2941, 'year', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence,
  claim_track, claim_label, claim_role
) VALUES (
  'reign-ying-zheng-qin', 'qin', 'ying-zheng', '赵政',
  NULL,
  -246, 1, NULL, -221, 9, 9,
  -2940, -2632, 'month', NULL, NULL,
  NULL, NULL, NULL
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence,
  claim_track = EXCLUDED.claim_track,
  claim_label = EXCLUDED.claim_label,
  claim_role = EXCLUDED.claim_role;

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('shangyang-reform', '商鞅变法', 'politics', 'point', 'year', '秦孝公六年，前356年；史籍或作前359年，取前356年', -356, 12, -4249, NULL, NULL, NULL, NULL, NULL, NULL, '商鞅在秦国推行军功爵、什伍连坐、废井田等改革，奠定统一六国基础。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('wuqi-reform-wei', '吴起变法（魏）', 'politics', 'point', 'year', '魏文侯时，约前403–前387年，取中点估列', -395, 12, -4717, NULL, NULL, NULL, NULL, NULL, NULL, '吴起在魏国主持军政改革，创建武卒，魏国成为战国初强国。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('guiling-battle', '桂陵之战', 'battle', 'point', 'year', '周威烈王十三年，前354年', -354, 12, -4225, NULL, NULL, NULL, NULL, NULL, NULL, '孙膑围魏救赵，于桂陵大败魏军，开创围魏救赵战法。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('maling-battle', '马陵之战', 'battle', 'point', 'year', '周显王三年，前341年', -341, 12, -4069, NULL, NULL, NULL, NULL, NULL, NULL, '孙膑减灶诱敌，于马陵伏击魏军，庞涓战死，魏国元气大伤。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('changping-battle', '长平之战', 'battle', 'point', 'year', '秦昭襄王四十七年，前260年', -260, 12, -3097, NULL, NULL, NULL, NULL, NULL, NULL, '白起于长平围歼赵军四十余万，赵国一蹶不振，秦统一大势已定。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;

-- event_dynasties (new + links to xia-shang-zhou events)
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('shangyang-reform', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wuqi-reform-wei', 'wei-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('guiling-battle', 'wei-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('guiling-battle', 'qi-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('maling-battle', 'wei-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('maling-battle', 'qi-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('changping-battle', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('changping-battle', 'zhao-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('kuiqiu', 'qi-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chengpu', 'jin-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chengpu', 'chu-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('sanjia-fenjin', 'jin-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('sanjia-fenjin', 'han-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('sanjia-fenjin', 'zhao-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('sanjia-fenjin', 'wei-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'qi-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'jin-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'chu-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'song-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'lu-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'wei-weiguo') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'zheng-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'cao-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'wu-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'yue-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhanguo', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhanguo', 'qi-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhanguo', 'chu-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhanguo', 'yan-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhanguo', 'han-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhanguo', 'zhao-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhanguo', 'wei-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhanguo', 'zhongshan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('baijia-zhengming', 'lu-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('baijia-zhengming', 'qi-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('baijia-zhengming', 'chu-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('baijia-zhengming', 'wei-warring') ON CONFLICT DO NOTHING;

-- event_participants
INSERT INTO event_participants (event_id, person_id) VALUES ('shangyang-reform', 'ying-quliang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('shangyang-reform', 'shang-yang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wuqi-reform-wei', 'wei-wen') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wuqi-reform-wei', 'wu-qi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('guiling-battle', 'sun-bin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('maling-battle', 'sun-bin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('changping-battle', 'bai-qi') ON CONFLICT DO NOTHING;

-- relations
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id)
VALUES ('rel-shangyang-reform-shang-yang', 'event', 'shangyang-reform', 'person', 'shang-yang', 'politics', NULL, NULL, NULL, NULL, NULL)
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id)
VALUES ('rel-changping-bai-qi', 'event', 'changping-battle', 'person', 'bai-qi', 'battle', NULL, NULL, NULL, NULL, NULL)
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id)
VALUES ('rel-guiling-sun-bin', 'event', 'guiling-battle', 'person', 'sun-bin', 'battle', NULL, NULL, NULL, NULL, NULL)
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id)
VALUES ('rel-maling-sun-bin', 'event', 'maling-battle', 'person', 'sun-bin', 'battle', NULL, NULL, NULL, NULL, NULL)
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;

-- Remove stale reigns from managed dynasties (superseded ids from older imports)
WITH stale AS (
  DELETE FROM reigns
  WHERE dynasty_id IN ('zou-state', 'qi-chunqiu', 'jin-chunqiu', 'chu-chunqiu', 'yan-chunqiu', 'song-chunqiu', 'lu-chunqiu', 'wei-weiguo', 'zheng-chunqiu', 'cao-chunqiu', 'wu-chunqiu', 'yue-chunqiu', 'zhongshan', 'han-warring', 'zhao-warring', 'wei-warring', 'qin') AND id NOT IN ('reign-zou-r1-zou-state', 'reign-zou-r2-zou-state', 'reign-zou-r3-zou-state', 'reign-zou-r4-zou-state', 'reign-zou-r5-zou-state', 'reign-zou-r6-zou-state', 'reign-zou-r7-zou-state', 'reign-zou-r8-zou-state', 'reign-zou-r9-zou-state', 'reign-system-missing-ruler-zou-state', 'reign-zou-r11-zou-state', 'reign-zou-r12-zou-state', 'reign-zou-r13-zou-state', 'reign-zou-r14-zou-state', 'reign-zou-r15-zou-state', 'reign-zou-r16-zou-state', 'reign-zou-r17-zou-state', 'reign-zou-r18-zou-state', 'reign-zou-mu-gong-zou-state', 'reign-lv-shang-qi-chunqiu', 'reign-qi-r1-qi-chunqiu', 'reign-qi-r2-qi-chunqiu', 'reign-qi-r3-qi-chunqiu', 'reign-qi-r4-qi-chunqiu', 'reign-qi-r5-qi-chunqiu', 'reign-qi-r6-qi-chunqiu', 'reign-qi-r7-qi-chunqiu', 'reign-qi-r8-qi-chunqiu', 'reign-qi-r9-qi-chunqiu', 'reign-qi-r10-qi-chunqiu', 'reign-qi-r11-qi-chunqiu', 'reign-qi-r12-qi-chunqiu', 'reign-qi-r13-qi-chunqiu', 'reign-qi-r14-qi-chunqiu', 'reign-jiang-xiaobai-qi-chunqiu', 'reign-qi-r16-qi-chunqiu', 'reign-qi-r17-qi-chunqiu', 'reign-qi-r18-qi-chunqiu', 'reign-qi-r19-qi-chunqiu', 'reign-qi-r20-qi-chunqiu', 'reign-qi-r21-qi-chunqiu', 'reign-qi-r22-qi-chunqiu', 'reign-qi-r23-qi-chunqiu', 'reign-qi-r24-qi-chunqiu', 'reign-qi-r25-qi-chunqiu', 'reign-qi-r26-qi-chunqiu', 'reign-qi-r27-qi-chunqiu', 'reign-qi-r28-qi-chunqiu', 'reign-qi-r29-qi-chunqiu', 'reign-qi-r30-qi-chunqiu', 'reign-jiang-dai-qi-chunqiu', 'reign-tian-he-qi-chunqiu', 'reign-qi-r33-qi-chunqiu', 'reign-qi-r34-qi-chunqiu', 'reign-qi-r35-qi-chunqiu', 'reign-qi-r36-qi-chunqiu', 'reign-qi-r37-qi-chunqiu', 'reign-qi-r38-qi-chunqiu', 'reign-qi-r39-qi-chunqiu', 'reign-ji-shuyu-jin-chunqiu', 'reign-jin-r1-jin-chunqiu', 'reign-jin-r2-jin-chunqiu', 'reign-jin-r3-jin-chunqiu', 'reign-jin-r4-jin-chunqiu', 'reign-jin-r5-jin-chunqiu', 'reign-jin-r6-jin-chunqiu', 'reign-jin-r7-jin-chunqiu', 'reign-jin-r8-jin-chunqiu', 'reign-jin-r9-jin-chunqiu', 'reign-jin-r10-jin-chunqiu', 'reign-jin-r11-jin-chunqiu', 'reign-jin-r12-jin-chunqiu', 'reign-jin-r13-jin-chunqiu', 'reign-jin-r14-jin-chunqiu', 'reign-jin-r15-jin-chunqiu', 'reign-jin-r16-jin-chunqiu', 'reign-jin-r17-jin-chunqiu', 'reign-jin-r18-jin-chunqiu', 'reign-jin-r19-jin-chunqiu', 'reign-jin-r20-jin-chunqiu', 'reign-jin-r21-jin-chunqiu', 'reign-jin-r22-jin-chunqiu', 'reign-ji-chonger-jin-chunqiu', 'reign-jin-r24-jin-chunqiu', 'reign-jin-r25-jin-chunqiu', 'reign-jin-r26-jin-chunqiu', 'reign-jin-r27-jin-chunqiu', 'reign-jin-r28-jin-chunqiu', 'reign-jin-r29-jin-chunqiu', 'reign-jin-r30-jin-chunqiu', 'reign-jin-r31-jin-chunqiu', 'reign-jin-r32-jin-chunqiu', 'reign-jin-r33-jin-chunqiu', 'reign-jin-r34-jin-chunqiu', 'reign-jin-r35-jin-chunqiu', 'reign-jin-r36-jin-chunqiu', 'reign-jin-r37-jin-chunqiu', 'reign-jin-r38-jin-chunqiu', 'reign-jin-r39-jin-chunqiu', 'reign-chu-r0-chu-chunqiu', 'reign-chu-r1-chu-chunqiu', 'reign-chu-r2-chu-chunqiu', 'reign-chu-r3-chu-chunqiu', 'reign-chu-r4-chu-chunqiu', 'reign-chu-r5-chu-chunqiu', 'reign-chu-r6-chu-chunqiu', 'reign-chu-r7-chu-chunqiu', 'reign-chu-r8-chu-chunqiu', 'reign-chu-r9-chu-chunqiu', 'reign-chu-r10-chu-chunqiu', 'reign-chu-r11-chu-chunqiu', 'reign-chu-r12-chu-chunqiu', 'reign-chu-r13-chu-chunqiu', 'reign-chu-r14-chu-chunqiu', 'reign-chu-r15-chu-chunqiu', 'reign-chu-r16-chu-chunqiu', 'reign-chu-r17-chu-chunqiu', 'reign-chu-r18-chu-chunqiu', 'reign-chu-r19-chu-chunqiu', 'reign-chu-r20-chu-chunqiu', 'reign-xiong-zhuang-chu-chunqiu', 'reign-chu-r22-chu-chunqiu', 'reign-chu-r23-chu-chunqiu', 'reign-chu-r24-chu-chunqiu', 'reign-chu-r25-chu-chunqiu', 'reign-chu-r26-chu-chunqiu', 'reign-chu-r27-chu-chunqiu', 'reign-chu-r28-chu-chunqiu', 'reign-chu-r29-chu-chunqiu', 'reign-chu-r30-chu-chunqiu', 'reign-chu-r31-chu-chunqiu', 'reign-chu-r32-chu-chunqiu', 'reign-chu-r33-chu-chunqiu', 'reign-chu-r34-chu-chunqiu', 'reign-chu-r35-chu-chunqiu', 'reign-chu-r36-chu-chunqiu', 'reign-chu-r37-chu-chunqiu', 'reign-chu-r38-chu-chunqiu', 'reign-chu-r39-chu-chunqiu', 'reign-chu-r40-chu-chunqiu', 'reign-chu-r41-chu-chunqiu', 'reign-chu-r42-chu-chunqiu', 'reign-chu-r43-chu-chunqiu', 'reign-ji-shi-yan-chunqiu', 'reign-yan-r1-yan-chunqiu', 'reign-yan-r2-yan-chunqiu', 'reign-yan-r3-yan-chunqiu', 'reign-yan-r4-yan-chunqiu', 'reign-yan-r5-yan-chunqiu', 'reign-yan-r6-yan-chunqiu', 'reign-yan-r7-yan-chunqiu', 'reign-yan-r8-yan-chunqiu', 'reign-yan-r9-yan-chunqiu', 'reign-yan-r10-yan-chunqiu', 'reign-yan-r11-yan-chunqiu', 'reign-yan-r12-yan-chunqiu', 'reign-yan-r13-yan-chunqiu', 'reign-yan-r14-yan-chunqiu', 'reign-yan-r15-yan-chunqiu', 'reign-yan-r16-yan-chunqiu', 'reign-yan-r17-yan-chunqiu', 'reign-yan-r18-yan-chunqiu', 'reign-yan-r19-yan-chunqiu', 'reign-yan-r20-yan-chunqiu', 'reign-yan-r21-yan-chunqiu', 'reign-yan-r22-yan-chunqiu', 'reign-yan-r23-yan-chunqiu', 'reign-yan-r24-yan-chunqiu', 'reign-yan-r25-yan-chunqiu', 'reign-yan-r26-yan-chunqiu', 'reign-yan-r27-yan-chunqiu', 'reign-yan-r28-yan-chunqiu', 'reign-yan-r14-yan-chunqiu-2', 'reign-yan-r18-yan-chunqiu-2', 'reign-yan-r31-yan-chunqiu', 'reign-yan-r32-yan-chunqiu', 'reign-yan-r33-yan-chunqiu', 'reign-yan-r34-yan-chunqiu', 'reign-yan-r35-yan-chunqiu', 'reign-yan-r36-yan-chunqiu', 'reign-yan-r37-yan-chunqiu', 'reign-song-weizi-song-chunqiu', 'reign-song-r1-song-chunqiu', 'reign-song-r2-song-chunqiu', 'reign-song-r3-song-chunqiu', 'reign-song-r4-song-chunqiu', 'reign-song-r5-song-chunqiu', 'reign-song-r6-song-chunqiu', 'reign-song-r7-song-chunqiu', 'reign-song-r8-song-chunqiu', 'reign-song-r9-song-chunqiu', 'reign-song-r10-song-chunqiu', 'reign-song-r11-song-chunqiu', 'reign-song-r12-song-chunqiu', 'reign-song-r13-song-chunqiu', 'reign-song-r14-song-chunqiu', 'reign-song-r15-song-chunqiu', 'reign-song-r16-song-chunqiu', 'reign-song-r17-song-chunqiu', 'reign-song-r18-song-chunqiu', 'reign-song-r19-song-chunqiu', 'reign-song-r20-song-chunqiu', 'reign-song-r21-song-chunqiu', 'reign-song-r22-song-chunqiu', 'reign-song-r23-song-chunqiu', 'reign-song-r24-song-chunqiu', 'reign-song-r25-song-chunqiu', 'reign-song-r26-song-chunqiu', 'reign-song-r27-song-chunqiu', 'reign-song-r28-song-chunqiu', 'reign-song-r29-song-chunqiu', 'reign-song-r30-song-chunqiu', 'reign-song-r31-song-chunqiu', 'reign-song-r32-song-chunqiu', 'reign-song-r33-song-chunqiu', 'reign-bo-qin-lu-chunqiu', 'reign-lu-r1-lu-chunqiu', 'reign-lu-r2-lu-chunqiu', 'reign-lu-r3-lu-chunqiu', 'reign-lu-r4-lu-chunqiu', 'reign-lu-r5-lu-chunqiu', 'reign-lu-r6-lu-chunqiu', 'reign-lu-r7-lu-chunqiu', 'reign-lu-r8-lu-chunqiu', 'reign-lu-r9-lu-chunqiu', 'reign-lu-r10-lu-chunqiu', 'reign-lu-r11-lu-chunqiu', 'reign-lu-r12-lu-chunqiu', 'reign-lu-r13-lu-chunqiu', 'reign-lu-r14-lu-chunqiu', 'reign-lu-r15-lu-chunqiu', 'reign-lu-r16-lu-chunqiu', 'reign-lu-r17-lu-chunqiu', 'reign-lu-r18-lu-chunqiu', 'reign-lu-r19-lu-chunqiu', 'reign-lu-r20-lu-chunqiu', 'reign-lu-r21-lu-chunqiu', 'reign-lu-r22-lu-chunqiu', 'reign-lu-r23-lu-chunqiu', 'reign-lu-r24-lu-chunqiu', 'reign-lu-r25-lu-chunqiu', 'reign-lu-r26-lu-chunqiu', 'reign-lu-r27-lu-chunqiu', 'reign-lu-r28-lu-chunqiu', 'reign-lu-r29-lu-chunqiu', 'reign-lu-r30-lu-chunqiu', 'reign-lu-r31-lu-chunqiu', 'reign-lu-r32-lu-chunqiu', 'reign-lu-r33-lu-chunqiu', 'reign-lu-r34-lu-chunqiu', 'reign-weiguo-r0-wei-weiguo', 'reign-weiguo-r1-wei-weiguo', 'reign-weiguo-r2-wei-weiguo', 'reign-weiguo-r3-wei-weiguo', 'reign-weiguo-r4-wei-weiguo', 'reign-weiguo-r5-wei-weiguo', 'reign-weiguo-r6-wei-weiguo', 'reign-weiguo-r7-wei-weiguo', 'reign-weiguo-r8-wei-weiguo', 'reign-weiguo-r9-wei-weiguo', 'reign-weiguo-r10-wei-weiguo', 'reign-weiguo-r11-wei-weiguo', 'reign-weiguo-r12-wei-weiguo', 'reign-weiguo-r13-wei-weiguo', 'reign-weiguo-r14-wei-weiguo', 'reign-weiguo-r15-wei-weiguo', 'reign-weiguo-r16-wei-weiguo', 'reign-weiguo-r15-wei-weiguo-2', 'reign-weiguo-r18-wei-weiguo', 'reign-weiguo-r19-wei-weiguo', 'reign-weiguo-r20-wei-weiguo', 'reign-weiguo-r21-wei-weiguo', 'reign-weiguo-r22-wei-weiguo', 'reign-weiguo-r21-wei-weiguo-2', 'reign-weiguo-r23-wei-weiguo', 'reign-weiguo-r24-wei-weiguo', 'reign-weiguo-r25-wei-weiguo', 'reign-weiguo-r26-wei-weiguo', 'reign-weiguo-r25-wei-weiguo-2', 'reign-weiguo-r28-wei-weiguo', 'reign-weiguo-r29-wei-weiguo', 'reign-weiguo-r30-wei-weiguo', 'reign-weiguo-r31-wei-weiguo', 'reign-weiguo-r32-wei-weiguo', 'reign-weiguo-r33-wei-weiguo', 'reign-weiguo-r30-wei-weiguo-2', 'reign-weiguo-r35-wei-weiguo', 'reign-weiguo-r36-wei-weiguo', 'reign-weiguo-r37-wei-weiguo', 'reign-weiguo-r38-wei-weiguo', 'reign-weiguo-r39-wei-weiguo', 'reign-weiguo-r40-wei-weiguo', 'reign-weiguo-r41-wei-weiguo', 'reign-weiguo-r42-wei-weiguo', 'reign-weiguo-r43-wei-weiguo', 'reign-weiguo-r44-wei-weiguo', 'reign-weiguo-r45-wei-weiguo', 'reign-weiguo-r46-wei-weiguo', 'reign-zheng-r0-zheng-chunqiu', 'reign-zheng-r1-zheng-chunqiu', 'reign-zheng-r2-zheng-chunqiu', 'reign-zheng-r3-zheng-chunqiu', 'reign-zheng-r4-zheng-chunqiu', 'reign-zheng-r3-zheng-chunqiu-2', 'reign-zheng-r6-zheng-chunqiu', 'reign-zheng-r7-zheng-chunqiu', 'reign-zheng-r4-zheng-chunqiu-2', 'reign-zheng-r9-zheng-chunqiu', 'reign-zheng-r10-zheng-chunqiu', 'reign-zheng-r11-zheng-chunqiu', 'reign-zheng-r12-zheng-chunqiu', 'reign-zheng-r13-zheng-chunqiu', 'reign-zheng-r14-zheng-chunqiu', 'reign-zheng-gongzi-xu-zheng-chunqiu', 'reign-zheng-r14-zheng-chunqiu-2', 'reign-zheng-r15-zheng-chunqiu', 'reign-zheng-r16-zheng-chunqiu', 'reign-zheng-r17-zheng-chunqiu', 'reign-zheng-r18-zheng-chunqiu', 'reign-zheng-r19-zheng-chunqiu', 'reign-zheng-r20-zheng-chunqiu', 'reign-zheng-r21-zheng-chunqiu', 'reign-zheng-r22-zheng-chunqiu', 'reign-zheng-r23-zheng-chunqiu', 'reign-zheng-r24-zheng-chunqiu', 'reign-cao-r0-cao-chunqiu', 'reign-cao-r1-cao-chunqiu', 'reign-cao-r2-cao-chunqiu', 'reign-cao-r3-cao-chunqiu', 'reign-cao-r4-cao-chunqiu', 'reign-cao-r5-cao-chunqiu', 'reign-cao-r6-cao-chunqiu', 'reign-cao-r7-cao-chunqiu', 'reign-cao-r8-cao-chunqiu', 'reign-cao-r9-cao-chunqiu', 'reign-cao-r10-cao-chunqiu', 'reign-cao-r11-cao-chunqiu', 'reign-cao-r12-cao-chunqiu', 'reign-cao-r13-cao-chunqiu', 'reign-cao-r14-cao-chunqiu', 'reign-cao-r15-cao-chunqiu', 'reign-cao-r16-cao-chunqiu', 'reign-cao-r17-cao-chunqiu', 'reign-cao-r18-cao-chunqiu', 'reign-cao-r19-cao-chunqiu', 'reign-cao-r20-cao-chunqiu', 'reign-cao-r21-cao-chunqiu', 'reign-cao-r22-cao-chunqiu', 'reign-cao-r23-cao-chunqiu', 'reign-cao-r24-cao-chunqiu', 'reign-cao-r25-cao-chunqiu', 'reign-wu-pre-r0-wu-chunqiu', 'reign-wu-pre-r1-wu-chunqiu', 'reign-wu-pre-r2-wu-chunqiu', 'reign-wu-pre-r3-wu-chunqiu', 'reign-wu-pre-r4-wu-chunqiu', 'reign-wu-pre-r5-wu-chunqiu', 'reign-wu-pre-r6-wu-chunqiu', 'reign-wu-pre-r7-wu-chunqiu', 'reign-wu-pre-r8-wu-chunqiu', 'reign-wu-pre-r9-wu-chunqiu', 'reign-wu-pre-r10-wu-chunqiu', 'reign-wu-pre-r11-wu-chunqiu', 'reign-wu-pre-r12-wu-chunqiu', 'reign-wu-pre-r13-wu-chunqiu', 'reign-wu-pre-r14-wu-chunqiu', 'reign-wu-pre-r15-wu-chunqiu', 'reign-wu-pre-r16-wu-chunqiu', 'reign-wu-pre-r17-wu-chunqiu', 'reign-wu-r0-wu-chunqiu', 'reign-wu-r1-wu-chunqiu', 'reign-wu-r2-wu-chunqiu', 'reign-wu-r3-wu-chunqiu', 'reign-wu-r4-wu-chunqiu', 'reign-helu-wu-chunqiu', 'reign-wu-fu-gai-wu-chunqiu', 'reign-fu-chai-wu-chunqiu', 'reign-yue-r3-yue-chunqiu', 'reign-yue-r4-yue-chunqiu', 'reign-gou-jian-yue-chunqiu', 'reign-yue-r6-yue-chunqiu', 'reign-yue-r7-yue-chunqiu', 'reign-yue-r8-yue-chunqiu', 'reign-yue-r9-yue-chunqiu', 'reign-yue-r10-yue-chunqiu', 'reign-yue-r11-yue-chunqiu', 'reign-yue-r12-yue-chunqiu', 'reign-yue-r13-yue-chunqiu', 'reign-zhongshan-r0-zhongshan', 'reign-zhongshan-r1-zhongshan', 'reign-zhongshan-r2-zhongshan', 'reign-zhongshan-r2-zhongshan-2', 'reign-zhongshan-r3-zhongshan', 'reign-zhongshan-r4-zhongshan', 'reign-zhongshan-r5-zhongshan', 'reign-zhongshan-r6-zhongshan', 'reign-han-jing-han-warring', 'reign-han-r1-han-warring', 'reign-han-r2-han-warring', 'reign-han-r3-han-warring', 'reign-han-r4-han-warring', 'reign-han-r5-han-warring', 'reign-han-r6-han-warring', 'reign-han-r7-han-warring', 'reign-han-r8-han-warring', 'reign-han-r9-han-warring', 'reign-han-r10-han-warring', 'reign-zhao-lie-zhao-warring', 'reign-zhao-r1-zhao-warring', 'reign-zhao-r2-zhao-warring', 'reign-zhao-r3-zhao-warring', 'reign-zhao-r4-zhao-warring', 'reign-zhao-r5-zhao-warring', 'reign-zhao-r6-zhao-warring', 'reign-zhao-r7-zhao-warring', 'reign-zhao-r8-zhao-warring', 'reign-zhao-r9-zhao-warring', 'reign-wei-wen-wei-warring', 'reign-wei-r1-wei-warring', 'reign-wei-r2-wei-warring', 'reign-wei-r3-wei-warring', 'reign-wei-r4-wei-warring', 'reign-wei-r5-wei-warring', 'reign-wei-r6-wei-warring', 'reign-wei-r7-wei-warring', 'reign-ying-qi-qin', 'reign-qin-r1-qin', 'reign-qin-r2-qin', 'reign-qin-r3-qin', 'reign-qin-r4-qin', 'reign-qin-r5-qin', 'reign-qin-r6-qin', 'reign-qin-r7-qin', 'reign-qin-r8-qin', 'reign-qin-r9-qin', 'reign-qin-r10-qin', 'reign-qin-r11-qin', 'reign-qin-r12-qin', 'reign-qin-r13-qin', 'reign-qin-r14-qin', 'reign-qin-r15-qin', 'reign-qin-r16-qin', 'reign-qin-r17-qin', 'reign-qin-r18-qin', 'reign-qin-r19-qin', 'reign-qin-r20-qin', 'reign-qin-r21-qin', 'reign-qin-r22-qin', 'reign-qin-r23-qin', 'reign-ying-quliang-qin', 'reign-qin-r25-qin', 'reign-qin-r26-qin', 'reign-qin-r27-qin', 'reign-qin-r28-qin', 'reign-qin-r29-qin', 'reign-ying-zheng-qin', 'reign-ying-zheng', 'reign-ying-huhai', 'reign-ying-ziying')
  RETURNING person_id
)
DELETE FROM persons p
WHERE p.id IN (SELECT DISTINCT person_id FROM stale)
  AND NOT EXISTS (SELECT 1 FROM reigns r WHERE r.person_id = p.id)
  AND NOT EXISTS (SELECT 1 FROM event_participants ep WHERE ep.person_id = p.id)
  AND NOT EXISTS (
    SELECT 1 FROM relations rel
    WHERE (rel.from_type = 'person' AND rel.from_id = p.id)
       OR (rel.to_type = 'person' AND rel.to_id = p.id)
  );

-- Drop ruler persons left behind by earlier imports
DELETE FROM persons p
WHERE p.id NOT IN ('zou-r1', 'zou-r2', 'zou-r3', 'zou-r4', 'zou-r5', 'zou-r6', 'zou-r7', 'zou-r8', 'zou-r9', 'system-missing-ruler', 'zou-r11', 'zou-r12', 'zou-r13', 'zou-r14', 'zou-r15', 'zou-r16', 'zou-r17', 'zou-r18', 'zou-mu-gong', 'lv-shang', 'qi-r1', 'qi-r2', 'qi-r3', 'qi-r4', 'qi-r5', 'qi-r6', 'qi-r7', 'qi-r8', 'qi-r9', 'qi-r10', 'qi-r11', 'qi-r12', 'qi-r13', 'qi-r14', 'jiang-xiaobai', 'qi-r16', 'qi-r17', 'qi-r18', 'qi-r19', 'qi-r20', 'qi-r21', 'qi-r22', 'qi-r23', 'qi-r24', 'qi-r25', 'qi-r26', 'qi-r27', 'qi-r28', 'qi-r29', 'qi-r30', 'jiang-dai', 'tian-he', 'qi-r33', 'qi-r34', 'qi-r35', 'qi-r36', 'qi-r37', 'qi-r38', 'qi-r39', 'ji-shuyu', 'jin-r1', 'jin-r2', 'jin-r3', 'jin-r4', 'jin-r5', 'jin-r6', 'jin-r7', 'jin-r8', 'jin-r9', 'jin-r10', 'jin-r11', 'jin-r12', 'jin-r13', 'jin-r14', 'jin-r15', 'jin-r16', 'jin-r17', 'jin-r18', 'jin-r19', 'jin-r20', 'jin-r21', 'jin-r22', 'ji-chonger', 'jin-r24', 'jin-r25', 'jin-r26', 'jin-r27', 'jin-r28', 'jin-r29', 'jin-r30', 'jin-r31', 'jin-r32', 'jin-r33', 'jin-r34', 'jin-r35', 'jin-r36', 'jin-r37', 'jin-r38', 'jin-r39', 'chu-r0', 'chu-r1', 'chu-r2', 'chu-r3', 'chu-r4', 'chu-r5', 'chu-r6', 'chu-r7', 'chu-r8', 'chu-r9', 'chu-r10', 'chu-r11', 'chu-r12', 'chu-r13', 'chu-r14', 'chu-r15', 'chu-r16', 'chu-r17', 'chu-r18', 'chu-r19', 'chu-r20', 'xiong-zhuang', 'chu-r22', 'chu-r23', 'chu-r24', 'chu-r25', 'chu-r26', 'chu-r27', 'chu-r28', 'chu-r29', 'chu-r30', 'chu-r31', 'chu-r32', 'chu-r33', 'chu-r34', 'chu-r35', 'chu-r36', 'chu-r37', 'chu-r38', 'chu-r39', 'chu-r40', 'chu-r41', 'chu-r42', 'chu-r43', 'ji-shi', 'yan-r1', 'yan-r2', 'yan-r3', 'yan-r4', 'yan-r5', 'yan-r6', 'yan-r7', 'yan-r8', 'yan-r9', 'yan-r10', 'yan-r11', 'yan-r12', 'yan-r13', 'yan-r14', 'yan-r15', 'yan-r16', 'yan-r17', 'yan-r18', 'yan-r19', 'yan-r20', 'yan-r21', 'yan-r22', 'yan-r23', 'yan-r24', 'yan-r25', 'yan-r26', 'yan-r27', 'yan-r28', 'yan-r31', 'yan-r32', 'yan-r33', 'yan-r34', 'yan-r35', 'yan-r36', 'yan-r37', 'song-weizi', 'song-r1', 'song-r2', 'song-r3', 'song-r4', 'song-r5', 'song-r6', 'song-r7', 'song-r8', 'song-r9', 'song-r10', 'song-r11', 'song-r12', 'song-r13', 'song-r14', 'song-r15', 'song-r16', 'song-r17', 'song-r18', 'song-r19', 'song-r20', 'song-r21', 'song-r22', 'song-r23', 'song-r24', 'song-r25', 'song-r26', 'song-r27', 'song-r28', 'song-r29', 'song-r30', 'song-r31', 'song-r32', 'song-r33', 'bo-qin', 'lu-r1', 'lu-r2', 'lu-r3', 'lu-r4', 'lu-r5', 'lu-r6', 'lu-r7', 'lu-r8', 'lu-r9', 'lu-r10', 'lu-r11', 'lu-r12', 'lu-r13', 'lu-r14', 'lu-r15', 'lu-r16', 'lu-r17', 'lu-r18', 'lu-r19', 'lu-r20', 'lu-r21', 'lu-r22', 'lu-r23', 'lu-r24', 'lu-r25', 'lu-r26', 'lu-r27', 'lu-r28', 'lu-r29', 'lu-r30', 'lu-r31', 'lu-r32', 'lu-r33', 'lu-r34', 'weiguo-r0', 'weiguo-r1', 'weiguo-r2', 'weiguo-r3', 'weiguo-r4', 'weiguo-r5', 'weiguo-r6', 'weiguo-r7', 'weiguo-r8', 'weiguo-r9', 'weiguo-r10', 'weiguo-r11', 'weiguo-r12', 'weiguo-r13', 'weiguo-r14', 'weiguo-r15', 'weiguo-r16', 'weiguo-r18', 'weiguo-r19', 'weiguo-r20', 'weiguo-r21', 'weiguo-r22', 'weiguo-r23', 'weiguo-r24', 'weiguo-r25', 'weiguo-r26', 'weiguo-r28', 'weiguo-r29', 'weiguo-r30', 'weiguo-r31', 'weiguo-r32', 'weiguo-r33', 'weiguo-r35', 'weiguo-r36', 'weiguo-r37', 'weiguo-r38', 'weiguo-r39', 'weiguo-r40', 'weiguo-r41', 'weiguo-r42', 'weiguo-r43', 'weiguo-r44', 'weiguo-r45', 'weiguo-r46', 'zheng-r0', 'zheng-r1', 'zheng-r2', 'zheng-r3', 'zheng-r4', 'zheng-r6', 'zheng-r7', 'zheng-r9', 'zheng-r10', 'zheng-r11', 'zheng-r12', 'zheng-r13', 'zheng-r14', 'zheng-gongzi-xu', 'zheng-r15', 'zheng-r16', 'zheng-r17', 'zheng-r18', 'zheng-r19', 'zheng-r20', 'zheng-r21', 'zheng-r22', 'zheng-r23', 'zheng-r24', 'cao-r0', 'cao-r1', 'cao-r2', 'cao-r3', 'cao-r4', 'cao-r5', 'cao-r6', 'cao-r7', 'cao-r8', 'cao-r9', 'cao-r10', 'cao-r11', 'cao-r12', 'cao-r13', 'cao-r14', 'cao-r15', 'cao-r16', 'cao-r17', 'cao-r18', 'cao-r19', 'cao-r20', 'cao-r21', 'cao-r22', 'cao-r23', 'cao-r24', 'cao-r25', 'wu-pre-r0', 'wu-pre-r1', 'wu-pre-r2', 'wu-pre-r3', 'wu-pre-r4', 'wu-pre-r5', 'wu-pre-r6', 'wu-pre-r7', 'wu-pre-r8', 'wu-pre-r9', 'wu-pre-r10', 'wu-pre-r11', 'wu-pre-r12', 'wu-pre-r13', 'wu-pre-r14', 'wu-pre-r15', 'wu-pre-r16', 'wu-pre-r17', 'wu-r0', 'wu-r1', 'wu-r2', 'wu-r3', 'wu-r4', 'helu', 'wu-fu-gai', 'fu-chai', 'yue-r3', 'yue-r4', 'gou-jian', 'yue-r6', 'yue-r7', 'yue-r8', 'yue-r9', 'yue-r10', 'yue-r11', 'yue-r12', 'yue-r13', 'zhongshan-r0', 'zhongshan-r1', 'zhongshan-r2', 'zhongshan-r3', 'zhongshan-r4', 'zhongshan-r5', 'zhongshan-r6', 'han-jing', 'han-r1', 'han-r2', 'han-r3', 'han-r4', 'han-r5', 'han-r6', 'han-r7', 'han-r8', 'han-r9', 'han-r10', 'zhao-lie', 'zhao-r1', 'zhao-r2', 'zhao-r3', 'zhao-r4', 'zhao-r5', 'zhao-r6', 'zhao-r7', 'zhao-r8', 'zhao-r9', 'wei-wen', 'wei-r1', 'wei-r2', 'wei-r3', 'wei-r4', 'wei-r5', 'wei-r6', 'wei-r7', 'ying-qi', 'qin-r1', 'qin-r2', 'qin-r3', 'qin-r4', 'qin-r5', 'qin-r6', 'qin-r7', 'qin-r8', 'qin-r9', 'qin-r10', 'qin-r11', 'qin-r12', 'qin-r13', 'qin-r14', 'qin-r15', 'qin-r16', 'qin-r17', 'qin-r18', 'qin-r19', 'qin-r20', 'qin-r21', 'qin-r22', 'qin-r23', 'ying-quliang', 'qin-r25', 'qin-r26', 'qin-r27', 'qin-r28', 'qin-r29', 'ying-zheng', 'shang-yang', 'wu-qi', 'sun-wu', 'wu-zixu', 'fan-li', 'qu-yuan', 'lao-zi', 'meng-ke', 'zhuang-zhou', 'han-fei', 'sun-bin', 'bai-qi', 'wang-jian-qin', 'bian-que', 'ying-huhai', 'ying-ziying')
  AND NOT EXISTS (SELECT 1 FROM reigns r WHERE r.person_id = p.id)
  AND NOT EXISTS (SELECT 1 FROM event_participants ep WHERE ep.person_id = p.id)
  AND NOT EXISTS (
    SELECT 1 FROM relations rel
    WHERE (rel.from_type = 'person' AND rel.from_id = p.id)
       OR (rel.to_type = 'person' AND rel.to_id = p.id)
  );

COMMIT;
