import { resolveDynastyName } from "@eralens/shared";
import { formatReignSpanTooltip, systemReignLabel, type Dynasty, type Reign } from "@eralens/shared";
import { memo } from "react";
import { InfoPopover } from "./InfoPopover";
import styles from "./ReignGapCard.module.css";

const MIN_GAP_PX = 10;

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

  const label = systemReignLabel(gap);
  const showLabel = width >= [...label].length * 12 + 16;
  const timeTooltip = formatReignSpanTooltip(gap);
  const tooltipText = dynasty.note
    ? `${label}\n${timeTooltip}\n${dynasty.note}`
    : `${label}\n${timeTooltip}`;

  return (
    <div className={styles.unit} style={{ left, width, top: 0 }}>
      <InfoPopover text={tooltipText}>
        {(handlers) => (
          <div
            className={[
              styles.card,
            ]
              .filter(Boolean)
              .join(" ")}
            style={{ ["--card-color" as string]: color }}
            aria-label={`${resolveDynastyName(dynasty, gap.startAbs)} ${label}`}
            role="img"
            tabIndex={0}
            {...handlers}
          >
            {showLabel && <p className={styles.label}>{label}</p>}
          </div>
        )}
      </InfoPopover>
    </div>
  );
}

export const ReignGapCard = memo(ReignGapCardImpl);
