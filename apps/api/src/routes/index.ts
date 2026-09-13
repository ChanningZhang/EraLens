import {
  buildEntityDetail,
  EntityDetailSchema,
  personLifeAbs,
  rangeIntersectsWindow,
  SearchHitSchema,
  searchEntities,
  TimelineSliceSchema,
} from "@eralens/shared";
import type { FastifyInstance } from "fastify";
import { prisma } from "../db.js";
import {
  mapDynasty,
  mapEvent,
  mapPerson,
  mapReign,
  mapRelation,
  toTimelineDataStore,
  type RawDynastyRow,
  type RawEventRow,
  type RawReignRow,
} from "../mappers.js";

const CACHE_HEADER = "public, max-age=60";

async function loadStore() {
  const [personRows, dynastyRows, reignRows, eventRows, relationRows] = await Promise.all([
    prisma.person.findMany(),
    prisma.dynasty.findMany(),
    prisma.reign.findMany({ include: { eraNames: true } }),
    prisma.event.findMany({
      include: { dynasties: true, participants: true },
    }),
    prisma.relation.findMany(),
  ]);

  return toTimelineDataStore({
    persons: personRows.map(mapPerson),
    dynasties: dynastyRows.map(mapDynasty),
    reigns: reignRows.map((row) => mapReign(row, row.eraNames)),
    events: eventRows.map(mapEvent),
    relations: relationRows.map(mapRelation),
  });
}

async function loadTimelineSlice(fromAbs: number, toAbs: number, scope?: string) {
  const dynastyRows = scope
    ? await prisma.$queryRaw<RawDynastyRow[]>`
        SELECT id, name, alt_names, scope, region, start_year, start_month, end_year, end_month,
               start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
        FROM dynasties
        WHERE span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')
          AND scope = ${scope}`
    : await prisma.$queryRaw<RawDynastyRow[]>`
        SELECT id, name, alt_names, scope, region, start_year, start_month, end_year, end_month,
               start_abs, end_abs, precision, color_token, orthodox_from_abs, parent_id, note
        FROM dynasties
        WHERE span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')`;

  const dynastyIds = dynastyRows.map((row) => row.id);

  if (dynastyIds.length === 0) {
    const personRows = await prisma.person.findMany({
      where: {
        birthYear: { not: null },
        birthMonth: { not: null },
        deathYear: { not: null },
        deathMonth: { not: null },
        reigns: { none: {} },
      },
    });
    const persons = personRows
      .map(mapPerson)
      .filter((person) => {
        const life = personLifeAbs(person);
        if (!life) return false;
        return rangeIntersectsWindow(life.startAbs, life.endAbs, fromAbs, toAbs);
      });
    return TimelineSliceSchema.parse({ dynasties: [], reigns: [], events: [], persons });
  }

  const reignRows = await prisma.$queryRaw<RawReignRow[]>`
    SELECT id, dynasty_id, person_id, title, posthumous_name, temple_name, preferred_appellation,
           start_year, start_month, end_year, end_month, start_abs, end_abs, precision
    FROM reigns
    WHERE dynasty_id = ANY(${dynastyIds}::text[])
      AND span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')`;

  const reignIds = reignRows.map((row) => row.id);
  const eraRows =
    reignIds.length > 0
      ? await prisma.eraName.findMany({
          where: { reignId: { in: reignIds } },
          orderBy: { sortOrder: "asc" },
        })
      : [];

  const eventRows = await prisma.$queryRaw<RawEventRow[]>`
    SELECT id, name, kind, time_mode, precision, date_note, at_year, at_month, at_abs,
           start_year, start_month, start_abs, end_year, end_month, end_abs, summary
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

  const erasByReign = new Map<string, typeof eraRows>();
  for (const era of eraRows) {
    const list = erasByReign.get(era.reignId) ?? [];
    list.push(era);
    erasByReign.set(era.reignId, list);
  }

  const dynasties = dynastyRows.map(mapDynasty);
  const reigns = reignRows.map((row) => mapReign(row, erasByReign.get(row.id) ?? []));
  const visibleReignPersonIds = [...new Set(reignRows.map((row) => row.person_id))];
  const [lifePersonRows, rulerPersonRows] = await Promise.all([
    prisma.person.findMany({
      where: {
        birthYear: { not: null },
        birthMonth: { not: null },
        deathYear: { not: null },
        deathMonth: { not: null },
        reigns: { none: {} },
      },
    }),
    visibleReignPersonIds.length
      ? prisma.person.findMany({ where: { id: { in: visibleReignPersonIds } } })
      : Promise.resolve([]),
  ]);
  const persons = [
    ...rulerPersonRows.map(mapPerson),
    ...lifePersonRows
      .map(mapPerson)
      .filter((person) => {
        const life = personLifeAbs(person);
        if (!life) return false;
        return rangeIntersectsWindow(life.startAbs, life.endAbs, fromAbs, toAbs);
      }),
  ];
  const events = eventRows
    .map((row) =>
      mapEvent({
        ...row,
        dynasties: (dynastiesByEvent.get(row.id) ?? []).map((dynastyId) => ({ dynastyId })),
        participants: (participantsByEvent.get(row.id) ?? []).map((personId) => ({ personId })),
      }),
    )
    .filter((event) => {
      const dynastyHit = event.dynastyIds.some((id: string) => dynastyIds.includes(id));
      return dynastyHit || event.dynastyIds.length === 0;
    });

  return TimelineSliceSchema.parse({ dynasties, reigns, events, persons });
}

export async function registerRoutes(app: FastifyInstance) {
  app.get("/health", async () => ({ ok: true }));

  app.get("/bounds", async (_request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const [dynastySpan, eventSpan] = await Promise.all([
      prisma.$queryRaw<{ min_abs: number | null; max_abs: number | null }[]>`
        SELECT MIN(start_abs) AS min_abs, MAX(end_abs) AS max_abs FROM dynasties`,
      prisma.$queryRaw<{ min_abs: number | null; max_abs: number | null }[]>`
        SELECT MIN(COALESCE(at_abs, start_abs)) AS min_abs,
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
      return { minAbs: 0, maxAbs: 5000 };
    }
    return { minAbs: Math.min(...mins), maxAbs: Math.max(...maxs) };
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
    if (!["dynasty", "reign", "person", "event"].includes(params.type)) {
      reply.code(400);
      return { error: "Invalid entity type" };
    }

    const store = await loadStore();
    try {
      const detail = buildEntityDetail(store, {
        type: params.type as "dynasty" | "reign" | "person" | "event",
        id: params.id,
      });
      return EntityDetailSchema.parse(detail);
    } catch {
      reply.code(404);
      return { error: "Entity not found" };
    }
  });

  app.get("/search", async (request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const query = request.query as { q?: string };
    const store = await loadStore();
    const hits = searchEntities(store, query.q ?? "");
    return SearchHitSchema.array().parse(hits);
  });
}
