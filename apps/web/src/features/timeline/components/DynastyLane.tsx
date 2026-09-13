import { motion } from "framer-motion";
import {
  COLOR_VALUES,
  resolveDynastyColorToken,
  type Dynasty,
  type Reign,
} from "@eralens/shared";
import type { PlacedDynasty } from "../model/laneLayout";
import { assignReignStacks, dynastyLaneHeight, STACK_ROW_HEIGHT } from "../model/reignClusters";
import { ReignCard } from "./ReignCard";
import styles from "./DynastyLane.module.css";

type Props = {
  dynasty: PlacedDynasty;
  reigns: Reign[];
  personNames: Map<string, string>;
  top: number;
};

export function DynastyLane({ dynasty, reigns, personNames, top }: Props) {
  const color = COLOR_VALUES[resolveDynastyColorToken(dynasty)];
  const { items, rowCount } = assignReignStacks(reigns);
  const height = dynastyLaneHeight(rowCount);

  return (
    <motion.div
      layout
      transition={{ duration: 0.16, ease: [0.2, 0.8, 0.2, 1] }}
      className={styles.lane}
      style={{
        top,
        height,
        ["--dynasty-color" as string]: color,
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
          {items.map(({ reign }) => (
            <ReignCard
              key={reign.id}
              reign={reign}
              dynasty={dynasty as Dynasty}
              color={color}
              reigns={reigns}
              personName={personNames.get(reign.personId)}
            />
          ))}
        </div>
      </div>
    </motion.div>
  );
}
