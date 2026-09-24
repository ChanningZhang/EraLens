#!/usr/bin/env node
import { eventPoint, eventYear, writeImportPackage, ym } from "../lib/sqlHelpers.mjs";

const events = [
  eventPoint({
    id: "finance-official-jiaozi-issued",
    name: "官交子发行",
    kind: "finance",
    precision: "month",
    at: ym(1024, 2),
    dynastyIds: ["song-north"],
    summary: "北宋在益州设交子务，收归民间交子发行权并开始发行官交子。纸币用于缓解四川铁钱沉重、携带不便造成的交易困难，成为国家管理纸币发行的早期制度实践。",
    dateNote: "天圣二年（1024）二月官交子正式发行；益州交子务于前一年设立。",
  }),
  eventPoint({
    id: "finance-qing-fixed-ding-tax",
    name: "滋生人丁永不加赋",
    kind: "finance",
    at: eventYear(1712),
    dynastyIds: ["qing"],
    summary: "清廷以康熙五十年（1711）在册丁额为定额，规定此后新增人丁不再增加丁银。政策冻结人头税总额，为雍正时期将丁银摊入田赋的改革奠定制度背景。",
    dateNote: "康熙五十一年（1712）颁旨；后续各省执行与丁银摊入田亩并非同一时点。",
  }),
  eventPoint({
    id: "finance-fabi-reform",
    name: "法币改革",
    kind: "finance",
    precision: "month",
    at: ym(1935, 11),
    dynastyIds: ["roc"],
    summary: "国民政府将中央、中国、交通三家银行发行的钞票定为法币，集中钞票发行与兑换管理，并停止以银元和白银作为流通货币。改革改变了中国币制和白银货币流通格局。",
    dateNote: "财政部于1935年11月3日公布改革办法，自11月4日起实施。",
  }),
];

const sources = [
  { label: "中国国家博物馆：会子版（交子与宋代纸币）", url: "https://www.chnmuseum.cn/zp/zpml/201812/t20181218_26121.shtml" },
  { label: "中国国家博物馆：中华史诗美术大展（官交子发行）", url: "https://en.chnmuseum.cn/Portals/0/web/exhibition/exhibitions/161120Chines-Epic/" },
  { label: "故宫博物院：康熙皇帝（康熙五十一年政策）", url: "https://www.dpm.org.cn/court/lineage/226256.html" },
  { label: "《清史稿·食货志》原文", url: "https://www.qj.hk/jingdian/book/79/3872.html" },
  { label: "美国国务院历史档案：1935年中国币制改革外交文件", url: "https://history.state.gov/historicaldocuments/frus1935v03/d613" },
  { label: "日本外务省外交史料馆：1935年币制改革研究资料", url: "https://www.mofa.go.jp/mofaj/files/100512963.pdf" },
];

writeImportPackage(new URL(".", import.meta.url).pathname, {
  slug: "financial-events",
  window: { startYear: 1024, startMonth: 1, endYear: 1935, endMonth: 12 },
  persons: [], dynasties: [], reignGroups: [], reigns: [], relations: [], events,
  manifest: {
    slug: "financial-events",
    title: "金融重大事件",
    window: { startYear: 1024, startMonth: 1, endYear: 1935, endMonth: 12 },
    scope: "cn",
    depth: "minimal",
    generatedAt: new Date().toISOString().slice(0, 10),
    counts: { persons: 0, dynasties: 0, reigns: 0, events: events.length, relations: 0 },
    sources,
    notes: [
      "金融 kind 用于具有制度影响的货币发行、税收金融化与币制改革节点。",
      "本批新增官交子、滋生人丁永不加赋、法币改革三条；与商业事件包合计15条，不超过用户设定的上限。",
      "一条鞭法未另列：已有张居正改革事件涵盖该项改革，避免重复导入。",
    ],
  },
});
