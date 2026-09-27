import { useEffect, useState, type RefObject } from "react";

export type StageViewportSize = { width: number; height: number };

/** Tracks the scrollport size of TimelineStage (not the tall lane content). */
export function useStageViewportSize(stageRef: RefObject<HTMLElement | null>): StageViewportSize {
  const [size, setSize] = useState<StageViewportSize>({ width: 0, height: 0 });

  useEffect(() => {
    const el = stageRef.current;
    if (!el) return;

    const apply = () => {
      const next = { width: el.clientWidth, height: el.clientHeight };
      if (next.width > 0 && next.height > 0) {
        setSize((previous) =>
          previous.width === next.width && previous.height === next.height
            ? previous
            : next,
        );
      }
    };

    apply();
    const observer = new ResizeObserver(apply);
    observer.observe(el);
    return () => observer.disconnect();
  }, [stageRef]);

  return size;
}
