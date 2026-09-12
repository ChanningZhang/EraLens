import { useSyncExternalStore } from "react";
import { viewportStore } from "../state/viewportStore";

export function useViewport() {
  return useSyncExternalStore(
    viewportStore.subscribe,
    viewportStore.getSnapshot,
    viewportStore.getServerSnapshot,
  );
}
