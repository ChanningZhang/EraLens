import {
  parseAppellationCsv,
  formatAppellationCsv,
  type Dynasty,
  type DynastyCapital,
  type DynastyGroup,
  type DynastyLaneGroup,
  type Event,
  type Person,
  type Reign,
  type Relation,
  type TimelineDataStore,
} from "@eralens/shared";
import type {
  Dynasty as DbDynasty,
  DynastyCapital as DbDynastyCapital,
  DynastyGroup as DbDynastyGroup,
  DynastyLaneGroup as DbDynastyLaneGroup,
  Event as DbEvent,
  EventLocation as DbEventLocation,
  Person as DbPerson,
  Reign as DbReign,
  Relation as DbRelation,
} from "@prisma/client";

export type RawDynastyRow = {
  id: string;
  name: string;
  alt_names: string[];
  scope: string;
  region: string;
  start_year: number;
  start_month: number;
  end_year: number;
  end_month: number;
  start_abs: number;
  end_abs: number;
  precision: string;
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
  end_year: number;
  end_month: number;
  start_abs: number;
  end_abs: number;
  precision: string;
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
  end_year: number;
  end_month: number;
  end_day: number | null;
  start_abs: number;
  end_abs: number;
  precision: string;
  start_date_confidence: string | null;
  end_date_confidence: string | null;
  claim_track: string | null;
  claim_label: string | null;
  claim_role: string | null;
  is_informal_monarch: boolean;
  is_main: boolean | null;
};

export type RawDynastyCapitalRow = {
  id: string;
  dynasty_id: string;
  historical_name: string;
  modern_name: string;
  longitude: { toString(): string } | number | string;
  latitude: { toString(): string } | number | string;
  coordinate_system: string;
  start_year: number;
  start_month: number;
  start_day: number | null;
  end_year: number;
  end_month: number;
  end_day: number | null;
  start_abs: number;
  end_abs: number;
  precision: string;
  end_precision: string | null;
  start_date_confidence: string | null;
  end_date_confidence: string | null;
  role: string;
  claim_track: string | null;
  note: string | null;
  links: unknown;
};

export type RawEventRow = {
  id: string;
  name: string;
  kind: string;
  time_mode: string;
  precision: string;
  date_note: string | null;
  at_year: number | null;
  at_month: number | null;
  at_abs: number | null;
  start_year: number | null;
  start_month: number | null;
  start_abs: number | null;
  end_year: number | null;
  end_month: number | null;
  end_abs: number | null;
  summary: string | null;
  meaning: string | null;
  content: string | null;
  location_id: string | null;
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
        ? { year: row.birthYear, month: row.birthMonth }
        : undefined,
    death:
      row.deathYear != null && row.deathMonth != null
        ? { year: row.deathYear, month: row.deathMonth }
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
    start: { year: startYear, month: startMonth },
    end: { year: endYear, month: endMonth },
    startAbs,
    endAbs,
    precision: row.precision as DynastyGroup["precision"],
    note: noteValue ?? undefined,
  };
}

export function mapDynastyLaneGroup(row: DbDynastyLaneGroup): DynastyLaneGroup {
  return {
    id: row.id,
    primaryDynastyId: row.primaryDynastyId,
    phaseDynastyIds: row.phaseDynastyIds,
    laneOrderStartAbs: row.laneOrderStartAbs,
    laneOrderEndAbs: row.laneOrderEndAbs,
  };
}

function toCoordinateNumber(value: { toString(): string } | number | string): number {
  return typeof value === "number" ? value : Number(value);
}

export function mapDynastyCapital(
  row: DbDynastyCapital | RawDynastyCapitalRow,
): DynastyCapital {
  const dynastyId = "dynastyId" in row ? row.dynastyId : row.dynasty_id;
  const historicalName =
    "historicalName" in row ? row.historicalName : row.historical_name;
  const modernName = "modernName" in row ? row.modernName : row.modern_name;
  const coordinateSystem =
    "coordinateSystem" in row ? row.coordinateSystem : row.coordinate_system;
  const startYear = "startYear" in row ? row.startYear : row.start_year;
  const startMonth = "startMonth" in row ? row.startMonth : row.start_month;
  const startDay = "startDay" in row ? row.startDay : row.start_day;
  const endYear = "endYear" in row ? row.endYear : row.end_year;
  const endMonth = "endMonth" in row ? row.endMonth : row.end_month;
  const endDay = "endDay" in row ? row.endDay : row.end_day;
  const startAbs = "startAbs" in row ? row.startAbs : row.start_abs;
  const endAbs = "endAbs" in row ? row.endAbs : row.end_abs;
  const endPrecision = "endPrecision" in row ? row.endPrecision : row.end_precision;
  const startDateConfidence =
    "startDateConfidence" in row ? row.startDateConfidence : row.start_date_confidence;
  const endDateConfidence =
    "endDateConfidence" in row ? row.endDateConfidence : row.end_date_confidence;
  const claimTrack = "claimTrack" in row ? row.claimTrack : row.claim_track;
  const noteValue = row.note;
  const links = (row.links as DynastyCapital["links"]) ?? [];

  return {
    id: row.id,
    dynastyId,
    historicalName,
    modernName,
    longitude: toCoordinateNumber(row.longitude),
    latitude: toCoordinateNumber(row.latitude),
    coordinateSystem: coordinateSystem as DynastyCapital["coordinateSystem"],
    start: {
      year: startYear,
      month: startMonth,
      ...(startDay != null ? { day: startDay } : {}),
    },
    end: {
      year: endYear,
      month: endMonth,
      ...(endDay != null ? { day: endDay } : {}),
    },
    startAbs,
    endAbs,
    precision: row.precision as DynastyCapital["precision"],
    endPrecision: (endPrecision as DynastyCapital["endPrecision"] | null) ?? undefined,
    startDateConfidence:
      (startDateConfidence as DynastyCapital["startDateConfidence"] | null) ?? undefined,
    endDateConfidence:
      (endDateConfidence as DynastyCapital["endDateConfidence"] | null) ?? undefined,
    role: row.role as DynastyCapital["role"],
    claimTrack: claimTrack ?? undefined,
    note: noteValue ?? undefined,
    links,
  };
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
    scope: row.scope as Dynasty["scope"],
    region: row.region,
    start: { year: startYear, month: startMonth },
    end: { year: endYear, month: endMonth },
    startAbs,
    endAbs,
    precision: row.precision as Dynasty["precision"],
    colorToken: colorToken as Dynasty["colorToken"],
    parentId: parentId ?? undefined,
    groupId: groupId ?? undefined,
    note: noteValue ?? undefined,
  };
}

function mapClaimRole(
  claimRole: string | null | undefined,
  claimTrack: string | null | undefined,
): Reign["claimRole"] | undefined {
  if (claimTrack) return "rival";
  if (claimRole === "rival") return "rival";
  return undefined;
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
  const rawClaimRole = "claimRole" in row ? row.claimRole : row.claim_role;
  const startDateConfidence =
    "startDateConfidence" in row ? row.startDateConfidence : row.start_date_confidence;
  const endDateConfidence =
    "endDateConfidence" in row ? row.endDateConfidence : row.end_date_confidence;
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
    },
    end: {
      year: endYear,
      month: endMonth,
      ...(endDay != null ? { day: endDay } : {}),
    },
    startAbs,
    endAbs,
    precision: row.precision as Reign["precision"],
    startDateConfidence:
      (startDateConfidence as Reign["startDateConfidence"] | null) ?? undefined,
    endDateConfidence:
      (endDateConfidence as Reign["endDateConfidence"] | null) ?? undefined,
    claimTrack: claimTrack ?? undefined,
    claimLabel: claimLabel ?? undefined,
    claimRole: mapClaimRole(rawClaimRole, claimTrack),
    isInformalMonarch: isInformalMonarch ?? false,
    isMain: isMain ?? undefined,
  };
}

export function mapEvent(
  row: (DbEvent | RawEventRow) & {
    dynasties: { dynastyId: string }[];
    participants: { personId: string }[];
    location?: DbEventLocation | null;
  },
): Event {
  const atYear = "atYear" in row ? row.atYear : row.at_year;
  const atMonth = "atMonth" in row ? row.atMonth : row.at_month;
  const atAbs = "atAbs" in row ? row.atAbs : row.at_abs;
  const startYear = "startYear" in row ? row.startYear : row.start_year;
  const startMonth = "startMonth" in row ? row.startMonth : row.start_month;
  const startAbs = "startAbs" in row ? row.startAbs : row.start_abs;
  const endYear = "endYear" in row ? row.endYear : row.end_year;
  const endMonth = "endMonth" in row ? row.endMonth : row.end_month;
  const endAbs = "endAbs" in row ? row.endAbs : row.end_abs;
  const timeMode = "timeMode" in row ? row.timeMode : row.time_mode;
  const dateNote = "dateNote" in row ? row.dateNote : row.date_note;
  const meaning = row.meaning;

  return {
    id: row.id,
    name: row.name,
    kind: row.kind as Event["kind"],
    timeMode: (timeMode as Event["timeMode"] | null) ?? "point",
    precision: (row.precision as Event["precision"] | null) ?? "year",
    dateNote: dateNote ?? undefined,
    at: atYear != null && atMonth != null ? { year: atYear, month: atMonth } : undefined,
    start:
      startYear != null && startMonth != null
        ? { year: startYear, month: startMonth }
        : undefined,
    end: endYear != null && endMonth != null ? { year: endYear, month: endMonth } : undefined,
    atAbs: atAbs ?? undefined,
    startAbs: startAbs ?? undefined,
    endAbs: endAbs ?? undefined,
    dynastyIds: row.dynasties.map((d) => d.dynastyId),
    participantIds: row.participants.map((p) => p.personId),
    summary: row.summary ?? undefined,
    meaning: meaning ?? undefined,
    content: row.content ?? undefined,
    locationId: ("locationId" in row ? row.locationId : row.location_id) ?? undefined,
    location: row.location ? {
      id: row.location.id,
      historicalName: row.location.historicalName,
      modernName: row.location.modernName,
      longitude: Number(row.location.longitude),
      latitude: Number(row.location.latitude),
      coordinateSystem: row.location.coordinateSystem,
      precision: row.location.precision,
      note: row.location.note ?? undefined,
      links: Array.isArray(row.location.links) ? row.location.links as { label: string; url: string }[] : [],
    } : undefined,
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
        ? { year: row.atYear, month: row.atMonth }
        : undefined,
    atAbs: row.atAbs ?? undefined,
    precision: (row.precision as Relation["precision"]) ?? undefined,
    eventId: row.eventId ?? undefined,
  };
}

export function toTimelineDataStore(input: {
  persons: Person[];
  dynasties: Dynasty[];
  reigns: Reign[];
  events: Event[];
  relations: Relation[];
}): TimelineDataStore {
  return input;
}
