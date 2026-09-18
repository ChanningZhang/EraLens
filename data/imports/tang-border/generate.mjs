#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Tang-era border states (618–842 / -37–668).
 * 吐蕃、吐谷浑、高句丽、回鹘
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  ym,
  person,
  dr,
  eventPoint,
  successionPairs,
  nextColor,
  writeImportPackage,
} from "../lib/sqlHelpers.mjs";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// ── persons ────────────────────────────────────────────────────────────────

const tuboPersons = [
  person("namri-songtsen", "南日松赞", ["君主"], "吐蕃赞普，松赞干布之父，统一各部，奠定吐蕃帝国基础。", "南日松赞"),
  person("songtsen-gampo", "松赞干布", ["君主"], "吐蕃赞普，创制藏文，迎娶文成公主，与唐和亲。", "松赞干布"),
  person("mangsong-mangtsen", "芒松芒赞", ["君主"], "吐蕃赞普，松赞干布之孙，幼年即位。", "芒松芒赞"),
  person("dusong-mangje", "杜松芒赞", ["君主"], "吐蕃赞普，亦称赤都松赞、杜松芒波杰。", "杜松芒赞"),
  person("tri-detsug-nyima", "赤德祖赞", ["君主"], "吐蕃赞普，亦称弃隶缩赞，与唐长期对峙。", "赤德祖赞"),
  person("tri-song-detsen", "赤松德赞", ["君主"], "吐蕃赞普，崇佛，与唐会盟，帝国鼎盛期君主。", "赤松德赞"),
  person("mu-ne-btsan", "穆尼赞普", ["君主"], "吐蕃赞普，亦称木奈赞普，在位极短。", "穆尼赞普"),
  person("tri-desong-btsan", "赤德松赞", ["君主"], "吐蕃赞普，穆尼赞普之弟，继续推行佛教。", "赤德松赞"),
  person("tri-tsug-lde-btsan", "赤祖德赞", ["君主"], "吐蕃赞普，年号彝泰，吐蕃晚期重要君主。", "赤祖德赞"),
  person("lang-darma", "朗达玛", ["君主"], "吐蕃末代赞普，禁佛，842年被杀，帝国分裂。", "朗达玛"),
];

const tuyuhunPersons = [
  person("murong-tuyuhun", "慕容吐谷浑", ["君主"], "吐谷浑奠基者，率部西迁，建立政权。", "慕容吐谷浑"),
  person("tuyan", "吐延", ["君主"], "慕容吐谷浑长子，继守青海。", "吐延"),
  person("yeyan", "叶延", ["君主"], "329年确立吐谷浑国号，以父名为氏。", "叶延"),
  person("suixi", "碎奚", ["君主"], "吐谷浑王，向前秦称臣。", "碎奚"),
  person("shilian", "视连", ["君主"], "白兰王，臣服西秦。", "视连"),
  person("shipi", "视罴", ["君主"], "吐谷浑王，继续据守青海。", "视罴"),
  person("wuheti", "乌纥提", ["君主"], "大单于，吐谷浑中期君主。", "乌纥提"),
  person("shulogan", "树洛干", ["君主"], "戊寅可汗，武王，吐谷浑重要君主。", "树洛干"),
  person("achen", "阿豺", ["君主"], "白兰王威王，吐谷浑名臣型君主。", "阿豺"),
  person("mugui", "慕璝", ["君主"], "惠王陇西王，吐谷浑势力扩张。", "慕璝"),
  person("muliyan", "慕利延", ["君主"], "河南王，慕璝之弟。", "慕利延"),
  person("shiyin", "拾寅", ["君主"], "河南王西平王，与北魏交涉频繁。", "拾寅"),
  person("duyihou", "度易侯", ["君主"], "河南王，吐谷浑中期君主。", "度易侯"),
  person("fulianchou", "伏连筹", ["君主"], "吐谷浑可汗，在位五十年。", "伏连筹"),
  person("kuailv", "夸吕", ["君主"], "吐谷浑可汗，与隋、唐往来。", "夸吕"),
  person("shifu", "世伏", ["君主"], "吐谷浑可汗，夸吕之子。", "世伏"),
  person("fuyun", "伏允", ["君主"], "步萨钵可汗，与唐、吐蕃长期角力，635年被杀。", "伏允"),
  person("murong-shun", "慕容顺", ["君主"], "甘豆可汗，伏允之子，唐册封西平郡王。", "慕容顺"),
  person("nuohabo", "慕容诺曷钵", ["君主"], "勤豆可汗，吐谷浑末代可汗，663年亡国投唐。", "慕容诺曷钵"),
];

const gaogouliPersons = [
  person("gao-zhumeng", "高朱蒙", ["君主"], "东明圣王，高句丽开国君主，朱蒙。", "朱蒙"),
  person("liuli-ming-wang", "琉璃明王", ["君主"], "高句丽第二代君主，名类利、孺留，东明圣王之子。", "琉璃明王"),
  person("daewuseong", "大武神王", ["君主"], "高句丽君主，名无恤，扩张辽东。", "大武神王"),
  person("minzhong-wang", "闵中王", ["君主"], "高句丽君主，名解色朱，大武神王之弟，太子年幼时被推举继位。", "閔中王"),
  person("muben-wang", "慕本王", ["君主"], "高句丽君主，名解忧，大武神王之子，被侍从杜鲁刺杀。", "慕本王"),
  person("taizu-wang", "太祖王", ["君主"], "高句丽太祖王，名宫，长期在位，国势渐强。", "太祖王"),
  person("cida-wang", "次大王", ["君主"], "高句丽君主，名遂成，太祖王之嗣。", "次大王"),
  person("xingda-wang", "新大王", ["君主"], "高句丽君主，名伯固，新大王时期。", "新大王"),
  person("guguo-chuan-wang", "故国川王", ["君主"], "高句丽君主，名男武，迁都国内城。", "故国川王"),
  person("shanshang-wang", "山上王", ["君主"], "高句丽君主，名延优，山上王时期。", "山上王"),
  person("dongchuan-wang", "东川王", ["君主"], "高句丽君主，名忧位居，东川王时期。", "东川王"),
  person("zhongchuan-wang", "中川王", ["君主"], "高句丽君主，名然弗，东川王之子。", "中川王"),
  person("xichuan-wang", "西川王", ["君主"], "高句丽君主，名药卢，中川王之子。", "西川王"),
  person("fengshang-wang", "烽上王", ["君主"], "高句丽君主，名相夫，为大臣所废后自杀。", "烽上王"),
  person("meichuan-wang", "美川王", ["君主"], "好壤王，名乙弗，高句丽重要君主。", "美川王"),
  person("guguo-yuan-wang", "故国原王", ["君主"], "高句丽君主，名斯由，故国原王时期。", "故国原王"),
  person("xiaoshoulin-wang", "小兽林王", ["君主"], "高句丽君主，名丘夫，迁都平壤前夕。", "小兽林王"),
  person("guguo-rang-wang", "故国壤王", ["君主"], "高句丽君主，名伊连，小兽林王之弟、好太王之父。", "故国壤王"),
  person("guangkaitu-wang", "广开土王", ["君主"], "高句丽鼎盛君主，名谈德，扩张辽东与半岛。", "广开土王"),
  person("changsheng-wang", "长寿王", ["君主"], "高句丽君主，名巨连，长期在位，国势稳定。", "长寿王"),
  person("wenzhi-wang", "文咨王", ["君主"], "文惠王，名罗云，高句丽文咨王时期。", "文咨王"),
  person("ancang-wang", "安藏王", ["君主"], "高句丽君主，名兴安，文咨王之子。", "安藏王"),
  person("anyuan-wang", "安原王", ["君主"], "高句丽君主，名宝延，安藏王之弟。", "安原王"),
  person("yangyuan-wang", "阳原王", ["君主"], "高句丽君主，名平成，安原王长子。", "阳原王"),
  person("pingyuan-wang", "平原王", ["君主"], "高句丽平原王，名阳成。", "平原王"),
  person("yingyang-wang", "婴阳王", ["君主"], "高句丽婴阳王，名元，与隋、唐对峙。", "婴阳王"),
  person("rongliu-wang", "荣留王", ["君主"], "高句丽荣留王，名建武，唐初君主。", "荣留王"),
  person("baozang-wang", "宝藏王", ["君主"], "高句丽末代君主，名宝藏，668年亡于唐。", "宝藏王"),
];

const huihuPersons = [
  person("guli-peiluo", "骨力裴罗", ["可汗", "君主"], "药罗葛氏，744年统一漠北，唐封怀仁可汗。", "骨力裴罗"),
  person("mo-yanchuo", "磨延啜", ["可汗", "君主"], "骨力裴罗之子，唐封英武可汗。", "磨延啜"),
  person("ya-yanchuo", "移地健", ["可汗", "君主"], "药罗葛氏，磨延啜次子，唐封英义可汗，后世常称牟羽可汗，引入摩尼教为国教。", "牟羽可汗"),
  person("huairen-kehan", "顿莫贺达干", ["可汗", "君主"], "杀移地健自立，唐封长寿天亲可汗。", "顿莫贺达干"),
  person("fengcheng-kehan", "多逻斯", ["可汗", "君主"], "顿莫贺达干之子，唐封忠贞可汗，在位仅一年。", "忠贞可汗"),
  person("jieyu-jiasi", "阿啜", ["可汗", "君主"], "多逻斯之弟，唐封奉诚可汗。", "奉诚可汗"),
  person("huaixin-kehan", "骨咄禄", ["可汗", "君主"], "阿跌氏，唐封怀信可汗，阿啜之后继统。", "怀信可汗"),
  person("fengyi-kehan", "滕里", ["可汗", "君主"], "本名失载，怀信可汗之后，唐封滕里可汗。", "滕里可汗"),
  person("anyuan-kehan", "保义", ["可汗", "君主"], "本名失载，硖跌氏，怀信可汗庶长子，唐封保义可汗。", "保义可汗"),
  person("zhongzhen-kehan", "崇德", ["可汗", "君主"], "本名失载，唐封崇德可汗。", "崇德可汗"),
  person("zhongjing-kehan", "曷萨特勤", ["可汗", "君主"], "硖跌氏，崇德可汗之弟，唐封昭礼可汗。", "昭礼可汗"),
  person("aidengli-kehan", "胡特勤", ["可汗", "君主"], "昭礼可汗从子，唐封彰信可汗。", "彰信可汗"),
  person("kasa-kehan", "葛萨", ["可汗", "君主"], "亦称㕎馺特勤，篡位，唐封㕎馺可汗，840年牙帐陷落时被杀。", "㕎馺可汗"),
  person("wujie-kehan", "乌希特勤", ["可汗", "君主"], "亦称乌介特勤，840年南逃，唐封乌介可汗，846年被杀。", "乌介可汗"),
  person("enzhen-kehan", "遏捻特勤", ["可汗", "君主"], "唐封遏捻可汗，846—848年在位，回鹘南迁时期末代可汗。", "遏捻可汗"),
];

const persons = [...tuboPersons, ...tuyuhunPersons, ...gaogouliPersons, ...huihuPersons];

// ── dynasties ────────────────────────────────────────────────────────────────

const dynasties = [
  {
    id: "tubo",
    name: "吐蕃",
    altNames: ["吐番", "大蕃"],
    scope: "cn",
    region: "east_asia",
    start: ym(618),
    end: ym(842),
    precision: "year",
    colorToken: nextColor(),
    note: "618年南日松赞统一青藏高原诸部；842年朗达玛被杀，帝国分裂。",
  },
  {
    id: "tuyuhun",
    name: "吐谷浑",
    altNames: ["吐谷浑汗国", "白兰"],
    scope: "cn",
    region: "east_asia",
    start: ym(329),
    end: ym(663),
    precision: "year",
    colorToken: nextColor(),
    note: "329年叶延确立国号；663年吐蕃灭之，诺曷钵投唐。",
  },
  {
    id: "gaogouli",
    name: "高句丽",
    altNames: ["高句骊", "高丽"],
    scope: "cn",
    region: "east_asia",
    start: ym(-37),
    end: ym(668),
    precision: "year",
    colorToken: nextColor(),
    note: "前37年朱蒙建国；668年唐将薛仁贵等灭之，宝藏王被俘。",
  },
  {
    id: "huihu",
    name: "回鹘",
    altNames: ["回纥", "回纥汗国"],
    scope: "cn",
    region: "east_asia",
    start: ym(744),
    end: ym(840),
    precision: "year",
    colorToken: nextColor(),
    note: "744年骨力裴罗建国；840年黠戛斯攻破牙帐，㕎馺可汗被杀，漠北汗国终结。",
  },
];

// ── reigns ───────────────────────────────────────────────────────────────────

const tuboReigns = [
  dr("tubo", "namri-songtsen", "赞普", null, null, 618, 629),
  dr("tubo", "songtsen-gampo", "赞普", null, null, 629, 650),
  dr("tubo", "mangsong-mangtsen", "赞普", null, null, 650, 676),
  dr("tubo", "dusong-mangje", "赞普", null, null, 676, 704),
  dr("tubo", "tri-detsug-nyima", "赞普", null, null, 704, 755),
  dr("tubo", "tri-song-detsen", "赞普", null, null, 755, 797),
  dr("tubo", "mu-ne-btsan", "赞普", null, null, 797, 798),
  dr("tubo", "tri-desong-btsan", "赞普", null, null, 798, 815),
  dr("tubo", "tri-tsug-lde-btsan", "赞普", null, null, 815, 838),
  dr("tubo", "lang-darma", "赞普", null, null, 838, 842),
];

const tuyuhunReigns = [
  dr("tuyuhun", "murong-tuyuhun", "河南王", null, null, 285, 317),
  dr("tuyuhun", "tuyan", "河南王", null, null, 317, 329),
  dr("tuyuhun", "yeyan", "吐谷浑王", null, null, 329, 351),
  dr("tuyuhun", "suixi", "吐谷浑王", null, null, 351, 371),
  dr("tuyuhun", "shilian", "白兰王", null, null, 371, 390),
  dr("tuyuhun", "shipi", "吐谷浑王", null, null, 390, 400),
  dr("tuyuhun", "wuheti", "大单于", null, null, 400, 405),
  dr("tuyuhun", "shulogan", "戊寅可汗", "武王", null, 405, 417),
  dr("tuyuhun", "achen", "白兰王", "威王", null, 417, 424),
  dr("tuyuhun", "mugui", "惠王", "陇西王", null, 424, 436),
  dr("tuyuhun", "muliyan", "河南王", null, null, 436, 452),
  dr("tuyuhun", "shiyin", "河南王", "西平王", null, 452, 481),
  dr("tuyuhun", "duyihou", "河南王", null, null, 481, 490),
  dr("tuyuhun", "fulianchou", "可汗", null, null, 490, 540),
  dr("tuyuhun", "kuailv", "可汗", null, null, 540, 591),
  dr("tuyuhun", "shifu", "可汗", null, null, 591, 597),
  dr("tuyuhun", "fuyun", "步萨钵可汗", null, null, 597, 635),
  dr("tuyuhun", "murong-shun", "甘豆可汗", null, null, 635, 635),
  dr("tuyuhun", "nuohabo", "勤豆可汗", "河源郡王", null, 635, 663),
];

const gaogouliReigns = [
  dr("gaogouli", "gao-zhumeng", "东明圣王", null, null, -37, -19),
  dr("gaogouli", "liuli-ming-wang", "琉璃明王", null, null, -19, 18),
  dr("gaogouli", "daewuseong", "大武神王", null, null, 18, 44),
  dr("gaogouli", "minzhong-wang", "闵中王", null, null, 44, 48),
  dr("gaogouli", "muben-wang", "慕本王", null, null, 48, 53),
  dr("gaogouli", "taizu-wang", "太祖王", null, null, 53, 146),
  dr("gaogouli", "cida-wang", "次大王", null, null, 146, 165),
  dr("gaogouli", "xingda-wang", "新大王", null, null, 165, 179),
  dr("gaogouli", "guguo-chuan-wang", "故国川王", null, null, 179, 197),
  dr("gaogouli", "shanshang-wang", "山上王", null, null, 197, 227),
  dr("gaogouli", "dongchuan-wang", "东川王", null, null, 227, 248),
  dr("gaogouli", "zhongchuan-wang", "中川王", null, null, 248, 270),
  dr("gaogouli", "xichuan-wang", "西川王", null, null, 270, 292),
  dr("gaogouli", "fengshang-wang", "烽上王", null, null, 292, 300),
  dr("gaogouli", "meichuan-wang", "美川王", null, null, 300, 331),
  dr("gaogouli", "guguo-yuan-wang", "故国原王", null, null, 331, 371),
  dr("gaogouli", "xiaoshoulin-wang", "小兽林王", null, null, 371, 384),
  dr("gaogouli", "guguo-rang-wang", "故国壤王", null, null, 384, 391),
  dr("gaogouli", "guangkaitu-wang", "广开土王", null, null, 391, 412),
  dr("gaogouli", "changsheng-wang", "长寿王", null, null, 412, 491),
  dr("gaogouli", "wenzhi-wang", "文咨王", null, null, 491, 519),
  dr("gaogouli", "ancang-wang", "安藏王", null, null, 519, 531),
  dr("gaogouli", "anyuan-wang", "安原王", null, null, 531, 545),
  dr("gaogouli", "yangyuan-wang", "阳原王", null, null, 545, 559),
  dr("gaogouli", "pingyuan-wang", "平原王", null, null, 559, 590),
  dr("gaogouli", "yingyang-wang", "婴阳王", null, null, 590, 618),
  dr("gaogouli", "rongliu-wang", "荣留王", null, null, 618, 642),
  dr("gaogouli", "baozang-wang", "宝藏王", null, null, 642, 668),
];

const huihuReigns = [
  dr("huihu", "guli-peiluo", "怀仁可汗", null, null, 744, 747),
  dr("huihu", "mo-yanchuo", "英武可汗", null, null, 747, 759),
  dr("huihu", "ya-yanchuo", "英义可汗", null, null, 759, 780),
  dr("huihu", "huairen-kehan", "长寿天亲可汗", null, null, 780, 789),
  dr("huihu", "fengcheng-kehan", "忠贞可汗", null, null, 789, 790),
  dr("huihu", "jieyu-jiasi", "奉诚可汗", null, null, 790, 795),
  dr("huihu", "huaixin-kehan", "怀信可汗", null, null, 795, 805),
  dr("huihu", "fengyi-kehan", "滕里可汗", null, null, 805, 808),
  dr("huihu", "anyuan-kehan", "保义可汗", null, null, 808, 821),
  dr("huihu", "zhongzhen-kehan", "崇德可汗", null, null, 821, 824),
  dr("huihu", "zhongjing-kehan", "昭礼可汗", null, null, 824, 832),
  dr("huihu", "aidengli-kehan", "彰信可汗", null, null, 832, 839),
  dr("huihu", "kasa-kehan", "㕎馺可汗", null, null, 839, 840),
];

const reignGroups = [tuboReigns, tuyuhunReigns, gaogouliReigns, huihuReigns];
const reigns = applyDocumentedDatesToReigns(reignGroups.flat());

// ── events ───────────────────────────────────────────────────────────────────

const events = [
  eventPoint({
    id: "tubo-founded",
    name: "吐蕃建国",
    kind: "politics",
    at: ym(618),
    dynastyIds: ["tubo"],
    participantIds: ["namri-songtsen"],
    summary: "南日松赞统一青藏高原诸部，吐蕃帝国肇始。",
  }),
  eventPoint({
    id: "gaogouli-destroyed-tang",
    name: "唐灭高句丽",
    kind: "battle",
    dateNote: "668年，唐将薛仁贵等攻灭高句丽",
    at: ym(668),
    dynastyIds: ["gaogouli", "tang"],
    participantIds: ["baozang-wang"],
    summary: "唐军攻灭高句丽，宝藏王被俘，高句丽亡国。",
  }),
  eventPoint({
    id: "huihu-destroyed",
    name: "回鹘灭亡",
    kind: "politics",
    dateNote: "840年，黠戛斯攻灭回鹘",
    at: ym(840),
    dynastyIds: ["huihu"],
    participantIds: ["kasa-kehan", "wujie-kehan"],
    summary: "黠戛斯攻破回鹘牙帐，㕎馺可汗被杀；乌介可汗南逃，漠北回鹘汗国终结。",
  }),
  eventPoint({
    id: "tuyuhun-destroyed",
    name: "吐谷浑灭亡",
    kind: "politics",
    dateNote: "663年，吐蕃占吐谷浑全境",
    at: ym(663),
    dynastyIds: ["tuyuhun", "tubo"],
    participantIds: ["nuohabo"],
    summary: "吐蕃大举入侵，诺曷钵率部投唐，吐谷浑汗国灭亡。",
  }),
];

// ── relations ────────────────────────────────────────────────────────────────

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
  { id: "rel-tubo-founded", fromRef: "event:tubo-founded", toRef: "dynasty:tubo", kind: "other" },
  { id: "rel-gaogouli-destroyed", fromRef: "event:gaogouli-destroyed-tang", toRef: "dynasty:gaogouli", kind: "battle" },
  { id: "rel-huihu-destroyed", fromRef: "event:huihu-destroyed", toRef: "dynasty:huihu", kind: "other" },
  { id: "rel-tuyuhun-destroyed", fromRef: "event:tuyuhun-destroyed", toRef: "dynasty:tuyuhun", kind: "battle" },
);

// ── output ───────────────────────────────────────────────────────────────────

const manifest = {
  slug: "tang-border",
  title: "唐代边陲政权（吐蕃·吐谷浑·高句丽·回鹘）",
  window: { startYear: -37, startMonth: 1, endYear: 842, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-18",
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
  },
  sources: [
    { label: "吐蕃", url: "https://zh.wikipedia.org/wiki/%E5%90%90%E8%95%83" },
    { label: "吐蕃君主列表", url: "https://zh.wikipedia.org/zh-cn/%E5%90%90%E8%95%83%E5%90%9B%E4%B8%BB%E5%88%97%E8%A1%A8" },
    { label: "吐谷浑", url: "https://zh.wikipedia.org/wiki/%E5%90%90%E8%B0%B7%E6%B5%91" },
    { label: "吐谷浑首领列表", url: "https://zh.wikipedia.org/wiki/%E5%90%90%E8%B0%B7%E6%B5%91%E9%A6%96%E9%A2%86%E5%88%97%E8%A1%A8" },
    { label: "高句丽君主列表", url: "https://zh.wikipedia.org/wiki/%E9%AB%98%E5%8F%A5%E4%B8%BD%E5%90%9B%E4%B8%BB%E5%88%97%E8%A1%A8" },
    { label: "回鹘", url: "https://zh.wikipedia.org/wiki/%E5%9B%9E%E9%B9%81" },
    { label: "回鹘可汗列表", url: "https://zh.wikipedia.org/wiki/%E5%9B%9E%E9%B9%98%E5%8F%AF%E6%B1%97%E5%88%97%E8%A1%A8" },
    { label: "唐灭高句丽", url: "https://zh.wikipedia.org/wiki/%E9%AB%98%E5%8F%A5%E4%B8%BD" },
  ],
  notes: [
    "吐蕃在位年取维基百科帝国时期标准列表（618–842），含南日松赞至朗达玛。",
    "吐谷浑含慕容吐谷浑至诺曷钵完整首领序列；王朝窗口取329–663。",
    "高句丽取维基百科君主列表28王（东明圣王至宝藏王）；故国川王以前年代有争议，precision=year，在位年依三国史记/维基列表。报德王（安胜，670–683）为亡国后新罗境内残部，不入高句丽王朝行。",
    "回鹘可汗序列据维基百科回鹘可汗列表（744–840）；人物名用本名，在位 title 用唐封称号，尊号不入人物名。",
    "唐（tang）复用 sui-tang-wudai-song 已有 id，本包仅关联 event_dynasties。",
  ],
};

const preSql = [
  "DELETE FROM relations WHERE id IN (",
  "  'rel-gao-zhumeng-daewuseong-succession',",
  "  'rel-daewuseong-taizu-wang-succession',",
  "  'rel-dongchuan-wang-meichuan-wang-succession',",
  "  'rel-xiaoshoulin-wang-guangkaitu-wang-succession',",
  "  'rel-wenzhi-wang-pingyuan-wang-succession'",
  ");",
].join("\n");

writeImportPackage(__dirname, {
  slug: "tang-border",
  window: { startYear: -37, startMonth: 1, endYear: 842, endMonth: 12 },
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  preSql,
  manifest,
});
