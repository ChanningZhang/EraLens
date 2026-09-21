import type {
  DynastyCapital,
  EntityDetail,
  EntityRef,
  Event,
  Lod,
  Person,
  Reign,
  SearchHit,
  TimelineCatalog,
  TimelineSlice,
} from "@eralens/shared";

export interface TimelineQuery {
  fromAbs: number;
  toAbs: number;
  scope?: string;
  lod: Lod;
}

export interface TimelineRepository {
  getTimeline(q: TimelineQuery): Promise<TimelineSlice>;
  getTimelineCatalog(scope?: string): Promise<TimelineCatalog>;
  getEntity(ref: EntityRef, options?: { focusReignId?: string }): Promise<EntityDetail>;
  search(term: string): Promise<SearchHit[]>;
  getBounds(): Promise<{ minAbs: number; maxAbs: number }>;
  getCapitals(fromAbs: number, toAbs: number): Promise<DynastyCapital[]>;
  getPersons(): Promise<Person[]>;
  getReigns(): Promise<Reign[]>;
  getEvents(): Promise<Event[]>;
}

export async function createRepository(): Promise<TimelineRepository> {
  const source = import.meta.env.VITE_DATA_SOURCE ?? "http";
  if (source === "http") {
    return (await import("./http/repository")).httpRepository;
  }
  return (await import("./mock/repository")).mockRepository;
}

let repositoryPromise: Promise<TimelineRepository> | null = null;

export function getRepository(): Promise<TimelineRepository> {
  if (!repositoryPromise) {
    repositoryPromise = createRepository();
  }
  return repositoryPromise;
}
