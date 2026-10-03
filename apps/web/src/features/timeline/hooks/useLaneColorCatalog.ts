import {
  buildStableLaneColorMap,
  type ColorToken,
  type CapitalLocation,
} from "@eralens/shared";
import { useEffect, useMemo } from "react";
import { laneColorStore } from "../state/laneColorStore";
import { useTimelineCatalog } from "./useTimelineCatalog";

export function useLaneColorCatalog(
  capitals?: readonly CapitalLocation[],
): ReadonlyMap<string, ColorToken> {
  const catalog = useTimelineCatalog();

  const colorMap = useMemo(() => {
    if (!catalog) return new Map<string, ColorToken>();
    return buildStableLaneColorMap(
      catalog.dynasties,
      catalog.dynastyGroups,
      capitals ?? [],
    );
  }, [catalog, capitals]);

  useEffect(() => {
    if (colorMap.size > 0) {
      laneColorStore.set(colorMap);
    }
  }, [colorMap]);

  return colorMap;
}
