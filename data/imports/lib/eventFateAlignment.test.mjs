import { describe, it } from "node:test";
import assert from "node:assert/strict";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { buildFateCatalog } from "../cross-dynasty-fate/catalog.mjs";
import { loadEventsFromImports, validateEventFateAlignment } from "./fateRelationHelpers.mjs";

const importsRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");

describe("validateEventFateAlignment", () => {
  it("aligns sui-tang day-precision events with linked fate lines", () => {
    const catalog = buildFateCatalog();
    const events = loadEventsFromImports(importsRoot);
    const linked = new Set([
      "tang-founded",
      "zhu-wen-usurp",
      "chenqiao-mutiny",
      "jingkang-incident",
      "beiliao-founded",
      "xiliao-fallen",
      "caishi-battle",
    ]);
    const dayPrecision = new Set([
      "tang-founded",
      "zhu-wen-usurp",
      "chenqiao-mutiny",
      "jingkang-incident",
      "beiliao-founded",
      "caishi-battle",
    ]);
    const failures = validateEventFateAlignment(catalog, events).filter((failure) =>
      linked.has(failure.eventId),
    );
    assert.deepEqual(failures, []);
    for (const id of dayPrecision) {
      const event = events.get(id);
      assert.equal(event?.precision, "day", `${id} should be day precision`);
    }
    for (const id of linked) {
      const event = events.get(id);
      assert.notEqual(event?.precision, "year", `${id} should not stay year precision`);
    }
  });
});
