import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import path from "node:path";
import { rmSync } from "node:fs";

export default defineConfig(({ mode }) => ({
  plugins: [react(), ...(["ios", "mac"].includes(mode) ? [{ name: "remove-native-database-assets", closeBundle() {
    rmSync(path.resolve(__dirname, `dist-${mode}/assets/databases`), { recursive: true, force: true });
  } }] : [])],
  build: {
    target: mode === "ios" || mode === "mac" ? "safari16.2" : undefined,
    outDir: mode === "ios" || mode === "mac" ? `dist-${mode}` : undefined,
  },
  define: ["ios", "mac"].includes(mode) ? { "import.meta.env.VITE_PLATFORM": JSON.stringify(mode), "import.meta.env.VITE_DATA_SOURCE": JSON.stringify("native") } : { "import.meta.env.VITE_PLATFORM": JSON.stringify("web") },
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "src"),
    },
  },
  server: {
    port: 5173,
    proxy: {
      "/api": {
        target: "http://localhost:3001",
        changeOrigin: true,
      },
    },
  },
}));
