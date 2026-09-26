#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Sui, Tang, Five Dynasties & Ten Kingdoms, Song (581–1279).
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import { finalizeImportReigns, sqlDeleteSystemMissingReigns } from "../lib/missingReigns.mjs";
import { drDay, ymDay } from "../lib/reignDateHelpers.mjs";
import { reignSql } from "../lib/reignSql.mjs";
import { dynastySql, formatAppellationCsv, mergeAppellationsIntoPersons, normalizeYearPrecisionAt, personSql } from "../lib/sqlHelpers.mjs";

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

function person(id, name, roles, bio, wikiTitle, birth = null, death = null) {
  return { id, name, roles, bio, links: wiki(wikiTitle), birth, death };
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
  eraNames = [],
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
    eraNames,
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    precision,
    claimTrack,
    claimLabel,
    claimRole,
  };
}

function dynastyReign(dynastyId, personId, title, posthumous, temple, startYear, endYear, eraNames = [], claim = null) {
  return reign({
    id: dynastyId === "sui" || dynastyId === "tang" ? `reign-${personId}` : `reign-${personId}-${dynastyId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    start: ym(startYear),
    end: ym(endYear, 12),
    eraNames,
    claimTrack: claim?.track,
    claimLabel: claim?.label,
    claimRole: claim?.role ?? (claim?.track ? "rival" : undefined),
  });
}

function eras(reignId, list) {
  return list.map((e, i) => ({
    reignId,
    name: e.name,
    start: ym(e.sy, e.sm ?? 1),
    end: ym(e.ey, e.em ?? 12),
    sortOrder: i,
  }));
}

function tangSplitReign(id, personId, title, posthumous, temple, startYear, endYear, opts = {}) {
  const { startMonth = 1, endMonth = 12, precision = "year", eraList = [] } = opts;
  const eraNames = eraList.length ? eras(id, eraList) : [];
  return reign({
    id,
    dynastyId: "tang",
    personId,
    title,
    posthumousName: posthumous,
    templeName: temple,
    start: ym(startYear, startMonth),
    end: ym(endYear, endMonth),
    precision,
    eraNames,
  });
}

function dr(dynastyId, personId, title, posthumous, temple, sy, ey, eraList = []) {
  const reignId = `reign-${personId}-${dynastyId}`;
  return dynastyReign(
    dynastyId,
    personId,
    title,
    posthumous,
    temple,
    sy,
    ey,
    eraList.length ? eras(reignId, eraList) : [],
    null,
  );
}


// ── persons ────────────────────────────────────────────────────────────────
// yang-jian already in DB from nanbei-chao

const persons = [
  person("yang-guang", "杨广", ["皇帝"], "隋炀帝，开运河、三征高句丽；江都时期仍为名义皇帝，与长安杨侑并存；江都兵变被杀。", "隋炀帝"),
  person("yang-you", "杨侑", ["皇帝"], "隋恭帝，李渊拥立时炀帝尚在江都，尊炀帝为太上皇；后禅让建唐。", "杨侑"),
  person("yang-hao", "杨浩", ["皇帝"], "隋秦王，宇文化及弑炀帝后拥立，为江都隋室续统，旋被废杀。", "杨浩"),
  person("yang-tong", "杨侗", ["皇帝"], "隋越王，王世充等在东都拥立的傀儡皇帝，619年被杀，名义隋主终结。", "杨侗"),
  person("yuwen-huaji", "宇文化及", ["将领", "政治家"], "江都兵变主谋，杀隋炀帝后拥立杨浩。", "宇文化及"),
  person("dou-jiande", "窦建德", ["君主", "起义领袖"], "隋末河北割据者，先称长乐王，后建夏称王；援郑败于虎牢，被俘后在长安处死。", "窦建德", { year: 573 }, { year: 621 }),
  person("wang-shichong", "王世充", ["皇帝", "将领", "政治家"], "隋末据洛阳，拥立杨侗后杀之自立，建郑称帝；621年降唐，赴蜀途中被仇家独孤修德所杀。", "王世充", null, { year: 621 }),
  // 唐
  person("li-yuan", "李渊", ["皇帝"], "唐高祖，太原起兵，建唐定都长安。", "李渊"),
  person("li-shimin", "李世民", ["皇帝"], "唐太宗，玄武门之变后即位，开创贞观之治。", "唐太宗"),
  person("li-zhi", "李治", ["皇帝"], "唐高宗，永徽年间与武则天共治。", "唐高宗"),
  person("li-xian", "李显", ["皇帝"], "唐中宗，两度即位，韦后乱政在其朝。", "唐中宗"),
  person("li-dan", "李旦", ["皇帝"], "唐睿宗，两度即位，后禅位玄宗。", "唐睿宗"),
  person("wu-zetian", "武则天", ["皇帝"], "中国历史上唯一女皇帝，改国号周。", "武则天"),
  person("li-longji", "李隆基", ["皇帝"], "唐玄宗，开元盛世，安史之乱在其朝。", "唐玄宗"),
  person("li-heng", "李亨", ["皇帝"], "唐肃宗，马嵬驿后即位，平定安史之乱。", "唐肃宗"),
  person("li-yu-tang", "李豫", ["皇帝"], "唐代宗，平定安史余部。", "唐代宗"),
  person("li-kuo", "李适", ["皇帝"], "唐德宗，后期藩镇坐大。", "唐德宗"),
  person("li-song", "李诵", ["皇帝"], "唐顺宗，在位仅八个月。", "唐顺宗"),
  person("li-chun", "李纯", ["皇帝"], "唐宪宗，元和中兴。", "唐宪宗"),
  person("li-heng-mu", "李恒", ["皇帝"], "唐穆宗，宴游无度，藩镇复叛。", "唐穆宗"),
  person("li-zhan", "李湛", ["皇帝"], "唐敬宗，荒淫，为宦官所杀。", "唐敬宗"),
  person("li-ang", "李昂", ["皇帝"], "唐文宗，甘露之变在其朝。", "唐文宗"),
  person("li-yan-tang", "李炎", ["皇帝"], "唐武宗，会昌灭佛。", "唐武宗"),
  person("li-chen-tang", "李忱", ["皇帝"], "唐宣宗，大中之治，晚唐中兴。", "唐宣宗"),
  person("li-cui", "李漼", ["皇帝"], "唐懿宗，奢靡，唐由盛转衰。", "唐懿宗"),
  person("li-xuan-tang", "李儇", ["皇帝"], "唐僖宗，黄巢起义在其朝。", "唐僖宗"),
  person("li-ye-tang", "李晔", ["皇帝"], "唐昭宗，为朱温控制，后被杀。", "唐昭宗"),
  person("li-zhu-tang", "李柷", ["皇帝"], "唐哀帝，朱温篡唐，唐亡。", "唐哀帝"),
  // 五代
  person("zhu-wen", "朱温", ["皇帝"], "原名朱温，参加黄巢起义后降唐，凭宣武军起家并控制唐廷。907年代唐称帝，建立后梁、定都开封；在位期间以武力重组藩镇，晚年因继承问题被子朱友珪弑杀。", "朱温"),
  person("zhu-yougui", "朱友珪", ["皇帝"], "朱温之子，初封郢王。912年发动政变弑父即位，次年遭弟朱友贞与将领袁象先起兵推翻，自杀身亡，后梁政局持续动荡。", "朱友珪"),
  person("zhu-youzhen", "朱友贞", ["皇帝"], "朱温之子，朱友珪死后由开封群臣拥立，在位期间与后唐李存勖长期交战。923年后唐军攻入开封，后梁灭亡，朱友贞自尽。", "朱友贞"),
  person("li-cunxu", "李存勖", ["皇帝"], "李克用之子，继承河东晋王与沙陀军事集团。923年称帝建后唐，灭后梁并迁都洛阳；在位后期宠信伶人、用人失当，兵变中被杀，后唐随之进入内乱。", "李存勖"),
  person("li-siyuan", "李嗣源", ["皇帝"], "李克用养子，沙陀将领，曾助李存勖建立后唐。926年兵变后入洛阳即位，在位时裁减宫廷开支、整顿吏治，史称明宗之治；死后诸子争位，后唐迅速失序。", "李嗣源"),
  person("li-conghou", "李从厚", ["皇帝"], "李嗣源第三子，明宗死后继位。即位后试图调动李从珂、石敬瑭等藩镇将领，引发政变；在位数月即被李从珂废黜，后被杀。", "李从厚"),
  person("li-congke", "李从珂", ["皇帝"], "李嗣源养子，原镇凤翔。934年起兵推翻闵帝李从厚后即位，面对石敬瑭在河东反叛并向契丹求援；契丹与晋军攻入洛阳时自焚，后唐灭亡。", "李从珂"),
  person("shi-jingtang", "石敬瑭", ["皇帝"], "李嗣源女婿，后唐河东节度使。936年借契丹兵推翻李从珂，建立后晋并以契丹为父国；割让燕云十六州、岁输财物，后晋因此长期受制于契丹。", "石敬瑭"),
  person("shi-chonggui", "石重贵", ["皇帝"], "石敬瑭侄，石敬瑭死后由宰相冯道等拥立。即位初向契丹称孙，随后拒绝臣服并与之交战；946至947年契丹南下攻陷开封，后晋亡，石重贵被迁往北方。", "石重贵"),
  person("liu-zhiyuan", "刘知远", ["皇帝"], "沙陀将领，长期任后晋河东节度使。契丹灭后晋、撤军北返后，他于947年在太原称帝，建立后汉并进据开封；即位不久病逝，由子刘承祐继位。", "刘知远"),
  person("liu-chengyou", "刘承祐", ["皇帝"], "刘知远之子，947年继位时年幼，由权臣与武将辅政。954年疑忌枢密使郭威而诛其家，郭威起兵攻入开封；刘承祐在逃亡中被杀，后汉亡。", "刘承祐"),
  person("guo-wei", "郭威", ["皇帝"], "后汉枢密使，出身军伍，因刘承祐诛其家而起兵。950年入开封后受拥立，建立后周；在位时整顿军政、减轻赋役并抑制藩镇，死后由养子柴荣继位。", "郭威"),
  person("chai-rong", "柴荣", ["皇帝"], "郭威养子，继承后周帝位，在位954—959年。改革军政、整顿财政并多次亲征，先后取秦凤、淮南等地，推动统一进程；北伐契丹途中病重返京，留下年幼之子继位。", "周世宗"),
  person("chai-zongxun", "柴宗训", ["皇帝"], "柴荣之子，959年继位时年幼，由符太后与大臣辅政。960年赵匡胤发动陈桥兵变，柴宗训禅位，后周亡；宋朝建立后被封郑王。", "柴宗训"),
  // 十国
  person("yang-xingmi", "杨行密", ["君主"], "庐州人，唐末起兵后任淮南节度使，与孙儒等军阀争夺江淮。控制扬州及淮南后受封吴王，为杨吴奠基；其子杨渥继位，政权由权臣徐温掌握。", "杨行密"),
  person("yang-wo", "杨渥", ["君主"], "杨行密长子，905年继承淮南节度使之位。徐温、张颢等权臣相争，杨渥试图亲政而遭废杀；杨隆演继位，杨吴实权转入徐氏。", "杨渥"),
  person("yang-longyan", "杨隆演", ["君主"], "杨行密次子，杨渥死后由徐温拥立。徐温掌握军政，杨隆演先受封吴王，919年建立吴国；其在位期间为权臣控制，死后杨溥继位。", "杨隆演"),
  person("yang-pu", "杨溥", ["皇帝"], "杨行密之子、杨隆演之弟，徐温死后由徐知诰继续掌权。927年称帝，国号吴；937年徐知诰迫其禅位，吴亡，杨溥被迁居润州并于次年去世。", "杨溥"),
  person("li-bian", "李昪", ["皇帝"], "本名徐知诰，徐温养子，长期掌握杨吴军政。937年迫吴睿帝杨溥禅位，先建齐、后改国号唐，史称南唐；在位时休兵息民、发展江淮经济，传位于子李璟。", "李昪"),
  person("li-jing-nantang", "李璟", ["皇帝"], "李昪长子，943年继位。南唐国力一度强盛，随后发动兼并闽、楚之战，却遭后周进攻并于958年割江北地、去帝号称国主；死后李煜继位。", "李璟"),
  person("li-yu-nantang", "李煜", ["君主"], "李璟第六子，961年继位，承受后周以来的割地与称臣局面。向宋称臣以保境，975年宋军攻陷金陵后出降，南唐亡；被俘至汴京，后以词作著称。", "李煜"),
  person("qian-liu", "钱镠", ["君主"], "杭州临安人，唐末以镇压浙西地方势力起家，受任镇海、镇东节度使。907年受封吴越王，控制两浙并以杭州为中心；在位时兴修海塘、水利，奠定吴越长期偏安基础。", "钱镠"),
  person("qian-yuangui", "钱元瓘", ["君主"], "钱镠第七子，继承吴越王位，在位期间维持对后唐、后晋的臣属关系并经营两浙。934年杭州火灾后重建城郭，941年去世，子钱弘佐继位。", "钱元瓘"),
  person("qian-hongzuo", "钱弘佐", ["君主"], "钱元瓘之子，年少继位，由元老水丘昭券等辅政。吴越继续向中原王朝称臣，钱弘佐在位六年后去世，弟钱弘倧继位。", "钱弘佐"),
  person("qian-hongcong", "钱弘倧", ["君主"], "钱元瓘之子，钱弘佐死后继位。权臣胡进思发动政变将其废黜并幽禁，钱弘俶随后即位，吴越王位转入另一支。", "钱弘倧"),
  person("qian-chu", "钱俶", ["君主"], "钱元瓘第九子，原名钱弘俶，947年后实际执掌吴越，后改名钱俶。向后周、北宋持续称臣，978年纳土归宋，保全两浙百姓与宗族。", "钱俶"),
  person("wang-shenzhi", "王审知", ["君主"], "光州固始人，与兄王潮随军入闽并控制福建，王潮死后继任。受封闽王，定都福州，在位时奉中原正朔、轻徭薄赋并发展海上贸易，为闽政权奠基。", "王审知"),
  person("wang-yanhan", "王延翰", ["君主"], "王审知长子，王审知死后继位。骄奢并与弟王延钧失和，926年被王延钧、王延禀起兵杀害，闽国由王延钧掌权。", "王延翰"),
  person("wang-yanjun", "王延钧", ["君主"], "王审知次子，联合王延禀推翻兄长王延翰后掌权，后称帝、改名王鏻。晚年猜忌宗室与大臣，934年被子王继鹏发动政变杀死。", "王延钧"),
  person("wang-jipeng", "王继鹏", ["君主"], "王延钧之子，改名王昶，杀父后继位并称帝。宠信宦官、兴建宫室，国内政变频仍；939年被叔父王延羲所杀。", "王继鹏"),
  person("wang-yanxi", "王延羲", ["君主"], "王审知之子，王继鹏死后即位，后改名王曦并称帝。统治期间闽国内乱加剧，部将朱文进与连重遇发动兵变将其杀死，闽国分裂。", "王延羲"),
  person("zhu-wenjin", "朱文进", ["君主"], "闽将，因王延羲猜忌而与连重遇发动政变，杀王延羲后自立为闽主。王氏宗室王延政自建州起兵反攻，朱文进在位仅数月即被杀。", "朱文进"),
  person("wang-yanzheng", "王延政", ["君主"], "王审知之子，长期镇守建州，与福州王氏政权对立。朱文进被杀后入据福州并称帝，改国号大殷、后复称闽；945年南唐军攻陷建州，王延政出降，闽亡。", "王延政"),
  person("liu-yan", "刘龑", ["皇帝"], "原名刘岩，刘隐之弟，继承其在岭南的军政基础。917年在广州称帝，国号大越，次年改汉，史称南汉；在位时扩张岭南并强化宫廷统治，传位于子刘玢。", "刘龑"),
  person("liu-bin", "刘玢", ["皇帝"], "刘龑次子，刘龑死后继位。统治仅一年多即被弟刘晟与党羽发动政变杀害，南汉皇位由刘晟承接。", "刘玢"),
  person("liu-sheng", "刘晟", ["皇帝"], "刘龑之子，杀兄刘玢后即位。以严酷手段清除宗室和大臣，南汉政局趋于封闭；死后子刘鋹继位，宋军于971年灭南汉。", "刘晟"),
  person("liu-chang", "刘鋹", ["皇帝"], "刘晟之子，958年继位时年幼，朝政由宦官与近臣把持。面对北宋南征未能组织有效抵抗，971年广州失守后出降，南汉亡。", "刘鋹"),
  person("wang-jian-shu", "王建", ["皇帝"], "许州舞阳人，唐末入蜀任职，逐步控制西川并据成都。907年称帝建前蜀，扩展至两川及汉中；晚年因继承安排引发宫廷冲突，死后子王衍继位。", "王建"),
  person("wang-yan-shu", "王衍", ["皇帝"], "王建幼子，918年继位。统治期间宠信近臣、巡游奢侈，前蜀防务松弛；925年后唐军攻入成都，王衍出降，前蜀亡。", "王衍"),
  person("meng-zhixiang", "孟知祥", ["皇帝"], "后唐明宗李嗣源女婿，曾任西川节度使，逐步兼并东川并控制两川。934年在成都称帝建立后蜀，同年去世，子孟昶继位并完成政权交接。", "孟知祥"),
  person("meng-chang", "孟昶", ["皇帝"], "孟知祥之子，934年继位，在位三十余年。前期整顿蜀地政务、兴修水利，后期政治渐趋奢靡；965年宋军入成都后出降，后蜀亡。", "孟昶"),
  person("gao-jixing", "高季兴", ["君主"], "陕州人，早年为朱温部将，后镇守荆南江陵。后唐建立后据地自立，受封南平王；凭江陵交通位置与周边政权往来、互市，开创荆南政权。", "高季兴"),
  person("gao-conghe", "高从诲", ["君主"], "高季兴之子，继承荆南政权，在位时与后唐、后晋及南方诸国保持往来，借朝贡与贸易维持小国地位。死后子高保融继位。", "高从诲"),
  person("gao-baorong", "高保融", ["君主"], "高从诲之子，948年继位。荆南继续向中原王朝称臣，借江陵水陆交通经营朝贡和转口贸易；去世后弟高保勖继位。", "高保融"),
  person("gao-baoxu", "高保勖", ["君主"], "高从诲之子、高保融之弟，继承荆南王位。即位后不久病重去世，由侄高继冲继位，政权继续维持江陵一隅。", "高保勖"),
  person("gao-jichong", "高继冲", ["君主"], "高保融之子，962年继承荆南。宋军平定湖南后进逼江陵，高继冲于963年纳土归宋，荆南政权结束。", "高继冲"),
  person("ma-yin", "马殷", ["君主"], "许州鄢陵人，唐末随秦宗权部将孙儒转战，后控制湖南并以潭州为中心。受后梁封楚王，建立马楚政权；在位时发展茶业、鼓励商贸并维持对中原称臣。", "马殷"),
  person("ma-xisheng", "马希声", ["君主"], "马殷之子，继承楚王位，在位时间较短。延续父亲对后梁的臣属关系，死后弟马希范继位。", "马希声"),
  person("ma-xifan", "马希范", ["君主"], "马殷之子，继位后扩建长沙城与宫室，并维持马楚对后晋、后汉的朝贡关系。其统治时期政权疆域与财赋达到高峰，但宫廷营建和赏赐耗费增加；死后诸弟争位。", "马希范"),
  person("ma-xiguang", "马希广", ["君主"], "马殷之子，马希范死后由部分大臣拥立。兄长马希萼不服，率军争夺潭州，马希广兵败被杀，楚国内战扩大。", "马希广"),
  person("ma-xie", "马希萼", ["君主"], "马殷之子，长期镇守朗州，与兄马希广争夺楚王位。攻下潭州后即位，但将领拥立其弟马希崇反叛；南唐乘乱出兵，马希萼被俘，楚国亡。", "马希萼"),
  person("ma-xichong", "马希崇", ["君主"], "马殷之子，参与推翻兄长马希萼后短暂掌权。951年南唐军入长沙，马希崇出降并被迁往金陵，马楚政权结束。", "马希崇"),
  person("liu-min", "刘旻", ["皇帝"], "本名刘崇，后汉高祖刘知远之弟。郭威代汉建周后，他在太原称帝，建立北汉并依附契丹，与后周及北宋长期争战；死后子刘钧继位。", "刘旻"),
  person("liu-jun-bei", "刘钧", ["皇帝"], "刘旻之子，954年继位，改名刘钧。北汉继续以契丹为外援，对后周、北宋用兵并数次遭败；968年去世后，养子刘继恩、刘继元相继继位。", "刘钧"),
  person("liu-jiyuan", "刘继元", ["皇帝"], "刘钧养子，继刘继恩被杀后即位。北汉在北宋持续围攻下日益困窘，979年宋太宗亲征太原，刘继元出降，北汉亡，宋完成对中原与北方主要地区的统一。", "刘继元"),
  // 宋
  person("zhao-kuangyin", "赵匡胤", ["皇帝"], "宋太祖，陈桥兵变建宋，杯酒释兵权。", "赵匡胤"),
  person("zhao-kuangyi", "赵光义", ["皇帝"], "宋太宗，完成统一，幽州之战失利。", "赵光义"),
  person("zhao-heng", "赵恒", ["皇帝"], "宋真宗，澶渊之盟在其朝。", "宋真宗"),
  person("zhao-zhen", "赵祯", ["皇帝"], "宋仁宗，庆历新政，北宋极盛。", "宋仁宗"),
  person("zhao-shu", "赵曙", ["皇帝"], "宋英宗，在位仅四年。", "宋英宗"),
  person("zhao-xu", "赵顼", ["皇帝"], "宋神宗，王安石变法在其朝。", "宋神宗"),
  person("zhao-zhe", "赵煦", ["皇帝"], "宋哲宗，元祐更化与绍圣绍述。", "宋哲宗"),
  person("zhao-ji", "赵佶", ["皇帝"], "宋徽宗，崇道兴艺术，靖康之耻。", "宋徽宗"),
  person("zhao-huan", "赵桓", ["皇帝"], "宋钦宗，靖康之变被俘，北宋亡。", "宋钦宗"),
  person("zhao-gou", "赵构", ["皇帝"], "宋高宗，南渡建南宋，杀岳飞。", "宋高宗"),
  person("zhao-shen", "赵昚", ["皇帝"], "宋孝宗，乾淳之治，南宋中兴。", "宋孝宗"),
  person("zhao-dun", "赵惇", ["皇帝"], "宋光宗，淳熙内禅。", "宋光宗"),
  person("zhao-kuo", "赵扩", ["皇帝"], "宋宁宗，开禧北伐。", "宋宁宗"),
  person("zhao-yun", "赵昀", ["皇帝"], "宋理宗，联蒙灭金，后蒙攻宋。", "宋理宗"),
  person("zhao-qi", "赵禥", ["皇帝"], "宋度宗，度宗荒怠，宋势日衰。", "宋度宗"),
  person("zhao-shi", "赵显", ["皇帝"], "宋恭帝，降元，南宋实质亡。", "宋恭帝"),
  person("zhao-shi-duan", "赵昰", ["皇帝"], "宋端宗，流亡途中崩。", "宋端宗"),
  person("zhao-bing", "赵昺", ["皇帝"], "宋帝昺，崖山海战殉国，南宋亡。", "宋帝昺"),
  person("an-lushan", "安禄山", ["将领"], "安史之乱发动者，范阳节度使。", "安禄山", ym(703), ym(761)),
  person("huang-chao", "黄巢", ["起义领袖"], "唐末农民起义领袖，攻入长安。", "黄巢"),
  person("wang-anshi", "王安石", ["政治家"], "北宋改革家，熙宁变法主持者。", "王安石", ym(1021), ym(1086)),
  // 唐——非帝王人物
  person("wei-zheng", "魏征", ["政治家"], "唐太宗时名相，以直言敢谏著称，为贞观之治奠基。", "魏征", ym(580), ym(643)),
  person("fang-xuanling", "房玄龄", ["政治家"], "唐初宰相，与杜如晦并称房谋杜断。", "房玄龄", ym(579), ym(648)),
  person("du-ruhui", "杜如晦", ["政治家"], "唐初宰相，辅佐李世民定策夺位、治理天下。", "杜如晦", ym(585), ym(630)),
  person("li-jing-tang", "李靖", ["军事家"], "唐初名将，平定江南、北击突厥，封卫国公。", "李靖", ym(571), ym(649)),
  person("guo-ziyi", "郭子仪", ["军事家"], "平定安史之乱功臣，再造唐朝，封汾阳王。", "郭子仪", ym(697), ym(781)),
  person("di-renjie", "狄仁杰", ["政治家"], "武周名臣，断案如神，后复为宰相。", "狄仁杰", ym(630), ym(700)),
  person("li-bai", "李白", ["诗人"], "盛唐诗人，诗仙，浪漫主义诗歌代表。", "李白", ym(701), ym(762)),
  person("du-fu", "杜甫", ["诗人"], "盛唐诗人，诗圣，现实主义诗歌高峰。", "杜甫", ym(712), ym(770)),
  person("wang-wei", "王维", ["诗人", "画家"], "盛唐诗人画家，山水田园诗代表。", "王维", ym(701), ym(761)),
  person("bai-juyi", "白居易", ["诗人"], "中唐诗人，新乐府运动代表，长恨歌、琵琶行作者。", "白居易", ym(772), ym(846)),
  person("han-yu", "韩愈", ["文学家"], "中唐古文运动领袖，唐宋八大家之首。", "韩愈", ym(768), ym(824)),
  person("du-mu", "杜牧", ["诗人"], "晚唐诗人，与李商隐并称小李杜。", "杜牧", ym(803), ym(852)),
  person("yan-zhenqing", "颜真卿", ["书法家", "政治家"], "唐代书法家，颜体创始人，安史之乱中守平原。", "颜真卿", ym(709), ym(784)),
  person("xuanzang", "玄奘", ["高僧", "学者"], "西行取经，回国后主持译经，创唯识宗。", "玄奘", ym(602), ym(664)),
  person("jianzhen", "鉴真", ["高僧"], "六次东渡日本，传播佛教与唐文化。", "鉴真", ym(688), ym(763)),
  person("yang-guifei", "杨玉环", ["后妃"], "唐玄宗宠妃，马嵬驿之变中被赐死。", "杨贵妃", ym(719), ym(756)),
  person("shangguan-waner", "上官婉儿", ["政治家", "诗人"], "武则天、中宗朝女官，掌制诰，诗文名世。", "上官婉儿", ym(664), ym(710)),
  person("wei-hou", "韦后", ["皇后", "政治家"], "唐中宗皇后，神龙政变后擅权，效法武则天，景龙政变中被杀。", "韦皇后", ym(644), ym(710, 7)),
  person("xue-rengui", "薛仁贵", ["军事家"], "唐将，白袍将军，征高句丽、击突厥。", "薛仁贵", ym(614), ym(683)),
  person("zhang-xun", "张巡", ["军事家"], "安史之乱中死守睢阳，阻叛军南下。", "张巡", null, ym(757)),
  // 宋——非帝王人物
  person("fan-zhongyan", "范仲淹", ["政治家", "文学家"], "北宋名臣，庆历新政主持者，岳阳楼记作者。", "范仲淹", ym(989), ym(1052)),
  person("bao-zheng", "包拯", ["政治家"], "北宋名臣，以清廉刚正著称，开封府尹。", "包拯", ym(999), ym(1062)),
  person("ouyang-xiu", "欧阳修", ["文学家", "政治家"], "北宋文坛领袖，唐宋八大家之一，主持庆历新政。", "欧阳修", ym(1007), ym(1072)),
  person("si-ma-guang", "司马光", ["史学家", "政治家"], "北宋史学家，主编资治通鉴，元祐更化代表。", "司马光", ym(1019), ym(1086)),
  person("su-shi", "苏轼", ["文学家", "政治家"], "北宋文学家，唐宋八大家之一，诗词书画皆精。", "苏轼", ym(1037), ym(1101)),
  person("shen-kuo", "沈括", ["科学家"], "北宋科学家，梦溪笔谈作者，天文历法、物理皆有建树。", "沈括", ym(1031), ym(1095)),
  person("xin-qiji", "辛弃疾", ["词人", "军事家"], "南宋词人，抗金名将，豪放词派代表。", "辛弃疾", ym(1140), ym(1207)),
  person("lu-you", "陆游", ["诗人"], "南宋爱国诗人，诗词文俱工，存诗近万首。", "陆游", ym(1125), ym(1210)),
  person("han-shizhong", "韩世忠", ["军事家"], "南宋抗金名将，黄天荡之战大败金军。", "韩世忠", ym(1089), ym(1151)),
  person("li-gang", "李纲", ["政治家", "军事家"], "北宋末宰相，力主抗金，靖康之变前后多次起用。", "李纲", ym(1083), ym(1140)),
  person("wen-tianxiang", "文天祥", ["政治家"], "南宋末丞相，抗元被俘，作正气歌，就义于大都。", "文天祥", ym(1236), ym(1283)),
];

const allPersons = persons;

// ── dynasties ──────────────────────────────────────────────────────────────

const dynastyGroups = [
  {
    id: "wudai",
    name: "五代",
    altNames: [],
    scope: "cn",
    start: ym(907),
    end: ym(960, 12),
    precision: "year",
    note: "907–960年北方五代更迭。",
  },
  {
    id: "shiguo",
    name: "十国",
    altNames: [],
    scope: "cn",
    start: ym(907),
    end: ym(979, 12),
    precision: "year",
    note: "907–979年南方十国割据。",
  },
];

const dynasties = [
  { id: "sui", name: "隋", altNames: ["大隋"], scope: "cn", region: "east_asia", start: ym(581, 3), end: ym(619, 5), precision: "month", note: "581年3月杨坚受禅建隋；589年灭陈统一。618年唐建立后，东都杨侗仍续统，至619年5月被废，隋亡。" },
  { id: "xu", name: "许", altNames: ["宇文化及许"], scope: "cn", region: "east_asia", start: ym(618, 9), end: ym(619, 5), precision: "month", note: "宇文化及杀杨浩后自立，国号许，旋为窦建德所败，619年覆亡。" },
  { id: "xia-dou-jiande", name: "夏", altNames: ["窦夏", "夏王窦建德政权"], scope: "cn", region: "east_asia", start: ym(618, 11), end: ym(621, 5), precision: "month", note: "窦建德于618年11月在乐寿建夏称王；621年5月虎牢战败被俘，夏政权覆亡。" },
  { id: "zheng", name: "郑", altNames: ["王世充郑"], scope: "cn", region: "east_asia", start: ym(619), end: ym(621, 6), precision: "month", note: "王世充于619年在洛阳称帝、国号郑；621年6月4日（武德四年五月丙寅）降唐，政权覆亡。" },
  { id: "tang", name: "唐", altNames: ["李唐"], scope: "cn", region: "east_asia", start: ym(618, 6), end: ym(907), precision: "month", note: "618年6月李渊受隋恭帝禅让建唐，都长安；907年朱温篡唐，唐亡。" },
  { id: "zhou-wu", name: "武周", altNames: ["周"], scope: "cn", region: "east_asia", start: ym(690), end: ym(705), precision: "year", note: "武则天改国号周，690–705年，后还政李唐。" },
  { id: "liang-hou", name: "后梁", altNames: ["梁"], scope: "cn", region: "east_asia", start: ym(907), end: ym(923), precision: "year", groupId: "wudai", note: "朱温篡唐建梁，都开封；923年后唐灭之。" },
  { id: "tang-hou", name: "后唐", altNames: ["唐"], scope: "cn", region: "east_asia", start: ym(923), end: ym(936), precision: "year", groupId: "wudai", note: "李存勖灭梁称帝；936年石敬瑭联契丹灭之。" },
  { id: "jin-hou", name: "后晋", altNames: ["晋"], scope: "cn", region: "east_asia", start: ym(936), end: ym(947), precision: "year", groupId: "wudai", note: "石敬瑭割燕云十六州；947年契丹灭晋。" },
  { id: "han-hou", name: "后汉", altNames: ["汉"], scope: "cn", region: "east_asia", start: ym(947), end: ym(951), precision: "year", groupId: "wudai", note: "刘知远建后汉；951年郭威代汉。" },
  { id: "zhou-hou", name: "后周", altNames: ["周"], scope: "cn", region: "east_asia", start: ym(951), end: ym(960), precision: "year", groupId: "wudai", note: "郭威建后周；960年赵匡胤陈桥兵变代周。" },
  { id: "wu-shi", name: "吴", altNames: ["杨吴", "十国吴"], scope: "cn", region: "east_asia", start: ym(902), end: ym(937), precision: "year", groupId: "shiguo", note: "杨行密据淮南；937年为南唐所灭。" },
  { id: "tang-nan", name: "南唐", altNames: ["唐"], scope: "cn", region: "east_asia", start: ym(937), end: ym(975), precision: "year", groupId: "shiguo", note: "李昪代吴建南唐；975年宋灭之。" },
  { id: "wuyue", name: "吴越", altNames: ["吴越国"], scope: "cn", region: "east_asia", start: ym(907), end: ym(978), precision: "year", groupId: "shiguo", note: "钱镠据两浙；978年钱俶纳土归宋。" },
  { id: "min-fujian", name: "闽", altNames: ["闽国"], scope: "cn", region: "east_asia", start: ym(909), end: ym(945), precision: "year", groupId: "shiguo", note: "王审知据福建；945年内乱灭亡。" },
  { id: "han-nan", name: "南汉", altNames: ["汉"], scope: "cn", region: "east_asia", start: ym(917), end: ym(971), precision: "year", groupId: "shiguo", note: "刘龑据岭南；971年宋灭之。" },
  { id: "shu-qian", name: "前蜀", altNames: ["蜀"], scope: "cn", region: "east_asia", start: ym(907), end: ym(925), precision: "year", groupId: "shiguo", note: "王建据成都；925年后唐灭之。" },
  { id: "shu-hou", name: "后蜀", altNames: ["蜀"], scope: "cn", region: "east_asia", start: ym(934), end: ym(965, 2), precision: "year", groupId: "shiguo", note: "孟知祥据成都；965年正月辛卯孟昶出降，宋灭之。" },
  { id: "jingnan", name: "荆南", altNames: ["南平"], scope: "cn", region: "east_asia", start: ym(924), end: ym(963), precision: "year", groupId: "shiguo", note: "高季兴据江陵；963年纳土归宋。" },
  { id: "chu-nan", name: "楚", altNames: ["马楚"], scope: "cn", region: "east_asia", start: ym(907), end: ym(951), precision: "year", groupId: "shiguo", note: "马殷据湖南；951年南唐灭楚。" },
  { id: "han-bei", name: "北汉", altNames: ["汉"], scope: "cn", region: "east_asia", start: ym(951), end: ym(979), precision: "year", groupId: "shiguo", note: "刘旻据太原；979年宋灭之，十国终结。" },
  { id: "song-north", name: "北宋", altNames: ["宋"], scope: "cn", region: "east_asia", start: ym(960, 2), end: ym(1127, 3), precision: "month", note: "960年2月陈桥兵变后赵匡胤建宋；1127年3月靖康之变，北宋亡。南宋于同年6月重建宋室。" },
  { id: "song-south", name: "南宋", altNames: ["宋"], scope: "cn", region: "east_asia", start: ym(1127, 6), end: ym(1279, 3), precision: "month", note: "1127年6月12日赵构即位，南宋重建宋室；1279年3月崖山海战，南宋亡。" },
];

// ── reigns ─────────────────────────────────────────────────────────────────

const suiReignsCore = [
  dynastyReign("sui", "yang-jian", "隋文帝", "文皇帝", null, 581, 604, eras("reign-yang-jian", [{ name: "开皇", sy: 581, ey: 600 }, { name: "仁寿", sy: 601, ey: 604 }])),
  dynastyReign("sui", "yang-guang", "隋炀帝", "炀皇帝", null, 604, 618, eras("reign-yang-guang", [{ name: "大业", sy: 605, ey: 618 }])),
  dynastyReign("sui", "yang-hao", "隋秦王", null, null, 618, 618, [], { role: "rival" }),
];
const suiReignsParallel = [
  dynastyReign("sui", "yang-you", "隋恭帝", "恭帝", null, 617, 618, [], {
    track: "changan",
    label: "长安",
  }),
  dynastyReign("sui", "yang-tong", "隋越王", null, null, 618, 619, [], {
    track: "luoyang",
    label: "洛阳",
  }),
];

const suiReignsRivalStates = [
  { ...dynastyReign("xia-dou-jiande", "dou-jiande", "夏王", null, null, 618, 621), start: ym(618, 11), startAbs: absMonth(618, 11), end: ym(621, 5), endAbs: absMonth(621, 5), precision: "month" },
  { ...dynastyReign("zheng", "wang-shichong", "郑帝", null, null, 619, 621), end: ym(621, 6), endAbs: absMonth(621, 6), precision: "month" },
];
const suiReigns = [...suiReignsCore, ...suiReignsParallel];
const xuReigns = [
  {
    ...reign({
      id: "reign-yuwen-huaji-xu",
      dynastyId: "xu",
      personId: "yuwen-huaji",
      title: "许帝",
      posthumousName: null,
      templeName: null,
      start: ym(618, 9),
      end: ym(619, 5),
      precision: "month",
      eraNames: ["天寿"],
    }),
  },
];

const tangReigns = [
  dynastyReign("tang", "li-yuan", "唐高祖", "神尧皇帝", "高祖", 618, 626),
  dynastyReign("tang", "li-shimin", "唐太宗", "文武皇帝", "太宗", 626, 649, eras("reign-li-shimin", [{ name: "贞观", sy: 627, ey: 649 }])),
  dynastyReign("tang", "li-zhi", "唐高宗", "天皇大帝", "高宗", 649, 683),
  // 李显、李旦两度即位，中间夹武周（690–705），各拆两段在位。
  tangSplitReign("reign-li-xian", "li-xian", "唐中宗", null, "中宗", 684, 684, { startMonth: 1, endMonth: 2, precision: "month" }),
  // 睿宗第一次退位于 690 年九月；武周 690 年十月称帝，705 年正月逊位，中宗同日复位。
  tangSplitReign("reign-li-dan", "li-dan", "唐睿宗", null, "睿宗", 684, 690, {
    endMonth: 9,
    precision: "month",
  }),
  tangSplitReign("reign-li-xian-2", "li-xian", "唐中宗", null, "中宗", 705, 710, {
    startMonth: 1,
    precision: "month",
  }),
  tangSplitReign("reign-li-dan-2", "li-dan", "唐睿宗", null, "睿宗", 710, 712),
  dynastyReign("tang", "li-longji", "唐玄宗", "至道大明孝皇帝", "玄宗", 712, 756, eras("reign-li-longji", [{ name: "开元", sy: 713, ey: 741 }, { name: "天宝", sy: 742, ey: 756 }])),
  dynastyReign("tang", "li-heng", "唐肃宗", null, "肃宗", 756, 762),
  dynastyReign("tang", "li-yu-tang", "唐代宗", null, "代宗", 762, 779),
  dynastyReign("tang", "li-kuo", "唐德宗", null, "德宗", 779, 805),
  dynastyReign("tang", "li-song", "唐顺宗", null, "顺宗", 805, 805),
  dynastyReign("tang", "li-chun", "唐宪宗", null, "宪宗", 806, 820),
  dynastyReign("tang", "li-heng-mu", "唐穆宗", null, "穆宗", 820, 824),
  dynastyReign("tang", "li-zhan", "唐敬宗", null, "敬宗", 824, 826),
  dynastyReign("tang", "li-ang", "唐文宗", null, "文宗", 826, 840),
  dynastyReign("tang", "li-yan-tang", "唐武宗", null, "武宗", 840, 846),
  dynastyReign("tang", "li-chen-tang", "唐宣宗", null, "宣宗", 846, 859),
  dynastyReign("tang", "li-cui", "唐懿宗", null, "懿宗", 859, 873),
  dynastyReign("tang", "li-xuan-tang", "唐僖宗", null, "僖宗", 873, 888),
  dynastyReign("tang", "li-ye-tang", "唐昭宗", null, "昭宗", 888, 904),
  dynastyReign("tang", "li-zhu-tang", "唐哀帝", "哀帝", null, 904, 907),
];

const zhouWuReigns = [
  reign({
    id: "reign-wu-zetian-zhou-wu",
    dynastyId: "zhou-wu",
    personId: "wu-zetian",
    title: "则天皇帝",
    posthumousName: null,
    templeName: null,
    start: ym(690, 10),
    end: ym(705, 1),
    precision: "month",
    eraNames: eras("reign-wu-zetian-zhou-wu", [
      { name: "天授", sy: 690, ey: 692 },
      { name: "万岁通天", sy: 696, ey: 697 },
      { name: "万岁登封", sy: 697, ey: 697 },
      { name: "神功", sy: 697, ey: 700 },
      { name: "圣历", sy: 700, ey: 700 },
      { name: "久视", sy: 700, ey: 701 },
      { name: "大足", sy: 701, ey: 701 },
      { name: "长安", sy: 701, ey: 705 },
    ]),
  }),
];

const wudaiReigns = [
  dr("liang-hou", "zhu-wen", "后梁太祖", null, "太祖", 907, 912),
  dr("liang-hou", "zhu-yougui", "后梁末帝", null, null, 912, 913),
  dr("liang-hou", "zhu-youzhen", "后梁末帝", null, null, 913, 923),
  dr("tang-hou", "li-cunxu", "后唐庄宗", null, "庄宗", 923, 926),
  dr("tang-hou", "li-siyuan", "后唐明宗", null, "明宗", 926, 933),
  dr("tang-hou", "li-conghou", "后唐闵帝", "闵帝", null, 934, 934),
  dr("tang-hou", "li-congke", "后唐末帝", null, null, 934, 936),
  dr("jin-hou", "shi-jingtang", "后晋高祖", null, "高祖", 936, 942),
  dr("jin-hou", "shi-chonggui", "后晋出帝", "出帝", null, 942, 947),
  dr("han-hou", "liu-zhiyuan", "后汉高祖", null, "高祖", 947, 948),
  dr("han-hou", "liu-chengyou", "后汉隐帝", "隐帝", null, 948, 951),
  dr("zhou-hou", "guo-wei", "后周太祖", null, "太祖", 951, 954),
  dr("zhou-hou", "chai-rong", "后周世宗", null, "世宗", 954, 959),
  dr("zhou-hou", "chai-zongxun", "后周恭帝", "恭帝", null, 959, 960),
];

const shiguoReigns = [
  dr("wu-shi", "yang-xingmi", "吴太祖", null, "太祖", 902, 905),
  dr("wu-shi", "yang-wo", "吴王", null, null, 905, 918),
  dr("wu-shi", "yang-longyan", "吴王", null, null, 918, 920),
  dr("wu-shi", "yang-pu", "吴末帝", null, null, 920, 937),
  dr("tang-nan", "li-bian", "南唐烈祖", null, "烈祖", 937, 943),
  dr("tang-nan", "li-jing-nantang", "南唐元宗", null, "元宗", 943, 961),
  dr("tang-nan", "li-yu-nantang", "南唐后主", null, null, 961, 975),
  dr("wuyue", "qian-liu", "吴越武肃王", "武肃王", null, 907, 932),
  dr("wuyue", "qian-yuangui", "吴越文穆王", "文穆王", null, 932, 941),
  dr("wuyue", "qian-hongzuo", "吴越忠悼王", "忠悼王", null, 941, 947),
  dr("wuyue", "qian-hongcong", "吴越忠逊王", "忠逊王", null, 947, 948),
  dr("wuyue", "qian-chu", "吴越忠懿王", "忠懿王", null, 948, 978),
  dr("min-fujian", "wang-shenzhi", "闽太祖", null, "太祖", 909, 925),
  dr("min-fujian", "wang-yanhan", "闽主", null, null, 925, 926),
  dr("min-fujian", "wang-yanjun", "闽主", null, null, 926, 935),
  dr("min-fujian", "wang-jipeng", "闽主", null, null, 935, 939),
  dr("min-fujian", "wang-yanxi", "闽主", null, null, 939, 944),
  dr("min-fujian", "zhu-wenjin", "闽主", null, null, 944, 944),
  dr("min-fujian", "wang-yanzheng", "闽主", null, null, 943, 945),
  dr("han-nan", "liu-yan", "南汉高祖", null, "高祖", 917, 942),
  dr("han-nan", "liu-bin", "南汉殇帝", "殇帝", null, 942, 943),
  dr("han-nan", "liu-sheng", "南汉中宗", null, "中宗", 943, 958),
  dr("han-nan", "liu-chang", "南汉末帝", null, null, 958, 971),
  dr("shu-qian", "wang-jian-shu", "前蜀高祖", null, "高祖", 907, 918),
  dr("shu-qian", "wang-yan-shu", "前蜀末帝", null, null, 918, 925),
  dr("shu-hou", "meng-zhixiang", "后蜀高祖", null, "高祖", 934, 934),
  dr("shu-hou", "meng-chang", "后蜀后主", "恭孝王", null, 934, 965),
  dr("jingnan", "gao-jixing", "荆南武信王", "武信王", null, 924, 928),
  dr("jingnan", "gao-conghe", "荆南文献王", "文献王", null, 928, 948),
  dr("jingnan", "gao-baorong", "荆南贞懿王", "贞懿王", null, 948, 960),
  dr("jingnan", "gao-baoxu", "荆南贞献王", "贞献王", null, 960, 962),
  dr("jingnan", "gao-jichong", "荆南末王", null, null, 962, 963),
  dr("chu-nan", "ma-yin", "楚武王", "武王", null, 907, 930),
  dr("chu-nan", "ma-xisheng", "楚王", null, null, 930, 932),
  dr("chu-nan", "ma-xifan", "楚王", null, null, 932, 947),
  dr("chu-nan", "ma-xiguang", "楚王", null, null, 947, 947),
  dr("chu-nan", "ma-xie", "楚王", null, null, 947, 950),
  dr("chu-nan", "ma-xichong", "楚王", null, null, 950, 951),
  dr("han-bei", "liu-min", "北汉世祖", null, "世祖", 951, 954),
  dr("han-bei", "liu-jun-bei", "北汉睿皇帝", "睿皇帝", null, 954, 968),
  dr("han-bei", "liu-jiyuan", "北汉末帝", null, null, 968, 979),
];

// 两宋皇帝在位日取维基百科/宋史通行换算，precision=day。
const songNorthReigns = [
  drDay("song-north", "zhao-kuangyin", "宋太祖", null, "太祖", 960, 2, 4, 976, 11, 14, [{ name: "建隆", sy: 960, ey: 963 }, { name: "乾德", sy: 963, ey: 968 }, { name: "开宝", sy: 968, ey: 976 }]),
  drDay("song-north", "zhao-kuangyi", "宋太宗", null, "太宗", 976, 11, 14, 997, 5, 8),
  drDay("song-north", "zhao-heng", "宋真宗", null, "真宗", 997, 5, 8, 1022, 3, 23),
  drDay("song-north", "zhao-zhen", "宋仁宗", null, "仁宗", 1022, 3, 23, 1063, 4, 30, [{ name: "天圣", sy: 1023, ey: 1032 }, { name: "明道", sy: 1032, ey: 1033 }, { name: "景祐", sy: 1034, ey: 1038 }, { name: "庆历", sy: 1041, ey: 1048 }]),
  drDay("song-north", "zhao-shu", "宋英宗", null, "英宗", 1063, 4, 30, 1067, 1, 25),
  drDay("song-north", "zhao-xu", "宋神宗", null, "神宗", 1067, 1, 25, 1085, 4, 1, [{ name: "熙宁", sy: 1068, ey: 1077 }, { name: "元丰", sy: 1078, ey: 1085 }]),
  drDay("song-north", "zhao-zhe", "宋哲宗", null, "哲宗", 1085, 4, 1, 1100, 2, 23),
  drDay("song-north", "zhao-ji", "宋徽宗", null, "徽宗", 1100, 2, 23, 1126, 1, 18),
  drDay("song-north", "zhao-huan", "宋钦宗", null, "钦宗", 1126, 1, 18, 1127, 6, 12),
];

const songSouthReigns = [
  drDay("song-south", "zhao-gou", "宋高宗", null, "高宗", 1127, 6, 12, 1162, 7, 24),
  drDay("song-south", "zhao-shen", "宋孝宗", null, "孝宗", 1162, 7, 24, 1189, 2, 18),
  drDay("song-south", "zhao-dun", "宋光宗", null, "光宗", 1189, 2, 18, 1194, 7, 24),
  drDay("song-south", "zhao-kuo", "宋宁宗", null, "宁宗", 1194, 7, 24, 1224, 9, 18),
  drDay("song-south", "zhao-yun", "宋理宗", null, "理宗", 1224, 9, 18, 1264, 11, 16),
  drDay("song-south", "zhao-qi", "宋度宗", null, "度宗", 1264, 11, 16, 1274, 8, 12),
  drDay("song-south", "zhao-shi", "宋恭帝", null, "恭帝", 1274, 8, 12, 1276, 2, 4),
  drDay("song-south", "zhao-shi-duan", "宋端宗", null, "端宗", 1276, 6, 14, 1278, 5, 8),
  drDay("song-south", "zhao-bing", "宋帝昺", null, null, 1278, 5, 10, 1279, 3, 19),
];

// 杨侑与杨侗使用并立 track；杨浩留在主行，但标记为非正统继位，不显示金色。
const reignGroups = [suiReignsCore, tangReigns, zhouWuReigns, wudaiReigns, shiguoReigns, songNorthReigns, songSouthReigns];
const reigns = applyDocumentedDatesToReigns(
  [suiReigns, xuReigns, suiReignsRivalStates, tangReigns, zhouWuReigns, wudaiReigns, shiguoReigns, songNorthReigns, songSouthReigns].flat(),
);

// ── events ───────────────────────────────────────────────────────────────────

function eventPoint(partial) {
  const precision = partial.precision ?? "year";
  const at = normalizeYearPrecisionAt(partial.at, precision);
  return { kind: "other", timeMode: "point", precision: "year", dynastyIds: [], participantIds: [], ...partial, precision, at, atAbs: at.abs };
}
function eventRange(partial) {
  const start = partial.start;
  const end = partial.end;
  const precision = partial.precision ?? "year";
  const at = partial.at ? normalizeYearPrecisionAt(partial.at, precision) : undefined;
  return {
    kind: "other", precision: "year", dynastyIds: [], participantIds: [], ...partial,
    precision, start, end, startAbs: start.abs, endAbs: end.abs, ...(at ? { at, atAbs: at.abs } : {}),
  };
}

const events = [
  eventPoint({ id: "sui-unify", name: "隋灭陈统一", kind: "politics", at: ym(589), dynastyIds: ["sui", "chen-nan"], participantIds: ["yang-jian"], summary: "隋军灭南陈，南北分裂终结，隋统一全国。" }),
  eventRange({ id: "kaihuang-rule", name: "开皇之治", kind: "politics", timeMode: "span", start: ym(581), end: ym(600), dynastyIds: ["sui"], participantIds: ["yang-jian"], summary: "隋文帝励精图治，轻徭薄赋，国力强盛。" }),
  eventRange({ id: "grand-canal", name: "开凿大运河", kind: "culture", timeMode: "span", dateNote: "605年起大规模开凿，连通南北", start: ym(605), end: ym(610), dynastyIds: ["sui"], participantIds: ["yang-guang"], summary: "隋炀帝下令开凿大运河，贯通南北交通。" }),
  eventRange({ id: "sui-campaign-goguryeo", name: "隋炀帝三征高丽", kind: "battle", timeMode: "span", start: ym(612), end: ym(614), dynastyIds: ["sui"], participantIds: ["yang-guang"], summary: "隋炀帝三次大规模远征高句丽，劳民伤财，隋军惨败，国力大损。" }),
  eventPoint({
    id: "yang-guang-killed",
    name: "江都兵变：隋炀帝被杀",
    kind: "politics",
    precision: "day",
    dateNote: "大业十四年三月十一丙辰，618年4月11日，宇文化及发动兵变，隋炀帝被弑",
    at: ymDay(618, 4, 11),
    dynastyIds: ["sui"],
    participantIds: ["yang-guang", "yuwen-huaji"],
    summary: "宇文化及发动江都兵变，隋炀帝杨广被弑；随后江都军拥立杨浩。",
  }),
  eventPoint({
    id: "yang-hao-killed",
    name: "宇文化及杀秦王杨浩",
    kind: "politics",
    precision: "day",
    dateNote: "武德元年九月辛未，618年10月23日，《新唐书·高祖本纪》记宇文化及杀秦王浩并自称皇帝",
    at: ymDay(618, 10, 23),
    dynastyIds: ["sui", "xu"],
    participantIds: ["yang-hao", "yuwen-huaji"],
    summary: "宇文化及杀隋秦王杨浩，随后自称皇帝，建立许政权。",
  }),
  eventPoint({ id: "xuanwumen", name: "玄武门之变", kind: "politics", precision: "month", dateNote: "武德九年六月，626年", at: ym(626, 7), dynastyIds: ["tang"], participantIds: ["li-shimin"], summary: "李世民发动政变，杀兄弟即位太子，后登基。" }),
  eventPoint({ id: "hulao-battle", name: "虎牢之战", kind: "battle", precision: "month", dateNote: "武德四年五月，李世民大败窦建德；王世充于同月丙寅（公历621年6月4日）降唐", at: ym(621, 5), dynastyIds: ["tang"], participantIds: ["li-shimin", "dou-jiande", "wang-shichong"], summary: "李世民于虎牢关以少胜多，窦建德被俘；失去外援的王世充随后降唐，唐朝平定夏、郑。" }),
  eventRange({ id: "zhenguan-rule", name: "贞观之治", kind: "politics", timeMode: "span", start: ym(627), end: ym(649), dynastyIds: ["tang"], participantIds: ["li-shimin"], summary: "唐太宗任贤纳谏，轻徭薄赋，为盛唐奠基。" }),
  eventRange({ id: "kaiyuan-prosperity", name: "开元盛世", kind: "politics", timeMode: "span", start: ym(713), end: ym(741), dynastyIds: ["tang"], participantIds: ["li-longji"], summary: "唐玄宗前期励精图治，唐朝国力达于鼎盛。" }),
  eventRange({ id: "anshi-rebellion", name: "安史之乱", kind: "battle", timeMode: "span", dateNote: "755–763年", start: ym(755), end: ym(763), dynastyIds: ["tang"], participantIds: ["li-longji", "an-lushan"], summary: "安禄山、史思明叛乱，唐朝由盛转衰。" }),
  eventPoint({ id: "huang-chao-uprising", name: "黄巢起义", kind: "politics", at: ym(875), dynastyIds: ["tang"], participantIds: ["huang-chao"], summary: "黄巢领导农民起义，攻入长安，唐廷名存实亡。" }),
  eventPoint({ id: "gaoliang-river-battle", name: "高梁河之战", kind: "battle", precision: "month", dateNote: "太平兴国四年六月，宋太宗北伐败于辽", at: ym(979, 6), dynastyIds: ["song-north", "liao"], participantIds: ["zhao-kuangyi"], summary: "宋太宗率军北伐辽国，于高梁河被耶律休哥击败，宋军溃退。" }),
  eventRange({ id: "xiangyang-siege", name: "襄樊之战", kind: "battle", timeMode: "span", start: ym(1268), end: ym(1273), dynastyIds: ["song-south", "mongol-empire", "yuan"], participantIds: ["zhao-qi"], summary: "蒙古军围攻襄阳、樊城；战争跨越1271年忽必烈改国号大元，1273年吕文焕降元，南宋长江防线洞开。" }),
  eventRange({ id: "xining-reform", name: "王安石变法", kind: "politics", timeMode: "span", start: ym(1069), end: ym(1085), dynastyIds: ["song-north"], participantIds: ["zhao-xu", "wang-anshi"], summary: "宋神宗用王安石推行新法，富国强兵。" }),
  eventPoint({
    id: "jingkang-incident",
    name: "靖康之变",
    kind: "politics",
    precision: "day",
    dateNote: "天会五年二月初六，1127年3月20日，金废徽钦二帝为庶人",
    at: ymDay(1127, 3, 20),
    dynastyIds: ["song-north"],
    participantIds: ["zhao-ji", "zhao-huan"],
    summary: "金军破开封，俘徽钦二帝，北宋灭亡。",
  }),
  eventPoint({
    id: "yashan-battle",
    name: "崖山海战",
    kind: "battle",
    precision: "day",
    dateNote: "祥兴二年二月初六，1279年3月19日，陆秀夫负帝昺殉国",
    at: ymDay(1279, 3, 19),
    dynastyIds: ["song-south", "yuan"],
    participantIds: ["zhao-bing"],
    summary: "元军于崖山击败宋军，陆秀夫负帝昺殉国，南宋亡。",
  }),
  eventRange({ id: "wudai-shiguo", name: "五代十国", kind: "politics", timeMode: "span", dateNote: "907–979年，北方五代更迭，南方十国并存", start: ym(907), end: ym(979), dynastyIds: ["liang-hou", "tang-hou", "jin-hou", "han-hou", "zhou-hou", "wu-shi", "tang-nan"], participantIds: ["zhu-wen"], summary: "唐亡后北方短命王朝更迭，南方十国割据，至宋统一。" }),
];

// ── relations ────────────────────────────────────────────────────────────────

function successionPairs(list) {
  const conventionalLine = list.filter((reign) => reign.claimRole !== "rival");
  const pairs = [];
  for (let i = 0; i < conventionalLine.length - 1; i++) {
    pairs.push([conventionalLine[i].personId, conventionalLine[i + 1].personId]);
  }
  return pairs;
}

const relations = [];
for (const group of reignGroups) {
  for (const [fromId, toId] of successionPairs(group)) {
    relations.push({ id: `rel-${fromId}-${toId}-succession`, fromRef: `person:${fromId}`, toRef: `person:${toId}`, kind: "succession" });
  }
}
relations.push(
  { id: "rel-xuanwumen-li-shimin", fromRef: "event:xuanwumen", toRef: "person:li-shimin", kind: "battle" },
  { id: "rel-hulao-li-shimin", fromRef: "event:hulao-battle", toRef: "person:li-shimin", kind: "battle" },
  { id: "rel-anshi-an-lushan", fromRef: "event:anshi-rebellion", toRef: "person:an-lushan", kind: "battle" },
  { id: "rel-gaoliang-zhao", fromRef: "event:gaoliang-river-battle", toRef: "person:zhao-kuangyi", kind: "battle" },
);

// ── SQL helpers ─────────────────────────────────────────────────────────────


function dynastyGroupSql(g) {
  return `INSERT INTO dynasty_groups (id, name, alt_names, scope, start_year, start_month, end_year, end_month, start_abs, end_abs, precision, note)
VALUES (${sqlStr(g.id)}, ${sqlStr(g.name)}, ${sqlArray(g.altNames ?? [])}, ${sqlStr(g.scope ?? "cn")}, ${g.start.year}, ${g.start.month}, ${g.end.year}, ${g.end.month}, ${g.start.abs}, ${g.end.abs}, ${sqlStr(g.precision ?? "year")}, ${sqlStr(g.note ?? null)})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, alt_names = EXCLUDED.alt_names, scope = EXCLUDED.scope, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, start_abs = EXCLUDED.start_abs, end_abs = EXCLUDED.end_abs, precision = EXCLUDED.precision, note = EXCLUDED.note;`;
}

function formatReignSql(r) {
  return reignSql(r, sqlStr, sqlJson, formatAppellationCsv);
}


function eventSql(e) {
  const cols = ["id", "name", "kind", "time_mode", "precision", "date_note", "at_year", "at_month", "at_day", "at_abs", "start_year", "start_month", "start_day", "start_abs", "end_year", "end_month", "end_day", "end_abs", "summary"];
  const vals = [sqlStr(e.id), sqlStr(e.name), sqlStr(e.kind), sqlStr(e.timeMode), sqlStr(e.precision), sqlStr(e.dateNote ?? null), e.at?.year ?? "NULL", e.at?.month ?? "NULL", e.at?.day ?? "NULL", e.atAbs ?? "NULL", e.start?.year ?? "NULL", e.start?.month ?? "NULL", e.start?.day ?? "NULL", e.startAbs ?? "NULL", e.end?.year ?? "NULL", e.end?.month ?? "NULL", e.end?.day ?? "NULL", e.endAbs ?? "NULL", sqlStr(e.summary ?? null)];
  return `INSERT INTO events (${cols.join(", ")}) VALUES (${vals.join(", ")})
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, kind = EXCLUDED.kind, time_mode = EXCLUDED.time_mode, precision = EXCLUDED.precision, date_note = EXCLUDED.date_note, at_year = EXCLUDED.at_year, at_month = EXCLUDED.at_month, at_day = EXCLUDED.at_day, at_abs = EXCLUDED.at_abs, start_year = EXCLUDED.start_year, start_month = EXCLUDED.start_month, start_day = EXCLUDED.start_day, start_abs = EXCLUDED.start_abs, end_year = EXCLUDED.end_year, end_month = EXCLUDED.end_month, end_day = EXCLUDED.end_day, end_abs = EXCLUDED.end_abs, summary = EXCLUDED.summary;`;
}

function parseRef(raw) {
  const [type, ...rest] = raw.split(":");
  return { type, id: rest.join(":") };
}

function relationSql(r) {
  const from = parseRef(r.fromRef);
  const to = parseRef(r.toRef);
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind) VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)}) ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;`;
}

const finalized = finalizeImportReigns(
  "sui-tang-wudai-song",
  allPersons,
  reigns,
);
const merged = mergeAppellationsIntoPersons(finalized.persons, finalized.reigns);
const importPersons = merged.persons;
const importReigns = merged.reigns;

const eventDynastySql = events.flatMap((e) => e.dynastyIds.map((d) => `INSERT INTO event_dynasties (event_id, dynasty_id) VALUES (${sqlStr(e.id)}, ${sqlStr(d)}) ON CONFLICT DO NOTHING;`));
const eventParticipantSql = events.flatMap((e) => e.participantIds.map((p) => `INSERT INTO event_participants (event_id, person_id) VALUES (${sqlStr(e.id)}, ${sqlStr(p)}) ON CONFLICT DO NOTHING;`));
const reignCapitalLinks = [
  ["reign-yang-you", "cap-sui-daxing-583"],
  ["reign-yang-you", "cap-sui-changan-618"],
  ["reign-yang-hao", "cap-sui-jiangdu-618"],
  ["reign-yang-tong", "cap-sui-luoyang-618"],
];
const reignCapitalSql = reignCapitalLinks.map(([reignId, capitalId]) =>
  `INSERT INTO reign_capitals (reign_id, capital_id) VALUES (${sqlStr(reignId)}, ${sqlStr(capitalId)}) ON CONFLICT DO NOTHING;`,
);

const sql = [
  "-- EraLens period import: sui-tang-wudai-song",
  "-- Window: 581-01 .. 1279-12",
  "BEGIN;",
  "DELETE FROM relations WHERE id = 'rel-yang-guang-yang-you-succession';",
  "DELETE FROM relations WHERE id = 'rel-yang-guang-yang-hao-succession';",
  "DELETE FROM relations WHERE from_type = 'event' AND from_id IN ('zhu-wen-usurp', 'yang-you-enthroned', 'yang-hao-enthroned', 'yang-tong-enthroned');",
  "DELETE FROM event_participants WHERE event_id IN ('yang-you-enthroned', 'yang-hao-enthroned', 'yang-tong-enthroned');",
  "DELETE FROM event_dynasties WHERE event_id IN ('yang-you-enthroned', 'yang-hao-enthroned', 'yang-tong-enthroned');",
  "DELETE FROM events WHERE id IN ('yang-you-enthroned', 'yang-hao-enthroned', 'yang-tong-enthroned');",
  "DELETE FROM event_participants WHERE event_id = 'zhu-wen-usurp';",
  "DELETE FROM event_dynasties WHERE event_id = 'zhu-wen-usurp';",
  "DELETE FROM events WHERE id = 'zhu-wen-usurp';",
  "DELETE FROM relations WHERE id = 'rel-yang-tong-li-yuan-killed';",
  "DELETE FROM reign_capitals WHERE reign_id IN ('reign-yang-you', 'reign-yang-hao', 'reign-yang-tong');",
  "DELETE FROM event_participants WHERE event_id = 'yang-tong-killed';",
  "DELETE FROM event_dynasties WHERE event_id = 'yang-tong-killed';",
  "DELETE FROM events WHERE id = 'yang-tong-killed';",
  "DELETE FROM reigns WHERE id = 'reign-dou-jiande-xia';",
  "",
  "-- remove stale auto-generated 史料缺 (武周期间唐行留白)",
  sqlDeleteSystemMissingReigns(["tang"], sqlStr),
  "",
  "", "-- persons", ...importPersons.map(personSql),
  "", "-- dynasty_groups", ...dynastyGroups.map(dynastyGroupSql),
  "", "-- dynasties", ...dynasties.map(dynastySql),
  "", "-- reigns", ...importReigns.map(formatReignSql),
  "", "-- reign_capitals", ...reignCapitalSql,
  "", "-- events", ...events.map(eventSql),
  "", "-- event_dynasties", ...eventDynastySql,
  "", "-- event_participants", ...eventParticipantSql,
  "", "-- relations", ...relations.map(relationSql),
  "", "COMMIT;", "",
].join("\n");

mkdirSync(__dirname, { recursive: true });
writeFileSync(path.join(__dirname, "import.sql"), sql);

const manifest = {
  slug: "sui-tang-wudai-song",
  title: "隋唐宋（含五代十国、武周）",
  window: { startYear: 581, startMonth: 1, endYear: 1279, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-13",
  counts: { persons: importPersons.length, dynasties: dynasties.length, reigns: importReigns.length, reign_capitals: reignCapitalLinks.length, events: events.length, relations: relations.length },
  sources: [
    { label: "隋朝", url: "https://zh.wikipedia.org/wiki/隋朝" },
    { label: "唐朝", url: "https://zh.wikipedia.org/wiki/唐朝" },
    { label: "五代十国", url: "https://zh.wikipedia.org/wiki/五代十国" },
    { label: "新五代史", url: "https://zh.wikisource.org/zh-hans/新五代史" },
    { label: "旧五代史", url: "https://zh.wikisource.org/zh-hans/旧五代史" },
    { label: "十国春秋", url: "https://zh.wikisource.org/zh-hans/十国春秋" },
    { label: "北宋", url: "https://zh.wikipedia.org/wiki/北宋" },
    { label: "南宋", url: "https://zh.wikipedia.org/wiki/南宋" },
    { label: "安史之乱", url: "https://zh.wikipedia.org/wiki/安史之乱" },
    { label: "靖康之变", url: "https://zh.wikipedia.org/wiki/靖康之变" },
    { label: "高梁河之战", url: "https://zh.wikipedia.org/wiki/高梁河之战" },
    { label: "宇文化及", url: "https://zh.wikipedia.org/wiki/宇文化及" },
    { label: "旧唐书·高祖本纪", url: "https://zh.wikisource.org/zh-hans/旧唐书/卷1" },
    { label: "窦建德", url: "https://zh.wikipedia.org/wiki/窦建德" },
    { label: "王世充", url: "https://zh.wikipedia.org/wiki/王世充" },
    { label: "虎牢之战", url: "https://zh.wikipedia.org/wiki/虎牢之战" },
  ],
  notes: [
    "覆盖隋（581–618）、唐（618–907）、武周（690–705）、五代十国（907–979）、北宋（960–1127）、南宋（1127–1279）。",
    "杨坚（yang-jian）复用 nanbei-chao 已有 id；后梁 id 为 liang-hou，避免与十六国后凉 liang-back 冲突。",
    "十国吴 id 为 wu-shi，避免与三国孙吴 wu 冲突；前蜀/后蜀为 shu-qian/shu-hou，避免与蜀汉 shu 冲突。",
    "十国各政权收录全部君主；五代收录全部皇帝。",
    "1279 崖山海战为南宋终结；元朝不在本包内。",
    "襄樊之战跨越1271年忽必烈改国号大元，关联南宋、蒙古帝国与元；崖山海战为1279年元军灭南宋，关联南宋与元。",
    "李显、李旦两度即位，在位拆为两段；690–705 年武周武则天，不与唐中宗重叠。",
    "隋末并行用 claim_track：杨侑在炀帝仍在位时于长安另立，杨侗也在炀帝死讯传至洛阳后另立；二人分别使用 changan/长安、luoyang/洛阳并立 track。杨浩在炀帝被弑后于江都继位，不设并立 track，留在主行；按本包取舍标记 claim_role=rival，因此卡片不镀正统金色。",
    "隋末在位记录显式关联都城：杨侑→大兴城、长安（按618年江都兵变分段），杨浩→江都，杨侗→东都洛阳。显式关联供在位详情与时间轴地图优先解析；没有关联的在位仍按王朝、时间及 claim_track 匹配。",
    "杨广于618-04-11在江都被宇文化及所弑；宇文化及随后建立许政权，命运线准确挂接至其许帝卡。",
    "补入夏（窦建德）与郑（王世充）两条隋末政权行及相应在位。夏（窦建德）使用独立 id xia-dou-jiande，避免与上古夏朝 xia 冲突。建夏起于618年11月，参据《中国大百科全书中国历史》所述武德元年十一月建国，以及《通鉴纪事本末》称夏王事在武德元年冬；十一月为史书记载的传统历月，本包按用户指定将展示时间记作618年11月。武德四年五月虎牢之战窦建德败俘；王世充于五月丙寅（公历621年6月4日）降唐；窦建德七月被斩。",
    "杨侗起始在位日按《资治通鉴》卷一八五及《资治通鉴》所记武德元年五月戊辰换算为618-06-22；《旧唐书》异记618-06-21。终点取619-05-23禅位日。",
    "南宋正统金色止于恭帝降元（1276-02）；端宗、帝昺接在恭帝之后走主线继承，但不计正统。",
    "北宋、南宋皇帝在位日取维基百科/宋史通行换算，precision=day。",
    "闽王延翰至朱文进、楚马希声/马希范在位日取维基百科条目公历换算（documentedReignDates）；马希广以后及王延政仍仅年/月。",
    "孟昶史称后主，宋追封楚王谥恭孝，posthumous_name 为恭孝王；出降取续资治通鉴乾德三年正月辛卯（965-02-23），不作卒年六月。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);

console.log(`Wrote import.sql + manifest.json: ${allPersons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations`);
