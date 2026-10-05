import { DatabaseSync } from "node:sqlite";
import { performance } from "node:perf_hooks";
import { writeFileSync } from "node:fs";
import { SqliteTimelineRepository } from "@eralens/data-access/sqlite";
import type { EntityRef } from "@eralens/shared";
import { LegacySqliteTimelineRepository } from "./legacySqliteRepository.js";
const db=new DatabaseSync("../../data/mobile/eralens-content.sqlite",{readOnly:true});
const provider={async open(){return {async query(sql:string,values:unknown[]=[]){return {values:db.prepare(sql).all(...values as (number|string|null)[]) as Record<string,unknown>[]};},async close(){}};}};
const results=[];
for(const [mode,repository] of [["before",new LegacySqliteTimelineRepository(provider)],["after",new SqliteTimelineRepository(provider)]] as const) {
  const lookup=repository as unknown as {personDetailContext(ref:EntityRef):Promise<unknown>};
  for(let i=0;i<10;i++) await lookup.personDetailContext({type:"person",id:"li-longji"});
  const measurements=[];
  for(let i=0;i<200;i++){const start=performance.now();await lookup.personDetailContext({type:"person",id:"li-longji"});measurements.push(performance.now()-start);}
  const sorted=[...measurements].sort((a,b)=>a-b);
  results.push({mode,median:sorted[100],p95:sorted[189],min:sorted[0],max:sorted.at(-1),measurements});
}
writeFileSync("../../docs/performance/detail-context.json",JSON.stringify({node:process.version,sqlite:db.prepare("SELECT sqlite_version() AS v").get()!.v,warmup:10,samples:200,results},null,2)+"\n");
console.log(JSON.stringify(results.map(({measurements,...rest})=>rest)));db.close();
