#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Xia-Shang-Zhou.
 * AbsMonth must match packages/shared/src/time.ts
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { alignReignSeamConfidences } from "../lib/alignReignSeamConfidences.mjs";
import { finalizeImportReigns } from "../lib/missingReigns.mjs";
import { applyFeudalClanMetadata } from "../lib/applyFeudalClanMetadata.mjs";
import { reignSql } from "../lib/reignSql.mjs";
import { validateReignDateConfidenceSeams } from "../lib/validateReignSeams.mjs";
import {
  dynastySql,
  formatAppellationCsv,
  mergeAppellationsIntoPersons,
  normalizeYearPrecisionAt,
  personSql,
} from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

function toAstroYear(year) {
  return year > 0 ? year : year + 1;
}
function absMonth(year, month = 1) {
  return toAstroYear(year) * 12 + (month - 1);
}
function sqlStr(value) {
  if (value == null) return "NULL";
  return `'${String(value).replace(/'/g, "''")}'`;
}
function sqlArray(values) {
  if (!values?.length) return "ARRAY[]::text[]";
  return `ARRAY[${values.map(sqlStr).join(",")}]`;
}
function sqlJson(value) {
  if (value == null) return "NULL";
  return `${sqlStr(JSON.stringify(value))}::jsonb`;
}
function ym(year, month = 1) {
  return { year, month, abs: absMonth(year, month) };
}

const wiki = (title) => [
  { label: "维基百科", url: `https://zh.wikipedia.org/wiki/${title}` },
];

/** 商王：persons.name 带姓私名，日名/史称进 alt_names 以便检索。 */
function shangKing({ id, given, dayName, bio, wikiTitle, extraAlt = [] }) {
  return {
    id,
    name: `子${given}`,
    altNames: [...new Set([dayName, ...extraAlt])],
    roles: ["君主"],
    bio,
    links: wiki(wikiTitle),
  };
}

const persons = [
  { id: "si-yu", name: "姒文命", altNames: ["禹", "大禹", "夏禹", "文命"], roles: ["君主"], bio: "夏朝开国之君，姒姓，名文命，史称禹、大禹。传说继父鲧治水，受舜禅，都阳城；《史记·夏本纪》以其为夏后氏始。生卒年无实测。", links: wiki("禹") },
  { id: "si-qi", name: "姒启", altNames: ["启", "夏后启"], roles: ["君主"], bio: "禹之子。传统记载益避启，诸侯归启，变禅让为世袭，史称家天下。《尚书·甘誓》载其伐有扈氏。生卒年无实测。", links: wiki("启_(夏朝)") },
  { id: "si-taikang", name: "姒太康", altNames: ["太康"], roles: ["君主"], bio: "启之子。《史记》载太康失国；《左传》谓后羿因夏民以代夏政，《五子之歌》托为太康兄弟所作。生卒年无实测。", links: wiki("太康_(夏朝)") },
  { id: "si-zhongkang", name: "姒仲康", altNames: ["仲康", "中康"], roles: ["君主"], bio: "太康之弟，《史记·夏本纪》作中康。后羿代夏之际夏后氏仍记其世次，子为相。生卒年无实测。", links: wiki("中康") },
  { id: "si-xiang", name: "姒相", altNames: ["相"], roles: ["君主"], bio: "仲康之子。寒浞当国时夏后；《左传》载过浇灭斟灌、斟鄩，杀相。后缗方娠逃归有仍，生少康。生卒年无实测。", links: wiki("相_(夏朝)") },
  { id: "si-shaokang", name: "姒少康", altNames: ["少康"], roles: ["君主"], bio: "相之子，有仍所生。自有虞起兵，与靡灭寒浞，使女艾灭浇、季杼灭豷，恢复夏政，史称少康中兴。生卒年无实测。", links: wiki("少康") },
  { id: "si-zhu", name: "姒杼", altNames: ["杼", "予", "季杼"], roles: ["君主"], bio: "少康之子，《史记》作帝予，亦作杼、季杼。少康中兴时诱杀寒豷于戈；《国语》称其能帅禹，夏后氏报祭。生卒年无实测。", links: wiki("杼") },
  { id: "si-huai", name: "姒槐", altNames: ["槐", "芬", "帝宁"], roles: ["君主"], bio: "杼之子，《史记》作帝槐；《今本竹书纪年》等或作芬、帝宁。正史几乎无事迹。生卒年无实测。", links: wiki("槐_(夏朝)") },
  { id: "si-mang", name: "姒芒", altNames: ["芒", "荒"], roles: ["君主"], bio: "槐之子，《史记》作帝芒；一作荒。《今本竹书纪年》载其以玄珪宾于河，事属传说。生卒年无实测。", links: wiki("芒_(夏朝)") },
  { id: "si-xie", name: "姒泄", altNames: ["泄"], roles: ["君主"], bio: "芒之子，《史记》作帝泄。《今本竹书纪年》载命畎夷、白夷、赤夷、玄夷、风夷、阳夷，事属传说。生卒年无实测。", links: wiki("泄") },
  { id: "si-bujiang", name: "姒不降", altNames: ["不降"], roles: ["君主"], bio: "泄之子。《史记》载不降崩、弟扃立，是夏世次中少见的兄终弟及。生卒年无实测。", links: wiki("不降") },
  { id: "si-jiong", name: "姒扃", altNames: ["扃"], roles: ["君主"], bio: "不降之弟。兄终弟及，子为廑。正史几乎无事迹。生卒年无实测。", links: wiki("扃") },
  { id: "si-jin", name: "姒廑", altNames: ["廑", "胤甲"], roles: ["君主"], bio: "扃之子，《史记》作帝廑；《今本竹书纪年》或作胤甲，并载天有妖孽、十日并出，事属传说。生卒年无实测。", links: wiki("廑") },
  { id: "si-kongjia", name: "姒孔甲", altNames: ["孔甲"], roles: ["君主"], bio: "不降之子；扃、廑之后由孔甲继。《史记》称其好方鬼神、事淫乱，夏后氏德衰、诸侯畔之；又有扰龙、刘累御龙传说。生卒年无实测。", links: wiki("孔甲") },
  { id: "si-gao", name: "姒皋", altNames: ["皋", "昊"], roles: ["君主"], bio: "孔甲之子，《史记》作帝皋；一作昊。正史几乎无事迹。生卒年无实测。", links: wiki("皋_(夏朝)") },
  { id: "si-fa", name: "姒发", altNames: ["发", "發"], roles: ["君主"], bio: "皋之子，《史记》作帝发，桀之父。《今本竹书纪年》载诸夷宾于王门，事属传说。生卒年无实测。", links: wiki("發_(夏朝)") },
  { id: "si-jie", name: "姒履癸", altNames: ["履癸", "桀", "夏桀"], roles: ["君主"], bio: "发之子，夏朝末代之王，史称桀。《史记》载其暴虐，鸣条之战为商汤所灭。生卒年无实测。", links: wiki("桀") },
  { id: "hou-yi", name: "后羿", altNames: ["羿", "夷羿", "有穷后羿"], clanShi: "有穷", roles: ["君主"], bio: "有穷氏首领，善射。《左传》载其自鉏迁穷石，因夏民以代夏政，不修民事，为寒浞所杀。传说未称夏后，不入夏后氏正统世次。生卒年无实测。", links: wiki("后羿_(夏朝)") },
  { id: "han-zhuo", name: "寒浞", altNames: ["浞", "韩浞"], ancestralXing: "妘", clanShi: "寒", roles: ["君主"], bio: "寒氏，名浞，妘姓。伯明氏谗子弟，后羿用为相，旋杀羿代有穷；使浇灭相。后为少康、靡所灭。非夏后正统，不入十七王继承链。生卒年无实测。", links: wiki("寒浞") },
  { id: "gun", name: "鲧", altNames: ["崇伯鲧", "梼杌"], ancestralXing: "姒", clanShi: "崇", death: ym(-2070), roles: ["政治家"], bio: "禹之父，崇伯。传说奉尧命障洪水九年不成，后被殛于羽山。生卒无实测；卒年取断代工程夏始约前2070年，示禹受禅之前。", links: wiki("鲧") },
  { id: "gao-yao", name: "皋陶", altNames: ["咎繇"], ancestralXing: "偃", roles: ["政治家"], bio: "尧舜禹时掌刑之臣，传说制五刑、造狱。禹曾欲禅位于他，先禹而卒。生卒年不可考。", links: wiki("皋陶") },
  { id: "bo-yi", name: "伯益", altNames: ["益", "柏翳", "大费"], ancestralXing: "嬴", roles: ["政治家"], bio: "舜禹时虞官，佐禹治水；禹卒后一度受禅，传统记载启继位而益避居。生卒年不可考。", links: wiki("伯益") },
  { id: "tu-shan-shi", name: "涂山氏", altNames: ["女娇", "涂山女"], clanShi: "涂山", roles: ["后妃"], bio: "传说禹之妃、启之母，涂山氏女，或名女娇。《吕氏春秋》有涂山女作歌之说。生卒年不可考。", links: wiki("涂山氏") },
  { id: "hou-min", name: "后缗", altNames: ["缗"], clanShi: "有仍", roles: ["后妃"], bio: "有仍氏女，夏后相之妻。相为浇所灭时方娠，逃出自窦，归于有仍，生少康。见《左传·哀公元年》。", links: wiki("后缗") },
  { id: "han-jiao", name: "浇", altNames: ["过浇", "奡"], ancestralXing: "妘", clanShi: "寒", roles: ["将领"], bio: "寒浞之子，处过，故称过浇。《左传》载其灭斟灌、斟鄩并杀相，后为少康遣女艾所灭。", links: wiki("浇") },
  { id: "mo-xi", name: "妹喜", altNames: ["末喜", "妹嬉"], clanShi: "有施", roles: ["后妃"], bio: "有施氏女，传说夏桀伐有施而得，为桀妃；传统叙事常将其与夏亡并提，事属传说。", links: wiki("妹喜") },
  { id: "guan-longpang", name: "关龙逢", altNames: ["关龙逄", "龙逢"], death: ym(-1600), roles: ["政治家"], bio: "夏桀时谏臣。传说桀通宵宴乐，关龙逢进黄图强谏被杀。生卒无实测；卒年取夏商分界约前1600年，示桀世之末。", links: wiki("关龙逢") },
  shangKing({
    id: "zi-tang",
    given: "履",
    dayName: "汤",
    extraAlt: ["成汤", "天乙", "大乙"],
    wikiTitle: "商汤",
    bio: "商朝开国之君，子姓，名履，又称成汤、天乙；鸣条之战灭夏。",
  }),
  {
    id: "yi-yin",
    name: "伊尹",
    altNames: ["伊挚", "阿衡", "保衡"],
    clanShi: "伊",
    birth: ym(-1649),
    death: ym(-1540),
    roles: ["政治家"],
    bio: "商初重臣，名挚，有莘氏媵臣出身；辅汤灭夏，历外丙、仲壬、太甲、沃丁。传说曾放太甲于桐宫。传统生年取维基前1649年；卒年按《今本竹书》沃丁八年，对到本表沃丁窗为前1540年。皆非实测。",
    links: wiki("伊尹"),
  },
  { id: "zhong-hui", name: "仲虺", altNames: ["莱朱"], clanShi: "薛", roles: ["政治家"], bio: "商汤左相，奚仲之后，居薛；与伊尹并相。《尚书》有仲虺之诰。生卒年不可考。", links: wiki("仲虺") },
  shangKing({
    id: "zi-waibing",
    given: "胜",
    dayName: "外丙",
    extraAlt: ["卜丙"],
    wikiTitle: "外丙",
    bio: "汤之子，太丁之弟。《孟子》《今本竹书纪年》在位二年，《史记》作三年；甲骨或作卜丙。",
  }),
  shangKing({
    id: "zi-zhongren",
    given: "庸",
    dayName: "仲壬",
    extraAlt: ["中壬"],
    wikiTitle: "仲壬",
    bio: "汤之子、外丙之弟，亦称中壬。孟子、史记均记在位四年；周祭未见其名，即位与否有争议。",
  }),
  shangKing({
    id: "zi-taijia",
    given: "至",
    dayName: "太甲",
    wikiTitle: "太甲",
    bio: "汤之孙，名至；商朝早期重要君主，与伊尹传说相关。",
  }),
  shangKing({
    id: "zi-woding",
    given: "绚",
    dayName: "沃丁",
    wikiTitle: "沃丁",
    bio: "太甲之子，名绚；伊尹卒后仍用伊尹诸子及咎单为政。",
  }),
  shangKing({
    id: "zi-taigeng",
    given: "辩",
    dayName: "太庚",
    extraAlt: ["大庚"],
    wikiTitle: "太庚",
    bio: "沃丁之弟，名辩，又称大庚。",
  }),
  shangKing({
    id: "zi-xiaojia",
    given: "高",
    dayName: "小甲",
    wikiTitle: "小甲",
    bio: "太庚之子，名高，商代早中期君主。",
  }),
  shangKing({
    id: "zi-yongji",
    given: "伷",
    dayName: "雍己",
    wikiTitle: "雍己",
    bio: "小甲之弟，名伷；传统记载此际诸侯不朝、殷道始衰。甲骨周祭或次太戊之后。",
  }),
  shangKing({
    id: "zi-taiwu",
    given: "密",
    dayName: "太戊",
    extraAlt: ["大戊"],
    wikiTitle: "太戊",
    bio: "雍己之弟，名密，又称大戊；传统称中宗，与伊陟、巫咸辅政而复兴。",
  }),
  { id: "yi-zhi", name: "伊陟", clanShi: "伊", roles: ["政治家"], bio: "伊尹之子，太戊时为相。传说亳有祥桑榖合生，伊陟劝太戊修德，殷道复兴。生卒年不可考。", links: wiki("伊陟") },
  { id: "wu-xian", name: "巫咸", roles: ["政治家", "学者"], bio: "太戊时大臣，与伊陟并治；后世亦传为巫师、星历之祖。生卒年不可考。", links: wiki("巫咸") },
  shangKing({
    id: "zi-zhongding",
    given: "庄",
    dayName: "仲丁",
    extraAlt: ["中丁"],
    wikiTitle: "仲丁",
    bio: "太戊之子，名庄；迁于嚣，九世之乱始。",
  }),
  shangKing({
    id: "zi-wairen",
    given: "发",
    dayName: "外壬",
    extraAlt: ["卜壬"],
    wikiTitle: "外壬",
    bio: "仲丁之弟，名发；甲骨或作卜壬，九世之乱中继位。",
  }),
  shangKing({
    id: "zi-hedanjia",
    given: "整",
    dayName: "河亶甲",
    extraAlt: ["戔甲"],
    wikiTitle: "河亶甲",
    bio: "外壬之弟，名整；甲骨作戔甲，传统记载曾迁于相。",
  }),
  shangKing({
    id: "zi-zuyi",
    given: "滕",
    dayName: "祖乙",
    wikiTitle: "祖乙",
    bio: "河亶甲之子，名滕；传统记载迁邢、殷道再兴。",
  }),
  shangKing({
    id: "zi-zuxin",
    given: "旦",
    dayName: "祖辛",
    wikiTitle: "祖辛",
    bio: "祖乙之子，名旦，商代早中期君主。",
  }),
  shangKing({
    id: "zi-wojia",
    given: "踰",
    dayName: "沃甲",
    extraAlt: ["开甲", "羌甲"],
    wikiTitle: "沃甲",
    bio: "祖辛之弟，名踰；竹书或作开甲，甲骨或作羌甲。",
  }),
  shangKing({
    id: "zi-zuding",
    given: "新",
    dayName: "祖丁",
    wikiTitle: "祖丁",
    bio: "沃甲之侄、祖辛之子，名新；传统记载居庇。",
  }),
  shangKing({
    id: "zi-nangeng",
    given: "更",
    dayName: "南庚",
    wikiTitle: "南庚",
    bio: "沃甲之子，名更；传统记载自庇迁于奄。",
  }),
  shangKing({
    id: "zi-yangjia",
    given: "和",
    dayName: "阳甲",
    wikiTitle: "阳甲",
    bio: "祖丁之子、盘庚之兄，名和；传统记载此际殷衰。",
  }),
  shangKing({
    id: "zi-pangeng",
    given: "旬",
    dayName: "盘庚",
    wikiTitle: "盘庚",
    bio: "祖丁之子，名旬；约前1300年迁都于殷，晚商以此为界。",
  }),
  shangKing({
    id: "zi-xiaoxin",
    given: "颂",
    dayName: "小辛",
    wikiTitle: "小辛",
    bio: "盘庚之弟，名颂；迁殷后继位，传统记载殷道再衰。",
  }),
  shangKing({
    id: "zi-xiaoyi",
    given: "敛",
    dayName: "小乙",
    wikiTitle: "小乙_(商朝)",
    bio: "小辛之弟、武丁之父，名敛；传统记载仍居殷。",
  }),
  shangKing({
    id: "zi-wuding",
    given: "昭",
    dayName: "武丁",
    wikiTitle: "武丁",
    bio: "小乙之子，名昭；商高宗，甲骨文所见盛世之王，史称武丁中兴。",
  }),
  { id: "fu-hao", name: "妇好", altNames: ["帚好"], death: ym(-1200), roles: ["王后", "军事家"], bio: "武丁配偶，甲骨所见女将、祭司，殷墟有墓。生年不详；卒于武丁在世时，年取考古通行约前1200年。", links: wiki("妇好") },
  { id: "gan-pan", name: "甘盘", altNames: ["甘盤"], roles: ["政治家"], bio: "小乙、武丁时大臣。传说小乙命其傅武丁；武丁即位后为卿士，不久卒，傅说继之。《尚书·君奭》以之与伊尹、伊陟并称。生卒年不可考。", links: wiki("甘盘") },
  { id: "fu-yue", name: "傅说", altNames: ["傅說"], roles: ["政治家"], bio: "武丁之相。传说原在傅岩版筑为胥靡，武丁梦得圣人而举以为相，助成武丁中兴。生卒年不可考。", links: wiki("傅说") },
  shangKing({
    id: "zi-zugeng",
    given: "跃",
    dayName: "祖庚",
    extraAlt: ["曜"],
    wikiTitle: "祖庚",
    bio: "武丁之子，名跃，一作曜；甲骨文作「且庚」。断代工程将祖庚至庚丁合为前1191–前1148年，年精度下四王平分。",
  }),
  shangKing({
    id: "zi-zujia",
    given: "载",
    dayName: "祖甲",
    wikiTitle: "祖甲",
    bio: "武丁之子、祖庚之弟，名载；甲骨文作「且甲」。与祖庚、廪辛、庚丁同属断代工程前1191–前1148年窗口。",
  }),
  shangKing({
    id: "zi-linxin",
    given: "先",
    dayName: "廪辛",
    extraAlt: ["冯辛"],
    wikiTitle: "廪辛",
    bio: "祖甲之子，名先；竹书或作冯辛。与祖庚、祖甲、庚丁同属断代工程前1191–前1148年窗口。",
  }),
  shangKing({
    id: "zi-gengding",
    given: "嚣",
    dayName: "庚丁",
    extraAlt: ["康丁"],
    wikiTitle: "康丁",
    bio: "廪辛之弟，名嚣；甲骨作文丁前的康丁，《史记》作庚丁。四王窗口之末，死年归本王，武乙次年起算。",
  }),
  shangKing({
    id: "zi-wuyi",
    given: "瞿",
    dayName: "武乙",
    wikiTitle: "武乙",
    bio: "庚丁之子，名瞿；晚商之王，断代工程定其在位前1147–前1113年。",
  }),
  shangKing({
    id: "zi-wending",
    given: "托",
    dayName: "文丁",
    extraAlt: ["太丁"],
    wikiTitle: "文丁",
    bio: "武乙之子，名托；晚商之王，《史记》或作太丁。",
  }),
  shangKing({
    id: "zi-diyi",
    given: "羡",
    dayName: "帝乙",
    wikiTitle: "帝乙",
    bio: "文丁之子、帝辛之父，名羡。",
  }),
  shangKing({
    id: "zi-dixin",
    given: "受",
    dayName: "帝辛",
    extraAlt: ["纣", "受德"],
    wikiTitle: "帝辛",
    bio: "商朝末代之王，名受，一名受德；周谥纣，牧野之战亡于周。",
  }),
  { id: "bi-gan", name: "比干", ancestralXing: "子", death: ym(-1046), roles: ["政治家", "宗室"], bio: "商末少师，文丁之子、帝辛叔父。《论语》与微子、箕子并称殷有三仁。传说强谏被剖心。生年不详；死年取牧野之年（断代工程前1046年），示纣末。", links: wiki("比干") },
  { id: "ji-zi", name: "箕子", altNames: ["胥余"], ancestralXing: "子", roles: ["政治家", "宗室"], bio: "商末宗室，帝辛诸父或庶兄。传说谏纣被囚，武王克商后访之，后走朝鲜。生卒年不可考。", links: wiki("箕子") },
  { id: "ji-chang", name: "姬昌", roles: ["西伯", "君主"], bio: "周文王，商末西伯，武王之父。", links: wiki("周文王") },
  { id: "ji-fa", name: "姬发", roles: ["天子"], bio: "周武王，牧野克商，建立西周。", links: wiki("周武王") },
  { id: "ji-dan", name: "姬旦", roles: ["政治家"], bio: "周公旦，武王之弟，成王初摄政，东征平三监。", links: wiki("周公旦") },
  { id: "lv-shang", name: "吕尚", birth: ym(-1156), death: ym(-1017), roles: ["军事家", "政治家"], bio: "姜太公（姜子牙），辅武王克商，封于齐。", links: wiki("姜子牙") },
  { id: "ji-song", name: "姬诵", roles: ["天子"], bio: "周成王，周公辅政，与康王并称成康之治。", links: wiki("周成王") },
  { id: "ji-zhao", name: "姬钊", roles: ["天子"], bio: "周康王，成康之治后期之王。", links: wiki("周康王") },
  { id: "ji-xia", name: "姬瑕", roles: ["天子"], bio: "周昭王，南征荆楚，传说卒于汉水。", links: wiki("周昭王") },
  { id: "ji-man", name: "姬满", roles: ["天子"], bio: "周穆王，西周在位最久的天子之一。", links: wiki("周穆王") },
  { id: "ji-yihu", name: "姬繄扈", roles: ["天子"], bio: "周共王，穆王之子。", links: wiki("周共王") },
  { id: "ji-jian", name: "姬囏", roles: ["天子"], bio: "周懿王，断代工程以元年天再旦为前899年。", links: wiki("周懿王") },
  { id: "ji-pifang", name: "姬辟方", roles: ["天子"], bio: "周孝王，共王之弟，继懿王而立。", links: wiki("周孝王") },
  { id: "ji-xie", name: "姬燮", roles: ["天子"], bio: "周夷王。", links: wiki("周夷王") },
  { id: "ji-hu", name: "姬胡", roles: ["天子"], bio: "周厉王，专利引发国人暴动，出奔于彘。", links: wiki("周厉王") },
  { id: "ji-jing", name: "姬静", roles: ["天子"], bio: "周宣王，共和之后即位，史称宣王中兴。", links: wiki("周宣王") },
  { id: "ji-gongsheng", name: "姬宫湦", roles: ["天子"], bio: "周幽王，犬戎之祸中身死，西周终结。", links: wiki("周幽王") },
  {
    id: "ji-yijiu",
    name: "姬宜臼",
    roles: ["天子"],
    bio: "周平王，申侯等拥立；与携王二王并立，东迁洛邑后后世视为东周正统。",
    links: wiki("周平王"),
  },
  {
    id: "ji-yuchen",
    name: "姬余臣",
    roles: ["天子"],
    bio: "周携王（携惠王），幽王弟；虢公翰等拥立于携，与平王并立；前750年晋文侯杀之。",
    links: wiki("周携王"),
  },
  { id: "ji-lin", name: "姬林", roles: ["天子"], bio: "周桓王。", links: wiki("周桓王") },
  { id: "ji-tuo", name: "姬佗", roles: ["天子"], bio: "周庄王。", links: wiki("周庄王") },
  { id: "ji-huqi", name: "姬胡齐", roles: ["天子"], bio: "周釐王，亦作周僖王。", links: wiki("周釐王") },
  { id: "ji-lang", name: "姬阆", roles: ["天子"], bio: "周惠王，其间有王子颓之乱。", links: wiki("周惠王") },
  { id: "ji-zheng", name: "姬郑", roles: ["天子"], bio: "周襄王，晋文公勤王前后在位。", links: wiki("周襄王") },
  { id: "ji-renchen", name: "姬壬臣", roles: ["天子"], bio: "周顷王。", links: wiki("周顷王") },
  { id: "ji-ban", name: "姬班", roles: ["天子"], bio: "周匡王。", links: wiki("周匡王") },
  { id: "ji-yu", name: "姬瑜", roles: ["天子"], bio: "周定王。", links: wiki("周定王") },
  { id: "ji-yi", name: "姬夷", roles: ["天子"], bio: "周简王。", links: wiki("周简王") },
  { id: "ji-xiexin", name: "姬泄心", roles: ["天子"], bio: "周灵王。", links: wiki("周灵王") },
  { id: "ji-gui", name: "姬贵", roles: ["天子"], bio: "周景王。", links: wiki("周景王") },
  { id: "ji-meng", name: "姬猛", roles: ["天子"], bio: "周悼王，在位仅数月。", links: wiki("周悼王") },
  { id: "ji-gai", name: "姬匄", roles: ["天子"], bio: "周敬王，春秋与战国之交的周天子。", links: wiki("周敬王") },
  { id: "ji-ren", name: "姬仁", roles: ["天子"], bio: "周元王。", links: wiki("周元王") },
  { id: "ji-jie", name: "姬介", roles: ["天子"], bio: "周贞定王。", links: wiki("周贞定王") },
  { id: "ji-quji", name: "姬去疾", roles: ["天子"], bio: "周哀王。史记：立三月，为弟叔袭杀。", links: wiki("周哀王") },
  { id: "ji-shu", name: "姬叔", roles: ["天子"], bio: "周思王。史记：杀哀王而立，立五月，旋为考王所杀。", links: wiki("周思王") },
  { id: "ji-wei", name: "姬嵬", roles: ["天子"], bio: "周考王。", links: wiki("周考王") },
  { id: "ji-wu", name: "姬午", roles: ["天子"], bio: "周威烈王，前403年命韩赵魏为诸侯。", links: wiki("周威烈王") },
  { id: "ji-jiao", name: "姬骄", roles: ["天子"], bio: "周安王。", links: wiki("周安王") },
  { id: "ji-xi", name: "姬喜", roles: ["天子"], bio: "周烈王。", links: wiki("周烈王") },
  { id: "ji-bian", name: "姬扁", roles: ["天子"], bio: "周显王。", links: wiki("周显王") },
  { id: "ji-ding", name: "姬定", roles: ["天子"], bio: "周慎靓王。", links: wiki("周慎靓王") },
  { id: "ji-yan", name: "姬延", roles: ["天子"], bio: "周赧王，东周末代天子，前256年周亡于秦。", links: wiki("周赧王") },
  { id: "jiang-xiaobai", name: "姜小白", roles: ["诸侯"], bio: "齐桓公，春秋首霸，葵丘会盟。", links: wiki("齐桓公") },
  { id: "guan-zhong", name: "管仲", roles: ["政治家"], bio: "齐桓公之相，助齐称霸。", links: wiki("管仲") },
  { id: "ji-chonger", name: "姬重耳", roles: ["诸侯"], bio: "晋文公，城濮之战胜楚，成为中原霸主。", links: wiki("晋文公") },
  {
    id: "kong-qiu",
    name: "孔丘",
    birth: ym(-551),
    death: ym(-479),
    roles: ["思想家"],
    bio: "孔子，儒家开创者，传统生卒前551–前479年。",
    links: wiki("孔子"),
  },
  // 非帝王人物
  { id: "da-ji", name: "妲己", death: ym(-1046), roles: ["后妃"], bio: "传说中商末帝辛宠妃。生卒无实测；卒年取牧野之年（前1046年），示商亡。", links: wiki("妲己") },
  { id: "bao-si", name: "褒姒", roles: ["后妃"], bio: "周幽王宠妃，传说与烽火戏诸侯、犬戎之祸相关。", links: wiki("褒姒") },
  { id: "ji-shi", name: "姬奭", roles: ["政治家"], bio: "召公奭，周武王弟，与周公旦分陕而治，辅佐成康。", links: wiki("召公奭") },
];

const dynasties = [
  {
    id: "xia",
    name: "夏",
    altNames: ["夏后氏"],
    scope: "cn",
    region: "east_asia",
    start: ym(-2070),
    end: ym(-1600, 12),
    precision: "year",
    note: "王朝窗口取断代工程前2070–前1600。各王起迄依今本《竹书纪年》在位年数自夏始顺推（桀用《帝王世纪》五十二年以接商汤），全部标 interpolated。相、少康之间有穷后羿、寒浞占夏行而非夏后正统。",
  },
  {
    id: "shang",
    name: "商",
    altNames: ["殷", "殷商"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1600),
    end: ym(-1046),
    precision: "year",
    note: "断代工程：商始约前1600年，盘庚迁殷约前1300年，武王克商前1046年。",
  },
  {
    id: "zhou-west",
    name: "西周",
    altNames: ["周"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1046),
    end: ym(-771, 12),
    precision: "year",
    note: "武王克商至犬戎破镐。列王年取夏商周断代工程《夏商周年表》。",
  },
  {
    id: "zhou-east",
    name: "东周",
    altNames: ["周"],
    scope: "cn",
    region: "east_asia",
    start: ym(-770),
    end: ym(-256, 12),
    precision: "year",
    note: "平王东迁至秦灭周。前770–前750年与携王二王并立，后世以平王为正统（claim_track 主线）。",
  },
];

function interpolatedConfidence(flag) {
  if (flag === true) {
    return { startDateConfidence: "interpolated", endDateConfidence: "interpolated" };
  }
  if (flag && typeof flag === "object") {
    return {
      startDateConfidence: flag.start ? "interpolated" : null,
      endDateConfidence: flag.end ? "interpolated" : null,
    };
  }
  return { startDateConfidence: null, endDateConfidence: null };
}

function reign({
  id,
  dynastyId,
  personId,
  title,
  posthumousName,
  templeName,
  start,
  end,
  precision = "year",
  startDateConfidence = null,
  endDateConfidence = null,
  claimTrack,
  claimLabel,
  claimRole,
}) {
  return {
    id,
    dynastyId,
    personId,
    title,
    posthumousName,
    templeName,
    eraNames: [],
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    precision,
    startDateConfidence,
    endDateConfidence,
    claimTrack,
    claimLabel,
    claimRole,
  };
}

function xiaReign(personId, _title, cardName, startYear, endYear, claim = null) {
  return reign({
    id: `reign-${personId}`,
    dynastyId: "xia",
    personId,
    title: cardName,
    start: ym(startYear),
    end: ym(endYear, 12),
    ...interpolatedConfidence(true),
    claimTrack: claim?.track,
    claimLabel: claim?.label,
    claimRole: claim?.role ?? (claim?.track ? "rival" : undefined),
  });
}

/** 今本竹书在位年自夏始顺推；桀取帝王世纪五十二年以接前1600。 */
const XIA_MAIN_KINGS = [
  { personId: "si-yu", title: "夏禹", card: "禹", startYear: -2070, endYear: -2061 },
  { personId: "si-qi", title: "夏启", card: "启", startYear: -2060, endYear: -2045 },
  { personId: "si-taikang", title: "夏太康", card: "太康", startYear: -2044, endYear: -2041 },
  { personId: "si-zhongkang", title: "夏仲康", card: "仲康", startYear: -2040, endYear: -2028 },
  { personId: "si-xiang", title: "夏相", card: "相", startYear: -2027, endYear: -2000 },
  { personId: "si-shaokang", title: "夏少康", card: "少康", startYear: -1959, endYear: -1939 },
  { personId: "si-zhu", title: "夏杼", card: "杼", startYear: -1938, endYear: -1922 },
  { personId: "si-huai", title: "夏槐", card: "槐", startYear: -1921, endYear: -1878 },
  { personId: "si-mang", title: "夏芒", card: "芒", startYear: -1877, endYear: -1820 },
  { personId: "si-xie", title: "夏泄", card: "泄", startYear: -1819, endYear: -1795 },
  { personId: "si-bujiang", title: "夏不降", card: "不降", startYear: -1794, endYear: -1736 },
  { personId: "si-jiong", title: "夏扃", card: "扃", startYear: -1735, endYear: -1718 },
  { personId: "si-jin", title: "夏廑", card: "廑", startYear: -1717, endYear: -1710 },
  { personId: "si-kongjia", title: "夏孔甲", card: "孔甲", startYear: -1709, endYear: -1679 },
  { personId: "si-gao", title: "夏皋", card: "皋", startYear: -1678, endYear: -1668 },
  { personId: "si-fa", title: "夏发", card: "发", startYear: -1667, endYear: -1652 },
  { personId: "si-jie", title: "夏桀", card: "桀", startYear: -1651, endYear: -1600 },
];

const xiaMainReigns = XIA_MAIN_KINGS.map((king) =>
  xiaReign(king.personId, king.title, king.card, king.startYear, king.endYear),
);

function xiaReignYears(personId) {
  const row = xiaMainReigns.find((r) => r.personId === personId);
  if (!row) throw new Error(`missing Xia reign ${personId}`);
  return { startYear: row.start.year, endYear: row.end.year };
}

const taikangYears = xiaReignYears("si-taikang");

const xiaUsurperReigns = [
  xiaReign("hou-yi", "有穷后羿", "后羿", -1999, -1992, { role: "rival" }),
  xiaReign("han-zhuo", "寒浞", "寒浞", -1991, -1960, { role: "rival" }),
];

const xiaReigns = [...xiaMainReigns, ...xiaUsurperReigns];

/** 商王称号如「商沃丁」「商王武丁」→ 谥号/日名「沃丁」「武丁」。 */
function shangPosthumousFromTitle(title) {
  const core = title.replace(/^商王?/, "");
  if (core === "帝辛") return "纣";
  return core;
}

function shangReign(personId, title, startYear, endYear, overrides = {}) {
  const endMonth = overrides.endMonth ?? 12;
  return reign({
    id: `reign-${personId}`,
    dynastyId: "shang",
    personId,
    title,
    posthumousName:
      overrides.posthumousName ?? shangPosthumousFromTitle(title),
    templeName: overrides.templeName,
    start: ym(startYear, overrides.startMonth ?? 1),
    end: ym(endYear, endMonth),
    ...interpolatedConfidence(overrides.interpolated),
  });
}

/** 竹书纪年各王在位年数；首尾锚定既有太甲、盘庚年，末王阳甲填满剩余窗口。 */
function chainShangReigns(entries, firstStartYear, lastEndYear) {
  const items = [];
  let startYear = firstStartYear;
  for (let i = 0; i < entries.length; i += 1) {
    const entry = entries[i];
    const years =
      i === entries.length - 1 ? lastEndYear - startYear + 1 : entry.years;
    const endYear = startYear + years - 1;
    items.push(
      reign({
        id: `reign-${entry.personId}`,
        dynastyId: "shang",
        personId: entry.personId,
        title: entry.title,
        posthumousName:
          entry.posthumousName ?? shangPosthumousFromTitle(entry.title),
        templeName: entry.templeName,
        start: ym(startYear),
        end: ym(endYear, 12),
        ...interpolatedConfidence(entry.interpolated),
      }),
    );
    startYear = endYear + 1;
  }
  return items;
}

const shangEarlyReigns = chainShangReigns(
  [
    { personId: "zi-woding", title: "商沃丁", years: 19 },
    { personId: "zi-taigeng", title: "商太庚", years: 5 },
    { personId: "zi-xiaojia", title: "商小甲", years: 17 },
    { personId: "zi-yongji", title: "商雍己", years: 12 },
    { personId: "zi-taiwu", title: "商太戊", templeName: "中宗", years: 75 },
    { personId: "zi-zhongding", title: "商仲丁", years: 9 },
    { personId: "zi-wairen", title: "商外壬", years: 10 },
    { personId: "zi-hedanjia", title: "商河亶甲", years: 9 },
    { personId: "zi-zuyi", title: "商祖乙", years: 19 },
    { personId: "zi-zuxin", title: "商祖辛", years: 14 },
    { personId: "zi-wojia", title: "商沃甲", years: 20 },
    { personId: "zi-zuding", title: "商祖丁", years: 9 },
    { personId: "zi-nangeng", title: "商南庚", years: 6 },
    { personId: "zi-yangjia", title: "商阳甲", years: 13 },
  ],
  -1547,
  -1311,
);

const shangLateReigns = chainShangReigns(
  [
    { personId: "zi-xiaoxin", title: "商小辛", years: 3 },
    { personId: "zi-xiaoyi", title: "商小乙", years: 3, interpolated: true },
  ],
  -1279,
  -1251,
);

const shangReigns = [
  shangReign("zi-tang", "商汤", -1600, -1571, {
    posthumousName: "武王",
    templeName: "高祖",
  }),
  // 汤、太甲为传统积年锚点。中间旧标「史料缺」实为外丙、仲壬；孟子/竹书 2+4 年、史记 3+4 年，此处按二王平分窗口。
  shangReign("zi-waibing", "商外丙", -1570, -1566, { interpolated: true }),
  shangReign("zi-zhongren", "商仲壬", -1565, -1561, { interpolated: true }),
  shangReign("zi-taijia", "商太甲", -1560, -1548, { templeName: "太宗" }),
  ...shangEarlyReigns,
  shangReign("zi-pangeng", "商盘庚", -1310, -1280, { templeName: "世祖" }),
  ...shangLateReigns,
  shangReign("zi-wuding", "商王武丁", -1250, -1192, { templeName: "高宗" }),
  // 夏商周年表：祖庚、祖甲、廪辛、庚丁合占前1191–前1148；四王平分，武乙从前1147年起。
  ...chainShangReigns(
    [
      { personId: "zi-zugeng", title: "商王祖庚", years: 11, interpolated: true },
      { personId: "zi-zujia", title: "商王祖甲", years: 11, interpolated: true },
      { personId: "zi-linxin", title: "商王廪辛", years: 11, interpolated: true },
      { personId: "zi-gengding", title: "商王庚丁", years: 11, interpolated: true },
    ],
    -1191,
    -1148,
  ),
  shangReign("zi-wuyi", "商王武乙", -1147, -1113),
  shangReign("zi-wending", "商王文丁", -1112, -1102),
  shangReign("zi-diyi", "商王帝乙", -1101, -1076),
  shangReign("zi-dixin", "商王帝辛", -1075, -1046, { endMonth: 1 }),
];

function zhouReign(
  personId,
  title,
  posthumous,
  startYear,
  endYear,
  dynastyId,
  startMonth = 1,
  endMonth = 12,
  claim = null,
) {
  return reign({
    id: `reign-${personId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    start: ym(startYear, startMonth),
    end: ym(endYear, endMonth),
    claimTrack: claim?.track,
    claimLabel: claim?.label,
    claimRole: claim?.track ? "rival" : undefined,
  });
}

const zhouWestReigns = [
  zhouReign("ji-fa", "周武王", "武王", -1046, -1043, "zhou-west"),
  zhouReign("ji-song", "周成王", "成王", -1042, -1021, "zhou-west"),
  zhouReign("ji-zhao", "周康王", "康王", -1020, -996, "zhou-west"),
  zhouReign("ji-xia", "周昭王", "昭王", -995, -977, "zhou-west"),
  zhouReign("ji-man", "周穆王", "穆王", -976, -923, "zhou-west"),
  zhouReign("ji-yihu", "周共王", "共王", -922, -900, "zhou-west"),
  zhouReign("ji-jian", "周懿王", "懿王", -899, -892, "zhou-west"),
  zhouReign("ji-pifang", "周孝王", "孝王", -891, -886, "zhou-west"),
  zhouReign("ji-xie", "周夷王", "夷王", -885, -878, "zhou-west"),
  zhouReign("ji-hu", "周厉王", "厉王", -877, -841, "zhou-west"),
  zhouReign("ji-jing", "周宣王", "宣王", -827, -782, "zhou-west"),
  zhouReign("ji-gongsheng", "周幽王", "幽王", -781, -771, "zhou-west"),
];

const zhouEastReigns = [
  zhouReign("ji-yijiu", "周平王", "平王", -770, -720, "zhou-east"),
  zhouReign("ji-yuchen", "周携王", "携王", -770, -750, "zhou-east", 1, 12, {
    track: "xie",
    label: "携",
  }),
  zhouReign("ji-lin", "周桓王", "桓王", -719, -697, "zhou-east"),
  zhouReign("ji-tuo", "周庄王", "庄王", -696, -682, "zhou-east"),
  zhouReign("ji-huqi", "周釐王", "釐王", -681, -677, "zhou-east"),
  zhouReign("ji-lang", "周惠王", "惠王", -676, -652, "zhou-east"),
  zhouReign("ji-zheng", "周襄王", "襄王", -651, -619, "zhou-east"),
  zhouReign("ji-renchen", "周顷王", "顷王", -618, -613, "zhou-east"),
  zhouReign("ji-ban", "周匡王", "匡王", -612, -607, "zhou-east"),
  zhouReign("ji-yu", "周定王", "定王", -606, -586, "zhou-east"),
  zhouReign("ji-yi", "周简王", "简王", -585, -572, "zhou-east"),
  zhouReign("ji-xiexin", "周灵王", "灵王", -571, -545, "zhou-east"),
  zhouReign("ji-gui", "周景王", "景王", -544, -521, "zhou-east"),
  zhouReign("ji-meng", "周悼王", "悼王", -520, -520, "zhou-east"),
  zhouReign("ji-gai", "周敬王", "敬王", -519, -477, "zhou-east"),
  zhouReign("ji-ren", "周元王", "元王", -476, -469, "zhou-east"),
  zhouReign("ji-jie", "周贞定王", "贞定王", -468, -442, "zhou-east"),
  // 史记：哀王立三月、思王立五月。无历月，按时长把前441年顺序切开。
  zhouReign("ji-quji", "周哀王", "哀王", -441, -441, "zhou-east", 1, 3),
  zhouReign("ji-shu", "周思王", "思王", -441, -441, "zhou-east", 4, 12),
  zhouReign("ji-wei", "周考王", "考王", -440, -426, "zhou-east"),
  zhouReign("ji-wu", "周威烈王", "威烈王", -425, -402, "zhou-east"),
  zhouReign("ji-jiao", "周安王", "安王", -401, -376, "zhou-east"),
  zhouReign("ji-xi", "周烈王", "烈王", -375, -369, "zhou-east"),
  zhouReign("ji-bian", "周显王", "显王", -368, -321, "zhou-east"),
  zhouReign("ji-ding", "周慎靓王", "慎靓王", -320, -315, "zhou-east"),
  zhouReign("ji-yan", "周赧王", "赧王", -314, -256, "zhou-east"),
];

const reigns = alignReignSeamConfidences([
  ...xiaReigns,
  ...shangReigns,
  ...zhouWestReigns,
  ...zhouEastReigns,
]);

const seamErrors = validateReignDateConfidenceSeams(reigns);
if (seamErrors.length) {
  console.error("Reign seam validation failed:");
  for (const error of seamErrors) console.error(" ", error);
  process.exit(1);
}

const finalized = finalizeImportReigns("xia-shang-zhou", persons, reigns);
const merged = mergeAppellationsIntoPersons(finalized.persons, finalized.reigns);
const importPersons = merged.persons;
const importReigns = merged.reigns;
const { missingReigns } = finalized;

const personDynastyId = new Map();
for (const reign of importReigns) {
  personDynastyId.set(reign.personId, reign.dynastyId);
}
applyFeudalClanMetadata({ persons: importPersons, dynasties, personDynastyId });

function eventPoint(partial) {
  const precision = partial.precision ?? "year";
  const at = normalizeYearPrecisionAt(partial.at, precision);
  return {
    kind: "other",
    timeMode: "point",
    precision: "year",
    dynastyIds: [],
    participantIds: [],
    ...partial,
    precision,
    at,
    atAbs: at.abs,
  };
}
function eventRange(partial) {
  const start = partial.start;
  const end = partial.end;
  const precision = partial.precision ?? "year";
  const at = partial.at ? normalizeYearPrecisionAt(partial.at, precision) : undefined;
  return {
    kind: "other",
    precision: "year",
    dynastyIds: [],
    participantIds: [],
    dateNote: undefined,
    ...partial,
    precision,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    ...(at ? { at, atAbs: at.abs } : {}),
  };
}

function shangReignYears(personId) {
  const row = shangReigns.find((r) => r.personId === personId);
  if (!row) throw new Error(`missing Shang reign ${personId}`);
  return { startYear: row.start.year, endYear: row.end.year };
}

const qiYears = xiaReignYears("si-qi");
const shaokangYears = xiaReignYears("si-shaokang");
const kongjiaYears = xiaReignYears("si-kongjia");
const jieYears = xiaReignYears("si-jie");
const taiwuYears = shangReignYears("zi-taiwu");

const events = [
  eventRange({
    id: "yu-flood-control",
    name: "大禹治水",
    kind: "other",
    timeMode: "circa",
    precision: "century",
    dateNote: "传说时代，具体年月不可考；窗口取夏朝建立前后的世纪尺度",
    start: ym(-2100),
    end: ym(-2070, 12),
    at: ym(-2070),
    dynastyIds: ["xia"],
    participantIds: ["si-yu", "gun", "gao-yao", "bo-yi", "tu-shan-shi"],
    summary: "传说禹疏导洪水，其后受禅，为夏后氏开国叙事的核心。",
  }),
  eventRange({
    id: "gan-battle",
    name: "甘之战",
    kind: "battle",
    timeMode: "circa",
    precision: "decade",
    dateNote: "《尚书·甘誓》载启伐有扈；绝对年取今本竹书年数自夏始顺推后的启在位段，标推算",
    start: ym(qiYears.startYear),
    end: ym(qiYears.endYear, 12),
    at: ym(qiYears.startYear + Math.floor((qiYears.endYear - qiYears.startYear) / 2)),
    dynastyIds: ["xia"],
    participantIds: ["si-qi"],
    summary: "夏启讨伐有扈氏，传统视为世袭王权确立过程中的战争。",
  }),
  eventRange({
    id: "taikang-lost",
    name: "太康失国",
    kind: "politics",
    timeMode: "circa",
    precision: "decade",
    dateNote: "太康失位传说。窗口取太康在位段（前2044–前2041）。",
    start: ym(taikangYears.startYear),
    end: ym(taikangYears.endYear, 12),
    at: ym(taikangYears.startYear, 12),
    dynastyIds: ["xia"],
    participantIds: ["si-taikang", "hou-yi"],
    summary: "太康失位，有穷后羿因夏民以代夏政。",
  }),
  eventRange({
    id: "shaokang-zhongxing",
    name: "少康中兴",
    kind: "politics",
    timeMode: "circa",
    precision: "decade",
    dateNote: "少康灭寒浞、恢复夏政；窗口取今本竹书年数顺推后的少康在位段，标推算",
    start: ym(shaokangYears.startYear),
    end: ym(shaokangYears.endYear, 12),
    at: ym(shaokangYears.startYear),
    dynastyIds: ["xia"],
    participantIds: ["si-shaokang", "hou-min", "han-zhuo", "han-jiao"],
    summary: "后缗逃归有仍生少康；少康自有虞起兵，消灭寒浞、过浇，恢复夏后氏统治。",
  }),
  eventRange({
    id: "kongjia-decline",
    name: "孔甲乱德",
    kind: "politics",
    timeMode: "circa",
    precision: "decade",
    dateNote: "《史记·夏本纪》记孔甲好鬼神、夏德衰；绝对年取今本竹书年数顺推后的孔甲在位段，标推算",
    start: ym(kongjiaYears.startYear),
    end: ym(kongjiaYears.endYear, 12),
    at: ym(kongjiaYears.startYear + Math.floor((kongjiaYears.endYear - kongjiaYears.startYear) / 2)),
    dynastyIds: ["xia"],
    participantIds: ["si-kongjia"],
    summary: "帝孔甲好方鬼神、事淫乱，夏后氏德衰、诸侯畔之；又有扰龙、刘累御龙传说。",
  }),
  eventRange({
    id: "guanlongpang-remonstrance",
    name: "关龙逢谏桀",
    kind: "politics",
    timeMode: "circa",
    precision: "decade",
    dateNote: "桀杀关龙逢出于《韩诗外传》等，具体年份不可考；窗取桀在位末段，标推算",
    start: ym(Math.max(jieYears.startYear, jieYears.endYear - 9)),
    end: ym(jieYears.endYear, 12),
    at: ym(jieYears.endYear),
    dynastyIds: ["xia"],
    participantIds: ["si-jie", "guan-longpang"],
    summary: "传说夏桀通宵宴乐，关龙逢进黄图强谏，被桀所杀。",
  }),
  eventRange({
    id: "mingtiao",
    name: "鸣条之战",
    kind: "battle",
    timeMode: "circa",
    precision: "decade",
    dateNote: "夏商分界取断代工程约前1600年，战役月日不详",
    start: ym(-1610),
    end: ym(-1600, 12),
    at: ym(-1600),
    dynastyIds: ["xia", "shang"],
    participantIds: ["si-jie", "zi-tang", "yi-yin", "zhong-hui", "mo-xi"],
    summary: "商汤与伊尹在鸣条击败夏桀，夏亡商兴。",
  }),
  eventRange({
    id: "yiyin-taijia",
    name: "伊尹放太甲",
    kind: "politics",
    timeMode: "circa",
    precision: "decade",
    dateNote: "桐宫放逐出于《史记》等传说，具体年份不可考",
    start: ym(-1560),
    end: ym(-1548, 12),
    at: ym(-1555),
    dynastyIds: ["shang"],
    participantIds: ["yi-yin", "zi-taijia"],
    summary: "传说太甲不遵汤法，伊尹放之于桐，三年后迎归复位。",
  }),
  eventRange({
    id: "taiwu-revival",
    name: "太戊修德",
    kind: "politics",
    timeMode: "circa",
    precision: "decade",
    dateNote: "《史记》记太戊立伊陟为相、用巫咸；绝对年取本表太戊在位前十年（竹书积年，非实测）",
    start: ym(taiwuYears.startYear),
    end: ym(taiwuYears.startYear + 9, 12),
    at: ym(taiwuYears.startYear),
    dynastyIds: ["shang"],
    participantIds: ["zi-taiwu", "yi-zhi", "wu-xian"],
    summary: "太戊以伊陟为相，用巫咸；传说亳有祥桑榖，修德后枯死，殷道复兴。",
  }),
  eventRange({
    id: "pangeng-move-yin",
    name: "盘庚迁殷",
    kind: "politics",
    timeMode: "circa",
    precision: "decade",
    dateNote: "断代工程估定迁殷约前1300年，起迄年不详",
    start: ym(-1310),
    end: ym(-1290, 12),
    at: ym(-1300),
    dynastyIds: ["shang"],
    participantIds: ["zi-pangeng"],
    summary: "盘庚迁都于殷（今安阳），此后商亦称殷。",
  }),
  eventRange({
    id: "wuding-zhongxing",
    name: "武丁中兴",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    dateNote: "在位年取断代工程前1250–前1192年",
    start: ym(-1250),
    end: ym(-1192, 12),
    dynastyIds: ["shang"],
    participantIds: ["zi-wuding", "fu-hao", "fu-yue", "gan-pan"],
    summary: "武丁对外用兵、内修祭祀，晚商达到鼎盛；甘盘、傅说辅政，妇好亦主征伐。",
  }),
  eventRange({
    id: "fuyue-fuyan",
    name: "武丁举傅说",
    kind: "politics",
    timeMode: "circa",
    precision: "decade",
    dateNote: "《史记》《说命》记武丁梦傅说、举于傅岩；年份不详，窗取武丁在位前十年",
    start: ym(-1250),
    end: ym(-1241, 12),
    at: ym(-1250),
    dynastyIds: ["shang"],
    participantIds: ["zi-wuding", "fu-yue", "gan-pan"],
    summary: "传说傅说在傅岩版筑，武丁按梦中形象求得，举以为相。",
  }),
  eventRange({
    id: "bigan-killed",
    name: "比干谏死",
    kind: "politics",
    timeMode: "circa",
    precision: "year",
    dateNote: "《今本竹书》系于帝辛末年杀王子比干；绝对年取牧野前1046年，月日不详",
    start: ym(-1047),
    end: ym(-1046, 12),
    at: ym(-1046),
    dynastyIds: ["shang"],
    participantIds: ["zi-dixin", "bi-gan"],
    summary: "传说比干强谏帝辛，被剖心而死；与微子、箕子并称殷有三仁。",
  }),
  eventPoint({
    id: "muye",
    name: "牧野之战",
    kind: "battle",
    precision: "month",
    dateNote: "断代工程取前1046年1月20日；月取正月，日不入库",
    at: ym(-1046, 1),
    dynastyIds: ["shang", "zhou-west"],
    participantIds: ["zi-dixin", "ji-fa", "lv-shang", "da-ji"],
    summary: "周武王会师牧野克商，商周分界。",
  }),
  eventRange({
    id: "sanjian-rebellion",
    name: "三监之乱",
    kind: "battle",
    timeMode: "circa",
    precision: "year",
    dateNote: "成王初、周公摄政期间，绝对年据西周初框架",
    start: ym(-1042),
    end: ym(-1036, 12),
    at: ym(-1041),
    dynastyIds: ["zhou-west"],
    participantIds: ["ji-song", "ji-dan"],
    summary: "管蔡霍三监联合武庚叛周，周公东征平定，大规模封建东土。",
  }),
  eventRange({
    id: "chengkang-rule",
    name: "成康之治",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    dateNote: "对应断代工程成王、康王在位年",
    start: ym(-1042),
    end: ym(-996, 12),
    dynastyIds: ["zhou-west"],
    participantIds: ["ji-song", "ji-zhao", "ji-dan"],
    summary: "西周早期政治相对安定，传统称刑错四十余年不用。",
  }),
  eventRange({
    id: "zhaowang-south",
    name: "昭王南征",
    kind: "battle",
    timeMode: "circa",
    precision: "year",
    dateNote: "昭王卒年取断代工程前977年，南征次数与月份不详",
    start: ym(-995),
    end: ym(-977, 12),
    at: ym(-977),
    dynastyIds: ["zhou-west"],
    participantIds: ["ji-xia"],
    summary: "周昭王多次南征荆楚，传说还师渡汉水而卒。",
  }),
  eventPoint({
    id: "guoren-riot",
    name: "国人暴动",
    kind: "politics",
    precision: "year",
    dateNote: "共和元年即前841年，为中国有确切纪年之始",
    at: ym(-841),
    dynastyIds: ["zhou-west"],
    participantIds: ["ji-hu"],
    summary: "厉王专利，国人暴动，王奔彘，周召共和行政。",
  }),
  eventRange({
    id: "gonghe-regency",
    name: "共和行政",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    dateNote: "前841–前828年，一说周召二公共和，一说共伯和摄政",
    start: ym(-841),
    end: ym(-828, 12),
    dynastyIds: ["zhou-west"],
    participantIds: ["ji-hu"],
    summary: "厉王出奔后的十四年无王期，至宣王即位结束。",
  }),
  eventRange({
    id: "xuanwang-zhongxing",
    name: "宣王中兴",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    start: ym(-827),
    end: ym(-782, 12),
    dynastyIds: ["zhou-west"],
    participantIds: ["ji-jing"],
    summary: "宣王整顿朝政、征伐玁狁，西周国势一度回升。",
  }),
  eventPoint({
    id: "quanrong-invasion",
    name: "犬戎之祸",
    kind: "battle",
    precision: "year",
    dateNote: "幽王十一年，前771年",
    at: ym(-771),
    dynastyIds: ["zhou-west"],
    participantIds: ["ji-gongsheng", "ji-yijiu"],
    summary: "申侯联合犬戎攻破镐京，幽王死，西周亡。",
  }),
  eventPoint({
    id: "zhou-dual-kings",
    name: "二王并立",
    kind: "politics",
    precision: "year",
    dateNote: "前771年幽王死后",
    at: ym(-771),
    dynastyIds: ["zhou-east"],
    participantIds: ["ji-yijiu", "ji-yuchen"],
    summary: "申侯等立平王，虢公翰等立携王；后世以平王东迁为东周正统。",
  }),
  eventPoint({
    id: "xie-wang-killed",
    name: "晋文侯杀携王",
    kind: "politics",
    precision: "year",
    dateNote: "前750年",
    at: ym(-750),
    dynastyIds: ["zhou-east"],
    participantIds: ["ji-yuchen"],
    summary: "晋文侯攻灭携王，二王并立终结，平王正统确立。",
  }),
  eventPoint({
    id: "pingwang-eastward",
    name: "平王东迁",
    kind: "politics",
    precision: "year",
    dateNote: "平王元年，前770年",
    at: ym(-770),
    dynastyIds: ["zhou-east"],
    participantIds: ["ji-yijiu"],
    summary: "平王迁都洛邑，东周开始，王室逐渐失去对诸侯的实质控制。",
  }),
  eventRange({
    id: "chunqiu",
    name: "春秋",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    dateNote: "平王东迁（前770）至三家分晋（前403）；与战国以册命立国为界",
    start: ym(-770),
    end: ym(-403, 12),
    dynastyIds: ["zhou-east"],
    summary: "诸侯争霸、礼崩乐坏，周天子共主名存实亡。",
  }),
  eventPoint({
    id: "kuiqiu",
    name: "葵丘之盟",
    kind: "politics",
    precision: "year",
    dateNote: "齐桓公三十五年，鲁僖公九年，前651年",
    at: ym(-651),
    dynastyIds: ["zhou-east"],
    participantIds: ["jiang-xiaobai", "guan-zhong", "ji-zheng"],
    summary: "齐桓公会诸侯于葵丘，周襄王赐胙，齐霸达到顶点。",
  }),
  eventPoint({
    id: "chengpu",
    name: "城濮之战",
    kind: "battle",
    precision: "year",
    dateNote: "鲁僖公二十八年，前632年",
    at: ym(-632),
    dynastyIds: ["zhou-east"],
    participantIds: ["ji-chonger"],
    summary: "楚围宋，宋向晋求援。晋先攻曹，因卫拒绝借道，又出兵伐卫；楚将宛春提出复曹、卫以换取楚军解宋围。晋采纳先轸之策，扣留宛春，暗中许诺复曹、卫，借此离间楚与曹、卫；又依晋文公旧诺退避三舍，最终在城濮击败楚军。战后晋复曹、卫，并于践土会盟，确立霸主地位。",
  }),
  eventRange({
    id: "zhanguo",
    name: "战国",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    dateNote: "以三家分晋、周天子册命韩赵魏为诸侯（前403）为起点，迄秦统一前221年",
    start: ym(-403),
    end: ym(-221, 12),
    dynastyIds: ["zhou-east"],
    summary: "七雄兼并，变法图强，至秦始皇统一而结束。",
  }),
  eventPoint({
    id: "sanjia-fenjin",
    name: "三家分晋",
    kind: "politics",
    precision: "year",
    dateNote: "周威烈王二十三年正式命韩赵魏为诸侯，前403年",
    at: ym(-403),
    dynastyIds: ["zhou-east"],
    participantIds: ["ji-wu"],
    summary: "周天子承认韩、赵、魏，战国格局形成的标志性事件。",
  }),
  eventRange({
    id: "baijia-zhengming",
    name: "百家争鸣",
    kind: "culture",
    timeMode: "circa",
    precision: "century",
    dateNote: "思想活跃期约自春秋晚期至秦统一，并无单一起迄年",
    start: ym(-551),
    end: ym(-221, 12),
    at: ym(-400),
    dynastyIds: ["zhou-east"],
    participantIds: ["kong-qiu"],
    summary: "儒墨道法名等学派并起，塑造此后中国思想传统。",
  }),
];

function successionPairs(list) {
  const main = list.filter((r) => !r.claimTrack && r.claimRole !== "rival");
  const pairs = [];
  for (let i = 0; i < main.length - 1; i++) {
    pairs.push([main[i].personId, main[i + 1].personId]);
  }
  return pairs;
}

const relations = [];
for (const [fromId, toId] of [
  ...successionPairs(xiaReigns),
  ...successionPairs(shangReigns),
  ...successionPairs(zhouWestReigns),
  ...successionPairs(zhouEastReigns),
  ["ji-chang", "ji-fa"],
]) {
  relations.push({
    id: `rel-${fromId}-${toId}-succession`,
    fromRef: `person:${fromId}`,
    toRef: `person:${toId}`,
    kind: "succession",
  });
}
relations.push(
  {
    id: "rel-hou-yi-han-zhuo-succession",
    fromRef: "person:hou-yi",
    toRef: "person:han-zhuo",
    kind: "succession",
  },
  { id: "rel-mingtiao-tang", fromRef: "event:mingtiao", toRef: "person:zi-tang", kind: "battle" },
  { id: "rel-muye-fa", fromRef: "event:muye", toRef: "person:ji-fa", kind: "battle" },
  { id: "rel-chengpu-chonger", fromRef: "event:chengpu", toRef: "person:ji-chonger", kind: "battle" },
);


function eventSql(e) {
  const cols = [
    "id",
    "name",
    "kind",
    "time_mode",
    "precision",
    "date_note",
    "at_year",
    "at_month",
    "at_abs",
    "start_year",
    "start_month",
    "start_abs",
    "end_year",
    "end_month",
    "end_abs",
    "summary",
  ];
  const vals = [
    sqlStr(e.id),
    sqlStr(e.name),
    sqlStr(e.kind),
    sqlStr(e.timeMode),
    sqlStr(e.precision),
    sqlStr(e.dateNote ?? null),
    e.at?.year ?? "NULL",
    e.at?.month ?? "NULL",
    e.atAbs ?? "NULL",
    e.start?.year ?? "NULL",
    e.start?.month ?? "NULL",
    e.startAbs ?? "NULL",
    e.end?.year ?? "NULL",
    e.end?.month ?? "NULL",
    e.endAbs ?? "NULL",
    sqlStr(e.summary ?? null),
  ];
  return `INSERT INTO events (${cols.join(", ")})
VALUES (${vals.join(", ")})
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  kind = EXCLUDED.kind,
  time_mode = EXCLUDED.time_mode,
  precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note,
  at_year = EXCLUDED.at_year,
  at_month = EXCLUDED.at_month,
  at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;`;
}

function parseRef(raw) {
  const [type, ...rest] = raw.split(":");
  return { type, id: rest.join(":") };
}

function relationSql(r) {
  const from = parseRef(r.fromRef);
  const to = parseRef(r.toRef);
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)})
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;`;
}

const eventDynastySql = events.flatMap((e) =>
  e.dynastyIds.map(
    (dynastyId) =>
      `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(e.id)}, ${sqlStr(dynastyId)}) ON CONFLICT DO NOTHING;`,
  ),
);
const eventParticipantSql = events.flatMap((e) =>
  e.participantIds.map(
    (personId) =>
      `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(e.id)}, ${sqlStr(personId)}) ON CONFLICT DO NOTHING;`,
  ),
);

const preSql = [
  "DELETE FROM event_dynasties WHERE dynasty_id = 'zhou';",
  "DELETE FROM reigns WHERE dynasty_id = 'zhou';",
  "DELETE FROM dynasties WHERE id = 'zhou';",
  "DELETE FROM reigns WHERE id = 'reign-missing-zhou-west--840';",
  "DELETE FROM reigns WHERE id = 'reign-missing-shang--1570';",
  "DELETE FROM reigns WHERE dynasty_id = 'xia' AND person_id = 'system-missing-ruler';",
  "DELETE FROM relations WHERE id LIKE 'rel-si-%-succession';",
  "DELETE FROM relations WHERE id IN ('rel-zi-tang-zi-taijia-succession','rel-ji-yijiu-ji-yuchen-succession','rel-ji-yuchen-ji-lin-succession','rel-hou-yi-han-zhuo-succession');",
  "DELETE FROM event_participants WHERE event_id IN ('taikang-lost','houyi-dai-xia','hanzhuo-cuan-xia');",
  "DELETE FROM event_dynasties WHERE event_id IN ('houyi-dai-xia','hanzhuo-cuan-xia');",
  "DELETE FROM events WHERE id IN ('houyi-dai-xia','hanzhuo-cuan-xia');",
].join("\n");

const sql = [
  "-- EraLens period import: xia-shang-zhou",
  "-- Window: -2070-01 .. -256-12",
  "-- Chronology: Xia-Shang-Zhou Chronology Project + Shiji Eastern Zhou kings",
  "BEGIN;",
  "",
  preSql,
  "",
  "-- persons",
  ...importPersons.map(personSql),
  "",
  "-- dynasties",
  ...dynasties.map(dynastySql),
  "",
  "-- reigns",
  ...importReigns.map((r) => reignSql(r, sqlStr, sqlJson, formatAppellationCsv)),
  "",
  "-- events",
  ...events.map(eventSql),
  "",
  "-- event_dynasties",
  ...eventDynastySql,
  "",
  "-- event_participants",
  ...eventParticipantSql,
  "",
  "-- relations",
  ...relations.map(relationSql),
  "",
  "COMMIT;",
  "",
].join("\n");

mkdirSync(__dirname, { recursive: true });
writeFileSync(path.join(__dirname, "import.sql"), sql);

const manifest = {
  slug: "xia-shang-zhou",
  title: "夏商周",
  window: { startYear: -2070, startMonth: 1, endYear: -256, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-19",
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "夏商周断代工程", url: "https://zh.wikipedia.org/wiki/夏商周断代工程" },
    { label: "夏商周年表", url: "https://zh.wikipedia.org/wiki/夏商周年表" },
    { label: "周朝君主列表", url: "https://zh.wikipedia.org/wiki/周朝君主列表" },
    { label: "商朝君主列表", url: "https://zh.wikipedia.org/wiki/商朝君主列表" },
    { label: "今本竹书纪年·夏纪", url: "https://zh.wikisource.org/wiki/今本竹書紀年/夏紀" },
    { label: "夏朝", url: "https://zh.wikipedia.org/wiki/夏朝" },
    { label: "夏朝君主列表", url: "https://zh.wikipedia.org/wiki/夏朝君主列表" },
    { label: "史记·夏本纪", url: "https://zh.wikisource.org/wiki/史記/卷02" },
    { label: "史记·殷本纪", url: "https://zh.wikisource.org/wiki/史記/卷03" },
    { label: "伊尹", url: "https://zh.wikipedia.org/wiki/伊尹" },
    { label: "妇好", url: "https://zh.wikipedia.org/wiki/妇好" },
    { label: "傅说", url: "https://zh.wikipedia.org/wiki/傅说" },
    { label: "比干", url: "https://zh.wikipedia.org/wiki/比干" },
    { label: "百度百科·夏商周断代工程（西周年表）", url: "https://baike.baidu.com/item/夏商周断代工程/2331516" },
  ],
  notes: [
    "王朝起迄与晚商、西周列王年优先采用夏商周断代工程2000年《夏商周年表》；该工程方法与结论在学界仍有争议，作教材通行框架而非定论。",
    "夏代具体王年工程未给出。十七王起迄依今本《竹书纪年》在位年数自断代工程夏始前2070年顺推，全部标 interpolated（卡片起迄波浪线）。桀取《帝王世纪》五十二年（前1651–前1600）以接商汤。正统金色自启起（家天下），禹受禅不上金。",
    "后羿、寒浞为有穷代夏君主，写入夏行在位卡（相、少康之间串行，不填 claim_track）。claim_role=rival：不上正统金色、不串进十七王继承链。年取推算前1999–前1992、前1991–前1960。二人之间另串后羿→寒浞继承。",
    "夏王 persons.name 带姒姓；禹用私名文命、桀用履癸，禹/桀/太康等卡片称号写在 reigns.title。",
    "商王 persons.name 取维基/今本竹书纪年所载私名并加子姓（子履、子昭、子受等）；日名与史称写入 alt_names，卡片主行仍用日名/谥号。",
    "汤庙号取甲骨/文献高祖（高祖乙），不取太祖。盘庚庙号世祖依维基分类。帝辛私名受，周谥纣仍作 posthumous_name。",
    "汤与太甲之间旧「史料缺」改为外丙、仲壬（史记、孟子世系）。二人传统年数为外丙二或三年、仲壬四年，在汤迄年与太甲起年锚点之间按二王平分，标 interpolated。仲壬不见于周祭，与沃丁同属有争议君主，仍从史记收录。",
    "太甲至盘庚之间诸王（沃丁至阳甲）取《竹书纪年》在位年数顺序，首尾衔接既有太甲（迄前1548）、盘庚（起前1310）锚点；非断代工程实测，precision=year。",
    "盘庚至武丁之间补入小辛、小乙；小辛取竹书纪年三年，小乙年数依盘庚（迄前1280）与武丁（起前1250）锚点填满并标 interpolated。",
    "晚商祖庚、祖甲、廪辛、庚丁：夏商周年表合为前1191–前1148年，工程未给出各王起迄；年精度下按四王平分（各11年）并标 interpolated。武乙从前1147年起（死年归庚丁），文丁从前1112年起，与年表一致。",
    "东周列王取《史记》系统常见年表（与维基百科周朝君主列表一致）。敬王取前519–前477年。年精度顺序继位：死年归旧王、新王次年起算。携王与平王同从前770年起（英文维基 770–750 BCE），不从前771年幽王死年画起。哀王、思王同年先后相残，非并立；史记仅记「立三月」「立五月」，无历月，贞定王年精度迄前442年，前441年按此时长切开（1–3月 / 4–12月），不作历日。",
    "共和行政不建在位卡片（非王），仅作 span 事件；厉王出奔至宣王即位间西周行留白，不用史料缺占位。周公旦不另建称王记录。",
    "夏商周无年号，不写入 era_names。",
    "未单列春秋战国诸侯国为王朝行，以免超出「夏商周」王室主线。",
    "东周二王并立用 claim_track：主线平王→桓王…（正统金色）；xie/携王为并行对手（前770–前750），不镀金、不串进继承链。",
    "夏商非帝王人物：伊尹生年取维基传统前1649年，卒年按今本竹书沃丁八年对到本表沃丁窗为前1540年；妇好卒年取考古通行约前1200年；鲧、关龙逢、比干、妲己仅有与夏始/夏亡/牧野绑定的估列卒年，便于人物层落点。仲虺、皋陶、伯益、伊陟、巫咸、甘盘、傅说、箕子生卒不明不填，以免正月占位。微子启已是宋国始封君 song-weizi，不在此包重复建人。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);

console.log(
  `Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`,
);
console.log("Sample abs:", {
  xiaStart: absMonth(-2070, 1),
  shangStart: absMonth(-1600, 1),
  muye: absMonth(-1046, 1),
  zhouEastEnd: absMonth(-256, 12),
});
