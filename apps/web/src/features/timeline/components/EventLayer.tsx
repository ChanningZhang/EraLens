import type { PlacedEvent } from "../model/eventLayout";
import { selectionStore } from "../state/selectionStore";
import { eventSpanAbs } from "@eralens/shared";
import styles from "./EventLayer.module.css";

type Props = {
  placed: PlacedEvent[];
  height: number;
};

export function EventLayer({ placed, height }: Props) {
  if (placed.length === 0) return null;

  return (
    <div className={styles.layer} style={{ height }}>
      {placed.map((item) => {
        const { event } = item;
        const { anchorAbs } = eventSpanAbs(event);

        return (
          <div key={event.id} className={styles.event} style={{ top: item.top }}>
            {item.showBand && (
              <button
                type="button"
                className={event.timeMode === "circa" ? styles.bandCirca : styles.bandSpan}
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
              aria-label={event.name}
            >
              <span className={styles.dot} />
              <span className={styles.label}>{event.name}</span>
            </button>
          </div>
        );
      })}
    </div>
  );
}
