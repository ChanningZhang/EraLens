import { useQuery } from "@tanstack/react-query";
import type { TimelineCatalog } from "@eralens/shared";
import { getRepository } from "@/data/repository";

import { useContentVersion } from "./useTimelineData";

const SCOPE = "cn";
const CATALOG_VERSION = 4;

export function useTimelineCatalog(): TimelineCatalog | undefined {
  const version = useContentVersion();
  const query = useQuery({
    queryKey: ["timeline-catalog", CATALOG_VERSION, SCOPE, version.data],
    queryFn: async () => {
      const repo = await getRepository();
      return repo.getTimelineCatalog(SCOPE);
    },
    enabled: !!version.data,
    staleTime: Infinity,
    gcTime: 24 * 60 * 60_000,
  });
  return query.data;
}
