import { EntityAssociationSchema, eventAssociationIds } from "@eralens/shared";
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
  DEFAULT_EVENT_DISPLAY_CONFIG,
  EventDisplayConfigSchema,
  filterTimeline,
  searchEntities,
  type Dynasty,
  type CapitalLocation, type LocationMappingQuery, type LocationMapping, filterLocationMappings,
  type Event,
  type Person,
  type Reign,
  type Relation,
} from "@eralens/shared";
import type { TimelineQuery, TimelineRepository } from "../repository";
import { createPlatformSettings } from "@eralens/data-access";
import { generateBulkDynasties, generateBulkReigns } from "./bulkGenerator";

import dynastiesJson from "../../../../../data/seed/dynasties.json";
import eventsJson from "../../../../../data/seed/events.json";
import personsJson from "../../../../../data/seed/persons.json";
import reignsJson from "../../../../../data/seed/reigns.json";
import associationsJson from "../../../../../data/seed/associations.json";
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
const associations=EntityAssociationSchema.array().parse(associationsJson);
const events = EventSchema.array().parse(eventsJson).map(event=>({...event,...eventAssociationIds(event.id,associations)}));
const relations = RelationSchema.array().parse(relationsJson);

const mockCapitals: CapitalLocation[] = [
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

const locationMappings: LocationMapping[]=mockCapitals.map(c=>({id:c.id,kind:"dynasty",externalId:c.dynastyId,locationId:c.id,
  location:{id:c.id,modernName:c.modernName,longitude:c.longitude,latitude:c.latitude,coordinateSystem:c.coordinateSystem},historicalName:c.historicalName,
  start:c.start,end:c.end,startAbs:c.startAbs,endAbs:c.endAbs,role:c.role,links:c.links}));
const store = { dynasties, reigns, persons, events, relations, associations, locationMappings };
const settings = createPlatformSettings();

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
      store,
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
  async getLocations() { return locationMappings.map(m=>m.location); },
  async getLocationMappings(query: LocationMappingQuery = {}) {return filterLocationMappings(locationMappings,query,events);},

  async getEventDisplayConfig() {
    const stored = await settings.get("eralens-event-display");
    return stored ? EventDisplayConfigSchema.parse(JSON.parse(stored)) : DEFAULT_EVENT_DISPLAY_CONFIG;
  },
  async setEventDisplayConfig(config) {
    await settings.set("eralens-event-display", JSON.stringify(config));
  },
};
