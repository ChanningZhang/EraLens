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
    if (!response.ok) throw new Error(`API error ${response.status}: ${path}`);
    return schema.parse(await response.json());
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

  getEntity(ref: EntityRef, options?: { focusReignId?: string }): Promise<EntityDetail> {
    const params = new URLSearchParams();
    if (options?.focusReignId) params.set("focusReign", options.focusReignId);
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
