-- EraLens import: event locations
BEGIN;

-- event_locations
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
VALUES ('loc-hulao', '虎牢关', '河南省郑州市荥阳市汜水镇虎牢关遗址', 113.13, 34.91, 'WGS84', 'approximate', NULL, '[{"label":"地点资料","url":"https://zh.wikipedia.org/wiki/虎牢关之战"}]'::jsonb)
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

COMMIT;
