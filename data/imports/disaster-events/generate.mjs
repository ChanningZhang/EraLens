#!/usr/bin/env node
import { eventPoint, eventRange, eventYear, writeImportPackage, ym } from "../lib/sqlHelpers.mjs";

const events = [
  eventPoint({
    id: "jianan-twenty-two-epidemic",
    name: "建安二十二年大疫",
    kind: "disaster",
    at: eventYear(217),
    dynastyIds: ["han-east"],
    summary: "建安二十二年，北方疫病流行。曹丕次年致吴质书追述亲友多遭疫病，陈琳、徐幹、应玚、刘桢相继去世；曹植《说疫气》也记述当年疫病造成的广泛死亡。疫情影响建安文人群体，但史料不足以判定具体病原或量化死亡人数。",
    dateNote: "建安二十二年（217）；按年精度记录。史料未能证明该场疫情始于196年，也不能据此确认为鼠疫或伤寒。",
  }),
  eventRange({
    id: "xin-wei-commandery-yellow-river-breach",
    name: "新莽魏郡黄河决口与长期河患",
    kind: "disaster",
    timeMode: "circa",
    precision: "year",
    start: ym(11),
    end: eventYear(69),
    dynastyIds: ["xin", "han-east"],
    summary: "始建国三年（11），黄河在魏郡决口，泛滥至清河以东数郡，河水长期扰动下游水系并影响汴渠。东汉明帝永平十二年（69）朝廷命王景、王吴修渠筑堤，治理黄河与汴渠。此区间表示决口后长期河患至系统治理启动的概略时段，不表示每年均发生同等规模洪水。",
    dateNote: "《汉书·王莽传》载始建国三年河决魏郡；《后汉书·王景传》载永平十二年（69）修渠筑堤。河患具体逐年起讫不详，故用概略区间，不延伸为精确至70年的连续灾害。",
  }),
  eventPoint({
    id: "ming-capital-epidemic-1643",
    name: "京师大疫",
    kind: "disaster",
    at: eventYear(1643),
    dynastyIds: ["ming"],
    summary: "崇祯十六年，北京发生严重疫病。《明史·五行志》记京师自二月至九月大疫，明末记述亦称死亡甚众。后世研究对当时疫病是否为鼠疫仍有不同判断，现有史料不足以确认具体病原或可靠死亡总数。",
    dateNote: "崇祯十六年（1643）；史籍所记二月至九月为农历，事件按年精度记录，不将农历月份直接换算为公历月份。",
  }),
  eventRange({
    id: "dingwu-north-china-famine",
    name: "丁戊奇荒",
    kind: "disaster",
    timeMode: "circa",
    precision: "year",
    start: ym(1875),
    end: eventYear(1879),
    dynastyIds: ["qing"],
    summary: "晚清华北持续旱灾引发严重饥荒，山西、河南、陕西、直隶、山东等地受灾，灾情在1877—1878年尤重，并波及邻近地区。饥荒造成粮食短缺、人口流徙和大规模赈济；不同研究对灾害起讫及死亡规模的估计不一。",
    dateNote: "研究常以1876—1879年概括华北大饥荒，中文“丁戊”指灾情高峰所在的1877、1878年；部分资料将旱象追溯至1875年。此处用概略区间涵盖旱灾发展与灾后缓解，不采用有争议的死亡数字。",
  }),
];

const sources = [
  { label: "《三国志·魏书·文帝纪》注引曹丕《与吴质书》", url: "https://zh.wikisource.org/zh-hans/與吳質書" },
  { label: "中央研究院历史语言研究所：林富士《东汉晚期的疫疠与宗教》", url: "https://www.ihp.sinica.edu.tw/~linfs/fslin/e-han.pdf" },
  { label: "《汉书·王莽传》", url: "https://zh.wikisource.org/zh-hans/漢書/卷099中" },
  { label: "《后汉书·王景传》", url: "https://zh.wikisource.org/zh-hans/後漢書/卷76" },
  { label: "水利知识服务平台：中国黄河水利史", url: "https://www.shuizhishi.cn/c/2020-04-09/520973.shtml" },
  { label: "中央研究院历史语言研究所：明代北京的瘟疫与帝国医疗体系的应变", url: "https://www11.ihp.sinica.edu.tw/storage/w2_file/3028acXZKHg.pdf" },
  { label: "北京市人民政府：北京历史上的疫情防控", url: "https://www.visitbeijing.com.cn/article/47QoNewiJhe" },
  { label: "Journal of Chinese History, Cambridge University Press: Drought and Famine in Northwest China", url: "https://www.cambridge.org/core/journals/journal-of-chinese-history/article/drought-and-famine-in-northwest-china-a-late-victorian-tragedy/5693EF8F6E7B5BDAED2802E185D26F56" },
  { label: "中国人民大学清史研究所：丁戊奇荒研究资料", url: "https://iqh.ruc.edu.cn/old/zgzhslt/ztyj_zh/mq/d42483df837e43e9a15226525fd321e2.htm" },
];

writeImportPackage(new URL(".", import.meta.url).pathname, {
  slug: "disaster-events",
  window: { startYear: 11, startMonth: 1, endYear: 1879, endMonth: 12 },
  persons: [], dynasties: [], reignGroups: [], reigns: [], relations: [], events,
  manifest: {
    slug: "disaster-events",
    title: "跨时期重大灾害事件",
    window: { startYear: 11, startMonth: 1, endYear: 1879, endMonth: 12 },
    scope: "cn",
    depth: "minimal",
    generatedAt: "2026-09-25",
    counts: { persons: 0, dynasties: 0, reigns: 0, events: events.length, relations: 0 },
    sources,
    notes: [
      "本包收录对广域人口、社会或水系造成显著影响，且不能由王朝泳道与君主在位信息表达的灾害事件。",
      "建安疫病依曹丕书信、曹植《说疫气》及相关研究记为217年；不把其扩展为196—217年的单场疫情，也不推断鼠疫或伤寒病原。",
      "新莽黄河决口至王景治河按史载锚点表示长期河患的概略区间，并非逐年连续洪水记录。",
      "崇祯十六年疫情按年精度记录；原始史籍月序为农历。病原与死亡规模存在史料及研究不确定性。",
      "丁戊奇荒各研究的起讫口径不一；区间包含旱象发展至灾情缓解，未录入争议较大的死亡人数估计。",
    ],
  },
});
