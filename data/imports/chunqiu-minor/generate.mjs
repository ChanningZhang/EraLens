#!/usr/bin/env node
/**
 * Generate EraLens import SQL for minor Spring-Autumn states and Warring States remnants.
 * Only rulers with documented reign windows from Wikipedia / 左传 are included.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  person,
  reign,
  dr,
  ym,
  eventPoint,
  writeImportPackage,
  successionPairs,
} from "../lib/sqlHelpers.mjs";
import { missingReign, SYSTEM_MISSING_RULER_PERSON_ID } from "../lib/missingReigns.mjs";
import { applyFeudalClanMetadata } from "../lib/applyFeudalClanMetadata.mjs";
import { preQinRegnalCardName } from "../lib/preQinCardAppellation.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

function rulerPerson(id, name, dynastyLabel, title, bio, wikiTitle = name) {
  // For rulers whose given names are lost, store the visible placeholder as
  // the card appellation so the family name is not shown on the timeline.
  const posthumousNames = name === "姬？" ? ["？"] : [];
  return person(id, name, ["君主"], bio ?? `${title}，${dynastyLabel}君主。`, wikiTitle, null, null, [], posthumousNames);
}

// ── reign definitions (documented and interpolated ruler succession) ─────────

const xueReigns = [
  // 左传仅载昭公三十一年（前511）薛伯谷卒，在位始年不详
  dr("xue-chunqiu", "xue-r1", "薛献公", "献公", null, -511, -511),
  dr("xue-chunqiu", "xue-r2", "薛襄公", "襄公", null, -510, -498),
  dr("xue-chunqiu", "xue-r3", "薛公比", null, null, -497, -497),
  dr("xue-chunqiu", "xue-r4", "薛惠公", "惠公", null, -496, -485),
];

const tengAnchoredReigns = [
  dr("teng-chunqiu", "teng-r2", "滕文公", "文公", null, -599, -575),
  dr("teng-chunqiu", "teng-r3", "滕成公", "成公", null, -574, -539),
  dr("teng-chunqiu", "teng-r4", "滕悼公", "悼公", null, -538, -514),
  dr("teng-chunqiu", "teng-r5", "滕顷公", "顷公", null, -513, -491),
  dr("teng-chunqiu", "teng-r6", "滕隐公", "隐公", null, -490, -484),
];

// Named and numbered rulers whose identities/世次 are attested. Unrecorded
// regnal dates are interpolated between the documented chronological anchors.
const tengRulerRoster = [
  ["teng-r0", "绣", "滕错叔", "周武王所封的滕国始封君。"],
  ["teng-r1", "穀", "滕庄公", "《春秋》隐公七年载其卒于前716年；旧谱名穀（亦作毂）。"],
  ["teng-r7", "婴齐", "滕宣公", "前641年为宋所执；按《世本》及杜预《春秋释例》为滕国第十七世君。"],
  ["teng-r8", "郑", "滕孝侯", "滕宣公之后、滕昭公之前的滕君；在位年代失考。"],
  ["teng-r9", "元", "滕昭公", "前615年朝鲁，前600年卒；姓名另有毛伯等异说。"],
  ["teng-r10", "？", "滕子", "《左传·僖公二十二年》（前638年）记载的滕君；本名失考。"],
  ["teng-r11", "？", "滕子", "《左传·庄公十六年》（前678年）记载的滕君；本名失考。"],
  ["teng-r12", "？", "滕子", "《左传·桓公二年》（前710年）记载其朝鲁；本名及卒年失考。"],
  ["teng-r13", "？", "滕侯", "《左传·隐公十一年》所载滕侯，前715至前711年在位；本名失考。"],
  ["teng-r20", "？", "滕公", "西周成康之际滕国第二世君，见《吾鬲》及《滕侯簋》铭文；本名失考。"],
  ["teng-r21", "？", "滕侯", "西周康王时期滕国第三世君，见《滕侯方鼎》《滕侯簋》铭文；本名失考。"],
  ["teng-r22", "命仲", "命仲", "西周康昭之际滕国第四世君，见《滕虎簋》铭文。"],
  ["teng-r23", "？", "滕侯", "命仲之子、滕伯文之父，西周昭王时期；姓名失载。"],
  ["teng-r24", "文", "滕伯文", "西周昭穆之际滕国第六世君，见《礼记·檀弓上》。"],
  ["teng-r25", "？", "？", "滕国第7世君，世次据《世本》及杜预《春秋释例》推定，姓名失载。"],
  ["teng-r26", "？", "？", "滕国第8世君，世次据《世本》及杜预《春秋释例》推定，姓名失载。"],
  ["teng-r27", "？", "？", "滕国第9世君，世次据《世本》及杜预《春秋释例》推定，姓名失载。"],
  ["teng-r28", "？", "？", "滕国第10世君，世次据《世本》及杜预《春秋释例》推定，姓名失载。"],
  ["teng-r29", "？", "？", "滕国第11世君，世次据《世本》及杜预《春秋释例》推定，姓名失载。"],
  ["teng-r30", "？", "？", "滕国第12世君，世次据《世本》及杜预《春秋释例》推定，姓名失载。"],
  ["teng-r31", "？", "？", "《世本》称滕隐公后六世，张志鹏《滕国新考》据《古本竹书纪年》推为前414年初次亡于越时的末代滕君；本名失载。"],
  ["teng-r33", "？", "？", "滕隐公之后第1世，列入《世本》所谓隐公后六世，姓名失载。"],
  ["teng-r34", "？", "？", "滕隐公之后第2世，列入《世本》所谓隐公后六世，姓名失载。"],
  ["teng-r35", "？", "？", "滕隐公之后第3世，列入《世本》所谓隐公后六世，姓名失载。"],
  ["teng-r36", "？", "？", "滕隐公之后第4世，列入《世本》所谓隐公后六世，姓名失载。"],
  ["teng-r37", "？", "？", "滕隐公之后第5世，列入《世本》所谓隐公后六世，姓名失载。"],
  ["teng-r16", "麇", "滕考公", "《世本》所载考公麇；赵岐注《孟子》认为即复国后的滕定公，前324年卒。"],
  ["teng-r17", "弘", "滕元公", "《世本》所载元公弘；赵岐注《孟子》认为即滕文公，前323至前316年在位。"],
  ["teng-r18", "昃", "滕侯昃", "据滕侯昃戈、敦铭文，属战国中期；可能是复国后的滕君，具体年代有争议。"],
  ["teng-r19", "丘", "滕公丘", "后世谱系说列为亡国君，前315至前296年；复旦《滕国新考》认为末代君主失名，故不据此建在位卡。"],
];

function interpolateTengReigns(entries, startYear, endYear, approximateStart = false) {
  const totalYears = endYear - startYear + 1;
  const baseYears = Math.floor(totalYears / entries.length);
  const extraYears = totalYears % entries.length;
  let nextYear = startYear;
  return entries.map(([personId, title], index) => {
    const duration = baseYears + (index < extraYears ? 1 : 0);
    const rulerStart = nextYear;
    const rulerEnd = nextYear + duration - 1;
    nextYear = rulerEnd + 1;
    return reign({
      id: `reign-${personId}-teng-chunqiu`, dynastyId: "teng-chunqiu", personId, title,
      start: ym(rulerStart), end: ym(rulerEnd, 12),
      startDateConfidence: index === 0 ? (approximateStart ? "approximate" : null) : "interpolated",
      endDateConfidence: index === entries.length - 1 ? null : "interpolated",
    });
  });
}

const tengEarlyReigns = interpolateTengReigns([
  ["teng-r0", "滕错叔"], ["teng-r20", "？"], ["teng-r21", "？"],
  ["teng-r22", "命仲"], ["teng-r23", "？"], ["teng-r24", "滕伯文"],
  ["teng-r25", "？"], ["teng-r26", "？"], ["teng-r27", "？"],
  ["teng-r28", "？"], ["teng-r29", "？"], ["teng-r30", "？"],
  ["teng-r1", "滕侯"],
], -1045, -716, true);

const tengLostSixReigns = interpolateTengReigns(
  [...Array.from({ length: 5 }, (_, i) => [`teng-r${i + 33}`, "？"]), ["teng-r31", "？"]], -483, -414,
);

function interpolatedTengReign(personId, title, startYear, endYear, startDateConfidence = "interpolated", endDateConfidence = "interpolated") {
  return reign({
    id: `reign-${personId}-teng-chunqiu`, dynastyId: "teng-chunqiu", personId, title,
    start: ym(startYear), end: ym(endYear, 12), startDateConfidence, endDateConfidence,
  });
}

const tengMiddleReigns = [
  interpolatedTengReign("teng-r12", "？", -710, -695, null),
  interpolatedTengReign("teng-r11", "？", -694, -660),
  interpolatedTengReign("teng-r7", "滕宣公", -659, -640),
  interpolatedTengReign("teng-r10", "？", -639, -631),
  interpolatedTengReign("teng-r8", "孝侯", -630, -623),
  interpolatedTengReign("teng-r9", "滕昭公", -622, -600, "interpolated", null),
];

const tengReigns = [
  ...tengEarlyReigns,
  dr("teng-chunqiu", "teng-r13", "？", null, null, -715, -711),
  ...tengMiddleReigns,
  ...tengLostSixReigns,
  ...tengAnchoredReigns,
];

const qiStateReigns = [
  dr("qi-state-chunqiu", "qi-state-r1", "杞武公", "武公", null, -750, -704),
  dr("qi-state-chunqiu", "qi-state-r1b", "杞靖公", "靖公", null, -703, -681),
  dr("qi-state-chunqiu", "qi-state-gong", "杞共公", "共公", null, -680, -673),
  dr("qi-state-chunqiu", "qi-state-de", "杞德公", "德公", null, -672, -655),
  dr("qi-state-chunqiu", "qi-state-r1c", "杞成公", "成公", null, -654, -637),
  dr("qi-state-chunqiu", "qi-state-r2", "杞桓公", "桓公", null, -636, -567),
  dr("qi-state-chunqiu", "qi-state-xiao", "杞孝公", "孝公", null, -566, -550),
  dr("qi-state-chunqiu", "qi-state-r3", "杞文公", "文公", null, -549, -536),
  dr("qi-state-chunqiu", "qi-state-r4", "杞平公", "平公", null, -535, -518),
  dr("qi-state-chunqiu", "qi-state-dao", "杞悼公", "悼公", null, -517, -506),
  dr("qi-state-chunqiu", "qi-state-yin", "杞隐公", "隐公", null, -506, -506),
  dr("qi-state-chunqiu", "qi-state-xi", "杞僖公", "僖公", null, -505, -487),
  dr("qi-state-chunqiu", "qi-state-r5", "杞湣公", "湣公", null, -486, -471),
  dr("qi-state-chunqiu", "qi-state-ai", "杞哀公", "哀公", null, -470, -461),
  dr("qi-state-chunqiu", "qi-state-chu", "杞出公", "出公", null, -460, -449),
  dr("qi-state-chunqiu", "qi-state-r6", "杞简公", "简公", null, -448, -445),
];

const juReigns = [
  dr("ju-chunqiu", "ju-r1", "莒纪公", "纪公", null, -615, -609),
  dr("ju-chunqiu", "ju-r1b", "莒厉公", "厉公", null, -608, -580),
  dr("ju-chunqiu", "ju-r2", "莒渠丘公", "渠丘公", null, -579, -577),
  dr("ju-chunqiu", "ju-r3", "莒犂比公", "犂比公", null, -576, -542),
  dr("ju-chunqiu", "ju-r4", "莒子舆", null, null, -541, -541),
  dr("ju-chunqiu", "ju-r5", "莒著丘公", "著丘公", null, -540, -528),
  dr("ju-chunqiu", "ju-r6", "莒共公", "共公", null, -527, -519),
  dr("ju-chunqiu", "ju-r7", "莒郊公", "郊公", null, -518, -481),
];

const daiReigns = [dr("dai-warring", "zhao-jia-dai", "代王", null, null, -228, -222)];

const jiaodongReigns = [dr("jiaodong-warring", "tian-shi", "胶东王", null, null, -221, -206)];

// 战国末周王畿分裂：西周国（王城）与东周国（巩），非西周/东周王朝分期。
const zhouGuoWestReigns = [
  dr("zhou-guo-west", "zhou-guo-jie", "西周桓公", "桓公", null, -440, -415),
  dr("zhou-guo-west", "zhou-guo-zao", "西周威公", "威公", null, -414, -367),
  reign({
    id: "reign-zhou-guo-chao-zhou-guo-west",
    dynastyId: "zhou-guo-west",
    personId: "zhou-guo-chao",
    title: "西周惠公",
    posthumousName: "惠公",
    templeName: null,
    start: ym(-366),
    end: ym(-330, 12),
    endDateConfidence: "interpolated",
  }),
  reign({
    id: "reign-zhou-guo-wugong-zhou-guo-west",
    dynastyId: "zhou-guo-west",
    personId: "zhou-guo-wugong",
    title: "武公",
    posthumousName: "武公",
    templeName: null,
    start: ym(-329),
    end: ym(-293, 12),
    startDateConfidence: "interpolated",
    endDateConfidence: "interpolated",
  }),
  reign({
    id: "reign-zhou-guo-jiu-zhou-guo-west",
    dynastyId: "zhou-guo-west",
    personId: "zhou-guo-jiu",
    title: "西周文公",
    posthumousName: "文公",
    templeName: null,
    start: ym(-292),
    end: ym(-256, 12),
    startDateConfidence: "interpolated",
  }),
];

const zhouGuoEastReigns = [
  dr("zhou-guo-east", "zhou-guo-gen", "东周惠公", "惠公", null, -366, -360),
];

function dynastyReignSpan(reignList) {
  return {
    startYear: Math.min(...reignList.map((r) => r.start.year)),
    endYear: Math.max(...reignList.map((r) => r.end.year)),
  };
}

const xueSpan = dynastyReignSpan(xueReigns);

const reignGroups = [
  xueReigns,
  tengReigns,
  qiStateReigns,
  juReigns,
  daiReigns,
  jiaodongReigns,
  zhouGuoWestReigns,
  zhouGuoEastReigns,
];
const STATE_NAME = {
  "xue-chunqiu": "薛",
  "teng-chunqiu": "滕",
  "qi-state-chunqiu": "杞",
  "ju-chunqiu": "莒",
  "dai-warring": "代",
  "jiaodong-warring": "胶东",
  "zhou-guo-west": "西周",
  "zhou-guo-east": "东周",
};

const reigns = reignGroups.flat().map((r) => {
  if (r.posthumousName) return r;
  const body = preQinRegnalCardName(r.title, STATE_NAME[r.dynastyId]);
  if (!body || body === r.title || body.length < 2) return r;
  return { ...r, title: body };
});

const RULER_META = {
  "xue-r1": { name: "谷", wiki: "薛献公", bio: "《左传·昭公三十一年》载前511年卒；在位始年不详，不承接前代拉满。" },
  "xue-r2": { name: "定", wiki: "薛襄公" },
  "xue-r3": { name: "比", wiki: "薛公比" },
  "xue-r4": { name: "夷", wiki: "薛惠公" },
  "teng-r2": {
    name: "寿",
    wiki: "滕文公_(春秋)",
    bio: "滕文公（寿），前599–前575年在位。为世子时曾见孟子问政，即位后遣然友问丧礼于邹；史载最详的滕国君主，《孟子·滕文公》上下篇即以其事为纲。",
  },
  "teng-r3": {
    name: "原",
    wiki: "滕成公",
    bio: "滕成公（原），文公之子，前574–前539年在位。史书记载有限，继文公之后守国。",
  },
  "teng-r4": {
    name: "宁",
    wiki: "滕悼公",
    bio: "滕悼公（宁），成公之子，前538–前514年在位，在位二十五年。",
  },
  "teng-r5": {
    name: "结",
    wiki: "滕顷公",
    bio: "滕顷公（结），悼公之子，前513–前491年在位。小国向鲁朝贡，前491年卒。",
  },
  "teng-r6": {
    name: "虞毋",
    wiki: "滕隐公",
    bio: "滕隐公（虞毋），顷公之子，前490–前484年在位。为春秋可考末代滕君之一，其后世系失考至越灭滕复国。",
  },
  "qi-state-r1": {
    name: "武公",
    wiki: "杞武公",
    bio: "杞武公，夏后姒姓后裔，前750–前704年在位。本包可考杞君始于此，在位四十七年。",
  },
  "qi-state-r1b": {
    name: "靖公",
    wiki: "杞靖公",
    bio: "杞靖公，武公之后，前703–前681年在位。史书记载有限。",
  },
  "qi-state-gong": {
    name: "共公",
    wiki: "杞共公",
    bio: "杞共公，前680–前673年在位，在位八年。",
  },
  "qi-state-de": {
    name: "德公",
    wiki: "杞德公",
    bio: "杞德公，前672–前655年在位。夏礼遗存之小国，孔子曾欲至杞考夏礼而叹「杞不足徵」。",
  },
  "qi-state-r1c": {
    name: "成公",
    wiki: "杞成公",
    bio: "杞成公，前654–前637年在位。在位时将国都迁至缘陵（今山东昌乐东南）。",
  },
  "qi-state-r2": {
    name: "姑容",
    wiki: "杞桓公",
    bio: "杞桓公（姑容），前636–前567年在位，在位七十年，为杞国在位最久之君。屡遭强邻压迫迁国，《列子·天瑞》「杞人忧天」故事或与此忧患有关。",
  },
  "qi-state-xiao": {
    name: "匄",
    wiki: "杞孝公",
    bio: "杞孝公（匄），桓公之子，前566–前550年在位。",
  },
  "qi-state-r3": {
    name: "益姑",
    wiki: "杞文公",
    bio: "杞文公（益姑），前549–前536年在位。在位时迁都淳于（今山东安丘东北）。",
  },
  "qi-state-r4": {
    name: "郁",
    wiki: "杞平公",
    bio: "杞平公（郁），前535–前518年在位。",
  },
  "qi-state-dao": {
    name: "成",
    wiki: "杞悼公",
    bio: "杞悼公（成），前517–前506年在位。",
  },
  "qi-state-yin": { name: "乞", wiki: "杞隐公", bio: "悼公之子，在位七月即为弟僖公所弑；死年与悼公同在前506年。" },
  "qi-state-xi": {
    name: "遂",
    wiki: "杞僖公",
    bio: "杞僖公（遂），弑兄隐公自立，前505–前487年在位。",
  },
  "qi-state-r5": {
    name: "维",
    wiki: "杞湣公",
    bio: "杞湣公（维），前486–前471年在位。",
  },
  "qi-state-ai": {
    name: "阏路",
    wiki: "杞哀公",
    bio: "杞哀公（阏路），前470–前461年在位。",
  },
  "qi-state-chu": {
    name: "欶",
    wiki: "杞出公",
    bio: "杞出公（欶），前460–前449年在位。",
  },
  "qi-state-r6": {
    name: "春",
    wiki: "杞简公",
    bio: "杞简公（春），末代君主，前448–前445年在位。前445年为齐所灭，杞国亡。",
  },
  "ju-r1": {
    name: "庶其",
    wiki: "莒纪公",
    bio: "莒纪公（庶其），前615–前609年在位。偏爱少子季佗、慢待太子仆；仆杀己自立为厉公（《左传·文公十八年》）。",
  },
  "ju-r1b": {
    name: "季佗",
    wiki: "莒厉公",
    bio: "莒厉公（季佗），纪公之子，弑父自立，前608–前580年在位。",
  },
  "ju-r2": {
    name: "朱",
    wiki: "莒渠丘公",
    bio: "莒渠丘公（朱），前579–前577年在位。疑为厉公之子，史载甚略。",
  },
  "ju-r3": {
    name: "密州",
    wiki: "莒犂比公",
    bio: "莒犂比公（密州），前576–前542年在位。据《左传》称其「虐」、好争战，为莒国最活跃时期；死后莒渐衰。",
  },
  "ju-r4": {
    name: "舆",
    wiki: "莒子舆",
    bio: "莒子舆（展舆），犂比公子，前541年在位仅一年。犂比公暴虐时先被立为太子，终短暂即位。",
  },
  "ju-r5": {
    name: "去疾",
    wiki: "莒著丘公",
    bio: "莒著丘公（去疾），犂比公子，前540–前528年在位。著丘公卒后，子郊公狂与弟庚舆争立，引发内乱。",
  },
  "ju-r6": {
    name: "庚舆",
    wiki: "莒共公",
    bio: "莒共公（庚舆），犂比公子，好铸剑以人试刃，暴虐失国，前527–前519年在位。国人逐之，迎郊公狂复位。",
  },
  "ju-r7": {
    name: "狂",
    wiki: "莒郊公",
    bio: "莒郊公（狂），著丘公子，两度在位（前528年数月、前518–前481年）。柱厉叔知其不遇而去海上，后返国殉之；前481年卒。",
  },
  "zhao-jia-dai": { name: "嘉", wiki: "代王嘉" },
  "tian-shi": { name: "巿", wiki: "田巿" },
  "zhou-guo-jie": { name: "揭", wiki: "西周国", bio: "周考王之弟，封于王城，续周公之职，为西周国始祖。" },
  "zhou-guo-zao": { name: "灶", wiki: "西周国" },
  "zhou-guo-chao": {
    name: "朝",
    wiki: "西周国",
    bio: "西周威公太子；前367年威公卒后与弟根分国，朝据王城为西周惠公。",
  },
  "zhou-guo-wugong": {
    name: "武公",
    wiki: "西周武公",
    bio: "西周惠公长子，承惠公为西周国君，文公之父。《史记·周本纪》及《史记集解》引徐广注可证其世系，但未载本名；部分后世君主表称其名共之，出处未详。在位起讫年无可靠记载。",
  },
  "zhou-guo-jiu": {
    name: "咎",
    wiki: "西周国",
    bio: "西周末任君，前256年秦攻西周国，纳土降秦后卒。中间武公世系在位年失考。",
  },
  "zhou-guo-gen": {
    name: "班",
    wiki: "东周国",
    bio: "西周威公少子，《韩非子》作根，《纪年》作杰；赵韩扶持下据巩为东周惠公。",
  },
};

const curatedMissingReigns = [
  missingReign({
    dynastyId: "zhou-guo-east",
    startYear: -360,
    endYear: -249,
    id: "reign-missing-zhou-guo-east--360",
  }),
  missingReign({
    dynastyId: "xue-chunqiu",
    startYear: -485,
    endYear: -327,
    id: "reign-missing-xue-chunqiu--485",
  }),
  missingReign({
    dynastyId: "teng-chunqiu",
    startYear: -296,
    endYear: -296,
    id: "reign-missing-teng-chunqiu--296",
  }),
  missingReign({
    dynastyId: "ju-chunqiu",
    startYear: -1046,
    endYear: -616,
    id: "reign-missing-ju-chunqiu--1046",
  }),
  missingReign({
    dynastyId: "ju-chunqiu",
    startYear: -481,
    endYear: -431,
    id: "reign-missing-ju-chunqiu--481",
  }),
];

const DYNASTY_LABELS = {
  "xue-chunqiu": "薛国",
  "teng-chunqiu": "滕国",
  "qi-state-chunqiu": "杞国",
  "ju-chunqiu": "莒国",
  "dai-warring": "代国",
  "jiaodong-warring": "胶东",
  "zhou-guo-west": "西周国",
  "zhou-guo-east": "东周国",
};

const rosterMeta = new Map(tengRulerRoster.map(([id, name, title, bio]) => [id, { name, wiki: title, bio }]));
const persons = reigns.map((r) => {
  const meta = RULER_META[r.personId] ?? rosterMeta.get(r.personId);
  const state = DYNASTY_LABELS[r.dynastyId];
  return rulerPerson(r.personId, meta.name, state, r.title, meta.bio ?? null, meta.wiki);
});
for (const [id, name, title, bio] of tengRulerRoster) {
  if (!persons.some((p) => p.id === id)) persons.push(rulerPerson(id, name, "滕国", title, bio, title));
}

const dynasties = [
  {
    id: "xue-chunqiu",
    name: "薛",
    altNames: ["薛国"],
    scope: "cn",
    region: "east_asia",
    start: ym(xueSpan.startYear),
    end: ym(-327, 12),
    precision: "year",
    note: "任姓小国；可考君主自薛献公（前511年卒）起；前327年齐魏共灭薛。西周薛伯等早期君主在位年失考，不收录。",
  },
  {
    id: "teng-chunqiu",
    name: "滕",
    altNames: ["滕国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1045),
    end: ym(-296, 12),
    precision: "year",
    note: "姬姓诸侯国，周武王封错叔绣。前414年一度为越所灭，后复国，前296年为宋所灭。",
  },
  {
    id: "qi-state-chunqiu",
    name: "杞",
    altNames: ["杞国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-750),
    end: ym(-445, 12),
    precision: "year",
    note: "自杞武公起有通行在位年；东楼公等更早君主失考。前445年为齐所灭。",
  },
  {
    id: "ju-chunqiu",
    name: "莒",
    altNames: ["莒国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1046),
    end: ym(-431, 12),
    precision: "year",
    note: "周初（断代工程取前1046年）封兹舆期；至春秋早期世系与具体在位年长期失载，以史料缺占位至前616年，后接可考莒君；前481年后至前431年楚灭莒前再以史料缺占位。",
  },
  {
    id: "dai-warring",
    name: "代",
    altNames: ["代国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-228),
    end: ym(-222, 12),
    precision: "year",
    note: "前228年赵嘉于代郡自立代王；前222年秦将王贲灭代。",
  },
  {
    id: "jiaodong-warring",
    name: "胶东",
    altNames: ["胶东国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-221),
    end: ym(-206, 12),
    precision: "year",
    note: "秦灭齐后即墨一带齐宗室残余；田巿等据胶东，至楚汉之际并入分封格局。",
  },
  {
    id: "zhou-guo-west",
    name: "西周国",
    altNames: ["西周", "西周公国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-440),
    end: ym(-256, 12),
    precision: "year",
    note: "战国周王畿小国，都王城（洛阳）；前440年周考王封弟揭所立，非西周王朝（zhou-west）。前367年威公卒后与东周国分立；前256年秦灭。",
  },
  {
    id: "zhou-guo-east",
    name: "东周国",
    altNames: ["东周", "东周公国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-367),
    end: ym(-249, 12),
    precision: "year",
    note: "战国周王畿小国，都巩（巩义）；前367年由西周威公少子根所立，非东周王朝（zhou-east）。前249年秦庄襄王灭。",
  },
];

const events = [
  eventPoint({
    id: "zhou-guo-split",
    name: "东西周国分立",
    kind: "politics",
    dateNote: "周威公卒，前367年；赵成侯、韩懿侯分周为二",
    at: ym(-367),
    dynastyIds: ["zhou-guo-west", "zhou-guo-east", "zhou-east"],
    participantIds: ["zhou-guo-chao", "zhou-guo-gen"],
    summary:
      "西周威公卒后，太子朝据王城为西周惠公，少子根据巩为东周惠公，周王畿分裂为西周国与东周国。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "chunqiu", dynastyId: "xue-chunqiu" },
  { eventId: "chunqiu", dynastyId: "teng-chunqiu" },
  { eventId: "chunqiu", dynastyId: "qi-state-chunqiu" },
  { eventId: "chunqiu", dynastyId: "ju-chunqiu" },
  { eventId: "zhanguo", dynastyId: "dai-warring" },
  { eventId: "zhanguo", dynastyId: "jiaodong-warring" },
  { eventId: "zhanguo", dynastyId: "zhou-guo-west" },
  { eventId: "zhanguo", dynastyId: "zhou-guo-east" },
];

const supplementalEventParticipants = [
];

const relations = [];
for (const group of reignGroups) {
  for (const [fromId, toId] of successionPairs(group)) {
    relations.push({
      id: `rel-${fromId}-${toId}-succession`,
      fromRef: `person:${fromId}`,
      toRef: `person:${toId}`,
      kind: "succession",
    });
  }
}
relations.push(
  { id: "rel-dai-founded-zhao-jia", fromRef: "event:dai-founded", toRef: "person:zhao-jia-dai", kind: "politics" },
  { id: "rel-zhou-guo-split-chao", fromRef: "event:zhou-guo-split", toRef: "person:zhou-guo-chao", kind: "politics" },
  { id: "rel-zhou-guo-split-gen", fromRef: "event:zhou-guo-split", toRef: "person:zhou-guo-gen", kind: "politics" },
);

const cleanupSql = [
  "DELETE FROM reigns WHERE id = 'reign-missing-zhou-guo-west--365';",
  "DELETE FROM event_participants WHERE event_id = 'dai-founded';",
  "DELETE FROM event_dynasties WHERE event_id = 'dai-founded';",
  "DELETE FROM events WHERE id = 'dai-founded';",
  "DELETE FROM reigns WHERE id IN (",
  "  'reign-xue-r0-xue-chunqiu',",
  "  'reign-teng-r0-teng-chunqiu',",
  "  'reign-teng-r1-teng-chunqiu',",
  "  'reign-teng-r7-teng-chunqiu',",
  "  'reign-qi-state-r0-qi-state-chunqiu',",
  "  'reign-ju-r0-ju-chunqiu',",
  "  'reign-ju-r6-ju-chunqiu'",
  ");",
  "DELETE FROM persons WHERE id IN ('xue-r0','qi-state-r0','ju-r0','zhou-guo-sijun')",
  "  AND id NOT IN (SELECT person_id FROM reigns);",
  "DELETE FROM reigns WHERE id = 'reign-missing-teng-chunqiu--484';",
  "DELETE FROM reigns WHERE id = 'reign-teng-r32-teng-chunqiu';",
  "DELETE FROM persons WHERE id = 'teng-r32' AND id NOT IN (SELECT person_id FROM reigns);",
  "DELETE FROM reigns WHERE id = 'reign-zhou-guo-sijun-zhou-guo-east';",
].join("\n");

const manifest = {
  slug: "chunqiu-minor",
  title: "春秋小国与战国残余",
  window: { startYear: -750, startMonth: 1, endYear: -206, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-23",
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
    supplementalEventDynastyLinks: supplementalEventDynasties.length,
  },
  sources: [
    { label: "薛国", url: "https://zh.wikipedia.org/wiki/薛国" },
    { label: "滕国", url: "https://zh.wikipedia.org/wiki/滕国" },
    { label: "滕国新考", url: "https://www.fdgwz.org.cn/Web/Show/1428" },
    { label: "杞国", url: "https://zh.wikipedia.org/wiki/杞国" },
    { label: "莒国", url: "https://zh.wikipedia.org/wiki/莒国" },
    { label: "代国 (战国)", url: "https://zh.wikipedia.org/wiki/代国_(战国)" },
    { label: "西周国", url: "https://zh.wikipedia.org/wiki/西周国" },
    { label: "西周武公", url: "https://zh.wikipedia.org/wiki/西周武公" },
    { label: "史记·周本纪", url: "https://ctext.org/shiji/zhou-ben-ji" },
    { label: "东周国", url: "https://zh.wikipedia.org/wiki/东周国" },
    { label: "周朝诸侯国君主列表", url: "https://zh.wikipedia.org/wiki/周朝诸侯国君主列表" },
  ],
  notes: [
    "各国 ancestral_xing / clan_shi 取 feudalClanMetadata（薛任、滕姬、杞姒、莒己、代嬴赵、胶东妫田、西周国/东周国姬）。",
    "除滕国外，其他小国仍仅收录有明确在位年的君主；无世次或连续君主数量依据的年代空白不强行拉满。",
    "薛献公仅知前511年卒（左传），不填虚始年；齐庄公/卫武公/曹桓公/宋昭公长年在维基或史记有载，保留。",
    "莒国起始按《莒国》条目所载周武王元年/前1046年修正；《莒国》明载周初至鲁隐公元年史文空缺，始封兹舆期后多世失考，故从前1046至前616年用系统史料缺占位，再接现有可考君主记录。",
    "《莒国》条目所列前1046年与夏商周断代工程克商纪年相同；按年精度年桶记王朝起点。",
    "薛国自薛献公起；滕国起点前移至错叔绣始封的约前1045年；杞国自武公起。",
    "滕国连续无年表的世系按可考边界均分并标 interpolated：始封至前716年滕侯毂卒之间依《世本》及杜预《春秋释例》共13世；前484年隐公卒至前414年越灭滕依《世本》‘隐公后六世’分为六段。始封约年前1045标 approximate，前716、前414等有来源锚点的外侧边界保持确定。",
    "滕国君主本名失载时，persons.name 记为姬？，reigns.title 记为？；不以世次说明或爵称代替姓名。",
    "春秋中段按《春秋》《左传》记事年夹定顺序君主，再在相邻锚点间均分连续在位段，均标 interpolated。前414年越灭滕至复国期间为实际亡国期，泳道内不画君主在位卡；复国后考公麇/定公、元公弘/文公按赵岐注对应。滕侯昃年代有争议；滕公丘属于另一谱系说，不作为确证在位记录。前296年末代君主失名，史料缺占位限于该年。",
    "薛国泳道起年取薛献公（前511，左传仅载卒年），不提前至西周薛伯；惠公之后至灭国用史料缺占位。",
    "杞桓公在位70年、高句丽太祖王等长年在史料中有记载，保留。",
    "代王嘉 person id 为 zhao-jia-dai，与赵桓子 zhao-r2 区分。",
    "薛、滕、杞、莒、代用国号，不带「国」。西周国/东周国例外：史记、战国策原文称西周、东周（君称西周君、东周君）；后世为与王朝分期西周/东周消歧，维基百科与杨宽《战国史料编年辑证》等通行作西周国、东周国。",
    "东西周惠公泳道的年精度起年统一记为前366年；前367年为西周威公卒、周王畿分立之年，东周国的分立事件仍按前367年记。",
    "杞国列王按维基「杞国」君主表（在位年份已是逾年切分）；隐公仅前506年七月，与悼公死年同桶。滕悼公迄前514、顷公起前513，与维基在位年数一致。",
    "西周武公承西周惠公、为西周文公之父；《史记·周本纪》及《史记集解》引徐广注支持其世系，但均未载本名。《周朝诸侯国君主列表》列名共之，未标明该名所据原始文献；《西周国》君主表则列姓名不详，故数据库不把共之记作确证本名。惠公从有据的前366年起始，惠公、武公、文公具体继位年失考；以三位连续君主在前366年至前256年（含两端）共111年间各分37年作插值，区间分别为前366—前330、前329—前293、前292—前256，内侧边界均标 interpolated，前366与前256锚点保持确定。此均分为年代估算，不是史料所载在位年数。东周惠公之后至秦灭前仍为史料缺。",
  ],
};

const personDynastyId = new Map();
for (const r of reigns) personDynastyId.set(r.personId, r.dynastyId);
for (const [id] of tengRulerRoster) personDynastyId.set(id, "teng-chunqiu");
applyFeudalClanMetadata({ persons, dynasties, personDynastyId });

writeImportPackage(__dirname, {
  slug: "chunqiu-minor",
  window: { startYear: -750, startMonth: 1, endYear: -206, endMonth: 12 },
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  supplementalEventDynasties,
  supplementalEventParticipants,
  preSql: cleanupSql,
  missingReigns: curatedMissingReigns,
  manifest,
});
