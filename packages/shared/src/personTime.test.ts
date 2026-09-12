import { describe, expect, it } from "vitest";
import { PersonSchema } from "./schema";
import { personLifeAbs } from "./personTime";
import { absMonth } from "./time";

describe("personLifeAbs", () => {
  it("returns abs span when birth and death are present", () => {
    const person = PersonSchema.parse({
      id: "cao-cao",
      name: "曹操",
      birth: { year: 155, month: 1 },
      death: { year: 220, month: 3 },
      roles: ["政治家"],
    });
    const life = personLifeAbs(person);
    expect(life).toEqual({
      startAbs: absMonth(155, 1),
      endAbs: absMonth(220, 3),
    });
  });

  it("returns null when birth or death is missing", () => {
    const person = PersonSchema.parse({
      id: "liu-xiu",
      name: "刘秀",
      roles: ["皇帝"],
    });
    expect(personLifeAbs(person)).toBeNull();
  });
});
