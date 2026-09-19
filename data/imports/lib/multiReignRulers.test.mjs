import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { applyMultiReignRulers } from "./multiReignRulers.mjs";

const WEI_CHENG_GONG_SPANS = {
  "wei-weiguo": {
    姬郑: [
      { startYear: -634, endYear: -632 },
      { startYear: -632, endYear: -600, ordinal: 2 },
    ],
  },
};

function ruler(extra) {
  return {
    dynastyId: "wei-weiguo",
    personId: extra.personId,
    title: extra.title,
    personName: extra.personName,
    posthumousName: extra.posthumousName ?? null,
    startYear: extra.startYear,
    endYear: extra.endYear,
    ...(extra.ordinal != null ? { ordinal: extra.ordinal } : {}),
  };
}

describe("applyMultiReignRulers", () => {
  it("expands merged wiki span when package supplies spanExpansions", () => {
    const rulers = [
      ruler({
        personId: "weiguo-r20",
        title: "卫文公",
        personName: "姬毁",
        posthumousName: "文公",
        startYear: -659,
        endYear: -635,
      }),
      ruler({
        personId: "weiguo-r21",
        title: "卫成公",
        personName: "姬郑",
        posthumousName: "成公",
        startYear: -634,
        endYear: -600,
      }),
      ruler({
        personId: "weiguo-r22",
        title: "卫君瑕",
        personName: "姬瑕",
        startYear: -632,
        endYear: -632,
      }),
    ];
    const out = applyMultiReignRulers("wei-weiguo", rulers, {
      spanExpansions: WEI_CHENG_GONG_SPANS,
    });
    const cheng = out.filter((r) => r.personId === "weiguo-r21");
    assert.equal(cheng.length, 2);
    assert.deepEqual(
      cheng.map((r) => [r.startYear, r.endYear, r.reignId]),
      [
        [-634, -632, "reign-weiguo-r21-wei-weiguo"],
        [-632, -600, "reign-weiguo-r21-wei-weiguo-2"],
      ],
    );
  });

  it("unifies duplicate wiki rows for 卫献公 under one personId", () => {
    const rulers = [
      ruler({
        personId: "weiguo-r25",
        title: "卫献公",
        personName: "姬衎",
        posthumousName: "献公",
        startYear: -576,
        endYear: -559,
      }),
      ruler({
        personId: "weiguo-r26",
        title: "卫殇公",
        personName: "姬秋",
        posthumousName: "殇公",
        startYear: -558,
        endYear: -547,
      }),
      ruler({
        personId: "weiguo-r27",
        title: "卫献公",
        personName: "姬衎",
        posthumousName: "献公",
        startYear: -546,
        endYear: -544,
      }),
    ];
    const out = applyMultiReignRulers("wei-weiguo", rulers);
    const xian = out.filter((r) => r.personName === "姬衎");
    assert.equal(xian.length, 2);
    assert.ok(xian.every((r) => r.personId === "weiguo-r25"));
    assert.deepEqual(
      xian.map((r) => r.reignId),
      ["reign-weiguo-r25-wei-weiguo", "reign-weiguo-r25-wei-weiguo-2"],
    );
  });
});
