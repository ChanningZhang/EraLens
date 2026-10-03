/** Idempotency probe for an isolated database, never the live database. */
import {readFileSync} from "node:fs";
import {spawnSync} from "node:child_process";
const database=process.argv.find(arg=>arg.startsWith('--db='))?.slice(5);
if(!database || !/^eralens_locations_\w+$/.test(database)) throw new Error('Pass --db=eralens_locations_<isolated database>');
const run=(input)=>{
  const result=spawnSync('docker',['exec','-i','eralens-postgres','psql','-U','eralens','-d',database,'-v','ON_ERROR_STOP=1','-qAt'],{input,encoding:'utf8'});
  if(result.status!==0) throw new Error(result.stderr);
  return result.stdout.trim();
};
const checksum=`SELECT json_build_object('locations',(SELECT count(*) FROM locations),'mappings',(SELECT count(*) FROM location_mapping),'checksum',md5((SELECT string_agg(to_jsonb(l)::text,'|' ORDER BY id) FROM locations l)||(SELECT string_agg(to_jsonb(m)::text,'|' ORDER BY id) FROM location_mapping m)));`;
const apply=()=>{for(const slug of ['locations','dynasty-capitals','reign-capitals','event-locations']) run(readFileSync(`data/imports/${slug}/import.sql`,'utf8'));};
apply();const first=run(checksum);apply();const second=run(checksum);
if(first!==second) throw new Error(`Incremental import changed on second application: ${first} / ${second}`);
console.log(JSON.stringify({status:'ok',...JSON.parse(second)},null,2));
