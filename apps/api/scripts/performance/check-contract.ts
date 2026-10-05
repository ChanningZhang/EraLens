import { DatabaseSync } from "node:sqlite";
import { writeFileSync } from "node:fs";
import { isDeepStrictEqual } from "node:util";
import { SqliteTimelineRepository } from "@eralens/data-access/sqlite";
import { absMonth, combineTimelineLayers, resolveFateRelations, mergeTimelineSlices } from "@eralens/shared";
import type { EntityRef, TimelineSlice } from "@eralens/shared";
import { LegacySqliteTimelineRepository } from "./legacySqliteRepository.js";
const db=new DatabaseSync("../../data/mobile/eralens-content.sqlite",{readOnly:true});
const provider={async open(){return {async query(sql:string,values:unknown[]=[]){return {values:db.prepare(sql).all(...values as (string|number|null)[]) as Record<string,unknown>[]};},async close(){}};}};
const before=new LegacySqliteTimelineRepository(provider),after=new SqliteTimelineRepository(provider);
let compared=0;
function canonical(v:unknown,key=""):unknown {
  if(Array.isArray(v)) {
    const ordered=["dynasties","dynastyGroups","reigns","events","persons","relations"].includes(key) && v.every(i => i && typeof i === "object" && "id" in i)
      ? [...v].sort((a,b)=>String(a.id).localeCompare(String(b.id))) : v;
    return ordered.map(i=>canonical(i));
  }
  if(v && typeof v==="object") return Object.fromEntries(Object.entries(v).sort(([a],[b])=>a.localeCompare(b)).map(([k,x])=>[k,canonical(x,k)]));
  return v;
}
function check(name:string,a:unknown,b:unknown){
  if(!isDeepStrictEqual(canonical(a),canonical(b))) {writeFileSync("../../docs/performance/contract-failure.json",JSON.stringify({name,before:a,after:b},null,2));throw new Error(`Mismatch: ${name}; see docs/performance/contract-failure.json`);} compared++;
}
check("bounds",await before.getBounds(),await after.getBounds());
for(const scope of [undefined,"cn","other"]) check(`catalog:${scope}`,await before.getTimelineCatalog(scope),await after.getTimelineCatalog(scope));
const periods=[[-1100,-1000],[-685,-650],[-1046,-771],[-1,1],[220,280],[304,439],[420,589],[581,907],[960,1279],[1368,1912],[1912,2026],[750,750]];
for (const [a,b] of periods) for(const fraction of [0,.25,.95]) {
  const query={fromAbs:absMonth(a,1)+fraction,toAbs:absMonth(b,12)+fraction,lod:"month" as const,scope:"cn"};
  const original=await before.getTimeline(query);
  check(`timeline:${a}:${b}:${fraction}`,original,await after.getTimeline(query));
  const [r,e,p]=await Promise.all([after.getReignTimeline(query),after.getEventTimeline(query),after.getPersonTimeline(query)]);
  check(`split:${a}:${b}:${fraction}`,mergeTimelineSlices([original]),combineTimelineLayers(r,e,p));
  const dbReigns=(await (before as unknown as {loadStore():Promise<{reigns:TimelineSlice["reigns"]}>}).loadStore()).reigns;
  const fullFates=resolveFateRelations(r.relations,dbReigns).map(f=>[f.relation.id,f.fromReign.id,f.toReign.id]);
  const splitFates=resolveFateRelations(r.relations,r.context.reigns).map(f=>[f.relation.id,f.fromReign.id,f.toReign.id]);
  check(`fates:${a}:${b}:${fraction}`,fullFates,splitFates);
}
for(const term of ["","唐","李隆基","太宗","唐太宗","李 白","姜子牙","杜甫","建隆","开元","赤壁","长安","西安","蒙古帝国","元","吴","明","南明","战争","盛世","忠","%","_"]) check(`search:${term}`,await before.search(term),await after.search(term));
for(const query of [{},{kind:"reign" as const,externalId:"reign-li-longji"},{kind:"event" as const},{kind:"event" as const,fromAbs:absMonth(1900,1),toAbs:absMonth(1950,12)},{fromAbs:absMonth(700,1),toAbs:absMonth(799,12)},{locationId:"no-location"}]) check(`mappings:${JSON.stringify(query)}`,await before.getLocationMappings(query),await after.getLocationMappings(query));
check("locations",await before.getLocations(),await after.getLocations());
const explicit:EntityRef[]=[{type:"person",id:"du-fu"},{type:"person",id:"li-longji"},{type:"person",id:"zhu-qizhen"},{type:"person",id:"zhu-yuanzhang"},{type:"person",id:"temujin"},{type:"person",id:"tolui"},{type:"dynasty",id:"tang"},{type:"dynasty",id:"yuan"},{type:"dynasty",id:"daxi"},{type:"reign",id:"reign-li-longji"},{type:"event",id:"chibi"},{type:"event",id:"idiom-wan-bi-gui-zhao"},{type:"location_mapping",id:"cap-tang-changan"},{type:"location_mapping",id:"map-reign:reign-jin-r12-jin-chunqiu:cap-jin-chunqiu-quwo"}];
for (const [type,table] of [["person","persons"],["reign","reigns"],["dynasty","dynasties"],["event","events"],["location_mapping","location_mapping"]] as const) {
  const records=db.prepare(`SELECT id FROM ${table} ORDER BY id`).all();
  for(let i=0;i<records.length;i+=Math.max(1,Math.floor(records.length/20))) explicit.push({type,id:String(records[i].id)});
}
for(const ref of explicit) check(`detail:${ref.type}:${ref.id}`,await before.getEntity(ref),await after.getEntity(ref));
for(const personId of ["zhu-qizhen","zhu-yuanzhang","li-longji"]) for(const row of db.prepare("SELECT id FROM reigns WHERE person_id=?").all(personId)) check(`focus:${personId}:${row.id}`,await before.getEntity({type:"person",id:personId},{focusReignId:String(row.id)}),await after.getEntity({type:"person",id:personId},{focusReignId:String(row.id)}));
for(const [ref,options] of [[{type:"person",id:"du-fu"},{focusReignId:"reign-li-longji"}],[{type:"person",id:"missing"},undefined],[{type:"reign",id:"missing"},undefined]] as const) {
  const old=await before.getEntity(ref,options).then(()=>false,()=>true),next=await after.getEntity(ref,options).then(()=>false,()=>true);check(`missing:${ref.id}`,old,next);
}
const cases=[...db.prepare("SELECT id FROM persons").all().map(p=>[{type:"person",id:String(p.id)},undefined]),...db.prepare("SELECT id,person_id FROM reigns").all().flatMap(r=>[[{type:"reign",id:String(r.id)},undefined],[{type:"person",id:String(r.person_id)},String(r.id)]])];
for(const [ref,focus] of cases) check(`context:${JSON.stringify(ref)}:${focus}`,await (before as any).personDetailContext(ref,focus),await (after as any).personDetailContext(ref,focus));
console.log(JSON.stringify({status:"ok",compared}));
writeFileSync("../../docs/performance/correctness.json",JSON.stringify({status:"ok",compared,periods,terms:23,detailCases:explicit.length,contextCases:cases.length},null,2)+"\n");
db.close();
