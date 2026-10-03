import {
  buildEntityDetail,
  DEFAULT_EVENT_DISPLAY_CONFIG,
  LocationSchema, LocationMappingSchema, LocationKindSchema, mapLocation, mapLocationMapping, filterLocationMappings, searchEntities,
  EventDisplayConfigSchema,
  EntityDetailSchema,
  eventKindLabel,
  eventSpanAbs,
  FATE_RELATION_KINDS,
  midpointAbs,
  normalizeSearchTerm,
  personIntersectsAbsWindow,
  personSearchAnchorAbs,
  personTimelinePlacement,
  SearchHitSchema,
  TimelineCatalogSchema,
  TimelineSliceSchema,
  type Event,
  type Relation,
  type TimelineDataStore,
} from "@eralens/shared";
import type { FastifyInstance } from "fastify";
import { prisma } from "../db.js";
import {
  mapDynasty,
  mapDynastyGroup,
  mapDynastyLaneGroup,
  mapEvent,
  mapPerson,
  mapReign,
  mapRelation,
  toTimelineDataStore,
  type RawDynastyGroupRow,
  type RawDynastyRow,
  type RawEventRow,
  type RawReignRow,
} from "../mappers.js";

const CACHE_HEADER = "public, max-age=60";

type PersonDetailBundleRow = {
  persons: unknown;
  dynasties: unknown;
  reigns: unknown;
  events: unknown;
  relations: unknown;
  selected_reign_ids: unknown;
  focus_reign_index: number | null;
  reign_count: number;
};

function jsonRows(value: unknown): Record<string, unknown>[] {
  return Array.isArray(value) ? value as Record<string, unknown>[] : [];
}

function mapBundlePerson(row: Record<string, unknown>) {
  return mapPerson({
    id: String(row.id),
    name: String(row.name),
    altNames: (row.alt_names as string[] | undefined) ?? [],
    ancestralXing: row.ancestral_xing as string | null,
    clanShi: row.clan_shi as string | null,
    birthYear: row.birth_year as number | null,
    birthMonth: row.birth_month as number | null,
    birthDay: row.birth_day as number | null,
    birthConfidence: row.birth_confidence as string | null,
    deathYear: row.death_year as number | null,
    deathMonth: row.death_month as number | null,
    deathDay: row.death_day as number | null,
    deathConfidence: row.death_confidence as string | null,
    roles: (row.roles as string[] | undefined) ?? [],
    bio: row.bio as string | null,
    links: row.links ?? [],
    posthumousName: row.posthumous_name as string | null,
    templeName: row.temple_name as string | null,
    title: row.title as string | null,
    searchTerms: (row.search_terms as string[] | undefined) ?? [],
  });
}

function mapBundleRelation(row: Record<string, unknown>): Relation {
  return {
    id: String(row.id),
    fromRef: `${String(row.from_type)}:${String(row.from_id)}`,
    toRef: `${String(row.to_type)}:${String(row.to_id)}`,
    kind: row.kind as Relation["kind"],
    ...(row.at_year == null || row.at_month == null
      ? {}
      : {
          at: {
            year: Number(row.at_year),
            month: Number(row.at_month),
            ...(row.at_day == null ? {} : { day: Number(row.at_day) }),
          },
        }),
    ...(row.at_abs == null ? {} : { atAbs: Number(row.at_abs) }),
    ...(row.event_id == null ? {} : { eventId: String(row.event_id) }),
  };
}

/** Person, reign rows, ordinal, and total are intentionally fetched in one SQL statement. */
async function loadPersonDetailBundle(
  personId: string | null,
  focusReignId: string | null,
): Promise<{
  store: TimelineDataStore;
  personId: string;
  selectedReignIds: string[];
  focusReignIndex?: number;
  reignCount: number;
} | null> {
  const rows = await prisma.$queryRaw<PersonDetailBundleRow[]>`
    WITH target_person AS (
      SELECT p.*
      FROM persons p
      WHERE p.id = COALESCE(
        ${personId}::text,
        (SELECT r.person_id FROM reigns r WHERE r.id = ${focusReignId}::text)
      )
        AND (
          ${focusReignId}::text IS NULL
          OR EXISTS (
            SELECT 1 FROM reigns r
            WHERE r.id = ${focusReignId}::text AND r.person_id = p.id
          )
        )
    ),
    ranked_target_reigns AS (
      SELECT r.*,
             (ROW_NUMBER() OVER (
               ORDER BY r.start_abs, COALESCE(r.start_day, 1), r.id
             ))::int AS reign_index,
             (COUNT(*) OVER ())::int AS reign_count
      FROM reigns r
      JOIN target_person tp ON tp.id = r.person_id
    ),
    selected_target_reigns AS (
      SELECT *
      FROM ranked_target_reigns
      WHERE ${focusReignId}::text IS NULL OR id = ${focusReignId}::text
    ),
    selected_dynasty_ids AS (
      SELECT DISTINCT dynasty_id FROM selected_target_reigns
    ),
    relevant_relations AS (
      SELECT rel.*
      FROM relations rel
      WHERE EXISTS (
        SELECT 1
        FROM selected_target_reigns sr
        WHERE (rel.from_type = 'reign' AND rel.from_id = sr.id)
           OR (rel.to_type = 'reign' AND rel.to_id = sr.id)
      )
    ),
    related_reign_ids AS (
      SELECT from_id AS id FROM relevant_relations WHERE from_type = 'reign'
      UNION
      SELECT to_id AS id FROM relevant_relations WHERE to_type = 'reign'
    ),
    bundle_reigns AS (
      SELECT r.*
      FROM reigns r
      WHERE r.dynasty_id IN (SELECT dynasty_id FROM selected_dynasty_ids)
         OR r.id IN (SELECT id FROM related_reign_ids)
    ),
    relevant_events AS (
      SELECT e.*
      FROM events e
      WHERE EXISTS (
        SELECT 1 FROM event_participants ep
        JOIN target_person tp ON tp.id = ep.person_id
        WHERE ep.event_id = e.id
      )
    ),
    bundle_dynasty_ids AS (
      SELECT dynasty_id AS id FROM bundle_reigns
      UNION
      SELECT ed.dynasty_id AS id
      FROM event_dynasties ed
      JOIN relevant_events e ON e.id = ed.event_id
    ),
    bundle_person_ids AS (
      SELECT id FROM target_person
      UNION
      SELECT r.person_id AS id
      FROM reigns r
      WHERE r.id IN (SELECT id FROM related_reign_ids)
      UNION
      SELECT from_id AS id FROM relevant_relations WHERE from_type = 'person'
      UNION
      SELECT to_id AS id FROM relevant_relations WHERE to_type = 'person'
    )
    SELECT
      COALESCE((SELECT jsonb_agg(to_jsonb(p) ORDER BY p.id)
                FROM persons p WHERE p.id IN (SELECT id FROM bundle_person_ids)), '[]'::jsonb) AS persons,
      COALESCE((SELECT jsonb_agg(to_jsonb(d) ORDER BY d.id)
                FROM dynasties d WHERE d.id IN (SELECT id FROM bundle_dynasty_ids)), '[]'::jsonb) AS dynasties,
      COALESCE((SELECT jsonb_agg(to_jsonb(r) ORDER BY r.start_abs, COALESCE(r.start_day, 1), r.id)
                FROM bundle_reigns r), '[]'::jsonb) AS reigns,
      COALESCE((SELECT jsonb_agg(
        to_jsonb(e) || jsonb_build_object(
          'dynasties', COALESCE((SELECT jsonb_agg(jsonb_build_object('dynastyId', ed.dynasty_id) ORDER BY ed.dynasty_id)
                                  FROM event_dynasties ed WHERE ed.event_id = e.id), '[]'::jsonb),
          'participants', COALESCE((SELECT jsonb_agg(jsonb_build_object('personId', ep.person_id) ORDER BY ep.person_id)
                                    FROM event_participants ep WHERE ep.event_id = e.id), '[]'::jsonb),
          'locationMappings', '[]'::jsonb
        ) ORDER BY e.id
      ) FROM relevant_events e), '[]'::jsonb) AS events,
      COALESCE((SELECT jsonb_agg(to_jsonb(rel) ORDER BY rel.id)
                FROM relevant_relations rel), '[]'::jsonb) AS relations,
      COALESCE((SELECT jsonb_agg(sr.id ORDER BY sr.reign_index) FROM selected_target_reigns sr), '[]'::jsonb) AS selected_reign_ids,
      (SELECT sr.reign_index FROM selected_target_reigns sr WHERE sr.id = ${focusReignId}::text) AS focus_reign_index,
      COALESCE((SELECT MAX(rtr.reign_count) FROM ranked_target_reigns rtr), 0)::int AS reign_count`;

  const row = rows[0];
  if (!row) return null;
  const eventMappings = await loadMappings({kind:"event"});
  const persons = jsonRows(row.persons).map(mapBundlePerson);
  const targetPerson = persons.find((person) => person.id === personId) ??
    persons.find((person) =>
      jsonRows(row.reigns).some((reign) => reign.id === focusReignId && reign.person_id === person.id)
    );
  if (!targetPerson) return null;
  return {
    store: {
      persons,
      dynasties: jsonRows(row.dynasties).map((value) => mapDynasty(value as never)),
      reigns: jsonRows(row.reigns).map((value) => mapReign(value as never)),
      events: jsonRows(row.events).map((value) => mapEvent({...value, locationMappings:eventMappings.filter(m=>m.externalId===value.id)} as never)),
      relations: jsonRows(row.relations).map(mapBundleRelation),
    },
    personId: targetPerson.id,
    selectedReignIds: Array.isArray(row.selected_reign_ids)
      ? row.selected_reign_ids.map(String)
      : [],
    ...(row.focus_reign_index == null ? {} : { focusReignIndex: Number(row.focus_reign_index) }),
    reignCount: Number(row.reign_count),
  };
}

async function loadMappings(query: import("@eralens/shared").LocationMappingQuery = {}) {
  const rows = await prisma.locationMapping.findMany({where:{kind:query.kind,externalId:query.externalId,locationId:query.locationId},include:{location:true},orderBy:{id:"asc"}});
  const mappings=rows.map(mapLocationMapping);
  const events=query.fromAbs != null || query.toAbs != null ? await prisma.event.findMany() : [];
  return filterLocationMappings(mappings,query,events.map(e=>({id:e.id,atAbs:e.atAbs ?? undefined,startAbs:e.startAbs ?? undefined,endAbs:e.endAbs ?? undefined})));
}
async function loadPersonDetailLocations(store: TimelineDataStore, selectedReignIds: readonly string[]) {
  const ids=new Set(selectedReignIds);
  const dynastyIds=new Set(store.reigns.filter(r=>ids.has(r.id)).map(r=>r.dynastyId));
  return (await loadMappings()).filter(m=>m.kind === "reign" ? store.reigns.some(r=>r.id===m.externalId) : m.kind === "dynasty" ? dynastyIds.has(m.externalId) : store.events.some(e=>e.id===m.externalId));
}

async function loadStore() {
  const [personRows, dynastyRows, reignRows, eventRows, relationRows] = await Promise.all([
    prisma.person.findMany({orderBy:{id:"asc"}}),
    prisma.dynasty.findMany({orderBy:{id:"asc"}}),
    prisma.reign.findMany({orderBy:{id:"asc"}}),
    prisma.event.findMany({
      orderBy:{id:"asc"},
      include: {
        dynasties: { orderBy: { dynastyId: "asc" } },
        participants: { orderBy: { personId: "asc" } },
      },
    }),
    prisma.relation.findMany({orderBy:{id:"asc"}}),
  ]);
  const locationMappings=await loadMappings();

  return toTimelineDataStore({
    persons: personRows.map(row=>({...mapPerson(row),searchTerms:row.searchTerms})),
    dynasties: dynastyRows.map(mapDynasty),
    reigns: reignRows.map((row) => mapReign(row)),
    events: eventRows.map(row=>mapEvent({...row,locationMappings:locationMappings.filter(m=>m.kind === "event" && m.externalId === row.id)})),
    locationMappings,
    relations: relationRows.map(mapRelation),
  });
}

/** Event dynasties provide context; their visibility does not gate the event marker. */
async function loadEventsInWindow(fromAbs: number, toAbs: number) {
  const eventRows = await prisma.$queryRaw<RawEventRow[]>`
    SELECT id, name, kind, time_mode, at_confidence, start_confidence, end_confidence, date_note, at_year, at_month, at_day, at_abs,
           start_year, start_month, start_day, start_abs, end_year, end_month, end_day, end_abs, summary, meaning, content
    FROM events
    WHERE span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')`;

  const eventIds = eventRows.map((row) => row.id);
  const [eventDynasties, eventParticipants] = await Promise.all([
    eventIds.length
      ? prisma.eventDynasty.findMany({ where: { eventId: { in: eventIds } }, orderBy: [{ eventId: "asc" }, { dynastyId: "asc" }] })
      : Promise.resolve([]),
    eventIds.length
      ? prisma.eventParticipant.findMany({ where: { eventId: { in: eventIds } }, orderBy: [{ eventId: "asc" }, { personId: "asc" }] })
      : Promise.resolve([]),
  ]);

  const mappings=await loadMappings({kind:"event"});

  const dynastiesByEvent = new Map<string, string[]>();
  for (const row of eventDynasties) {
    const list = dynastiesByEvent.get(row.eventId) ?? [];
    list.push(row.dynastyId);
    dynastiesByEvent.set(row.eventId, list);
  }
  const participantsByEvent = new Map<string, string[]>();
  for (const row of eventParticipants) {
    const list = participantsByEvent.get(row.eventId) ?? [];
    list.push(row.personId);
    participantsByEvent.set(row.eventId, list);
  }

  return eventRows.map((row) =>
    mapEvent({
      ...row,
      locationMappings: mappings.filter(m=>m.externalId===row.id),
      dynasties: (dynastiesByEvent.get(row.id) ?? []).map((dynastyId) => ({ dynastyId })),
      participants: (participantsByEvent.get(row.id) ?? []).map((personId) => ({ personId })),
    }),
  );
}

const PLACEABLE_NON_RULER_WHERE = {
  reigns: { none: {} },
  OR: [
    { AND: [{ birthYear: { not: null } }, { birthMonth: { not: null } }] },
    { AND: [{ deathYear: { not: null } }, { deathMonth: { not: null } }] },
  ],
};

async function loadTimelineSlice(fromAbs: number, toAbs: number, scope?: string) {
  const dynastyRows = scope
    ? await prisma.$queryRaw<RawDynastyRow[]>`
        SELECT id, name, alt_names, scope, region, start_year, start_month, start_day, end_year, end_month, end_day,
               start_abs, end_abs, start_confidence, end_confidence, color_token,
               parent_id, group_id, note
        FROM dynasties
        WHERE span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')
          AND scope = ${scope}`
    : await prisma.$queryRaw<RawDynastyRow[]>`
        SELECT id, name, alt_names, scope, region, start_year, start_month, start_day, end_year, end_month, end_day,
               start_abs, end_abs, start_confidence, end_confidence, color_token,
               parent_id, group_id, note
        FROM dynasties
        WHERE span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')`;

  const dynastyIds = dynastyRows.map((row) => row.id);
  const events = await loadEventsInWindow(fromAbs, toAbs);

  if (dynastyIds.length === 0) {
    const personRows = await prisma.person.findMany({
      where: PLACEABLE_NON_RULER_WHERE,
    });
    const persons = personRows
      .map(mapPerson)
      .filter((person) => personIntersectsAbsWindow(person, fromAbs, toAbs));
    return TimelineSliceSchema.parse({
      dynasties: [],
      dynastyGroups: [],
      dynastyLaneGroups: [],
      reigns: [],
      events,
      persons,
      relations: [],
    });
  }

  const reignRows = await prisma.$queryRaw<RawReignRow[]>`
    SELECT id, dynasty_id, person_id, title, era_names,
           start_year, start_month, start_day, end_year, end_month, end_day,
           start_abs, end_abs, start_confidence, end_confidence,
           claim_track, claim_label, claim_role, is_informal_monarch, is_main
    FROM reigns
    WHERE dynasty_id = ANY(${dynastyIds}::text[])
      AND span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')`;

  const dynasties = dynastyRows.map(mapDynasty);
  const groupIds = [
    ...new Set(
      dynastyRows
        .map((row) => row.group_id)
        .filter((groupId): groupId is string => Boolean(groupId)),
    ),
  ];
  const dynastyGroupRows =
    groupIds.length > 0
      ? await prisma.$queryRaw<RawDynastyGroupRow[]>`
          SELECT id, name, alt_names, scope, start_year, start_month, start_day, end_year, end_month, end_day,
                 start_abs, end_abs, start_confidence, end_confidence, note
          FROM dynasty_groups
          WHERE id = ANY(${groupIds}::text[])`
      : [];
  const dynastyGroups = dynastyGroupRows.map(mapDynastyGroup);
  const dynastyLaneGroups = (await prisma.dynastyLaneGroup.findMany()).map(
    mapDynastyLaneGroup,
  );
  const reigns = reignRows.map((row) => mapReign(row));
  const visibleReignPersonIds = [...new Set(reignRows.map((row) => row.person_id))];
  const [lifePersonRows, rulerPersonRows] = await Promise.all([
    prisma.person.findMany({
      where: PLACEABLE_NON_RULER_WHERE,
    }),
    visibleReignPersonIds.length
      ? prisma.person.findMany({ where: { id: { in: visibleReignPersonIds } } })
      : Promise.resolve([]),
  ]);
  const persons = [
    ...rulerPersonRows.map(mapPerson),
    ...lifePersonRows
      .map(mapPerson)
      .filter((person) => personIntersectsAbsWindow(person, fromAbs, toAbs)),
  ];

  const relationRows = await prisma.$queryRaw<
    {
      id: string;
      from_type: string;
      from_id: string;
      to_type: string;
      to_id: string;
      kind: string;
      at_year: number | null;
      at_month: number | null;
      at_day: number | null;
      at_abs: number | null;
      at_confidence: string | null;
      event_id: string | null;
    }[]
  >`
    SELECT id, from_type, from_id, to_type, to_id, kind,
           at_year, at_month, at_day, at_abs, at_confidence, event_id
    FROM relations
    WHERE kind = ANY(${[...FATE_RELATION_KINDS]}::text[])
      AND at_abs IS NOT NULL
      AND at_abs >= ${fromAbs}::int
      AND at_abs <= ${toAbs}::int`;

  const relations = relationRows.map((row) =>
    mapRelation({
      id: row.id,
      fromType: row.from_type,
      fromId: row.from_id,
      toType: row.to_type,
      toId: row.to_id,
      kind: row.kind,
      atYear: row.at_year,
      atMonth: row.at_month,
      atDay: row.at_day,
      atAbs: row.at_abs,
      atConfidence: row.at_confidence,
      eventId: row.event_id,
    }),
  );

  return TimelineSliceSchema.parse({
    dynasties,
    dynastyGroups,
    dynastyLaneGroups,
    reigns,
    events,
    persons,
    relations,
  });
}

export async function registerRoutes(app: FastifyInstance) {
  app.get("/settings/events", async () => {
    const row = await prisma.sysConfig.findUnique({ where: { key: "event-display" } });
    const parsed = row ? EventDisplayConfigSchema.safeParse(row.value) : null;
    return parsed?.success ? parsed.data : DEFAULT_EVENT_DISPLAY_CONFIG;
  });

  app.put("/settings/events", async (request, reply) => {
    const parsed = EventDisplayConfigSchema.safeParse(request.body);
    if (!parsed.success) return reply.code(400).send({ error: "Invalid event display settings" });
    await prisma.sysConfig.upsert({
      where: { key: "event-display" },
      create: { key: "event-display", value: parsed.data },
      update: { value: parsed.data },
    });
    return parsed.data;
  });
  app.get("/health", async () => ({ ok: true }));

  app.get("/bounds", async (_request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const [dynastySpan, eventSpan] = await Promise.all([
      prisma.$queryRaw<{ min_abs: number | null; max_abs: number | null }[]>`
        SELECT MIN(start_abs) AS min_abs, MAX(end_abs) AS max_abs FROM dynasties`,
      prisma.$queryRaw<{ min_abs: number | null; max_abs: number | null }[]>`
        SELECT MIN(COALESCE(start_abs, at_abs)) AS min_abs,
               MAX(COALESCE(end_abs, at_abs)) AS max_abs
        FROM events`,
    ]);
    const mins = [dynastySpan[0]?.min_abs, eventSpan[0]?.min_abs].filter(
      (value): value is number => value != null,
    );
    const maxs = [dynastySpan[0]?.max_abs, eventSpan[0]?.max_abs].filter(
      (value): value is number => value != null,
    );
    if (mins.length === 0 || maxs.length === 0) {
      return { minAbs: -30_000, maxAbs: 25_000 };
    }
    return { minAbs: Math.min(...mins), maxAbs: Math.max(...maxs) };
  });

  app.get("/timeline-catalog", async (request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const query = request.query as { scope?: string };
    const dynastyRows = query.scope
      ? await prisma.dynasty.findMany({ where: { scope: query.scope } })
      : await prisma.dynasty.findMany();
    const [dynastyGroupRows, dynastyLaneGroups] = await Promise.all([
      prisma.dynastyGroup.findMany(),
      prisma.dynastyLaneGroup.findMany(),
    ]);
    return TimelineCatalogSchema.parse({
      dynasties: dynastyRows.map(mapDynasty),
      dynastyGroups: dynastyGroupRows.map(mapDynastyGroup),
      dynastyLaneGroups: dynastyLaneGroups.map(mapDynastyLaneGroup),
    });
  });

  app.get("/timeline", async (request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const query = request.query as {
      from?: string;
      to?: string;
      lod?: string;
      scope?: string;
    };
    const fromAbs = Number(query.from);
    const toAbs = Number(query.to);
    if (!Number.isFinite(fromAbs) || !Number.isFinite(toAbs)) {
      reply.code(400);
      return { error: "from and to are required numeric AbsMonth values" };
    }

    return loadTimelineSlice(fromAbs, toAbs, query.scope);
  });

  app.get("/entities/:type/:id", async (request, reply) => {
    reply.header("Cache-Control", "no-store");
    const params = request.params as { type: string; id: string };
    if (!["dynasty", "reign", "person", "event", "location_mapping"].includes(params.type)) {
      reply.code(400);
      return { error: "Invalid entity type" };
    }

    try {
      if (params.type === "location_mapping") {
        const store=await loadStore();
        return EntityDetailSchema.parse(buildEntityDetail(store,{type:"location_mapping",id:params.id}));
      }

      const query = request.query as { focusReign?: string };
      let entityType = params.type;
      let entityId = params.id;
      let focusReignId = query.focusReign;

      if (params.type === "person" || params.type === "reign") {
        const requestedPersonId = params.type === "person" ? params.id : null;
        focusReignId = params.type === "reign" ? params.id : focusReignId;
        const bundle = await loadPersonDetailBundle(
          requestedPersonId,
          focusReignId ?? null,
        );
        if (!bundle) {
          reply.code(404);
          return { error: "Entity not found" };
        }
        const locationMappings = await loadPersonDetailLocations(
          bundle.store,
          bundle.selectedReignIds,
        );
        const detail = buildEntityDetail(
          { ...bundle.store, locationMappings },
          { type: "person", id: bundle.personId },
          {
            focusReignId,
            selectedReignIds: bundle.selectedReignIds,
            focusReignIndex: bundle.focusReignIndex,
            reignCount: bundle.reignCount,
          },
        );
        return EntityDetailSchema.parse(detail);
      }

      const store = await loadStore();

      const detail = buildEntityDetail(
        store,
        {
          type: entityType as "dynasty" | "person" | "event",
          id: entityId,
        },
        {},
      );
      return EntityDetailSchema.parse(detail);
    } catch {
      reply.code(404);
      return { error: "Entity not found" };
    }
  });

  app.get("/search", async (request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const query = request.query as { q?: string };
    const q = normalizeSearchTerm(query.q ?? "");
    if (!q) return [];

    return SearchHitSchema.array().parse(searchEntities(await loadStore(),query.q ?? ""));
  });

  app.get("/locations",async (_request,reply)=>{
    reply.header("Cache-Control",CACHE_HEADER);
    return LocationSchema.array().parse((await prisma.location.findMany({orderBy:{id:"asc"}})).map(mapLocation));
  });
  app.get("/location-mappings",async (request,reply)=>{
    reply.header("Cache-Control",CACHE_HEADER);
    const q=request.query as {kind?:string;externalId?:string;locationId?:string;from?:string;to?:string};
    const kind=q.kind ? LocationKindSchema.safeParse(q.kind) : undefined;
    if(kind && !kind.success) return reply.code(400).send({error:"Invalid location kind"});
    const from=q.from == null ? undefined : Number(q.from),to=q.to == null ? undefined : Number(q.to);
    if((from == null)!==(to == null) || from != null && (!Number.isInteger(from) || !Number.isInteger(to) || from>to!)) return reply.code(400).send({error:"from/to must be an ordered pair of integer AbsMonth values"});
    return LocationMappingSchema.array().parse(await loadMappings({kind:kind?.success ? kind.data : undefined,externalId:q.externalId,locationId:q.locationId,fromAbs:from,toAbs:to}));
  });
}
