import { describe, expect, it } from "vitest";
import { EventSchema, PersonSchema, type ReignTimeline } from "@eralens/shared";
import { assembleTimelineFrame } from "./timelineLayerState";
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
