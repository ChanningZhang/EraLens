import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { Capacitor } from "@capacitor/core";
import { Keyboard } from "@capacitor/keyboard";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { App } from "./app/App";
import { installTimelineWheel } from "./features/timeline/hooks/useTimelineWheel";
import { viewportStore } from "./features/timeline/state/viewportStore";
import "./design/tokens.css";
import "./design/rareCjkFont.css";
import "./design/timelineSerifFont.css";
import "./design/typography.css";
import "./design/masterGold.css";

installTimelineWheel();

if (Capacitor.getPlatform() === "ios") {
  void Keyboard.setAccessoryBarVisible({ isVisible: false });
}

const queryClient = new QueryClient();

async function bootstrap() {
  if (Capacitor.getPlatform() === "ios") {
    await viewportStore.restorePersistedState();
    viewportStore.enablePersistence();
  }

  createRoot(document.getElementById("root")!).render(
    <StrictMode>
      <QueryClientProvider client={queryClient}>
        <App />
      </QueryClientProvider>
    </StrictMode>,
  );
}

void bootstrap();
