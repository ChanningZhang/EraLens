import { combineTimelineLayers, type EventTimeline, type PersonTimeline, type ReignTimeline } from "@eralens/shared";

type Loaded<T> = {data?:T;sourceKey?:string;requestedSourceKey?:string;isLoading?:boolean};
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

type TimelineFrame = ReturnType<typeof assembleTimelineFrame> & { sourceKey?: string; datasetVersion?: string };

/** Keep a coherent previous frame while an uncached window's layers arrive. */
export function resolveTimelineFrame(
  previous: TimelineFrame | undefined,
  reigns: Loaded<ReignTimeline>,
  events: Loaded<EventTimeline>,
  persons: Loaded<PersonTimeline>,
): TimelineFrame {
  const waitingFor = (layer: Loaded<{ datasetVersion: string }>) =>
    layer.isLoading && (layer.sourceKey !== reigns.sourceKey ||
      layer.data?.datasetVersion !== reigns.data?.datasetVersion);
  if (previous?.data && previous.sourceKey && reigns.data &&
      previous.datasetVersion === reigns.data.datasetVersion &&
      previous.sourceKey !== (reigns.requestedSourceKey ?? reigns.sourceKey) &&
      (reigns.isLoading || waitingFor(events) || waitingFor(persons))) {
    return previous;
  }
  return { ...assembleTimelineFrame(reigns, events, persons), sourceKey: reigns.sourceKey, datasetVersion: reigns.data?.datasetVersion };
}
