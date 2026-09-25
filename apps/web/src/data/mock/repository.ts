import {
  capitalsActiveAtAbs,
  DynastySchema,
  EventSchema,
  PersonSchema,
  ReignSchema,
  RelationSchema,
  buildEntityDetail,
  buildPersonSearchTerms,
  computeBounds,
  filterTimeline,
  searchEntities,
  type Dynasty,
  type DynastyCapital,
  type Event,
  type Person,
  type Reign,
  type Relation,
} from "@eralens/shared";
import type { TimelineQuery, TimelineRepository } from "../repository";
import { generateBulkDynasties, generateBulkReigns } from "./bulkGenerator";

import dynastiesJson from "../../../../../data/seed/dynasties.json";
import eventsJson from "../../../../../data/seed/events.json";
import personsJson from "../../../../../data/seed/persons.json";
import reignsJson from "../../../../../data/seed/reigns.json";
import relationsJson from "../../../../../data/seed/relations.json";

const dynasties = [
  ...DynastySchema.array().parse(dynastiesJson),
  ...(import.meta.env.VITE_PERF_DATA === "1" ? generateBulkDynasties() : []),
];
const reigns = [
  ...ReignSchema.array().parse(reignsJson),
  ...(import.meta.env.VITE_PERF_DATA === "1" ? generateBulkReigns() : []),
];
const rawPersons = PersonSchema.array().parse(personsJson);
const persons = rawPersons.map((person) => ({
  ...person,
  searchTerms: buildPersonSearchTerms(person, reigns, dynasties),
}));
const events = EventSchema.array().parse(eventsJson);
const relations = RelationSchema.array().parse(relationsJson);

const mockCapitals: DynastyCapital[] = [
  {
    id: "cap-tang-changan",
    dynastyId: "tang",
    historicalName: "长安",
    modernName: "陕西省西安市",
    longitude: 108.939645,
    latitude: 34.343207,
    coordinateSystem: "GCJ02",
    start: { year: 618, month: 1 },
    end: { year: 904, month: 12 },
    startAbs: 7416,
    endAbs: 10848,
    precision: "year",
    role: "primary",
    links: [],
  },
  {
    id: "cap-tang-luoyang",
    dynastyId: "tang",
    historicalName: "洛阳",
    modernName: "河南省洛阳市",
    longitude: 112.453895,
    latitude: 34.619702,
    coordinateSystem: "GCJ02",
    start: { year: 657, month: 1 },
    end: { year: 904, month: 12 },
    startAbs: 7884,
    endAbs: 10848,
    precision: "year",
    role: "secondary",
    links: [],
  },
];

const store = { dynasties, reigns, persons, events, relations, capitals: mockCapitals };

export const mockRepository: TimelineRepository = {
  async getTimeline(query: TimelineQuery) {
    return filterTimeline(store, {
      fromAbs: query.fromAbs,
      toAbs: query.toAbs,
      scope: query.scope,
    });
  },
  async getTimelineCatalog(scope?: string) {
    const dynasties = scope
      ? store.dynasties.filter((dynasty) => dynasty.scope === scope)
      : store.dynasties;
    return {
      dynasties,
      dynastyGroups: [],
      dynastyLaneGroups: [],
    };
  },
  async getEntity(ref, options) {
    return buildEntityDetail(
      { ...store, capitals: mockCapitals },
      ref,
      { focusReignId: options?.focusReignId },
    );
  },
  async search(term) {
    return searchEntities(store, term);
  },
  async getBounds() {
    return computeBounds(store);
  },
  async getCapitals(fromAbs: number, toAbs: number) {
    const atAbs = Math.round((fromAbs + toAbs) / 2);
    return capitalsActiveAtAbs(mockCapitals, atAbs).map((capital) => ({
      ...capital,
      reignIds: capital.reignIds ?? [],
    }));
  },
  async getPersons() {
    return persons;
  },
  async getReigns() {
    return reigns;
  },
  async getEvents() {
    return events;
  },
};

export type { Dynasty, Reign, Person, Event, Relation };
