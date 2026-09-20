import { useMemo } from "react";
import {
  type Dynasty,
  type DynastyLaneGroup,
  type Reign,
  buildPreQinClanContext,
  formatReignSpanTooltip,
  DATE_CONFIDENCE_LABEL,
  isUncertainDateConfidence,
  reignVisualBounds,
  isParallelClaim,
  PARALLEL_CLAIM_LABEL,
  resolveReignCardGivenName,
  resolveReignCardLabel,
  resolveReignCardMeta,
  resolveRocReignRegionLabel,
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
  resolveStackedCardUnit,
  STACK_ROW_HEIGHT,
} from "../model/reignClusters";
import { selectionStore } from "../state/selectionStore";
import { HoverTooltip } from "./HoverTooltip";
import { ReignWavyEdge } from "./ReignWavyEdge";
import styles from "./ReignCard.module.css";

/** Breathing room at interpolated seams so wavy junctions stay visible. */
const UNCERTAIN_SEAM_GAP_PX = 3;

type Props = {
  reign: Reign;
  dynasty: Dynasty;
  color: string;
  reigns: Reign[];
  personName?: string;
  personClan?: {
    ancestralXing?: string;
    clanShi?: string;
    posthumousNames?: string[];
    templeNames?: string[];
  };
  orthodox?: boolean;
  laneGroups?: readonly DynastyLaneGroup[];
};

export function ReignCard({
  reign,
  dynasty,
  color,
  reigns,
  personName: personNameFromTimeline,
  personClan,
  orthodox = false,
  laneGroups = [],
}: Props) {
  const viewport = useViewport();
  const selection = useSelection();
  const { startAbs, endExclusive, stackIndex } = resolveReignVisualSpan(
    reign,
    reigns,
    laneGroups,
  );
  const { items, rowCount } = assignReignStacks(reigns, laneGroups);
  const { unitTop, unitHeight } = resolveStackedCardUnit(reign, reigns, laneGroups);
  const compactStack = unitHeight < STACK_ROW_HEIGHT;
  const overlapsLowerRow = items.some((item) => {
    if (item.stackIndex <= stackIndex) return false;
    const span = resolveReignVisualSpan(item.reign, reigns, laneGroups);
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
  const uncertainStart = isUncertainDateConfidence(reign.startDateConfidence);
  const uncertainEnd = isUncertainDateConfidence(reign.endDateConfidence);
  const seamInsetLeft = uncertainStart ? UNCERTAIN_SEAM_GAP_PX : 0;
  const seamInsetRight = uncertainEnd ? UNCERTAIN_SEAM_GAP_PX : 0;
  const selected =
    (selection.selected?.type === "reign" && selection.selected.id === reign.id) ||
    (selection.selected?.type === "person" &&
      selection.selected.id === reign.personId &&
      selection.highlightAbs === reign.startAbs);

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
  const clan = buildPreQinClanContext(personClan, dynasty);
  const label = resolveReignCardLabel(reign, personName, {
    cardWidthPx: visualWidth,
    clan,
  });
  const barLayout = resolveReignBarLayout(visualWidth, [...label].length);
  const left = barLayout.centerOnAnchor
    ? projectAbs(viewport, anchor) - barLayout.unitWidthPx / 2
    : projectAbs(viewport, visual.start);
  const detail = barLayout.captionBelow ? "below" : barLayout.textLayout.level;
  const parallel = isParallelClaim(reign);
  const meta = resolveReignCardMeta(reign, personName, clan);
  const metaGlyphCount = meta ? [...meta.name].length : 0;
  const showMeta = shouldShowReignCardMeta(
    barLayout.barWidthPx,
    [...label].length,
    metaGlyphCount,
  );
  const givenName = resolveReignCardGivenName(reign, personName, clan);
  const regionLabel = resolveRocReignRegionLabel(reign, dynasty.name);
  const tooltipName =
    givenName && givenName !== label
      ? givenName
      : personName && personName !== label
        ? personName
        : label;
  const timeTooltip = formatReignSpanTooltip(reign);
  const dateConfidenceNote = [
    uncertainStart && reign.startDateConfidence
      ? `起年${DATE_CONFIDENCE_LABEL[reign.startDateConfidence]}`
      : null,
    uncertainEnd && reign.endDateConfidence
      ? `迄年${DATE_CONFIDENCE_LABEL[reign.endDateConfidence]}`
      : null,
  ]
    .filter(Boolean)
    .join("；");
  const claimTooltip = parallel
    ? `${PARALLEL_CLAIM_LABEL}${reign.claimLabel ? `・${reign.claimLabel}` : ""}`
    : undefined;
  const tooltipText = buildReignCardTooltip({
    detail,
    showMeta,
    meta,
    tooltipName,
    timeTooltip: dateConfidenceNote
      ? `${timeTooltip}\n${dateConfidenceNote}`
      : timeTooltip,
    claimTooltip,
  });

  const className = useMemo(() => {
    return [
      styles.card,
      barLayout.markerStyle ? styles.marker : "",
      detail === "wrap" ? styles.wrap : "",
      uncertainStart ? styles.uncertainStart : "",
      uncertainEnd ? styles.uncertainEnd : "",
      orthodox ? "orthodoxGold" : "",
      selected ? styles.selected : "",
      parallel ? styles.parallel : "",
      compactStack ? styles.compactStack : "",
    ]
      .filter(Boolean)
      .join(" ");
  }, [
    barLayout.markerStyle,
    detail,
    uncertainStart,
    uncertainEnd,
    orthodox,
    selected,
    parallel,
    compactStack,
  ]);

  return (
    <div
      className={styles.unit}
      style={{
        left,
        width: barLayout.unitWidthPx,
        top: unitTop,
        height: unitHeight,
      }}
    >
      <div
        className={styles.cardShell}
        style={{ ["--card-color" as string]: color }}
      >
        {uncertainStart && <ReignWavyEdge side="left" />}
        <HoverTooltip text={tooltipText}>
          {(handlers) => (
            <button
              type="button"
              className={className}
              style={{
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
                selectionStore.select({ type: "person", id: reign.personId }, reign.startAbs);
                selectionStore.syncToUrl(viewport.centerAbs);
              }}
              aria-label={
                claimTooltip
                  ? `${label} ${regionLabel} ${claimTooltip}`
                  : `${label} ${regionLabel}`
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
        {uncertainEnd && <ReignWavyEdge side="right" />}
      </div>
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
