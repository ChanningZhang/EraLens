import type { CSSProperties } from "react";
import { EVENT_MARKER_HEIGHT, type PlacedEvent } from "../model/eventLayout";
import { selectionStore } from "../state/selectionStore";
import { eventSpanAbs, formatEventTime } from "@eralens/shared";
import { isApproximateConfidence } from "@eralens/shared";
import styles from "./EventLayer.module.css";

const markerSizeStyle: CSSProperties & { "--event-marker-height": string } = {
  "--event-marker-height": `${EVENT_MARKER_HEIGHT}px`,
};

export function EventKindPreview({ kind, label }: { kind: string; label: string }) {
  return (
    <span className={`${styles.marker} ${styles.settingsSample}`} style={markerSizeStyle} data-event-kind={kind} aria-hidden="true">
      <span className={styles.dot} />
      <span className={styles.label}>{label}</span>
    </span>
  );
}

type Props = {
  placed: PlacedEvent[];
  height: number;
  laneBadges?: boolean;
};

export function EventLayer({ placed, height, laneBadges = false }: Props) {
  if (placed.length === 0) return null;

  return (
    <div className={`${styles.layer} ${laneBadges ? styles.badgeLayer : ""}`} style={{ ...markerSizeStyle, height }}>
      {placed.map((item) => {
        const { event } = item;
        const { anchorAbs } = eventSpanAbs(event);
        const approximate = isApproximateConfidence(event.atConfidence ?? event.at?.confidence) ||
          isApproximateConfidence(event.startConfidence ?? event.start?.confidence) || isApproximateConfidence(event.endConfidence ?? event.end?.confidence);

        return (
          <div key={event.id} className={styles.event} style={{ top: item.top }}>
            {item.showBand && (
              <button
                type="button"
                className={styles.bandSpan}
                style={{ left: item.bandLeft, width: item.bandWidth }}
                onClick={() => {
                  selectionStore.select({ type: "event", id: event.id }, anchorAbs);
                }}
                aria-hidden="true"
                tabIndex={-1}
              />
            )}
            <button
              type="button"
              className={styles.marker}
              data-event-kind={event.kind}
              style={{ left: item.anchorX }}
              onClick={() => {
                selectionStore.select({ type: "event", id: event.id }, anchorAbs);
              }}
              aria-label={`${event.name}，${formatEventTime(event)}`}
            >
              <span className={styles.dot} />
              <span className={styles.label}>{event.name}</span>
              {approximate && <span className={styles.approximateTag}>约</span>}
            </button>
          </div>
        );
      })}
    </div>
  );
}
