import type { CapacitorConfig } from "@capacitor/cli";

const config: CapacitorConfig = {
  appId: "com.eralens.app",
  appName: "EraLens",
  webDir: "../web/dist",
  bundledWebRuntime: false,
  ios: {
    // CSS env(safe-area-inset-*) is the single source for the shared React UI.
    contentInset: "never",
  },
};

export default config;
