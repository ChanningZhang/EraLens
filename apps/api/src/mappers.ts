import { eventAssociationIds, type EntityAssociation } from "@eralens/shared";
import {
  parseAppellationCsv,
  formatAppellationCsv,
  type Dynasty,
  type CapitalLocation,
  type DynastyGroup,
  type Event,
  type HistoricalDateConfidence,
  type Person,
  type Reign,
  type Relation,
  type TimelineDataStore,
  fromAbsMonth,
  confidencePrecision,
} from "@eralens/shared";
import type {
  Dynasty as DbDynasty,
  DynastyGroup as DbDynastyGroup,
  Event as DbEvent,
  Person as DbPerson,
  Reign as DbReign,
  Relation as DbRelation,
} from "@prisma/client";

export type RawDynastyRow = {
  id: string;
  name: string;
  alt_names: string[];
  ethnicity?: string | null;
  scope: string;
  region: string;
  start_year: number;
  start_month: number;
  start_day?: number | null;
  start_confidence?: string;
  end_year: number;
  end_month: number;
  end_day?: number | null;
  end_confidence?: string;
  start_abs: number;
  end_abs: number;
  color_token: string;
  parent_id: string | null;
  group_id: string | null;
  note: string | null;
};

export type RawDynastyGroupRow = {
  id: string;
  name: string;
  alt_names: string[];
  scope: string;
  start_year: number;
  start_month: number;
  start_day?: number | null;
  start_confidence?: string;
  end_year: number;
  end_month: number;
  end_day?: number | null;
  end_confidence?: string;
  start_abs: number;
  end_abs: number;
  note: string | null;
};

export type RawReignRow = {
  id: string;
  dynasty_id: string;
  person_id: string;
  title: string;
  era_names: string | null;
  start_year: number;
  start_month: number;
  start_day: number | null;
  end_year: number | null;
  end_month: number | null;
  end_day: number | null;
  start_abs: number;
  end_abs: number;
  start_confidence?: string;
  end_confidence?: string;
  claim_track: string | null;
  claim_label: string | null;
  is_informal_monarch: boolean;
  is_main: boolean | null;
};

export type RawEventRow = {
  id: string;
  name: string;
  kind: string;
  time_mode: string;
  at_confidence?: string | null;
  start_confidence?: string | null;
  end_confidence?: string | null;
  date_note: string | null;
  at_year: number | null;
  at_month: number | null;
  at_day: number | null;
  at_abs: number | null;
  start_year: number | null;
  start_month: number | null;
  start_day: number | null;
  start_abs: number | null;
  end_year: number | null;
  end_month: number | null;
  end_day: number | null;
  end_abs: number | null;
  summary: string | null;
  meaning: string | null;
  content: string | null;
};

export function mapPerson(row: DbPerson): Person {
  return {
    id: row.id,
    name: row.name,
    title: row.title ?? undefined,
    altNames: row.altNames ?? [],
    ancestralXing: row.ancestralXing ?? undefined,
    clanShi: row.clanShi ?? undefined,
    birth:
      row.birthYear != null && row.birthMonth != null
        ? { year: row.birthYear, month: row.birthMonth, ...(row.birthDay != null ? { day: row.birthDay } : {}), ...(row.birthConfidence ? { confidence: row.birthConfidence as Person["birth"] extends infer T ? T extends { confidence?: infer C } ? C : never : never } : {}) }
        : undefined,
    death:
      row.deathYear != null && row.deathMonth != null
        ? { year: row.deathYear, month: row.deathMonth, ...(row.deathDay != null ? { day: row.deathDay } : {}), ...(row.deathConfidence ? { confidence: row.deathConfidence as NonNullable<Person["death"]>["confidence"] } : {}) }
        : undefined,
    roles: row.roles,
    bio: row.bio ?? undefined,
    links: (row.links as Person["links"]) ?? [],
    posthumousNames: parseAppellationCsv(row.posthumousName),
    templeNames: parseAppellationCsv(row.templeName),
  };
}

export function mapDynastyGroup(
  row: DbDynastyGroup | RawDynastyGroupRow,
): DynastyGroup {
  const altNames = "altNames" in row ? row.altNames : row.alt_names;
  const startYear = "startYear" in row ? row.startYear : row.start_year;
  const startMonth = "startMonth" in row ? row.startMonth : row.start_month;
  const endYear = "endYear" in row ? row.endYear : row.end_year;
  const endMonth = "endMonth" in row ? row.endMonth : row.end_month;
  const startAbs = "startAbs" in row ? row.startAbs : row.start_abs;
  const endAbs = "endAbs" in row ? row.endAbs : row.end_abs;
  const noteValue = row.note;

  return {
    id: row.id,
    name: row.name,
    altNames,
    scope: row.scope as DynastyGroup["scope"],
    start: { year: startYear, month: startMonth, ...("startDay" in row && row.startDay != null ? { day: row.startDay } : "start_day" in row && row.start_day != null ? { day: row.start_day } : {}), confidence: (("startConfidence" in row ? row.startConfidence : row.start_confidence) ?? "year") as HistoricalDateConfidence },
    end: { year: endYear, month: endMonth, ...("endDay" in row && row.endDay != null ? { day: row.endDay } : "end_day" in row && row.end_day != null ? { day: row.end_day } : {}), confidence: (("endConfidence" in row ? row.endConfidence : row.end_confidence) ?? "year") as HistoricalDateConfidence },
    startAbs,
    endAbs,
    precision: confidencePrecision((("startConfidence" in row ? row.startConfidence : row.start_confidence) ?? "year") as HistoricalDateConfidence),
    startConfidence: ("startConfidence" in row ? row.startConfidence : row.start_confidence) as DynastyGroup["startConfidence"],
    endConfidence: ("endConfidence" in row ? row.endConfidence : row.end_confidence) as DynastyGroup["endConfidence"],
    note: noteValue ?? undefined,
  };
}


function toCoordinateNumber(value: { toString(): string } | number | string): number {
  return typeof value === "number" ? value : Number(value);
}

export function mapDynasty(row: DbDynasty | RawDynastyRow): Dynasty {
  const altNames = "altNames" in row ? row.altNames : row.alt_names;
  const startYear = "startYear" in row ? row.startYear : row.start_year;
  const startMonth = "startMonth" in row ? row.startMonth : row.start_month;
  const endYear = "endYear" in row ? row.endYear : row.end_year;
  const endMonth = "endMonth" in row ? row.endMonth : row.end_month;
  const startAbs = "startAbs" in row ? row.startAbs : row.start_abs;
  const endAbs = "endAbs" in row ? row.endAbs : row.end_abs;
  const colorToken = "colorToken" in row ? row.colorToken : row.color_token;
  const parentId = "parentId" in row ? row.parentId : row.parent_id;
  const groupId = "groupId" in row ? row.groupId : row.group_id;
  const noteValue = row.note;

  return {
    id: row.id,
    name: row.name,
    altNames,
    ethnicity: row.ethnicity ?? undefined,
    scope: row.scope as Dynasty["scope"],
    region: row.region,
    start: { year: startYear, month: startMonth, ...("startDay" in row && row.startDay != null ? { day: row.startDay } : "start_day" in row && row.start_day != null ? { day: row.start_day } : {}), confidence: (("startConfidence" in row ? row.startConfidence : row.start_confidence) ?? "year") as HistoricalDateConfidence },
    end: { year: endYear, month: endMonth, ...("endDay" in row && row.endDay != null ? { day: row.endDay } : "end_day" in row && row.end_day != null ? { day: row.end_day } : {}), confidence: (("endConfidence" in row ? row.endConfidence : row.end_confidence) ?? "year") as HistoricalDateConfidence },
    startAbs,
    endAbs,
    precision: confidencePrecision((("startConfidence" in row ? row.startConfidence : row.start_confidence) ?? "year") as HistoricalDateConfidence),
    startConfidence: ("startConfidence" in row ? row.startConfidence : row.start_confidence) as Dynasty["startConfidence"],
    endConfidence: ("endConfidence" in row ? row.endConfidence : row.end_confidence) as Dynasty["endConfidence"],
    colorToken: colorToken as Dynasty["colorToken"],
    parentId: parentId ?? undefined,
    groupId: groupId ?? undefined,
    note: noteValue ?? undefined,
  };
}

export function mapReign(row: DbReign | RawReignRow): Reign {
  const dynastyId = "dynastyId" in row ? row.dynastyId : row.dynasty_id;
  const personId = "personId" in row ? row.personId : row.person_id;
  const eraNamesRaw = "eraNames" in row ? row.eraNames : row.era_names;
  const startYear = "startYear" in row ? row.startYear : row.start_year;
  const startMonth = "startMonth" in row ? row.startMonth : row.start_month;
  const startDay = "startDay" in row ? row.startDay : row.start_day;
  const endYear = "endYear" in row ? row.endYear : row.end_year;
  const endMonth = "endMonth" in row ? row.endMonth : row.end_month;
  const endDay = "endDay" in row ? row.endDay : row.end_day;
  const startAbs = "startAbs" in row ? row.startAbs : row.start_abs;
  const endAbs = "endAbs" in row ? row.endAbs : row.end_abs;
  const claimTrack = "claimTrack" in row ? row.claimTrack : row.claim_track;
  const claimLabel = "claimLabel" in row ? row.claimLabel : row.claim_label;
  const isInformalMonarch =
    "isInformalMonarch" in row ? row.isInformalMonarch : row.is_informal_monarch;
  const isMain = "isMain" in row ? row.isMain : row.is_main;

  return {
    id: row.id,
    dynastyId,
    personId,
    title: row.title,
    eraNames: parseAppellationCsv(eraNamesRaw),
    start: {
      year: startYear,
      month: startMonth,
      ...(startDay != null ? { day: startDay } : {}),
      confidence: (("startConfidence" in row ? row.startConfidence : row.start_confidence) ?? "year") as HistoricalDateConfidence,
    },
    end: {
      // Open-ended reigns retain an end_abs display cap for the current import window.
      year: endYear ?? fromAbsMonth(endAbs).year,
      month: endMonth ?? fromAbsMonth(endAbs).month,
      ...(endDay != null ? { day: endDay } : {}),
      confidence: (("endConfidence" in row ? row.endConfidence : row.end_confidence) ?? "year") as HistoricalDateConfidence,
    },
    startAbs,
    endAbs,
    precision: confidencePrecision((("startConfidence" in row ? row.startConfidence : row.start_confidence) ?? "year") as HistoricalDateConfidence),
    isOngoing: endYear == null || endMonth == null,
    startConfidence: ("startConfidence" in row ? row.startConfidence : row.start_confidence) as Reign["startConfidence"],
    endConfidence: ("endConfidence" in row ? row.endConfidence : row.end_confidence) as Reign["endConfidence"],
    claimTrack: claimTrack ?? undefined,
    claimLabel: claimLabel ?? undefined,
    isInformalMonarch: isInformalMonarch ?? false,
    isMain: isMain ?? undefined,
  };
}

export function mapEvent(
  row: (DbEvent | RawEventRow) & {
    locationMappings?: import("@eralens/shared").LocationMapping[];
  },
  associations: readonly EntityAssociation[] = [],
): Event {
  const atYear = "atYear" in row ? row.atYear : row.at_year;
  const atMonth = "atMonth" in row ? row.atMonth : row.at_month;
  const atDay = "atDay" in row ? row.atDay : row.at_day;
  const atAbs = "atAbs" in row ? row.atAbs : row.at_abs;
  const startYear = "startYear" in row ? row.startYear : row.start_year;
  const startMonth = "startMonth" in row ? row.startMonth : row.start_month;
  const startDay = "startDay" in row ? row.startDay : row.start_day;
  const startAbs = "startAbs" in row ? row.startAbs : row.start_abs;
  const endYear = "endYear" in row ? row.endYear : row.end_year;
  const endMonth = "endMonth" in row ? row.endMonth : row.end_month;
  const endDay = "endDay" in row ? row.endDay : row.end_day;
  const endAbs = "endAbs" in row ? row.endAbs : row.end_abs;
  const timeMode = "timeMode" in row ? row.timeMode : row.time_mode;
  const dateNote = "dateNote" in row ? row.dateNote : row.date_note;
  const meaning = row.meaning;

  return {
    id: row.id,
    name: row.name,
    kind: row.kind as Event["kind"],
    timeMode: (timeMode as Event["timeMode"] | null) ?? "point",
    precision: confidencePrecision((atYear != null ? (("atConfidence" in row ? row.atConfidence : row.at_confidence) ?? "year") : (("startConfidence" in row ? row.startConfidence : row.start_confidence) ?? "year")) as HistoricalDateConfidence),
    atConfidence: (("atConfidence" in row ? row.atConfidence : row.at_confidence) ?? undefined) as Event["atConfidence"],
    startConfidence: (("startConfidence" in row ? row.startConfidence : row.start_confidence) ?? undefined) as Event["startConfidence"],
    endConfidence: (("endConfidence" in row ? row.endConfidence : row.end_confidence) ?? undefined) as Event["endConfidence"],
    dateNote: dateNote ?? undefined,
    at: atYear != null && atMonth != null ? { year: atYear, month: atMonth, ...(atDay != null ? { day: atDay } : {}), confidence: (("atConfidence" in row ? row.atConfidence : row.at_confidence) ?? undefined) as HistoricalDateConfidence | undefined } : undefined,
    start:
      startYear != null && startMonth != null
        ? { year: startYear, month: startMonth, ...(startDay != null ? { day: startDay } : {}), confidence: (("startConfidence" in row ? row.startConfidence : row.start_confidence) ?? undefined) as HistoricalDateConfidence | undefined }
        : undefined,
    end: endYear != null && endMonth != null ? { year: endYear, month: endMonth, ...(endDay != null ? { day: endDay } : {}), confidence: (("endConfidence" in row ? row.endConfidence : row.end_confidence) ?? undefined) as HistoricalDateConfidence | undefined } : undefined,
    atAbs: atAbs ?? undefined,
    startAbs: startAbs ?? undefined,
    endAbs: endAbs ?? undefined,
    ...eventAssociationIds(row.id, associations),
    summary: row.summary ?? undefined,
    meaning: meaning ?? undefined,
    content: row.content ?? undefined,
    locationMappings: row.locationMappings ?? [],
  };
}

export function mapRelation(row: DbRelation): Relation {
  return {
    id: row.id,
    fromRef: `${row.fromType}:${row.fromId}`,
    toRef: `${row.toType}:${row.toId}`,
    kind: row.kind as Relation["kind"],
    at:
      row.atYear != null && row.atMonth != null
        ? { year: row.atYear, month: row.atMonth, ...(row.atDay != null ? { day: row.atDay } : {}) }
        : undefined,
    atAbs: row.atAbs ?? undefined,
    atConfidence: (row.atConfidence as Relation["atConfidence"] | null) ?? undefined,
    eventId: row.eventId ?? undefined,
  };
}

export function toTimelineDataStore(input: {
  locationMappings?: import("@eralens/shared").LocationMapping[];
  persons: Person[];
  dynasties: Dynasty[];
  reigns: Reign[];
  events: Event[];
  relations: Relation[];
  associations?: EntityAssociation[];
}): TimelineDataStore {
  return input;
}
