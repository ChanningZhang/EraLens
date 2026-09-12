#!/usr/bin/env node
/**
 * Generate EraLens import SQL for Spring-Autumn & Warring States feudal states.
 * AbsMonth must match packages/shared/src/time.ts
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

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
    start,
    end,
    startAbs: start.abs,
    endAbs: end.abs,
    precision,
  };
}

function dynastyReign(dynastyId, personId, title, posthumous, startYear, endYear, preferred = null) {
  const pref =
    preferred ??
    (posthumous ? { kind: "posthumous", name: title } : { kind: "regnal", name: title });
  return reign({
    id: `reign-${personId}-${dynastyId}`,
    dynastyId,
    personId,
    title,
    posthumousName: posthumous,
    templeName: null,
    preferred: pref,
    start: ym(startYear),
    end: ym(endYear, 12),
  });
}

function person(id, name, roles, bio, wikiTitle, birth = null, death = null) {
  return { id, name, roles, bio, links: wiki(wikiTitle), birth, death };
}

function eventPoint({ id, name, kind, at, precision = "year", dateNote, dynastyIds = [], participantIds = [], summary }) {
  return {
    id,
    name,
    kind,
    timeMode: "point",
    precision,
    dateNote,
    at,
    atAbs: at.abs,
    dynastyIds,
    participantIds,
    summary,
  };
}

// ── persons (new; jiang-xiaobai, ji-chonger, lv-shang, ying-zheng, kong-qiu already in DB) ──

const persons = [
  person("xiong-zhuang", "熊侣", ["君主"], "楚庄王，春秋五霸之一，问鼎中原。", "楚庄王"),
  person("ying-quliang", "嬴渠梁", ["君主"], "秦孝公，任用商鞅变法，秦国由弱转强。", "秦孝公"),
  person("ying-qi", "嬴开", ["君主"], "秦襄公，护送周平王东迁，秦国始列为诸侯。", "秦襄公"),
  person("gou-jian", "勾践", ["君主"], "越国君主，卧薪尝胆，终灭吴国。", "勾践"),
  person("fu-chai", "夫差", ["君主"], "吴王夫差，破越后骄纵，终为勾践所灭。", "夫差"),
  person("wei-wen", "魏文侯", ["君主"], "魏国开国君主，任用李悝、吴起，战国初强。", "魏文侯"),
  person("han-jing", "韩景侯", ["君主"], "韩国开国君主，前403年周天子正式册命。", "韩景侯"),
  person("zhao-lie", "赵烈侯", ["君主"], "赵国开国君主，与韩魏同受周室册命。", "赵烈侯"),
  person("shang-yang", "商鞅", ["政治家"], "卫国人，秦孝公时主持变法，奠定秦统一基础。", "商鞅"),
  person("wu-qi", "吴起", ["军事家", "政治家"], "魏文侯时名将，后在楚主持变法。", "吴起"),
  person("sun-wu", "孙武", ["军事家"], "齐国军事家，著《孙子兵法》，传为吴王阖闾将。", "孙武"),
];

// ── dynasties (feudal states; id suffix avoids later homonymous dynasties) ──

const colorTokens = ["ochre", "indigo", "moss", "mineral", "cinnabar", "stone", "grape", "wisteria"];
let colorIdx = 0;
function nextColor() {
  return colorTokens[colorIdx++ % colorTokens.length];
}

const dynasties = [
  {
    id: "qi-chunqiu",
    name: "齐国",
    altNames: ["齐", "姜齐", "田齐"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1046),
    end: ym(-221, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "周武王封姜太公于齐；前386年田氏代齐；前221年秦灭齐。",
  },
  {
    id: "jin-chunqiu",
    name: "晋国",
    altNames: ["晋"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1033),
    end: ym(-376, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "周成王封叔虞于唐，改国号晋；前403年三家分晋，公室至前376年废。",
  },
  {
    id: "chu-chunqiu",
    name: "楚国",
    altNames: ["楚", "荆楚"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1042),
    end: ym(-223, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "周成王封熊绎于楚；春秋战国南方大国，前223年秦灭楚。",
  },
  {
    id: "yan-chunqiu",
    name: "燕国",
    altNames: ["燕"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1044),
    end: ym(-222, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "周武王封召公奭于燕；战国七雄之一，前222年秦灭燕。",
  },
  {
    id: "song-chunqiu",
    name: "宋国",
    altNames: ["宋"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1034),
    end: ym(-286, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "周成王封微子启于宋；前286年齐湣王灭宋。",
  },
  {
    id: "lu-chunqiu",
    name: "鲁国",
    altNames: ["鲁"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1042),
    end: ym(-256, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "周武王封周公旦于鲁；孔子故乡，前256年楚灭鲁。",
  },
  {
    id: "wei-weiguo",
    name: "卫国",
    altNames: ["卫"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1038),
    end: ym(-209, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "周成王封康叔封于卫；小国久存，秦二世时废。",
  },
  {
    id: "zheng-chunqiu",
    name: "郑国",
    altNames: ["郑"],
    scope: "cn",
    region: "east_asia",
    start: ym(-806),
    end: ym(-375, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "周厉王少子友封于郑，后东迁新郑；前375年韩灭郑。",
  },
  {
    id: "cao-chunqiu",
    name: "曹国",
    altNames: ["曹"],
    scope: "cn",
    region: "east_asia",
    start: ym(-1046),
    end: ym(-487, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "周武王封弟振铎于曹；前487年宋灭曹。",
  },
  {
    id: "wu-chunqiu",
    name: "吴国",
    altNames: ["吴"],
    scope: "cn",
    region: "east_asia",
    start: ym(-585),
    end: ym(-473, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "春秋东南强国，阖闾、夫差时盛；前473年越灭吴。",
  },
  {
    id: "yue-chunqiu",
    name: "越国",
    altNames: ["越"],
    scope: "cn",
    region: "east_asia",
    start: ym(-600),
    end: ym(-334, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "东南古国，勾践灭吴后北进；前334年楚败越，国势衰微。",
  },
  {
    id: "zhongshan",
    name: "中山",
    altNames: ["中山国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-476),
    end: ym(-296, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "鲜虞白狄所建，战国中小国；前296年赵灭中山。",
  },
  {
    id: "han-warring",
    name: "韩国",
    altNames: ["韩"],
    scope: "cn",
    region: "east_asia",
    start: ym(-403),
    end: ym(-230, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "三家分晋后韩氏立国，前403年周天子册命；前230年秦灭韩。",
  },
  {
    id: "zhao-warring",
    name: "赵国",
    altNames: ["赵"],
    scope: "cn",
    region: "east_asia",
    start: ym(-403),
    end: ym(-222, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "三家分晋后赵氏立国；前222年秦灭赵。",
  },
  {
    id: "wei-warring",
    name: "魏国",
    altNames: ["魏", "梁"],
    scope: "cn",
    region: "east_asia",
    start: ym(-403),
    end: ym(-225, 12),
    precision: "year",
    colorToken: nextColor(),
    note: "三家分晋后魏氏立国，都大梁；前225年秦灭魏。与三国曹魏 wei 区分。",
  },
  // Upsert qin: extend feudal-state span back to秦襄公，统一帝国段仍由 qin-han 包维护
  {
    id: "qin",
    name: "秦",
    altNames: ["嬴秦", "秦国"],
    scope: "cn",
    region: "east_asia",
    start: ym(-770),
    end: ym(-207, 12),
    precision: "year",
    colorToken: "ochre",
    note: "前770年秦襄公护周平王东迁列为诸侯；前221年嬴政称帝统一；前207年子婴降，秦亡。",
  },
];

// ── reigns (representative rulers per state) ──

const reigns = [
  dynastyReign("qi-chunqiu", "lv-shang", "齐太公", "太公", -1046, -1043),
  dynastyReign("qi-chunqiu", "jiang-xiaobai", "齐桓公", "桓公", -685, -643),
  dynastyReign("jin-chunqiu", "ji-chonger", "晋文公", "文公", -636, -628),
  dynastyReign("chu-chunqiu", "xiong-zhuang", "楚庄王", "庄王", -613, -591),
  dynastyReign("qin", "ying-qi", "秦襄公", "襄公", -770, -766),
  dynastyReign("qin", "ying-quliang", "秦孝公", "孝公", -361, -338),
  dynastyReign("wu-chunqiu", "fu-chai", "吴王夫差", "夫差", -495, -473),
  dynastyReign("yue-chunqiu", "gou-jian", "越王勾践", "勾践", -496, -465),
  dynastyReign("wei-warring", "wei-wen", "魏文侯", "文侯", -424, -387),
  dynastyReign("han-warring", "han-jing", "韩景侯", "景侯", -408, -400),
  dynastyReign("zhao-warring", "zhao-lie", "赵烈侯", "烈侯", -403, -387),
];

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
];

// ── SQL generation ───────────────────────────────────────────────────────────

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
  return `INSERT INTO relations (id, from_type, from_id, to_type, to_id, kind)
VALUES (${sqlStr(r.id)}, ${sqlStr(from.type)}, ${sqlStr(from.id)}, ${sqlStr(to.type)}, ${sqlStr(to.id)}, ${sqlStr(r.kind)})
ON CONFLICT (from_type, from_id, to_type, to_id, kind) DO NOTHING;`;
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
  "-- event_dynasties (new + links to xia-shang-zhou events)",
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
  slug: "chunqiu-zhanguo",
  title: "春秋战国诸侯国",
  window: { startYear: -1046, startMonth: 1, endYear: -207, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: "2026-09-12",
  counts: {
    persons: persons.length,
    dynasties: dynasties.length,
    reigns: reigns.length,
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
  ],
  notes: [
    "收录春秋主要列国与战国七雄（齐楚燕韩赵魏秦）及宋鲁卫郑曹吴越中山等。",
    "id 后缀 -chunqiu / -warring / wei-weiguo 避免与曹魏 wei、孙吴 wu、北宋 song-north 等同名冲突。",
    "秦国 upsert 已有 qin 行，将始年延至前770年秦襄公，与 qin-han 统一帝国段衔接。",
    "各国在位仅列代表性君主；未逐代收录全部国君。",
    "未收录薛、滕、杞、莒等小国；未收录战国末期的代、胶东等残余。",
    "葵丘之盟、城濮之战、三家分晋等事件沿用 xia-shang-zhou 已有 id，本包仅补 event_dynasties 关联。",
  ],
};
writeFileSync(path.join(__dirname, "manifest.json"), `${JSON.stringify(manifest, null, 2)}\n`);

console.log(
  `Wrote import.sql + manifest.json: ${persons.length} persons, ${dynasties.length} dynasties, ${reigns.length} reigns, ${events.length} events, ${relations.length} relations, ${existingEventDynasties.length} event_dynasty links`,
);
console.log("Sample abs:", {
  qiStart: absMonth(-1046, 1),
  sanjiaFenjin: absMonth(-403, 1),
  qinUnify: absMonth(-221, 1),
  qinEnd: absMonth(-207, 12),
});
