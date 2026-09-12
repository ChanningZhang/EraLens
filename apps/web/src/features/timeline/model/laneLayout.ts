import type { Dynasty } from "@eralens/shared";

export type PlacedDynasty = Dynasty & {
  lane: number;
};

function compareDynastyOrder(a: Dynasty, b: Dynasty): number {
  return (
    a.startAbs - b.startAbs ||
    a.endAbs - b.endAbs ||
    a.id.localeCompare(b.id)
  );
}

/**
 * Every dynasty visible in the current window owns one row.
 *
 * Rows are always ordered chronologically. A later dynasty cannot reuse an
 * earlier dynasty's row until the earlier dynasty has completely left the
 * viewport; removing a row therefore only shifts following rows upward.
 */
export function assignLanes(dynasties: Dynasty[]): PlacedDynasty[] {
  return [...dynasties]
    .sort(compareDynastyOrder)
    .map((dynasty, lane) => ({ ...dynasty, lane }));
}

export function getLaneCount(placed: PlacedDynasty[]): number {
  if (placed.length === 0) return 0;
  return Math.max(...placed.map((d) => d.lane)) + 1;
}
