import { formatAbsSpanTooltip, type Dynasty, type Reign } from "@eralens/shared";
import { memo } from "react";
import { HoverTooltip } from "./HoverTooltip";
import styles from "./ReignGapCard.module.css";

const MIN_GAP_PX = 10;
/** 3-char label at 12px + horizontal padding */
const LABEL_MIN_PX = 44;

type Props = {
  gap: Reign;
  dynasty: Dynasty;
  color: string;
  pxPerMonth: number;
};

function ReignGapCardImpl({ gap, dynasty, color, pxPerMonth }: Props) {
  const left = gap.startAbs * pxPerMonth;
  const endExclusive = gap.endAbs + 1;
  const width = Math.max(1, (endExclusive - gap.startAbs) * pxPerMonth);
  if (width < MIN_GAP_PX) return null;

  const showLabel = width >= LABEL_MIN_PX;
  const timeTooltip = formatAbsSpanTooltip(gap.startAbs, gap.endAbs, gap.precision);
  const tooltipText = dynasty.note
    ? `史料缺\n${timeTooltip}\n${dynasty.note}`
    : `史料缺\n${timeTooltip}`;

  return (
    <div className={styles.unit} style={{ left, width, top: 0 }}>
      <HoverTooltip text={tooltipText}>
        {(handlers) => (
          <div
            className={[
              styles.card,
            ]
              .filter(Boolean)
              .join(" ")}
            style={{ ["--card-color" as string]: color }}
            aria-label={`${dynasty.name} 史料缺`}
            {...handlers}
          >
            {showLabel && <p className={styles.label}>史料缺</p>}
          </div>
        )}
      </HoverTooltip>
    </div>
  );
}

export const ReignGapCard = memo(ReignGapCardImpl);
