import {
  formatAbsSpanTooltip,
  type Reign,
  type ReignUncertaintyBoundary,
  uncertaintyBoundaryTooltip,
} from "@eralens/shared";
import { useViewport } from "../hooks/useViewport";
import { projectAbs } from "../model/coordinates";
import { STACK_ROW_HEIGHT } from "../model/reignClusters";
import { HoverTooltip } from "./HoverTooltip";
import styles from "./ReignUncertaintyGap.module.css";

const MIN_RENDER_PX = 4;
const JUNCTION_WIDTH_PX = 8;

type Props = {
  boundary: ReignUncertaintyBoundary;
  rulers: Reign[];
  color: string;
};

function WavyEdge({ side }: { side: "left" | "right" }) {
  return (
    <svg
      className={side === "left" ? styles.waveLeft : styles.waveRight}
      viewBox="0 0 6 48"
      preserveAspectRatio="none"
      aria-hidden
    >
      <path
        d="M3,0 C1,4 5,8 3,12 C1,16 5,20 3,24 C1,28 5,32 3,36 C1,40 5,44 3,48"
        fill="none"
        vectorEffect="non-scaling-stroke"
      />
    </svg>
  );
}

export function ReignUncertaintyGap({ boundary, rulers, color }: Props) {
  const viewport = useViewport();
  const isJunction = boundary.kind === "junction";
  const gapStart = boundary.startAbs;
  const gapEndExclusive = boundary.endAbs + 1;

  const naturalLeft = projectAbs(viewport, gapStart);
  const naturalWidth = Math.max(
    1,
    projectAbs(viewport, gapEndExclusive) - naturalLeft,
  );
  const width = isJunction ? JUNCTION_WIDTH_PX : naturalWidth;
  const left = isJunction
    ? projectAbs(viewport, boundary.startAbs) - width / 2
    : naturalLeft;

  if (!isJunction && naturalWidth < MIN_RENDER_PX) return null;

  const timeTooltip = formatAbsSpanTooltip(
    boundary.startAbs,
    boundary.endAbs,
    "year",
  );
  const tooltipText = `${uncertaintyBoundaryTooltip(boundary, rulers)}\n${timeTooltip}`;

  return (
    <div
      className={styles.unit}
      style={{
        left,
        width,
        top: boundary.stackIndex * STACK_ROW_HEIGHT,
        ["--gap-color" as string]: color,
      }}
    >
      <HoverTooltip text={tooltipText}>
        {(handlers) => (
          <div
            className={[styles.gap, isJunction ? styles.junction : ""]
              .filter(Boolean)
              .join(" ")}
            aria-label="年代失考"
            {...handlers}
          >
            <WavyEdge side="left" />
            <div className={styles.void} />
            <WavyEdge side="right" />
          </div>
        )}
      </HoverTooltip>
    </div>
  );
}
