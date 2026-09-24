import type { PlacedReignFate } from "../model/reignFateLayout";
import { motion, useReducedMotion } from "framer-motion";
import { HoverTooltip } from "./HoverTooltip";
import styles from "./ReignFateLayer.module.css";

type Props = {
  placed: PlacedReignFate[];
  height: number;
};

export function ReignFateLayer({ placed, height }: Props) {
  const reduceMotion = useReducedMotion();
  if (placed.length === 0) return null;
  const transition = { duration: reduceMotion ? 0 : 0.24, ease: [0.2, 0.8, 0.2, 1] as const };

  return (
    <svg
      className={styles.layer}
      style={{ height }}
      role="img"
      aria-label="跨王朝帝王关系"
    >
      {placed.map((item) => {
        const segments = [
          { x1: item.originX, x2: item.eventX, y1: item.originY, y2: item.originY },
          { x1: item.eventX, x2: item.eventX, y1: item.originY, y2: item.destinationY },
          { x1: item.eventX, x2: item.destinationX, y1: item.destinationY, y2: item.destinationY },
        ];
        return (
          <HoverTooltip key={item.id} text={item.tooltip} followPointer>
            {(handlers) => (
            <g
              className={styles.link}
              style={{ ["--card-color" as string]: item.color }}
              aria-label={item.tooltip}
              {...handlers}
            >
              {segments.map((segment, index) => (
                <motion.line
                  key={`hit-${index}`}
                  x1={segment.x1}
                  x2={segment.x2}
                  animate={{ y1: segment.y1, y2: segment.y2 }}
                  transition={transition}
                  className={styles.hit}
                />
              ))}
              <motion.line
                x1={item.tickX}
                x2={item.tickX}
                animate={{ y1: item.tickTop, y2: item.tickTop + item.tickHeight }}
                transition={transition}
                className={styles.hit}
              />
              {segments.map((segment, index) => (
                <motion.line
                  key={`path-${index}`}
                  x1={segment.x1}
                  x2={segment.x2}
                  animate={{ y1: segment.y1, y2: segment.y2 }}
                  transition={transition}
                  className={styles.path}
                />
              ))}
              <motion.line
                x1={item.tickX}
                x2={item.tickX}
                animate={{ y1: item.tickTop, y2: item.tickTop + item.tickHeight }}
                transition={transition}
                className={styles.tick}
              />
              <motion.circle
                cx={item.originX}
                animate={{ cy: item.originY }}
                transition={transition}
                r={7}
                className={styles.originHit}
              />
              <motion.circle
                cx={item.originX}
                animate={{ cy: item.originY }}
                transition={transition}
                r={3.2}
                className={styles.originRing}
              />
              <motion.circle
                cx={item.originX}
                animate={{ cy: item.originY }}
                transition={transition}
                r={1.2}
                className={styles.originCore}
              />
            </g>
            )}
          </HoverTooltip>
        );
      })}
    </svg>
  );
}
