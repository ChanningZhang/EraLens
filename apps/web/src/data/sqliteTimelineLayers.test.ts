import { DatabaseSync } from "node:sqlite";
import { readFileSync, copyFileSync, mkdtempSync, rmSync } from "node:fs";
import { tmpdir } from "node:os";
import path from "node:path";
import { afterEach, describe, expect, it } from "vitest";
import { SqliteTimelineRepository } from "@eralens/data-access/sqlite";
import { absMonth, combineTimelineLayers, ContentVersionMismatchError, resolveFateRelations } from "@eralens/shared";
import versions from "../../../../data/mobile/versions.json";

const connections:DatabaseSync[]=[];
const directories:string[]=[];
afterEach(() => { for(const db of connections.splice(0)) db.close(); for(const dir of directories.splice(0)) rmSync(dir,{recursive:true,force:true}); });
function fixture(onQuery?:(sql:string,db:DatabaseSync)=>void) {
  const db=new DatabaseSync(":memory:"); connections.push(db);
  db.exec(readFileSync(new URL("../../../../data/mobile/schema.sql",import.meta.url),"utf8"));
  const insert=(table:string,row:Record<string,unknown>) => db.prepare(`INSERT INTO ${table} (${Object.keys(row).join(",")}) VALUES (${Object.keys(row).map(()=>"?").join(",")})`).run(...Object.values(row) as (number|string|null)[]);
  for(const [key,value] of Object.entries({schema_version:versions.schemaVersion,contract_version:versions.contractVersion,dataset_version:"v1"})) insert("content_metadata",{key,value:JSON.stringify(value)});
  for(const id of ["a","b"]) insert("dynasties",{id,name:id,scope:"cn",region:"east_asia",start_year:500,start_month:1,end_year:520,end_month:12,start_abs:absMonth(500,1),end_abs:absMonth(520,12),start_confidence:"year",end_confidence:"year",color_token:"ochre"});
  for(const id of ["old","future","ordinary","rival"]) insert("persons",{id,name:id,...(id==="ordinary"?{birth_year:500,birth_month:1,death_year:510,death_month:12}:{})});
  for(const [id,personId,dynastyId,start,end,track] of [["r-old","old","a",502,504,null],["r-next","future","b",507,510,null],["r-rival","rival","b",505,508,"parallel"]] as const) insert("reigns",{id,person_id:personId,dynasty_id:dynastyId,title:personId,start_year:start,start_month:1,end_year:end,end_month:12,start_abs:absMonth(start,1),end_abs:absMonth(end,12),start_confidence:"year",end_confidence:"year",claim_track:track,is_informal_monarch:0});
  insert("events",{id:"event",name:"event",kind:"politics",time_mode:"point",at_year:505,at_month:6,at_day:15,at_confidence:"day",at_abs:absMonth(505,6),links:JSON.stringify([{label:"史料",url:"https://example.org/source"}])});
  insert("entity_associations",{a_type:"dynasty",a_id:"a",b_type:"event",b_id:"event"});
  insert("entity_associations",{a_type:"event",a_id:"event",b_type:"person",b_id:"old"});
  insert("relations",{id:"fate",from_type:"person",from_id:"old",to_type:"person",to_id:"future",kind:"surrender",at_abs:absMonth(505,12)});
  insert("locations",{id:"loc",modern_name:"place",longitude:100,latitude:30,coordinate_system:"WGS84"});
  insert("location_mapping",{id:"mapping",kind:"event",external_id:"event",location_id:"loc",historical_name:"place"});
  let calls=0;
  const repo=new SqliteTimelineRepository({async open(){return {async query(sql,values=[]){calls++;onQuery?.(sql,db);return {values:db.prepare(sql).all(...values as (number|string|null)[]) as Record<string,unknown>[]};},async close(){}};}});
  return {db,repo,calls:()=>calls};
}
const query={fromAbs:absMonth(505,1),toAbs:absMonth(505,12),lod:"month" as const,scope:"cn"};
describe("SQLite timeline layers",() => {
  it("loads past/future fate endpoints without making them ordinary people",async () => {
    const {repo}=fixture();
    const [r,e,p]=await Promise.all([repo.getReignTimeline(query),repo.getEventTimeline(query),repo.getPersonTimeline(query)]);
    expect(r.reigns.map(r=>r.id)).toEqual(["r-rival"]);
    expect(r.context.reigns.map(r=>r.id).sort()).toEqual(["r-next","r-old","r-rival"]);
    const fates=resolveFateRelations(r.relations,r.context.reigns);
    expect(fates.map(f=>[f.fromReign.id,f.toReign.id])).toEqual([["r-old","r-next"]]);
    expect(p.persons.map(p=>p.id)).toEqual(["ordinary"]);
    expect(e.events[0].participantIds).toEqual(["old"]);
    expect(e.events[0].dynastyIds).toEqual(["a"]);
    expect(e.events[0].locationMappings[0].id).toBe("mapping");
    expect(e.events[0].links).toEqual([{label:"史料",url:"https://example.org/source"}]);
    expect((await repo.getEntity({type:"event",id:"event"})).links).toEqual(e.events[0].links);
    expect(combineTimelineLayers(r,e,p)).toEqual(await repo.getTimeline(query));
  });
  it("performs no queries for an empty search or a pre-cancelled request",async () => {
    const {repo,calls}=fixture();
    expect(await repo.search("  ")).toEqual([]);
    const controller=new AbortController();controller.abort();
    await expect(repo.getEventTimeline({...query,signal:controller.signal})).rejects.toThrow();
    expect(calls()).toBe(0);
  });
  it("stops subsequent stages when cancellation arrives during a query",async () => {
    const controller=new AbortController();
    const {repo,calls}=fixture(sql => {if(sql.startsWith("SELECT * FROM dynasties WHERE")) controller.abort();});
    await expect(repo.getReignTimeline({...query,signal:controller.signal})).rejects.toThrow();
    expect(calls()).toBe(2);
  });
  it("retries a version change and rejects a request for an old version",async () => {
    let changed=false;
    const {repo}=fixture((sql,db) => {if(!changed && sql.startsWith("SELECT * FROM dynasties WHERE")){changed=true;db.prepare("UPDATE content_metadata SET value=? WHERE key='dataset_version'").run(JSON.stringify("v2"));}});
    expect((await repo.getReignTimeline(query)).datasetVersion).toBe("v2");
    await expect(repo.getReignTimeline({...query,datasetVersion:"v1"})).rejects.toBeInstanceOf(ContentVersionMismatchError);
  });
  it("bounds retry attempts if the dataset keeps changing",async () => {
    let revision=1;
    const {repo}=fixture((sql,db) => {if(sql.startsWith("SELECT * FROM dynasties WHERE")) db.prepare("UPDATE content_metadata SET value=? WHERE key='dataset_version'").run(JSON.stringify(`v${++revision}`));});
    await expect(repo.getReignTimeline(query)).rejects.toBeInstanceOf(ContentVersionMismatchError);
    expect(revision).toBe(3);
  });
  it("reads an in-place import on a long-lived read-only connection",async () => {
    const directory=mkdtempSync(path.join(tmpdir(),"eralens-query-test-"));directories.push(directory);
    const filename=path.join(directory,"content.sqlite");
    copyFileSync(new URL("../../../../data/mobile/eralens-content.sqlite",import.meta.url),filename);
    const reader=new DatabaseSync(filename,{readOnly:true}),writer=new DatabaseSync(filename);connections.push(reader,writer);
    const repo=new SqliteTimelineRepository({async open(){return {async query(sql,values=[]){return {values:reader.prepare(sql).all(...values as (number|string|null)[]) as Record<string,unknown>[]};},async close(){}};}});
    const before=await repo.getEventTimeline({...query,fromAbs:absMonth(208,1),toAbs:absMonth(208,12)});
    writer.exec("BEGIN IMMEDIATE");
    writer.prepare("UPDATE events SET name=? WHERE id='chibi'").run("updated-test-name");
    writer.prepare("UPDATE content_metadata SET value=? WHERE key='dataset_version'").run(JSON.stringify("updated-test-version"));
    writer.exec("COMMIT");
    const after=await repo.getEventTimeline({...query,fromAbs:absMonth(208,1),toAbs:absMonth(208,12)});
    expect(after.datasetVersion).toBe("updated-test-version");
    expect(before.events.find(e=>e.id==="chibi")?.name).not.toBe("updated-test-name");
    expect(after.events.find(e=>e.id==="chibi")?.name).toBe("updated-test-name");
  });
});
