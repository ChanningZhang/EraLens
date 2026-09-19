import {
  COLOR_VALUES,
  fallbackLaneColorToken,
  type ColorToken,
} from "@eralens/shared";
import { useSyncExternalStore } from "react";
import { laneColorStore } from "../state/laneColorStore";

export function useLaneColorToken(dynastyId?: string): ColorToken | undefined {
  const map = useSyncExternalStore(
    laneColorStore.subscribe,
    laneColorStore.getMap,
    laneColorStore.getMap,
  );

  if (!dynastyId) return undefined;
  return map.get(dynastyId) ?? fallbackLaneColorToken(dynastyId);
}

export function useLaneColorValue(dynastyId?: string): string | undefined {
  const token = useLaneColorToken(dynastyId);
  return token ? COLOR_VALUES[token] : undefined;
}
