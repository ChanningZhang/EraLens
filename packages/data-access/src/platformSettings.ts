import { Capacitor } from "@capacitor/core";
import { Preferences } from "@capacitor/preferences";

export interface PlatformSettings {
  get(key: string): Promise<string | null>;
  set(key: string, value: string): Promise<void>;
}

let nativeMigration: Promise<void> | undefined;

function migrateLegacyNativeSettings() {
  nativeMigration ??= Preferences.migrate().then(() => Preferences.removeOld()).catch(() => {
    // First launch has nothing to migrate on most installs. Keep the app usable
    // if WebKit storage is unavailable or the migration was already completed.
  });
  return nativeMigration;
}

export function createPlatformSettings(): PlatformSettings {
  if (Capacitor.isNativePlatform()) {
    return {
      async get(key) { await migrateLegacyNativeSettings(); return (await Preferences.get({ key })).value; },
      async set(key, value) { await migrateLegacyNativeSettings(); await Preferences.set({ key, value }); },
    };
  }
  return {
    async get(key) { return globalThis.localStorage?.getItem(key) ?? null; },
    async set(key, value) { globalThis.localStorage?.setItem(key, value); },
  };
}
