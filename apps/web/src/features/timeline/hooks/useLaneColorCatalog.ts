import { buildStableLaneColorMap, type ColorToken } from "@eralens/shared";
import { useQuery } from "@tanstack/react-query";
import { useEffect, useMemo } from "react";
import { getRepository } from "@/data/repository";
import { laneColorStore } from "../state/laneColorStore";

const SCOPE = "cn";
const CATALOG_VERSION = 3;

export function useLaneColorCatalog(): ReadonlyMap<string, ColorToken> {
  const catalogQuery = useQuery({
    queryKey: ["timeline-catalog", CATALOG_VERSION, SCOPE],
    queryFn: async () => {
      const repo = await getRepository();
      return repo.getTimelineCatalog(SCOPE);
    },
    staleTime: Infinity,
    gcTime: 24 * 60 * 60_000,
  });

  const colorMap = useMemo(() => {
    if (!catalogQuery.data) return new Map<string, ColorToken>();
    return buildStableLaneColorMap(
      catalogQuery.data.dynasties,
      catalogQuery.data.dynastyGroups,
      catalogQuery.data.dynastyLaneGroups,
    );
  }, [catalogQuery.data]);

  useEffect(() => {
    if (colorMap.size > 0) {
      laneColorStore.set(colorMap);
    }
  }, [colorMap]);

  return colorMap;
}
