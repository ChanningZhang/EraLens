import { useEffect, useRef, useState } from "react";
import { createPlatformSettings } from "@eralens/data-access";
import { DEFAULT_TIMELINE_LAYOUT_PREFERENCES, type TimelineLayoutPreferences } from "@eralens/shared";
import { viewportStore } from "@/features/timeline/state/viewportStore";

const settings = createPlatformSettings();
const SETTINGS_KEY = "eralens.timeline-layout.v1";

export function useTimelineLayoutSettings() {
  const [preferences, setPreferences] = useState(DEFAULT_TIMELINE_LAYOUT_PREFERENCES);
  const revision = useRef(0);
  useEffect(() => {
    let active = true;
    void settings.get(SETTINGS_KEY).then((value) => {
      if (!active || revision.current !== 0 || !value) return;
      const parsed = JSON.parse(value) as Partial<TimelineLayoutPreferences>;
      const next: TimelineLayoutPreferences = {
        railCollapsed: parsed.railCollapsed === true,
        density: parsed.density === "compact" || parsed.density === "comfortable" ? parsed.density : "auto",
      };
      setPreferences(next);
      viewportStore.setLayoutPreferences(next);
    }).catch(() => { /* Default layout remains usable without persisted settings. */ });
    return () => { active = false; };
  }, []);

  function updateLayout(update: Partial<TimelineLayoutPreferences>) {
    revision.current += 1;
    const next = { ...preferences, ...update };
    setPreferences(next);
    viewportStore.setLayoutPreferences(next);
    void settings.set(SETTINGS_KEY, JSON.stringify(next)).catch(() => { /* Keep the session choice. */ });
  }

  return { preferences, updateLayout };
}
