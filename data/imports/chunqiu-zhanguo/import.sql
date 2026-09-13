-- EraLens period import: chunqiu-zhanguo
-- Window: -1046-01 .. -207-12 (Spring-Autumn & Warring States feudal states)
-- Chronology: Shiji + Wikipedia state lists
BEGIN;

-- persons
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'lv-shang', '吕尚',
  -1156, 1,
  -1017, 1,
  ARRAY['君主','军事家','政治家'], '姜太公（姜子牙），辅武王克商，封于齐。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/姜子牙"}]'::jsonb
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
  'qi-r1', '姜伋',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐丁公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/丁公"}]'::jsonb
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
  'qi-r2', '姜得',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐乙公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/乙公"}]'::jsonb
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
  'qi-r3', '姜慈母',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐癸公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/癸公"}]'::jsonb
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
  'qi-r4', '姜不辰',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐哀公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哀公"}]'::jsonb
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
  'qi-r5', '姜静',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐胡公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/胡公"}]'::jsonb
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
  'qi-r6', '姜山',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐献公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/献公"}]'::jsonb
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
  'qi-r7', '姜寿',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐武公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武公"}]'::jsonb
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
  'qi-r8', '姜无忌',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐厉公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/厉公"}]'::jsonb
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
  'qi-r9', '姜赤',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐文公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'qi-r10', '姜脱',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐成公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成公"}]'::jsonb
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
  'qi-r11', '姜购',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐前庄公（姜购），维基齐国君主表载在位64年（前794–前731），为齐国在位最久之君。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄公"}]'::jsonb
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
  'qi-r12', '姜禄甫',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐釐公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/釐公"}]'::jsonb
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
  'qi-r13', '姜诸儿',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐襄公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄公"}]'::jsonb
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
  'qi-r14', '姜无知',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '公孙无知，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/公孙无知"}]'::jsonb
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
  'jiang-xiaobai', '姜小白',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐桓公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓公"}]'::jsonb
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
  'qi-r16', '姜无诡',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '公子无亏，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/公子无亏"}]'::jsonb
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
  'qi-r17', '姜昭',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐孝公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孝公"}]'::jsonb
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
  'qi-r18', '姜潘',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐昭公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭公"}]'::jsonb
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
  'qi-r19', '姜舍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐君舍，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/君舍"}]'::jsonb
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
  'qi-r20', '姜商人',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐懿公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/懿公"}]'::jsonb
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
  'qi-r21', '姜元',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐惠公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠公"}]'::jsonb
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
  'qi-r22', '姜无野',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐顷公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/顷公"}]'::jsonb
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
  'qi-r23', '姜环',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐灵公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/灵公"}]'::jsonb
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
  'qi-r24', '姜光',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐庄公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄公"}]'::jsonb
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
  'qi-r25', '姜杵臼',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐景公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/景公"}]'::jsonb
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
  'qi-r26', '姜荼',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '安孺子，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/安孺子"}]'::jsonb
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
  'qi-r27', '姜阳生',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐悼公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼公"}]'::jsonb
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
  'qi-r28', '姜壬',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐简公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/简公"}]'::jsonb
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
  'qi-r29', '姜骜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐平公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/平公"}]'::jsonb
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
  'qi-r30', '姜积',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐宣公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣公"}]'::jsonb
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
  'qi-r31', '田和',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐太公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/太公"}]'::jsonb
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
  'qi-r32', '姜贷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐康公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/康公"}]'::jsonb
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
  'qi-r33', '田剡',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐侯剡，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯剡"}]'::jsonb
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
  'qi-r34', '田午',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐桓公，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓公"}]'::jsonb
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
  'qi-r35', '田因齐',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐威王，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/威王"}]'::jsonb
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
  'qi-r36', '田辟彊',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐宣王，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣王"}]'::jsonb
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
  'qi-r37', '田地',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐湣王，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/湣王"}]'::jsonb
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
  'qi-r38', '田法章',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐襄王，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄王"}]'::jsonb
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
  'qi-r39', '田建',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '齐王建，齐国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王建"}]'::jsonb
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
  'ji-shuyu', '姬虞',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '唐叔虞，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/唐叔虞"}]'::jsonb
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
  'jin-r1', '姬燮',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋侯燮，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯燮"}]'::jsonb
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
  'jin-r2', '姬宁族',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋武侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武侯"}]'::jsonb
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
  'jin-r3', '姬服人',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋成侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成侯"}]'::jsonb
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
  'jin-r4', '姬福',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋厉侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/厉侯"}]'::jsonb
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
  'jin-r5', '姬宜臼',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋靖侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/靖侯"}]'::jsonb
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
  'jin-r6', '姬司徒',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋釐侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/釐侯"}]'::jsonb
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
  'jin-r7', '姬籍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋献侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/献侯"}]'::jsonb
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
  'jin-r8', '费王',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋穆侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/穆侯"}]'::jsonb
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
  'jin-r9', '姬殇',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋殇叔，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/殇叔"}]'::jsonb
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
  'jin-r10', '姬仇',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋文侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文侯"}]'::jsonb
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
  'jin-r11', '姬伯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋昭侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭侯"}]'::jsonb
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
  'jin-r12', '姬成师',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曲沃桓叔，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曲沃桓叔"}]'::jsonb
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
  'jin-r13', '姬平',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋孝侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孝侯"}]'::jsonb
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
  'jin-r14', '姬鱓',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曲沃庄伯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曲沃庄伯"}]'::jsonb
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
  'jin-r15', '姬却',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋鄂侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/鄂侯"}]'::jsonb
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
  'jin-r16', '姬光',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋哀侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哀侯"}]'::jsonb
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
  'jin-r17', '姬称',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曲沃武公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曲沃武公"}]'::jsonb
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
  'jin-r18', '姬小子',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋小子侯，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/小子侯"}]'::jsonb
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
  'jin-r19', '姬缗',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋侯缗，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯缗"}]'::jsonb
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
  'jin-r20', '姬诡诸',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋献公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/献公"}]'::jsonb
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
  'jin-r21', '姬夷吾',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋惠公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠公"}]'::jsonb
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
  'jin-r22', '姬圉',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋怀公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/怀公"}]'::jsonb
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
  'ji-chonger', '姬重耳',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋文公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'jin-r24', '姬欢',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋襄公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄公"}]'::jsonb
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
  'jin-r25', '姬夷皋',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋灵公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/灵公"}]'::jsonb
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
  'jin-r26', '姬黑臀',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋成公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成公"}]'::jsonb
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
  'jin-r27', '姬据',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋景公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/景公"}]'::jsonb
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
  'jin-r28', '姬寿曼',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋厉公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/厉公"}]'::jsonb
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
  'jin-r29', '姬周',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋悼公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼公"}]'::jsonb
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
  'jin-r30', '姬彪',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋平公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/平公"}]'::jsonb
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
  'jin-r31', '姬夷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋昭公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭公"}]'::jsonb
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
  'jin-r32', '姬弃疾',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋顷公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/顷公"}]'::jsonb
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
  'jin-r33', '姬午',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋定公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/定公"}]'::jsonb
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
  'jin-r34', '姬凿',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋出公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/出公"}]'::jsonb
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
  'jin-r35', '姬骄',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋哀公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哀公"}]'::jsonb
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
  'jin-r36', '姬柳',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋幽公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/幽公"}]'::jsonb
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
  'jin-r37', '姬止',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋烈公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/烈公"}]'::jsonb
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
  'jin-r38', '姬颀',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋孝公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孝公"}]'::jsonb
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
  'jin-r39', '姬俱酒',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '晋静公，晋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/静公"}]'::jsonb
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
  'chu-r0', '熊绎',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊绎，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊绎"}]'::jsonb
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
  'chu-r1', '熊艾',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊艾，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊艾"}]'::jsonb
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
  'chu-r2', '熊䵣',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊䵣，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊䵣"}]'::jsonb
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
  'chu-r3', '熊胜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊胜，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊胜"}]'::jsonb
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
  'chu-r4', '熊杨',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊杨，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊杨"}]'::jsonb
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
  'chu-r5', '熊渠',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊渠，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊渠"}]'::jsonb
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
  'chu-r6', '熊挚',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊挚红，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊挚红"}]'::jsonb
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
  'chu-r7', '熊延',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊延，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊延"}]'::jsonb
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
  'chu-r8', '熊勇',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊勇，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊勇"}]'::jsonb
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
  'chu-r9', '熊严',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊严，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊严"}]'::jsonb
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
  'chu-r10', '熊霜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊霜，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊霜"}]'::jsonb
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
  'chu-r11', '熊徇',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊徇，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊徇"}]'::jsonb
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
  'chu-r12', '熊咢',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '熊咢，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/熊咢"}]'::jsonb
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
  'chu-r13', '熊仪',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚若敖，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/若敖"}]'::jsonb
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
  'chu-r14', '熊坎',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚霄敖，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/霄敖"}]'::jsonb
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
  'chu-r15', '熊眴',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚蚡冒，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/蚡冒"}]'::jsonb
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
  'chu-r16', '熊通',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚武王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武王"}]'::jsonb
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
  'chu-r17', '熊赀',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚文王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文王"}]'::jsonb
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
  'chu-r18', '熊艰',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚堵敖，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/堵敖"}]'::jsonb
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
  'chu-r19', '熊恽',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚成王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成王"}]'::jsonb
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
  'chu-r20', '熊商臣',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚穆王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/穆王"}]'::jsonb
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
  'xiong-zhuang', '熊侣',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚庄王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄王"}]'::jsonb
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
  'chu-r22', '熊审',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚共王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共王"}]'::jsonb
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
  'chu-r23', '熊招',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚康王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/康王"}]'::jsonb
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
  'chu-r24', '熊员',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚郏敖，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郏敖"}]'::jsonb
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
  'chu-r25', '熊围',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚灵王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/灵王"}]'::jsonb
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
  'chu-r26', '熊比',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚王比，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王比"}]'::jsonb
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
  'chu-r27', '熊居',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚平王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/平王"}]'::jsonb
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
  'chu-r28', '熊珍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚昭王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭王"}]'::jsonb
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
  'chu-r29', '熊章',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚惠王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠王"}]'::jsonb
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
  'chu-r30', '熊中',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚简王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/简王"}]'::jsonb
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
  'chu-r31', '熊当',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚声王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/声王"}]'::jsonb
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
  'chu-r32', '熊疑',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚悼王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼王"}]'::jsonb
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
  'chu-r33', '熊臧',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚肃王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/肃王"}]'::jsonb
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
  'chu-r34', '熊良夫',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚宣王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣王"}]'::jsonb
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
  'chu-r35', '熊商',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚威王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/威王"}]'::jsonb
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
  'chu-r36', '熊槐',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚怀王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/怀王"}]'::jsonb
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
  'chu-r37', '熊横',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚顷襄王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/顷襄王"}]'::jsonb
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
  'chu-r38', '熊元',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚考烈王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/考烈王"}]'::jsonb
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
  'chu-r39', '熊悍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚幽王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/幽王"}]'::jsonb
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
  'chu-r40', '熊犹',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚哀王，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哀王"}]'::jsonb
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
  'chu-r41', '熊负刍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚王负刍，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王负刍"}]'::jsonb
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
  'chu-r42', '熊启',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚昌平君，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昌平君"}]'::jsonb
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
  'chu-r43', '熊心',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚义帝，楚国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/义帝"}]'::jsonb
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
  'ji-shi', '姬奭',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕召公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/召公"}]'::jsonb
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
  'yan-r1', '姬克',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕侯克，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯克"}]'::jsonb
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
  'yan-r2', '姬旨',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕侯旨，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯旨"}]'::jsonb
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
  'yan-r3', '姬舞',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕侯舞，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯舞"}]'::jsonb
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
  'yan-r4', '姬惠侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕惠侯，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠侯"}]'::jsonb
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
  'yan-r5', '姬庄',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕釐侯，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/釐侯"}]'::jsonb
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
  'yan-r6', '姬顷侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕顷侯，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/顷侯"}]'::jsonb
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
  'yan-r7', '姬哀侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕哀侯，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哀侯"}]'::jsonb
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
  'yan-r8', '姬郑侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕郑侯，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/郑侯"}]'::jsonb
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
  'yan-r9', '姬穆侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕穆侯，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/穆侯"}]'::jsonb
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
  'yan-r10', '姬宣侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕宣侯，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣侯"}]'::jsonb
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
  'yan-r11', '姬桓侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕桓侯，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓侯"}]'::jsonb
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
  'yan-r12', '姬庄公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕庄公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄公"}]'::jsonb
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
  'yan-r13', '姬襄公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕襄公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄公"}]'::jsonb
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
  'yan-r14', '姬桓公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕桓公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓公"}]'::jsonb
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
  'yan-r15', '姬宣公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕宣公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣公"}]'::jsonb
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
  'yan-r16', '姬昭公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕昭公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭公"}]'::jsonb
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
  'yan-r17', '姬武公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕武公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武公"}]'::jsonb
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
  'yan-r18', '姬文公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕文公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'yan-r19', '姬懿公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕懿公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/懿公"}]'::jsonb
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
  'yan-r20', '姬惠公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕惠公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠公"}]'::jsonb
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
  'yan-r21', '姬悼公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕悼公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼公"}]'::jsonb
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
  'yan-r22', '姬共公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕共公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共公"}]'::jsonb
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
  'yan-r23', '姬平公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕平公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/平公"}]'::jsonb
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
  'yan-r24', '姬简公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕简公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/简公"}]'::jsonb
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
  'yan-r25', '姬桓',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕孝公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孝公"}]'::jsonb
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
  'yan-r26', '姬戴',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕成公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成公"}]'::jsonb
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
  'yan-r27', '姬闵公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕闵公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/闵公"}]'::jsonb
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
  'yan-r28', '姬载',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕简公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/简公"}]'::jsonb
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
  'yan-r29', '姬桓公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕桓公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓公"}]'::jsonb
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
  'yan-r30', '姬文公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕文公，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'yan-r31', '姬易王',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕易王，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/易王"}]'::jsonb
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
  'yan-r32', '姬哙',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕王哙，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王哙"}]'::jsonb
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
  'yan-r33', '姬职',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕昭王，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭王"}]'::jsonb
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
  'yan-r34', '姬惠王',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕惠王，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠王"}]'::jsonb
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
  'yan-r35', '姬讙',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕武成王，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武成王"}]'::jsonb
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
  'yan-r36', '姬遇',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕孝王，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孝王"}]'::jsonb
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
  'yan-r37', '姬喜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '燕王喜，燕国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王喜"}]'::jsonb
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
  'song-weizi', '子启',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋微子，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/微子"}]'::jsonb
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
  'song-r1', '子衍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋微仲，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/微仲"}]'::jsonb
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
  'song-r2', '子稽',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋公稽，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/公稽"}]'::jsonb
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
  'song-r3', '子申',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋丁公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/丁公"}]'::jsonb
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
  'song-r4', '子共',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋湣公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/湣公"}]'::jsonb
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
  'song-r5', '子熙',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋炀公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/炀公"}]'::jsonb
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
  'song-r6', '子鲋祀',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋厉公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/厉公"}]'::jsonb
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
  'song-r7', '子举',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋釐公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/釐公"}]'::jsonb
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
  'song-r8', '子覵',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋惠公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠公"}]'::jsonb
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
  'song-r9', '哀公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋哀公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哀公"}]'::jsonb
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
  'song-r10', '子白',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋戴公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/戴公"}]'::jsonb
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
  'song-r11', '子司空',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋武公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武公"}]'::jsonb
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
  'song-r12', '子力',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋宣公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣公"}]'::jsonb
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
  'song-r13', '子和',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋穆公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/穆公"}]'::jsonb
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
  'song-r14', '子与夷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋殇公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/殇公"}]'::jsonb
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
  'song-r15', '子冯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋庄公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄公"}]'::jsonb
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
  'song-r16', '子捷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋湣公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/湣公"}]'::jsonb
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
  'song-r17', '子游',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋公游，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/公游"}]'::jsonb
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
  'song-r18', '子御说',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋桓公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓公"}]'::jsonb
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
  'song-r19', '子兹甫',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋襄公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄公"}]'::jsonb
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
  'song-r20', '子王臣',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋成公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成公"}]'::jsonb
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
  'song-r21', '子御',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋公御，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/公御"}]'::jsonb
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
  'song-r22', '子杵臼',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋昭公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭公"}]'::jsonb
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
  'song-r23', '子鲍革',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋文公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'song-r24', '子瑕',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋共公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共公"}]'::jsonb
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
  'song-r25', '子成',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋平公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/平公"}]'::jsonb
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
  'song-r26', '子佐',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋元公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/元公"}]'::jsonb
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
  'song-r27', '子头曼',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋景公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/景公"}]'::jsonb
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
  'song-r28', '子特',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋昭公（子特），前469–前404年在位。《史记·宋微子世家》另有前422年卒异说。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宋昭公特"}]'::jsonb
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
  'song-r29', '子购由',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋悼公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼公"}]'::jsonb
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
  'song-r30', '子田',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋休公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/休公"}]'::jsonb
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
  'song-r31', '子辟兵',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋桓公，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓公"}]'::jsonb
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
  'song-r32', '戴喜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋剔成君，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/剔成君"}]'::jsonb
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
  'song-r33', '戴偃',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '宋康王，宋国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/康王"}]'::jsonb
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
  'bo-qin', '伯禽',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '伯禽，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/伯禽"}]'::jsonb
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
  'lu-r1', '姬酋',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁考公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/考公"}]'::jsonb
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
  'lu-r2', '姬熙',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁炀公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/炀公"}]'::jsonb
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
  'lu-r3', '姬宰',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁幽公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/幽公"}]'::jsonb
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
  'lu-r4', '姬晞',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁魏公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏公"}]'::jsonb
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
  'lu-r5', '姬擢',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁厉公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/厉公"}]'::jsonb
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
  'lu-r6', '姬具',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁献公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/献公"}]'::jsonb
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
  'lu-r7', '姬濞',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁真公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/真公"}]'::jsonb
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
  'lu-r8', '姬敖',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁武公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武公"}]'::jsonb
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
  'lu-r9', '姬戏',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁懿公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/懿公"}]'::jsonb
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
  'lu-r10', '姬伯御',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁公伯御，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/公伯御"}]'::jsonb
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
  'lu-r11', '姬称',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁孝公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孝公"}]'::jsonb
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
  'lu-r12', '姬弗涅',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁惠公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠公"}]'::jsonb
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
  'lu-r13', '姬息姑',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁隐公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/隐公"}]'::jsonb
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
  'lu-r14', '姬允',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁桓公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓公"}]'::jsonb
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
  'lu-r15', '姬同',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁庄公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄公"}]'::jsonb
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
  'lu-r16', '姬启',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁闵公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/闵公"}]'::jsonb
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
  'lu-r17', '姬申',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁釐公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/釐公"}]'::jsonb
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
  'lu-r18', '姬兴',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁文公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'lu-r19', '姬馁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁宣公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣公"}]'::jsonb
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
  'lu-r20', '姬黑肱',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁成公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成公"}]'::jsonb
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
  'lu-r21', '姬午',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁襄公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄公"}]'::jsonb
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
  'lu-r22', '姬野',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁君野，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/君野"}]'::jsonb
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
  'lu-r23', '姬稠',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁昭公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭公"}]'::jsonb
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
  'lu-r24', '姬宋',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁定公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/定公"}]'::jsonb
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
  'lu-r25', '姬将',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁哀公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哀公"}]'::jsonb
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
  'lu-r26', '姬宁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁悼公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼公"}]'::jsonb
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
  'lu-r27', '姬嘉',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁元公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/元公"}]'::jsonb
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
  'lu-r28', '姬显',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁穆公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/穆公"}]'::jsonb
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
  'lu-r29', '姬奋',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁共公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共公"}]'::jsonb
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
  'lu-r30', '姬屯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁康公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/康公"}]'::jsonb
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
  'lu-r31', '姬匽',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁景公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/景公"}]'::jsonb
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
  'lu-r32', '姬叔',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁平公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/平公"}]'::jsonb
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
  'lu-r33', '姬贾',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁文公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'lu-r34', '姬仇',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '鲁顷公，鲁国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/顷公"}]'::jsonb
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
  'weiguo-r0', '姬封',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫康叔，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/康叔"}]'::jsonb
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
  'weiguo-r1', '姬代',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫康伯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/康伯"}]'::jsonb
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
  'weiguo-r2', '考伯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫考伯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/考伯"}]'::jsonb
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
  'weiguo-r3', '嗣伯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫嗣伯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/嗣伯"}]'::jsonb
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
  'weiguo-r4', '疌伯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫疌伯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/疌伯"}]'::jsonb
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
  'weiguo-r5', '靖伯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫靖伯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/靖伯"}]'::jsonb
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
  'weiguo-r6', '贞伯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫贞伯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/贞伯"}]'::jsonb
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
  'weiguo-r7', '顷侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫顷侯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/顷侯"}]'::jsonb
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
  'weiguo-r8', '釐侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫釐侯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/釐侯"}]'::jsonb
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
  'weiguo-r9', '姬余',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫共伯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共伯"}]'::jsonb
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
  'weiguo-r10', '姬和',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫武公（姬和），《史记·卫世家》载前812–前758年在位，共55年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫武公"}]'::jsonb
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
  'weiguo-r11', '姬扬',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫庄公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄公"}]'::jsonb
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
  'weiguo-r12', '姬完',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫桓公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓公"}]'::jsonb
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
  'weiguo-r13', '姬州吁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫州吁，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/州吁"}]'::jsonb
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
  'weiguo-r14', '姬晋',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫宣公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣公"}]'::jsonb
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
  'weiguo-r15', '姬朔',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫惠公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠公"}]'::jsonb
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
  'weiguo-r16', '姬黔牟',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫黔牟，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/黔牟"}]'::jsonb
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
  'weiguo-r17', '姬朔',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫惠公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠公"}]'::jsonb
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
  'weiguo-r18', '姬赤',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫懿公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/懿公"}]'::jsonb
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
  'weiguo-r19', '姬申',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫戴公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/戴公"}]'::jsonb
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
  'weiguo-r20', '姬毁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫文公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'weiguo-r21', '姬郑',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫成公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成公"}]'::jsonb
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
  'weiguo-r22', '姬瑕',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫君瑕，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/君瑕"}]'::jsonb
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
  'weiguo-r23', '姬遫',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫穆公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/穆公"}]'::jsonb
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
  'weiguo-r24', '姬臧',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫定公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/定公"}]'::jsonb
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
  'weiguo-r25', '姬衎',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫献公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/献公"}]'::jsonb
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
  'weiguo-r26', '姬秋',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫殇公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/殇公"}]'::jsonb
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
  'weiguo-r27', '姬衎',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫献公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/献公"}]'::jsonb
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
  'weiguo-r28', '姬恶',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫襄公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄公"}]'::jsonb
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
  'weiguo-r29', '姬元',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫灵公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/灵公"}]'::jsonb
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
  'weiguo-r30', '姬辄',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫出公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/出公"}]'::jsonb
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
  'weiguo-r31', '姬蒯聩',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫庄公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄公"}]'::jsonb
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
  'weiguo-r32', '姬斑师',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫斑师，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/斑师"}]'::jsonb
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
  'weiguo-r33', '姬起',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫君起，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/君起"}]'::jsonb
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
  'weiguo-r34', '姬辄',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫出公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/出公"}]'::jsonb
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
  'weiguo-r35', '姬黔',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫悼公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼公"}]'::jsonb
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
  'weiguo-r36', '姬弗',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫敬公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/敬公"}]'::jsonb
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
  'weiguo-r37', '姬纠',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫昭公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭公"}]'::jsonb
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
  'weiguo-r38', '姬亶',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫怀公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/怀公"}]'::jsonb
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
  'weiguo-r39', '姬颓',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫慎公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/慎公"}]'::jsonb
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
  'weiguo-r40', '姬训',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫声公，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/声公"}]'::jsonb
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
  'weiguo-r41', '姬遫',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫成侯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成侯"}]'::jsonb
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
  'weiguo-r42', '姬子南劲',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫平侯，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/平侯"}]'::jsonb
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
  'weiguo-r43', '缺失',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫嗣君，本名失考，前334–前293年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫嗣君"}]'::jsonb
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
  'weiguo-r44', '缺失',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫怀君，本名失考，前292–前254年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫怀君"}]'::jsonb
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
  'weiguo-r45', '缺失',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫元君，姬姓子南氏，本名失考，前254–前230年在位。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/卫元君"}]'::jsonb
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
  'weiguo-r46', '姬角',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '卫君角，卫国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/君角"}]'::jsonb
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
  'zheng-r0', '姬友',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑桓公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓公"}]'::jsonb
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
  'zheng-r1', '姬掘突',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑武公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武公"}]'::jsonb
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
  'zheng-r2', '姬寤生',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑庄公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄公"}]'::jsonb
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
  'zheng-r3', '姬忽',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑昭公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭公"}]'::jsonb
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
  'zheng-r4', '姬突',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑厉公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/厉公"}]'::jsonb
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
  'zheng-r5', '姬忽',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑昭公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭公"}]'::jsonb
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
  'zheng-r6', '姬子亹',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑子亹，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/子亹"}]'::jsonb
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
  'zheng-r7', '姬婴',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑子婴，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/子婴"}]'::jsonb
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
  'zheng-r8', '姬突',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑厉公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/厉公"}]'::jsonb
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
  'zheng-r9', '姬踕',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑文公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'zheng-r10', '姬子兰',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑穆公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/穆公"}]'::jsonb
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
  'zheng-r11', '姬子夷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑灵公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/灵公"}]'::jsonb
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
  'zheng-r12', '姬子坚',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑襄公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄公"}]'::jsonb
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
  'zheng-r13', '姬沸',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑悼公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼公"}]'::jsonb
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
  'zheng-r14', '姬睔',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑成公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成公"}]'::jsonb
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
  'zheng-r15', '姬恽',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑釐公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/釐公"}]'::jsonb
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
  'zheng-r16', '姬嘉',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑简公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/简公"}]'::jsonb
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
  'zheng-r17', '姬宁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑定公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/定公"}]'::jsonb
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
  'zheng-r18', '姬趸',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑献公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/献公"}]'::jsonb
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
  'zheng-r19', '姬胜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑声公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/声公"}]'::jsonb
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
  'zheng-r20', '姬易',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑哀公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哀公"}]'::jsonb
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
  'zheng-r21', '姬丑',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑共公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共公"}]'::jsonb
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
  'zheng-r22', '姬已',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑幽公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/幽公"}]'::jsonb
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
  'zheng-r23', '姬骀',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑𦈡公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/𦈡公"}]'::jsonb
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
  'zheng-r24', '姬乙',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '郑康公，郑国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/康公"}]'::jsonb
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
  'cao-r0', '姬振铎',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹叔振铎，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/叔振铎"}]'::jsonb
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
  'cao-r1', '姬脾',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹太伯，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/太伯"}]'::jsonb
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
  'cao-r2', '姬平',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹仲君，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/仲君"}]'::jsonb
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
  'cao-r3', '姬侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹宫伯，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宫伯"}]'::jsonb
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
  'cao-r4', '姬云',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹孝伯，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孝伯"}]'::jsonb
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
  'cao-r5', '姬喜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹夷伯，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/夷伯"}]'::jsonb
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
  'cao-r6', '姬彊',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹幽伯，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/幽伯"}]'::jsonb
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
  'cao-r7', '姬苏',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹戴伯，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/戴伯"}]'::jsonb
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
  'cao-r8', '姬兕',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹惠伯，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠伯"}]'::jsonb
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
  'cao-r9', '姬石甫',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹废伯，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/废伯"}]'::jsonb
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
  'cao-r10', '姬武',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹穆公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/穆公"}]'::jsonb
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
  'cao-r11', '姬终生',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹桓公（姬终生），《史记·蔡世家》载前756–前702年在位，共55年。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/曹桓公"}]'::jsonb
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
  'cao-r12', '姬夕姑',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹庄公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄公"}]'::jsonb
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
  'cao-r13', '姬夷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹釐公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/釐公"}]'::jsonb
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
  'cao-r14', '姬班',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹昭公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭公"}]'::jsonb
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
  'cao-r15', '姬襄',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹共公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共公"}]'::jsonb
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
  'cao-r16', '姬寿',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹文公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'cao-r17', '姬彊',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹宣公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣公"}]'::jsonb
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
  'cao-r18', '姬负刍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹成公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成公"}]'::jsonb
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
  'cao-r19', '姬胜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹武公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武公"}]'::jsonb
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
  'cao-r20', '姬须',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹平公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/平公"}]'::jsonb
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
  'cao-r21', '姬午',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹悼公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼公"}]'::jsonb
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
  'cao-r22', '姬野',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹声公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/声公"}]'::jsonb
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
  'cao-r23', '姬通',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹隐公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/隐公"}]'::jsonb
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
  'cao-r24', '姬露',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹靖公，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/靖公"}]'::jsonb
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
  'cao-r25', '姬伯阳',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '曹伯阳，曹国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/伯阳"}]'::jsonb
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
  'wu-r0', '姬乘',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '吴王寿梦，吴国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王寿梦"}]'::jsonb
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
  'wu-r1', '姬遏',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '吴王诸樊，吴国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王诸樊"}]'::jsonb
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
  'wu-r2', '姬余祭',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '吴王余祭，吴国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王余祭"}]'::jsonb
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
  'wu-r3', '姬余眛',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '吴王余昧，吴国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王余昧"}]'::jsonb
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
  'wu-r4', '僚',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '吴王僚，吴国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王僚"}]'::jsonb
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
  'helu', '阖闾',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '吴王阖闾，任用伍子胥、孙武，破楚入郢。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/阖闾"}]'::jsonb
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
  'fu-chai', '夫差',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '吴王夫差，吴国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王夫差"}]'::jsonb
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
  'yue-r0', '姒无余',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越侯无余，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯无余"}]'::jsonb
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
  'yue-r1', '姒无壬',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越侯无壬，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯无壬"}]'::jsonb
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
  'yue-r2', '姒无瞫',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越侯无瞫，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯无瞫"}]'::jsonb
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
  'yue-r3', '姒夫谭',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越侯夫谭，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯夫谭"}]'::jsonb
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
  'yue-r4', '姒允常',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越侯允常，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/侯允常"}]'::jsonb
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
  'gou-jian', '姒勾践',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越王勾践，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王勾践"}]'::jsonb
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
  'yue-r6', '姒与夷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越王鹿郢，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王鹿郢"}]'::jsonb
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
  'yue-r7', '姒不寿',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越王不寿，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王不寿"}]'::jsonb
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
  'yue-r8', '姒翁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越王朱勾，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王朱勾"}]'::jsonb
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
  'yue-r9', '姒翳',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越王翳，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王翳"}]'::jsonb
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
  'yue-r10', '姒错枝',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越王错枝，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王错枝"}]'::jsonb
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
  'yue-r11', '姒无余',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越王无余，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王无余"}]'::jsonb
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
  'yue-r12', '姒无颛',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越王无颛，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王无颛"}]'::jsonb
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
  'yue-r13', '姒无彊',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越王无彊，越国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王无彊"}]'::jsonb
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
  'zhongshan-r0', '姬窟',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '中山武公，中山君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山武公"}]'::jsonb
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
  'zhongshan-r1', '姬桓公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '中山桓公，中山君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山桓公"}]'::jsonb
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
  'zhongshan-r2', '姬成公',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '中山成公，中山君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山成公"}]'::jsonb
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
  'zhongshan-r3', '姬厝',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '中山王厝，中山君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山王厝"}]'::jsonb
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
  'zhongshan-r4', '姬胜',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '中山王胜，中山君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山王胜"}]'::jsonb
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
  'zhongshan-r5', '姬尚',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '中山王尚，中山君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/中山王尚"}]'::jsonb
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
  'han-jing', '韩虔',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩景侯，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/景侯"}]'::jsonb
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
  'han-r1', '韩取',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩烈侯，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/烈侯"}]'::jsonb
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
  'han-r2', '韩猷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩文侯，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文侯"}]'::jsonb
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
  'han-r3', '韩屯蒙',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩哀侯，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哀侯"}]'::jsonb
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
  'han-r4', '韩若山',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩共侯，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共侯"}]'::jsonb
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
  'han-r5', '韩武',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩釐侯，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/釐侯"}]'::jsonb
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
  'han-r6', '韩康',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩宣惠王，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣惠王"}]'::jsonb
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
  'han-r7', '韩仓',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩襄王，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄王"}]'::jsonb
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
  'han-r8', '韩咎',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩釐王，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/釐王"}]'::jsonb
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
  'han-r9', '韩然',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩桓惠王，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓惠王"}]'::jsonb
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
  'han-r10', '韩安',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩王安，韩国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王安"}]'::jsonb
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
  'zhao-lie', '赵籍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵烈侯，赵国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/烈侯"}]'::jsonb
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
  'zhao-r1', '赵□',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵武侯，赵国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武侯"}]'::jsonb
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
  'zhao-r2', '赵章',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵敬侯，赵国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/敬侯"}]'::jsonb
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
  'zhao-r3', '赵种',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵成侯，赵国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成侯"}]'::jsonb
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
  'zhao-r4', '赵语',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵肃侯，赵国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/肃侯"}]'::jsonb
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
  'zhao-r5', '赵雍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵武灵王，赵国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武灵王"}]'::jsonb
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
  'zhao-r6', '赵何',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵惠文王，赵国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠文王"}]'::jsonb
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
  'zhao-r7', '赵丹',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵孝成王，赵国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孝成王"}]'::jsonb
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
  'zhao-r8', '赵偃',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵悼襄王，赵国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼襄王"}]'::jsonb
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
  'zhao-r9', '赵迁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵幽缪王，赵国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/幽缪王"}]'::jsonb
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
  'wei-wen', '魏斯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '魏文侯，魏国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文侯"}]'::jsonb
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
  'wei-r1', '魏击',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '魏武侯，魏国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武侯"}]'::jsonb
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
  'wei-r2', '魏罃',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '魏罃，魏国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/罃"}]'::jsonb
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
  'wei-r3', '魏罃',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '魏惠成王，魏国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠成王"}]'::jsonb
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
  'wei-r4', '魏嗣',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '魏襄王，魏国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄王"}]'::jsonb
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
  'wei-r5', '魏遫',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '魏昭王，魏国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭王"}]'::jsonb
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
  'wei-r6', '魏圉',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '魏安僖王，魏国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/安僖王"}]'::jsonb
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
  'wei-r7', '魏午',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '魏景湣王，魏国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/景湣王"}]'::jsonb
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
  'wei-r8', '魏假',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '魏假，魏国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/假"}]'::jsonb
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
  'ying-qi', '嬴开',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦襄公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/襄公"}]'::jsonb
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
  'qin-r1', '嬴康',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦文公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/文公"}]'::jsonb
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
  'qin-r2', '嬴立',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦宪公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宪公"}]'::jsonb
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
  'qin-r3', '嬴曼',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦出子，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/出子"}]'::jsonb
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
  'qin-r4', '嬴说',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦武公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武公"}]'::jsonb
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
  'qin-r5', '嬴嘉',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦德公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/德公"}]'::jsonb
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
  'qin-r6', '嬴恬',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦宣公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/宣公"}]'::jsonb
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
  'qin-r7', '嬴载',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦成公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/成公"}]'::jsonb
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
  'qin-r8', '嬴任好',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦穆公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/穆公"}]'::jsonb
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
  'qin-r9', '嬴罃',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦康公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/康公"}]'::jsonb
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
  'qin-r10', '嬴和',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦共公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/共公"}]'::jsonb
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
  'qin-r11', '嬴荣',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦桓公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/桓公"}]'::jsonb
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
  'qin-r12', '嬴石',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦景公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/景公"}]'::jsonb
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
  'qin-r13', '嬴籍',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦哀公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/哀公"}]'::jsonb
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
  'qin-r14', '嬴宁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦惠公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠公"}]'::jsonb
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
  'qin-r15', '嬴盘',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦悼公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/悼公"}]'::jsonb
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
  'qin-r16', '嬴刺',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦厉共公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/厉共公"}]'::jsonb
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
  'qin-r17', '嬴欣',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦躁公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/躁公"}]'::jsonb
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
  'qin-r18', '嬴封',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦怀公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/怀公"}]'::jsonb
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
  'qin-r19', '嬴肃',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦灵公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/灵公"}]'::jsonb
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
  'qin-r20', '嬴悼子',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦简公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/简公"}]'::jsonb
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
  'qin-r21', '嬴仁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦惠公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠公"}]'::jsonb
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
  'qin-r22', '嬴昌',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦出公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/出公"}]'::jsonb
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
  'qin-r23', '嬴师隰',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦献公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/献公"}]'::jsonb
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
  'ying-quliang', '嬴渠梁',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦孝公，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孝公"}]'::jsonb
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
  'qin-r25', '嬴驷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦惠文王，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/惠文王"}]'::jsonb
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
  'qin-r26', '嬴荡',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦武王，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/武王"}]'::jsonb
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
  'qin-r27', '嬴稷',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦昭襄王，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/昭襄王"}]'::jsonb
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
  'qin-r28', '嬴柱',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦孝文王，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孝文王"}]'::jsonb
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
  'qin-r29', '嬴子楚',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦庄襄王，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄襄王"}]'::jsonb
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
  'ying-zheng', '嬴政',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '秦王政，秦国君主。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王政"}]'::jsonb
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
  'shang-yang', '商鞅',
  -390, 1,
  -338, 1,
  ARRAY['政治家'], '卫国人，秦孝公时主持变法，奠定秦统一基础。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/商鞅"}]'::jsonb
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
  'wu-qi', '吴起',
  -440, 1,
  -381, 1,
  ARRAY['军事家','政治家'], '魏文侯时名将，后在楚主持变法。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/吴起"}]'::jsonb
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
  'sun-wu', '孙武',
  NULL, NULL,
  NULL, NULL,
  ARRAY['军事家'], '齐国军事家，著《孙子兵法》，传为吴王阖闾将。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孙武"}]'::jsonb
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
  'wu-zixu', '伍子胥',
  -559, 1,
  -484, 1,
  ARRAY['军事家','政治家'], '楚人，助吴王阖闾破楚入郢，后被夫差赐死。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/伍子胥"}]'::jsonb
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
  'fan-li', '范蠡',
  -536, 1,
  -448, 1,
  ARRAY['政治家','军事家'], '越国大夫，助勾践灭吴，后泛舟五湖。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/范蠡"}]'::jsonb
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
  'qu-yuan', '屈原',
  -340, 1,
  -278, 1,
  ARRAY['诗人','政治家'], '楚国诗人，楚辞代表，投汨罗江而死。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/屈原"}]'::jsonb
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
  'lao-zi', '老子',
  NULL, NULL,
  NULL, NULL,
  ARRAY['思想家'], '道家学派创始人，传统认为著道德经。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/老子"}]'::jsonb
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
  'meng-ke', '孟子',
  -372, 1,
  -289, 1,
  ARRAY['思想家'], '战国时期儒家代表，主张仁政王道。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孟子"}]'::jsonb
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
  'zhuang-zhou', '庄子',
  -369, 1,
  -286, 1,
  ARRAY['思想家'], '道家代表人物，庄子作者。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/庄子"}]'::jsonb
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
  'han-fei', '韩非',
  -280, 1,
  -233, 1,
  ARRAY['思想家'], '法家集大成者，秦王政重其书，后遭李斯害死。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩非"}]'::jsonb
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
  'sun-bin', '孙膑',
  -378, 1,
  -316, 1,
  ARRAY['军事家'], '孙子后裔，著孙膑兵法，桂陵、马陵大败魏军。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/孙膑"}]'::jsonb
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
  'bai-qi', '白起',
  -332, 1,
  -257, 1,
  ARRAY['军事家'], '秦国名将，长平之战坑赵卒，封武安君。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/白起"}]'::jsonb
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
  'wang-jian-qin', '王翦',
  NULL, NULL,
  NULL, NULL,
  ARRAY['军事家'], '秦国名将，灭楚、灭燕，助秦统一天下。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/王翦"}]'::jsonb
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
  'bian-que', '扁鹊',
  -407, 1,
  -310, 1,
  ARRAY['医学家'], '战国名医，望闻问切四诊法传说与其相关。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/扁鹊"}]'::jsonb
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
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'qi-chunqiu', '齐国', ARRAY['齐','姜齐','田齐'], 'cn', 'east_asia',
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'jin-chunqiu', '晋国', ARRAY['晋'], 'cn', 'east_asia',
  -1042, 1, -349, 12,
  -12492, -4165, 'year', 'azure', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'chu-chunqiu', '楚国', ARRAY['楚','荆楚'], 'cn', 'east_asia',
  -1042, 1, -223, 12,
  -12492, -2653, 'year', 'cinnabar', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'yan-chunqiu', '燕国', ARRAY['燕'], 'cn', 'east_asia',
  -1044, 1, -222, 12,
  -12516, -2641, 'year', 'jade', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'song-chunqiu', '宋国', ARRAY['宋'], 'cn', 'east_asia',
  -1034, 1, -286, 12,
  -12396, -3409, 'year', 'indigo', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'lu-chunqiu', '鲁国', ARRAY['鲁'], 'cn', 'east_asia',
  -1042, 1, -256, 12,
  -12492, -3049, 'year', 'coral', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'wei-weiguo', '卫国', ARRAY['卫'], 'cn', 'east_asia',
  -1040, 1, -209, 12,
  -12468, -2485, 'year', 'moss', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'zheng-chunqiu', '郑国', ARRAY['郑'], 'cn', 'east_asia',
  -806, 1, -375, 12,
  -9660, -4477, 'year', 'plum', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'cao-chunqiu', '曹国', ARRAY['曹'], 'cn', 'east_asia',
  -1046, 1, -487, 12,
  -12540, -5821, 'year', 'mineral', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'wu-chunqiu', '吴国', ARRAY['吴'], 'cn', 'east_asia',
  -585, 1, -473, 12,
  -7008, -5653, 'year', 'amber', NULL, NULL,
  '春秋东南强国，阖闾、夫差时盛；前473年越灭吴。'
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
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'yue-chunqiu', '越国', ARRAY['越'], 'cn', 'east_asia',
  -600, 1, -334, 12,
  -7188, -3985, 'year', 'grape', NULL, NULL,
  '东南古国，勾践灭吴后北进；前334年楚败越，国势衰微。'
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
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'zhongshan', '中山', ARRAY['中山国'], 'cn', 'east_asia',
  -476, 1, -296, 12,
  -5700, -3529, 'year', 'sage', NULL, NULL,
  '鲜虞白狄所建，战国中小国；前296年赵灭中山。'
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
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'han-warring', '韩国', ARRAY['韩'], 'cn', 'east_asia',
  -403, 1, -230, 12,
  -4824, -2737, 'year', 'stone', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'zhao-warring', '赵国', ARRAY['赵'], 'cn', 'east_asia',
  -403, 1, -222, 12,
  -4824, -2641, 'year', 'clay', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'wei-warring', '魏国', ARRAY['魏','梁'], 'cn', 'east_asia',
  -403, 1, -225, 12,
  -4824, -2677, 'year', 'wisteria', NULL, NULL,
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
  color_token = EXCLUDED.color_token,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  'qin', '秦', ARRAY['嬴秦','秦国'], 'cn', 'east_asia',
  -770, 1, -207, 12,
  -9228, -2461, 'year', 'ochre', -2640, NULL,
  '前770年秦襄公护周平王东迁列为诸侯；前221年嬴政称帝统一；前207年子婴降，秦亡。'
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
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;

-- reigns
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lv-shang-qi-chunqiu', 'qi-chunqiu', 'lv-shang', '齐太公',
  '太公', NULL, '{"kind":"posthumous","name":"齐太公"}'::jsonb,
  -1046, 1, NULL, -1011, 12, NULL,
  -12540, -12109, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r1-qi-chunqiu', 'qi-chunqiu', 'qi-r1', '齐丁公',
  '丁公', NULL, '{"kind":"posthumous","name":"齐丁公"}'::jsonb,
  -1010, 1, NULL, -974, 12, NULL,
  -12108, -11665, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r2-qi-chunqiu', 'qi-chunqiu', 'qi-r2', '齐乙公',
  '乙公', NULL, '{"kind":"posthumous","name":"齐乙公"}'::jsonb,
  -973, 1, NULL, -937, 12, NULL,
  -11664, -11221, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r3-qi-chunqiu', 'qi-chunqiu', 'qi-r3', '齐癸公',
  '癸公', NULL, '{"kind":"posthumous","name":"齐癸公"}'::jsonb,
  -936, 1, NULL, -900, 12, NULL,
  -11220, -10777, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r4-qi-chunqiu', 'qi-chunqiu', 'qi-r4', '齐哀公',
  '哀公', NULL, '{"kind":"posthumous","name":"齐哀公"}'::jsonb,
  -899, 1, NULL, -863, 12, NULL,
  -10776, -10333, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r5-qi-chunqiu', 'qi-chunqiu', 'qi-r5', '齐胡公',
  '胡公', NULL, '{"kind":"posthumous","name":"齐胡公"}'::jsonb,
  -862, 1, NULL, -860, 12, NULL,
  -10332, -10297, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r6-qi-chunqiu', 'qi-chunqiu', 'qi-r6', '齐献公',
  '献公', NULL, '{"kind":"posthumous","name":"齐献公"}'::jsonb,
  -859, 1, NULL, -851, 12, NULL,
  -10296, -10189, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r7-qi-chunqiu', 'qi-chunqiu', 'qi-r7', '齐武公',
  '武公', NULL, '{"kind":"posthumous","name":"齐武公"}'::jsonb,
  -850, 1, NULL, -825, 12, NULL,
  -10188, -9877, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r8-qi-chunqiu', 'qi-chunqiu', 'qi-r8', '齐厉公',
  '厉公', NULL, '{"kind":"posthumous","name":"齐厉公"}'::jsonb,
  -824, 1, NULL, -816, 12, NULL,
  -9876, -9769, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r9-qi-chunqiu', 'qi-chunqiu', 'qi-r9', '齐文公',
  '文公', NULL, '{"kind":"posthumous","name":"齐文公"}'::jsonb,
  -815, 1, NULL, -804, 12, NULL,
  -9768, -9625, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r10-qi-chunqiu', 'qi-chunqiu', 'qi-r10', '齐成公',
  '成公', NULL, '{"kind":"posthumous","name":"齐成公"}'::jsonb,
  -803, 1, NULL, -795, 12, NULL,
  -9624, -9517, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r11-qi-chunqiu', 'qi-chunqiu', 'qi-r11', '齐庄公',
  '庄公', NULL, '{"kind":"posthumous","name":"齐庄公"}'::jsonb,
  -794, 1, NULL, -731, 12, NULL,
  -9516, -8749, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r12-qi-chunqiu', 'qi-chunqiu', 'qi-r12', '齐釐公',
  '釐公', NULL, '{"kind":"posthumous","name":"齐釐公"}'::jsonb,
  -730, 1, NULL, -698, 12, NULL,
  -8748, -8353, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r13-qi-chunqiu', 'qi-chunqiu', 'qi-r13', '齐襄公',
  '襄公', NULL, '{"kind":"posthumous","name":"齐襄公"}'::jsonb,
  -697, 1, NULL, -686, 12, NULL,
  -8352, -8209, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r14-qi-chunqiu', 'qi-chunqiu', 'qi-r14', '公孙无知',
  NULL, NULL, '{"kind":"regnal","name":"公孙无知"}'::jsonb,
  -686, 1, NULL, -686, 12, NULL,
  -8220, -8209, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jiang-xiaobai-qi-chunqiu', 'qi-chunqiu', 'jiang-xiaobai', '齐桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"齐桓公"}'::jsonb,
  -685, 1, NULL, -643, 12, NULL,
  -8208, -7693, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r16-qi-chunqiu', 'qi-chunqiu', 'qi-r16', '公子无亏',
  NULL, NULL, '{"kind":"regnal","name":"公子无亏"}'::jsonb,
  -643, 1, NULL, -643, 12, NULL,
  -7704, -7693, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r17-qi-chunqiu', 'qi-chunqiu', 'qi-r17', '齐孝公',
  '孝公', NULL, '{"kind":"posthumous","name":"齐孝公"}'::jsonb,
  -642, 1, NULL, -633, 12, NULL,
  -7692, -7573, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r18-qi-chunqiu', 'qi-chunqiu', 'qi-r18', '齐昭公',
  '昭公', NULL, '{"kind":"posthumous","name":"齐昭公"}'::jsonb,
  -632, 1, NULL, -613, 12, NULL,
  -7572, -7333, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r19-qi-chunqiu', 'qi-chunqiu', 'qi-r19', '齐君舍',
  NULL, NULL, '{"kind":"regnal","name":"齐君舍"}'::jsonb,
  -613, 1, NULL, -613, 12, NULL,
  -7344, -7333, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r20-qi-chunqiu', 'qi-chunqiu', 'qi-r20', '齐懿公',
  '懿公', NULL, '{"kind":"posthumous","name":"齐懿公"}'::jsonb,
  -612, 1, NULL, -609, 12, NULL,
  -7332, -7285, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r21-qi-chunqiu', 'qi-chunqiu', 'qi-r21', '齐惠公',
  '惠公', NULL, '{"kind":"posthumous","name":"齐惠公"}'::jsonb,
  -608, 1, NULL, -599, 12, NULL,
  -7284, -7165, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r22-qi-chunqiu', 'qi-chunqiu', 'qi-r22', '齐顷公',
  '顷公', NULL, '{"kind":"posthumous","name":"齐顷公"}'::jsonb,
  -598, 1, NULL, -582, 12, NULL,
  -7164, -6961, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r23-qi-chunqiu', 'qi-chunqiu', 'qi-r23', '齐灵公',
  '灵公', NULL, '{"kind":"posthumous","name":"齐灵公"}'::jsonb,
  -581, 1, NULL, -554, 12, NULL,
  -6960, -6625, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r24-qi-chunqiu', 'qi-chunqiu', 'qi-r24', '齐庄公',
  '庄公', NULL, '{"kind":"posthumous","name":"齐庄公"}'::jsonb,
  -553, 1, NULL, -548, 12, NULL,
  -6624, -6553, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r25-qi-chunqiu', 'qi-chunqiu', 'qi-r25', '齐景公',
  '景公', NULL, '{"kind":"posthumous","name":"齐景公"}'::jsonb,
  -547, 1, NULL, -490, 12, NULL,
  -6552, -5857, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r26-qi-chunqiu', 'qi-chunqiu', 'qi-r26', '安孺子',
  NULL, NULL, '{"kind":"regnal","name":"安孺子"}'::jsonb,
  -489, 1, NULL, -489, 12, NULL,
  -5856, -5845, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r27-qi-chunqiu', 'qi-chunqiu', 'qi-r27', '齐悼公',
  '悼公', NULL, '{"kind":"posthumous","name":"齐悼公"}'::jsonb,
  -488, 1, NULL, -485, 12, NULL,
  -5844, -5797, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r28-qi-chunqiu', 'qi-chunqiu', 'qi-r28', '齐简公',
  '简公', NULL, '{"kind":"posthumous","name":"齐简公"}'::jsonb,
  -484, 1, NULL, -481, 12, NULL,
  -5796, -5749, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r29-qi-chunqiu', 'qi-chunqiu', 'qi-r29', '齐平公',
  '平公', NULL, '{"kind":"posthumous","name":"齐平公"}'::jsonb,
  -480, 1, NULL, -456, 12, NULL,
  -5748, -5449, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r30-qi-chunqiu', 'qi-chunqiu', 'qi-r30', '齐宣公',
  '宣公', NULL, '{"kind":"posthumous","name":"齐宣公"}'::jsonb,
  -455, 1, NULL, -405, 12, NULL,
  -5448, -4837, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r31-qi-chunqiu', 'qi-chunqiu', 'qi-r31', '齐太公',
  '太公', NULL, '{"kind":"posthumous","name":"齐太公"}'::jsonb,
  -404, 1, NULL, -384, 12, NULL,
  -4836, -4585, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r32-qi-chunqiu', 'qi-chunqiu', 'qi-r32', '齐康公',
  '康公', NULL, '{"kind":"posthumous","name":"齐康公"}'::jsonb,
  -404, 1, NULL, -379, 12, NULL,
  -4836, -4525, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r33-qi-chunqiu', 'qi-chunqiu', 'qi-r33', '齐侯剡',
  NULL, NULL, '{"kind":"regnal","name":"齐侯剡"}'::jsonb,
  -383, 1, NULL, -375, 12, NULL,
  -4584, -4477, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r34-qi-chunqiu', 'qi-chunqiu', 'qi-r34', '齐桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"齐桓公"}'::jsonb,
  -374, 1, NULL, -357, 12, NULL,
  -4476, -4261, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r35-qi-chunqiu', 'qi-chunqiu', 'qi-r35', '齐威王',
  '威王', NULL, '{"kind":"posthumous","name":"齐威王"}'::jsonb,
  -356, 1, NULL, -320, 12, NULL,
  -4260, -3817, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r36-qi-chunqiu', 'qi-chunqiu', 'qi-r36', '齐宣王',
  '宣王', NULL, '{"kind":"posthumous","name":"齐宣王"}'::jsonb,
  -319, 1, NULL, -301, 12, NULL,
  -3816, -3589, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r37-qi-chunqiu', 'qi-chunqiu', 'qi-r37', '齐湣王',
  '湣王', NULL, '{"kind":"posthumous","name":"齐湣王"}'::jsonb,
  -300, 1, NULL, -284, 12, NULL,
  -3588, -3385, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r38-qi-chunqiu', 'qi-chunqiu', 'qi-r38', '齐襄王',
  '襄王', NULL, '{"kind":"posthumous","name":"齐襄王"}'::jsonb,
  -283, 1, NULL, -265, 12, NULL,
  -3384, -3157, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qi-r39-qi-chunqiu', 'qi-chunqiu', 'qi-r39', '齐王建',
  NULL, NULL, '{"kind":"regnal","name":"齐王建"}'::jsonb,
  -264, 1, NULL, -221, 12, NULL,
  -3156, -2629, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-ji-shuyu-jin-chunqiu', 'jin-chunqiu', 'ji-shuyu', '唐叔虞',
  NULL, NULL, '{"kind":"regnal","name":"唐叔虞"}'::jsonb,
  -1042, 1, NULL, -1007, 12, NULL,
  -12492, -12061, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r1-jin-chunqiu', 'jin-chunqiu', 'jin-r1', '晋侯燮',
  NULL, NULL, '{"kind":"regnal","name":"晋侯燮"}'::jsonb,
  -1006, 1, NULL, -970, 12, NULL,
  -12060, -11617, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r2-jin-chunqiu', 'jin-chunqiu', 'jin-r2', '晋武侯',
  '武侯', NULL, '{"kind":"posthumous","name":"晋武侯"}'::jsonb,
  -969, 1, NULL, -933, 12, NULL,
  -11616, -11173, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r3-jin-chunqiu', 'jin-chunqiu', 'jin-r3', '晋成侯',
  '成侯', NULL, '{"kind":"posthumous","name":"晋成侯"}'::jsonb,
  -932, 1, NULL, -896, 12, NULL,
  -11172, -10729, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r4-jin-chunqiu', 'jin-chunqiu', 'jin-r4', '晋厉侯',
  '厉侯', NULL, '{"kind":"posthumous","name":"晋厉侯"}'::jsonb,
  -895, 1, NULL, -859, 12, NULL,
  -10728, -10285, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r5-jin-chunqiu', 'jin-chunqiu', 'jin-r5', '晋靖侯',
  '靖侯', NULL, '{"kind":"posthumous","name":"晋靖侯"}'::jsonb,
  -858, 1, NULL, -841, 12, NULL,
  -10284, -10069, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r6-jin-chunqiu', 'jin-chunqiu', 'jin-r6', '晋釐侯',
  '釐侯', NULL, '{"kind":"posthumous","name":"晋釐侯"}'::jsonb,
  -840, 1, NULL, -823, 12, NULL,
  -10068, -9853, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r7-jin-chunqiu', 'jin-chunqiu', 'jin-r7', '晋献侯',
  '献侯', NULL, '{"kind":"posthumous","name":"晋献侯"}'::jsonb,
  -822, 1, NULL, -812, 12, NULL,
  -9852, -9721, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r8-jin-chunqiu', 'jin-chunqiu', 'jin-r8', '晋穆侯',
  '穆侯', NULL, '{"kind":"posthumous","name":"晋穆侯"}'::jsonb,
  -811, 1, NULL, -785, 12, NULL,
  -9720, -9397, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r9-jin-chunqiu', 'jin-chunqiu', 'jin-r9', '晋殇叔',
  '殇叔', NULL, '{"kind":"posthumous","name":"晋殇叔"}'::jsonb,
  -784, 1, NULL, -781, 12, NULL,
  -9396, -9349, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r10-jin-chunqiu', 'jin-chunqiu', 'jin-r10', '晋文侯',
  '文侯', NULL, '{"kind":"posthumous","name":"晋文侯"}'::jsonb,
  -780, 1, NULL, -746, 12, NULL,
  -9348, -8929, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r11-jin-chunqiu', 'jin-chunqiu', 'jin-r11', '晋昭侯',
  '昭侯', NULL, '{"kind":"posthumous","name":"晋昭侯"}'::jsonb,
  -745, 1, NULL, -740, 12, NULL,
  -8928, -8857, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r12-jin-chunqiu', 'jin-chunqiu', 'jin-r12', '曲沃桓叔',
  NULL, NULL, '{"kind":"regnal","name":"曲沃桓叔"}'::jsonb,
  -744, 1, NULL, -731, 12, NULL,
  -8916, -8749, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r13-jin-chunqiu', 'jin-chunqiu', 'jin-r13', '晋孝侯',
  '孝侯', NULL, '{"kind":"posthumous","name":"晋孝侯"}'::jsonb,
  -739, 1, NULL, -724, 12, NULL,
  -8856, -8665, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r14-jin-chunqiu', 'jin-chunqiu', 'jin-r14', '曲沃庄伯',
  NULL, NULL, '{"kind":"regnal","name":"曲沃庄伯"}'::jsonb,
  -730, 1, NULL, -716, 12, NULL,
  -8748, -8569, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r15-jin-chunqiu', 'jin-chunqiu', 'jin-r15', '晋鄂侯',
  '鄂侯', NULL, '{"kind":"posthumous","name":"晋鄂侯"}'::jsonb,
  -723, 1, NULL, -718, 12, NULL,
  -8664, -8593, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r16-jin-chunqiu', 'jin-chunqiu', 'jin-r16', '晋哀侯',
  '哀侯', NULL, '{"kind":"posthumous","name":"晋哀侯"}'::jsonb,
  -717, 1, NULL, -709, 12, NULL,
  -8592, -8485, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r17-jin-chunqiu', 'jin-chunqiu', 'jin-r17', '曲沃武公',
  '曲沃武公', NULL, '{"kind":"posthumous","name":"曲沃武公"}'::jsonb,
  -715, 1, NULL, -677, 12, NULL,
  -8568, -8101, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r18-jin-chunqiu', 'jin-chunqiu', 'jin-r18', '晋小子侯',
  '小子侯', NULL, '{"kind":"posthumous","name":"晋小子侯"}'::jsonb,
  -708, 1, NULL, -705, 12, NULL,
  -8484, -8437, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r19-jin-chunqiu', 'jin-chunqiu', 'jin-r19', '晋侯缗',
  NULL, NULL, '{"kind":"regnal","name":"晋侯缗"}'::jsonb,
  -704, 1, NULL, -678, 12, NULL,
  -8436, -8113, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r20-jin-chunqiu', 'jin-chunqiu', 'jin-r20', '晋献公',
  '献公', NULL, '{"kind":"posthumous","name":"晋献公"}'::jsonb,
  -676, 1, NULL, -651, 12, NULL,
  -8100, -7789, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r21-jin-chunqiu', 'jin-chunqiu', 'jin-r21', '晋惠公',
  '惠公', NULL, '{"kind":"posthumous","name":"晋惠公"}'::jsonb,
  -650, 1, NULL, -637, 12, NULL,
  -7788, -7621, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r22-jin-chunqiu', 'jin-chunqiu', 'jin-r22', '晋怀公',
  '怀公', NULL, '{"kind":"posthumous","name":"晋怀公"}'::jsonb,
  -637, 1, NULL, -637, 12, NULL,
  -7632, -7621, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-ji-chonger-jin-chunqiu', 'jin-chunqiu', 'ji-chonger', '晋文公',
  '文公', NULL, '{"kind":"posthumous","name":"晋文公"}'::jsonb,
  -636, 1, NULL, -628, 12, NULL,
  -7620, -7513, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r24-jin-chunqiu', 'jin-chunqiu', 'jin-r24', '晋襄公',
  '襄公', NULL, '{"kind":"posthumous","name":"晋襄公"}'::jsonb,
  -627, 1, NULL, -621, 12, NULL,
  -7512, -7429, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r25-jin-chunqiu', 'jin-chunqiu', 'jin-r25', '晋灵公',
  '灵公', NULL, '{"kind":"posthumous","name":"晋灵公"}'::jsonb,
  -620, 1, NULL, -607, 12, NULL,
  -7428, -7261, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r26-jin-chunqiu', 'jin-chunqiu', 'jin-r26', '晋成公',
  '成公', NULL, '{"kind":"posthumous","name":"晋成公"}'::jsonb,
  -606, 1, NULL, -600, 12, NULL,
  -7260, -7177, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r27-jin-chunqiu', 'jin-chunqiu', 'jin-r27', '晋景公',
  '景公', NULL, '{"kind":"posthumous","name":"晋景公"}'::jsonb,
  -599, 1, NULL, -581, 12, NULL,
  -7176, -6949, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r28-jin-chunqiu', 'jin-chunqiu', 'jin-r28', '晋厉公',
  '厉公', NULL, '{"kind":"posthumous","name":"晋厉公"}'::jsonb,
  -580, 1, NULL, -573, 12, NULL,
  -6948, -6853, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r29-jin-chunqiu', 'jin-chunqiu', 'jin-r29', '晋悼公',
  '悼公', NULL, '{"kind":"posthumous","name":"晋悼公"}'::jsonb,
  -572, 1, NULL, -558, 12, NULL,
  -6852, -6673, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r30-jin-chunqiu', 'jin-chunqiu', 'jin-r30', '晋平公',
  '平公', NULL, '{"kind":"posthumous","name":"晋平公"}'::jsonb,
  -557, 1, NULL, -532, 12, NULL,
  -6672, -6361, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r31-jin-chunqiu', 'jin-chunqiu', 'jin-r31', '晋昭公',
  '昭公', NULL, '{"kind":"posthumous","name":"晋昭公"}'::jsonb,
  -531, 1, NULL, -526, 12, NULL,
  -6360, -6289, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r32-jin-chunqiu', 'jin-chunqiu', 'jin-r32', '晋顷公',
  '顷公', NULL, '{"kind":"posthumous","name":"晋顷公"}'::jsonb,
  -525, 1, NULL, -512, 12, NULL,
  -6288, -6121, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r33-jin-chunqiu', 'jin-chunqiu', 'jin-r33', '晋定公',
  '定公', NULL, '{"kind":"posthumous","name":"晋定公"}'::jsonb,
  -511, 1, NULL, -475, 12, NULL,
  -6120, -5677, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r34-jin-chunqiu', 'jin-chunqiu', 'jin-r34', '晋出公',
  '出公', NULL, '{"kind":"posthumous","name":"晋出公"}'::jsonb,
  -474, 1, NULL, -452, 12, NULL,
  -5676, -5401, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r35-jin-chunqiu', 'jin-chunqiu', 'jin-r35', '晋哀公',
  '哀公', NULL, '{"kind":"posthumous","name":"晋哀公"}'::jsonb,
  -451, 1, NULL, -434, 12, NULL,
  -5400, -5185, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r36-jin-chunqiu', 'jin-chunqiu', 'jin-r36', '晋幽公',
  '幽公', NULL, '{"kind":"posthumous","name":"晋幽公"}'::jsonb,
  -433, 1, NULL, -416, 12, NULL,
  -5184, -4969, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r37-jin-chunqiu', 'jin-chunqiu', 'jin-r37', '晋烈公',
  '烈公', NULL, '{"kind":"posthumous","name":"晋烈公"}'::jsonb,
  -415, 1, NULL, -389, 12, NULL,
  -4968, -4645, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r38-jin-chunqiu', 'jin-chunqiu', 'jin-r38', '晋孝公',
  '孝公', NULL, '{"kind":"posthumous","name":"晋孝公"}'::jsonb,
  -388, 1, NULL, -357, 12, NULL,
  -4644, -4261, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-jin-r39-jin-chunqiu', 'jin-chunqiu', 'jin-r39', '晋静公',
  '静公', NULL, '{"kind":"posthumous","name":"晋静公"}'::jsonb,
  -356, 1, NULL, -349, 12, NULL,
  -4260, -4165, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r0-chu-chunqiu', 'chu-chunqiu', 'chu-r0', '熊绎',
  NULL, NULL, '{"kind":"regnal","name":"熊绎"}'::jsonb,
  -1042, 1, NULL, -1019, 12, NULL,
  -12492, -12205, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r1-chu-chunqiu', 'chu-chunqiu', 'chu-r1', '熊艾',
  NULL, NULL, '{"kind":"regnal","name":"熊艾"}'::jsonb,
  -1018, 1, NULL, -995, 12, NULL,
  -12204, -11917, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r2-chu-chunqiu', 'chu-chunqiu', 'chu-r2', '熊䵣',
  NULL, NULL, '{"kind":"regnal","name":"熊䵣"}'::jsonb,
  -994, 1, NULL, -970, 12, NULL,
  -11916, -11617, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r3-chu-chunqiu', 'chu-chunqiu', 'chu-r3', '熊胜',
  NULL, NULL, '{"kind":"regnal","name":"熊胜"}'::jsonb,
  -969, 1, NULL, -946, 12, NULL,
  -11616, -11329, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r4-chu-chunqiu', 'chu-chunqiu', 'chu-r4', '熊杨',
  NULL, NULL, '{"kind":"regnal","name":"熊杨"}'::jsonb,
  -945, 1, NULL, -922, 12, NULL,
  -11328, -11041, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r5-chu-chunqiu', 'chu-chunqiu', 'chu-r5', '熊渠',
  NULL, NULL, '{"kind":"regnal","name":"熊渠"}'::jsonb,
  -921, 1, NULL, -897, 12, NULL,
  -11040, -10741, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r6-chu-chunqiu', 'chu-chunqiu', 'chu-r6', '熊挚红',
  NULL, NULL, '{"kind":"regnal","name":"熊挚红"}'::jsonb,
  -896, 1, NULL, -873, 12, NULL,
  -10740, -10453, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r7-chu-chunqiu', 'chu-chunqiu', 'chu-r7', '熊延',
  NULL, NULL, '{"kind":"regnal","name":"熊延"}'::jsonb,
  -872, 1, NULL, -848, 12, NULL,
  -10452, -10153, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r8-chu-chunqiu', 'chu-chunqiu', 'chu-r8', '熊勇',
  NULL, NULL, '{"kind":"regnal","name":"熊勇"}'::jsonb,
  -847, 1, NULL, -838, 12, NULL,
  -10152, -10033, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r9-chu-chunqiu', 'chu-chunqiu', 'chu-r9', '熊严',
  NULL, NULL, '{"kind":"regnal","name":"熊严"}'::jsonb,
  -837, 1, NULL, -828, 12, NULL,
  -10032, -9913, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r10-chu-chunqiu', 'chu-chunqiu', 'chu-r10', '熊霜',
  NULL, NULL, '{"kind":"regnal","name":"熊霜"}'::jsonb,
  -827, 1, NULL, -822, 12, NULL,
  -9912, -9841, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r11-chu-chunqiu', 'chu-chunqiu', 'chu-r11', '熊徇',
  NULL, NULL, '{"kind":"regnal","name":"熊徇"}'::jsonb,
  -821, 1, NULL, -800, 12, NULL,
  -9840, -9577, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r12-chu-chunqiu', 'chu-chunqiu', 'chu-r12', '熊咢',
  NULL, NULL, '{"kind":"regnal","name":"熊咢"}'::jsonb,
  -799, 1, NULL, -791, 12, NULL,
  -9576, -9469, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r13-chu-chunqiu', 'chu-chunqiu', 'chu-r13', '楚若敖',
  NULL, NULL, '{"kind":"regnal","name":"楚若敖"}'::jsonb,
  -790, 1, NULL, -764, 12, NULL,
  -9468, -9145, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r14-chu-chunqiu', 'chu-chunqiu', 'chu-r14', '楚霄敖',
  NULL, NULL, '{"kind":"regnal","name":"楚霄敖"}'::jsonb,
  -763, 1, NULL, -758, 12, NULL,
  -9144, -9073, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r15-chu-chunqiu', 'chu-chunqiu', 'chu-r15', '楚蚡冒',
  NULL, NULL, '{"kind":"regnal","name":"楚蚡冒"}'::jsonb,
  -757, 1, NULL, -741, 12, NULL,
  -9072, -8869, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r16-chu-chunqiu', 'chu-chunqiu', 'chu-r16', '楚武王',
  '武王', NULL, '{"kind":"posthumous","name":"楚武王"}'::jsonb,
  -740, 1, NULL, -690, 12, NULL,
  -8868, -8257, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r17-chu-chunqiu', 'chu-chunqiu', 'chu-r17', '楚文王',
  '文王', NULL, '{"kind":"posthumous","name":"楚文王"}'::jsonb,
  -689, 1, NULL, -675, 12, NULL,
  -8256, -8077, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r18-chu-chunqiu', 'chu-chunqiu', 'chu-r18', '楚堵敖',
  NULL, NULL, '{"kind":"regnal","name":"楚堵敖"}'::jsonb,
  -674, 1, NULL, -672, 12, NULL,
  -8076, -8041, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r19-chu-chunqiu', 'chu-chunqiu', 'chu-r19', '楚成王',
  '成王', NULL, '{"kind":"posthumous","name":"楚成王"}'::jsonb,
  -671, 1, NULL, -626, 12, NULL,
  -8040, -7489, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r20-chu-chunqiu', 'chu-chunqiu', 'chu-r20', '楚穆王',
  '穆王', NULL, '{"kind":"posthumous","name":"楚穆王"}'::jsonb,
  -625, 1, NULL, -614, 12, NULL,
  -7488, -7345, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-xiong-zhuang-chu-chunqiu', 'chu-chunqiu', 'xiong-zhuang', '楚庄王',
  '庄王', NULL, '{"kind":"posthumous","name":"楚庄王"}'::jsonb,
  -613, 1, NULL, -591, 12, NULL,
  -7344, -7069, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r22-chu-chunqiu', 'chu-chunqiu', 'chu-r22', '楚共王',
  '共王', NULL, '{"kind":"posthumous","name":"楚共王"}'::jsonb,
  -590, 1, NULL, -560, 12, NULL,
  -7068, -6697, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r23-chu-chunqiu', 'chu-chunqiu', 'chu-r23', '楚康王',
  '康王', NULL, '{"kind":"posthumous","name":"楚康王"}'::jsonb,
  -559, 1, NULL, -545, 12, NULL,
  -6696, -6517, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r24-chu-chunqiu', 'chu-chunqiu', 'chu-r24', '楚郏敖',
  NULL, NULL, '{"kind":"regnal","name":"楚郏敖"}'::jsonb,
  -544, 1, NULL, -541, 12, NULL,
  -6516, -6469, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r25-chu-chunqiu', 'chu-chunqiu', 'chu-r25', '楚灵王',
  '灵王', NULL, '{"kind":"posthumous","name":"楚灵王"}'::jsonb,
  -540, 1, NULL, -529, 12, NULL,
  -6468, -6325, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r26-chu-chunqiu', 'chu-chunqiu', 'chu-r26', '楚王比',
  NULL, NULL, '{"kind":"regnal","name":"楚王比"}'::jsonb,
  -529, 1, NULL, -529, 12, NULL,
  -6336, -6325, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r27-chu-chunqiu', 'chu-chunqiu', 'chu-r27', '楚平王',
  '平王', NULL, '{"kind":"posthumous","name":"楚平王"}'::jsonb,
  -528, 1, NULL, -516, 12, NULL,
  -6324, -6169, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r28-chu-chunqiu', 'chu-chunqiu', 'chu-r28', '楚昭王',
  '昭王', NULL, '{"kind":"posthumous","name":"楚昭王"}'::jsonb,
  -515, 1, NULL, -489, 12, NULL,
  -6168, -5845, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r29-chu-chunqiu', 'chu-chunqiu', 'chu-r29', '楚惠王',
  '惠王', NULL, '{"kind":"posthumous","name":"楚惠王"}'::jsonb,
  -488, 1, NULL, -432, 12, NULL,
  -5844, -5161, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r30-chu-chunqiu', 'chu-chunqiu', 'chu-r30', '楚简王',
  '简王', NULL, '{"kind":"posthumous","name":"楚简王"}'::jsonb,
  -431, 1, NULL, -408, 12, NULL,
  -5160, -4873, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r31-chu-chunqiu', 'chu-chunqiu', 'chu-r31', '楚声王',
  '声王', NULL, '{"kind":"posthumous","name":"楚声王"}'::jsonb,
  -407, 1, NULL, -402, 12, NULL,
  -4872, -4801, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r32-chu-chunqiu', 'chu-chunqiu', 'chu-r32', '楚悼王',
  '悼王', NULL, '{"kind":"posthumous","name":"楚悼王"}'::jsonb,
  -401, 1, NULL, -381, 12, NULL,
  -4800, -4549, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r33-chu-chunqiu', 'chu-chunqiu', 'chu-r33', '楚肃王',
  '肃王', NULL, '{"kind":"posthumous","name":"楚肃王"}'::jsonb,
  -380, 1, NULL, -370, 12, NULL,
  -4548, -4417, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r34-chu-chunqiu', 'chu-chunqiu', 'chu-r34', '楚宣王',
  '宣王', NULL, '{"kind":"posthumous","name":"楚宣王"}'::jsonb,
  -369, 1, NULL, -340, 12, NULL,
  -4416, -4057, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r35-chu-chunqiu', 'chu-chunqiu', 'chu-r35', '楚威王',
  '威王', NULL, '{"kind":"posthumous","name":"楚威王"}'::jsonb,
  -339, 1, NULL, -329, 12, NULL,
  -4056, -3925, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r36-chu-chunqiu', 'chu-chunqiu', 'chu-r36', '楚怀王',
  '怀王', NULL, '{"kind":"posthumous","name":"楚怀王"}'::jsonb,
  -328, 1, NULL, -299, 12, NULL,
  -3924, -3565, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r37-chu-chunqiu', 'chu-chunqiu', 'chu-r37', '楚顷襄王',
  '顷襄王', NULL, '{"kind":"posthumous","name":"楚顷襄王"}'::jsonb,
  -298, 1, NULL, -263, 12, NULL,
  -3564, -3133, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r38-chu-chunqiu', 'chu-chunqiu', 'chu-r38', '楚考烈王',
  '考烈王', NULL, '{"kind":"posthumous","name":"楚考烈王"}'::jsonb,
  -262, 1, NULL, -238, 12, NULL,
  -3132, -2833, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r39-chu-chunqiu', 'chu-chunqiu', 'chu-r39', '楚幽王',
  '幽王', NULL, '{"kind":"posthumous","name":"楚幽王"}'::jsonb,
  -237, 1, NULL, -228, 12, NULL,
  -2832, -2713, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r40-chu-chunqiu', 'chu-chunqiu', 'chu-r40', '楚哀王',
  '哀王', NULL, '{"kind":"posthumous","name":"楚哀王"}'::jsonb,
  -228, 1, NULL, -228, 12, NULL,
  -2724, -2713, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r41-chu-chunqiu', 'chu-chunqiu', 'chu-r41', '楚王负刍',
  NULL, NULL, '{"kind":"regnal","name":"楚王负刍"}'::jsonb,
  -227, 1, NULL, -223, 12, NULL,
  -2712, -2653, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r42-chu-chunqiu', 'chu-chunqiu', 'chu-r42', '楚昌平君',
  NULL, NULL, '{"kind":"regnal","name":"楚昌平君"}'::jsonb,
  -223, 1, NULL, -223, 12, NULL,
  -2664, -2653, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-chu-r43-chu-chunqiu', 'chu-chunqiu', 'chu-r43', '楚义帝',
  NULL, NULL, '{"kind":"regnal","name":"楚义帝"}'::jsonb,
  -208, 1, NULL, -205, 12, NULL,
  -2484, -2437, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-ji-shi-yan-chunqiu', 'yan-chunqiu', 'ji-shi', '燕召公',
  '召公', NULL, '{"kind":"posthumous","name":"燕召公"}'::jsonb,
  -1044, 1, NULL, -1000, 12, NULL,
  -12516, -11977, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r1-yan-chunqiu', 'yan-chunqiu', 'yan-r1', '燕侯克',
  NULL, NULL, '{"kind":"regnal","name":"燕侯克"}'::jsonb,
  -999, 1, NULL, -955, 12, NULL,
  -11976, -11437, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r2-yan-chunqiu', 'yan-chunqiu', 'yan-r2', '燕侯旨',
  NULL, NULL, '{"kind":"regnal","name":"燕侯旨"}'::jsonb,
  -954, 1, NULL, -910, 12, NULL,
  -11436, -10897, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r3-yan-chunqiu', 'yan-chunqiu', 'yan-r3', '燕侯舞',
  NULL, NULL, '{"kind":"regnal","name":"燕侯舞"}'::jsonb,
  -909, 1, NULL, -865, 12, NULL,
  -10896, -10357, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r4-yan-chunqiu', 'yan-chunqiu', 'yan-r4', '燕惠侯',
  '惠侯', NULL, '{"kind":"posthumous","name":"燕惠侯"}'::jsonb,
  -864, 1, NULL, -827, 12, NULL,
  -10356, -9901, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r5-yan-chunqiu', 'yan-chunqiu', 'yan-r5', '燕釐侯',
  '釐侯', NULL, '{"kind":"posthumous","name":"燕釐侯"}'::jsonb,
  -826, 1, NULL, -791, 12, NULL,
  -9900, -9469, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r6-yan-chunqiu', 'yan-chunqiu', 'yan-r6', '燕顷侯',
  '顷侯', NULL, '{"kind":"posthumous","name":"燕顷侯"}'::jsonb,
  -790, 1, NULL, -767, 12, NULL,
  -9468, -9181, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r7-yan-chunqiu', 'yan-chunqiu', 'yan-r7', '燕哀侯',
  '哀侯', NULL, '{"kind":"posthumous","name":"燕哀侯"}'::jsonb,
  -766, 1, NULL, -765, 12, NULL,
  -9180, -9157, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r8-yan-chunqiu', 'yan-chunqiu', 'yan-r8', '燕郑侯',
  '郑侯', NULL, '{"kind":"posthumous","name":"燕郑侯"}'::jsonb,
  -764, 1, NULL, -729, 12, NULL,
  -9156, -8725, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r9-yan-chunqiu', 'yan-chunqiu', 'yan-r9', '燕穆侯',
  '穆侯', NULL, '{"kind":"posthumous","name":"燕穆侯"}'::jsonb,
  -728, 1, NULL, -711, 12, NULL,
  -8724, -8509, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r10-yan-chunqiu', 'yan-chunqiu', 'yan-r10', '燕宣侯',
  '宣侯', NULL, '{"kind":"posthumous","name":"燕宣侯"}'::jsonb,
  -710, 1, NULL, -698, 12, NULL,
  -8508, -8353, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r11-yan-chunqiu', 'yan-chunqiu', 'yan-r11', '燕桓侯',
  '桓侯', NULL, '{"kind":"posthumous","name":"燕桓侯"}'::jsonb,
  -697, 1, NULL, -691, 12, NULL,
  -8352, -8269, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r12-yan-chunqiu', 'yan-chunqiu', 'yan-r12', '燕庄公',
  '庄公', NULL, '{"kind":"posthumous","name":"燕庄公"}'::jsonb,
  -690, 1, NULL, -658, 12, NULL,
  -8268, -7873, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r13-yan-chunqiu', 'yan-chunqiu', 'yan-r13', '燕襄公',
  '襄公', NULL, '{"kind":"posthumous","name":"燕襄公"}'::jsonb,
  -657, 1, NULL, -618, 12, NULL,
  -7872, -7393, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r14-yan-chunqiu', 'yan-chunqiu', 'yan-r14', '燕桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"燕桓公"}'::jsonb,
  -617, 1, NULL, -602, 12, NULL,
  -7392, -7201, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r15-yan-chunqiu', 'yan-chunqiu', 'yan-r15', '燕宣公',
  '宣公', NULL, '{"kind":"posthumous","name":"燕宣公"}'::jsonb,
  -601, 1, NULL, -587, 12, NULL,
  -7200, -7021, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r16-yan-chunqiu', 'yan-chunqiu', 'yan-r16', '燕昭公',
  '昭公', NULL, '{"kind":"posthumous","name":"燕昭公"}'::jsonb,
  -586, 1, NULL, -574, 12, NULL,
  -7020, -6865, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r17-yan-chunqiu', 'yan-chunqiu', 'yan-r17', '燕武公',
  '武公', NULL, '{"kind":"posthumous","name":"燕武公"}'::jsonb,
  -573, 1, NULL, -555, 12, NULL,
  -6864, -6637, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r18-yan-chunqiu', 'yan-chunqiu', 'yan-r18', '燕文公',
  '文公', NULL, '{"kind":"posthumous","name":"燕文公"}'::jsonb,
  -554, 1, NULL, -549, 12, NULL,
  -6636, -6565, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r19-yan-chunqiu', 'yan-chunqiu', 'yan-r19', '燕懿公',
  '懿公', NULL, '{"kind":"posthumous","name":"燕懿公"}'::jsonb,
  -548, 1, NULL, -545, 12, NULL,
  -6564, -6517, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r20-yan-chunqiu', 'yan-chunqiu', 'yan-r20', '燕惠公',
  '惠公', NULL, '{"kind":"posthumous","name":"燕惠公"}'::jsonb,
  -544, 1, NULL, -536, 12, NULL,
  -6516, -6409, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r21-yan-chunqiu', 'yan-chunqiu', 'yan-r21', '燕悼公',
  '悼公', NULL, '{"kind":"posthumous","name":"燕悼公"}'::jsonb,
  -535, 1, NULL, -529, 12, NULL,
  -6408, -6325, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r22-yan-chunqiu', 'yan-chunqiu', 'yan-r22', '燕共公',
  '共公', NULL, '{"kind":"posthumous","name":"燕共公"}'::jsonb,
  -528, 1, NULL, -524, 12, NULL,
  -6324, -6265, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r23-yan-chunqiu', 'yan-chunqiu', 'yan-r23', '燕平公',
  '平公', NULL, '{"kind":"posthumous","name":"燕平公"}'::jsonb,
  -523, 1, NULL, -505, 12, NULL,
  -6264, -6037, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r24-yan-chunqiu', 'yan-chunqiu', 'yan-r24', '燕简公',
  '简公', NULL, '{"kind":"posthumous","name":"燕简公"}'::jsonb,
  -504, 1, NULL, -493, 12, NULL,
  -6036, -5893, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r25-yan-chunqiu', 'yan-chunqiu', 'yan-r25', '燕孝公',
  '孝公', NULL, '{"kind":"posthumous","name":"燕孝公"}'::jsonb,
  -492, 1, NULL, -455, 12, NULL,
  -5892, -5437, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r26-yan-chunqiu', 'yan-chunqiu', 'yan-r26', '燕成公',
  '成公', NULL, '{"kind":"posthumous","name":"燕成公"}'::jsonb,
  -454, 1, NULL, -439, 12, NULL,
  -5436, -5245, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r27-yan-chunqiu', 'yan-chunqiu', 'yan-r27', '燕闵公',
  '闵公', NULL, '{"kind":"posthumous","name":"燕闵公"}'::jsonb,
  -438, 1, NULL, -415, 12, NULL,
  -5244, -4957, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r28-yan-chunqiu', 'yan-chunqiu', 'yan-r28', '燕简公',
  '简公', NULL, '{"kind":"posthumous","name":"燕简公"}'::jsonb,
  -414, 1, NULL, -373, 12, NULL,
  -4956, -4453, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r29-yan-chunqiu', 'yan-chunqiu', 'yan-r29', '燕桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"燕桓公"}'::jsonb,
  -372, 1, NULL, -362, 12, NULL,
  -4452, -4321, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r30-yan-chunqiu', 'yan-chunqiu', 'yan-r30', '燕文公',
  '文公', NULL, '{"kind":"posthumous","name":"燕文公"}'::jsonb,
  -361, 1, NULL, -333, 12, NULL,
  -4320, -3973, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r31-yan-chunqiu', 'yan-chunqiu', 'yan-r31', '燕易王',
  '易王', NULL, '{"kind":"posthumous","name":"燕易王"}'::jsonb,
  -332, 1, NULL, -321, 12, NULL,
  -3972, -3829, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r32-yan-chunqiu', 'yan-chunqiu', 'yan-r32', '燕王哙',
  NULL, NULL, '{"kind":"regnal","name":"燕王哙"}'::jsonb,
  -320, 1, NULL, -314, 12, NULL,
  -3828, -3745, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r33-yan-chunqiu', 'yan-chunqiu', 'yan-r33', '燕昭王',
  '昭王', NULL, '{"kind":"posthumous","name":"燕昭王"}'::jsonb,
  -312, 1, NULL, -279, 12, NULL,
  -3732, -3325, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r34-yan-chunqiu', 'yan-chunqiu', 'yan-r34', '燕惠王',
  '惠王', NULL, '{"kind":"posthumous","name":"燕惠王"}'::jsonb,
  -278, 1, NULL, -271, 12, NULL,
  -3324, -3229, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r35-yan-chunqiu', 'yan-chunqiu', 'yan-r35', '燕武成王',
  '武成王', NULL, '{"kind":"posthumous","name":"燕武成王"}'::jsonb,
  -271, 1, NULL, -258, 12, NULL,
  -3240, -3073, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r36-yan-chunqiu', 'yan-chunqiu', 'yan-r36', '燕孝王',
  '孝王', NULL, '{"kind":"posthumous","name":"燕孝王"}'::jsonb,
  -257, 1, NULL, -255, 12, NULL,
  -3072, -3037, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yan-r37-yan-chunqiu', 'yan-chunqiu', 'yan-r37', '燕王喜',
  NULL, NULL, '{"kind":"regnal","name":"燕王喜"}'::jsonb,
  -254, 1, NULL, -222, 12, NULL,
  -3036, -2641, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-weizi-song-chunqiu', 'song-chunqiu', 'song-weizi', '宋微子',
  NULL, NULL, '{"kind":"regnal","name":"宋微子"}'::jsonb,
  -1034, 1, NULL, -1010, 12, NULL,
  -12396, -12097, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r1-song-chunqiu', 'song-chunqiu', 'song-r1', '宋微仲',
  NULL, NULL, '{"kind":"regnal","name":"宋微仲"}'::jsonb,
  -1009, 1, NULL, -985, 12, NULL,
  -12096, -11797, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r2-song-chunqiu', 'song-chunqiu', 'song-r2', '宋公稽',
  NULL, NULL, '{"kind":"regnal","name":"宋公稽"}'::jsonb,
  -984, 1, NULL, -960, 12, NULL,
  -11796, -11497, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r3-song-chunqiu', 'song-chunqiu', 'song-r3', '宋丁公',
  '丁公', NULL, '{"kind":"posthumous","name":"宋丁公"}'::jsonb,
  -959, 1, NULL, -935, 12, NULL,
  -11496, -11197, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r4-song-chunqiu', 'song-chunqiu', 'song-r4', '宋湣公',
  '湣公', NULL, '{"kind":"posthumous","name":"宋湣公"}'::jsonb,
  -934, 1, NULL, -910, 12, NULL,
  -11196, -10897, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r5-song-chunqiu', 'song-chunqiu', 'song-r5', '宋炀公',
  '炀公', NULL, '{"kind":"posthumous","name":"宋炀公"}'::jsonb,
  -909, 1, NULL, -885, 12, NULL,
  -10896, -10597, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r6-song-chunqiu', 'song-chunqiu', 'song-r6', '宋厉公',
  '厉公', NULL, '{"kind":"posthumous","name":"宋厉公"}'::jsonb,
  -884, 1, NULL, -859, 12, NULL,
  -10596, -10285, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r7-song-chunqiu', 'song-chunqiu', 'song-r7', '宋釐公',
  '釐公', NULL, '{"kind":"posthumous","name":"宋釐公"}'::jsonb,
  -858, 1, NULL, -831, 12, NULL,
  -10284, -9949, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r8-song-chunqiu', 'song-chunqiu', 'song-r8', '宋惠公',
  '惠公', NULL, '{"kind":"posthumous","name":"宋惠公"}'::jsonb,
  -830, 1, NULL, -800, 12, NULL,
  -9948, -9577, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r9-song-chunqiu', 'song-chunqiu', 'song-r9', '宋哀公',
  '哀公', NULL, '{"kind":"posthumous","name":"宋哀公"}'::jsonb,
  -800, 1, NULL, -800, 12, NULL,
  -9588, -9577, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r10-song-chunqiu', 'song-chunqiu', 'song-r10', '宋戴公',
  '戴公', NULL, '{"kind":"posthumous","name":"宋戴公"}'::jsonb,
  -799, 1, NULL, -766, 12, NULL,
  -9576, -9169, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r11-song-chunqiu', 'song-chunqiu', 'song-r11', '宋武公',
  '武公', NULL, '{"kind":"posthumous","name":"宋武公"}'::jsonb,
  -765, 1, NULL, -748, 12, NULL,
  -9168, -8953, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r12-song-chunqiu', 'song-chunqiu', 'song-r12', '宋宣公',
  '宣公', NULL, '{"kind":"posthumous","name":"宋宣公"}'::jsonb,
  -747, 1, NULL, -729, 12, NULL,
  -8952, -8725, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r13-song-chunqiu', 'song-chunqiu', 'song-r13', '宋穆公',
  '穆公', NULL, '{"kind":"posthumous","name":"宋穆公"}'::jsonb,
  -728, 1, NULL, -720, 12, NULL,
  -8724, -8617, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r14-song-chunqiu', 'song-chunqiu', 'song-r14', '宋殇公',
  '殇公', NULL, '{"kind":"posthumous","name":"宋殇公"}'::jsonb,
  -719, 1, NULL, -711, 12, NULL,
  -8616, -8509, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r15-song-chunqiu', 'song-chunqiu', 'song-r15', '宋庄公',
  '庄公', NULL, '{"kind":"posthumous","name":"宋庄公"}'::jsonb,
  -710, 1, NULL, -692, 12, NULL,
  -8508, -8281, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r16-song-chunqiu', 'song-chunqiu', 'song-r16', '宋湣公',
  '湣公', NULL, '{"kind":"posthumous","name":"宋湣公"}'::jsonb,
  -691, 1, NULL, -682, 12, NULL,
  -8280, -8161, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r17-song-chunqiu', 'song-chunqiu', 'song-r17', '宋公游',
  NULL, NULL, '{"kind":"regnal","name":"宋公游"}'::jsonb,
  -682, 1, NULL, -682, 12, NULL,
  -8172, -8161, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r18-song-chunqiu', 'song-chunqiu', 'song-r18', '宋桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"宋桓公"}'::jsonb,
  -681, 1, NULL, -651, 12, NULL,
  -8160, -7789, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r19-song-chunqiu', 'song-chunqiu', 'song-r19', '宋襄公',
  '襄公', NULL, '{"kind":"posthumous","name":"宋襄公"}'::jsonb,
  -650, 1, NULL, -637, 12, NULL,
  -7788, -7621, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r20-song-chunqiu', 'song-chunqiu', 'song-r20', '宋成公',
  '成公', NULL, '{"kind":"posthumous","name":"宋成公"}'::jsonb,
  -636, 1, NULL, -620, 12, NULL,
  -7620, -7417, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r21-song-chunqiu', 'song-chunqiu', 'song-r21', '宋公御',
  NULL, NULL, '{"kind":"regnal","name":"宋公御"}'::jsonb,
  -620, 1, NULL, -620, 12, NULL,
  -7428, -7417, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r22-song-chunqiu', 'song-chunqiu', 'song-r22', '宋昭公',
  '昭公', NULL, '{"kind":"posthumous","name":"宋昭公"}'::jsonb,
  -619, 1, NULL, -611, 12, NULL,
  -7416, -7309, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r23-song-chunqiu', 'song-chunqiu', 'song-r23', '宋文公',
  '文公', NULL, '{"kind":"posthumous","name":"宋文公"}'::jsonb,
  -610, 1, NULL, -589, 12, NULL,
  -7308, -7045, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r24-song-chunqiu', 'song-chunqiu', 'song-r24', '宋共公',
  '共公', NULL, '{"kind":"posthumous","name":"宋共公"}'::jsonb,
  -588, 1, NULL, -576, 12, NULL,
  -7044, -6889, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r25-song-chunqiu', 'song-chunqiu', 'song-r25', '宋平公',
  '平公', NULL, '{"kind":"posthumous","name":"宋平公"}'::jsonb,
  -575, 1, NULL, -532, 12, NULL,
  -6888, -6361, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r26-song-chunqiu', 'song-chunqiu', 'song-r26', '宋元公',
  '元公', NULL, '{"kind":"posthumous","name":"宋元公"}'::jsonb,
  -531, 1, NULL, -517, 12, NULL,
  -6360, -6181, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r27-song-chunqiu', 'song-chunqiu', 'song-r27', '宋景公',
  '景公', NULL, '{"kind":"posthumous","name":"宋景公"}'::jsonb,
  -516, 1, NULL, -469, 12, NULL,
  -6180, -5605, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r28-song-chunqiu', 'song-chunqiu', 'song-r28', '宋昭公',
  '昭公', NULL, '{"kind":"posthumous","name":"宋昭公"}'::jsonb,
  -468, 1, NULL, -404, 12, NULL,
  -5604, -4825, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r29-song-chunqiu', 'song-chunqiu', 'song-r29', '宋悼公',
  '悼公', NULL, '{"kind":"posthumous","name":"宋悼公"}'::jsonb,
  -403, 1, NULL, -385, 12, NULL,
  -4824, -4597, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r30-song-chunqiu', 'song-chunqiu', 'song-r30', '宋休公',
  '休公', NULL, '{"kind":"posthumous","name":"宋休公"}'::jsonb,
  -385, 1, NULL, -363, 12, NULL,
  -4608, -4333, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r31-song-chunqiu', 'song-chunqiu', 'song-r31', '宋桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"宋桓公"}'::jsonb,
  -362, 1, NULL, -356, 12, NULL,
  -4332, -4249, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r32-song-chunqiu', 'song-chunqiu', 'song-r32', '宋剔成君',
  NULL, NULL, '{"kind":"regnal","name":"宋剔成君"}'::jsonb,
  -355, 1, NULL, -329, 12, NULL,
  -4248, -3925, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-song-r33-song-chunqiu', 'song-chunqiu', 'song-r33', '宋康王',
  '康王', NULL, '{"kind":"posthumous","name":"宋康王"}'::jsonb,
  -328, 1, NULL, -286, 12, NULL,
  -3924, -3409, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-bo-qin-lu-chunqiu', 'lu-chunqiu', 'bo-qin', '伯禽',
  NULL, NULL, '{"kind":"regnal","name":"伯禽"}'::jsonb,
  -1043, 1, NULL, -998, 12, NULL,
  -12504, -11953, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r1-lu-chunqiu', 'lu-chunqiu', 'lu-r1', '鲁考公',
  '考公', NULL, '{"kind":"posthumous","name":"鲁考公"}'::jsonb,
  -997, 1, NULL, -994, 12, NULL,
  -11952, -11905, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r2-lu-chunqiu', 'lu-chunqiu', 'lu-r2', '鲁炀公',
  '炀公', NULL, '{"kind":"posthumous","name":"鲁炀公"}'::jsonb,
  -993, 1, NULL, -988, 12, NULL,
  -11904, -11833, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r3-lu-chunqiu', 'lu-chunqiu', 'lu-r3', '鲁幽公',
  '幽公', NULL, '{"kind":"posthumous","name":"鲁幽公"}'::jsonb,
  -987, 1, NULL, -974, 12, NULL,
  -11832, -11665, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r4-lu-chunqiu', 'lu-chunqiu', 'lu-r4', '鲁魏公',
  '魏公', NULL, '{"kind":"posthumous","name":"鲁魏公"}'::jsonb,
  -973, 1, NULL, -924, 12, NULL,
  -11664, -11065, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r5-lu-chunqiu', 'lu-chunqiu', 'lu-r5', '鲁厉公',
  '厉公', NULL, '{"kind":"posthumous","name":"鲁厉公"}'::jsonb,
  -923, 1, NULL, -887, 12, NULL,
  -11064, -10621, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r6-lu-chunqiu', 'lu-chunqiu', 'lu-r6', '鲁献公',
  '献公', NULL, '{"kind":"posthumous","name":"鲁献公"}'::jsonb,
  -886, 1, NULL, -855, 12, NULL,
  -10620, -10237, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r7-lu-chunqiu', 'lu-chunqiu', 'lu-r7', '鲁真公',
  '真公', NULL, '{"kind":"posthumous","name":"鲁真公"}'::jsonb,
  -854, 1, NULL, -825, 12, NULL,
  -10236, -9877, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r8-lu-chunqiu', 'lu-chunqiu', 'lu-r8', '鲁武公',
  '武公', NULL, '{"kind":"posthumous","name":"鲁武公"}'::jsonb,
  -824, 1, NULL, -816, 12, NULL,
  -9876, -9769, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r9-lu-chunqiu', 'lu-chunqiu', 'lu-r9', '鲁懿公',
  '懿公', NULL, '{"kind":"posthumous","name":"鲁懿公"}'::jsonb,
  -815, 1, NULL, -807, 12, NULL,
  -9768, -9661, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r10-lu-chunqiu', 'lu-chunqiu', 'lu-r10', '鲁公伯御',
  NULL, NULL, '{"kind":"regnal","name":"鲁公伯御"}'::jsonb,
  -806, 1, NULL, -796, 12, NULL,
  -9660, -9529, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r11-lu-chunqiu', 'lu-chunqiu', 'lu-r11', '鲁孝公',
  '孝公', NULL, '{"kind":"posthumous","name":"鲁孝公"}'::jsonb,
  -795, 1, NULL, -769, 12, NULL,
  -9528, -9205, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r12-lu-chunqiu', 'lu-chunqiu', 'lu-r12', '鲁惠公',
  '惠公', NULL, '{"kind":"posthumous","name":"鲁惠公"}'::jsonb,
  -768, 1, NULL, -723, 12, NULL,
  -9204, -8653, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r13-lu-chunqiu', 'lu-chunqiu', 'lu-r13', '鲁隐公',
  '隐公', NULL, '{"kind":"posthumous","name":"鲁隐公"}'::jsonb,
  -722, 1, NULL, -712, 12, NULL,
  -8652, -8521, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r14-lu-chunqiu', 'lu-chunqiu', 'lu-r14', '鲁桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"鲁桓公"}'::jsonb,
  -711, 1, NULL, -694, 12, NULL,
  -8520, -8305, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r15-lu-chunqiu', 'lu-chunqiu', 'lu-r15', '鲁庄公',
  '庄公', NULL, '{"kind":"posthumous","name":"鲁庄公"}'::jsonb,
  -693, 1, NULL, -662, 12, NULL,
  -8304, -7921, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r16-lu-chunqiu', 'lu-chunqiu', 'lu-r16', '鲁闵公',
  '闵公', NULL, '{"kind":"posthumous","name":"鲁闵公"}'::jsonb,
  -661, 1, NULL, -660, 12, NULL,
  -7920, -7897, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r17-lu-chunqiu', 'lu-chunqiu', 'lu-r17', '鲁釐公',
  '釐公', NULL, '{"kind":"posthumous","name":"鲁釐公"}'::jsonb,
  -659, 1, NULL, -627, 12, NULL,
  -7896, -7501, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r18-lu-chunqiu', 'lu-chunqiu', 'lu-r18', '鲁文公',
  '文公', NULL, '{"kind":"posthumous","name":"鲁文公"}'::jsonb,
  -626, 1, NULL, -609, 12, NULL,
  -7500, -7285, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r19-lu-chunqiu', 'lu-chunqiu', 'lu-r19', '鲁宣公',
  '宣公', NULL, '{"kind":"posthumous","name":"鲁宣公"}'::jsonb,
  -608, 1, NULL, -591, 12, NULL,
  -7284, -7069, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r20-lu-chunqiu', 'lu-chunqiu', 'lu-r20', '鲁成公',
  '成公', NULL, '{"kind":"posthumous","name":"鲁成公"}'::jsonb,
  -590, 1, NULL, -573, 12, NULL,
  -7068, -6853, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r21-lu-chunqiu', 'lu-chunqiu', 'lu-r21', '鲁襄公',
  '襄公', NULL, '{"kind":"posthumous","name":"鲁襄公"}'::jsonb,
  -572, 1, NULL, -542, 12, NULL,
  -6852, -6481, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r22-lu-chunqiu', 'lu-chunqiu', 'lu-r22', '鲁君野',
  NULL, NULL, '{"kind":"regnal","name":"鲁君野"}'::jsonb,
  -542, 1, NULL, -542, 12, NULL,
  -6492, -6481, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r23-lu-chunqiu', 'lu-chunqiu', 'lu-r23', '鲁昭公',
  '昭公', NULL, '{"kind":"posthumous","name":"鲁昭公"}'::jsonb,
  -541, 1, NULL, -510, 12, NULL,
  -6480, -6097, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r24-lu-chunqiu', 'lu-chunqiu', 'lu-r24', '鲁定公',
  '定公', NULL, '{"kind":"posthumous","name":"鲁定公"}'::jsonb,
  -509, 1, NULL, -495, 12, NULL,
  -6096, -5917, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r25-lu-chunqiu', 'lu-chunqiu', 'lu-r25', '鲁哀公',
  '哀公', NULL, '{"kind":"posthumous","name":"鲁哀公"}'::jsonb,
  -494, 1, NULL, -468, 12, NULL,
  -5916, -5593, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r26-lu-chunqiu', 'lu-chunqiu', 'lu-r26', '鲁悼公',
  '悼公', NULL, '{"kind":"posthumous","name":"鲁悼公"}'::jsonb,
  -467, 1, NULL, -437, 12, NULL,
  -5592, -5221, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r27-lu-chunqiu', 'lu-chunqiu', 'lu-r27', '鲁元公',
  '元公', NULL, '{"kind":"posthumous","name":"鲁元公"}'::jsonb,
  -436, 1, NULL, -416, 12, NULL,
  -5220, -4969, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r28-lu-chunqiu', 'lu-chunqiu', 'lu-r28', '鲁穆公',
  '穆公', NULL, '{"kind":"posthumous","name":"鲁穆公"}'::jsonb,
  -415, 1, NULL, -383, 12, NULL,
  -4968, -4573, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r29-lu-chunqiu', 'lu-chunqiu', 'lu-r29', '鲁共公',
  '共公', NULL, '{"kind":"posthumous","name":"鲁共公"}'::jsonb,
  -382, 1, NULL, -353, 12, NULL,
  -4572, -4213, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r30-lu-chunqiu', 'lu-chunqiu', 'lu-r30', '鲁康公',
  '康公', NULL, '{"kind":"posthumous","name":"鲁康公"}'::jsonb,
  -352, 1, NULL, -344, 12, NULL,
  -4212, -4105, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r31-lu-chunqiu', 'lu-chunqiu', 'lu-r31', '鲁景公',
  '景公', NULL, '{"kind":"posthumous","name":"鲁景公"}'::jsonb,
  -343, 1, NULL, -323, 12, NULL,
  -4104, -3853, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r32-lu-chunqiu', 'lu-chunqiu', 'lu-r32', '鲁平公',
  '平公', NULL, '{"kind":"posthumous","name":"鲁平公"}'::jsonb,
  -322, 1, NULL, -303, 12, NULL,
  -3852, -3613, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r33-lu-chunqiu', 'lu-chunqiu', 'lu-r33', '鲁文公',
  '文公', NULL, '{"kind":"posthumous","name":"鲁文公"}'::jsonb,
  -302, 1, NULL, -280, 12, NULL,
  -3612, -3337, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-lu-r34-lu-chunqiu', 'lu-chunqiu', 'lu-r34', '鲁顷公',
  '顷公', NULL, '{"kind":"posthumous","name":"鲁顷公"}'::jsonb,
  -279, 1, NULL, -256, 12, NULL,
  -3336, -3049, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r0-wei-weiguo', 'wei-weiguo', 'weiguo-r0', '卫康叔',
  '康叔', NULL, '{"kind":"posthumous","name":"卫康叔"}'::jsonb,
  -1040, 1, NULL, -1017, 12, NULL,
  -12468, -12181, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r1-wei-weiguo', 'wei-weiguo', 'weiguo-r1', '卫康伯',
  '康伯', NULL, '{"kind":"posthumous","name":"卫康伯"}'::jsonb,
  -1016, 1, NULL, -992, 12, NULL,
  -12180, -11881, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r2-wei-weiguo', 'wei-weiguo', 'weiguo-r2', '卫考伯',
  '考伯', NULL, '{"kind":"posthumous","name":"卫考伯"}'::jsonb,
  -991, 1, NULL, -967, 12, NULL,
  -11880, -11581, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r3-wei-weiguo', 'wei-weiguo', 'weiguo-r3', '卫嗣伯',
  '嗣伯', NULL, '{"kind":"posthumous","name":"卫嗣伯"}'::jsonb,
  -966, 1, NULL, -942, 12, NULL,
  -11580, -11281, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r4-wei-weiguo', 'wei-weiguo', 'weiguo-r4', '卫疌伯',
  '疌伯', NULL, '{"kind":"posthumous","name":"卫疌伯"}'::jsonb,
  -941, 1, NULL, -917, 12, NULL,
  -11280, -10981, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r5-wei-weiguo', 'wei-weiguo', 'weiguo-r5', '卫靖伯',
  '靖伯', NULL, '{"kind":"posthumous","name":"卫靖伯"}'::jsonb,
  -916, 1, NULL, -892, 12, NULL,
  -10980, -10681, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r6-wei-weiguo', 'wei-weiguo', 'weiguo-r6', '卫贞伯',
  '贞伯', NULL, '{"kind":"posthumous","name":"卫贞伯"}'::jsonb,
  -891, 1, NULL, -867, 12, NULL,
  -10680, -10381, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r7-wei-weiguo', 'wei-weiguo', 'weiguo-r7', '卫顷侯',
  '顷侯', NULL, '{"kind":"posthumous","name":"卫顷侯"}'::jsonb,
  -866, 1, NULL, -855, 12, NULL,
  -10380, -10237, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r8-wei-weiguo', 'wei-weiguo', 'weiguo-r8', '卫釐侯',
  '釐侯', NULL, '{"kind":"posthumous","name":"卫釐侯"}'::jsonb,
  -854, 1, NULL, -813, 12, NULL,
  -10236, -9733, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r9-wei-weiguo', 'wei-weiguo', 'weiguo-r9', '卫共伯',
  '共伯', NULL, '{"kind":"posthumous","name":"卫共伯"}'::jsonb,
  -813, 1, NULL, -813, 12, NULL,
  -9744, -9733, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r10-wei-weiguo', 'wei-weiguo', 'weiguo-r10', '卫武公',
  '武公', NULL, '{"kind":"posthumous","name":"卫武公"}'::jsonb,
  -812, 1, NULL, -758, 12, NULL,
  -9732, -9073, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r11-wei-weiguo', 'wei-weiguo', 'weiguo-r11', '卫庄公',
  '庄公', NULL, '{"kind":"posthumous","name":"卫庄公"}'::jsonb,
  -757, 1, NULL, -735, 12, NULL,
  -9072, -8797, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r12-wei-weiguo', 'wei-weiguo', 'weiguo-r12', '卫桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"卫桓公"}'::jsonb,
  -734, 1, NULL, -719, 12, NULL,
  -8796, -8605, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r13-wei-weiguo', 'wei-weiguo', 'weiguo-r13', '卫州吁',
  NULL, NULL, '{"kind":"regnal","name":"卫州吁"}'::jsonb,
  -719, 1, NULL, -719, 12, NULL,
  -8616, -8605, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r14-wei-weiguo', 'wei-weiguo', 'weiguo-r14', '卫宣公',
  '宣公', NULL, '{"kind":"posthumous","name":"卫宣公"}'::jsonb,
  -718, 1, NULL, -700, 12, NULL,
  -8604, -8377, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r15-wei-weiguo', 'wei-weiguo', 'weiguo-r15', '卫惠公',
  '惠公', NULL, '{"kind":"posthumous","name":"卫惠公"}'::jsonb,
  -699, 1, NULL, -696, 12, NULL,
  -8376, -8329, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r16-wei-weiguo', 'wei-weiguo', 'weiguo-r16', '卫黔牟',
  NULL, NULL, '{"kind":"regnal","name":"卫黔牟"}'::jsonb,
  -696, 1, NULL, -688, 12, NULL,
  -8340, -8233, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r17-wei-weiguo', 'wei-weiguo', 'weiguo-r17', '卫惠公',
  '惠公', NULL, '{"kind":"posthumous","name":"卫惠公"}'::jsonb,
  -688, 1, NULL, -669, 12, NULL,
  -8244, -8005, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r18-wei-weiguo', 'wei-weiguo', 'weiguo-r18', '卫懿公',
  '懿公', NULL, '{"kind":"posthumous","name":"卫懿公"}'::jsonb,
  -668, 1, NULL, -660, 12, NULL,
  -8004, -7897, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r19-wei-weiguo', 'wei-weiguo', 'weiguo-r19', '卫戴公',
  '戴公', NULL, '{"kind":"posthumous","name":"卫戴公"}'::jsonb,
  -660, 1, NULL, -660, 12, NULL,
  -7908, -7897, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r20-wei-weiguo', 'wei-weiguo', 'weiguo-r20', '卫文公',
  '文公', NULL, '{"kind":"posthumous","name":"卫文公"}'::jsonb,
  -659, 1, NULL, -635, 12, NULL,
  -7896, -7597, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r21-wei-weiguo', 'wei-weiguo', 'weiguo-r21', '卫成公',
  '成公', NULL, '{"kind":"posthumous","name":"卫成公"}'::jsonb,
  -634, 1, NULL, -600, 12, NULL,
  -7596, -7177, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r22-wei-weiguo', 'wei-weiguo', 'weiguo-r22', '卫君瑕',
  NULL, NULL, '{"kind":"regnal","name":"卫君瑕"}'::jsonb,
  -632, 1, NULL, -632, 12, NULL,
  -7572, -7561, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r23-wei-weiguo', 'wei-weiguo', 'weiguo-r23', '卫穆公',
  '穆公', NULL, '{"kind":"posthumous","name":"卫穆公"}'::jsonb,
  -599, 1, NULL, -589, 12, NULL,
  -7176, -7045, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r24-wei-weiguo', 'wei-weiguo', 'weiguo-r24', '卫定公',
  '定公', NULL, '{"kind":"posthumous","name":"卫定公"}'::jsonb,
  -588, 1, NULL, -577, 12, NULL,
  -7044, -6901, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r25-wei-weiguo', 'wei-weiguo', 'weiguo-r25', '卫献公',
  '献公', NULL, '{"kind":"posthumous","name":"卫献公"}'::jsonb,
  -576, 1, NULL, -559, 12, NULL,
  -6900, -6685, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r26-wei-weiguo', 'wei-weiguo', 'weiguo-r26', '卫殇公',
  '殇公', NULL, '{"kind":"posthumous","name":"卫殇公"}'::jsonb,
  -558, 1, NULL, -547, 12, NULL,
  -6684, -6541, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r27-wei-weiguo', 'wei-weiguo', 'weiguo-r27', '卫献公',
  '献公', NULL, '{"kind":"posthumous","name":"卫献公"}'::jsonb,
  -546, 1, NULL, -544, 12, NULL,
  -6540, -6505, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r28-wei-weiguo', 'wei-weiguo', 'weiguo-r28', '卫襄公',
  '襄公', NULL, '{"kind":"posthumous","name":"卫襄公"}'::jsonb,
  -543, 1, NULL, -535, 12, NULL,
  -6504, -6397, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r29-wei-weiguo', 'wei-weiguo', 'weiguo-r29', '卫灵公',
  '灵公', NULL, '{"kind":"posthumous","name":"卫灵公"}'::jsonb,
  -534, 1, NULL, -493, 12, NULL,
  -6396, -5893, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r30-wei-weiguo', 'wei-weiguo', 'weiguo-r30', '卫出公',
  '出公', NULL, '{"kind":"posthumous","name":"卫出公"}'::jsonb,
  -492, 1, NULL, -480, 12, NULL,
  -5892, -5737, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r31-wei-weiguo', 'wei-weiguo', 'weiguo-r31', '卫庄公',
  '庄公', NULL, '{"kind":"posthumous","name":"卫庄公"}'::jsonb,
  -480, 1, NULL, -478, 12, NULL,
  -5748, -5713, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r32-wei-weiguo', 'wei-weiguo', 'weiguo-r32', '卫斑师',
  NULL, NULL, '{"kind":"regnal","name":"卫斑师"}'::jsonb,
  -478, 1, NULL, -478, 12, NULL,
  -5724, -5713, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r33-wei-weiguo', 'wei-weiguo', 'weiguo-r33', '卫君起',
  NULL, NULL, '{"kind":"regnal","name":"卫君起"}'::jsonb,
  -477, 1, NULL, -477, 12, NULL,
  -5712, -5701, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r34-wei-weiguo', 'wei-weiguo', 'weiguo-r34', '卫出公',
  '出公', NULL, '{"kind":"posthumous","name":"卫出公"}'::jsonb,
  -476, 1, NULL, -470, 12, NULL,
  -5700, -5617, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r35-wei-weiguo', 'wei-weiguo', 'weiguo-r35', '卫悼公',
  '悼公', NULL, '{"kind":"posthumous","name":"卫悼公"}'::jsonb,
  -469, 1, NULL, -465, 12, NULL,
  -5616, -5557, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r36-wei-weiguo', 'wei-weiguo', 'weiguo-r36', '卫敬公',
  '敬公', NULL, '{"kind":"posthumous","name":"卫敬公"}'::jsonb,
  -464, 1, NULL, -432, 12, NULL,
  -5556, -5161, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r37-wei-weiguo', 'wei-weiguo', 'weiguo-r37', '卫昭公',
  '昭公', NULL, '{"kind":"posthumous","name":"卫昭公"}'::jsonb,
  -431, 1, NULL, -426, 12, NULL,
  -5160, -5089, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r38-wei-weiguo', 'wei-weiguo', 'weiguo-r38', '卫怀公',
  '怀公', NULL, '{"kind":"posthumous","name":"卫怀公"}'::jsonb,
  -425, 1, NULL, -415, 12, NULL,
  -5088, -4957, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r39-wei-weiguo', 'wei-weiguo', 'weiguo-r39', '卫慎公',
  '慎公', NULL, '{"kind":"posthumous","name":"卫慎公"}'::jsonb,
  -414, 1, NULL, -383, 12, NULL,
  -4956, -4573, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r40-wei-weiguo', 'wei-weiguo', 'weiguo-r40', '卫声公',
  '声公', NULL, '{"kind":"posthumous","name":"卫声公"}'::jsonb,
  -382, 1, NULL, -372, 12, NULL,
  -4572, -4441, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r41-wei-weiguo', 'wei-weiguo', 'weiguo-r41', '卫成侯',
  '成侯', NULL, '{"kind":"posthumous","name":"卫成侯"}'::jsonb,
  -371, 1, NULL, -343, 12, NULL,
  -4440, -4093, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r42-wei-weiguo', 'wei-weiguo', 'weiguo-r42', '卫平侯',
  '平侯', NULL, '{"kind":"posthumous","name":"卫平侯"}'::jsonb,
  -342, 1, NULL, -335, 12, NULL,
  -4092, -3997, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r43-wei-weiguo', 'wei-weiguo', 'weiguo-r43', '卫嗣君',
  NULL, NULL, '{"kind":"regnal","name":"卫嗣君"}'::jsonb,
  -334, 1, NULL, -293, 12, NULL,
  -3996, -3493, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r44-wei-weiguo', 'wei-weiguo', 'weiguo-r44', '卫怀君',
  NULL, NULL, '{"kind":"regnal","name":"卫怀君"}'::jsonb,
  -292, 1, NULL, -254, 12, NULL,
  -3492, -3025, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r45-wei-weiguo', 'wei-weiguo', 'weiguo-r45', '卫元君',
  NULL, NULL, '{"kind":"regnal","name":"卫元君"}'::jsonb,
  -254, 1, NULL, -230, 12, NULL,
  -3036, -2737, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-weiguo-r46-wei-weiguo', 'wei-weiguo', 'weiguo-r46', '卫君角',
  NULL, NULL, '{"kind":"regnal","name":"卫君角"}'::jsonb,
  -241, 1, NULL, -209, 12, NULL,
  -2880, -2485, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r0-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r0', '郑桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"郑桓公"}'::jsonb,
  -806, 1, NULL, -771, 12, NULL,
  -9660, -9229, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r1-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r1', '郑武公',
  '武公', NULL, '{"kind":"posthumous","name":"郑武公"}'::jsonb,
  -770, 1, NULL, -744, 12, NULL,
  -9228, -8905, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r2-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r2', '郑庄公',
  '庄公', NULL, '{"kind":"posthumous","name":"郑庄公"}'::jsonb,
  -743, 1, NULL, -701, 12, NULL,
  -8904, -8389, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r3-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r3', '郑昭公',
  '昭公', NULL, '{"kind":"posthumous","name":"郑昭公"}'::jsonb,
  -700, 1, NULL, -700, 12, NULL,
  -8388, -8377, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r4-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r4', '郑厉公',
  '厉公', NULL, '{"kind":"posthumous","name":"郑厉公"}'::jsonb,
  -700, 1, NULL, -697, 12, NULL,
  -8388, -8341, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r5-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r5', '郑昭公',
  '昭公', NULL, '{"kind":"posthumous","name":"郑昭公"}'::jsonb,
  -696, 1, NULL, -695, 12, NULL,
  -8340, -8317, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r6-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r6', '郑子亹',
  NULL, NULL, '{"kind":"regnal","name":"郑子亹"}'::jsonb,
  -694, 1, NULL, -694, 12, NULL,
  -8316, -8305, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r7-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r7', '郑子婴',
  NULL, NULL, '{"kind":"regnal","name":"郑子婴"}'::jsonb,
  -693, 1, NULL, -680, 12, NULL,
  -8304, -8137, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r8-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r8', '郑厉公',
  '厉公', NULL, '{"kind":"posthumous","name":"郑厉公"}'::jsonb,
  -679, 1, NULL, -673, 12, NULL,
  -8136, -8053, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r9-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r9', '郑文公',
  '文公', NULL, '{"kind":"posthumous","name":"郑文公"}'::jsonb,
  -672, 1, NULL, -628, 12, NULL,
  -8052, -7513, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r10-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r10', '郑穆公',
  '穆公', NULL, '{"kind":"posthumous","name":"郑穆公"}'::jsonb,
  -627, 1, NULL, -606, 12, NULL,
  -7512, -7249, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r11-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r11', '郑灵公',
  '灵公', NULL, '{"kind":"posthumous","name":"郑灵公"}'::jsonb,
  -605, 1, NULL, -605, 12, NULL,
  -7248, -7237, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r12-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r12', '郑襄公',
  '襄公', NULL, '{"kind":"posthumous","name":"郑襄公"}'::jsonb,
  -604, 1, NULL, -587, 12, NULL,
  -7236, -7021, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r13-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r13', '郑悼公',
  '悼公', NULL, '{"kind":"posthumous","name":"郑悼公"}'::jsonb,
  -586, 1, NULL, -585, 12, NULL,
  -7020, -6997, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r14-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r14', '郑成公',
  '成公', NULL, '{"kind":"posthumous","name":"郑成公"}'::jsonb,
  -584, 1, NULL, -571, 12, NULL,
  -6996, -6829, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r15-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r15', '郑釐公',
  '釐公', NULL, '{"kind":"posthumous","name":"郑釐公"}'::jsonb,
  -570, 1, NULL, -566, 12, NULL,
  -6828, -6769, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r16-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r16', '郑简公',
  '简公', NULL, '{"kind":"posthumous","name":"郑简公"}'::jsonb,
  -565, 1, NULL, -530, 12, NULL,
  -6768, -6337, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r17-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r17', '郑定公',
  '定公', NULL, '{"kind":"posthumous","name":"郑定公"}'::jsonb,
  -529, 1, NULL, -514, 12, NULL,
  -6336, -6145, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r18-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r18', '郑献公',
  '献公', NULL, '{"kind":"posthumous","name":"郑献公"}'::jsonb,
  -513, 1, NULL, -501, 12, NULL,
  -6144, -5989, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r19-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r19', '郑声公',
  '声公', NULL, '{"kind":"posthumous","name":"郑声公"}'::jsonb,
  -500, 1, NULL, -463, 12, NULL,
  -5988, -5533, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r20-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r20', '郑哀公',
  '哀公', NULL, '{"kind":"posthumous","name":"郑哀公"}'::jsonb,
  -462, 1, NULL, -455, 12, NULL,
  -5532, -5437, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r21-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r21', '郑共公',
  '共公', NULL, '{"kind":"posthumous","name":"郑共公"}'::jsonb,
  -454, 1, NULL, -424, 12, NULL,
  -5436, -5065, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r22-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r22', '郑幽公',
  '幽公', NULL, '{"kind":"posthumous","name":"郑幽公"}'::jsonb,
  -423, 1, NULL, -423, 12, NULL,
  -5064, -5053, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r23-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r23', '郑𦈡公',
  '𦈡公', NULL, '{"kind":"posthumous","name":"郑𦈡公"}'::jsonb,
  -422, 1, NULL, -396, 12, NULL,
  -5052, -4729, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zheng-r24-zheng-chunqiu', 'zheng-chunqiu', 'zheng-r24', '郑康公',
  '康公', NULL, '{"kind":"posthumous","name":"郑康公"}'::jsonb,
  -395, 1, NULL, -375, 12, NULL,
  -4728, -4477, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r0-cao-chunqiu', 'cao-chunqiu', 'cao-r0', '曹叔振铎',
  NULL, NULL, '{"kind":"regnal","name":"曹叔振铎"}'::jsonb,
  -1046, 1, NULL, -1011, 12, NULL,
  -12540, -12109, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r1-cao-chunqiu', 'cao-chunqiu', 'cao-r1', '曹太伯',
  '太伯', NULL, '{"kind":"posthumous","name":"曹太伯"}'::jsonb,
  -1010, 1, NULL, -975, 12, NULL,
  -12108, -11677, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r2-cao-chunqiu', 'cao-chunqiu', 'cao-r2', '曹仲君',
  NULL, NULL, '{"kind":"regnal","name":"曹仲君"}'::jsonb,
  -974, 1, NULL, -939, 12, NULL,
  -11676, -11245, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r3-cao-chunqiu', 'cao-chunqiu', 'cao-r3', '曹宫伯',
  '宫伯', NULL, '{"kind":"posthumous","name":"曹宫伯"}'::jsonb,
  -938, 1, NULL, -903, 12, NULL,
  -11244, -10813, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r4-cao-chunqiu', 'cao-chunqiu', 'cao-r4', '曹孝伯',
  '孝伯', NULL, '{"kind":"posthumous","name":"曹孝伯"}'::jsonb,
  -902, 1, NULL, -866, 12, NULL,
  -10812, -10369, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r5-cao-chunqiu', 'cao-chunqiu', 'cao-r5', '曹夷伯',
  '夷伯', NULL, '{"kind":"posthumous","name":"曹夷伯"}'::jsonb,
  -865, 1, NULL, -835, 12, NULL,
  -10368, -9997, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r6-cao-chunqiu', 'cao-chunqiu', 'cao-r6', '曹幽伯',
  '幽伯', NULL, '{"kind":"posthumous","name":"曹幽伯"}'::jsonb,
  -835, 1, NULL, -826, 12, NULL,
  -10008, -9889, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r7-cao-chunqiu', 'cao-chunqiu', 'cao-r7', '曹戴伯',
  '戴伯', NULL, '{"kind":"posthumous","name":"曹戴伯"}'::jsonb,
  -826, 1, NULL, -796, 12, NULL,
  -9900, -9529, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r8-cao-chunqiu', 'cao-chunqiu', 'cao-r8', '曹惠伯',
  '惠伯', NULL, '{"kind":"posthumous","name":"曹惠伯"}'::jsonb,
  -796, 1, NULL, -760, 12, NULL,
  -9540, -9097, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r9-cao-chunqiu', 'cao-chunqiu', 'cao-r9', '曹废伯',
  '废伯', NULL, '{"kind":"posthumous","name":"曹废伯"}'::jsonb,
  -760, 1, NULL, -760, 12, NULL,
  -9108, -9097, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r10-cao-chunqiu', 'cao-chunqiu', 'cao-r10', '曹穆公',
  '穆公', NULL, '{"kind":"posthumous","name":"曹穆公"}'::jsonb,
  -760, 1, NULL, -757, 12, NULL,
  -9108, -9061, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r11-cao-chunqiu', 'cao-chunqiu', 'cao-r11', '曹桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"曹桓公"}'::jsonb,
  -757, 1, NULL, -702, 12, NULL,
  -9072, -8401, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r12-cao-chunqiu', 'cao-chunqiu', 'cao-r12', '曹庄公',
  '庄公', NULL, '{"kind":"posthumous","name":"曹庄公"}'::jsonb,
  -702, 1, NULL, -671, 12, NULL,
  -8412, -8029, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r13-cao-chunqiu', 'cao-chunqiu', 'cao-r13', '曹釐公',
  '釐公', NULL, '{"kind":"posthumous","name":"曹釐公"}'::jsonb,
  -671, 1, NULL, -662, 12, NULL,
  -8040, -7921, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r14-cao-chunqiu', 'cao-chunqiu', 'cao-r14', '曹昭公',
  '昭公', NULL, '{"kind":"posthumous","name":"曹昭公"}'::jsonb,
  -662, 1, NULL, -653, 12, NULL,
  -7932, -7813, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r15-cao-chunqiu', 'cao-chunqiu', 'cao-r15', '曹共公',
  '共公', NULL, '{"kind":"posthumous","name":"曹共公"}'::jsonb,
  -653, 1, NULL, -618, 12, NULL,
  -7824, -7393, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r16-cao-chunqiu', 'cao-chunqiu', 'cao-r16', '曹文公',
  '文公', NULL, '{"kind":"posthumous","name":"曹文公"}'::jsonb,
  -618, 1, NULL, -595, 12, NULL,
  -7404, -7117, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r17-cao-chunqiu', 'cao-chunqiu', 'cao-r17', '曹宣公',
  '宣公', NULL, '{"kind":"posthumous","name":"曹宣公"}'::jsonb,
  -595, 1, NULL, -578, 12, NULL,
  -7128, -6913, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r18-cao-chunqiu', 'cao-chunqiu', 'cao-r18', '曹成公',
  '成公', NULL, '{"kind":"posthumous","name":"曹成公"}'::jsonb,
  -578, 1, NULL, -555, 12, NULL,
  -6924, -6637, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r19-cao-chunqiu', 'cao-chunqiu', 'cao-r19', '曹武公',
  '武公', NULL, '{"kind":"posthumous","name":"曹武公"}'::jsonb,
  -555, 1, NULL, -528, 12, NULL,
  -6648, -6313, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r20-cao-chunqiu', 'cao-chunqiu', 'cao-r20', '曹平公',
  '平公', NULL, '{"kind":"posthumous","name":"曹平公"}'::jsonb,
  -528, 1, NULL, -524, 12, NULL,
  -6324, -6265, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r21-cao-chunqiu', 'cao-chunqiu', 'cao-r21', '曹悼公',
  '悼公', NULL, '{"kind":"posthumous","name":"曹悼公"}'::jsonb,
  -524, 1, NULL, -515, 12, NULL,
  -6276, -6157, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r22-cao-chunqiu', 'cao-chunqiu', 'cao-r22', '曹声公',
  '声公', NULL, '{"kind":"posthumous","name":"曹声公"}'::jsonb,
  -515, 1, NULL, -510, 12, NULL,
  -6168, -6097, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r23-cao-chunqiu', 'cao-chunqiu', 'cao-r23', '曹隐公',
  '隐公', NULL, '{"kind":"posthumous","name":"曹隐公"}'::jsonb,
  -510, 1, NULL, -506, 12, NULL,
  -6108, -6049, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r24-cao-chunqiu', 'cao-chunqiu', 'cao-r24', '曹靖公',
  '靖公', NULL, '{"kind":"posthumous","name":"曹靖公"}'::jsonb,
  -506, 1, NULL, -502, 12, NULL,
  -6060, -6001, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-cao-r25-cao-chunqiu', 'cao-chunqiu', 'cao-r25', '曹伯阳',
  NULL, NULL, '{"kind":"regnal","name":"曹伯阳"}'::jsonb,
  -502, 1, NULL, -487, 12, NULL,
  -6012, -5821, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wu-r0-wu-chunqiu', 'wu-chunqiu', 'wu-r0', '吴王寿梦',
  NULL, NULL, '{"kind":"regnal","name":"吴王寿梦"}'::jsonb,
  -585, 1, NULL, -561, 12, NULL,
  -7008, -6709, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wu-r1-wu-chunqiu', 'wu-chunqiu', 'wu-r1', '吴王诸樊',
  NULL, NULL, '{"kind":"regnal","name":"吴王诸樊"}'::jsonb,
  -560, 1, NULL, -548, 12, NULL,
  -6708, -6553, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wu-r2-wu-chunqiu', 'wu-chunqiu', 'wu-r2', '吴王余祭',
  NULL, NULL, '{"kind":"regnal","name":"吴王余祭"}'::jsonb,
  -547, 1, NULL, -544, 12, NULL,
  -6552, -6505, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wu-r3-wu-chunqiu', 'wu-chunqiu', 'wu-r3', '吴王余昧',
  NULL, NULL, '{"kind":"regnal","name":"吴王余昧"}'::jsonb,
  -543, 1, NULL, -527, 12, NULL,
  -6504, -6301, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wu-r4-wu-chunqiu', 'wu-chunqiu', 'wu-r4', '吴王僚',
  NULL, NULL, '{"kind":"regnal","name":"吴王僚"}'::jsonb,
  -526, 1, NULL, -515, 12, NULL,
  -6300, -6157, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-helu-wu-chunqiu', 'wu-chunqiu', 'helu', '吴王阖闾',
  NULL, NULL, '{"kind":"regnal","name":"吴王阖闾"}'::jsonb,
  -514, 1, NULL, -496, 12, NULL,
  -6156, -5929, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-fu-chai-wu-chunqiu', 'wu-chunqiu', 'fu-chai', '吴王夫差',
  NULL, NULL, '{"kind":"regnal","name":"吴王夫差"}'::jsonb,
  -495, 1, NULL, -473, 12, NULL,
  -5928, -5653, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r0-yue-chunqiu', 'yue-chunqiu', 'yue-r0', '越侯无余',
  NULL, NULL, '{"kind":"regnal","name":"越侯无余"}'::jsonb,
  -565, 1, NULL, -553, 12, NULL,
  -6768, -6613, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r1-yue-chunqiu', 'yue-chunqiu', 'yue-r1', '越侯无壬',
  NULL, NULL, '{"kind":"regnal","name":"越侯无壬"}'::jsonb,
  -552, 1, NULL, -539, 12, NULL,
  -6612, -6445, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r2-yue-chunqiu', 'yue-chunqiu', 'yue-r2', '越侯无瞫',
  NULL, NULL, '{"kind":"regnal","name":"越侯无瞫"}'::jsonb,
  -538, 1, NULL, -525, 12, NULL,
  -6444, -6277, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r3-yue-chunqiu', 'yue-chunqiu', 'yue-r3', '越侯夫谭',
  NULL, NULL, '{"kind":"regnal","name":"越侯夫谭"}'::jsonb,
  -524, 1, NULL, -511, 12, NULL,
  -6276, -6109, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r4-yue-chunqiu', 'yue-chunqiu', 'yue-r4', '越侯允常',
  NULL, NULL, '{"kind":"regnal","name":"越侯允常"}'::jsonb,
  -510, 1, NULL, -497, 12, NULL,
  -6108, -5941, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-gou-jian-yue-chunqiu', 'yue-chunqiu', 'gou-jian', '越王勾践',
  NULL, NULL, '{"kind":"regnal","name":"越王勾践"}'::jsonb,
  -496, 1, NULL, -464, 12, NULL,
  -5940, -5545, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r6-yue-chunqiu', 'yue-chunqiu', 'yue-r6', '越王鹿郢',
  NULL, NULL, '{"kind":"regnal","name":"越王鹿郢"}'::jsonb,
  -463, 1, NULL, -458, 12, NULL,
  -5544, -5473, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r7-yue-chunqiu', 'yue-chunqiu', 'yue-r7', '越王不寿',
  NULL, NULL, '{"kind":"regnal","name":"越王不寿"}'::jsonb,
  -457, 1, NULL, -448, 12, NULL,
  -5472, -5353, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r8-yue-chunqiu', 'yue-chunqiu', 'yue-r8', '越王朱勾',
  NULL, NULL, '{"kind":"regnal","name":"越王朱勾"}'::jsonb,
  -447, 1, NULL, -411, 12, NULL,
  -5352, -4909, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r9-yue-chunqiu', 'yue-chunqiu', 'yue-r9', '越王翳',
  NULL, NULL, '{"kind":"regnal","name":"越王翳"}'::jsonb,
  -410, 1, NULL, -375, 12, NULL,
  -4908, -4477, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r10-yue-chunqiu', 'yue-chunqiu', 'yue-r10', '越王错枝',
  NULL, NULL, '{"kind":"regnal","name":"越王错枝"}'::jsonb,
  -374, 1, NULL, -373, 12, NULL,
  -4476, -4453, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r11-yue-chunqiu', 'yue-chunqiu', 'yue-r11', '越王无余',
  NULL, NULL, '{"kind":"regnal","name":"越王无余"}'::jsonb,
  -372, 1, NULL, -361, 12, NULL,
  -4452, -4309, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r12-yue-chunqiu', 'yue-chunqiu', 'yue-r12', '越王无颛',
  NULL, NULL, '{"kind":"regnal","name":"越王无颛"}'::jsonb,
  -360, 1, NULL, -343, 12, NULL,
  -4308, -4093, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-yue-r13-yue-chunqiu', 'yue-chunqiu', 'yue-r13', '越王无彊',
  NULL, NULL, '{"kind":"regnal","name":"越王无彊"}'::jsonb,
  -342, 1, NULL, -306, 12, NULL,
  -4092, -3649, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhongshan-r0-zhongshan', 'zhongshan', 'zhongshan-r0', '中山武公',
  '武公', NULL, '{"kind":"posthumous","name":"中山武公"}'::jsonb,
  -414, 1, NULL, -406, 12, NULL,
  -4956, -4849, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhongshan-r1-zhongshan', 'zhongshan', 'zhongshan-r1', '中山桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"中山桓公"}'::jsonb,
  -414, 1, NULL, -340, 12, NULL,
  -4956, -4057, 'year', 'interpolated', 'interpolated'
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhongshan-r2-zhongshan', 'zhongshan', 'zhongshan-r2', '中山成公',
  '成公', NULL, '{"kind":"posthumous","name":"中山成公"}'::jsonb,
  -339, 1, NULL, -328, 12, NULL,
  -4056, -3913, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhongshan-r3-zhongshan', 'zhongshan', 'zhongshan-r3', '中山王厝',
  NULL, NULL, '{"kind":"regnal","name":"中山王厝"}'::jsonb,
  -327, 1, NULL, -313, 12, NULL,
  -3912, -3733, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhongshan-r4-zhongshan', 'zhongshan', 'zhongshan-r4', '中山王胜',
  NULL, NULL, '{"kind":"regnal","name":"中山王胜"}'::jsonb,
  -312, 1, NULL, -299, 12, NULL,
  -3732, -3565, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhongshan-r5-zhongshan', 'zhongshan', 'zhongshan-r5', '中山王尚',
  NULL, NULL, '{"kind":"regnal","name":"中山王尚"}'::jsonb,
  -298, 1, NULL, -296, 12, NULL,
  -3564, -3529, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-jing-han-warring', 'han-warring', 'han-jing', '韩景侯',
  '景侯', NULL, '{"kind":"posthumous","name":"韩景侯"}'::jsonb,
  -403, 1, NULL, -400, 12, NULL,
  -4824, -4777, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-r1-han-warring', 'han-warring', 'han-r1', '韩烈侯',
  '烈侯', NULL, '{"kind":"posthumous","name":"韩烈侯"}'::jsonb,
  -399, 1, NULL, -387, 12, NULL,
  -4776, -4621, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-r2-han-warring', 'han-warring', 'han-r2', '韩文侯',
  '文侯', NULL, '{"kind":"posthumous","name":"韩文侯"}'::jsonb,
  -386, 1, NULL, -377, 12, NULL,
  -4620, -4501, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-r3-han-warring', 'han-warring', 'han-r3', '韩哀侯',
  '哀侯', NULL, '{"kind":"posthumous","name":"韩哀侯"}'::jsonb,
  -376, 1, NULL, -374, 12, NULL,
  -4500, -4465, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-r4-han-warring', 'han-warring', 'han-r4', '韩共侯',
  '共侯', NULL, '{"kind":"posthumous","name":"韩共侯"}'::jsonb,
  -374, 1, NULL, -363, 12, NULL,
  -4476, -4333, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-r5-han-warring', 'han-warring', 'han-r5', '韩釐侯',
  '釐侯', NULL, '{"kind":"posthumous","name":"韩釐侯"}'::jsonb,
  -362, 1, NULL, -333, 12, NULL,
  -4332, -3973, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-r6-han-warring', 'han-warring', 'han-r6', '韩宣惠王',
  '宣惠王', NULL, '{"kind":"posthumous","name":"韩宣惠王"}'::jsonb,
  -332, 1, NULL, -312, 12, NULL,
  -3972, -3721, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-r7-han-warring', 'han-warring', 'han-r7', '韩襄王',
  '襄王', NULL, '{"kind":"posthumous","name":"韩襄王"}'::jsonb,
  -311, 1, NULL, -296, 12, NULL,
  -3720, -3529, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-r8-han-warring', 'han-warring', 'han-r8', '韩釐王',
  '釐王', NULL, '{"kind":"posthumous","name":"韩釐王"}'::jsonb,
  -295, 1, NULL, -273, 12, NULL,
  -3528, -3253, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-r9-han-warring', 'han-warring', 'han-r9', '韩桓惠王',
  '桓惠王', NULL, '{"kind":"posthumous","name":"韩桓惠王"}'::jsonb,
  -272, 1, NULL, -239, 12, NULL,
  -3252, -2845, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-han-r10-han-warring', 'han-warring', 'han-r10', '韩王安',
  NULL, NULL, '{"kind":"regnal","name":"韩王安"}'::jsonb,
  -238, 1, NULL, -230, 12, NULL,
  -2844, -2737, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhao-lie-zhao-warring', 'zhao-warring', 'zhao-lie', '赵烈侯',
  '烈侯', NULL, '{"kind":"posthumous","name":"赵烈侯"}'::jsonb,
  -403, 1, NULL, -400, 12, NULL,
  -4824, -4777, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhao-r1-zhao-warring', 'zhao-warring', 'zhao-r1', '赵武侯',
  '武侯', NULL, '{"kind":"posthumous","name":"赵武侯"}'::jsonb,
  -399, 1, NULL, -387, 12, NULL,
  -4776, -4621, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhao-r2-zhao-warring', 'zhao-warring', 'zhao-r2', '赵敬侯',
  '敬侯', NULL, '{"kind":"posthumous","name":"赵敬侯"}'::jsonb,
  -386, 1, NULL, -375, 12, NULL,
  -4620, -4477, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhao-r3-zhao-warring', 'zhao-warring', 'zhao-r3', '赵成侯',
  '成侯', NULL, '{"kind":"posthumous","name":"赵成侯"}'::jsonb,
  -374, 1, NULL, -350, 12, NULL,
  -4476, -4177, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhao-r4-zhao-warring', 'zhao-warring', 'zhao-r4', '赵肃侯',
  '肃侯', NULL, '{"kind":"posthumous","name":"赵肃侯"}'::jsonb,
  -349, 1, NULL, -326, 12, NULL,
  -4176, -3889, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhao-r5-zhao-warring', 'zhao-warring', 'zhao-r5', '赵武灵王',
  '武灵王', NULL, '{"kind":"posthumous","name":"赵武灵王"}'::jsonb,
  -325, 1, NULL, -299, 12, NULL,
  -3888, -3565, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhao-r6-zhao-warring', 'zhao-warring', 'zhao-r6', '赵惠文王',
  '惠文王', NULL, '{"kind":"posthumous","name":"赵惠文王"}'::jsonb,
  -298, 1, NULL, -266, 12, NULL,
  -3564, -3169, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhao-r7-zhao-warring', 'zhao-warring', 'zhao-r7', '赵孝成王',
  '孝成王', NULL, '{"kind":"posthumous","name":"赵孝成王"}'::jsonb,
  -265, 1, NULL, -245, 12, NULL,
  -3168, -2917, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhao-r8-zhao-warring', 'zhao-warring', 'zhao-r8', '赵悼襄王',
  '悼襄王', NULL, '{"kind":"posthumous","name":"赵悼襄王"}'::jsonb,
  -244, 1, NULL, -236, 12, NULL,
  -2916, -2809, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-zhao-r9-zhao-warring', 'zhao-warring', 'zhao-r9', '赵幽缪王',
  '幽缪王', NULL, '{"kind":"posthumous","name":"赵幽缪王"}'::jsonb,
  -235, 1, NULL, -228, 12, NULL,
  -2808, -2713, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wei-wen-wei-warring', 'wei-warring', 'wei-wen', '魏文侯',
  '文侯', NULL, '{"kind":"posthumous","name":"魏文侯"}'::jsonb,
  -403, 1, NULL, -396, 12, NULL,
  -4824, -4729, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wei-r1-wei-warring', 'wei-warring', 'wei-r1', '魏武侯',
  '武侯', NULL, '{"kind":"posthumous","name":"魏武侯"}'::jsonb,
  -395, 1, NULL, -370, 12, NULL,
  -4728, -4417, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wei-r2-wei-warring', 'wei-warring', 'wei-r2', '魏罃',
  NULL, NULL, '{"kind":"regnal","name":"魏罃"}'::jsonb,
  -369, 1, NULL, -344, 12, NULL,
  -4416, -4105, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wei-r3-wei-warring', 'wei-warring', 'wei-r3', '魏惠成王',
  '惠成王', NULL, '{"kind":"posthumous","name":"魏惠成王"}'::jsonb,
  -344, 1, NULL, -319, 12, NULL,
  -4116, -3805, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wei-r4-wei-warring', 'wei-warring', 'wei-r4', '魏襄王',
  '襄王', NULL, '{"kind":"posthumous","name":"魏襄王"}'::jsonb,
  -318, 1, NULL, -296, 12, NULL,
  -3804, -3529, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wei-r5-wei-warring', 'wei-warring', 'wei-r5', '魏昭王',
  '昭王', NULL, '{"kind":"posthumous","name":"魏昭王"}'::jsonb,
  -295, 1, NULL, -277, 12, NULL,
  -3528, -3301, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wei-r6-wei-warring', 'wei-warring', 'wei-r6', '魏安僖王',
  '安僖王', NULL, '{"kind":"posthumous","name":"魏安僖王"}'::jsonb,
  -276, 1, NULL, -243, 12, NULL,
  -3300, -2893, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wei-r7-wei-warring', 'wei-warring', 'wei-r7', '魏景湣王',
  '景湣王', NULL, '{"kind":"posthumous","name":"魏景湣王"}'::jsonb,
  -242, 1, NULL, -228, 12, NULL,
  -2892, -2713, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-wei-r8-wei-warring', 'wei-warring', 'wei-r8', '魏假',
  NULL, NULL, '{"kind":"regnal","name":"魏假"}'::jsonb,
  -227, 1, NULL, -225, 12, NULL,
  -2712, -2677, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-ying-qi-qin', 'qin', 'ying-qi', '秦襄公',
  '襄公', NULL, '{"kind":"posthumous","name":"秦襄公"}'::jsonb,
  -778, 1, NULL, -766, 12, NULL,
  -9324, -9169, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r1-qin', 'qin', 'qin-r1', '秦文公',
  '文公', NULL, '{"kind":"posthumous","name":"秦文公"}'::jsonb,
  -766, 1, NULL, -716, 12, NULL,
  -9180, -8569, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r2-qin', 'qin', 'qin-r2', '秦宪公',
  '宪公', NULL, '{"kind":"posthumous","name":"秦宪公"}'::jsonb,
  -716, 1, NULL, -704, 12, NULL,
  -8580, -8425, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r3-qin', 'qin', 'qin-r3', '秦出子',
  NULL, NULL, '{"kind":"regnal","name":"秦出子"}'::jsonb,
  -704, 1, NULL, -698, 12, NULL,
  -8436, -8353, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r4-qin', 'qin', 'qin-r4', '秦武公',
  '武公', NULL, '{"kind":"posthumous","name":"秦武公"}'::jsonb,
  -698, 1, NULL, -678, 12, NULL,
  -8364, -8113, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r5-qin', 'qin', 'qin-r5', '秦德公',
  '德公', NULL, '{"kind":"posthumous","name":"秦德公"}'::jsonb,
  -678, 1, NULL, -676, 12, NULL,
  -8124, -8089, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r6-qin', 'qin', 'qin-r6', '秦宣公',
  '宣公', NULL, '{"kind":"posthumous","name":"秦宣公"}'::jsonb,
  -676, 1, NULL, -664, 12, NULL,
  -8100, -7945, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r7-qin', 'qin', 'qin-r7', '秦成公',
  '成公', NULL, '{"kind":"posthumous","name":"秦成公"}'::jsonb,
  -664, 1, NULL, -660, 12, NULL,
  -7956, -7897, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r8-qin', 'qin', 'qin-r8', '秦穆公',
  '穆公', NULL, '{"kind":"posthumous","name":"秦穆公"}'::jsonb,
  -660, 1, NULL, -621, 12, NULL,
  -7908, -7429, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r9-qin', 'qin', 'qin-r9', '秦康公',
  '康公', NULL, '{"kind":"posthumous","name":"秦康公"}'::jsonb,
  -621, 1, NULL, -609, 12, NULL,
  -7440, -7285, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r10-qin', 'qin', 'qin-r10', '秦共公',
  '共公', NULL, '{"kind":"posthumous","name":"秦共公"}'::jsonb,
  -609, 1, NULL, -605, 12, NULL,
  -7296, -7237, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r11-qin', 'qin', 'qin-r11', '秦桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"秦桓公"}'::jsonb,
  -605, 1, NULL, -577, 12, NULL,
  -7248, -6901, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r12-qin', 'qin', 'qin-r12', '秦景公',
  '景公', NULL, '{"kind":"posthumous","name":"秦景公"}'::jsonb,
  -577, 1, NULL, -537, 12, NULL,
  -6912, -6421, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r13-qin', 'qin', 'qin-r13', '秦哀公',
  '哀公', NULL, '{"kind":"posthumous","name":"秦哀公"}'::jsonb,
  -537, 1, NULL, -501, 12, NULL,
  -6432, -5989, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r14-qin', 'qin', 'qin-r14', '秦惠公',
  '惠公', NULL, '{"kind":"posthumous","name":"秦惠公"}'::jsonb,
  -501, 1, NULL, -492, 12, NULL,
  -6000, -5881, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r15-qin', 'qin', 'qin-r15', '秦悼公',
  '悼公', NULL, '{"kind":"posthumous","name":"秦悼公"}'::jsonb,
  -492, 1, NULL, -477, 12, NULL,
  -5892, -5701, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r16-qin', 'qin', 'qin-r16', '秦厉共公',
  '厉共公', NULL, '{"kind":"posthumous","name":"秦厉共公"}'::jsonb,
  -477, 1, NULL, -443, 12, NULL,
  -5712, -5293, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r17-qin', 'qin', 'qin-r17', '秦躁公',
  '躁公', NULL, '{"kind":"posthumous","name":"秦躁公"}'::jsonb,
  -443, 1, NULL, -429, 12, NULL,
  -5304, -5125, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r18-qin', 'qin', 'qin-r18', '秦怀公',
  '怀公', NULL, '{"kind":"posthumous","name":"秦怀公"}'::jsonb,
  -429, 1, NULL, -425, 12, NULL,
  -5136, -5077, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r19-qin', 'qin', 'qin-r19', '秦灵公',
  '灵公', NULL, '{"kind":"posthumous","name":"秦灵公"}'::jsonb,
  -425, 1, NULL, -415, 12, NULL,
  -5088, -4957, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r20-qin', 'qin', 'qin-r20', '秦简公',
  '简公', NULL, '{"kind":"posthumous","name":"秦简公"}'::jsonb,
  -415, 1, NULL, -400, 12, NULL,
  -4968, -4777, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r21-qin', 'qin', 'qin-r21', '秦惠公',
  '惠公', NULL, '{"kind":"posthumous","name":"秦惠公"}'::jsonb,
  -400, 1, NULL, -387, 12, NULL,
  -4788, -4621, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r22-qin', 'qin', 'qin-r22', '秦出公',
  '出公', NULL, '{"kind":"posthumous","name":"秦出公"}'::jsonb,
  -387, 1, NULL, -385, 12, NULL,
  -4632, -4597, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r23-qin', 'qin', 'qin-r23', '秦献公',
  '献公', NULL, '{"kind":"posthumous","name":"秦献公"}'::jsonb,
  -385, 1, NULL, -362, 12, NULL,
  -4608, -4321, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-ying-quliang-qin', 'qin', 'ying-quliang', '秦孝公',
  '孝公', NULL, '{"kind":"posthumous","name":"秦孝公"}'::jsonb,
  -362, 1, NULL, -338, 12, NULL,
  -4332, -4033, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r25-qin', 'qin', 'qin-r25', '秦惠文王',
  '惠文王', NULL, '{"kind":"posthumous","name":"秦惠文王"}'::jsonb,
  -338, 1, NULL, -311, 12, NULL,
  -4044, -3709, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r26-qin', 'qin', 'qin-r26', '秦武王',
  '武王', NULL, '{"kind":"posthumous","name":"秦武王"}'::jsonb,
  -311, 1, NULL, -307, 12, NULL,
  -3720, -3661, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r27-qin', 'qin', 'qin-r27', '秦昭襄王',
  '昭襄王', NULL, '{"kind":"posthumous","name":"秦昭襄王"}'::jsonb,
  -307, 1, NULL, -251, 12, NULL,
  -3672, -2989, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r28-qin', 'qin', 'qin-r28', '秦孝文王',
  '孝文王', NULL, '{"kind":"posthumous","name":"秦孝文王"}'::jsonb,
  -251, 1, NULL, -250, 12, NULL,
  -3000, -2977, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-qin-r29-qin', 'qin', 'qin-r29', '秦庄襄王',
  '庄襄王', NULL, '{"kind":"posthumous","name":"秦庄襄王"}'::jsonb,
  -250, 1, NULL, -247, 12, NULL,
  -2988, -2941, 'year', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  'reign-ying-zheng-qin', 'qin', 'ying-zheng', '秦王政',
  NULL, NULL, '{"kind":"regnal","name":"秦王政"}'::jsonb,
  -247, 1, NULL, -221, 9, 9,
  -2952, -2632, 'month', NULL, NULL
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
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('shangyang-reform', '商鞅变法', 'politics', 'point', 'year', '秦孝公六年，前356年；史籍或作前359年，取前356年', -356, 1, -4260, NULL, NULL, NULL, NULL, NULL, NULL, '商鞅在秦国推行军功爵、什伍连坐、废井田等改革，奠定统一六国基础。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('wuqi-reform-wei', '吴起变法（魏）', 'politics', 'point', 'year', '魏文侯时，约前403–前387年，取中点估列', -395, 1, -4728, NULL, NULL, NULL, NULL, NULL, NULL, '吴起在魏国主持军政改革，创建武卒，魏国成为战国初强国。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('wu-destroy-yue', '越灭吴', 'battle', 'point', 'year', '越王勾践二十二年，前473年', -473, 1, -5664, NULL, NULL, NULL, NULL, NULL, NULL, '勾践灭吴，夫差自杀，吴国灭亡。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qin-destroy-han', '秦灭韩', 'battle', 'point', 'year', '秦王政元年，前230年', -230, 1, -2748, NULL, NULL, NULL, NULL, NULL, NULL, '秦将内史腾攻韩，俘韩王安，韩国灭亡，六国兼并由此开端。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qin-destroy-chu', '秦灭楚', 'battle', 'point', 'year', '秦王政二十六年，前223年', -223, 1, -2664, NULL, NULL, NULL, NULL, NULL, NULL, '王翦、蒙武率军灭楚，俘楚王负刍。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('guiling-battle', '桂陵之战', 'battle', 'point', 'year', '周威烈王十三年，前354年', -354, 1, -4236, NULL, NULL, NULL, NULL, NULL, NULL, '孙膑围魏救赵，于桂陵大败魏军，开创围魏救赵战法。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('maling-battle', '马陵之战', 'battle', 'point', 'year', '周显王三年，前341年', -341, 1, -4080, NULL, NULL, NULL, NULL, NULL, NULL, '孙膑减灶诱敌，于马陵伏击魏军，庞涓战死，魏国元气大伤。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('changping-battle', '长平之战', 'battle', 'point', 'year', '秦昭襄王四十七年，前260年', -260, 1, -3108, NULL, NULL, NULL, NULL, NULL, NULL, '白起于长平围歼赵军四十余万，赵国一蹶不振，秦统一大势已定。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qin-destroy-wei', '秦灭魏', 'battle', 'point', 'year', '秦王政二十二年，前225年', -225, 1, -2688, NULL, NULL, NULL, NULL, NULL, NULL, '王贲引黄河水灌大梁，魏王假投降，魏国灭亡。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qin-destroy-zhao', '秦灭赵', 'battle', 'point', 'year', '秦王政二十五年，前222年', -222, 1, -2652, NULL, NULL, NULL, NULL, NULL, NULL, '王翦、王贲率军灭赵，俘赵王嘉，赵国灭亡。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qin-destroy-yan', '秦灭燕', 'battle', 'point', 'year', '秦王政二十五年，前222年', -222, 1, -2652, NULL, NULL, NULL, NULL, NULL, NULL, '王翦率军攻燕，俘燕王喜，燕国灭亡。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary)
VALUES ('qin-destroy-qi', '秦灭齐', 'battle', 'point', 'year', '秦王政二十六年，前221年', -221, 1, -2640, NULL, NULL, NULL, NULL, NULL, NULL, '王贲率军灭齐，俘齐王建，六国悉灭，秦统一六国。')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;

-- event_dynasties (new + links to xia-shang-zhou events)
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('shangyang-reform', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wuqi-reform-wei', 'wei-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wu-destroy-yue', 'yue-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wu-destroy-yue', 'wu-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-han', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-han', 'han-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-chu', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-chu', 'chu-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('guiling-battle', 'wei-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('guiling-battle', 'qi-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('maling-battle', 'wei-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('maling-battle', 'qi-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('changping-battle', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('changping-battle', 'zhao-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-wei', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-wei', 'wei-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-zhao', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-zhao', 'zhao-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-yan', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-yan', 'yan-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-qi', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-qi', 'qi-chunqiu') ON CONFLICT DO NOTHING;
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
INSERT INTO event_participants (event_id, person_id) VALUES ('wu-destroy-yue', 'gou-jian') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('wu-destroy-yue', 'fu-chai') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-destroy-han', 'ying-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-destroy-chu', 'ying-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('guiling-battle', 'sun-bin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('maling-battle', 'sun-bin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('changping-battle', 'bai-qi') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-destroy-wei', 'ying-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-destroy-zhao', 'ying-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-destroy-zhao', 'wang-jian-qin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-destroy-yan', 'ying-zheng') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-destroy-yan', 'wang-jian-qin') ON CONFLICT DO NOTHING;
INSERT INTO event_participants (event_id, person_id) VALUES ('qin-destroy-qi', 'ying-zheng') ON CONFLICT DO NOTHING;

-- relations
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-shangyang-reform-shang-yang', 'event', 'shangyang-reform', 'person', 'shang-yang', 'politics')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-wu-destroy-yue-gou-jian', 'event', 'wu-destroy-yue', 'person', 'gou-jian', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-qin-destroy-han-ying-zheng', 'event', 'qin-destroy-han', 'person', 'ying-zheng', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-qin-destroy-chu-ying-zheng', 'event', 'qin-destroy-chu', 'person', 'ying-zheng', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-changping-bai-qi', 'event', 'changping-battle', 'person', 'bai-qi', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-guiling-sun-bin', 'event', 'guiling-battle', 'person', 'sun-bin', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;
INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES ('rel-maling-sun-bin', 'event', 'maling-battle', 'person', 'sun-bin', 'battle')
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;

-- Remove stale reigns from managed dynasties (superseded ids from older imports)
WITH stale AS (
  DELETE FROM reigns
  WHERE dynasty_id IN ('qi-chunqiu', 'jin-chunqiu', 'chu-chunqiu', 'yan-chunqiu', 'song-chunqiu', 'lu-chunqiu', 'wei-weiguo', 'zheng-chunqiu', 'cao-chunqiu', 'wu-chunqiu', 'yue-chunqiu', 'zhongshan', 'han-warring', 'zhao-warring', 'wei-warring', 'qin') AND id NOT IN ('reign-lv-shang-qi-chunqiu', 'reign-qi-r1-qi-chunqiu', 'reign-qi-r2-qi-chunqiu', 'reign-qi-r3-qi-chunqiu', 'reign-qi-r4-qi-chunqiu', 'reign-qi-r5-qi-chunqiu', 'reign-qi-r6-qi-chunqiu', 'reign-qi-r7-qi-chunqiu', 'reign-qi-r8-qi-chunqiu', 'reign-qi-r9-qi-chunqiu', 'reign-qi-r10-qi-chunqiu', 'reign-qi-r11-qi-chunqiu', 'reign-qi-r12-qi-chunqiu', 'reign-qi-r13-qi-chunqiu', 'reign-qi-r14-qi-chunqiu', 'reign-jiang-xiaobai-qi-chunqiu', 'reign-qi-r16-qi-chunqiu', 'reign-qi-r17-qi-chunqiu', 'reign-qi-r18-qi-chunqiu', 'reign-qi-r19-qi-chunqiu', 'reign-qi-r20-qi-chunqiu', 'reign-qi-r21-qi-chunqiu', 'reign-qi-r22-qi-chunqiu', 'reign-qi-r23-qi-chunqiu', 'reign-qi-r24-qi-chunqiu', 'reign-qi-r25-qi-chunqiu', 'reign-qi-r26-qi-chunqiu', 'reign-qi-r27-qi-chunqiu', 'reign-qi-r28-qi-chunqiu', 'reign-qi-r29-qi-chunqiu', 'reign-qi-r30-qi-chunqiu', 'reign-qi-r31-qi-chunqiu', 'reign-qi-r32-qi-chunqiu', 'reign-qi-r33-qi-chunqiu', 'reign-qi-r34-qi-chunqiu', 'reign-qi-r35-qi-chunqiu', 'reign-qi-r36-qi-chunqiu', 'reign-qi-r37-qi-chunqiu', 'reign-qi-r38-qi-chunqiu', 'reign-qi-r39-qi-chunqiu', 'reign-ji-shuyu-jin-chunqiu', 'reign-jin-r1-jin-chunqiu', 'reign-jin-r2-jin-chunqiu', 'reign-jin-r3-jin-chunqiu', 'reign-jin-r4-jin-chunqiu', 'reign-jin-r5-jin-chunqiu', 'reign-jin-r6-jin-chunqiu', 'reign-jin-r7-jin-chunqiu', 'reign-jin-r8-jin-chunqiu', 'reign-jin-r9-jin-chunqiu', 'reign-jin-r10-jin-chunqiu', 'reign-jin-r11-jin-chunqiu', 'reign-jin-r12-jin-chunqiu', 'reign-jin-r13-jin-chunqiu', 'reign-jin-r14-jin-chunqiu', 'reign-jin-r15-jin-chunqiu', 'reign-jin-r16-jin-chunqiu', 'reign-jin-r17-jin-chunqiu', 'reign-jin-r18-jin-chunqiu', 'reign-jin-r19-jin-chunqiu', 'reign-jin-r20-jin-chunqiu', 'reign-jin-r21-jin-chunqiu', 'reign-jin-r22-jin-chunqiu', 'reign-ji-chonger-jin-chunqiu', 'reign-jin-r24-jin-chunqiu', 'reign-jin-r25-jin-chunqiu', 'reign-jin-r26-jin-chunqiu', 'reign-jin-r27-jin-chunqiu', 'reign-jin-r28-jin-chunqiu', 'reign-jin-r29-jin-chunqiu', 'reign-jin-r30-jin-chunqiu', 'reign-jin-r31-jin-chunqiu', 'reign-jin-r32-jin-chunqiu', 'reign-jin-r33-jin-chunqiu', 'reign-jin-r34-jin-chunqiu', 'reign-jin-r35-jin-chunqiu', 'reign-jin-r36-jin-chunqiu', 'reign-jin-r37-jin-chunqiu', 'reign-jin-r38-jin-chunqiu', 'reign-jin-r39-jin-chunqiu', 'reign-chu-r0-chu-chunqiu', 'reign-chu-r1-chu-chunqiu', 'reign-chu-r2-chu-chunqiu', 'reign-chu-r3-chu-chunqiu', 'reign-chu-r4-chu-chunqiu', 'reign-chu-r5-chu-chunqiu', 'reign-chu-r6-chu-chunqiu', 'reign-chu-r7-chu-chunqiu', 'reign-chu-r8-chu-chunqiu', 'reign-chu-r9-chu-chunqiu', 'reign-chu-r10-chu-chunqiu', 'reign-chu-r11-chu-chunqiu', 'reign-chu-r12-chu-chunqiu', 'reign-chu-r13-chu-chunqiu', 'reign-chu-r14-chu-chunqiu', 'reign-chu-r15-chu-chunqiu', 'reign-chu-r16-chu-chunqiu', 'reign-chu-r17-chu-chunqiu', 'reign-chu-r18-chu-chunqiu', 'reign-chu-r19-chu-chunqiu', 'reign-chu-r20-chu-chunqiu', 'reign-xiong-zhuang-chu-chunqiu', 'reign-chu-r22-chu-chunqiu', 'reign-chu-r23-chu-chunqiu', 'reign-chu-r24-chu-chunqiu', 'reign-chu-r25-chu-chunqiu', 'reign-chu-r26-chu-chunqiu', 'reign-chu-r27-chu-chunqiu', 'reign-chu-r28-chu-chunqiu', 'reign-chu-r29-chu-chunqiu', 'reign-chu-r30-chu-chunqiu', 'reign-chu-r31-chu-chunqiu', 'reign-chu-r32-chu-chunqiu', 'reign-chu-r33-chu-chunqiu', 'reign-chu-r34-chu-chunqiu', 'reign-chu-r35-chu-chunqiu', 'reign-chu-r36-chu-chunqiu', 'reign-chu-r37-chu-chunqiu', 'reign-chu-r38-chu-chunqiu', 'reign-chu-r39-chu-chunqiu', 'reign-chu-r40-chu-chunqiu', 'reign-chu-r41-chu-chunqiu', 'reign-chu-r42-chu-chunqiu', 'reign-chu-r43-chu-chunqiu', 'reign-ji-shi-yan-chunqiu', 'reign-yan-r1-yan-chunqiu', 'reign-yan-r2-yan-chunqiu', 'reign-yan-r3-yan-chunqiu', 'reign-yan-r4-yan-chunqiu', 'reign-yan-r5-yan-chunqiu', 'reign-yan-r6-yan-chunqiu', 'reign-yan-r7-yan-chunqiu', 'reign-yan-r8-yan-chunqiu', 'reign-yan-r9-yan-chunqiu', 'reign-yan-r10-yan-chunqiu', 'reign-yan-r11-yan-chunqiu', 'reign-yan-r12-yan-chunqiu', 'reign-yan-r13-yan-chunqiu', 'reign-yan-r14-yan-chunqiu', 'reign-yan-r15-yan-chunqiu', 'reign-yan-r16-yan-chunqiu', 'reign-yan-r17-yan-chunqiu', 'reign-yan-r18-yan-chunqiu', 'reign-yan-r19-yan-chunqiu', 'reign-yan-r20-yan-chunqiu', 'reign-yan-r21-yan-chunqiu', 'reign-yan-r22-yan-chunqiu', 'reign-yan-r23-yan-chunqiu', 'reign-yan-r24-yan-chunqiu', 'reign-yan-r25-yan-chunqiu', 'reign-yan-r26-yan-chunqiu', 'reign-yan-r27-yan-chunqiu', 'reign-yan-r28-yan-chunqiu', 'reign-yan-r29-yan-chunqiu', 'reign-yan-r30-yan-chunqiu', 'reign-yan-r31-yan-chunqiu', 'reign-yan-r32-yan-chunqiu', 'reign-yan-r33-yan-chunqiu', 'reign-yan-r34-yan-chunqiu', 'reign-yan-r35-yan-chunqiu', 'reign-yan-r36-yan-chunqiu', 'reign-yan-r37-yan-chunqiu', 'reign-song-weizi-song-chunqiu', 'reign-song-r1-song-chunqiu', 'reign-song-r2-song-chunqiu', 'reign-song-r3-song-chunqiu', 'reign-song-r4-song-chunqiu', 'reign-song-r5-song-chunqiu', 'reign-song-r6-song-chunqiu', 'reign-song-r7-song-chunqiu', 'reign-song-r8-song-chunqiu', 'reign-song-r9-song-chunqiu', 'reign-song-r10-song-chunqiu', 'reign-song-r11-song-chunqiu', 'reign-song-r12-song-chunqiu', 'reign-song-r13-song-chunqiu', 'reign-song-r14-song-chunqiu', 'reign-song-r15-song-chunqiu', 'reign-song-r16-song-chunqiu', 'reign-song-r17-song-chunqiu', 'reign-song-r18-song-chunqiu', 'reign-song-r19-song-chunqiu', 'reign-song-r20-song-chunqiu', 'reign-song-r21-song-chunqiu', 'reign-song-r22-song-chunqiu', 'reign-song-r23-song-chunqiu', 'reign-song-r24-song-chunqiu', 'reign-song-r25-song-chunqiu', 'reign-song-r26-song-chunqiu', 'reign-song-r27-song-chunqiu', 'reign-song-r28-song-chunqiu', 'reign-song-r29-song-chunqiu', 'reign-song-r30-song-chunqiu', 'reign-song-r31-song-chunqiu', 'reign-song-r32-song-chunqiu', 'reign-song-r33-song-chunqiu', 'reign-bo-qin-lu-chunqiu', 'reign-lu-r1-lu-chunqiu', 'reign-lu-r2-lu-chunqiu', 'reign-lu-r3-lu-chunqiu', 'reign-lu-r4-lu-chunqiu', 'reign-lu-r5-lu-chunqiu', 'reign-lu-r6-lu-chunqiu', 'reign-lu-r7-lu-chunqiu', 'reign-lu-r8-lu-chunqiu', 'reign-lu-r9-lu-chunqiu', 'reign-lu-r10-lu-chunqiu', 'reign-lu-r11-lu-chunqiu', 'reign-lu-r12-lu-chunqiu', 'reign-lu-r13-lu-chunqiu', 'reign-lu-r14-lu-chunqiu', 'reign-lu-r15-lu-chunqiu', 'reign-lu-r16-lu-chunqiu', 'reign-lu-r17-lu-chunqiu', 'reign-lu-r18-lu-chunqiu', 'reign-lu-r19-lu-chunqiu', 'reign-lu-r20-lu-chunqiu', 'reign-lu-r21-lu-chunqiu', 'reign-lu-r22-lu-chunqiu', 'reign-lu-r23-lu-chunqiu', 'reign-lu-r24-lu-chunqiu', 'reign-lu-r25-lu-chunqiu', 'reign-lu-r26-lu-chunqiu', 'reign-lu-r27-lu-chunqiu', 'reign-lu-r28-lu-chunqiu', 'reign-lu-r29-lu-chunqiu', 'reign-lu-r30-lu-chunqiu', 'reign-lu-r31-lu-chunqiu', 'reign-lu-r32-lu-chunqiu', 'reign-lu-r33-lu-chunqiu', 'reign-lu-r34-lu-chunqiu', 'reign-weiguo-r0-wei-weiguo', 'reign-weiguo-r1-wei-weiguo', 'reign-weiguo-r2-wei-weiguo', 'reign-weiguo-r3-wei-weiguo', 'reign-weiguo-r4-wei-weiguo', 'reign-weiguo-r5-wei-weiguo', 'reign-weiguo-r6-wei-weiguo', 'reign-weiguo-r7-wei-weiguo', 'reign-weiguo-r8-wei-weiguo', 'reign-weiguo-r9-wei-weiguo', 'reign-weiguo-r10-wei-weiguo', 'reign-weiguo-r11-wei-weiguo', 'reign-weiguo-r12-wei-weiguo', 'reign-weiguo-r13-wei-weiguo', 'reign-weiguo-r14-wei-weiguo', 'reign-weiguo-r15-wei-weiguo', 'reign-weiguo-r16-wei-weiguo', 'reign-weiguo-r17-wei-weiguo', 'reign-weiguo-r18-wei-weiguo', 'reign-weiguo-r19-wei-weiguo', 'reign-weiguo-r20-wei-weiguo', 'reign-weiguo-r21-wei-weiguo', 'reign-weiguo-r22-wei-weiguo', 'reign-weiguo-r23-wei-weiguo', 'reign-weiguo-r24-wei-weiguo', 'reign-weiguo-r25-wei-weiguo', 'reign-weiguo-r26-wei-weiguo', 'reign-weiguo-r27-wei-weiguo', 'reign-weiguo-r28-wei-weiguo', 'reign-weiguo-r29-wei-weiguo', 'reign-weiguo-r30-wei-weiguo', 'reign-weiguo-r31-wei-weiguo', 'reign-weiguo-r32-wei-weiguo', 'reign-weiguo-r33-wei-weiguo', 'reign-weiguo-r34-wei-weiguo', 'reign-weiguo-r35-wei-weiguo', 'reign-weiguo-r36-wei-weiguo', 'reign-weiguo-r37-wei-weiguo', 'reign-weiguo-r38-wei-weiguo', 'reign-weiguo-r39-wei-weiguo', 'reign-weiguo-r40-wei-weiguo', 'reign-weiguo-r41-wei-weiguo', 'reign-weiguo-r42-wei-weiguo', 'reign-weiguo-r43-wei-weiguo', 'reign-weiguo-r44-wei-weiguo', 'reign-weiguo-r45-wei-weiguo', 'reign-weiguo-r46-wei-weiguo', 'reign-zheng-r0-zheng-chunqiu', 'reign-zheng-r1-zheng-chunqiu', 'reign-zheng-r2-zheng-chunqiu', 'reign-zheng-r3-zheng-chunqiu', 'reign-zheng-r4-zheng-chunqiu', 'reign-zheng-r5-zheng-chunqiu', 'reign-zheng-r6-zheng-chunqiu', 'reign-zheng-r7-zheng-chunqiu', 'reign-zheng-r8-zheng-chunqiu', 'reign-zheng-r9-zheng-chunqiu', 'reign-zheng-r10-zheng-chunqiu', 'reign-zheng-r11-zheng-chunqiu', 'reign-zheng-r12-zheng-chunqiu', 'reign-zheng-r13-zheng-chunqiu', 'reign-zheng-r14-zheng-chunqiu', 'reign-zheng-r15-zheng-chunqiu', 'reign-zheng-r16-zheng-chunqiu', 'reign-zheng-r17-zheng-chunqiu', 'reign-zheng-r18-zheng-chunqiu', 'reign-zheng-r19-zheng-chunqiu', 'reign-zheng-r20-zheng-chunqiu', 'reign-zheng-r21-zheng-chunqiu', 'reign-zheng-r22-zheng-chunqiu', 'reign-zheng-r23-zheng-chunqiu', 'reign-zheng-r24-zheng-chunqiu', 'reign-cao-r0-cao-chunqiu', 'reign-cao-r1-cao-chunqiu', 'reign-cao-r2-cao-chunqiu', 'reign-cao-r3-cao-chunqiu', 'reign-cao-r4-cao-chunqiu', 'reign-cao-r5-cao-chunqiu', 'reign-cao-r6-cao-chunqiu', 'reign-cao-r7-cao-chunqiu', 'reign-cao-r8-cao-chunqiu', 'reign-cao-r9-cao-chunqiu', 'reign-cao-r10-cao-chunqiu', 'reign-cao-r11-cao-chunqiu', 'reign-cao-r12-cao-chunqiu', 'reign-cao-r13-cao-chunqiu', 'reign-cao-r14-cao-chunqiu', 'reign-cao-r15-cao-chunqiu', 'reign-cao-r16-cao-chunqiu', 'reign-cao-r17-cao-chunqiu', 'reign-cao-r18-cao-chunqiu', 'reign-cao-r19-cao-chunqiu', 'reign-cao-r20-cao-chunqiu', 'reign-cao-r21-cao-chunqiu', 'reign-cao-r22-cao-chunqiu', 'reign-cao-r23-cao-chunqiu', 'reign-cao-r24-cao-chunqiu', 'reign-cao-r25-cao-chunqiu', 'reign-wu-r0-wu-chunqiu', 'reign-wu-r1-wu-chunqiu', 'reign-wu-r2-wu-chunqiu', 'reign-wu-r3-wu-chunqiu', 'reign-wu-r4-wu-chunqiu', 'reign-helu-wu-chunqiu', 'reign-fu-chai-wu-chunqiu', 'reign-yue-r0-yue-chunqiu', 'reign-yue-r1-yue-chunqiu', 'reign-yue-r2-yue-chunqiu', 'reign-yue-r3-yue-chunqiu', 'reign-yue-r4-yue-chunqiu', 'reign-gou-jian-yue-chunqiu', 'reign-yue-r6-yue-chunqiu', 'reign-yue-r7-yue-chunqiu', 'reign-yue-r8-yue-chunqiu', 'reign-yue-r9-yue-chunqiu', 'reign-yue-r10-yue-chunqiu', 'reign-yue-r11-yue-chunqiu', 'reign-yue-r12-yue-chunqiu', 'reign-yue-r13-yue-chunqiu', 'reign-zhongshan-r0-zhongshan', 'reign-zhongshan-r1-zhongshan', 'reign-zhongshan-r2-zhongshan', 'reign-zhongshan-r3-zhongshan', 'reign-zhongshan-r4-zhongshan', 'reign-zhongshan-r5-zhongshan', 'reign-han-jing-han-warring', 'reign-han-r1-han-warring', 'reign-han-r2-han-warring', 'reign-han-r3-han-warring', 'reign-han-r4-han-warring', 'reign-han-r5-han-warring', 'reign-han-r6-han-warring', 'reign-han-r7-han-warring', 'reign-han-r8-han-warring', 'reign-han-r9-han-warring', 'reign-han-r10-han-warring', 'reign-zhao-lie-zhao-warring', 'reign-zhao-r1-zhao-warring', 'reign-zhao-r2-zhao-warring', 'reign-zhao-r3-zhao-warring', 'reign-zhao-r4-zhao-warring', 'reign-zhao-r5-zhao-warring', 'reign-zhao-r6-zhao-warring', 'reign-zhao-r7-zhao-warring', 'reign-zhao-r8-zhao-warring', 'reign-zhao-r9-zhao-warring', 'reign-wei-wen-wei-warring', 'reign-wei-r1-wei-warring', 'reign-wei-r2-wei-warring', 'reign-wei-r3-wei-warring', 'reign-wei-r4-wei-warring', 'reign-wei-r5-wei-warring', 'reign-wei-r6-wei-warring', 'reign-wei-r7-wei-warring', 'reign-wei-r8-wei-warring', 'reign-ying-qi-qin', 'reign-qin-r1-qin', 'reign-qin-r2-qin', 'reign-qin-r3-qin', 'reign-qin-r4-qin', 'reign-qin-r5-qin', 'reign-qin-r6-qin', 'reign-qin-r7-qin', 'reign-qin-r8-qin', 'reign-qin-r9-qin', 'reign-qin-r10-qin', 'reign-qin-r11-qin', 'reign-qin-r12-qin', 'reign-qin-r13-qin', 'reign-qin-r14-qin', 'reign-qin-r15-qin', 'reign-qin-r16-qin', 'reign-qin-r17-qin', 'reign-qin-r18-qin', 'reign-qin-r19-qin', 'reign-qin-r20-qin', 'reign-qin-r21-qin', 'reign-qin-r22-qin', 'reign-qin-r23-qin', 'reign-ying-quliang-qin', 'reign-qin-r25-qin', 'reign-qin-r26-qin', 'reign-qin-r27-qin', 'reign-qin-r28-qin', 'reign-qin-r29-qin', 'reign-ying-zheng-qin', 'reign-ying-zheng', 'reign-ying-huhai', 'reign-ying-ziying')
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
WHERE p.id NOT IN ('lv-shang', 'qi-r1', 'qi-r2', 'qi-r3', 'qi-r4', 'qi-r5', 'qi-r6', 'qi-r7', 'qi-r8', 'qi-r9', 'qi-r10', 'qi-r11', 'qi-r12', 'qi-r13', 'qi-r14', 'jiang-xiaobai', 'qi-r16', 'qi-r17', 'qi-r18', 'qi-r19', 'qi-r20', 'qi-r21', 'qi-r22', 'qi-r23', 'qi-r24', 'qi-r25', 'qi-r26', 'qi-r27', 'qi-r28', 'qi-r29', 'qi-r30', 'qi-r31', 'qi-r32', 'qi-r33', 'qi-r34', 'qi-r35', 'qi-r36', 'qi-r37', 'qi-r38', 'qi-r39', 'ji-shuyu', 'jin-r1', 'jin-r2', 'jin-r3', 'jin-r4', 'jin-r5', 'jin-r6', 'jin-r7', 'jin-r8', 'jin-r9', 'jin-r10', 'jin-r11', 'jin-r12', 'jin-r13', 'jin-r14', 'jin-r15', 'jin-r16', 'jin-r17', 'jin-r18', 'jin-r19', 'jin-r20', 'jin-r21', 'jin-r22', 'ji-chonger', 'jin-r24', 'jin-r25', 'jin-r26', 'jin-r27', 'jin-r28', 'jin-r29', 'jin-r30', 'jin-r31', 'jin-r32', 'jin-r33', 'jin-r34', 'jin-r35', 'jin-r36', 'jin-r37', 'jin-r38', 'jin-r39', 'chu-r0', 'chu-r1', 'chu-r2', 'chu-r3', 'chu-r4', 'chu-r5', 'chu-r6', 'chu-r7', 'chu-r8', 'chu-r9', 'chu-r10', 'chu-r11', 'chu-r12', 'chu-r13', 'chu-r14', 'chu-r15', 'chu-r16', 'chu-r17', 'chu-r18', 'chu-r19', 'chu-r20', 'xiong-zhuang', 'chu-r22', 'chu-r23', 'chu-r24', 'chu-r25', 'chu-r26', 'chu-r27', 'chu-r28', 'chu-r29', 'chu-r30', 'chu-r31', 'chu-r32', 'chu-r33', 'chu-r34', 'chu-r35', 'chu-r36', 'chu-r37', 'chu-r38', 'chu-r39', 'chu-r40', 'chu-r41', 'chu-r42', 'chu-r43', 'ji-shi', 'yan-r1', 'yan-r2', 'yan-r3', 'yan-r4', 'yan-r5', 'yan-r6', 'yan-r7', 'yan-r8', 'yan-r9', 'yan-r10', 'yan-r11', 'yan-r12', 'yan-r13', 'yan-r14', 'yan-r15', 'yan-r16', 'yan-r17', 'yan-r18', 'yan-r19', 'yan-r20', 'yan-r21', 'yan-r22', 'yan-r23', 'yan-r24', 'yan-r25', 'yan-r26', 'yan-r27', 'yan-r28', 'yan-r29', 'yan-r30', 'yan-r31', 'yan-r32', 'yan-r33', 'yan-r34', 'yan-r35', 'yan-r36', 'yan-r37', 'song-weizi', 'song-r1', 'song-r2', 'song-r3', 'song-r4', 'song-r5', 'song-r6', 'song-r7', 'song-r8', 'song-r9', 'song-r10', 'song-r11', 'song-r12', 'song-r13', 'song-r14', 'song-r15', 'song-r16', 'song-r17', 'song-r18', 'song-r19', 'song-r20', 'song-r21', 'song-r22', 'song-r23', 'song-r24', 'song-r25', 'song-r26', 'song-r27', 'song-r28', 'song-r29', 'song-r30', 'song-r31', 'song-r32', 'song-r33', 'bo-qin', 'lu-r1', 'lu-r2', 'lu-r3', 'lu-r4', 'lu-r5', 'lu-r6', 'lu-r7', 'lu-r8', 'lu-r9', 'lu-r10', 'lu-r11', 'lu-r12', 'lu-r13', 'lu-r14', 'lu-r15', 'lu-r16', 'lu-r17', 'lu-r18', 'lu-r19', 'lu-r20', 'lu-r21', 'lu-r22', 'lu-r23', 'lu-r24', 'lu-r25', 'lu-r26', 'lu-r27', 'lu-r28', 'lu-r29', 'lu-r30', 'lu-r31', 'lu-r32', 'lu-r33', 'lu-r34', 'weiguo-r0', 'weiguo-r1', 'weiguo-r2', 'weiguo-r3', 'weiguo-r4', 'weiguo-r5', 'weiguo-r6', 'weiguo-r7', 'weiguo-r8', 'weiguo-r9', 'weiguo-r10', 'weiguo-r11', 'weiguo-r12', 'weiguo-r13', 'weiguo-r14', 'weiguo-r15', 'weiguo-r16', 'weiguo-r17', 'weiguo-r18', 'weiguo-r19', 'weiguo-r20', 'weiguo-r21', 'weiguo-r22', 'weiguo-r23', 'weiguo-r24', 'weiguo-r25', 'weiguo-r26', 'weiguo-r27', 'weiguo-r28', 'weiguo-r29', 'weiguo-r30', 'weiguo-r31', 'weiguo-r32', 'weiguo-r33', 'weiguo-r34', 'weiguo-r35', 'weiguo-r36', 'weiguo-r37', 'weiguo-r38', 'weiguo-r39', 'weiguo-r40', 'weiguo-r41', 'weiguo-r42', 'weiguo-r43', 'weiguo-r44', 'weiguo-r45', 'weiguo-r46', 'zheng-r0', 'zheng-r1', 'zheng-r2', 'zheng-r3', 'zheng-r4', 'zheng-r5', 'zheng-r6', 'zheng-r7', 'zheng-r8', 'zheng-r9', 'zheng-r10', 'zheng-r11', 'zheng-r12', 'zheng-r13', 'zheng-r14', 'zheng-r15', 'zheng-r16', 'zheng-r17', 'zheng-r18', 'zheng-r19', 'zheng-r20', 'zheng-r21', 'zheng-r22', 'zheng-r23', 'zheng-r24', 'cao-r0', 'cao-r1', 'cao-r2', 'cao-r3', 'cao-r4', 'cao-r5', 'cao-r6', 'cao-r7', 'cao-r8', 'cao-r9', 'cao-r10', 'cao-r11', 'cao-r12', 'cao-r13', 'cao-r14', 'cao-r15', 'cao-r16', 'cao-r17', 'cao-r18', 'cao-r19', 'cao-r20', 'cao-r21', 'cao-r22', 'cao-r23', 'cao-r24', 'cao-r25', 'wu-r0', 'wu-r1', 'wu-r2', 'wu-r3', 'wu-r4', 'helu', 'fu-chai', 'yue-r0', 'yue-r1', 'yue-r2', 'yue-r3', 'yue-r4', 'gou-jian', 'yue-r6', 'yue-r7', 'yue-r8', 'yue-r9', 'yue-r10', 'yue-r11', 'yue-r12', 'yue-r13', 'zhongshan-r0', 'zhongshan-r1', 'zhongshan-r2', 'zhongshan-r3', 'zhongshan-r4', 'zhongshan-r5', 'han-jing', 'han-r1', 'han-r2', 'han-r3', 'han-r4', 'han-r5', 'han-r6', 'han-r7', 'han-r8', 'han-r9', 'han-r10', 'zhao-lie', 'zhao-r1', 'zhao-r2', 'zhao-r3', 'zhao-r4', 'zhao-r5', 'zhao-r6', 'zhao-r7', 'zhao-r8', 'zhao-r9', 'wei-wen', 'wei-r1', 'wei-r2', 'wei-r3', 'wei-r4', 'wei-r5', 'wei-r6', 'wei-r7', 'wei-r8', 'ying-qi', 'qin-r1', 'qin-r2', 'qin-r3', 'qin-r4', 'qin-r5', 'qin-r6', 'qin-r7', 'qin-r8', 'qin-r9', 'qin-r10', 'qin-r11', 'qin-r12', 'qin-r13', 'qin-r14', 'qin-r15', 'qin-r16', 'qin-r17', 'qin-r18', 'qin-r19', 'qin-r20', 'qin-r21', 'qin-r22', 'qin-r23', 'ying-quliang', 'qin-r25', 'qin-r26', 'qin-r27', 'qin-r28', 'qin-r29', 'ying-zheng', 'shang-yang', 'wu-qi', 'sun-wu', 'wu-zixu', 'fan-li', 'qu-yuan', 'lao-zi', 'meng-ke', 'zhuang-zhou', 'han-fei', 'sun-bin', 'bai-qi', 'wang-jian-qin', 'bian-que', 'ying-huhai', 'ying-ziying')
  AND NOT EXISTS (SELECT 1 FROM reigns r WHERE r.person_id = p.id)
  AND NOT EXISTS (SELECT 1 FROM event_participants ep WHERE ep.person_id = p.id)
  AND NOT EXISTS (
    SELECT 1 FROM relations rel
    WHERE (rel.from_type = 'person' AND rel.from_id = p.id)
       OR (rel.to_type = 'person' AND rel.to_id = p.id)
  );

COMMIT;
