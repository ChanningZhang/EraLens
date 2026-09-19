#!/usr/bin/env node
/**
 * 史前考古文化：以 circa 事件标在时间轴上，不建王朝行。
 * 年代取维基百科通行碳十四窗口，精度 century，避免伪造成月日。
 */
import path from "node:path";
import { fileURLToPath } from "node:url";
import { eventRange, writeImportPackage, ym } from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

function culture({ id, name, startYear, endYear, atYear, dateNote, summary }) {
  return eventRange({
    id,
    name,
    kind: "culture",
    timeMode: "circa",
    precision: "century",
    dateNote,
    start: ym(startYear),
    end: ym(endYear, 12),
    at: ym(atYear),
    summary,
  });
}

const events = [
  culture({
    id: "jiahu",
    name: "贾湖文化",
    startYear: -7000,
    endYear: -5800,
    atYear: -6400,
    dateNote: "贾湖遗址三期约距今9000–7800年；骨笛分期作前7000–前5800。一说属裴李岗文化类型。",
    summary: "河南舞阳贾湖，新石器早期聚落。出土七声音阶骨笛、炭化稻、龟甲契刻符号，为黄河—淮河间早期文化的代表。",
  }),
  culture({
    id: "hemudu",
    name: "河姆渡文化",
    startYear: -5000,
    endYear: -3300,
    atYear: -4150,
    dateNote: "河姆渡遗址四期碳十四：一期约前5000–前4500，四期约前3600–前3300；亦作前5000–前3000。",
    summary: "浙江余姚河姆渡，长江下游新石器文化。干栏式建筑、夹炭黑陶与大量栽培稻谷，证明江南史前稻作与定居。",
  }),
  culture({
    id: "yangshao",
    name: "仰韶文化",
    startYear: -5000,
    endYear: -2700,
    atYear: -3850,
    dateNote: "约前5000–前2700。半坡、庙底沟等为地方类型。",
    summary: "以河南渑池仰韶村命名，分布于黄河中游。彩陶、农业村落与半地穴房屋，是中原新石器中期的主干文化。",
  }),
  culture({
    id: "hongshan",
    name: "红山文化",
    startYear: -4700,
    endYear: -2900,
    atYear: -3800,
    dateNote: "约前4700–前2900，与仰韶中晚期相当。",
    summary: "西辽河流域新石器文化，内蒙古赤峰红山及辽宁牛河梁为代表。玉龙、积石冢与女神庙，显示早期礼仪中心。",
  }),
  culture({
    id: "dawenkou",
    name: "大汶口文化",
    startYear: -4300,
    endYear: -2500,
    atYear: -3400,
    dateNote: "约前4300–前2500；一说稍早自前4500，约前2500过渡为龙山。",
    summary: "以山东泰安大汶口命名，海岱地区新石器文化。陶鬶、拔牙习俗与陶器刻画符号，下接山东龙山文化。",
  }),
  culture({
    id: "liangzhu",
    name: "良渚文化",
    startYear: -3300,
    endYear: -2300,
    atYear: -2800,
    dateNote: "通行约前3300–前2300；亦记距今约5300–4000年（约前3300–前2000）。",
    summary: "环太湖地区新石器晚期文化。良渚古城、水利系统与琮璧钺玉礼器，常被视为长江下游早期国家形态。",
  }),
  culture({
    id: "majiayao",
    name: "马家窑文化",
    startYear: -3300,
    endYear: -2100,
    atYear: -2700,
    dateNote: "约前3300–前2100。马家窑、半山、马厂为同一文化诸类型。",
    summary: "甘青地区新石器文化，仰韶西向发展的一支。以精美彩陶著称，林家等地出土早期青铜小刀。",
  }),
  culture({
    id: "longshan",
    name: "龙山文化",
    startYear: -3000,
    endYear: -2000,
    atYear: -2500,
    dateNote: "距今约5000–4000年；山东龙山约前2500–前2000。此取黄河中下游龙山时代总范围。",
    summary: "新石器晚期黑陶文化，分布于山东、河南、山西、陕西等地。蛋壳黑陶、夯土城址，下接二里头等早期青铜文化。",
  }),
  culture({
    id: "taosi",
    name: "陶寺文化",
    startYear: -2300,
    endYear: -1900,
    atYear: -2100,
    dateNote: "陶寺中期约前2100–前2000；观象台或可上溯至距今约4700年。此取龙山时代晋南陶寺通行年。",
    summary: "山西襄汾陶寺，晋南龙山时代都邑。宫殿、观象台、朱书扁壶与等级墓葬，常被用以探索早期国家与尧都传说。",
  }),
  culture({
    id: "shimao",
    name: "石峁",
    startYear: -2300,
    endYear: -1800,
    atYear: -2050,
    dateNote: "石峁城址属龙山晚期，通行碳十四约前2300–前1800（距今约4300–3800年）。",
    summary: "陕西神木石峁，目前所见中国史前规模最大的石构城址。皇城台、玉器与石雕，为河套—陕北早期邦国遗存。",
  }),
  culture({
    id: "erlitou",
    name: "二里头文化",
    startYear: -1750,
    endYear: -1520,
    atYear: -1640,
    dateNote: "2015年AMS：文化早不过前1900、晚不过前1500；一期约前1750，四期约止于前1520。亦作约前1800–前1500。与文献夏朝不能简单等同。",
    summary: "河南偃师二里头，中原最早的大型都邑之一。宫城、青铜礼器与绿松石龙，是探索夏商分界与早期国家的核心遗存。",
  }),
  culture({
    id: "sanxingdui",
    name: "三星堆文化",
    startYear: -2000,
    endYear: -1100,
    atYear: -1200,
    dateNote: "遗址约前2800–前1100。一期属宝墩文化；二三期三星堆文化约前2000–前1400；著名祭祀坑约前1200–前1000，属四期十二桥。不含宝墩一期。",
    summary: "四川广汉三星堆，古蜀青铜文明。纵目面具、神树、金杖与大型祭祀坑，与中原夏商并行而风格迥异。",
  }),
];

const manifest = {
  slug: "prehistoric-cultures",
  title: "史前考古文化",
  window: { startYear: -7000, startMonth: 1, endYear: -1100, endMonth: 12 },
  scope: "cn",
  depth: "standard",
  generatedAt: new Date().toISOString().slice(0, 10),
  counts: {
    persons: 0,
    dynasties: 0,
    reigns: 0,
    events: events.length,
    relations: 0,
  },
  sources: [
    { label: "贾湖遗址", url: "https://zh.wikipedia.org/wiki/贾湖遗址" },
    { label: "河姆渡遗址", url: "https://zh.wikipedia.org/wiki/河姆渡遗址" },
    { label: "仰韶文化", url: "https://zh.wikipedia.org/wiki/仰韶文化" },
    { label: "红山文化", url: "https://zh.wikipedia.org/wiki/红山文化" },
    { label: "大汶口文化", url: "https://zh.wikipedia.org/wiki/大汶口文化" },
    { label: "良渚文化", url: "https://zh.wikipedia.org/wiki/良渚文化" },
    { label: "马家窑文化", url: "https://zh.wikipedia.org/wiki/马家窑文化" },
    { label: "龙山文化", url: "https://zh.wikipedia.org/wiki/龙山文化" },
    { label: "陶寺遗址", url: "https://zh.wikipedia.org/wiki/陶寺遗址" },
    { label: "石峁遗址", url: "https://zh.wikipedia.org/wiki/石峁遗址" },
    { label: "二里头文化", url: "https://zh.wikipedia.org/wiki/二里头文化" },
    { label: "二里头遗址", url: "https://zh.wikipedia.org/wiki/二里头遗址" },
    { label: "三星堆遗址", url: "https://zh.wikipedia.org/wiki/三星堆遗址" },
  ],
  notes: [
    "不建王朝行或在位卡片：此类为考古学文化/遗址，不是文献世系国号。事件不挂 event_dynasties，以免把二里头等同夏、三星堆等同商。",
    "全部 time_mode=circa、precision=century：碳十四窗口本无月日；千年尺度缩放时仅世纪精度事件可见。",
    "收录教科书与文明探源常用条目：贾湖、河姆渡、仰韶、红山、大汶口、良渚、马家窑、龙山、陶寺、石峁、二里头、三星堆。半坡、牛河梁、殷墟不另立，以免与仰韶/红山/商重复。",
    "起迄取维基通行年，争议写入各条 date_note（读者可见的年代说明，不含「窗口/维基作」等入库用语）；at 为窗口中点，三星堆 at 取著名祭祀坑约前1200年。",
    "三星堆条自二三期（约前2000）起至遗址下限前1100，含祭祀坑，不含宝墩一期。半坡、庙底沟、马家窑诸类型不另立事件。",
  ],
};

writeImportPackage(__dirname, {
  slug: "prehistoric-cultures",
  window: manifest.window,
  persons: [],
  dynasties: [],
  reignGroups: [],
  reigns: [],
  events,
  relations: [],
  manifest,
});
