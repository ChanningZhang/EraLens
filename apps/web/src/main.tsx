import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { App } from "./app/App";
import { installTimelineWheel } from "./features/timeline/hooks/useTimelineWheel";
import "./design/tokens.css";
import "./design/rareCjkFont.css";
import "./design/typography.css";
import { Capacitor } from "@capacitor/core";

if (Capacitor.isNativePlatform()) {
  void import("./data/iosSqliteProbe")
    .then(({ runIosSqliteProbe }) => runIosSqliteProbe())
    .catch((error: unknown) => console.error("[EraLens] bundled SQLite probe failed", error));
}
import "./design/masterGold.css";

installTimelineWheel();

const queryClient = new QueryClient();

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <QueryClientProvider client={queryClient}>
      <App />
    </QueryClientProvider>
  </StrictMode>,
);
