-- EraLens period import: song-liao-jin
-- Window: 916-01 .. 1234-12
BEGIN;

-- persons
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelu-abaoji', '耶律阿保机', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '辽太祖，统一契丹，916年称帝建大契丹。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/耶律阿保机"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelu-deguang', '耶律德光', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '辽太宗，灭后晋，947年改国号大辽。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/耶律德光"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelu-ruan', '耶律阮', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '辽世宗，太宗之子，在位五年遇弑。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/耶律阮"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelu-jing', '耶律璟', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '辽穆宗，酗酒嗜杀，近侍弑之。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/耶律璟"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelu-xian', '耶律贤', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '辽景宗，整顿吏治，为圣宗盛世奠基。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/耶律贤"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelu-longxu', '耶律隆绪', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '辽圣宗，萧太后摄政，与宋订澶渊之盟。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/耶律隆绪"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelu-zongzhen', '耶律宗真', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '辽兴宗，在位期间辽势仍强。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/耶律宗真"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelu-hongji', '耶律洪基', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '辽道宗，在位长久，后期辽政日衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/耶律洪基"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yelu-yanxi', '耶律延禧', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '辽天祚帝，1125年被金俘，辽亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/耶律延禧"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('wanyan-aguda', '完颜阿骨打', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '金太祖，统一女真，1115年建国反辽。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/完颜阿骨打"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('wanyan-sheng', '完颜晟', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '金太宗，继续攻辽灭宋，占中原。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/完颜晟"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('wanyan-dan', '完颜亶', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '金熙宗，推行汉化，后被弑。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/完颜亶"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('wanyan-liang', '完颜亮', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '海陵王，迁都中都，1161年采石之战败亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/完颜亮"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('wanyan-yong', '完颜雍', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '金世宗，大定之治，金朝中兴。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/完颜雍"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('wanyan-jing', '完颜璟', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '金章宗，在位期间金势尚盛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/完颜璟"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('wanyan-yongji', '完颜永济', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '卫绍王，蒙古入侵时被弑。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/完颜永济"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('wanyan-xun', '完颜珣', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '金宣宗，迁都南京，蒙金战争加剧。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/完颜珣"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('wanyan-shouxu', '完颜守绪', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '金哀宗，1234年蔡州陷落，金亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/完颜守绪"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('wanyan-chenglin', '完颜承麟', NULL, NULL, NULL, NULL, ARRAY['皇帝'], '金末帝，即位不足一日即战死。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/完颜承麟"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yue-fei', '岳飞', 1103, 1, 1142, 1, ARRAY['军事家'], '南宋抗金名将，郾城大捷，后被秦桧害死。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/岳飞"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('yu-yunwen', '虞允文', 1110, 1, 1174, 1, ARRAY['军事家','政治家'], '采石之战大败金军，阻止金军渡江。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/虞允文"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('qin-hui', '秦桧', 1090, 1, 1155, 1, ARRAY['政治家'], '南宋权臣，主和议，害岳飞。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦桧"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('kou-zhun', '寇准', 961, 1, 1023, 1, ARRAY['政治家'], '北宋名相，真宗朝力主御驾亲征，促成澶渊之盟。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/寇准"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES ('xiao-chuo', '萧绰', 953, 1, 1009, 1, ARRAY['政治家'], '辽景宗皇后，圣宗朝萧太后，摄政多年，与宋订澶渊之盟。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧绰"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links;

-- dynasties
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, parent_id, note)
VALUES ('liao', '辽', ARRAY['契丹','大辽'], 'cn', 'east_asia', 916, 1, 1125, 1, 10992, 13500, 'year', 'ochre', NULL, '契丹耶律氏，916年太祖称帝；1125年金灭辽。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, note = EXCLUDED.note;
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, parent_id, note)
VALUES ('jin-nvzhen', '金', ARRAY['大金','女真金'], 'cn', 'east_asia', 1115, 1, 1234, 1, 13380, 14808, 'year', 'azure', NULL, '女真完颜氏，1115年太祖建国；1234年蒙古灭金。id 为 jin-nvzhen，避免与两晋/后晋 jin-* 冲突。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, color_token = EXCLUDED.color_token, note = EXCLUDED.note;

-- reigns
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-yelu-abaoji-liao', 'liao', 'yelu-abaoji', '辽太祖', NULL, '太祖', '{"kind":"temple","name":"辽太祖"}'::jsonb, 916, 1, 926, 12, 10992, 11123, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-yelu-deguang-liao', 'liao', 'yelu-deguang', '辽太宗', NULL, '太宗', '{"kind":"temple","name":"辽太宗"}'::jsonb, 927, 1, 947, 12, 11124, 11375, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-yelu-ruan-liao', 'liao', 'yelu-ruan', '辽世宗', NULL, '世宗', '{"kind":"temple","name":"辽世宗"}'::jsonb, 947, 1, 951, 12, 11364, 11423, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-yelu-jing-liao', 'liao', 'yelu-jing', '辽穆宗', NULL, '穆宗', '{"kind":"temple","name":"辽穆宗"}'::jsonb, 951, 1, 969, 12, 11412, 11639, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-yelu-xian-liao', 'liao', 'yelu-xian', '辽景宗', NULL, '景宗', '{"kind":"temple","name":"辽景宗"}'::jsonb, 969, 1, 982, 12, 11628, 11795, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-yelu-longxu-liao', 'liao', 'yelu-longxu', '辽圣宗', NULL, '圣宗', '{"kind":"temple","name":"辽圣宗"}'::jsonb, 982, 1, 1031, 12, 11784, 12383, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-yelu-zongzhen-liao', 'liao', 'yelu-zongzhen', '辽兴宗', NULL, '兴宗', '{"kind":"temple","name":"辽兴宗"}'::jsonb, 1031, 1, 1055, 12, 12372, 12671, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-yelu-hongji-liao', 'liao', 'yelu-hongji', '辽道宗', NULL, '道宗', '{"kind":"temple","name":"辽道宗"}'::jsonb, 1055, 1, 1101, 12, 12660, 13223, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-yelu-yanxi-liao', 'liao', 'yelu-yanxi', '辽天祚帝', NULL, NULL, '{"kind":"posthumous","name":"辽天祚帝"}'::jsonb, 1101, 1, 1125, 12, 13212, 13511, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-wanyan-aguda-jin-nvzhen', 'jin-nvzhen', 'wanyan-aguda', '金太祖', NULL, '太祖', '{"kind":"temple","name":"金太祖"}'::jsonb, 1115, 1, 1123, 12, 13380, 13487, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-wanyan-sheng-jin-nvzhen', 'jin-nvzhen', 'wanyan-sheng', '金太宗', NULL, '太宗', '{"kind":"temple","name":"金太宗"}'::jsonb, 1123, 1, 1135, 12, 13476, 13631, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-wanyan-dan-jin-nvzhen', 'jin-nvzhen', 'wanyan-dan', '金熙宗', NULL, '熙宗', '{"kind":"temple","name":"金熙宗"}'::jsonb, 1135, 1, 1149, 12, 13620, 13799, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-wanyan-liang-jin-nvzhen', 'jin-nvzhen', 'wanyan-liang', '海陵王', NULL, NULL, '{"kind":"regnal","name":"海陵王"}'::jsonb, 1149, 1, 1161, 12, 13788, 13943, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-wanyan-yong-jin-nvzhen', 'jin-nvzhen', 'wanyan-yong', '金世宗', NULL, '世宗', '{"kind":"temple","name":"金世宗"}'::jsonb, 1161, 1, 1189, 12, 13932, 14279, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-wanyan-jing-jin-nvzhen', 'jin-nvzhen', 'wanyan-jing', '金章宗', NULL, '章宗', '{"kind":"temple","name":"金章宗"}'::jsonb, 1189, 1, 1208, 12, 14268, 14507, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-wanyan-yongji-jin-nvzhen', 'jin-nvzhen', 'wanyan-yongji', '卫绍王', NULL, NULL, '{"kind":"regnal","name":"卫绍王"}'::jsonb, 1208, 1, 1213, 12, 14496, 14567, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-wanyan-xun-jin-nvzhen', 'jin-nvzhen', 'wanyan-xun', '金宣宗', NULL, '宣宗', '{"kind":"temple","name":"金宣宗"}'::jsonb, 1213, 1, 1223, 12, 14556, 14687, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-wanyan-shouxu-jin-nvzhen', 'jin-nvzhen', 'wanyan-shouxu', '金哀宗', NULL, '哀宗', '{"kind":"temple","name":"金哀宗"}'::jsonb, 1223, 1, 1234, 12, 14676, 14819, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;
INSERT INTO reigns (id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation, start_year, start_month, end_year, end_month, start_abs, end_abs, precision)
VALUES ('reign-wanyan-chenglin-jin-nvzhen', 'jin-nvzhen', 'wanyan-chenglin', '金末帝', NULL, NULL, '{"kind":"posthumous","name":"金末帝"}'::jsonb, 1234, 1, 1234, 12, 14808, 14819, 'year')
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, preferred_appellation = EXCLUDED.preferred_appellation, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision;

-- era_names
DELETE FROM era_names WHERE reign_id = 'reign-yelu-abaoji-liao';
DELETE FROM era_names WHERE reign_id = 'reign-yelu-longxu-liao';
DELETE FROM era_names WHERE reign_id = 'reign-wanyan-aguda-jin-nvzhen';
DELETE FROM era_names WHERE reign_id = 'reign-wanyan-yong-jin-nvzhen';
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-yelu-abaoji-liao', '神册', 916, 1, 922, 12, 10992, 11075, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-yelu-abaoji-liao', '天赞', 922, 1, 926, 12, 11064, 11123, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-yelu-longxu-liao', '统和', 983, 1, 1012, 12, 11796, 12155, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-yelu-longxu-liao', '开泰', 1012, 1, 1021, 12, 12144, 12263, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-yelu-longxu-liao', '太平', 1021, 1, 1031, 12, 12252, 12383, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-wanyan-aguda-jin-nvzhen', '收国', 1115, 1, 1116, 12, 13380, 13403, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-wanyan-aguda-jin-nvzhen', '天辅', 1117, 1, 1123, 12, 13404, 13487, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-wanyan-yong-jin-nvzhen', '大定', 1161, 1, 1189, 12, 13932, 14279, 0);

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('chanyuan-treaty', '澶渊之盟', 'politics', 'point', 'year', NULL, 1004, 1, 12048, NULL, NULL, NULL, NULL, NULL, NULL, '宋真宗与辽圣宗订立和约，宋岁赐辽银绢，双方罢兵。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('jin-founded', '金朝建立', 'politics', 'point', 'year', NULL, 1115, 1, 13380, NULL, NULL, NULL, NULL, NULL, NULL, '完颜阿骨打称帝，国号大金，起兵反辽。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('jin-destroy-liao', '金灭辽', 'battle', 'point', 'year', '1125年俘天祚帝', 1125, 1, 13500, NULL, NULL, NULL, NULL, NULL, NULL, '金军俘辽天祚帝耶律延禧，辽朝灭亡。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('yancheng-battle', '郾城之战', 'battle', 'point', 'year', NULL, 1140, 1, 13680, NULL, NULL, NULL, NULL, NULL, NULL, '岳飞率岳家军大败金军，收复中原要地。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('shaoxing-treaty', '绍兴和议', 'politics', 'point', 'year', NULL, 1141, 1, 13692, NULL, NULL, NULL, NULL, NULL, NULL, '宋金议和，割地纳贡，岳飞被害，南北对峙格局确立。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('caishi-battle', '采石之战', 'battle', 'point', 'year', NULL, 1161, 1, 13932, NULL, NULL, NULL, NULL, NULL, NULL, '虞允文督师采石，大败金军，完颜亮兵败被杀。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('kaixi-expedition', '开禧北伐', 'battle', 'span', 'year', NULL, NULL, NULL, NULL, 1206, 1, 14472, 1208, 1, 14496, '宋宁宗朝北伐金朝，初战告捷后失利，嘉定和议复归对峙。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary) VALUES ('song-jin-alliance-mongol', '联蒙灭金', 'politics', 'point', 'year', '1234年蔡州陷落', 1234, 1, 14808, NULL, NULL, NULL, NULL, NULL, NULL, '宋蒙结盟攻金，金哀宗殉国，金朝灭亡；宋随即遭蒙古南侵。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;

-- event_dynasties
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chanyuan-treaty', 'liao') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chanyuan-treaty', 'song-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('jin-founded', 'jin-nvzhen') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('jin-destroy-liao', 'jin-nvzhen') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('jin-destroy-liao', 'liao') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yancheng-battle', 'song-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yancheng-battle', 'jin-nvzhen') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('shaoxing-treaty', 'song-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('shaoxing-treaty', 'jin-nvzhen') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('caishi-battle', 'song-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('caishi-battle', 'jin-nvzhen') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('kaixi-expedition', 'song-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('kaixi-expedition', 'jin-nvzhen') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('song-jin-alliance-mongol', 'song-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('song-jin-alliance-mongol', 'jin-nvzhen') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('jingkang-incident', 'jin-nvzhen') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('song-south-founded', 'jin-nvzhen') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('jingkang-incident', 'liao') ON CONFLICT DO NOTHING;

-- event_participants
INSERT INTO event_participants (event_id, person_id) VALUES ('chanyuan-treaty', 'yelu-longxu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chanyuan-treaty', 'zhao-heng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('jin-founded', 'wanyan-aguda') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('jin-destroy-liao', 'wanyan-sheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('jin-destroy-liao', 'yelu-yanxi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yancheng-battle', 'yue-fei') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('shaoxing-treaty', 'zhao-gou') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('shaoxing-treaty', 'qin-hui') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('caishi-battle', 'yu-yunwen') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('caishi-battle', 'wanyan-liang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('kaixi-expedition', 'zhao-kuo') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('song-jin-alliance-mongol', 'zhao-yun') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('song-jin-alliance-mongol', 'wanyan-shouxu') ON CONFLICT DO NOTHING;

-- relations
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-yelu-abaoji-yelu-deguang-succession', 'person', 'yelu-abaoji', 'person', 'yelu-deguang', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-yelu-deguang-yelu-ruan-succession', 'person', 'yelu-deguang', 'person', 'yelu-ruan', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-yelu-ruan-yelu-jing-succession', 'person', 'yelu-ruan', 'person', 'yelu-jing', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-yelu-jing-yelu-xian-succession', 'person', 'yelu-jing', 'person', 'yelu-xian', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-yelu-xian-yelu-longxu-succession', 'person', 'yelu-xian', 'person', 'yelu-longxu', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-yelu-longxu-yelu-zongzhen-succession', 'person', 'yelu-longxu', 'person', 'yelu-zongzhen', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-yelu-zongzhen-yelu-hongji-succession', 'person', 'yelu-zongzhen', 'person', 'yelu-hongji', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-yelu-hongji-yelu-yanxi-succession', 'person', 'yelu-hongji', 'person', 'yelu-yanxi', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-wanyan-aguda-wanyan-sheng-succession', 'person', 'wanyan-aguda', 'person', 'wanyan-sheng', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-wanyan-sheng-wanyan-dan-succession', 'person', 'wanyan-sheng', 'person', 'wanyan-dan', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-wanyan-dan-wanyan-liang-succession', 'person', 'wanyan-dan', 'person', 'wanyan-liang', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-wanyan-liang-wanyan-yong-succession', 'person', 'wanyan-liang', 'person', 'wanyan-yong', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-wanyan-yong-wanyan-jing-succession', 'person', 'wanyan-yong', 'person', 'wanyan-jing', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-wanyan-jing-wanyan-yongji-succession', 'person', 'wanyan-jing', 'person', 'wanyan-yongji', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-wanyan-yongji-wanyan-xun-succession', 'person', 'wanyan-yongji', 'person', 'wanyan-xun', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-wanyan-xun-wanyan-shouxu-succession', 'person', 'wanyan-xun', 'person', 'wanyan-shouxu', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-wanyan-shouxu-wanyan-chenglin-succession', 'person', 'wanyan-shouxu', 'person', 'wanyan-chenglin', 'succession') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-chanyuan-liao-song', 'event', 'chanyuan-treaty', 'dynasty', 'liao', 'alliance') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-yancheng-yue-fei', 'event', 'yancheng-battle', 'person', 'yue-fei', 'battle') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-caishi-yu-yunwen', 'event', 'caishi-battle', 'person', 'yu-yunwen', 'battle') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES ('rel-jin-destroy-liao', 'event', 'jin-destroy-liao', 'dynasty', 'liao', 'battle') ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;

COMMIT;
