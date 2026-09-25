import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { memo } from "react";
import {
  TIMELINE_RAIL_INSET_PX,
  TIMELINE_RAIL_LABEL_WIDTH_PX,
  getDynastyLaneGroup,
  isFrozenLaneMaster,
  resolveActivePhaseDynastyId,
  resolveDynastyColorValue,
  resolveFrozenLaneLabel,
  resolveReignColorValue,
  type ColorToken,
  type Dynasty,
  type DynastyLaneGroup,
  type Reign,
} from "@eralens/shared";
import { useSelection } from "../hooks/useSelection";
import { useViewport } from "../hooks/useViewport";
import { laneLabelAnchorAbs, worldPanOffsetX } from "../model/coordinates";
import type { PlacedDynasty } from "../model/laneLayout";
import {
  STACK_ROW_HEIGHT,
  type PreparedReignGeometry,
} from "../model/reignClusters";
import { selectionStore } from "../state/selectionStore";
import { ReignCard } from "./ReignCard";
import { ReignGapCard } from "./ReignGapCard";
import { EventLayer } from "./EventLayer";
import type { PlacedEvent } from "../model/eventLayout";
import styles from "./DynastyLane.module.css";

type Props = {
  dynasty: PlacedDynasty;
  laneColorToken: ColorToken;
  reigns: Reign[];
  visibleReigns: Reign[];
  visibleMissingReigns: Reign[];
  reignGeometry: ReadonlyMap<string, PreparedReignGeometry>;
  rowCount: number;
  barHeight: number;
  dynastiesById: Map<string, Dynasty>;
  personNames: Map<string, string>;
  personClans: Map<
    string,
    | {
        title?: string;
        ancestralXing?: string;
        clanShi?: string;
        posthumousNames?: string[];
        templeNames?: string[];
      }
    | undefined
  >;
  laneGroups: readonly DynastyLaneGroup[];
  top: number;
  height: number;
  badges: PlacedEvent[];
};

type LaneCardsProps = Pick<Props,
  "visibleReigns" | "visibleMissingReigns" | "reignGeometry" | "dynastiesById" |
  "personNames" | "personClans" | "laneColorToken"
> & { fallbackDynasty: Dynasty; laneColor: string; pxPerMonth: number };

const LaneCards = memo(function LaneCards({
  visibleReigns, visibleMissingReigns, reignGeometry, dynastiesById,
  personNames, personClans, laneColorToken, fallbackDynasty, laneColor, pxPerMonth,
}: LaneCardsProps) {
  return (
    <>
      {visibleMissingReigns.map((gap) => (
        <ReignGapCard
          key={gap.id}
          gap={gap}
          dynasty={dynastiesById.get(gap.dynastyId) ?? fallbackDynasty}
          color={laneColor}
          pxPerMonth={pxPerMonth}
        />
      ))}
      {visibleReigns.map((reign) => {
        const reignDynasty = dynastiesById.get(reign.dynastyId) ?? fallbackDynasty;
        const geometry = reignGeometry.get(reign.id);
        if (!geometry) return null;
        return (
          <ReignCard
            key={reign.id}
            reign={reign}
            dynasty={reignDynasty}
            color={resolveReignColorValue(reignDynasty, reign, laneColorToken)}
            geometry={geometry}
            pxPerMonth={pxPerMonth}
            personName={personNames.get(reign.personId)}
            personClan={personClans.get(reign.personId)}
            master={reign.isMain === true}
          />
        );
      })}
    </>
  );
}, (a, b) =>
  a.visibleReigns === b.visibleReigns &&
  a.visibleMissingReigns === b.visibleMissingReigns &&
  a.reignGeometry === b.reignGeometry &&
  a.dynastiesById === b.dynastiesById &&
  a.personNames === b.personNames &&
  a.personClans === b.personClans &&
  a.laneColorToken === b.laneColorToken &&
  a.laneColor === b.laneColor &&
  a.pxPerMonth === b.pxPerMonth &&
  a.fallbackDynasty.id === b.fallbackDynasty.id,
);

export function DynastyLane({
  dynasty,
  laneColorToken,
  reigns,
  visibleReigns,
  visibleMissingReigns,
  reignGeometry,
  rowCount,
  barHeight,
  dynastiesById,
  personNames,
  personClans,
  laneGroups,
  top,
  height,
  badges,
}: Props) {
  const viewport = useViewport();
  const reduceMotion = useReducedMotion();
  const selection = useSelection();
  const labelAnchorAbs = laneLabelAnchorAbs(viewport);
  const cardPanX = worldPanOffsetX(viewport);
  const laneGroup = getDynastyLaneGroup(dynasty.id, laneGroups);
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
    laneGroups,
  );
  const frozenMaster = isFrozenLaneMaster(activePhaseDynasty.id, labelAnchorAbs, reigns);
  const selected =
    selection.selected?.type === "dynasty" &&
    selection.selected.id === activePhaseDynasty.id;
  // Lane floor / gap cards stay on the persisted token. The frozen name
  // chip overlays gold when the center guide falls within a master reign.
  const laneColor = resolveDynastyColorValue(activePhaseDynasty, laneColorToken);
  return (
    <motion.div
      className={styles.lane}
      initial={reduceMotion ? false : { top: top + 10, height, opacity: 0 }}
      animate={{ top, height, opacity: 1 }}
      exit={{ opacity: 0, transition: { duration: reduceMotion ? 0 : 0.14 } }}
      transition={{ duration: reduceMotion ? 0 : 0.24, ease: [0.2, 0.8, 0.2, 1] }}
      style={{
        ["--dynasty-color" as string]: laneColor,
        ["--stack-row-height" as string]: `${STACK_ROW_HEIGHT}px`,
        ["--dynasty-bar-height" as string]: `${barHeight}px`,
        ["--timeline-rail-inset" as string]: `${TIMELINE_RAIL_INSET_PX}px`,
        ["--timeline-rail-label-width" as string]: `${TIMELINE_RAIL_LABEL_WIDTH_PX}px`,
      }}
    >
      <button
        type="button"
        className={[
          styles.frozenLabel,
          selected ? styles.selected : "",
          frozenMaster ? "masterGold" : "",
        ]
          .filter(Boolean)
          .join(" ")}
        style={rowCount > 1 ? { top: "50%", transform: "translateY(-50%)" } : undefined}
        onClick={() => {
          selectionStore.select(
            { type: "dynasty", id: activePhaseDynasty.id },
            activePhaseDynasty.startAbs,
          );
          selectionStore.syncToUrl(viewport.centerAbs);
        }}
        aria-label={frozenLabel}
        aria-pressed={selected}
      >
        <span className={styles.labelText}>
          <AnimatePresence mode="wait" initial={false}>
            <motion.span
              key={frozenLabel}
              className={styles.name}
              initial={{ opacity: 0, y: 4 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -4 }}
              transition={{ duration: 0.14, ease: [0.2, 0.8, 0.2, 1] }}
            >
              {frozenLabel}
            </motion.span>
          </AnimatePresence>
        </span>
      </button>

      <div className={styles.reignSequence}>
        <div className={styles.cards} style={{ transform: `translateX(${cardPanX}px)` }}>
          <LaneCards
            visibleReigns={visibleReigns}
            visibleMissingReigns={visibleMissingReigns}
            reignGeometry={reignGeometry}
            dynastiesById={dynastiesById}
            personNames={personNames}
            personClans={personClans}
            laneColorToken={laneColorToken}
            fallbackDynasty={dynasty}
            laneColor={laneColor}
            pxPerMonth={viewport.pxPerMonth}
          />
        </div>
      </div>
      <EventLayer placed={badges} height={height} laneBadges />
    </motion.div>
  );
}
