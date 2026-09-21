import { formatAbsSpanTooltip, personPointKindLabel } from "@eralens/shared";
import { useSelection } from "../hooks/useSelection";
import { useViewport } from "../hooks/useViewport";
import { EVENT_MARKER_DOT_OFFSET } from "../model/eventLayout";
import { personDetailLevel } from "../model/lod";
import type { PlacedPerson } from "../model/personLayout";
import { selectionStore } from "../state/selectionStore";
import { HoverTooltip } from "./HoverTooltip";
import styles from "./PersonCard.module.css";

type Props = {
  placed: PlacedPerson;
};

export function PersonCard({ placed }: Props) {
  const viewport = useViewport();
  const selection = useSelection();
  const { person, top, startAbs, endAbs, mode, pointKind } = placed;
  const selected =
    selection.selected?.type === "person" &&
    selection.selected.id === person.id &&
    selection.focusReignId == null;
  const role = person.roles[0];
  const timeTooltip =
    mode === "point" && pointKind
      ? `${formatAbsSpanTooltip(startAbs, endAbs)}（${personPointKindLabel(pointKind)}）`
      : formatAbsSpanTooltip(startAbs, endAbs);

  if (mode === "point" && placed.anchorX !== undefined && pointKind) {
    const detail = personDetailLevel(viewport.lod, placed.width);
    const kindLabel = personPointKindLabel(pointKind);

    return (
      <HoverTooltip text={timeTooltip}>
        {(handlers) => (
          <button
            type="button"
            className={[
              styles.pointMarker,
              detail === "dot" ? styles.pointDot : "",
              selected ? styles.selected : "",
            ]
              .filter(Boolean)
              .join(" ")}
            style={{
              top,
              left: placed.anchorX,
              transform: `translateX(calc(-1 * ${EVENT_MARKER_DOT_OFFSET}px))`,
            }}
            onClick={() => {
              selectionStore.select({ type: "person", id: person.id }, startAbs);
              selectionStore.syncToUrl(viewport.centerAbs);
            }}
            aria-label={`${person.name}，${kindLabel}`}
            {...handlers}
          >
            <span className={styles.pointDotIcon} />
            {detail !== "dot" && (
              <>
                <span className={styles.name}>{person.name}</span>
                <span className={styles.pointKind}>{kindLabel}</span>
              </>
            )}
          </button>
        )}
      </HoverTooltip>
    );
  }

  const { left, width } = placed;
  const detail = personDetailLevel(viewport.lod, width);

  return (
    <HoverTooltip text={timeTooltip}>
      {(handlers) => (
        <button
          type="button"
          className={[
            styles.card,
            detail === "dot" ? styles.dot : "",
            detail === "compact" ? styles.compact : "",
            selected ? styles.selected : "",
          ]
            .filter(Boolean)
            .join(" ")}
          style={{ left, width, top }}
          onClick={() => {
            selectionStore.select({ type: "person", id: person.id }, startAbs);
            selectionStore.syncToUrl(viewport.centerAbs);
          }}
          aria-label={role ? `${person.name}，${role}` : person.name}
          {...handlers}
        >
          {detail !== "dot" && <span className={styles.name}>{person.name}</span>}
          {detail === "full" && role && <span className={styles.role}>{role}</span>}
        </button>
      )}
    </HoverTooltip>
  );
}
