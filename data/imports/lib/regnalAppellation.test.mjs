import { describe, it } from "node:test";
import assert from "node:assert/strict";
import {
  appellationFieldsFromRegnalTitle,
  resolveRegnalAppellationFields,
} from "./regnalAppellation.mjs";

describe("appellationFieldsFromRegnalTitle", () => {
  it("derives posthumous bodies from imperial titles", () => {
    assert.deepEqual(appellationFieldsFromRegnalTitle("sui", "隋文帝"), {
      posthumousName: "文帝",
      templeName: null,
    });
    assert.deepEqual(appellationFieldsFromRegnalTitle("wuyue", "吴越武肃王"), {
      posthumousName: "武肃王",
      templeName: null,
    });
  });

  it("does not infer temple names from 祖/宗 shorthand", () => {
    assert.deepEqual(appellationFieldsFromRegnalTitle("tang", "唐太宗"), {
      posthumousName: "太宗",
      templeName: null,
    });
  });

  it("does not treat conventional 史称 as posthumous names", () => {
    assert.deepEqual(appellationFieldsFromRegnalTitle("song-liu", "宋少帝"), {
      posthumousName: null,
      templeName: null,
    });
    assert.deepEqual(appellationFieldsFromRegnalTitle("wu", "吴末帝"), {
      posthumousName: null,
      templeName: null,
    });
    assert.deepEqual(appellationFieldsFromRegnalTitle("chen-nan", "陈后主"), {
      posthumousName: null,
      templeName: null,
    });
  });
});

describe("resolveRegnalAppellationFields", () => {
  it("keeps an explicit temple and does not copy it into posthumous_name", () => {
    assert.deepEqual(
      resolveRegnalAppellationFields("tang", "唐肃宗", null, "肃宗"),
      { posthumousName: null, templeName: "肃宗" },
    );
    assert.deepEqual(
      resolveRegnalAppellationFields("tang", "唐太宗", "文武皇帝", "太宗"),
      { posthumousName: "文武皇帝", templeName: "太宗" },
    );
  });

  it("still fills posthumous from title when temple is absent", () => {
    assert.deepEqual(
      resolveRegnalAppellationFields("sui", "隋文帝", null, null),
      { posthumousName: "文帝", templeName: null },
    );
  });
});
