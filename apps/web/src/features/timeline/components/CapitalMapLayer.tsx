import {
  COLOR_VALUES,
  fallbackLaneColorToken,
  resolveDynastyColorValue,
  type ColorToken,
  type Dynasty,
  type DynastyCapital,
} from "@eralens/shared";
import { useEffect, useMemo, useRef, useState } from "react";
import { HoverTooltip } from "./HoverTooltip";
import { useSelection } from "../hooks/useSelection";
import { projectGcj02, resolveChinaMapInsets, wgs84ToGcj02 } from "../model/chinaMapProjection";
import { selectionStore } from "../state/selectionStore";
import styles from "./CapitalMapLayer.module.css";

type PlacedCapital = {
  capital: DynastyCapital;
  dynastyName: string;
  x: number;
  y: number;
  color: string;
};

type Props = {
  capitals: readonly DynastyCapital[];
  dynastiesById: ReadonlyMap<string, Dynasty>;
  dynastyNamesById: ReadonlyMap<string, string>;
  laneColorMap: ReadonlyMap<string, ColorToken>;
  atAbs: number;
  gutterPx: number;
  scale: number;
  offset: { x: number; y: number };
};

function roleClassName(role: DynastyCapital["role"]) {
  if (role === "secondary") return styles.secondary;
  if (role === "temporary") return styles.temporary;
  return styles.primary;
}

function resolveDynastyName(
  capital: DynastyCapital,
  dynastiesById: ReadonlyMap<string, Dynasty>,
  dynastyNamesById: ReadonlyMap<string, string>,
): string {
  return (
    dynastiesById.get(capital.dynastyId)?.name ??
    dynastyNamesById.get(capital.dynastyId) ??
    capital.dynastyId
  );
}

export function CapitalMapLayer({
  capitals,
  dynastiesById,
  dynastyNamesById,
  laneColorMap,
  atAbs,
  gutterPx,
  scale,
  offset,
}: Props) {
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
      if (!rect) return;
      apply(rect.width, rect.height);
    });
    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  const placed = useMemo(() => {
    if (size.width < 1 || size.height < 1 || capitals.length === 0) return [];

    return capitals.map((capital) => {
      const dynasty = dynastiesById.get(capital.dynastyId);
      const token = laneColorMap.get(capital.dynastyId) ?? fallbackLaneColorToken(capital.dynastyId);
      const color = dynasty
        ? resolveDynastyColorValue(dynasty, token, atAbs)
        : COLOR_VALUES[token];
      const coordinate = capital.coordinateSystem === "WGS84"
        ? wgs84ToGcj02(capital.longitude, capital.latitude)
        : { x: capital.longitude, y: capital.latitude };
      const point = projectGcj02(
        coordinate.x,
        coordinate.y,
        size.width,
        size.height,
        resolveChinaMapInsets(gutterPx),
      );
      return {
        capital,
        dynastyName: resolveDynastyName(capital, dynastiesById, dynastyNamesById),
        x: point.x,
        y: point.y,
        color,
      };
    });
  }, [
    atAbs,
    capitals,
    dynastiesById,
    dynastyNamesById,
    gutterPx,
    laneColorMap,
    size.height,
    size.width,
  ]);

  return (
    <div ref={containerRef} className={styles.layer} aria-hidden={placed.length === 0}>
      {placed.map(({ capital, dynastyName, x, y, color }) => {
        const isSelected =
          selection.selected?.type === "capital" && selection.selected.id === capital.id;
        return (
        <HoverTooltip
          key={capital.id}
          text={`${dynastyName} · ${capital.historicalName} · ${capital.modernName}`}
        >
          {(handlers) => (
            <button
              type="button"
              className={isSelected ? `${styles.marker} ${styles.selected}` : styles.marker}
              style={{
                left: `${offset.x + x * scale}px`,
                top: `${offset.y + y * scale}px`,
                ["--capital-color" as string]: color,
              }}
              aria-label={`${dynastyName}都城${capital.historicalName}（${capital.modernName}）`}
              aria-pressed={isSelected}
              onClick={() => {
                selectionStore.select({ type: "capital", id: capital.id }, atAbs);
              }}
              {...handlers}
            >
              <span className={`${styles.dot} ${roleClassName(capital.role)}`} aria-hidden="true" />
              <span className={styles.label}>{dynastyName}</span>
            </button>
          )}
        </HoverTooltip>
        );
      })}
    </div>
  );
}
