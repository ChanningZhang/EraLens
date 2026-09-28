import type { PlacedReignFate } from "../model/reignFateLayout";
import { InfoPopover } from "./InfoPopover";
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
      role="group"
      aria-label="跨王朝帝王关系"
    >
      {placed.map((item) => {
        const segments = [
          { x1: item.originX, x2: item.eventX, y1: item.originY, y2: item.originY },
          { x1: item.eventX, x2: item.eventX, y1: item.originY, y2: item.destinationY },
          { x1: item.eventX, x2: item.destinationX, y1: item.destinationY, y2: item.destinationY },
        ];
        return (
          <InfoPopover key={item.id} text={item.tooltip} followPointer>
            {(handlers) => (
            <g
              className={styles.link}
              style={{ ["--card-color" as string]: item.color }}
              role="img"
              tabIndex={0}
              aria-label={item.tooltip}
              {...handlers}
            >
              {segments.map((segment, index) => (
                <line
                  key={`hit-${index}`}
                  x1={segment.x1}
                  x2={segment.x2}
                  y1={segment.y1}
                  y2={segment.y2}
                  className={styles.hit}
                />
              ))}
              <line
                x1={item.tickX}
                x2={item.tickX}
                y1={item.tickTop}
                y2={item.tickTop + item.tickHeight}
                className={styles.hit}
              />
              {segments.map((segment, index) => (
                <line
                  key={`path-${index}`}
                  x1={segment.x1}
                  x2={segment.x2}
                  y1={segment.y1}
                  y2={segment.y2}
                  className={styles.path}
                />
              ))}
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
          </InfoPopover>
        );
      })}
    </svg>
  );
}
