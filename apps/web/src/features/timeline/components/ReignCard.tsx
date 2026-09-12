import { useMemo, useState } from "react";
import type { Dynasty, Reign } from "@eralens/shared";
import { useQueries } from "@tanstack/react-query";
import { getRepository } from "@/data/repository";
import { useSelection } from "../hooks/useSelection";
import { useViewport } from "../hooks/useViewport";
import { projectAbs } from "../model/coordinates";
import {
  APPELLATION_LABELS,
  resolveEmperorAppellation,
} from "../model/emperorAppellation";
import { cardDetailLevel } from "../model/lod";
import { reignCardSpan } from "../model/reignClusters";
import { selectionStore } from "../state/selectionStore";
import styles from "./ReignCard.module.css";

type Props = {
  reigns: Reign[];
  dynasty: Dynasty;
  color: string;
  nextReignStartAbs?: number;
};

export function ReignCard({
  reigns,
  dynasty,
  color,
  nextReignStartAbs,
}: Props) {
  const viewport = useViewport();
  const selection = useSelection();
  const [tooltipPos, setTooltipPos] = useState<{ x: number; y: number } | null>(null);
  const primary = reigns[0]!;

  const startAbs = Math.min(...reigns.map((item) => item.startAbs));
  const endAbs = Math.max(...reigns.map((item) => item.endAbs));
  const { endExclusive } = reignCardSpan(startAbs, endAbs, nextReignStartAbs);
  const left = projectAbs(viewport, startAbs);
  const width = Math.max(1, projectAbs(viewport, endExclusive) - left);
  const clustered = reigns.length > 1;
  const selected = reigns.some(
    (item) => selection.selected?.type === "reign" && selection.selected.id === item.id,
  );

  const personQueries = useQueries({
    queries: reigns.map((item) => ({
      queryKey: ["person", item.personId],
      queryFn: async () => {
        const repo = await getRepository();
        const detailEntity = await repo.getEntity({ type: "person", id: item.personId });
        return detailEntity.title;
      },
      staleTime: Infinity,
    })),
  });

  const labels = reigns.map((item, index) => personQueries[index]?.data ?? item.title);
  const joinedLabel = labels.join(" · ");
  const detail = clustered
    ? cardDetailLevel(width, [...joinedLabel].length) === "below"
      ? "below"
      : "wrap"
    : cardDetailLevel(width, [...labels[0]!].length);
  const appellation = clustered ? null : resolveEmperorAppellation(primary);
  const appellationLabel = appellation
    ? APPELLATION_LABELS[appellation.kind]
    : null;
  const tooltipText = clustered
    ? joinedLabel
    : appellation
      ? `${labels[0]}　${appellationLabel}：${appellation.name}`
      : labels[0]!;

  const className = useMemo(() => {
    return [
      styles.card,
      detail === "wrap" ? styles.wrap : "",
      detail === "below" ? styles.below : "",
      clustered && detail === "below" ? styles.belowCluster : "",
      selected ? styles.selected : "",
    ]
      .filter(Boolean)
      .join(" ");
  }, [clustered, detail, selected]);

  function selectReign(reign: Reign) {
    selectionStore.select({ type: "reign", id: reign.id }, reign.startAbs);
    selectionStore.syncToUrl(viewport.centerAbs);
  }

  return (
    <>
      <button
        type="button"
        className={className}
        style={{
          left,
          width,
          ["--card-color" as string]: color,
        }}
        onClick={() => selectReign(primary)}
        onMouseEnter={(e) => {
          if (detail === "full") return;
          setTooltipPos({ x: e.clientX, y: e.clientY - 12 });
        }}
        onMouseLeave={() => setTooltipPos(null)}
        aria-label={`${joinedLabel} ${dynasty.name}`}
      >
        {detail !== "below" && <p className={styles.name}>{joinedLabel}</p>}
        {detail === "full" && appellation && (
          <p className={styles.meta}>
            <span className={styles.metaKind}>{appellationLabel}</span>
            {appellation.name}
          </p>
        )}
      </button>
      {detail === "below" && (
        <div className={styles.captions} style={{ left }}>
          {reigns.map((item, index) => (
            <button
              key={item.id}
              type="button"
              className={styles.caption}
              onClick={() => selectReign(item)}
            >
              {labels[index]}
            </button>
          ))}
        </div>
      )}
      {tooltipPos && detail !== "full" && (
        <div
          className={styles.tooltip}
          style={{ left: tooltipPos.x + 12, top: tooltipPos.y }}
        >
          {tooltipText}
        </div>
      )}
    </>
  );
}
