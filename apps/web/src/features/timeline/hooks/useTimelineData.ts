import { useQueries, useQuery, useQueryClient } from "@tanstack/react-query";
import { useEffect, useMemo, useRef } from "react";
import {
  getAdjacentChunk, listQueryChunks, mergeReignTimelineChunks, ContentVersionMismatchError,
  type Lod, type QueryChunk, type ReignTimeline, type EventTimeline, type PersonTimeline,
} from "@eralens/shared";
import { getRepository } from "@/data/repository";
import { useViewport } from "./useViewport";
import { shouldShowPersons } from "../model/lod";
import { assembleTimelineFrame } from "../model/timelineLayerState";

const SCOPE = "cn";
const TIMELINE_CACHE_VERSION = 36;
type Layer = "reigns" | "events" | "persons";

export function useContentVersion() {
  return useQuery({ queryKey:["content-version"], queryFn:async () => (await getRepository()).getDatasetVersion(),
    staleTime:30_000, refetchInterval:30_000 });
}
function chunkKey(layer:Layer, chunk:QueryChunk, version:string) {
  return ["timeline-layer",TIMELINE_CACHE_VERSION,chunk.fromAbs,chunk.toAbs,SCOPE,layer,version] as const;
}
export function shouldPruneTimelineChunk(key:readonly unknown[], from:number, to:number):boolean {
  if (key[0] !== "timeline-layer" || key[1] !== TIMELINE_CACHE_VERSION) return false;
  return typeof key[2] === "number" && typeof key[3] === "number" && (key[3] < from || key[2] > to);
}
const OPTIONS = {
  staleTime:Infinity, gcTime:5*60_000,
  retry:(count:number,error:Error) => !(error instanceof ContentVersionMismatchError) && count < 3,
  refetchOnWindowFocus:(query:{state:{status:string}}) => query.state.status === "error",
  refetchOnReconnect:(query:{state:{status:string}}) => query.state.status === "error",
  refetchInterval:(query:{state:{status:string}}) => query.state.status === "error" ? 10_000 : false,
} as const;

function useLayer<T extends {datasetVersion:string}>(
  layer:Layer, chunks:QueryChunk[], lod:Lod, version:string|undefined, enabled:boolean,
  merge:(items:T[]) => T,
) {
  const client=useQueryClient();
  const sourceKey=chunks.map(c => `${c.fromAbs}:${c.toAbs}`).join("|");
  const fetchChunk=async (chunk:QueryChunk,signal?:AbortSignal):Promise<T> => {
    const repository=await getRepository();
    const query={...chunk,lod,scope:SCOPE,signal,datasetVersion:version};
    try {
      const value = layer === "reigns" ? await repository.getReignTimeline(query)
        : layer === "events" ? await repository.getEventTimeline(query) : await repository.getPersonTimeline(query);
      if (value.datasetVersion !== version) throw new ContentVersionMismatchError();
      return value as unknown as T;
    } catch (error) {
      if (error instanceof ContentVersionMismatchError) void client.invalidateQueries({queryKey:["content-version"]});
      throw error;
    }
  };
  const queries=useQueries({queries:chunks.map(chunk => ({queryKey:chunkKey(layer,chunk,version ?? "pending"),
    queryFn:({signal}:{signal:AbortSignal}) => fetchChunk(chunk,signal),enabled:enabled && !!version,...OPTIONS}))});
  const last=useRef<{data:T;sourceKey:string}|undefined>(undefined);
  const revision=`${version}|${enabled}|${sourceKey}|${queries.map(q => `${q.dataUpdatedAt}:${q.status}`).join(":")}`;
  const result=useMemo(() => {
    if (!enabled || !version) return undefined;
    const values=queries.map(q => q.data);
    if (values.length && values.every((v):v is T => !!v && v.datasetVersion === version)) last.current={data:merge(values),sourceKey};
    return last.current?.data.datasetVersion === version ? last.current : undefined;
    // Query revisions, not useQueries array identity, drive merging.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  },[revision]);
  useEffect(() => {
    if (!version || !enabled || !chunks.length) return;
    const size=chunks[0].toAbs-chunks[0].fromAbs;
    client.removeQueries({predicate:q => q.queryKey[0] === "timeline-layer" && q.getObserversCount() === 0 && q.queryKey[5] === layer &&
      (q.queryKey[6] !== version || shouldPruneTimelineChunk(q.queryKey,chunks[0].fromAbs-size*2,chunks.at(-1)!.toAbs+size*2))});
    for (const chunk of [getAdjacentChunk(chunks[0],-1,lod),getAdjacentChunk(chunks.at(-1)!,1,lod)]) {
      void client.prefetchQuery({queryKey:chunkKey(layer,chunk,version),queryFn:({signal}) => fetchChunk(chunk,signal),...OPTIONS});
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  },[sourceKey,version,enabled,lod,layer,client]);
  useEffect(() => {
    if (!enabled) void client.cancelQueries({predicate:q => q.queryKey[0] === "timeline-layer" && q.queryKey[5] === layer});
  },[enabled,layer,client]);
  return { ...result, error:queries.find(q => q.error)?.error ?? null,
    isLoading:enabled && !!version && queries.some(q => q.isLoading),isFetching:queries.some(q => q.isFetching) };
}

export function useTimelineData() {
  const viewport=useViewport();
  const version=useContentVersion();
  const requested=listQueryChunks(viewport.startAbs-60,viewport.endAbs+60,viewport.lod);
  const chunkRevision=requested.map(c => `${c.fromAbs}:${c.toAbs}`).join("|");
  // eslint-disable-next-line react-hooks/exhaustive-deps
  const chunks=useMemo(() => requested,[chunkRevision]);
  const reigns=useLayer<ReignTimeline>("reigns",chunks,viewport.lod,version.data,true,mergeReignTimelineChunks);
  const events=useLayer<EventTimeline>("events",chunks,viewport.lod,version.data,true,items => ({datasetVersion:items[0].datasetVersion,events:[...new Map(items.flatMap(i => i.events).map(e => [e.id,e])).values()]}));
  const persons=useLayer<PersonTimeline>("persons",chunks,viewport.lod,version.data,shouldShowPersons(viewport.lod),items => ({datasetVersion:items[0].datasetVersion,persons:[...new Map(items.flatMap(i => i.persons).map(p => [p.id,p])).values()]}));
  const frame=useMemo(() => assembleTimelineFrame(reigns,events,persons),[reigns.data,reigns.sourceKey,events.data,events.sourceKey,persons.data,persons.sourceKey]);
  return { ...frame,isLoading:version.isLoading || reigns.isLoading,isFetching:reigns.isFetching || events.isFetching || persons.isFetching,
    error:version.error ?? reigns.error,layerErrors:{reigns:reigns.error,events:events.error,persons:persons.error} };
}
export function useDataBounds() {
  const version=useContentVersion();
  return useQuery({queryKey:["bounds",9,version.data],queryFn:async () => (await getRepository()).getBounds(),enabled:!!version.data,staleTime:Infinity});
}
