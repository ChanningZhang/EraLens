#!/usr/bin/env node
/**
 * Bake dynasty_capitals import from capitals-raw.json + coordinates.json (GCJ-02).
 */
import { readFileSync, writeFileSync, existsSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { dynastyCapitalSql } from "../lib/sqlHelpers.mjs";
import { assertCapitalModernNames } from "../lib/validateCapitalModernName.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

/** Retired capital rows — deleted on import so UPSERT-only packages can drop removed seats. */
const REMOVED_CAPITAL_IDS = ["cap-roc-taibei-23388"];

const raw = JSON.parse(readFileSync(path.join(__dirname, "capitals-raw.json"), "utf8"));
const seed = JSON.parse(readFileSync(path.join(__dirname, "coordinates-seed.json"), "utf8"));
const extraPath = path.join(__dirname, "coordinates.json");
const extra = existsSync(extraPath)
  ? JSON.parse(readFileSync(extraPath, "utf8"))
  : {};
const coords = { ...seed, ...extra };

const missing = new Set();
const capitals = raw.map((c) => {
  const coord = coords[c.modernName];
  if (!coord) {
    missing.add(c.modernName);
    return null;
  }
  return {
    ...c,
    longitude: coord.longitude,
    latitude: coord.latitude,
    coordinateSystem: "GCJ02",
  };
});

if (missing.size) {
  console.error(`[dynasty-capitals] Missing coordinates for ${missing.size} locations:`);
  for (const name of [...missing].sort()) console.error(`  - ${name}`);
  process.exit(1);
}

assertCapitalModernNames(capitals);

const years = capitals.flatMap((c) => [c.start.year, c.end.year]);
const removalSql = REMOVED_CAPITAL_IDS.map(
  (id) => `DELETE FROM dynasty_capitals WHERE id = '${id}';`,
);

const sql = [
  "-- EraLens period import: dynasty-capitals",
  "BEGIN;",
  "",
  ...(removalSql.length ? ["-- removed capitals", ...removalSql, ""] : []),
  "-- dynasty_capitals",
  ...capitals.map(dynastyCapitalSql),
  "",
  "COMMIT;",
  "",
].join("\n");

writeFileSync(path.join(__dirname, "import.sql"), sql);
writeFileSync(
  path.join(__dirname, "manifest.json"),
  `${JSON.stringify(
    {
      slug: "dynasty-capitals",
      title: "全库王朝都城",
      window: {
        startYear: Math.min(...years),
        startMonth: 1,
        endYear: Math.max(...years),
        endMonth: 12,
      },
      scope: "cn",
      depth: "standard",
      generatedAt: new Date().toISOString().slice(0, 10),
      counts: { dynasty_capitals: capitals.length },
      sources: [
        { label: "维基百科", url: "https://zh.wikipedia.org/wiki/中国古代都城" },
        { label: "唐哀帝（维基百科）", url: "https://zh.wikipedia.org/wiki/唐哀帝" },
        { label: "高德地图地理编码", url: "https://lbs.amap.com/api/webservice/guide/api/georegeo" },
      ],
      notes: [
        "modernName 为省/市全称；坐标 GCJ-02，经 Amap maps_geo 烘焙",
        "唐都城：904年迁都洛阳，李柷（唐哀帝）在位至907年唐亡；洛阳记录拆分为迁都前陪都与迁都后正都",
        `覆盖 ${new Set(capitals.map((c) => c.dynastyId)).size} 个王朝，${capitals.length} 条都城记录`,
      ],
    },
    null,
    2,
  )}\n`,
);
console.log(`[dynasty-capitals] ${capitals.length} capital seats for ${new Set(capitals.map((c) => c.dynastyId)).size} dynasties`);
