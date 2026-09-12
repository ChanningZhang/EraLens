import { useMemo, useState } from "react";
import {
  type Dynasty,
  type Reign,
  resolveReignCardMeta,
  resolveReignPrimaryLabel,
} from "@eralens/shared";
import { useQuery } from "@tanstack/react-query";
import { getRepository } from "@/data/repository";
import { useSelection } from "../hooks/useSelection";
import { useViewport } from "../hooks/useViewport";
import { projectAbs } from "../model/coordinates";
import { cardDetailLevel } from "../model/lod";
import { resolveReignVisualSpan, STACK_ROW_HEIGHT } from "../model/reignClusters";
import { selectionStore } from "../state/selectionStore";
import styles from "./ReignCard.module.css";

type Props = {
  reign: Reign;
  dynasty: Dynasty;
  color: string;
  reigns: Reign[];
};

export function ReignCard({
  reign,
  dynasty,
  color,
  reigns,
}: Props) {
  const viewport = useViewport();
  const selection = useSelection();
  const [tooltipPos, setTooltipPos] = useState<{ x: number; y: number } | null>(null);
  const { startAbs, endExclusive, stackIndex } = resolveReignVisualSpan(reign, reigns);
  const left = projectAbs(viewport, startAbs);
  const width = Math.max(1, projectAbs(viewport, endExclusive) - left);
  const selected =
    selection.selected?.type === "reign" && selection.selected.id === reign.id;

  const personQuery = useQuery({
    queryKey: ["person", reign.personId],
    queryFn: async () => {
      const repo = await getRepository();
      const detailEntity = await repo.getEntity({ type: "person", id: reign.personId });
      return detailEntity.title;
    },
    staleTime: Infinity,
  });

  const personName = personQuery.data;
  const label = resolveReignPrimaryLabel(reign, personName);
  const detail = cardDetailLevel(width, [...label].length);
  const meta = resolveReignCardMeta(reign, personName);
  const tooltipText = meta ? `${label}　${meta.label}：${meta.name}` : label;

  const className = useMemo(() => {
    return [
      styles.card,
      detail === "wrap" ? styles.wrap : "",
      detail === "below" ? styles.below : "",
      selected ? styles.selected : "",
    ]
      .filter(Boolean)
      .join(" ");
  }, [detail, selected]);

  return (
    <div
      className={styles.unit}
      style={{
        left,
        width,
        top: stackIndex * STACK_ROW_HEIGHT,
      }}
    >
      <button
        type="button"
        className={className}
        style={{ ["--card-color" as string]: color }}
        onClick={() => {
          selectionStore.select({ type: "reign", id: reign.id }, reign.startAbs);
          selectionStore.syncToUrl(viewport.centerAbs);
        }}
        onMouseEnter={(e) => {
          if (detail === "full") return;
          setTooltipPos({ x: e.clientX, y: e.clientY - 12 });
        }}
        onMouseLeave={() => setTooltipPos(null)}
        aria-label={`${label} ${dynasty.name}`}
      >
        {detail !== "below" && <p className={styles.name}>{label}</p>}
        {detail === "full" && meta && (
          <p className={styles.meta}>
            <span className={styles.metaKind}>{meta.label}</span>
            {meta.name}
          </p>
        )}
      </button>
      {detail === "below" && <span className={styles.caption}>{label}</span>}
      {tooltipPos && detail !== "full" && (
        <div
          className={styles.tooltip}
          style={{ left: tooltipPos.x + 12, top: tooltipPos.y }}
        >
          {tooltipText}
        </div>
      )}
    </div>
  );
}
