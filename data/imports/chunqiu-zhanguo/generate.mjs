#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Spring-Autumn & Warring States feudal states.
 * AbsMonth must match packages/shared/src/time.ts
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { rulersByDynasty, rulerStats } from "./rulers.mjs";
import { RULER_BIO_OVERRIDES, WIKI_TITLE_BY_PERSON_ID } from "./ruler-bios.mjs";
import { alignReignSeamConfidences } from "../lib/alignReignSeamConfidences.mjs";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import { applyFeudalClanMetadata } from "../lib/applyFeudalClanMetadata.mjs";
import { validateReignDateConfidenceSeams } from "../lib/validateReignSeams.mjs";
import { ORTHODOX_FROM_START } from "../lib/orthodoxDynasties.mjs";
import { finalizeImportReigns } from "../lib/missingReigns.mjs";
import { LEGACY_COLOR_TOKEN, formatAppellationCsv, mergeAppellationsIntoPersons, normalizeYearPrecisionAt, personSql } from "../lib/sqlHelpers.mjs";

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
function wiki(title) {
  return [{ label: "维基百科", url: `https://zh.wikipedia.org/wiki/${title}` }];
}

function reignIdFor(r) {
  if (r.reignId) return r.reignId;
  if (r.ordinal > 1) return `reign-${r.personId}-${r.dynastyId}-${r.ordinal}`;
  return `reign-${r.personId}-${r.dynastyId}`;
}

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
  startDateConfidence = null,
  endDateConfidence = null,
}) {
  return {
    id,
    dynastyId,
    personId,
    title,
    posthumousName,
    templeName,
    preferredAppellation: preferred,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    precision,
    startDateConfidence,
    endDateConfidence,
  };
}

function dynastyReign(dynastyId, personId, title, posthumous, startYear, endYear, preferred = null) {
  return reign({
    id: `reign-${personId}-${dynastyId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: null,
    preferred,
    start: ym(startYear),
    end: ym(endYear, 12),
  });
}

function person(id, name, roles, bio, wikiTitle, birth = null, death = null) {
  return { id, name, roles, bio, links: wiki(wikiTitle), birth, death };
}

function eventPoint({ id, name, kind, at, precision = "year", dateNote, dynastyIds = [], participantIds = [], summary }) {
  const resolvedAt = normalizeYearPrecisionAt(at, precision);
  return {
    id,
    name,
    kind,
    timeMode: "point",
    precision,
    dateNote,
    at: resolvedAt,
    atAbs: resolvedAt.abs,
    dynastyIds,
    participantIds,
    summary,
  };
}

// ── persons (rulers + key figures) ──

const EXTRA_PERSONS = [
  person("shang-yang", "商鞅", ["政治家"], "卫国人，秦孝公时主持变法，奠定秦统一基础。", "商鞅", ym(-390), ym(-338)),
  person("wu-qi", "吴起", ["军事家", "政治家"], "魏文侯时名将，后在楚主持变法。", "吴起", ym(-440), ym(-381)),
  person("sun-wu", "孙武", ["军事家"], "齐国军事家，著《孙子兵法》，传为吴王阖闾将。", "孙武"),
  person("helu", "阖闾", ["君主"], "吴王阖闾，任用伍子胥、孙武，破楚入郢。", "阖闾"),
  person("wu-zixu", "伍子胥", ["军事家", "政治家"], "楚人，助吴王阖闾破楚入郢，后被夫差赐死。", "伍子胥", ym(-559), ym(-484)),
  person("fan-li", "范蠡", ["政治家", "军事家"], "越国大夫，助勾践灭吴，后泛舟五湖。", "范蠡", ym(-536), ym(-448)),
  person("qu-yuan", "屈原", ["诗人", "政治家"], "楚国诗人，楚辞代表，投汨罗江而死。", "屈原", ym(-340), ym(-278)),
  person("lao-zi", "老子", ["思想家"], "道家学派创始人，传统认为著道德经。", "老子"),
  person("meng-ke", "孟子", ["思想家"], "战国时期儒家代表，主张仁政王道。", "孟子", ym(-372), ym(-289)),
  person("zhuang-zhou", "庄子", ["思想家"], "道家代表人物，庄子作者。", "庄子", ym(-369), ym(-286)),
  person("han-fei", "韩非", ["思想家"], "法家集大成者，秦王政重其书，后遭李斯害死。", "韩非", ym(-280), ym(-233)),
  person("sun-bin", "孙膑", ["军事家"], "孙子后裔，著孙膑兵法，桂陵、马陵大败魏军。", "孙膑", ym(-378), ym(-316)),
  person("bai-qi", "白起", ["军事家"], "秦国名将，长平之战坑赵卒，封武安君。", "白起", ym(-332), ym(-257)),
  person("wang-jian-qin", "王翦", ["军事家"], "秦国名将，灭楚、灭燕，助秦统一天下。", "王翦"),
  person("bian-que", "扁鹊", ["医学家"], "战国名医，望闻问切四诊法传说与其相关。", "扁鹊", ym(-407), ym(-310)),
];

function dynastyReignSpan(dynastyId) {
  const rs = rulersByDynasty[dynastyId] ?? [];
  return {
    startYear: Math.min(...rs.map((r) => r.startYear)),
    endYear: Math.max(...rs.map((r) => r.endYear)),
  };
}

const yueSpan = dynastyReignSpan("yue-chunqiu");
const zhongshanSpan = dynastyReignSpan("zhongshan");

const DYNASTY_LABELS = {
  "qi-chunqiu": "齐国",
  "jin-chunqiu": "晋国",
  "chu-chunqiu": "楚国",
  "yan-chunqiu": "燕国",
  "song-chunqiu": "宋国",
  "lu-chunqiu": "鲁国",
  "wei-weiguo": "卫国",
  "zheng-chunqiu": "郑国",
  "cao-chunqiu": "曹国",
  "wu-chunqiu": "吴国",
  "yue-chunqiu": "越国",
  zhongshan: "中山",
  "han-warring": "韩国",
  "zhao-warring": "赵国",
  "wei-warring": "魏国",
  qin: "秦国",
};

function rulerPerson(r) {
  const state = DYNASTY_LABELS[r.dynastyId] ?? r.dynastyId;
  const displayName =
    r.personName && !/^[0-9]+$/.test(r.personName) && !/^[0-9]+年$/.test(r.personName)
      ? r.personName
      : r.title;
  const wikiTitle = WIKI_TITLE_BY_PERSON_ID[r.personId] ?? r.title;
  return person(
    r.personId,
    displayName,
    ["君主"],
    `${r.title}，${state}君主。`,
    wikiTitle,
  );
}

const rulerPersons = Object.values(rulersByDynasty)
  .flat()
  .map(rulerPerson);
const personById = new Map();
for (const p of [...rulerPersons, ...EXTRA_PERSONS]) {
  personById.set(p.id, p);
}

for (const [id, patch] of Object.entries(RULER_BIO_OVERRIDES)) {
  const existing = personById.get(id);
  if (existing) personById.set(id, { ...existing, ...patch });
}

const PERSON_DETAIL_OVERRIDES = {
  "lv-shang": {
    altNames: ["姜子牙", "姜太公", "太公"],
    roles: ["君主", "军事家", "政治家"],
    bio: "姜太公（姜子牙），辅武王克商，封于齐。",
    links: wiki("姜子牙"),
    birth: ym(-1156),
    death: ym(-1017),
  },
  "song-weizi": {
    altNames: ["微子", "微子启"],
    bio: "微子启，帝乙长子、帝辛庶兄。数谏不听而亡奔，周封之于宋，为宋国始封君。",
    links: wiki("微子"),
  },
  "ji-shuyu": {
    bio: "唐叔虞（虞），周成王弟，初封于唐，后改国号晋，为晋国始封君。桐叶封弟典故即指其事。",
    links: wiki("唐叔虞"),
  },
  "ji-chonger": {
    bio: "晋文公（重耳），晋献公之子。流亡十九年后即位，城濮之战败楚，践土会盟，列为春秋五霸之一。",
    links: wiki("晋文公"),
  },
  "jiang-dai": {
    bio: "齐康公（姜贷），姜齐末代。前404年继宣公；前391年田和放逐于海上，姜齐在齐君位止。前379年卒，姜太公之祀绝。",
    links: wiki("齐康公"),
    death: ym(-379),
  },
  "tian-he": {
    bio: "田齐太公（田和）。前391年放逐齐康公自立，前386年周安王列为诸侯，史称田氏代齐。前384年卒。",
    links: wiki("田和"),
    death: ym(-384),
  },
  "song-r16": {
    bio: "宋闵公（子捷），宋庄公之子，前691–前682年在位。与鲁多次交战，乘丘之役鲁擒南宫万后释归；因猎博与万争执，前682年为南宫长万所弑于蒙泽。万立子游，诸公子杀子游而立弟御说为宋桓公。",
    links: wiki("宋闵公"),
    death: ym(-682),
  },
  "song-r28": {
    bio: "宋昭公（子特），前469–前404年在位。《史记·宋微子世家》另有前422年卒异说。",
    links: wiki("宋昭公特"),
  },
  "qi-r11": {
    bio: "齐前庄公（姜购），维基齐国君主表载在位64年（前794–前731），为齐国在位最久之君。",
  },
  "weiguo-r10": {
    bio: "卫武公（姬和），《史记·卫世家》载前812–前758年在位，共55年。",
    links: wiki("卫武公"),
  },
  "weiguo-r21": {
    bio: "卫成公（姬郑）。前634年即位，出奔后弟卫君瑕代立，僖公三十年复位，前600年卒。维基分两次在位（前634–前632、前632–前600）；年桶以卫君瑕占前632年，复位段逾年改元起前631年。",
    links: wiki("卫成公"),
  },
  "cao-r11": {
    bio: "曹桓公（姬终生），《史记·蔡世家》载前756–前702年在位，共55年。",
    links: wiki("曹桓公"),
  },
  "weiguo-r41": {
    bio: "卫成侯（姬遫），卫声公之子，前371–前343年在位。前346年卫国自贬为侯，臣服韩、赵、魏。",
    links: wiki("卫成侯"),
  },
  "weiguo-r42": {
    bio: "卫平侯（姬劲），姬姓子南氏，卫灵公少子公子郢之后；前342–前335年在位。",
    links: wiki("卫平侯"),
  },
  "weiguo-r43": {
    bio: "卫嗣君，本名失考，前334–前293年在位。",
    links: wiki("卫嗣君"),
  },
  "weiguo-r44": {
    bio: "卫怀君，本名失考，前292–前254年在位。",
    links: wiki("卫怀君"),
  },
  "weiguo-r45": {
    bio: "卫元君，姬姓子南氏，本名失考，前254–前230年在位。",
    links: wiki("卫元君"),
  },
  "song-r32": {
    bio: "宋剔成君，本名戴喜，字子罕。司城子罕篡位，约前355–前329年在位，无谥号。",
    links: wiki("剔成君"),
  },
  "yue-r6": {
    bio: "越王鹿郢，名与夷，又名鹿郢、于赐，勾践之子。",
    links: wiki("鹿郢"),
  },
  "yue-r8": {
    bio: "越王朱勾，名翁，一作州勾，不寿之子。",
    links: wiki("朱勾"),
  },
  "zhongshan-r0": {
    bio: "中山文公，维基年表载约前424–前415年在位，姓名失载。",
    links: wiki("中山文公"),
  },
  "zhongshan-r1": {
    bio: "中山武公，本名姬窟，文公之子，前414–约前406年在位。",
    links: wiki("中山武公"),
  },
  "zhongshan-r2": {
    bio: "中山桓公，复兴后约前380–约前350年在位，姓名失载。",
    links: wiki("中山桓公"),
  },
  "zhongshan-r3": {
    bio: "中山成公，约前349–前328年在位，姓名失载。",
    links: wiki("中山成公"),
  },
  "zhongshan-r4": {
    bio: "中山王厝（𰯼），前327–约前310年在位。",
    links: wiki("中山王厝"),
  },
  "zhongshan-r5": {
    bio: "中山王𧊒，约前309–前299年在位；前299年赵破灵寿后逃齐卒。",
    links: wiki("中山王𧊒"),
  },
  "zhongshan-r6": {
    bio: "中山王尚，前298–前296年在位，赵灭中山。",
    links: wiki("中山王尚"),
  },
};

for (const [id, patch] of Object.entries(PERSON_DETAIL_OVERRIDES)) {
  const existing = personById.get(id);
  if (existing) personById.set(id, { ...existing, ...patch });
}

const persons = [...personById.values()];

// ── dynasties (feudal states; id suffix avoids later homonymous dynasties) ──


const dynasties = [
  {
    id: "qi-chunqiu",
    name: "齐",
    altNames: ["姜齐", "田齐", "齐国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1046),
    end: ym(-221, 12),
    precision: "year",
    note: "周武王封姜太公于齐；前386年田氏代齐；前221年秦灭齐。",
  },
  {
    id: "jin-chunqiu",
    name: "晋",
    altNames: ["晋国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1042),
    end: ym(-349, 12),
    precision: "year",
    note: "周成王封叔虞于唐，改国号晋；前403年三家分晋；前376年公室被废、另立傀儡君，前349年静公被杀而国亡。",
  },
  {
    id: "chu-chunqiu",
    name: "楚",
    altNames: ["荆楚", "楚国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1042),
    end: ym(-223, 12),
    precision: "year",
    note: "周成王封熊绎于楚；春秋战国南方大国，前223年秦灭楚。",
  },
  {
    id: "yan-chunqiu",
    name: "燕",
    altNames: ["燕国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1044),
    end: ym(-222, 12),
    precision: "year",
    note: "周武王封召公奭于燕；战国七雄之一，前222年秦灭燕。",
  },
  {
    id: "song-chunqiu",
    name: "宋",
    altNames: ["宋国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1034),
    end: ym(-286, 12),
    precision: "year",
    note: "周成王封微子启于宋；前286年齐湣王灭宋。",
  },
  {
    id: "lu-chunqiu",
    name: "鲁",
    altNames: ["鲁国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1042),
    end: ym(-256, 12),
    precision: "year",
    note: "周武王封周公旦于鲁；孔子故乡，前256年楚灭鲁。",
  },
  {
    id: "wei-weiguo",
    name: "卫",
    altNames: ["卫国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1040),
    end: ym(-209, 12),
    precision: "year",
    note: "周成王封康叔封于卫；小国久存，秦二世时废。",
  },
  {
    id: "zheng-chunqiu",
    name: "郑",
    altNames: ["郑国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-806),
    end: ym(-375, 12),
    precision: "year",
    note: "周厉王少子友封于郑，后东迁新郑；前375年韩灭郑。",
  },
  {
    id: "cao-chunqiu",
    name: "曹",
    altNames: ["曹国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1046),
    end: ym(-487, 12),
    precision: "year",
    note: "周武王封弟振铎于曹；前487年宋灭曹。",
  },
  {
    id: "wu-chunqiu",
    name: "吴",
    altNames: ["吴国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-585),
    end: ym(-473, 12),
    precision: "year",
    note: "春秋东南强国，阖闾、夫差时盛；前473年越灭吴。",
  },
  {
    id: "yue-chunqiu",
    name: "越",
    altNames: ["越国"],
    scope: "cn",
    region: "east_asia",
    start: ym(yueSpan.startYear),
    end: ym(yueSpan.endYear, 12),
    precision: "year",
    note: "东南古国。传说夏少康庶子无余始封会稽，中间世系多缺载；有年表自允常。勾践灭吴后北进；前306年楚破越。",
  },
  {
    id: "zhongshan",
    name: "中山",
    altNames: ["中山国"],
    scope: "cn",
    region: "east_asia",
    start: ym(zhongshanSpan.startYear),
    end: ym(zhongshanSpan.endYear, 12),
    precision: "year",
    note: "鲜虞白狄所建。有年表自文公、武公；前406年后亡国，桓公复兴。前296年赵灭中山。",
  },
  {
    id: "han-warring",
    name: "韩",
    altNames: ["韩国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-403),
    end: ym(-230, 12),
    precision: "year",
    note: "三家分晋后韩氏立国，前403年周天子册命；前230年秦灭韩。",
  },
  {
    id: "zhao-warring",
    name: "赵",
    altNames: ["赵国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-403),
    end: ym(-222, 12),
    precision: "year",
    note: "三家分晋后赵氏立国；前222年秦灭赵。",
  },
  {
    id: "wei-warring",
    name: "魏",
    altNames: ["梁", "魏国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-403),
    end: ym(-225, 12),
    precision: "year",
    note: "三家分晋后魏氏立国，都大梁；前225年秦灭魏。与三国曹魏 wei 区分。",
  },
  // Upsert qin: extend feudal-state span back to秦襄公，统一帝国段仍由 qin-han 包维护
  {
    id: "qin",
    name: "秦",
    altNames: ["嬴秦", "秦国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-778),
    end: ym(-207, 12),
    precision: "year",
    note: "前778年秦襄公即位；前770年护周平王东迁列为诸侯；前221年嬴政称帝统一；前207年子婴降，秦亡。",
  },
];

// ── reigns (full succession per state; built from Wikipedia/Shiji chronology) ──

function dedupeReigns(reignList) {
  const seen = new Set();
  return reignList.filter((r) => {
    const key = `${r.dynastyId}|${r.startAbs}|${r.endAbs}|${r.personId}`;
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}

const reigns = alignReignSeamConfidences(
  applyDocumentedDatesToReigns(
    dedupeReigns(
      Object.values(rulersByDynasty)
        .flat()
        .map((r) =>
          reign({
            id: reignIdFor(r),
            dynastyId: r.dynastyId,
            personId: r.personId,
            title: r.title,
            posthumousName: r.posthumousName,
            templeName: null,
            preferred: r.preferredAppellation ?? null,
            start: ym(r.startYear),
            end: ym(r.endYear, 12),
            startDateConfidence: r.startDateConfidence ?? null,
            endDateConfidence: r.endDateConfidence ?? null,
          }),
        ),
    ),
  ),
);

const seamErrors = validateReignDateConfidenceSeams(reigns);
if (seamErrors.length) {
  console.error("Reign seam validation failed:");
  for (const error of seamErrors) console.error(" ", error);
  process.exit(1);
}

const finalized = finalizeImportReigns(
  "chunqiu-zhanguo",
  persons,
  reigns,
);
const merged = mergeAppellationsIntoPersons(finalized.persons, finalized.reigns);
const importPersons = merged.persons;
const importReigns = merged.reigns;
const missingReigns = finalized.missingReigns;

const personDynastyId = new Map();
for (const [dynastyId, rulers] of Object.entries(rulersByDynasty)) {
  for (const ruler of rulers) {
    personDynastyId.set(ruler.personId, dynastyId);
  }
}
applyFeudalClanMetadata({ persons: importPersons, dynasties, personDynastyId });

// ── events ──

const events = [
  eventPoint({
    id: "shangyang-reform",
    name: "商鞅变法",
    kind: "politics",
    dateNote: "秦孝公六年，前356年；史籍或作前359年，取前356年",
    at: ym(-356),
    dynastyIds: ["qin"],
    participantIds: ["ying-quliang", "shang-yang"],
    summary: "商鞅在秦国推行军功爵、什伍连坐、废井田等改革，奠定统一六国基础。",
  }),
  eventPoint({
    id: "wuqi-reform-wei",
    name: "吴起变法（魏）",
    kind: "politics",
    dateNote: "魏文侯时，约前403–前387年，取中点估列",
    at: ym(-395),
    dynastyIds: ["wei-warring"],
    participantIds: ["wei-wen", "wu-qi"],
    summary: "吴起在魏国主持军政改革，创建武卒，魏国成为战国初强国。",
  }),
  eventPoint({
    id: "wu-destroy-yue",
    name: "越灭吴",
    kind: "battle",
    dateNote: "越王勾践二十二年，前473年",
    at: ym(-473),
    dynastyIds: ["yue-chunqiu", "wu-chunqiu"],
    participantIds: ["gou-jian", "fu-chai"],
    summary: "勾践灭吴，夫差自杀，吴国灭亡。",
  }),
  eventPoint({
    id: "qin-destroy-han",
    name: "秦灭韩",
    kind: "battle",
    dateNote: "秦王政元年，前230年",
    at: ym(-230),
    dynastyIds: ["qin", "han-warring"],
    participantIds: ["ying-zheng"],
    summary: "秦将内史腾攻韩，俘韩王安，韩国灭亡，六国兼并由此开端。",
  }),
  eventPoint({
    id: "qin-destroy-chu",
    name: "秦灭楚",
    kind: "battle",
    dateNote: "秦王政二十六年，前223年",
    at: ym(-223),
    dynastyIds: ["qin", "chu-chunqiu"],
    participantIds: ["ying-zheng"],
    summary: "王翦、蒙武率军灭楚，俘楚王负刍。",
  }),
  eventPoint({
    id: "guiling-battle",
    name: "桂陵之战",
    kind: "battle",
    dateNote: "周威烈王十三年，前354年",
    at: ym(-354),
    dynastyIds: ["wei-warring", "qi-chunqiu"],
    participantIds: ["sun-bin"],
    summary: "孙膑围魏救赵，于桂陵大败魏军，开创围魏救赵战法。",
  }),
  eventPoint({
    id: "maling-battle",
    name: "马陵之战",
    kind: "battle",
    dateNote: "周显王三年，前341年",
    at: ym(-341),
    dynastyIds: ["wei-warring", "qi-chunqiu"],
    participantIds: ["sun-bin"],
    summary: "孙膑减灶诱敌，于马陵伏击魏军，庞涓战死，魏国元气大伤。",
  }),
  eventPoint({
    id: "changping-battle",
    name: "长平之战",
    kind: "battle",
    dateNote: "秦昭襄王四十七年，前260年",
    at: ym(-260),
    dynastyIds: ["qin", "zhao-warring"],
    participantIds: ["bai-qi"],
    summary: "白起于长平围歼赵军四十余万，赵国一蹶不振，秦统一大势已定。",
  }),
  eventPoint({
    id: "qin-destroy-wei",
    name: "秦灭魏",
    kind: "battle",
    dateNote: "秦王政二十二年，前225年",
    at: ym(-225),
    dynastyIds: ["qin", "wei-warring"],
    participantIds: ["ying-zheng"],
    summary: "王贲引黄河水灌大梁，魏王假投降，魏国灭亡。",
  }),
  eventPoint({
    id: "qin-destroy-zhao",
    name: "秦灭赵",
    kind: "battle",
    dateNote: "秦王政十九年，前228年",
    at: ym(-228),
    dynastyIds: ["qin", "zhao-warring"],
    participantIds: ["ying-zheng", "wang-jian-qin"],
    summary: "秦军破赵都邯郸，赵王迁被迫降秦，赵国灭亡。",
  }),
  eventPoint({
    id: "qin-destroy-yan",
    name: "秦灭燕",
    kind: "battle",
    dateNote: "秦王政二十五年，前222年",
    at: ym(-222),
    dynastyIds: ["qin", "yan-chunqiu"],
    participantIds: ["ying-zheng", "wang-jian-qin"],
    summary: "王翦率军攻燕，俘燕王喜，燕国灭亡。",
  }),
  eventPoint({
    id: "qin-destroy-qi",
    name: "秦灭齐",
    kind: "battle",
    dateNote: "秦王政二十六年，前221年",
    at: ym(-221),
    dynastyIds: ["qin", "qi-chunqiu"],
    participantIds: ["ying-zheng"],
    summary: "王贲率军灭齐，俘齐王建，六国悉灭，秦统一六国。",
  }),
];

// Link existing events (from xia-shang-zhou) to new state rows
const existingEventDynasties = [
  ["kuiqiu", "qi-chunqiu"],
  ["chengpu", "jin-chunqiu"],
  ["chengpu", "chu-chunqiu"],
  ["sanjia-fenjin", "jin-chunqiu"],
  ["sanjia-fenjin", "han-warring"],
  ["sanjia-fenjin", "zhao-warring"],
  ["sanjia-fenjin", "wei-warring"],
  ["chunqiu", "qi-chunqiu"],
  ["chunqiu", "jin-chunqiu"],
  ["chunqiu", "chu-chunqiu"],
  ["chunqiu", "song-chunqiu"],
  ["chunqiu", "lu-chunqiu"],
  ["chunqiu", "wei-weiguo"],
  ["chunqiu", "zheng-chunqiu"],
  ["chunqiu", "cao-chunqiu"],
  ["chunqiu", "wu-chunqiu"],
  ["chunqiu", "yue-chunqiu"],
  ["zhanguo", "qin"],
  ["zhanguo", "qi-chunqiu"],
  ["zhanguo", "chu-chunqiu"],
  ["zhanguo", "yan-chunqiu"],
  ["zhanguo", "han-warring"],
  ["zhanguo", "zhao-warring"],
  ["zhanguo", "wei-warring"],
  ["zhanguo", "zhongshan"],
  ["baijia-zhengming", "lu-chunqiu"],
  ["baijia-zhengming", "qi-chunqiu"],
  ["baijia-zhengming", "chu-chunqiu"],
  ["baijia-zhengming", "wei-warring"],
];

const relations = [
  { id: "rel-shangyang-reform-shang-yang", fromRef: "event:shangyang-reform", toRef: "person:shang-yang", kind: "politics" },
  { id: "rel-wu-destroy-yue-gou-jian", fromRef: "event:wu-destroy-yue", toRef: "person:gou-jian", kind: "battle" },
  { id: "rel-qin-destroy-han-ying-zheng", fromRef: "event:qin-destroy-han", toRef: "person:ying-zheng", kind: "battle" },
  { id: "rel-qin-destroy-chu-ying-zheng", fromRef: "event:qin-destroy-chu", toRef: "person:ying-zheng", kind: "battle" },
  { id: "rel-changping-bai-qi", fromRef: "event:changping-battle", toRef: "person:bai-qi", kind: "battle" },
  { id: "rel-guiling-sun-bin", fromRef: "event:guiling-battle", toRef: "person:sun-bin", kind: "battle" },
  { id: "rel-maling-sun-bin", fromRef: "event:maling-battle", toRef: "person:sun-bin", kind: "battle" },
];

// ── SQL generation ───────────────────────────────────────────────────────────


function dynastySql(d) {
  const orthodoxFromAbs =
    d.orthodoxFromAbs ??
    (d.id === "qin" ? absMonth(-221) : ORTHODOX_FROM_START.has(d.id) ? d.start.abs : null);
  return `INSERT INTO dynasties (
  id, name, ancestral_xing, clan_shi, alt_names, scope, region,
  start_year, start_month, end_year, end_month,
  start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
) VALUES (
  ${sqlStr(d.id)}, ${sqlStr(d.name)}, ${sqlStr(d.ancestralXing ?? null)}, ${sqlStr(d.clanShi ?? null)}, ${sqlArray(d.altNames)}, ${sqlStr(d.scope)}, ${sqlStr(d.region)},
  ${d.start.year}, ${d.start.month}, ${d.end.year}, ${d.end.month},
  ${d.start.abs}, ${d.end.abs}, ${sqlStr(d.precision)}, ${sqlStr(LEGACY_COLOR_TOKEN)}, ${orthodoxFromAbs ?? "NULL"}, NULL,
  ${sqlStr(d.note)}
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  ancestral_xing = EXCLUDED.ancestral_xing,
  clan_shi = EXCLUDED.clan_shi,
  alt_names = EXCLUDED.alt_names,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  orthodox_from_abs = EXCLUDED.orthodox_from_abs,
  note = EXCLUDED.note;`;
}

function reignSql(r) {
  return `INSERT INTO reigns (
  id, dynasty_id, person_id, title,
  era_names, preferred_appellation,
  start_year, start_month, start_day, end_year, end_month, end_day,
  start_abs, end_abs, precision, start_date_confidence, end_date_confidence
) VALUES (
  ${sqlStr(r.id)}, ${sqlStr(r.dynastyId)}, ${sqlStr(r.personId)}, ${sqlStr(r.title)},
  ${sqlStr(formatAppellationCsv(r.eraNames))}, ${sqlJson(r.preferredAppellation)},
  ${r.start.year}, ${r.start.month}, ${r.start.day ?? "NULL"}, ${r.end.year}, ${r.end.month}, ${r.end.day ?? "NULL"},
  ${r.startAbs}, ${r.endAbs}, ${sqlStr(r.precision)}, ${sqlStr(r.startDateConfidence ?? null)}, ${sqlStr(r.endDateConfidence ?? null)}
)
ON CONFLICT (id) DO UPDATE SET
  dynasty_id = EXCLUDED.dynasty_id,
  person_id = EXCLUDED.person_id,
  title = EXCLUDED.title,
  era_names = EXCLUDED.era_names,
  preferred_appellation = EXCLUDED.preferred_appellation,
  start_year = EXCLUDED.start_year,
  start_month = EXCLUDED.start_month,
  start_day = EXCLUDED.start_day,
  end_year = EXCLUDED.end_year,
  end_month = EXCLUDED.end_month,
  end_day = EXCLUDED.end_day,
  start_abs = EXCLUDED.start_abs,
  end_abs = EXCLUDED.end_abs,
  precision = EXCLUDED.precision,
  start_date_confidence = EXCLUDED.start_date_confidence,
  end_date_confidence = EXCLUDED.end_date_confidence;`;
}

function eventSql(e) {
  const cols = [
    "id", "name", "kind", "time_mode", "precision", "date_note",
    "at_year", "at_month", "at_abs",
    "start_year", "start_month", "start_abs",
    "end_year", "end_month", "end_abs",
    "summary",
  ];
  const vals = [
    sqlStr(e.id), sqlStr(e.name), sqlStr(e.kind), sqlStr(e.timeMode), sqlStr(e.precision), sqlStr(e.dateNote ?? null),
    e.at?.year ?? "NULL", e.at?.month ?? "NULL", e.atAbs ?? "NULL",
    e.start?.year ?? "NULL", e.start?.month ?? "NULL", e.startAbs ?? "NULL",
    e.end?.year ?? "NULL", e.end?.month ?? "NULL", e.endAbs ?? "NULL",
    sqlStr(e.summary ?? null),
  ];
  return `INSERT INTO events (${cols.join(", ")})
VALUES (${vals.join(", ")})
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision,
  date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs,
  start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_abs = EXCLUDED.start_abs,
  end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_abs = EXCLUDED.end_abs,
  summary = EXCLUDED.summary;`;
}

function parseRef(raw) {
  const [type, ...rest] = raw.split(":");
  return { type, id: rest.join(":") };
}

function relationSql(r) {
  const from = parseRef(r.fromRef);
  const to = parseRef(r.toRef);
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind, at_year, at_month, at_abs, precision, event_id)
VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)}, ${r.at?.year ?? "NULL"}, ${r.at?.month ?? "NULL"}, ${r.atAbs ?? "NULL"}, ${sqlStr(r.precision ?? null)}, ${sqlStr(r.eventId ?? null)})
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO UPDATE SET at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_abs = EXCLUDED.at_abs, precision = EXCLUDED.precision, event_id = EXCLUDED.event_id;`;
}

/** Reigns maintained by qin-han; must survive chunqiu-zhanguo stale cleanup on qin. */
const QIN_HAN_PROTECTED_REIGN_IDS = [
  "reign-ying-zheng",
  "reign-ying-huhai",
  "reign-ying-ziying",
];
const QIN_HAN_PROTECTED_PERSON_IDS = ["ying-huhai", "ying-ziying"];

function staleReignCleanupSql(reignList, dynastyList) {
  const dynastyIds = dynastyList.map((d) => d.id);
  const reignIds = [...new Set([...reignList.map((r) => r.id), ...QIN_HAN_PROTECTED_REIGN_IDS])];
  if (reignIds.length === 0 || dynastyIds.length === 0) return [];

  const dynastySql = dynastyIds.map(sqlStr).join(", ");
  const reignSql = reignIds.map(sqlStr).join(", ");

  return [
    "",
    "-- Remove stale reigns from managed dynasties (superseded ids from older imports)",
    `WITH stale AS (`,
    `  DELETE FROM reigns`,
    `  WHERE dynasty_id IN (${dynastySql}) AND id NOT IN (${reignSql})`,
    `  RETURNING person_id`,
    `)`,
    `DELETE FROM persons p`,
    `WHERE p.id IN (SELECT DISTINCT person_id FROM stale)`,
    `  AND NOT EXISTS (SELECT 1 FROM reigns r WHERE r.person_id = p.id)`,
    `  AND NOT EXISTS (SELECT 1 FROM event_participants ep WHERE ep.person_id = p.id)`,
    `  AND NOT EXISTS (`,
    `    SELECT 1 FROM relations rel`,
    `    WHERE (rel.from_type = 'person' AND rel.from_id = p.id)`,
    `       OR (rel.to_type = 'person' AND rel.to_id = p.id)`,
    `  );`,
  ];
}

function orphanPersonCleanupSql(personList) {
  const personIds = [...new Set([...personList.map((p) => p.id), ...QIN_HAN_PROTECTED_PERSON_IDS])];
  if (personIds.length === 0) return [];

  const personSql = personIds.map(sqlStr).join(", ");
  return [
    "",
    "-- Drop ruler persons left behind by earlier imports",
    `DELETE FROM persons p`,
    `WHERE p.id NOT IN (${personSql})`,
    `  AND NOT EXISTS (SELECT 1 FROM reigns r WHERE r.person_id = p.id)`,
    `  AND NOT EXISTS (SELECT 1 FROM event_participants ep WHERE ep.person_id = p.id)`,
    `  AND NOT EXISTS (`,
    `    SELECT 1 FROM relations rel`,
    `    WHERE (rel.from_type = 'person' AND rel.from_id = p.id)`,
    `       OR (rel.to_type = 'person' AND rel.to_id = p.id)`,
    `  );`,
  ];
}

const eventDynastySql = [
  ...events.flatMap((e) =>
    e.dynastyIds.map(
      (dynastyId) =>
        `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(e.id)}, ${sqlStr(dynastyId)}) ON CONFLICT DO NOTHING;`,
    ),
  ),
  ...existingEventDynasties.map(
    ([eventId, dynastyId]) =>
      `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(eventId)}, ${sqlStr(dynastyId)}) ON CONFLICT DO NOTHING;`,
  ),
];

const eventParticipantSql = events.flatMap((e) =>
  e.participantIds.map(
    (personId) =>
      `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(e.id)}, ${sqlStr(personId)}) ON CONFLICT DO NOTHING;`,
  ),
);

const sql = [
  "-- EraLens period import: chunqiu-zhanguo",
  "-- Window: -1046-01 .. -207-12 (Spring-Autumn & Warring States feudal states)",
  "-- Chronology: Shiji + Wikipedia state lists",
  "BEGIN;",
  "",
  "-- persons",
  ...importPersons.map(personSql),
  "",
  "-- dynasties",
  ...dynasties.map(dynastySql),
  "",
  "-- reigns",
  ...importReigns.map(reignSql),
  "",
  "-- events",
  ...events.map(eventSql),
  "",
  "-- event_dynasties (new + links to xia-shang-zhou events)",
  ...eventDynastySql,
  "",
  "-- event_participants",
  ...eventParticipantSql,
  "",
  "-- relations",
  ...relations.map(relationSql),
  ...staleReignCleanupSql(importReigns, dynasties),
  ...orphanPersonCleanupSql(importPersons),
  "",
  "COMMIT;",
  "",
].join("\n");

mkdirSync(__dirname, { recursive: true });
writeFileSync(path.join(__dirname, "import.sql"), sql);

const manifest = {
  slug: "chunqiu-zhanguo",
  title: "春秋战国诸侯国",
  window: { startYear: -1046, startMonth: 1, endYear: -207, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: rulerStats.generatedAt,
  counts: {
    persons: importPersons.length,
    dynasties: dynasties.length,
    reigns: importReigns.length,
    missingReigns: missingReigns.length,
    events: events.length,
    relations: relations.length,
    existingEventDynastyLinks: existingEventDynasties.length,
  },
  sources: [
    { label: "春秋时期", url: "https://zh.wikipedia.org/wiki/春秋时期" },
    { label: "战国时期", url: "https://zh.wikipedia.org/wiki/战国时期" },
    { label: "战国七雄", url: "https://zh.wikipedia.org/wiki/战国七雄" },
    { label: "齐国", url: "https://zh.wikipedia.org/wiki/齐国" },
    { label: "晋国", url: "https://zh.wikipedia.org/wiki/晋国" },
    { label: "楚国", url: "https://zh.wikipedia.org/wiki/楚国" },
    { label: "秦国", url: "https://zh.wikipedia.org/wiki/秦国" },
    { label: "三家分晋", url: "https://zh.wikipedia.org/wiki/三家分晋" },
    { label: "周朝诸侯国君主列表", url: "https://zh.wikipedia.org/zh-cn/周朝诸侯国君主列表" },
    { label: "齐国君主列表", url: "https://zh.wikipedia.org/zh-cn/齐国君主列表" },
    { label: "田和", url: "https://zh.wikipedia.org/wiki/田和" },
    { label: "田氏代齐", url: "https://zh.wikipedia.org/wiki/田氏代齐" },
    { label: "秦国君主列表", url: "https://zh.wikipedia.org/zh-cn/秦国君主列表" },
  ],
  notes: [
    "收录春秋主要列国与战国七雄（齐楚燕韩赵魏秦）及宋鲁卫郑曹吴越中山等。",
    "列国泳道名用国号（齐、楚、韩），与夏商周秦汉一致，不带「国」；「齐国」等写入 alt_names。",
    "id 后缀 -chunqiu / -warring / wei-weiguo 避免与曹魏 wei、孙吴 wu、北宋 song-north 等同名冲突。",
    "秦国 upsert 已有 qin 行，将始年延至前778年秦襄公即位，与 qin-han 统一帝国段衔接；清理脚本保留 qin-han 的秦二世、子婴 reign。",
    "各国国君世系取维基百科大陆简体（zh-cn）诸侯君主列表与《史记》年表；按表头读取称号/姓名/在位年份，不用本地繁简转换。",
    "年精度顺序继位按逾年改元切年（死年归旧王、新王次年起算，见 deathYearSuccession.mjs；用维基原始起年检测，避免孝文王占死后庄襄王不再后移）。维基在位年份常与死年重叠（如秦文公起前766年）；一年短祚、秦灵公/简公/献公未逾年改元、曲沃与翼并立不后移。魏惠王称王前后合并为一条在位（前369–前319）。",
    "西周早中期无在位年的国君在相邻锚点之间按世系均分时长（不设单条上限），不把整段失考年摊到开国之君身上；均分结果标 start/end_date_confidence=interpolated。",
    "齐太公不用维基齐国表的前1122年（旧克商年），与西周始年（前1046）对齐。",
    "田氏代齐为顺序接续，不是并立：宣公→康公→田和→侯剡。齐国表田和前404–前384年是田悼子卒后的领袖年；田和称君取条目前391年自立，前386年周安王列为诸侯。康公卒前379年，前391年被放逐后不在齐行续画，在位迄前392年。",
    "卫国人物 id 用 weiguo- 前缀，避免与战国魏 wei-r* 冲突；燕召公用 ji-shi，避免与宋恭帝 zhao-shi 冲突。",
    "同人多次即位拆多条 reign（reignId 后缀 -2），与唐/明一致；维基合并年表由 build-rulers.mjs 条目校正展开，不做运行时 split。",
    "年代诸说不一或仅存谥号者，在 manifest 与 date_note 中说明；月日未知标 precision: year。",
    "越国泳道不收夏少康庶子无余及无壬、无瞫：维基诸侯表在无余后「中有十世不明」、无瞫后「中有二十世不明」，无通行王年，不把远祖插值到春秋。有年表自允常；无年表的夫谭仅按允常前窗口插值。王朝起迄取在位首尾（夫谭至无彊前306），楚破越从维基诸侯表前306年，不取旧泳道前334。",
    "中山国泳道起迄取在位首尾（文公至王尚前296），不提前至桓公复兴传说起点前478；武公之后至桓公复兴间亡国留白。",
    "未收录薛、滕、杞、莒等小国；未收录战国末期的代、胶东等残余。",
    "葵丘之盟、城濮之战、三家分晋等事件沿用 xia-shang-zhou 已有 id，本包仅补 event_dynasties 关联。",
    "韩赵魏在位仅收录前403年册命立国之后；晋国卿大夫世系（赵简子等）不挂在三国行上。晋国止于前349年静公被杀。",
    `国君数据由 fetch-wiki-zh-cn.py + build-rulers.mjs 生成，共 ${rulerStats.reigns} 条在位记录。`,
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);

console.log(
  `Wrote import.sql + manifest.json: ${importPersons.length} persons, ${dynasties.length} dynasties, ${importReigns.length} reigns (${missingReigns.length} missing), ${events.length} events, ${relations.length} relations, ${existingEventDynasties.length} event_dynasty links`,
);
console.log("Sample abs:", {
  qiStart: absMonth(-1046, 1),
  sanjiaFenjin: absMonth(-403, 1),
  qinUnify: absMonth(-221, 1),
  qinEnd: absMonth(-207, 12),
});
