-- EraLens period import: poetry
-- Window: -475-01 .. 1898-12
BEGIN;

-- cleanup
DELETE FROM event_dynasties WHERE event_id = 'poetry-yuanyuanqu';
DELETE FROM event_participants WHERE event_id = 'poetry-yuanyuanqu';
DELETE FROM events WHERE id = 'poetry-yuanyuanqu';
DELETE FROM persons WHERE id = 'wu-meicun' AND NOT EXISTS (SELECT 1 FROM event_participants WHERE person_id = 'wu-meicun') AND NOT EXISTS (SELECT 1 FROM reigns WHERE person_id = 'wu-meicun');

-- persons
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wang-can', '王粲', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','文学家'], '东汉末建安七子之一，作品反映汉末战乱。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王粲"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('tao-yuanming', '陶渊明', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','文学家'], '东晋诗人，田园诗代表。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/陶渊明"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('meng-hao-ran', '孟浩然', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人'], '盛唐山水田园诗人。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孟浩然"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wang-zhi-huan', '王之涣', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人'], '盛唐边塞诗人，《登鹳雀楼》《凉州词》作者。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王之涣"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wang-chang-ling', '王昌龄', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人'], '盛唐边塞诗代表诗人。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王昌龄"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('cui-hao', '崔颢', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人'], '盛唐诗人，《黄鹤楼》作者。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/崔颢"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('du-fu', '杜甫', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','文学家'], '盛唐诗人，诗圣，现实主义诗歌代表。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/杜甫"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('li-bai', '李白', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','文学家'], '盛唐诗人，诗仙，浪漫主义诗歌代表。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李白"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhang-ji', '张继', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人'], '中唐诗人，《枫桥夜泊》作者。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/张继"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('liu-zong-yuan', '柳宗元', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','文学家','政治家'], '中唐文学家、政治家，唐宋八大家之一。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/柳宗元"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('meng-jiao', '孟郊', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人'], '中唐诗人，以苦吟和乐府诗著称。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孟郊"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('li-shen', '李绅', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','政治家'], '中唐诗人，《悯农》作者。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李绅"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('liu-yu-xi', '刘禹锡', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','文学家','政治家'], '中唐诗人、政治家，作品多有咏史怀古之作。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘禹锡"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('du-mu', '杜牧', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','文学家','政治家'], '晚唐诗人、政治家，与李商隐并称小李杜。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/杜牧"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('su-shi', '苏轼', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','文学家','政治家'], '北宋文学家、政治家，诗词文书画皆精。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/苏轼"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('lu-you', '陆游', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','文学家'], '南宋爱国诗人，诗词文俱工。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/陆游"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wen-tianxiang', '文天祥', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','政治家'], '南宋末丞相、抗元人物。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文天祥"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('zhang-yanghao', '张养浩', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['文学家','政治家'], '元代散曲家、政治家。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/张养浩"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('ma-zhiyuan', '马致远', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['文学家'], '元代散曲家、戏曲家。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/马致远"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('wang-mian', '王冕', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','画家'], '元末诗人、画家。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王冕"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('xia-wanchun', '夏完淳', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','抗清人物'], '明末抗清诗人，南明遗民代表。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/夏完淳"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('gong-zi-zhen', '龚自珍', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','文学家','政治家'], '清代思想家、文学家，主张改革。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/龚自珍"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('qiu-fengjia', '丘逢甲', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诗人','教育家'], '晚清诗人，甲午战后台湾诗人代表。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/丘逢甲"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name, title)
VALUES ('tan-sitong', '谭嗣同', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['政治家','诗人'], '戊戌维新人物，戊戌六君子之一。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/谭嗣同"}]'::jsonb, NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name, title = EXCLUDED.title;

-- dynasties

-- reigns

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-wuyi', '无衣', 'poetry', 'circa', 'year', '春秋战国之际；传统归入《诗经·秦风》', NULL, NULL, NULL, -475, 1, -5688, -221, 12, -2629, '秦地军民同仇敌忾、共赴战场的诗篇。', NULL, '岂曰无衣？与子同袍。
王于兴师，修我戈矛。与子同仇！

岂曰无衣？与子同泽。
王于兴师，修我矛戟。与子偕作！

岂曰无衣？与子同裳。
王于兴师，修我甲兵。与子偕行！')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-gaixia-ge', '垓下歌', 'poetry', 'point', 'year', '前202年，垓下兵败前后', -202, 12, -2401, NULL, NULL, NULL, NULL, NULL, NULL, '项羽在垓下之战前后的绝命歌，见证楚汉战争终局。', NULL, '力拔山兮气盖世，
时不利兮骓不逝。
骓不逝兮可奈何，
虞兮虞兮奈若何！')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-da-feng-ge', '大风歌', 'poetry', 'point', 'year', '前195年，平定英布后归途', -195, 12, -2317, NULL, NULL, NULL, NULL, NULL, NULL, '刘邦平定淮南王英布后所作，表现汉初帝国与诸侯政治。', NULL, '大风起兮云飞扬，
威加海内兮归故乡，
安得猛士兮守四方！')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-duan-ge-xing', '短歌行', 'poetry', 'point', 'year', '建安十三年前后，年代有争议', 208, 12, 2507, NULL, NULL, NULL, NULL, NULL, NULL, '曹操借宴饮歌咏求贤与统一天下的政治抱负。', NULL, '对酒当歌，人生几何！譬如朝露，去日苦多。
慨当以慷，忧思难忘。何以解忧？唯有杜康。
青青子衿，悠悠我心。但为君故，沉吟至今。
呦呦鹿鸣，食野之苹。我有嘉宾，鼓瑟吹笙。
明明如月，何时可掇？忧从中来，不可断绝。
越陌度阡，枉用相存。契阔谈䜩，心念旧恩。
月明星稀，乌鹊南飞。绕树三匝，何枝可依？
山不厌高，海不厌深。周公吐哺，天下归心。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-guan-cang-hai', '观沧海', 'poetry', 'point', 'year', '建安十二年，北征乌桓后', 207, 12, 2495, NULL, NULL, NULL, NULL, NULL, NULL, '曹操北征乌桓后登临碣石所作，写山海气象与统一抱负。', NULL, '东临碣石，以观沧海。
水何澹澹，山岛竦峙。
树木丛生，百草丰茂。
秋风萧瑟，洪波涌起。
日月之行，若出其中；
星汉灿烂，若出其里。
幸甚至哉，歌以咏志。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-gui-sui-shou', '龟虽寿', 'poetry', 'circa', 'year', '建安十二年至十五年前后', NULL, NULL, NULL, 207, 1, 2484, 210, 12, 2531, '曹操晚年抒写建功立业与老当益壮的政治志向。', NULL, '神龟虽寿，犹有竟时；
腾蛇乘雾，终为土灰。
老骥伏枥，志在千里；
烈士暮年，壮心不已。
盈缩之期，不但在天；
养怡之福，可得永年。
幸甚至哉，歌以咏志。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-yin-jiu', '饮酒》其五', 'poetry', 'circa', 'year', '东晋末至刘宋初，具体年份不详', NULL, NULL, NULL, 400, 1, 4800, 420, 12, 5051, '陶渊明归隐后所作的田园诗，反映士人对政治秩序的退避。', NULL, '结庐在人境，而无车马喧。
问君何能尔？心远地自偏。
采菊东篱下，悠然见南山。
山气日夕佳，飞鸟相与还。
此中有真意，欲辨已忘言。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-mulan', '木兰诗', 'poetry', 'circa', 'year', '北朝民歌，成篇年代有争议', NULL, NULL, NULL, 386, 1, 4632, 534, 12, 6419, '北朝战争背景下木兰代父从军的乐府叙事诗。', NULL, '唧唧复唧唧，木兰当户织。不闻机杼声，唯闻女叹息。
问女何所思，问女何所忆。女亦无所思，女亦无所忆。
昨夜见军帖，可汗大点兵，军书十二卷，卷卷有爷名。
阿爷无大儿，木兰无长兄，愿为市鞍马，从此替爷征。
东市买骏马，西市买鞍鞯，南市买辔头，北市买长鞭。
旦辞爷娘去，暮宿黄河边；不闻爷娘唤女声，但闻黄河流水鸣溅溅。
旦辞黄河去，暮至黑山头；不闻爷娘唤女声，但闻燕山胡骑鸣啾啾。
万里赴戎机，关山度若飞。朔气传金柝，寒光照铁衣。
将军百战死，壮士十年归。
归来见天子，天子坐明堂。策勋十二转，赏赐百千强。
可汗问所欲，木兰不用尚书郎；愿驰千里足，送儿还故乡。
爷娘闻女来，出郭相扶将；阿姊闻妹来，当户理红妆；小弟闻姊来，磨刀霍霍向猪羊。
开我东阁门，坐我西阁床。脱我战时袍，著我旧时裳。
当窗理云鬓，对镜帖花黄。出门看火伴，火伴皆惊忙：同行十二年，不知木兰是女郎。
雄兔脚扑朔，雌兔眼迷离；双兔傍地走，安能辨我是雄雌？')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-chile-ge', '敕勒歌', 'poetry', 'circa', 'year', '北朝民歌，流传与定型年代不详', NULL, NULL, NULL, 450, 1, 5400, 580, 12, 6971, '北方草原与军旅生活相关的著名民歌。', NULL, '敕勒川，阴山下。
天似穹庐，笼盖四野。
天苍苍，野茫茫。
风吹草低见牛羊。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-chun-xiao', '春晓', 'poetry', 'circa', 'year', '盛唐，约开元年间', NULL, NULL, NULL, 710, 1, 8520, 740, 12, 8891, '孟浩然的春日晓眠诗，代表盛唐山水田园诗的日常审美。', NULL, '春眠不觉晓，处处闻啼鸟。
夜来风雨声，花落知多少。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-dengguanquelou', '登鹳雀楼', 'poetry', 'circa', 'year', '盛唐，具体创作年份不详', NULL, NULL, NULL, 720, 1, 8640, 742, 12, 8915, '王之涣登临鹳雀楼所作的登高诗，关联河东名楼与盛唐气象。', NULL, '白日依山尽，黄河入海流。
欲穷千里目，更上一层楼。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-liangzhou', '凉州词', 'poetry', 'circa', 'year', '盛唐，凉州与玉门关边塞背景', NULL, NULL, NULL, 720, 1, 8640, 742, 12, 8915, '王之涣的边塞名篇，表现河西边防的孤城、羌笛与军旅情境。', NULL, '黄河远上白云间，一片孤城万仞山。
羌笛何须怨杨柳，春风不度玉门关。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-chusai-wang-changling', '出塞', 'poetry', 'circa', 'year', '盛唐，边塞诗，具体年份不详', NULL, NULL, NULL, 720, 1, 8640, 756, 12, 9083, '王昌龄借边关与戍守书写唐代边疆战争和将士心愿。', NULL, '秦时明月汉时关，万里长征人未还。
但使龙城飞将在，不教胡马度阴山。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-congjunxing', '从军行', 'poetry', 'circa', 'year', '盛唐，西北边塞背景', NULL, NULL, NULL, 720, 1, 8640, 756, 12, 9083, '王昌龄边塞组诗，描写戍边、出征与报国。', NULL, '青海长云暗雪山，孤城遥望玉门关。
黄沙百战穿金甲，不破楼兰终不还。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-huanghelou', '黄鹤楼', 'poetry', 'point', 'year', '盛唐，具体创作年份约在开元年间', 725, 12, 8711, NULL, NULL, NULL, NULL, NULL, NULL, '崔颢登黄鹤楼怀古，连接江城地标与历史兴亡感。', NULL, '昔人已乘黄鹤去，此地空余黄鹤楼。
黄鹤一去不复返，白云千载空悠悠。
晴川历历汉阳树，芳草萋萋鹦鹉洲。
日暮乡关何处是？烟波江上使人愁。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-wangyue', '望岳', 'poetry', 'point', 'year', '开元二十四年前后，游齐赵时', 736, 12, 8843, NULL, NULL, NULL, NULL, NULL, NULL, '杜甫登临泰山所作，表现盛唐山河与个人政治抱负。', NULL, '岱宗夫如何？齐鲁青未了。
造化钟神秀，阴阳割昏晓。
荡胸生层云，决眦入归鸟。
会当凌绝顶，一览众山小。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-shudaonan', '蜀道难', 'poetry', 'circa', 'year', '天宝初年，具体年份有争议', NULL, NULL, NULL, 740, 1, 8880, 744, 12, 8939, '李白借蜀道艰险写行旅、山川和政治道路的险阻。', NULL, '噫吁嚱，危乎高哉！蜀道之难，难于上青天！
蚕丛及鱼凫，开国何茫然！尔来四万八千岁，不与秦塞通人烟。
西当太白有鸟道，可以横绝峨眉巅。地崩山摧壮士死，然后天梯石栈相钩连。
上有六龙回日之高标，下有冲波逆折之回川。黄鹤之飞尚不得过，猿猱欲度愁攀援。
青泥何盘盘，百步九折萦岩峦。扪参历井仰胁息，以手抚膺坐长叹。
问君西游何时还？畏途巉岩不可攀。但见悲鸟号古木，雄飞雌从绕林间。又闻子规啼夜月，愁空山。
蜀道之难，难于上青天，使人听此凋朱颜！连峰去天不盈尺，枯松倒挂倚绝壁。
飞湍瀑流争喧豗，砯崖转石万壑雷。其险也如此，嗟尔远道之人胡为乎来哉！
剑阁峥嵘而崔嵬，一夫当关，万夫莫开。所守或匪亲，化为狼与豺。
朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻。锦城虽云乐，不如早还家。
蜀道之难，难于上青天，侧身西望长咨嗟！')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-jingyesi', '静夜思', 'poetry', 'circa', 'year', '盛唐早期，具体地点与年份不详', NULL, NULL, NULL, 725, 1, 8700, 730, 12, 8771, '李白羁旅夜宿时的思乡名篇。', NULL, '床前明月光，疑是地上霜。
举头望明月，低头思故乡。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-jiangjinjiu', '将进酒', 'poetry', 'circa', 'year', '天宝年间，约在嵩山一带', NULL, NULL, NULL, 750, 1, 9000, 753, 12, 9047, '李白借宴饮抒写人生失意与不平之气。', NULL, '君不见黄河之水天上来，奔流到海不复回。
君不见高堂明镜悲白发，朝如青丝暮成雪。
人生得意须尽欢，莫使金樽空对月。
天生我材必有用，千金散尽还复来。
烹羊宰牛且为乐，会须一饮三百杯。
岑夫子，丹丘生。将进酒，杯莫停。
与君歌一曲，请君为我倾耳听。
钟鼓馔玉不足贵，但愿长醉不复醒。
古来圣贤皆寂寞，惟有饮者留其名。
陈王昔时宴平乐，斗酒十千恣欢谑。
主人何为言少钱，径须沽取对君酌。
五花马，千金裘，呼儿将出换美酒，与尔同销万古愁。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-zaofabaidicheng', '早发白帝城', 'poetry', 'point', 'year', '乾元二年，流放夜郎遇赦后', 759, 12, 9119, NULL, NULL, NULL, NULL, NULL, NULL, '李白遇赦后自白帝城顺江东下所作。', NULL, '朝辞白帝彩云间，千里江陵一日还。
两岸猿声啼不住，轻舟已过万重山。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-chunwang', '春望', 'poetry', 'point', 'year', '至德二载，长安陷于叛军期间', 757, 12, 9095, NULL, NULL, NULL, NULL, NULL, NULL, '杜甫身陷长安时目睹国破城残所作，记录安史之乱的社会创伤。', NULL, '国破山河在，城春草木深。
感时花溅泪，恨别鸟惊心。
烽火连三月，家书抵万金。
白头搔更短，浑欲不胜簪。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-shuxiang', '蜀相', 'poetry', 'point', 'year', '上元元年，成都武侯祠', 760, 12, 9131, NULL, NULL, NULL, NULL, NULL, NULL, '杜甫凭吊诸葛亮，寄托安史乱后对贤相与政治理想的追慕。', NULL, '丞相祠堂何处寻？锦官城外柏森森。
映阶碧草自春色，隔叶黄鹂空好音。
三顾频烦天下计，两朝开济老臣心。
出师未捷身先死，长使英雄泪满襟。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-wenguanjun', '闻官军收河南河北', 'poetry', 'point', 'year', '宝应元年，安史之乱结束消息传来', 763, 12, 9167, NULL, NULL, NULL, NULL, NULL, NULL, '杜甫听闻唐军收复河南河北后的喜极而作。', NULL, '剑外忽传收蓟北，初闻涕泪满衣裳。
却看妻子愁何在，漫卷诗书喜欲狂。
白日放歌须纵酒，青春作伴好还乡。
即从巴峡穿巫峡，便下襄阳向洛阳。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-denggao', '登高', 'poetry', 'point', 'year', '大历二年，夔州', 767, 12, 9215, NULL, NULL, NULL, NULL, NULL, NULL, '杜甫晚年登高所作，包含乱后漂泊与国家衰败的沉郁感。', NULL, '风急天高猿啸哀，渚清沙白鸟飞回。
无边落木萧萧下，不尽长江滚滚来。
万里悲秋常作客，百年多病独登台。
艰难苦恨繁霜鬓，潦倒新停浊酒杯。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-fengqiao-yebo', '枫桥夜泊', 'poetry', 'circa', 'year', '安史之乱后，约8世纪中叶；具体年份不详', NULL, NULL, NULL, 750, 1, 9000, 770, 12, 9251, '张继夜泊苏州枫桥所作，连接江南古迹、战乱后羁旅与城市记忆。', NULL, '月落乌啼霜满天，江枫渔火对愁眠。
姑苏城外寒山寺，夜半钟声到客船。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-jiangxue', '江雪', 'poetry', 'point', 'year', '永贞革新失败后，柳宗元被贬永州时期', 805, 12, 9671, NULL, NULL, NULL, NULL, NULL, NULL, '柳宗元贬谪永州时所作，写孤绝江山与政治失意。', NULL, '千山鸟飞绝，万径人踪灭。
孤舟蓑笠翁，独钓寒江雪。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-youzimeng', '游子吟', 'poetry', 'circa', 'year', '中唐，具体年份不详', NULL, NULL, NULL, 795, 1, 9540, 815, 12, 9791, '孟郊游子行役时歌咏母爱与离别。', NULL, '慈母手中线，游子身上衣。
临行密密缝，意恐迟迟归。
谁言寸草心，报得三春晖。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-minnong', '悯农', 'poetry', 'circa', 'year', '中唐，具体年份不详', NULL, NULL, NULL, 795, 1, 9540, 830, 12, 9971, '李绅悯惜农民劳作与民生艰辛的名篇。', NULL, '锄禾日当午，汗滴禾下土。
谁知盘中餐，粒粒皆辛苦。

春种一粒粟，秋收万颗子。
四海无闲田，农夫犹饿死。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-wuyixiang', '乌衣巷', 'poetry', 'point', 'year', '宝历二年，金陵；咏六朝旧迹', 824, 12, 9899, NULL, NULL, NULL, NULL, NULL, NULL, '刘禹锡凭吊金陵乌衣巷，以燕子旧巢写六朝门阀与王朝兴亡。', NULL, '朱雀桥边野草花，乌衣巷口夕阳斜。
旧时王谢堂前燕，飞入寻常百姓家。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-boqinhua', '泊秦淮', 'poetry', 'point', 'year', '晚唐，约大和年间', 824, 12, 9899, NULL, NULL, NULL, NULL, NULL, NULL, '杜牧夜泊秦淮，借南朝旧都讽喻晚唐政治忧患。', NULL, '烟笼寒水月笼沙，夜泊秦淮近酒家。
商女不知亡国恨，隔江犹唱后庭花。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-chibi-du-mu', '赤壁', 'poetry', 'circa', 'year', '晚唐，具体创作年份不详', NULL, NULL, NULL, 840, 1, 10080, 850, 12, 10211, '杜牧凭吊赤壁古战场，以三国旧事寄托历史兴亡感。', NULL, '折戟沉沙铁未销，自将磨洗认前朝。
东风不与周郎便，铜雀春深锁二乔。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-tixilinbi', '题西林壁', 'poetry', 'point', 'year', '元丰七年，庐山西林寺', 1084, 12, 13019, NULL, NULL, NULL, NULL, NULL, NULL, '苏轼游庐山题壁，写观察视角与山川名胜。', NULL, '横看成岭侧成峰，远近高低各不同。
不识庐山真面目，只缘身在此山中。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-yinhu-chuqing', '饮湖上初晴后雨', 'poetry', 'point', 'year', '熙宁六年前后，杭州', 1073, 12, 12887, NULL, NULL, NULL, NULL, NULL, NULL, '苏轼任杭州通判时咏西湖名篇。', NULL, '水光潋滟晴方好，山色空蒙雨亦奇。
欲把西湖比西子，淡妆浓抹总相宜。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-youshanxicun', '游山西村', 'poetry', 'point', 'year', '乾道三年，山阴', 1167, 12, 14015, NULL, NULL, NULL, NULL, NULL, NULL, '陆游闲居山阴时所作，写南宋乡村社会与民情。', NULL, '莫笑农家腊酒浑，丰年留客足鸡豚。
山重水复疑无路，柳暗花明又一村。
箫鼓追随春社近，衣冠简朴古风存。
从今若许闲乘月，拄杖无时夜叩门。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-shufen', '书愤', 'poetry', 'point', 'year', '淳熙十三年，蜀中', 1186, 12, 14243, NULL, NULL, NULL, NULL, NULL, NULL, '陆游追忆抗金经历，表达南宋恢复故土的政治抱负。', NULL, '早岁那知世事艰，中原北望气如山。
楼船夜雪瓜洲渡，铁马秋风大散关。
塞上长城空自许，镜中衰鬓已先斑。
出师一表真名世，千载谁堪伯仲间！')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-shier', '示儿', 'poetry', 'point', 'year', '嘉定三年，临终前', 1210, 12, 14531, NULL, NULL, NULL, NULL, NULL, NULL, '陆游临终前嘱咐子孙勿忘北定中原。', NULL, '死去元知万事空，但悲不见九州同。
王师北定中原日，家祭无忘告乃翁。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-guolingdingyang', '过零丁洋', 'poetry', 'circa', 'year', '祥兴元年至二年，宋元战争期间', NULL, NULL, NULL, 1278, 1, 15336, 1279, 12, 15359, '文天祥被俘途中经过零丁洋所作，关联南宋覆亡。', NULL, '辛苦遭逢起一经，干戈寥落四周星。
山河破碎风飘絮，身世浮沉雨打萍。
惶恐滩头说惶恐，零丁洋里叹零丁。
人生自古谁无死？留取丹心照汗青。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-zhengqige', '正气歌', 'poetry', 'point', 'year', '至元十六年前后，大都狱中', 1279, 12, 15359, NULL, NULL, NULL, NULL, NULL, NULL, '文天祥在元大都狱中歌咏忠节与历史正气。', NULL, '天地有正气，杂然赋流形。
下则为河岳，上则为日星。
于人曰浩然，沛乎塞苍冥。
皇路当清夷，含和吐明庭。
时穷节乃见，一一垂丹青。
在齐太史简，在晋董狐笔。
在秦张良椎，在汉苏武节。
为严将军头，为嵇侍中血。
为张睢阳齿，为颜常山舌。
或为辽东帽，清操厉冰雪。
或为出师表，鬼神泣壮烈。
或为渡江楫，慷慨吞胡羯。
或为击贼笏，逆竖头破裂。
是气所磅礴，凛烈万古存。
当其贯日月，生死安足论。
地维赖以立，天柱赖以尊。
三纲实系命，道义为之根。
嗟予遘阳九，隶也实不力。
楚囚缨其冠，传车送穷北。
鼎镬甘如饴，求之不可得。
阴房阗鬼火，春院閟天黑。
牛骥同一皂，鸡栖凤凰食。
一朝蒙雾露，分作沟中瘠。
如此再寒暑，百沴自辟易。
嗟哉沮洳场，为我安乐国。
岂有他缪巧，阴阳不能贼。
顾此耿耿在，仰视浮云白。
悠悠我心悲，苍天曷有极。
哲人日已远，典刑在夙昔。
风檐展书读，古道照颜色。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-tongguan-huaigu', '山坡羊·潼关怀古', 'poetry', 'circa', 'year', '元代，赴关中赈灾途中', NULL, NULL, NULL, 1315, 1, 15780, 1325, 12, 15911, '张养浩凭吊潼关，借历代兴亡关注百姓疾苦。', NULL, '峰峦如聚，波涛如怒，山河表里潼关路。
望西都，意踌躇。
伤心秦汉经行处，宫阙万间都做了土。
兴，百姓苦；亡，百姓苦。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-tianjing-shaqiu', '天净沙·秋思', 'poetry', 'circa', 'year', '元代，具体创作年份不详', NULL, NULL, NULL, 1300, 1, 15600, 1321, 12, 15863, '马致远羁旅秋思的散曲名篇。', NULL, '枯藤老树昏鸦，小桥流水人家，古道西风瘦马。
夕阳西下，断肠人在天涯。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-shihuiyin', '石灰吟', 'poetry', 'circa', 'year', '明代中期，创作年代有不同说法', NULL, NULL, NULL, 1435, 1, 17220, 1450, 12, 17411, '于谦借石灰自况，成为明代忠臣政治伦理的象征性诗篇。', NULL, '千锤万凿出深山，烈火焚烧若等闲。
粉骨碎身浑不怕，要留清白在人间。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-bie-yunjian', '别云间', 'poetry', 'point', 'year', '弘光元年，抗清被捕前后', 1645, 12, 19751, NULL, NULL, NULL, NULL, NULL, NULL, '夏完淳被捕前所作，表现南明抗清与少年殉国。', NULL, '三年羁旅客，今日又南冠。
无限山河泪，谁言天地宽。
已知泉路近，欲别故乡难。
毅魄归来日，灵旗空际看。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-jihai', '己亥杂诗》其五', 'poetry', 'point', 'year', '道光十九年，龚自珍离京南归途中', 1839, 12, 22079, NULL, NULL, NULL, NULL, NULL, NULL, '龚自珍以落花自况，寄托晚清政治改革与人才培养愿望。', NULL, '浩荡离愁白日斜，吟鞭东指即天涯。
落红不是无情物，化作春泥更护花。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-fushu-dengcheng', '赴戍登程口占示家人', 'poetry', 'point', 'year', '道光二十二年八月，西安赴伊犁途中', 1842, 12, 22115, NULL, NULL, NULL, NULL, NULL, NULL, '林则徐被遣戍伊犁、告别家人时所作。', NULL, '力微任重久神疲，再竭衰庸定不支。
苟利国家生死以，岂因祸福避趋之？
谪居正是君恩厚，养拙刚于戍卒宜。
戏与山妻谈故事，试吟断送老头皮。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-chunchou', '春愁', 'poetry', 'point', 'year', '甲午战败、台湾割让前后，具体月份不详', 1895, 12, 22751, NULL, NULL, NULL, NULL, NULL, NULL, '丘逢甲写甲午战败与台湾割让后的家国之愁。', NULL, '春愁难遣强看山，往事惊心泪欲潸。
四百万人同一哭，去年今日割台湾。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content) VALUES ('poetry-yuzhong-tibi', '狱中题壁', 'poetry', 'point', 'year', '光绪二十四年，戊戌政变后狱中', 1898, 12, 22787, NULL, NULL, NULL, NULL, NULL, NULL, '谭嗣同被捕后作，关联戊戌政变与维新派殉难。', NULL, '望门投止思张俭，忍死须臾待杜根。
我自横刀向天笑，去留肝胆两昆仑。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content;

-- event_dynasties
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-wuyi', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-gaixia-ge', 'chu-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-gaixia-ge', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-da-feng-ge', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-duan-ge-xing', 'han-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-guan-cang-hai', 'han-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-gui-sui-shou', 'han-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-yin-jiu', 'jin-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-mulan', 'wei-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-chile-ge', 'wei-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-chile-ge', 'qi-bei') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-chun-xiao', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-dengguanquelou', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-liangzhou', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-chusai-wang-changling', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-congjunxing', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-huanghelou', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-wangyue', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-shudaonan', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-jingyesi', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-jiangjinjiu', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-zaofabaidicheng', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-chunwang', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-shuxiang', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-wenguanjun', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-denggao', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-fengqiao-yebo', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-jiangxue', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-youzimeng', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-minnong', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-wuyixiang', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-boqinhua', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-chibi-du-mu', 'tang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-tixilinbi', 'song-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-yinhu-chuqing', 'song-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-youshanxicun', 'song-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-shufen', 'song-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-shier', 'song-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-guolingdingyang', 'song-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-guolingdingyang', 'yuan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-zhengqige', 'song-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-zhengqige', 'yuan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-tongguan-huaigu', 'yuan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-tianjing-shaqiu', 'yuan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-shihuiyin', 'ming') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-bie-yunjian', 'ming-south') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-jihai', 'qing') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-fushu-dengcheng', 'qing') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-chunchou', 'qing') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('poetry-yuzhong-tibi', 'qing') ON CONFLICT DO NOTHING;

-- event_participants
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-gaixia-ge', 'xiang-yu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-da-feng-ge', 'liu-bang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-duan-ge-xing', 'cao-cao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-guan-cang-hai', 'cao-cao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-gui-sui-shou', 'cao-cao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-yin-jiu', 'tao-yuanming') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-chun-xiao', 'meng-hao-ran') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-dengguanquelou', 'wang-zhi-huan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-liangzhou', 'wang-zhi-huan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-chusai-wang-changling', 'wang-chang-ling') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-congjunxing', 'wang-chang-ling') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-huanghelou', 'cui-hao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-wangyue', 'du-fu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-shudaonan', 'li-bai') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-jingyesi', 'li-bai') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-jiangjinjiu', 'li-bai') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-zaofabaidicheng', 'li-bai') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-chunwang', 'du-fu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-shuxiang', 'du-fu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-wenguanjun', 'du-fu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-denggao', 'du-fu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-fengqiao-yebo', 'zhang-ji') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-jiangxue', 'liu-zong-yuan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-youzimeng', 'meng-jiao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-minnong', 'li-shen') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-wuyixiang', 'liu-yu-xi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-boqinhua', 'du-mu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-chibi-du-mu', 'du-mu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-tixilinbi', 'su-shi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-yinhu-chuqing', 'su-shi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-youshanxicun', 'lu-you') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-shufen', 'lu-you') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-shier', 'lu-you') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-guolingdingyang', 'wen-tianxiang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-zhengqige', 'wen-tianxiang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-tongguan-huaigu', 'zhang-yanghao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-tianjing-shaqiu', 'ma-zhiyuan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-shihuiyin', 'yu-qian') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-bie-yunjian', 'xia-wanchun') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-jihai', 'gong-zi-zhen') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-fushu-dengcheng', 'lin-zexu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-chunchou', 'qiu-fengjia') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('poetry-yuzhong-tibi', 'tan-sitong') ON CONFLICT DO NOTHING;

-- relations

COMMIT;
