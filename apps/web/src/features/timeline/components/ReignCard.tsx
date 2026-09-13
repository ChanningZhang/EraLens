import { useMemo } from "react";
import {
  type Dynasty,
  type Reign,
  formatAbsSpanTooltip,
  resolveReignCardLabel,
  resolveReignCardMeta,
} from "@eralens/shared";
import { useQuery } from "@tanstack/react-query";
import { getRepository } from "@/data/repository";
import { useSelection } from "../hooks/useSelection";
import { useViewport } from "../hooks/useViewport";
import { projectAbs } from "../model/coordinates";
import { resolveReignCardTextLayout, shouldShowReignCardMeta } from "../model/lod";
import {
  assignReignStacks,
  resolveReignVisualSpan,
  STACK_ROW_HEIGHT,
} from "../model/reignClusters";
import { selectionStore } from "../state/selectionStore";
import { HoverTooltip } from "./HoverTooltip";
import styles from "./ReignCard.module.css";

type Props = {
  reign: Reign;
  dynasty: Dynasty;
  color: string;
  orthodox?: boolean;
  reigns: Reign[];
  personName?: string;
};

export function ReignCard({
  reign,
  dynasty,
  color,
  orthodox = false,
  reigns,
  personName: personNameFromTimeline,
}: Props) {
  const viewport = useViewport();
  const selection = useSelection();
  const { startAbs, endExclusive, stackIndex } = resolveReignVisualSpan(reign, reigns);
  const { rowCount } = assignReignStacks(reigns);
  const showCaptionBelow = stackIndex === rowCount - 1;
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
    enabled: !personNameFromTimeline,
    staleTime: 5 * 60_000,
  });

  const personName = personNameFromTimeline ?? personQuery.data;
  const label = resolveReignCardLabel(reign, personName, {
    cardWidthPx: width,
    dynastyId: dynasty.id,
  });
  const layout = resolveReignCardTextLayout(width, [...label].length);
  const detail = layout.level;
  const meta = resolveReignCardMeta(reign, personName);
  const metaGlyphCount = meta ? [...meta.name].length : 0;
  const showMeta = shouldShowReignCardMeta(
    width,
    [...label].length,
    metaGlyphCount,
  );
  const tooltipName = personName && personName !== label ? personName : label;
  const nameTooltip = meta ? `${tooltipName}　${meta.name}` : tooltipName;
  const timeTooltip = formatAbsSpanTooltip(reign.startAbs, reign.endAbs);
  const tooltipText = detail === "full" ? timeTooltip : `${nameTooltip}\n${timeTooltip}`;

  const className = useMemo(() => {
    return [
      styles.card,
      detail === "wrap" ? styles.wrap : "",
      orthodox ? styles.orthodox : "",
      selected ? styles.selected : "",
    ]
      .filter(Boolean)
      .join(" ");
  }, [detail, orthodox, selected]);

  return (
    <div
      className={styles.unit}
      style={{
        left,
        width,
        top: stackIndex * STACK_ROW_HEIGHT,
      }}
    >
      <HoverTooltip text={tooltipText}>
        {(handlers) => (
          <button
            type="button"
            className={className}
            style={{
              ["--card-color" as string]: color,
              ...(detail === "wrap"
                ? { ["--card-name-size" as string]: `${layout.nameFontPx}px` }
                : {}),
            }}
            onClick={() => {
              selectionStore.select({ type: "reign", id: reign.id }, reign.startAbs);
              selectionStore.syncToUrl(viewport.centerAbs);
            }}
            aria-label={`${label} ${dynasty.name}`}
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
      {detail === "below" && showCaptionBelow && (
        <span className={styles.caption}>{label}</span>
      )}
    </div>
  );
}
