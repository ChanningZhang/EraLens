-- EraLens period import: financial-events
-- Window: 1024-01 .. 1935-12
BEGIN;

-- persons

-- dynasties

-- reigns

-- events
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content, location_id) VALUES ('finance-official-jiaozi-issued', '官交子发行', 'finance', 'point', 'month', '天圣二年（1024）二月官交子正式发行；益州交子务于前一年设立。', 1024, 2, 12289, NULL, NULL, NULL, NULL, NULL, NULL, '北宋在益州设交子务，收归民间交子发行权并开始发行官交子。纸币用于缓解四川铁钱沉重、携带不便造成的交易困难，成为国家管理纸币发行的早期制度实践。', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content, location_id = EXCLUDED.location_id;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content, location_id) VALUES ('finance-qing-fixed-ding-tax', '滋生人丁永不加赋', 'finance', 'point', 'year', '康熙五十一年（1712）颁旨；后续各省执行与丁银摊入田亩并非同一时点。', 1712, 12, 20555, NULL, NULL, NULL, NULL, NULL, NULL, '清廷以康熙五十年（1711）在册丁额为定额，规定此后新增人丁不再增加丁银。政策冻结人头税总额，为雍正时期将丁银摊入田赋的改革奠定制度背景。', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content, location_id = EXCLUDED.location_id;
INSERT INTO events (id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs, start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content, location_id) VALUES ('finance-fabi-reform', '法币改革', 'finance', 'point', 'month', '财政部于1935年11月3日公布改革办法，自11月4日起实施。', 1935, 11, 23230, NULL, NULL, NULL, NULL, NULL, NULL, '国民政府将中央、中国、交通三家银行发行的钞票定为法币，集中钞票发行与兑换管理，并停止以银元和白银作为流通货币。改革改变了中国币制和白银货币流通格局。', NULL, NULL, NULL)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary, meaning = EXCLUDED.meaning, content = EXCLUDED.content, location_id = EXCLUDED.location_id;

-- event_dynasties
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('finance-official-jiaozi-issued', 'song-north') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('finance-qing-fixed-ding-tax', 'qing') ON CONFLICT DO NOTHING;
INSERT INTO event_dynasties (event_id, dynasty_id) VALUES ('finance-fabi-reform', 'roc') ON CONFLICT DO NOTHING;

-- event_participants

-- relations

COMMIT;
