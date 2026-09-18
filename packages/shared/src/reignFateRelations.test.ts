import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import {
  resolveFateFromReign,
  resolveFateRelation,
  resolveFateRelations,
  resolveFateToReign,
} from "./reignFateRelations";
import type { Reign, Relation } from "./schema";

const yingZhengQin: Reign = {
  id: "reign-ying-zheng-qin",
  dynastyId: "qin",
  personId: "ying-zheng",
  title: "秦王政",
  eraNames: [],
  start: { year: -246, month: 1 },
  end: { year: -221, month: 9, day: 9 },
  startAbs: absMonth(-246, 1),
  endAbs: absMonth(-221, 9, 9),
  precision: "day",
};

const yingZhengEmperor: Reign = {
  id: "reign-ying-zheng",
  dynastyId: "qin",
  personId: "ying-zheng",
  title: "秦始皇帝",
  eraNames: [],
  start: { year: -221, month: 9, day: 10 },
  end: { year: -210, month: 7, day: 11 },
  startAbs: absMonth(-221, 9, 10),
  endAbs: absMonth(-210, 7, 11),
  precision: "day",
};

const hanLast: Reign = {
  id: "reign-han-r10-han-warring",
  dynastyId: "han-warring",
  personId: "han-r10",
  title: "韩王安",
  eraNames: [],
  start: { year: -238, month: 1 },
  end: { year: -230, month: 12 },
  startAbs: absMonth(-238, 1),
  endAbs: absMonth(-230, 12),
  precision: "year",
};

const weiLast: Reign = {
  id: "reign-wei-r7-wei-warring",
  dynastyId: "wei-warring",
  personId: "wei-r7",
  title: "魏假",
  eraNames: [],
  start: { year: -227, month: 1 },
  end: { year: -225, month: 12 },
  startAbs: absMonth(-227, 1),
  endAbs: absMonth(-225, 12),
  precision: "year",
};

const reigns = [hanLast, weiLast, yingZhengQin, yingZhengEmperor];

function fateRel(partial: Partial<Relation> & Pick<Relation, "id" | "fromRef" | "toRef" | "kind">): Relation {
  return {
    atAbs: absMonth(-230, 12),
    precision: "year",
    ...partial,
  };
}

describe("reignFateRelations", () => {
  it("resolves receiver reign at atAbs for dual qin reigns", () => {
    expect(resolveFateToReign("ying-zheng", absMonth(-230, 12), reigns)?.id).toBe(
      "reign-ying-zheng-qin",
    );
    expect(resolveFateToReign("ying-zheng", absMonth(-221, 12), reigns)?.id).toBe(
      "reign-ying-zheng",
    );
    expect(resolveFateToReign("ying-zheng", absMonth(-220, 1), reigns)?.id).toBe(
      "reign-ying-zheng",
    );
  });

  it("falls back to next reign within 24 months for abdication receivers", () => {
    const liuXie: Reign = {
      id: "reign-liu-xie",
      dynastyId: "han-east",
      personId: "liu-xie",
      title: "汉献帝",
      eraNames: [],
      start: { year: 189, month: 9, day: 29 },
      end: { year: 220, month: 11, day: 25 },
      startAbs: absMonth(189, 9, 29),
      endAbs: absMonth(220, 11, 25),
      precision: "day",
    };
    const caoPi: Reign = {
      id: "reign-cao-pi",
      dynastyId: "wei",
      personId: "cao-pi",
      title: "魏文帝",
      eraNames: [],
      start: { year: 220, month: 12, day: 11 },
      end: { year: 226, month: 6, day: 29 },
      startAbs: absMonth(220, 12, 11),
      endAbs: absMonth(226, 6, 29),
      precision: "day",
    };
    const atAbs = absMonth(220, 11, 25);
    expect(resolveFateToReign("cao-pi", atAbs, [liuXie, caoPi])?.id).toBe("reign-cao-pi");
  });

  it("resolves victim reign at endAbs when active at atAbs", () => {
    expect(resolveFateFromReign("han-r10", absMonth(-230, 12), reigns)?.id).toBe(
      "reign-han-r10-han-warring",
    );
  });

  it("skips same-dynasty fate relations", () => {
    const relation = fateRel({
      id: "rel-same-dynasty",
      fromRef: "person:ying-zheng",
      toRef: "person:ying-zheng",
      kind: "surrender",
      atAbs: absMonth(-230, 12),
    });
    expect(resolveFateRelation(relation, reigns)).toBeUndefined();
  });

  it("resolves fate victim from explicit reign ref for missing-ruler placeholders", () => {
    const missing: Reign = {
      id: "reign-missing-zhou-guo-east--360",
      dynastyId: "zhou-guo-east",
      personId: "system-missing-ruler",
      title: "史料缺",
      eraNames: [],
      start: { year: -360, month: 1 },
      end: { year: -249, month: 12 },
      startAbs: absMonth(-360, 1),
      endAbs: absMonth(-249, 12),
      precision: "year",
    };
    const zhuangxiang: Reign = {
      id: "reign-qin-r29-qin",
      dynastyId: "qin",
      personId: "qin-r29",
      title: "秦庄襄王",
      eraNames: [],
      start: { year: -249, month: 1 },
      end: { year: -247, month: 12 },
      startAbs: absMonth(-249, 1),
      endAbs: absMonth(-247, 12),
      precision: "year",
    };
    const atAbs = absMonth(-249, 12);
    const relation = fateRel({
      id: "rel-missing-zhou-guo-east-qin-r29-killed",
      fromRef: "reign:reign-missing-zhou-guo-east--360",
      toRef: "person:qin-r29",
      kind: "killed",
      atAbs,
    });
    const resolved = resolveFateRelation(relation, [missing, zhuangxiang]);
    expect(resolved?.fromReign.id).toBe("reign-missing-zhou-guo-east--360");
    expect(resolved?.toReign.id).toBe("reign-qin-r29-qin");
  });

  it("resolves cross-dynasty qin conquest edge", () => {
    const relation = fateRel({
      id: "rel-han-r10-ying-zheng-surrender",
      fromRef: "person:han-r10",
      toRef: "person:ying-zheng",
      kind: "surrender",
      atAbs: absMonth(-230, 12),
      eventId: "qin-destroy-han",
    });
    const resolved = resolveFateRelation(relation, reigns);
    expect(resolved?.fromReign.id).toBe("reign-han-r10-han-warring");
    expect(resolved?.toReign.id).toBe("reign-ying-zheng-qin");
  });

  it("resolves ziying surrender to liu bang pre-imperial reign", () => {
    const ziying: Reign = {
      id: "reign-ying-ziying",
      dynastyId: "qin",
      personId: "ying-ziying",
      title: "秦王子婴",
      eraNames: [],
      start: { year: -207, month: 10, day: 1 },
      end: { year: -207, month: 11, day: 17 },
      startAbs: absMonth(-207, 10, 1),
      endAbs: absMonth(-207, 11, 17),
      precision: "day",
    };
    const liuBangKing: Reign = {
      id: "reign-liu-bang-han-king-han-west",
      dynastyId: "han-west",
      personId: "liu-bang",
      title: "沛公",
      eraNames: [],
      start: { year: -209, month: 9 },
      end: { year: -202, month: 2, day: 27 },
      startAbs: absMonth(-209, 9),
      endAbs: absMonth(-202, 2, 27),
      precision: "day",
    };
    const atAbs = absMonth(-207, 11, 17);
    const relation = fateRel({
      id: "rel-ying-ziying-liu-bang-surrender",
      fromRef: "person:ying-ziying",
      toRef: "person:liu-bang",
      kind: "surrender",
      atAbs,
      eventId: "liu-enter-xianyang",
    });
    const resolved = resolveFateRelation(relation, [ziying, liuBangKing]);
    expect(resolved?.fromReign.id).toBe("reign-ying-ziying");
    expect(resolved?.toReign.id).toBe("reign-liu-bang-han-king-han-west");
  });
});
