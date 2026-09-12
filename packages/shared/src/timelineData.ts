import { resolveReignPrimaryLabel } from "./emperorAppellation";
import { eventSpanAbs, formatEventTime } from "./eventTime";
import {
  TimelineSliceSchema,
  type Dynasty,
  type EntityDetail,
  type EntityRef,
  type Event,
  type Person,
  type Reign,
  type Relation,
  type SearchHit,
  type TimelineSlice,
} from "./schema";
import { rangeIntersectsWindow } from "./time";

export type TimelineFilterQuery = {
  fromAbs: number;
  toAbs: number;
  scope?: string;
};

export type TimelineDataStore = {
  dynasties: Dynasty[];
  reigns: Reign[];
  persons: Person[];
  events: Event[];
  relations: Relation[];
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

  return TimelineSliceSchema.parse({
    dynasties: visibleDynasties,
    reigns: visibleReigns,
    events: visibleEvents,
  });
}

function refKey(ref: EntityRef): string {
  return `${ref.type}:${ref.id}`;
}

function parseRef(raw: string): EntityRef | null {
  const [type, ...rest] = raw.split(":");
  const id = rest.join(":");
  if (!type || !id) return null;
  if (type === "dynasty" || type === "reign" || type === "person" || type === "event") {
    return { type, id };
  }
  return null;
}

export function buildEntityDetail(
  store: TimelineDataStore,
  ref: EntityRef,
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

  if (ref.type === "dynasty") {
    const dynasty = dynastyMap.get(ref.id);
    if (!dynasty) throw new Error(`Dynasty not found: ${ref.id}`);
    const relatedReigns = store.reigns
      .filter((r) => r.dynastyId === dynasty.id)
      .slice(0, 6)
      .map((r) => {
        const person = personMap.get(r.personId);
        const label = resolveReignPrimaryLabel(r, person?.name);
        const personName = person?.name ?? r.title;
        const usesEra = label !== personName;
        return {
          ref: { type: "reign" as const, id: r.id },
          label,
          subtitle: usesEra ? personName : r.title,
          abs: r.startAbs,
        };
      });
    return {
      ref,
      title: dynasty.name,
      subtitle: dynasty.altNames?.[0],
      colorToken: dynasty.colorToken,
      facts: [
        { label: "起止", value: `${dynasty.start.year} — ${dynasty.end.year}` },
        { label: "范围", value: dynasty.scope === "cn" ? "中国史" : dynasty.scope },
      ],
      summary: dynasty.note,
      related: relatedReigns,
      links: [],
    };
  }

  if (ref.type === "reign") {
    const reign = reignMap.get(ref.id);
    if (!reign) throw new Error(`Reign not found: ${ref.id}`);
    const person = personMap.get(reign.personId);
    const dynasty = dynastyMap.get(reign.dynastyId);
    const era = reign.eraNames[0]?.name;
    const personName = person?.name ?? reign.title;
    const title = resolveReignPrimaryLabel(reign, person?.name);
    const usesEra = title !== personName;
    const related = store.relations
      .filter((rel) => rel.fromRef === refKey(ref) || rel.toRef === refKey(ref))
      .map((rel) => {
        const other = rel.fromRef === refKey(ref) ? rel.toRef : rel.fromRef;
        const parsed = parseRef(other);
        if (!parsed) return null;
        return buildRelatedSummary(parsed);
      })
      .filter(Boolean) as EntityDetail["related"];

    return {
      ref,
      title,
      subtitle: usesEra
        ? `${dynasty?.name ?? ""} · ${personName}`
        : `${dynasty?.name ?? ""} · ${reign.title}`,
      colorToken: dynasty?.colorToken,
      facts: [
        { label: "在位", value: `${reign.start.year} — ${reign.end.year}` },
        ...(reign.posthumousName
          ? [{ label: "谥号", value: reign.posthumousName }]
          : []),
        ...(reign.templeName
          ? [{ label: "庙号", value: reign.templeName }]
          : []),
        ...(era ? [{ label: "年号", value: era }] : []),
      ],
      summary: person?.bio,
      related,
      links: person?.links ?? [],
    };
  }

  if (ref.type === "person") {
    const person = personMap.get(ref.id);
    if (!person) throw new Error(`Person not found: ${ref.id}`);
    const personReigns = store.reigns.filter((r) => r.personId === person.id);
    return {
      ref,
      title: person.name,
      subtitle: person.roles.join(" · "),
      facts: [
        ...(person.birth
          ? [{ label: "生", value: `${person.birth.year}年` }]
          : []),
        ...(person.death
          ? [{ label: "卒", value: `${person.death.year}年` }]
          : []),
      ],
      summary: person.bio,
      related: personReigns.map((r) => ({
        ref: { type: "reign" as const, id: r.id },
        label: r.title,
        subtitle: `${r.start.year} — ${r.end.year}`,
        abs: r.startAbs,
      })),
      links: person.links,
    };
  }

  const event = eventMap.get(ref.id);
  if (!event) throw new Error(`Event not found: ${ref.id}`);
  const { anchorAbs } = eventSpanAbs(event);
  return {
    ref,
    title: event.name,
    subtitle: event.kind,
    facts: [
      {
        label: "时间",
        value: formatEventTime(event),
      },
      ...(event.dateNote ? [{ label: "年代说明", value: event.dateNote }] : []),
    ],
    summary: event.summary,
    related: event.participantIds
      .map((id) => {
        const summary = buildRelatedSummary({ type: "person", id });
        return summary ? { ...summary, abs: anchorAbs } : null;
      })
      .filter(Boolean)
      .slice(0, 8) as EntityDetail["related"],
    links: [],
  };
}

export function searchEntities(store: TimelineDataStore, term: string): SearchHit[] {
  const q = term.trim().toLowerCase();
  if (!q) return [];
  const hits: SearchHit[] = [];

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
    if (person.name.toLowerCase().includes(q)) {
      hits.push({
        ref: { type: "person", id: person.id },
        label: person.name,
        subtitle: person.roles.join(" · "),
      });
    }
  }
  for (const event of store.events) {
    if (event.name.toLowerCase().includes(q)) {
      hits.push({
        ref: { type: "event", id: event.id },
        label: event.name,
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
