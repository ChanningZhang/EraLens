import {
  fateRelationLabel,
  isFateRelationKind,
  resolveFateRelations,
  type Relation,
  type Reign,
} from "@eralens/shared";
import { expandWindow } from "./visible";
import { clampAbsToBarX, layoutLaneReignBar, type ReignCardLayout } from "./reignCardLayout";
import { partitionReignRecords } from "./reignClusters";
import { getWindow, projectAbs, type ViewportState } from "./coordinates";

export type TimelineLaneLayout = {
  dynastyId: string;
  top: number;
  /** Full lane records before `partitionReignRecords` (rulers + 史料缺). */
  records: readonly Reign[];
  /** Lane 本色 from the dynasty token. Never orthodox gold. */
  color: string;
};

export type PlacedReignFate = {
  id: string;
  path: string;
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
  tickX: number,
): { tickX: number; tickTop: number; tickHeight: number } {
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
): PlacedReignFate[] {
  const { startAbs, endAbs } = getWindow(viewport);
  const buffered = expandWindow(startAbs, endAbs, 120);
  const layoutByReignId = new Map<string, ReignCardLayout>();
  const colorByReignId = new Map<string, string>();

  for (const lane of lanes) {
    const { rulers } = partitionReignRecords(lane.records);
    for (const reign of lane.records) {
      colorByReignId.set(reign.id, lane.color);
      const layout = layoutLaneReignBar(
        reign,
        lane.dynastyId,
        rulers,
        viewport,
        lane.top,
        personNames.get(reign.personId),
      );
      if (layout) layoutByReignId.set(reign.id, layout);
    }
  }

  const placed: PlacedReignFate[] = [];
  for (const item of resolveFateRelations(relations, reigns)) {
    const { relation, fromReign, toReign } = item;
    if (relation.atAbs < buffered.startAbs || relation.atAbs > buffered.endAbs) {
      continue;
    }

    const fromLayout = layoutByReignId.get(fromReign.id);
    const toLayout = layoutByReignId.get(toReign.id);
    if (!fromLayout || !toLayout) continue;

    const eventX = projectAbs(viewport, relation.atAbs);
    const sourceAnchorX = clampAbsToBarX(relation.atAbs, fromLayout, viewport);
    const destinationAnchorX = clampAbsToBarX(relation.atAbs, toLayout, viewport);
    // If the event is outside a card, approach it from the card midline. When
    // it is inside the source card, dock at the edge facing the destination.
    const sourceY = Math.abs(eventX - sourceAnchorX) > ORTHOGONAL_EPSILON_PX
      ? fromLayout.barMidY
      : sourceFacingBorderY(fromLayout, toLayout);
    // The horizontal segment must meet the receiving card at its vertical
    // midpoint. Keep the event column authoritative, then run the connector
    // across the lane gap into the card center rather than its top/bottom edge.
    const destinationY = toLayout.barMidY;

    const fromName = personNames.get(fromReign.personId) ?? fromReign.title;
    const toName = personNames.get(toReign.personId) ?? toReign.title;
    if (!isFateRelationKind(relation.kind)) continue;
    const color = colorByReignId.get(fromReign.id) ?? "var(--color-ink-muted)";
    const tick = destTick(toLayout, destinationAnchorX);
    placed.push({
      id: relation.id,
      path: buildFatePath(
        sourceAnchorX,
        sourceY,
        eventX,
        destinationAnchorX,
        destinationY,
      ),
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
