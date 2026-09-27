import { formatEventTime, type Event } from "@eralens/shared";
import { useMemo } from "react";
import { InfoPopover } from "./InfoPopover";
import { useSelection } from "../hooks/useSelection";
import { projectGcj02InLayout, wgs84ToGcj02, type ChinaMapLayout } from "../model/chinaMapProjection";
import { selectionStore } from "../state/selectionStore";
import styles from "./EventMapLayer.module.css";

type Props = {
  events: readonly Event[];
  atAbs: number;
  layout: ChinaMapLayout | null;
  scale: number;
  offset: { x: number; y: number };
};

export function EventMapLayer({ events, atAbs, layout, scale, offset }: Props) {
  const selection = useSelection();

  const placed = useMemo(() => {
    if (!layout) return [];
    return events.flatMap((event) => {
      const locations = event.locations.length > 0 ? event.locations : event.location ? [event.location] : [];
      return locations.map((location, index) => {
        const point = location.coordinateSystem === "GCJ02"
          ? { x: location.longitude, y: location.latitude }
          : wgs84ToGcj02(location.longitude, location.latitude);
        const projected = projectGcj02InLayout(point.x, point.y, layout);
        return { event, location, key: `${event.id}:${location.id}:${index}`, x: projected.x, y: projected.y };
      });
    });
  }, [events, layout]);

  return (
    <div className={styles.layer} aria-hidden={placed.length === 0}>
      {placed.map(({ event, location, key, x, y }) => {
        const isSelected = selection.selected?.type === "event" && selection.selected.id === event.id;
        const tooltip = `${event.name} · ${formatEventTime(event)} · ${location.historicalName}（${location.modernName}）`;
        return (
          <InfoPopover key={key} text={tooltip}>
            {(handlers) => (
              <button
                type="button"
                className={isSelected ? `${styles.marker} ${styles.selected}` : styles.marker}
                style={{
                  left: `${offset.x + x * scale}px`,
                  top: `${offset.y + y * scale}px`,
                }}
                aria-label={`${event.name}，${formatEventTime(event)}，地点：${location.historicalName}（${location.modernName}）`}
                aria-pressed={isSelected}
                onClick={() => selectionStore.select({ type: "event", id: event.id }, atAbs)}
                {...handlers}
              >
                <span className={styles.dot} aria-hidden="true" />
                <span className={styles.label}>{event.name}</span>
              </button>
            )}
          </InfoPopover>
        );
      })}
    </div>
  );
}
