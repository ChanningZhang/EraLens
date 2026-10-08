import { TimePointSchema, DateConfidenceSchema, HistoricalDateSchema } from "./historicalDateSchemas.mjs";
import { parseDynastyName, validateDynastyName } from "./dynastyNameFormat.mjs";
import { DynastyFeudalRankDefinitionSchema } from "./dynastyFeudalRank";
import { assertEntityAssociation } from "./entityAssociations.mjs";
import { z } from "zod";

export const PrecisionSchema = z.enum(["year", "month", "day"]);
export type Precision = z.infer<typeof PrecisionSchema>;

export const EventPrecisionSchema = z.enum([
  "day",
  "month",
  "year",
  "decade",
  "century",
]);
export type EventPrecision = z.infer<typeof EventPrecisionSchema>;

export const EventTimeModeSchema = z.enum(["point", "span"]);
export type EventTimeMode = z.infer<typeof EventTimeModeSchema>;

export { TimePointSchema, DateConfidenceSchema, HistoricalDateSchema } from "./historicalDateSchemas.mjs";
export type HistoricalDateConfidence = z.infer<typeof DateConfidenceSchema>;
export type HistoricalDate = z.infer<typeof HistoricalDateSchema>;

export const TimeRangeSchema = z.object({
  start: TimePointSchema,
  end: TimePointSchema,
});

export const ScopeSchema = z.enum(["cn", "global"]);
export type Scope = z.infer<typeof ScopeSchema>;

export const ColorTokenSchema = z.enum([
  "cinnabar",
  "mineral",
  "ochre",
  "indigo",
  "moss",
  "wisteria",
  "grape",
  "stone",
  "jade",
  "coral",
  "plum",
  "azure",
  "amber",
  "clay",
  "sage",
  "slate",
  "crimson",
  "bronze",
  "rose",
  "lime",
  "navy",
  "peacock",
  "copper",
  "mulberry",
  "gold",
]);
export type ColorToken = z.infer<typeof ColorTokenSchema>;
export const COLOR_TOKENS = ColorTokenSchema.options;

export const DynastyGroupSchema = z.object({
  id: z.string(),
  name: z.string(),
  altNames: z.array(z.string()).default([]),
  scope: ScopeSchema.default("cn"),
  start: TimePointSchema,
  end: TimePointSchema,
  startAbs: z.number(),
  endAbs: z.number(),
  /** Derived at the API boundary from endpoint confidence; not persisted. */
  precision: PrecisionSchema.default("year"),
  startConfidence: DateConfidenceSchema.optional(),
  endConfidence: DateConfidenceSchema.optional(),
  note: z.string().optional(),
});

export const DynastySchema = z.object({
  id: z.string(),
  name: z.string().superRefine((name, ctx) => {
    try { parseDynastyName(name); } catch (error) {
      ctx.addIssue({ code: "custom", message: error instanceof Error ? error.message : "Invalid dynasty name" });
    }
  }),
  altNames: z.array(z.string()).default([]),
  /** Founding or ruling ethnic group, when historically well supported. */
  ethnicity: z.string().trim().min(1).optional(),
  /** Time-varying one-character label from the cited Zhou states table. */
  feudalRank: DynastyFeudalRankDefinitionSchema.optional(),
  scope: ScopeSchema.default("cn"),
  region: z.string().default("east_asia"),
  start: TimePointSchema,
  end: TimePointSchema.optional(),
  startAbs: z.number(),
  endAbs: z.number(),
  /** Derived at the API boundary from endpoint confidence; not persisted. */
  precision: PrecisionSchema.default("year"),
  startConfidence: DateConfidenceSchema.optional(),
  endConfidence: DateConfidenceSchema.optional(),
  /** Legacy DB placeholder; lane colors are assigned at render time. */
  colorToken: ColorTokenSchema.optional(),
  parentId: z.string().optional(),
  groupId: z.string().optional(),
  note: z.string().optional(),
  isDeleted: z.boolean().nullable().optional(),
}).superRefine((dynasty, ctx) => {
  try { validateDynastyName(dynasty); } catch (error) {
    ctx.addIssue({ code: "custom", path: ["name"], message: error instanceof Error ? error.message : "Invalid dynasty name" });
  }
});

export const PersonSchema = z.object({
  id: z.string(),
  name: z.string(),
  dynastyId: z.string().optional(),
  title: z.string().optional(),
  altNames: z.array(z.string()).default([]),
  /** 姓 — import-time field from wiki/史料, not inferred at runtime. */
  ancestralXing: z.string().optional(),
  /** 氏 — import-time field from wiki/史料, not inferred at runtime. */
  clanShi: z.string().optional(),
  birth: TimePointSchema.optional(),
  death: TimePointSchema.optional(),
  roles: z.array(z.string()).default([]),
  bio: z.string().optional(),
  links: z
    .array(
      z.object({
        label: z.string(),
        url: z.string(),
      }),
    )
    .default([]),
  /** CSV in DB; pre-Qin values are pure 谥字, with the full appellation in title. */
  posthumousNames: z.array(z.string()).default([]),
  /** Comma-separated in DB; parsed to array at runtime. */
  templeNames: z.array(z.string()).default([]),
  /** Optional in client/mock data; the database owns the persisted search index. */
  searchTerms: z.array(z.string()).optional(),
});

export const AppellationKindSchema = z.enum([
  "posthumous",
  "temple",
  "regnal",
]);

/** Trust level for a reign start/end year when sources disagree or are interpolated. */
export const LegacyDateConfidenceSchema = z.enum([
  "certain",
  "approximate",
  "interpolated",
]);

export const CoordinateSystemSchema = z.enum(["GCJ02", "WGS84"]);
export type CoordinateSystem = z.infer<typeof CoordinateSystemSchema>;

export const CapitalRoleSchema = z.enum(["primary", "secondary", "temporary"]);
export type CapitalRole = z.infer<typeof CapitalRoleSchema>;

export const CapitalLocationSchema = z.object({
  id: z.string(),
  mappingKind: z.enum(["dynasty", "reign"]).optional(),
  dynastyId: z.string(),
  historicalName: z.string(),
  modernName: z.string(),
  longitude: z.number(),
  latitude: z.number(),
  coordinateSystem: CoordinateSystemSchema.default("GCJ02"),
  start: TimePointSchema,
  end: TimePointSchema,
  startAbs: z.number(),
  endAbs: z.number(),
  /** Derived at the API boundary from endpoint confidence; not persisted. */
  precision: PrecisionSchema.default("year"),
  endPrecision: PrecisionSchema.optional(),
  startConfidence: DateConfidenceSchema.optional(),
  endConfidence: DateConfidenceSchema.optional(),
  role: CapitalRoleSchema.default("primary"),
  claimTrack: z.string().optional(),
  /** Explicit reign mapping owners; an empty list never establishes a reign tenure. */
  reignIds: z.array(z.string()).optional(),
  note: z.string().optional(),
  links: z
    .array(
      z.object({
        label: z.string(),
        url: z.string(),
      }),
    )
    .default([]),
});

export const ReignSchema = z.object({
  id: z.string(),
  dynastyId: z.string(),
  personId: z.string(),
  title: z.string(),
  /** Comma-separated in DB; parsed to array at runtime. */
  eraNames: z.array(z.string()).default([]),
  start: TimePointSchema,
  end: TimePointSchema,
  startAbs: z.number(),
  endAbs: z.number(),
  /** End date is open/unknown; endAbs may still cap rendering at the current data window. */
  isOngoing: z.boolean().optional(),
  /** Derived at the API boundary from endpoint confidence; not persisted. */
  precision: PrecisionSchema.default("year"),
  startConfidence: DateConfidenceSchema.optional(),
  endConfidence: DateConfidenceSchema.optional(),
  /** Parallel-claim lane key; absent puts the reign on the main track. */
  claimTrack: z.string().optional(),
  /** Short seat label shown on the card (长安 / 洛阳 / 绍兴监国). */
  claimLabel: z.string().optional(),
  /** Non-formal sovereign: regent, acting head, joint vice-chair, etc. Renders with diagonal stripes. */
  isInformalMonarch: z.boolean().default(false),
  /** Explicitly marked main-line ruler; null/omitted means unclassified. */
  isMain: z.boolean().nullable().optional(),
});

export const EventKindSchema = z.enum([
  "battle",
  "politics",
  "culture",
  "disaster",
  "commerce",
  "agriculture",
  "finance",
  "idiom",
  "poetry",
  "other",
]);

export const EventDisplayConfigSchema = z.object({
  kinds: z.record(EventKindSchema, z.boolean()),
});
export type EventDisplayConfig = z.infer<typeof EventDisplayConfigSchema>;

export const LocationKindSchema = z.enum(["dynasty", "reign", "event"]);
export type LocationKind = z.infer<typeof LocationKindSchema>;
export const LocationSchema = z.object({
  id: z.string(), modernName: z.string(), longitude: z.number().min(-180).max(180),
  latitude: z.number().min(-90).max(90), coordinateSystem: CoordinateSystemSchema,
});
export type Location = z.infer<typeof LocationSchema>;
export const LocationMappingSchema = z.object({
  id: z.string(), locationId: z.string(), kind: LocationKindSchema, externalId: z.string(),
  historicalName: z.string().min(1).refine(name => !/[（）()；;]/u.test(name) && !/代表点|会战|大战/u.test(name), "historicalName must contain only period place names"),
  location: LocationSchema,
  spatialPrecision: z.string().optional(),
  start: TimePointSchema.optional(), end: TimePointSchema.optional(), startAbs: z.number().optional(), endAbs: z.number().optional(),
  startConfidence: DateConfidenceSchema.optional(), endConfidence: DateConfidenceSchema.optional(),
  role: CapitalRoleSchema.optional(), note: z.string().optional(),
  links: z.array(z.object({ label: z.string(), url: z.string() })).default([]),
}).superRefine((m, ctx) => {
  if (m.location.id !== m.locationId) ctx.addIssue({code: z.ZodIssueCode.custom, message: "Location reference mismatch", path: ["locationId"]});
  if (m.kind !== "event" && (!m.start || !m.end || m.startAbs == null || m.endAbs == null || !m.role)) ctx.addIssue({code: z.ZodIssueCode.custom, message: "Capital mapping requires dated endpoints and role"});
  if (m.kind === "event" && (m.start || m.end || m.role || m.startAbs != null || m.endAbs != null)) ctx.addIssue({code: z.ZodIssueCode.custom, message: "Event mapping dates belong to its event"});
});
export type LocationMapping = z.infer<typeof LocationMappingSchema>;

export const DEFAULT_EVENT_DISPLAY_CONFIG: EventDisplayConfig = {
  kinds: {
    battle: true, politics: true, culture: true, disaster: true, commerce: true,
    agriculture: true, finance: true, idiom: true, poetry: true, other: true,
  },
};

export const EventSchema = z
  .object({
    id: z.string(),
    name: z.string(),
    kind: EventKindSchema.default("other"),
    timeMode: EventTimeModeSchema.default("point"),
    /** Derived presentation granularity; the database stores endpoint confidence. */
    precision: EventPrecisionSchema.default("year"),
    atConfidence: DateConfidenceSchema.optional(),
    startConfidence: DateConfidenceSchema.optional(),
    endConfidence: DateConfidenceSchema.optional(),
    dateNote: z.string().optional(),
    start: TimePointSchema.optional(),
    end: TimePointSchema.optional(),
    at: TimePointSchema.optional(),
    startAbs: z.number().optional(),
    endAbs: z.number().optional(),
    atAbs: z.number().optional(),
    dynastyIds: z.array(z.string()).default([]),
    participantIds: z.array(z.string()).default([]),
    summary: z.string().optional(),
    meaning: z.string().optional(),
    content: z.string().optional(),
    links: z.array(z.object({ label: z.string(), url: z.string() })).optional(),
    locationMappings: z.array(LocationMappingSchema).default([]),
  })
  .superRefine((event, ctx) => {
    if (event.kind === "idiom") {
      if (event.timeMode !== "point") {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: "idiom events must use timeMode point",
          path: ["timeMode"],
        });
      }
      if (!event.meaning?.trim()) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: "idiom events require meaning",
          path: ["meaning"],
        });
      }
    }
    if (event.timeMode === "point" && event.atAbs == null) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: "point events require atAbs",
        path: ["atAbs"],
      });
    }
    if (
      event.timeMode === "span" &&
      (event.startAbs == null || event.endAbs == null)
    ) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: "span events require startAbs and endAbs",
        path: ["startAbs"],
      });
    }
  });

export const EntityAssociationSchema = z.object({ aRef: z.string(), bRef: z.string() }).strict().superRefine((row, ctx) => {
  try { assertEntityAssociation(row); } catch (error) { ctx.addIssue({code: z.ZodIssueCode.custom, message: String(error)}); }
});

export const RelationKindSchema = z.enum([
  "succession",
  "killed",
  "surrender",
  "abdication",
  "captured",
  "conquered",
]);
export type RelationKind = z.infer<typeof RelationKindSchema>;

export const FATE_RELATION_KINDS = [
  "killed",
  "surrender",
  "abdication",
  "captured",
  "conquered",
] as const satisfies readonly RelationKind[];
export type FateRelationKind = (typeof FATE_RELATION_KINDS)[number];

export const RelationSchema = z
  .object({
    id: z.string(),
    fromRef: z.string(),
    toRef: z.string(),
    kind: RelationKindSchema,
    at: TimePointSchema.optional(),
    atAbs: z.number().optional(),
    atConfidence: DateConfidenceSchema.optional(),
    eventId: z.string().optional(),
  })
  .superRefine((relation, ctx) => {
    if (relation.kind === "succession") {
      if (!/^person:.+$/u.test(relation.fromRef) || !/^person:.+$/u.test(relation.toRef)) ctx.addIssue({code: z.ZodIssueCode.custom, message: "succession requires person endpoints"});
      return;
    }
    if (relation.atAbs == null) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: "fate relations require atAbs",
        path: ["atAbs"],
      });
    }
    const fromOk =
      relation.fromRef.startsWith("person:") || relation.fromRef.startsWith("reign:");
    if (!fromOk || !relation.toRef.startsWith("person:")) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: "fate relations require person:to and person:/reign:from endpoints",
        path: ["fromRef"],
      });
    }
  });

export const EntityRefSchema = z.object({
  type: z.enum(["dynasty", "reign", "person", "event", "location_mapping"]),
  id: z.string(),
});

export const LodSchema = z.enum(["millennium", "century", "decade", "month"]);
export type Lod = z.infer<typeof LodSchema>;

export const TimelineSliceSchema = z.object({
  dynasties: z.array(DynastySchema),
  dynastyGroups: z.array(DynastyGroupSchema).default([]),
  reigns: z.array(ReignSchema),
  events: z.array(EventSchema),
  persons: z.array(PersonSchema).default([]),
  relations: z.array(RelationSchema).default([]),
});

export const TimelineContextSchema = z.object({
  dynasties: z.array(DynastySchema),
  reigns: z.array(ReignSchema),
  persons: z.array(PersonSchema),
});
export const ReignTimelineSchema = TimelineSliceSchema.pick({
  dynasties: true, dynastyGroups: true, reigns: true, persons: true, relations: true,
}).extend({ datasetVersion: z.string(), context: TimelineContextSchema });
export const EventTimelineSchema = z.object({ datasetVersion: z.string(), events: z.array(EventSchema) });
export const PersonTimelineSchema = z.object({ datasetVersion: z.string(), persons: z.array(PersonSchema) });
export type ReignTimeline = z.infer<typeof ReignTimelineSchema>;
export type EventTimeline = z.infer<typeof EventTimelineSchema>;
export type PersonTimeline = z.infer<typeof PersonTimelineSchema>;
export type TimelineContext = z.infer<typeof TimelineContextSchema>;

/** Full dynasty catalog for stable lane-color assignment (no reigns/events). */
export const TimelineCatalogSchema = z.object({
  dynasties: z.array(DynastySchema),
  dynastyGroups: z.array(DynastyGroupSchema).default([]),
});
export type TimelineCatalog = z.infer<typeof TimelineCatalogSchema>;

export const EntityDetailSchema = z.object({
  ref: EntityRefSchema,
  title: z.string(),
  subtitle: z.string().optional(),
  dynastyId: z.string().optional(),
  colorToken: ColorTokenSchema.optional(),
  reignCount: z.number().int().nonnegative().optional(),
  facts: z.array(z.object({ label: z.string(), value: z.string() })).default([]),
  summary: z.string().optional(),
  content: z.string().optional(),
  related: z
    .array(
      z.object({
        ref: EntityRefSchema,
        label: z.string(),
        modernName: z.string().optional(),
        subtitle: z.string().optional(),
        abs: z.number().optional(),
        group: z.enum(["idiom", "poetry", "event", "reign", "person", "dynasty", "location_mapping", "location"]).optional(),
      }),
    )
    .default([]),
  capitalTenures: z
    .array(
      z.object({
        capital: z
          .object({
            ref: EntityRefSchema,
            label: z.string(),
            modernName: z.string(),
            subtitle: z.string().optional(),
          })
          .optional(),
        tenure: z.object({
          ref: EntityRefSchema,
          label: z.string(),
          duration: z.string().optional(),
          name: z.string().optional(),
          abs: z.number(),
          isInformalMonarch: z.boolean().optional(),
        }),
      }),
    )
    .default([]),
  links: z
    .array(
      z.object({
        label: z.string(),
        url: z.string(),
      }),
    )
    .default([]),
});

export const SearchHitSchema = z.object({
  ref: EntityRefSchema,
  label: z.string(),
  subtitle: z.string().optional(),
  abs: z.number().optional(),
});

export type CapitalLocation = z.infer<typeof CapitalLocationSchema>;
export type Dynasty = z.infer<typeof DynastySchema>;
export type DynastyGroup = z.infer<typeof DynastyGroupSchema>;
export type Reign = z.infer<typeof ReignSchema>;
export type AppellationKind = z.infer<typeof AppellationKindSchema>;
export type Person = z.infer<typeof PersonSchema>;
export type Event = z.output<typeof EventSchema>;
export type Relation = z.infer<typeof RelationSchema>;
export type EntityRef = z.infer<typeof EntityRefSchema>;
export type TimelineSlice = z.infer<typeof TimelineSliceSchema>;
export type EntityDetail = z.infer<typeof EntityDetailSchema>;
export type SearchHit = z.infer<typeof SearchHitSchema>;

export const COLOR_VALUES: Record<ColorToken, string> = {
  cinnabar: "#D4382A",
  mineral: "#1A8F8F",
  ochre: "#C4922A",
  indigo: "#2F4A9E",
  moss: "#5A8F3C",
  wisteria: "#9B6CC8",
  grape: "#7A3565",
  stone: "#4E6A82",
  jade: "#1F9B62",
  coral: "#E85D3B",
  plum: "#9B3D8F",
  azure: "#2A85C4",
  amber: "#E09018",
  clay: "#C25E40",
  sage: "#6B9270",
  slate: "#5B5E9C",
  crimson: "#C41E3A",
  bronze: "#9C7428",
  rose: "#D14E86",
  lime: "#7CAD1E",
  navy: "#1B3568",
  peacock: "#148F8F",
  copper: "#B45A24",
  mulberry: "#7A3F82",
  gold: "#C9A227",
};
