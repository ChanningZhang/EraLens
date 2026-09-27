import chinaOutline from "@/assets/china-outline.svg?raw";
import type { ChinaMapLayout } from "../model/chinaMapProjection";
import styles from "./ChinaMapBackground.module.css";

type Props = {
  layout: ChinaMapLayout | null;
  scale: number;
  offset: { x: number; y: number };
};

export function ChinaMapBackground({ layout, scale, offset }: Props) {
  return (
    <div className={styles.background}>
      <div className={styles.veil} />
      {layout && (
        <div
          className={styles.mapBox}
          data-china-map-box
          data-testid="china-map-frame"
          style={{
            left: `${layout.left}px`,
            top: `${layout.top}px`,
            width: `${layout.width}px`,
            height: `${layout.height}px`,
            transform: `translate(${offset.x + layout.left * (scale - 1)}px, ${offset.y + layout.top * (scale - 1)}px) scale(${scale})`,
          }}
          // Inline SVG so theme tokens and gradients apply (img cannot use currentColor/CSS vars).
          dangerouslySetInnerHTML={{ __html: chinaOutline }}
        />
      )}
    </div>
  );
}
