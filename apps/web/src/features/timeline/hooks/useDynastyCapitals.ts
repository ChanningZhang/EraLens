import { useQuery } from "@tanstack/react-query";
import { getRepository } from "@/data/repository";

const STALE_TIME = Infinity;
const GC_TIME = 24 * 60 * 60_000;

type Bounds = { minAbs: number; maxAbs: number };

/** Load the full capital catalog once; filter at render time to avoid pan flicker. */
export function useDynastyCapitals(bounds: Bounds | undefined) {
  return useQuery({
    queryKey: ["dynasty-capitals", "all", bounds?.minAbs, bounds?.maxAbs],
    queryFn: async () => {
      const repo = await getRepository();
      return repo.getCapitals(bounds!.minAbs, bounds!.maxAbs);
    },
    enabled: bounds != null,
    staleTime: STALE_TIME,
    gcTime: GC_TIME,
    refetchOnWindowFocus: false,
    refetchOnReconnect: false,
  });
}
