import { useMemo } from "react";
import {
  type Dynasty,
  type Reign,
  formatReignSpanTooltip,
  claimTrackOf,
  isUncertainDateConfidence,
  isUncertainReignSeam,
  reignVisualBounds,
  isParallelClaim,
  PARALLEL_CLAIM_LABEL,
  resolveReignCardLabel,
  resolveReignCardMeta,
} from "@eralens/shared";
import { useQuery } from "@tanstack/react-query";
import { getRepository } from "@/data/repository";
import { useSelection } from "../hooks/useSelection";
import { useViewport } from "../hooks/useViewport";
import { projectAbs } from "../model/coordinates";
import {
  buildReignCardTooltip,
  resolveReignBarLayout,
  resolveReignCaptionPlacement,
  shouldShowReignCardMeta,
} from "../model/lod";
import {
  assignReignStacks,
  resolveReignVisualSpan,
  STACK_ROW_HEIGHT,
  stackRowOffset,
} from "../model/reignClusters";
import { selectionStore } from "../state/selectionStore";
import { HoverTooltip } from "./HoverTooltip";
import styles from "./ReignCard.module.css";

/** Breathing room at interpolated seams so wavy junctions stay visible. */
const UNCERTAIN_SEAM_GAP_PX = 3;

type Props = {
  reign: Reign;
  dynasty: Dynasty;
  color: string;
  reigns: Reign[];
  personName?: string;
  orthodox?: boolean;
};

export function ReignCard({
  reign,
  dynasty,
  color,
  reigns,
  personName: personNameFromTimeline,
  orthodox = false,
}: Props) {
  const viewport = useViewport();
  const selection = useSelection();
  const { startAbs, endExclusive, stackIndex } = resolveReignVisualSpan(reign, reigns);
  const { items, rowCount, rowHeights } = assignReignStacks(reigns);
  const overlapsLowerRow = items.some((item) => {
    if (item.stackIndex <= stackIndex) return false;
    const span = resolveReignVisualSpan(item.reign, reigns);
    return span.startAbs < endExclusive && span.endExclusive > startAbs;
  });
  const captionPlacement = resolveReignCaptionPlacement({
    stackIndex,
    rowCount,
    overlapsLowerRow,
  });
  const visual = reignVisualBounds(reign, startAbs, endExclusive);
  const durationMonths = visual.endExclusive - visual.start;
  const visualWidth = Math.max(0, durationMonths * viewport.pxPerMonth);
  const anchor = (visual.start + visual.endExclusive) / 2;
  const trackPeers = reigns
    .filter((item) => claimTrackOf(item) === claimTrackOf(reign))
    .sort((a, b) => a.startAbs - b.startAbs || a.id.localeCompare(b.id));
  const reignIndex = trackPeers.findIndex((item) => item.id === reign.id);
  const prevReign = reignIndex > 0 ? trackPeers[reignIndex - 1] : undefined;
  const nextReign =
    reignIndex >= 0 && reignIndex < trackPeers.length - 1
      ? trackPeers[reignIndex + 1]
      : undefined;
  const seamInsetLeft =
    prevReign && isUncertainReignSeam(prevReign, reign)
      ? UNCERTAIN_SEAM_GAP_PX
      : 0;
  const seamInsetRight =
    nextReign && isUncertainReignSeam(reign, nextReign)
      ? UNCERTAIN_SEAM_GAP_PX
      : 0;
  const selected =
    selection.selected?.type === "reign" && selection.selected.id === reign.id;

  const personQuery = useQuery({
    queryKey: ["person", reign.personId],
    queryFn: async () => {
      const repo = await getRepository();
      const detailEntity = await repo.getEntity({ type: "person", id: reign.personId });
      return detailEntity.title;
    },
    enabled: !personNameFromTimeline,
    staleTime: 5 * 60_000,
  });

  const personName = personNameFromTimeline ?? personQuery.data;
  const label = resolveReignCardLabel(reign, personName, {
    cardWidthPx: visualWidth,
    dynastyId: dynasty.id,
  });
  const barLayout = resolveReignBarLayout(visualWidth, [...label].length);
  const left = barLayout.centerOnAnchor
    ? projectAbs(viewport, anchor) - barLayout.unitWidthPx / 2
    : projectAbs(viewport, visual.start);
  const detail = barLayout.captionBelow ? "below" : barLayout.textLayout.level;
  const parallel = isParallelClaim(reign);
  // For concurrent claimants the seat (长安 / 洛阳) tells them apart far better
  // than the appellation kind, so it takes over the subtitle slot.
  const meta =
    parallel && reign.claimLabel
      ? { label: "据点", name: reign.claimLabel }
      : resolveReignCardMeta(reign, personName);
  const metaGlyphCount = meta ? [...meta.name].length : 0;
  const showMeta = shouldShowReignCardMeta(
    barLayout.barWidthPx,
    [...label].length,
    metaGlyphCount,
  );
  const tooltipName = personName && personName !== label ? personName : label;
  const timeTooltip = formatReignSpanTooltip(reign);
  const claimTooltip = parallel
    ? `${PARALLEL_CLAIM_LABEL}${reign.claimLabel ? `・${reign.claimLabel}` : ""}`
    : undefined;
  const tooltipText = buildReignCardTooltip({
    detail,
    showMeta,
    meta,
    tooltipName,
    timeTooltip,
    claimTooltip,
  });

  const className = useMemo(() => {
    return [
      styles.card,
      barLayout.markerStyle ? styles.marker : "",
      detail === "wrap" ? styles.wrap : "",
      orthodox ? "orthodoxGold" : "",
      selected ? styles.selected : "",
      parallel ? styles.parallel : "",
    ]
      .filter(Boolean)
      .join(" ");
  }, [barLayout.markerStyle, detail, orthodox, selected, parallel]);

  return (
    <div
      className={styles.unit}
      style={{
        left,
        width: barLayout.unitWidthPx,
        top: stackRowOffset(rowHeights, stackIndex),
        height: rowHeights[stackIndex] ?? STACK_ROW_HEIGHT,
      }}
    >
      <HoverTooltip text={tooltipText}>
        {(handlers) => (
          <button
            type="button"
            className={className}
            style={{
              ["--card-color" as string]: color,
              ...(barLayout.markerStyle
                ? {
                    left: barLayout.barInsetPx,
                    width: barLayout.barWidthPx,
                    right: "auto",
                  }
                : {
                    left: seamInsetLeft,
                    right: seamInsetRight,
                  }),
              ...(detail === "wrap"
                ? {
                    ["--card-name-size" as string]: `${barLayout.textLayout.nameFontPx}px`,
                  }
                : {}),
            }}
            onClick={() => {
              selectionStore.select({ type: "reign", id: reign.id }, reign.startAbs);
              selectionStore.syncToUrl(viewport.centerAbs);
            }}
            aria-label={
              claimTooltip
                ? `${label} ${dynasty.name} ${claimTooltip}`
                : `${label} ${dynasty.name}`
            }
            {...handlers}
          >
            {detail !== "below" && (
              <div className={styles.content}>
                <p className={styles.name}>{label}</p>
                {showMeta && meta && <p className={styles.meta}>{meta.name}</p>}
              </div>
            )}
          </button>
        )}
      </HoverTooltip>
      {detail === "below" && (
        <span
          className={
            captionPlacement === "above" ? styles.captionAbove : styles.caption
          }
        >
          {label}
        </span>
      )}
    </div>
  );
}
