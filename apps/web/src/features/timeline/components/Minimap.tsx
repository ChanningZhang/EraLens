import { useMemo, useRef } from "react";
import { useViewport } from "../hooks/useViewport";
import { viewportStore } from "../state/viewportStore";
import styles from "./Minimap.module.css";

type Props = {
  minAbs: number;
  maxAbs: number;
  density: number[];
};

export function Minimap({ minAbs, maxAbs, density }: Props) {
  const viewport = useViewport();
  const ref = useRef<HTMLDivElement>(null);
  const span = maxAbs - minAbs || 1;

  const windowStyle = useMemo(() => {
    const leftPct = ((viewport.startAbs - minAbs) / span) * 100;
    const widthPct = ((viewport.endAbs - viewport.startAbs) / span) * 100;
    return {
      left: `${Math.max(0, leftPct)}%`,
      width: `${Math.min(100 - Math.max(0, leftPct), widthPct)}%`,
    };
  }, [viewport.startAbs, viewport.endAbs, minAbs, span]);

  return (
    <div
      ref={ref}
      className={styles.minimap}
      onClick={(event) => {
        const rect = ref.current?.getBoundingClientRect();
        if (!rect) return;
        const ratio = (event.clientX - rect.left) / rect.width;
        const targetAbs = minAbs + ratio * span;
        viewportStore.jumpToAbs(targetAbs);
      }}
    >
      {density.map((weight, index) => (
        <span
          key={index}
          className={styles.bar}
          style={{
            left: `${(index / density.length) * 100}%`,
            opacity: 0.3 + weight * 0.7,
          }}
        />
      ))}
      <div className={styles.window} style={windowStyle} />
    </div>
  );
}

export function useMinimapDensity(minAbs: number, maxAbs: number, buckets = 48): number[] {
  const span = maxAbs - minAbs || 1;
  const bucketSize = span / buckets;
  return useMemo(() => {
    const weights = new Array(buckets).fill(0);
    for (let i = 0; i < buckets; i++) {
      const center = minAbs + (i + 0.5) * bucketSize;
      const dist = Math.abs(center - 2650);
      weights[i] = Math.max(0, 1 - dist / 800);
    }
    return weights;
  }, [minAbs, maxAbs, buckets, bucketSize]);
}
