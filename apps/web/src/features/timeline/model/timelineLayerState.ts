import { combineTimelineLayers, type EventTimeline, type PersonTimeline, type ReignTimeline } from "@eralens/shared";

type Loaded<T> = {data?:T;sourceKey?:string};
/** Never attach events from a stale chunk or a different dataset to a new reign layer. */
export function assembleTimelineFrame(reigns:Loaded<ReignTimeline>,events:Loaded<EventTimeline>,persons:Loaded<PersonTimeline>) {
  const base=reigns.data;
  if (!base) {
    if (!events.data) return {data:undefined,context:undefined};
    const empty:ReignTimeline={datasetVersion:events.data.datasetVersion,dynasties:[],dynastyGroups:[],reigns:[],persons:[],relations:[],context:{dynasties:[],reigns:[],persons:[]}};
    return {data:combineTimelineLayers(empty,events.data),context:empty.context};
  }
  const matches=(layer:Loaded<{datasetVersion:string}>) => layer.sourceKey === reigns.sourceKey && layer.data?.datasetVersion === base.datasetVersion;
  return {data:combineTimelineLayers(base,matches(events) ? events.data : undefined,matches(persons) ? persons.data : undefined),context:base.context};
}
