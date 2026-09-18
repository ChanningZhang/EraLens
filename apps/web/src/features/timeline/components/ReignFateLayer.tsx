import type { PlacedReignFate } from "../model/reignFateLayout";
import { HoverTooltip } from "./HoverTooltip";
import styles from "./ReignFateLayer.module.css";

type Props = {
  placed: PlacedReignFate[];
  height: number;
};

export function ReignFateLayer({ placed, height }: Props) {
  if (placed.length === 0) return null;

  return (
    <svg
      className={styles.layer}
      style={{ height }}
      role="img"
      aria-label="跨王朝帝王关系"
    >
      {placed.map((item) => (
        <HoverTooltip key={item.id} text={item.tooltip} followPointer>
          {(handlers) => (
            <g
              className={styles.link}
              style={{ ["--card-color" as string]: item.color }}
              aria-label={item.tooltip}
              {...handlers}
            >
              <path d={item.path} className={styles.hit} />
              <line
                x1={item.tickX}
                x2={item.tickX}
                y1={item.tickTop}
                y2={item.tickTop + item.tickHeight}
                className={styles.hit}
              />
              <path d={item.path} className={styles.path} />
              <line
                x1={item.tickX}
                x2={item.tickX}
                y1={item.tickTop}
                y2={item.tickTop + item.tickHeight}
                className={styles.tick}
              />
              <circle
                cx={item.originX}
                cy={item.originY}
                r={7}
                className={styles.originHit}
              />
              <circle
                cx={item.originX}
                cy={item.originY}
                r={3.2}
                className={styles.originRing}
              />
              <circle
                cx={item.originX}
                cy={item.originY}
                r={1.2}
                className={styles.originCore}
              />
            </g>
          )}
        </HoverTooltip>
      ))}
    </svg>
  );
}
