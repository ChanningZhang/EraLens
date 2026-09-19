import type { ColorToken } from "@eralens/shared";

type Listener = () => void;

const listeners = new Set<Listener>();
let map = new Map<string, ColorToken>();

export const laneColorStore = {
  getMap(): ReadonlyMap<string, ColorToken> {
    return map;
  },

  get(dynastyId: string): ColorToken | undefined {
    return map.get(dynastyId);
  },

  set(next: Map<string, ColorToken>) {
    map = next;
    for (const listener of listeners) listener();
  },

  subscribe(listener: Listener) {
    listeners.add(listener);
    return () => listeners.delete(listener);
  },
};
