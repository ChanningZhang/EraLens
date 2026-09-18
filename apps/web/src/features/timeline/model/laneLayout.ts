import type { Dynasty } from "@eralens/shared";

export type PlacedDynasty = Dynasty & {
  lane: number;
};

/**
 * Every dynasty visible in the current window owns one row.
 *
 * Row order follows the input sequence (callers run `orderDynastiesForLanes`
 * first). A later dynasty cannot reuse an earlier dynasty's row until the
 * earlier dynasty has completely left the viewport; removing a row therefore
 * only shifts following rows upward.
 */
export function assignLanes(dynasties: Dynasty[]): PlacedDynasty[] {
  return dynasties.map((dynasty, lane) => ({ ...dynasty, lane }));
}

export function getLaneCount(placed: PlacedDynasty[]): number {
  if (placed.length === 0) return 0;
  return Math.max(...placed.map((d) => d.lane)) + 1;
}
