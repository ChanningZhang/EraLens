import { useQuery } from "@tanstack/react-query";
import type { TimelineCatalog } from "@eralens/shared";
import { getRepository } from "@/data/repository";

const SCOPE = "cn";
const CATALOG_VERSION = 3;

export function useTimelineCatalog(): TimelineCatalog | undefined {
  const query = useQuery({
    queryKey: ["timeline-catalog", CATALOG_VERSION, SCOPE],
    queryFn: async () => {
      const repo = await getRepository();
      return repo.getTimelineCatalog(SCOPE);
    },
    staleTime: Infinity,
    gcTime: 24 * 60 * 60_000,
  });
  return query.data;
}
