import { filterTimeline, type TimelineDataStore, type TimelineFilterQuery } from "./timelineData";
import type { EventTimeline, PersonTimeline, ReignTimeline, TimelineSlice, Person } from "./schema";
import { isFateRelationKind } from "./reignFateRelations";

export class ContentVersionMismatchError extends Error {
  constructor() { super("Content dataset changed while loading timeline"); this.name = "ContentVersionMismatchError"; }
}

/** SQL candidates may include whole months; exact intersection stays in shared rules. */
export function timelineCandidateWindow(query: TimelineFilterQuery) {
  return { fromAbs: Math.floor(query.fromAbs), toAbs: Math.floor(query.toAbs) };
}

/** Endpoint captions need names/appellations, not full biographies and source links. */
export function timelineContextPerson(person: Person): Person {
  return { id:person.id,name:person.name,title:person.title,ancestralXing:person.ancestralXing,
    clanShi:person.clanShi,posthumousNames:person.posthumousNames,templeNames:person.templeNames,
    altNames:[],roles:[],links:[] };
}

export function reignTimelineFromStore(store: TimelineDataStore, query: TimelineFilterQuery, datasetVersion: string): ReignTimeline {
  const visible = filterTimeline(store, query);
  const dynastyIds = new Set(visible.dynasties.map(d => d.id));
  const personIds = new Set(visible.reigns.map(r => r.personId));
  // A relation may name an earlier or upcoming reign outside the visible chunk.
  const fatePersonIds = new Set<string>();
  const explicitReigns = new Set<string>();
  for (const relation of visible.relations) {
    for (const ref of [relation.fromRef, relation.toRef]) {
      if (ref.startsWith("person:")) fatePersonIds.add(ref.slice(7));
      if (ref.startsWith("reign:")) explicitReigns.add(ref.slice(6));
    }
  }
  for (const reign of store.reigns) {
    if (fatePersonIds.has(reign.personId) || explicitReigns.has(reign.id)) dynastyIds.add(reign.dynastyId);
  }
  const contextReigns = store.reigns.filter(r => dynastyIds.has(r.dynastyId));
  const contextPersonIds = new Set(contextReigns.map(r => r.personId));
  const publicPerson = ({searchTerms: _terms, ...person}: TimelineDataStore["persons"][number]) => person;
  return {
    datasetVersion, dynasties: visible.dynasties, dynastyGroups: visible.dynastyGroups,
    reigns: visible.reigns, persons: store.persons.filter(p => personIds.has(p.id)).map(publicPerson),
    relations: visible.relations.filter(r => isFateRelationKind(r.kind)),
    context: { dynasties: store.dynasties.filter(d => dynastyIds.has(d.id)), reigns: contextReigns,
      persons: store.persons.filter(p => contextPersonIds.has(p.id)).map(timelineContextPerson) },
  };
}

/** Ordinary people are classified against all reigns, never just viewport reigns. */
export function personTimelineFromStore(store: TimelineDataStore, query: TimelineFilterQuery, datasetVersion: string): PersonTimeline {
  const rulers = new Set(store.reigns.map(r => r.personId));
  return { datasetVersion, persons: filterTimeline(store, query).persons.filter(p => !rulers.has(p.id) && !p.roles.includes("君主"))
    .map(({searchTerms: _terms, ...person}) => person) };
}

export function combineTimelineLayers(reigns: ReignTimeline, events?: EventTimeline, persons?: PersonTimeline): TimelineSlice {
  if ((events && events.datasetVersion !== reigns.datasetVersion) || (persons && persons.datasetVersion !== reigns.datasetVersion)) throw new ContentVersionMismatchError();
  return { dynasties: reigns.dynasties, dynastyGroups: reigns.dynastyGroups, reigns: reigns.reigns,
    relations: reigns.relations, events: events?.events ?? [],
    persons: [...new Map([...reigns.persons, ...(persons?.persons ?? [])].map(p => [p.id,p])).values()] };
}

export function mergeReignTimelineChunks(chunks: readonly ReignTimeline[]): ReignTimeline {
  if (!chunks.length) throw new Error("No reign chunks to merge");
  const version = chunks[0].datasetVersion;
  if (chunks.some(c => c.datasetVersion !== version)) throw new ContentVersionMismatchError();
  const unique = <T extends {id:string}>(items: T[]) => [...new Map(items.map(i => [i.id,i])).values()];
  return { datasetVersion:version,
    dynasties:unique(chunks.flatMap(c => c.dynasties)), dynastyGroups:unique(chunks.flatMap(c => c.dynastyGroups)),
    reigns:unique(chunks.flatMap(c => c.reigns)), persons:unique(chunks.flatMap(c => c.persons)), relations:unique(chunks.flatMap(c => c.relations)),
    context:{dynasties:unique(chunks.flatMap(c => c.context.dynasties)),reigns:unique(chunks.flatMap(c => c.context.reigns)),persons:unique(chunks.flatMap(c => c.context.persons))} };
}
