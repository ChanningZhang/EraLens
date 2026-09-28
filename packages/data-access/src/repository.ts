import type {
  DynastyCapital,
  EntityDetail,
  EntityRef,
  EventDisplayConfig,
  Lod,
  SearchHit,
  TimelineCatalog,
  TimelineSlice,
} from "@eralens/shared";

export interface TimelineQuery {
  fromAbs: number;
  toAbs: number;
  scope?: string;
  lod: Lod;
  /** Lets viewport changes cancel HTTP work that is no longer visible. */
  signal?: AbortSignal;
}

export interface TimelineRepository {
  getTimeline(query: TimelineQuery): Promise<TimelineSlice>;
  getTimelineCatalog(scope?: string): Promise<TimelineCatalog>;
  getEntity(ref: EntityRef, options?: { focusReignId?: string }): Promise<EntityDetail>;
  search(term: string): Promise<SearchHit[]>;
  getBounds(): Promise<{ minAbs: number; maxAbs: number }>;
  getCapitals(fromAbs: number, toAbs: number): Promise<DynastyCapital[]>;
  getEventDisplayConfig(): Promise<EventDisplayConfig>;
  setEventDisplayConfig(config: EventDisplayConfig): Promise<void>;
}

export interface SqliteDatabase {
  query(sql: string, values?: unknown[]): Promise<{ values?: Record<string, unknown>[] }>;
  close(): Promise<void>;
}

export interface SqliteDatabaseProvider {
  open(): Promise<SqliteDatabase>;
}
