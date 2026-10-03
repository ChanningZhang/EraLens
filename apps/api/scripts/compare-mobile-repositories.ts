import { DatabaseSync } from "node:sqlite";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { absMonth } from "@eralens/shared";
import { HttpTimelineRepository, SqliteTimelineRepository } from "@eralens/data-access";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..");
const databasePath = path.resolve(root, process.argv.find((arg) => arg.startsWith("--db="))?.slice(5) ?? "data/mobile/eralens-content.sqlite");
const apiBase = process.argv.find((arg) => arg.startsWith("--api="))?.slice(6) ?? "http://localhost:3001/api";
const windows = [
  [-1046, -771], [-1, 1], [220, 280], [420, 589], [581, 907], [960, 1279], [1368, 1912], [1912, 2026],
] as const;
const lods = ["month", "decade", "century", "millennium"] as const;
const unorderedIdArrays = new Set(["dynasties", "dynastyGroups", "dynastyLaneGroups", "reigns", "events", "persons", "relations"]);
const canonical = (value: unknown, parentKey = ""): unknown => {
  if (Array.isArray(value)) {
    const ordered = unorderedIdArrays.has(parentKey) && value.every((item) => item && typeof item === "object" && "id" in item)
      ? [...value].sort((a, b) => String((a as { id: unknown }).id).localeCompare(String((b as { id: unknown }).id)))
      : value;
    return ordered.map((item) => canonical(item));
  }
  if (value && typeof value === "object") {
    const record = value as Record<string, unknown>;
    return Object.fromEntries(Object.keys(record).sort().map((key) => [key, canonical(record[key], key)]));
  }
  return value;
};
const normalize = (value: unknown) => JSON.stringify(canonical(value));
function firstDifference(a: unknown, b: unknown, pathName = "$" ): string {
  const left = canonical(a);
  const right = canonical(b);
  if (JSON.stringify(left) === JSON.stringify(right)) return "";
  if (left && right && typeof left === "object" && typeof right === "object") {
    if (Array.isArray(left) && Array.isArray(right)) {
      for (let index = 0; index < Math.max(left.length, right.length); index++) {
        if (JSON.stringify(left[index]) !== JSON.stringify(right[index])) return firstDifference(left[index], right[index], `${pathName}[${index}]`);
      }
    } else {
      const keys = new Set([...Object.keys(left), ...Object.keys(right)]);
      for (const key of keys) if (JSON.stringify((left as Record<string, unknown>)[key]) !== JSON.stringify((right as Record<string, unknown>)[key])) return firstDifference((left as Record<string, unknown>)[key], (right as Record<string, unknown>)[key], `${pathName}.${key}`);
    }
  }
  return `${pathName}: ${JSON.stringify(left)} !== ${JSON.stringify(right)}`;
}

const sqliteRepository = new SqliteTimelineRepository({
  async open() {
    const db = new DatabaseSync(databasePath, { readOnly: true });
    return {
      async query(sql, values = []) {
        return { values: db.prepare(sql).all(...values as (null | number | bigint | string | Uint8Array)[]) as Record<string, unknown>[] };
      },
      async close() { db.close(); },
    };
  },
});
const httpRepository = new HttpTimelineRepository(apiBase);
if (process.argv.includes("--sqlite-only")) {
  try {
    const bounds = await sqliteRepository.getBounds();
    const catalog = await sqliteRepository.getTimelineCatalog("cn");
    const slice = await sqliteRepository.getTimeline({
      fromAbs: absMonth(-1046, 1), toAbs: absMonth(-771, 12), lod: "month", scope: "cn",
    });
    const capitals = await sqliteRepository.getLocationMappings({kind:"dynasty",fromAbs:absMonth(600, 1),toAbs:absMonth(900, 12)});
    const search = await sqliteRepository.search("李隆基");
    const detail = await sqliteRepository.getEntity({ type: "person", id: "li-longji" });
    console.log(JSON.stringify({ status: "ok", bounds, catalogDynasties: catalog.dynasties.length, zhou: {
      dynasties: slice.dynasties.length, reigns: slice.reigns.length, events: slice.events.length,
      persons: slice.persons.length, relations: slice.relations.length,
    }, tangCapitals: capitals.length, searchHits: search.length, detailTitle: detail.title }, null, 2));
  } finally { await sqliteRepository.close(); }
  process.exit(0);
}
let compared = 0;
function compare(label: string, httpValue: unknown, sqliteValue: unknown) {
  if (normalize(httpValue) !== normalize(sqliteValue)) {
    throw new Error(`Repository contract mismatch: ${label}\n${firstDifference(httpValue, sqliteValue)}`);
  }
  compared++;
}

try {
  const [httpCatalog, sqliteCatalog] = await Promise.all([httpRepository.getTimelineCatalog("cn"), sqliteRepository.getTimelineCatalog("cn")]);
  compare("catalog:cn", httpCatalog, sqliteCatalog);
  const [httpBounds, sqliteBounds] = await Promise.all([httpRepository.getBounds(), sqliteRepository.getBounds()]);
  compare("bounds", httpBounds, sqliteBounds);

  compare("locations",await httpRepository.getLocations(),await sqliteRepository.getLocations());
  for (const query of [{}, {kind:"reign" as const, externalId:"reign-jin-r12-jin-chunqiu"}, {kind:"event" as const}, {kind:"event" as const, fromAbs:absMonth(1900,1),toAbs:absMonth(1950,12)}]) {
    compare(`mappings:${JSON.stringify(query)}`,await httpRepository.getLocationMappings(query),await sqliteRepository.getLocationMappings(query));
  }

  for (const [index, [startYear, endYear]] of windows.entries()) {
    const fromAbs = absMonth(startYear, 1);
    const toAbs = absMonth(endYear, 12);
    const [httpCaps, sqliteCaps] = await Promise.all([
      httpRepository.getLocationMappings({kind:"dynasty",fromAbs,toAbs}), sqliteRepository.getLocationMappings({kind:"dynasty",fromAbs,toAbs}),
    ]);
    compare(`capitals:${index}`, httpCaps, sqliteCaps);
    for (const lod of lods) {
      const query = { fromAbs, toAbs, lod, scope: "cn" };
      const [httpSlice, sqliteSlice] = await Promise.all([
        httpRepository.getTimeline(query), sqliteRepository.getTimeline(query),
      ]);
      compare(`timeline:${index}:${lod}`, httpSlice, sqliteSlice);
    }
  }

  for (const term of ["唐", "李隆基", "长安", "开元", "赤壁"]) {
    const [httpHits, sqliteHits] = await Promise.all([httpRepository.search(term), sqliteRepository.search(term)]);
    compare(`search:${term}`, httpHits, sqliteHits);
  }

  const refs = [
    { type: "dynasty", id: "tang" }, { type: "reign", id: "reign-li-longji" },
    { type: "person", id: "li-longji" }, { type: "event", id: "banquan-zhulu" },
    { type: "location_mapping", id: "cap-tang-changan" },
    { type: "location_mapping", id: "map-reign:reign-jin-r12-jin-chunqiu:cap-jin-chunqiu-quwo" },
    { type: "reign", id: "reign-jin-r12-jin-chunqiu" },
  ] as const;
  for (const ref of refs) {
    const [httpDetail, sqliteDetail] = await Promise.all([httpRepository.getEntity(ref), sqliteRepository.getEntity(ref)]);
    compare(`entity:${ref.type}:${ref.id}`, httpDetail, sqliteDetail);
  }
  console.log(JSON.stringify({ status: "ok", compared, windows: windows.length, lods: lods.length }, null, 2));
} finally {
  await sqliteRepository.close();
}
