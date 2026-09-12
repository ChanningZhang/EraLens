import { absMonth, fromAbsMonth } from "@eralens/shared";

export type RulerTickSteps = {
  labelYears: number;
  minorYears: number;
};

/** Ruler label density follows zoom: 10y → 5y → 1y. */
export function getRulerTickSteps(pxPerMonth: number): RulerTickSteps {
  if (pxPerMonth >= 6) {
    return { labelYears: 1, minorYears: 0 };
  }
  if (pxPerMonth >= 2.5) {
    return { labelYears: 5, minorYears: 1 };
  }
  if (pxPerMonth >= 0.6) {
    return { labelYears: 10, minorYears: 1 };
  }
  if (pxPerMonth >= 0.15) {
    return { labelYears: 50, minorYears: 10 };
  }
  return { labelYears: 100, minorYears: 10 };
}

export type RulerTick = {
  abs: number;
  kind: "label" | "minor" | "mid";
  text?: string;
};

export function buildRulerTicks(
  startAbs: number,
  endAbs: number,
  pxPerMonth: number,
): RulerTick[] {
  const { labelYears, minorYears } = getRulerTickSteps(pxPerMonth);
  const { year: startYear } = fromAbsMonth(startAbs);
  const { year: endYear } = fromAbsMonth(endAbs);

  const stepYears = minorYears || labelYears;
  const firstYear = Math.floor(startYear / stepYears) * stepYears;
  const ticks: RulerTick[] = [];

  for (let year = firstYear; year <= endYear + labelYears; year += stepYears) {
    // Historical calendar notation has no year zero.
    if (year === 0) continue;
    const abs = absMonth(year, 1);
    if (abs < startAbs - 12 || abs > endAbs + 12) continue;

    const isLabel = year % labelYears === 0;
    if (isLabel) {
      ticks.push({ abs, kind: "label", text: formatRulerYear(year) });
      continue;
    }

    if (minorYears <= 0) continue;

    const isMid =
      labelYears > minorYears && year % labelYears === labelYears / 2 && labelYears >= 10;
    ticks.push({ abs, kind: isMid ? "mid" : "minor" });
  }

  return ticks;
}

export function formatRulerYear(year: number): string {
  if (year < 0) return `前${Math.abs(year)}`;
  if (year === 0) return "元年";
  return `${year}`;
}
