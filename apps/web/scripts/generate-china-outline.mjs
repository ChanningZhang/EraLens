#!/usr/bin/env node
/**
 * Regenerate apps/web/src/assets/china-outline.svg from high-resolution boundary data.
 *
 * Source: Aliyun DataV national boundary (adcode 100000, ~7k vertices,含台湾与离岛).
 *
 * Usage: node apps/web/scripts/generate-china-outline.mjs
 */
import { writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const outPath = path.resolve(__dirname, "../src/assets/china-outline.svg");

const NATION_URL = "https://geo.datav.aliyun.com/areas_v3/bound/100000.json";

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

function ringToPath(ring) {
  return (
    ring
      .map(([lng, lat], index) => `${index === 0 ? "M" : "L"} ${lng.toFixed(5)} ${lat.toFixed(5)}`)
      .join(" ") + " Z"
  );
}

async function main() {
  const nationJson = await fetchJson(NATION_URL);
  const nationFeature =
    nationJson.type === "FeatureCollection" ? nationJson.features[0] : nationJson;
  if (!nationFeature?.geometry) throw new Error("National boundary feature missing");

  const paths = ringsFromGeometry(nationFeature.geometry)
    .filter((ring) => ring.length >= 4)
    .map(ringToPath);

  const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="73 17 63 37" preserveAspectRatio="xMidYMid meet" aria-hidden="true">
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
  <g transform="scale(1,-1) translate(0,-71)" filter="url(#mapSoftShadow)">
    <g class="china-land" fill="url(#chinaFill)" stroke="var(--map-stroke, #c4baa8)" stroke-width="0.05" stroke-linejoin="round" stroke-linecap="round" shape-rendering="geometricPrecision">
${paths.map((d) => `      <path d="${d}" />`).join("\n")}
    </g>
  </g>
</svg>
`;

  writeFileSync(outPath, svg);
  const kb = (Buffer.byteLength(svg) / 1024).toFixed(1);
  console.log(`[china-outline] wrote ${outPath} (${paths.length} paths, ${kb} KB)`);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
