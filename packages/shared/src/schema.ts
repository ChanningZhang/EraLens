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

export const EventTimeModeSchema = z.enum(["point", "span", "circa"]);
export type EventTimeMode = z.infer<typeof EventTimeModeSchema>;

export const TimePointSchema = z.object({
  year: z.number(),
  month: z.number().int().min(1).max(12),
  day: z.number().int().min(1).max(31).optional(),
});

export const TimeRangeSchema = z.object({
  start: TimePointSchema,
  end: TimePointSchema,
  precision: PrecisionSchema.default("year"),
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

export const DynastyLaneGroupSchema = z.object({
  id: z.string(),
  primaryDynastyId: z.string(),
  phaseDynastyIds: z.array(z.string()),
  laneOrderStartAbs: z.number(),
  laneOrderEndAbs: z.number(),
});

export const DynastyGroupSchema = z.object({
  id: z.string(),
  name: z.string(),
  altNames: z.array(z.string()).default([]),
  scope: ScopeSchema.default("cn"),
  start: TimePointSchema,
  end: TimePointSchema,
  startAbs: z.number(),
  endAbs: z.number(),
  precision: PrecisionSchema.default("year"),
  note: z.string().optional(),
});

export const DynastySchema = z.object({
  id: z.string(),
  name: z.string(),
  altNames: z.array(z.string()).default([]),
  scope: ScopeSchema.default("cn"),
  region: z.string().default("east_asia"),
  start: TimePointSchema,
  end: TimePointSchema,
  startAbs: z.number(),
  endAbs: z.number(),
  precision: PrecisionSchema.default("year"),
  /** Legacy DB placeholder; lane colors are assigned at render time. */
  colorToken: ColorTokenSchema.optional(),
  parentId: z.string().optional(),
  groupId: z.string().optional(),
  note: z.string().optional(),
});

export const PersonSchema = z.object({
  id: z.string(),
  name: z.string(),
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
  /** Comma-separated in DB; parsed to array at runtime. */
  posthumousNames: z.array(z.string()).default([]),
  /** Comma-separated in DB; parsed to array at runtime. */
  templeNames: z.array(z.string()).default([]),
  /** Optional in client/mock data; the database owns the persisted search index. */
  searchTerms: z.array(z.string()).optional(),
});

export const AppellationKindSchema = z.enum([
  "posthumous",
  "temple",
  "era",
  "regnal",
]);

/**
 * Marker for a ruler who is not on the conventionally counted master line.
 * With `claimTrack`: concurrent claimant (隋末三帝并立, 南明鲁监国 / 绍武),
 * secondary parallel row. Without `claimTrack`: sequential usurper on the main
 * row (有穷代夏), no gold and no extra stack. Absent means main succession.
 */
export const ClaimRoleSchema = z.enum(["rival"]);

/** Trust level for a reign start/end year when sources disagree or are interpolated. */
export const DateConfidenceSchema = z.enum([
  "certain",
  "approximate",
  "interpolated",
]);

export const CoordinateSystemSchema = z.enum(["GCJ02", "WGS84"]);
export type CoordinateSystem = z.infer<typeof CoordinateSystemSchema>;

export const CapitalRoleSchema = z.enum(["primary", "secondary", "temporary"]);
export type CapitalRole = z.infer<typeof CapitalRoleSchema>;

export const DynastyCapitalSchema = z.object({
  id: z.string(),
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
  precision: PrecisionSchema.default("year"),
  /** Optional end boundary precision when the start is known only by year. */
  endPrecision: PrecisionSchema.optional(),
  startDateConfidence: DateConfidenceSchema.optional(),
  endDateConfidence: DateConfidenceSchema.optional(),
  role: CapitalRoleSchema.default("primary"),
  claimTrack: z.string().optional(),
  /** Explicit reign-capital links; an empty list uses dynasty/time ownership. */
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
  precision: PrecisionSchema.default("year"),
  /** Omitted = certain. Mark approximate/interpolated when the year is estimated. */
  startDateConfidence: DateConfidenceSchema.optional(),
  endDateConfidence: DateConfidenceSchema.optional(),
  /** Parallel-claim lane key; absent puts the reign on the main track. */
  claimTrack: z.string().optional(),
  /** Short seat label shown on the card (长安 / 洛阳 / 绍兴监国). */
  claimLabel: z.string().optional(),
  claimRole: ClaimRoleSchema.optional(),
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
    precision: EventPrecisionSchema.default("year"),
    /** Date is known only approximately; independent from circa range semantics. */
    isApproximate: z.boolean().default(false),
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
    locationId: z.string().optional(),
    location: z.object({
      id: z.string(),
      historicalName: z.string(),
      modernName: z.string(),
      longitude: z.number(),
      latitude: z.number(),
      coordinateSystem: z.string(),
      precision: z.string(),
      note: z.string().optional(),
      links: z.array(z.object({ label: z.string(), url: z.string() })).default([]),
    }).optional(),
    locations: z.array(z.object({
      id: z.string(),
      historicalName: z.string(),
      modernName: z.string(),
      longitude: z.number(),
      latitude: z.number(),
      coordinateSystem: z.string(),
      precision: z.string(),
      note: z.string().optional(),
      links: z.array(z.object({ label: z.string(), url: z.string() })).default([]),
    })).default([]),
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
      (event.timeMode === "span" || event.timeMode === "circa") &&
      (event.startAbs == null || event.endAbs == null)
    ) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: "span/circa events require startAbs and endAbs",
        path: ["startAbs"],
      });
    }
  });

export const RelationKindSchema = z.enum([
  "succession",
  "battle",
  "alliance",
  "enthronement",
  "other",
  "killed",
  "surrender",
  "abdication",
  "captured",
]);
export type RelationKind = z.infer<typeof RelationKindSchema>;

export const FATE_RELATION_KINDS = [
  "killed",
  "surrender",
  "abdication",
  "captured",
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
    precision: PrecisionSchema.optional(),
    eventId: z.string().optional(),
  })
  .superRefine((relation, ctx) => {
    if (!FATE_RELATION_KINDS.includes(relation.kind as FateRelationKind)) {
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
  type: z.enum(["dynasty", "reign", "person", "event", "capital"]),
  id: z.string(),
});

export const LodSchema = z.enum(["millennium", "century", "decade", "month"]);
export type Lod = z.infer<typeof LodSchema>;

export const TimelineSliceSchema = z.object({
  dynasties: z.array(DynastySchema),
  dynastyGroups: z.array(DynastyGroupSchema).default([]),
  dynastyLaneGroups: z.array(DynastyLaneGroupSchema).default([]),
  reigns: z.array(ReignSchema),
  events: z.array(EventSchema),
  persons: z.array(PersonSchema).default([]),
  relations: z.array(RelationSchema).default([]),
});

/** Full dynasty catalog for stable lane-color assignment (no reigns/events). */
export const TimelineCatalogSchema = z.object({
  dynasties: z.array(DynastySchema),
  dynastyGroups: z.array(DynastyGroupSchema).default([]),
  dynastyLaneGroups: z.array(DynastyLaneGroupSchema).default([]),
});
export type TimelineCatalog = z.infer<typeof TimelineCatalogSchema>;

export const EntityDetailSchema = z.object({
  ref: EntityRefSchema,
  title: z.string(),
  subtitle: z.string().optional(),
  dynastyId: z.string().optional(),
  colorToken: ColorTokenSchema.optional(),
  facts: z.array(z.object({ label: z.string(), value: z.string() })).default([]),
  summary: z.string().optional(),
  content: z.string().optional(),
  related: z
    .array(
      z.object({
        ref: EntityRefSchema,
        label: z.string(),
        subtitle: z.string().optional(),
        abs: z.number().optional(),
        group: z.enum(["idiom", "poetry", "event", "reign", "person", "dynasty", "capital", "location"]).optional(),
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
            subtitle: z.string().optional(),
          })
          .optional(),
        tenure: z.object({
          ref: EntityRefSchema,
          label: z.string(),
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

export type DynastyCapital = z.infer<typeof DynastyCapitalSchema>;
export type Dynasty = z.infer<typeof DynastySchema>;
export type DynastyGroup = z.infer<typeof DynastyGroupSchema>;
export type DynastyLaneGroup = z.infer<typeof DynastyLaneGroupSchema>;
export type Reign = z.infer<typeof ReignSchema>;
export type ClaimRole = z.infer<typeof ClaimRoleSchema>;
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
