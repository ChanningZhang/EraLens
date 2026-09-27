import {
  COLOR_VALUES,
  fallbackLaneColorToken,
  resolveDynastyColorValue,
  type ColorToken,
  type Dynasty,
  type DynastyCapital,
} from "@eralens/shared";
import { useMemo } from "react";
import { InfoPopover } from "./InfoPopover";
import { useSelection } from "../hooks/useSelection";
import { projectGcj02InLayout, wgs84ToGcj02, type ChinaMapLayout } from "../model/chinaMapProjection";
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
  layout: ChinaMapLayout | null;
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
  layout,
  scale,
  offset,
}: Props) {
  const selection = useSelection();
  const placed = useMemo(() => {
    if (!layout || capitals.length === 0) return [];

    return capitals.map((capital) => {
      const dynasty = dynastiesById.get(capital.dynastyId);
      const token = laneColorMap.get(capital.dynastyId) ?? fallbackLaneColorToken(capital.dynastyId);
      const color = dynasty
        ? resolveDynastyColorValue(dynasty, token)
        : COLOR_VALUES[token];
      const coordinate = capital.coordinateSystem === "WGS84"
        ? wgs84ToGcj02(capital.longitude, capital.latitude)
        : { x: capital.longitude, y: capital.latitude };
      const point = projectGcj02InLayout(coordinate.x, coordinate.y, layout);
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
    layout,
    laneColorMap,
  ]);

  return (
    <div className={styles.layer} aria-hidden={placed.length === 0}>
      {placed.map(({ capital, dynastyName, x, y, color }) => {
        const isSelected =
          selection.selected?.type === "capital" && selection.selected.id === capital.id;
        return (
        <InfoPopover
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
        </InfoPopover>
        );
      })}
    </div>
  );
}
