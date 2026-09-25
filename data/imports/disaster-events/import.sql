-- EraLens period import: disaster-events
-- Window: 11-01 .. 1879-12
BEGIN;

-- persons

-- dynasties

-- reigns

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content, location_id) VALUES ('jianan-twenty-two-epidemic', '建安二十二年大疫', 'disaster', 'point', 'year', '建安二十二年（217）；按年精度记录。史料未能证明该场疫情始于196年，也不能据此确认为鼠疫或伤寒。', 217, 12, 2615, NULL, NULL, NULL, NULL, NULL, NULL, '建安二十二年，北方疫病流行。曹丕次年致吴质书追述亲友多遭疫病，陈琳、徐幹、应玚、刘桢相继去世；曹植《说疫气》也记述当年疫病造成的广泛死亡。疫情影响建安文人群体，但史料不足以判定具体病原或量化死亡人数。', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content, location_id = EXCLUDED.location_id;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content, location_id) VALUES ('xin-wei-commandery-yellow-river-breach', '新莽魏郡黄河决口与长期河患', 'disaster', 'circa', 'year', '《汉书·王莽传》载始建国三年河决魏郡；《后汉书·王景传》载永平十二年（69）修渠筑堤。河患具体逐年起讫不详，故用概略区间，不延伸为精确至70年的连续灾害。', NULL, NULL, NULL, 11, 1, 132, 69, 12, 839, '始建国三年（11），黄河在魏郡决口，泛滥至清河以东数郡，河水长期扰动下游水系并影响汴渠。东汉明帝永平十二年（69）朝廷命王景、王吴修渠筑堤，治理黄河与汴渠。此区间表示决口后长期河患至系统治理启动的概略时段，不表示每年均发生同等规模洪水。', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content, location_id = EXCLUDED.location_id;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content, location_id) VALUES ('ming-capital-epidemic-1643', '京师大疫', 'disaster', 'point', 'year', '崇祯十六年（1643）；史籍所记二月至九月为农历，事件按年精度记录，不将农历月份直接换算为公历月份。', 1643, 12, 19727, NULL, NULL, NULL, NULL, NULL, NULL, '崇祯十六年，北京发生严重疫病。《明史·五行志》记京师自二月至九月大疫，明末记述亦称死亡甚众。后世研究对当时疫病是否为鼠疫仍有不同判断，现有史料不足以确认具体病原或可靠死亡总数。', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content, location_id = EXCLUDED.location_id;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content, location_id) VALUES ('dingwu-north-china-famine', '丁戊奇荒', 'disaster', 'circa', 'year', '研究常以1876—1879年概括华北大饥荒，中文“丁戊”指灾情高峰所在的1877、1878年；部分资料将旱象追溯至1875年。此处用概略区间涵盖旱灾发展与灾后缓解，不采用有争议的死亡数字。', NULL, NULL, NULL, 1875, 1, 22500, 1879, 12, 22559, '晚清华北持续旱灾引发严重饥荒，山西、河南、陕西、直隶、山东等地受灾，灾情在1877—1878年尤重，并波及邻近地区。饥荒造成粮食短缺、人口流徙和大规模赈济；不同研究对灾害起讫及死亡规模的估计不一。', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content, location_id = EXCLUDED.location_id;

-- event_dynasties
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('jianan-twenty-two-epidemic', 'han-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xin-wei-commandery-yellow-river-breach', 'xin') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('xin-wei-commandery-yellow-river-breach', 'han-east') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('ming-capital-epidemic-1643', 'ming') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('dingwu-north-china-famine', 'qing') ON CONFLICT DO NOTHING;

-- event_participants

-- relations

COMMIT;
