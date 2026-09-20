import { useEffect, useState, type RefObject } from "react";

/** Tracks the scrollport height of TimelineStage (not the tall lane content). */
export function useStageViewportHeight(stageRef: RefObject<HTMLElement | null>): number {
  const [height, setHeight] = useState(0);

  useEffect(() => {
    const el = stageRef.current;
    if (!el) return;

    const apply = () => {
      const next = el.clientHeight;
      if (next > 0) setHeight(next);
    };

    apply();
    const observer = new ResizeObserver(apply);
    observer.observe(el);
    return () => observer.disconnect();
  }, [stageRef]);

  return height;
}
