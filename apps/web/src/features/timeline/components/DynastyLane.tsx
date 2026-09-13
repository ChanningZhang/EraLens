import { AnimatePresence, motion } from "framer-motion";
import {
  getDynastyLaneGroup,
  isOrthodoxReign,
  overlapsOrthodoxSpan,
  resolveActivePhaseDynastyId,
  resolveConcurrencySpans,
  resolveDynastyColorValue,
  resolveFrozenLabelAnchorAbs,
  resolveFrozenLaneLabel,
  type Dynasty,
  type Reign,
} from "@eralens/shared";
import { useViewport } from "../hooks/useViewport";
import { projectAbs } from "../model/coordinates";
import type { PlacedDynasty } from "../model/laneLayout";
import {
  assignReignStacks,
  dynastyLaneHeight,
  STACK_ROW_HEIGHT,
} from "../model/reignClusters";
import { ReignCard } from "./ReignCard";
import { ReignGapCard } from "./ReignGapCard";
import styles from "./DynastyLane.module.css";

type Props = {
  dynasty: PlacedDynasty;
  reigns: Reign[];
  missingReigns: Reign[];
  dynastiesById: Map<string, Dynasty>;
  personNames: Map<string, string>;
  top: number;
};

export function DynastyLane({
  dynasty,
  reigns,
  missingReigns,
  dynastiesById,
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
  const concurrencySpans = resolveConcurrencySpans(reigns);

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
        <div className={styles.concurrencyBands} aria-hidden>
          {concurrencySpans.map((span) => {
            const left = projectAbs(viewport, span.startAbs);
            const width = Math.max(
              1,
              projectAbs(viewport, span.endAbs + 1) - left,
            );
            return (
              <div
                key={`${span.startAbs}-${span.endAbs}-${span.trackCount}`}
                className={styles.concurrencyBand}
                style={{ left, width }}
                title={`${span.trackCount} 路并立`}
              />
            );
          })}
        </div>
        <div className={styles.cards}>
          {missingReigns.map((gap) => (
            <ReignGapCard
              key={gap.id}
              gap={gap}
              dynasty={dynasty as Dynasty}
              color={laneColor}
              orthodox={overlapsOrthodoxSpan(
                dynasty,
                gap.startAbs,
                gap.endAbs,
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
                orthodox={isOrthodoxReign(reignDynasty, reign)}
              />
            );
          })}
        </div>
      </div>
    </motion.div>
  );
}
