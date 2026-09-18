import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { assignOverlappingBranchTracks } from "./overlappingBranchTracks.mjs";

function r(title, start, end, extra = {}) {
  return { title, start, end, ...extra };
}

describe("assignOverlappingBranchTracks", () => {
  it("puts overlapping Tian Qi on a parallel track and keeps Jiang Kang Gong on main", () => {
    const rulers = [
      r("齐宣公", -455, -405, { clan: "姜" }),
      r("齐康公", -404, -379, { clan: "姜" }),
      r("齐太公", -404, -384, { clan: "田" }),
      r("齐侯剡", -383, -375, { clan: "田" }),
      r("齐桓公", -374, -357, { clan: "田" }),
    ];
    assignOverlappingBranchTracks(rulers);
    assert.equal(rulers[0].claimTrack, undefined);
    assert.equal(rulers[1].claimTrack, undefined);
    assert.equal(rulers[2].claimTrack, "tian");
    assert.equal(rulers[2].claimLabel, "田");
    assert.equal(rulers[2].claimRole, "rival");
    assert.equal(rulers[3].claimTrack, "tian");
    assert.equal(rulers[4].claimTrack, undefined);
  });

  it("does nothing when a dynasty has only one clan", () => {
    const rulers = [
      r("齐宣公", -455, -405, { clan: "姜" }),
      r("齐康公", -404, -379, { clan: "姜" }),
    ];
    assignOverlappingBranchTracks(rulers);
    assert.equal(rulers.every((item) => item.claimTrack == null), true);
  });
});
