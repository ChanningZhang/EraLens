import { firstAppellation } from "./appellationFields";
import { buildReignTenureCapitalRows, capitalRoleLabel, dynastyCapitalRelatedItems } from "./dynastyCapitals";
import { claimDetailFacts } from "./claimTracks";
import { PRE_IMPERIAL_START_YEAR } from "./appellationPolicy";
import {
  buildPreQinClanContext,
  resolvePreQinNameFacts,
  resolveReignDetailFacts,
  resolveReignDetailSubtitle,
  resolveReignPrimaryLabel,
  usesPreQinCardLayout,
} from "./emperorAppellation";
import {
  fallbackLaneColorToken,
  resolveDynastyColorToken,
  resolveReignColorToken,
} from "./dynastyColors";
import { resolveOrthodoxFromAbs } from "./orthodoxDynasties";
import { eventKindLabel, eventSpanAbs, formatEventTime } from "./eventTime";
import {
  TimelineSliceSchema,
  type Dynasty,
  type DynastyCapital,
  type DynastyGroup,
  type DynastyLaneGroup,
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
  personTimelinePlacement,
} from "./personTime";
import { normalizeSearchTerm } from "./personSearchTerms";
import { DATE_CONFIDENCE_LABEL } from "./reignBoundaries";
import { isFateRelationKind } from "./reignFateRelations";
import { rangeIntersectsWindow } from "./time";

export type TimelineFilterQuery = {
  fromAbs: number;
  toAbs: number;
  scope?: string;
};

export type TimelineDataStore = {
  dynasties: Dynasty[];
  dynastyGroups?: DynastyGroup[];
  dynastyLaneGroups?: DynastyLaneGroup[];
  reigns: Reign[];
  persons: Person[];
  events: Event[];
  relations: Relation[];
  capitals?: DynastyCapital[];
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
    const intersects = rangeIntersectsWindow(startAbs, endAbs, query.fromAbs, query.toAbs);
    const dynastyHit = e.dynastyIds.some((id) => dynastyIds.has(id));
    return intersects && (dynastyHit || e.dynastyIds.length === 0);
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
    dynastyLaneGroups: store.dynastyLaneGroups ?? [],
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

function sortEventsByAnchor(events: Event[]): Event[] {
  return [...events].sort(
    (a, b) => eventSpanAbs(a).anchorAbs - eventSpanAbs(b).anchorAbs,
  );
}

type RelatedItem = EntityDetail["related"][number];

function idiomRelatedItems(events: Event[]): RelatedItem[] {
  return sortEventsByAnchor(events.filter((e) => e.kind === "idiom")).map((e) => ({
    ref: { type: "event", id: e.id },
    label: e.name,
    subtitle: e.meaning ? truncateText(e.meaning) : undefined,
    abs: eventSpanAbs(e).anchorAbs,
    group: "idiom",
  }));
}

function poetryRelatedItems(events: Event[]): RelatedItem[] {
  return sortEventsByAnchor(events.filter((e) => e.kind === "poetry")).map((e) => ({
    ref: { type: "event", id: e.id },
    label: e.name,
    subtitle: eventKindLabel(e.kind),
    abs: eventSpanAbs(e).anchorAbs,
    group: "poetry",
  }));
}

function eventRelatedItems(events: Event[]): RelatedItem[] {
  return sortEventsByAnchor(events.filter((e) => e.kind !== "idiom" && e.kind !== "poetry")).map((e) => ({
    ref: { type: "event", id: e.id },
    label: e.name,
    subtitle: formatEventTime(e),
    abs: eventSpanAbs(e).anchorAbs,
    group: "event",
  }));
}

function eventsForPerson(store: TimelineDataStore, personId: string): Event[] {
  return store.events.filter((e) => e.participantIds.includes(personId));
}

function fateRelationRelatedItems(
  store: TimelineDataStore,
  reigns: Reign[],
  buildRelatedSummary: (relatedRef: EntityRef) => {
    ref: EntityRef;
    label: string;
    subtitle?: string;
  },
): RelatedItem[] {
  return reigns.flatMap((reign) => {
    const reignRef: EntityRef = { type: "reign", id: reign.id };
    return store.relations
      .filter((rel) => rel.fromRef === refKey(reignRef) || rel.toRef === refKey(reignRef))
      .map((rel) => {
        const other = rel.fromRef === refKey(reignRef) ? rel.toRef : rel.fromRef;
        const parsed = parseRef(other);
        if (!parsed) return null;
        return buildRelatedSummary(parsed);
      })
      .filter(Boolean) as RelatedItem[];
  });
}

export type PersonDetailOptions = {
  focusReignId?: string;
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
  const personReigns = store.reigns
    .filter((reign) => reign.personId === person.id)
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

  const capitalTenures = personReigns.flatMap((reign) => {
    const rows = buildReignTenureCapitalRows(reign, store.capitals ?? []);
    if (personReigns.length < 2) return rows;
    const name = (reign.eraNames.length > 0
      ? reign.eraNames.join("、")
      : reign.title).trim();
    return rows.map((row) => ({
      ...row,
      tenure: { ...row.tenure, ...(name ? { name } : {}) },
    }));
  });
  const clan = buildPreQinClanContext(person);
  const participantEvents = eventsForPerson(store, person.id);
  const preQinReign = personReigns.find((reign) => usesPreQinCardLayout(reign));
  const preQinByBirth =
    !preQinReign &&
    person.birth != null &&
    person.birth.year < PRE_IMPERIAL_START_YEAR;

  let title: string;
  let subtitle: string | undefined;
  if (focusReign) {
    const dynasty = dynastyMap.get(focusReign.dynastyId);
    title = resolveReignPrimaryLabel(focusReign, person.name, clan);
    subtitle = resolveReignDetailSubtitle(
      focusReign,
      dynasty?.name,
      person.name,
      clan,
    );
  } else {
    title =
      preQinReign || preQinByBirth
        ? preQinReign
          ? resolveReignPrimaryLabel(preQinReign, person.name, clan)
          : (firstAppellation(person.posthumousNames) ?? person.name)
        : person.name;
    subtitle = person.roles.join(" · ");
  }

  const facts = focusReign
    ? [
        ...resolveReignDetailFacts(focusReign, person.name, clan).filter(
          (fact) => fact.label !== "在位",
        ),
        ...claimDetailFacts(focusReign),
      ]
    : [
        ...(preQinReign || preQinByBirth
          ? resolvePreQinNameFacts(person.name, clan, preQinReign)
          : []),
        ...(person.posthumousNames.length
          ? [{ label: "谥号", value: person.posthumousNames.join("、") }]
          : []),
        ...(person.templeNames.length
          ? [{ label: "庙号", value: person.templeNames.join("、") }]
          : []),
        ...(person.birth ? [{ label: "生", value: `${person.birth.year}年` }] : []),
        ...(person.death ? [{ label: "卒", value: `${person.death.year}年` }] : []),
      ];

  const colorReign = focusReign ?? personReigns[0];
  const colorDynasty = colorReign ? dynastyMap.get(colorReign.dynastyId) : undefined;

  return {
    title,
    subtitle,
    dynastyId: colorReign?.dynastyId,
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
    related: [
      ...fateRelationRelatedItems(store, personReigns, buildRelatedSummary),
      ...eventRelatedItems(participantEvents),
      ...idiomRelatedItems(participantEvents),
      ...poetryRelatedItems(participantEvents),
    ],
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
    type === "capital"
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

  function buildRelatedSummary(relatedRef: EntityRef) {
    try {
      const detail = buildEntityDetail(store, relatedRef);
      return {
        ref: relatedRef,
        label: detail.title,
        subtitle: detail.subtitle,
      };
    } catch {
      return { ref: relatedRef, label: relatedRef.id };
    }
  }

  if (ref.type === "capital") {
    const capital = (store.capitals ?? []).find((item) => item.id === ref.id);
    if (!capital) throw new Error(`Capital not found: ${ref.id}`);
    const dynasty = dynastyMap.get(capital.dynastyId);
    const facts = [
      { label: "归属", value: dynasty?.name ?? capital.dynastyId },
      { label: "今址", value: capital.modernName },
      { label: "时段", value: `${capital.start.year} — ${capital.end.year}` },
      { label: "地位", value: capitalRoleLabel(capital.role) },
    ];
    if (capital.startDateConfidence && capital.startDateConfidence !== "certain") {
      facts.push({
        label: "起始年代",
        value: DATE_CONFIDENCE_LABEL[capital.startDateConfidence],
      });
    }
    if (capital.endDateConfidence && capital.endDateConfidence !== "certain") {
      facts.push({
        label: "终止年代",
        value: DATE_CONFIDENCE_LABEL[capital.endDateConfidence],
      });
    }
    return {
      ref,
      title: capital.historicalName,
      subtitle: dynasty
        ? `${dynasty.name} · ${capital.modernName}`
        : capital.modernName,
      dynastyId: capital.dynastyId,
      colorToken: dynasty
        ? resolveDynastyColorToken(
            dynasty,
            fallbackLaneColorToken(dynasty.id),
            resolveOrthodoxFromAbs(dynasty) ?? dynasty.startAbs,
          )
        : undefined,
      facts,
      summary: capital.note,
      related: dynasty
        ? [
            {
              ref: { type: "dynasty", id: dynasty.id },
              label: dynasty.name,
              subtitle: dynasty.altNames?.[0],
              abs: capital.startAbs,
              group: "dynasty",
            },
          ]
        : [],
      capitalTenures: [],
      links: capital.links,
    };
  }

  if (ref.type === "dynasty") {
    const dynasty = dynastyMap.get(ref.id);
    if (!dynasty) throw new Error(`Dynasty not found: ${ref.id}`);
    const dynastyEvents = store.events.filter((e) =>
      e.dynastyIds.includes(dynasty.id),
    );
    const idiomRelated = idiomRelatedItems(dynastyEvents);
    const poetryRelated = poetryRelatedItems(dynastyEvents);
    const eventRelated = eventRelatedItems(dynastyEvents);
    const capitalRelated = dynastyCapitalRelatedItems(dynasty.id, store.capitals ?? []);
    return {
      ref,
      title: dynasty.name,
      subtitle: dynasty.altNames?.[0],
      dynastyId: dynasty.id,
      colorToken: resolveDynastyColorToken(
        dynasty,
        fallbackLaneColorToken(dynasty.id),
        resolveOrthodoxFromAbs(dynasty) ?? dynasty.startAbs,
      ),
      facts: [
        { label: "起止", value: `${dynasty.start.year} — ${dynasty.end.year}` },
        { label: "范围", value: dynasty.scope === "cn" ? "中国史" : dynasty.scope },
      ],
      summary: dynasty.note,
      related: [...capitalRelated, ...eventRelated, ...idiomRelated, ...poetryRelated],
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
    personOptions = { focusReignId: ref.id };
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

  if (event.kind === "idiom") {
    const dynastyRelated = linkedDynasties.map((dynasty) => ({
      ref: { type: "dynasty" as const, id: dynasty.id },
      label: dynasty.name,
      subtitle: dynasty.altNames?.[0],
      abs: anchorAbs,
      group: "dynasty" as const,
    }));
    const sourceEventRelated = store.relations
      .filter((rel) => rel.fromRef === refKey(ref) && rel.toRef.startsWith("event:"))
      .map((rel) => parseRef(rel.toRef))
      .filter((parsed): parsed is EntityRef => parsed != null)
      .map((parsed) => {
        const summary = buildRelatedSummary(parsed);
        const sourceEvent = eventMap.get(parsed.id);
        return {
          ...summary,
          abs: sourceEvent ? eventSpanAbs(sourceEvent).anchorAbs : anchorAbs,
          group: "event" as const,
        };
      });
    const participantRelated = event.participantIds
      .map((id) => {
        const summary = buildRelatedSummary({ type: "person", id });
        return summary
          ? { ...summary, abs: anchorAbs, group: "person" as const }
          : null;
      })
      .filter(Boolean) as EntityDetail["related"];

    return {
      ref,
      title: event.name,
      subtitle:
        linkedDynasties.length > 0
          ? linkedDynasties.map((dynasty) => dynasty.name).join(" · ")
          : eventKindLabel(event.kind),
      dynastyId: primaryDynasty?.id,
      colorToken: primaryDynasty
        ? resolveDynastyColorToken(
            primaryDynasty,
            fallbackLaneColorToken(primaryDynasty.id),
            resolveOrthodoxFromAbs(primaryDynasty) ?? primaryDynasty.startAbs,
          )
        : undefined,
      facts: [
        { label: "释义", value: event.meaning ?? "" },
        { label: "典故年代", value: formatEventTime(event) },
        { label: "类型", value: eventKindLabel(event.kind) },
        ...(event.dateNote ? [{ label: "说明", value: event.dateNote }] : []),
      ],
      summary: event.summary,
      related: [...dynastyRelated, ...participantRelated, ...sourceEventRelated],
      capitalTenures: [],
      links: [],
    };
  }

  return {
    ref,
    title: event.name,
    subtitle:
      linkedDynasties.length > 0
        ? linkedDynasties.map((dynasty) => dynasty.name).join(" · ")
        : eventKindLabel(event.kind),
    dynastyId: primaryDynasty?.id,
    colorToken: primaryDynasty
      ? resolveDynastyColorToken(
          primaryDynasty,
          fallbackLaneColorToken(primaryDynasty.id),
          resolveOrthodoxFromAbs(primaryDynasty) ?? primaryDynasty.startAbs,
        )
      : undefined,
    facts: [
      ...(event.kind === "poetry"
        ? []
        : [{ label: "时间", value: formatEventTime(event) }]),
      { label: "类型", value: eventKindLabel(event.kind) },
      ...(event.dateNote ? [{ label: "说明", value: event.dateNote }] : []),
    ],
    summary: event.summary,
    content: event.content,
    related: event.participantIds
      .map((id) => {
        const summary = buildRelatedSummary({ type: "person", id });
        return summary
          ? { ...summary, abs: anchorAbs, group: "person" as const }
          : null;
      })
      .filter(Boolean) as EntityDetail["related"],
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

  for (const dynasty of store.dynasties) {
    if (dynasty.name.toLowerCase().includes(q)) {
      hits.push({
        ref: { type: "dynasty", id: dynasty.id },
        label: dynasty.name,
        abs: dynasty.startAbs,
      });
    }
  }
  for (const person of store.persons) {
    if (personMatchesSearch(person, q)) {
      const placement = personTimelinePlacement(person);
      hits.push({
        ref: { type: "person", id: person.id },
        label: person.name,
        subtitle: person.roles.join(" · "),
        abs: placement?.anchorAbs,
      });
    }
  }
  for (const reign of store.reigns) {
    const matchedEraNames = reign.eraNames.filter((eraName) =>
      eraName.toLowerCase().includes(q),
    );
    if (matchedEraNames.length === 0) continue;
    const person = personById.get(reign.personId);
    const dynasty = dynastyById.get(reign.dynastyId);
    hits.push({
      ref: { type: "reign", id: reign.id },
      label: matchedEraNames[0],
      subtitle: [person?.name, dynasty?.name].filter(Boolean).join(" · ") || undefined,
      abs: reign.startAbs,
    });
  }
  for (const capital of store.capitals ?? []) {
    const dynasty = dynastyById.get(capital.dynastyId);
    const nameHit = normalizeSearchTerm(capital.historicalName).includes(q);
    const modernNameHit = normalizeSearchTerm(capital.modernName).includes(q);
    if (!nameHit && !modernNameHit) continue;
    hits.push({
      ref: { type: "capital", id: capital.id },
      label: capital.historicalName,
      subtitle: [capital.modernName, dynasty?.name, "都城"].filter(Boolean).join(" · "),
      abs: capital.startAbs,
    });
  }
  for (const event of store.events) {
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
