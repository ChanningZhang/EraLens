import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { preQinRegnalCardName } from "./preQinCardAppellation.mjs";

describe("preQinRegnalCardName", () => {
  it("drops the dynasty 国号 and keeps 王/侯 when the private name differs", () => {
    assert.equal(preQinRegnalCardName("齐王建", "齐", "田建"), "王建");
    assert.equal(preQinRegnalCardName("燕侯克", "燕"), "侯克");
  });

  it("drops 王 when the person is stored as a bare single-character given name", () => {
    assert.equal(preQinRegnalCardName("中山王厝", "中山", "厝"), "厝");
    assert.equal(preQinRegnalCardName("中山王𧊒", "中山", "𧊒"), "𧊒");
    assert.equal(preQinRegnalCardName("吴王僚", "吴", "僚"), "僚");
  });

  it("drops 王/侯 before multi-character given names", () => {
    assert.equal(preQinRegnalCardName("吴王夫差", "吴"), "夫差");
    assert.equal(preQinRegnalCardName("越侯夫谭", "越"), "夫谭");
  });

  it("drops 王 when the person is stored as 姓+单字私名", () => {
    const ji = { ancestralXing: "姬" };
    assert.equal(preQinRegnalCardName("燕王哙", "燕", "姬哙", ji), "哙");
    assert.equal(preQinRegnalCardName("燕王喜", "燕", "姬喜", ji), "喜");
  });

  it("drops 侯 when the person is stored as 氏+单字私名", () => {
    assert.equal(
      preQinRegnalCardName("齐侯剡", "齐", "田剡", { clanShi: "田" }),
      "剡",
    );
  });

  it("keeps 号/称号 bodies that are not 王X names", () => {
    assert.equal(preQinRegnalCardName("楚若敖", "楚"), "若敖");
    assert.equal(preQinRegnalCardName("夏禹", "夏"), "禹");
    assert.equal(preQinRegnalCardName("夏太康", "夏"), "太康");
    assert.equal(preQinRegnalCardName("卫嗣君", "卫"), "嗣君");
  });

  it("returns null when the title has no matching 国号 prefix", () => {
    assert.equal(preQinRegnalCardName("公孙无知", "齐"), null);
    assert.equal(preQinRegnalCardName("熊绎", "楚"), null);
    assert.equal(preQinRegnalCardName("周武王", "西周"), null);
  });
});
