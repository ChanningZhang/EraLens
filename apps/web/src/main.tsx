import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { App } from "./app/App";
import { isNativeApp } from "./data/nativePlatform";
import { installTimelineWheel } from "./features/timeline/hooks/useTimelineWheel";
import { viewportStore } from "./features/timeline/state/viewportStore";
import "./design/tokens.css";
import "./design/rareCjkFont.css";
import "./design/timelineSerifFont.css";
import "./design/typography.css";
import "./design/masterGold.css";

installTimelineWheel();

const queryClient = new QueryClient();

async function bootstrap() {
  if (isNativeApp()) {
    void viewportStore.restorePersistedState()
      .then(() => viewportStore.enablePersistence())
      .catch((error: unknown) => console.error("读取本地时间轴设置失败", error));
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
