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

  private async capitalsForEntity(
    ref: EntityRef,
    store: TimelineDataStore,
  ): Promise<DynastyCapital[]> {
    const db = await this.dbPromise;
    let where: string;
    let values: unknown[];

    if (ref.type === "capital") {
      where = "dc.id = ?";
      values = [ref.id];
    } else if (ref.type === "dynasty") {
      where = "dc.dynasty_id = ?";
      values = [ref.id];
    } else if (ref.type === "person" || ref.type === "reign") {
      const personId = ref.type === "person"
        ? ref.id
        : store.reigns.find((reign) => reign.id === ref.id)?.personId;
      if (!personId) return [];

      // Match the API detail route: a person's reign-capital context includes
      // every dynasty they ruled, but excludes other dynasties' capitals.
      where = `dc.dynasty_id IN (
        SELECT DISTINCT dynasty_id FROM reigns WHERE person_id = ?
      )`;
      values = [personId];
    } else {
      // The API builds event details without loading capital rows.
      return [];
    }

    const capitalRows = await rows(db, `
      SELECT dc.*,
             COALESCE((
               SELECT json_group_array(link.reign_id)
               FROM (
                 SELECT rc.reign_id
                 FROM reign_capitals AS rc
                 WHERE rc.capital_id = dc.id
                 ORDER BY rc.reign_id
               ) AS link
             ), '[]') AS detail_reign_ids
      FROM dynasty_capitals AS dc
      WHERE ${where}
      ORDER BY dc.start_abs, dc.role, dc.id
    `, values);
    return capitalRows.map((capital) =>
      mapCapital(capital, strings(capital.detail_reign_ids)),
    );
  }

  /** SQLite counterpart of the API's person-detail context query. */
  private async personDetailContext(
    ref: EntityRef,
    focusReignId?: string,
  ): Promise<PersonDetailContext[] | undefined> {
    if (ref.type !== "person" && ref.type !== "reign") return undefined;
    const db = await this.dbPromise;
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
               'birth_year', p.birth_year, 'birth_month', p.birth_month,
               'death_year', p.death_year, 'death_month', p.death_month,
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
               'end_year', rr.end_year, 'end_month', rr.end_month,
               'end_day', rr.end_day,
               'start_abs', rr.start_abs, 'end_abs', rr.end_abs,
               'precision', rr.precision,
               'start_date_confidence', rr.start_date_confidence,
               'end_date_confidence', rr.end_date_confidence,
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
    const store = await this.store();
    const context = await this.personDetailContext(ref, options?.focusReignId);
    if (context && context.length === 0) throw new Error(`Entity not found: ${ref.id}`);
    const capitals = await this.capitalsForEntity(ref, store);
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
          capitals,
        }
      : { ...store, capitals };
    return buildEntityDetail(
      detailStore,
      ref,
      {
        focusReignId: ref.type === "reign" ? ref.id : options?.focusReignId,
        selectedReignIds: contextReigns.map((reign) => reign.id),
        focusReignIndex: context?.[0]?.reignIndex,
        reignCount: context?.[0]?.reignCount,
      },
    );
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
