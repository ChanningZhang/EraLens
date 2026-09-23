import { describe, expect, it } from "vitest";
import { buildPersonSearchTerms, normalizeSearchTerm } from "./personSearchTerms";

describe("buildPersonSearchTerms", () => {
  it("builds dynasty appellations and structured clan-name aliases", () => {
    const person = {
      id: "li-shimin",
      name: "李世民",
      altNames: ["秦王李世民"],
      clanShi: "李",
      roles: ["君主"],
      links: [],
      posthumousNames: ["文皇帝"],
      templeNames: ["太宗"],
      searchTerms: [],
    };
    const reign = {
      id: "reign-li-shimin",
      dynastyId: "tang",
      personId: person.id,
      title: "唐太宗",
      eraNames: ["贞观"],
      start: { year: 626, month: 9 },
      end: { year: 649, month: 7 },
      startAbs: 7512,
      endAbs: 7782,
      precision: "month" as const,
      isInformalMonarch: false,
    };
    const dynasty = {
      id: "tang",
      name: "唐",
      altNames: ["李唐"],
      scope: "cn" as const,
      region: "east_asia",
      start: { year: 618, month: 6 },
      end: { year: 907, month: 5 },
      startAbs: 7416,
      endAbs: 10876,
      precision: "month" as const,
    };

    expect(buildPersonSearchTerms(person, [reign], [dynasty])).toEqual(
      expect.arrayContaining([
        "李世民",
        "秦王李世民",
        "太宗",
        "文皇帝",
        "唐太宗",
        "李唐太宗",
        "唐文皇帝",
        "李唐文皇帝",
      ]),
    );
  });

  it("normalizes whitespace before lookup", () => {
    expect(normalizeSearchTerm(" 唐 太宗 ")).toBe("唐太宗");
  });

  it("builds both ancestral-xing and clan-shi private-name forms", () => {
    const terms = buildPersonSearchTerms(
      {
        id: "tian-yinqi",
        name: "妫因齐",
        altNames: [],
        ancestralXing: "妫",
        clanShi: "田",
        roles: ["君主"],
        links: [],
        posthumousNames: ["威王"],
        templeNames: [],
      },
      [],
      [],
    );

    expect(terms).toEqual(expect.arrayContaining(["妫因齐", "田因齐", "威王"]));
  });
});
