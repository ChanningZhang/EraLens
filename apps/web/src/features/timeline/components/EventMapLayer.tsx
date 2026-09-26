import { formatEventTime, type Event } from "@eralens/shared";
import { useEffect, useMemo, useRef, useState } from "react";
import { HoverTooltip } from "./HoverTooltip";
import { useSelection } from "../hooks/useSelection";
import { projectGcj02, resolveChinaMapInsets, wgs84ToGcj02 } from "../model/chinaMapProjection";
import { selectionStore } from "../state/selectionStore";
import styles from "./EventMapLayer.module.css";

type Props = {
  events: readonly Event[];
  atAbs: number;
  gutterPx: number;
  scale: number;
  offset: { x: number; y: number };
};

export function EventMapLayer({ events, atAbs, gutterPx, scale, offset }: Props) {
  const selection = useSelection();
  const containerRef = useRef<HTMLDivElement>(null);
  const [size, setSize] = useState({ width: 0, height: 0 });

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;
    const apply = (width: number, height: number) => {
      if (width < 1 || height < 1) return;
      setSize({ width, height });
    };
    apply(el.clientWidth, el.clientHeight);
    const observer = new ResizeObserver((entries) => {
      const rect = entries[0]?.contentRect;
      if (rect) apply(rect.width, rect.height);
    });
    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  const placed = useMemo(() => {
    if (size.width < 1 || size.height < 1) return [];
    return events.flatMap((event) => {
      const locations = event.locations.length > 0 ? event.locations : event.location ? [event.location] : [];
      return locations.map((location, index) => {
        const point = location.coordinateSystem === "GCJ02"
          ? { x: location.longitude, y: location.latitude }
          : wgs84ToGcj02(location.longitude, location.latitude);
        const projected = projectGcj02(
          point.x,
          point.y,
          size.width,
          size.height,
          resolveChinaMapInsets(gutterPx),
        );
        return { event, location, key: `${event.id}:${location.id}:${index}`, x: projected.x, y: projected.y };
      });
    });
  }, [events, gutterPx, size.height, size.width]);

  return (
    <div ref={containerRef} className={styles.layer} aria-hidden={placed.length === 0}>
      {placed.map(({ event, location, key, x, y }) => {
        const isSelected = selection.selected?.type === "event" && selection.selected.id === event.id;
        const tooltip = `${event.name} · ${formatEventTime(event)} · ${location.historicalName}（${location.modernName}）`;
        return (
          <HoverTooltip key={key} text={tooltip}>
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
          </HoverTooltip>
        );
      })}
    </div>
  );
}
