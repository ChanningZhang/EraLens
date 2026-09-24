#!/usr/bin/env node
/** Famous classical poems as timeline events. */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { eventPoint, eventRange, person, writeImportPackage, ym } from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Existing historical persons are intentionally referenced, not redefined here.
const poetryPersons = [
  person("wang-can", "王粲", ["诗人", "文学家"], "东汉末建安七子之一，作品反映汉末战乱。", "王粲"),
  person("tao-yuanming", "陶渊明", ["诗人", "文学家"], "东晋诗人，田园诗代表。", "陶渊明"),
  person("meng-hao-ran", "孟浩然", ["诗人"], "盛唐山水田园诗人。", "孟浩然"),
  person("wang-zhi-huan", "王之涣", ["诗人"], "盛唐边塞诗人，《登鹳雀楼》《凉州词》作者。", "王之涣"),
  person("wang-chang-ling", "王昌龄", ["诗人"], "盛唐边塞诗代表诗人。", "王昌龄"),
  person("cui-hao", "崔颢", ["诗人"], "盛唐诗人，《黄鹤楼》作者。", "崔颢"),
  person("du-fu", "杜甫", ["诗人", "文学家"], "盛唐诗人，诗圣，现实主义诗歌代表。", "杜甫"),
  person("li-bai", "李白", ["诗人", "文学家"], "盛唐诗人，诗仙，浪漫主义诗歌代表。", "李白"),
  person("zhang-ji", "张继", ["诗人"], "中唐诗人，《枫桥夜泊》作者。", "张继"),
  person("liu-zong-yuan", "柳宗元", ["诗人", "文学家", "政治家"], "中唐文学家、政治家，唐宋八大家之一。", "柳宗元"),
  person("meng-jiao", "孟郊", ["诗人"], "中唐诗人，以苦吟和乐府诗著称。", "孟郊"),
  person("li-shen", "李绅", ["诗人", "政治家"], "中唐诗人，《悯农》作者。", "李绅"),
  person("liu-yu-xi", "刘禹锡", ["诗人", "文学家", "政治家"], "中唐诗人、政治家，作品多有咏史怀古之作。", "刘禹锡"),
  person("du-mu", "杜牧", ["诗人", "文学家", "政治家"], "晚唐诗人、政治家，与李商隐并称小李杜。", "杜牧"),
  person("su-shi", "苏轼", ["诗人", "文学家", "政治家"], "北宋文学家、政治家，诗词文书画皆精。", "苏轼"),
  person("lu-you", "陆游", ["诗人", "文学家"], "南宋爱国诗人，诗词文俱工。", "陆游"),
  person("wen-tianxiang", "文天祥", ["诗人", "政治家"], "南宋末丞相、抗元人物。", "文天祥"),
  person("zhang-yanghao", "张养浩", ["文学家", "政治家"], "元代散曲家、政治家。", "张养浩"),
  person("ma-zhiyuan", "马致远", ["文学家"], "元代散曲家、戏曲家。", "马致远"),
  person("wang-mian", "王冕", ["诗人", "画家"], "元末诗人、画家。", "王冕"),
  person("xia-wanchun", "夏完淳", ["诗人", "抗清人物"], "明末抗清诗人，南明遗民代表。", "夏完淳"),
  person("gong-zi-zhen", "龚自珍", ["诗人", "文学家", "政治家"], "清代思想家、文学家，主张改革。", "龚自珍"),
  person("qiu-fengjia", "丘逢甲", ["诗人", "教育家"], "晚清诗人，甲午战后台湾诗人代表。", "丘逢甲"),
  person("tan-sitong", "谭嗣同", ["政治家", "诗人"], "戊戌维新人物，戊戌六君子之一。", "谭嗣同"),
];

function poemPoint({ id, name, year, dynastyIds = [], participantIds = [], dateNote, summary }) {
  return eventPoint({ id, name: name.replace(/^《|》$/g, ""), kind: "poetry", at: ym(year, 12), dynastyIds, participantIds, dateNote, summary });
}

function poemCirca({ id, name, startYear, endYear, dynastyIds = [], participantIds = [], dateNote, summary }) {
  return eventRange({
    id,
    name: name.replace(/^《|》$/g, ""),
    kind: "poetry",
    timeMode: "circa",
    precision: "year",
    start: ym(startYear, 1),
    end: ym(endYear, 12),
    dynastyIds,
    participantIds,
    dateNote,
    summary,
  });
}

const events = [
  poemCirca({ id: "poetry-wuyi", name: "《无衣》", startYear: -475, endYear: -221, dynastyIds: ["qin"], dateNote: "春秋战国之际；传统归入《诗经·秦风》", summary: "秦地军民同仇敌忾、共赴战场的诗篇。" }),
  poemPoint({ id: "poetry-gaixia-ge", name: "《垓下歌》", year: -202, dynastyIds: ["chu-west", "han-west"], participantIds: ["xiang-yu"], dateNote: "前202年，垓下兵败前后", summary: "项羽在垓下之战前后的绝命歌，见证楚汉战争终局。" }),
  poemPoint({ id: "poetry-da-feng-ge", name: "《大风歌》", year: -195, dynastyIds: ["han-west"], participantIds: ["liu-bang"], dateNote: "前195年，平定英布后归途", summary: "刘邦平定淮南王英布后所作，表现汉初帝国与诸侯政治。" }),
  poemPoint({ id: "poetry-duan-ge-xing", name: "《短歌行》", year: 208, dynastyIds: ["han-east"], participantIds: ["cao-cao"], dateNote: "建安十三年前后，年代有争议", summary: "曹操借宴饮歌咏求贤与统一天下的政治抱负。" }),
  poemPoint({ id: "poetry-guan-cang-hai", name: "《观沧海》", year: 207, dynastyIds: ["han-east"], participantIds: ["cao-cao"], dateNote: "建安十二年，北征乌桓后", summary: "曹操北征乌桓后登临碣石所作，写山海气象与统一抱负。" }),
  poemCirca({ id: "poetry-gui-sui-shou", name: "《龟虽寿》", startYear: 207, endYear: 210, dynastyIds: ["han-east"], participantIds: ["cao-cao"], dateNote: "建安十二年至十五年前后", summary: "曹操晚年抒写建功立业与老当益壮的政治志向。" }),
  poemCirca({ id: "poetry-yin-jiu", name: "《饮酒》其五", startYear: 400, endYear: 420, dynastyIds: ["jin-east"], participantIds: ["tao-yuanming"], dateNote: "东晋末至刘宋初，具体年份不详", summary: "陶渊明归隐后所作的田园诗，反映士人对政治秩序的退避。" }),
  poemCirca({ id: "poetry-mulan", name: "《木兰诗》", startYear: 386, endYear: 534, dynastyIds: ["wei-north"], dateNote: "北朝民歌，成篇年代有争议", summary: "北朝战争背景下木兰代父从军的乐府叙事诗。" }),
  poemCirca({ id: "poetry-chile-ge", name: "《敕勒歌》", startYear: 450, endYear: 580, dynastyIds: ["wei-north", "qi-bei"], dateNote: "北朝民歌，流传与定型年代不详", summary: "北方草原与军旅生活相关的著名民歌。" }),
  poemCirca({ id: "poetry-chun-xiao", name: "《春晓》", startYear: 710, endYear: 740, dynastyIds: ["tang"], participantIds: ["meng-hao-ran"], dateNote: "盛唐，约开元年间", summary: "孟浩然的春日晓眠诗，代表盛唐山水田园诗的日常审美。" }),
  poemCirca({ id: "poetry-dengguanquelou", name: "《登鹳雀楼》", startYear: 720, endYear: 742, dynastyIds: ["tang"], participantIds: ["wang-zhi-huan"], dateNote: "盛唐，具体创作年份不详", summary: "王之涣登临鹳雀楼所作的登高诗，关联河东名楼与盛唐气象。" }),
  poemCirca({ id: "poetry-liangzhou", name: "《凉州词》", startYear: 720, endYear: 742, dynastyIds: ["tang"], participantIds: ["wang-zhi-huan"], dateNote: "盛唐，凉州与玉门关边塞背景", summary: "王之涣的边塞名篇，表现河西边防的孤城、羌笛与军旅情境。" }),
  poemCirca({ id: "poetry-chusai-wang-changling", name: "《出塞》", startYear: 720, endYear: 756, dynastyIds: ["tang"], participantIds: ["wang-chang-ling"], dateNote: "盛唐，边塞诗，具体年份不详", summary: "王昌龄借边关与戍守书写唐代边疆战争和将士心愿。" }),
  poemCirca({ id: "poetry-congjunxing", name: "《从军行》", startYear: 720, endYear: 756, dynastyIds: ["tang"], participantIds: ["wang-chang-ling"], dateNote: "盛唐，西北边塞背景", summary: "王昌龄边塞组诗，描写戍边、出征与报国。" }),
  poemPoint({ id: "poetry-huanghelou", name: "《黄鹤楼》", year: 725, dynastyIds: ["tang"], participantIds: ["cui-hao"], dateNote: "盛唐，具体创作年份约在开元年间", summary: "崔颢登黄鹤楼怀古，连接江城地标与历史兴亡感。" }),
  poemPoint({ id: "poetry-wangyue", name: "《望岳》", year: 736, dynastyIds: ["tang"], participantIds: ["du-fu"], dateNote: "开元二十四年前后，游齐赵时", summary: "杜甫登临泰山所作，表现盛唐山河与个人政治抱负。" }),
  poemCirca({ id: "poetry-shudaonan", name: "《蜀道难》", startYear: 740, endYear: 744, dynastyIds: ["tang"], participantIds: ["li-bai"], dateNote: "天宝初年，具体年份有争议", summary: "李白借蜀道艰险写行旅、山川和政治道路的险阻。" }),
  poemCirca({ id: "poetry-jingyesi", name: "《静夜思》", startYear: 725, endYear: 730, dynastyIds: ["tang"], participantIds: ["li-bai"], dateNote: "盛唐早期，具体地点与年份不详", summary: "李白羁旅夜宿时的思乡名篇。" }),
  poemCirca({ id: "poetry-jiangjinjiu", name: "《将进酒》", startYear: 750, endYear: 753, dynastyIds: ["tang"], participantIds: ["li-bai"], dateNote: "天宝年间，约在嵩山一带", summary: "李白借宴饮抒写人生失意与不平之气。" }),
  poemPoint({ id: "poetry-zaofabaidicheng", name: "《早发白帝城》", year: 759, dynastyIds: ["tang"], participantIds: ["li-bai"], dateNote: "乾元二年，流放夜郎遇赦后", summary: "李白遇赦后自白帝城顺江东下所作。" }),
  poemPoint({ id: "poetry-chunwang", name: "《春望》", year: 757, dynastyIds: ["tang"], participantIds: ["du-fu"], dateNote: "至德二载，长安陷于叛军期间", summary: "杜甫身陷长安时目睹国破城残所作，记录安史之乱的社会创伤。" }),
  poemPoint({ id: "poetry-shuxiang", name: "《蜀相》", year: 760, dynastyIds: ["tang"], participantIds: ["du-fu"], dateNote: "上元元年，成都武侯祠", summary: "杜甫凭吊诸葛亮，寄托安史乱后对贤相与政治理想的追慕。" }),
  poemPoint({ id: "poetry-wenguanjun", name: "《闻官军收河南河北》", year: 763, dynastyIds: ["tang"], participantIds: ["du-fu"], dateNote: "宝应元年，安史之乱结束消息传来", summary: "杜甫听闻唐军收复河南河北后的喜极而作。" }),
  poemPoint({ id: "poetry-denggao", name: "《登高》", year: 767, dynastyIds: ["tang"], participantIds: ["du-fu"], dateNote: "大历二年，夔州", summary: "杜甫晚年登高所作，包含乱后漂泊与国家衰败的沉郁感。" }),
  poemCirca({ id: "poetry-fengqiao-yebo", name: "《枫桥夜泊》", startYear: 750, endYear: 770, dynastyIds: ["tang"], participantIds: ["zhang-ji"], dateNote: "安史之乱后，约8世纪中叶；具体年份不详", summary: "张继夜泊苏州枫桥所作，连接江南古迹、战乱后羁旅与城市记忆。" }),
  poemPoint({ id: "poetry-jiangxue", name: "《江雪》", year: 805, dynastyIds: ["tang"], participantIds: ["liu-zong-yuan"], dateNote: "永贞革新失败后，柳宗元被贬永州时期", summary: "柳宗元贬谪永州时所作，写孤绝江山与政治失意。" }),
  poemCirca({ id: "poetry-youzimeng", name: "《游子吟》", startYear: 795, endYear: 815, dynastyIds: ["tang"], participantIds: ["meng-jiao"], dateNote: "中唐，具体年份不详", summary: "孟郊游子行役时歌咏母爱与离别。" }),
  poemCirca({ id: "poetry-minnong", name: "《悯农》", startYear: 795, endYear: 830, dynastyIds: ["tang"], participantIds: ["li-shen"], dateNote: "中唐，具体年份不详", summary: "李绅悯惜农民劳作与民生艰辛的名篇。" }),
  poemPoint({ id: "poetry-wuyixiang", name: "《乌衣巷》", year: 824, dynastyIds: ["tang"], participantIds: ["liu-yu-xi"], dateNote: "宝历二年，金陵；咏六朝旧迹", summary: "刘禹锡凭吊金陵乌衣巷，以燕子旧巢写六朝门阀与王朝兴亡。" }),
  poemPoint({ id: "poetry-boqinhua", name: "《泊秦淮》", year: 824, dynastyIds: ["tang"], participantIds: ["du-mu"], dateNote: "晚唐，约大和年间", summary: "杜牧夜泊秦淮，借南朝旧都讽喻晚唐政治忧患。" }),
  poemCirca({ id: "poetry-chibi-du-mu", name: "《赤壁》", startYear: 840, endYear: 850, dynastyIds: ["tang"], participantIds: ["du-mu"], dateNote: "晚唐，具体创作年份不详", summary: "杜牧凭吊赤壁古战场，以三国旧事寄托历史兴亡感。" }),
  poemPoint({ id: "poetry-tixilinbi", name: "《题西林壁》", year: 1084, dynastyIds: ["song-north"], participantIds: ["su-shi"], dateNote: "元丰七年，庐山西林寺", summary: "苏轼游庐山题壁，写观察视角与山川名胜。" }),
  poemPoint({ id: "poetry-yinhu-chuqing", name: "《饮湖上初晴后雨》", year: 1073, dynastyIds: ["song-north"], participantIds: ["su-shi"], dateNote: "熙宁六年前后，杭州", summary: "苏轼任杭州通判时咏西湖名篇。" }),
  poemPoint({ id: "poetry-youshanxicun", name: "《游山西村》", year: 1167, dynastyIds: ["song-south"], participantIds: ["lu-you"], dateNote: "乾道三年，山阴", summary: "陆游闲居山阴时所作，写南宋乡村社会与民情。" }),
  poemPoint({ id: "poetry-shufen", name: "《书愤》", year: 1186, dynastyIds: ["song-south"], participantIds: ["lu-you"], dateNote: "淳熙十三年，蜀中", summary: "陆游追忆抗金经历，表达南宋恢复故土的政治抱负。" }),
  poemPoint({ id: "poetry-shier", name: "《示儿》", year: 1210, dynastyIds: ["song-south"], participantIds: ["lu-you"], dateNote: "嘉定三年，临终前", summary: "陆游临终前嘱咐子孙勿忘北定中原。" }),
  poemCirca({ id: "poetry-guolingdingyang", name: "《过零丁洋》", startYear: 1278, endYear: 1279, dynastyIds: ["song-south", "yuan"], participantIds: ["wen-tianxiang"], dateNote: "祥兴元年至二年，宋元战争期间", summary: "文天祥被俘途中经过零丁洋所作，关联南宋覆亡。" }),
  poemPoint({ id: "poetry-zhengqige", name: "《正气歌》", year: 1279, dynastyIds: ["song-south", "yuan"], participantIds: ["wen-tianxiang"], dateNote: "至元十六年前后，大都狱中", summary: "文天祥在元大都狱中歌咏忠节与历史正气。" }),
  poemCirca({ id: "poetry-tongguan-huaigu", name: "《山坡羊·潼关怀古》", startYear: 1315, endYear: 1325, dynastyIds: ["yuan"], participantIds: ["zhang-yanghao"], dateNote: "元代，赴关中赈灾途中", summary: "张养浩凭吊潼关，借历代兴亡关注百姓疾苦。" }),
  poemCirca({ id: "poetry-tianjing-shaqiu", name: "《天净沙·秋思》", startYear: 1300, endYear: 1321, dynastyIds: ["yuan"], participantIds: ["ma-zhiyuan"], dateNote: "元代，具体创作年份不详", summary: "马致远羁旅秋思的散曲名篇。" }),
  poemCirca({ id: "poetry-shihuiyin", name: "《石灰吟》", startYear: 1435, endYear: 1450, dynastyIds: ["ming"], participantIds: ["yu-qian"], dateNote: "明代中期，创作年代有不同说法", summary: "于谦借石灰自况，成为明代忠臣政治伦理的象征性诗篇。" }),
  poemPoint({ id: "poetry-jihai", name: "《己亥杂诗》其五", year: 1839, dynastyIds: ["qing"], participantIds: ["gong-zi-zhen"], dateNote: "道光十九年，龚自珍离京南归途中", summary: "龚自珍以落花自况，寄托晚清政治改革与人才培养愿望。" }),
  poemPoint({ id: "poetry-fushu-dengcheng", name: "《赴戍登程口占示家人》", year: 1842, dynastyIds: ["qing"], participantIds: ["lin-zexu"], dateNote: "道光二十二年八月，西安赴伊犁途中", summary: "林则徐被遣戍伊犁、告别家人时所作。" }),
  poemPoint({ id: "poetry-chunchou", name: "《春愁》", year: 1895, dynastyIds: ["qing"], participantIds: ["qiu-fengjia"], dateNote: "甲午战败、台湾割让前后，具体月份不详", summary: "丘逢甲写甲午战败与台湾割让后的家国之愁。" }),
  poemPoint({ id: "poetry-yuzhong-tibi", name: "《狱中题壁》", year: 1898, dynastyIds: ["qing"], participantIds: ["tan-sitong"], dateNote: "光绪二十四年，戊戌政变后狱中", summary: "谭嗣同被捕后作，关联戊戌政变与维新派殉难。" }),
];

const poemTexts = {
  "poetry-wuyi": `岂曰无衣？与子同袍。\n王于兴师，修我戈矛。与子同仇！\n\n岂曰无衣？与子同泽。\n王于兴师，修我矛戟。与子偕作！\n\n岂曰无衣？与子同裳。\n王于兴师，修我甲兵。与子偕行！`,
  "poetry-gaixia-ge": `力拔山兮气盖世，\n时不利兮骓不逝。\n骓不逝兮可奈何，\n虞兮虞兮奈若何！`,
  "poetry-da-feng-ge": `大风起兮云飞扬，\n威加海内兮归故乡，\n安得猛士兮守四方！`,
  "poetry-duan-ge-xing": `对酒当歌，人生几何！譬如朝露，去日苦多。\n慨当以慷，忧思难忘。何以解忧？唯有杜康。\n青青子衿，悠悠我心。但为君故，沉吟至今。\n呦呦鹿鸣，食野之苹。我有嘉宾，鼓瑟吹笙。\n明明如月，何时可掇？忧从中来，不可断绝。\n越陌度阡，枉用相存。契阔谈䜩，心念旧恩。\n月明星稀，乌鹊南飞。绕树三匝，何枝可依？\n山不厌高，海不厌深。周公吐哺，天下归心。`,
  "poetry-guan-cang-hai": `东临碣石，以观沧海。\n水何澹澹，山岛竦峙。\n树木丛生，百草丰茂。\n秋风萧瑟，洪波涌起。\n日月之行，若出其中；\n星汉灿烂，若出其里。\n幸甚至哉，歌以咏志。`,
  "poetry-gui-sui-shou": `神龟虽寿，犹有竟时；\n腾蛇乘雾，终为土灰。\n老骥伏枥，志在千里；\n烈士暮年，壮心不已。\n盈缩之期，不但在天；\n养怡之福，可得永年。\n幸甚至哉，歌以咏志。`,
  "poetry-yin-jiu": `结庐在人境，而无车马喧。\n问君何能尔？心远地自偏。\n采菊东篱下，悠然见南山。\n山气日夕佳，飞鸟相与还。\n此中有真意，欲辨已忘言。`,
  "poetry-mulan": `唧唧复唧唧，木兰当户织。不闻机杼声，唯闻女叹息。\n问女何所思，问女何所忆。女亦无所思，女亦无所忆。\n昨夜见军帖，可汗大点兵，军书十二卷，卷卷有爷名。\n阿爷无大儿，木兰无长兄，愿为市鞍马，从此替爷征。\n东市买骏马，西市买鞍鞯，南市买辔头，北市买长鞭。\n旦辞爷娘去，暮宿黄河边；不闻爷娘唤女声，但闻黄河流水鸣溅溅。\n旦辞黄河去，暮至黑山头；不闻爷娘唤女声，但闻燕山胡骑鸣啾啾。\n万里赴戎机，关山度若飞。朔气传金柝，寒光照铁衣。\n将军百战死，壮士十年归。\n归来见天子，天子坐明堂。策勋十二转，赏赐百千强。\n可汗问所欲，木兰不用尚书郎；愿驰千里足，送儿还故乡。\n爷娘闻女来，出郭相扶将；阿姊闻妹来，当户理红妆；小弟闻姊来，磨刀霍霍向猪羊。\n开我东阁门，坐我西阁床。脱我战时袍，著我旧时裳。\n当窗理云鬓，对镜帖花黄。出门看火伴，火伴皆惊忙：同行十二年，不知木兰是女郎。\n雄兔脚扑朔，雌兔眼迷离；双兔傍地走，安能辨我是雄雌？`,
  "poetry-chile-ge": `敕勒川，阴山下。\n天似穹庐，笼盖四野。\n天苍苍，野茫茫。\n风吹草低见牛羊。`,
  "poetry-chun-xiao": `春眠不觉晓，处处闻啼鸟。\n夜来风雨声，花落知多少。`,
  "poetry-dengguanquelou": `白日依山尽，黄河入海流。\n欲穷千里目，更上一层楼。`,
  "poetry-liangzhou": `黄河远上白云间，一片孤城万仞山。\n羌笛何须怨杨柳，春风不度玉门关。`,
  "poetry-chusai-wang-changling": `秦时明月汉时关，万里长征人未还。\n但使龙城飞将在，不教胡马度阴山。`,
  "poetry-congjunxing": `青海长云暗雪山，孤城遥望玉门关。\n黄沙百战穿金甲，不破楼兰终不还。`,
  "poetry-huanghelou": `昔人已乘黄鹤去，此地空余黄鹤楼。\n黄鹤一去不复返，白云千载空悠悠。\n晴川历历汉阳树，芳草萋萋鹦鹉洲。\n日暮乡关何处是？烟波江上使人愁。`,
  "poetry-wangyue": `岱宗夫如何？齐鲁青未了。\n造化钟神秀，阴阳割昏晓。\n荡胸生层云，决眦入归鸟。\n会当凌绝顶，一览众山小。`,
  "poetry-shudaonan": `噫吁嚱，危乎高哉！蜀道之难，难于上青天！\n蚕丛及鱼凫，开国何茫然！尔来四万八千岁，不与秦塞通人烟。\n西当太白有鸟道，可以横绝峨眉巅。地崩山摧壮士死，然后天梯石栈相钩连。\n上有六龙回日之高标，下有冲波逆折之回川。黄鹤之飞尚不得过，猿猱欲度愁攀援。\n青泥何盘盘，百步九折萦岩峦。扪参历井仰胁息，以手抚膺坐长叹。\n问君西游何时还？畏途巉岩不可攀。但见悲鸟号古木，雄飞雌从绕林间。又闻子规啼夜月，愁空山。\n蜀道之难，难于上青天，使人听此凋朱颜！连峰去天不盈尺，枯松倒挂倚绝壁。\n飞湍瀑流争喧豗，砯崖转石万壑雷。其险也如此，嗟尔远道之人胡为乎来哉！\n剑阁峥嵘而崔嵬，一夫当关，万夫莫开。所守或匪亲，化为狼与豺。\n朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻。锦城虽云乐，不如早还家。\n蜀道之难，难于上青天，侧身西望长咨嗟！`,
  "poetry-jingyesi": `床前明月光，疑是地上霜。\n举头望明月，低头思故乡。`,
  "poetry-jiangjinjiu": `君不见黄河之水天上来，奔流到海不复回。\n君不见高堂明镜悲白发，朝如青丝暮成雪。\n人生得意须尽欢，莫使金樽空对月。\n天生我材必有用，千金散尽还复来。\n烹羊宰牛且为乐，会须一饮三百杯。\n岑夫子，丹丘生。将进酒，杯莫停。\n与君歌一曲，请君为我倾耳听。\n钟鼓馔玉不足贵，但愿长醉不复醒。\n古来圣贤皆寂寞，惟有饮者留其名。\n陈王昔时宴平乐，斗酒十千恣欢谑。\n主人何为言少钱，径须沽取对君酌。\n五花马，千金裘，呼儿将出换美酒，与尔同销万古愁。`,
  "poetry-zaofabaidicheng": `朝辞白帝彩云间，千里江陵一日还。\n两岸猿声啼不住，轻舟已过万重山。`,
  "poetry-chunwang": `国破山河在，城春草木深。\n感时花溅泪，恨别鸟惊心。\n烽火连三月，家书抵万金。\n白头搔更短，浑欲不胜簪。`,
  "poetry-shuxiang": `丞相祠堂何处寻？锦官城外柏森森。\n映阶碧草自春色，隔叶黄鹂空好音。\n三顾频烦天下计，两朝开济老臣心。\n出师未捷身先死，长使英雄泪满襟。`,
  "poetry-wenguanjun": `剑外忽传收蓟北，初闻涕泪满衣裳。\n却看妻子愁何在，漫卷诗书喜欲狂。\n白日放歌须纵酒，青春作伴好还乡。\n即从巴峡穿巫峡，便下襄阳向洛阳。`,
  "poetry-denggao": `风急天高猿啸哀，渚清沙白鸟飞回。\n无边落木萧萧下，不尽长江滚滚来。\n万里悲秋常作客，百年多病独登台。\n艰难苦恨繁霜鬓，潦倒新停浊酒杯。`,
  "poetry-fengqiao-yebo": `月落乌啼霜满天，江枫渔火对愁眠。\n姑苏城外寒山寺，夜半钟声到客船。`,
  "poetry-jiangxue": `千山鸟飞绝，万径人踪灭。\n孤舟蓑笠翁，独钓寒江雪。`,
  "poetry-youzimeng": `慈母手中线，游子身上衣。\n临行密密缝，意恐迟迟归。\n谁言寸草心，报得三春晖。`,
  "poetry-minnong": `锄禾日当午，汗滴禾下土。\n谁知盘中餐，粒粒皆辛苦。\n\n春种一粒粟，秋收万颗子。\n四海无闲田，农夫犹饿死。`,
  "poetry-wuyixiang": `朱雀桥边野草花，乌衣巷口夕阳斜。\n旧时王谢堂前燕，飞入寻常百姓家。`,
  "poetry-boqinhua": `烟笼寒水月笼沙，夜泊秦淮近酒家。\n商女不知亡国恨，隔江犹唱后庭花。`,
  "poetry-chibi-du-mu": `折戟沉沙铁未销，自将磨洗认前朝。\n东风不与周郎便，铜雀春深锁二乔。`,
  "poetry-tixilinbi": `横看成岭侧成峰，远近高低各不同。\n不识庐山真面目，只缘身在此山中。`,
  "poetry-yinhu-chuqing": `水光潋滟晴方好，山色空蒙雨亦奇。\n欲把西湖比西子，淡妆浓抹总相宜。`,
  "poetry-youshanxicun": `莫笑农家腊酒浑，丰年留客足鸡豚。\n山重水复疑无路，柳暗花明又一村。\n箫鼓追随春社近，衣冠简朴古风存。\n从今若许闲乘月，拄杖无时夜叩门。`,
  "poetry-shufen": `早岁那知世事艰，中原北望气如山。\n楼船夜雪瓜洲渡，铁马秋风大散关。\n塞上长城空自许，镜中衰鬓已先斑。\n出师一表真名世，千载谁堪伯仲间！`,
  "poetry-shier": `死去元知万事空，但悲不见九州同。\n王师北定中原日，家祭无忘告乃翁。`,
  "poetry-guolingdingyang": `辛苦遭逢起一经，干戈寥落四周星。\n山河破碎风飘絮，身世浮沉雨打萍。\n惶恐滩头说惶恐，零丁洋里叹零丁。\n人生自古谁无死？留取丹心照汗青。`,
  "poetry-zhengqige": `天地有正气，杂然赋流形。\n下则为河岳，上则为日星。\n于人曰浩然，沛乎塞苍冥。\n皇路当清夷，含和吐明庭。\n时穷节乃见，一一垂丹青。\n在齐太史简，在晋董狐笔。\n在秦张良椎，在汉苏武节。\n为严将军头，为嵇侍中血。\n为张睢阳齿，为颜常山舌。\n或为辽东帽，清操厉冰雪。\n或为出师表，鬼神泣壮烈。\n或为渡江楫，慷慨吞胡羯。\n或为击贼笏，逆竖头破裂。\n是气所磅礴，凛烈万古存。\n当其贯日月，生死安足论。\n地维赖以立，天柱赖以尊。\n三纲实系命，道义为之根。\n嗟予遘阳九，隶也实不力。\n楚囚缨其冠，传车送穷北。\n鼎镬甘如饴，求之不可得。\n阴房阗鬼火，春院閟天黑。\n牛骥同一皂，鸡栖凤凰食。\n一朝蒙雾露，分作沟中瘠。\n如此再寒暑，百沴自辟易。\n嗟哉沮洳场，为我安乐国。\n岂有他缪巧，阴阳不能贼。\n顾此耿耿在，仰视浮云白。\n悠悠我心悲，苍天曷有极。\n哲人日已远，典刑在夙昔。\n风檐展书读，古道照颜色。`,
  "poetry-tongguan-huaigu": `峰峦如聚，波涛如怒，山河表里潼关路。\n望西都，意踌躇。\n伤心秦汉经行处，宫阙万间都做了土。\n兴，百姓苦；亡，百姓苦。`,
  "poetry-tianjing-shaqiu": `枯藤老树昏鸦，小桥流水人家，古道西风瘦马。\n夕阳西下，断肠人在天涯。`,
  "poetry-shihuiyin": `千锤万凿出深山，烈火焚烧若等闲。\n粉骨碎身浑不怕，要留清白在人间。`,
  "poetry-jihai": `浩荡离愁白日斜，吟鞭东指即天涯。\n落红不是无情物，化作春泥更护花。`,
  "poetry-fushu-dengcheng": `力微任重久神疲，再竭衰庸定不支。\n苟利国家生死以，岂因祸福避趋之？\n谪居正是君恩厚，养拙刚于戍卒宜。\n戏与山妻谈故事，试吟断送老头皮。`,
  "poetry-chunchou": `春愁难遣强看山，往事惊心泪欲潸。\n四百万人同一哭，去年今日割台湾。`,
  "poetry-yuzhong-tibi": `望门投止思张俭，忍死须臾待杜根。\n我自横刀向天笑，去留肝胆两昆仑。`,
};

for (const event of events) {
  event.content = poemTexts[event.id];
  if (!event.content) throw new Error(`Missing full poem text for ${event.id}`);
}

const sourceFor = (event) => `https://zh.wikipedia.org/wiki/${encodeURIComponent(event.name.replace(/^《|》$/g, ""))}`;

writeImportPackage(__dirname, {
  slug: "poetry",
  window: { startYear: -475, startMonth: 1, endYear: 1898, endMonth: 12 },
  persons: poetryPersons,
  dynasties: [],
  reigns: [],
  events,
  relations: [],
  preSql: [
    "DELETE FROM event_dynasties WHERE event_id = 'poetry-bie-yunjian';",
    "DELETE FROM event_participants WHERE event_id = 'poetry-bie-yunjian';",
    "DELETE FROM events WHERE id = 'poetry-bie-yunjian';",
    "DELETE FROM event_dynasties WHERE event_id = 'poetry-yuanyuanqu';",
    "DELETE FROM event_participants WHERE event_id = 'poetry-yuanyuanqu';",
    "DELETE FROM events WHERE id = 'poetry-yuanyuanqu';",
    "DELETE FROM persons WHERE id = 'wu-meicun' AND NOT EXISTS (SELECT 1 FROM event_participants WHERE person_id = 'wu-meicun') AND NOT EXISTS (SELECT 1 FROM reigns WHERE person_id = 'wu-meicun');",
  ].join("\n"),
  manifest: {
    slug: "poetry",
    title: "古诗名篇（poetry 事件）",
    window: { startYear: -475, startMonth: 1, endYear: 1898, endMonth: 12 },
    scope: "cn",
    depth: "standard",
    generatedAt: "2026-09-23",
    counts: { persons: poetryPersons.length, dynasties: 0, reigns: 0, events: events.length, relations: 0 },
    sources: events.map((event) => ({ label: event.name, url: sourceFor(event) })),
    notes: [
      "首批按知名度优先收录；事件标题保留诗名，kind=poetry 仅作为类型标签。",
      "无法确定具体年份的作品使用 circa 窗口；窗口是创作年代或流传定型年代的工作取值，不表示精确创作日。",
      "《凉州词》《出塞》《枫桥夜泊》《登鹳雀楼》等采用盛唐或安史之乱后的大致年代；不同文献可能有异说。",
      "未保存整首诗正文，只保存名篇索引、作者、年代、背景摘要与来源链接。",
    ],
  },
});
