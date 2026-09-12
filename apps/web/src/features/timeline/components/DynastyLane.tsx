import { motion } from "framer-motion";
import { COLOR_VALUES, type Dynasty, type Reign } from "@eralens/shared";
import type { PlacedDynasty } from "../model/laneLayout";
import { clusterSameStartReigns } from "../model/reignClusters";
import { ReignCard } from "./ReignCard";
import styles from "./DynastyLane.module.css";

type Props = {
  dynasty: PlacedDynasty;
  reigns: Reign[];
  laneHeight: number;
  topOffset?: number;
};

export function DynastyLane({ dynasty, reigns, laneHeight, topOffset = 0 }: Props) {
  const color = COLOR_VALUES[dynasty.colorToken];
  const clusters = clusterSameStartReigns(reigns);

  return (
    <motion.div
      layout
      transition={{ duration: 0.16, ease: [0.2, 0.8, 0.2, 1] }}
      className={styles.lane}
      style={{
        top: topOffset + dynasty.lane * laneHeight,
        height: laneHeight,
        ["--dynasty-color" as string]: color,
      }}
    >
      <div className={styles.frozenLabel}>
        <span className={styles.colorMark} aria-hidden="true" />
        <div className={styles.labelText}>
          <p className={styles.name}>{dynasty.name}</p>
        </div>
      </div>

      <div className={styles.reignSequence}>
        <div className={styles.cards}>
          {clusters.map((group, index) => (
            <ReignCard
              key={group.map((item) => item.id).join(",")}
              reigns={group}
              dynasty={dynasty as Dynasty}
              color={color}
              nextReignStartAbs={clusters[index + 1]?.[0]?.startAbs}
            />
          ))}
        </div>
      </div>
    </motion.div>
  );
}
