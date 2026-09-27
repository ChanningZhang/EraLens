#!/usr/bin/env node
/**
 * Regenerate apps/web/src/assets/china-outline.svg.
 *
 * - Land: Aliyun DataV national boundary (adcode 100000)
 * - Rivers: HydroRIVERS v1.0 (15 arc-second hydrographic network), Asia tile.
 *   Lehner & Grill (2013), Hydrological Processes 27(15), 2171–2186,
 *   https://doi.org/10.1002/hyp.9740
 *
 * Latitude projection must stay in sync with chinaMapProjection.ts.
 *
 * Usage: node apps/web/scripts/generate-china-outline.mjs
 */
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { execFileSync } from "node:child_process";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const outPath = path.resolve(__dirname, "../src/assets/china-outline.svg");

const NATION_URL = "https://geo.datav.aliyun.com/areas_v3/bound/100000.json";
const HYDRORIVERS_URL =
  "https://data.hydrosheds.org/file/HydroRIVERS/HydroRIVERS_v10_as_shp.zip";
// HydroRIVERS v1.0 main-stem outlet reach IDs (NEXT_DOWN=0). Each selected
// course is reconstructed upstream through the ORD_CLAS=1 connected reaches.
const RIVER_OUTLETS = { yangtze: 40613666, yellow: 40417973 };
const RIVER_DATA_DIR = "HydroRIVERS_v10_as_shp";
const RIVER_DATA_PREFIX = "HydroRIVERS_v10_as";

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

async function downloadFile(url, filePath) {
  const res = await fetch(url);
  if (!res.ok) throw new Error(`Failed to fetch ${url}: ${res.status}`);
  writeFileSync(filePath, Buffer.from(await res.arrayBuffer()));
}

function ringsFromGeometry(geometry) {
  if (geometry.type === "Polygon") return [geometry.coordinates[0]];
  if (geometry.type === "MultiPolygon") return geometry.coordinates.map((poly) => poly[0]);
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

// HydroRIVERS is WGS84 while the Aliyun DataV boundary used for the map is
// GCJ-02. Keep this formula aligned with wgs84ToGcj02 in chinaMapProjection.ts.
function wgs84ToGcj02(lng, lat) {
  if (lng < 72.004 || lng > 137.8347 || lat < 0.8293 || lat > 55.8271) {
    return [lng, lat];
  }
  const transformLat = (x, y) => {
    let value = -100 + 2 * x + 3 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.sqrt(Math.abs(x));
    value += ((20 * Math.sin(6 * x * Math.PI) + 20 * Math.sin(2 * x * Math.PI)) * 2) / 3;
    value += ((20 * Math.sin(y * Math.PI) + 40 * Math.sin((y / 3) * Math.PI)) * 2) / 3;
    value += ((160 * Math.sin((y / 12) * Math.PI) + 320 * Math.sin((y * Math.PI) / 30)) * 2) / 3;
    return value;
  };
  const transformLng = (x, y) => {
    let value = 300 + x + 2 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.sqrt(Math.abs(x));
    value += ((20 * Math.sin(6 * x * Math.PI) + 20 * Math.sin(2 * x * Math.PI)) * 2) / 3;
    value += ((20 * Math.sin(x * Math.PI) + 40 * Math.sin((x / 3) * Math.PI)) * 2) / 3;
    value += ((150 * Math.sin((x / 12) * Math.PI) + 300 * Math.sin((x / 30) * Math.PI)) * 2) / 3;
    return value;
  };
  const axis = 6378245;
  const eccentricity = 0.006693421622965943;
  const deltaLat = transformLat(lng - 105, lat - 35);
  const deltaLng = transformLng(lng - 105, lat - 35);
  const radLat = (lat / 180) * Math.PI;
  const magic = 1 - eccentricity * Math.sin(radLat) ** 2;
  const sqrtMagic = Math.sqrt(magic);
  const adjustedLat = (deltaLat * 180) / (((axis * (1 - eccentricity)) / (magic * sqrtMagic)) * Math.PI);
  const adjustedLng = (deltaLng * 180) / ((axis / sqrtMagic) * Math.cos(radLat) * Math.PI);
  return [lng + adjustedLng, lat + adjustedLat];
}

function parseDbfRecords(dbf, wantedMainRivers) {
  const headerLength = dbf.readUInt16LE(8);
  const recordLength = dbf.readUInt16LE(10);
  const fields = [];
  for (let offset = 32; offset < headerLength && dbf[offset] !== 0x0d; offset += 32) {
    const end = dbf.indexOf(0, offset);
    fields.push({
      name: dbf.toString("ascii", offset, Math.min(end, offset + 11)),
      width: dbf[offset + 16],
    });
  }

  const offsets = new Map();
  let fieldOffset = 1; // DBF deletion flag
  for (const field of fields) {
    offsets.set(field.name, { offset: fieldOffset, width: field.width });
    fieldOffset += field.width;
  }

  const records = new Map();
  const recordCount = dbf.readUInt32LE(4);
  for (let index = 0; index < recordCount; index += 1) {
    const start = headerLength + index * recordLength;
    if (dbf[start] === 0x2a) continue;
    const readNumber = (name) => {
      const field = offsets.get(name);
      return Number(dbf.toString("ascii", start + field.offset, start + field.offset + field.width).trim());
    };
    const mainRiver = readNumber("MAIN_RIV");
    if (!wantedMainRivers.has(mainRiver)) continue;
    records.set(index, {
      id: readNumber("HYRIV_ID"),
      nextDown: readNumber("NEXT_DOWN"),
      mainRiver,
      order: readNumber("ORD_CLAS"),
      distUpKm: readNumber("DIST_UP_KM"),
    });
  }
  return records;
}

function parseSelectedRiverShapes(shp, selectedRecords) {
  const reaches = new Map();
  let offset = 100;
  let index = 0;
  while (offset + 8 <= shp.length) {
    const contentLength = shp.readInt32BE(offset + 4) * 2;
    const contentStart = offset + 8;
    const contentEnd = contentStart + contentLength;
    const record = selectedRecords.get(index);
    if (record && shp.readInt32LE(contentStart) === 3) {
      const partCount = shp.readInt32LE(contentStart + 36);
      const pointCount = shp.readInt32LE(contentStart + 40);
      const pointOffset = contentStart + 44 + partCount * 4;
      const points = [];
      for (let pointIndex = 0; pointIndex < pointCount; pointIndex += 1) {
        const pointStart = pointOffset + pointIndex * 16;
        points.push([shp.readDoubleLE(pointStart), shp.readDoubleLE(pointStart + 8)]);
      }
      reaches.set(record.id, { ...record, points });
    }
    offset = contentEnd;
    index += 1;
  }
  return reaches;
}

function mainStem(reaches, outletId) {
  const upstreamByOutlet = new Map();
  for (const reach of reaches.values()) {
    if (reach.order !== 1 || reach.nextDown === 0) continue;
    const upstream = upstreamByOutlet.get(reach.nextDown) ?? [];
    upstream.push(reach);
    upstreamByOutlet.set(reach.nextDown, upstream);
  }

  const downstreamToUpstream = [];
  const visited = new Set();
  let current = reaches.get(outletId);
  while (current && !visited.has(current.id)) {
    visited.add(current.id);
    downstreamToUpstream.push(current);
    const upstream = upstreamByOutlet.get(current.id) ?? [];
    current = upstream.sort((a, b) => b.distUpKm - a.distUpKm)[0];
  }
  if (downstreamToUpstream.length === 0 || downstreamToUpstream[0].id !== outletId) {
    throw new Error(`HydroRIVERS outlet ${outletId} is missing`);
  }

  const line = [];
  for (const reach of downstreamToUpstream.reverse()) {
    let points = reach.points;
    if (line.length > 0) {
      const startDistance = squaredDistance(line.at(-1), points[0]);
      const endDistance = squaredDistance(line.at(-1), points.at(-1));
      if (endDistance < startDistance) points = [...points].reverse();
      if (squaredDistance(line.at(-1), points[0]) > 1e-8) {
        throw new Error(`HydroRIVERS reaches disconnect at ${reach.id}`);
      }
      line.push(...points.slice(1));
    } else {
      line.push(...points);
    }
  }
  return simplifyLine(line, 0.012);
}

function squaredDistance(a, b) {
  const meanLat = ((a[1] + b[1]) / 2) * (Math.PI / 180);
  const dx = (a[0] - b[0]) * Math.cos(meanLat);
  const dy = a[1] - b[1];
  return dx * dx + dy * dy;
}

function simplifyLine(line, toleranceDegrees) {
  if (line.length < 3) return line;
  const keep = new Uint8Array(line.length);
  keep[0] = 1;
  keep[line.length - 1] = 1;
  const stack = [[0, line.length - 1]];
  const threshold = toleranceDegrees * toleranceDegrees;
  while (stack.length > 0) {
    const [start, end] = stack.pop();
    let maxDistance = threshold;
    let maxIndex = -1;
    const [ax, ay] = line[start];
    const [bx, by] = line[end];
    const latScale = Math.cos((((ay + by) / 2) * Math.PI) / 180);
    const dx = (bx - ax) * latScale;
    const dy = by - ay;
    const lengthSquared = dx * dx + dy * dy;
    for (let index = start + 1; index < end; index += 1) {
      const [x, y] = line[index];
      const px = (x - ax) * latScale;
      const py = y - ay;
      const t = lengthSquared === 0 ? 0 : Math.max(0, Math.min(1, (px * dx + py * dy) / lengthSquared));
      const distanceX = px - t * dx;
      const distanceY = py - t * dy;
      const distance = distanceX * distanceX + distanceY * distanceY;
      if (distance > maxDistance) {
        maxDistance = distance;
        maxIndex = index;
      }
    }
    if (maxIndex !== -1) {
      keep[maxIndex] = 1;
      stack.push([start, maxIndex], [maxIndex, end]);
    }
  }
  return line.filter((_, index) => keep[index]);
}

async function fetchHydroRivers() {
  const tempDir = mkdtempSync(path.join(os.tmpdir(), "eralens-hydrorivers-"));
  try {
    const archivePath = path.join(tempDir, "hydrorivers.zip");
    await downloadFile(HYDRORIVERS_URL, archivePath);
    execFileSync("unzip", ["-oq", archivePath, "-d", tempDir]);
    const dataBase = path.join(tempDir, RIVER_DATA_DIR, RIVER_DATA_PREFIX);
    const selectedRecords = parseDbfRecords(
      readFileSync(`${dataBase}.dbf`),
      new Set(Object.values(RIVER_OUTLETS)),
    );
    const reaches = parseSelectedRiverShapes(readFileSync(`${dataBase}.shp`), selectedRecords);
    return Object.fromEntries(
      Object.entries(RIVER_OUTLETS).map(([name, outletId]) => [
        name,
        mainStem(reaches, outletId),
      ]),
    );
  } finally {
    rmSync(tempDir, { recursive: true, force: true });
  }
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
  const [nationJson, riverLines] = await Promise.all([
    fetchJson(NATION_URL),
    fetchHydroRivers(),
  ]);

  const nationFeature =
    nationJson.type === "FeatureCollection" ? nationJson.features[0] : nationJson;
  if (!nationFeature?.geometry) throw new Error("National boundary feature missing");

  const landPaths = ringsFromGeometry(nationFeature.geometry)
    .filter((ring) => ring.length >= 4)
    .map(ringToPath);

  const toMapCoordinates = (line) => line.map(([lng, lat]) => wgs84ToGcj02(lng, lat));
  const yangtzeLines = [toMapCoordinates(riverLines.yangtze)];
  const yellowLines = [toMapCoordinates(riverLines.yellow)];

  const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="${viewBox}" preserveAspectRatio="xMidYMid meet" aria-hidden="true">
  <!-- HydroRIVERS v1.0 Asia; WGS84 converted to GCJ-02. Lehner & Grill (2013), DOI 10.1002/hyp.9740. Main-stem reaches selected by outlet IDs ${RIVER_OUTLETS.yangtze} (Yangtze) and ${RIVER_OUTLETS.yellow} (Yellow). -->
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
