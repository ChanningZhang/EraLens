#!/usr/bin/env node
/**
 * Generate EraLens import SQL + merge Xia-Shang-Zhou entities into data/seed.
 * AbsMonth must match packages/shared/src/time.ts
 */
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(__dirname, "../../..");
const seedDir = path.join(repoRoot, "data/seed");

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

const persons = [
  { id: "si-yu", name: "禹", roles: ["君主"], bio: "夏朝开国之君，史称大禹，传说治水有功。", links: wiki("禹") },
  { id: "si-qi", name: "启", roles: ["君主"], bio: "禹之子，传统记载变禅让为世袭，史称家天下。", links: wiki("启_(夏朝)") },
  { id: "si-taikang", name: "太康", roles: ["君主"], bio: "夏启之子，传说失国于后羿。", links: wiki("太康_(夏朝)") },
  { id: "hou-yi", name: "后羿", roles: ["君主", "军事家"], bio: "有穷氏首领，传说代夏政，史称后羿代夏。", links: wiki("后羿_(夏朝)") },
  { id: "si-shaokang", name: "少康", roles: ["君主"], bio: "夏相之子，传统记载中兴夏后氏。", links: wiki("少康") },
  { id: "si-jie", name: "桀", roles: ["君主"], bio: "夏朝末代之王履癸，鸣条之战为商汤所灭。", links: wiki("桀") },
  { id: "zi-tang", name: "汤", roles: ["君主"], bio: "商朝开国之君成汤，鸣条之战灭夏。", links: wiki("商汤") },
  { id: "yi-yin", name: "伊尹", roles: ["政治家"], bio: "商初重臣，辅汤灭夏，传说曾放太甲于桐宫。", links: wiki("伊尹") },
  { id: "zi-taijia", name: "太甲", roles: ["君主"], bio: "汤之孙，商朝早期重要君主，与伊尹传说相关。", links: wiki("太甲") },
  { id: "zi-woding", name: "沃丁", roles: ["君主"], bio: "太甲之子，伊尹卒后仍用伊尹诸子及咎单为政。", links: wiki("沃丁") },
  { id: "zi-taigeng", name: "太庚", roles: ["君主"], bio: "沃丁之弟，又称大庚。", links: wiki("太庚") },
  { id: "zi-xiaojia", name: "小甲", roles: ["君主"], bio: "太庚之子，商代早中期君主。", links: wiki("小甲") },
  { id: "zi-yongji", name: "雍己", roles: ["君主"], bio: "小甲之弟，传统记载此际诸侯不朝、殷道始衰。", links: wiki("雍己") },
  { id: "zi-taiwu", name: "太戊", roles: ["君主"], bio: "雍己之弟，传统称中宗，与伊陟、巫咸辅政而复兴。", links: wiki("太戊") },
  { id: "zi-zhongding", name: "仲丁", roles: ["君主"], bio: "太戊之子，迁于嚣，九世之乱始。", links: wiki("仲丁") },
  { id: "zi-wairen", name: "外壬", roles: ["君主"], bio: "仲丁之弟，九世之乱中继位。", links: wiki("外壬") },
  { id: "zi-hedanjia", name: "河亶甲", roles: ["君主"], bio: "外壬之弟，传统记载曾迁于相。", links: wiki("河亶甲") },
  { id: "zi-zuyi", name: "祖乙", roles: ["君主"], bio: "河亶甲之子，传统记载迁邢、殷道再兴。", links: wiki("祖乙") },
  { id: "zi-zuxin", name: "祖辛", roles: ["君主"], bio: "祖乙之子，商代早中期君主。", links: wiki("祖辛") },
  { id: "zi-wojia", name: "沃甲", roles: ["君主"], bio: "祖辛之弟，甲骨文或作羌甲。", links: wiki("沃甲") },
  { id: "zi-zuding", name: "祖丁", roles: ["君主"], bio: "沃甲之侄，祖辛之子，传统记载居庇。", links: wiki("祖丁") },
  { id: "zi-nangeng", name: "南庚", roles: ["君主"], bio: "祖丁之弟，传统记载自庇迁于奄。", links: wiki("南庚") },
  { id: "zi-yangjia", name: "阳甲", roles: ["君主"], bio: "祖丁之子，盘庚之兄，传统记载此际殷衰。", links: wiki("阳甲") },
  { id: "zi-pangeng", name: "盘庚", roles: ["君主"], bio: "商王，约前1300年迁都于殷，晚商以此为界。", links: wiki("盘庚") },
  { id: "zi-xiaoxin", name: "小辛", roles: ["君主"], bio: "盘庚之弟，迁殷后继位，传统记载殷道再衰。", links: wiki("小辛") },
  { id: "zi-xiaoyi", name: "小乙", roles: ["君主"], bio: "小辛之弟，武丁之父，传统记载仍居殷。", links: wiki("小乙_(商朝)") },
  { id: "zi-wuding", name: "武丁", roles: ["君主"], bio: "商高宗，甲骨文所见盛世之王，史称武丁中兴。", links: wiki("武丁") },
  { id: "fu-hao", name: "妇好", roles: ["王后", "军事家"], bio: "武丁配偶，甲骨与殷墟墓葬所见女将、祭司。", links: wiki("妇好") },
  { id: "zi-zugeng", name: "祖庚", roles: ["君主"], bio: "武丁之子，甲骨文作「且庚」，断代工程定其在位前1191–前1148年。", links: wiki("祖庚") },
  { id: "zi-zujia", name: "祖甲", roles: ["君主"], bio: "武丁之子、祖庚之弟，甲骨文作「且甲」，断代工程定其在位前1148–前1112年。", links: wiki("祖甲") },
  { id: "zi-wuyi", name: "武乙", roles: ["君主"], bio: "晚商之王，断代工程定其在位前1147–前1113年。", links: wiki("武乙") },
  { id: "zi-wending", name: "文丁", roles: ["君主"], bio: "晚商之王，《史记》或作太丁。", links: wiki("文丁") },
  { id: "zi-diyi", name: "帝乙", roles: ["君主"], bio: "晚商之王，帝辛之父。", links: wiki("帝乙") },
  { id: "zi-dixin", name: "帝辛", roles: ["君主"], bio: "商朝末代之王，世称纣，牧野之战亡于周。", links: wiki("帝辛") },
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
  { id: "ji-yijiu", name: "姬宜臼", roles: ["天子"], bio: "周平王，东迁洛邑，东周开始。", links: wiki("周平王") },
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
  { id: "da-ji", name: "妲己", roles: ["后妃"], bio: "传说中商末帝辛宠妃，牧野之战后商亡。", links: wiki("妲己") },
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
    colorToken: "ochre",
    note: "夏商周断代工程拟夏始约前2070年、夏商分界约前1600年；具体王年多不可考，学界对其历史性仍有争议。",
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
    colorToken: "mineral",
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
    colorToken: "indigo",
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
    colorToken: "moss",
    note: "平王东迁至秦灭周。王年取《史记》系统常见年表；东周王室衰微，列国争霸不另建王朝行。",
  },
];

function reign({
  id,
  dynastyId,
  personId,
  title,
  posthumousName,
  templeName,
  preferred,
  start,
  end,
  precision = "year",
}) {
  return {
    id,
    dynastyId,
    personId,
    title,
    posthumousName,
    templeName,
    preferredAppellation: preferred,
    eraNames: [],
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    precision,
  };
}

const xiaReigns = [
  reign({
    id: "reign-si-yu",
    dynastyId: "xia",
    personId: "si-yu",
    title: "夏禹",
    preferred: { kind: "regnal", name: "夏禹" },
    start: ym(-2070),
    end: ym(-2026, 12),
  }),
  reign({
    id: "reign-si-qi",
    dynastyId: "xia",
    personId: "si-qi",
    title: "夏启",
    preferred: { kind: "regnal", name: "夏启" },
    start: ym(-2025),
    end: ym(-2010, 12),
  }),
  reign({
    id: "reign-si-taikang",
    dynastyId: "xia",
    personId: "si-taikang",
    title: "夏太康",
    preferred: { kind: "regnal", name: "夏太康" },
    start: ym(-2009),
    end: ym(-1990, 12),
  }),
  reign({
    id: "reign-si-shaokang",
    dynastyId: "xia",
    personId: "si-shaokang",
    title: "夏少康",
    preferred: { kind: "regnal", name: "夏少康" },
    start: ym(-1910),
    end: ym(-1860, 12),
  }),
  reign({
    id: "reign-si-jie",
    dynastyId: "xia",
    personId: "si-jie",
    title: "夏桀",
    preferred: { kind: "regnal", name: "夏桀" },
    start: ym(-1650),
    end: ym(-1600, 12),
  }),
];

/** 商王称号如「商沃丁」「商王武丁」→ 谥号/日名「沃丁」「武丁」。 */
function shangPosthumousFromTitle(title) {
  const core = title.replace(/^商王?/, "");
  if (core === "帝辛") return "纣";
  return core;
}

/**
 * 卡片副标题：通常用「商武丁」；「帝+名」已是完整君王称谓，不再叠「商」前缀；
 * 帝辛通行作「商纣王」。
 */
function shangPreferredName(title) {
  const core = title.replace(/^商王?/, "");
  if (core === "帝辛") return "商纣王";
  if (/^帝/.test(core)) return core;
  return title.replace(/^商王/, "商");
}

function defaultShangPreferred(entry) {
  if (entry.preferred) return entry.preferred;
  return { kind: "posthumous", name: shangPreferredName(entry.title) };
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
    preferred:
      overrides.preferred ?? defaultShangPreferred({ title, ...overrides }),
    start: ym(startYear, overrides.startMonth ?? 1),
    end: ym(endYear, endMonth),
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
        preferred: defaultShangPreferred(entry),
        start: ym(startYear),
        end: ym(endYear, 12),
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
    { personId: "zi-xiaoyi", title: "商小乙", years: 3 },
  ],
  -1279,
  -1251,
);

const shangReigns = [
  shangReign("zi-tang", "商汤", -1600, -1571, {
    posthumousName: "武王",
    templeName: "太祖",
  }),
  shangReign("zi-taijia", "商太甲", -1560, -1548, { templeName: "太宗" }),
  ...shangEarlyReigns,
  shangReign("zi-pangeng", "商盘庚", -1310, -1280),
  ...shangLateReigns,
  shangReign("zi-wuding", "商王武丁", -1250, -1192, { templeName: "高宗" }),
  shangReign("zi-zugeng", "商王祖庚", -1191, -1148),
  shangReign("zi-zujia", "商王祖甲", -1148, -1112),
  shangReign("zi-wuyi", "商王武乙", -1147, -1113),
  shangReign("zi-wending", "商王文丁", -1112, -1102),
  shangReign("zi-diyi", "商王帝乙", -1101, -1076),
  shangReign("zi-dixin", "商王帝辛", -1075, -1046, { endMonth: 1 }),
];

for (const r of shangReigns) {
  const pref = r.preferredAppellation;
  if (pref?.kind !== "posthumous") {
    throw new Error(
      `Shang reign ${r.id} must use posthumous preferred appellation, got ${pref?.kind}`,
    );
  }
}

function zhouReign(
  personId,
  title,
  posthumous,
  startYear,
  endYear,
  dynastyId,
  startMonth = 1,
  endMonth = 12,
) {
  return reign({
    id: `reign-${personId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    preferred: { kind: "posthumous", name: title },
    start: ym(startYear, startMonth),
    end: ym(endYear, endMonth),
  });
}

const zhouWestReigns = [
  zhouReign("ji-fa", "周武王", "武王", -1046, -1043, "zhou-west"),
  zhouReign("ji-song", "周成王", "成王", -1042, -1021, "zhou-west"),
  zhouReign("ji-zhao", "周康王", "康王", -1020, -996, "zhou-west"),
  zhouReign("ji-xia", "周昭王", "昭王", -995, -977, "zhou-west"),
  zhouReign("ji-man", "周穆王", "穆王", -976, -922, "zhou-west"),
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
  zhouReign("ji-gui", "周景王", "景王", -544, -520, "zhou-east"),
  zhouReign("ji-meng", "周悼王", "悼王", -520, -520, "zhou-east"),
  zhouReign("ji-gai", "周敬王", "敬王", -519, -477, "zhou-east"),
  zhouReign("ji-ren", "周元王", "元王", -476, -469, "zhou-east"),
  zhouReign("ji-jie", "周贞定王", "贞定王", -468, -441, "zhou-east"),
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

const reigns = [...xiaReigns, ...shangReigns, ...zhouWestReigns, ...zhouEastReigns];

function eventPoint(partial) {
  const at = partial.at;
  return {
    kind: "other",
    timeMode: "point",
    precision: "year",
    dynastyIds: [],
    participantIds: [],
    ...partial,
    at,
    atAbs: at.abs,
  };
}
function eventRange(partial) {
  const start = partial.start;
  const end = partial.end;
  const at = partial.at;
  return {
    kind: "other",
    precision: "year",
    dynastyIds: [],
    participantIds: [],
    dateNote: undefined,
    ...partial,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    ...(at ? { at, atAbs: at.abs } : {}),
  };
}

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
    participantIds: ["si-yu"],
    summary: "传说禹疏导洪水，其后受禅，为夏后氏开国叙事的核心。",
  }),
  eventRange({
    id: "gan-battle",
    name: "甘之战",
    kind: "battle",
    timeMode: "circa",
    precision: "decade",
    dateNote: "《尚书·甘誓》载启伐有扈，绝对年代据夏初框架估列",
    start: ym(-2025),
    end: ym(-2010, 12),
    at: ym(-2020),
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
    dateNote: "后羿代夏、寒浞代羿均为传说，窗口置于夏初启之后",
    start: ym(-2009),
    end: ym(-1950, 12),
    at: ym(-1990),
    dynastyIds: ["xia"],
    participantIds: ["si-taikang", "hou-yi"],
    summary: "太康失位，有穷后羿代夏，夏后氏中衰。",
  }),
  eventRange({
    id: "shaokang-zhongxing",
    name: "少康中兴",
    kind: "politics",
    timeMode: "circa",
    precision: "decade",
    dateNote: "少康灭寒浞、恢复夏政，年数无实测，仅标相对位置",
    start: ym(-1920),
    end: ym(-1860, 12),
    at: ym(-1910),
    dynastyIds: ["xia"],
    participantIds: ["si-shaokang"],
    summary: "少康自有虞起兵，消灭寒浞，恢复夏后氏统治。",
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
    participantIds: ["si-jie", "zi-tang", "yi-yin"],
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
    participantIds: ["zi-wuding", "fu-hao"],
    summary: "武丁对外用兵、内修祭祀，晚商达到鼎盛，妇好亦主征伐。",
  }),
  eventPoint({
    id: "muye",
    name: "牧野之战",
    kind: "battle",
    precision: "month",
    dateNote: "断代工程取前1046年1月20日；月取正月，日不入库",
    at: ym(-1046, 1),
    dynastyIds: ["shang", "zhou-west"],
    participantIds: ["zi-dixin", "ji-fa", "lv-shang"],
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
    summary: "晋文公败楚于城濮，随后践土会盟，晋霸确立。",
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
  eventPoint({
    id: "qin-destroy-zhou",
    name: "秦灭周",
    kind: "politics",
    precision: "year",
    dateNote: "赧王五十九年，前256年，秦昭襄王灭西周君",
    at: ym(-256),
    dynastyIds: ["zhou-east"],
    participantIds: ["ji-yan"],
    summary: "秦攻取周王畿，赧王卒，东周灭亡。",
  }),
];

function successionPairs(list) {
  const pairs = [];
  for (let i = 0; i < list.length - 1; i++) {
    pairs.push([list[i].personId, list[i + 1].personId]);
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
  { id: "rel-mingtiao-tang", fromRef: "event:mingtiao", toRef: "person:zi-tang", kind: "battle" },
  { id: "rel-muye-fa", fromRef: "event:muye", toRef: "person:ji-fa", kind: "battle" },
  { id: "rel-chengpu-chonger", fromRef: "event:chengpu", toRef: "person:ji-chonger", kind: "battle" },
);

function personSql(p) {
  return `INSERT INTO persons (id, name, birth_year, birth_month, death_year, death_month, roles, bio, links)
VALUES (
  ${sqlStr(p.id)}, ${sqlStr(p.name)},
  ${p.birth?.year ?? "NULL"}, ${p.birth?.month ?? "NULL"},
  ${p.death?.year ?? "NULL"}, ${p.death?.month ?? "NULL"},
  ${sqlArray(p.roles)}, ${sqlStr(p.bio)}, ${sqlJson(p.links)}
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  birth_year = EXCLUDED.birth_year,
  birth_month = EXCLUDED.birth_month,
  death_year = EXCLUDED.death_year,
  death_month = EXCLUDED.death_month,
  roles = EXCLUDED.roles,
  bio = EXCLUDED.bio,
  links = EXCLUDED.links;`;
}

function dynastySql(d) {
  return `INSERT INTO dynasties (
  id, name, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, parent_id, note
) VALUES (
  ${sqlStr(d.id)}, ${sqlStr(d.name)}, ${sqlArray(d.altNames)}, ${sqlStr(d.scope)}, ${sqlStr(d.region)},
  ${d.start.year}, ${d.start.month}, ${d.end.year}, ${d.end.month},
  ${d.start.abs}, ${d.end.abs}, ${sqlStr(d.precision)}, ${sqlStr(d.colorToken)}, NULL,
  ${sqlStr(d.note)}
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
  note = EXCLUDED.note;`;
}

function reignSql(r) {
  return `INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  posthumous_name, temple_name, preferred_appellation,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision
) VALUES (
  ${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(r.title)},
  ${sqlStr(r.posthumousName ?? null)}, ${sqlStr(r.templeName ?? null)}, ${sqlJson(r.preferredAppellation)},
  ${r.start.year}, ${r.start.month}, ${r.end.year}, ${r.end.month},
  ${r.startAbs}, ${r.endAbs}, ${sqlStr(r.precision)}
)
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
  precision = EXCLUDED.precision;`;
}

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
  ...persons.map(personSql),
  "",
  "-- dynasties",
  ...dynasties.map(dynastySql),
  "",
  "-- reigns",
  ...reigns.map(reignSql),
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
  generatedAt: "2026-09-12",
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
    { label: "夏朝", url: "https://zh.wikipedia.org/wiki/夏朝" },
    { label: "百度百科·夏商周断代工程（西周年表）", url: "https://baike.baidu.com/item/夏商周断代工程/2331516" },
  ],
  notes: [
    "王朝起迄与晚商、西周列王年优先采用夏商周断代工程2000年《夏商周年表》；该工程方法与结论在学界仍有争议，作教材通行框架而非定论。",
    "夏代及商代前期具体王年工程未给出。禹、启、太康、少康、桀与汤、太甲、盘庚的在位年为传统积年锚定工程框架的估列，precision=year，事件用 circa，避免伪造成月日。",
    "太甲至盘庚之间诸王（沃丁至阳甲）取《竹书纪年》在位年数顺序，首尾衔接既有太甲（迄前1548）、盘庚（起前1310）锚点；非断代工程实测，precision=year。",
    "盘庚至武丁之间补入小辛、小乙；小辛取竹书纪年三年，小乙年数依盘庚（迄前1280）与武丁（起前1250）锚点填满，precision=year。",
    "晚商补入祖庚、祖甲（断代工程前1191–前1148、前1148–前1112）；工程表中武乙（前1147–前1113）与祖甲在位年部分重叠，系原表取舍，未另改武乙年。",
    "东周列王取《史记》系统常见年表（与维基百科周朝君主列表一致）。敬王取前519–前477年。哀王、思王同年先后相残，非并立；史记仅记「立三月」「立五月」，无历月，按此时长将前441年顺序切开（1–3月 / 4–12月），不作历日。",
    "共和行政不建在位卡片（非王），仅作 span 事件。周公旦不另建称王记录。",
    "夏商周无年号，不写入 era_names。",
    "未单列春秋战国诸侯国为王朝行，以免超出「夏商周」王室主线。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);

function toPersonJson(p) {
  const out = { id: p.id, name: p.name };
  if (p.birth) out.birth = { year: p.birth.year, month: p.birth.month };
  if (p.death) out.death = { year: p.death.year, month: p.death.month };
  out.roles = p.roles;
  if (p.bio) out.bio = p.bio;
  if (p.links) out.links = p.links;
  return out;
}
function toDynastyJson(d) {
  return {
    id: d.id,
    name: d.name,
    altNames: d.altNames,
    scope: d.scope,
    region: d.region,
    start: { year: d.start.year, month: d.start.month },
    end: { year: d.end.year, month: d.end.month },
    startAbs: d.start.abs,
    endAbs: d.end.abs,
    precision: d.precision,
    colorToken: d.colorToken,
    note: d.note,
  };
}
function toReignJson(r) {
  const out = {
    id: r.id,
    dynastyId: r.dynastyId,
    personId: r.personId,
    title: r.title,
    eraNames: [],
    start: { year: r.start.year, month: r.start.month },
    end: { year: r.end.year, month: r.end.month },
    startAbs: r.startAbs,
    endAbs: r.endAbs,
    precision: r.precision,
  };
  if (r.posthumousName) out.posthumousName = r.posthumousName;
  if (r.templeName) out.templeName = r.templeName;
  if (r.preferredAppellation) out.preferredAppellation = r.preferredAppellation;
  return out;
}
function toEventJson(e) {
  const out = {
    id: e.id,
    name: e.name,
    kind: e.kind,
    timeMode: e.timeMode,
    precision: e.precision,
    dynastyIds: e.dynastyIds,
    participantIds: e.participantIds,
  };
  if (e.dateNote) out.dateNote = e.dateNote;
  if (e.at) {
    out.at = { year: e.at.year, month: e.at.month };
    out.atAbs = e.atAbs;
  }
  if (e.start) {
    out.start = { year: e.start.year, month: e.start.month };
    out.startAbs = e.startAbs;
  }
  if (e.end) {
    out.end = { year: e.end.year, month: e.end.month };
    out.endAbs = e.endAbs;
  }
  if (e.summary) out.summary = e.summary;
  return out;
}

function mergeById(existing, incoming) {
  const incomingIds = new Set(incoming.map((x) => x.id));
  return [...incoming, ...existing.filter((x) => !incomingIds.has(x.id))];
}

const REMOVED_MERGED_ZHOU_ID = "zhou";

function prepareSeedDynasties(existing) {
  return mergeById(
    existing.filter((d) => d.id !== REMOVED_MERGED_ZHOU_ID),
    dynasties.map(toDynastyJson),
  );
}

function prepareSeedReigns(existing) {
  return mergeById(
    existing.filter((r) => r.dynastyId !== REMOVED_MERGED_ZHOU_ID),
    reigns.map(toReignJson),
  );
}

function prepareSeedEvents(existing) {
  const remapped = existing.map((e) => ({
    ...e,
    dynastyIds: (e.dynastyIds ?? []).filter((id) => id !== REMOVED_MERGED_ZHOU_ID),
  }));
  return mergeById(remapped, events.map(toEventJson));
}

const seedFiles = {
  "persons.json": mergeById(JSON.parse(readFileSync(path.join(seedDir, "persons.json"), "utf8")), persons.map(toPersonJson)),
  "dynasties.json": prepareSeedDynasties(JSON.parse(readFileSync(path.join(seedDir, "dynasties.json"), "utf8"))),
  "reigns.json": prepareSeedReigns(JSON.parse(readFileSync(path.join(seedDir, "reigns.json"), "utf8"))),
  "events.json": prepareSeedEvents(JSON.parse(readFileSync(path.join(seedDir, "events.json"), "utf8"))),
  "relations.json": mergeById(JSON.parse(readFileSync(path.join(seedDir, "relations.json"), "utf8")), relations),
};

for (const [filename, data] of Object.entries(seedFiles)) {
  writeFileSync(path.join(seedDir, filename), `${JSON.stringify(data, null, 2)}\n`);
}

console.log(
  `Wrote import.sql + manifest.json and merged seed JSON: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`,
);
console.log("Sample abs:", {
  xiaStart: absMonth(-2070, 1),
  shangStart: absMonth(-1600, 1),
  muye: absMonth(-1046, 1),
  zhouEastEnd: absMonth(-256, 12),
});
