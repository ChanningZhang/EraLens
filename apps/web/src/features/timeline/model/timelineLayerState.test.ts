import { describe, expect, it } from "vitest";
import { EventSchema, PersonSchema, type ReignTimeline } from "@eralens/shared";
import { assembleTimelineFrame, resolveTimelineFrame } from "./timelineLayerState";
const base:ReignTimeline={datasetVersion:"v1",dynasties:[],dynastyGroups:[],reigns:[],persons:[],relations:[],context:{dynasties:[],reigns:[],persons:[]}};
const event=EventSchema.parse({id:"e",name:"event",kind:"politics",at:{year:505,month:6},atAbs:6065});
const events={datasetVersion:"v1",events:[event]};
describe("timeline layer assembly",() => {
  it("shows reigns while other layers are loading or failed",() => {
    expect(assembleTimelineFrame({data:base,sourceKey:"a"},{},{}).data?.events).toEqual([]);
    expect(assembleTimelineFrame({data:base,sourceKey:"a"},{},{}).data?.reigns).toEqual(base.reigns);
  });
  it("rejects late results from another chunk or dataset",() => {
    expect(assembleTimelineFrame({data:base,sourceKey:"a"},{data:events,sourceKey:"b"},{}).data?.events).toEqual([]);
    expect(assembleTimelineFrame({data:base,sourceKey:"a"},{data:{...events,datasetVersion:"v0"},sourceKey:"a"},{}).data?.events).toEqual([]);
    expect(assembleTimelineFrame({data:base,sourceKey:"a"},{data:events,sourceKey:"a"},{}).data?.events).toEqual([event]);
  });
  it("can show the event rail independently before reigns arrive",() => {
    const frame=assembleTimelineFrame({},{data:events,sourceKey:"a"},{});
    expect(frame.data?.events).toEqual([event]);expect(frame.data?.dynasties).toEqual([]);
  });
  it("keeps context people out of the footer data",() => {
    const withContext={...base,context:{...base.context,persons:[PersonSchema.parse({id:"ruler",name:"ruler"})]}};
    expect(assembleTimelineFrame({data:withContext,sourceKey:"a"},{},{}).data?.persons).toEqual([]);
  });
});

describe("timeline window transitions", () => {
  const previous = resolveTimelineFrame(undefined,
    { data: base, sourceKey: "a" }, { data: events, sourceKey: "a" }, {});

  it("keeps events visible when reigns arrive before the new event layer", () => {
    const pending = resolveTimelineFrame(previous,
      { data: base, sourceKey: "b" },
      { data: events, sourceKey: "a", isLoading: true }, {});
    expect(pending).toBe(previous);
    expect(pending.data?.events).toEqual([event]);
    const ready = resolveTimelineFrame(pending,
      { data: base, sourceKey: "b" }, { data: events, sourceKey: "b" }, {});
    expect(ready.sourceKey).toBe("b");
    expect(ready.data?.events).toEqual([event]);
  });

  it("keeps events visible when the event layer arrives before reigns", () => {
    const pending = resolveTimelineFrame(previous,
      { data: base, sourceKey: "a", requestedSourceKey: "b", isLoading: true },
      { data: events, sourceKey: "b" }, {});
    expect(pending).toBe(previous);
    expect(resolveTimelineFrame(pending,
      { data: base, sourceKey: "b" }, { data: events, sourceKey: "b" }, {}).sourceKey).toBe("b");
  });

  it("waits for an enabled person layer when changing windows", () => {
    expect(resolveTimelineFrame(previous,
      { data: base, sourceKey: "b" }, { data: events, sourceKey: "b" },
      { isLoading: true })).toBe(previous);
  });

  it("still shows initial reigns and does not wait forever for failed or disabled layers", () => {
    expect(resolveTimelineFrame(undefined,
      { data: base, sourceKey: "a" }, { isLoading: true }, {}).data?.reigns).toEqual([]);
    const failed = resolveTimelineFrame(previous,
      { data: base, sourceKey: "b" }, { data: events, sourceKey: "a", isLoading: false }, {});
    expect(failed.sourceKey).toBe("b");
    expect(failed.data?.events).toEqual([]);
  });

  it("never preserves an old dataset during a content version change", () => {
    const next = resolveTimelineFrame(previous,
      { data: { ...base, datasetVersion: "v2" }, sourceKey: "b" }, { isLoading: true }, {});
    expect(next.datasetVersion).toBe("v2");
    expect(next.data?.events).toEqual([]);
    expect(resolveTimelineFrame(previous, {}, {}, {}).data).toBeUndefined();
  });

  it("ignores slow intermediate windows while the latest requested window loads", () => {
    const pending = resolveTimelineFrame(previous,
      { data: base, sourceKey: "b", requestedSourceKey: "c", isLoading: true },
      { data: events, sourceKey: "b", isLoading: true }, {});
    expect(pending).toBe(previous);
    expect(resolveTimelineFrame(pending,
      { data: base, sourceKey: "c" }, { data: events, sourceKey: "c" }, {}).sourceKey).toBe("c");
  });
});
