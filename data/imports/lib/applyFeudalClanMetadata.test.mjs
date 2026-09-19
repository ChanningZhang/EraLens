import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { applyFeudalClanMetadata } from "./applyFeudalClanMetadata.mjs";
import { personNamePrefix } from "./feudalClanMetadata.mjs";

describe("applyFeudalClanMetadata", () => {
  it("stamps dynasty 姓/氏 and inherits onto persons", () => {
    const persons = [{ id: "ji-fa", name: "姬发" }];
    const dynasties = [{ id: "zhou-west", name: "西周" }];
    applyFeudalClanMetadata({
      persons,
      dynasties,
      personDynastyId: { "ji-fa": "zhou-west" },
    });
    assert.equal(dynasties[0].ancestralXing, "姬");
    assert.equal(persons[0].ancestralXing, "姬");
  });

  it("lets 田 overwrite inherited 姜齐", () => {
    const persons = [{ id: "qi-r38", name: "田因齐" }];
    const dynasties = [{ id: "qi-chunqiu", name: "齐" }];
    applyFeudalClanMetadata({
      persons,
      dynasties,
      personDynastyId: { "qi-r38": "qi-chunqiu" },
    });
    assert.equal(dynasties[0].ancestralXing, "姜");
    assert.equal(persons[0].ancestralXing, "妫");
    assert.equal(persons[0].clanShi, "田");
  });

  it("keeps 吕尚 as 姜姓吕氏", () => {
    const persons = [{ id: "lv-shang", name: "吕尚" }];
    const dynasties = [{ id: "qi-chunqiu", name: "齐" }];
    applyFeudalClanMetadata({
      persons,
      dynasties,
      personDynastyId: { "lv-shang": "qi-chunqiu" },
    });
    assert.equal(persons[0].ancestralXing, "姜");
    assert.equal(persons[0].clanShi, "吕");
  });

  it("lets usurpers clear inherited dynasty 姓", () => {
    const persons = [{ id: "hou-yi", name: "后羿" }];
    const dynasties = [{ id: "xia", name: "夏" }];
    applyFeudalClanMetadata({
      persons,
      dynasties,
      personDynastyId: { "hou-yi": "xia" },
    });
    assert.equal(persons[0].ancestralXing, null);
    assert.equal(persons[0].clanShi, "有穷");
  });

  it("does not stamp the shared missing-ruler person", () => {
    const persons = [{ id: "system-missing-ruler", name: "史料缺" }];
    const dynasties = [{ id: "ju-chunqiu", name: "莒" }];
    applyFeudalClanMetadata({
      persons,
      dynasties,
      personDynastyId: { "system-missing-ruler": "ju-chunqiu" },
    });
    assert.equal(persons[0].ancestralXing, undefined);
    assert.equal(dynasties[0].ancestralXing, "己");
  });
});

describe("personNamePrefix", () => {
  it("uses 氏 when personal names conventionally carry 氏", () => {
    assert.equal(personNamePrefix("chu-chunqiu"), "熊");
    assert.equal(personNamePrefix("wei-warring"), "魏");
    assert.equal(personNamePrefix("qin"), "嬴");
    assert.equal(personNamePrefix("xue-chunqiu"), "任");
  });
});
