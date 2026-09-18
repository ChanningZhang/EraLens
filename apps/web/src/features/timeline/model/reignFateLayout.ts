import {
  fateRelationLabel,
  resolveFateRelations,
  type Relation,
  type Reign,
} from "@eralens/shared";
import { expandWindow } from "./visible";
import { clampAbsToBarX, layoutLaneReignBar, type ReignCardLayout } from "./reignCardLayout";
import { partitionReignRecords } from "./reignClusters";
import { type ViewportState } from "./coordinates";

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
/** Stop just outside the painted card so the dash does not pierce the fill. */
const EDGE_GAP_PX = 2;
const TICK_HEIGHT_PX = 6;
const ELBOW_RADIUS_PX = 6;

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

/** Dest edge of `layout` that faces `other`, inset into the lane gutter. */
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
  startX: number,
  startY: number,
  endX: number,
  endY: number,
): string {
  const x0 = roundPx(startX);
  const y0 = roundPx(startY);
  const x1 = roundPx(endX);
  const y1 = roundPx(endY);
  if (Math.abs(x1 - x0) <= ORTHOGONAL_EPSILON_PX) {
    return `M ${x0} ${y0} L ${x1} ${y1}`;
  }
  const dx = x1 - x0;
  const dy = y1 - y0;
  const radius = Math.min(ELBOW_RADIUS_PX, Math.abs(dx) / 2, Math.abs(dy) / 2);
  if (radius < 1) {
    return `M ${x0} ${y0} L ${x1} ${y0} L ${x1} ${y1}`;
  }
  const signX = dx >= 0 ? 1 : -1;
  const signY = dy >= 0 ? 1 : -1;
  const preX = roundPx(x1 - signX * radius);
  const postY = roundPx(y0 + signY * radius);
  return `M ${x0} ${y0} L ${preX} ${y0} Q ${x1} ${y0} ${x1} ${postY} L ${x1} ${y1}`;
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
): PlacedReignFate[] {
  const buffered = expandWindow(viewport.startAbs, viewport.endAbs, 120);
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

    const startX = clampAbsToBarX(relation.atAbs, fromLayout, viewport);
    const endX = clampAbsToBarX(relation.atAbs, toLayout, viewport);
    const needsHorizontal = Math.abs(endX - startX) > ORTHOGONAL_EPSILON_PX;
    // Horizontal leader leaves along the source mid-height (left/right
    // border). A pure vertical docks on the facing top/bottom border.
    const startY = needsHorizontal
      ? fromLayout.barMidY
      : sourceFacingBorderY(fromLayout, toLayout);
    const endY = facingEdgeY(toLayout, fromLayout);

    const fromName = personNames.get(fromReign.personId) ?? fromReign.title;
    const toName = personNames.get(toReign.personId) ?? toReign.title;
    const color = colorByReignId.get(fromReign.id) ?? "var(--color-ink-muted)";
    const tick = destTick(toLayout, fromLayout, endX);
    placed.push({
      id: relation.id,
      path: buildFatePath(startX, startY, endX, endY),
      originX: roundPx(startX),
      originY: roundPx(startY),
      tickX: tick.tickX,
      tickTop: tick.tickTop,
      tickHeight: tick.tickHeight,
      tooltip: `${fromName} → ${toName}（${fateRelationLabel(relation.kind)}）`,
      color,
    });
  }

  return placed;
}
