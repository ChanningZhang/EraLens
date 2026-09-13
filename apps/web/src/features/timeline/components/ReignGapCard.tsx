import type { Dynasty } from "@eralens/shared";
import { formatAbsSpanTooltip } from "@eralens/shared";
import { useViewport } from "../hooks/useViewport";
import { projectAbs } from "../model/coordinates";
import { resolveLod } from "../model/lod";
import type { ReignGap } from "../model/reignClusters";
import { HoverTooltip } from "./HoverTooltip";
import styles from "./ReignGapCard.module.css";

const MIN_GAP_PX = 10;
const LABEL_MIN_PX = 56;

type Props = {
  gap: ReignGap;
  dynasty: Dynasty;
  color: string;
  orthodox?: boolean;
};

export function ReignGapCard({ gap, dynasty, color, orthodox = false }: Props) {
  const viewport = useViewport();
  const left = projectAbs(viewport, gap.startAbs);
  const width = Math.max(1, projectAbs(viewport, gap.endExclusive) - left);
  if (width < MIN_GAP_PX) return null;

  const lod = resolveLod(viewport.pxPerMonth);
  const showLabel = lod !== "millennium" && width >= LABEL_MIN_PX;
  const endAbs = gap.endExclusive - 1;
  const timeTooltip = formatAbsSpanTooltip(gap.startAbs, endAbs);
  const tooltipText = dynasty.note
    ? `国君记载缺\n${timeTooltip}\n${dynasty.note}`
    : `国君记载缺\n${timeTooltip}`;

  return (
    <div className={styles.unit} style={{ left, width, top: 0 }}>
      <HoverTooltip text={tooltipText}>
        {(handlers) => (
          <div
            className={[styles.card, orthodox ? styles.orthodox : ""].filter(Boolean).join(" ")}
            style={{ ["--card-color" as string]: color }}
            aria-label={`${dynasty.name} 国君记载缺`}
            {...handlers}
          >
            {showLabel && <p className={styles.label}>国君记载缺</p>}
          </div>
        )}
      </HoverTooltip>
    </div>
  );
}
