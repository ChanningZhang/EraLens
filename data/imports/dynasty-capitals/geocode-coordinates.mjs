#!/usr/bin/env node
/**
 * Geocode all missing modernName values via Amap MCP maps_geo (1.5s between calls).
 * Merges coordinates-seed.json + newly geocoded → coordinates.json
 */
import { readFileSync, writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const MCP_URL =
  process.env.AMAP_MCP_URL ??
  "https://mcp.amap.com/mcp?key=19d798984baa30ad057664f886e6edcd";
const DELAY_MS = 1500;

const FOREIGN = {
  朝鲜民主主义人民共和国平壤市: { longitude: 125.7625, latitude: 39.0392 },
  蒙古国前杭爱省哈拉巴尔嘎斯: { longitude: 102.833, latitude: 47.197 },
  蒙古国前杭爱省哈拉和林苏木: { longitude: 102.848, latitude: 47.197 },
  吉尔吉斯斯坦楚河州托克马克市: { longitude: 75.279, latitude: 42.848 },
};

function cityHint(address) {
  const muni = address.match(/^(北京市|上海市|天津市|重庆市)$/);
  if (muni) return muni[1];
  const afterProv = address.replace(/^[^省]+省/, "").replace(/^[^区]+自治区/, "");
  const city = afterProv.match(/^(.+?市)/);
  if (city) return city[1];
  const league = afterProv.match(/^(.+?盟)/);
  if (league) return league[1];
  return afterProv.slice(0, 6) || address;
}

async function mapsGeo(address) {
  const res = await fetch(MCP_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json, text/event-stream",
    },
    body: JSON.stringify({
      jsonrpc: "2.0",
      id: 1,
      method: "tools/call",
      params: {
        name: "maps_geo",
        arguments: { address, city: cityHint(address) },
      },
    }),
  });
  const data = await res.json();
  if (data.error) throw new Error(data.error.message ?? JSON.stringify(data.error));
  const text = data.result?.content?.[0]?.text;
  if (!text) throw new Error("empty MCP response");
  const parsed = JSON.parse(text);
  const hit = parsed.results?.[0];
  if (!hit?.location) throw new Error("no geocode result");
  const [longitude, latitude] = hit.location.split(",").map(Number);
  return { longitude, latitude, level: hit.level, formatted: `${hit.province}${hit.city}${hit.district ?? ""}` };
}

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

const raw = JSON.parse(readFileSync(path.join(__dirname, "capitals-raw.json"), "utf8"));
const seed = JSON.parse(readFileSync(path.join(__dirname, "coordinates-seed.json"), "utf8"));
const allNames = [...new Set(raw.map((r) => r.modernName))].sort();

const coords = { ...seed, ...FOREIGN };
const failures = [];

for (const name of allNames) {
  if (coords[name]) continue;
  try {
    const result = await mapsGeo(name);
    coords[name] = { longitude: result.longitude, latitude: result.latitude };
    console.log(`OK  ${name} → ${result.longitude}, ${result.latitude} (${result.level})`);
  } catch (err) {
    failures.push({ name, error: String(err.message ?? err) });
    console.error(`FAIL ${name}: ${err.message ?? err}`);
  }
  await sleep(DELAY_MS);
}

const out = {};
for (const name of allNames) {
  if (coords[name]) out[name] = coords[name];
}

writeFileSync(path.join(__dirname, "coordinates.json"), `${JSON.stringify(out, null, 2)}\n`);

console.log("\n--- Summary ---");
console.log(`Unique modernName: ${allNames.length}`);
console.log(`Coordinates written: ${Object.keys(out).length}`);
console.log(`Failures: ${failures.length}`);
if (failures.length) {
  for (const f of failures) console.log(`  - ${f.name}: ${f.error}`);
}
process.exit(failures.length ? 1 : 0);
