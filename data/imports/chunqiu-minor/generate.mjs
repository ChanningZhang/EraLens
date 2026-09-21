#!/usr/bin/env node
/**
 * Generate EraLens import SQL for minor Spring-Autumn states and Warring States remnants.
 * Only rulers with documented reign windows from Wikipedia / 左传 are included.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  person,
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
  return person(id, name, ["君主"], bio ?? `${title}，${dynastyLabel}君主。`, wikiTitle);
}

// ── reign definitions (维基诸侯君主表 / 左传可考年) ─────────────────────────

const xueReigns = [
  // 左传仅载昭公三十一年（前511）薛伯谷卒，在位始年不详
  dr("xue-chunqiu", "xue-r1", "薛献公", "献公", null, -511, -511),
  dr("xue-chunqiu", "xue-r2", "薛襄公", "襄公", null, -510, -498),
  dr("xue-chunqiu", "xue-r3", "薛公比", null, null, -497, -497),
  dr("xue-chunqiu", "xue-r4", "薛惠公", "惠公", null, -496, -485),
];

const tengReigns = [
  dr("teng-chunqiu", "teng-r2", "滕文公", "文公", null, -599, -575),
  dr("teng-chunqiu", "teng-r3", "滕成公", "成公", null, -574, -539),
  dr("teng-chunqiu", "teng-r4", "滕悼公", "悼公", null, -538, -514),
  dr("teng-chunqiu", "teng-r5", "滕顷公", "顷公", null, -513, -491),
  dr("teng-chunqiu", "teng-r6", "滕隐公", "隐公", null, -490, -484),
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
  dr("zhou-guo-west", "zhou-guo-chao", "西周惠公", "惠公", null, -366, -366),
  dr("zhou-guo-west", "zhou-guo-jiu", "西周文公", "文公", null, -315, -256),
];

const zhouGuoEastReigns = [
  dr("zhou-guo-east", "zhou-guo-gen", "东周惠公", "惠公", null, -367, -360),
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
  "xue-r1": { name: "任谷", wiki: "薛献公", bio: "《左传·昭公三十一年》载前511年卒；在位始年不详，不承接前代拉满。" },
  "xue-r2": { name: "任定", wiki: "薛襄公" },
  "xue-r3": { name: "任比", wiki: "薛公比" },
  "xue-r4": { name: "任夷", wiki: "薛惠公" },
  "teng-r2": {
    name: "姬寿",
    wiki: "滕文公_(春秋)",
    bio: "滕文公（寿），前599–前575年在位。为世子时曾见孟子问政，即位后遣然友问丧礼于邹；史载最详的滕国君主，《孟子·滕文公》上下篇即以其事为纲。",
  },
  "teng-r3": {
    name: "姬原",
    wiki: "滕成公",
    bio: "滕成公（原），文公之子，前574–前539年在位。史书记载有限，继文公之后守国。",
  },
  "teng-r4": {
    name: "姬宁",
    wiki: "滕悼公",
    bio: "滕悼公（宁），成公之子，前538–前514年在位，在位二十五年。",
  },
  "teng-r5": {
    name: "姬结",
    wiki: "滕顷公",
    bio: "滕顷公（结），悼公之子，前513–前491年在位。小国向鲁朝贡，前491年卒。",
  },
  "teng-r6": {
    name: "姬虞毋",
    wiki: "滕隐公",
    bio: "滕隐公（虞毋），顷公之子，前490–前484年在位。为春秋可考末代滕君之一，其后世系失考至越灭滕复国。",
  },
  "qi-state-r1": {
    name: "姒武公",
    wiki: "杞武公",
    bio: "杞武公，夏后姒姓后裔，前750–前704年在位。本包可考杞君始于此，在位四十七年。",
  },
  "qi-state-r1b": {
    name: "姒靖公",
    wiki: "杞靖公",
    bio: "杞靖公，武公之后，前703–前681年在位。史书记载有限。",
  },
  "qi-state-gong": {
    name: "姒共公",
    wiki: "杞共公",
    bio: "杞共公，前680–前673年在位，在位八年。",
  },
  "qi-state-de": {
    name: "姒德公",
    wiki: "杞德公",
    bio: "杞德公，前672–前655年在位。夏礼遗存之小国，孔子曾欲至杞考夏礼而叹「杞不足徵」。",
  },
  "qi-state-r1c": {
    name: "姒成公",
    wiki: "杞成公",
    bio: "杞成公，前654–前637年在位。在位时将国都迁至缘陵（今山东昌乐东南）。",
  },
  "qi-state-r2": {
    name: "姒姑容",
    wiki: "杞桓公",
    bio: "杞桓公（姑容），前636–前567年在位，在位七十年，为杞国在位最久之君。屡遭强邻压迫迁国，《列子·天瑞》「杞人忧天」故事或与此忧患有关。",
  },
  "qi-state-xiao": {
    name: "姒匄",
    wiki: "杞孝公",
    bio: "杞孝公（匄），桓公之子，前566–前550年在位。",
  },
  "qi-state-r3": {
    name: "姒益姑",
    wiki: "杞文公",
    bio: "杞文公（益姑），前549–前536年在位。在位时迁都淳于（今山东安丘东北）。",
  },
  "qi-state-r4": {
    name: "姒郁",
    wiki: "杞平公",
    bio: "杞平公（郁），前535–前518年在位。",
  },
  "qi-state-dao": {
    name: "姒成",
    wiki: "杞悼公",
    bio: "杞悼公（成），前517–前506年在位。",
  },
  "qi-state-yin": { name: "姒乞", wiki: "杞隐公", bio: "悼公之子，在位七月即为弟僖公所弑；死年与悼公同在前506年。" },
  "qi-state-xi": {
    name: "姒遂",
    wiki: "杞僖公",
    bio: "杞僖公（遂），弑兄隐公自立，前505–前487年在位。",
  },
  "qi-state-r5": {
    name: "姒维",
    wiki: "杞湣公",
    bio: "杞湣公（维），前486–前471年在位。",
  },
  "qi-state-ai": {
    name: "姒阏路",
    wiki: "杞哀公",
    bio: "杞哀公（阏路），前470–前461年在位。",
  },
  "qi-state-chu": {
    name: "姒欶",
    wiki: "杞出公",
    bio: "杞出公（欶），前460–前449年在位。",
  },
  "qi-state-r6": {
    name: "姒春",
    wiki: "杞简公",
    bio: "杞简公（春），末代君主，前448–前445年在位。前445年为齐所灭，杞国亡。",
  },
  "ju-r1": {
    name: "己庶其",
    wiki: "莒纪公",
    bio: "莒纪公（庶其），前615–前609年在位。偏爱少子季佗、慢待太子仆；仆杀己自立为厉公（《左传·文公十八年》）。",
  },
  "ju-r1b": {
    name: "己季佗",
    wiki: "莒厉公",
    bio: "莒厉公（季佗），纪公之子，弑父自立，前608–前580年在位。",
  },
  "ju-r2": {
    name: "己朱",
    wiki: "莒渠丘公",
    bio: "莒渠丘公（朱），前579–前577年在位。疑为厉公之子，史载甚略。",
  },
  "ju-r3": {
    name: "己密州",
    wiki: "莒犂比公",
    bio: "莒犂比公（密州），前576–前542年在位。据《左传》称其「虐」、好争战，为莒国最活跃时期；死后莒渐衰。",
  },
  "ju-r4": {
    name: "己舆",
    wiki: "莒子舆",
    bio: "莒子舆（展舆），犂比公子，前541年在位仅一年。犂比公暴虐时先被立为太子，终短暂即位。",
  },
  "ju-r5": {
    name: "己去疾",
    wiki: "莒著丘公",
    bio: "莒著丘公（去疾），犂比公子，前540–前528年在位。著丘公卒后，子郊公狂与弟庚舆争立，引发内乱。",
  },
  "ju-r6": {
    name: "己庚舆",
    wiki: "莒共公",
    bio: "莒共公（庚舆），犂比公子，好铸剑以人试刃，暴虐失国，前527–前519年在位。国人逐之，迎郊公狂复位。",
  },
  "ju-r7": {
    name: "己狂",
    wiki: "莒郊公",
    bio: "莒郊公（狂），著丘公子，两度在位（前528年数月、前518–前481年）。柱厉叔知其不遇而去海上，后返国殉之；前481年卒。",
  },
  "zhao-jia-dai": { name: "赵嘉", wiki: "代王嘉" },
  "tian-shi": { name: "田巿", wiki: "田巿" },
  "zhou-guo-jie": { name: "姬揭", wiki: "西周国", bio: "周考王之弟，封于王城，续周公之职，为西周国始祖。" },
  "zhou-guo-zao": { name: "姬灶", wiki: "西周国" },
  "zhou-guo-chao": {
    name: "姬朝",
    wiki: "西周国",
    bio: "西周威公太子；前367年威公卒后与弟根分国，朝据王城为西周惠公。",
  },
  "zhou-guo-jiu": {
    name: "姬咎",
    wiki: "西周国",
    bio: "西周末任君，前256年秦攻西周国，纳土降秦后卒。中间武公世系在位年失考。",
  },
  "zhou-guo-gen": {
    name: "姬班",
    wiki: "东周国",
    bio: "西周威公少子，《韩非子》作根，《纪年》作杰；赵韩扶持下据巩为东周惠公。",
  },
};

const curatedMissingReigns = [
  missingReign({
    dynastyId: "zhou-guo-west",
    startYear: -365,
    endYear: -316,
    id: "reign-missing-zhou-guo-west--365",
  }),
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
    startYear: -484,
    endYear: -296,
    id: "reign-missing-teng-chunqiu--484",
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

const persons = reigns.map((r) => {
  const meta = RULER_META[r.personId];
  const state = DYNASTY_LABELS[r.dynastyId];
  return rulerPerson(r.personId, meta.name, state, r.title, meta.bio ?? null, meta.wiki);
});

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
    start: ym(-599),
    end: ym(-296, 12),
    precision: "year",
    note: "周武王封弟错叔绣于滕；本包仅收录春秋可考君主（文公至隐公）。前414年越灭滕后复国，世系失考；前296年宋康王终灭之。",
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
    start: ym(-615),
    end: ym(-431, 12),
    precision: "year",
    note: "兹舆期受封后多世失考；本包自春秋可见于《左传》的莒纪公起收录。前431年为楚所灭。",
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
    id: "dai-founded",
    name: "代王嘉自立",
    kind: "politics",
    dateNote: "赵幽缪王八年，前228年，秦占邯郸后赵嘉逃代自立",
    at: ym(-228),
    dynastyIds: ["dai-warring", "zhao-warring"],
    participantIds: ["zhao-jia-dai"],
    summary: "赵公子嘉逃至代郡，被大夫拥立为代王，延续赵国宗祀。",
  }),
  eventPoint({
    id: "qin-destroy-dai",
    name: "秦灭代",
    kind: "battle",
    dateNote: "秦王政二十五年，前222年",
    at: ym(-222),
    dynastyIds: ["dai-warring", "qin"],
    participantIds: ["zhao-jia-dai"],
    summary: "秦将王贲攻代，俘代王嘉，代国灭亡。",
  }),
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
  eventPoint({
    id: "qin-destroy-zhou-east",
    name: "秦灭东周国",
    kind: "politics",
    dateNote: "秦庄襄王元年，前249年",
    at: ym(-249),
    dynastyIds: ["zhou-guo-east", "qin"],
    participantIds: [SYSTEM_MISSING_RULER_PERSON_ID],
    summary: "秦庄襄王遣吕不韦攻东周国，杀东周君，东周国灭亡。",
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
  { eventId: "qin-destroy-han", dynastyId: "dai-warring" },
  { eventId: "qin-destroy-zhou", dynastyId: "zhou-guo-west" },
];

const supplementalEventParticipants = [
  { eventId: "qin-destroy-zhou", personId: "zhou-guo-jiu" },
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
  { id: "rel-qin-destroy-dai-zhao-jia", fromRef: "event:qin-destroy-dai", toRef: "person:zhao-jia-dai", kind: "battle" },
  { id: "rel-zhou-guo-split-chao", fromRef: "event:zhou-guo-split", toRef: "person:zhou-guo-chao", kind: "politics" },
  { id: "rel-zhou-guo-split-gen", fromRef: "event:zhou-guo-split", toRef: "person:zhou-guo-gen", kind: "politics" },
  {
    id: "rel-qin-destroy-zhou-east-missing-ruler",
    fromRef: "event:qin-destroy-zhou-east",
    toRef: `person:${SYSTEM_MISSING_RULER_PERSON_ID}`,
    kind: "politics",
  },
);

const cleanupSql = [
  "DELETE FROM reigns WHERE id IN (",
  "  'reign-xue-r0-xue-chunqiu',",
  "  'reign-teng-r0-teng-chunqiu',",
  "  'reign-teng-r1-teng-chunqiu',",
  "  'reign-teng-r7-teng-chunqiu',",
  "  'reign-qi-state-r0-qi-state-chunqiu',",
  "  'reign-ju-r0-ju-chunqiu',",
  "  'reign-ju-r6-ju-chunqiu'",
  ");",
  "DELETE FROM persons WHERE id IN ('xue-r0','teng-r0','teng-r1','teng-r7','qi-state-r0','ju-r0','zhou-guo-sijun')",
  "  AND id NOT IN (SELECT person_id FROM reigns);",
  "DELETE FROM reigns WHERE id = 'reign-zhou-guo-sijun-zhou-guo-east';",
].join("\n");

const manifest = {
  slug: "chunqiu-minor",
  title: "春秋小国与战国残余",
  window: { startYear: -750, startMonth: 1, endYear: -206, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-13",
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
    { label: "杞国", url: "https://zh.wikipedia.org/wiki/杞国" },
    { label: "莒国", url: "https://zh.wikipedia.org/wiki/莒国" },
    { label: "代国 (战国)", url: "https://zh.wikipedia.org/wiki/代国_(战国)" },
    { label: "西周国", url: "https://zh.wikipedia.org/wiki/西周国" },
    { label: "东周国", url: "https://zh.wikipedia.org/wiki/东周国" },
    { label: "周朝诸侯国君主列表", url: "https://zh.wikipedia.org/wiki/周朝诸侯国君主列表" },
  ],
  notes: [
    "各国 ancestral_xing / clan_shi 取 feudalClanMetadata（薛任、滕姬、杞姒、莒己、代嬴赵、胶东妫田、西周国/东周国姬）。",
    "仅收录维基/左传有明确在位年的君主；早期失考君主不强行拉满王朝跨度。",
    "薛献公仅知前511年卒（左传），不填虚始年；齐庄公/卫武公/曹桓公/宋昭公长年在维基或史记有载，保留。",
    "薛国自薛献公起；滕国自春秋滕文公起；杞国自武公起；莒国自纪公起。",
    "薛国泳道起年取薛献公（前511，左传仅载卒年），不提前至西周薛伯；惠公之后至灭国用史料缺占位。",
    "杞桓公在位70年、高句丽太祖王等长年在史料中有记载，保留。",
    "代王嘉 person id 为 zhao-jia-dai，与赵桓子 zhao-r2 区分。",
    "薛、滕、杞、莒、代用国号，不带「国」。西周国/东周国例外：史记、战国策原文称西周、东周（君称西周君、东周君）；后世为与王朝分期西周/东周消歧，维基百科与杨宽《战国史料编年辑证》等通行作西周国、东周国。",
    "年精度顺序继位：死年归旧王。西周惠公改从前366年起（威公卒年归威公），与东周惠公前367年并立不混为同一王室继位。",
    "杞国列王按维基「杞国」君主表（在位年份已是逾年切分）；隐公仅前506年七月，与悼公死年同桶。滕悼公迄前514、顷公起前513，与维基在位年数一致。",
    "西周武公、东周昭文君等中间世系在位年失考，不强行拉满；西周惠公与文公之间、东周惠公之后至秦灭前用系统史料缺占位。",
  ],
};

const personDynastyId = new Map();
for (const r of reigns) personDynastyId.set(r.personId, r.dynastyId);
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
