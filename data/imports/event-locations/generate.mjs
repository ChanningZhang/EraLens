#!/usr/bin/env node
import { writeFileSync } from "node:fs";
import { eventLocationSql, sqlStr } from "../lib/sqlHelpers.mjs";
import { locations } from "./locations.mjs";

const statements = locations.map((location) => eventLocationSql(location));
for (const location of locations) {
  statements.push(`UPDATE events SET location_id = ${sqlStr(location.id)} WHERE id = ${sqlStr(location.eventId)};`);
}
const sql = `-- EraLens import: event locations\nBEGIN;\n\n-- event_locations\n${statements.join("\n")}\n\nCOMMIT;\n`;
writeFileSync(new URL("./import.sql", import.meta.url), sql);
writeFileSync(new URL("./manifest.json", import.meta.url), `${JSON.stringify({
  slug: "event-locations", title: "战争事件地点", window: { startYear: 9999, startMonth: 1, endYear: 9999, endMonth: 12 }, scope: "cn", depth: "standard", importPhase: "post", generatedAt: "2026-09-24",
  counts: { persons: 0, dynasties: 0, reigns: 0, events: 0, relations: 0, eventLocations: locations.length },
  sources: [...new Map(locations.flatMap((location) => location.links).map((link) => [link.url, link])).values()],
  notes: ["仅为可定位到具体遗址或区域的战争事件补地点；战场范围以近似点表达。存在定位争议者在地点 note 中说明。未能可靠定位的战争保持地点为空。", "坐标采用 WGS84；来源链接用于核对古称、今地与地点定位。"],
}, null, 2)}\n`);
console.log(`[event-locations] ${locations.length} locations`);
