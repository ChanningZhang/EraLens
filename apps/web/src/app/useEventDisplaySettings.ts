import { useCallback, useEffect, useState } from "react";
import { DEFAULT_EVENT_DISPLAY_CONFIG, type EventDisplayConfig, type EventKindSchema } from "@eralens/shared";
import { getRepository } from "@/data/repository";

export function useEventDisplaySettings() {
  const [eventDisplay, setEventDisplay] = useState<EventDisplayConfig>(DEFAULT_EVENT_DISPLAY_CONFIG);

  useEffect(() => {
    let active = true;
    void getRepository().then((repository) => repository.getEventDisplayConfig())
      .then((config) => { if (active) setEventDisplay(config); })
      .catch(() => { /* Defaults remain usable while remote settings are unavailable. */ });
    return () => { active = false; };
  }, []);

  const updateEventKind = useCallback(async (kind: (typeof EventKindSchema.options)[number], enabled: boolean) => {
    const next = { kinds: { ...eventDisplay.kinds, [kind]: enabled } };
    setEventDisplay(next);
    try {
      const repository = await getRepository();
      await repository.setEventDisplayConfig(next);
    } catch { /* The current session keeps the selected value. */ }
  }, [eventDisplay]);

  return { eventDisplay, updateEventKind };
}
