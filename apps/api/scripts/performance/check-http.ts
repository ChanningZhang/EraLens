import { DatabaseSync } from "node:sqlite";
import assert from "node:assert/strict";
import Fastify from "fastify";
import { writeFileSync } from "node:fs";
import { SqliteTimelineRepository } from "@eralens/data-access/sqlite";
import { combineTimelineLayers, ReignTimelineSchema, EventTimelineSchema, PersonTimelineSchema, absMonth } from "@eralens/shared";
import { registerRoutes } from "../../src/routes/index.js";
const db = new DatabaseSync("../../data/mobile/eralens-content.sqlite",{readOnly:true});
const repository = new SqliteTimelineRepository({async open(){return {async query(sql,values=[]){return {values:db.prepare(sql).all(...values as (number|string|null)[]) as Record<string,unknown>[]};},async close(){}};}});
const app=Fastify();
const metadata = Object.fromEntries(db.prepare("SELECT key,value FROM content_metadata").all().map(r=>[String(r.key),JSON.parse(String(r.value))]));
await app.register(async api => registerRoutes(api,repository,{async get(){return null;},async set(){}},async()=>({datasetVersion:metadata.dataset_version,schemaVersion:metadata.schema_version,contractVersion:metadata.contract_version})),{prefix:"/api"});
let checks=0;
for(const [start,end] of [[750,750],[304,439],[1368,2026]]) {
  const params=`from=${absMonth(start,1)}&to=${absMonth(end,12)}&lod=month&scope=cn&datasetVersion=${metadata.dataset_version}`;
  const responses=await Promise.all(["reigns","events","persons"].map(layer=>app.inject(`/api/timeline/${layer}?${params}`)));
  for(const response of responses){assert.equal(response.statusCode,200);checks++;}
  const data=combineTimelineLayers(ReignTimelineSchema.parse(responses[0].json()),EventTimelineSchema.parse(responses[1].json()),PersonTimelineSchema.parse(responses[2].json()));
  assert.deepEqual(JSON.parse(JSON.stringify(data)),JSON.parse(JSON.stringify(await repository.getTimeline({fromAbs:absMonth(start,1),toAbs:absMonth(end,12),lod:"month",scope:"cn"}))));checks++;
}
for(const layer of ["reigns","events","persons"]) {
  for(const query of ["","from=2&to=1","from=foo&to=12","from=1&to=12&lod=invalid"]) {assert.equal((await app.inject(`/api/timeline/${layer}?${query}`)).statusCode,400);checks++;}
  assert.equal((await app.inject(`/api/timeline/${layer}?from=1&to=12&datasetVersion=old`)).statusCode,409);checks++;
}
assert.equal((await app.inject("/api/health")).json().datasetVersion,metadata.dataset_version);checks++;
console.log(JSON.stringify({status:"ok",checks}));
writeFileSync("../../docs/performance/http-correctness.json",JSON.stringify({status:"ok",checks},null,2)+"\n");
await app.close();db.close();
