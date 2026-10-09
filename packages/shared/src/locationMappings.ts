import { LocationSchema, LocationMappingSchema, type Location, type LocationMapping, type CapitalLocation, type Reign, type LocationKind } from "./schema";
import { confidencePrecision } from "./historicalDate";
export type LocationMappingQuery = { kind?: LocationKind; externalId?: string; locationId?: string; fromAbs?: number; toAbs?: number };
type Row = Record<string, unknown>;
const decode = (v: unknown): unknown => typeof v === "string" ? JSON.parse(v) : v;
const camel = (r: Row): Row => Object.fromEntries(Object.entries(r).map(([k,v]) => [k.replace(/_([a-z])/g,(_,c:string)=>c.toUpperCase()),v]));
export function mapLocation(row: unknown): Location {
  const r=camel(row as Row);
  return LocationSchema.parse({...r, longitude:Number(r.longitude), latitude:Number(r.latitude)});
}
export function mapLocationMapping(row: unknown): LocationMapping {
  const r=camel(row as Row);
  const point=(edge:string) => r[edge+"Year"] == null ? undefined : {year:r[edge+"Year"], month:r[edge+"Month"], ...(r[edge+"Day"] == null ? {} : {day:r[edge+"Day"]}), confidence:r[edge+"Confidence"]};
  return LocationMappingSchema.parse({...r, location:mapLocation(decode(r.location)),
    start:r.start ?? point("start"), end:r.end ?? point("end"),
    startAbs:r.startAbs ?? undefined, endAbs:r.endAbs ?? undefined,
    startConfidence:r.startConfidence ?? undefined, endConfidence:r.endConfidence ?? undefined,
    spatialPrecision:r.spatialPrecision ?? undefined, role:r.role ?? undefined, note:r.note ?? undefined, links:decode(r.links ?? [])});
}
/** A rendering/interval projection, never a second persisted geographic record. */
export function projectCapitalLocations(mappings: readonly LocationMapping[], reigns: readonly Reign[]): CapitalLocation[] {
  const byReign=new Map(reigns.map(r=>[r.id,r]));
  return mappings.flatMap(m=>{
    if(m.kind === "event" || !m.start || !m.end || m.startAbs == null || m.endAbs == null || !m.role) return [];
    const reign=m.kind === "reign" ? byReign.get(m.externalId) : undefined;
    if(m.kind === "reign" && !reign) return [];
    return [{...m.location, id:m.id, mappingKind:m.kind, dynastyId:reign?.dynastyId ?? m.externalId,
      historicalName:m.historicalName, start:m.start, end:m.end, startAbs:m.startAbs, endAbs:m.endAbs,
      startConfidence:m.startConfidence, endConfidence:m.endConfidence,
      precision:confidencePrecision(m.start.confidence ?? m.startConfidence ?? "year"),
      endPrecision:confidencePrecision(m.end.confidence ?? m.endConfidence ?? "year"),
      role:m.role, claimTrack:reign?.claimTrack, dynastyName:reign?.dynastyName,
      reignIds:reign ? [reign.id] : [], note:m.note, links:m.links}];
  });
}
export function capitalLocations(store: {locationMappings?: readonly LocationMapping[]; reigns: readonly Reign[]}): CapitalLocation[] {
  return projectCapitalLocations(store.locationMappings ?? [],store.reigns);
}
export function filterLocationMappings(mappings: readonly LocationMapping[], query: LocationMappingQuery, events: readonly {id:string;atAbs?:number;startAbs?:number;endAbs?:number}[] = []): LocationMapping[] {
  const byEvent=new Map(events.map(e=>[e.id,e]));
  return mappings.filter(m=>{
    if(query.kind && m.kind !== query.kind || query.externalId && m.externalId !== query.externalId || query.locationId && m.locationId !== query.locationId) return false;
    const e=m.kind === "event" ? byEvent.get(m.externalId) : undefined;
    const start=e ? e.atAbs ?? e.startAbs : m.startAbs; const end=e ? e.atAbs ?? e.endAbs : m.endAbs;
    return (query.fromAbs == null || end != null && end >= query.fromAbs) && (query.toAbs == null || start != null && start <= query.toAbs);
  }).sort((a,b)=>(a.startAbs ?? 0)-(b.startAbs ?? 0) || (a.role ?? "").localeCompare(b.role ?? "") || (a.id < b.id ? -1 : a.id > b.id ? 1 : 0));
}
