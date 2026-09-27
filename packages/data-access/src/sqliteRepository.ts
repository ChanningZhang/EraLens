import {
  buildEntityDetail, computeBounds, DynastyCapitalSchema, DynastyGroupSchema,
  DynastyLaneGroupSchema, DynastySchema, EventSchema, EventLocationSchema,
  filterTimeline, fromAbsMonth, normalizeSearchTerm, PersonSchema, RelationSchema, ReignSchema,
  searchEntities, type Dynasty, type DynastyCapital, type DynastyGroup,
  type DynastyLaneGroup, type EntityDetail, type EntityRef, type Event,
  type EventDisplayConfig, type Person, type Reign, type Relation,
  type SearchHit, type TimelineCatalog, type TimelineDataStore, type TimelineSlice,
} from "@eralens/shared";
import { DEFAULT_EVENT_DISPLAY_CONFIG, EventDisplayConfigSchema } from "@eralens/shared";
import type { SqliteDatabaseProvider, TimelineQuery, TimelineRepository } from "./repository";
import { createPlatformSettings } from "./platformSettings";

type Row = Record<string, unknown>;
const own = (row: Row, key: string) => row[key] == null ? undefined : row[key];
const json = <T>(value: unknown, fallback: T): T => {
  if (typeof value !== "string") return (value ?? fallback) as T;
  try { return JSON.parse(value) as T; } catch { return fallback; }
};
const strings = (value: unknown) => json<string[]>(value, []);
const n = (value: unknown) => value == null ? undefined : Number(value);
const bool = (value: unknown) => value == null ? undefined : Boolean(value);
const point = (year: unknown, month: unknown, day?: unknown) => year == null || month == null
  ? undefined
  : { year: Number(year), month: Number(month), ...(day == null ? {} : { day: Number(day) }) };
const csv = (value: unknown) => typeof value === "string" ? value.split(",").map((part) => part.trim()).filter(Boolean) : [];

function mapPerson(row: Row): Person {
  return PersonSchema.parse({
    id: row.id, name: row.name, title: own(row, "title"), altNames: strings(row.alt_names),
    ancestralXing: own(row, "ancestral_xing"), clanShi: own(row, "clan_shi"),
    birth: point(row.birth_year, row.birth_month), death: point(row.death_year, row.death_month),
    roles: strings(row.roles), bio: own(row, "bio"), links: json(row.links, []),
    posthumousNames: csv(row.posthumous_name), templeNames: csv(row.temple_name),
    searchTerms: strings(row.search_terms),
  });
}

function mapDynasty(row: Row): Dynasty {
  return DynastySchema.parse({
    id: row.id, name: row.name, altNames: strings(row.alt_names), scope: row.scope,
    region: row.region, start: point(row.start_year, row.start_month), end: point(row.end_year, row.end_month),
    startAbs: Number(row.start_abs), endAbs: Number(row.end_abs), precision: row.precision,
    colorToken: row.color_token, parentId: own(row, "parent_id"), groupId: own(row, "group_id"), note: own(row, "note"),
  });
}

function mapGroup(row: Row): DynastyGroup {
  return DynastyGroupSchema.parse({
    id: row.id, name: row.name, altNames: strings(row.alt_names), scope: row.scope,
    start: point(row.start_year, row.start_month), end: point(row.end_year, row.end_month),
    startAbs: Number(row.start_abs), endAbs: Number(row.end_abs), precision: row.precision, note: own(row, "note"),
  });
}

function mapLaneGroup(row: Row): DynastyLaneGroup {
  return DynastyLaneGroupSchema.parse({
    id: row.id, primaryDynastyId: row.primary_dynasty_id, phaseDynastyIds: strings(row.phase_dynasty_ids),
    laneOrderStartAbs: Number(row.lane_order_start_abs), laneOrderEndAbs: Number(row.lane_order_end_abs),
  });
}

function mapReign(row: Row): Reign {
  const endAbs = Number(row.end_abs);
  const fallbackEnd = fromAbsMonth(endAbs);
  const claimTrack = own(row, "claim_track");
  return ReignSchema.parse({
    id: row.id, dynastyId: row.dynasty_id, personId: row.person_id, title: row.title,
    eraNames: csv(row.era_names), start: point(row.start_year, row.start_month, row.start_day),
    end: point(row.end_year ?? fallbackEnd.year, row.end_month ?? fallbackEnd.month, row.end_day),
    startAbs: Number(row.start_abs), endAbs, isOngoing: row.end_year == null || row.end_month == null,
    precision: row.precision, startDateConfidence: own(row, "start_date_confidence"),
    endDateConfidence: own(row, "end_date_confidence"), claimTrack, claimLabel: own(row, "claim_label"),
    claimRole: claimTrack || row.claim_role === "rival" ? "rival" : undefined,
    isInformalMonarch: Boolean(row.is_informal_monarch), isMain: row.is_main == null ? undefined : Boolean(row.is_main),
  });
}

function mapLocation(row: Row) {
  return EventLocationSchema.parse({
    id: row.id, historicalName: row.historical_name, modernName: row.modern_name,
    longitude: Number(row.longitude), latitude: Number(row.latitude), coordinateSystem: row.coordinate_system,
    precision: row.precision, note: own(row, "note"), links: json(row.links, []),
  });
}

function mapEvent(row: Row, dynasties: Row[], participants: Row[], location?: ReturnType<typeof mapLocation>): Event {
  return EventSchema.parse({
    id: row.id, name: row.name, kind: row.kind, timeMode: row.time_mode, precision: row.precision,
    isApproximate: Boolean(row.is_approximate), dateNote: own(row, "date_note"),
    at: point(row.at_year, row.at_month, row.at_day), start: point(row.start_year, row.start_month, row.start_day),
    end: point(row.end_year, row.end_month, row.end_day), atAbs: n(row.at_abs), startAbs: n(row.start_abs), endAbs: n(row.end_abs),
    dynastyIds: dynasties.map((link) => String(link.dynasty_id)),
    participantIds: participants.map((link) => String(link.person_id)),
    summary: own(row, "summary"), meaning: own(row, "meaning"), content: own(row, "content"),
    locationId: own(row, "location_id"), location, locations: location ? [location] : [],
  });
}

function mapRelation(row: Row): Relation {
  return RelationSchema.parse({
    id: row.id, fromRef: `${row.from_type}:${row.from_id}`, toRef: `${row.to_type}:${row.to_id}`,
    kind: row.kind, at: point(row.at_year, row.at_month, row.at_day), atAbs: n(row.at_abs),
    precision: own(row, "precision"), eventId: own(row, "event_id"),
  });
}

function mapCapital(row: Row, reignIds: string[]): DynastyCapital {
  return DynastyCapitalSchema.parse({
    id: row.id, dynastyId: row.dynasty_id, historicalName: row.historical_name, modernName: row.modern_name,
    longitude: Number(row.longitude), latitude: Number(row.latitude), coordinateSystem: row.coordinate_system,
    start: point(row.start_year, row.start_month, row.start_day), end: point(row.end_year, row.end_month, row.end_day),
    startAbs: Number(row.start_abs), endAbs: Number(row.end_abs), precision: row.precision,
    endPrecision: own(row, "end_precision"), startDateConfidence: own(row, "start_date_confidence"),
    endDateConfidence: own(row, "end_date_confidence"), role: row.role, claimTrack: own(row, "claim_track"),
    reignIds, note: own(row, "note"), links: json(row.links, []),
  });
}

async function rows(db: Awaited<ReturnType<SqliteDatabaseProvider["open"]>>, sql: string, values: unknown[] = []): Promise<Row[]> {
  return (await db.query(sql, values)).values ?? [];
}

export class SqliteTimelineRepository implements TimelineRepository {
  private dbPromise: ReturnType<SqliteDatabaseProvider["open"]>;
  private storePromise: Promise<TimelineDataStore> | null = null;
  private readonly settings = createPlatformSettings();

  constructor(provider: SqliteDatabaseProvider) { this.dbPromise = provider.open(); }

  private async store(): Promise<TimelineDataStore> {
    if (!this.storePromise) this.storePromise = this.loadStore();
    return this.storePromise;
  }

  private async loadStore(): Promise<TimelineDataStore> {
    const db = await this.dbPromise;
    const metadata = await rows(db, "SELECT key, value FROM content_metadata");
    const meta = new Map<string, unknown>(metadata.map((row) => [String(row.key), JSON.parse(String(row.value)) as unknown]));
    if (!meta.has("schema_version") || !meta.has("contract_version")) throw new Error("SQLite content database has no schema metadata");
    if (meta.get("schema_version") !== 1 || meta.get("contract_version") !== 2) throw new Error("SQLite content database version is not supported by this app");
    const [personsRaw, dynastiesRaw, groupsRaw, lanesRaw, reignsRaw, eventsRaw, dynLinks, participantLinks, locationRaw, relationsRaw, capitalsRaw, capitalLinks] = await Promise.all([
      rows(db, "SELECT * FROM persons"), rows(db, "SELECT * FROM dynasties"), rows(db, "SELECT * FROM dynasty_groups"),
      rows(db, "SELECT * FROM dynasty_lane_groups"), rows(db, "SELECT * FROM reigns"), rows(db, "SELECT * FROM events"),
      rows(db, "SELECT * FROM event_dynasties"), rows(db, "SELECT * FROM event_participants"), rows(db, "SELECT * FROM event_locations"),
      rows(db, "SELECT * FROM relations"), rows(db, "SELECT * FROM dynasty_capitals"), rows(db, "SELECT * FROM reign_capitals"),
    ]);
    const locations = new Map(locationRaw.map((row) => [String(row.id), mapLocation(row)]));
    return {
      persons: personsRaw.map(mapPerson), dynasties: dynastiesRaw.map(mapDynasty),
      dynastyGroups: groupsRaw.map(mapGroup), dynastyLaneGroups: lanesRaw.map(mapLaneGroup),
      reigns: reignsRaw.map(mapReign),
      events: eventsRaw.map((event) => mapEvent(event,
        dynLinks.filter((link) => link.event_id === event.id),
        participantLinks.filter((link) => link.event_id === event.id),
        locations.get(String(event.location_id)))),
      relations: relationsRaw.map(mapRelation),
      capitals: capitalsRaw.map((capital) => mapCapital(capital, capitalLinks.filter((link) => link.capital_id === capital.id).map((link) => String(link.reign_id)))),
    };
  }

  async getTimeline(query: TimelineQuery): Promise<TimelineSlice> {
    const slice = filterTimeline(await this.store(), { fromAbs: query.fromAbs, toAbs: query.toAbs, scope: query.scope });
    return {
      ...slice,
      // searchTerms are an offline search index and are not part of the HTTP timeline DTO.
      persons: slice.persons.map(({ searchTerms: _searchTerms, ...person }) => person),
    };
  }

  async getTimelineCatalog(scope?: string): Promise<TimelineCatalog> {
    const store = await this.store();
    return {
      dynasties: scope ? store.dynasties.filter((item) => item.scope === scope) : store.dynasties,
      dynastyGroups: store.dynastyGroups ?? [], dynastyLaneGroups: store.dynastyLaneGroups ?? [],
    };
  }

  async getEntity(ref: EntityRef, options?: { focusReignId?: string }): Promise<EntityDetail> {
    return buildEntityDetail(await this.store(), ref, { focusReignId: options?.focusReignId });
  }

  async search(term: string): Promise<SearchHit[]> { return searchEntities(await this.store(), term); }

  async getBounds(): Promise<{ minAbs: number; maxAbs: number }> { return computeBounds(await this.store()); }

  async getCapitals(fromAbs: number, toAbs: number): Promise<DynastyCapital[]> {
    const store = await this.store();
    return (store.capitals ?? [])
      .filter((capital) => capital.startAbs <= toAbs && capital.endAbs >= fromAbs)
      .sort((a, b) => a.startAbs - b.startAbs || a.role.localeCompare(b.role) || a.id.localeCompare(b.id));
  }

  async getEventDisplayConfig(): Promise<EventDisplayConfig> {
    const value = await this.settings.get("eralens-event-display");
    return value ? EventDisplayConfigSchema.parse(JSON.parse(value)) : DEFAULT_EVENT_DISPLAY_CONFIG;
  }

  async setEventDisplayConfig(config: EventDisplayConfig): Promise<void> {
    await this.settings.set("eralens-event-display", JSON.stringify(config));
  }

  async close(): Promise<void> { (await this.dbPromise).close(); }
}

export function normalizeSqliteSearchTerm(value: string): string { return normalizeSearchTerm(value); }
