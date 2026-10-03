import { describe, expect, it } from "vitest";
import { EntityAssociationSchema, EventSchema, RelationSchema } from "./schema";
import { buildEntityDetail, type TimelineDataStore } from "./timelineData";
import { eventAssociationIds, normalizeAssociation } from "./entityAssociations.mjs";

describe("direct association details", () => {
  const associations = [
    normalizeAssociation("person:p1", "person:p2"),
    normalizeAssociation("event:e", "person:p1"),
    normalizeAssociation("event:e", "person:p2"),
  ];
  const store: TimelineDataStore = {
    dynasties: [], reigns: [], relations: [], associations,
    persons: [
      { id: "p1", name: "甲", roles: [], links: [] },
      { id: "p2", name: "乙", roles: [], links: [] },
    ],
    events: [EventSchema.parse({
      id: "e", name: "典故", kind: "idiom", timeMode: "point", meaning: "释义",
      at: { year: 100, month: 12, confidence: "year" }, atAbs: 1211,
      ...eventAssociationIds("e", associations),
    })],
  };

  it("expands only direct neighbors and terminates when the graph has cycles", () => {
    const person = buildEntityDetail(store, { type: "person", id: "p1" });
    expect(person.related.map(item => item.ref)).toEqual([
      { type: "event", id: "e" }, { type: "person", id: "p2" },
    ]);
    expect(person.related.map(item => item.group)).toEqual(["idiom", "person"]);
    const event = buildEntityDetail(store, { type: "event", id: "e" });
    expect(event.related.map(item => item.ref)).toEqual([
      { type: "person", id: "p1" }, { type: "person", id: "p2" },
    ]);
    expect(event.related.every(item => item.group === "person")).toBe(true);
  });

  it("deduplicates direct objects even if a runtime store repeats a pair", () => {
    const detail = buildEntityDetail({ ...store, associations: [...associations, associations[0]] },
      { type: "person", id: "p2" });
    expect(detail.related).toHaveLength(2);
  });

  it("rejects ordinary relation kinds, event succession and noncanonical associations", () => {
    expect(EntityAssociationSchema.safeParse({ aRef: "person:p1", bRef: "event:e" }).success).toBe(false);
    expect(RelationSchema.safeParse({ id: "r", kind: "battle", fromRef: "person:p1", toRef: "person:p2" }).success).toBe(false);
    expect(RelationSchema.safeParse({ id: "r", kind: "succession", fromRef: "event:e", toRef: "person:p2" }).success).toBe(false);
  });
});
