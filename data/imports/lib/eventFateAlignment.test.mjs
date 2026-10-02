import { describe, it } from "node:test";
import assert from "node:assert/strict";
import path from "node:path";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { loadEventsFromImports, validateEventFateAlignment } from "./fateRelationHelpers.mjs";

const importsRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), "..");
const cache = JSON.parse(readFileSync(path.join(importsRoot, "cross-dynasty-fate", "cache.json"), "utf8"));

describe("validateEventFateAlignment", () => {
  it("aligns sui-tang day-precision events with linked fate lines", () => {
    const catalog = cache.relations;
    const events = loadEventsFromImports(importsRoot);
    const linked = new Set([
      "jingkang-incident",
      "caishi-battle",
      "gaogouli-destroyed-tang",
    ]);
    const dayPrecision = new Set(["jingkang-incident", "caishi-battle"]);
    const failures = validateEventFateAlignment(catalog, events).filter((failure) =>
      linked.has(failure.eventId),
    );
    assert.deepEqual(failures, []);
    for (const id of dayPrecision) {
      const event = events.get(id);
      assert.equal(event?.confidence, "day", `${id} should carry day confidence`);
    }
    for (const id of linked) {
      const event = events.get(id);
      assert.notEqual(event?.confidence, "year", `${id} should not stay year confidence`);
    }
  });
});
