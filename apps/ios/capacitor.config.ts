import type { CapacitorConfig } from "@capacitor/cli";

const config: CapacitorConfig = {
  appId: "com.eralens.app",
  appName: "EraLens",
  webDir: "../web/dist",
  bundledWebRuntime: false,
  ios: {
    contentInset: "automatic",
  },
};

export default config;
