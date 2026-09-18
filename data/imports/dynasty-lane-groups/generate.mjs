#!/usr/bin/env node
/**
 * Static timeline lane-group configuration (西周/东周, 蒙古/元, 吴/明/南明).
 */
import { writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { absMonth } from "../lib/sqlHelpers.mjs";
import { dynastyLaneGroupSql } from "../lib/sqlHelpers.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const laneGroups = [
  {
    id: "mongol-yuan",
    primaryDynastyId: "yuan",
    phaseDynastyIds: ["mongol-empire", "yuan"],
    laneOrderStartAbs: absMonth(1206),
    laneOrderEndAbs: absMonth(1388),
  },
  {
    id: "wu-ming",
    primaryDynastyId: "ming",
    phaseDynastyIds: ["wu-zhu", "ming", "ming-south"],
    laneOrderStartAbs: absMonth(1364),
    laneOrderEndAbs: absMonth(1662),
  },
  {
    id: "zhou-west-east",
    primaryDynastyId: "zhou-west",
    phaseDynastyIds: ["zhou-west", "zhou-east"],
    laneOrderStartAbs: absMonth(-1046),
    laneOrderEndAbs: absMonth(-256, 12),
  },
];

const sql = [
  "-- EraLens period import: dynasty-lane-groups",
  "BEGIN;",
  "",
  "-- dynasty_lane_groups",
  ...laneGroups.map(dynastyLaneGroupSql),
  "",
  "COMMIT;",
  "",
].join("\n");

mkdirSync(__dirname, { recursive: true });
writeFileSync(path.join(__dirname, "import.sql"), sql);
writeFileSync(
  path.join(__dirname, "manifest.json"),
  `${JSON.stringify(
    {
      slug: "dynasty-lane-groups",
      window: { startYear: -9999, startMonth: 1, endYear: 9999, endMonth: 12 },
      notes: "Timeline lane merge configuration; imported before historical packages.",
    },
    null,
    2,
  )}\n`,
);
console.log(`[dynasty-lane-groups] ${laneGroups.length} lane groups`);
