import {
  buildEntityDetail,
  DynastyCapitalSchema,
  EntityDetailSchema,
  eventKindLabel,
  eventSpanAbs,
  normalizeSearchTerm,
  personIntersectsAbsWindow,
  personSearchAnchorAbs,
  personTimelinePlacement,
  SearchHitSchema,
  TimelineCatalogSchema,
  TimelineSliceSchema,
  type Event,
} from "@eralens/shared";
import type { FastifyInstance } from "fastify";
import { prisma } from "../db.js";
import {
  mapDynasty,
  mapDynastyCapital,
  mapDynastyGroup,
  mapDynastyLaneGroup,
  mapEvent,
  mapPerson,
  mapReign,
  mapRelation,
  toTimelineDataStore,
  type RawDynastyCapitalRow,
  type RawDynastyGroupRow,
  type RawDynastyRow,
  type RawEventRow,
  type RawReignRow,
} from "../mappers.js";

const CACHE_HEADER = "public, max-age=60";

async function loadStore() {
  const [personRows, dynastyRows, reignRows, eventRows, relationRows] = await Promise.all([
    prisma.person.findMany(),
    prisma.dynasty.findMany(),
    prisma.reign.findMany(),
    prisma.event.findMany({
      include: { dynasties: true, participants: true },
    }),
    prisma.relation.findMany(),
  ]);

  return toTimelineDataStore({
    persons: personRows.map(mapPerson),
    dynasties: dynastyRows.map(mapDynasty),
    reigns: reignRows.map((row) => mapReign(row)),
    events: eventRows.map(mapEvent),
    relations: relationRows.map(mapRelation),
  });
}

/** Event dynasties provide context; their visibility does not gate the event marker. */
async function loadEventsInWindow(fromAbs: number, toAbs: number) {
  const eventRows = await prisma.$queryRaw<RawEventRow[]>`
    SELECT id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs,
           start_year, start_month, start_abs, end_year, end_month, end_abs, summary, meaning, content
    FROM events
    WHERE span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')`;

  const eventIds = eventRows.map((row) => row.id);
  const [eventDynasties, eventParticipants] = await Promise.all([
    eventIds.length
      ? prisma.eventDynasty.findMany({ where: { eventId: { in: eventIds } } })
      : Promise.resolve([]),
    eventIds.length
      ? prisma.eventParticipant.findMany({ where: { eventId: { in: eventIds } } })
      : Promise.resolve([]),
  ]);

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
        SELECT id, name, alt_names, scope, region, start_year, start_month, end_year, end_month,
               start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs,
               parent_id, group_id, note
        FROM dynasties
        WHERE span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')
          AND scope = ${scope}`
    : await prisma.$queryRaw<RawDynastyRow[]>`
        SELECT id, name, alt_names, scope, region, start_year, start_month, end_year, end_month,
               start_abs, end_abs, precision, color_token, orthodox_from_abs, orthodox_end_abs,
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
           start_abs, end_abs, precision,
           start_date_confidence, end_date_confidence,
           claim_track, claim_label, claim_role, is_informal_monarch
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
          SELECT id, name, alt_names, scope, start_year, start_month, end_year, end_month,
                 start_abs, end_abs, precision, note
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
      at_abs: number | null;
      precision: string | null;
      event_id: string | null;
    }[]
  >`
    SELECT id, from_type, from_id, to_type, to_id, kind,
           at_year, at_month, at_abs, precision, event_id
    FROM relations
    WHERE kind IN ('killed', 'surrender', 'abdication', 'captured')
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
      atAbs: row.at_abs,
      precision: row.precision,
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
    reply.header("Cache-Control", CACHE_HEADER);
    const params = request.params as { type: string; id: string };
    if (!["dynasty", "reign", "person", "event", "capital"].includes(params.type)) {
      reply.code(400);
      return { error: "Invalid entity type" };
    }

    try {
      if (params.type === "capital") {
        const row = await prisma.dynastyCapital.findUnique({ where: { id: params.id } });
        if (!row) {
          reply.code(404);
          return { error: "Entity not found" };
        }
        const store = await loadStore();
        const detail = buildEntityDetail(
          { ...store, capitals: [mapDynastyCapital(row)] },
          { type: "capital", id: params.id },
        );
        return EntityDetailSchema.parse(detail);
      }

      const store = await loadStore();
      const query = request.query as { focusReign?: string };
      let entityType = params.type;
      let entityId = params.id;
      let focusReignId = query.focusReign;

      if (params.type === "reign") {
        const reign = store.reigns.find((item) => item.id === params.id);
        if (!reign) {
          reply.code(404);
          return { error: "Entity not found" };
        }
        entityType = "person";
        entityId = reign.personId;
        focusReignId = params.id;
      }

      let capitals;
      if (entityType === "dynasty") {
        const dynasty = store.dynasties.find((item) => item.id === entityId);
        if (!dynasty) {
          reply.code(404);
          return { error: "Entity not found" };
        }
        const rows = await prisma.$queryRaw<RawDynastyCapitalRow[]>`
          SELECT id, dynasty_id, historical_name, modern_name,
                 longitude, latitude, coordinate_system,
                 start_year, start_month, start_day,
                 end_year, end_month, end_day,
                 start_abs, end_abs, precision,
                 start_date_confidence, end_date_confidence,
                 role, claim_track, note, links
          FROM dynasty_capitals
          WHERE dynasty_id = ${dynasty.id}
          ORDER BY start_abs, role, id`;
        capitals = rows.map(mapDynastyCapital);
      } else if (entityType === "person") {
        const person = store.persons.find((item) => item.id === entityId);
        if (!person) {
          reply.code(404);
          return { error: "Entity not found" };
        }
        const dynastyIds = [
          ...new Set(
            store.reigns
              .filter((reign) => reign.personId === person.id)
              .map((reign) => reign.dynastyId),
          ),
        ];
        if (dynastyIds.length > 0) {
          const rows = await prisma.dynastyCapital.findMany({
            where: { dynastyId: { in: dynastyIds } },
            orderBy: [{ startAbs: "asc" }, { role: "asc" }, { id: "asc" }],
          });
          capitals = rows.map(mapDynastyCapital);
        }
      }

      const detail = buildEntityDetail(
        capitals ? { ...store, capitals } : store,
        {
          type: entityType as "dynasty" | "person" | "event",
          id: entityId,
        },
        entityType === "person" ? { focusReignId } : {},
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

    const [personRows, dynastyRows, reignRows, eventRows, capitalRows] = await Promise.all([
      prisma.person.findMany({
        where: { searchTerms: { has: q } },
        take: 12,
      }),
      prisma.dynasty.findMany({
        where: { name: { contains: q, mode: "insensitive" } },
        take: 12,
      }),
      prisma.reign.findMany({
        where: { eraNames: { contains: q, mode: "insensitive" } },
        include: { person: true, dynasty: true },
        take: 12,
      }),
      prisma.event.findMany({
        where: {
          OR: [
            { name: { contains: q, mode: "insensitive" } },
            { meaning: { contains: q, mode: "insensitive" } },
          ],
        },
        take: 12,
      }),
      prisma.dynastyCapital.findMany({
        where: {
          OR: [
            { historicalName: { contains: q, mode: "insensitive" } },
            { modernName: { contains: q, mode: "insensitive" } },
          ],
        },
        include: { dynasty: true },
        take: 12,
      }),
    ]);

    const personReigns = personRows.length
      ? await prisma.reign.findMany({
          where: { personId: { in: personRows.map((person) => person.id) } },
          select: { personId: true, startAbs: true },
          orderBy: { startAbs: "asc" },
        })
      : [];

    const hits = [
      ...dynastyRows.map((dynasty) => ({
        ref: { type: "dynasty" as const, id: dynasty.id },
        label: dynasty.name,
        abs: dynasty.startAbs,
      })),
      ...personRows.map((row) => {
        const person = mapPerson(row);
        return {
          ref: { type: "person" as const, id: person.id },
          label: person.name,
          subtitle: person.roles.join(" · "),
          abs: personSearchAnchorAbs(person, personReigns),
        };
      }),
      ...reignRows.map((reign) => ({
        ref: { type: "reign" as const, id: reign.id },
        label:
          reign.eraNames
            ?.split(",")
            .map((name) => name.trim())
            .find((name) => normalizeSearchTerm(name).includes(q)) ?? reign.title,
        subtitle: `${reign.person.name} · ${reign.dynasty.name}`,
        abs: reign.startAbs,
      })),
      ...capitalRows.map((capital) => ({
        ref: { type: "capital" as const, id: capital.id },
        label: capital.historicalName,
        subtitle: `${capital.modernName} · ${capital.dynasty.name} · 都城`,
        abs: capital.startAbs,
      })),
      ...eventRows.map((event) => ({
        ref: { type: "event" as const, id: event.id },
        label: event.name,
        subtitle:
          event.kind === "idiom" ? "成语" : eventKindLabel(event.kind as Event["kind"]),
        abs: eventSpanAbs({
          atAbs: event.atAbs ?? undefined,
          startAbs: event.startAbs ?? undefined,
          endAbs: event.endAbs ?? undefined,
        }).anchorAbs,
      })),
    ].slice(0, 12);
    return SearchHitSchema.array().parse(hits);
  });

  app.get("/capitals", async (request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const query = request.query as { from?: string; to?: string; dynastyId?: string };
    const fromAbs = Number(query.from);
    const toAbs = Number(query.to);
    if (!Number.isFinite(fromAbs) || !Number.isFinite(toAbs)) {
      reply.code(400);
      return { error: "from and to are required numeric AbsMonth values" };
    }

    const rows = query.dynastyId
      ? await prisma.$queryRaw<RawDynastyCapitalRow[]>`
          SELECT id, dynasty_id, historical_name, modern_name,
                 longitude, latitude, coordinate_system,
                 start_year, start_month, start_day,
                 end_year, end_month, end_day,
                 start_abs, end_abs, precision,
                 start_date_confidence, end_date_confidence,
                 role, claim_track, note, links
          FROM dynasty_capitals
          WHERE dynasty_id = ${query.dynastyId}
            AND start_abs <= ${toAbs}::int
            AND end_abs >= ${fromAbs}::int`
      : await prisma.$queryRaw<RawDynastyCapitalRow[]>`
          SELECT id, dynasty_id, historical_name, modern_name,
                 longitude, latitude, coordinate_system,
                 start_year, start_month, start_day,
                 end_year, end_month, end_day,
                 start_abs, end_abs, precision,
                 start_date_confidence, end_date_confidence,
                 role, claim_track, note, links
          FROM dynasty_capitals
          WHERE start_abs <= ${toAbs}::int
            AND end_abs >= ${fromAbs}::int`;

    return DynastyCapitalSchema.array().parse(rows.map(mapDynastyCapital));
  });
}
