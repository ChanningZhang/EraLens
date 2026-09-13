import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import { searchEntities } from "./timelineData";

describe("searchEntities person aliases", () => {
  const store = {
    dynasties: [],
    reigns: [],
    events: [],
    relations: [],
    persons: [
      {
        id: "lv-shang",
        name: "吕尚",
        birth: { year: -1156, month: 1 },
        death: { year: -1017, month: 1 },
        roles: ["君主", "军事家", "政治家"],
        links: [],
      },
    ],
  };

  it("finds 姜子牙 by alias even when the stored name is 吕尚", () => {
    const hits = searchEntities(store, "姜子牙");
    expect(hits).toEqual([
      {
        ref: { type: "person", id: "lv-shang" },
        label: "吕尚",
        subtitle: "君主 · 军事家 · 政治家",
        abs: absMonth(-1156, 1),
      },
    ]);
  });
});
