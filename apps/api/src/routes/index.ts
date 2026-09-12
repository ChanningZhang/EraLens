import {
  buildEntityDetail,
  computeBounds,
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
               start_abs, end_abs, precision, color_token, parent_id, note
        FROM dynasties
        WHERE span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')
          AND scope = ${scope}`
    : await prisma.$queryRaw<RawDynastyRow[]>`
        SELECT id, name, alt_names, scope, region, start_year, start_month, end_year, end_month,
               start_abs, end_abs, precision, color_token, parent_id, note
        FROM dynasties
        WHERE span && int4range(${fromAbs}::int, ${toAbs}::int, '[]')`;

  const dynastyIds = dynastyRows.map((row) => row.id);

  const [personRows, reignPersonRows] = await Promise.all([
    prisma.person.findMany({
      where: {
        birthYear: { not: null },
        birthMonth: { not: null },
        deathYear: { not: null },
        deathMonth: { not: null },
        reigns: { none: {} },
      },
    }),
    prisma.reign.findMany({ select: { personId: true } }),
  ]);
  const reignPersonIds = new Set(reignPersonRows.map((row) => row.personId));
  const persons = personRows
    .map(mapPerson)
    .filter((person) => {
      if (reignPersonIds.has(person.id)) return false;
      const life = personLifeAbs(person);
      if (!life) return false;
      return rangeIntersectsWindow(life.startAbs, life.endAbs, fromAbs, toAbs);
    });

  if (dynastyIds.length === 0) {
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
    const store = await loadStore();
    return computeBounds(store);
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
