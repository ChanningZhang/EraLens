import type {
  Location, LocationMapping, LocationMappingQuery,
  EntityDetail,
  EntityRef,
  EventDisplayConfig,
  Lod,
  SearchHit,
  TimelineCatalog,
  TimelineSlice,
  ReignTimeline, EventTimeline, PersonTimeline,
} from "@eralens/shared";

export interface TimelineQuery {
  fromAbs: number;
  toAbs: number;
  scope?: string;
  lod: Lod;
  /** Lets viewport changes cancel HTTP work that is no longer visible. */
  signal?: AbortSignal;
  datasetVersion?: string;
}

export interface TimelineRepository {
  getDatasetVersion(): Promise<string>;
  getReignTimeline(query: TimelineQuery): Promise<ReignTimeline>;
  getEventTimeline(query: TimelineQuery): Promise<EventTimeline>;
  getPersonTimeline(query: TimelineQuery): Promise<PersonTimeline>;
  getTimeline(query: TimelineQuery): Promise<TimelineSlice>;
  getTimelineCatalog(scope?: string): Promise<TimelineCatalog>;
  getEntity(ref: EntityRef, options?: { focusReignId?: string; atAbs?: number }): Promise<EntityDetail>;
  search(term: string): Promise<SearchHit[]>;
  getBounds(): Promise<{ minAbs: number; maxAbs: number }>;
  getLocations(): Promise<Location[]>;
  getLocationMappings(query?: LocationMappingQuery): Promise<LocationMapping[]>;
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

export interface SettingsStore {
  get(key: string): Promise<string | null>;
  set(key: string, value: string): Promise<void>;
}

export interface NativeAppContentInfo {
  platform: "ios" | "mac";
  protocolVersion: 1;
  datasetVersion: string;
  schemaVersion: number;
  contractVersion: number;
  sourceGitSha: string;
  builtAt: string;
  appVersion: string;
  appBuild: string;
}

export interface EraLensNativeBridge {
  platform: "ios" | "mac";
  protocolVersion: 1;
  query(sql: string, values: unknown[]): Promise<{ values?: Record<string, unknown>[] }>;
  closeDatabase(): Promise<void>;
  getSetting(key: string): Promise<string | null>;
  setSetting(key: string, value: string): Promise<void>;
  getContentInfo(): Promise<NativeAppContentInfo>;
  openExternal(options: { url: string }): Promise<void>;
}

declare global {
  interface Window {
    eralensNative?: EraLensNativeBridge;
  }
}
