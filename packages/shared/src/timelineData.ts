import { resolveDynastyName, resolveDynastyDefaultName, dynastyNameSearchEntries } from "./dynastyNames";
import { relatedEntityRefs, type EntityAssociation } from "./entityAssociations.mjs";
import { capitalLocations } from "./locationMappings";
import { formatHistoricalDate, isApproximateConfidence } from "./historicalDate";
import { buildReignTenureCapitalRows, capitalDateRangeLabel, capitalLocationRoleLabel, dynastyCapitalRelatedItems } from "./dynastyCapitals";
import { claimDetailFacts } from "./claimTracks";
import { PRE_IMPERIAL_START_YEAR } from "./appellationPolicy";
import {
  buildPreQinClanContext,
  resolvePersonDetailTitle,
  resolveReignDetailHeading,
  resolvePreQinNameFacts,
  usesPreQinCardLayout,
} from "./emperorAppellation";
import {
  fallbackLaneColorToken,
  resolveDynastyColorToken,
  resolveReignColorToken,
} from "./dynastyColors";
import { eventKindLabel, eventSpanAbs, formatEventTime } from "./eventTime";
import {
  formatReignDurationLabel,
  formatReignYearRange,
} from "./reignVisual";
import {
  TimelineSliceSchema,
  type Dynasty,
  type CapitalLocation,
  type DynastyGroup,
  type EntityDetail,
  type EntityRef,
  type Event,
  type Person,
  type Reign,
  type Relation,
  type SearchHit,
  type TimelineSlice,
} from "./schema";
import {
  personIntersectsAbsWindow,
  personSearchAnchorAbs,
  personTimelinePlacement,
} from "./personTime";
import { normalizeSearchTerm } from "./personSearchTerms";
import { DATE_CONFIDENCE_LABEL } from "./reignBoundaries";
import { isFateRelationKind } from "./reignFateRelations";
import { midpointAbs, rangeIntersectsWindow } from "./time";

export type TimelineFilterQuery = {
  fromAbs: number;
  toAbs: number;
  scope?: string;
};

export type TimelineDataStore = {
  dynasties: Dynasty[];
  dynastyGroups?: DynastyGroup[];
  reigns: Reign[];
  persons: Person[];
  events: Event[];
  relations: Relation[];
  associations?: EntityAssociation[];
  locationMappings?: import("./schema").LocationMapping[];
};

export function filterTimeline(
  store: TimelineDataStore,
  query: TimelineFilterQuery,
): TimelineSlice {
  const visibleDynasties = store.dynasties.filter((d) => {
    if (query.scope && d.scope !== query.scope) return false;
    return rangeIntersectsWindow(d.startAbs, d.endAbs, query.fromAbs, query.toAbs);
  });
  const dynastyIds = new Set(visibleDynasties.map((d) => d.id));
  const visibleReigns = store.reigns.filter(
    (r) =>
      dynastyIds.has(r.dynastyId) &&
      rangeIntersectsWindow(r.startAbs, r.endAbs, query.fromAbs, query.toAbs),
  );
  const visibleEvents = store.events.filter((e) => {
    const { startAbs, endAbs } = eventSpanAbs(e);
    return rangeIntersectsWindow(startAbs, endAbs, query.fromAbs, query.toAbs);
  });

  const visibleReignPersonIds = new Set(visibleReigns.map((r) => r.personId));
  const reignPersonIds = new Set(store.reigns.map((r) => r.personId));
  const visiblePersons = store.persons.filter((person) => {
    if (visibleReignPersonIds.has(person.id)) return true;
    if (reignPersonIds.has(person.id)) return false;
    return personIntersectsAbsWindow(person, query.fromAbs, query.toAbs);
  });

  const visibleGroupIds = new Set(
    visibleDynasties
      .map((dynasty) => dynasty.groupId)
      .filter((groupId): groupId is string => Boolean(groupId)),
  );
  const visibleDynastyGroups = (store.dynastyGroups ?? []).filter((group) =>
    visibleGroupIds.has(group.id),
  );

  const visibleRelations = store.relations.filter((relation) => {
    if (relation.atAbs == null) return false;
    if (!isFateRelationKind(relation.kind)) return false;
    return relation.atAbs >= query.fromAbs && relation.atAbs <= query.toAbs;
  });

  return TimelineSliceSchema.parse({
    dynasties: visibleDynasties,
    dynastyGroups: visibleDynastyGroups,
    reigns: visibleReigns,
    events: visibleEvents,
    persons: visiblePersons,
    relations: visibleRelations,
  });
}

function refKey(ref: EntityRef): string {
  return `${ref.type}:${ref.id}`;
}

function truncateText(text: string, max = 36): string {
  if (text.length <= max) return text;
  return `${text.slice(0, max)}…`;
}

type RelatedItem = EntityDetail["related"][number];

type RelatedSummary = (ref: EntityRef, atAbs?: number) => { ref: EntityRef; label: string; subtitle?: string };

function associationRelatedItems(
  store: TimelineDataStore,
  ref: EntityRef,
  summary: RelatedSummary,
): RelatedItem[] {
  const sourceEvent = ref.type === "event" ? store.events.find(e => e.id === ref.id) : undefined;
  return relatedEntityRefs(store.associations ?? [], refKey(ref)).flatMap(raw => {
    const other = parseRef(raw);
    if (!other) return [];
    let abs: number | undefined;
    let group: RelatedItem["group"];
    if (other.type === "person") {
      const person = store.persons.find(p => p.id === other.id);
      if (!person) return [];
      abs = sourceEvent ? eventSpanAbs(sourceEvent).anchorAbs : personSearchAnchorAbs(person, store.reigns);
      group = "person";
    } else if (other.type === "dynasty") {
      const dynasty = store.dynasties.find(d => d.id === other.id);
      if (!dynasty) return [];
      abs = sourceEvent ? eventSpanAbs(sourceEvent).anchorAbs : dynasty.startAbs;
      group = "dynasty";
    } else if (other.type === "event") {
      const event = store.events.find(e => e.id === other.id);
      if (!event) return [];
      abs = eventSpanAbs(event).anchorAbs;
      group = event.kind === "idiom" ? "idiom" : event.kind === "poetry" ? "poetry" : "event";
    } else return [];
    return [{ ...summary(other, other.type === "dynasty" ? abs : undefined), abs, group }];
  }).sort((a, b) => (a.abs ?? Infinity) - (b.abs ?? Infinity));
}

function uniqueRelatedItems(items: RelatedItem[]): RelatedItem[] {
  const seen = new Set<string>();
  return items.filter(item => {
    const key = refKey(item.ref);
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}

function fateRelationRelatedItems(
  store: TimelineDataStore,
  reigns: Reign[],
  personId: string,
  summary: RelatedSummary,
): RelatedItem[] {
  const refs = new Set([`person:${personId}`, ...reigns.map(r => `reign:${r.id}`)]);
  return store.relations.filter(rel =>
    isFateRelationKind(rel.kind) && (refs.has(rel.fromRef) || refs.has(rel.toRef)),
  ).flatMap(rel => {
    const other = parseRef(refs.has(rel.fromRef) ? rel.toRef : rel.fromRef);
    return other ? [{
      ...summary(other), abs: rel.atAbs,
      group: other.type === "reign" ? "reign" as const : "person" as const,
    }] : [];
  });
}

export type PersonDetailOptions = {
  /** Summary construction must not recursively expand association graphs. */
  includeRelated?: boolean;
  /** Optional time context for dynasty details; person headings always use the default name. */
  atAbs?: number;
  focusReignId?: string;
  /** Reign rows selected by the single detail query; other rows may be ownership context. */
  selectedReignIds?: readonly string[];
  /** One-based chronological position returned by the detail query. */
  focusReignIndex?: number;
  /** Total reign records for the person returned by the detail query. */
  reignCount?: number;
};

function buildPersonEntityDetail(
  store: TimelineDataStore,
  person: Person,
  options: PersonDetailOptions = {},
  buildRelatedSummary: (relatedRef: EntityRef) => {
    ref: EntityRef;
    label: string;
    subtitle?: string;
  },
): Omit<EntityDetail, "ref"> {
  const dynastyMap = new Map(store.dynasties.map((d) => [d.id, d]));
  const selectedReignIds = options.selectedReignIds
    ? new Set(options.selectedReignIds)
    : undefined;
  const personReigns = store.reigns
    .filter(
      (reign) =>
        reign.personId === person.id &&
        (!selectedReignIds || selectedReignIds.has(reign.id)),
    )
    .sort(
      (a, b) =>
        a.startAbs - b.startAbs ||
        (a.start.day ?? 1) - (b.start.day ?? 1) ||
        a.id.localeCompare(b.id),
    );
  const focusReign = options.focusReignId
    ? personReigns.find((reign) => reign.id === options.focusReignId)
    : undefined;
  if (options.focusReignId && !focusReign) {
    throw new Error(`Reign not found: ${options.focusReignId}`);
  }

  const capitalReigns = focusReign ? [focusReign] : personReigns;
  const capitalTenures = capitalReigns.flatMap((reign) => {
    const rows = buildReignTenureCapitalRows(reign, capitalLocations(store), store.reigns);
    return rows;
  });
  const clan = buildPreQinClanContext(person);
  const preQinReign = personReigns.find((reign) => usesPreQinCardLayout(reign));
  const preQinByBirth =
    !preQinReign &&
    person.birth != null &&
    person.birth.year < PRE_IMPERIAL_START_YEAR;

  const focusReignIndex = focusReign
    ? options.focusReignIndex ?? personReigns.findIndex((reign) => reign.id === focusReign.id) + 1
    : undefined;
  const reignCount = options.reignCount ?? personReigns.length;
  const detailReign = focusReign ?? personReigns[0];
  const headingDynasty = detailReign
    ? dynastyMap.get(detailReign.dynastyId)
    : person.dynastyId
      ? dynastyMap.get(person.dynastyId)
      : undefined;
  const headingDynastyName = headingDynasty?.altNames?.[0]?.trim() ||
    (headingDynasty ? resolveDynastyDefaultName(headingDynasty) : undefined);
  const heading = resolveReignDetailHeading(
    detailReign,
    headingDynastyName,
    person.name,
    clan,
    {
      focusedReign: Boolean(focusReign),
      periodYear: detailReign?.start.year ?? person.birth?.year,
    },
  );
  const subtitle = heading
    ? focusReign && reignCount > 1 && focusReignIndex
      ? `${heading} · ${focusReignIndex}/${reignCount}`
      : heading
    : undefined;
  const title = resolvePersonDetailTitle(person.name, clan);
  const factReigns = focusReign ? [focusReign] : personReigns;
  const factEraNames = factReigns.flatMap((reign) =>
    reign.eraNames.filter(Boolean),
  );

  const commonFacts = [
    ...(preQinReign || preQinByBirth
      ? resolvePreQinNameFacts(person.name, clan, preQinReign)
      : []),
    ...((person.posthumousNames ?? []).length
      ? [{ label: "谥号", value: (person.posthumousNames ?? []).join("、") }]
      : []),
    ...((person.templeNames ?? []).length
      ? [{ label: "庙号", value: (person.templeNames ?? []).join("、") }]
      : []),
    ...(factEraNames.length
      ? [{ label: "年号", value: factEraNames.join("，") }]
      : []),
    ...(person.birth ? [{ label: "生", value: formatHistoricalDate(person.birth) }] : []),
    ...(person.death ? [{ label: "卒", value: formatHistoricalDate(person.death) }] : []),
  ];
  const facts = [
    ...(factReigns.length
      ? [{
          label: "在位",
          value: factReigns
            .map((reign) => {
              const range = formatReignYearRange(reign);
              const duration = formatReignDurationLabel(reign);
              return duration ? `${range} · ${duration}` : range;
            })
            .join("\n"),
        }]
      : []),
    ...commonFacts,
    ...(focusReign ? claimDetailFacts(focusReign) : []),
  ];

  const colorReign = focusReign ?? personReigns[0];
  const colorDynasty = colorReign ? dynastyMap.get(colorReign.dynastyId) : undefined;

  return {
    title,
    subtitle,
    reignCount,
    dynastyId: person.dynastyId ?? colorReign?.dynastyId,
    colorToken:
      colorReign && colorDynasty
        ? resolveReignColorToken(
            colorDynasty,
            colorReign,
            fallbackLaneColorToken(colorDynasty.id),
          )
        : undefined,
    facts,
    summary: person.bio,
    related: options.includeRelated === false ? [] : uniqueRelatedItems([
      ...fateRelationRelatedItems(store, personReigns, person.id, buildRelatedSummary),
      ...associationRelatedItems(store, {type:"person",id:person.id},buildRelatedSummary),
    ]),
    capitalTenures,
    links: person.links ?? [],
  };
}

function parseRef(raw: string): EntityRef | null {
  const [type, ...rest] = raw.split(":");
  const id = rest.join(":");
  if (!type || !id) return null;
  if (
    type === "dynasty" ||
    type === "reign" ||
    type === "person" ||
    type === "event" ||
    type === "location_mapping"
  ) {
    return { type, id };
  }
  return null;
}

export function buildEntityDetail(
  store: TimelineDataStore,
  ref: EntityRef,
  options: PersonDetailOptions = {},
): EntityDetail {
  const personMap = new Map(store.persons.map((p) => [p.id, p]));
  const dynastyMap = new Map(store.dynasties.map((d) => [d.id, d]));
  const reignMap = new Map(store.reigns.map((r) => [r.id, r]));
  const eventMap = new Map(store.events.map((e) => [e.id, e]));

  function buildRelatedSummary(relatedRef: EntityRef, atAbs?: number) {
    try {
      const detail = buildEntityDetail(store, relatedRef, { includeRelated: false, atAbs });
      return {
        ref: relatedRef,
        label: detail.title,
        subtitle: detail.subtitle,
      };
    } catch {
      return { ref: relatedRef, label: relatedRef.id };
    }
  }

  if (ref.type === "location_mapping") {
    const mapping=(store.locationMappings ?? []).find(m=>m.id===ref.id) ?? store.events.flatMap(e=>e.locationMappings ?? []).find(m=>m.id===ref.id);
    if (!mapping) throw new Error(`Location mapping not found: ${ref.id}`);
    const ownerRef: EntityRef={type:mapping.kind,id:mapping.externalId};
    const owner=buildRelatedSummary(ownerRef,mapping.startAbs);
    const capital=capitalLocations(store).find(c=>c.id===mapping.id);
    const mappedEvent=mapping.kind === "event" ? eventMap.get(mapping.externalId) : undefined;
    const dynastyId=mapping.kind === "dynasty" ? mapping.externalId : mapping.kind === "reign" ? store.reigns.find(r=>r.id===mapping.externalId)?.dynastyId : undefined;
    const dynasty=dynastyId ? dynastyMap.get(dynastyId) : undefined;
    return {ref,title:mapping.historicalName,subtitle:[owner.label,mapping.location.modernName].filter(Boolean).join(" · "),dynastyId,
      colorToken:dynasty ? resolveDynastyColorToken(dynasty,fallbackLaneColorToken(dynasty.id)) : undefined,
      facts:[{label:"归属",value:owner.label},{label:"今址",value:mapping.location.modernName},
        ...(capital ? [{label:"时段",value:capitalDateRangeLabel(capital)},{label:"地位",value:capitalLocationRoleLabel(capital)}] : []),
        ...(mappedEvent ? [{label:"时间",value:formatEventTime(mappedEvent)}] : []),
        ...(mapping.spatialPrecision ? [{label:"空间定位精度",value:mapping.spatialPrecision}] : [])],
      summary:mapping.note,related:[{...owner,abs:capital?.startAbs ?? (mappedEvent ? eventSpanAbs(mappedEvent).anchorAbs : undefined),group:mapping.kind}],capitalTenures:[],links:mapping.links};
  }

  if (ref.type === "dynasty") {
    const dynasty = dynastyMap.get(ref.id);
    if (!dynasty) throw new Error(`Dynasty not found: ${ref.id}`);
    const capitalRelated = dynastyCapitalRelatedItems(dynasty.id, capitalLocations(store));
    const associatedRelated = options.includeRelated === false ? [] : associationRelatedItems(store,ref,buildRelatedSummary);
    return {
      ref,
      title: resolveDynastyName(dynasty, options.atAbs),
      subtitle: dynasty.altNames?.[0],
      dynastyId: dynasty.id,
      colorToken: resolveDynastyColorToken(
        dynasty,
        fallbackLaneColorToken(dynasty.id),

      ),
      facts: [
        { label: "起止", value: `${dynasty.start.year} — ${dynasty.end.year}` },
        { label: "范围", value: dynasty.scope === "cn" ? "中国史" : dynasty.scope },
      ],
      summary: dynasty.note,
      related: options.includeRelated === false ? [] : uniqueRelatedItems([...capitalRelated, ...associatedRelated]),
      capitalTenures: [],
      links: [],
    };
  }

  let personRef: EntityRef = ref;
  let personOptions = options;
  if (ref.type === "reign") {
    const reign = reignMap.get(ref.id);
    if (!reign) throw new Error(`Reign not found: ${ref.id}`);
    personRef = { type: "person", id: reign.personId };
    personOptions = { ...options, focusReignId: ref.id };
  }

  if (personRef.type === "person") {
    const person = personMap.get(personRef.id);
    if (!person) throw new Error(`Person not found: ${personRef.id}`);
    return {
      ref: personRef,
      ...buildPersonEntityDetail(store, person, personOptions, buildRelatedSummary),
    };
  }

  const event = eventMap.get(ref.id);
  if (!event) throw new Error(`Event not found: ${ref.id}`);
  const { anchorAbs } = eventSpanAbs(event);
  const linkedDynasties = event.dynastyIds
    .map((id) => dynastyMap.get(id))
    .filter((dynasty): dynasty is NonNullable<typeof dynasty> => dynasty != null);
  const primaryDynasty = linkedDynasties[0];
  const locationRelated: EntityDetail["related"] = (event.locationMappings ?? []).map(m => ({ref:{type:"location_mapping",id:m.id}, label:m.historicalName, subtitle:m.location.modernName, abs:anchorAbs,group:"location"}));
  const ordinaryRelated = options.includeRelated === false ? [] : associationRelatedItems(store,ref,buildRelatedSummary);

  if (event.kind === "idiom") {
    return {
      ref,
      title: event.name,
      subtitle:
        linkedDynasties.length > 0
          ? linkedDynasties.map((dynasty) => resolveDynastyName(dynasty, anchorAbs)).join(" · ")
          : eventKindLabel(event.kind),
      dynastyId: primaryDynasty?.id,
      colorToken: primaryDynasty
        ? resolveDynastyColorToken(
            primaryDynasty,
            fallbackLaneColorToken(primaryDynasty.id),

          )
        : undefined,
      facts: [
        { label: "释义", value: event.meaning ?? "" },
        { label: "典故年代", value: formatEventTime(event) },
        { label: "类型", value: eventKindLabel(event.kind) },
        ...(event.dateNote ? [{ label: "说明", value: event.dateNote }] : []),
        ...((isApproximateConfidence(event.atConfidence ?? event.at?.confidence) || isApproximateConfidence(event.startConfidence ?? event.start?.confidence) || isApproximateConfidence(event.endConfidence ?? event.end?.confidence)) ? [{ label: "日期精度", value: "非精确" }] : []),
      ],
      summary: event.summary,
      related: options.includeRelated === false ? [] : uniqueRelatedItems([...locationRelated, ...ordinaryRelated]),
      capitalTenures: [],
      links: [],
    };
  }

  return {
    ref,
    title: event.name,
    subtitle:
      linkedDynasties.length > 0
        ? linkedDynasties.map((dynasty) => resolveDynastyName(dynasty, anchorAbs)).join(" · ")
        : eventKindLabel(event.kind),
    dynastyId: primaryDynasty?.id,
    colorToken: primaryDynasty
      ? resolveDynastyColorToken(
          primaryDynasty,
          fallbackLaneColorToken(primaryDynasty.id),

        )
      : undefined,
    facts: [
      ...(event.kind === "poetry"
        ? []
        : [{ label: "时间", value: formatEventTime(event) }]),
      { label: "类型", value: eventKindLabel(event.kind) },
      ...(event.dateNote ? [{ label: "说明", value: event.dateNote }] : []),
      ...((isApproximateConfidence(event.atConfidence ?? event.at?.confidence) || isApproximateConfidence(event.startConfidence ?? event.start?.confidence) || isApproximateConfidence(event.endConfidence ?? event.end?.confidence)) ? [{ label: "日期精度", value: "非精确" }] : []),
    ],
    summary: event.summary,
    content: event.content,
    related: options.includeRelated === false ? [] : uniqueRelatedItems([...locationRelated, ...ordinaryRelated]),
    capitalTenures: [],
    links: [],
  };
}

function personMatchesSearch(person: Person, q: string): boolean {
  const terms = person.searchTerms?.length
    ? person.searchTerms
    : [person.name, ...(person.altNames ?? [])];
  return terms.some((term) => normalizeSearchTerm(term) === q);
}

export function searchEntities(store: TimelineDataStore, term: string): SearchHit[] {
  const q = normalizeSearchTerm(term);
  if (!q) return [];
  const hits: SearchHit[] = [];
  const personById = new Map(store.persons.map((person) => [person.id, person]));
  const dynastyById = new Map(store.dynasties.map((dynasty) => [dynasty.id, dynasty]));

  for (const dynasty of [...store.dynasties].sort((a,b)=>a.id.localeCompare(b.id))) {
    const entries = dynastyNameSearchEntries(dynasty, midpointAbs(dynasty.startAbs, dynasty.endAbs));
    const exact = entries.find(entry => normalizeSearchTerm(entry.name) === q);
    const matched = exact ?? entries.find(entry => normalizeSearchTerm(entry.name).includes(q));
    const alias = (dynasty.altNames ?? []).some(name => normalizeSearchTerm(name).includes(q));
    if (matched || alias) {
      hits.push({ ref: { type: "dynasty", id: dynasty.id },
        label: matched?.name ?? resolveDynastyDefaultName(dynasty),
        abs: matched?.abs ?? midpointAbs(dynasty.startAbs, dynasty.endAbs) });
    }
  }
  for (const person of [...store.persons].sort((a,b)=>a.id.localeCompare(b.id))) {
    if (personMatchesSearch(person, q)) {
      hits.push({
        ref: { type: "person", id: person.id },
        label: person.name,
        subtitle: person.roles.join(" · "),
        abs: personSearchAnchorAbs(person, store.reigns),
      });
    }
  }
  for (const reign of [...store.reigns].sort((a,b)=>a.id.localeCompare(b.id))) {
    const matchedEraNames = reign.eraNames.filter((eraName) =>
      eraName.toLowerCase().includes(q),
    );
    if (matchedEraNames.length === 0) continue;
    const person = personById.get(reign.personId);
    const dynasty = dynastyById.get(reign.dynastyId);
    hits.push({
      ref: { type: "reign", id: reign.id },
      label: matchedEraNames[0],
      subtitle: [person?.name, dynasty ? resolveDynastyDefaultName(dynasty) : undefined].filter(Boolean).join(" · ") || undefined,
      abs: midpointAbs(reign.startAbs, reign.endAbs),
    });
  }
  for (const m of store.locationMappings ?? []) {
    if (!normalizeSearchTerm(m.historicalName).includes(q) && !normalizeSearchTerm(m.location.modernName).includes(q)) continue;
    const reign=m.kind === "reign" ? store.reigns.find(r=>r.id===m.externalId) : undefined;
    const dynasty=dynastyById.get(reign?.dynastyId ?? m.externalId);
    const event=m.kind === "event" ? store.events.find(e=>e.id===m.externalId) : undefined;
    hits.push({ref:{type:"location_mapping",id:m.id},label:m.historicalName,
      subtitle:[m.location.modernName,event?.name ?? (dynasty ? resolveDynastyName(dynasty, m.startAbs) : undefined),m.kind === "event" ? "事件地点" : "都城"].filter(Boolean).join(" · "),
      abs:event ? eventSpanAbs(event).anchorAbs : m.startAbs != null && m.endAbs != null ? midpointAbs(m.startAbs,m.endAbs) : undefined});
  }
  for (const event of [...store.events].sort((a,b)=>a.id.localeCompare(b.id))) {
    const nameHit = event.name.toLowerCase().includes(q);
    const meaningHit = event.meaning?.toLowerCase().includes(q) ?? false;
    if (nameHit || meaningHit) {
      hits.push({
        ref: { type: "event", id: event.id },
        label: event.name,
        subtitle: event.kind === "idiom" ? "成语" : eventKindLabel(event.kind),
        abs: eventSpanAbs(event).anchorAbs,
      });
    }
  }

  return hits.slice(0, 12);
}

export function computeBounds(store: TimelineDataStore): { minAbs: number; maxAbs: number } {
  const allStarts = [
    ...store.dynasties.map((d) => d.startAbs),
    ...store.events.map((e) => eventSpanAbs(e).startAbs),
  ];
  const allEnds = [
    ...store.dynasties.map((d) => d.endAbs),
    ...store.events.map((e) => eventSpanAbs(e).endAbs),
  ];
  return {
    minAbs: Math.min(...allStarts),
    maxAbs: Math.max(...allEnds),
  };
}
