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
]);
export type ColorToken = z.infer<typeof ColorTokenSchema>;
export const COLOR_TOKENS = ColorTokenSchema.options;

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
  parentId: z.string().optional(),
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

export const RelationSchema = z.object({
  id: z.string(),
  fromRef: z.string(),
  toRef: z.string(),
  kind: z.enum(["succession", "battle", "alliance", "other"]),
});

export const EntityRefSchema = z.object({
  type: z.enum(["dynasty", "reign", "person", "event"]),
  id: z.string(),
});

export const LodSchema = z.enum(["millennium", "century", "decade", "month"]);
export type Lod = z.infer<typeof LodSchema>;

export const TimelineSliceSchema = z.object({
  dynasties: z.array(DynastySchema),
  reigns: z.array(ReignSchema),
  events: z.array(EventSchema),
  persons: z.array(PersonSchema).default([]),
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
};
