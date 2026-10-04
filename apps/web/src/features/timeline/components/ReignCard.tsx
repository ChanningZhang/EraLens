import { resolveDynastyDefaultName } from "@eralens/shared";
import { memo, useMemo } from "react";
import {
  type Dynasty,
  type Reign,
  buildPreQinClanContext,
  formatReignSpanTooltip,
  isInterpolatedConfidence,
  isParallelClaim,
  PARALLEL_CLAIM_LABEL,
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
  CAPTION_ROW_SPACING_PX,
  type PreparedReignGeometry,
} from "../model/reignClusters";
import { selectionStore } from "../state/selectionStore";
import { viewportStore } from "../state/viewportStore";
import { InfoPopover } from "./InfoPopover";
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
  rowHeight: number;
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
  rowHeight,
}: Props) {
  const selection = useSelection();
  const { unitTop, unitHeight, stackIndex, rowCount, overlapsLowerRow } = geometry;
  const compactStack = unitHeight < rowHeight;
  const captionPlacement = resolveReignCaptionPlacement({
    stackIndex,
    rowCount,
    overlapsLowerRow,
  });
  const durationMonths = geometry.visualEndExclusive - geometry.visualStart;
  const visualWidth = Math.max(0, durationMonths * pxPerMonth);
  const anchor = (geometry.visualStart + geometry.visualEndExclusive) / 2;
  const startConfidence = reign.start.confidence ?? "year";
  const endConfidence = reign.end.confidence ?? "year";
  const interpolatedStart = isInterpolatedConfidence(startConfidence);
  const interpolatedEnd = isInterpolatedConfidence(endConfidence);
  const seamInsetLeft = interpolatedStart ? UNCERTAIN_SEAM_GAP_PX : 0;
  const seamInsetRight = interpolatedEnd ? UNCERTAIN_SEAM_GAP_PX : 0;
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
    const barLayout = resolveReignBarLayout(visualWidth, labelLength, unitHeight);
    const detail = barLayout.captionBelow ? "below" : barLayout.textLayout.level;
    const parallel = isParallelClaim(reign);
    const meta = resolveReignCardMeta(reign, personName, clan);
    const showMeta = shouldShowReignCardMeta(barLayout.barWidthPx, labelLength, meta ? [...meta.name].length : 0, unitHeight);
    const regionLabel = resolveRocReignRegionLabel(reign, resolveDynastyDefaultName(dynasty));
    const timeTooltip = formatReignSpanTooltip(reign);
    const claimTooltip = parallel
      ? `${PARALLEL_CLAIM_LABEL}${reign.claimLabel ? `・${reign.claimLabel}` : ""}`
      : undefined;
    const tooltipText = buildReignCardTooltip({
      showMeta: showMeta && detail !== "below", meta,
      timeTooltip,
      claimTooltip,
    });
    return { label, barLayout, detail, parallel, meta, showMeta, regionLabel, claimTooltip, tooltipText };
  }, [reign, personName, personClan, dynasty.name, visualWidth, startConfidence, endConfidence, unitHeight]);
  const left = barLayout.centerOnAnchor
    ? anchor * pxPerMonth - barLayout.unitWidthPx / 2
    : geometry.visualStart * pxPerMonth;
  const selectReign = () => {
    selectionStore.select(
      { type: "person", id: reign.personId },
      reign.startAbs,
      { focusReignId: reign.id },
    );
    selectionStore.syncToUrl(viewportStore.getSnapshot().centerAbs);
  };

  const className = useMemo(() => {
    return [
      styles.card,
      barLayout.markerStyle ? styles.marker : "",
      detail === "wrap" ? styles.wrap : "",
      interpolatedStart ? styles.uncertainStart : "",
      interpolatedEnd ? styles.uncertainEnd : "",
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
    interpolatedStart,
    interpolatedEnd,
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
        data-map-pan-exclude
        style={{ ["--card-color" as string]: color }}
        onClick={selectReign}
      >
        {interpolatedStart && <ReignWavyEdge side="left" />}
        <InfoPopover text={tooltipText}>
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
                ["--card-name-size" as string]: `${barLayout.textLayout.nameFontPx}px`,
                ["--card-meta-size" as string]: `${barLayout.textLayout.metaFontPx}px`,
              }}
              onClick={(event) => {
                event.stopPropagation();
                selectReign();
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
        </InfoPopover>
        {interpolatedEnd && <ReignWavyEdge side="right" />}
      </div>
      {detail === "below" && (
        <button
          type="button"
          className={
            captionPlacement === "above" ? styles.captionAbove : styles.caption
          }
          style={{
            ["--caption-offset-px" as string]: `${geometry.captionRow * CAPTION_ROW_SPACING_PX}px`,
          }}
          onClick={selectReign}
          aria-label={`${label} 在位详情`}
        >
          {label}
        </button>
      )}
    </div>
  );
}

export const ReignCard = memo(ReignCardImpl);
