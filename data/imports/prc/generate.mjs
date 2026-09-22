#!/usr/bin/env node
/**
 * Generate EraLens import SQL for the People's Republic of China.
 * Rulers are constitutional heads of state (中央人民政府主席 / 国家主席 / 国家代主席),
 * not CCP general secretaries or paramount leaders.
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyDocumentedDatesToReigns } from "../lib/documentedReignDates.mjs";
import { sqlDeleteSystemMissingReigns } from "../lib/missingReigns.mjs";
import {
  person,
  reign,
  ym,
  eventPoint,
  eventRange,
  writeImportPackage,
  successionPairs,
  sqlStr,
} from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

function prcOffice({ id, personId, title, start, end }) {
  const [sy, sm, sd] = start;
  const [ey, em, ed] = end;
  return reign({
    id: id ?? `reign-${personId}-prc`,
    dynastyId: "prc",
    personId,
    title,
    posthumousName: null,
    templeName: null,
    start: sd != null ? { ...ym(sy, sm), day: sd } : ym(sy, sm),
    end: ed != null ? { ...ym(ey, em), day: ed } : ym(ey, em),
    precision: sd != null && ed != null ? "day" : "month",
  });
}

const persons = [
  person(
    "mao-zedong",
    "毛泽东",
    ["政治家", "军事家"],
    "1949年10月1日出任中央人民政府主席，1954年9月27日当选国家主席，至1959年4月27日不连任。其后仍任中共中央主席、中央军委主席，1976年9月9日在北京逝世。",
    "毛泽东",
    ym(1893, 12),
    ym(1976, 9),
  ),
  person(
    "liu-shaoqi",
    "刘少奇",
    ["政治家"],
    "1959年4月27日当选国家主席，1965年连任；1968年10月31日中共八届十二中全会撤销党内外职务。1969年11月12日在开封逝世。",
    "刘少奇",
    ym(1898, 11),
    ym(1969, 11),
  ),
  person(
    "dong-biwu",
    "董必武",
    ["政治家"],
    "国家副主席。1968年10月31日起与宋庆龄共同代行国家主席职权；1972年2月24日起以中华人民共和国代主席名义行使职权，至1975年1月17日四届全国人大一次会议修宪废除国家主席。",
    "董必武",
    ym(1886, 3),
    ym(1975, 4),
  ),
  person(
    "song-qingling",
    "宋庆龄",
    ["政治家"],
    "国家副主席。1968年10月31日至1972年2月24日与董必武共同代行国家主席职权。1981年5月16日被授予中华人民共和国名誉主席称号。",
    "宋庆龄",
    ym(1893, 1),
    ym(1981, 5),
  ),
  // Joint acting presidency, modeled like the shared office of 共和行政.
  person(
    "song-qingling-dong-biwu",
    "宋庆龄、董必武",
    ["政治家", "联合代行国家元首"],
    "1968年10月31日至1972年2月24日，与董必武（按联合主体记录）共同以国家副主席身份代行国家主席职权。个人资料分别保留在宋庆龄、董必武人物记录中。",
    "中华人民共和国国家元首列表",
    null,
    null,
    ["董必武、宋庆龄"],
  ),
  person(
    "npc-standing-committee",
    "全国人大常委会",
    ["机构"],
    "1975年1月17日四届全国人大一次会议修宪废除国家主席，改由全国人民代表大会常务委员会集体行使国家元首职权，至1983年6月18日六届全国人大一次会议选举李先念为国家主席。期间委员长为朱德（1975–1976）、叶剑英（1978–1983）；朱德逝世至叶剑英就任之间由宋庆龄等副委员长集体代理。",
    "全国人民代表大会常务委员会",
    null,
    null,
    ["人大常委会", "全国人民代表大会常务委员会"],
  ),
  person(
    "zhu-de",
    "朱德",
    ["军事家", "政治家"],
    "开国元帅。1975年1月17日四届全国人大一次会议当选全国人大常委会委员长，1976年7月6日在任上去世。",
    "朱德",
    ym(1886, 12),
    ym(1976, 7),
  ),
  person(
    "li-xiannian",
    "李先念",
    ["政治家"],
    "1983年6月18日六届全国人大一次会议当选国家主席，为修宪恢复国家主席后的首任，至1988年4月8日卸任。",
    "李先念",
    ym(1909, 6),
    ym(1992, 6),
  ),
  person(
    "yang-shangkun",
    "杨尚昆",
    ["政治家"],
    "1988年4月8日当选国家主席，至1993年3月27日卸任。恢复国家主席后唯一一任非中共中央政治局常委担任的国家主席。",
    "杨尚昆",
    ym(1907, 7),
    ym(1998, 9),
  ),
  person(
    "jiang-zemin",
    "江泽民",
    ["政治家"],
    "1993年3月27日当选国家主席，1998年连任，至2003年3月15日卸任。此前1989年起任中共中央总书记。",
    "江泽民",
    ym(1926, 8),
    ym(2022, 11),
  ),
  person(
    "hu-jintao",
    "胡锦涛",
    ["政治家"],
    "2003年3月15日当选国家主席，2008年连任，至2013年3月14日卸任。",
    "胡锦涛",
    ym(1942, 12),
  ),
  person(
    "xi-jinping",
    "习近平",
    ["政治家"],
    "2013年3月14日当选国家主席，其后连任。任期收录截至2026年9月。",
    "习近平",
    ym(1953, 6),
  ),
  person(
    "zhou-enlai",
    "周恩来",
    ["政治家"],
    "开国总理，长期主持国务院；1976年1月8日在北京逝世。",
    "周恩来",
    ym(1898, 3),
    ym(1976, 1),
  ),
  person(
    "deng-xiaoping",
    "邓小平",
    ["政治家"],
    "1978年十一届三中全会后成为实际最高领导人，推动改革开放；曾任中共中央军委主席，从未担任国家主席。1997年2月19日逝世。",
    "邓小平",
    ym(1904, 8),
    ym(1997, 2),
  ),
  person(
    "hua-guofeng",
    "华国锋",
    ["政治家"],
    "毛泽东逝世后任中共中央主席、中央军委主席、国务院总理；未担任国家主席。2008年8月20日逝世。",
    "华国锋",
    ym(1921, 2),
    ym(2008, 8),
  ),
  person(
    "lin-biao",
    "林彪",
    ["军事家", "政治家"],
    "元帅，九大党章曾写为接班人；1971年9月13日乘机出逃，在蒙古温都尔汗坠机身亡。",
    "林彪",
    ym(1907, 12),
    ym(1971, 9),
  ),
  person(
    "jiang-qing",
    "江青",
    ["政治家"],
    "毛泽东夫人，文化大革命中中央文革小组成员；1976年10月被捕，后以林彪、江青反革命集团案受审。",
    "江青",
    ym(1914, 3),
    ym(1991, 5),
  ),
  person(
    "peng-dehuai",
    "彭德怀",
    ["军事家"],
    "开国元帅，中国人民志愿军司令员兼政治委员，指挥抗美援朝战争。",
    "彭德怀",
    ym(1898, 10),
    ym(1974, 11),
  ),
  person(
    "ye-jianying",
    "叶剑英",
    ["军事家", "政治家"],
    "元帅。1976年10月与华国锋等粉碎「四人帮」；1978–1983年任全国人大常委会委员长。",
    "叶剑英",
    ym(1897, 4),
    ym(1986, 10),
  ),
  person(
    "hu-yaobang",
    "胡耀邦",
    ["政治家"],
    "1980年代任中共中央总书记，主持拨乱反正；1987年辞职，1989年4月15日逝世。",
    "胡耀邦",
    ym(1915, 11),
    ym(1989, 4),
  ),
  person(
    "zhao-ziyang",
    "赵紫阳",
    ["政治家"],
    "1980年代任国务院总理、中共中央总书记；1989年免职，2005年1月17日逝世。",
    "赵紫阳",
    ym(1919, 10),
    ym(2005, 1),
  ),
];

const dynasties = [
  {
    id: "prc",
    name: "中华人民共和国",
    altNames: ["新中国"],
    scope: "cn",
    region: "east_asia",
    start: ym(1949, 10),
    end: ym(2026, 9),
    precision: "month",
    note: "1949年10月1日成立。正统自起始。元首按维基百科「中华人民共和国国家元首列表」收录中央人民政府主席、国家主席、国家副主席代行、国家代主席及废除主席期间的全国人大常委会，截至2026年9月。",
  },
];

const maoLiuReigns = [
  prcOffice({
    personId: "mao-zedong",
    title: "中央人民政府主席",
    start: [1949, 10, 1],
    end: [1954, 9, 27],
  }),
  prcOffice({
    id: "reign-mao-zedong-prc-2",
    personId: "mao-zedong",
    title: "国家主席",
    start: [1954, 9, 27],
    end: [1959, 4, 27],
  }),
  prcOffice({
    personId: "liu-shaoqi",
    title: "国家主席",
    start: [1959, 4, 27],
    end: [1968, 10, 31],
  }),
];

const jointViceReigns = [
  prcOffice({
    id: "reign-song-qingling-dong-biwu-prc",
    personId: "song-qingling-dong-biwu",
    title: "国家副主席共同代行国家主席职权",
    start: [1968, 10, 31],
    end: [1972, 2, 24],
  }),
];

const actingReigns = [
  prcOffice({
    personId: "dong-biwu",
    title: "国家代主席",
    start: [1972, 2, 24],
    end: [1975, 1, 17],
  }),
];

const npcCollectiveReigns = [
  prcOffice({
    personId: "npc-standing-committee",
    title: "全国人大常委会",
    start: [1975, 1, 17],
    end: [1983, 6, 18],
  }),
];

const restoredReigns = [
  prcOffice({
    personId: "li-xiannian",
    title: "国家主席",
    start: [1983, 6, 18],
    end: [1988, 4, 8],
  }),
  prcOffice({
    personId: "yang-shangkun",
    title: "国家主席",
    start: [1988, 4, 8],
    end: [1993, 3, 27],
  }),
  prcOffice({
    personId: "jiang-zemin",
    title: "国家主席",
    start: [1993, 3, 27],
    end: [2003, 3, 15],
  }),
  prcOffice({
    personId: "hu-jintao",
    title: "国家主席",
    start: [2003, 3, 15],
    end: [2013, 3, 14],
  }),
  prcOffice({
    personId: "xi-jinping",
    title: "国家主席",
    start: [2013, 3, 14],
    end: [2026, 9],
  }),
];

const serialReignGroups = [maoLiuReigns, actingReigns, [...npcCollectiveReigns, ...restoredReigns]];
const reignGroups = [...serialReignGroups, jointViceReigns];
const reigns = applyDocumentedDatesToReigns(reignGroups.flat());

const events = [
  eventPoint({
    id: "prc-founded",
    name: "开国大典",
    kind: "politics",
    precision: "day",
    dateNote: "1949年10月1日，毛泽东在天安门城楼宣告中华人民共和国中央人民政府成立",
    at: ym(1949, 10),
    dynastyIds: ["prc", "roc"],
    participantIds: ["mao-zedong", "zhou-enlai"],
    summary: "北京举行开国大典，中华人民共和国成立，中央人民政府就职。",
  }),
  eventRange({
    id: "korean-war",
    name: "抗美援朝",
    kind: "battle",
    timeMode: "span",
    precision: "month",
    dateNote: "1950年10月志愿军入朝，至1953年7月朝鲜停战协定签字",
    start: ym(1950, 10),
    end: ym(1953, 7),
    dynastyIds: ["prc"],
    participantIds: ["mao-zedong", "zhou-enlai", "peng-dehuai"],
    summary: "中国人民志愿军入朝作战，1953年7月签订停战协定。",
  }),
  eventRange({
    id: "great-leap-forward",
    name: "大跃进",
    kind: "politics",
    timeMode: "span",
    precision: "year",
    dateNote: "1958年八大二次会议提出总路线，至1961年国民经济调整",
    start: ym(1958),
    end: ym(1961, 12),
    dynastyIds: ["prc"],
    participantIds: ["mao-zedong"],
    summary: "以钢为纲的跃进运动与人民公社化，随后出现三年困难，国民经济被迫调整。",
  }),
  eventRange({
    id: "cultural-revolution",
    name: "文化大革命",
    kind: "politics",
    timeMode: "span",
    precision: "month",
    dateNote: "1966年5月「五一六通知」至1976年10月粉碎「四人帮」",
    start: ym(1966, 5),
    end: ym(1976, 10),
    dynastyIds: ["prc"],
    participantIds: ["mao-zedong", "liu-shaoqi", "lin-biao", "jiang-qing", "zhou-enlai"],
    summary: "长达十年的政治运动，党和国家领导层与社会秩序受到严重冲击，至粉碎「四人帮」结束。",
  }),
  eventPoint({
    id: "lin-biao-incident",
    name: "九一三事件",
    kind: "politics",
    precision: "day",
    dateNote: "1971年9月13日，林彪乘机出逃，坠于蒙古温都尔汗",
    at: ym(1971, 9),
    dynastyIds: ["prc"],
    participantIds: ["lin-biao", "mao-zedong"],
    summary: "林彪乘机出逃坠亡，接班人安排破裂。",
  }),
  eventPoint({
    id: "gang-of-four-arrested",
    name: "粉碎「四人帮」",
    kind: "politics",
    precision: "day",
    dateNote: "1976年10月6日，华国锋、叶剑英等在怀仁堂拘禁江青等",
    at: ym(1976, 10),
    dynastyIds: ["prc"],
    participantIds: ["hua-guofeng", "jiang-qing", "ye-jianying"],
    summary: "江青、张春桥、姚文元、王洪文被隔离审查，文化大革命结束。",
  }),
  eventPoint({
    id: "third-plenum-1978",
    name: "十一届三中全会",
    kind: "politics",
    precision: "day",
    dateNote: "1978年12月18日至22日",
    at: ym(1978, 12),
    dynastyIds: ["prc"],
    participantIds: ["deng-xiaoping", "hua-guofeng"],
    summary: "决定把工作重点转到社会主义现代化建设，改革开放起步。",
  }),
  eventPoint({
    id: "deng-southern-tour",
    name: "邓小平南巡",
    kind: "politics",
    precision: "month",
    dateNote: "1992年1–2月视察武昌、深圳、珠海、上海",
    at: ym(1992, 1),
    dynastyIds: ["prc"],
    participantIds: ["deng-xiaoping"],
    summary: "邓小平南方谈话推动新一轮改革开放。",
  }),
  eventPoint({
    id: "hong-kong-handover",
    name: "香港回归",
    kind: "politics",
    precision: "day",
    dateNote: "1997年7月1日，中华人民共和国对香港恢复行使主权",
    at: ym(1997, 7),
    dynastyIds: ["prc"],
    participantIds: ["jiang-zemin"],
    summary: "香港特别行政区成立，英国结束对香港的管治。",
  }),
  eventPoint({
    id: "macau-handover",
    name: "澳门回归",
    kind: "politics",
    precision: "day",
    dateNote: "1999年12月20日，中华人民共和国对澳门恢复行使主权",
    at: ym(1999, 12),
    dynastyIds: ["prc"],
    participantIds: ["jiang-zemin"],
    summary: "澳门特别行政区成立，葡萄牙结束对澳门的管治。",
  }),
  eventPoint({
    id: "china-joins-wto",
    name: "加入世界贸易组织",
    kind: "politics",
    precision: "day",
    dateNote: "2001年12月11日正式成为世界贸易组织成员",
    at: ym(2001, 12),
    dynastyIds: ["prc"],
    participantIds: ["jiang-zemin"],
    summary: "中国加入世界贸易组织，对外开放进入新阶段。",
  }),
  eventPoint({
    id: "beijing-olympics-2008",
    name: "北京奥运会",
    kind: "culture",
    precision: "month",
    dateNote: "2008年8月8日至24日",
    at: ym(2008, 8),
    dynastyIds: ["prc"],
    participantIds: ["hu-jintao"],
    summary: "第二十九届夏季奥林匹克运动会在北京举行。",
  }),
  eventPoint({
    id: "eighteenth-party-congress",
    name: "中共十八大",
    kind: "politics",
    precision: "month",
    dateNote: "2012年11月8日至14日，15日十八届一中全会选举习近平为总书记",
    at: ym(2012, 11),
    dynastyIds: ["prc"],
    participantIds: ["hu-jintao", "xi-jinping"],
    summary: "胡锦涛卸任总书记，习近平当选中共中央总书记、中央军委主席。国家主席至2013年3月交接。",
  }),
];

const supplementalEventDynasties = [
  { eventId: "civil-war", dynastyId: "prc" },
];

const relations = [];
for (const group of serialReignGroups) {
  for (const [fromId, toId] of successionPairs(group)) {
    if (fromId === toId) continue;
    relations.push({
      id: `rel-${fromId}-${toId}-succession`,
      fromRef: `person:${fromId}`,
      toRef: `person:${toId}`,
      kind: "succession",
    });
  }
}

const staleReignIds = [
  "reign-hua-guofeng-prc",
  "reign-deng-xiaoping-prc",
  "reign-song-qingling-prc",
  "reign-dong-biwu-prc-vice",
];
const staleRelationIds = [
  "rel-mao-zedong-hua-guofeng-succession",
  "rel-hua-guofeng-deng-xiaoping-succession",
  "rel-deng-xiaoping-jiang-zemin-succession",
];

const manifest = {
  slug: "prc",
  title: "中华人民共和国",
  window: { startYear: 1949, startMonth: 10, endYear: 2026, endMonth: 9 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-19",
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
    events: events.length,
    relations: relations.length,
    supplementalEventDynastyLinks: supplementalEventDynasties.length,
  },
  sources: [
    { label: "中华人民共和国国家元首列表", url: "https://zh.wikipedia.org/wiki/中华人民共和国国家元首列表" },
    { label: "中华人民共和国主席", url: "https://zh.wikipedia.org/wiki/中华人民共和国主席" },
    { label: "全国人民代表大会常务委员会", url: "https://zh.wikipedia.org/wiki/全国人民代表大会常务委员会" },
    { label: "中华人民共和国", url: "https://zh.wikipedia.org/wiki/中华人民共和国" },
    { label: "中华人民共和国历史", url: "https://zh.wikipedia.org/wiki/中华人民共和国历史" },
    { label: "抗美援朝", url: "https://zh.wikipedia.org/wiki/抗美援朝" },
    { label: "文化大革命", url: "https://zh.wikipedia.org/wiki/文化大革命" },
    { label: "中国共产党第十一届中央委员会第三次全体会议", url: "https://zh.wikipedia.org/wiki/中国共产党第十一届中央委员会第三次全体会议" },
  ],
  notes: [
    "覆盖中华人民共和国（1949-10–2026-09），单行 prc 王朝。正统自开国日起算；民国金色已截于 1949-09。",
    "主线按维基百科「中华人民共和国国家元首列表」：中央人民政府主席、国家主席、国家副主席代行、国家代主席、废除主席期间的全国人大常委会。中共中央总书记、中央军委主席不建 reign。邓小平从未任国家主席，只作 person。",
    "毛泽东分两段：1949-10-01 中央人民政府主席至 1954-09-27；同日当选国家主席至 1959-04-27。宪法改职称，比照民国国民政府主席/总统分卡。刘少奇 1959-04-27 至 1968-10-31。",
    "1968-10-31 至 1972-02-24 宋庆龄、董必武以国家副主席共同代行主席职权，合并为一个联合主体卡片；两人的独立人物记录仍保留。董必武 1972-02-24 起以国家代主席名义行职权，至 1975-01-17。",
    "1975-01-17 至 1983-06-18 宪法不设国家主席，全国人大常委会集体行使元首职权，建机构卡；委员长朱德、叶剑英不另建主席卡。宋庆龄名誉主席（1981）为荣誉称号，不建 reign。",
    "李先念 1983-06-18 复设后首任，杨尚昆、江泽民、胡锦涛、习近平接任。连任不拆卡。习近平任期收录截至 2026-09。",
    "华国锋、胡耀邦、赵紫阳只建 persons。国民政府迁台并非投降、禅让或被俘，不画跨朝命运线。国共内战事件 civil-war 补挂 prc。",
  ],
};

writeImportPackage(__dirname, {
  slug: "prc",
  window: manifest.window,
  persons,
  dynasties,
  reignGroups,
  reigns,
  events,
  relations,
  supplementalEventDynasties,
  preSql: [
    sqlDeleteSystemMissingReigns(["prc"], sqlStr),
    `DELETE FROM reigns WHERE id IN (${staleReignIds.map(sqlStr).join(", ")});`,
    `DELETE FROM relations WHERE id IN (${staleRelationIds.map(sqlStr).join(", ")});`,
  ].filter(Boolean).join("\n"),
  manifest,
});
