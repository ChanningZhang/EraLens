import { useSyncExternalStore } from "react";
import { selectionStore } from "../state/selectionStore";

export function useSelection() {
  return useSyncExternalStore(
    selectionStore.subscribe,
    selectionStore.getSnapshot,
    selectionStore.getServerSnapshot,
  );
}
