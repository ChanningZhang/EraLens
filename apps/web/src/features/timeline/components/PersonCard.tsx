import { formatAbsSpanTooltip, personPointKindLabel } from "@eralens/shared";
import { useSelection } from "../hooks/useSelection";
import { useViewport } from "../hooks/useViewport";
import { EVENT_MARKER_DOT_OFFSET } from "../model/eventLayout";
import { personDetailLevel } from "../model/lod";
import type { PlacedPerson } from "../model/personLayout";
import { selectionStore } from "../state/selectionStore";
import { InfoPopover } from "./InfoPopover";
import styles from "./PersonCard.module.css";

type Props = {
  placed: PlacedPerson;
  lineVisible: boolean;
  onSelectLine: () => void;
};

export function PersonCard({ placed, lineVisible, onSelectLine }: Props) {
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
      <InfoPopover text={timeTooltip}>
        {(handlers) => (
          <button
            type="button"
            className={[
              styles.pointMarker,
              pointKind === "death" ? styles.pointDeath : "",
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
      </InfoPopover>
    );
  }

  const { left, width } = placed;
  const detail = personDetailLevel(viewport.lod, width);
  // A lifespan can begin before the visible window. Keep its small label at
  // the timeline edge in that case, rather than leaving an unexplained line.
  const labelLeft = Math.max(6, viewport.gutterPx + 2 - left);

  return (
    <InfoPopover text={timeTooltip}>
      {(handlers) => (
        <>
          <button
            type="button"
            className={[
              styles.card,
              styles.lifeLine,
              lineVisible ? styles.lineVisible : "",
              detail === "dot" ? styles.dot : "",
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
            {detail !== "dot" && (
              <span className={styles.label} style={{ left: labelLeft }}>
                <span className={styles.name}>{person.name}</span>
                {detail === "full" && role && (
                  <span className={styles.role}>{role}</span>
                )}
              </span>
            )}
          </button>
          {detail !== "dot" && (
            <button
              type="button"
              className={`${styles.personSelectDot} ${lineVisible ? styles.personSelectDotActive : ""}`}
              style={{ left: left + labelLeft + 6, top: top + 9 }}
              aria-label={`${lineVisible ? "取消显示" : "显示"}${person.name}的生平横线`}
              aria-pressed={lineVisible}
              onPointerDown={(event) => event.stopPropagation()}
              onClick={(event) => {
                event.stopPropagation();
                onSelectLine();
              }}
            />
          )}
        </>
      )}
    </InfoPopover>
  );
}
