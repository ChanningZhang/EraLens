-- EraLens import: event locations
BEGIN;

-- event_locations
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-feng-lang-ju-xu', '狼居胥山', '蒙古国肯特山脉一带', 109.5, 48.5, 'WGS84', 'approximate', '狼居胥山通常比定为今蒙古国肯特山一带，具体对应仍有历史地理争议；坐标为山脉区域近似代表点，不指向确定峰顶。另有其他考定，故精度为 approximate。', '[{"label":"《汉书·卫青霍去病传》","url":"https://zh.wikisource.org/zh-hans/漢書/卷055"},{"label":"肯特山（蒙古国）","url":"https://zh.wikipedia.org/wiki/肯特山_(蒙古国)"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-kublai-moves-capital-to-zhongdu', '中都（今北京）', '北京市', 116.397, 39.916, 'WGS84', 'approximate', '以迁入的金中都旧城区域为代表点；忽必烈此后在中都东北营建元大都，坐标不表示元大都城址。', '[{"label":"北京市地方志：忽必烈迁都中都、元迁都大都","url":"https://www.bjdsdfz.cn/jcdq.jhtml"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-zhou-nanwang-moves-to-western-zhou-capital', '西周国王城', '河南省洛阳市西工区东周王城遗址', 112.437, 34.672, 'WGS84', 'approximate', '周赧王迁居西周国王城的代表点；具体迁居年份有异说，遗址定位依都城资料。', '[{"label":"东周王城遗址","url":"https://zh.wikipedia.org/wiki/东周王城"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-sui-moves-to-daxing', '大兴城', '陕西省西安市', 108.939, 34.248, 'WGS84', 'approximate', '迁入新建大兴城，坐标取西安城市范围的代表点，不表示单一宫殿或遗址坐标。', '[{"label":"陕西省地方志：西安市志","url":"https://dfz.shaanxi.gov.cn/zslm/fzzlk/xbsxsxz/xbsxz/xas_16198/201405/P020240923625160882829.pdf"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-wu-zhou-moves-capital-to-luoyang', '神都洛阳', '河南省洛阳市', 112.454, 34.619, 'WGS84', 'approximate', '迁都目的地为洛阳；坐标取古城区域中心。', '[{"label":"《旧唐书·则天皇后本纪》","url":"https://zh.wikisource.org/zh-hans/舊唐書/卷六"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-tang-forced-move-to-luoyang', '东都洛阳', '河南省洛阳市', 112.454, 34.619, 'WGS84', 'approximate', '事件中心是唐廷被迫迁入洛阳；坐标取古城区域中心。', '[{"label":"《旧唐书·昭宗本纪》","url":"https://zh.wikisource.org/zh-hans/舊唐書/卷二十上"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-tang-restored-capital-to-changan', '长安', '陕西省西安市', 108.94, 34.34, 'WGS84', 'approximate', '以唐朝还都目的地长安为代表点，取城市范围中心。', '[{"label":"《旧唐书·中宗本纪》","url":"https://zh.wikisource.org/zh-hans/舊唐書/卷七"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-song-moves-capital-to-linan', '临安府', '浙江省杭州市', 120.155, 30.274, 'WGS84', 'approximate', '以南宋正式定为行在的临安府为代表点，取杭州城市范围中心。', '[{"label":"《宋史·高宗本纪》","url":"https://zh.wikisource.org/zh-hans/宋史/卷二十五"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-ming-moves-capital-to-beijing', '北京', '北京市', 116.397, 39.916, 'WGS84', 'approximate', '迁都目的地为北京；坐标取城市范围中心。', '[{"label":"中国大运河博物馆：永乐迁都","url":"https://m.canalmuseum.org.cn/res/mpwork/be39852bcd974f12962108850c059dfb.pdf"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-roc-moves-wartime-government-to-chongqing', '重庆', '重庆市', 106.551, 29.563, 'WGS84', 'approximate', '国民政府迁渝，以重庆主城区为代表点；不表示迁移路线或战时陪都全部范围。', '[{"label":"重庆市政协：国民政府迁都重庆史料","url":"https://www.cqzx.gov.cn"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-roc-returns-capital-to-nanjing', '南京', '江苏省南京市', 118.797, 32.06, 'WGS84', 'approximate', '还都目的地南京，以城市范围中心为代表点。', '[{"label":"国民政府还都南京","url":"https://zh.wikipedia.org/wiki/國民政府還都"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-zhou-jingwang-moves-to-chengzhou', '成周（汉魏洛阳故城区域）', '河南省洛阳市瀍河回族区汉魏洛阳故城', 112.589, 34.728, 'WGS84', 'approximate', '迁都目的地为成周；坐标取汉魏洛阳故城区域，具体古城范围按遗址定位。', '[{"label":"成周","url":"https://zh.wikipedia.org/wiki/成周"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-pangeng-move-yin', '殷（殷墟）', '河南省安阳市殷都区殷墟遗址', 114.316, 36.125, 'WGS84', 'approximate', '以盘庚迁殷后的商都殷为代表点；遗址范围较大，坐标仅作区域定位。', '[{"label":"殷墟","url":"https://zh.wikipedia.org/wiki/殷墟"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-pingwang-eastward', '东周王城', '河南省洛阳市西工区东周王城遗址', 112.437, 34.672, 'WGS84', 'approximate', '平王东迁的目的地为王城；坐标取东周王城遗址区域。', '[{"label":"东周王城遗址","url":"https://zh.wikipedia.org/wiki/东周王城"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-yuan-moves-capital-to-dadu', '大都（元大都）', '北京市', 116.397, 39.916, 'WGS84', 'approximate', '以元大都城址区域为迁都目的地代表点；上都继续作为夏都，事件地点仅标示新定都中心。', '[{"label":"北京市地方志：忽必烈迁都中都、元迁都大都","url":"https://www.bjdsdfz.cn/jcdq.jhtml"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-qing-enter-pass', '北京', '北京市', 116.397, 39.916, 'WGS84', 'approximate', '清廷迁都目的地为北京；该事件同时叙述清军入关，地点点位只标迁都中心，不代表军事行动范围。', '[{"label":"故宫博物院：清廷迁都北京","url":"https://www.dpm.org.cn/court/event/159873.html"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-taiping-capital-tianjing', '天京（江宁）', '江苏省南京市', 118.797, 32.06, 'WGS84', 'approximate', '太平军攻克江宁后以此为都，坐标取南京城市范围中心。', '[{"label":"太平天国定都天京","url":"https://zh.wikipedia.org/wiki/天京"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-hongmen-banquet', '新丰鸿门', '陕西省西安市临潼区新丰街道鸿门堡村鸿门坂遗址', 109.272, 34.412, 'WGS84', 'approximate', '《史记·项羽本纪》称项羽驻军新丰鸿门。采用今鸿门堡村鸿门坂遗址附近作代表点；宴会遗址为后世认定位置，不将景区建筑视为汉代原址。', '[{"label":"《史记·项羽本纪》","url":"https://zh.wikisource.org/wiki/史記/卷007"},{"label":"鸿门宴遗址地址与定位","url":"https://ditu.amap.com/place/B001D00964"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-daze-township', '大泽乡', '安徽省宿州市埇桥区大泽乡镇一带', 117.19, 33.65, 'WGS84', 'approximate', '《史记·陈涉世家》记九百戍卒屯大泽乡并在此起事。今大泽乡镇为通行对应地，古乡具体边界及起事点未能精确复原，坐标仅标示区域。', '[{"label":"《史记·陈涉世家》","url":"https://zh.wikisource.org/wiki/史記/卷048"},{"label":"大泽乡历史地名","url":"https://www.cidianwang.com/lishi/diming/5/36215jk.htm"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-wulei-city', '乌垒城（西域都护府治所）', '新疆维吾尔自治区巴音郭楞蒙古自治州轮台县东南乌垒古城区域', 84.25, 41.55, 'WGS84', 'approximate', '西域都护府初治乌垒城，故以轮台县境内遗址区域为设置地点代表。乌垒城具体考古对应遗址尚有不同意见，奎玉克协海尔古城、卓尔库特古城等均有相关考证；坐标仅示轮台县东南候选区域，不代表已确认遗址中心。', '[{"label":"《汉书·西域传》","url":"https://zh.wikisource.org/wiki/漢書/卷096下"},{"label":"央广网：乌垒城与西域都护府驻地","url":"https://www.cnr.cn/yuleguangbo/pinlvxinw/20161221/t20161221_523372915.shtml"},{"label":"轮台县西域都护府遗址群考古资料","url":"https://www.xjlt.gov.cn/xjltx/c1104328/202503/10f62e4cb6d84501b372a5966eb9b518/files/42.%E8%BD%AE%E5%8F%B0%E5%8E%BF%E8%A5%BF%E5%9F%9F%E9%83%BD%E6%8A%A4%E5%BA%9C%E9%81%97%E5%9D%80%E7%BE%A4%EF%BC%88%E5%8D%93%E5%B0%94%E5%BA%93%E7%89%B9%E5%8F%A4%E5%9F%8E%EF%BC%89%E8%80%83%E5%8F%A4%E9%81%97%E5%9D%80%E5%85%AC%E5%9B%AD%E7%A0%94%E7%A9%B6%E4%BF%9D%E6%8A%A4%E4%B8%AD%E5%BF%832025%E5%B9%B4%E5%8D%95%E4%BD%8D%E9%A2%84%E7%AE%97%E5%85%AC%E5%BC%80%E6%8A%A5%E5%91%8A-20251126165408544.pdf"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-julu-yellow-turban', '巨鹿郡及冀州起义中心', '河北省邢台市巨鹿县一带', 115.037, 37.221, 'WGS84', 'approximate', '黄巾军在多个州郡同时起事，张角领导的核心力量活动于冀州，后以广宗等地为据点。此处取巨鹿郡作为起义组织的代表区域，不表示全部起义范围或单一爆发点。', '[{"label":"《后汉书·皇甫嵩朱儁列传》","url":"https://zh.wikisource.org/wiki/後漢書/卷071"},{"label":"黄巾之乱：起义范围与冀州中心","url":"https://www.cne3online.com/culture/view/11543616/11561454609091.shtml"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-yuanju', '曹州冤句', '山东省菏泽市牡丹区西南一带', 115.35, 35.1, 'WGS84', 'approximate', '黄巢起义持续十余年并转战多地；据乾符二年黄巢在曹州冤句起兵的记载，取冤句故地作起事代表点。冤句故城具体位置有考证差异，坐标仅表示菏泽西南区域。', '[{"label":"《新唐书·黄巢传》","url":"https://zh.wikisource.org/wiki/新唐書/卷225下"},{"label":"山东地情档案：黄巢籍贯考略","url":"https://shandong-chorography.org/database/fa01/section/3/article/60/"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-chenqiao', '陈桥驿', '河南省新乡市封丘县陈桥镇陈桥村', 114.46, 35.03, 'WGS84', 'approximate', '《续资治通鉴长编》卷一记赵匡胤军至陈桥驿后被拥立。按封丘县陈桥镇陈桥村陈桥驿遗址区域定位，坐标为遗址近似点。', '[{"label":"《续资治通鉴长编》卷一","url":"https://zh.wikisource.org/wiki/續資治通鑑長編/卷001"},{"label":"封丘县人民政府：陈桥驿","url":"https://www.fengqiu.gov.cn/mlfq/tpfq/1074690.html"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-gaoping-tombs-incident', '洛阳（洛水浮桥）；高平陵在今汝阳县茹店村一带', '河南省洛阳市；高平陵遗址位于洛阳市汝阳县茹店村一带', 112.453, 34.619, 'WGS84', 'approximate', '政变主行动为司马懿控制京城洛阳及洛水浮桥，坐标取洛阳古城区域中心；曹芳当日赴高平陵谒陵，高平陵遗址约在今汝阳县茹店村。该点表示政变控制中心，不表示陵址坐标。', '[{"label":"《三国志·魏书·齐王纪》","url":"https://zh.wikisource.org/zh-hans/三國志/卷04"},{"label":"高平陵","url":"https://zh.wikipedia.org/wiki/高平陵"},{"label":"河南省文物局：第七批全国重点文物保护单位保护范围和建设控制地带","url":"https://wgl.kaifeng.gov.cn/kfswhgdhlyj/swgljwbdw/1805436537969889280/M71CbQHO.pdf"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-baiteng', '白登山', '山西省大同市云州区周士庄镇马铺山', 113.37025, 40.13972, 'WGS84', 'approximate', '采用马铺山说作近似定位；白登山的具体位置仍有争议，另有采凉山等说。', '[{"label":"云州区人民政府：白登之战遗址","url":"https://www.yunzhou.gov.cn/yzqrmzfz/sqglcyjj/202007/7efb8d970c9c42b9b94471068b663e55.shtml"},{"label":"白登山汉代遗迹调查","url":"https://m.fx361.com/news/2018/0814/16088578.html"},{"label":"大同市平城区人民政府：白登山定位争议","url":"https://www.pingcheng.gov.cn/pcqrmzfz/pingcheng1/202407/46e23c04a12f4ae1ad034e0ef57d8039.shtml"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-changban', '长坂', '湖北省荆门市掇刀区长坂坡', 112.211, 30.965, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/长坂坡之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-xiaoyaojin', '逍遥津', '安徽省合肥市庐阳区逍遥津公园', 117.302, 31.873, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/逍遥津之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-hanzhong', '汉中', '陕西省汉中市', 107.023, 33.067, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/汉中之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-dingjunshan', '定军山', '陕西省汉中市勉县定军山镇', 106.674, 33.118, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/定军山之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-xiangfan', '襄阳、樊城', '湖北省襄阳市襄城区、樊城区', 112.145, 32.043, 'WGS84', 'approximate', '战事横跨襄阳、樊城及汉水沿线，以两城间汉水为地图标点。', '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/樊城之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-ruxu', '濡须口', '安徽省芜湖市无为市裕溪河入长江口一带', 117.78, 31.3, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/濡须之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-jieting', '街亭', '甘肃省天水市秦安县陇城镇一带', 105.68, 34.96, 'WGS84', 'approximate', '街亭具体故址有争议，取通行考定区域。', '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/街亭之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-shiting', '石亭', '安徽省安庆市潜山市至桐城市一带', 116.95, 31.04, 'WGS84', 'approximate', '古石亭故址有不同考定，坐标为约略区域中心。', '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/石亭之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-wuzhangyuan', '五丈原', '陕西省宝鸡市岐山县五丈原镇', 107.63, 34.3, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/五丈原"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-guandu', '官渡', '河南省郑州市中牟县官渡镇', 113.98, 34.72, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/官渡之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-chibi', '赤壁、乌林', '湖北省咸宁市赤壁市赤壁镇至洪湖市乌林镇', 113.63, 29.89, 'WGS84', 'approximate', '传统主流定位取蒲圻（今赤壁市）一带，具体战场仍有嘉鱼等异说；标示赤壁、乌林之间的大致区域。', '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/赤壁之戰"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-yiling', '夷陵、猇亭', '湖北省宜昌市夷陵区至猇亭区', 111.42, 30.95, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/夷陵之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-guiling', '桂陵', '河南省开封市兰考县一带', 114.82, 34.82, 'WGS84', 'approximate', '桂陵故址考定不一，采用通行的兰考说，坐标仅作区域定位。', '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/桂陵之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-maling', '马陵', '山东省聊城市莘县大张家镇', 115.55, 36.16, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/馬陵之戰"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-changping', '长平', '山西省晋城市高平市长平之战遗址', 112.92, 35.8, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/长平之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-julu', '巨鹿', '河北省邢台市巨鹿县', 115.04, 37.22, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/巨鹿之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-gaixia', '垓下', '安徽省宿州市灵璧县东南一带', 117.62, 33.43, 'WGS84', 'approximate', '垓下位置存在灵璧、固镇等说，采用灵璧东南说作近似标点。', '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/垓下"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-kunyang', '昆阳', '河南省平顶山市叶县古城一带', 113.35, 33.62, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/昆阳之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-feishui', '淝水', '安徽省淮南市寿县东南', 116.82, 32.5, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/淝水之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-hulao', '虎牢关', '河南省郑州市荥阳市汜水镇虎牢关遗址', 113.13, 34.91, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/虎牢之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-qin-liang-dingtao', '定陶', '山东省菏泽市定陶区', 115.57, 35.07, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/项梁"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-yancheng', '郾城', '河南省漯河市郾城区', 113.98, 33.59, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/郾城之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-caishi', '采石矶', '安徽省马鞍山市雨山区采石街道', 118.49, 31.66, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/采石之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-gaoliang-river', '高梁河', '北京市海淀区高梁河一带', 116.34, 39.95, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/高梁河之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-xiangyang-siege', '襄阳', '湖北省襄阳市襄城区', 112.14, 32.01, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/襄阳之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-yashan', '崖山、厓门', '广东省江门市新会区古井镇崖门水道', 113.09, 22.27, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/崖门海战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-tianjing', '天京', '江苏省南京市', 118.8, 32.06, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/天京之役"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-gaogouli-pyongyang', '平壤城', '朝鲜民主主义人民共和国平壤市', 125.75, 39.02, 'WGS84', 'approximate', '668年唐与新罗联军攻陷平壤，高句丽灭亡。', '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/高句丽"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-chimei-changan', '长安', '陕西省西安市', 108.94, 34.34, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/赤眉军"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-ming-capture-dadu', '大都', '北京市', 116.4, 39.9, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/元大都"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-tumu', '土木堡', '河北省张家口市怀来县土木镇', 115.62, 40.39, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/土木之变"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-beijing-defense', '北京', '北京市', 116.4, 39.9, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/北京保卫战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-sarhu', '萨尔浒', '辽宁省抚顺市东洲区萨尔浒山', 124.06, 41.89, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/萨尔浒之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-ningyuan', '宁远', '辽宁省葫芦岛市兴城市古城', 120.73, 40.62, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/宁远之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-songjin', '松山、锦州', '辽宁省锦州市凌海市至锦州市区', 121.15, 41.1, 'WGS84', 'approximate', '松山、锦州两处攻防构成战役主体，坐标取二地之间的近似位置。', '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/松锦之战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-taiwan-conquest', '澎湖、台湾', '台湾海峡澎湖群岛至台湾岛', 119.57, 23.57, 'WGS84', 'approximate', '事件涵盖澎湖海战与郑克塽在台湾降清，以澎湖为代表性标点。', '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/澎湖海战"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-poyang-lake-battle', '鄱阳湖', '江西省鄱阳湖南昌附近水域', 116.2, 29.05, 'WGS84', 'approximate', '战役发生于鄱阳湖及湖口一带水域，取湖区近南昌侧的近似标点；具体交战水域随战事推进而变化。', '[{"label":"鄱阳湖之战","url":"https://zh.wikipedia.org/wiki/鄱阳湖之战"},{"label":"鄱阳湖保护区资料","url":"https://www.fnrrc.com/ziranbaohuqujianjie/9912.html"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-korqin-sea-battle', '捕鱼儿海（贝尔湖）', '中蒙边界贝尔湖一带', 117.706, 47.802, 'WGS84', 'approximate', '捕鱼儿海即今贝尔湖；战场为湖岸及其东北方向营地一带，取湖区作近似标点。', '[{"label":"明太祖第六次北伐（捕鱼儿海之战）","url":"https://zh.wikipedia.org/wiki/明太祖第六次北伐"},{"label":"贝尔湖","url":"https://zh.wikipedia.org/wiki/贝尔湖"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
INSERT INTO event_locations (id, historical_name, modern_name, longitude, latitude, coordinate_system, precision, note, links)
VALUES ('loc-yinping', '阴平道（阴平故城区域）', '甘肃省陇南市文县鹄衣坝附近', 104.6835, 32.944031, 'WGS84', 'approximate', '以汉代阴平道故城所在的文县区域作近似标点；偷渡路线由此向东南越摩天岭，经今四川平武方向至江油关，坐标不代表全程。阴平道具体线路尚有不同考证。', '[{"label":"《三国志·魏书·邓艾传》","url":"https://zh.wikisource.org/zh-hans/三國志/卷28"},{"label":"蜀道寻踪：阴平古道记","url":"https://cbgc.scol.com.cn/news/5026693"},{"label":"文县中心坐标","url":"https://www.poi86.com/poi/amap/district/621222/2.html"}]'::jsonb)
ON CONFLICT (id) DO UPDATE SET historical_name = EXCLUDED.historical_name, modern_name = EXCLUDED.modern_name, longitude = EXCLUDED.longitude, latitude = EXCLUDED.latitude, coordinate_system = EXCLUDED.coordinate_system, precision = EXCLUDED.precision, note = EXCLUDED.note, links = EXCLUDED.links;
UPDATE events SET location_id = 'loc-feng-lang-ju-xu' WHERE id = 'idiom-feng-lang-ju-xu';
UPDATE events SET location_id = 'loc-kublai-moves-capital-to-zhongdu' WHERE id = 'kublai-moves-capital-to-zhongdu';
UPDATE events SET location_id = 'loc-zhou-nanwang-moves-to-western-zhou-capital' WHERE id = 'zhou-nanwang-moves-to-western-zhou-capital';
UPDATE events SET location_id = 'loc-sui-moves-to-daxing' WHERE id = 'sui-moves-to-daxing';
UPDATE events SET location_id = 'loc-wu-zhou-moves-capital-to-luoyang' WHERE id = 'wu-zhou-moves-capital-to-luoyang';
UPDATE events SET location_id = 'loc-tang-forced-move-to-luoyang' WHERE id = 'tang-forced-move-to-luoyang';
UPDATE events SET location_id = 'loc-tang-restored-capital-to-changan' WHERE id = 'tang-restored-capital-to-changan';
UPDATE events SET location_id = 'loc-song-moves-capital-to-linan' WHERE id = 'song-moves-capital-to-linan';
UPDATE events SET location_id = 'loc-ming-moves-capital-to-beijing' WHERE id = 'ming-moves-capital-to-beijing';
UPDATE events SET location_id = 'loc-roc-moves-wartime-government-to-chongqing' WHERE id = 'roc-moves-wartime-government-to-chongqing';
UPDATE events SET location_id = 'loc-roc-returns-capital-to-nanjing' WHERE id = 'roc-returns-capital-to-nanjing';
UPDATE events SET location_id = 'loc-zhou-jingwang-moves-to-chengzhou' WHERE id = 'zhou-jingwang-moves-to-chengzhou';
UPDATE events SET location_id = 'loc-pangeng-move-yin' WHERE id = 'pangeng-move-yin';
UPDATE events SET location_id = 'loc-pingwang-eastward' WHERE id = 'pingwang-eastward';
UPDATE events SET location_id = 'loc-yuan-moves-capital-to-dadu' WHERE id = 'yuan-moves-capital-to-dadu';
UPDATE events SET location_id = 'loc-qing-enter-pass' WHERE id = 'qing-enter-pass';
UPDATE events SET location_id = 'loc-taiping-capital-tianjing' WHERE id = 'taiping-capital-tianjing';
UPDATE events SET location_id = 'loc-hongmen-banquet' WHERE id = 'hongmen-banquet';
UPDATE events SET location_id = 'loc-daze-township' WHERE id = 'daze-uprising';
UPDATE events SET location_id = 'loc-wulei-city' WHERE id = 'western-han-protectorate-of-western-regions';
UPDATE events SET location_id = 'loc-julu-yellow-turban' WHERE id = 'yellow-turban';
UPDATE events SET location_id = 'loc-yuanju' WHERE id = 'huang-chao-uprising';
UPDATE events SET location_id = 'loc-chenqiao' WHERE id = 'chenqiao-mutiny';
UPDATE events SET location_id = 'loc-gaoping-tombs-incident' WHERE id = 'gaoping-tombs-incident';
UPDATE events SET location_id = 'loc-baiteng' WHERE id = 'baiteng-siege';
UPDATE events SET location_id = 'loc-changban' WHERE id = 'changban';
UPDATE events SET location_id = 'loc-xiaoyaojin' WHERE id = 'xiaoyaojin';
UPDATE events SET location_id = 'loc-hanzhong' WHERE id = 'hanzhong';
UPDATE events SET location_id = 'loc-dingjunshan' WHERE id = 'dingjunshan';
UPDATE events SET location_id = 'loc-xiangfan' WHERE id = 'xiangfan';
UPDATE events SET location_id = 'loc-ruxu' WHERE id = 'ruxu';
UPDATE events SET location_id = 'loc-jieting' WHERE id = 'jieting';
UPDATE events SET location_id = 'loc-shiting' WHERE id = 'shiting';
UPDATE events SET location_id = 'loc-wuzhangyuan' WHERE id = 'wuzhangyuan';
UPDATE events SET location_id = 'loc-guandu' WHERE id = 'guandu';
UPDATE events SET location_id = 'loc-chibi' WHERE id = 'chibi';
UPDATE events SET location_id = 'loc-yiling' WHERE id = 'yiling';
UPDATE events SET location_id = 'loc-guiling' WHERE id = 'guiling-battle';
UPDATE events SET location_id = 'loc-maling' WHERE id = 'maling-battle';
UPDATE events SET location_id = 'loc-changping' WHERE id = 'changping-battle';
UPDATE events SET location_id = 'loc-julu' WHERE id = 'julu-battle';
UPDATE events SET location_id = 'loc-gaixia' WHERE id = 'gaixia';
UPDATE events SET location_id = 'loc-kunyang' WHERE id = 'kunyang-battle';
UPDATE events SET location_id = 'loc-feishui' WHERE id = 'feishui-battle';
UPDATE events SET location_id = 'loc-hulao' WHERE id = 'hulao-battle';
UPDATE events SET location_id = 'loc-qin-liang-dingtao' WHERE id = 'xiangliang-death';
UPDATE events SET location_id = 'loc-yancheng' WHERE id = 'yancheng-battle';
UPDATE events SET location_id = 'loc-caishi' WHERE id = 'caishi-battle';
UPDATE events SET location_id = 'loc-gaoliang-river' WHERE id = 'gaoliang-river-battle';
UPDATE events SET location_id = 'loc-xiangyang-siege' WHERE id = 'xiangyang-siege';
UPDATE events SET location_id = 'loc-yashan' WHERE id = 'yashan-battle';
UPDATE events SET location_id = 'loc-tianjing' WHERE id = 'fall-of-tianjing';
UPDATE events SET location_id = 'loc-gaogouli-pyongyang' WHERE id = 'gaogouli-destroyed-tang';
UPDATE events SET location_id = 'loc-chimei-changan' WHERE id = 'chimei-capture-changan';
UPDATE events SET location_id = 'loc-ming-capture-dadu' WHERE id = 'ming-capture-dadu';
UPDATE events SET location_id = 'loc-tumu' WHERE id = 'tumu-crisis';
UPDATE events SET location_id = 'loc-beijing-defense' WHERE id = 'beijing-defense';
UPDATE events SET location_id = 'loc-sarhu' WHERE id = 'sarhu-battle';
UPDATE events SET location_id = 'loc-ningyuan' WHERE id = 'ningyuan-battle';
UPDATE events SET location_id = 'loc-songjin' WHERE id = 'songjin-campaign';
UPDATE events SET location_id = 'loc-taiwan-conquest' WHERE id = 'qing-conquer-taiwan';
UPDATE events SET location_id = 'loc-poyang-lake-battle' WHERE id = 'poyang-lake-battle';
UPDATE events SET location_id = 'loc-korqin-sea-battle' WHERE id = 'korqin-sea-battle';
UPDATE events SET location_id = 'loc-yinping' WHERE id = 'deng-ai-crosses-yinping';

COMMIT;
