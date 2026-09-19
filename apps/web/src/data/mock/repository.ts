import {
  DynastySchema,
  EventSchema,
  PersonSchema,
  ReignSchema,
  RelationSchema,
  buildEntityDetail,
  computeBounds,
  filterTimeline,
  searchEntities,
  type Dynasty,
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
const persons = PersonSchema.array().parse(personsJson);
const events = EventSchema.array().parse(eventsJson);
const relations = RelationSchema.array().parse(relationsJson);

const store = { dynasties, reigns, persons, events, relations };

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
  async getEntity(ref) {
    return buildEntityDetail(store, ref);
  },
  async search(term) {
    return searchEntities(store, term);
  },
  async getBounds() {
    return computeBounds(store);
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
