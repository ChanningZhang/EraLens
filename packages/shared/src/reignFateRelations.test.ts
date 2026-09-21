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

  it("drops surrender when the same ruler also has a killed fate line", () => {
    const liYu: Reign = {
      id: "reign-li-yu",
      dynastyId: "tang-south",
      personId: "li-yu",
      title: "南唐后主",
      eraNames: [],
      start: { year: 961, month: 1 },
      end: { year: 975, month: 12 },
      startAbs: absMonth(961, 1),
      endAbs: absMonth(975, 12),
      precision: "year",
    };
    const zhaoKuangyin: Reign = {
      id: "reign-zhao-kuangyin",
      dynastyId: "song-north",
      personId: "zhao-kuangyin",
      title: "宋太祖",
      eraNames: [],
      start: { year: 960, month: 1 },
      end: { year: 979, month: 12 },
      startAbs: absMonth(960, 1),
      endAbs: absMonth(979, 12),
      precision: "year",
    };
    const reignList = [liYu, zhaoKuangyin];
    const surrender = fateRel({
      id: "rel-li-yu-zhao-kuangyin-surrender",
      fromRef: "person:li-yu",
      toRef: "person:zhao-kuangyin",
      kind: "surrender",
      atAbs: absMonth(975, 12),
    });
    const killed = fateRel({
      id: "rel-li-yu-zhao-kuangyin-killed",
      fromRef: "person:li-yu",
      toRef: "person:zhao-kuangyin",
      kind: "killed",
      atAbs: absMonth(978, 8),
    });
    const resolved = resolveFateRelations([surrender, killed], reignList);
    expect(resolved).toHaveLength(1);
    expect(resolved[0]?.relation.kind).toBe("killed");
    expect(resolved[0]?.relation.id).toBe("rel-li-yu-zhao-kuangyin-killed");
  });

  it("keeps abdication alongside a later killed fate for the same ruler", () => {
    const ruziYing: Reign = {
      id: "reign-ruzi-ying",
      dynastyId: "han-west",
      personId: "ruzi-ying",
      title: "孺子婴",
      eraNames: [],
      start: { year: 6, month: 4 },
      end: { year: 9, month: 1 },
      startAbs: absMonth(6, 4),
      endAbs: absMonth(9, 1),
      precision: "day",
    };
    const wangMang: Reign = {
      id: "reign-wang-mang",
      dynastyId: "xin",
      personId: "wang-mang",
      title: "新莽皇帝",
      eraNames: [],
      start: { year: 9, month: 1 },
      end: { year: 23, month: 10 },
      startAbs: absMonth(9, 1),
      endAbs: absMonth(23, 10),
      precision: "day",
    };
    const liuXuan: Reign = {
      id: "reign-liu-xuan",
      dynastyId: "han-gengshi",
      personId: "liu-xuan",
      title: "更始帝",
      eraNames: [],
      start: { year: 23, month: 3 },
      end: { year: 25, month: 10 },
      startAbs: absMonth(23, 3),
      endAbs: absMonth(25, 10),
      precision: "day",
    };
    const reignList = [ruziYing, wangMang, liuXuan];
    const abdication = fateRel({
      id: "rel-ruzi-ying-wang-mang-abdication",
      fromRef: "person:ruzi-ying",
      toRef: "person:wang-mang",
      kind: "abdication",
      atAbs: absMonth(9, 1),
    });
    const killed = fateRel({
      id: "rel-ruzi-ying-liu-xuan-killed",
      fromRef: "person:ruzi-ying",
      toRef: "person:liu-xuan",
      kind: "killed",
      atAbs: absMonth(24, 1),
    });
    const resolved = resolveFateRelations([abdication, killed], reignList);
    expect(resolved.map((item) => item.relation.kind).sort()).toEqual(["abdication", "killed"]);
  });

  it("drops captured fate lines when killed is also present", () => {
    const victim: Reign = {
      id: "reign-victim",
      dynastyId: "victim-dynasty",
      personId: "victim-person",
      title: "亡国君",
      eraNames: [],
      start: { year: 100, month: 1 },
      end: { year: 110, month: 12 },
      startAbs: absMonth(100, 1),
      endAbs: absMonth(110, 12),
      precision: "year",
    };
    const receiver: Reign = {
      id: "reign-receiver",
      dynastyId: "receiver-dynasty",
      personId: "receiver-person",
      title: "征服者",
      eraNames: [],
      start: { year: 90, month: 1 },
      end: { year: 120, month: 12 },
      startAbs: absMonth(90, 1),
      endAbs: absMonth(120, 12),
      precision: "year",
    };
    const reignList = [victim, receiver];
    const captured = fateRel({
      id: "rel-victim-receiver-captured",
      fromRef: "person:victim-person",
      toRef: "person:receiver-person",
      kind: "captured",
      atAbs: absMonth(110, 12),
    });
    const killed = fateRel({
      id: "rel-victim-receiver-killed",
      fromRef: "person:victim-person",
      toRef: "person:receiver-person",
      kind: "killed",
      atAbs: absMonth(112, 12),
    });
    const resolved = resolveFateRelations([captured, killed], reignList);
    expect(resolved).toHaveLength(1);
    expect(resolved[0]?.relation.kind).toBe("killed");
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
