import { memo, useMemo } from "react";
import {
  type Dynasty,
  type Reign,
  buildPreQinClanContext,
  formatReignSpanTooltip,
  DATE_CONFIDENCE_LABEL,
  isUncertainDateConfidence,
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
import {
  buildReignCardTooltip,
  resolveReignBarLayout,
  resolveReignCaptionPlacement,
  shouldShowReignCardMeta,
} from "../model/lod";
import {
  STACK_ROW_HEIGHT,
  type PreparedReignGeometry,
} from "../model/reignClusters";
import { selectionStore } from "../state/selectionStore";
import { viewportStore } from "../state/viewportStore";
import { HoverTooltip } from "./HoverTooltip";
import { ReignWavyEdge } from "./ReignWavyEdge";
import styles from "./ReignCard.module.css";

/** Breathing room at interpolated seams so wavy junctions stay visible. */
const UNCERTAIN_SEAM_GAP_PX = 3;

type Props = {
  reign: Reign;
  dynasty: Dynasty;
  color: string;
  personName?: string;
  personClan?: {
    title?: string;
    ancestralXing?: string;
    clanShi?: string;
    posthumousNames?: string[];
    templeNames?: string[];
  };
  master?: boolean;
  geometry: PreparedReignGeometry;
  pxPerMonth: number;
};

function ReignCardImpl({
  reign,
  dynasty,
  color,
  personName: personNameFromTimeline,
  personClan,
  master = false,
  geometry,
  pxPerMonth,
}: Props) {
  const selection = useSelection();
  const { unitTop, unitHeight, stackIndex, rowCount, overlapsLowerRow } = geometry;
  const compactStack = unitHeight < STACK_ROW_HEIGHT;
  const captionPlacement = resolveReignCaptionPlacement({
    stackIndex,
    rowCount,
    overlapsLowerRow,
  });
  const durationMonths = geometry.visualEndExclusive - geometry.visualStart;
  const visualWidth = Math.max(0, durationMonths * pxPerMonth);
  const anchor = (geometry.visualStart + geometry.visualEndExclusive) / 2;
  const uncertainStart = isUncertainDateConfidence(reign.startDateConfidence);
  const uncertainEnd = isUncertainDateConfidence(reign.endDateConfidence);
  const seamInsetLeft = uncertainStart ? UNCERTAIN_SEAM_GAP_PX : 0;
  const seamInsetRight = uncertainEnd ? UNCERTAIN_SEAM_GAP_PX : 0;
  const selected =
    (selection.selected?.type === "person" &&
      selection.selected.id === reign.personId &&
      selection.focusReignId === reign.id) ||
    (selection.selected?.type === "reign" && selection.selected.id === reign.id);

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
  const { label, barLayout, detail, parallel, meta, showMeta, regionLabel, claimTooltip, tooltipText } = useMemo(() => {
    const clan = buildPreQinClanContext(personClan);
    const label = resolveReignCardLabel(reign, personName, { cardWidthPx: visualWidth, clan });
    const labelLength = [...label].length;
    const barLayout = resolveReignBarLayout(visualWidth, labelLength);
    const detail = barLayout.captionBelow ? "below" : barLayout.textLayout.level;
    const parallel = isParallelClaim(reign);
    const meta = resolveReignCardMeta(reign, personName, clan);
    const showMeta = shouldShowReignCardMeta(barLayout.barWidthPx, labelLength, meta ? [...meta.name].length : 0);
    const givenName = resolveReignCardGivenName(reign, personName, clan);
    const regionLabel = resolveRocReignRegionLabel(reign, dynasty.name);
    const tooltipName = givenName && givenName !== label
      ? givenName
      : personName && personName !== label ? personName : label;
    const timeTooltip = formatReignSpanTooltip(reign);
    const dateConfidenceNote = [
      uncertainStart && reign.startDateConfidence ? `起年${DATE_CONFIDENCE_LABEL[reign.startDateConfidence]}` : null,
      uncertainEnd && reign.endDateConfidence ? `迄年${DATE_CONFIDENCE_LABEL[reign.endDateConfidence]}` : null,
    ].filter(Boolean).join("；");
    const claimTooltip = parallel
      ? `${PARALLEL_CLAIM_LABEL}${reign.claimLabel ? `・${reign.claimLabel}` : ""}`
      : undefined;
    const tooltipText = buildReignCardTooltip({
      detail, showMeta, meta, tooltipName,
      timeTooltip: dateConfidenceNote ? `${timeTooltip}\n${dateConfidenceNote}` : timeTooltip,
      claimTooltip,
    });
    return { label, barLayout, detail, parallel, meta, showMeta, regionLabel, claimTooltip, tooltipText };
  }, [reign, personName, personClan, dynasty.name, visualWidth, uncertainStart, uncertainEnd]);
  const left = barLayout.centerOnAnchor
    ? anchor * pxPerMonth - barLayout.unitWidthPx / 2
    : geometry.visualStart * pxPerMonth;

  const className = useMemo(() => {
    return [
      styles.card,
      barLayout.markerStyle ? styles.marker : "",
      detail === "wrap" ? styles.wrap : "",
      uncertainStart ? styles.uncertainStart : "",
      uncertainEnd ? styles.uncertainEnd : "",
      master ? "masterGold" : "",
      selected ? styles.selected : "",
      parallel ? styles.parallel : "",
      compactStack ? styles.compactStack : "",
      reign.isInformalMonarch ? styles.informalMonarch : "",
    ]
      .filter(Boolean)
      .join(" ");
  }, [
    barLayout.markerStyle,
    detail,
    uncertainStart,
    uncertainEnd,
    master,
    selected,
    parallel,
    compactStack,
    reign.isInformalMonarch,
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
                selectionStore.select(
                  { type: "person", id: reign.personId },
                  reign.startAbs,
                  { focusReignId: reign.id },
                );
                selectionStore.syncToUrl(viewportStore.getSnapshot().centerAbs);
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

export const ReignCard = memo(ReignCardImpl);
