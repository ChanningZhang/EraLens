import { mapEntityAssociation, eventAssociationIds, type EntityAssociation } from "@eralens/shared";
import {
  buildEntityDetail, computeBounds, DynastyGroupSchema,
  DynastySchema, EventSchema, mapLocation, mapLocationMapping, filterLocationMappings,
  filterTimeline, fromAbsMonth, normalizeSearchTerm, PersonSchema, RelationSchema, ReignSchema,
  confidencePrecision,
  searchEntities, type Dynasty, type LocationMappingQuery, type LocationMapping, type Location, type DynastyGroup,
type EntityDetail, type EntityRef, type Event,
  type EventDisplayConfig, type Person, type Reign, type Relation,
  type SearchHit, type TimelineCatalog, type TimelineDataStore, type TimelineSlice,
} from "@eralens/shared";
import { DEFAULT_EVENT_DISPLAY_CONFIG, EventDisplayConfigSchema } from "@eralens/shared";
import type { SqliteDatabaseProvider, TimelineQuery, TimelineRepository } from "./repository";
import { createPlatformSettings } from "./platformSettings";

type Row = Record<string, unknown>;
type PersonDetailContext = {
  person: Person;
  reign?: Reign;
  reignIndex?: number;
  reignCount: number;
};
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
    birth: point(row.birth_year, row.birth_month, row.birth_day) ? { ...point(row.birth_year, row.birth_month, row.birth_day), confidence: own(row, "birth_confidence") } : undefined,
    death: point(row.death_year, row.death_month, row.death_day) ? { ...point(row.death_year, row.death_month, row.death_day), confidence: own(row, "death_confidence") } : undefined,
    roles: strings(row.roles), bio: own(row, "bio"), links: json(row.links, []),
    posthumousNames: csv(row.posthumous_name), templeNames: csv(row.temple_name),
    searchTerms: strings(row.search_terms),
  });
}

function mapDynasty(row: Row): Dynasty {
  return DynastySchema.parse({
    id: row.id, name: row.name, altNames: strings(row.alt_names), scope: row.scope,
    region: row.region, start: { ...point(row.start_year, row.start_month, row.start_day), confidence: row.start_confidence }, end: { ...point(row.end_year, row.end_month, row.end_day), confidence: row.end_confidence },
    startAbs: Number(row.start_abs), endAbs: Number(row.end_abs), precision: confidencePrecision((row.start_confidence ?? "year") as Parameters<typeof confidencePrecision>[0]), startConfidence: row.start_confidence, endConfidence: row.end_confidence,
    colorToken: row.color_token, parentId: own(row, "parent_id"), groupId: own(row, "group_id"), note: own(row, "note"),
  });
}

function mapGroup(row: Row): DynastyGroup {
  return DynastyGroupSchema.parse({
    id: row.id, name: row.name, altNames: strings(row.alt_names), scope: row.scope,
    start: { ...point(row.start_year, row.start_month, row.start_day), confidence: row.start_confidence }, end: { ...point(row.end_year, row.end_month, row.end_day), confidence: row.end_confidence },
    startAbs: Number(row.start_abs), endAbs: Number(row.end_abs), precision: confidencePrecision((row.start_confidence ?? "year") as Parameters<typeof confidencePrecision>[0]), startConfidence: row.start_confidence, endConfidence: row.end_confidence, note: own(row, "note"),
  });
}


function mapReign(row: Row): Reign {
  const endAbs = Number(row.end_abs);
  const fallbackEnd = fromAbsMonth(endAbs);
  const claimTrack = own(row, "claim_track");
  return ReignSchema.parse({
    id: row.id, dynastyId: row.dynasty_id, personId: row.person_id, title: row.title,
    eraNames: csv(row.era_names), start: { ...point(row.start_year, row.start_month, row.start_day), confidence: row.start_confidence },
    end: { ...point(row.end_year ?? fallbackEnd.year, row.end_month ?? fallbackEnd.month, row.end_day), confidence: row.end_confidence },
    startAbs: Number(row.start_abs), endAbs, isOngoing: row.end_year == null || row.end_month == null,
    precision: confidencePrecision((row.start_confidence ?? "year") as Parameters<typeof confidencePrecision>[0]), startConfidence: row.start_confidence, endConfidence: row.end_confidence,
    claimTrack, claimLabel: own(row, "claim_label"),
    claimRole: claimTrack || row.claim_role === "rival" ? "rival" : undefined,
    isInformalMonarch: Boolean(row.is_informal_monarch), isMain: row.is_main == null ? undefined : Boolean(row.is_main),
  });
}

function mapEvent(row: Row, associations: readonly EntityAssociation[], locationMappings: LocationMapping[] = []): Event {
  return EventSchema.parse({
    id: row.id, name: row.name, kind: row.kind, timeMode: row.time_mode, precision: confidencePrecision((row.at_confidence ?? row.start_confidence ?? "year") as Parameters<typeof confidencePrecision>[0]), atConfidence: own(row, "at_confidence"), startConfidence: own(row, "start_confidence"), endConfidence: own(row, "end_confidence"), dateNote: own(row, "date_note"),
    at: point(row.at_year, row.at_month, row.at_day) ? { ...point(row.at_year, row.at_month, row.at_day), confidence: own(row, "at_confidence") } : undefined,
    start: point(row.start_year, row.start_month, row.start_day) ? { ...point(row.start_year, row.start_month, row.start_day), confidence: own(row, "start_confidence") } : undefined,
    end: point(row.end_year, row.end_month, row.end_day) ? { ...point(row.end_year, row.end_month, row.end_day), confidence: own(row, "end_confidence") } : undefined,
    atAbs: n(row.at_abs), startAbs: n(row.start_abs), endAbs: n(row.end_abs),
    ...eventAssociationIds(String(row.id),associations),
    summary: own(row, "summary"), meaning: own(row, "meaning"), content: own(row, "content"),
    locationMappings,
  });
}

function mapRelation(row: Row): Relation {
  return RelationSchema.parse({
    id: row.id, fromRef: `${row.from_type}:${row.from_id}`, toRef: `${row.to_type}:${row.to_id}`,
    kind: row.kind, at: point(row.at_year, row.at_month, row.at_day), atAbs: n(row.at_abs),
    atConfidence: own(row, "at_confidence"), eventId: own(row, "event_id"),
  });
}

async function rows(db: Awaited<ReturnType<SqliteDatabaseProvider["open"]>>, sql: string, values: unknown[] = []): Promise<Row[]> {
  return (await db.query(sql, values)).values ?? [];
}

export class SqliteTimelineRepository implements TimelineRepository {
  private dbPromise: ReturnType<SqliteDatabaseProvider["open"]> | null = null;
  private storePromise: Promise<TimelineDataStore> | null = null;
  private readonly settings = createPlatformSettings();

  constructor(private readonly provider: SqliteDatabaseProvider) {}

  private database(): ReturnType<SqliteDatabaseProvider["open"]> {
    if (!this.dbPromise) {
      const opening = this.provider.open();
      const recoverable = opening.catch((error) => {
        if (this.dbPromise === recoverable) this.dbPromise = null;
        throw error;
      });
      this.dbPromise = recoverable;
    }
    return this.dbPromise;
  }

  private async store(): Promise<TimelineDataStore> {
    if (!this.storePromise) {
      const loading = this.loadStore();
      const recoverable = loading.catch((error) => {
        if (this.storePromise === recoverable) this.storePromise = null;
        throw error;
      });
      this.storePromise = recoverable;
    }
    return this.storePromise;
  }

  private async loadStore(): Promise<TimelineDataStore> {
    const db = await this.database();
    const metadata = await rows(db, "SELECT key, value FROM content_metadata");
    const meta = new Map<string, unknown>(metadata.map((row) => [String(row.key), JSON.parse(String(row.value)) as unknown]));
    if (!meta.has("schema_version") || !meta.has("contract_version")) throw new Error("SQLite content database has no schema metadata");
    if (meta.get("schema_version") !== 5 || meta.get("contract_version") !== 6) throw new Error("SQLite content database version is not supported by this app");
    const [personsRaw, dynastiesRaw, groupsRaw, reignsRaw, eventsRaw, associationRows, mappingRaw, relationsRaw] = await Promise.all([
      rows(db, "SELECT * FROM persons"), rows(db, "SELECT * FROM dynasties"), rows(db, "SELECT * FROM dynasty_groups"),
      rows(db, "SELECT * FROM reigns"), rows(db, "SELECT * FROM events"),
      rows(db, "SELECT * FROM entity_associations"), rows(db, "SELECT m.*, json_object('id',l.id,'modern_name',l.modern_name,'longitude',l.longitude,'latitude',l.latitude,'coordinate_system',l.coordinate_system) AS location FROM location_mapping m JOIN locations l ON l.id=m.location_id"),
      rows(db, "SELECT * FROM relations"),
    ]);
    const locationMappings=filterLocationMappings(mappingRaw.map(mapLocationMapping),{});
    const associations=associationRows.map(mapEntityAssociation);
    return {
      persons: personsRaw.map(mapPerson), dynasties: dynastiesRaw.map(mapDynasty),
      dynastyGroups: groupsRaw.map(mapGroup),
      reigns: reignsRaw.map(mapReign),
      events: eventsRaw.map((event) => mapEvent(event, associations,
        locationMappings.filter(m=>m.kind === "event" && m.externalId===event.id))),
      relations: relationsRaw.map(mapRelation),
      associations,
      locationMappings,
    };
  }

  /** SQLite counterpart of the API's person-detail context query. */
  private async personDetailContext(
    ref: EntityRef,
    focusReignId?: string,
  ): Promise<PersonDetailContext[] | undefined> {
    if (ref.type !== "person" && ref.type !== "reign") return undefined;
    const db = await this.database();
    const personId = ref.type === "person" ? ref.id : null;
    const requestedReignId = ref.type === "reign" ? ref.id : focusReignId ?? null;
    const result = await rows(db, `
      WITH request(person_id, focus_reign_id) AS (VALUES (?, ?)),
      target_person AS (
        SELECT p.id
        FROM persons p
        CROSS JOIN request request_row
        WHERE p.id = COALESCE(
          request_row.person_id,
          (SELECT r.person_id FROM reigns r WHERE r.id = request_row.focus_reign_id)
        )
          AND (
            request_row.focus_reign_id IS NULL
            OR EXISTS (
              SELECT 1 FROM reigns r
              WHERE r.id = request_row.focus_reign_id AND r.person_id = p.id
            )
          )
      ),
      ranked_reigns AS (
        SELECT r.*,
               ROW_NUMBER() OVER (
                 ORDER BY r.start_abs, COALESCE(r.start_day, 1), r.id
               ) AS reign_index,
               COUNT(*) OVER () AS reign_count
        FROM reigns r
        JOIN target_person tp ON tp.id = r.person_id
      )
      SELECT json_object(
               'id', p.id, 'name', p.name, 'title', p.title,
               'alt_names', p.alt_names,
               'ancestral_xing', p.ancestral_xing, 'clan_shi', p.clan_shi,
               'birth_year', p.birth_year, 'birth_month', p.birth_month, 'birth_day', p.birth_day,
               'birth_confidence', p.birth_confidence,
               'death_year', p.death_year, 'death_month', p.death_month, 'death_day', p.death_day,
               'death_confidence', p.death_confidence,
               'roles', p.roles, 'bio', p.bio, 'links', p.links,
               'posthumous_name', p.posthumous_name,
               'temple_name', p.temple_name,
               'search_terms', p.search_terms
             ) AS person_json,
             CASE WHEN rr.id IS NULL THEN NULL ELSE json_object(
               'id', rr.id, 'dynasty_id', rr.dynasty_id,
               'person_id', rr.person_id, 'title', rr.title,
               'era_names', rr.era_names,
               'start_year', rr.start_year, 'start_month', rr.start_month,
               'start_day', rr.start_day,
               'start_confidence', rr.start_confidence,
               'end_year', rr.end_year, 'end_month', rr.end_month,
               'end_day', rr.end_day,
               'end_confidence', rr.end_confidence,
               'start_abs', rr.start_abs, 'end_abs', rr.end_abs,
               'claim_track', rr.claim_track, 'claim_label', rr.claim_label,
               'claim_role', rr.claim_role,
               'is_informal_monarch', rr.is_informal_monarch,
               'is_main', rr.is_main
             ) END AS reign_json,
             rr.reign_index,
             COALESCE(rr.reign_count, 0) AS reign_count
      FROM target_person tp
      JOIN persons p ON p.id = tp.id
      CROSS JOIN request request_row
      LEFT JOIN ranked_reigns rr
        ON (request_row.focus_reign_id IS NULL OR rr.id = request_row.focus_reign_id)
      ORDER BY rr.reign_index
    `, [personId, requestedReignId]);
    return result.map((row) => ({
      person: mapPerson(json<Row>(row.person_json, {})),
      ...(row.reign_json == null
        ? {}
        : { reign: mapReign(json<Row>(row.reign_json, {})) }),
      ...(row.reign_index == null ? {} : { reignIndex: Number(row.reign_index) }),
      reignCount: Number(row.reign_count),
    }));
  }

  async getTimeline(query: TimelineQuery): Promise<TimelineSlice> {
    if (query.signal?.aborted) throw query.signal.reason ?? new DOMException("Timeline query cancelled", "AbortError");
    const store = await this.store();
    if (query.signal?.aborted) throw query.signal.reason ?? new DOMException("Timeline query cancelled", "AbortError");
    const slice = filterTimeline(store, { fromAbs: query.fromAbs, toAbs: query.toAbs, scope: query.scope });
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
      dynastyGroups: store.dynastyGroups ?? [],
    };
  }

  async getEntity(ref: EntityRef, options?: { focusReignId?: string; atAbs?: number }): Promise<EntityDetail> {
    const store = await this.store();
    const context = await this.personDetailContext(ref, options?.focusReignId);
    if (context && context.length === 0) throw new Error(`Entity not found: ${ref.id}`);
    const contextPerson = context?.[0]?.person;
    const contextReigns = context?.flatMap((row) => row.reign ? [row.reign] : []) ?? [];
    const contextReignById = new Map(contextReigns.map((reign) => [reign.id, reign]));
    const detailStore = contextPerson
      ? {
          ...store,
          persons: store.persons.map((person) =>
            person.id === contextPerson.id ? contextPerson : person,
          ),
          reigns: store.reigns.map((reign) => contextReignById.get(reign.id) ?? reign),
        }
      : store;
    return buildEntityDetail(
      detailStore,
      ref,
      {
        atAbs: options?.atAbs,
        focusReignId: ref.type === "reign" ? ref.id : options?.focusReignId,
        selectedReignIds: contextReigns.map((reign) => reign.id),
        focusReignIndex: context?.[0]?.reignIndex,
        reignCount: context?.[0]?.reignCount,
      },
    );
  }

  async search(term: string): Promise<SearchHit[]> { return searchEntities(await this.store(), term); }

  async getBounds(): Promise<{ minAbs: number; maxAbs: number }> { return computeBounds(await this.store()); }

  async getLocations(): Promise<Location[]> {
    return (await rows(await this.database(),"SELECT * FROM locations ORDER BY id")).map(mapLocation);
  }
  async getLocationMappings(query: LocationMappingQuery = {}): Promise<LocationMapping[]> {
    const store=await this.store();
    return filterLocationMappings(store.locationMappings ?? [],query,store.events);
  }

  async getEventDisplayConfig(): Promise<EventDisplayConfig> {
    const value = await this.settings.get("eralens-event-display");
    return value ? EventDisplayConfigSchema.parse(JSON.parse(value)) : DEFAULT_EVENT_DISPLAY_CONFIG;
  }

  async setEventDisplayConfig(config: EventDisplayConfig): Promise<void> {
    await this.settings.set("eralens-event-display", JSON.stringify(config));
  }

  async close(): Promise<void> {
    const database = this.dbPromise;
    this.dbPromise = null;
    this.storePromise = null;
    if (database) await (await database).close();
  }
}

export function normalizeSqliteSearchTerm(value: string): string { return normalizeSearchTerm(value); }
