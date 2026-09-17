import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { applyDeathYearToPredecessor } from "./deathYearSuccession.mjs";

function r(title, start, end, extra = {}) {
  return { dynastyId: extra.dynastyId ?? "qin", title, start, end, ...extra };
}

describe("applyDeathYearToPredecessor", () => {
  it("gives the death year to the predecessor and starts the next king the year after", () => {
    const rulers = [
      r("秦襄公", -778, -766),
      r("秦文公", -766, -716),
      r("秦宪公", -716, -704),
    ];
    applyDeathYearToPredecessor(rulers);
    assert.deepEqual(
      rulers.map((x) => [x.title, x.start, x.end]),
      [
        ["秦襄公", -778, -766],
        ["秦文公", -765, -716],
        ["秦宪公", -715, -704],
      ],
    );
  });

  it("keeps one-year short reigns on the death year", () => {
    const rulers = [
      r("齐襄公", -697, -686, { dynastyId: "qi-chunqiu" }),
      r("公孙无知", -686, -686, { dynastyId: "qi-chunqiu" }),
      r("齐桓公", -685, -643, { dynastyId: "qi-chunqiu" }),
    ];
    applyDeathYearToPredecessor(rulers);
    assert.equal(rulers.find((x) => x.title === "公孙无知").start, -686);
    assert.equal(rulers.find((x) => x.title === "齐桓公").start, -685);
  });

  it("does not shift 未逾年改元 titles", () => {
    const rulers = [
      r("秦怀公", -428, -425),
      r("秦灵公", -425, -415),
      r("秦简公", -415, -400),
    ];
    applyDeathYearToPredecessor(rulers);
    assert.equal(rulers.find((x) => x.title === "秦灵公").start, -425);
    assert.equal(rulers.find((x) => x.title === "秦简公").start, -415);
  });

  it("does not shift concurrent multi-year starts", () => {
    const rulers = [
      r("齐太公", -404, -384, { dynastyId: "qi-chunqiu", name: "田和" }),
      r("齐康公", -404, -379, { dynastyId: "qi-chunqiu", name: "姜贷" }),
    ];
    applyDeathYearToPredecessor(rulers);
    assert.equal(rulers[0].start, -404);
    assert.equal(rulers[1].start, -404);
  });

  it("shifts 庄襄王 off 孝文王's death year using original wiki years", () => {
    const rulers = [
      r("秦昭襄王", -307, -251),
      r("秦孝文王", -251, -250),
      r("秦庄襄王", -250, -247),
      r("秦王政", -247, -210),
    ];
    applyDeathYearToPredecessor(rulers);
    assert.deepEqual(
      rulers.map((x) => [x.title, x.start, x.end]),
      [
        ["秦昭襄王", -307, -251],
        ["秦孝文王", -250, -250],
        ["秦庄襄王", -249, -247],
        ["秦王政", -246, -210],
      ],
    );
  });

  it("does not split the same person across a 改元 year", () => {
    const rulers = [
      r("魏罃", -369, -344, { dynastyId: "wei-warring", name: "魏罃" }),
      r("魏惠成王", -344, -319, { dynastyId: "wei-warring", name: "魏罃" }),
    ];
    applyDeathYearToPredecessor(rulers);
    assert.equal(rulers[1].start, -344);
  });
});
