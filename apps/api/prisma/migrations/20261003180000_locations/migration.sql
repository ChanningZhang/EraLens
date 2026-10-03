BEGIN;
CREATE TABLE locations (
 id TEXT PRIMARY KEY, modern_name TEXT NOT NULL,
 longitude DECIMAL(10,7) NOT NULL CHECK (longitude BETWEEN -180 AND 180),
 latitude DECIMAL(10,7) NOT NULL CHECK (latitude BETWEEN -90 AND 90),
 coordinate_system TEXT NOT NULL CHECK (coordinate_system IN ('GCJ02','WGS84')),
 UNIQUE(modern_name,longitude,latitude,coordinate_system)
);
CREATE TABLE location_mapping (
 id TEXT PRIMARY KEY, location_id TEXT NOT NULL REFERENCES locations(id) ON DELETE RESTRICT ON UPDATE CASCADE,
 kind TEXT NOT NULL CHECK (kind IN ('dynasty','reign','event')), external_id TEXT NOT NULL,
 historical_name TEXT NOT NULL, spatial_precision TEXT,
 start_year INTEGER, start_month INTEGER, start_day INTEGER, end_year INTEGER, end_month INTEGER, end_day INTEGER,
 start_abs INTEGER, end_abs INTEGER, start_confidence TEXT, end_confidence TEXT, role TEXT,
 note TEXT, links JSONB NOT NULL DEFAULT '[]',
 CHECK ((kind='event' AND start_year IS NULL AND start_month IS NULL AND start_day IS NULL AND end_year IS NULL AND end_month IS NULL AND end_day IS NULL AND start_abs IS NULL AND end_abs IS NULL AND start_confidence IS NULL AND end_confidence IS NULL AND role IS NULL)
   OR (kind IN ('dynasty','reign') AND start_year IS NOT NULL AND start_month IS NOT NULL AND end_year IS NOT NULL AND end_month IS NOT NULL AND start_abs IS NOT NULL AND end_abs IS NOT NULL AND start_confidence IS NOT NULL AND end_confidence IS NOT NULL AND role IS NOT NULL AND role IN ('primary','secondary','temporary') AND end_abs>=start_abs))
);
CREATE INDEX location_mapping_kind_external_id_idx ON location_mapping(kind,external_id);
CREATE INDEX location_mapping_location_id_idx ON location_mapping(location_id);
CREATE INDEX location_mapping_start_abs_end_abs_idx ON location_mapping(start_abs,end_abs);
INSERT INTO locations(id,modern_name,longitude,latitude,coordinate_system)
 SELECT 'loc-' || md5(modern_name || chr(31) || longitude::text || chr(31) || latitude::text || chr(31) || coordinate_system),modern_name,longitude,latitude,coordinate_system FROM dynasty_capitals
 UNION SELECT 'loc-' || md5(modern_name || chr(31) || longitude::text || chr(31) || latitude::text || chr(31) || coordinate_system),modern_name,longitude,latitude,coordinate_system FROM event_locations;
INSERT INTO location_mapping(id,location_id,kind,external_id,historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links)
 SELECT id,'loc-' || md5(modern_name || chr(31) || longitude::text || chr(31) || latitude::text || chr(31) || coordinate_system),'dynasty',dynasty_id,historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links FROM dynasty_capitals;
INSERT INTO location_mapping(id,location_id,kind,external_id,historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links)
 SELECT 'map-reign:'||rc.reign_id||':'||c.id,'loc-' || md5(modern_name || chr(31) || longitude::text || chr(31) || latitude::text || chr(31) || coordinate_system),'reign',rc.reign_id,historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links FROM reign_capitals rc JOIN dynasty_capitals c ON c.id=rc.capital_id;
INSERT INTO location_mapping(id,location_id,kind,external_id,historical_name,spatial_precision,note,links)
 SELECT 'map-event:'||e.id||':'||l.id,'loc-' || md5(modern_name || chr(31) || longitude::text || chr(31) || latitude::text || chr(31) || coordinate_system),'event',e.id,historical_name,precision,note,links FROM event_locations l JOIN events e ON e.location_id=l.id;
DO $$ BEGIN
 IF (SELECT count(*) FROM location_mapping WHERE kind='dynasty') <> (SELECT count(*) FROM dynasty_capitals)
 OR (SELECT count(*) FROM location_mapping WHERE kind='reign') <> (SELECT count(*) FROM reign_capitals)
 OR (SELECT count(*) FROM location_mapping WHERE kind='event') <> (SELECT count(*) FROM events WHERE location_id IS NOT NULL)
 THEN RAISE EXCEPTION 'Location backfill lost historical associations'; END IF;
 IF EXISTS (SELECT 1 FROM event_locations l WHERE NOT EXISTS (SELECT 1 FROM events e WHERE e.location_id=l.id)) THEN RAISE EXCEPTION 'Unreferenced event location requires explicit migration'; END IF;
END $$;
CREATE FUNCTION validate_location_mapping_owner() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE valid BOOLEAN;
BEGIN
 CASE NEW.kind
 WHEN 'dynasty' THEN PERFORM 1 FROM dynasties WHERE id=NEW.external_id FOR KEY SHARE; valid:=FOUND;
 WHEN 'reign' THEN PERFORM 1 FROM reigns WHERE id=NEW.external_id FOR KEY SHARE; valid:=FOUND;
 WHEN 'event' THEN PERFORM 1 FROM events WHERE id=NEW.external_id FOR KEY SHARE; valid:=FOUND;
 ELSE valid:=false;
 END CASE;
 IF NOT valid THEN RAISE EXCEPTION 'Invalid location mapping owner: %:%',NEW.kind,NEW.external_id USING ERRCODE='23503'; END IF;
 RETURN NEW;
END $$;
CREATE TRIGGER location_mapping_owner_check BEFORE INSERT OR UPDATE ON location_mapping FOR EACH ROW EXECUTE FUNCTION validate_location_mapping_owner();
CREATE FUNCTION maintain_location_mapping_owner() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE owner_kind TEXT:=TG_ARGV[0];
BEGIN
 IF TG_OP='UPDATE' THEN UPDATE location_mapping SET external_id=NEW.id WHERE kind=owner_kind AND external_id=OLD.id; RETURN NEW; END IF;
 IF owner_kind='dynasty' AND EXISTS(SELECT 1 FROM location_mapping WHERE kind=owner_kind AND external_id=OLD.id) THEN RAISE EXCEPTION 'Dynasty still has location mappings' USING ERRCODE='23503'; END IF;
 DELETE FROM location_mapping WHERE kind=owner_kind AND external_id=OLD.id;
 RETURN OLD;
END $$;
CREATE TRIGGER dynasty_location_delete BEFORE DELETE ON dynasties FOR EACH ROW EXECUTE FUNCTION maintain_location_mapping_owner('dynasty');
CREATE TRIGGER reign_location_delete BEFORE DELETE ON reigns FOR EACH ROW EXECUTE FUNCTION maintain_location_mapping_owner('reign');
CREATE TRIGGER event_location_delete BEFORE DELETE ON events FOR EACH ROW EXECUTE FUNCTION maintain_location_mapping_owner('event');
CREATE TRIGGER dynasty_location_update AFTER UPDATE OF id ON dynasties FOR EACH ROW EXECUTE FUNCTION maintain_location_mapping_owner('dynasty');
CREATE TRIGGER reign_location_update AFTER UPDATE OF id ON reigns FOR EACH ROW EXECUTE FUNCTION maintain_location_mapping_owner('reign');
CREATE TRIGGER event_location_update AFTER UPDATE OF id ON events FOR EACH ROW EXECUTE FUNCTION maintain_location_mapping_owner('event');
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绛', note=concat_ws(' ',note,'地点名称原注：绛（故绛）。') WHERE id='cap-jin-chunqiu-jiang-669';
UPDATE location_mapping SET historical_name='乐寿', note=concat_ws(' ',note,'地点名称原注：乐寿（金城宫）。') WHERE id='cap-xia-dou-jiande-leshou-618';
UPDATE location_mapping SET historical_name='洺州', note=concat_ws(' ',note,'地点名称原注：洺州（万春宫）。') WHERE id='cap-xia-dou-jiande-mingzhou-619';
UPDATE location_mapping SET historical_name='上都', note=concat_ws(' ',note,'地点名称原注：开平/上都。') WHERE id='cap-yuan-kaiping-15252';
UPDATE location_mapping SET historical_name='盛京', note=concat_ws(' ',note,'地点名称原注：沈阳/盛京。') WHERE id='cap-qing-shengjing';
UPDATE location_mapping SET historical_name='和林/哈拉和林', note=concat_ws(' ',note,'地点名称原注：和林（哈拉和林）。') WHERE id='cap-yuan-helin-1370';
UPDATE location_mapping SET historical_name='赫图阿拉', note=concat_ws(' ',note,'地点名称原注：赫图阿拉（兴京）。') WHERE id='cap-qing-hetuala-1616';
UPDATE location_mapping SET historical_name='辽阳', note=concat_ws(' ',note,'地点名称原注：辽阳（东京）。') WHERE id='cap-qing-liaoyang-1621';
UPDATE location_mapping SET historical_name='邺/安成府', note=concat_ws(' ',note,'地点名称原注：邺（安成府）。') WHERE id='cap-yan-anshi-ye-757';
UPDATE location_mapping SET historical_name='洛阳/周京', note=concat_ws(' ',note,'地点名称原注：洛阳（周京）。') WHERE id='cap-yan-anshi-luoyang-759';
UPDATE location_mapping SET historical_name='邺/安成府', note=concat_ws(' ',note,'地点名称原注：邺（安成府）。') WHERE id='map-reign:reign-an-qingxu:cap-yan-anshi-ye-757';
UPDATE location_mapping SET historical_name='和林/哈拉和林', note=concat_ws(' ',note,'地点名称原注：和林（哈拉和林）。') WHERE id='map-reign:reign-ayushiridara-yuan:cap-yuan-helin-1370';
UPDATE location_mapping SET historical_name='乐寿', note=concat_ws(' ',note,'地点名称原注：乐寿（金城宫）。') WHERE id='map-reign:reign-dou-jiande-xia-dou-jiande:cap-xia-dou-jiande-leshou-618';
UPDATE location_mapping SET historical_name='洺州', note=concat_ws(' ',note,'地点名称原注：洺州（万春宫）。') WHERE id='map-reign:reign-dou-jiande-xia-dou-jiande:cap-xia-dou-jiande-mingzhou-619';
UPDATE location_mapping SET historical_name='盛京', note=concat_ws(' ',note,'地点名称原注：沈阳/盛京。') WHERE id='map-reign:reign-fulin-qing:cap-qing-shengjing';
UPDATE location_mapping SET historical_name='上都', note=concat_ws(' ',note,'地点名称原注：开平/上都。') WHERE id='map-reign:reign-hu-bilie-yuan:cap-yuan-kaiping-15252';
UPDATE location_mapping SET historical_name='盛京', note=concat_ws(' ',note,'地点名称原注：沈阳/盛京。') WHERE id='map-reign:reign-huang-taiji-qing:cap-qing-shengjing';
UPDATE location_mapping SET historical_name='绛', note=concat_ws(' ',note,'地点名称原注：绛（故绛）。') WHERE id='map-reign:reign-ji-chonger-jin-chunqiu:cap-jin-chunqiu-jiang-669';
UPDATE location_mapping SET historical_name='绛', note=concat_ws(' ',note,'地点名称原注：绛（故绛）。') WHERE id='map-reign:reign-jin-r21-jin-chunqiu:cap-jin-chunqiu-jiang-669';
UPDATE location_mapping SET historical_name='绛', note=concat_ws(' ',note,'地点名称原注：绛（故绛）。') WHERE id='map-reign:reign-jin-r24-jin-chunqiu:cap-jin-chunqiu-jiang-669';
UPDATE location_mapping SET historical_name='绛', note=concat_ws(' ',note,'地点名称原注：绛（故绛）。') WHERE id='map-reign:reign-jin-r25-jin-chunqiu:cap-jin-chunqiu-jiang-669';
UPDATE location_mapping SET historical_name='绛', note=concat_ws(' ',note,'地点名称原注：绛（故绛）。') WHERE id='map-reign:reign-jin-r26-jin-chunqiu:cap-jin-chunqiu-jiang-669';
UPDATE location_mapping SET historical_name='绛', note=concat_ws(' ',note,'地点名称原注：绛（故绛）。') WHERE id='map-reign:reign-jin-r27-jin-chunqiu:cap-jin-chunqiu-jiang-669';
UPDATE location_mapping SET historical_name='赫图阿拉', note=concat_ws(' ',note,'地点名称原注：赫图阿拉（兴京）。') WHERE id='map-reign:reign-nurhaci-qing:cap-qing-hetuala-1616';
UPDATE location_mapping SET historical_name='辽阳', note=concat_ws(' ',note,'地点名称原注：辽阳（东京）。') WHERE id='map-reign:reign-nurhaci-qing:cap-qing-liaoyang-1621';
UPDATE location_mapping SET historical_name='洛阳/周京', note=concat_ws(' ',note,'地点名称原注：洛阳（周京）。') WHERE id='map-reign:reign-shi-chaoyi:cap-yan-anshi-luoyang-759';
UPDATE location_mapping SET historical_name='洛阳/周京', note=concat_ws(' ',note,'地点名称原注：洛阳（周京）。') WHERE id='map-reign:reign-shi-siming:cap-yan-anshi-luoyang-759';
UPDATE location_mapping SET historical_name='和林/哈拉和林', note=concat_ws(' ',note,'地点名称原注：和林（哈拉和林）。') WHERE id='map-reign:reign-togus-temur-yuan:cap-yuan-helin-1370';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-he-zou-state:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-kaogong-zou-state:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-missing-after-he-1:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-missing-after-kaogong-1:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-missing-after-kaogong-2:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-mu-gong-zou-state:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-r13-zou-state:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-r14-zou-state:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-r15-zou-state:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-r16-zou-state:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-r17-zou-state:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-r18-zou-state:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-r18-zou-state-2:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='绎', note=concat_ws(' ',note,'地点名称原注：绎（邾国故城）。') WHERE id='map-reign:reign-zou-r19-zou-state:cap-zou-state-yi-614';
UPDATE location_mapping SET historical_name='中都', note=concat_ws(' ',note,'地点名称原注：中都（今北京）。') WHERE id='map-event:kublai-moves-capital-to-zhongdu:loc-kublai-moves-capital-to-zhongdu';
UPDATE location_mapping SET historical_name='成周', note=concat_ws(' ',note,'地点名称原注：成周（汉魏洛阳故城区域）。') WHERE id='map-event:zhou-jingwang-moves-to-chengzhou:loc-zhou-jingwang-moves-to-chengzhou';
UPDATE location_mapping SET historical_name='殷', note=concat_ws(' ',note,'地点名称原注：殷（殷墟）。') WHERE id='map-event:pangeng-move-yin:loc-pangeng-move-yin';
UPDATE location_mapping SET historical_name='大都', note=concat_ws(' ',note,'地点名称原注：大都（元大都）。') WHERE id='map-event:yuan-moves-capital-to-dadu:loc-yuan-moves-capital-to-dadu';
UPDATE location_mapping SET historical_name='天京', note=concat_ws(' ',note,'地点名称原注：天京（江宁）。') WHERE id='map-event:taiping-capital-tianjing:loc-taiping-capital-tianjing';
UPDATE location_mapping SET historical_name='乌垒城', note=concat_ws(' ',note,'地点名称原注：乌垒城（西域都护府治所）。') WHERE id='map-event:western-han-protectorate-of-western-regions:loc-wulei-city';
UPDATE location_mapping SET historical_name='洛阳', note=concat_ws(' ',note,'地点名称原注：洛阳（洛水浮桥）；高平陵在今汝阳县茹店村一带。') WHERE id='map-event:gaoping-tombs-incident:loc-gaoping-tombs-incident';
UPDATE location_mapping SET historical_name='捕鱼儿海', note=concat_ws(' ',note,'地点名称原注：捕鱼儿海（贝尔湖）。') WHERE id='map-event:korqin-sea-battle:loc-korqin-sea-battle';
UPDATE location_mapping SET historical_name='阴平道', note=concat_ws(' ',note,'地点名称原注：阴平道（阴平故城区域）。') WHERE id='map-event:deng-ai-crosses-yinping:loc-yinping';
UPDATE location_mapping SET historical_name='长安', note=concat_ws(' ',note,'地点名称原注：长安（汉长安城区域）。') WHERE id='map-event:jin-west-court-forced-to-changan:loc-jin-west-court-forced-to-changan';
UPDATE location_mapping SET historical_name='北平', note=concat_ws(' ',note,'地点名称原注：平津作战代表点（北平）。') WHERE id='map-event:pingjin-campaign:loc-pingjin-campaign';
UPDATE location_mapping SET historical_name='上海', note=concat_ws(' ',note,'地点名称原注：淞沪会战（上海）。') WHERE id='map-event:shanghai-campaign-1937:loc-shanghai-campaign-1937';
UPDATE location_mapping SET historical_name='闸北', note=concat_ws(' ',note,'地点名称原注：闸北（天通庵车站一带）。') WHERE id='map-event:shanghai-incident-1932:loc-shanghai-128-incident';
UPDATE location_mapping SET historical_name='太原', note=concat_ws(' ',note,'地点名称原注：太原会战代表点（太原）。') WHERE id='map-event:taiyuan-campaign:loc-taiyuan-campaign';
UPDATE location_mapping SET historical_name='徐州', note=concat_ws(' ',note,'地点名称原注：徐州会战代表点（徐州）。') WHERE id='map-event:xuzhou-campaign:loc-xuzhou-campaign';
UPDATE location_mapping SET historical_name='武汉', note=concat_ws(' ',note,'地点名称原注：武汉会战代表点（武汉）。') WHERE id='map-event:wuhan-campaign:loc-wuhan-campaign';
UPDATE location_mapping SET historical_name='南昌', note=concat_ws(' ',note,'地点名称原注：南昌会战代表点（南昌）。') WHERE id='map-event:nanchang-campaign:loc-nanchang-campaign';
UPDATE location_mapping SET historical_name='长沙', note=concat_ws(' ',note,'地点名称原注：第一次长沙会战代表点（长沙）。') WHERE id='map-event:first-changsha-campaign:loc-first-changsha-campaign';
UPDATE location_mapping SET historical_name='阳泉', note=concat_ws(' ',note,'地点名称原注：百团大战代表点（阳泉）。') WHERE id='map-event:hundred-regiments-campaign:loc-hundred-regiments-campaign';
UPDATE location_mapping SET historical_name='长沙', note=concat_ws(' ',note,'地点名称原注：第二次长沙会战代表点（长沙）。') WHERE id='map-event:second-changsha-campaign:loc-second-changsha-campaign';
UPDATE location_mapping SET historical_name='长沙', note=concat_ws(' ',note,'地点名称原注：第三次长沙会战代表点（长沙）。') WHERE id='map-event:third-changsha-campaign:loc-third-changsha-campaign';
UPDATE location_mapping SET historical_name='郑州', note=concat_ws(' ',note,'地点名称原注：豫湘桂会战代表点（郑州）。') WHERE id='map-event:yuxianggui-campaign:loc-yuxianggui-campaign';
UPDATE location_mapping SET historical_name='雪峰山', note=concat_ws(' ',note,'地点名称原注：湘西会战代表点（雪峰山）。') WHERE id='map-event:western-hunan-campaign:loc-western-hunan-campaign';
UPDATE location_mapping SET historical_name='北大营', note=concat_ws(' ',note,'地点名称原注：北大营（九一八事变主要交战点）。') WHERE id='map-event:mukden-incident:loc-mukden-incident';
INSERT INTO location_mapping(id,location_id,kind,external_id,historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links) SELECT 'map-reign:reign-zou-r13-zou-state:cap-zou-state-yi-614',location_id,'reign','reign-zou-r13-zou-state',historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links FROM location_mapping WHERE id='cap-zou-state-yi-614' AND kind='dynasty' ON CONFLICT(id) DO NOTHING;
INSERT INTO location_mapping(id,location_id,kind,external_id,historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links) SELECT 'map-reign:reign-sima-lun:cap-jin-west-luoyang-266',location_id,'reign','reign-sima-lun',historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links FROM location_mapping WHERE id='cap-jin-west-luoyang-266' AND kind='dynasty' ON CONFLICT(id) DO NOTHING;
INSERT INTO location_mapping(id,location_id,kind,external_id,historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links) SELECT 'map-reign:reign-yuan-shi-xiaoming-daughter:cap-wei-north-luoyang-494',location_id,'reign','reign-yuan-shi-xiaoming-daughter',historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links FROM location_mapping WHERE id='cap-wei-north-luoyang-494' AND kind='dynasty' ON CONFLICT(id) DO NOTHING;
INSERT INTO location_mapping(id,location_id,kind,external_id,historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links) SELECT 'map-reign:reign-yuan-zhao:cap-wei-north-luoyang-494',location_id,'reign','reign-yuan-zhao',historical_name,start_year, start_month, start_day, end_year, end_month, end_day, start_abs, end_abs, start_confidence, end_confidence, role,note,links FROM location_mapping WHERE id='cap-wei-north-luoyang-494' AND kind='dynasty' ON CONFLICT(id) DO NOTHING;
DO $$ BEGIN
 IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema=current_schema() AND table_name='events' AND column_name='location_capital_id') THEN
   EXECUTE $q$INSERT INTO location_mapping(id,location_id,kind,external_id,historical_name,note,links)
     SELECT 'map-event:'||e.id||':'||c.id,c.location_id,'event',e.id,c.historical_name,c.note,c.links
     FROM events e JOIN location_mapping c ON c.kind='dynasty' AND c.id=e.location_capital_id
     WHERE e.location_capital_id IS NOT NULL ON CONFLICT(id) DO NOTHING$q$;
   ALTER TABLE events DROP COLUMN location_capital_id;
 END IF;
END $$;
ALTER TABLE events DROP COLUMN location_id;
DROP TABLE reign_capitals;
DROP TABLE dynasty_capitals;
DROP TABLE event_locations;

-- Reviewed source annotations and same-point modern name normalization.
UPDATE location_mapping SET note='前745年晋昭侯封成师于曲沃，号桓叔，曲沃为其封邑及支系治所，当时晋君都翼。桓叔、庄伯、武公三世以曲沃为据点与翼公室争位；前739年桓叔应潘父之邀入晋，遭晋人反击后退回曲沃，双方公开对立；前678年武公代翼并受周王册命为晋侯。古曲沃据上郭城址及邱家庄墓群考古研究定位于今闻喜县，并非现代曲沃县。地图为高德上郭村的约略代表点，不是古城城墙或宫殿的精确位置；代翼后曲沃仍为宗庙所在地，不将祭祀中心自动延长为国君主都。 该治所属曲沃支系。' WHERE id='cap-jin-chunqiu-quwo';
UPDATE location_mapping SET note='朱以海于1645年在绍兴监国；1646年绍兴失守后出走。与南明主线及绍武并立政权分轨记录，坐标为越城区行政区约略点。 该治所属鲁监国政权。' WHERE id='cap-ming-south-shaoxing-1645';
UPDATE location_mapping SET note='绍武政权都广州。 该治所属绍武政权。' WHERE id='cap-ming-south-广州-1646';
UPDATE location_mapping SET links='[{"url":"https://www.dpm.org.cn/court/lineage/226250.html","label":"故宫博物院：努尔哈赤年表"},{"url":"https://www.amap.com/place/B019D00ZWN","label":"高德地图：赫图阿拉城"},{"url":"https://www.dpm.org.cn/lemmas/244892.html","label":"故宫博物院：赫图阿拉"}]'::jsonb WHERE id='cap-qing-hetuala-1616';
UPDATE location_mapping SET note='杨侑在长安的并立阶段：江都兵变后继续在长安，618年六月禅位。杨侑禅位公历换算有6月12日、6月18日等异说，故终点保留六月精度。 该治所属长安朝廷。' WHERE id='cap-sui-changan-618';
UPDATE location_mapping SET note='洛阳留守官于618年6月22日拥立杨侗，至619年5月23日禅位；作为杨侗并立在位期间的都城记录。 该治所属洛阳朝廷。' WHERE id='cap-sui-luoyang-618';
UPDATE location_mapping SET location_id='loc-ea36bf10f6f624664cffe9590c9bef79' WHERE id='cap-yan-anshi-fanyang-755';
UPDATE location_mapping SET location_id='loc-ea36bf10f6f624664cffe9590c9bef79' WHERE id='cap-yan-anshi-fanyang-759';
UPDATE location_mapping SET location_id='loc-ea36bf10f6f624664cffe9590c9bef79' WHERE id='cap-yan-anshi-fanyang-secondary-759';
UPDATE location_mapping SET location_id='loc-ea36bf10f6f624664cffe9590c9bef79' WHERE id='map-reign:reign-an-lushan-uprising:cap-yan-anshi-fanyang-755';
UPDATE location_mapping SET note='前745年晋昭侯封成师于曲沃，号桓叔，曲沃为其封邑及支系治所，当时晋君都翼。桓叔、庄伯、武公三世以曲沃为据点与翼公室争位；前739年桓叔应潘父之邀入晋，遭晋人反击后退回曲沃，双方公开对立；前678年武公代翼并受周王册命为晋侯。古曲沃据上郭城址及邱家庄墓群考古研究定位于今闻喜县，并非现代曲沃县。地图为高德上郭村的约略代表点，不是古城城墙或宫殿的精确位置；代翼后曲沃仍为宗庙所在地，不将祭祀中心自动延长为国君主都。 该治所属曲沃支系。' WHERE id='map-reign:reign-jin-r12-jin-chunqiu:cap-jin-chunqiu-quwo';
UPDATE location_mapping SET note='前745年晋昭侯封成师于曲沃，号桓叔，曲沃为其封邑及支系治所，当时晋君都翼。桓叔、庄伯、武公三世以曲沃为据点与翼公室争位；前739年桓叔应潘父之邀入晋，遭晋人反击后退回曲沃，双方公开对立；前678年武公代翼并受周王册命为晋侯。古曲沃据上郭城址及邱家庄墓群考古研究定位于今闻喜县，并非现代曲沃县。地图为高德上郭村的约略代表点，不是古城城墙或宫殿的精确位置；代翼后曲沃仍为宗庙所在地，不将祭祀中心自动延长为国君主都。 该治所属曲沃支系。' WHERE id='map-reign:reign-jin-r14-jin-chunqiu:cap-jin-chunqiu-quwo';
UPDATE location_mapping SET note='前745年晋昭侯封成师于曲沃，号桓叔，曲沃为其封邑及支系治所，当时晋君都翼。桓叔、庄伯、武公三世以曲沃为据点与翼公室争位；前739年桓叔应潘父之邀入晋，遭晋人反击后退回曲沃，双方公开对立；前678年武公代翼并受周王册命为晋侯。古曲沃据上郭城址及邱家庄墓群考古研究定位于今闻喜县，并非现代曲沃县。地图为高德上郭村的约略代表点，不是古城城墙或宫殿的精确位置；代翼后曲沃仍为宗庙所在地，不将祭祀中心自动延长为国君主都。 该治所属曲沃支系。' WHERE id='map-reign:reign-jin-r17-jin-chunqiu:cap-jin-chunqiu-quwo';
UPDATE location_mapping SET location_id='loc-ea36bf10f6f624664cffe9590c9bef79' WHERE id='map-reign:reign-shi-chaoyi:cap-yan-anshi-fanyang-secondary-759';
UPDATE location_mapping SET location_id='loc-ea36bf10f6f624664cffe9590c9bef79' WHERE id='map-reign:reign-shi-siming:cap-yan-anshi-fanyang-759';
UPDATE location_mapping SET location_id='loc-ea36bf10f6f624664cffe9590c9bef79' WHERE id='map-reign:reign-shi-siming:cap-yan-anshi-fanyang-secondary-759';
UPDATE location_mapping SET note='洛阳留守官于618年6月22日拥立杨侗，至619年5月23日禅位；作为杨侗并立在位期间的都城记录。 该治所属洛阳朝廷。' WHERE id='map-reign:reign-yang-tong:cap-sui-luoyang-618';
UPDATE location_mapping SET note='杨侑在长安的并立阶段：江都兵变后继续在长安，618年六月禅位。杨侑禅位公历换算有6月12日、6月18日等异说，故终点保留六月精度。 该治所属长安朝廷。' WHERE id='map-reign:reign-yang-you:cap-sui-changan-618';
UPDATE location_mapping SET note='朱以海于1645年在绍兴监国；1646年绍兴失守后出走。与南明主线及绍武并立政权分轨记录，坐标为越城区行政区约略点。 该治所属鲁监国政权。' WHERE id='map-reign:reign-zhu-yihai-ming-south:cap-ming-south-shaoxing-1645';
UPDATE location_mapping SET note='绍武政权都广州。 该治所属绍武政权。' WHERE id='map-reign:reign-zhu-yuyue-ming-south:cap-ming-south-广州-1646';
DELETE FROM locations WHERE id='loc-03958ad50d750ddccd613606b6043144' AND NOT EXISTS (SELECT 1 FROM location_mapping WHERE location_id=locations.id);
COMMIT;
