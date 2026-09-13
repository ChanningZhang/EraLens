import { motion } from "framer-motion";
import {
  overlapsOrthodoxSpan,
  resolveDynastyColorValue,
  type Dynasty,
  type Reign,
} from "@eralens/shared";
import type { PlacedDynasty } from "../model/laneLayout";
import {
  assignReignStacks,
  computeReignGaps,
  dynastyLaneHeight,
  STACK_ROW_HEIGHT,
} from "../model/reignClusters";
import { ReignCard } from "./ReignCard";
import { ReignGapCard } from "./ReignGapCard";
import styles from "./DynastyLane.module.css";

type Props = {
  dynasty: PlacedDynasty;
  reigns: Reign[];
  personNames: Map<string, string>;
  top: number;
};

export function DynastyLane({ dynasty, reigns, personNames, top }: Props) {
  const laneColor = resolveDynastyColorValue(dynasty);
  const { items, rowCount } = assignReignStacks(reigns);
  const height = dynastyLaneHeight(rowCount);
  const gaps = computeReignGaps(dynasty, reigns);

  return (
    <motion.div
      layout
      transition={{ duration: 0.16, ease: [0.2, 0.8, 0.2, 1] }}
      className={styles.lane}
      style={{
        top,
        height,
        ["--dynasty-color" as string]: laneColor,
        ["--stack-row-height" as string]: `${STACK_ROW_HEIGHT}px`,
        ["--dynasty-bar-height" as string]: `${rowCount * STACK_ROW_HEIGHT}px`,
      }}
    >
      <div
        className={styles.frozenLabel}
        style={rowCount > 1 ? { top: "50%", transform: "translateY(-50%)" } : undefined}
      >
        <div className={styles.labelText}>
          <p className={styles.name}>{dynasty.name}</p>
        </div>
      </div>

      <div className={styles.reignSequence}>
        <div className={styles.cards}>
          {gaps.map((gap) => (
            <ReignGapCard
              key={`gap-${gap.startAbs}-${gap.endExclusive}`}
              gap={gap}
              dynasty={dynasty as Dynasty}
              color={laneColor}
              orthodox={overlapsOrthodoxSpan(
                dynasty,
                gap.startAbs,
                gap.endExclusive - 1,
              )}
            />
          ))}
          {items.map(({ reign }) => (
            <ReignCard
              key={reign.id}
              reign={reign}
              dynasty={dynasty as Dynasty}
              color={laneColor}
              reigns={reigns}
              personName={personNames.get(reign.personId)}
              orthodox={overlapsOrthodoxSpan(
                dynasty,
                reign.startAbs,
                reign.endAbs,
              )}
            />
          ))}
        </div>
      </div>
    </motion.div>
  );
}
