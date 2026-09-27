import { Capacitor } from "@capacitor/core";
import { Preferences } from "@capacitor/preferences";

export interface PlatformSettings {
  get(key: string): Promise<string | null>;
  set(key: string, value: string): Promise<void>;
}

export function createPlatformSettings(): PlatformSettings {
  if (Capacitor.isNativePlatform()) {
    return {
      async get(key) { return (await Preferences.get({ key })).value; },
      async set(key, value) { await Preferences.set({ key, value }); },
    };
  }
  return {
    async get(key) { return globalThis.localStorage?.getItem(key) ?? null; },
    async set(key, value) { globalThis.localStorage?.setItem(key, value); },
  };
}
