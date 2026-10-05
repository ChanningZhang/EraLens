import {
  LocationSchema, LocationMappingSchema,
  EntityDetailSchema,
  EventDisplayConfigSchema,
  SearchHitSchema,
  TimelineCatalogSchema,
  TimelineSliceSchema,
  type Location, type LocationMapping, type LocationMappingQuery,
  type EntityDetail,
  type EntityRef,
  type EventDisplayConfig,
  type SearchHit,
  type TimelineCatalog,
  type TimelineSlice,
  ReignTimelineSchema, EventTimelineSchema, PersonTimelineSchema, ContentVersionMismatchError,
  type ReignTimeline, type EventTimeline, type PersonTimeline,
} from "@eralens/shared";
import type { TimelineQuery, TimelineRepository } from "./repository";

export class HttpTimelineRepository implements TimelineRepository {
  constructor(private readonly apiBase = "/api") {}

  private async fetchJson<T>(
    path: string,
    schema: { parse: (data: unknown) => T },
    signal?: AbortSignal,
  ): Promise<T> {
    const response = await fetch(`${this.apiBase}${path}`, { signal });
    if (response.status === 409) throw new ContentVersionMismatchError();
    if (!response.ok) throw new Error(`API error ${response.status}: ${path}`);
    return schema.parse(await response.json());
  }

  async getDatasetVersion(): Promise<string> {
    const response = await fetch(`${this.apiBase}/health`);
    if (!response.ok) throw new Error("Unable to read content version");
    const value = await response.json() as {datasetVersion?:unknown};
    if (typeof value.datasetVersion !== "string") throw new Error("Invalid content version");
    return value.datasetVersion;
  }

  private layerParams(query: TimelineQuery) {
    return new URLSearchParams({ from:String(query.fromAbs), to:String(query.toAbs), lod:query.lod,
      ...(query.scope ? {scope:query.scope} : {}), ...(query.datasetVersion ? {datasetVersion:query.datasetVersion} : {}) });
  }
  getReignTimeline(query: TimelineQuery): Promise<ReignTimeline> {
    return this.fetchJson(`/timeline/reigns?${this.layerParams(query)}`,ReignTimelineSchema,query.signal);
  }
  getEventTimeline(query: TimelineQuery): Promise<EventTimeline> {
    return this.fetchJson(`/timeline/events?${this.layerParams(query)}`,EventTimelineSchema,query.signal);
  }
  getPersonTimeline(query: TimelineQuery): Promise<PersonTimeline> {
    return this.fetchJson(`/timeline/persons?${this.layerParams(query)}`,PersonTimelineSchema,query.signal);
  }

  getTimeline(query: TimelineQuery): Promise<TimelineSlice> {
    const params = new URLSearchParams({
      from: String(query.fromAbs), to: String(query.toAbs), lod: query.lod,
      ...(query.scope ? { scope: query.scope } : {}),
    });
    return this.fetchJson(`/timeline?${params}`, TimelineSliceSchema, query.signal);
  }

  getTimelineCatalog(scope?: string): Promise<TimelineCatalog> {
    const query = new URLSearchParams(scope ? { scope } : "").toString();
    return this.fetchJson(`/timeline-catalog${query ? `?${query}` : ""}`, TimelineCatalogSchema);
  }

  getEntity(ref: EntityRef, options?: { focusReignId?: string; atAbs?: number }): Promise<EntityDetail> {
    const params = new URLSearchParams();
    if (options?.focusReignId) params.set("focusReign", options.focusReignId);
    if (options?.atAbs != null) params.set("atAbs", String(options.atAbs));
    const query = params.toString();
    return this.fetchJson(`/entities/${ref.type}/${encodeURIComponent(ref.id)}${query ? `?${query}` : ""}`, EntityDetailSchema);
  }

  async search(term: string): Promise<SearchHit[]> {
    const params = new URLSearchParams({ q: term });
    const response = await fetch(`${this.apiBase}/search?${params}`);
    if (!response.ok) throw new Error("Search failed");
    return SearchHitSchema.array().parse(await response.json());
  }

  async getBounds(): Promise<{ minAbs: number; maxAbs: number }> {
    const response = await fetch(`${this.apiBase}/bounds`);
    if (!response.ok) throw new Error("Bounds failed");
    const value = await response.json() as { minAbs?: unknown; maxAbs?: unknown };
    if (typeof value.minAbs !== "number" || !Number.isFinite(value.minAbs) ||
        typeof value.maxAbs !== "number" || !Number.isFinite(value.maxAbs)) {
      throw new Error("Bounds response is invalid");
    }
    return { minAbs: value.minAbs, maxAbs: value.maxAbs };
  }

  getLocations(): Promise<Location[]> { return this.fetchJson("/locations",LocationSchema.array()); }
  getLocationMappings(query: LocationMappingQuery = {}): Promise<LocationMapping[]> {
    const params=new URLSearchParams();
    for(const [key,value] of Object.entries(query)) if(value != null) params.set(key === "fromAbs" ? "from" : key === "toAbs" ? "to" : key,String(value));
    return this.fetchJson(`/location-mappings?${params}`,LocationMappingSchema.array());
  }

  async getEventDisplayConfig(): Promise<EventDisplayConfig> {
    return this.fetchJson("/settings/events", EventDisplayConfigSchema);
  }

  async setEventDisplayConfig(config: EventDisplayConfig): Promise<void> {
    const response = await fetch(`${this.apiBase}/settings/events`, {
      method: "PUT", headers: { "content-type": "application/json" }, body: JSON.stringify(config),
    });
    if (!response.ok) throw new Error("Event display settings could not be saved");
  }
}
