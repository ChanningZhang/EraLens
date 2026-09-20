import { buildStableLaneColorMap, type ColorToken } from "@eralens/shared";
import { useEffect, useMemo } from "react";
import { laneColorStore } from "../state/laneColorStore";
import { useTimelineCatalog } from "./useTimelineCatalog";

export function useLaneColorCatalog(): ReadonlyMap<string, ColorToken> {
  const catalog = useTimelineCatalog();

  const colorMap = useMemo(() => {
    if (!catalog) return new Map<string, ColorToken>();
    return buildStableLaneColorMap(
      catalog.dynasties,
      catalog.dynastyGroups,
      catalog.dynastyLaneGroups,
    );
  }, [catalog]);

  useEffect(() => {
    if (colorMap.size > 0) {
      laneColorStore.set(colorMap);
    }
  }, [colorMap]);

  return colorMap;
}
