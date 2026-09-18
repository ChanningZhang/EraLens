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
  colorToken: ColorTokenSchema,
  /** AbsMonth from which this dynasty is displayed as orthodox (gold). Overrides built-in rules when set. */
  orthodoxFromAbs: z.number().optional(),
  /** AbsMonth after which orthodox (gold) display ends, even if the dynasty continues. */
  orthodoxEndAbs: z.number().optional(),
  parentId: z.string().optional(),
  groupId: z.string().optional(),
  note: z.string().optional(),
});

export const EraNameSchema = z.object({
  name: z.string(),
  start: TimePointSchema,
  end: TimePointSchema,
  startAbs: z.number(),
  endAbs: z.number(),
});

export const PersonSchema = z.object({
  id: z.string(),
  name: z.string(),
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
});

export const AppellationKindSchema = z.enum([
  "posthumous",
  "temple",
  "era",
  "regnal",
]);

export const PreferredAppellationSchema = z.object({
  kind: AppellationKindSchema,
  name: z.string(),
});

/**
 * Marker for a ruler who held power concurrently with the dynasty's main line
 * (隋末三帝并立, 南明鲁监国 / 绍武). Absent means the ruler belongs to the
 * conventionally counted succession. Parallel cards share one visual treatment.
 */
export const ClaimRoleSchema = z.enum(["rival"]);

/** Trust level for a reign start/end year when sources disagree or are interpolated. */
export const DateConfidenceSchema = z.enum([
  "certain",
  "approximate",
  "interpolated",
]);

export const ReignSchema = z.object({
  id: z.string(),
  dynastyId: z.string(),
  personId: z.string(),
  title: z.string(),
  posthumousName: z.string().optional(),
  templeName: z.string().optional(),
  preferredAppellation: PreferredAppellationSchema.optional(),
  eraNames: z.array(EraNameSchema).default([]),
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
});

export const EventKindSchema = z.enum([
  "battle",
  "politics",
  "culture",
  "disaster",
  "other",
]);

export const EventSchema = z
  .object({
    id: z.string(),
    name: z.string(),
    kind: EventKindSchema.default("other"),
    timeMode: EventTimeModeSchema.default("point"),
    precision: EventPrecisionSchema.default("year"),
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
  })
  .superRefine((event, ctx) => {
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
  type: z.enum(["dynasty", "reign", "person", "event"]),
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

export const EntityDetailSchema = z.object({
  ref: EntityRefSchema,
  title: z.string(),
  subtitle: z.string().optional(),
  colorToken: ColorTokenSchema.optional(),
  facts: z.array(z.object({ label: z.string(), value: z.string() })).default([]),
  summary: z.string().optional(),
  related: z
    .array(
      z.object({
        ref: EntityRefSchema,
        label: z.string(),
        subtitle: z.string().optional(),
        abs: z.number().optional(),
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

export type Dynasty = z.infer<typeof DynastySchema>;
export type DynastyGroup = z.infer<typeof DynastyGroupSchema>;
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
  cinnabar: "#A8432F",
  mineral: "#3A6B6E",
  ochre: "#9A7B4F",
  indigo: "#3C4E7A",
  moss: "#5C6B4A",
  wisteria: "#BE8A2C",
  grape: "#6E4B5C",
  stone: "#4A5E6B",
  jade: "#3F8A62",
  coral: "#C76A58",
  plum: "#8B5C86",
  azure: "#4F86A8",
  amber: "#C8963E",
  clay: "#B06E52",
  sage: "#7D9172",
  slate: "#636882",
  gold: "#C9A227",
};
