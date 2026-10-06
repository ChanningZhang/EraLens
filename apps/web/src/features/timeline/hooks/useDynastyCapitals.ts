import { projectCapitalLocations } from "@eralens/shared";
import { useMemo } from "react";
import { useQuery } from "@tanstack/react-query";
import { getRepository } from "@/data/repository";
import type { Reign } from "@eralens/shared";

import { useContentVersion } from "./useTimelineData";

const STALE_TIME = Infinity;
const GC_TIME = 24 * 60 * 60_000;

type Bounds = { minAbs: number; maxAbs: number };
const EMPTY_REIGNS: readonly Reign[] = [];

/** Load dynasty and reign capital mappings; project at render time to avoid pan flicker. */
export function useCapitalLocations(bounds: Bounds | undefined, reigns?: readonly Reign[]) {
  const version = useContentVersion();
  const query = useQuery({
    queryKey: ["dynasty-capitals", "all-with-reign-mappings", bounds?.minAbs, bounds?.maxAbs, version.data],
    queryFn: async () => {
      const repo = await getRepository();
      return repo.getLocationMappings({fromAbs:bounds!.minAbs,toAbs:bounds!.maxAbs});
    },
    enabled: bounds != null && !!version.data,
    staleTime: STALE_TIME,
    gcTime: GC_TIME,
    refetchOnWindowFocus: false,
    refetchOnReconnect: false,
  });
  const data = useMemo(
    () => query.data ? projectCapitalLocations(query.data, reigns ?? EMPTY_REIGNS) : undefined,
    [query.data, reigns],
  );
  return { ...query, data };
}
