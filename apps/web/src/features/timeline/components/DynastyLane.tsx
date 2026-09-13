import { AnimatePresence, motion } from "framer-motion";
import {
  getDynastyLaneGroup,
  overlapsOrthodoxSpan,
  resolveActivePhaseDynastyId,
  resolveDynastyColorValue,
  resolveFrozenLabelAnchorAbs,
  resolveFrozenLaneLabel,
  type Dynasty,
  type Reign,
} from "@eralens/shared";
import { useViewport } from "../hooks/useViewport";
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
  dynastiesById: Map<string, Dynasty>;
  gapCoverageReigns?: Reign[];
  personNames: Map<string, string>;
  top: number;
};

export function DynastyLane({
  dynasty,
  reigns,
  dynastiesById,
  gapCoverageReigns = [],
  personNames,
  top,
}: Props) {
  const viewport = useViewport();
  const labelAnchorAbs = resolveFrozenLabelAnchorAbs(
    viewport.startAbs,
    viewport.pxPerMonth,
  );
  const laneGroup = getDynastyLaneGroup(dynasty.id);
  const activePhaseDynasty =
    laneGroup == null
      ? dynasty
      : dynastiesById.get(
          resolveActivePhaseDynastyId(laneGroup, dynastiesById, labelAnchorAbs),
        ) ?? dynasty;
  const frozenLabel = resolveFrozenLaneLabel(
    dynasty,
    dynastiesById,
    labelAnchorAbs,
  );
  const laneColor = resolveDynastyColorValue(activePhaseDynasty, labelAnchorAbs);
  const { items, rowCount } = assignReignStacks(reigns);
  const height = dynastyLaneHeight(rowCount);
  const gaps = computeReignGaps(
    dynasty,
    gapCoverageReigns.length > 0 ? [...reigns, ...gapCoverageReigns] : reigns,
  );

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
          <AnimatePresence mode="wait" initial={false}>
            <motion.p
              key={frozenLabel}
              className={styles.name}
              initial={{ opacity: 0, y: 4 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -4 }}
              transition={{ duration: 0.14, ease: [0.2, 0.8, 0.2, 1] }}
            >
              {frozenLabel}
            </motion.p>
          </AnimatePresence>
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
          {items.map(({ reign }) => {
            const reignDynasty = dynastiesById.get(reign.dynastyId) ?? dynasty;
            return (
              <ReignCard
                key={reign.id}
                reign={reign}
                dynasty={reignDynasty as Dynasty}
                color={laneColor}
                reigns={reigns}
                personName={personNames.get(reign.personId)}
                orthodox={overlapsOrthodoxSpan(
                  reignDynasty,
                  reign.startAbs,
                  reign.endAbs,
                )}
              />
            );
          })}
        </div>
      </div>
    </motion.div>
  );
}
