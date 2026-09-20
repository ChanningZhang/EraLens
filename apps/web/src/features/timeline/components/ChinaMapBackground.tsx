import { useEffect, useMemo, useRef, useState } from "react";
import chinaOutline from "@/assets/china-outline.svg?raw";
import {
  resolveChinaMapInsets,
  resolveChinaMapLayout,
} from "../model/chinaMapProjection";
import styles from "./ChinaMapBackground.module.css";

type Props = {
  gutterPx: number;
};

export function ChinaMapBackground({ gutterPx }: Props) {
  const containerRef = useRef<HTMLDivElement>(null);
  const [size, setSize] = useState({ width: 0, height: 0 });

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;
    const apply = (width: number, height: number) => {
      if (width < 1 || height < 1) return;
      setSize({ width, height });
    };
    apply(el.clientWidth, el.clientHeight);
    const observer = new ResizeObserver((entries) => {
      const rect = entries[0]?.contentRect;
      if (!rect) return;
      apply(rect.width, rect.height);
    });
    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  const layout = useMemo(() => {
    if (size.width < 1 || size.height < 1) return null;
    return resolveChinaMapLayout(
      size.width,
      size.height,
      resolveChinaMapInsets(gutterPx),
    );
  }, [gutterPx, size.height, size.width]);

  return (
    <div ref={containerRef} className={styles.background} aria-hidden="true">
      <div className={styles.veil} />
      {layout && (
        <div
          className={styles.mapBox}
          style={{
            left: `${layout.left}px`,
            top: `${layout.top}px`,
            width: `${layout.width}px`,
            height: `${layout.height}px`,
          }}
          // Inline SVG so theme tokens and gradients apply (img cannot use currentColor/CSS vars).
          dangerouslySetInnerHTML={{ __html: chinaOutline }}
        />
      )}
    </div>
  );
}
