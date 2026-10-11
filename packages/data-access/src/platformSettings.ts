import type { EraLensNativeBridge } from "./repository";

export interface PlatformSettings {
  get(key: string): Promise<string | null>;
  set(key: string, value: string): Promise<void>;
}

export function createPlatformSettings(nativeBridge?: EraLensNativeBridge): PlatformSettings {
  const bridge = nativeBridge ?? (typeof window !== "undefined" ? window.eralensNative : undefined);
  if (bridge) {
    return {
      get: (key) => bridge.getSetting(key),
      set: (key, value) => bridge.setSetting(key, value),
    };
  }
  return {
    async get(key) { return globalThis.localStorage?.getItem(key) ?? null; },
    async set(key, value) { globalThis.localStorage?.setItem(key, value); },
  };
}
