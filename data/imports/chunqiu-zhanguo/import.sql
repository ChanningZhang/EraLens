-- EraLens period import: chunqiu-zhanguo
-- Window: -1046-01 .. -207-12 (Spring-Autumn & Warring States feudal states)
-- Chronology: Shiji + Wikipedia state lists
BEGIN;

-- persons
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'xiong-zhuang', '熊侣',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '楚庄王，春秋五霸之一，问鼎中原。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/楚庄王"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
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
  ARRAY['君主'], '秦孝公，任用商鞅变法，秦国由弱转强。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦孝公"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
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
  ARRAY['君主'], '秦襄公，护送周平王东迁，秦国始列为诸侯。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/秦襄公"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'gou-jian', '勾践',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '越国君主，卧薪尝胆，终灭吴国。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/勾践"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
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
  ARRAY['君主'], '吴王夫差，破越后骄纵，终为勾践所灭。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/夫差"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'wei-wen', '魏文侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '魏国开国君主，任用李悝、吴起，战国初强。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/魏文侯"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'han-jing', '韩景侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '韩国开国君主，前403年周天子正式册命。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/韩景侯"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;
INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  'zhao-lie', '赵烈侯',
  NULL, NULL,
  NULL, NULL,
  ARRAY['君主'], '赵国开国君主，与韩魏同受周室册命。', '[{"label":"维基百科","url":"https://zh.wikipedia.org/wiki/赵烈侯"}]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
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
  NULL, NULL,
  NULL, NULL,
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
  NULL, NULL,
  NULL, NULL,
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

-- dynasties
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'qi-chunqiu', '齐国', ARRAY['齐','姜齐','田齐'], 'cn', 'east_asia',
  -1046, 1, -221, 12,
  -12540, -2629, 'year', 'ochre', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'jin-chunqiu', '晋国', ARRAY['晋'], 'cn', 'east_asia',
  -1033, 1, -376, 12,
  -12384, -4489, 'year', 'indigo', NULL,
  '周成王封叔虞于唐，改国号晋；前403年三家分晋，公室至前376年废。'
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
  'chu-chunqiu', '楚国', ARRAY['楚','荆楚'], 'cn', 'east_asia',
  -1042, 1, -223, 12,
  -12492, -2653, 'year', 'moss', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'yan-chunqiu', '燕国', ARRAY['燕'], 'cn', 'east_asia',
  -1044, 1, -222, 12,
  -12516, -2641, 'year', 'mineral', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'song-chunqiu', '宋国', ARRAY['宋'], 'cn', 'east_asia',
  -1034, 1, -286, 12,
  -12396, -3409, 'year', 'cinnabar', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'lu-chunqiu', '鲁国', ARRAY['鲁'], 'cn', 'east_asia',
  -1042, 1, -256, 12,
  -12492, -3049, 'year', 'stone', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'wei-weiguo', '卫国', ARRAY['卫'], 'cn', 'east_asia',
  -1038, 1, -209, 12,
  -12444, -2485, 'year', 'grape', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'zheng-chunqiu', '郑国', ARRAY['郑'], 'cn', 'east_asia',
  -806, 1, -375, 12,
  -9660, -4477, 'year', 'wisteria', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'cao-chunqiu', '曹国', ARRAY['曹'], 'cn', 'east_asia',
  -1046, 1, -487, 12,
  -12540, -5821, 'year', 'ochre', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'wu-chunqiu', '吴国', ARRAY['吴'], 'cn', 'east_asia',
  -585, 1, -473, 12,
  -7008, -5653, 'year', 'indigo', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'yue-chunqiu', '越国', ARRAY['越'], 'cn', 'east_asia',
  -600, 1, -334, 12,
  -7188, -3985, 'year', 'moss', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'zhongshan', '中山', ARRAY['中山国'], 'cn', 'east_asia',
  -476, 1, -296, 12,
  -5700, -3529, 'year', 'mineral', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'han-warring', '韩国', ARRAY['韩'], 'cn', 'east_asia',
  -403, 1, -230, 12,
  -4824, -2737, 'year', 'cinnabar', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'zhao-warring', '赵国', ARRAY['赵'], 'cn', 'east_asia',
  -403, 1, -222, 12,
  -4824, -2641, 'year', 'stone', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'wei-warring', '魏国', ARRAY['魏','梁'], 'cn', 'east_asia',
  -403, 1, -225, 12,
  -4824, -2677, 'year', 'grape', NULL,
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
  note = EXCLUDED.note;
INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  'qin', '秦', ARRAY['嬴秦','秦国'], 'cn', 'east_asia',
  -770, 1, -207, 12,
  -9228, -2461, 'year', 'ochre', NULL,
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
  note = EXCLUDED.note;

-- reigns
INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  'reign-lv-shang-qi-chunqiu', 'qi-chunqiu', 'lv-shang', '齐太公',
  '太公', NULL, '{"kind":"posthumous","name":"齐太公"}'::jsonb,
  -1046, 1, -1043, 12,
  -12540, -12493, 'year'
)
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
  'reign-jiang-xiaobai-qi-chunqiu', 'qi-chunqiu', 'jiang-xiaobai', '齐桓公',
  '桓公', NULL, '{"kind":"posthumous","name":"齐桓公"}'::jsonb,
  -685, 1, -643, 12,
  -8208, -7693, 'year'
)
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
  'reign-ji-chonger-jin-chunqiu', 'jin-chunqiu', 'ji-chonger', '晋文公',
  '文公', NULL, '{"kind":"posthumous","name":"晋文公"}'::jsonb,
  -636, 1, -628, 12,
  -7620, -7513, 'year'
)
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
  'reign-xiong-zhuang-chu-chunqiu', 'chu-chunqiu', 'xiong-zhuang', '楚庄王',
  '庄王', NULL, '{"kind":"posthumous","name":"楚庄王"}'::jsonb,
  -613, 1, -591, 12,
  -7344, -7069, 'year'
)
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
  'reign-ying-qi-qin', 'qin', 'ying-qi', '秦襄公',
  '襄公', NULL, '{"kind":"posthumous","name":"秦襄公"}'::jsonb,
  -770, 1, -766, 12,
  -9228, -9169, 'year'
)
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
  'reign-ying-quliang-qin', 'qin', 'ying-quliang', '秦孝公',
  '孝公', NULL, '{"kind":"posthumous","name":"秦孝公"}'::jsonb,
  -361, 1, -338, 12,
  -4320, -4033, 'year'
)
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
  'reign-fu-chai-wu-chunqiu', 'wu-chunqiu', 'fu-chai', '吴王夫差',
  '夫差', NULL, '{"kind":"posthumous","name":"吴王夫差"}'::jsonb,
  -495, 1, -473, 12,
  -5928, -5653, 'year'
)
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
  'reign-gou-jian-yue-chunqiu', 'yue-chunqiu', 'gou-jian', '越王勾践',
  '勾践', NULL, '{"kind":"posthumous","name":"越王勾践"}'::jsonb,
  -496, 1, -465, 12,
  -5940, -5557, 'year'
)
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
  'reign-wei-wen-wei-warring', 'wei-warring', 'wei-wen', '魏文侯',
  '文侯', NULL, '{"kind":"posthumous","name":"魏文侯"}'::jsonb,
  -424, 1, -387, 12,
  -5076, -4621, 'year'
)
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
  'reign-han-jing-han-warring', 'han-warring', 'han-jing', '韩景侯',
  '景侯', NULL, '{"kind":"posthumous","name":"韩景侯"}'::jsonb,
  -408, 1, -400, 12,
  -4884, -4777, 'year'
)
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
  'reign-zhao-lie-zhao-warring', 'zhao-warring', 'zhao-lie', '赵烈侯',
  '烈侯', NULL, '{"kind":"posthumous","name":"赵烈侯"}'::jsonb,
  -403, 1, -387, 12,
  -4824, -4621, 'year'
)
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

-- event_dynasties (new + links to xia-shang-zhou events)
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('shangyang-reform', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wuqi-reform-wei', 'wei-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wu-destroy-yue', 'yue-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('wu-destroy-yue', 'wu-chunqiu') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-han', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-han', 'han-warring') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-chu', 'qin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('qin-destroy-chu', 'chu-chunqiu') ON CONFLICT DO NOTHING;
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

COMMIT;
