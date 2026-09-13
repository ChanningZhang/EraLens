-- EraLens period import: qin-han
-- Window: -221-01 .. 220-12
-- Chronology: Shiji + Wikipedia Han dynasty emperor list
BEGIN;

-- persons
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'ying-zheng', '嬴政',
  -259, 1,
  -210, 1,
  ARRAY['皇帝'], '秦始皇帝，灭六国统一天下，建立中国首个大一统中央集权帝国。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦始皇"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'ying-huhai', '胡亥',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '秦二世皇帝，赵高矫诏即位，秦政益暴，终致天下反叛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦二世"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'ying-ziying', '子婴',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦末秦王，赵高废二世后立之，刘邦入关后投降，秦朝终结。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦王子婴"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'li-si', '李斯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['政治家'], '秦相，助嬴政统一，推行郡县、书同文，后因赵高陷害被诛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/李斯"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'chen-sheng', '陈胜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['起义领袖'], '大泽乡起义领袖，首开秦末农民战争。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/陈胜"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'wu-guang', '吴广',
  NULL, NULL,
  NULL, NULL,
  ARRAY['起义领袖'], '与陈胜共举大泽乡义旗，后称王于张楚。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吴广"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'xiang-yu', '项羽',
  -232, 1,
  -202, 1,
  ARRAY['霸王','军事家'], '西楚霸王，巨鹿破秦军，垓下败于刘邦后自刎。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/项羽"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-bang', '刘邦',
  -256, 1,
  -195, 1,
  ARRAY['皇帝'], '汉高祖，楚汉之争胜项羽，建立西汉。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘邦"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'lv-zhi', '吕雉',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇后','政治家'], '汉高祖皇后，惠帝后临朝称制，史称吕后。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吕雉"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'xiao-he', '萧何',
  -257, 1,
  -193, 1,
  ARRAY['政治家'], '汉初相国，定都长安、制律令，与韩信、张良并称三杰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧何"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'han-xin', '韩信',
  -231, 1,
  -196, 1,
  ARRAY['军事家'], '汉初大将，破赵燕齐楚，垓下围项羽，后遭诛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩信"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'zhang-liang', '张良',
  -250, 1,
  -186, 1,
  ARRAY['政治家','军事家'], '汉初谋臣，鸿门宴护刘邦，功成身退。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/张良"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-ying', '刘盈',
  -211, 1,
  -188, 1,
  ARRAY['皇帝'], '汉惠帝，高祖嫡子，在位推行与民休息。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘盈"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-gong', '刘恭',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '史称前少帝，惠帝子，为吕后所废杀，汉朝未正式承认。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘恭"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-hong-shao', '刘弘',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '史称后少帝，吕氏所立，文帝即位后被废，汉朝未正式承认。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘弘"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-heng', '刘恒',
  -203, 1,
  -157, 1,
  ARRAY['皇帝'], '汉文帝，铲除诸吕后即位，与景帝共创文景之治。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉文帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-qi', '刘启',
  -188, 1,
  -141, 1,
  ARRAY['皇帝'], '汉景帝，平定七国之乱，延续轻徭薄赋。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉景帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-che', '刘彻',
  -156, 1,
  -87, 1,
  ARRAY['皇帝'], '汉武帝，开疆拓土、独尊儒术，西汉国力达于鼎盛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉武帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-fuling', '刘弗陵',
  -94, 1,
  -74, 1,
  ARRAY['皇帝'], '汉昭帝，武帝少子，与宣帝之间史称昭宣之治。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉昭帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-he', '刘贺',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '汉废帝，昭帝崩后由霍光等拥立，在位仅二十七日即被废。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘贺"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-xun', '刘询',
  -91, 1,
  -48, 1,
  ARRAY['皇帝'], '汉宣帝，武帝曾孙，中兴汉室，史称昭宣之治。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉宣帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-shi', '刘奭',
  -75, 1,
  -33, 1,
  ARRAY['皇帝'], '汉元帝，昭君出塞在其朝。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉元帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-ao', '刘骜',
  -51, 1,
  -7, 1,
  ARRAY['皇帝'], '汉成帝，外戚王氏势力渐盛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉成帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-xin', '刘欣',
  -27, 1,
  -1, 1,
  ARRAY['皇帝'], '汉哀帝，在位短暂，西汉由盛转衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉哀帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-kan', '刘衎',
  -9, 1,
  6, 1,
  ARRAY['皇帝'], '汉平帝，王莽摄政，西汉实亡于其朝。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉平帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'ruzi-ying', '刘婴',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '孺子婴，平帝死后王莽立为太子而未正式登基，新莽代汉。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孺子婴"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'zhang-qian', '张骞',
  -164, 1,
  -114, 1,
  ARRAY['外交家'], '汉武帝时两次出使西域，开辟丝绸之路。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/张骞"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'zhang-han', '章邯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['将领'], '秦末名将，巨鹿败后降楚，后降汉封雍王。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/章邯"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'xiang-liang', '项梁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['起义领袖','将领'], '项羽叔父，会稽起兵反秦，立楚怀王，战死于定陶。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/项梁"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'wei-bao', '魏豹',
  NULL, NULL,
  NULL, NULL,
  ARRAY['诸侯'], '魏王豹，秦末复立魏国，楚汉间反复，终为韩信所灭。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏王豹"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'wei-qing', '卫青',
  NULL, NULL,
  NULL, NULL,
  ARRAY['军事家'], '汉武帝时大将，屡破匈奴，封大将军。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫青"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'huo-qubing', '霍去病',
  -140, 1,
  -117, 1,
  ARRAY['军事家'], '汉武帝时名将，河西、漠北连破匈奴，封冠军侯。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/霍去病"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'wang-mang', '王莽',
  -45, 1,
  23, 1,
  ARRAY['皇帝'], '新莽开国皇帝，外戚出身，篡汉自立，改革失败，绿林起义而亡。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王莽"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-xuan', '刘玄',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '更始帝，绿林军拥立，新莽亡后短暂称帝，后为赤眉所杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/更始帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-xiu', '刘秀',
  -5, 1,
  57, 1,
  ARRAY['皇帝'], '光武帝，东汉开国皇帝，昆阳之战后统一天下。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘秀"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-zhuang', '刘庄',
  28, 1,
  75, 1,
  ARRAY['皇帝'], '汉明帝，光武帝子，继续巩固东汉统治。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉明帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-zuo', '刘炟',
  57, 1,
  88, 1,
  ARRAY['皇帝'], '汉章帝，明帝子，东汉前期国力稳固。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉章帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-zhao', '刘肇',
  79, 1,
  106, 1,
  ARRAY['皇帝'], '汉和帝，章帝子，东汉国力达于鼎盛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉和帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-long', '刘隆',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '汉殇帝，和帝子，即位百日而崩，中国历史上最短命皇帝之一。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉殇帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-hu', '刘祜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '汉安帝，东汉中期皇帝，外戚宦官势力渐盛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉安帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-yi-shao', '刘懿',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '汉前少帝，安帝子，在位数月即卒。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉少帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-bao', '刘保',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '汉顺帝，东汉中后期皇帝。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉顺帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-bing', '刘炳',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '汉冲帝，顺帝子，在位不足两年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉冲帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-zuan', '刘缵',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '汉质帝，在位一年余，为梁太后所害。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉质帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-zhi', '刘志',
  132, 1,
  168, 1,
  ARRAY['皇帝'], '汉桓帝，诛灭梁氏外戚，后期宦官专权。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉桓帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-hong', '刘宏',
  157, 1,
  189, 1,
  ARRAY['皇帝'], '汉灵帝，东汉末年皇帝，黄巾起义在其朝爆发。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉灵帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-bian', '刘辩',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '汉后少帝，灵帝长子，为董卓所废。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉少帝刘辩"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-xie', '刘协',
  181, 1,
  234, 1,
  ARRAY['皇帝'], '汉献帝，东汉末代皇帝，曹丕受禅后东汉终结。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/汉献帝"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'zhao-gao', '赵高',
  NULL, NULL,
  NULL, NULL,
  ARRAY['政治家'], '秦宦官，矫诏立胡亥，指鹿为马，后被子婴诛杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵高"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'huo-guang', '霍光',
  -68, 1,
  68, 1,
  ARRAY['政治家'], '汉昭帝辅政大臣，废立昌邑王、拥立宣帝，权倾朝野。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/霍光"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'wang-zhaojun', '王昭君',
  -52, 1,
  -15, 1,
  ARRAY['后妃'], '汉元帝宫人，自愿和亲匈奴，昭君出塞。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王昭君"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'dou-taihou', '窦太后',
  NULL, NULL,
  NULL, NULL,
  ARRAY['太后','政治家'], '汉文帝皇后，景帝生母，崇尚黄老，文景之治重要推手。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/窦太后"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liang-taihou', '梁太后',
  NULL, NULL,
  NULL, NULL,
  ARRAY['太后','政治家'], '汉顺帝皇后，质帝、桓帝朝临朝，毒杀质帝。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/梁妢"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'dong-zhongshu', '董仲舒',
  -179, 1,
  -104, 1,
  ARRAY['思想家'], '汉武帝时大儒，独尊儒术理论奠基者。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/董仲舒"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'si-ma-qian', '司马迁',
  -145, 1,
  -86, 1,
  ARRAY['史学家'], '汉武帝时太史令，著史记，中国第一部纪传体通史。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/司马迁"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'ban-chao', '班超',
  32, 1,
  102, 1,
  ARRAY['外交家','军事家'], '东汉名将，投笔从戎，通西域三十六年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/班超"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'cai-lun', '蔡伦',
  NULL, NULL,
  NULL, NULL,
  ARRAY['发明家'], '东汉宦官，改进造纸术，纸张普及为之勃兴。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/蔡伦"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;

-- dynasties
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'chu-west', '西楚', ARRAY['楚'], 'cn', 'east_asia',
  -206, 1, -202, 12,
  -2460, -2401, 'year', 'indigo', NULL,
  '项羽分封后自立西楚霸王，都彭城；垓下败亡，政权终结。'
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
  color_token = EXCLUDED.color_token,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'han-west', '西汉', ARRAY['前汉','汉'], 'cn', 'east_asia',
  -202, 1, 8, 11,
  -2412, 106, 'year', 'mineral', NULL,
  '刘邦称帝定都长安；孺子婴被废、王莽代汉，前8年十一月西汉终结。'
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
  color_token = EXCLUDED.color_token,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'xin', '新', ARRAY['新莽'], 'cn', 'east_asia',
  9, 1, 23, 10,
  108, 285, 'year', 'moss', NULL,
  '王莽篡汉自立，国号新；地皇四年绿林攻入长安，王莽被杀。'
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
  color_token = EXCLUDED.color_token,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'han-gengshi', '更始', ARRAY['玄汉'], 'cn', 'east_asia',
  23, 1, 25, 10,
  276, 309, 'year', 'wisteria', NULL,
  '绿林军拥立更始帝刘玄，复汉号；赤眉入长安后刘玄降被杀。'
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
  color_token = EXCLUDED.color_token,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'han-east', '东汉', ARRAY['后汉'], 'cn', 'east_asia',
  25, 1, 220, 12,
  300, 2651, 'year', 'cinnabar', NULL,
  '光武帝刘秀建立，定都洛阳；献帝禅让曹丕，东汉终结。'
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
  color_token = EXCLUDED.color_token,
  note = EXCLUDED.note;

-- reigns
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-ying-zheng', 'qin', 'ying-zheng', '秦始皇帝',
  NULL, NULL, '{"kind":"regnal","name":"秦始皇"}'::jsonb,
  -221, 1, -210, 12,
  -2640, -2497, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-ying-huhai', 'qin', 'ying-huhai', '秦二世皇帝',
  NULL, NULL, '{"kind":"regnal","name":"秦二世"}'::jsonb,
  -210, 1, -207, 12,
  -2508, -2461, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-ying-ziying', 'qin', 'ying-ziying', '秦王子婴',
  NULL, NULL, '{"kind":"regnal","name":"秦王子婴"}'::jsonb,
  -207, 1, -207, 12,
  -2472, -2461, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-xiang-yu', 'chu-west', 'xiang-yu', '西楚霸王',
  NULL, NULL, '{"kind":"posthumous","name":"西楚霸王"}'::jsonb,
  -206, 1, -202, 12,
  -2460, -2401, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-bang', 'han-west', 'liu-bang', '汉高祖',
  '高皇帝', '太祖', '{"kind":"posthumous","name":"汉高祖"}'::jsonb,
  -202, 1, -195, 12,
  -2412, -2317, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-ying', 'han-west', 'liu-ying', '汉惠帝',
  '孝惠皇帝', NULL, '{"kind":"posthumous","name":"汉惠帝"}'::jsonb,
  -195, 1, -188, 12,
  -2328, -2233, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-gong', 'han-west', 'liu-gong', '汉前少帝',
  NULL, NULL, '{"kind":"posthumous","name":"汉前少帝"}'::jsonb,
  -188, 1, -184, 12,
  -2244, -2185, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-hong-shao', 'han-west', 'liu-hong-shao', '汉后少帝',
  NULL, NULL, '{"kind":"posthumous","name":"汉后少帝"}'::jsonb,
  -184, 1, -180, 12,
  -2196, -2137, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-heng', 'han-west', 'liu-heng', '汉文帝',
  '孝文皇帝', '太宗', '{"kind":"posthumous","name":"汉文帝"}'::jsonb,
  -180, 1, -157, 12,
  -2148, -1861, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-qi', 'han-west', 'liu-qi', '汉景帝',
  '孝景皇帝', NULL, '{"kind":"posthumous","name":"汉景帝"}'::jsonb,
  -157, 1, -141, 12,
  -1872, -1669, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-che', 'han-west', 'liu-che', '汉武帝',
  '孝武皇帝', '世宗', '{"kind":"posthumous","name":"汉武帝"}'::jsonb,
  -141, 1, -87, 12,
  -1680, -1021, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-fuling', 'han-west', 'liu-fuling', '汉昭帝',
  '孝昭皇帝', NULL, '{"kind":"posthumous","name":"汉昭帝"}'::jsonb,
  -87, 1, -74, 12,
  -1032, -865, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-he', 'han-west', 'liu-he', '汉废帝',
  NULL, NULL, '{"kind":"posthumous","name":"汉废帝"}'::jsonb,
  -74, 1, -74, 12,
  -876, -865, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-xun', 'han-west', 'liu-xun', '汉宣帝',
  '孝宣皇帝', NULL, '{"kind":"posthumous","name":"汉宣帝"}'::jsonb,
  -74, 1, -48, 12,
  -876, -553, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-shi', 'han-west', 'liu-shi', '汉元帝',
  '孝元皇帝', NULL, '{"kind":"posthumous","name":"汉元帝"}'::jsonb,
  -48, 1, -33, 12,
  -564, -373, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-ao', 'han-west', 'liu-ao', '汉成帝',
  '孝成皇帝', NULL, '{"kind":"posthumous","name":"汉成帝"}'::jsonb,
  -33, 1, -7, 12,
  -384, -61, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-xin', 'han-west', 'liu-xin', '汉哀帝',
  '孝哀皇帝', NULL, '{"kind":"posthumous","name":"汉哀帝"}'::jsonb,
  -7, 1, -1, 12,
  -72, 11, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-kan', 'han-west', 'liu-kan', '汉平帝',
  '孝平皇帝', NULL, '{"kind":"posthumous","name":"汉平帝"}'::jsonb,
  -1, 1, 6, 12,
  0, 83, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-ruzi-ying', 'han-west', 'ruzi-ying', '孺子婴',
  NULL, NULL, '{"kind":"era","name":"居摄"}'::jsonb,
  6, 1, 8, 12,
  72, 107, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-wang-mang', 'xin', 'wang-mang', '新莽皇帝',
  NULL, NULL, '{"kind":"regnal","name":"王莽"}'::jsonb,
  9, 1, 23, 12,
  108, 287, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-xuan', 'han-gengshi', 'liu-xuan', '更始帝',
  NULL, NULL, '{"kind":"regnal","name":"更始帝"}'::jsonb,
  23, 1, 25, 12,
  276, 311, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-xiu', 'han-east', 'liu-xiu', '汉光武帝',
  '光武皇帝', '世祖', '{"kind":"posthumous","name":"汉光武帝"}'::jsonb,
  25, 1, 57, 12,
  300, 695, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-zhuang', 'han-east', 'liu-zhuang', '汉明帝',
  '孝明皇帝', '显宗', '{"kind":"posthumous","name":"汉明帝"}'::jsonb,
  57, 1, 75, 12,
  684, 911, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-zuo', 'han-east', 'liu-zuo', '汉章帝',
  '孝章皇帝', '肃宗', '{"kind":"posthumous","name":"汉章帝"}'::jsonb,
  75, 1, 88, 12,
  900, 1067, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-zhao', 'han-east', 'liu-zhao', '汉和帝',
  '孝和皇帝', NULL, '{"kind":"posthumous","name":"汉和帝"}'::jsonb,
  88, 1, 106, 12,
  1056, 1283, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-long', 'han-east', 'liu-long', '汉殇帝',
  '孝殇皇帝', NULL, '{"kind":"posthumous","name":"汉殇帝"}'::jsonb,
  106, 1, 106, 12,
  1272, 1283, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-hu', 'han-east', 'liu-hu', '汉安帝',
  '孝安皇帝', NULL, '{"kind":"posthumous","name":"汉安帝"}'::jsonb,
  106, 1, 125, 12,
  1272, 1511, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-yi-shao', 'han-east', 'liu-yi-shao', '汉前少帝',
  NULL, NULL, '{"kind":"posthumous","name":"汉前少帝"}'::jsonb,
  125, 1, 125, 12,
  1500, 1511, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-bao', 'han-east', 'liu-bao', '汉顺帝',
  '孝顺皇帝', NULL, '{"kind":"posthumous","name":"汉顺帝"}'::jsonb,
  125, 1, 144, 12,
  1500, 1739, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-bing', 'han-east', 'liu-bing', '汉冲帝',
  '孝冲皇帝', NULL, '{"kind":"posthumous","name":"汉冲帝"}'::jsonb,
  144, 1, 145, 12,
  1728, 1751, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-zuan', 'han-east', 'liu-zuan', '汉质帝',
  '孝质皇帝', NULL, '{"kind":"posthumous","name":"汉质帝"}'::jsonb,
  145, 1, 146, 12,
  1740, 1763, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-zhi', 'han-east', 'liu-zhi', '汉桓帝',
  '孝桓皇帝', NULL, '{"kind":"posthumous","name":"汉桓帝"}'::jsonb,
  146, 1, 168, 12,
  1752, 2027, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-hong', 'han-east', 'liu-hong', '汉灵帝',
  '孝灵皇帝', NULL, '{"kind":"posthumous","name":"汉灵帝"}'::jsonb,
  168, 1, 189, 12,
  2016, 2279, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-bian', 'han-east', 'liu-bian', '汉后少帝',
  NULL, NULL, '{"kind":"posthumous","name":"汉后少帝"}'::jsonb,
  189, 1, 189, 12,
  2268, 2279, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-liu-xie', 'han-east', 'liu-xie', '汉献帝',
  '孝献皇帝', NULL, '{"kind":"posthumous","name":"汉献帝"}'::jsonb,
  189, 1, 220, 12,
  2268, 2651, 'year'
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  posthumous_name = EXCLUDED.posthumous_name,
  temple_name = EXCLUDED.temple_name,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision;

-- era_names
DELETE FROM era_names WHERE reign_id = 'reign-liu-che';
DELETE FROM era_names WHERE reign_id = 'reign-liu-fuling';
DELETE FROM era_names WHERE reign_id = 'reign-liu-xun';
DELETE FROM era_names WHERE reign_id = 'reign-liu-shi';
DELETE FROM era_names WHERE reign_id = 'reign-liu-ao';
DELETE FROM era_names WHERE reign_id = 'reign-liu-xin';
DELETE FROM era_names WHERE reign_id = 'reign-liu-kan';
DELETE FROM era_names WHERE reign_id = 'reign-ruzi-ying';
DELETE FROM era_names WHERE reign_id = 'reign-wang-mang';
DELETE FROM era_names WHERE reign_id = 'reign-liu-xuan';
DELETE FROM era_names WHERE reign_id = 'reign-liu-xiu';
DELETE FROM era_names WHERE reign_id = 'reign-liu-zhuang';
DELETE FROM era_names WHERE reign_id = 'reign-liu-zuo';
DELETE FROM era_names WHERE reign_id = 'reign-liu-zhao';
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '建元', -140, 1, -135, 12, -1668, -1597, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '元光', -134, 1, -129, 12, -1596, -1525, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '元朔', -128, 1, -123, 12, -1524, -1453, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '元狩', -122, 1, -117, 12, -1452, -1381, 3);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '元鼎', -116, 1, -111, 12, -1380, -1309, 4);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '元封', -110, 1, -105, 12, -1308, -1237, 5);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '太初', -104, 1, -101, 12, -1236, -1189, 6);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '天汉', -100, 1, -97, 12, -1188, -1141, 7);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '太始', -96, 1, -93, 12, -1140, -1093, 8);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '征和', -92, 1, -89, 12, -1092, -1045, 9);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-che', '后元', -88, 1, -87, 12, -1044, -1021, 10);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-fuling', '始元', -86, 1, -81, 12, -1020, -949, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-fuling', '元凤', -80, 1, -75, 12, -948, -877, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-fuling', '元平', -74, 1, -74, 12, -876, -865, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xun', '本初', -74, 1, -70, 12, -876, -817, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xun', '地节', -69, 1, -66, 12, -816, -769, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xun', '元康', -65, 1, -62, 12, -768, -721, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xun', '神爵', -61, 1, -58, 12, -720, -673, 3);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xun', '五凤', -57, 1, -54, 12, -672, -625, 4);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xun', '甘露', -53, 1, -50, 12, -624, -577, 5);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xun', '黄龙', -49, 1, -48, 12, -576, -553, 6);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-shi', '初元', -48, 1, -44, 12, -564, -505, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-shi', '永光', -43, 1, -39, 12, -504, -445, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-shi', '建昭', -38, 1, -34, 12, -444, -385, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-shi', '竟宁', -33, 1, -33, 12, -384, -373, 3);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-ao', '建始', -32, 1, -28, 12, -372, -313, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-ao', '河平', -28, 1, -25, 12, -324, -277, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-ao', '阳朔', -24, 1, -21, 12, -276, -229, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-ao', '鸿嘉', -20, 1, -17, 12, -228, -181, 3);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-ao', '永始', -16, 1, -13, 12, -180, -133, 4);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-ao', '元延', -12, 1, -9, 12, -132, -85, 5);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-ao', '绥和', -8, 1, -7, 12, -84, -61, 6);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xin', '建平', -6, 1, -3, 12, -60, -13, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xin', '元寿', -2, 1, -1, 12, -12, 11, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-kan', '元始', 1, 1, 5, 12, 12, 71, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-ruzi-ying', '居摄', 6, 1, 8, 12, 72, 107, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-wang-mang', '始建国', 9, 1, 13, 12, 108, 167, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-wang-mang', '天凤', 14, 1, 19, 12, 168, 239, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-wang-mang', '地皇', 20, 1, 23, 12, 240, 287, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xuan', '更始', 23, 1, 25, 12, 276, 311, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xiu', '建武', 25, 1, 56, 12, 300, 683, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-xiu', '建武中元', 56, 1, 57, 12, 672, 695, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-zhuang', '永平', 58, 1, 75, 12, 696, 911, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-zuo', '建初', 76, 1, 84, 12, 912, 1019, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-zuo', '元和', 84, 1, 87, 12, 1008, 1055, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-zuo', '章和', 87, 1, 88, 12, 1044, 1067, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-zhao', '永元', 89, 1, 105, 12, 1068, 1271, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-zhao', '元兴', 105, 1, 105, 12, 1260, 1271, 1);

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qin-unify', '秦灭六国', 'politics', 'point', 'year', '秦王政先后灭韩赵魏楚燕齐，前221年称帝', -221, 1, -2640, NULL, NULL, NULL, NULL, NULL, NULL, '秦完成统一战争，建立中国历史上首个大一统帝国。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qin-standardize', '书同文车同轨', 'culture', 'span', 'year', '统一后推行文字、度量衡、车轨及郡县制，具体月份不详', NULL, NULL, NULL, -221, 1, -2640, -210, 12, -2497, '秦始皇统一文字、度量衡与道路车轨，推行郡县制。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('burn-books', '焚书坑儒', 'culture', 'circa', 'year', '焚书约前213年，坑儒约前212年，取两年窗口', -213, 1, -2544, -213, 1, -2544, -212, 12, -2521, '秦始皇下令焚毁非实用典籍，后又坑杀批评朝政的儒生。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('great-wall-qin', '修筑长城', 'other', 'circa', 'decade', '秦统一后连接燕赵秦旧塞，具体起工年月诸说不一', -215, 1, -2568, -221, 1, -2640, -210, 12, -2497, '秦将战国北方边塞连接延展，形成后世长城雏形。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('yingzheng-death', '秦始皇驾崩', 'politics', 'point', 'year', '始皇三十七年，前210年，死于沙丘', -210, 1, -2508, NULL, NULL, NULL, NULL, NULL, NULL, '秦始皇东巡途中病逝，赵高与李斯篡改遗诏立胡亥。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('daze-uprising', '大泽乡起义', 'politics', 'point', 'year', '秦二世元年七月，前209年', -209, 1, -2496, NULL, NULL, NULL, NULL, NULL, NULL, '陈胜、吴广揭竿而起，秦末农民战争爆发。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('julu-battle', '巨鹿之战', 'battle', 'point', 'year', '秦二世三年，前207年，项羽破秦军主力', -207, 1, -2472, NULL, NULL, NULL, NULL, NULL, NULL, '项羽破釜沉舟，大破章邯所率秦军，秦亡势成。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('xiangliang-death', '项梁战死定陶', 'battle', 'point', 'year', '秦二世三年九月，前208年', -208, 1, -2484, NULL, NULL, NULL, NULL, NULL, NULL, '项梁战死于定陶，项羽继其军权。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('liu-enter-xianyang', '刘邦入关', 'politics', 'point', 'year', '秦王子婴投降，前207年', -207, 1, -2472, NULL, NULL, NULL, NULL, NULL, NULL, '刘邦率军入咸阳，子婴投降，秦朝名义上灭亡。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('hongmen-banquet', '鸿门宴', 'politics', 'point', 'year', '汉王元年，前206年', -206, 1, -2460, NULL, NULL, NULL, NULL, NULL, NULL, '刘邦赴项羽之会，张良等周旋，刘邦脱险。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('chu-han-war', '楚汉战争', 'battle', 'span', 'year', '项羽自立西楚霸王至垓下败亡，前206–前202年', NULL, NULL, NULL, -206, 1, -2460, -202, 12, -2401, '刘邦与项羽争夺天下，历时四年。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('gaixia', '垓下之战', 'battle', 'point', 'year', '汉五年十二月，前202年', -202, 1, -2412, NULL, NULL, NULL, NULL, NULL, NULL, '韩信等合围项羽于垓下，项羽兵败自刎，楚亡汉兴。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('han-founded', '西汉建立', 'politics', 'point', 'year', '汉五年二月甲午，前202年，刘邦称帝于定陶', -202, 1, -2412, NULL, NULL, NULL, NULL, NULL, NULL, '刘邦称帝，定国号汉，初都洛阳后迁长安。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('baiteng-siege', '白登之围', 'battle', 'point', 'year', '汉七年，前200年，高祖被匈奴围困于白登山', -200, 1, -2388, NULL, NULL, NULL, NULL, NULL, NULL, '刘邦北击匈奴失利被围，脱险后改行和亲政策。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qiguo-rebellion', '七国之乱', 'battle', 'span', 'year', '景帝三年，前154年', NULL, NULL, NULL, -154, 1, -1836, -154, 12, -1825, '吴楚等七国起兵反中央，景帝命周亚夫平定。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('lv-regency', '吕后称制', 'politics', 'span', 'year', '惠帝崩后吕后临朝，前188–前180年', NULL, NULL, NULL, -188, 1, -2244, -180, 12, -2137, '吕后专擅朝政，大封吕氏，至文帝即位结束。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('wenjing-rule', '文景之治', 'politics', 'span', 'year', NULL, NULL, NULL, NULL, -180, 1, -2148, -141, 12, -1669, '文帝景帝轻徭薄赋、与民休息，国力恢复。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('wu-han-expansion', '汉武帝开疆', 'politics', 'span', 'year', NULL, NULL, NULL, NULL, -141, 1, -1680, -87, 12, -1021, '武帝北击匈奴、通西域、南平百越、东并闽越，西汉疆域大幅扩展。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('zhangqian-mission', '张骞通西域', 'culture', 'circa', 'year', '武帝建元三年首次出使，前138年；二使前119年，取主要窗口', -138, 1, -1644, -138, 1, -1644, -114, 12, -1345, '张骞两次出使西域，开辟丝绸之路，沟通中西。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('hexi-battle', '河西之战', 'battle', 'point', 'year', '元狩二年，前121年，霍去病两次西进', -121, 1, -1440, NULL, NULL, NULL, NULL, NULL, NULL, '霍去病大破匈奴，夺取河西走廊，置武威、酒泉等郡。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('mobei-battle', '漠北之战', 'battle', 'point', 'year', '元狩四年，前119年，卫青、霍去病分道出击', -119, 1, -1416, NULL, NULL, NULL, NULL, NULL, NULL, '汉军深入漠北，大破匈奴主力，匈奴远遁，无力南犯。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('dayuan-expedition', '远征大宛', 'battle', 'circa', 'year', '太初二年，前103–前101年，李广利两征大宛', -102, 1, -1212, -103, 1, -1224, -101, 12, -1189, '汉武帝遣军远征大宛，历时三年，终斩其王。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('wugu-case', '巫蛊之祸', 'politics', 'point', 'year', '征和二年，前91年', -91, 1, -1080, NULL, NULL, NULL, NULL, NULL, NULL, '武帝晚年巫蛊案牵连太子刘据，朝局动荡。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('zhaoxuan-rule', '昭宣之治', 'politics', 'span', 'year', NULL, NULL, NULL, NULL, -87, 1, -1032, -48, 12, -553, '昭帝、宣帝励精图治，西汉中兴。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('zhaojun-chusai', '昭君出塞', 'culture', 'point', 'year', '竟宁元年，前33年', -33, 1, -384, NULL, NULL, NULL, NULL, NULL, NULL, '元帝以王昭君嫁呼韩邪单于，汉匈和好。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('wang-mang-usurp', '王莽篡汉', 'politics', 'point', 'year', '始建国元年，9年，孺子婴被废', 9, 1, 108, NULL, NULL, NULL, NULL, NULL, NULL, '王莽受孺子婴禅让，改国号为新，西汉终结。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('kunyang-battle', '昆阳之战', 'battle', 'point', 'year', '更始元年，23年，刘秀以少胜多破王莽军', 23, 1, 276, NULL, NULL, NULL, NULL, NULL, NULL, '刘秀率绿林军于昆阳大破王莽主力，新莽覆亡在即。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('han-east-founded', '东汉建立', 'politics', 'point', 'year', '建武元年，25年，刘秀称帝于鄗城', 25, 1, 300, NULL, NULL, NULL, NULL, NULL, NULL, '刘秀击败各路割据，定都洛阳，东汉开始。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('yellow-turban', '黄巾起义', 'politics', 'point', 'year', '灵帝建宁二年，184年', 184, 1, 2208, NULL, NULL, NULL, NULL, NULL, NULL, '张角领导黄巾起义，东汉统治根基动摇，群雄割据。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('han-east-end', '东汉终结', 'politics', 'point', 'year', '献帝延康元年十一月，220年，曹丕受禅', 220, 1, 2640, NULL, NULL, NULL, NULL, NULL, NULL, '曹丕篡汉，献帝禅让，东汉灭亡，曹魏建立。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;

-- event_dynasties
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-unify', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-standardize', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('burn-books', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('great-wall-qin', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yingzheng-death', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('daze-uprising', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('julu-battle', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('julu-battle', 'chu-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xiangliang-death', 'chu-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('liu-enter-xianyang', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('hongmen-banquet', 'chu-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('hongmen-banquet', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chu-han-war', 'chu-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chu-han-war', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('gaixia', 'chu-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('gaixia', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('han-founded', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('baiteng-siege', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qiguo-rebellion', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('lv-regency', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wenjing-rule', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wu-han-expansion', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhangqian-mission', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('hexi-battle', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('mobei-battle', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('dayuan-expedition', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wugu-case', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhaoxuan-rule', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhaojun-chusai', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wang-mang-usurp', 'han-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wang-mang-usurp', 'xin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('kunyang-battle', 'xin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('kunyang-battle', 'han-gengshi') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('han-east-founded', 'han-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yellow-turban', 'han-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('han-east-end', 'han-east') ON CONFLICT DO NOTHING;

-- event_participants
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-unify', 'ying-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-standardize', 'ying-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-standardize', 'li-si') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('burn-books', 'ying-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('burn-books', 'li-si') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('great-wall-qin', 'ying-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yingzheng-death', 'ying-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('daze-uprising', 'chen-sheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('daze-uprising', 'wu-guang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('julu-battle', 'xiang-yu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('julu-battle', 'zhang-han') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('julu-battle', 'xiang-liang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('xiangliang-death', 'xiang-liang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('xiangliang-death', 'xiang-yu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('liu-enter-xianyang', 'liu-bang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('liu-enter-xianyang', 'ying-ziying') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('hongmen-banquet', 'liu-bang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('hongmen-banquet', 'xiang-yu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('hongmen-banquet', 'zhang-liang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chu-han-war', 'liu-bang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chu-han-war', 'xiang-yu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chu-han-war', 'han-xin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chu-han-war', 'zhang-liang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('gaixia', 'liu-bang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('gaixia', 'xiang-yu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('gaixia', 'han-xin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('han-founded', 'liu-bang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('baiteng-siege', 'liu-bang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qiguo-rebellion', 'liu-qi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('lv-regency', 'lv-zhi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wenjing-rule', 'liu-heng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wenjing-rule', 'liu-qi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wu-han-expansion', 'liu-che') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhangqian-mission', 'liu-che') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhangqian-mission', 'zhang-qian') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('hexi-battle', 'liu-che') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('hexi-battle', 'huo-qubing') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('mobei-battle', 'liu-che') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('mobei-battle', 'wei-qing') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('mobei-battle', 'huo-qubing') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('dayuan-expedition', 'liu-che') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wugu-case', 'liu-che') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhaoxuan-rule', 'liu-fuling') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhaoxuan-rule', 'liu-xun') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhaojun-chusai', 'liu-shi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhaojun-chusai', 'wang-zhaojun') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wang-mang-usurp', 'wang-mang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wang-mang-usurp', 'ruzi-ying') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('kunyang-battle', 'liu-xiu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('kunyang-battle', 'wang-mang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('han-east-founded', 'liu-xiu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yellow-turban', 'liu-hong') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('han-east-end', 'liu-xie') ON CONFLICT DO NOTHING;

-- relations
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ying-zheng-ying-huhai-succession', 'person', 'ying-zheng', 'person', 'ying-huhai', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-ying-huhai-ying-ziying-succession', 'person', 'ying-huhai', 'person', 'ying-ziying', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-bang-liu-ying-succession', 'person', 'liu-bang', 'person', 'liu-ying', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-ying-liu-gong-succession', 'person', 'liu-ying', 'person', 'liu-gong', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-gong-liu-hong-shao-succession', 'person', 'liu-gong', 'person', 'liu-hong-shao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-hong-shao-liu-heng-succession', 'person', 'liu-hong-shao', 'person', 'liu-heng', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-heng-liu-qi-succession', 'person', 'liu-heng', 'person', 'liu-qi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-qi-liu-che-succession', 'person', 'liu-qi', 'person', 'liu-che', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-che-liu-fuling-succession', 'person', 'liu-che', 'person', 'liu-fuling', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-fuling-liu-he-succession', 'person', 'liu-fuling', 'person', 'liu-he', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-he-liu-xun-succession', 'person', 'liu-he', 'person', 'liu-xun', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-xun-liu-shi-succession', 'person', 'liu-xun', 'person', 'liu-shi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-shi-liu-ao-succession', 'person', 'liu-shi', 'person', 'liu-ao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-ao-liu-xin-succession', 'person', 'liu-ao', 'person', 'liu-xin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-xin-liu-kan-succession', 'person', 'liu-xin', 'person', 'liu-kan', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-kan-ruzi-ying-succession', 'person', 'liu-kan', 'person', 'ruzi-ying', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-xiu-liu-zhuang-succession', 'person', 'liu-xiu', 'person', 'liu-zhuang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-zhuang-liu-zuo-succession', 'person', 'liu-zhuang', 'person', 'liu-zuo', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-zuo-liu-zhao-succession', 'person', 'liu-zuo', 'person', 'liu-zhao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-zhao-liu-long-succession', 'person', 'liu-zhao', 'person', 'liu-long', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-long-liu-hu-succession', 'person', 'liu-long', 'person', 'liu-hu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-hu-liu-yi-shao-succession', 'person', 'liu-hu', 'person', 'liu-yi-shao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-yi-shao-liu-bao-succession', 'person', 'liu-yi-shao', 'person', 'liu-bao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-bao-liu-bing-succession', 'person', 'liu-bao', 'person', 'liu-bing', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-bing-liu-zuan-succession', 'person', 'liu-bing', 'person', 'liu-zuan', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-zuan-liu-zhi-succession', 'person', 'liu-zuan', 'person', 'liu-zhi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-zhi-liu-hong-succession', 'person', 'liu-zhi', 'person', 'liu-hong', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-hong-liu-bian-succession', 'person', 'liu-hong', 'person', 'liu-bian', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-bian-liu-xie-succession', 'person', 'liu-bian', 'person', 'liu-xie', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-gaixia-liu-bang', 'event', 'gaixia', 'person', 'liu-bang', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-gaixia-xiang-yu', 'event', 'gaixia', 'person', 'xiang-yu', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-chu-han-liu-bang', 'event', 'chu-han-war', 'person', 'liu-bang', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-julu-xiang-yu', 'event', 'julu-battle', 'person', 'xiang-yu', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-mobei-huo-qubing', 'event', 'mobei-battle', 'person', 'huo-qubing', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-kunyang-liu-xiu', 'event', 'kunyang-battle', 'person', 'liu-xiu', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;

COMMIT;
