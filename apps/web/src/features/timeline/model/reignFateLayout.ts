import {
  fateRelationLabel,
  isFateRelationKind,
  resolveFateRelations,
  type ResolvedFateRelation,
  resolveReignCardLabel,
  buildPreQinClanContext,
  absMonthAtDay,
  type Relation,
  type Reign,
} from "@eralens/shared";
import { expandWindow } from "./visible";
import { clampAbsToBarX, layoutLaneReignBar, type ReignCardLayout } from "./reignCardLayout";
import { partitionReignRecords } from "./reignClusters";
import type { PreparedReignGeometry } from "./reignClusters";
import { getWindow, projectAbs, type ViewportState } from "./coordinates";

export type TimelineLaneLayout = {
  dynastyId: string;
  top: number;
  /** Full lane records before `partitionReignRecords` (rulers + 史料缺). */
  records: readonly Reign[];
  /** Lane 本色 from the dynasty token. Never master gold. */
  color: string;
  geometryByReignId?: ReadonlyMap<string, PreparedReignGeometry>;
};

export type PlacedReignFate = {
  id: string;
  path: string;
  eventX: number;
  destinationX: number;
  destinationY: number;
  originX: number;
  originY: number;
  tickX: number;
  tickTop: number;
  tickHeight: number;
  tooltip: string;
  /** Source lane 本色. */
  color: string;
};

const ORTHOGONAL_EPSILON_PX = 2;
/** Stop just outside the painted card so the dash does not pierce the fill. */
const EDGE_GAP_PX = 2;
const TICK_HEIGHT_PX = 6;

function barBottom(layout: Pick<ReignCardLayout, "barTop" | "barHeight">): number {
  return layout.barTop + layout.barHeight;
}

/**
 * Source-card edge that faces `other`. Origin sits on this painted border
 * (not in the gutter) so the marker straddles the stroke.
 */
function sourceFacingBorderY(layout: ReignCardLayout, other: ReignCardLayout): number {
  if (layout.barMidY > other.barMidY + ORTHOGONAL_EPSILON_PX) {
    return layout.barTop;
  }
  if (layout.barMidY < other.barMidY - ORTHOGONAL_EPSILON_PX) {
    return barBottom(layout);
  }
  return layout.barMidY;
}

/** Destination edge that faces the source, with a small lane-side gap. */
function facingEdgeY(layout: ReignCardLayout, other: ReignCardLayout): number {
  if (layout.barMidY > other.barMidY + ORTHOGONAL_EPSILON_PX) {
    return layout.barTop - EDGE_GAP_PX;
  }
  if (layout.barMidY < other.barMidY - ORTHOGONAL_EPSILON_PX) {
    return barBottom(layout) + EDGE_GAP_PX;
  }
  return layout.barMidY;
}

function roundPx(value: number): number {
  return Math.round(value * 10) / 10;
}

function buildFatePath(
  sourceAnchorX: number,
  sourceAnchorY: number,
  eventX: number,
  destinationAnchorX: number,
  destinationAnchorY: number,
): string {
  const sourceX = roundPx(sourceAnchorX);
  const sourceY = roundPx(sourceAnchorY);
  const eventColumnX = roundPx(eventX);
  const destinationX = roundPx(destinationAnchorX);
  const destinationY = roundPx(destinationAnchorY);
  const segments = [`M ${sourceX} ${sourceY}`];

  // The event column is authoritative. Card anchors may be clamped to a
  // reign's bar when the receiver has not acceded yet, but the vertical fate
  // segment must remain at relation.atAbs.
  if (Math.abs(eventColumnX - sourceX) > ORTHOGONAL_EPSILON_PX) {
    segments.push(`L ${eventColumnX} ${sourceY}`);
  }
  segments.push(`L ${eventColumnX} ${destinationY}`);
  if (Math.abs(destinationX - eventColumnX) > ORTHOGONAL_EPSILON_PX) {
    segments.push(`L ${destinationX} ${destinationY}`);
  }
  return segments.join(" ");
}

function destTick(
  toLayout: ReignCardLayout,
  fromLayout: ReignCardLayout,
  tickX: number,
): { tickX: number; tickTop: number; tickHeight: number } {
  if (toLayout.barMidY < fromLayout.barMidY - ORTHOGONAL_EPSILON_PX) {
    return {
      tickX,
      tickTop: barBottom(toLayout) - TICK_HEIGHT_PX,
      tickHeight: TICK_HEIGHT_PX,
    };
  }
  if (toLayout.barMidY > fromLayout.barMidY + ORTHOGONAL_EPSILON_PX) {
    return {
      tickX,
      tickTop: toLayout.barTop,
      tickHeight: TICK_HEIGHT_PX,
    };
  }
  return {
    tickX,
    tickTop: toLayout.barMidY - TICK_HEIGHT_PX / 2,
    tickHeight: TICK_HEIGHT_PX,
  };
}

export function layoutReignFates(
  relations: readonly Relation[],
  reigns: readonly Reign[],
  lanes: readonly TimelineLaneLayout[],
  viewport: ViewportState,
  personNames: ReadonlyMap<string, string>,
  personDisplay: ReadonlyMap<string, {
    title?: string;
    ancestralXing?: string;
    clanShi?: string;
    posthumousNames?: string[];
    templeNames?: string[];
  }> = new Map(),
  resolvedRelations?: readonly ResolvedFateRelation[],
): PlacedReignFate[] {
  const { startAbs, endAbs } = getWindow(viewport);
  const buffered = expandWindow(startAbs, endAbs, 120);
  const candidates = (resolvedRelations ?? resolveFateRelations(relations, reigns)).filter(
    ({ relation }) => relation.atAbs >= buffered.startAbs && relation.atAbs <= buffered.endAbs,
  );
  if (candidates.length === 0) return [];
  const neededReigns = new Set(candidates.flatMap(({ fromReign, toReign }) => [fromReign.id, toReign.id]));
  const layoutByReignId = new Map<string, ReignCardLayout>();
  const colorByReignId = new Map<string, string>();

  for (const lane of lanes) {
    const { rulers } = partitionReignRecords(lane.records);
    for (const reign of lane.records) {
      if (!neededReigns.has(reign.id)) continue;
      colorByReignId.set(reign.id, lane.color);
      const layout = layoutLaneReignBar(
        reign,
        lane.dynastyId,
        rulers,
        viewport,
        lane.top,
        personNames.get(reign.personId),
        buildPreQinClanContext(personDisplay.get(reign.personId)),
        [],
        lane.geometryByReignId?.get(reign.id),
      );
      if (layout) layoutByReignId.set(reign.id, layout);
    }
  }

  const placed: PlacedReignFate[] = [];
  for (const item of candidates) {
    const { relation, fromReign, toReign } = item;
    const relationAbs = relation.at ? absMonthAtDay(relation.at) : relation.atAbs!;

    const fromLayout = layoutByReignId.get(fromReign.id);
    const toLayout = layoutByReignId.get(toReign.id);
    if (!fromLayout || !toLayout) continue;

    const eventX = projectAbs(viewport, relationAbs);
    const sourceAnchorX = clampAbsToBarX(relationAbs, fromLayout, viewport);
    const destinationAnchorX = clampAbsToBarX(relationAbs, toLayout, viewport);
    // If the event is outside a card, approach it from the card midline. When
    // it is inside the source card, dock at the edge facing the destination.
    const sourceY = Math.abs(eventX - sourceAnchorX) > ORTHOGONAL_EPSILON_PX
      ? fromLayout.barMidY
      : sourceFacingBorderY(fromLayout, toLayout);
    const hasHorizontalLeader =
      Math.abs(sourceAnchorX - eventX) > ORTHOGONAL_EPSILON_PX ||
      Math.abs(destinationAnchorX - eventX) > ORTHOGONAL_EPSILON_PX;
    // Keep the event column authoritative. A horizontal leader may enter the
    // receiving card at its midpoint (needed when the card starts later),
    // while a nearly vertical line stops at the facing edge.
    const destinationY = hasHorizontalLeader
      ? toLayout.barMidY
      : facingEdgeY(toLayout, fromLayout);

    const displayName = (reign: Reign) => resolveReignCardLabel(
      reign,
      personNames.get(reign.personId),
      { clan: buildPreQinClanContext(personDisplay.get(reign.personId)) },
    );
    const fromName = displayName(fromReign);
    const toName = displayName(toReign);
    if (!isFateRelationKind(relation.kind)) continue;
    const color = colorByReignId.get(fromReign.id) ?? "var(--color-ink-muted)";
    const tick = hasHorizontalLeader
      ? {
          tickX: destinationAnchorX,
          tickTop: toLayout.barMidY - TICK_HEIGHT_PX / 2,
          tickHeight: TICK_HEIGHT_PX,
        }
      : destTick(toLayout, fromLayout, destinationAnchorX);
    placed.push({
      id: relation.id,
      path: buildFatePath(
        sourceAnchorX,
        sourceY,
        eventX,
        destinationAnchorX,
        destinationY,
      ),
      eventX: roundPx(eventX),
      destinationX: roundPx(destinationAnchorX),
      destinationY: roundPx(destinationY),
      originX: roundPx(sourceAnchorX),
      originY: roundPx(sourceY),
      tickX: tick.tickX,
      tickTop: tick.tickTop,
      tickHeight: tick.tickHeight,
      tooltip: `${fromName} → ${toName}（${fateRelationLabel(relation.kind)}）`,
      color,
    });
  }

  return placed;
}
