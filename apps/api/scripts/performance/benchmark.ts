import { DatabaseSync } from "node:sqlite";
import { performance } from "node:perf_hooks";
import { writeFileSync, statSync } from "node:fs";
import os from "node:os";
import path from "node:path";
import Fastify from "fastify";
import { SqliteTimelineRepository } from "@eralens/data-access/sqlite";
import type { TimelineRepository, SqliteDatabaseProvider } from "@eralens/data-access/repository";
import { absMonth } from "@eralens/shared";
import { registerRoutes } from "../../src/routes/index.js";
import { LegacySqliteTimelineRepository } from "./legacySqliteRepository.js";

const baseline = process.argv.includes("--baseline");
const samples = Number(process.argv.find(a => a.startsWith("--samples="))?.split("=")[1] ?? 200);
const output = path.resolve(process.argv.find(a => a.startsWith("--output="))?.slice(9) ?? `../../docs/performance/${baseline ? "before" : "after"}.json`);
const filename = path.resolve(process.argv.find(a => a.startsWith("--db="))?.slice(5) ?? "../../data/mobile/eralens-content.sqlite");
const db = new DatabaseSync(filename, { readOnly: true });
const metadata = Object.fromEntries(db.prepare("SELECT key,value FROM content_metadata").all().map(r => [String(r.key), JSON.parse(String(r.value))]));
const seenSql = new Map<string, unknown[]>();
let counters = { queries: 0, rows: 0, sqlMs: 0 };
const provider: SqliteDatabaseProvider = { async open() { return {
  async query(sql, values = []) {
    seenSql.set(sql, values);
    const start = performance.now();
    const result = db.prepare(sql).all(...values as (string | number | null)[]);
    counters.queries++; counters.rows += result.length; counters.sqlMs += performance.now() - start;
    return { values: result };
  }, async close() {},
}; } };
const createRepository = () => (baseline ? new LegacySqliteTimelineRepository(provider) : new SqliteTimelineRepository(provider)) as unknown as TimelineRepository;
const repository = createRepository();
const windows = [
  { name: "year-750", fromAbs: absMonth(750, 1), toAbs: absMonth(750, 12), lod: "month" as const, scope: "cn" },
  { name: "century-700", fromAbs: absMonth(700, 1), toAbs: absMonth(799, 12), lod: "century" as const, scope: "cn" },
  { name: "dense-304-439", fromAbs: absMonth(304, 1), toAbs: absMonth(439, 12), lod: "century" as const, scope: "cn" },
  { name: "wide-1368-2026", fromAbs: absMonth(1368, 1), toAbs: absMonth(2026, 12), lod: "millennium" as const, scope: "cn" },
];
type Measurement = { ms: number; queries: number; rows: number; sqlMs: number; bytes: number };
const records: Record<string, unknown>[] = [];
const queryPlans: {sql:string;details:unknown[]}[] = [];
const report = { startedAt: new Date().toISOString(), finishedAt: "", queryPlans, mode: baseline ? "before" : "after", samples, warmup: 10,
  environment: { node: process.version, sqlite: db.prepare("SELECT sqlite_version() AS version").get()!.version,
    platform: os.platform(), arch: os.arch(), cpu: os.cpus()[0]?.model, databaseBytes: statSync(filename).size, metadata },
  records,
};
function summary(values: number[]) {
  const sorted = [...values].sort((a,b) => a-b);
  return { median: sorted[Math.floor(sorted.length / 2)], p95: sorted[Math.ceil(sorted.length * .95) - 1], min: sorted[0], max: sorted.at(-1) };
}
async function measure(name: string, operation: () => Promise<unknown>, count = samples) {
  for (let i = 0; i < 10; i++) await operation();
  const measurements: Measurement[] = [];
  for (let i = 0; i < count; i++) {
    counters = { queries: 0, rows: 0, sqlMs: 0 };
    const start = performance.now(); const value = await operation(); const ms = performance.now() - start;
    measurements.push({ ms, ...counters, bytes: Buffer.byteLength(JSON.stringify(value)) });
  }
  const result = { name, ...Object.fromEntries(["ms", "queries", "rows", "sqlMs", "bytes"].map(key => [key, summary(measurements.map(m => m[key as keyof Measurement]))])), measurements };
  records.push(result); writeFileSync(output, JSON.stringify(report, null, 2) + "\n");
  console.log(JSON.stringify({ name, ms: summary(measurements.map(m => m.ms)), rows: measurements[0].rows, queries: measurements[0].queries }));
}

// A new repository/connection path is distinct from an OS-cold disk cache.
await measure("repository:first-connection", async () => {
  const connection = new DatabaseSync(filename, { readOnly: true });
  const repo = (baseline ? new LegacySqliteTimelineRepository({ async open() { return { async query(sql, values=[]) {
    const start=performance.now(); const valuesOut=connection.prepare(sql).all(...values as (string|number|null)[]);
    counters.queries++; counters.rows+=valuesOut.length; counters.sqlMs+=performance.now()-start; return { values: valuesOut };
  },async close() {} }; } }) : new SqliteTimelineRepository({ async open() { return { async query(sql, values=[]) {
    const start=performance.now(); const valuesOut=connection.prepare(sql).all(...values as (string|number|null)[]);
    counters.queries++; counters.rows+=valuesOut.length; counters.sqlMs+=performance.now()-start; return { values: valuesOut };
  },async close() {} }; } }));
  try { return await repo.getTimeline(windows[0]); } finally { connection.close(); }
}, 20);
for (const window of windows) {
  await measure(`repository:timeline:${window.name}`, () => repository.getTimeline(window));
  if (!baseline) {
    await measure(`repository:reigns:${window.name}`, () => repository.getReignTimeline(window));
    await measure(`repository:events:${window.name}`, () => repository.getEventTimeline(window));
    await measure(`repository:persons:${window.name}`, () => repository.getPersonTimeline(window));
    await measure(`repository:split-all:${window.name}`, () => Promise.all([repository.getReignTimeline(window), repository.getEventTimeline(window), repository.getPersonTimeline(window)]));
  }
}
for (const term of ["", "李隆基", "唐", "开元", "长安", "赤壁"]) await measure(`repository:search:${term || "empty"}`, () => repository.search(term));
await measure("repository:detail:li-longji", () => repository.getEntity({ type:"person", id:"li-longji" }));
await measure("repository:detail:tang", () => repository.getEntity({ type:"dynasty", id:"tang" }));
await measure("repository:catalog", () => repository.getTimelineCatalog("cn"));
await measure("repository:bounds", () => repository.getBounds());
await measure("repository:mappings", () => repository.getLocationMappings({ kind:"reign", externalId:"reign-li-longji" }));
await measure("repository:locations", () => repository.getLocations());

const app = Fastify({ logger: false });
await app.register(async api => registerRoutes(api, repository, { async get(){return null;}, async set(){} }, async () => ({ datasetVersion:metadata.dataset_version, schemaVersion:metadata.schema_version, contractVersion:metadata.contract_version })), { prefix:"/api" });
await app.listen({ host:"127.0.0.1", port:0 });
const origin=app.listeningOrigin;
async function request(url: string) { const response=await fetch(origin+url); if (!response.ok) throw new Error(`${url}: ${response.status} ${await response.text()}`); return response.json(); }
const urls = windows.map(w => `/api/timeline?from=${w.fromAbs}&to=${w.toAbs}&lod=${w.lod}&scope=cn`);
const splitUrls = (index:number, persons=true) => ["reigns","events",...(persons?["persons"]:[])].map(layer => urls[index].replace("/timeline?",`/timeline/${layer}?`));
for (const [index,w] of windows.entries()) {
  await measure(`http:timeline:${w.name}`, () => request(urls[index]));
  if (!baseline) await measure(`http:split-all:${w.name}`, () => Promise.all(splitUrls(index).map(request)));
}
async function measureClients(name:string,operation:()=>Promise<unknown>,concurrency:number) {
  for(let i=0;i<10;i++) await Promise.all(Array.from({length:concurrency},operation));
  const measurements:Measurement[]=[];
  const batches:number[]=[];
  for(let completed=0;completed<samples;completed+=concurrency) {
    counters={queries:0,rows:0,sqlMs:0};
    const count=Math.min(concurrency,samples-completed),start=performance.now();
    const results=await Promise.all(Array.from({length:count},async()=>{const t=performance.now();const value=await operation();return {ms:performance.now()-t,bytes:Buffer.byteLength(JSON.stringify(value))};}));
    batches.push(performance.now()-start);
    for(const result of results) measurements.push({...result,queries:counters.queries/count,rows:counters.rows/count,sqlMs:counters.sqlMs/count});
  }
  records.push({name,concurrency,batchMs:summary(batches),...Object.fromEntries(["ms","queries","rows","sqlMs","bytes"].map(key=>[key,summary(measurements.map(m=>m[key as keyof Measurement]))])),measurements});
  writeFileSync(output,JSON.stringify(report,null,2)+"\n");
  console.log(JSON.stringify({name,ms:summary(measurements.map(m=>m.ms)),batchMs:summary(batches)}));
}
for (const concurrency of [5,10]) {
  await measureClients(`http:timeline:concurrency-${concurrency}`, () => request(urls[0]),concurrency);
  if (!baseline) await measureClients(`http:split-all:concurrency-${concurrency}`, () => Promise.all(splitUrls(0).map(request)),concurrency);
}
await measure("http:persons-hidden", () => baseline ? request(urls[3]) : Promise.all(splitUrls(3,false).map(request)));
// 200 frame requests through a repeating sequence of ten viewport windows; no browser cache.
let panIndex=0;
await measure("http:pan", async () => {
  const i=panIndex++ % 10,from=absMonth(700+i*10,1),to=absMonth(710+i*10,1);
  const query=`from=${from}&to=${to}&lod=month&scope=cn`;
  return baseline ? request(`/api/timeline?${query}`) : await Promise.all(["reigns","events","persons"].map(layer => request(`/api/timeline/${layer}?${query}`)));
});
await app.close();
for (const [sql,values] of seenSql) {
  if (sql.includes("WITH request") || sql.includes("search_entries") || sql.includes("FROM dynasties WHERE") || sql.includes("FROM events WHERE") || sql.includes("FROM persons p WHERE") || sql === "SELECT * FROM persons" || sql.includes("m.external_id IN") || sql.includes("FROM reigns WHERE dynasty_id")) {
    queryPlans.push({sql:sql.replace(/\s+/g," ").trim(),details:db.prepare("EXPLAIN QUERY PLAN " + sql).all(...values as (string|number|null)[]).map(r=>r.detail)});
  }
}
const finalVersion = JSON.parse(String(db.prepare("SELECT value FROM content_metadata WHERE key='dataset_version'").get()!.value));
if (finalVersion !== metadata.dataset_version) throw new Error("Database changed during benchmark");
report.finishedAt = new Date().toISOString();
writeFileSync(output,JSON.stringify(report,null,2)+"\n");
db.close();
