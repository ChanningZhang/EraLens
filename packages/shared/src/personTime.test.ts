import { describe, expect, it } from "vitest";
import { PersonSchema } from "./schema";
import {
  personIntersectsAbsWindow,
  personLifeAbs,
  personPlacementWindow,
  personPointKindLabel,
  personTimelinePlacement,
} from "./personTime";
import { absMonth } from "./time";

describe("personTimelinePlacement", () => {
  it("returns span when birth and death are present", () => {
    const person = PersonSchema.parse({
      id: "cao-cao",
      name: "曹操",
      birth: { year: 155, month: 1 },
      death: { year: 220, month: 3 },
      roles: ["政治家"],
    });
    expect(personTimelinePlacement(person)).toEqual({
      mode: "span",
      startAbs: absMonth(155, 1),
      endAbs: absMonth(220, 3),
      anchorAbs: absMonth(155, 1),
    });
  });

  it("returns birth point when only birth is known", () => {
    const person = PersonSchema.parse({
      id: "zhang-liang",
      name: "张良",
      birth: { year: -250, month: 1 },
      roles: ["政治家"],
    });
    expect(personTimelinePlacement(person)).toEqual({
      mode: "point",
      anchorAbs: absMonth(-250, 1),
      pointKind: "birth",
    });
  });

  it("returns death point when only death is known", () => {
    const person = PersonSchema.parse({
      id: "han-xin",
      name: "韩信",
      death: { year: -196, month: 1 },
      roles: ["军事家"],
    });
    expect(personTimelinePlacement(person)).toEqual({
      mode: "point",
      anchorAbs: absMonth(-196, 1),
      pointKind: "death",
    });
  });

  it("returns null when neither birth nor death is known", () => {
    const person = PersonSchema.parse({
      id: "liu-xiu",
      name: "刘秀",
      roles: ["皇帝"],
    });
    expect(personTimelinePlacement(person)).toBeNull();
  });
});

describe("personLifeAbs", () => {
  it("returns abs span only for full lifespan", () => {
    const person = PersonSchema.parse({
      id: "cao-cao",
      name: "曹操",
      birth: { year: 155, month: 1 },
      death: { year: 220, month: 3 },
      roles: ["政治家"],
    });
    expect(personLifeAbs(person)).toEqual({
      startAbs: absMonth(155, 1),
      endAbs: absMonth(220, 3),
    });
  });

  it("returns null for partial dates", () => {
    const person = PersonSchema.parse({
      id: "zhang-liang",
      name: "张良",
      birth: { year: -250, month: 1 },
      roles: ["政治家"],
    });
    expect(personLifeAbs(person)).toBeNull();
  });
});

describe("personPlacementWindow", () => {
  it("uses a single month for point placements", () => {
    const placement = personTimelinePlacement(
      PersonSchema.parse({
        id: "xiao-he",
        name: "萧何",
        death: { year: -193, month: 1 },
        roles: ["政治家"],
      }),
    );
    expect(placement).not.toBeNull();
    if (!placement) return;
    expect(personPlacementWindow(placement)).toEqual({
      startAbs: absMonth(-193, 1),
      endAbs: absMonth(-193, 1),
    });
  });
});

describe("personPointKindLabel", () => {
  it("labels birth and death", () => {
    expect(personPointKindLabel("birth")).toBe("生");
    expect(personPointKindLabel("death")).toBe("卒");
  });
});

describe("personIntersectsAbsWindow", () => {
  it("includes death-only persons at the death month", () => {
    const person = PersonSchema.parse({
      id: "fu-hao",
      name: "妇好",
      death: { year: -1200, month: 1 },
      roles: ["王后"],
    });
    const at = absMonth(-1200, 1);
    expect(personIntersectsAbsWindow(person, at, at)).toBe(true);
    expect(personIntersectsAbsWindow(person, at + 1, at + 12)).toBe(false);
  });
});
