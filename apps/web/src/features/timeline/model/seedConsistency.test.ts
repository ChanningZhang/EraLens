import { describe, expect, it } from "vitest";
import {
  DynastySchema,
  EventSchema,
  ReignSchema,
  absMonth,
} from "@eralens/shared";
import dynastiesJson from "../../../../../../data/seed/dynasties.json";
import eventsJson from "../../../../../../data/seed/events.json";
import reignsJson from "../../../../../../data/seed/reigns.json";

describe("timeline seed coordinates", () => {
  it("keeps dynasty absolute months derived from calendar dates", () => {
    for (const dynasty of DynastySchema.array().parse(dynastiesJson)) {
      expect(dynasty.startAbs, `${dynasty.id}.startAbs`).toBe(
        absMonth(dynasty.start.year, dynasty.start.month),
      );
      expect(dynasty.endAbs, `${dynasty.id}.endAbs`).toBe(
        absMonth(dynasty.end.year, dynasty.end.month),
      );
    }
  });

  it("keeps reign absolute months derived from calendar dates", () => {
    for (const reign of ReignSchema.array().parse(reignsJson)) {
      expect(reign.startAbs, `${reign.id}.startAbs`).toBe(
        absMonth(reign.start.year, reign.start.month),
      );
      expect(reign.endAbs, `${reign.id}.endAbs`).toBe(
        absMonth(reign.end.year, reign.end.month),
      );
    }
  });

  it("keeps point-event absolute months derived from calendar dates", () => {
    for (const event of EventSchema.array().parse(eventsJson)) {
      if (event.at && event.atAbs !== undefined) {
        expect(event.atAbs, `${event.id}.atAbs`).toBe(
          absMonth(event.at.year, event.at.month),
        );
      }
      if (event.start && event.startAbs !== undefined) {
        expect(event.startAbs, `${event.id}.startAbs`).toBe(
          absMonth(event.start.year, event.start.month),
        );
      }
      if (event.end && event.endAbs !== undefined) {
        expect(event.endAbs, `${event.id}.endAbs`).toBe(
          absMonth(event.end.year, event.end.month),
        );
      }
    }
  });
});
