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
  plugins: {
    Keyboard: {
      // iOS 26 keyboards have transparent, rounded edges that expose the
      // native window behind them. Keep that backdrop in sync with the app.
      autoBackdropColor: "dom",
    },
  },
};

export default config;
