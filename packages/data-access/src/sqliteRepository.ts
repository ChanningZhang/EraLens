import { mapEntityAssociation, eventAssociationIds, type EntityAssociation } from "@eralens/shared";
import {
  buildEntityDetail, DynastyGroupSchema,
  DynastySchema, EventSchema, mapLocation, mapLocationMapping, filterLocationMappings,
  filterTimeline, fromAbsMonth, normalizeSearchTerm, PersonSchema, RelationSchema, ReignSchema,
  confidencePrecision,
  searchEntities, combineTimelineLayers, reignTimelineFromStore, timelineCandidateWindow,
  ContentVersionMismatchError, personIntersectsAbsWindow, eventSpanAbs, rangeIntersectsWindow,
  type ReignTimeline, type EventTimeline, type PersonTimeline, type Dynasty, type LocationMappingQuery, type LocationMapping, type Location, type DynastyGroup,
type EntityDetail, type EntityRef, type Event,
  type EventDisplayConfig, type Person, type Reign, type Relation,
  type SearchHit, type TimelineCatalog, type TimelineDataStore, type TimelineSlice,
} from "@eralens/shared";
import { DEFAULT_EVENT_DISPLAY_CONFIG, EventDisplayConfigSchema } from "@eralens/shared";
import type { SqliteDatabaseProvider, TimelineQuery, TimelineRepository } from "./repository";
import contentVersions from "../../../data/mobile/versions.json";

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
const point = (year: unknown, month: unknown, day?: unknown) => year == null || month == null
  ? undefined
  : { year: Number(year), month: Number(month), ...(day == null ? {} : { day: Number(day) }) };
const csv = (value: unknown) => typeof value === "string" ? value.split(",").map((part) => part.trim()).filter(Boolean) : [];

export function mapPerson(row: Row): Person {
  return PersonSchema.parse({
    id: row.id, name: row.name, title: own(row, "title"), altNames: strings(row.alt_names),
    dynastyId: own(row, "dynasty_id"),
    ancestralXing: own(row, "ancestral_xing"), clanShi: own(row, "clan_shi"),
    birth: point(row.birth_year, row.birth_month, row.birth_day) ? { ...point(row.birth_year, row.birth_month, row.birth_day), confidence: own(row, "birth_confidence") } : undefined,
    death: point(row.death_year, row.death_month, row.death_day) ? { ...point(row.death_year, row.death_month, row.death_day), confidence: own(row, "death_confidence") } : undefined,
    roles: strings(row.roles), bio: own(row, "bio"), links: json(row.links, []),
    posthumousNames: csv(row.posthumous_name), templeNames: csv(row.temple_name),
    searchTerms: strings(row.search_terms),
  });
}

export function mapDynasty(row: Row): Dynasty {
  return DynastySchema.parse({
    id: row.id, name: row.name, altNames: strings(row.alt_names), ethnicity: own(row, "ethnicity"), scope: row.scope,
    region: row.region, start: { ...point(row.start_year, row.start_month, row.start_day), confidence: row.start_confidence }, end: point(row.end_year, row.end_month, row.end_day) ? { ...point(row.end_year, row.end_month, row.end_day), confidence: row.end_confidence } : undefined,
    startAbs: Number(row.start_abs), endAbs: Number(row.end_abs), precision: confidencePrecision((row.start_confidence ?? "year") as Parameters<typeof confidencePrecision>[0]), startConfidence: row.start_confidence, endConfidence: row.end_confidence ?? undefined,
    colorToken: row.color_token, parentId: own(row, "parent_id"), groupId: own(row, "group_id"), note: own(row, "note"),
  });
}

export function mapGroup(row: Row): DynastyGroup {
  return DynastyGroupSchema.parse({
    id: row.id, name: row.name, altNames: strings(row.alt_names), scope: row.scope,
    start: { ...point(row.start_year, row.start_month, row.start_day), confidence: row.start_confidence }, end: { ...point(row.end_year, row.end_month, row.end_day), confidence: row.end_confidence },
    startAbs: Number(row.start_abs), endAbs: Number(row.end_abs), precision: confidencePrecision((row.start_confidence ?? "year") as Parameters<typeof confidencePrecision>[0]), startConfidence: row.start_confidence, endConfidence: row.end_confidence, note: own(row, "note"),
  });
}


export function mapReign(row: Row): Reign {
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
    isInformalMonarch: Boolean(row.is_informal_monarch), isMain: row.is_main == null ? undefined : Boolean(row.is_main),
  });
}

export function mapEvent(row: Row, associations: readonly EntityAssociation[], locationMappings: LocationMapping[] = []): Event {
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

export function mapRelation(row: Row): Relation {
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
  constructor(
    private readonly provider: SqliteDatabaseProvider,
    private readonly settings: import("./repository").SettingsStore = {
      async get() { return null; },
      async set() {},
    },
  ) {}

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

  private async metadata(): Promise<string> {
    const result = await rows(await this.database(), "SELECT key, value FROM content_metadata WHERE key IN ('schema_version','contract_version','dataset_version')");
    const meta = new Map(result.map(row => [String(row.key), JSON.parse(String(row.value)) as unknown]));
    if (!meta.has("schema_version") || !meta.has("contract_version")) throw new Error("SQLite content database has no schema metadata");
    if (meta.get("schema_version") !== contentVersions.schemaVersion || meta.get("contract_version") !== contentVersions.contractVersion) throw new Error("SQLite content database version is not supported by this app");
    return String(meta.get("dataset_version") ?? "unversioned");
  }

  private cancelled(signal?: AbortSignal) {
    if (signal?.aborted) throw signal.reason ?? new DOMException("Timeline query cancelled", "AbortError");
  }

  private async consistent<T>(operation: (version: string) => Promise<T>, query?: Pick<TimelineQuery, "signal" | "datasetVersion">): Promise<T> {
    for (let attempt = 0; attempt < 2; attempt++) {
      this.cancelled(query?.signal);
      const version = await this.metadata();
      if (query?.datasetVersion && query.datasetVersion !== version) throw new ContentVersionMismatchError();
      const value = await operation(version);
      this.cancelled(query?.signal);
      if (await this.metadata() === version) return value;
    }
    throw new ContentVersionMismatchError();
  }

  private async selectIds(table: string, ids: readonly string[], column = "id", projection = "*"): Promise<Row[]> {
    const db = await this.database();
    const result: Row[] = [];
    const unique = [...new Set(ids)];
    for (let start = 0; start < unique.length; start += 200) {
      const chunk = unique.slice(start, start + 200);
      result.push(...await rows(db, `SELECT ${projection} FROM ${table} WHERE ${column} IN (${chunk.map(() => "?").join(",")}) ORDER BY rowid`, chunk));
    }
    return result;
  }

  private async associationsFor(type: string, ids: readonly string[]): Promise<EntityAssociation[]> {
    const db = await this.database();
    const result = new Map<string, EntityAssociation>();
    for (let start = 0; start < ids.length; start += 200) {
      const chunk = ids.slice(start, start + 200);
      const placeholders = chunk.map(() => "?").join(",");
      const associations = await rows(db, `SELECT * FROM entity_associations WHERE (a_type=? AND a_id IN (${placeholders})) OR (b_type=? AND b_id IN (${placeholders}))`, [type,...chunk,type,...chunk]);
      for (const raw of associations) {
        const association = mapEntityAssociation(raw);
        result.set(`${association.aRef}|${association.bRef}`, association);
      }
    }
    return [...result.values()];
  }

  private async mappingsFor(kind: string, ids: readonly string[]): Promise<LocationMapping[]> {
    const db = await this.database();
    const result: LocationMapping[] = [];
    for (let start = 0; start < ids.length; start += 200) {
      const chunk = ids.slice(start, start + 200);
      result.push(...(await rows(db, `${this.mappingSql} WHERE m.kind=? AND m.external_id IN (${chunk.map(() => "?").join(",")})`, [kind,...chunk])).map(mapLocationMapping));
    }
    return filterLocationMappings(result, {});
  }

  private readonly mappingSql = "SELECT m.*, json_object('id',l.id,'modern_name',l.modern_name,'longitude',l.longitude,'latitude',l.latitude,'coordinate_system',l.coordinate_system) AS location FROM location_mapping m JOIN locations l ON l.id=m.location_id";

  private async mapEvents(raw: Row[], includeLocations = true): Promise<Event[]> {
    const ids = raw.map(r => String(r.id));
    const associations = await this.associationsFor("event", ids);
    const mappings = includeLocations ? await this.mappingsFor("event", ids) : [];
    const byEvent = new Map<string, EntityAssociation[]>();
    const locations = new Map<string, LocationMapping[]>();
    for (const association of associations) {
      for (const ref of [association.aRef, association.bRef]) if (ref.startsWith("event:")) {
        const id = ref.slice(6);
        const group = byEvent.get(id) ?? []; group.push(association); byEvent.set(id, group);
      }
    }
    for (const mapping of mappings) {
      const group = locations.get(mapping.externalId) ?? []; group.push(mapping); locations.set(mapping.externalId, group);
    }
    return raw.map(row => mapEvent(row, byEvent.get(String(row.id)) ?? [], locations.get(String(row.id)) ?? []));
  }

  private emptyStore(): TimelineDataStore {
    return { persons: [], dynasties: [], dynastyGroups: [], reigns: [], events: [], relations: [], associations: [], locationMappings: [] };
  }

  private async reignLayer(query: TimelineQuery, version: string): Promise<ReignTimeline> {
    const db = await this.database();
    const window = timelineCandidateWindow(query);
    const dynastyRaw = await rows(db, `SELECT * FROM dynasties WHERE start_abs<=? AND end_abs>=?${query.scope ? " AND scope=?" : ""} ORDER BY rowid`, [window.toAbs,window.fromAbs,...(query.scope ? [query.scope] : [])]);
    this.cancelled(query.signal);
    const relations = (await rows(db, "SELECT * FROM relations WHERE kind<>'succession' AND at_abs>=? AND at_abs<=? ORDER BY rowid", [query.fromAbs,query.toAbs])).map(mapRelation);
    this.cancelled(query.signal);
    const personIds: string[] = [], reignIds: string[] = [];
    for (const relation of relations) for (const ref of [relation.fromRef,relation.toRef]) {
      if (ref.startsWith("person:")) personIds.push(ref.slice(7));
      if (ref.startsWith("reign:")) reignIds.push(ref.slice(6));
    }
    const endpointReigns = [...await this.selectIds("reigns", personIds, "person_id"), ...await this.selectIds("reigns", reignIds)];
    const dynastyIds = [...new Set([...dynastyRaw.map(d => String(d.id)),...endpointReigns.map(r => String(r.dynasty_id))])];
    const dynasties = [...new Map([...dynastyRaw,...await this.selectIds("dynasties", dynastyIds.filter(id => !dynastyRaw.some(d => d.id === id)))].map(d => [String(d.id),mapDynasty(d)])).values()];
    const reigns = (await this.selectIds("reigns",dynastyIds,"dynasty_id")).map(mapReign);
    const captionPeople = (await this.selectIds("persons",reigns.map(r => r.personId),"id","id,name,title,ancestral_xing,clan_shi,posthumous_name,temple_name")).map(mapPerson);
    const visibleDynastyIds = new Set(dynastyRaw.map(d => String(d.id)));
    const visiblePersonIds = reigns.filter(r => visibleDynastyIds.has(r.dynastyId) && rangeIntersectsWindow(r.startAbs,r.endAbs,query.fromAbs,query.toAbs)).map(r => r.personId);
    const persons = [...new Map([...captionPeople,...(await this.selectIds("persons",visiblePersonIds)).map(mapPerson)].map(p => [p.id,p])).values()];
    const dynastyGroups = (await this.selectIds("dynasty_groups",dynasties.flatMap(d => d.groupId ? [d.groupId] : []))).map(mapGroup);
    return reignTimelineFromStore({ ...this.emptyStore(), dynasties, dynastyGroups, reigns, persons, relations },query,version);
  }

  private async eventLayer(query: TimelineQuery, version: string): Promise<EventTimeline> {
    const window = timelineCandidateWindow(query);
    const raw = await rows(await this.database(), `SELECT * FROM events WHERE at_abs BETWEEN ? AND ? OR (start_abs<=? AND end_abs>=?) ORDER BY rowid`, [window.fromAbs,window.toAbs,window.toAbs,window.fromAbs]);
    this.cancelled(query.signal);
    const events = await this.mapEvents(raw);
    this.cancelled(query.signal);
    return { datasetVersion: version, events: filterTimeline({ ...this.emptyStore(), events },query).events };
  }

  private async personLayer(query: TimelineQuery, version: string, includeUnreignedMonarchs = false): Promise<PersonTimeline> {
    const window = timelineCandidateWindow(query);
    const fromYear = fromAbsMonth(window.fromAbs).year, toYear = fromAbsMonth(window.toAbs).year;
    const raw = await rows(await this.database(), `SELECT p.* FROM persons p WHERE NOT EXISTS (SELECT 1 FROM reigns r WHERE r.person_id=p.id) AND (
      (p.birth_year<=? AND p.death_year>=?) OR
      (p.birth_year BETWEEN ? AND ?) OR (p.death_year BETWEEN ? AND ?)
    ) ORDER BY p.rowid`, [toYear,fromYear,fromYear,toYear,fromYear,toYear]);
    this.cancelled(query.signal);
    return { datasetVersion:version, persons:raw.map(mapPerson).filter(p => (includeUnreignedMonarchs || !p.roles.includes("君主")) && personIntersectsAbsWindow(p,query.fromAbs,query.toAbs)).map(({searchTerms:_terms,...person}) => person) };
  }

  getDatasetVersion(): Promise<string> { return this.metadata(); }
  getReignTimeline(query: TimelineQuery): Promise<ReignTimeline> { return this.consistent(version => this.reignLayer(query,version),query); }
  getEventTimeline(query: TimelineQuery): Promise<EventTimeline> { return this.consistent(version => this.eventLayer(query,version),query); }
  getPersonTimeline(query: TimelineQuery): Promise<PersonTimeline> { return this.consistent(version => this.personLayer(query,version),query); }

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
        WHERE p.id = COALESCE(
          (SELECT person_id FROM request),
          (SELECT r.person_id FROM reigns r WHERE r.id = (SELECT focus_reign_id FROM request))
        )
          AND (
            (SELECT focus_reign_id FROM request) IS NULL
            OR EXISTS (
              SELECT 1 FROM reigns r
              WHERE r.id = (SELECT focus_reign_id FROM request) AND r.person_id = p.id
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
        WHERE r.person_id = (SELECT id FROM target_person)
      )
      SELECT json_object(
               'id', p.id, 'name', p.name, 'title', p.title,
               'dynasty_id', p.dynasty_id,
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

  getTimeline(query: TimelineQuery): Promise<TimelineSlice> {
    return this.consistent(async version => combineTimelineLayers(
      await this.reignLayer(query,version), await this.eventLayer(query,version), await this.personLayer(query,version,true),
    ),query);
  }

  getTimelineCatalog(scope?: string): Promise<TimelineCatalog> {
    return this.consistent(async () => {
      const db = await this.database();
      return { dynasties: (await rows(db, `SELECT * FROM dynasties${scope ? " WHERE scope=?" : ""} ORDER BY rowid`,scope ? [scope] : [])).map(mapDynasty),
        dynastyGroups: (await rows(db,"SELECT * FROM dynasty_groups ORDER BY rowid")).map(mapGroup) };
    });
  }

  /** One-hop detail graph plus the complete ownership series of its reigns. */
  private async detailStore(ref: EntityRef, context?: PersonDetailContext[]): Promise<TimelineDataStore> {
    const store = this.emptyStore();
    const refs = new Map<string, EntityRef>();
    const addRef = (type: EntityRef["type"], id: string) => refs.set(`${type}:${id}`, {type,id});
    const addRawRef = (raw:string) => {
      const separator = raw.indexOf(":");
      const type = raw.slice(0,separator) as EntityRef["type"];
      if (["person","reign","event","dynasty"].includes(type)) addRef(type,raw.slice(separator+1));
    };
    addRef(ref.type,ref.id);
    let primary: EntityRef = ref;
    if (context?.[0]) {
      primary = {type:"person",id:context[0].person.id}; addRef(primary.type,primary.id);
    }
    const rootMappings = ref.type === "location_mapping" ? await this.selectIds("location_mapping",[ref.id]) : [];
    for (const mapping of rootMappings) {
      primary = {type:String(mapping.kind) as EntityRef["type"],id:String(mapping.external_id)};
      addRef(primary.type,primary.id);
    }
    const associations = ["person","event","dynasty"].includes(primary.type) ? await this.associationsFor(primary.type,[primary.id]) : [];
    store.associations = associations;
    for (const association of associations) { addRawRef(association.aRef); addRawRef(association.bRef); }
    if (primary.type === "person") {
      const reignIds = context?.flatMap(c => c.reign ? [c.reign.id] : []) ?? [];
      const clause = reignIds.length ? ` OR (from_type='reign' AND from_id IN (${reignIds.map(() => "?").join(",")}))` : "";
      store.relations = (await rows(await this.database(),`SELECT * FROM relations WHERE (from_type='person' AND from_id=?) OR (to_type='person' AND to_id=?)${clause} ORDER BY rowid`,[primary.id,primary.id,...reignIds])).map(mapRelation);
      for (const relation of store.relations) { addRawRef(relation.fromRef); addRawRef(relation.toRef); }
    }
    const ids = (type:EntityRef["type"]) => [...refs.values()].filter(r => r.type === type).map(r => r.id);
    const directReigns = await this.selectIds("reigns",ids("reign"));
    const personsRaw = await this.selectIds("persons",[...ids("person"),...directReigns.map(r => String(r.person_id))]);
    const personReigns = await this.selectIds("reigns",personsRaw.map(p => String(p.id)),"person_id");
    const dynastyIds = [...new Set([...ids("dynasty"),...personsRaw.flatMap(p => p.dynasty_id ? [String(p.dynasty_id)] : []),...(context?.[0]?.person.dynastyId ? [context[0].person.dynastyId] : []),...directReigns.map(r => String(r.dynasty_id)),...personReigns.map(r => String(r.dynasty_id))])];
    store.dynasties = (await this.selectIds("dynasties",dynastyIds)).map(mapDynasty);
    store.persons = [...new Map([...personsRaw.map(mapPerson),...(context?.[0] ? [context[0].person] : [])].map(p => [p.id,p])).values()];
    store.reigns = (await this.selectIds("reigns",dynastyIds,"dynasty_id")).map(mapReign);
    // Event related summaries depend on the event's associated dynasty, too.
    const eventRaw = await this.selectIds("events",ids("event"));
    store.events = await this.mapEvents(eventRaw);
    const eventDynasties = store.events.flatMap(e => e.dynastyIds).filter(id => !dynastyIds.includes(id));
    store.dynasties.push(...(await this.selectIds("dynasties",eventDynasties)).map(mapDynasty));
    const mappings = [...await this.mappingsFor("dynasty",dynastyIds),...await this.mappingsFor("reign",store.reigns.map(r => r.id)),...store.events.flatMap(e => e.locationMappings)];
    if (rootMappings.length && primary.type !== "event") {
      const rootLocations = await this.selectIds("locations",rootMappings.map(m => String(m.location_id)));
      const byId = new Map(rootLocations.map(l => [String(l.id),l]));
      mappings.push(...rootMappings.map(m => mapLocationMapping({...m,location:byId.get(String(m.location_id))})));
    }
    const modernNames = [...new Set(mappings.filter(m => m.kind === "reign").map(m => m.location.modernName.trim()))];
    // Capital arbitration can include another dynasty at the same modern location.
    for (let start=0;start<modernNames.length;start+=200) {
      const chunk=modernNames.slice(start,start+200);
      mappings.push(...(await rows(await this.database(),`${this.mappingSql} WHERE m.kind='reign' AND trim(l.modern_name) IN (${chunk.map(() => "?").join(",")})`,chunk)).map(mapLocationMapping));
    }
    const peerReignIds = mappings.filter(m => m.kind === "reign").map(m => m.externalId).filter(id => !store.reigns.some(r => r.id === id));
    store.reigns.push(...(await this.selectIds("reigns",peerReignIds)).map(mapReign));
    store.locationMappings = filterLocationMappings([...new Map(mappings.map(m => [m.id,m])).values()],{});
    return store;
  }

  getEntity(ref: EntityRef, options?: { focusReignId?: string; atAbs?: number }): Promise<EntityDetail> {
    return this.consistent(async () => {
      const context = await this.personDetailContext(ref,options?.focusReignId);
      if (context && context.length === 0) throw new Error(`Entity not found: ${ref.id}`);
      const store = await this.detailStore(ref,context);
      return buildEntityDetail(store,ref,{ atAbs:options?.atAbs,
        focusReignId:ref.type === "reign" ? ref.id : options?.focusReignId,
        selectedReignIds:context?.flatMap(row => row.reign ? [row.reign.id] : []) ?? [],
        focusReignIndex:context?.[0]?.reignIndex, reignCount:context?.[0]?.reignCount });
    });
  }

  search(term: string): Promise<SearchHit[]> {
    const normalized = normalizeSearchTerm(term);
    if (!normalized) return Promise.resolve([]);
    return this.consistent(async () => {
      const db = await this.database();
      const entries = await rows(db, `SELECT entity_type,entity_id FROM search_entries WHERE entity_type='person' AND normalized_term=? UNION SELECT entity_type,entity_id FROM search_entries WHERE entity_type<>'person' AND instr(normalized_term,?)>0`,[normalized,normalized]);
      const ids = (type:string) => entries.filter(e => e.entity_type === type).map(e => String(e.entity_id));
      const store = this.emptyStore();
      store.persons = (await this.selectIds("persons",ids("person"))).map(mapPerson);
      store.reigns = [...new Map([...await this.selectIds("reigns",ids("reign")),...await this.selectIds("reigns",ids("person"),"person_id")].map(r => [String(r.id),mapReign(r)])).values()];
      store.events = await this.mapEvents(await this.selectIds("events",ids("event")),false);
      const mappingRaw = await this.selectIds("location_mapping",ids("location_mapping"));
      const locationRows = await this.selectIds("locations",mappingRaw.map(m => String(m.location_id)));
      const locations = new Map(locationRows.map(l => [String(l.id),l]));
      store.locationMappings = filterLocationMappings(mappingRaw.map(m => mapLocationMapping({...m,location:locations.get(String(m.location_id))})),{});
      // Context-only entities must not produce extra hits: search then restrict to indexed candidates.
      const contextReigns = (await this.selectIds("reigns",mappingRaw.filter(m => m.kind === "reign").map(m => String(m.external_id)))).map(mapReign);
      store.reigns = [...new Map([...store.reigns,...contextReigns].map(r => [r.id,r])).values()];
      store.persons = [...new Map([...store.persons,...(await this.selectIds("persons",store.reigns.map(r => r.personId))).map(mapPerson)].map(p => [p.id,p])).values()];
      store.events = [...new Map([...store.events,...await this.mapEvents(await this.selectIds("events",mappingRaw.filter(m => m.kind === "event").map(m => String(m.external_id))),false)].map(e => [e.id,e])).values()];
      store.dynasties = (await this.selectIds("dynasties",[...ids("dynasty"),...store.reigns.map(r => r.dynastyId),...mappingRaw.filter(m => m.kind === "dynasty").map(m => String(m.external_id))])).map(mapDynasty);
      const candidates = new Set(entries.map(e => `${e.entity_type}:${e.entity_id}`));
      return searchEntities(store,term,candidates);
    });
  }

  getBounds(): Promise<{ minAbs: number; maxAbs: number }> {
    return this.consistent(async () => {
      const db = await this.database();
      const dynasties = (await rows(db,"SELECT start_abs,end_abs FROM dynasties"));
      const events = await rows(db,"SELECT at_year,at_month,at_day,at_abs,start_year,start_month,start_day,start_abs,end_year,end_month,end_day,end_abs FROM events");
      const spans = events.map(e => eventSpanAbs({at:point(e.at_year,e.at_month,e.at_day),atAbs:n(e.at_abs),start:point(e.start_year,e.start_month,e.start_day),startAbs:n(e.start_abs),end:point(e.end_year,e.end_month,e.end_day),endAbs:n(e.end_abs)}));
      return { minAbs:Math.min(...dynasties.map(d => Number(d.start_abs)),...spans.map(e => e.startAbs)), maxAbs:Math.max(...dynasties.map(d => Number(d.end_abs)),...spans.map(e => e.endAbs)) };
    });
  }

  getLocations(): Promise<Location[]> {
    return this.consistent(async () => (await rows(await this.database(),"SELECT * FROM locations ORDER BY id")).map(mapLocation));
  }

  getLocationMappings(query: LocationMappingQuery = {}): Promise<LocationMapping[]> {
    return this.consistent(async () => {
      const where:string[] = [], values:unknown[] = [];
      for (const [key,value] of [["kind",query.kind],["external_id",query.externalId],["location_id",query.locationId]] as const) if (value) { where.push(`m.${key}=?`); values.push(value); }
      if (query.fromAbs != null) { where.push("(CASE WHEN m.kind='event' THEN COALESCE(e.at_abs,e.end_abs) ELSE m.end_abs END)>=?"); values.push(query.fromAbs); }
      if (query.toAbs != null) { where.push("(CASE WHEN m.kind='event' THEN COALESCE(e.at_abs,e.start_abs) ELSE m.start_abs END)<=?"); values.push(query.toAbs); }
      const result = await rows(await this.database(),`${this.mappingSql} LEFT JOIN events e ON m.kind='event' AND e.id=m.external_id${where.length ? " WHERE " + where.join(" AND ") : ""}`,values);
      // SQL already applied event dates; the shared sorter needs no second time filter.
      return filterLocationMappings(result.map(mapLocationMapping),{});
    });
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
    if (database) await (await database).close();
  }
}

export function normalizeSqliteSearchTerm(value: string): string { return normalizeSearchTerm(value); }
