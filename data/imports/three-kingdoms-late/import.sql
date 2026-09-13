-- EraLens period import: three-kingdoms-late
-- Window: 239-01 .. 280-05
BEGIN;

-- persons
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('cao-fang', '曹芳', 231, 1, 274, 1, ARRAY['皇帝'], '曹魏第三位皇帝，魏明帝之子，后被司马师废为齐王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹芳"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('cao-mao', '曹髦', 241, 1, 260, 5, ARRAY['皇帝'], '曹魏第四位皇帝，文帝孙，甘露五年被司马昭部卒所害。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹髦"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('cao-huan', '曹奂', 246, 1, 302, 1, ARRAY['皇帝'], '曹魏末代皇帝，咸熙二年禅位于司马炎，曹魏终结。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹奂"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('sun-xiu', '孙休', 235, 1, 264, 9, ARRAY['皇帝'], '孙吴第三位皇帝，孙权第六子，在位期间整顿吏治。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孙休"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('sun-hao', '孙皓', 242, 1, 284, 1, ARRAY['皇帝'], '孙吴末代皇帝，天纪四年降于晋，孙吴亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孙皓"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;

-- dynasties

-- reigns
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-cao-fang', 'wei', 'cao-fang', '魏少帝', '邵陵厉王', NULL, '{"kind":"posthumous","name":"魏少帝"}'::jsonb, 239, 1, 254, 10, 2868, 3057, 'month')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-cao-mao', 'wei', 'cao-mao', '魏废帝', '高贵乡公', NULL, '{"kind":"posthumous","name":"魏废帝"}'::jsonb, 254, 10, 260, 5, 3057, 3124, 'month')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-cao-huan', 'wei', 'cao-huan', '魏元帝', '元皇帝', NULL, '{"kind":"posthumous","name":"魏元帝"}'::jsonb, 260, 6, 266, 2, 3125, 3193, 'month')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-sun-xiu', 'wu', 'sun-xiu', '吴景帝', '景皇帝', NULL, '{"kind":"posthumous","name":"吴景帝"}'::jsonb, 258, 11, 264, 9, 3106, 3176, 'month')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-sun-hao', 'wu', 'sun-hao', '吴末帝', '乌程侯', NULL, '{"kind":"posthumous","name":"吴末帝"}'::jsonb, 264, 9, 280, 5, 3176, 3364, 'month')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;

-- era_names
DELETE FROM era_names WHERE reign_id = 'reign-cao-fang';
DELETE FROM era_names WHERE reign_id = 'reign-cao-mao';
DELETE FROM era_names WHERE reign_id = 'reign-cao-huan';
DELETE FROM era_names WHERE reign_id = 'reign-sun-xiu';
DELETE FROM era_names WHERE reign_id = 'reign-sun-hao';
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-cao-fang', '正始', 239, 1, 249, 12, 2868, 2999, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-cao-fang', '嘉平', 249, 1, 254, 10, 2988, 3057, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-cao-mao', '正元', 254, 10, 256, 12, 3057, 3083, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-cao-mao', '甘露', 257, 1, 260, 5, 3084, 3124, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-cao-huan', '景元', 260, 6, 263, 12, 3125, 3167, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-cao-huan', '咸熙', 264, 1, 266, 2, 3168, 3193, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-sun-xiu', '永安', 258, 11, 264, 9, 3106, 3176, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-sun-hao', '元兴', 264, 9, 265, 12, 3176, 3191, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-sun-hao', '甘露', 265, 1, 266, 12, 3180, 3203, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-sun-hao', '宝鼎', 266, 1, 269, 12, 3192, 3239, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-sun-hao', '建兴', 269, 1, 271, 12, 3228, 3263, 3);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-sun-hao', '凤凰', 272, 1, 274, 12, 3264, 3299, 4);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-sun-hao', '天册', 275, 1, 275, 12, 3300, 3311, 5);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-sun-hao', '天玺', 276, 1, 276, 12, 3312, 3323, 6);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-sun-hao', '天纪', 277, 1, 280, 5, 3324, 3364, 7);

-- events

-- event_dynasties

-- event_participants

-- relations
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-cao-fang-cao-mao-succession', 'person', 'cao-fang', 'person', 'cao-mao', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-cao-mao-cao-huan-succession', 'person', 'cao-mao', 'person', 'cao-huan', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-sun-xiu-sun-hao-succession', 'person', 'sun-xiu', 'person', 'sun-hao', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-cao-rui-cao-fang-succession', 'person', 'cao-rui', 'person', 'cao-fang', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-sun-liang-sun-xiu-succession', 'person', 'sun-liang', 'person', 'sun-xiu', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;

COMMIT;
