-- EraLens period import: nanbei-chao
-- Window: 386-01 .. 589-12 (Northern and Southern Dynasties)
-- Chronology: Wikipedia Nanbei-chao emperor lists
BEGIN;

-- persons
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'liu-yifu', '刘义符',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '宋少帝，刘裕长子，被徐羡之等废杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘义符"}]'::jsonb
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
  'liu-yilong', '刘义隆',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '宋文帝，元嘉之治，后被太子刘劭所弑。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘义隆"}]'::jsonb
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
  'liu-shao', '刘劭',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '宋元凶，弑父自立，旋为刘骏所灭。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘劭"}]'::jsonb
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
  'liu-jun', '刘骏',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '宋孝武帝，平讨元凶，后期穷兵黩武。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘骏"}]'::jsonb
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
  'liu-ziye', '刘子业',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '宋前废帝，荒淫暴虐，为湘东王刘彧所杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘子业"}]'::jsonb
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
  'liu-yu-song', '刘彧',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '宋明帝，屠戮宗室，宋室由盛转衰。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘彧"}]'::jsonb
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
  'liu-yu-fei', '刘昱',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '宋后废帝，为萧道成所杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘昱"}]'::jsonb
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
  'liu-zhun', '刘准',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '宋顺帝，刘宋末代，萧道成代宋。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/刘准"}]'::jsonb
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
  'xiao-daocheng', '萧道成',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '齐高帝，代宋建齐，定都建康。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧道成"}]'::jsonb
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
  'xiao-ze', '萧赜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '齐武帝，永明之治，南齐极盛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧赜"}]'::jsonb
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
  'xiao-zhaoye', '萧昭业',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '南齐郁林王，荒乱，为萧鸾所废杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧昭业"}]'::jsonb
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
  'xiao-zhaowen', '萧昭文',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '南齐海陵王，在位仅二十三日。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧昭文"}]'::jsonb
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
  'xiao-luan', '萧鸾',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '齐明帝，杀侄自立，大杀齐室。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧鸾"}]'::jsonb
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
  'xiao-baojuan', '萧宝卷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '东昏侯，荒淫，为萧衍所废。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧宝卷"}]'::jsonb
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
  'xiao-baorong', '萧宝融',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '齐和帝，南齐末代，萧衍代齐。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧宝融"}]'::jsonb
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
  'xiao-yan', '萧衍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '梁武帝，崇佛，侯景之乱在其朝，饿死台城。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧衍"}]'::jsonb
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
  'xiao-gang', '萧纲',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '梁简文帝，侯景拥立，后被杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧纲"}]'::jsonb
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
  'xiao-yi', '萧绎',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '梁元帝，江陵称帝，后为西魏所杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧绎"}]'::jsonb
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
  'xiao-fangzhi', '萧方智',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '梁敬帝，南梁末代，陈霸先代梁。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/萧方智"}]'::jsonb
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
  'chen-baxian', '陈霸先',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '陈武帝，代梁建陈，定都建康。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/陈霸先"}]'::jsonb
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
  'chen-qian', '陈蒨',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '陈文帝，陈霸先侄，励精图治。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/陈蒨"}]'::jsonb
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
  'chen-bozong', '陈伯宗',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '陈废帝，为叔父陈顼所废。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/陈伯宗"}]'::jsonb
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
  'chen-xu', '陈顼',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '陈宣帝，陈朝中兴，北伐齐。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/陈顼"}]'::jsonb
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
  'chen-shubao', '陈叔宝',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '陈后主，玉树后庭花，隋灭陈。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/陈叔宝"}]'::jsonb
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
  'tuoba-gui', '拓跋珪',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏道武帝，386年建国，统一北方。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏道武帝"}]'::jsonb
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
  'tuoba-si', '拓跋嗣',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏明元帝，道武帝子，巩固北魏统治。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏明元帝"}]'::jsonb
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
  'tuoba-tao', '拓跋焘',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏太武帝，灭北凉，统一北方。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏太武帝"}]'::jsonb
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
  'tuoba-yu', '拓跋余',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏南安王，太武帝被杀后继位，旋被诛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/元余"}]'::jsonb
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
  'tuoba-jun', '拓跋浚',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏文成帝，恢复佛教，与南朝和亲。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏文成帝"}]'::jsonb
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
  'tuoba-hong', '拓跋弘',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏献文帝，后禅位予子，为冯太后所杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏献文帝"}]'::jsonb
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
  'yuan-hong', '元宏',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏孝文帝，迁都洛阳，汉化改革。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏孝文帝"}]'::jsonb
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
  'yuan-ke', '元恪',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏宣武帝，孝文帝子。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏宣武帝"}]'::jsonb
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
  'yuan-xu', '元诩',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏孝明帝，被胡太后所毒杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏孝明帝"}]'::jsonb
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
  'yuan-zi-you', '元子攸',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏孝庄帝，诛尔朱荣，后为尔朱世隆所杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏孝庄帝"}]'::jsonb
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
  'yuan-ye', '元晔',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏长广王，尔朱氏所立，后被废杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/元晔"}]'::jsonb
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
  'yuan-lang', '元朗',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏节闵帝，尔朱氏所立，后被废。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/元朗"}]'::jsonb
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
  'yuan-xiu', '元修',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北魏孝武帝，北魏末代，为宇文泰挟至长安，后西魏开始。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏孝武帝"}]'::jsonb
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
  'yuan-shan-jian', '元善见',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '东魏孝静帝，北魏分裂后据邺城，为北齐所废。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏孝静帝"}]'::jsonb
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
  'yuan-bao-ju', '元宝炬',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '西魏文帝，宇文泰拥立，都长安。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/元宝炬"}]'::jsonb
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
  'yuan-qin', '元钦',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '西魏废帝，为宇文觉所废杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/元钦"}]'::jsonb
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
  'tuoba-kuo', '拓跋廓',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '西魏恭帝，西魏末代，禅让于北周宇文觉。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏恭帝"}]'::jsonb
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
  'gao-yang', '高洋',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北齐文宣帝，建国于邺，前期励精，后期暴虐。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐文宣帝"}]'::jsonb
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
  'gao-yin', '高殷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北齐废帝，文宣帝子，为叔父高演所废杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐废帝"}]'::jsonb
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
  'gao-yan', '高演',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北齐孝昭帝，夺侄位，在位仅两年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐孝昭帝"}]'::jsonb
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
  'gao-zhan', '高湛',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北齐武成帝，荒淫，传位予子。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/齐武成帝"}]'::jsonb
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
  'gao-wei', '高纬',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北齐后主，宠信小人，为北周所灭。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/高纬"}]'::jsonb
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
  'gao-heng', '高恒',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北齐幼主，北齐末代，为北周所俘。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/高恒"}]'::jsonb
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
  'yuwen-jue', '宇文觉',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北周孝闵帝，代西魏建周，为宇文护所杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周孝闵帝"}]'::jsonb
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
  'yuwen-yu', '宇文毓',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北周明帝，宇文觉之兄，为宇文护所毒杀。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周明帝"}]'::jsonb
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
  'yuwen-yong', '宇文邕',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北周武帝，灭佛，灭北齐，统一北方。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周武帝"}]'::jsonb
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
  'yuwen-yun', '宇文赟',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北周宣帝，荒淫，传位予子后崩。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周宣帝"}]'::jsonb
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
  'yuwen-yan', '宇文衍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝'], '北周静帝，北周末代，杨坚代周。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/周静帝"}]'::jsonb
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
  'hou-jing', '侯景',
  NULL, NULL,
  NULL, NULL,
  ARRAY['将领'], '北魏降将，梁武帝时降梁，后发动侯景之乱。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯景"}]'::jsonb
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
  'chen-qingzhi', '陈庆之',
  NULL, NULL,
  NULL, NULL,
  ARRAY['军事家'], '梁将，七千白袍军入洛阳，威震北魏。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/陈庆之"}]'::jsonb
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
  'erzhu-rong', '尔朱荣',
  NULL, NULL,
  NULL, NULL,
  ARRAY['军事家','政治家'], '北魏权臣，河阴之变，后为孝庄帝所诛。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/尔朱荣"}]'::jsonb
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
  'feng-taihou', '冯太后',
  442, 1,
  490, 1,
  ARRAY['太后','政治家'], '北魏文明太后，献文帝、孝文帝朝两度临朝，推动改革。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/冯太后"}]'::jsonb
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
  'hu-taihou', '胡太后',
  NULL, NULL,
  528, 4,
  ARRAY['太后','政治家'], '北魏灵太后，孝明帝生母，毒杀明帝，河阴之变后被沉河。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/胡太后"}]'::jsonb
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
  'zu-chongzhi', '祖冲之',
  429, 1,
  500, 1,
  ARRAY['科学家'], '南朝数学家，精确圆周率，大明历作者。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/祖冲之"}]'::jsonb
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
  'zhang-lihua', '张丽华',
  559, 1,
  604, 1,
  ARRAY['后妃','政治家'], '陈后主宠妃，与孔、龚二妃干预朝政，隋灭陈时殉。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/张丽华"}]'::jsonb
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
  'yang-jian', '杨坚',
  NULL, NULL,
  NULL, NULL,
  ARRAY['皇帝','政治家'], '隋文帝，代北周建隋，后灭陈统一天下。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/杨坚"}]'::jsonb
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
  'wei-north', '北魏', ARRAY['魏','拓跋魏'], 'cn', 'east_asia',
  386, 1, 534, 1,
  4632, 6408, 'year', 'ochre', NULL,
  '拓跋珪386年建国，439年灭北凉统一北方；534年分裂为东魏、西魏。'
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
  'song-liu', '刘宋', ARRAY['宋','南朝宋'], 'cn', 'east_asia',
  420, 7, 479, 1,
  5046, 5748, 'year', 'azure', NULL,
  '刘裕代晋建宋，都建康；479年萧道成代宋。'
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
  'qi-nan', '南齐', ARRAY['齐','萧齐'], 'cn', 'east_asia',
  479, 1, 502, 1,
  5748, 6024, 'year', 'cinnabar', NULL,
  '萧道成代宋建齐；502年萧衍代齐。'
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
  'liang-nan', '南梁', ARRAY['梁','萧梁'], 'cn', 'east_asia',
  502, 1, 557, 1,
  6024, 6684, 'year', 'jade', NULL,
  '萧衍代齐建梁；557年陈霸先代梁。'
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
  'wei-east', '东魏', ARRAY['魏'], 'cn', 'east_asia',
  534, 1, 550, 1,
  6408, 6600, 'year', 'indigo', NULL,
  '534年元善见东迁邺城；550年高洋代魏建北齐。'
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
  'wei-west', '西魏', ARRAY['魏'], 'cn', 'east_asia',
  535, 1, 557, 1,
  6420, 6684, 'year', 'coral', NULL,
  '535年元宝炬西迁长安；557年宇文觉代魏建北周。'
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
  'chen-nan', '南陈', ARRAY['陈'], 'cn', 'east_asia',
  557, 1, 589, 1,
  6684, 7068, 'year', 'moss', NULL,
  '陈霸先代梁建陈；589年隋灭陈，南北朝终结。'
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
  'qi-bei', '北齐', ARRAY['齐','高齐'], 'cn', 'east_asia',
  550, 1, 577, 1,
  6600, 6924, 'year', 'plum', NULL,
  '高洋代东魏建齐，都邺；577年北周灭齐。'
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
  'zhou-bei', '北周', ARRAY['周','宇文周'], 'cn', 'east_asia',
  557, 1, 581, 1,
  6684, 6972, 'year', 'mineral', NULL,
  '宇文觉代西魏建周，都长安；581年杨坚代周。'
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
  'reign-tuoba-gui', 'wei-north', 'tuoba-gui', '魏道武帝',
  '道武皇帝', '太祖', '{"kind":"posthumous","name":"魏道武帝"}'::jsonb,
  386, 1, 409, 12,
  4632, 4919, 'year'
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
  'reign-tuoba-si', 'wei-north', 'tuoba-si', '魏明元帝',
  '明元皇帝', '太宗', '{"kind":"posthumous","name":"魏明元帝"}'::jsonb,
  409, 1, 423, 12,
  4908, 5087, 'year'
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
  'reign-tuoba-tao', 'wei-north', 'tuoba-tao', '魏太武帝',
  '太武皇帝', '世祖', '{"kind":"posthumous","name":"魏太武帝"}'::jsonb,
  423, 1, 452, 12,
  5076, 5435, 'year'
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
  'reign-tuoba-yu', 'wei-north', 'tuoba-yu', '魏南安王',
  NULL, NULL, '{"kind":"regnal","name":"魏南安王"}'::jsonb,
  452, 1, 452, 12,
  5424, 5435, 'year'
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
  'reign-tuoba-jun', 'wei-north', 'tuoba-jun', '魏文成帝',
  '文成皇帝', '高宗', '{"kind":"posthumous","name":"魏文成帝"}'::jsonb,
  452, 1, 465, 12,
  5424, 5591, 'year'
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
  'reign-tuoba-hong', 'wei-north', 'tuoba-hong', '魏献文帝',
  '献文皇帝', NULL, '{"kind":"posthumous","name":"魏献文帝"}'::jsonb,
  465, 1, 471, 12,
  5580, 5663, 'year'
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
  'reign-yuan-hong', 'wei-north', 'yuan-hong', '魏孝文帝',
  '孝文皇帝', '高祖', '{"kind":"posthumous","name":"魏孝文帝"}'::jsonb,
  471, 1, 499, 12,
  5652, 5999, 'year'
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
  'reign-yuan-ke', 'wei-north', 'yuan-ke', '魏宣武帝',
  '宣武皇帝', NULL, '{"kind":"posthumous","name":"魏宣武帝"}'::jsonb,
  499, 1, 515, 12,
  5988, 6191, 'year'
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
  'reign-yuan-xu', 'wei-north', 'yuan-xu', '魏孝明帝',
  '孝明皇帝', NULL, '{"kind":"posthumous","name":"魏孝明帝"}'::jsonb,
  515, 1, 528, 12,
  6180, 6347, 'year'
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
  'reign-yuan-zi-you', 'wei-north', 'yuan-zi-you', '魏孝庄帝',
  '孝庄皇帝', NULL, '{"kind":"posthumous","name":"魏孝庄帝"}'::jsonb,
  528, 1, 530, 12,
  6336, 6371, 'year'
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
  'reign-yuan-ye', 'wei-north', 'yuan-ye', '魏长广王',
  NULL, NULL, '{"kind":"regnal","name":"魏长广王"}'::jsonb,
  530, 1, 531, 12,
  6360, 6383, 'year'
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
  'reign-yuan-lang', 'wei-north', 'yuan-lang', '魏节闵帝',
  NULL, NULL, '{"kind":"posthumous","name":"魏节闵帝"}'::jsonb,
  531, 1, 532, 12,
  6372, 6395, 'year'
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
  'reign-yuan-xiu', 'wei-north', 'yuan-xiu', '魏孝武帝',
  '孝武皇帝', NULL, '{"kind":"posthumous","name":"魏孝武帝"}'::jsonb,
  532, 1, 534, 12,
  6384, 6419, 'year'
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
  'reign-liu-yu-jin', 'song-liu', 'liu-yu-jin', '宋武帝',
  '武皇帝', '高祖', '{"kind":"posthumous","name":"宋武帝"}'::jsonb,
  420, 1, 422, 12,
  5040, 5075, 'year'
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
  'reign-liu-yifu', 'song-liu', 'liu-yifu', '宋少帝',
  NULL, NULL, '{"kind":"posthumous","name":"宋少帝"}'::jsonb,
  422, 1, 424, 12,
  5064, 5099, 'year'
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
  'reign-liu-yilong', 'song-liu', 'liu-yilong', '宋文帝',
  '文皇帝', '太祖', '{"kind":"posthumous","name":"宋文帝"}'::jsonb,
  424, 1, 453, 12,
  5088, 5447, 'year'
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
  'reign-liu-shao', 'song-liu', 'liu-shao', '宋元凶',
  NULL, NULL, '{"kind":"regnal","name":"宋元凶"}'::jsonb,
  453, 1, 453, 12,
  5436, 5447, 'year'
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
  'reign-liu-jun', 'song-liu', 'liu-jun', '宋孝武帝',
  '孝武皇帝', '世祖', '{"kind":"posthumous","name":"宋孝武帝"}'::jsonb,
  453, 1, 464, 12,
  5436, 5579, 'year'
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
  'reign-liu-ziye', 'song-liu', 'liu-ziye', '宋前废帝',
  NULL, NULL, '{"kind":"posthumous","name":"宋前废帝"}'::jsonb,
  464, 1, 465, 12,
  5568, 5591, 'year'
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
  'reign-liu-yu-song', 'song-liu', 'liu-yu-song', '宋明帝',
  '明皇帝', '太宗', '{"kind":"posthumous","name":"宋明帝"}'::jsonb,
  465, 1, 472, 12,
  5580, 5675, 'year'
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
  'reign-liu-yu-fei', 'song-liu', 'liu-yu-fei', '宋后废帝',
  NULL, NULL, '{"kind":"posthumous","name":"宋后废帝"}'::jsonb,
  473, 1, 477, 12,
  5676, 5735, 'year'
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
  'reign-liu-zhun', 'song-liu', 'liu-zhun', '宋顺帝',
  '顺皇帝', NULL, '{"kind":"posthumous","name":"宋顺帝"}'::jsonb,
  477, 1, 479, 12,
  5724, 5759, 'year'
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
  'reign-xiao-daocheng', 'qi-nan', 'xiao-daocheng', '齐高帝',
  '高皇帝', '太祖', '{"kind":"posthumous","name":"齐高帝"}'::jsonb,
  479, 1, 482, 12,
  5748, 5795, 'year'
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
  'reign-xiao-ze', 'qi-nan', 'xiao-ze', '齐武帝',
  '武皇帝', '世祖', '{"kind":"posthumous","name":"齐武帝"}'::jsonb,
  482, 1, 493, 12,
  5784, 5927, 'year'
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
  'reign-xiao-zhaoye', 'qi-nan', 'xiao-zhaoye', '齐郁林王',
  NULL, NULL, '{"kind":"regnal","name":"齐郁林王"}'::jsonb,
  494, 1, 494, 12,
  5928, 5939, 'year'
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
  'reign-xiao-zhaowen', 'qi-nan', 'xiao-zhaowen', '齐海陵王',
  NULL, NULL, '{"kind":"regnal","name":"齐海陵王"}'::jsonb,
  494, 1, 494, 12,
  5928, 5939, 'year'
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
  'reign-xiao-luan', 'qi-nan', 'xiao-luan', '齐明帝',
  '明皇帝', '高宗', '{"kind":"posthumous","name":"齐明帝"}'::jsonb,
  494, 1, 498, 12,
  5928, 5987, 'year'
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
  'reign-xiao-baojuan', 'qi-nan', 'xiao-baojuan', '东昏侯',
  NULL, NULL, '{"kind":"regnal","name":"东昏侯"}'::jsonb,
  499, 1, 501, 12,
  5988, 6023, 'year'
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
  'reign-xiao-baorong', 'qi-nan', 'xiao-baorong', '齐和帝',
  NULL, NULL, '{"kind":"posthumous","name":"齐和帝"}'::jsonb,
  501, 1, 502, 12,
  6012, 6035, 'year'
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
  'reign-xiao-yan', 'liang-nan', 'xiao-yan', '梁武帝',
  '武皇帝', '高祖', '{"kind":"posthumous","name":"梁武帝"}'::jsonb,
  502, 1, 549, 12,
  6024, 6599, 'year'
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
  'reign-xiao-gang', 'liang-nan', 'xiao-gang', '梁简文帝',
  NULL, NULL, '{"kind":"posthumous","name":"梁简文帝"}'::jsonb,
  549, 1, 551, 12,
  6588, 6623, 'year'
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
  'reign-xiao-yi', 'liang-nan', 'xiao-yi', '梁元帝',
  '孝元皇帝', NULL, '{"kind":"posthumous","name":"梁元帝"}'::jsonb,
  552, 1, 555, 12,
  6624, 6671, 'year'
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
  'reign-xiao-fangzhi', 'liang-nan', 'xiao-fangzhi', '梁敬帝',
  NULL, NULL, '{"kind":"posthumous","name":"梁敬帝"}'::jsonb,
  555, 1, 557, 12,
  6660, 6695, 'year'
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
  'reign-yuan-shan-jian', 'wei-east', 'yuan-shan-jian', '魏孝静帝',
  '孝静皇帝', NULL, '{"kind":"posthumous","name":"魏孝静帝"}'::jsonb,
  534, 1, 550, 12,
  6408, 6611, 'year'
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
  'reign-yuan-bao-ju', 'wei-west', 'yuan-bao-ju', '西魏文帝',
  '文皇帝', NULL, '{"kind":"posthumous","name":"西魏文帝"}'::jsonb,
  535, 1, 551, 12,
  6420, 6623, 'year'
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
  'reign-yuan-qin', 'wei-west', 'yuan-qin', '西魏废帝',
  NULL, NULL, '{"kind":"posthumous","name":"西魏废帝"}'::jsonb,
  551, 1, 554, 12,
  6612, 6659, 'year'
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
  'reign-tuoba-kuo', 'wei-west', 'tuoba-kuo', '西魏恭帝',
  NULL, NULL, '{"kind":"posthumous","name":"西魏恭帝"}'::jsonb,
  554, 1, 557, 12,
  6648, 6695, 'year'
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
  'reign-chen-baxian', 'chen-nan', 'chen-baxian', '陈武帝',
  '武皇帝', '高祖', '{"kind":"posthumous","name":"陈武帝"}'::jsonb,
  557, 1, 559, 12,
  6684, 6719, 'year'
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
  'reign-chen-qian', 'chen-nan', 'chen-qian', '陈文帝',
  '文皇帝', NULL, '{"kind":"posthumous","name":"陈文帝"}'::jsonb,
  559, 1, 566, 12,
  6708, 6803, 'year'
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
  'reign-chen-bozong', 'chen-nan', 'chen-bozong', '陈废帝',
  NULL, NULL, '{"kind":"posthumous","name":"陈废帝"}'::jsonb,
  566, 1, 568, 12,
  6792, 6827, 'year'
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
  'reign-chen-xu', 'chen-nan', 'chen-xu', '陈宣帝',
  '宣皇帝', NULL, '{"kind":"posthumous","name":"陈宣帝"}'::jsonb,
  568, 1, 582, 12,
  6816, 6995, 'year'
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
  'reign-chen-shubao', 'chen-nan', 'chen-shubao', '陈后主',
  NULL, NULL, '{"kind":"regnal","name":"陈后主"}'::jsonb,
  582, 1, 589, 12,
  6984, 7079, 'year'
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
  'reign-gao-yang', 'qi-bei', 'gao-yang', '齐文宣帝',
  '文宣皇帝', NULL, '{"kind":"posthumous","name":"齐文宣帝"}'::jsonb,
  550, 1, 559, 12,
  6600, 6719, 'year'
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
  'reign-gao-yin', 'qi-bei', 'gao-yin', '齐废帝',
  NULL, NULL, '{"kind":"posthumous","name":"齐废帝"}'::jsonb,
  560, 1, 561, 12,
  6720, 6743, 'year'
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
  'reign-gao-yan', 'qi-bei', 'gao-yan', '齐孝昭帝',
  '孝昭皇帝', NULL, '{"kind":"posthumous","name":"齐孝昭帝"}'::jsonb,
  561, 1, 565, 12,
  6732, 6791, 'year'
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
  'reign-gao-zhan', 'qi-bei', 'gao-zhan', '齐武成帝',
  '武成皇帝', NULL, '{"kind":"posthumous","name":"齐武成帝"}'::jsonb,
  565, 1, 569, 12,
  6780, 6839, 'year'
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
  'reign-gao-wei', 'qi-bei', 'gao-wei', '齐后主',
  NULL, NULL, '{"kind":"regnal","name":"齐后主"}'::jsonb,
  569, 1, 577, 12,
  6828, 6935, 'year'
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
  'reign-gao-heng', 'qi-bei', 'gao-heng', '齐幼主',
  NULL, NULL, '{"kind":"regnal","name":"齐幼主"}'::jsonb,
  577, 1, 577, 12,
  6924, 6935, 'year'
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
  'reign-yuwen-jue', 'zhou-bei', 'yuwen-jue', '周孝闵帝',
  NULL, NULL, '{"kind":"posthumous","name":"周孝闵帝"}'::jsonb,
  557, 1, 557, 12,
  6684, 6695, 'year'
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
  'reign-yuwen-yu', 'zhou-bei', 'yuwen-yu', '周明帝',
  '明皇帝', NULL, '{"kind":"posthumous","name":"周明帝"}'::jsonb,
  557, 1, 560, 12,
  6684, 6731, 'year'
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
  'reign-yuwen-yong', 'zhou-bei', 'yuwen-yong', '周武帝',
  '武皇帝', NULL, '{"kind":"posthumous","name":"周武帝"}'::jsonb,
  560, 1, 578, 12,
  6720, 6947, 'year'
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
  'reign-yuwen-yun', 'zhou-bei', 'yuwen-yun', '周宣帝',
  '宣皇帝', NULL, '{"kind":"posthumous","name":"周宣帝"}'::jsonb,
  578, 1, 579, 12,
  6936, 6959, 'year'
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
  'reign-yuwen-yan', 'zhou-bei', 'yuwen-yan', '周静帝',
  NULL, NULL, '{"kind":"posthumous","name":"周静帝"}'::jsonb,
  579, 1, 581, 12,
  6948, 6983, 'year'
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
DELETE FROM era_names WHERE reign_id = 'reign-yuan-hong';
DELETE FROM era_names WHERE reign_id = 'reign-liu-yu-jin';
DELETE FROM era_names WHERE reign_id = 'reign-liu-yilong';
DELETE FROM era_names WHERE reign_id = 'reign-liu-jun';
DELETE FROM era_names WHERE reign_id = 'reign-xiao-ze';
DELETE FROM era_names WHERE reign_id = 'reign-xiao-yan';
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-yuan-hong', '太和', 477, 1, 499, 12, 5724, 5999, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-yu-jin', '永初', 420, 1, 422, 12, 5040, 5075, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-yilong', '元嘉', 424, 1, 453, 12, 5088, 5447, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-jun', '孝建', 454, 1, 456, 12, 5448, 5483, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-liu-jun', '大明', 457, 1, 464, 12, 5484, 5579, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-xiao-ze', '永明', 483, 1, 493, 12, 5796, 5927, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-xiao-yan', '天监', 502, 1, 519, 12, 6024, 6239, 0);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-xiao-yan', '普通', 520, 1, 527, 12, 6240, 6335, 1);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-xiao-yan', '大通', 527, 1, 529, 12, 6324, 6359, 2);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-xiao-yan', '中大通', 529, 1, 534, 12, 6348, 6419, 3);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-xiao-yan', '大同', 535, 1, 546, 12, 6420, 6563, 4);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-xiao-yan', '中大同', 546, 1, 547, 12, 6552, 6575, 5);
INSERT INTO era_names (reign_id, name, start_year, start_month, end_year, end_month, start_abs, end_abs, sort_order)
VALUES ('reign-xiao-yan', '太清', 547, 1, 549, 12, 6564, 6599, 6);

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('wei-north-founded', '北魏建立', 'politics', 'point', 'year', NULL, 386, 1, 4632, NULL, NULL, NULL, NULL, NULL, NULL, '拓跋珪即代王位，国号魏，后迁都平城，北魏开始。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('song-liu-founded', '刘宋代晋', 'politics', 'point', 'year', '420年七月，刘裕受禅代晋', 420, 7, 5046, NULL, NULL, NULL, NULL, NULL, NULL, '刘裕废晋恭帝自立，改国号宋，南朝开始。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('yuanjia-rule', '元嘉之治', 'politics', 'span', 'year', NULL, NULL, NULL, NULL, 424, 1, 5088, 453, 1, 5436, '宋文帝刘义隆励精图治，南朝国力达于鼎盛。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qi-nan-founded', '南齐代宋', 'politics', 'point', 'year', NULL, 479, 1, 5748, NULL, NULL, NULL, NULL, NULL, NULL, '萧道成废宋顺帝自立，改国号齐。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('liang-nan-founded', '南梁代齐', 'politics', 'point', 'year', NULL, 502, 1, 6024, NULL, NULL, NULL, NULL, NULL, NULL, '萧衍废齐和帝自立，改国号梁。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('xiaoyan-reform', '梁武帝崇佛', 'culture', 'span', 'year', '萧衍多次舍身同泰寺，大力崇佛', NULL, NULL, NULL, 502, 1, 6024, 549, 1, 6588, '梁武帝萧衍崇信佛教，多次舍身，耗费国库。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('houjing-rebellion', '侯景之乱', 'politics', 'span', 'year', '548–552年，侯景叛梁，陷建康', NULL, NULL, NULL, 548, 1, 6576, 552, 1, 6624, '侯景叛梁，攻陷建康，梁武帝饿死台城，江南凋敝。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('chen-nan-founded', '南陈代梁', 'politics', 'point', 'year', NULL, 557, 1, 6684, NULL, NULL, NULL, NULL, NULL, NULL, '陈霸先废梁敬帝自立，改国号陈。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('tuoba-reform', '孝文帝改革', 'politics', 'span', 'year', '494年迁都洛阳，推行汉化', NULL, NULL, NULL, 471, 1, 5652, 499, 1, 5988, '孝文帝迁都洛阳，改姓元，推行均田制与汉化政策。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('wei-split', '北魏分裂', 'politics', 'point', 'year', '534年，孝武帝西迁，东魏、西魏分立', 534, 1, 6408, NULL, NULL, NULL, NULL, NULL, NULL, '北魏分裂为东魏（邺城）与西魏（长安），北朝进入新阶段。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qi-bei-founded', '北齐代东魏', 'politics', 'point', 'year', NULL, 550, 1, 6600, NULL, NULL, NULL, NULL, NULL, NULL, '高洋废东魏孝静帝自立，改国号齐，史称北齐。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('zhou-bei-founded', '北周代西魏', 'politics', 'point', 'year', NULL, 557, 1, 6684, NULL, NULL, NULL, NULL, NULL, NULL, '宇文觉废西魏恭帝自立，改国号周，史称北周。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('zhou-qi-unify', '北周灭北齐', 'battle', 'point', 'year', '577年，周武帝宇文邕灭齐', 577, 1, 6924, NULL, NULL, NULL, NULL, NULL, NULL, '北周武帝攻灭北齐，北方重归统一。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('yang-jian-usurp', '杨坚代周', 'politics', 'point', 'year', '581年，杨坚废周静帝，建隋', 581, 1, 6972, NULL, NULL, NULL, NULL, NULL, NULL, '杨坚废北周静帝自立，改国号隋，北朝终结。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('sui-chen-unify', '隋灭陈', 'politics', 'point', 'year', '589年，隋军渡江灭陈', 589, 1, 7068, NULL, NULL, NULL, NULL, NULL, NULL, '隋军灭南陈，陈后主降，南北分裂终结，中国重归统一。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('chen-qingzhi-luoyang', '白袍军入洛', 'battle', 'point', 'year', '528年，陈庆之率七千白袍军入洛阳', 528, 1, 6336, NULL, NULL, NULL, NULL, NULL, NULL, '陈庆之率七千白袍军护送元颢入洛，威震北魏。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('he-yin-massacre', '河阴之变', 'politics', 'point', 'year', '528年，尔朱荣于河阴屠杀百官', 528, 1, 6336, NULL, NULL, NULL, NULL, NULL, NULL, '尔朱荣于河阴屠杀北魏公卿两千余人，后诛杀孝明帝。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;

-- event_dynasties
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wei-north-founded', 'wei-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('song-liu-founded', 'song-liu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('song-liu-founded', 'jin-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yuanjia-rule', 'song-liu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qi-nan-founded', 'song-liu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qi-nan-founded', 'qi-nan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('liang-nan-founded', 'qi-nan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('liang-nan-founded', 'liang-nan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xiaoyan-reform', 'liang-nan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('houjing-rebellion', 'liang-nan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chen-nan-founded', 'liang-nan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chen-nan-founded', 'chen-nan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('tuoba-reform', 'wei-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wei-split', 'wei-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wei-split', 'wei-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wei-split', 'wei-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qi-bei-founded', 'wei-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qi-bei-founded', 'qi-bei') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhou-bei-founded', 'wei-west') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhou-bei-founded', 'zhou-bei') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhou-qi-unify', 'zhou-bei') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('zhou-qi-unify', 'qi-bei') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('yang-jian-usurp', 'zhou-bei') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('sui-chen-unify', 'chen-nan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chen-qingzhi-luoyang', 'liang-nan') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('chen-qingzhi-luoyang', 'wei-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('he-yin-massacre', 'wei-north') ON CONFLICT DO NOTHING;

-- event_participants
INSERT INTO event_participants (event_id, person_id) VALUES ('wei-north-founded', 'tuoba-gui') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('song-liu-founded', 'liu-yu-jin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yuanjia-rule', 'liu-yilong') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qi-nan-founded', 'xiao-daocheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qi-nan-founded', 'liu-zhun') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('liang-nan-founded', 'xiao-yan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('liang-nan-founded', 'xiao-baorong') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('xiaoyan-reform', 'xiao-yan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('houjing-rebellion', 'hou-jing') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('houjing-rebellion', 'xiao-yan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chen-nan-founded', 'chen-baxian') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chen-nan-founded', 'xiao-fangzhi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('tuoba-reform', 'yuan-hong') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wei-split', 'yuan-xiu') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wei-split', 'yuan-shan-jian') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qi-bei-founded', 'gao-yang') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qi-bei-founded', 'yuan-shan-jian') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhou-bei-founded', 'yuwen-jue') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhou-bei-founded', 'tuoba-kuo') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhou-qi-unify', 'yuwen-yong') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('zhou-qi-unify', 'gao-wei') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yang-jian-usurp', 'yang-jian') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('yang-jian-usurp', 'yuwen-yan') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('sui-chen-unify', 'chen-shubao') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('sui-chen-unify', 'yang-jian') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('chen-qingzhi-luoyang', 'chen-qingzhi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('he-yin-massacre', 'erzhu-rong') ON CONFLICT DO NOTHING;

-- relations
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-tuoba-gui-tuoba-si-succession', 'person', 'tuoba-gui', 'person', 'tuoba-si', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-tuoba-si-tuoba-tao-succession', 'person', 'tuoba-si', 'person', 'tuoba-tao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-tuoba-tao-tuoba-yu-succession', 'person', 'tuoba-tao', 'person', 'tuoba-yu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-tuoba-yu-tuoba-jun-succession', 'person', 'tuoba-yu', 'person', 'tuoba-jun', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-tuoba-jun-tuoba-hong-succession', 'person', 'tuoba-jun', 'person', 'tuoba-hong', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-tuoba-hong-yuan-hong-succession', 'person', 'tuoba-hong', 'person', 'yuan-hong', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuan-hong-yuan-ke-succession', 'person', 'yuan-hong', 'person', 'yuan-ke', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuan-ke-yuan-xu-succession', 'person', 'yuan-ke', 'person', 'yuan-xu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuan-xu-yuan-zi-you-succession', 'person', 'yuan-xu', 'person', 'yuan-zi-you', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuan-zi-you-yuan-ye-succession', 'person', 'yuan-zi-you', 'person', 'yuan-ye', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuan-ye-yuan-lang-succession', 'person', 'yuan-ye', 'person', 'yuan-lang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuan-lang-yuan-xiu-succession', 'person', 'yuan-lang', 'person', 'yuan-xiu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-yu-jin-liu-yifu-succession', 'person', 'liu-yu-jin', 'person', 'liu-yifu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-yifu-liu-yilong-succession', 'person', 'liu-yifu', 'person', 'liu-yilong', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-yilong-liu-shao-succession', 'person', 'liu-yilong', 'person', 'liu-shao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-shao-liu-jun-succession', 'person', 'liu-shao', 'person', 'liu-jun', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-jun-liu-ziye-succession', 'person', 'liu-jun', 'person', 'liu-ziye', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-ziye-liu-yu-song-succession', 'person', 'liu-ziye', 'person', 'liu-yu-song', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-yu-song-liu-yu-fei-succession', 'person', 'liu-yu-song', 'person', 'liu-yu-fei', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-liu-yu-fei-liu-zhun-succession', 'person', 'liu-yu-fei', 'person', 'liu-zhun', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-xiao-daocheng-xiao-ze-succession', 'person', 'xiao-daocheng', 'person', 'xiao-ze', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-xiao-ze-xiao-zhaoye-succession', 'person', 'xiao-ze', 'person', 'xiao-zhaoye', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-xiao-zhaoye-xiao-zhaowen-succession', 'person', 'xiao-zhaoye', 'person', 'xiao-zhaowen', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-xiao-zhaowen-xiao-luan-succession', 'person', 'xiao-zhaowen', 'person', 'xiao-luan', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-xiao-luan-xiao-baojuan-succession', 'person', 'xiao-luan', 'person', 'xiao-baojuan', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-xiao-baojuan-xiao-baorong-succession', 'person', 'xiao-baojuan', 'person', 'xiao-baorong', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-xiao-yan-xiao-gang-succession', 'person', 'xiao-yan', 'person', 'xiao-gang', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-xiao-gang-xiao-yi-succession', 'person', 'xiao-gang', 'person', 'xiao-yi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-xiao-yi-xiao-fangzhi-succession', 'person', 'xiao-yi', 'person', 'xiao-fangzhi', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuan-bao-ju-yuan-qin-succession', 'person', 'yuan-bao-ju', 'person', 'yuan-qin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuan-qin-tuoba-kuo-succession', 'person', 'yuan-qin', 'person', 'tuoba-kuo', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-chen-baxian-chen-qian-succession', 'person', 'chen-baxian', 'person', 'chen-qian', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-chen-qian-chen-bozong-succession', 'person', 'chen-qian', 'person', 'chen-bozong', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-chen-bozong-chen-xu-succession', 'person', 'chen-bozong', 'person', 'chen-xu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-chen-xu-chen-shubao-succession', 'person', 'chen-xu', 'person', 'chen-shubao', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-gao-yang-gao-yin-succession', 'person', 'gao-yang', 'person', 'gao-yin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-gao-yin-gao-yan-succession', 'person', 'gao-yin', 'person', 'gao-yan', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-gao-yan-gao-zhan-succession', 'person', 'gao-yan', 'person', 'gao-zhan', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-gao-zhan-gao-wei-succession', 'person', 'gao-zhan', 'person', 'gao-wei', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-gao-wei-gao-heng-succession', 'person', 'gao-wei', 'person', 'gao-heng', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuwen-jue-yuwen-yu-succession', 'person', 'yuwen-jue', 'person', 'yuwen-yu', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuwen-yu-yuwen-yong-succession', 'person', 'yuwen-yu', 'person', 'yuwen-yong', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuwen-yong-yuwen-yun-succession', 'person', 'yuwen-yong', 'person', 'yuwen-yun', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-yuwen-yun-yuwen-yan-succession', 'person', 'yuwen-yun', 'person', 'yuwen-yan', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-houjing-xiao-yan', 'event', 'houjing-rebellion', 'person', 'hou-jing', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-zhouqi-yuwen-yong', 'event', 'zhou-qi-unify', 'person', 'yuwen-yong', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-songliu-liu-yu-jin', 'event', 'song-liu-founded', 'person', 'liu-yu-jin', 'succession')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;

COMMIT;
