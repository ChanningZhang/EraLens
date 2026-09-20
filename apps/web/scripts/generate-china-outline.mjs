#!/usr/bin/env node
/**
 * Regenerate apps/web/src/assets/china-outline.svg.
 *
 * - Land: Aliyun DataV national boundary (adcode 100000)
 * - Rivers: Natural Earth 50m (Yangtze = Jinsha + Chang Jiang + Yangtze; Yellow = Huang + Yellow)
 *
 * Latitude projection must stay in sync with chinaMapProjection.ts.
 *
 * Usage: node apps/web/scripts/generate-china-outline.mjs
 */
import { writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const outPath = path.resolve(__dirname, "../src/assets/china-outline.svg");

const NATION_URL = "https://geo.datav.aliyun.com/areas_v3/bound/100000.json";
const RIVERS_URL =
  "https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_50m_rivers_lake_centerlines.geojson";

const YANGTZE_SEGMENT_NAMES = new Set(["Jinsha", "Chang Jiang", "Yangtze"]);

const MAP_BOUNDS = { minLng: 73, maxLng: 136, minLat: 17, maxLat: 54 };
const MAP_MID_LAT = (MAP_BOUNDS.minLat + MAP_BOUNDS.maxLat) / 2;
const MAP_LATITUDE_SCALE = Math.cos((MAP_MID_LAT * Math.PI) / 180);

function projectChinaLatitude(lat) {
  return MAP_MID_LAT + (lat - MAP_MID_LAT) / MAP_LATITUDE_SCALE;
}

const projectedMinLat = projectChinaLatitude(MAP_BOUNDS.minLat);
const projectedMaxLat = projectChinaLatitude(MAP_BOUNDS.maxLat);
const projectedLatSpan = projectedMaxLat - projectedMinLat;
const lngSpan = MAP_BOUNDS.maxLng - MAP_BOUNDS.minLng;
const flipSum = projectedMinLat + projectedMaxLat;
const viewBox = `${MAP_BOUNDS.minLng} ${projectedMinLat} ${lngSpan} ${projectedLatSpan}`;

async function fetchJson(url) {
  const res = await fetch(url);
  if (!res.ok) throw new Error(`Failed to fetch ${url}: ${res.status}`);
  return res.json();
}

function ringsFromGeometry(geometry) {
  if (geometry.type === "Polygon") return [geometry.coordinates[0]];
  if (geometry.type === "MultiPolygon") return geometry.coordinates.map((poly) => poly[0]);
  return [];
}

function linesFromGeometry(geometry) {
  if (geometry.type === "LineString") return [geometry.coordinates];
  if (geometry.type === "MultiLineString") return geometry.coordinates;
  return [];
}

function ringToPath(ring) {
  return (
    ring
      .map(([lng, lat], index) => {
        const y = projectChinaLatitude(lat);
        return `${index === 0 ? "M" : "L"} ${lng.toFixed(5)} ${y.toFixed(5)}`;
      })
      .join(" ") + " Z"
  );
}

function lineToPath(line) {
  return line
    .map(([lng, lat], index) => {
      const y = projectChinaLatitude(lat);
      return `${index === 0 ? "M" : "L"} ${lng.toFixed(5)} ${y.toFixed(5)}`;
    })
    .join(" ");
}

function extractRiverLines(features, predicate) {
  const lines = [];
  for (const feature of features) {
    if (!predicate(feature)) continue;
    for (const line of linesFromGeometry(feature.geometry)) {
      if (line.length >= 2) lines.push(line);
    }
  }
  return lines;
}

function riverPathMarkup(lines, className, strokeVar, strokeWidth) {
  return lines
    .map(
      (line) =>
        `      <path class="${className}" d="${lineToPath(line)}" stroke="${strokeVar}" stroke-width="${strokeWidth}" fill="none" opacity="0.72" />`,
    )
    .join("\n");
}

async function main() {
  const [nationJson, riversJson] = await Promise.all([fetchJson(NATION_URL), fetchJson(RIVERS_URL)]);

  const nationFeature =
    nationJson.type === "FeatureCollection" ? nationJson.features[0] : nationJson;
  if (!nationFeature?.geometry) throw new Error("National boundary feature missing");

  const landPaths = ringsFromGeometry(nationFeature.geometry)
    .filter((ring) => ring.length >= 4)
    .map(ringToPath);

  const riverFeatures = riversJson.features ?? [];
  const yangtzeLines = extractRiverLines(
    riverFeatures,
    (feature) => YANGTZE_SEGMENT_NAMES.has(feature.properties?.name ?? ""),
  );
  const yellowLines = extractRiverLines(
    riverFeatures,
    (feature) =>
      feature.properties?.name === "Huang" &&
      (feature.properties?.name_en === "Huang" ||
        feature.properties?.name_en === "Yellow" ||
        feature.properties?.name_en == null),
  );

  const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="${viewBox}" preserveAspectRatio="xMidYMid meet" aria-hidden="true">
  <defs>
    <linearGradient id="chinaFill" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="var(--map-fill-top, #e8e2d4)" />
      <stop offset="55%" stop-color="var(--map-fill-mid, #ddd6c6)" />
      <stop offset="100%" stop-color="var(--map-fill-bottom, #d4cbb8)" />
    </linearGradient>
    <filter id="mapSoftShadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="1" stdDeviation="2" flood-color="rgba(27,25,23,0.08)" />
    </filter>
  </defs>
  <g transform="scale(1,-1) translate(0,-${flipSum})">
    <g class="china-land" fill="url(#chinaFill)" stroke="var(--map-stroke, #c4baa8)" stroke-width="0.05" stroke-linejoin="round" stroke-linecap="round" shape-rendering="geometricPrecision" filter="url(#mapSoftShadow)">
${landPaths.map((d) => `      <path d="${d}" />`).join("\n")}
    </g>
    <g class="china-rivers" stroke-linecap="round" stroke-linejoin="round" shape-rendering="geometricPrecision">
${riverPathMarkup(yangtzeLines, "river-yangtze", "var(--map-river-yangtze)", "0.14")}
${riverPathMarkup(yellowLines, "river-yellow", "var(--map-river-yellow)", "0.13")}
    </g>
  </g>
</svg>
`;

  writeFileSync(outPath, svg);
  const kb = (Buffer.byteLength(svg) / 1024).toFixed(1);
  console.log(
    `[china-outline] wrote ${outPath} (viewBox=${viewBox}; ${landPaths.length} land + ${yangtzeLines.length} Yangtze + ${yellowLines.length} Yellow lines, ${kb} KB)`,
  );
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
