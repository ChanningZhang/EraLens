-- EraLens period import: xia-shang-zhou
-- Window: -2070-01 .. -256-12
-- Chronology: Xia-Shang-Zhou Chronology Project + Shiji Eastern Zhou kings
BEGIN;

DELETE FROM event_dynasties WHERE dynasty_id = 'zhou';
DELETE FROM reigns WHERE dynasty_id = 'zhou';
DELETE FROM dynasties WHERE id = 'zhou';
DELETE FROM reigns WHERE id = 'reign-missing-zhou-west--840';
DELETE FROM reigns WHERE id = 'reign-missing-shang--1570';
DELETE FROM reigns WHERE dynasty_id = 'xia' AND person_id = 'system-missing-ruler';
DELETE FROM relations WHERE id LIKE 'rel-si-%-succession';
DELETE FROM relations WHERE id IN ('rel-zi-tang-zi-taijia-succession','rel-ji-yijiu-ji-yuchen-succession','rel-ji-yuchen-ji-lin-succession','rel-hou-yi-han-zhuo-succession');
DELETE FROM event_participants WHERE event_id IN ('taikang-lost','houyi-dai-xia','hanzhuo-cuan-xia');
DELETE FROM event_dynasties WHERE event_id IN ('houyi-dai-xia','hanzhuo-cuan-xia');
DELETE FROM events WHERE id IN ('houyi-dai-xia','hanzhuo-cuan-xia');

-- persons
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-yu', '姒文命', ARRAY['禹','大禹','夏禹','文命'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '夏朝开国之君，姒姓，名文命，史称禹、大禹。传说继父鲧治水，受舜禅，都阳城；《史记·夏本纪》以其为夏后氏始。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/禹"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-qi', '姒启', ARRAY['启','夏后启'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '禹之子。传统记载益避启，诸侯归启，变禅让为世袭，史称家天下。《尚书·甘誓》载其伐有扈氏。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/启_(夏朝)"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-taikang', '姒太康', ARRAY['太康'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '启之子。《史记》载太康失国；《左传》谓后羿因夏民以代夏政，《五子之歌》托为太康兄弟所作。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/太康_(夏朝)"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-zhongkang', '姒仲康', ARRAY['仲康','中康'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '太康之弟，《史记·夏本纪》作中康。后羿代夏之际夏后氏仍记其世次，子为相。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中康"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-xiang', '姒相', ARRAY['相'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '仲康之子。寒浞当国时夏后；《左传》载过浇灭斟灌、斟鄩，杀相。后缗方娠逃归有仍，生少康。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/相_(夏朝)"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-shaokang', '姒少康', ARRAY['少康'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '相之子，有仍所生。自有虞起兵，与靡灭寒浞，使女艾灭浇、季杼灭豷，恢复夏政，史称少康中兴。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/少康"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-zhu', '姒杼', ARRAY['杼','予','季杼'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '少康之子，《史记》作帝予，亦作杼、季杼。少康中兴时诱杀寒豷于戈；《国语》称其能帅禹，夏后氏报祭。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/杼"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-huai', '姒槐', ARRAY['槐','芬','帝宁'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '杼之子，《史记》作帝槐；《今本竹书纪年》等或作芬、帝宁。正史几乎无事迹。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/槐_(夏朝)"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-mang', '姒芒', ARRAY['芒','荒'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '槐之子，《史记》作帝芒；一作荒。《今本竹书纪年》载其以玄珪宾于河，事属传说。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/芒_(夏朝)"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-xie', '姒泄', ARRAY['泄'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '芒之子，《史记》作帝泄。《今本竹书纪年》载命畎夷、白夷、赤夷、玄夷、风夷、阳夷，事属传说。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/泄"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-bujiang', '姒不降', ARRAY['不降'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '泄之子。《史记》载不降崩、弟扃立，是夏世次中少见的兄终弟及。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/不降"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-jiong', '姒扃', ARRAY['扃'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '不降之弟。兄终弟及，子为廑。正史几乎无事迹。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/扃"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-jin', '姒廑', ARRAY['廑','胤甲'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '扃之子，《史记》作帝廑；《今本竹书纪年》或作胤甲，并载天有妖孽、十日并出，事属传说。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/廑"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-kongjia', '姒孔甲', ARRAY['孔甲'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '不降之子；扃、廑之后由孔甲继。《史记》称其好方鬼神、事淫乱，夏后氏德衰、诸侯畔之；又有扰龙、刘累御龙传说。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孔甲"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-gao', '姒皋', ARRAY['皋','昊'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '孔甲之子，《史记》作帝皋；一作昊。正史几乎无事迹。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/皋_(夏朝)"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-fa', '姒发', ARRAY['发','發'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '皋之子，《史记》作帝发，桀之父。《今本竹书纪年》载诸夷宾于王门，事属传说。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/發_(夏朝)"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('si-jie', '姒履癸', ARRAY['履癸','桀','夏桀'], '姒', '夏', NULL, NULL, NULL, NULL, ARRAY['君主'], '发之子，夏朝末代之王，史称桀。《史记》载其暴虐，鸣条之战为商汤所灭。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桀"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('hou-yi', '后羿', ARRAY['羿','夷羿','有穷后羿'], NULL, '有穷', NULL, NULL, NULL, NULL, ARRAY['君主'], '有穷氏首领，善射。《左传》载其自鉏迁穷石，因夏民以代夏政，不修民事，为寒浞所杀。传说未称夏后，不入夏后氏正统世次。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/后羿_(夏朝)"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('han-zhuo', '寒浞', ARRAY['浞','韩浞'], '妘', '寒', NULL, NULL, NULL, NULL, ARRAY['君主'], '寒氏，名浞，妘姓。伯明氏谗子弟，后羿用为相，旋杀羿代有穷；使浇灭相。后为少康、靡所灭。非夏后正统，不入十七王继承链。生卒年无实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/寒浞"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('gun', '鲧', ARRAY['崇伯鲧','梼杌'], '姒', '崇', NULL, NULL, -2070, 1, ARRAY['政治家'], '禹之父，崇伯。传说奉尧命障洪水九年不成，后被殛于羽山。生卒无实测；卒年取断代工程夏始约前2070年，示禹受禅之前。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鲧"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('gao-yao', '皋陶', ARRAY['咎繇'], '偃', NULL, NULL, NULL, NULL, NULL, ARRAY['政治家'], '尧舜禹时掌刑之臣，传说制五刑、造狱。禹曾欲禅位于他，先禹而卒。生卒年不可考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/皋陶"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('bo-yi', '伯益', ARRAY['益','柏翳','大费'], '嬴', NULL, NULL, NULL, NULL, NULL, ARRAY['政治家'], '舜禹时虞官，佐禹治水；禹卒后一度受禅，传统记载启继位而益避居。生卒年不可考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/伯益"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('tu-shan-shi', '涂山氏', ARRAY['女娇','涂山女'], NULL, '涂山', NULL, NULL, NULL, NULL, ARRAY['后妃'], '传说禹之妃、启之母，涂山氏女，或名女娇。《吕氏春秋》有涂山女作歌之说。生卒年不可考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/涂山氏"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('hou-min', '后缗', ARRAY['缗'], NULL, '有仍', NULL, NULL, NULL, NULL, ARRAY['后妃'], '有仍氏女，夏后相之妻。相为浇所灭时方娠，逃出自窦，归于有仍，生少康。见《左传·哀公元年》。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/后缗"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('han-jiao', '浇', ARRAY['过浇','奡'], '妘', '寒', NULL, NULL, NULL, NULL, ARRAY['将领'], '寒浞之子，处过，故称过浇。《左传》载其灭斟灌、斟鄩并杀相，后为少康遣女艾所灭。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/浇"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('mo-xi', '妹喜', ARRAY['末喜','妹嬉'], NULL, '有施', NULL, NULL, NULL, NULL, ARRAY['后妃'], '有施氏女，传说夏桀伐有施而得，为桀妃；传统叙事常将其与夏亡并提，事属传说。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/妹喜"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('guan-longpang', '关龙逢', ARRAY['关龙逄','龙逢'], NULL, NULL, NULL, NULL, -1600, 1, ARRAY['政治家'], '夏桀时谏臣。传说桀通宵宴乐，关龙逢进黄图强谏被杀。生卒无实测；卒年取夏商分界约前1600年，示桀世之末。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/关龙逢"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-tang', '子履', ARRAY['汤','成汤','天乙','大乙'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '商朝开国之君，子姓，名履，又称成汤、天乙；鸣条之战灭夏。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/商汤"}]'::jsonb, '武王', '高祖')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('yi-yin', '伊尹', ARRAY['伊挚','阿衡','保衡'], NULL, '伊', -1649, 1, -1540, 1, ARRAY['政治家'], '商初重臣，名挚，有莘氏媵臣出身；辅汤灭夏，历外丙、仲壬、太甲、沃丁。传说曾放太甲于桐宫。传统生年取维基前1649年；卒年按《今本竹书》沃丁八年，对到本表沃丁窗为前1540年。皆非实测。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/伊尹"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zhong-hui', '仲虺', ARRAY['莱朱'], NULL, '薛', NULL, NULL, NULL, NULL, ARRAY['政治家'], '商汤左相，奚仲之后，居薛；与伊尹并相。《尚书》有仲虺之诰。生卒年不可考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/仲虺"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-waibing', '子胜', ARRAY['外丙','卜丙'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '汤之子，太丁之弟。《孟子》《今本竹书纪年》在位二年，《史记》作三年；甲骨或作卜丙。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/外丙"}]'::jsonb, '外丙', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-zhongren', '子庸', ARRAY['仲壬','中壬'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '汤之子、外丙之弟，亦称中壬。孟子、史记均记在位四年；周祭未见其名，即位与否有争议。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/仲壬"}]'::jsonb, '仲壬', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-taijia', '子至', ARRAY['太甲'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '汤之孙，名至；商朝早期重要君主，与伊尹传说相关。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/太甲"}]'::jsonb, '太甲', '太宗')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-woding', '子绚', ARRAY['沃丁'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '太甲之子，名绚；伊尹卒后仍用伊尹诸子及咎单为政。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/沃丁"}]'::jsonb, '沃丁', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-taigeng', '子辩', ARRAY['太庚','大庚'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '沃丁之弟，名辩，又称大庚。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/太庚"}]'::jsonb, '太庚', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-xiaojia', '子高', ARRAY['小甲'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '太庚之子，名高，商代早中期君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/小甲"}]'::jsonb, '小甲', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-yongji', '子伷', ARRAY['雍己'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '小甲之弟，名伷；传统记载此际诸侯不朝、殷道始衰。甲骨周祭或次太戊之后。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/雍己"}]'::jsonb, '雍己', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-taiwu', '子密', ARRAY['太戊','大戊'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '雍己之弟，名密，又称大戊；传统称中宗，与伊陟、巫咸辅政而复兴。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/太戊"}]'::jsonb, '太戊', '中宗')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('yi-zhi', '伊陟', ARRAY[]::text[], NULL, '伊', NULL, NULL, NULL, NULL, ARRAY['政治家'], '伊尹之子，太戊时为相。传说亳有祥桑榖合生，伊陟劝太戊修德，殷道复兴。生卒年不可考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/伊陟"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('wu-xian', '巫咸', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['政治家','学者'], '太戊时大臣，与伊陟并治；后世亦传为巫师、星历之祖。生卒年不可考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/巫咸"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-zhongding', '子庄', ARRAY['仲丁','中丁'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '太戊之子，名庄；迁于嚣，九世之乱始。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/仲丁"}]'::jsonb, '仲丁', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-wairen', '子发', ARRAY['外壬','卜壬'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '仲丁之弟，名发；甲骨或作卜壬，九世之乱中继位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/外壬"}]'::jsonb, '外壬', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-hedanjia', '子整', ARRAY['河亶甲','戔甲'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '外壬之弟，名整；甲骨作戔甲，传统记载曾迁于相。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/河亶甲"}]'::jsonb, '河亶甲', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-zuyi', '子滕', ARRAY['祖乙'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '河亶甲之子，名滕；传统记载迁邢、殷道再兴。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/祖乙"}]'::jsonb, '祖乙', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-zuxin', '子旦', ARRAY['祖辛'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '祖乙之子，名旦，商代早中期君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/祖辛"}]'::jsonb, '祖辛', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-wojia', '子踰', ARRAY['沃甲','开甲','羌甲'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '祖辛之弟，名踰；竹书或作开甲，甲骨或作羌甲。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/沃甲"}]'::jsonb, '沃甲', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-zuding', '子新', ARRAY['祖丁'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '沃甲之侄、祖辛之子，名新；传统记载居庇。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/祖丁"}]'::jsonb, '祖丁', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-nangeng', '子更', ARRAY['南庚'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '沃甲之子，名更；传统记载自庇迁于奄。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/南庚"}]'::jsonb, '南庚', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-yangjia', '子和', ARRAY['阳甲'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '祖丁之子、盘庚之兄，名和；传统记载此际殷衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/阳甲"}]'::jsonb, '阳甲', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-pangeng', '子旬', ARRAY['盘庚'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '祖丁之子，名旬；约前1300年迁都于殷，晚商以此为界。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/盘庚"}]'::jsonb, '盘庚', '世祖')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-xiaoxin', '子颂', ARRAY['小辛'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '盘庚之弟，名颂；迁殷后继位，传统记载殷道再衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/小辛"}]'::jsonb, '小辛', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-xiaoyi', '子敛', ARRAY['小乙'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '小辛之弟、武丁之父，名敛；传统记载仍居殷。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/小乙_(商朝)"}]'::jsonb, '小乙', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-wuding', '子昭', ARRAY['武丁'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '小乙之子，名昭；商高宗，甲骨文所见盛世之王，史称武丁中兴。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武丁"}]'::jsonb, '武丁', '高宗')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('fu-hao', '妇好', ARRAY['帚好'], NULL, NULL, NULL, NULL, -1200, 1, ARRAY['王后','军事家'], '武丁配偶，甲骨所见女将、祭司，殷墟有墓。生年不详；卒于武丁在世时，年取考古通行约前1200年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/妇好"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('gan-pan', '甘盘', ARRAY['甘盤'], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['政治家'], '小乙、武丁时大臣。传说小乙命其傅武丁；武丁即位后为卿士，不久卒，傅说继之。《尚书·君奭》以之与伊尹、伊陟并称。生卒年不可考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/甘盘"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('fu-yue', '傅说', ARRAY['傅說'], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['政治家'], '武丁之相。传说原在傅岩版筑为胥靡，武丁梦得圣人而举以为相，助成武丁中兴。生卒年不可考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/傅说"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-zugeng', '子跃', ARRAY['祖庚','曜'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '武丁之子，名跃，一作曜；甲骨文作「且庚」。断代工程将祖庚至庚丁合为前1191–前1148年，年精度下四王平分。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/祖庚"}]'::jsonb, '祖庚', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-zujia', '子载', ARRAY['祖甲'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '武丁之子、祖庚之弟，名载；甲骨文作「且甲」。与祖庚、廪辛、庚丁同属断代工程前1191–前1148年窗口。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/祖甲"}]'::jsonb, '祖甲', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-linxin', '子先', ARRAY['廪辛','冯辛'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '祖甲之子，名先；竹书或作冯辛。与祖庚、祖甲、庚丁同属断代工程前1191–前1148年窗口。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/廪辛"}]'::jsonb, '廪辛', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-gengding', '子嚣', ARRAY['庚丁','康丁'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '廪辛之弟，名嚣；甲骨作文丁前的康丁，《史记》作庚丁。四王窗口之末，死年归本王，武乙次年起算。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/康丁"}]'::jsonb, '庚丁', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-wuyi', '子瞿', ARRAY['武乙'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '庚丁之子，名瞿；晚商之王，断代工程定其在位前1147–前1113年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武乙"}]'::jsonb, '武乙', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-wending', '子托', ARRAY['文丁','太丁'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '武乙之子，名托；晚商之王，《史记》或作太丁。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文丁"}]'::jsonb, '文丁', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-diyi', '子羡', ARRAY['帝乙'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '文丁之子、帝辛之父，名羡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/帝乙"}]'::jsonb, '帝乙', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('zi-dixin', '子受', ARRAY['帝辛','纣','受德'], '子', '殷', NULL, NULL, NULL, NULL, ARRAY['君主'], '商朝末代之王，名受，一名受德；周谥纣，牧野之战亡于周。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/帝辛"}]'::jsonb, '纣', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('bi-gan', '比干', ARRAY[]::text[], '子', NULL, NULL, NULL, -1046, 1, ARRAY['政治家','宗室'], '商末少师，文丁之子、帝辛叔父。《论语》与微子、箕子并称殷有三仁。传说强谏被剖心。生年不详；死年取牧野之年（断代工程前1046年），示纣末。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/比干"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-zi', '箕子', ARRAY['胥余'], '子', NULL, NULL, NULL, NULL, NULL, ARRAY['政治家','宗室'], '商末宗室，帝辛诸父或庶兄。传说谏纣被囚，武王克商后访之，后走朝鲜。生卒年不可考。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/箕子"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-chang', '姬昌', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['西伯','君主'], '周文王，商末西伯，武王之父。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周文王"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-fa', '姬发', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周武王，牧野克商，建立西周。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周武王"}]'::jsonb, '武王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-dan', '姬旦', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['政治家'], '周公旦，武王之弟，成王初摄政，东征平三监。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周公旦"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('lv-shang', '吕尚', ARRAY[]::text[], NULL, '吕', -1156, 1, -1017, 1, ARRAY['军事家','政治家'], '姜太公（姜子牙），辅武王克商，封于齐。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/姜子牙"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-song', '姬诵', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周成王，周公辅政，与康王并称成康之治。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周成王"}]'::jsonb, '成王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-zhao', '姬钊', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周康王，成康之治后期之王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周康王"}]'::jsonb, '康王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-xia', '姬瑕', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周昭王，南征荆楚，传说卒于汉水。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周昭王"}]'::jsonb, '昭王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-man', '姬满', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周穆王，西周在位最久的天子之一。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周穆王"}]'::jsonb, '穆王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-yihu', '姬繄扈', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周共王，穆王之子。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周共王"}]'::jsonb, '共王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-jian', '姬囏', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周懿王，断代工程以元年天再旦为前899年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周懿王"}]'::jsonb, '懿王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-pifang', '姬辟方', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周孝王，共王之弟，继懿王而立。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周孝王"}]'::jsonb, '孝王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-xie', '姬燮', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周夷王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周夷王"}]'::jsonb, '夷王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-hu', '姬胡', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周厉王，专利引发国人暴动，出奔于彘。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周厉王"}]'::jsonb, '厉王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-jing', '姬静', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周宣王，共和之后即位，史称宣王中兴。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周宣王"}]'::jsonb, '宣王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-gongsheng', '姬宫湦', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周幽王，犬戎之祸中身死，西周终结。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周幽王"}]'::jsonb, '幽王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-yijiu', '姬宜臼', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周平王，申侯等拥立；与携王二王并立，东迁洛邑后后世视为东周正统。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周平王"}]'::jsonb, '平王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-yuchen', '姬余臣', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周携王（携惠王），幽王弟；虢公翰等拥立于携，与平王并立；前750年晋文侯杀之。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周携王"}]'::jsonb, '携王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-lin', '姬林', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周桓王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周桓王"}]'::jsonb, '桓王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-tuo', '姬佗', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周庄王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周庄王"}]'::jsonb, '庄王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-huqi', '姬胡齐', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周釐王，亦作周僖王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周釐王"}]'::jsonb, '釐王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-lang', '姬阆', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周惠王，其间有王子颓之乱。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周惠王"}]'::jsonb, '惠王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-zheng', '姬郑', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周襄王，晋文公勤王前后在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周襄王"}]'::jsonb, '襄王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-renchen', '姬壬臣', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周顷王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周顷王"}]'::jsonb, '顷王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-ban', '姬班', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周匡王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周匡王"}]'::jsonb, '匡王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-yu', '姬瑜', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周定王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周定王"}]'::jsonb, '定王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-yi', '姬夷', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周简王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周简王"}]'::jsonb, '简王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-xiexin', '姬泄心', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周灵王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周灵王"}]'::jsonb, '灵王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-gui', '姬贵', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周景王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周景王"}]'::jsonb, '景王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-meng', '姬猛', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周悼王，在位仅数月。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周悼王"}]'::jsonb, '悼王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-gai', '姬匄', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周敬王，春秋与战国之交的周天子。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周敬王"}]'::jsonb, '敬王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-ren', '姬仁', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周元王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周元王"}]'::jsonb, '元王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-jie', '姬介', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周贞定王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周贞定王"}]'::jsonb, '贞定王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-quji', '姬去疾', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周哀王。史记：立三月，为弟叔袭杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周哀王"}]'::jsonb, '哀王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-shu', '姬叔', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周思王。史记：杀哀王而立，立五月，旋为考王所杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周思王"}]'::jsonb, '思王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-wei', '姬嵬', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周考王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周考王"}]'::jsonb, '考王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-wu', '姬午', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周威烈王，前403年命韩赵魏为诸侯。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周威烈王"}]'::jsonb, '威烈王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-jiao', '姬骄', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周安王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周安王"}]'::jsonb, '安王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-xi', '姬喜', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周烈王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周烈王"}]'::jsonb, '烈王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-bian', '姬扁', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周显王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周显王"}]'::jsonb, '显王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-ding', '姬定', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周慎靓王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周慎靓王"}]'::jsonb, '慎靓王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-yan', '姬延', ARRAY[]::text[], '姬', NULL, NULL, NULL, NULL, NULL, ARRAY['天子'], '周赧王，东周末代天子，前256年周亡于秦。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周赧王"}]'::jsonb, '赧王', NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('jiang-xiaobai', '姜小白', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诸侯'], '齐桓公，春秋首霸，葵丘会盟。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐桓公"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('guan-zhong', '管仲', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['政治家'], '齐桓公之相，助齐称霸。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/管仲"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-chonger', '姬重耳', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['诸侯'], '晋文公，城濮之战胜楚，成为中原霸主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/晋文公"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('kong-qiu', '孔丘', ARRAY[]::text[], NULL, NULL, -551, 1, -479, 1, ARRAY['思想家'], '孔子，儒家开创者，传统生卒前551–前479年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孔子"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('da-ji', '妲己', ARRAY[]::text[], NULL, NULL, NULL, NULL, -1046, 1, ARRAY['后妃'], '传说中商末帝辛宠妃。生卒无实测；卒年取牧野之年（前1046年），示商亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/妲己"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('bao-si', '褒姒', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['后妃'], '周幽王宠妃，传说与烽火戏诸侯、犬戎之祸相关。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/褒姒"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;
INSERT INTO persons (id, name, alt_names, ancestral_xing, clan_shi, birth_year, birth_month, death_year, death_month, roles, bio, links, posthumous_name, temple_name)
VALUES ('ji-shi', '姬奭', ARRAY[]::text[], NULL, NULL, NULL, NULL, NULL, NULL, ARRAY['政治家'], '召公奭，周武王弟，与周公旦分陕而治，辅佐成康。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/召公奭"}]'::jsonb, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, ancestral_xing = EXCLUDED.ancestral_xing, clan_shi = EXCLUDED.clan_shi, birth_year = EXCLUDED.birth_year, birth_month = EXCLUDED.birth_month, death_year = EXCLUDED.death_year, death_month = EXCLUDED.death_month, roles = EXCLUDED.roles, bio = EXCLUDED.bio, links = EXCLUDED.links, posthumous_name = EXCLUDED.posthumous_name, temple_name = EXCLUDED.temple_name;

-- dynasties
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES ('xia', '夏', ARRAY['夏后氏'], 'cn', 'east_asia', -2070, 1, -1600, 12, -24828, -19177, 'year', 'ochre', -24720, -19177, NULL, NULL, '王朝窗口取断代工程前2070–前1600。各王起迄依今本《竹书纪年》在位年数自夏始顺推（桀用《帝王世纪》五十二年以接商汤），全部标 interpolated。相、少康之间有穷后羿、寒浞占夏行而非夏后正统。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES ('shang', '商', ARRAY['殷','殷商'], 'cn', 'east_asia', -1600, 1, -1046, 1, -19188, -12540, 'year', 'ochre', -19188, -12540, NULL, NULL, '断代工程：商始约前1600年，盘庚迁殷约前1300年，武王克商前1046年。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES ('zhou-west', '西周', ARRAY['周'], 'cn', 'east_asia', -1046, 1, -771, 12, -12540, -9229, 'year', 'ochre', -12540, -9229, NULL, NULL, '武王克商至犬戎破镐。列王年取夏商周断代工程《夏商周年表》。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;
INSERT INTO dynasties (id, name, alt_names, scope, region, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs, parent_id, group_id, note)
VALUES ('zhou-east', '东周', ARRAY['周'], 'cn', 'east_asia', -770, 1, -256, 12, -9228, -3049, 'year', 'ochre', -9228, -3049, NULL, NULL, '平王东迁至秦灭周。前770–前750年与携王二王并立，后世以平王为正统（claim_track 主线）。')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, orthodox_from_abs = EXCLUDED.orthodox_from_abs, orthodox_end_abs = EXCLUDED.orthodox_end_abs, group_id = EXCLUDED.group_id, note = EXCLUDED.note;

-- reigns
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-yu', 'xia', 'si-yu', '禹', NULL, -2070, 1, NULL, -2061, 12, NULL, -24828, -24709, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-qi', 'xia', 'si-qi', '启', NULL, -2060, 1, NULL, -2045, 12, NULL, -24708, -24517, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-taikang', 'xia', 'si-taikang', '太康', NULL, -2044, 1, NULL, -2041, 12, NULL, -24516, -24469, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-zhongkang', 'xia', 'si-zhongkang', '仲康', NULL, -2040, 1, NULL, -2028, 12, NULL, -24468, -24313, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-xiang', 'xia', 'si-xiang', '相', NULL, -2027, 1, NULL, -2000, 12, NULL, -24312, -23977, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-shaokang', 'xia', 'si-shaokang', '少康', NULL, -1959, 1, NULL, -1939, 12, NULL, -23496, -23245, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-zhu', 'xia', 'si-zhu', '杼', NULL, -1938, 1, NULL, -1922, 12, NULL, -23244, -23041, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-huai', 'xia', 'si-huai', '槐', NULL, -1921, 1, NULL, -1878, 12, NULL, -23040, -22513, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-mang', 'xia', 'si-mang', '芒', NULL, -1877, 1, NULL, -1820, 12, NULL, -22512, -21817, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-xie', 'xia', 'si-xie', '泄', NULL, -1819, 1, NULL, -1795, 12, NULL, -21816, -21517, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-bujiang', 'xia', 'si-bujiang', '不降', NULL, -1794, 1, NULL, -1736, 12, NULL, -21516, -20809, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-jiong', 'xia', 'si-jiong', '扃', NULL, -1735, 1, NULL, -1718, 12, NULL, -20808, -20593, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-jin', 'xia', 'si-jin', '廑', NULL, -1717, 1, NULL, -1710, 12, NULL, -20592, -20497, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-kongjia', 'xia', 'si-kongjia', '孔甲', NULL, -1709, 1, NULL, -1679, 12, NULL, -20496, -20125, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-gao', 'xia', 'si-gao', '皋', NULL, -1678, 1, NULL, -1668, 12, NULL, -20124, -19993, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-fa', 'xia', 'si-fa', '发', NULL, -1667, 1, NULL, -1652, 12, NULL, -19992, -19801, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-si-jie', 'xia', 'si-jie', '桀', NULL, -1651, 1, NULL, -1600, 12, NULL, -19800, -19177, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-hou-yi', 'xia', 'hou-yi', '后羿', NULL, -1999, 1, NULL, -1992, 12, NULL, -23976, -23881, 'year', 'interpolated', 'interpolated', NULL, NULL, 'rival', false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-han-zhuo', 'xia', 'han-zhuo', '寒浞', NULL, -1991, 1, NULL, -1960, 12, NULL, -23880, -23497, 'year', 'interpolated', 'interpolated', NULL, NULL, 'rival', false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-tang', 'shang', 'zi-tang', '商汤', NULL, -1600, 1, NULL, -1571, 12, NULL, -19188, -18829, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-waibing', 'shang', 'zi-waibing', '商外丙', NULL, -1570, 1, NULL, -1566, 12, NULL, -18828, -18769, 'year', NULL, 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-zhongren', 'shang', 'zi-zhongren', '商仲壬', NULL, -1565, 1, NULL, -1561, 12, NULL, -18768, -18709, 'year', 'interpolated', NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-taijia', 'shang', 'zi-taijia', '商太甲', NULL, -1560, 1, NULL, -1548, 12, NULL, -18708, -18553, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-woding', 'shang', 'zi-woding', '商沃丁', NULL, -1547, 1, NULL, -1529, 12, NULL, -18552, -18325, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-taigeng', 'shang', 'zi-taigeng', '商太庚', NULL, -1528, 1, NULL, -1524, 12, NULL, -18324, -18265, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-xiaojia', 'shang', 'zi-xiaojia', '商小甲', NULL, -1523, 1, NULL, -1507, 12, NULL, -18264, -18061, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-yongji', 'shang', 'zi-yongji', '商雍己', NULL, -1506, 1, NULL, -1495, 12, NULL, -18060, -17917, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-taiwu', 'shang', 'zi-taiwu', '商太戊', NULL, -1494, 1, NULL, -1420, 12, NULL, -17916, -17017, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-zhongding', 'shang', 'zi-zhongding', '商仲丁', NULL, -1419, 1, NULL, -1411, 12, NULL, -17016, -16909, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-wairen', 'shang', 'zi-wairen', '商外壬', NULL, -1410, 1, NULL, -1401, 12, NULL, -16908, -16789, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-hedanjia', 'shang', 'zi-hedanjia', '商河亶甲', NULL, -1400, 1, NULL, -1392, 12, NULL, -16788, -16681, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-zuyi', 'shang', 'zi-zuyi', '商祖乙', NULL, -1391, 1, NULL, -1373, 12, NULL, -16680, -16453, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-zuxin', 'shang', 'zi-zuxin', '商祖辛', NULL, -1372, 1, NULL, -1359, 12, NULL, -16452, -16285, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-wojia', 'shang', 'zi-wojia', '商沃甲', NULL, -1358, 1, NULL, -1339, 12, NULL, -16284, -16045, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-zuding', 'shang', 'zi-zuding', '商祖丁', NULL, -1338, 1, NULL, -1330, 12, NULL, -16044, -15937, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-nangeng', 'shang', 'zi-nangeng', '商南庚', NULL, -1329, 1, NULL, -1324, 12, NULL, -15936, -15865, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-yangjia', 'shang', 'zi-yangjia', '商阳甲', NULL, -1323, 1, NULL, -1311, 12, NULL, -15864, -15709, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-pangeng', 'shang', 'zi-pangeng', '商盘庚', NULL, -1310, 1, NULL, -1280, 12, NULL, -15708, -15337, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-xiaoxin', 'shang', 'zi-xiaoxin', '商小辛', NULL, -1279, 1, NULL, -1277, 12, NULL, -15336, -15301, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-xiaoyi', 'shang', 'zi-xiaoyi', '商小乙', NULL, -1276, 1, NULL, -1251, 12, NULL, -15300, -14989, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-wuding', 'shang', 'zi-wuding', '商王武丁', NULL, -1250, 1, NULL, -1192, 12, NULL, -14988, -14281, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-zugeng', 'shang', 'zi-zugeng', '商王祖庚', NULL, -1191, 1, NULL, -1181, 12, NULL, -14280, -14149, 'year', NULL, 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-zujia', 'shang', 'zi-zujia', '商王祖甲', NULL, -1180, 1, NULL, -1170, 12, NULL, -14148, -14017, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-linxin', 'shang', 'zi-linxin', '商王廪辛', NULL, -1169, 1, NULL, -1159, 12, NULL, -14016, -13885, 'year', 'interpolated', 'interpolated', NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-gengding', 'shang', 'zi-gengding', '商王庚丁', NULL, -1158, 1, NULL, -1148, 12, NULL, -13884, -13753, 'year', 'interpolated', NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-wuyi', 'shang', 'zi-wuyi', '商王武乙', NULL, -1147, 1, NULL, -1113, 12, NULL, -13752, -13333, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-wending', 'shang', 'zi-wending', '商王文丁', NULL, -1112, 1, NULL, -1102, 12, NULL, -13332, -13201, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-diyi', 'shang', 'zi-diyi', '商王帝乙', NULL, -1101, 1, NULL, -1076, 12, NULL, -13200, -12889, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-zi-dixin', 'shang', 'zi-dixin', '商王帝辛', NULL, -1075, 1, NULL, -1046, 1, NULL, -12888, -12540, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-fa', 'zhou-west', 'ji-fa', '周武王', NULL, -1046, 1, NULL, -1043, 12, NULL, -12540, -12493, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-song', 'zhou-west', 'ji-song', '周成王', NULL, -1042, 1, NULL, -1021, 12, NULL, -12492, -12229, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-zhao', 'zhou-west', 'ji-zhao', '周康王', NULL, -1020, 1, NULL, -996, 12, NULL, -12228, -11929, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-xia', 'zhou-west', 'ji-xia', '周昭王', NULL, -995, 1, NULL, -977, 12, NULL, -11928, -11701, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-man', 'zhou-west', 'ji-man', '周穆王', NULL, -976, 1, NULL, -923, 12, NULL, -11700, -11053, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-yihu', 'zhou-west', 'ji-yihu', '周共王', NULL, -922, 1, NULL, -900, 12, NULL, -11052, -10777, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-jian', 'zhou-west', 'ji-jian', '周懿王', NULL, -899, 1, NULL, -892, 12, NULL, -10776, -10681, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-pifang', 'zhou-west', 'ji-pifang', '周孝王', NULL, -891, 1, NULL, -886, 12, NULL, -10680, -10609, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-xie', 'zhou-west', 'ji-xie', '周夷王', NULL, -885, 1, NULL, -878, 12, NULL, -10608, -10513, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-hu', 'zhou-west', 'ji-hu', '周厉王', NULL, -877, 1, NULL, -841, 12, NULL, -10512, -10069, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-jing', 'zhou-west', 'ji-jing', '周宣王', NULL, -827, 1, NULL, -782, 12, NULL, -9912, -9361, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-gongsheng', 'zhou-west', 'ji-gongsheng', '周幽王', NULL, -781, 1, NULL, -771, 12, NULL, -9360, -9229, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-yijiu', 'zhou-east', 'ji-yijiu', '周平王', NULL, -770, 1, NULL, -720, 12, NULL, -9228, -8617, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-yuchen', 'zhou-east', 'ji-yuchen', '周携王', NULL, -770, 1, NULL, -750, 12, NULL, -9228, -8977, 'year', NULL, NULL, 'xie', '携', 'rival', false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-lin', 'zhou-east', 'ji-lin', '周桓王', NULL, -719, 1, NULL, -697, 12, NULL, -8616, -8341, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-tuo', 'zhou-east', 'ji-tuo', '周庄王', NULL, -696, 1, NULL, -682, 12, NULL, -8340, -8161, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-huqi', 'zhou-east', 'ji-huqi', '周釐王', NULL, -681, 1, NULL, -677, 12, NULL, -8160, -8101, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-lang', 'zhou-east', 'ji-lang', '周惠王', NULL, -676, 1, NULL, -652, 12, NULL, -8100, -7801, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-zheng', 'zhou-east', 'ji-zheng', '周襄王', NULL, -651, 1, NULL, -619, 12, NULL, -7800, -7405, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-renchen', 'zhou-east', 'ji-renchen', '周顷王', NULL, -618, 1, NULL, -613, 12, NULL, -7404, -7333, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-ban', 'zhou-east', 'ji-ban', '周匡王', NULL, -612, 1, NULL, -607, 12, NULL, -7332, -7261, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-yu', 'zhou-east', 'ji-yu', '周定王', NULL, -606, 1, NULL, -586, 12, NULL, -7260, -7009, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-yi', 'zhou-east', 'ji-yi', '周简王', NULL, -585, 1, NULL, -572, 12, NULL, -7008, -6841, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-xiexin', 'zhou-east', 'ji-xiexin', '周灵王', NULL, -571, 1, NULL, -545, 12, NULL, -6840, -6517, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-gui', 'zhou-east', 'ji-gui', '周景王', NULL, -544, 1, NULL, -521, 12, NULL, -6516, -6229, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-meng', 'zhou-east', 'ji-meng', '周悼王', NULL, -520, 1, NULL, -520, 12, NULL, -6228, -6217, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-gai', 'zhou-east', 'ji-gai', '周敬王', NULL, -519, 1, NULL, -477, 12, NULL, -6216, -5701, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-ren', 'zhou-east', 'ji-ren', '周元王', NULL, -476, 1, NULL, -469, 12, NULL, -5700, -5605, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-jie', 'zhou-east', 'ji-jie', '周贞定王', NULL, -468, 1, NULL, -442, 12, NULL, -5604, -5281, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-quji', 'zhou-east', 'ji-quji', '周哀王', NULL, -441, 1, NULL, -441, 3, NULL, -5280, -5278, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-shu', 'zhou-east', 'ji-shu', '周思王', NULL, -441, 4, NULL, -441, 12, NULL, -5277, -5269, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-wei', 'zhou-east', 'ji-wei', '周考王', NULL, -440, 1, NULL, -426, 12, NULL, -5268, -5089, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-wu', 'zhou-east', 'ji-wu', '周威烈王', NULL, -425, 1, NULL, -402, 12, NULL, -5088, -4801, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-jiao', 'zhou-east', 'ji-jiao', '周安王', NULL, -401, 1, NULL, -376, 12, NULL, -4800, -4489, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-xi', 'zhou-east', 'ji-xi', '周烈王', NULL, -375, 1, NULL, -369, 12, NULL, -4488, -4405, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-bian', 'zhou-east', 'ji-bian', '周显王', NULL, -368, 1, NULL, -321, 12, NULL, -4404, -3829, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-ding', 'zhou-east', 'ji-ding', '周慎靓王', NULL, -320, 1, NULL, -315, 12, NULL, -3828, -3757, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;
INSERT INTO reigns (id, dynasty_id, person_id, title, era_names, start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, precision, start_date_confidence, end_date_confidence, claim_track, claim_label, claim_role, is_informal_monarch)
VALUES ('reign-ji-yan', 'zhou-east', 'ji-yan', '周赧王', NULL, -314, 1, NULL, -256, 12, NULL, -3756, -3049, 'year', NULL, NULL, NULL, NULL, NULL, false)
ON CONFLICT (id) DO UPDATE SET dynasty_id = EXCLUDED.dynasty_id, person_id = EXCLUDED.person_id, title = EXCLUDED.title, era_names = EXCLUDED.era_names, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, start_date_confidence = EXCLUDED.start_date_confidence, end_date_confidence = EXCLUDED.end_date_confidence, claim_track = EXCLUDED.claim_track, claim_label = EXCLUDED.claim_label, claim_role = EXCLUDED.claim_role, is_informal_monarch = EXCLUDED.is_informal_monarch;

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('yu-flood-control', '大禹治水', 'other', 'circa', 'century', '传说时代，具体年月不可考；窗口取夏朝建立前后的世纪尺度', -2070, 1, -24828, -2100, 1, -25188, -2070, 12, -24817, '传说禹疏导洪水，其后受禅，为夏后氏开国叙事的核心。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('gan-battle', '甘之战', 'battle', 'circa', 'decade', '《尚书·甘誓》载启伐有扈；绝对年取今本竹书年数自夏始顺推后的启在位段，标推算', -2053, 1, -24624, -2060, 1, -24708, -2045, 12, -24517, '夏启讨伐有扈氏，传统视为世袭王权确立过程中的战争。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('taikang-lost', '太康失国', 'politics', 'circa', 'decade', '太康失位传说。窗口取太康在位段（前2044–前2041）。', -2044, 12, -24505, -2044, 1, -24516, -2041, 12, -24469, '太康失位，有穷后羿因夏民以代夏政。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('shaokang-zhongxing', '少康中兴', 'politics', 'circa', 'decade', '少康灭寒浞、恢复夏政；窗口取今本竹书年数顺推后的少康在位段，标推算', -1959, 1, -23496, -1959, 1, -23496, -1939, 12, -23245, '后缗逃归有仍生少康；少康自有虞起兵，消灭寒浞、过浇，恢复夏后氏统治。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('kongjia-decline', '孔甲乱德', 'politics', 'circa', 'decade', '《史记·夏本纪》记孔甲好鬼神、夏德衰；绝对年取今本竹书年数顺推后的孔甲在位段，标推算', -1694, 1, -20316, -1709, 1, -20496, -1679, 12, -20125, '帝孔甲好方鬼神、事淫乱，夏后氏德衰、诸侯畔之；又有扰龙、刘累御龙传说。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('guanlongpang-remonstrance', '关龙逢谏桀', 'politics', 'circa', 'decade', '桀杀关龙逢出于《韩诗外传》等，具体年份不可考；窗取桀在位末段，标推算', -1600, 1, -19188, -1609, 1, -19296, -1600, 12, -19177, '传说夏桀通宵宴乐，关龙逢进黄图强谏，被桀所杀。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('mingtiao', '鸣条之战', 'battle', 'circa', 'decade', '夏商分界取断代工程约前1600年，战役月日不详', -1600, 1, -19188, -1610, 1, -19308, -1600, 12, -19177, '商汤与伊尹在鸣条击败夏桀，夏亡商兴。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('yiyin-taijia', '伊尹放太甲', 'politics', 'circa', 'decade', '桐宫放逐出于《史记》等传说，具体年份不可考', -1555, 1, -18648, -1560, 1, -18708, -1548, 12, -18553, '传说太甲不遵汤法，伊尹放之于桐，三年后迎归复位。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('taiwu-revival', '太戊修德', 'politics', 'circa', 'decade', '《史记》记太戊立伊陟为相、用巫咸；绝对年取本表太戊在位前十年（竹书积年，非实测）', -1494, 1, -17916, -1494, 1, -17916, -1485, 12, -17797, '太戊以伊陟为相，用巫咸；传说亳有祥桑榖，修德后枯死，殷道复兴。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('pangeng-move-yin', '盘庚迁殷', 'politics', 'circa', 'decade', '断代工程估定迁殷约前1300年，起迄年不详', -1300, 1, -15588, -1310, 1, -15708, -1290, 12, -15457, '盘庚迁都于殷（今安阳），此后商亦称殷。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('wuding-zhongxing', '武丁中兴', 'politics', 'span', 'year', '在位年取断代工程前1250–前1192年', NULL, NULL, NULL, -1250, 1, -14988, -1192, 12, -14281, '武丁对外用兵、内修祭祀，晚商达到鼎盛；甘盘、傅说辅政，妇好亦主征伐。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('fuyue-fuyan', '武丁举傅说', 'politics', 'circa', 'decade', '《史记》《说命》记武丁梦傅说、举于傅岩；年份不详，窗取武丁在位前十年', -1250, 1, -14988, -1250, 1, -14988, -1241, 12, -14869, '传说傅说在傅岩版筑，武丁按梦中形象求得，举以为相。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('bigan-killed', '比干谏死', 'politics', 'circa', 'year', '《今本竹书》系于帝辛末年杀王子比干；绝对年取牧野前1046年，月日不详', -1046, 12, -12529, -1047, 1, -12552, -1046, 12, -12529, '传说比干强谏帝辛，被剖心而死；与微子、箕子并称殷有三仁。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('muye', '牧野之战', 'battle', 'point', 'month', '断代工程取前1046年1月20日；月取正月，日不入库', -1046, 1, -12540, NULL, NULL, NULL, NULL, NULL, NULL, '周武王会师牧野克商，商周分界。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('sanjian-rebellion', '三监之乱', 'battle', 'circa', 'year', '成王初、周公摄政期间，绝对年据西周初框架', -1041, 12, -12469, -1042, 1, -12492, -1036, 12, -12409, '管蔡霍三监联合武庚叛周，周公东征平定，大规模封建东土。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('chengkang-rule', '成康之治', 'politics', 'span', 'year', '对应断代工程成王、康王在位年', NULL, NULL, NULL, -1042, 1, -12492, -996, 12, -11929, '西周早期政治相对安定，传统称刑错四十余年不用。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('zhaowang-south', '昭王南征', 'battle', 'circa', 'year', '昭王卒年取断代工程前977年，南征次数与月份不详', -977, 12, -11701, -995, 1, -11928, -977, 12, -11701, '周昭王多次南征荆楚，传说还师渡汉水而卒。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('guoren-riot', '国人暴动', 'politics', 'point', 'year', '共和元年即前841年，为中国有确切纪年之始', -841, 12, -10069, NULL, NULL, NULL, NULL, NULL, NULL, '厉王专利，国人暴动，王奔彘，周召共和行政。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('gonghe-regency', '共和行政', 'politics', 'span', 'year', '前841–前828年，一说周召二公共和，一说共伯和摄政', NULL, NULL, NULL, -841, 1, -10080, -828, 12, -9913, '厉王出奔后的十四年无王期，至宣王即位结束。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('xuanwang-zhongxing', '宣王中兴', 'politics', 'span', 'year', NULL, NULL, NULL, NULL, -827, 1, -9912, -782, 12, -9361, '宣王整顿朝政、征伐玁狁，西周国势一度回升。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('quanrong-invasion', '犬戎之祸', 'battle', 'point', 'year', '幽王十一年，前771年', -771, 12, -9229, NULL, NULL, NULL, NULL, NULL, NULL, '申侯联合犬戎攻破镐京，幽王死，西周亡。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('zhou-dual-kings', '二王并立', 'politics', 'point', 'year', '前771年幽王死后', -771, 12, -9229, NULL, NULL, NULL, NULL, NULL, NULL, '申侯等立平王，虢公翰等立携王；后世以平王东迁为东周正统。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('xie-wang-killed', '晋文侯杀携王', 'politics', 'point', 'year', '前750年', -750, 12, -8977, NULL, NULL, NULL, NULL, NULL, NULL, '晋文侯攻灭携王，二王并立终结，平王正统确立。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('pingwang-eastward', '平王东迁', 'politics', 'point', 'year', '平王元年，前770年', -770, 12, -9217, NULL, NULL, NULL, NULL, NULL, NULL, '平王迁都洛邑，东周开始，王室逐渐失去对诸侯的实质控制。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('chunqiu', '春秋', 'politics', 'span', 'year', '平王东迁（前770）至三家分晋（前403）；与战国以册命立国为界', NULL, NULL, NULL, -770, 1, -9228, -403, 12, -4813, '诸侯争霸、礼崩乐坏，周天子共主名存实亡。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('kuiqiu', '葵丘之盟', 'politics', 'point', 'year', '齐桓公三十五年，鲁僖公九年，前651年', -651, 12, -7789, NULL, NULL, NULL, NULL, NULL, NULL, '齐桓公会诸侯于葵丘，周襄王赐胙，齐霸达到顶点。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('chengpu', '城濮之战', 'battle', 'point', 'year', '鲁僖公二十八年，前632年', -632, 12, -7561, NULL, NULL, NULL, NULL, NULL, NULL, '楚围宋，宋向晋求援。晋先攻曹，因卫拒绝借道，又出兵伐卫；楚将宛春提出复曹、卫以换取楚军解宋围。晋采纳先轸之策，扣留宛春，暗中许诺复曹、卫，借此离间楚与曹、卫；又依晋文公旧诺退避三舍，最终在城濮击败楚军。战后晋复曹、卫，并于践土会盟，确立霸主地位。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('zhanguo', '战国', 'politics', 'span', 'year', '以三家分晋、周天子册命韩赵魏为诸侯（前403）为起点，迄秦统一前221年', NULL, NULL, NULL, -403, 1, -4824, -221, 12, -2629, '七雄兼并，变法图强，至秦始皇统一而结束。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('sanjia-fenjin', '三家分晋', 'politics', 'point', 'year', '周威烈王二十三年正式命韩赵魏为诸侯，前403年', -403, 12, -4813, NULL, NULL, NULL, NULL, NULL, NULL, '周天子承认韩、赵、魏，战国格局形成的标志性事件。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('baijia-zhengming', '百家争鸣', 'culture', 'circa', 'century', '思想活跃期约自春秋晚期至秦统一，并无单一起迄年', -400, 1, -4788, -551, 1, -6600, -221, 12, -2629, '儒墨道法名等学派并起，塑造此后中国思想传统。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;

-- event_dynasties
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yu-flood-control', 'xia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('gan-battle', 'xia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('taikang-lost', 'xia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('shaokang-zhongxing', 'xia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('kongjia-decline', 'xia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('guanlongpang-remonstrance', 'xia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('mingtiao', 'xia') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('mingtiao', 'shang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yiyin-taijia', 'shang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('taiwu-revival', 'shang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('pangeng-move-yin', 'shang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wuding-zhongxing', 'shang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('fuyue-fuyan', 'shang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('bigan-killed', 'shang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('muye', 'shang') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('muye', 'zhou-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('sanjian-rebellion', 'zhou-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chengkang-rule', 'zhou-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhaowang-south', 'zhou-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('guoren-riot', 'zhou-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('gonghe-regency', 'zhou-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xuanwang-zhongxing', 'zhou-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('quanrong-invasion', 'zhou-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhou-dual-kings', 'zhou-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xie-wang-killed', 'zhou-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('pingwang-eastward', 'zhou-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chunqiu', 'zhou-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('kuiqiu', 'zhou-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chengpu', 'zhou-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhanguo', 'zhou-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('sanjia-fenjin', 'zhou-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('baijia-zhengming', 'zhou-east') ON CONFLICT DO NOTHING;

-- event_participants
INSERT INTO event_participants (event_id, person_id) VALUES ('yu-flood-control', 'si-yu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yu-flood-control', 'gun') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yu-flood-control', 'gao-yao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yu-flood-control', 'bo-yi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yu-flood-control', 'tu-shan-shi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('gan-battle', 'si-qi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('taikang-lost', 'si-taikang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('taikang-lost', 'hou-yi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('shaokang-zhongxing', 'si-shaokang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('shaokang-zhongxing', 'hou-min') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('shaokang-zhongxing', 'han-zhuo') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('shaokang-zhongxing', 'han-jiao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('kongjia-decline', 'si-kongjia') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('guanlongpang-remonstrance', 'si-jie') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('guanlongpang-remonstrance', 'guan-longpang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('mingtiao', 'si-jie') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('mingtiao', 'zi-tang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('mingtiao', 'yi-yin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('mingtiao', 'zhong-hui') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('mingtiao', 'mo-xi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yiyin-taijia', 'yi-yin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yiyin-taijia', 'zi-taijia') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('taiwu-revival', 'zi-taiwu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('taiwu-revival', 'yi-zhi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('taiwu-revival', 'wu-xian') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('pangeng-move-yin', 'zi-pangeng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wuding-zhongxing', 'zi-wuding') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wuding-zhongxing', 'fu-hao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wuding-zhongxing', 'fu-yue') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wuding-zhongxing', 'gan-pan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('fuyue-fuyan', 'zi-wuding') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('fuyue-fuyan', 'fu-yue') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('fuyue-fuyan', 'gan-pan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('bigan-killed', 'zi-dixin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('bigan-killed', 'bi-gan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('muye', 'zi-dixin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('muye', 'ji-fa') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('muye', 'lv-shang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('muye', 'da-ji') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('sanjian-rebellion', 'ji-song') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('sanjian-rebellion', 'ji-dan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chengkang-rule', 'ji-song') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chengkang-rule', 'ji-zhao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chengkang-rule', 'ji-dan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhaowang-south', 'ji-xia') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('guoren-riot', 'ji-hu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('gonghe-regency', 'ji-hu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('xuanwang-zhongxing', 'ji-jing') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('quanrong-invasion', 'ji-gongsheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('quanrong-invasion', 'ji-yijiu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhou-dual-kings', 'ji-yijiu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhou-dual-kings', 'ji-yuchen') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('xie-wang-killed', 'ji-yuchen') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('pingwang-eastward', 'ji-yijiu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('kuiqiu', 'jiang-xiaobai') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('kuiqiu', 'guan-zhong') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('kuiqiu', 'ji-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chengpu', 'ji-chonger') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('sanjia-fenjin', 'ji-wu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('baijia-zhengming', 'kong-qiu') ON CONFLICT DO NOTHING;

-- relations
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-yu-si-qi-succession', 'person', 'si-yu', 'person', 'si-qi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-qi-si-taikang-succession', 'person', 'si-qi', 'person', 'si-taikang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-taikang-si-zhongkang-succession', 'person', 'si-taikang', 'person', 'si-zhongkang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-zhongkang-si-xiang-succession', 'person', 'si-zhongkang', 'person', 'si-xiang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-xiang-si-shaokang-succession', 'person', 'si-xiang', 'person', 'si-shaokang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-shaokang-si-zhu-succession', 'person', 'si-shaokang', 'person', 'si-zhu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-zhu-si-huai-succession', 'person', 'si-zhu', 'person', 'si-huai', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-huai-si-mang-succession', 'person', 'si-huai', 'person', 'si-mang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-mang-si-xie-succession', 'person', 'si-mang', 'person', 'si-xie', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-xie-si-bujiang-succession', 'person', 'si-xie', 'person', 'si-bujiang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-bujiang-si-jiong-succession', 'person', 'si-bujiang', 'person', 'si-jiong', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-jiong-si-jin-succession', 'person', 'si-jiong', 'person', 'si-jin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-jin-si-kongjia-succession', 'person', 'si-jin', 'person', 'si-kongjia', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-kongjia-si-gao-succession', 'person', 'si-kongjia', 'person', 'si-gao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-gao-si-fa-succession', 'person', 'si-gao', 'person', 'si-fa', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-si-fa-si-jie-succession', 'person', 'si-fa', 'person', 'si-jie', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-tang-zi-waibing-succession', 'person', 'zi-tang', 'person', 'zi-waibing', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-waibing-zi-zhongren-succession', 'person', 'zi-waibing', 'person', 'zi-zhongren', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-zhongren-zi-taijia-succession', 'person', 'zi-zhongren', 'person', 'zi-taijia', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-taijia-zi-woding-succession', 'person', 'zi-taijia', 'person', 'zi-woding', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-woding-zi-taigeng-succession', 'person', 'zi-woding', 'person', 'zi-taigeng', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-taigeng-zi-xiaojia-succession', 'person', 'zi-taigeng', 'person', 'zi-xiaojia', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-xiaojia-zi-yongji-succession', 'person', 'zi-xiaojia', 'person', 'zi-yongji', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-yongji-zi-taiwu-succession', 'person', 'zi-yongji', 'person', 'zi-taiwu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-taiwu-zi-zhongding-succession', 'person', 'zi-taiwu', 'person', 'zi-zhongding', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-zhongding-zi-wairen-succession', 'person', 'zi-zhongding', 'person', 'zi-wairen', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-wairen-zi-hedanjia-succession', 'person', 'zi-wairen', 'person', 'zi-hedanjia', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-hedanjia-zi-zuyi-succession', 'person', 'zi-hedanjia', 'person', 'zi-zuyi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-zuyi-zi-zuxin-succession', 'person', 'zi-zuyi', 'person', 'zi-zuxin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-zuxin-zi-wojia-succession', 'person', 'zi-zuxin', 'person', 'zi-wojia', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-wojia-zi-zuding-succession', 'person', 'zi-wojia', 'person', 'zi-zuding', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-zuding-zi-nangeng-succession', 'person', 'zi-zuding', 'person', 'zi-nangeng', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-nangeng-zi-yangjia-succession', 'person', 'zi-nangeng', 'person', 'zi-yangjia', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-yangjia-zi-pangeng-succession', 'person', 'zi-yangjia', 'person', 'zi-pangeng', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-pangeng-zi-xiaoxin-succession', 'person', 'zi-pangeng', 'person', 'zi-xiaoxin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-xiaoxin-zi-xiaoyi-succession', 'person', 'zi-xiaoxin', 'person', 'zi-xiaoyi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-xiaoyi-zi-wuding-succession', 'person', 'zi-xiaoyi', 'person', 'zi-wuding', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-wuding-zi-zugeng-succession', 'person', 'zi-wuding', 'person', 'zi-zugeng', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-zugeng-zi-zujia-succession', 'person', 'zi-zugeng', 'person', 'zi-zujia', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-zujia-zi-linxin-succession', 'person', 'zi-zujia', 'person', 'zi-linxin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-linxin-zi-gengding-succession', 'person', 'zi-linxin', 'person', 'zi-gengding', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-gengding-zi-wuyi-succession', 'person', 'zi-gengding', 'person', 'zi-wuyi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-wuyi-zi-wending-succession', 'person', 'zi-wuyi', 'person', 'zi-wending', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-wending-zi-diyi-succession', 'person', 'zi-wending', 'person', 'zi-diyi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zi-diyi-zi-dixin-succession', 'person', 'zi-diyi', 'person', 'zi-dixin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-fa-ji-song-succession', 'person', 'ji-fa', 'person', 'ji-song', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-song-ji-zhao-succession', 'person', 'ji-song', 'person', 'ji-zhao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-zhao-ji-xia-succession', 'person', 'ji-zhao', 'person', 'ji-xia', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-xia-ji-man-succession', 'person', 'ji-xia', 'person', 'ji-man', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-man-ji-yihu-succession', 'person', 'ji-man', 'person', 'ji-yihu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-yihu-ji-jian-succession', 'person', 'ji-yihu', 'person', 'ji-jian', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-jian-ji-pifang-succession', 'person', 'ji-jian', 'person', 'ji-pifang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-pifang-ji-xie-succession', 'person', 'ji-pifang', 'person', 'ji-xie', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-xie-ji-hu-succession', 'person', 'ji-xie', 'person', 'ji-hu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-hu-ji-jing-succession', 'person', 'ji-hu', 'person', 'ji-jing', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-jing-ji-gongsheng-succession', 'person', 'ji-jing', 'person', 'ji-gongsheng', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-yijiu-ji-lin-succession', 'person', 'ji-yijiu', 'person', 'ji-lin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-lin-ji-tuo-succession', 'person', 'ji-lin', 'person', 'ji-tuo', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-tuo-ji-huqi-succession', 'person', 'ji-tuo', 'person', 'ji-huqi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-huqi-ji-lang-succession', 'person', 'ji-huqi', 'person', 'ji-lang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-lang-ji-zheng-succession', 'person', 'ji-lang', 'person', 'ji-zheng', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-zheng-ji-renchen-succession', 'person', 'ji-zheng', 'person', 'ji-renchen', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-renchen-ji-ban-succession', 'person', 'ji-renchen', 'person', 'ji-ban', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-ban-ji-yu-succession', 'person', 'ji-ban', 'person', 'ji-yu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-yu-ji-yi-succession', 'person', 'ji-yu', 'person', 'ji-yi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-yi-ji-xiexin-succession', 'person', 'ji-yi', 'person', 'ji-xiexin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-xiexin-ji-gui-succession', 'person', 'ji-xiexin', 'person', 'ji-gui', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-gui-ji-meng-succession', 'person', 'ji-gui', 'person', 'ji-meng', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-meng-ji-gai-succession', 'person', 'ji-meng', 'person', 'ji-gai', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-gai-ji-ren-succession', 'person', 'ji-gai', 'person', 'ji-ren', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-ren-ji-jie-succession', 'person', 'ji-ren', 'person', 'ji-jie', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-jie-ji-quji-succession', 'person', 'ji-jie', 'person', 'ji-quji', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-quji-ji-shu-succession', 'person', 'ji-quji', 'person', 'ji-shu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-shu-ji-wei-succession', 'person', 'ji-shu', 'person', 'ji-wei', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-wei-ji-wu-succession', 'person', 'ji-wei', 'person', 'ji-wu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-wu-ji-jiao-succession', 'person', 'ji-wu', 'person', 'ji-jiao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-jiao-ji-xi-succession', 'person', 'ji-jiao', 'person', 'ji-xi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-xi-ji-bian-succession', 'person', 'ji-xi', 'person', 'ji-bian', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-bian-ji-ding-succession', 'person', 'ji-bian', 'person', 'ji-ding', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-ding-ji-yan-succession', 'person', 'ji-ding', 'person', 'ji-yan', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ji-chang-ji-fa-succession', 'person', 'ji-chang', 'person', 'ji-fa', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-hou-yi-han-zhuo-succession', 'person', 'hou-yi', 'person', 'han-zhuo', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-mingtiao-tang', 'event', 'mingtiao', 'person', 'zi-tang', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-muye-fa', 'event', 'muye', 'person', 'ji-fa', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-chengpu-chonger', 'event', 'chengpu', 'person', 'ji-chonger', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;

COMMIT;
