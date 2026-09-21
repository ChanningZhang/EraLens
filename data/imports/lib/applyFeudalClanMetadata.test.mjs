import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { applyFeudalClanMetadata } from "./applyFeudalClanMetadata.mjs";
import {
  normalizeFeudalPersonName,
  personNamePrefix,
} from "./feudalClanMetadata.mjs";

describe("applyFeudalClanMetadata", () => {
  it("inherits dynasty 姓/氏 defaults onto persons", () => {
    const persons = [{ id: "ji-fa", name: "姬发" }];
    applyFeudalClanMetadata({
      persons,
      personDynastyId: { "ji-fa": "zhou-west" },
    });
    assert.equal(persons[0].ancestralXing, "姬");
  });

  it("lets 田 overwrite inherited 姜齐", () => {
    const persons = [{ id: "qi-r38", name: "妫因齐" }];
    applyFeudalClanMetadata({
      persons,
      personDynastyId: { "qi-r38": "qi-chunqiu" },
    });
    assert.equal(persons[0].ancestralXing, "妫");
    assert.equal(persons[0].clanShi, "田");
  });

  it("keeps 吕尚 as 姜姓吕氏", () => {
    const persons = [{ id: "lv-shang", name: "姜尚" }];
    applyFeudalClanMetadata({
      persons,
      personDynastyId: { "lv-shang": "qi-chunqiu" },
    });
    assert.equal(persons[0].ancestralXing, "姜");
    assert.equal(persons[0].clanShi, "吕");
  });

  it("lets usurpers clear inherited dynasty 姓", () => {
    const persons = [{ id: "hou-yi", name: "后羿" }];
    applyFeudalClanMetadata({
      persons,
      personDynastyId: { "hou-yi": "xia" },
    });
    assert.equal(persons[0].ancestralXing, null);
    assert.equal(persons[0].clanShi, "有穷");
  });

  it("marks 卫平侯 as 姬姓子南氏", () => {
    const persons = [{ id: "weiguo-r42", name: "姬劲" }];
    applyFeudalClanMetadata({
      persons,
      personDynastyId: { "weiguo-r42": "wei-weiguo" },
    });
    assert.equal(persons[0].ancestralXing, "姬");
    assert.equal(persons[0].clanShi, "子南");
  });

  it("does not stamp the shared missing-ruler person", () => {
    const persons = [{ id: "system-missing-ruler", name: "史料缺" }];
    applyFeudalClanMetadata({
      persons,
      personDynastyId: { "system-missing-ruler": "ju-chunqiu" },
    });
    assert.equal(persons[0].ancestralXing, undefined);
  });
});

describe("personNamePrefix", () => {
  it("always uses 姓 for stored person names", () => {
    assert.equal(personNamePrefix("chu-chunqiu"), "芈");
    assert.equal(personNamePrefix("wei-warring"), "姬");
    assert.equal(personNamePrefix("qin"), "嬴");
    assert.equal(personNamePrefix("xue-chunqiu"), "任");
  });
});

describe("normalizeFeudalPersonName", () => {
  it("rewrites 氏-prefixed wiki names into 姓+私名", () => {
    assert.equal(normalizeFeudalPersonName("chu-chunqiu", "熊侣"), "芈侣");
    assert.equal(normalizeFeudalPersonName("qi-chunqiu", "田因齐", "妫"), "妫因齐");
    assert.equal(normalizeFeudalPersonName("qi-chunqiu", "吕尚"), "姜尚");
    assert.equal(normalizeFeudalPersonName("song-chunqiu", "戴喜"), "子喜");
    assert.equal(normalizeFeudalPersonName("wei-weiguo", "子南劲"), "姬劲");
  });
});
