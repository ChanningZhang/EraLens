import {
  DEFAULT_EVENT_DISPLAY_CONFIG,
  EntityDetailSchema,
  EventDisplayConfigSchema,
  LocationKindSchema,
  LocationMappingSchema,
  LocationSchema,
  SearchHitSchema,
  TimelineCatalogSchema,
  TimelineSliceSchema,
  type EntityRef,
} from "@eralens/shared";
import type { TimelineRepository, SettingsStore } from "@eralens/data-access/repository";
import type { FastifyInstance } from "fastify";

const CACHE_HEADER = "public, max-age=60";
const LODS = new Set(["month", "decade", "century", "millennium"]);

export async function registerRoutes(
  app: FastifyInstance,
  repository: TimelineRepository,
  settings: SettingsStore,
  contentInfo: { datasetVersion: string; schemaVersion: number; contractVersion: number },
) {
  app.get("/settings/events", async () => {
    const value = await settings.get("event-display");
    const parsed = value ? EventDisplayConfigSchema.safeParse(JSON.parse(value)) : null;
    return parsed?.success ? parsed.data : DEFAULT_EVENT_DISPLAY_CONFIG;
  });

  app.put("/settings/events", async (request, reply) => {
    const parsed = EventDisplayConfigSchema.safeParse(request.body);
    if (!parsed.success) return reply.code(400).send({ error: "Invalid event display settings" });
    await settings.set("event-display", JSON.stringify(parsed.data));
    return parsed.data;
  });

  app.get("/health", async () => ({ ok: true, ...contentInfo }));

  app.get("/bounds", async (_request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    return repository.getBounds();
  });

  app.get("/timeline-catalog", async (request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const query = request.query as { scope?: string };
    return TimelineCatalogSchema.parse(await repository.getTimelineCatalog(query.scope));
  });

  app.get("/timeline", async (request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const query = request.query as { from?: string; to?: string; lod?: string; scope?: string };
    const fromAbs = Number(query.from);
    const toAbs = Number(query.to);
    if (!Number.isFinite(fromAbs) || !Number.isFinite(toAbs)) {
      return reply.code(400).send({ error: "from and to are required numeric AbsMonth values" });
    }
    if (query.lod && !LODS.has(query.lod)) return reply.code(400).send({ error: "Invalid lod" });
    try {
      return TimelineSliceSchema.parse(await repository.getTimeline({
        fromAbs, toAbs, scope: query.scope, lod: (query.lod ?? "month") as "month" | "decade" | "century" | "millennium",
      }));
    } catch (error) {
      request.log.error(error);
      return reply.code(500).send({ error: "Unable to load timeline" });
    }
  });

  app.get("/entities/:type/:id", async (request, reply) => {
    reply.header("Cache-Control", "no-store");
    const params = request.params as { type: string; id: string };
    if (!["dynasty", "reign", "person", "event", "location_mapping"].includes(params.type)) {
      return reply.code(400).send({ error: "Invalid entity type" });
    }
    const query = request.query as { focusReign?: string; atAbs?: string };
    const atAbs = query.atAbs == null ? undefined : Number(query.atAbs);
    if (atAbs != null && !Number.isFinite(atAbs)) return reply.code(400).send({ error: "Invalid atAbs" });
    try {
      const ref = { type: params.type, id: params.id } as EntityRef;
      return EntityDetailSchema.parse(await repository.getEntity(ref, { focusReignId: query.focusReign, atAbs }));
    } catch {
      return reply.code(404).send({ error: "Entity not found" });
    }
  });

  app.get("/search", async (request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const query = request.query as { q?: string };
    try { return SearchHitSchema.array().parse(await repository.search(query.q ?? "")); }
    catch (error) {
      request.log.error(error);
      return reply.code(500).send({ error: "Unable to search" });
    }
  });

  app.get("/locations", async (_request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    return LocationSchema.array().parse(await repository.getLocations());
  });

  app.get("/location-mappings", async (request, reply) => {
    reply.header("Cache-Control", CACHE_HEADER);
    const query = request.query as { kind?: string; externalId?: string; locationId?: string; from?: string; to?: string };
    const kind = query.kind ? LocationKindSchema.safeParse(query.kind) : undefined;
    if (kind && !kind.success) return reply.code(400).send({ error: "Invalid location kind" });
    const from = query.from == null ? undefined : Number(query.from);
    const to = query.to == null ? undefined : Number(query.to);
    if ((from == null) !== (to == null) || (from != null && (!Number.isInteger(from) || !Number.isInteger(to) || from > to!))) {
      return reply.code(400).send({ error: "from/to must be an ordered pair of integer AbsMonth values" });
    }
    return LocationMappingSchema.array().parse(await repository.getLocationMappings({
      kind: kind?.success ? kind.data : undefined,
      externalId: query.externalId,
      locationId: query.locationId,
      fromAbs: from,
      toAbs: to,
    }));
  });
}
