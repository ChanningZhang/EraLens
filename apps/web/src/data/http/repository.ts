import {
  DynastyCapitalSchema,
  EntityDetailSchema,
  SearchHitSchema,
  TimelineCatalogSchema,
  TimelineSliceSchema,
  type DynastyCapital,
  type EntityDetail,
  type EntityRef,
  type Event,
  type Person,
  type Reign,
  type SearchHit,
  type TimelineCatalog,
  type TimelineSlice,
} from "@eralens/shared";
import type { TimelineQuery, TimelineRepository } from "../repository";

const API_BASE = import.meta.env.VITE_API_BASE ?? "/api";

async function fetchJson<T>(path: string, schema: { parse: (data: unknown) => T }): Promise<T> {
  const res = await fetch(`${API_BASE}${path}`);
  if (!res.ok) {
    throw new Error(`API error ${res.status}: ${path}`);
  }
  const data = await res.json();
  return schema.parse(data);
}

export const httpRepository: TimelineRepository = {
  async getTimeline(query: TimelineQuery): Promise<TimelineSlice> {
    const params = new URLSearchParams({
      from: String(query.fromAbs),
      to: String(query.toAbs),
      lod: query.lod,
      ...(query.scope ? { scope: query.scope } : {}),
    });
    return fetchJson(`/timeline?${params}`, TimelineSliceSchema);
  },
  async getTimelineCatalog(scope?: string): Promise<TimelineCatalog> {
    const params = new URLSearchParams(scope ? { scope } : {});
    const query = params.toString();
    return fetchJson(
      `/timeline-catalog${query ? `?${query}` : ""}`,
      TimelineCatalogSchema,
    );
  },
  async getEntity(ref: EntityRef, options?: { focusReignId?: string }): Promise<EntityDetail> {
    const params = new URLSearchParams();
    if (options?.focusReignId) {
      params.set("focusReign", options.focusReignId);
    }
    const query = params.toString();
    return fetchJson(
      `/entities/${ref.type}/${ref.id}${query ? `?${query}` : ""}`,
      EntityDetailSchema,
    );
  },
  async search(term: string): Promise<SearchHit[]> {
    const params = new URLSearchParams({ q: term });
    const data = await fetch(`${API_BASE}/search?${params}`);
    if (!data.ok) throw new Error("Search failed");
    const json = await data.json();
    return SearchHitSchema.array().parse(json);
  },
  async getBounds() {
    const res = await fetch(`${API_BASE}/bounds`);
    if (!res.ok) throw new Error("Bounds failed");
    return res.json() as Promise<{ minAbs: number; maxAbs: number }>;
  },
  async getCapitals(fromAbs: number, toAbs: number): Promise<DynastyCapital[]> {
    const params = new URLSearchParams({
      from: String(fromAbs),
      to: String(toAbs),
    });
    return fetchJson(`/capitals?${params}`, DynastyCapitalSchema.array());
  },
  async getPersons(): Promise<Person[]> {
    throw new Error("Not implemented on HTTP repository yet");
  },
  async getReigns(): Promise<Reign[]> {
    throw new Error("Not implemented on HTTP repository yet");
  },
  async getEvents(): Promise<Event[]> {
    throw new Error("Not implemented on HTTP repository yet");
  },
};
